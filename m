Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35CEC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuGf-0005h6-3c; Wed, 21 Feb 2024 16:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuGd-0005g3-8M
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:36:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuGb-0005UH-Ec
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:36:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so17421265ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708551396; x=1709156196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2v9XGA/E18jXpKOpefIljoZ27yjt5k9rVr1O7vT2Qqc=;
 b=gXYmLbpyKXomTgL1ekD+LnNRZ7Xj66RvqMa1pSL/G13lE/Kod1Ux6gwsbyyZzV6cHc
 GPfz3vkBIvtVtPIDm8xg87QEMuMhxrgmBhzz+A62xwWyL9XAL8u80kddcA9K+v4ypTL/
 AiMWRIfR9rdrcF4ESbG9V6c4pxo4vVLU6+lb/rdOrTJl3nEbdUHcNf0Z5k38yr94XTaQ
 arUsBhw1h86vHlUAstrGv6EYP5DtR3wpQziFbUcC0cAjLQB8xC8pbyQgGq1d+rp7/Lee
 W9jVFQMmjc4htCfwTyvdkFebu/9OZPlyjKYbnvCoZ/ZCWLqaokhDDCGweJIrLShScKuS
 W9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551396; x=1709156196;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2v9XGA/E18jXpKOpefIljoZ27yjt5k9rVr1O7vT2Qqc=;
 b=UPPz8GWukNEr+rgykFOCCP5CcFkpSf/4RSi5ccCTGmVSjC1wXR7HP4P6S42sdqpATy
 GlwLpZ9HJq/kcyJwMxqBoUsSzG8r4DcDnR91xFzAOKpsEWsboAPADowuI8X9N7379gq2
 MiY0fwavqxqR6alQ/J6ZvppcF3RwRMqq5n3Wqik6pS8NGR471vQ8iY/XzhqYEqF39r4y
 uxl19vLQb4qSHPjhMF+llL/LNVc+qsuWRTpJFPLagB0gmHcJPPpfDCN+srWjOnfdDwu9
 OlyJYj5WZyBYsGdMfAhUUQAM/fzFNJRBS8U+9WjODRw+09wkS0y14HZruyY4c1FYV80B
 SMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAo6fwmcg7s/aewJBVpt8LaBojjS4Dpy06psTEV0FenE7InzeM11drLC/cluEhoCzfGOQl39hX9XF1z/u+67ObK4sBWOE=
X-Gm-Message-State: AOJu0Yy87dqpaj+uvDVcxPm7JZ4S9NwKR6fvm7rjlkPhr8GXpSRL+9Ci
 +05xCm6pN/ulS/BL8htXW02El5PMucNg9uhaixd82A5+f8bys6V/tqQyGr7ZwoU=
X-Google-Smtp-Source: AGHT+IFhvrMmbEYl2fGwaUjAHBp/pq/XNWwnu4XJH2uoqu6cdGxrXVcrQJ/D3BFRtumGTBg+963J6Q==
X-Received: by 2002:a17:903:1c2:b0:1db:ea2b:d2b4 with SMTP id
 e2-20020a17090301c200b001dbea2bd2b4mr11032096plh.15.1708551395897; 
 Wed, 21 Feb 2024 13:36:35 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090282c200b001dbcf653017sm7878074plz.289.2024.02.21.13.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:36:35 -0800 (PST)
Message-ID: <edbe3faa-d83e-4410-811a-d15fe244817a@linaro.org>
Date: Wed, 21 Feb 2024 11:36:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/22] target/arm: Handle IS/FS in ISR_EL1 for NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-9-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Add IS and FS bit in ISR_EL1 and handle the read according to whether the
> NMI is IRQ or FIQ.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/cpu.h    | 2 ++
>   target/arm/helper.c | 9 +++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 051e589e19..e2d07e3312 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1476,6 +1476,8 @@ FIELD(CPTR_EL3, TCPAC, 31, 1)
>   #define CPSR_N (1U << 31)
>   #define CPSR_NZCV (CPSR_N | CPSR_Z | CPSR_C | CPSR_V)
>   #define CPSR_AIF (CPSR_A | CPSR_I | CPSR_F)
> +#define ISR_FS (1U << 9)
> +#define ISR_IS (1U << 10)
>   
>   #define CPSR_IT (CPSR_IT_0_1 | CPSR_IT_2_7)
>   #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPSR_Q \
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0bd7a87e51..62c8e5d611 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2022,6 +2022,10 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>           if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
>               ret |= CPSR_I;
>           }
> +
> +        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) && env->nmi_is_irq) {
> +            ret |= ISR_IS;
> +        }
>       }
>   
>       if (hcr_el2 & HCR_FMO) {
> @@ -2032,6 +2036,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>           if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
>               ret |= CPSR_F;
>           }
> +
> +        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) &&
> +            (!env->nmi_is_irq)) {
> +            ret |= ISR_FS;
> +        }
>       }

The external CPU_INTERRUPT_NMI will never signal FIQ.

With CPU_INTERRUPT_NMI, both CPSR_I and ISR_IS must be set.

Missing is the handling of HCRX_EL2.{VFNMI,VINMI} to signal vFIQ and vIRQ with 
superpriority.  Unless I missed it, I don't see HCRX_EL2 adjusted for FEAT_NMI at all.


r~


