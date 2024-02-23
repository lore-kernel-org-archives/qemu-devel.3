Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C78C54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcFT-000086-KY; Fri, 23 Feb 2024 15:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbnx-00031O-Sw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:05:58 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbnf-0003KB-VJ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:05:54 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso1003835a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708718735; x=1709323535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BSKus13F2QZ/NOGwIn/uNhTJoGgg1VTqL9wjKKBLFMw=;
 b=iDynX55om2oKaMSOunDExk+uwe/NtFJP+gVraFjq3am4SI1W3kebBZlJGqIOVXZr3z
 dcA+1MhhslR4f79VN4BjWEImfxs1LYQ6dE2A9s/9t+n4PNY0CYfl43waIoYFEtGtMoh/
 pQmZLK5GAMXp13UUGg/WZ512bh2tMEztDhz1pM0FJbmF66mIdTAHkdhN63+arF42xGAo
 WThVIBPmoMsuhVziIhkpwYpb1cs306YYGk0k8b2dYEVT2W4ANxcCwPXjlKSAZpJrXAzz
 J14sNJ9LSKradg7V49b5goeSCwrlPL1eJymSSAdwoSHAUGoSrSEUDiHMaPoMkZ7ZCqUr
 vRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708718735; x=1709323535;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BSKus13F2QZ/NOGwIn/uNhTJoGgg1VTqL9wjKKBLFMw=;
 b=YR40gtwrZSeK2QDFFWOxDCyM996R4+BGDYwFbtSnqMG9InoeMaff8e6sB8bklSzoPU
 oTvOidPoBPEm+aBOeB5hh22WxtROEAw6YBmbOJToU9iwLISDmXOTRGfpgR+Nw72l9z/u
 T5UukWJhMxC5jlx/0paAjidYruztNuaV4OgVXYPCmQit9Z+4EDwKd0CjyoA6V+lBTm0R
 XaobDNzMmNRKWzoqBSfKECZCARIgAiTyiElGkyktWH7ClN/2c/3hPa6GdDZlvQ2dWxqq
 R8dLPymZMrtI6ukz9wKnvkDDWIlZ89OehZl95Bu348hhcvGIDFAclsLhYWNymwT4yswu
 r6Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2j0Lb5CCHpun/m0y4mRE1cL8XM9F3PuqaSwipxkpQmqNM6EHW5W89TFLxQF+nRLM15oVPEgrVWGBQMGb/0JlkygUFKLo=
X-Gm-Message-State: AOJu0YxDMdCHwsQCfXbq9x9ZZuI/eu050ScFgQF6gXExnlibVXIaw3bk
 ZpQ7WGr5XDybCrAauxr9Lvie5ttUjDRCQNvt3HSbq22ebK1FMNS0ItrVQ/BQwac=
X-Google-Smtp-Source: AGHT+IFjE4qj2oZpS22JWOnP8WgdoyGjiTZ2qQ22BeuBK7NJFS1Dpmk35wkfy5bEJIBnJFy4GyYCLA==
X-Received: by 2002:a17:90b:48c6:b0:299:592a:7d19 with SMTP id
 li6-20020a17090b48c600b00299592a7d19mr873040pjb.3.1708718735210; 
 Fri, 23 Feb 2024 12:05:35 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lj10-20020a17090b344a00b00298ca46547fsm1885987pjb.36.2024.02.23.12.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:05:34 -0800 (PST)
Message-ID: <b92a47ca-bb2d-40d5-8356-e554327a76e5@linaro.org>
Date: Fri, 23 Feb 2024 10:05:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/21] target/arm: Handle IS/FS in ISR_EL1 for NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-9-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Add IS and FS bit in ISR_EL1 and handle the read. With CPU_INTERRUPT_NMI, both
> CPSR_I and ISR_IS must be set.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> --
> v3:
> - CPU_INTERRUPT_NMI do not set FIQ, so remove it.
> - With CPU_INTERRUPT_NMI, both CPSR_I and ISR_IS must be set.
> ---
>   target/arm/cpu.h    | 2 ++
>   target/arm/helper.c | 5 +++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b23be7fc24..ae9a75d717 100644
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
> index 2f54413b01..eb97ce0356 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2022,6 +2022,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>           if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
>               ret |= CPSR_I;
>           }
> +
> +        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
> +            ret |= ISR_IS;
> +            ret |= CPSR_I;
> +        }
>       }

Need to handle CPU_INTERRUPT_VNMI (which can be raised from the GIC).

Need to handle HCRX_EL2.VFNMI with CPU_INTERRUPT_VFIQ (which cannot be raised from the 
GIC, so we can determine VFIQ superpriority based solely on the cpu state).


r~

