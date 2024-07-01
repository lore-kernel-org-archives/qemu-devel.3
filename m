Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5659CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMqt-00005g-Eu; Mon, 01 Jul 2024 15:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMqm-0008Sz-Rm
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:38:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMqj-0000dV-Pi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:38:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1faad2f1967so33450345ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719862684; x=1720467484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9gm6U3QuN8qh4jvxqkaEeESn2G0o2VxAmU601KibAg=;
 b=CA79542D9JLuM8us3HlLNbBG6ZbMDWCnPaQG0bYYhJJlD2NEkAuGgOECuv2hwFoKoy
 t/dJ6jZRMBTBGVwNmu2kjowCT7xPm1FRkkVyCR4BLElEMbN4jlw1ZtaSi7Tlv2k6hasx
 IG8MiFrr5a1uCAMvlEloWE907lT4x3Ietu9lMXA1boe3fwBNhiBPgQgVCx/3Negp4c6+
 Ro5ZmSJpb7e7fwrLVPeKNZWefbCZQg4JXqaCJIIxe/12qLhl07oG96+yCuk5iO7HbH8g
 Wb6UI7oxJ3opH2eXiIrAO83DbBKa4LrLAQE+lVGjWXp7MWaILbdHdImtb6OsbXOY3J1d
 G1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862684; x=1720467484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9gm6U3QuN8qh4jvxqkaEeESn2G0o2VxAmU601KibAg=;
 b=aVvxit8sou6qgMLkmnDpN/7aZQkspUmlEgSpwc1z2QjA5tpeP+bC34kdOY8yEpgNLY
 T77NXr8KnYPUOl+eSSHnk025mT+Vvdw2GEvU9A/VbEMesNjEPz+NnjwdX7a7w6jevxVt
 SyomABi0AEm/fj06rg6h8FrzveUCUclOg/iLsyJam8Jo2zZzLAC8I6e3EoNsHwf3IzAL
 BnNDE+/Z2kAXRdds+2AVfJGOcbNOcgxVd+XsYUYWIpYJv7FtD5CmlxIYr8gZKxconmCP
 qdaecXNU1WAx5mGkgK6wAOBf25IZlRdKv0RtfW1VXbBGbx3q1xPPogtAkYBoVrE5UC+3
 /arQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ6UljjmDcHRDqpFc11w1ScoOTFWCWDBeo3E6qf2THf4Gkr8UJV38zekl3u3F6WTNsya8R+5L0dW2xSXCjiYd31mw26A4=
X-Gm-Message-State: AOJu0YyyYYY2BXgTWvzXIw1hBRJE/RKZJb8Ns9u5LyTaOTj2GYbTMz2T
 JbAvbvw5tg/l1xk1ohZU91GPL5fx05TINAe2NEoAGggfDPxriDh/yWbz4I0XcqcFV+xSiEF+4GC
 m
X-Google-Smtp-Source: AGHT+IEqkd81vIVrMAxKB1F3yuIoZl1d/vnHMSfLDtiyFIrJjIh2Jo1a+XDNo0dTmmKngeyuB69v9w==
X-Received: by 2002:a17:902:cec3:b0:1fa:a34e:8804 with SMTP id
 d9443c01a7336-1fac7e27e8cmr152863675ad.1.1719862684263; 
 Mon, 01 Jul 2024 12:38:04 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1596920sm68711185ad.268.2024.07.01.12.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:38:03 -0700 (PDT)
Message-ID: <c59da172-0485-479f-8b44-573c40cc9b8e@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:37:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] target/riscv: More accurately model priv mode
 filtering.
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-10-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-10-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 6/26/24 8:57 PM, Atish Patra wrote:
> From: Rajnesh Kanwal <rkanwal@rivosinc.com>
> 
> In case of programmable counters configured to count inst/cycles
> we often end-up with counter not incrementing at all from kernel's
> perspective.
> 
> For example:
> - Kernel configures hpm3 to count instructions and sets hpmcounter
>    to -10000 and all modes except U mode are inhibited.
> - In QEMU we configure a timer to expire after ~10000 instructions.
> - Problem is, it's often the case that kernel might not even schedule
>    Umode task and we hit the timer callback in QEMU.
> - In the timer callback we inject the interrupt into kernel, kernel
>    runs the handler and reads hpmcounter3 value.
> - Given QEMU maintains individual counters to count for each privilege
>    mode, and given umode never ran, the umode counter didn't increment
>    and QEMU returns same value as was programmed by the kernel when
>    starting the counter.
> - Kernel checks for overflow using previous and current value of the
>    counter and reprograms the counter given there wasn't an overflow
>    as per the counter value. (Which itself is a problem. We have QEMU
>    telling kernel that counter3 overflowed but the counter value
>    returned by QEMU doesn't seem to reflect that.).
> 
> This change makes sure that timer is reprogrammed from the handler
> if the counter didn't overflow based on the counter value.
> 
> Second, this change makes sure that whenever the counter is read,
> it's value is updated to reflect the latest count.
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c |  5 ++++-
>   target/riscv/pmu.c | 30 +++++++++++++++++++++++++++---
>   target/riscv/pmu.h |  2 ++
>   3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 150e02f080ec..91172b90e000 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -970,6 +970,9 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>           goto done;
>       }
>   
> +    /* Update counter before reading. */
> +    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
> +
>       if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
>           curr_val += counter_arr[PRV_M];
>       }
> @@ -1053,7 +1056,7 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> +RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                            bool upper_half, uint32_t ctr_idx)
>   {
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 63420d9f3679..a4729f6c53bb 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -425,6 +425,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>       target_ulong *mhpmevent_val;
>       uint64_t of_bit_mask;
>       int64_t irq_trigger_at;
> +    uint64_t curr_ctr_val, curr_ctrh_val;
> +    uint64_t ctr_val;
>   
>       if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
>           evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> @@ -454,6 +456,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>           return;
>       }
>   
> +    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
> +    ctr_val = counter->mhpmcounter_val;
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
> +        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
> +        ctr_val = ctr_val |
> +                ((uint64_t)counter->mhpmcounterh_val << 32);
> +    }
> +
> +    /*
> +     * We can not accommodate for inhibited modes when setting up timer. Check
> +     * if the counter has actually overflowed or not by comparing current
> +     * counter value (accommodated for inhibited modes) with software written
> +     * counter value.
> +     */
> +    if (curr_ctr_val >= ctr_val) {
> +        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
> +        return;
> +    }
> +
>       if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
>           /* Generate interrupt only if OF bit is clear */
>           if (!(*mhpmevent_val & of_bit_mask)) {
> @@ -475,7 +497,7 @@ void riscv_pmu_timer_cb(void *priv)
>   
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>   {
> -    uint64_t overflow_delta, overflow_at;
> +    uint64_t overflow_delta, overflow_at, curr_ns;
>       int64_t overflow_ns, overflow_left = 0;
>       RISCVCPU *cpu = env_archcpu(env);
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> @@ -506,8 +528,10 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>       } else {
>           return -1;
>       }
> -    overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                  overflow_ns;
> +    curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    overflow_at =  curr_ns + overflow_ns;
> +    if (overflow_at <= curr_ns)
> +        overflow_at = UINT64_MAX;
>   
>       if (overflow_at > INT64_MAX) {
>           overflow_left += overflow_at - INT64_MAX;
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index ca40cfeed647..3853d0e2629e 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -36,5 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
>   void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
>                                    bool new_virt);
> +RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> +                                  bool upper_half, uint32_t ctr_idx);
>   
>   #endif /* RISCV_PMU_H */
> 

