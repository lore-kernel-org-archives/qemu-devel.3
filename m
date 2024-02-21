Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6FC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrfq-0008VU-JT; Wed, 21 Feb 2024 13:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrfp-0008UV-MM
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:50:29 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrfY-0007zA-UV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:50:29 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e486abf3a5so1179272b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708541411; x=1709146211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9xIiLvRY3xbhfc35tIkJp/NU/J0+jshpKxjq/sU0Ku0=;
 b=aEFOGx3QW1by9ld1l84XpFPa9YBfpCW2Y/02/ucrJnX5+TsY43mCvbobFt4icEdg6Y
 mgIccFvTgp+EBAuV2z/vVjAkazl75sKgOh01gLTVuR/4fjar/82M7ty9zd/VsCUoCecb
 17AaS6EEy8TDjSEcck5NBYWsqhDF+mDt29WqfotIJOeKCpAgdcEDwuJW6ZSf5/j3huRf
 hO8mYvXg8ONgsbR6j9US7gLeu2clTpn0CxNbWK++A1UHtMnc0hYOoZc/8emuSIO5NhqJ
 nfLQedNjaCGVFqeSc104Thoe8gqWDfq45jR2MkS5SaMUqAnC3NXzWP0BnHDo8QPdUYJE
 /q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708541411; x=1709146211;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9xIiLvRY3xbhfc35tIkJp/NU/J0+jshpKxjq/sU0Ku0=;
 b=DAzldHQcIe3gY8H6arOC3ysOkHnIOMV5NpzSMo38CuTPa8wVXIkOPN25hF83Ze0+9o
 EeMdNUzNoMotrQ9oRMy/sRlCByaAFidI0B/f/8yA39r23hBTH4QQqpGVbCf3ExpwXW+Z
 1RLIHSW5f0sLNvkk++wDX+Pr1NKQM8L7FIv2L4APSmfQZKk+HwigULxi1fWPR6JyaGNH
 eRQh54dGYxYl8Jto5ceMeF0X3oDTbnN2TqOU+hu7EnleBUp7AzFknaI9Lb3sIaI+OXM5
 Yw/V2T6/lw10Mbkcp1DGcrggOWLeMaCOIggqx6Y3gr8j+22BUh75MtNB/J2ahjWAxmDi
 wmfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4bmYz1NzjkhHq/dRD8M7n50kIcjhq92x7mKd/Srf89LkUUApV3/yTx4aPwwamibGv9rxvR8X57KhOKirx8nFYRWND/Cw=
X-Gm-Message-State: AOJu0YwF0wJxj7VN5vU8+l3wIHa4nYNfcin9Ljz4l7Pj6qyp74HQJjAZ
 JrivUFVu4MzpeiT4T5onBr9cXC9A4qvlRWGKSqVunwLz3ypCu5+2KWUbjhaiTqs=
X-Google-Smtp-Source: AGHT+IEMjJbY6FSCj+U/FAZzmCFE/bxTRWubIwR3SO02b2u6RaEuC7saLXQHphJjbsH8SN7IOiPxAw==
X-Received: by 2002:a05:6a21:168d:b0:19e:9c82:b139 with SMTP id
 np13-20020a056a21168d00b0019e9c82b139mr17733965pzb.45.1708541411185; 
 Wed, 21 Feb 2024 10:50:11 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ka36-20020a056a0093a400b006e48e0499dfsm1866046pfb.39.2024.02.21.10.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:50:10 -0800 (PST)
Message-ID: <5f25d9cf-3ca0-4adb-860e-71a8fac3b504@linaro.org>
Date: Wed, 21 Feb 2024 08:50:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/22] target/arm: Add PSTATE.ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-4-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> The ALLINT bit in PSTATE is used to mask all IRQ or FIQ interrupts.
> 
> Place this in its own field within ENV, as that will
> make it easier to reset from within TCG generated code.
> 
> With the change to pstate_read/write, exception entry
> and return are automatically handled.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/cpu.c | 3 +++
>   target/arm/cpu.h | 9 +++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5fa86bc8d5..5e5978c302 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1104,6 +1104,9 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       if (cpu_isar_feature(aa64_bti, cpu)) {
>           qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
>       }
> +    if (cpu_isar_feature(aa64_nmi, cpu)) {
> +        qemu_fprintf(f, "  ALLINT=%d", (psr & PSTATE_ALLINT) >> 13);
> +    }

This is one bit -- !!(psr & ALLINT) is better

We don't individually print DAIF either; why is this bit more special?

> @@ -224,6 +224,7 @@ typedef struct CPUArchState {
>        *    semantics as for AArch32, as described in the comments on each field)
>        *  nRW (also known as M[4]) is kept, inverted, in env->aarch64
>        *  DAIF (exception masks) are kept in env->daif
> +     *  ALLINT (all IRQ or FIQ interrupts masks) are kept in env->allint
>        *  BTYPE is kept in env->btype
>        *  SM and ZA are kept in env->svcr
>        *  all other bits are stored in their correct places in env->pstate
> @@ -261,6 +262,7 @@ typedef struct CPUArchState {
>       uint32_t btype;  /* BTI branch type.  spsr[11:10].  */
>       uint64_t daif; /* exception masks, in the bits they are in PSTATE */
>       uint64_t svcr; /* PSTATE.{SM,ZA} in the bits they are in SVCR */
> +    uint64_t allint; /* All IRQ or FIQ interrupt mask, in the bit in PSTATE */

Why is this split out from env->pstate?

The allint bit matches the documentation for SPSR_EL1, which is how env->pstate is 
documented.  The other exclusions have some performance imperative which I don't see for 
allint.


r~

