Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101BFC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE74b-0004vJ-0X; Mon, 03 Jun 2024 08:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE74Y-0004uT-HT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:45:59 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE74V-00007k-8t
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:45:57 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52b894021cbso3605993e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418753; x=1718023553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y9/kdvEy1zFeE8qYjhl8QzY0Lg7rForBZ7KDGI6Dbo8=;
 b=kQHl/tjfhoJPSN8A5IzijoAVH217vz85sbm7vBDCNcdJQI5n2BaDhncf7YJckGOr9B
 bekbTgn+BklVg1M6bN4kgHTordJvLWUab/+S+s+WCjIWdrKR+yKdydd9RH+bxcdgfbE1
 9vBBXVPWzrWVMHk2X9EJTpyWa5yVc1WjYTjETI2nh9jMOJ/xPt/FdbbZLgseM392ak8s
 a7+sjBOMNBw0mmhGXxq7wqiCfYUQlPK+Vq8DB7b3AZDZJwteKdJHt6UEw4IcSAUWfZv4
 aN6UNejpOo7n52q7/2+M9ixZb/qcBTQ36xR496uMKVbni/hs7CIoTHjRxkkhZ7I8QGRP
 romg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418753; x=1718023553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y9/kdvEy1zFeE8qYjhl8QzY0Lg7rForBZ7KDGI6Dbo8=;
 b=EerNERiM4FaSi5jwPNYH75gNkA0e/OC3OlH7g54VNvFvQYmdhm9BncfQ/ZeqxX1SeY
 USMdToYZk1ZI8BamDnsF0Pf7WJFVPeupj839FlmiZXc6sKorEKRHWoGkcp4kIo9yW4oB
 8Sif1TyVi84TIvvnOEFA3fTs77cvaQI4Bouf1iCJlG++kdo2qKLpAaJTMcIKTSW62UEa
 qfFCqBlhr9Wcy8hsvCj+Z91TpLR7YhFf9D/mrkn/GL0sOdDlTcTyOpyuvXvvEPJm/W2P
 /D02orHi8/WxOzwG05gCfZE4Fn+xqcD7Cn9LDnPBbdatI0wSFcIo0VEUoW106LKoi765
 +7Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuFYIlT2cEbdp/mGYajfDf3nXRUm08Ma6OB4rbEcW6YGNPP0BHGvsPyuTpYovmxzA/TPSE2y8roMFnAittY4M7NxtbDqc=
X-Gm-Message-State: AOJu0YxLxCecuH5HbcvWcERsj/f39btsqM+nGltmq2UXkLUZpIMUmqwe
 DTPNgLZNSdCbn+cXsERuDqGOLOt5nDosInjdtIo59o9kmU0qFBZjtbOCLESSnM8=
X-Google-Smtp-Source: AGHT+IG+b+abFigqP3HVVy+bYOonRXbsW1B8x30UABQS3BrjhWLXfiyKWQtLN8kepCqgYOL3palQxQ==
X-Received: by 2002:a05:6512:33cf:b0:52b:9064:2e6c with SMTP id
 2adb3069b0e04-52b9064316fmr5451574e87.3.1717418753330; 
 Mon, 03 Jun 2024 05:45:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f25610a2sm240519866b.193.2024.06.03.05.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:45:52 -0700 (PDT)
Message-ID: <044212d1-d267-41eb-96c8-e2e6ab3bd558@linaro.org>
Date: Mon, 3 Jun 2024 14:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: Fix two lines with hard-coded tabs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org
References: <20240531170952.505323-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531170952.505323-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/5/24 19:09, Peter Maydell wrote:
> In kvm-all.c, two lines have been accidentally indented with
> hard-coded tabs rather than spaces. Normalise to match the rest
> of the file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, patch queued.


