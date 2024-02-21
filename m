Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA9C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 19:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcsH8-0004Sn-D8; Wed, 21 Feb 2024 14:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsH6-0004Rd-LE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 14:29:00 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsH4-0006kf-P0
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 14:29:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e47a104c2eso1560712b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708543737; x=1709148537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZhlfY+tfIcCgiq79UYeQpxQ7acX7rQbi2TkoHHTCvhI=;
 b=FqfBBM/FNpPo/DQUcnRpwPr1PMmvxu9Zzb6DPDfnyxO16SnofKUI2wXEg+qQjhQXh0
 u/8LeD8IDzk7eBcHZDmppbI3Q6/ckA0oCsBfOJfajSd8t8ZPHBN9AQpW74I6XYBKMa7m
 f8G8PX8XLEsTRELMppldiBU4UAR7NgahmGxBsI1Blyd0x3W9c6Pxm258AjBxAv15K6Q6
 zPNWGHduzBy/fY5Nfb45iuJASC7oXQ9ZDYPpU16FoFY3wkottXXZhdSyhRhPAHrebulT
 0o+Vk1KFllXc115bO0hxGbr3YBEbjeZb5pAtphq6Fs4yS5HAzQf7ZlfnCpgB6XeBFsCw
 vNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708543737; x=1709148537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhlfY+tfIcCgiq79UYeQpxQ7acX7rQbi2TkoHHTCvhI=;
 b=QWUKZgOdnlkR9DqitmHKjpZIQlaNnQ5BQ4TiIZjPjdnbf4nYCYo/EjsoT79YsZzD77
 VIkJGXPE+3BDxUDR9RAdVhjO9VVu3kylMkvD08/pfWrodW/hdp/uL+JZsPqg4Zr1Ez2e
 O2ZQGjF4QCF2++8J3J/wAmLSYg89ZuTgo/5zMopov/7DI/FAFv1rOYEFJtezx3RhMU5o
 6M28zLBQ9SPE0Fo9tBOYFjK9IxiUf6iEK26ETcEe62Rrtntyi49nJL6kG/OipMsqJZVL
 lPT6aufJnPWIA+pT1hiF7VzmL0y140lCTP2G0QHV/vDyA0wMikrZVkbBxJkHJ29u6e/T
 vD8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvCduwA6X9b9XV6cQB8VetEl4k5K5bTjQH/TjXs0srq1u2ku1R9uWXlto0y1gu/cfsbhipSbIFZ2aw2gfdXcwvmGl9L8=
X-Gm-Message-State: AOJu0Yyxq7ywg3rJ/p1ldB6x77ZXeBlAG442Nx4LosQcFqQlG2igT4Rv
 jbn87irXZbRj45a3BtbScx2cCkqZT57jSL57+BkmZrKr41RwXt3LGUvVsLzQFEqEmxS2ci4pzwi
 e
X-Google-Smtp-Source: AGHT+IHctboMq2iHCJsaLO/XJAKlbCa0a/6bVXlujjJgmzZ5mg7wKlQXXcyxuZVR1bEj4CSosVlqWg==
X-Received: by 2002:a62:cd82:0:b0:6e4:3ea4:a7e1 with SMTP id
 o124-20020a62cd82000000b006e43ea4a7e1mr7061123pfg.27.1708543736930; 
 Wed, 21 Feb 2024 11:28:56 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa79d02000000b006e37814cb11sm8427109pfp.4.2024.02.21.11.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 11:28:56 -0800 (PST)
Message-ID: <699fbf87-8f24-4d3d-b230-f956ce371f20@linaro.org>
Date: Wed, 21 Feb 2024 09:28:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/22] target/arm: Support MSR access to ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-6-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> Support ALLINT msr access as follow:
> 	mrs <xt>, ALLINT	// read allint
> 	msr ALLINT, <xt>	// write allint with imm
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/helper.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a3062cb2ad..211156d640 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4618,6 +4618,31 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       env->daif = value & PSTATE_DAIF;
>   }
>   
> +static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                              uint64_t value)
> +{
> +    env->allint = value & PSTATE_ALLINT;
> +}
> +
> +static uint64_t aa64_allint_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->allint & PSTATE_ALLINT;
> +}
> +
> +static CPAccessResult aa64_allint_access(CPUARMState *env,
> +                                         const ARMCPRegInfo *ri, bool isread)
> +{
> +    if (arm_current_el(env) == 0) {
> +        return CP_ACCESS_TRAP_UNCATEGORIZED;
> +    }

This is handled by .access PL1_RW.

> +
> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
> +        cpu_isar_feature(aa64_hcx, env_archcpu(env)) &&
> +        (env->cp15.hcrx_el2 & HCRX_TALLINT))
> +        return CP_ACCESS_TRAP_EL2;

You should be using arm_hcrx_el2_eff(env).
Missing braces.

> @@ -5437,6 +5462,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>         .access = PL0_RW, .accessfn = aa64_daif_access,
>         .fieldoffset = offsetof(CPUARMState, daif),
>         .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
> +    { .name = "ALLINT", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .opc2 = 0, .crn = 4, .crm = 3,
> +      .type = ARM_CP_NO_RAW,
> +      .access = PL1_RW, .accessfn = aa64_allint_access,
> +      .fieldoffset = offsetof(CPUARMState, allint),
> +      .writefn = aa64_allint_write, .readfn = aa64_allint_read,
> +      .resetfn = arm_cp_reset_ignore },

You cannot add ALLINT here in v8_cp_reginfo[].
Compare fgt_reginfo[], and how it is registered.


r~

