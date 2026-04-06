Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFECE9D826
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XvA-0000Oh-VV; Sun, 05 Apr 2026 20:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xv7-0000OE-K2
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:34:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xv5-000335-N2
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:34:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so12928405ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775435660; x=1776040460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixch61KXiMMszGJxsdCYmXGRfTuAcChvwontcbhu5Ok=;
 b=kDlHCxvqhkboh1y/B9Ze6KskTnGrDVEh6UgQfzTdJ1O71RQSW7zDaOy6I3aY+QzYX/
 84QaTIf0c9LaiPfBBAciLrGfsV8yRlb7XKwyw04h+uvF2wv+BhMDGM2S8w9axqgF8V9j
 PeeqJLHKC0W3gTjsuitjUV6v3Dz8z2npy2wgEsy9mIK7Om1c/WtGNrJI2n6cOUgS/rjZ
 XQexZKrEQ/7yr5qRujmNV+Qd0yfyGjcPIV3V1LJG9uyETudHr9/wPnNix3HzZTf65l12
 rPZk6rsVgch2descWFHxXxbe8Adi89Hy68EFFLC2zMEPPz3t7xa5DdzcrgOtMBqppHk6
 miQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775435660; x=1776040460;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixch61KXiMMszGJxsdCYmXGRfTuAcChvwontcbhu5Ok=;
 b=OfH4XrkyyQRbWoDDn1TrHgB+Rboj2Msg34y24Bqv+cmxaRigY0lsn/k9tsZzUibooc
 PfOwWeYK8C6gPqIddw4PIjIdqaJw4WEE1acRkhmfjitOr4at8apsCNvBuDUKrV04rhk5
 q/TS6mVhc5OsgtUKCSbgRPpzdD3+Ddn0dLomR2xEqUUa9/tX0Cy5vbnX+8CebaXQevqI
 EE0nOAb5bx9uxsSbbOoxFj2/DIyZJOPDUbzyy9ma3eiijobYeMPAnd6R8Xwb6w0UYW9G
 FHWBDQ3yUylsJO2y8Hk4ar/Yn7RlAbzfS0g1RclJ9ZMkzsRSZe1tJcD0sx5I0N3q0zY3
 kzWw==
X-Gm-Message-State: AOJu0Yw/XHPMom5CU6JLjWKl9rggz6z7cYgtc/XG0iIV9OuOtRkAwdCj
 4T00AZJARYZN5exAy8TUFLUNQSztgJSTSACMWNjhkkbU3sOEN5fYNqzXoYBOQafHSBEuzeKaXxG
 jFSWp
X-Gm-Gg: AeBDietdgIP2rR4P0nfBhCAW6N1kveLgFY5a2kQrK/hg7fEciaIywhLcsj/PDpz4WKy
 5g9bhh9H4sLWznAVllqDB/oidXl95ed0i09D79I7RdK9cQMp8ALnAIGQFmjtRJeQQ+7ETxB8EpC
 tYYrYEgHTVdwtOXz7M39uyM91aEShaaN7qOO9DJfVuIaAjWyiiypjVtV7VWaVTuOySQQ642Yujb
 ppAO8D5r265R6xV33ECrTgQWV/uq5U+q3GTV5EHT+M/kQzKW6HZJ7g6gFg9KUXCov1hhMSh7cur
 UFZd89MlimDJm11AogdCcfsIpHm9WFG2R6hSqf6RsJL4XO4PjSnNd2fqJqB9QZBxcR19KXUfDyn
 I3z9ZMhcG4fuKB3TAkuVrVxFHfiGYf8vRjVoIkn2HXPt2OOm8HTo+qUwu46vRg9mb3rt6Fpdz4M
 KL4avmwZcCPnMdjWZTs0yNcxbkAQMaNsUq5oIPBmYY60VkNQC2scYNarwuJNwDt0mrxKI=
X-Received: by 2002:a17:902:e748:b0:2b0:571f:6f09 with SMTP id
 d9443c01a7336-2b2818934camr115174665ad.44.1775435660186; 
 Sun, 05 Apr 2026 17:34:20 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d1f1sm152541225ad.10.2026.04.05.17.34.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:34:19 -0700 (PDT)
Message-ID: <7ee1abe7-8d29-4152-b1e0-d0442da327fa@linaro.org>
Date: Mon, 6 Apr 2026 10:34:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/35] target/arm: add gt_calc_next_event_stream
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-27-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/21/26 00:05, Alex Bennée wrote:
> Two generic timers (K and H) are capable of generating timer event
> stream events. Provide a helper to calculate when the nearest one will
> happen. This will eventually be used when implementing WFE/WFET.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/cpu.h    | 10 ++++++
>   target/arm/helper.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 657ff4ab20b..bf6cf74c2e1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1208,6 +1208,16 @@ void arm_gt_sel2vtimer_cb(void *opaque);
>   unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
>   void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
>   
> +/**
> + * gt_calc_next_event_stream() - calculate and arm event stream timer
> + * @env: CPUArmState
> + *
> + * Calculate the next event stream time and return it. Returns -1 if
> + * no event streams are enabled. It is up to the WFE helpers to decide
> + * on the next time.
> + */
> +int64_t gt_calc_next_event_stream(CPUARMState *env);

Why cpu.h?  Where is this going to be used?

r~

> +
>   #define ARM_AFF0_SHIFT 0
>   #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
>   #define ARM_AFF1_SHIFT 8
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ba6db46d453..3627ffcdcfd 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -25,6 +25,7 @@
>   #include "exec/icount.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
> +#include "system/cpus.h"
>   #include "qapi/error.h"
>   #include "qemu/guest-random.h"
>   #ifdef CONFIG_TCG
> @@ -2022,6 +2023,90 @@ void arm_gt_hvtimer_cb(void *opaque)
>       gt_recalc_timer(cpu, GTIMER_HYPVIRT);
>   }
>   
> +/*
> + * Event Stream events don't do anything apart from wake up sleeping
> + * cores. These helpers calculate the next event stream event time so
> + * the WFE helper can decide when its next wake up tick will be.
> + */
> +static int64_t gt_recalc_one_evt(CPUARMState *env, uint32_t control, uint64_t offset)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    bool evnten = FIELD_EX32(control, CNTxCTL, EVNTEN);
> +
> +    if (evnten) {
> +        int evnti = FIELD_EX32(control, CNTxCTL, EVNTI);
> +        bool evntis = FIELD_EX32(control, CNTxCTL, EVNTIS);
> +        bool evntdir = FIELD_EX32(control, CNTxCTL, EVNTDIR);
> +        /*
> +         * To figure out when the next event timer should fire we need
> +         * to calculate which bit of the counter we want to flip and
> +         * which transition counts.
> +         *
> +         * So we calculate 1 << bit - current lower bits and then add
> +         * 1 << bit if the bit needs to flip twice to meet evntdir
> +         */
> +        int bit = evntis ? evnti + 8 : evnti;
> +        uint64_t count = gt_get_countervalue(env) - offset;
> +        uint64_t target_bit = BIT_ULL(bit);
> +        uint64_t lower_bits = MAKE_64BIT_MASK(0, bit - 1);
> +        uint64_t next_tick = target_bit - (count & lower_bits);
> +        uint64_t abstick;
> +
> +        /* do we need to bit flip twice? */
> +        if (((count & target_bit) != 0) ^ evntdir) {
> +            next_tick += target_bit;
> +        }
> +
> +        /*
> +         * Note that the desired next expiry time might be beyond the
> +         * signed-64-bit range of a QEMUTimer -- in this case we just
> +         * set the timer for as far in the future as possible. When the
> +         * timer expires we will reset the timer for any remaining period.
> +         */
> +        if (uadd64_overflow(next_tick, offset, &abstick)) {
> +            abstick = UINT64_MAX;
> +        }
> +        if (abstick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> +            return INT64_MAX;
> +        } else {
> +            return abstick;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +int64_t gt_calc_next_event_stream(CPUARMState *env)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    uint64_t hcr = arm_hcr_el2_eff(env);
> +    int64_t next_time = -1;
> +    uint64_t offset;
> +
> +    /* Unless we are missing EL2 this can generate events */
> +    if (arm_feature(env, ARM_FEATURE_EL2)) {
> +        offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
> +        next_time = gt_recalc_one_evt(env, env->cp15.cnthctl_el2, offset);
> +    }
> +
> +    /* Event stream events from virtual counter enabled? */
> +    if (!cpu_isar_feature(aa64_vh, cpu) ||
> +        !((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE))) {
> +        int64_t next_virt_time;
> +        offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
> +        next_virt_time = gt_recalc_one_evt(env, env->cp15.c14_cntkctl, offset);
> +
> +        /* is this earlier than the next physical event? */
> +        if (next_virt_time > 0) {
> +            if (next_time < 0 || next_virt_time < next_time) {
> +                next_time = next_virt_time;
> +            }
> +        }
> +    }
> +
> +    return next_time;
> +}
> +
>   static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>       /*
>        * Note that CNTFRQ is purely reads-as-written for the benefit


