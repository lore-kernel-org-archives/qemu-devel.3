Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C212CC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZufA-0001OL-82; Fri, 02 Aug 2024 11:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZuf7-00018U-FL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:57:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZuf5-0001vg-QC
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:57:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so56644535e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722614266; x=1723219066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCUp7Qb4RaXwvncqUBrJaBmeHYe/fhEE9ih7IJovnGM=;
 b=Sx3mARSFrC8CTnHTWsxstrlCVKGwjWKKo67KJujHN36wFul8dlJLLhln4CGvBnheza
 g+xjbvBJnl9dSXd9hqFQ/5n6rWrq6PZU737wM4IrJfboN7zEqFq+A6FJbhyZRNu2h03+
 COpB974nz/EW4m4a/WgJ5XB/DLrzhI9WdEhdpuJ7xbUnByCWfi5zi7BVzv7116Hmuf8B
 C5/cPmR8v8JxfQU6JT8FVqpyCswuGyQt/CWAA5lp8DLiwJ2w3Iz4Mb+txRwMrHzkOTqm
 Ci/qisFH6BsAby4xfr1+CYXfOt5+phBBsySSz64s3Y5JEnHPhg7R1+c+pBZ4HigcJGw4
 DGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722614266; x=1723219066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCUp7Qb4RaXwvncqUBrJaBmeHYe/fhEE9ih7IJovnGM=;
 b=pAIl8oSPvzbgsGxoDAWt+AsI8h61EJK8khepxvwUt0dfCbZVQlOaAloWDfxi68Xn11
 CkYTUCm25onPS9xWPJSPZ450fXjuBS1TVAITqHXlBR6Ijmj9+IvMYeASah5UgjO4MFJ/
 G1POCOB7cngDfEytprTc45v540PwnlvUCBN8ro/9LH0/3cfoF1/WyQfSrM7+Swbjkn59
 xeA/ZZ09jVlVNzw/dbeAXP4ghUlu5Dmcfq1eK25IMkHQsXHY00o+AAb7xNa4U8eSpGIZ
 yuGVhVFtCFKTga6Iz6AVUMezqaMIrB0fHzCuUNvwYv/PfdcG5dXXLgwiTdniDo6g0Oin
 +D/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8dCxqc1FKhv3ZtQNGeOmvXZJNyRv2kl7Av+znIrzpxwJqJSt9AiSg/aoA6/0WUFY4CO0F8z+qZXgZlOnwCurIzNXGblg=
X-Gm-Message-State: AOJu0YwtudooGpwl+npLdaIbaRsfs0ZElwdzPuJdUnslv3yNacRaqGqv
 mPWug++xIFqmfffwnT2EsMkp14SXyZvRWV0Xm8py3Stw0qf2vAmvjQrQmym5lq9GSYHkttq4wQs
 d
X-Google-Smtp-Source: AGHT+IFDSn+q76AWNeIlueREQzZVKuFVqkOIOYtMAUSHUQA7iSRmLLFaxxXXNLyf0AHg+Wa5fnhdmA==
X-Received: by 2002:a05:600c:45ca:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-428e6b00748mr25133475e9.15.1722614265898; 
 Fri, 02 Aug 2024 08:57:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7cbd2sm38061465e9.38.2024.08.02.08.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 08:57:45 -0700 (PDT)
Message-ID: <067cb14a-3743-42bb-afcb-bb9cbc94d6c5@linaro.org>
Date: Fri, 2 Aug 2024 17:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/5] docs: Typo fix in live disk backup
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
References: <20240802133118.2000067-2-eblake@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240802133118.2000067-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/8/24 15:30, Eric Blake wrote:
> Add in the missing space in the section header.
> 
> Fixes: 1084159b31 ("qapi: deprecate drive-backup", v6.2.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> Noticed while figuring out where nbd docs would appear in [1] once [2]
> goes live:
> [1] https://www.qemu.org/docs/master/interop/index.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00223.html
> 
> ---
>   docs/interop/live-block-operations.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



