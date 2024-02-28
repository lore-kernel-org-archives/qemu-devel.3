Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8859C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQos-0000wS-31; Wed, 28 Feb 2024 15:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQoj-0000tK-20
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:46:20 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQof-00067r-60
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:46:16 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so188076a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709153170; x=1709757970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFrYaUyH6C3KJFDnBGSitBvRMfKNrYAM1DFp2DLfUKQ=;
 b=tQlBKm5gAjIe0tc2LVqnREJP+zAn0WQs5w/2eK1Uts35G89mSrxxPIgw0kAzSlLbsm
 Le8ORXxX66KEDpyYVPj6AVRe3ZrKmu5hqzVobDicH/ogCrSlk3zsXj6a8rXYSFScK7vB
 +plarvFHvvFTPzAcWkD598HzaADbOsgznIGFWNZ0uBg6gZ4DlEW+H5GqJsEl8om5RB9i
 6C257XHT80/lYB7EoN/w7Vq6l9gGB+9Xq03T6kESVfKNF4j+a9mCUyzWN+IfH82qkxdJ
 SfSJzCMNHgpDCGN3E2Dw3+rzosOdQWKWDM4iA85jLEEOknTZ77bKWWaVMv+CrTziSZsv
 zG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709153170; x=1709757970;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFrYaUyH6C3KJFDnBGSitBvRMfKNrYAM1DFp2DLfUKQ=;
 b=PysPV8Rd7KtLSR6w/4HVM/FJqGEgyxPbNW/Zuzn0tiu6/E8LYY5Q+fwALsLFHj5eX2
 RODC8qbXC3+wNubN/70CNHbgm982bG6lL1EBHFxrfe3XDqnbJ/V9Kuh7pG3ndOD7pf5Z
 JU/8o8fObFciIUWdtRCYvUQ1NHBfeUU9ItvY/MMGjSSFvqJDEdgPhHxXJlA/gS2L1Iti
 rkWLssotd/1j3QsoM1WDa6OFl9kMY2+REc6JChc6mMNsMllIfzCKMwAo0TFVc7fe7Uv8
 2+kY44UldFAXXaNBBMtMzBJhJPsrdPJaxsNogPEsbelJwRaQ+JgViUmygzOEYTf7E0cy
 rGuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTakKmU2pB6KV+NyW3HkP3dHxZTFpdyfBdMpoCEM09UtvOiQskrFNqTE2jWFsD8mOVdBVSCFcHhDz0kmpwMLomQfnXQvE=
X-Gm-Message-State: AOJu0Yx625J7yNx+rW7kege6w6zIBwEtSaW95CMukPAWcYrMG+zJFFba
 fgsvVRdg60UdOD+TewxqQud3hBYv2nuctQKKLfQNoIp4E+PpccHqZuPPi0Z4jO8=
X-Google-Smtp-Source: AGHT+IE0j5ho3Icw4+GU2ILAv2T8I5YXdwhYdfCxK2QjwWL4UPHMyUHHcyeAfVVYlNMiyIZ+816+6Q==
X-Received: by 2002:a17:90a:6c43:b0:29a:a31d:695a with SMTP id
 x61-20020a17090a6c4300b0029aa31d695amr354507pjj.1.1709153170596; 
 Wed, 28 Feb 2024 12:46:10 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 st3-20020a17090b1fc300b00299ef19177dsm2168045pjb.8.2024.02.28.12.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 12:46:10 -0800 (PST)
Message-ID: <8a2cc10e-18a8-412b-beea-a33ace5f4c52@linaro.org>
Date: Wed, 28 Feb 2024 10:46:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
 <20240228092946.1768728-5-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228092946.1768728-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 2/27/24 23:29, Jinjie Ruan via wrote:
> Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
> EL0 check is necessary to ALLINT, and the EL1 check is necessary when
> imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
> unconditional write to pc and use raise_exception_ra to unwind.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Fix the ALLINT MSR (immediate) decodetree implementation.
> - Remove arm_is_el2_enabled() check in allint_check().
> - Update env->allint to env->pstate.
> - Only call allint_check() when imm == 1.
> - Simplify the allint_check() to not pass "op" and extract.
> - Implement it inline for EL2/3, or EL1 with imm==0.
> - Pass (a->imm & 1) * PSTATE_ALLINT (i64) to simplfy the ALLINT set/clear.
> v3:
> - Remove EL0 check in allint_check().
> - Add TALLINT check for EL1 in allint_check().
> - Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
> ---
>   target/arm/tcg/a64.decode      |  1 +
>   target/arm/tcg/helper-a64.c    | 16 ++++++++++++++++
>   target/arm/tcg/helper-a64.h    |  1 +
>   target/arm/tcg/translate-a64.c | 19 +++++++++++++++++++
>   4 files changed, 37 insertions(+)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 8a20dce3c8..0e7656fd15 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
>   MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>   MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>   MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111

Good.

> +static void allint_check(CPUARMState *env, uintptr_t ra)
> +{
> +    /* ALLINT update to PSTATE. */
> +    if (arm_current_el(env) == 1 && (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {

You know this will only be called for EL1.
Since the function is only used once, might as well merge...

> +        raise_exception_ra(env, EXCP_UDEF,
> +                           syn_aa64_sysregtrap(0, 1, 0, 4, 1, 0x1f, 0),
> +                           exception_target_el(env), ra);
> +    }
> +}
> +
> +void HELPER(msr_i_allint)(CPUARMState *env, uint64_t val)
> +{
> +    allint_check(env, GETPC());

... with the only caller.

> +    env->pstate = (env->pstate & ~PSTATE_ALLINT) | (val & PSTATE_ALLINT);

You know that val always equals PSTATE_ALLINT, so this simplifies to

     env->pstate |= PSTATE_ALLINT;

I suggest a rename to msr_set_allint_el1.

> +static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
> +{
> +    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
> +        return false;
> +    }
> +
> +    if ((a->imm & 1) == 0) {

imm is only one bit, per decode, so you can drop the & 1 here.

> +        clear_pstate_bits(PSTATE_ALLINT);
> +    } else if (s->current_el > 1) {
> +        set_pstate_bits(PSTATE_ALLINT);
> +    } else {
> +        gen_helper_msr_i_allint(tcg_env,
> +                                tcg_constant_tl((a->imm & 1) * PSTATE_ALLINT));

Because you've already eliminated imm == 0, you know imm is always 1, so that simplifies 
the entire function definition, per above.


r~

