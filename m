Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FBC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 19:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrxw-0002Sl-50; Wed, 21 Feb 2024 14:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrxu-0002SG-Lx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 14:09:10 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrxr-0003KU-Un
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 14:09:10 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so4916338b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708542545; x=1709147345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=djwKvPbpFsXhgBG1hqt3/swL3Y/0xWo+lVf0faNr4uo=;
 b=hJOZ7Cp+XFN8oyavGIwMqYniufdOb2XEwltVGWAnCWBzUn4sCv08DbX25Zm56G3p1R
 1zoafx6KtGqpnH0HlVFWuvV6/N5RBg3aUfYp/q2R7J6l7dzXjmHtDG/YWAmwtB9LANF3
 tqJ2sicWPIRNwUlPNHnproeYytZESUNOHIKwH/t2MFQHxeHS83YEMu4IodPjJ3cmvtGU
 GxzlOhBhs4qUfLgzT7d3NEp5rttxYzF4Zo7eMBfAZDGPRrs2OciniZVOB2VbE3agvTY2
 C5iN1Go7OBoIcEvd0T2Z1cyzm8SD1hiWTIx+kIziRZK1foIrtdf3VB5N5PwuddErbC/k
 GrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708542545; x=1709147345;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=djwKvPbpFsXhgBG1hqt3/swL3Y/0xWo+lVf0faNr4uo=;
 b=vqw6uvimuxdcD2rSpGplsDngSQoNKoZIxfDw187FdSSVL/2Qo+mDE6qXZgXdHtDgy7
 AVLtLfGrMvQsBZPze+YEzo8yk3+XWmfzbilzKMS8jsCZd6fH9VRp2yZO3e1PPuVxFqhB
 tabK2du3YQK8w84ORm0NI2wQSgqIgI97+rqvz54dcN7zTRlGy1PDO6LRO0LNDK/qsdMq
 quOxNyYibXIo9f2luNXq5XA9gZhXEQorVtWeZGbeQvqJjHtbBIgcs8YBh4eGDq2haRRX
 LNE86v1RPiXXx4qPvkP4zywkmZCQhaF98RgpbTefZfQrY7wo5hMRTsvE3EzETGvQq8w5
 PBsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ054qQhzZoaw0WMcqwgFBxyiKnj6TwLaXjnkLWeq2Jm1VyeWUckh4/4DIYPs6AQk+p7IOuo/F3mIIUbbd2TnPvxvV6rI=
X-Gm-Message-State: AOJu0YwU292Axug1RbQM7Wbe8DIjdDIQ5U3PWqshRH2JWW+WThEEwJmj
 e/DceI1NdollcLqyrWwgKvskC9gPLzEYi+07rS7a5y0G4GmWpenVTez/yFQZs7Y=
X-Google-Smtp-Source: AGHT+IG3k5BK6pQBvKsijfp+Q0ZDaRbOsSD2Q2nfyPaVf5ET8H4uVdenElf7X4uoVNoIpnNyu4fReg==
X-Received: by 2002:aa7:8583:0:b0:6e4:6a74:ee5b with SMTP id
 w3-20020aa78583000000b006e46a74ee5bmr7948878pfn.14.1708542544926; 
 Wed, 21 Feb 2024 11:09:04 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f12-20020a056a0022cc00b006e478f9504csm4157801pfj.104.2024.02.21.11.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 11:09:04 -0800 (PST)
Message-ID: <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
Date: Wed, 21 Feb 2024 09:09:01 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-5-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
> to unwind.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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
>   MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
>   
>   # MRS, MSR (register), SYS, SYSL. These are all essentially the
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index ebaa7f00df..3686926ada 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -66,6 +66,30 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
>       update_spsel(env, imm);
>   }
>   
> +static void allint_check(CPUARMState *env, uint32_t op,
> +                       uint32_t imm, uintptr_t ra)
> +{
> +    /* ALLINT update to PSTATE. */
> +    if (arm_current_el(env) == 0) {
> +        raise_exception_ra(env, EXCP_UDEF,
> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
> +                                               extract32(op, 3, 3), 4,
> +                                               imm, 0x1f, 0),
> +                           exception_target_el(env), ra);
> +    }
> +}

A runtime check for EL0 is not necessary; you've already handled that in 
trans_MSR_i_ALLINT().  However, what *is* missing here is the test against TALLINT for EL1.

> +
> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
> +{
> +    allint_check(env, 0x8, imm, GETPC());
> +    if (imm == 1) {
> +        env->allint |= PSTATE_ALLINT;
> +    } else {
> +        env->allint &= ~PSTATE_ALLINT;
> +    }

I think you should not write an immediate-specific helper, but one which can also handle 
the variable "MSR allint, <xt>".  This is no more difficult than

void HELPER(msr_allint)(CPUARMState *env, target_ulong val)
{
     ... check ...
     env->pstate = (env->pstate & ~PSTATE_ALLINT) | (val & PSTATE_ALLINT);
}

> +    arm_rebuild_hflags(env);
> +}

allint does not affect hflags; no rebuild required.

> +static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
> +{
> +    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
> +        return false;
> +    }
> +    gen_helper_msr_i_allint(tcg_env, tcg_constant_i32(a->imm));

You're passing all of #imm4, not #imm1, which meant the test in your msr_i_allint helper 
was wrong.

To work with the generalized helper above, this would be

     tcg_constant_tl((a->imm & 1) * PSTATE_ALLINT);


r~

