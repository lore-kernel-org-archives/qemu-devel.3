Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdb3h-0000L4-Tw; Fri, 23 Feb 2024 14:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdapM-00030n-IF
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:03:20 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdapK-0003Ay-IK
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:03:20 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e48eef8be5so899061b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708714997; x=1709319797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEElzyEVrJ6vzUESEF4GnXDG/VM9u04WwX4vIcjXnIM=;
 b=muhnycI5/Yyw6ehlhXVeiOi6JZeRE8/U5qWyd5xeLryCbA0Nz0nUSCVH0kBrFqavIz
 gfghGf5o8nEqq8YxFASnElMvSefRncouk4xF1z7XbbobF4SV3RFdsOSLyP1uphL0yd1N
 ZYC0dvaOmaNopHn9delweOcsqmgBhwDX3eUGpOydzwZoDah/oKlQqm88JLfPTkdrhn/d
 gGGuv79GXxbdxPeU+OpataCCfjs64PUux/bxlf6cuaWoU+4h4JkIX3cWABtwsyPqBN6v
 6C1KngyvFJ/bI8VrbChH/4Z1STXv9LGTV2n6DQEr4GrMVc9lAu2VkKvw/YLm5dRPWV9z
 yopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708714997; x=1709319797;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEElzyEVrJ6vzUESEF4GnXDG/VM9u04WwX4vIcjXnIM=;
 b=MSZ2jjYxXMMX8TyWXEO0lMZoRV3o07o6zTCo8LGb1i/jZjav0pkx8EBE37Tce7Olco
 lcxzmQbVKnLAH0Ccv1VGhI/UP0btrpdS/g5cO9ghj7EELqcOOumt0Szn6kI1K7nhZqF6
 onUVSnytbkgyzlrm8mTsbG1KHvsQw6bbg5mhFnTx00fX4NKSit6cZMmi2ENB2vWPJifb
 lBPeZbAXlt14FspK05CxYiJQo6l9+a8O9T73GPw9wUnq42PfIe894svfT+vIjN2fFDz+
 nVLhoshIuh1ER392Jss3OGQceJ2Gdwew7N1D1acAHNFpnuucWjBTtjMTlXWbcQvA60Yd
 WfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuk3K4axCJMggB6AEjd79LzFfj8Yf+0xIanCa9ak/xk136s9vz4t7+FY3CuLNe24F9/fTo0z10NVWQswlItxiWybc4aDQ=
X-Gm-Message-State: AOJu0YwpzwIepbHEW++6x1RuiSpu6La9Fn7h8IRpSji67A/Aet5alcG0
 fSijE6EoCNLc/ZF6iOd0LzgIDgcypZX46uTrIiuYfJEH3i9xWn8Ka99e2shW0E8=
X-Google-Smtp-Source: AGHT+IE1IA32SSMpneXCXZTi17/7oRX25MX6EvoiVOXSQcHYdUxHf/VqbONL1QUPZZaE4moL2QdAfQ==
X-Received: by 2002:a05:6a00:1d1f:b0:6e4:e40f:5e12 with SMTP id
 a31-20020a056a001d1f00b006e4e40f5e12mr775299pfx.7.1708714996641; 
 Fri, 23 Feb 2024 11:03:16 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f20-20020aa782d4000000b006e3f09fd6a4sm11956522pfn.170.2024.02.23.11.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 11:03:16 -0800 (PST)
Message-ID: <9b20584a-3c4c-47a2-bf42-f8d7d4eabd9f@linaro.org>
Date: Fri, 23 Feb 2024 09:03:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/21] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-5-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
> to unwind.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Remove EL0 check in allint_check().
> - Add TALLINT check for EL1 in allint_check().
> - Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
> ---
>   target/arm/tcg/a64.decode      |  1 +
>   target/arm/tcg/helper-a64.c    | 24 ++++++++++++++++++++++++
>   target/arm/tcg/helper-a64.h    |  1 +
>   target/arm/tcg/translate-a64.c | 10 ++++++++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 8a20dce3c8..3588080024 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
>   MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>   MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>   MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i

Decode is incorrect either here, or in trans_MSR_i_ALLINT, because CRm != '000x' is UNDEFINED.

MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111

is perhaps the clearest implementation.

> +static void allint_check(CPUARMState *env, uint32_t op,
> +                       uint32_t imm, uintptr_t ra)
> +{
> +    /* ALLINT update to PSTATE. */
> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
> +        (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
> +        raise_exception_ra(env, EXCP_UDEF,
> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
> +                                               extract32(op, 3, 3), 4,
> +                                               imm, 0x1f, 0),
> +                           exception_target_el(env), ra);
> +    }
> +}
> +
> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
> +{
> +    allint_check(env, 0x8, imm, GETPC());

As previously noted, the check for MSR_i only applies to imm==1, not 0.

As previously noted, with ALLINT in env->pstate, you can implement this completely inline 
for EL[23], or EL1 with imm==0.

No point in passing in "op" and extracting, because you know exactly what the value should 
be for all MSR ALLINT.


r~

