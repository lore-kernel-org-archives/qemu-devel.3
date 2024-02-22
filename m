Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC6FC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7tH-0002BM-KC; Thu, 22 Feb 2024 07:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7tG-0002BD-B6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:09:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7tD-0003sP-Ru
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:09:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41273f53c71so13631795e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708603761; x=1709208561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OtiMlelEPB6ZyC4HUzht+KUykZXe+UeyQV75YHFLxIc=;
 b=gM3o4SsQV6cvWz5a52FQQ1/h0E/nzquMk7rOrDCy3mrv6L4arq9HJXuoxhpoxbrkAp
 WBXMSZ2em3CrDl0CTfAq0oKkPyw+6oiz2svOcUkvjvCKwzLkTpmKVah0HUbInebqNfnq
 RxWiWZVQ4+SVWAheJUD5AKdSNUncqWgU2xqCI5l5qeCU7IX7wFqjy4+NyLysOLi/Nwul
 1qCwO0oxc+ZNi45wwCgdGsTfMOtZnqcfDLoc4cPaxvWQKKDXHRdOXm4YWm2JkJreP3hR
 Af9F8wZck6FnwmVk2luDe4XsCY5izeFNpHUHZv+t63NcN+e67cpp3jKGRLaBQIv7IwwG
 /W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708603761; x=1709208561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OtiMlelEPB6ZyC4HUzht+KUykZXe+UeyQV75YHFLxIc=;
 b=WF9vDyZ1JqRkifMK5OrMV+m1Paqxthx3bYjyMoUuP1BFeZcmbRXiz7If8ZXgpWvPl2
 lF/PWAdbpsqHOvvGaMVuiE5Ns+kd7fZIqOsq1d5AHZP3He7LHl+8Io3274sKaDmCI9p1
 8cJ18qYKMavMLUxaYlttaGxICVS1kXIFtpDCwAzZnqCZiAqWZtxkSAzFKtjH2m9BAAku
 hs/4o/Y3+5TjDuOK9BhQkJOFwyW6MOan5jOq4yhAj+ac1O+ZXeey7kR4o/X/poRmvupN
 63xFb2qPtOtgy52AcZ8MsG6BNkFt1K2S626WBl1b90FqKRNzAk1mQ3NTszYGJzFR/gs2
 5TLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoQz/Z9zYnm1hBvkIqkaWLCEJrETT8N0Raopn/bvZrJck3rB2G+8lBMOKyoHwFoHnm5hZPfO9oGk6dXkFVpDCqXwG5Ctc=
X-Gm-Message-State: AOJu0Yxh4PkTIS+7fGy6ddi2ihC6i7DQojHcRyCn79yDLmhtdBYHJIkz
 XFtYBwBTZ+QZXyMJBHLuDSaY9EIJemN/hq+3n8hIIb5tEFv6ZgsoLUJDgZtrJEU=
X-Google-Smtp-Source: AGHT+IEt9hCFNtvswN1PQ1WOR9Xd5N8KasinrmXvmClGtFzbMo/di9ifycLkoaCYKtkFAdtSDxpGfA==
X-Received: by 2002:a05:600c:1e02:b0:412:66ef:4b3c with SMTP id
 ay2-20020a05600c1e0200b0041266ef4b3cmr10917916wmb.18.1708603761125; 
 Thu, 22 Feb 2024 04:09:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b004105528c61fsm21995433wms.35.2024.02.22.04.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 04:09:20 -0800 (PST)
Message-ID: <f0b24f1d-1d6d-477d-948d-976b89f922d6@linaro.org>
Date: Thu, 22 Feb 2024 13:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] target/ppc: Simplify syscall exception handlers
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/2/24 12:33, BALATON Zoltan wrote:
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy

"simplify"

> this code. Also add "unlikely" to mark the less freqiently used branch

"frequently"

> for the compiler.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   target/ppc/excp_helper.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)


