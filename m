Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643DBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMj9-0002Qw-5e; Mon, 01 Jul 2024 15:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMj7-0002Qc-FL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:30:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMiw-0006cr-NV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:30:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so2233342b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719862201; x=1720467001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UbEgaQ6PILO319LDRRaIcm8IAYJGnAbRE8Ib1rTEuU=;
 b=X3yxT2axquk4BzikWFfnGMmKK3X9W+uAsZcCpxLOMShIrtWs+DbexBn8K24iPXrO4O
 O9e022jwZztkiggRrBhKaDOD1ePcVqf8dqC/tTR7/B5zl56AJqb7oQZhY50myCr+UUIy
 whvfp2SLj2+sJvKRBtK/50xwHLWUbc5X/95zbHf6kDXQhiDQijJzcjRywCHlJZdvIcZ0
 AZkdgOMYNYldpMFQt6Do7AaWhAozLEt2JwbktusGNntecNkRZOR7alSax7LH+xp6+QQD
 OItUiaakJKrQW/TEk/6QdyRTF8/w3h93cyneWbm7O0Mqq3PL8KfDh0cTc3tI2mi2GehV
 HUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862201; x=1720467001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6UbEgaQ6PILO319LDRRaIcm8IAYJGnAbRE8Ib1rTEuU=;
 b=fieh5qqDHm8vbaSO8qybRifohj+5xaXirtDO8D9pgnR0QWB+IcrV4jwoxPDEdRQu3Z
 M0tNhYEEVp99YG733CBeaH+F4OJszIppHCm1pJmlSDAVxMYJzgNTSHgqzZDrHABW+JTo
 bcvKSxMEY2xu/SPCvHSIefLEMsftuprAjhABtHG5rvtJbi07O+9fAfO6oBYofJAFiJ/G
 XyqZVPaqgzS28flzbbG+ADBzOEncRe+9zEVVLA0Yn3j/DSEw3QwckYyqsbteCNG0ORkz
 FRm4edURR1Z3f+Tx+Y1N1XM/8t0CnibOkT5iQXev/wnjiQ8VJkkTuSTR02qg3Q9T/+Ng
 pHsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW4uuyBdzE3S/5tU/4RNl2ZlOK8WzSPwVxvHIfpoWU7mRuFziemfjomPMEGanmDruKAVOB9fA6a0e1iuYmamlg+2Tqpps=
X-Gm-Message-State: AOJu0YydKv5lgyzCCHkD5H/6EdAD6sQzEJjJbyfUdzjKh8kSu3kAzcTJ
 pNVs6mXMlCscAa69VjMC3DBy2/mxbsnC4EPqPsLNALm3Gcp8aO/YaVXkXGvRh70=
X-Google-Smtp-Source: AGHT+IESwjOd+1zYSnu2h7GQ5hX9b7JwKEFLzUSXh4an+4NsXfd3akyUAcASHWBTbRafRi7Z+CbTAQ==
X-Received: by 2002:a05:6a20:6715:b0:1bd:1d46:e6ca with SMTP id
 adf61e73a8af0-1bef626ee2amr4045372637.50.1719862200641; 
 Mon, 01 Jul 2024 12:30:00 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804a96ac5sm6886568b3a.211.2024.07.01.12.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:30:00 -0700 (PDT)
Message-ID: <4c6a710c-6baf-4042-b3da-03ecde934325@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:29:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-6-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-6-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Privilege mode filtering can also be emulated for cycle/instret by
> tracking host_ticks/icount during each privilege mode switch. This
> patch implements that for both cycle/instret and mhpmcounters. The
> first one requires Smcntrpmf while the other one requires Sscofpmf
> to be enabled.
> 
> The cycle/instret are still computed using host ticks when icount
> is not enabled. Otherwise, they are computed using raw icount which
> is more accurate in icount mode.
> 
> Co-Developed-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h        |  11 +++++
>   target/riscv/cpu_bits.h   |   5 ++
>   target/riscv/cpu_helper.c |   9 +++-
>   target/riscv/csr.c        | 117 ++++++++++++++++++++++++++++++++--------------
>   target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++++++++
>   target/riscv/pmu.h        |   2 +
>   6 files changed, 199 insertions(+), 37 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c5d289e5f4b9..d56d640b06be 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -158,6 +158,15 @@ typedef struct PMUCTRState {
>       target_ulong irq_overflow_left;
>   } PMUCTRState;
>   
> +typedef struct PMUFixedCtrState {
> +        /* Track cycle and icount for each privilege mode */
> +        uint64_t counter[4];
> +        uint64_t counter_prev[4];
> +        /* Track cycle and icount for each privilege mode when V = 1*/
> +        uint64_t counter_virt[2];
> +        uint64_t counter_virt_prev[2];
> +} PMUFixedCtrState;
> +
>   struct CPUArchState {
>       target_ulong gpr[32];
>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> @@ -354,6 +363,8 @@ struct CPUArchState {
>       /* PMU event selector configured values for RV32 */
>       target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>   
> +    PMUFixedCtrState pmu_fixed_ctrs[2];
> +
>       target_ulong sscratch;
>       target_ulong mscratch;
>   
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5faa817453bb..18f19615e4fe 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -926,6 +926,11 @@ typedef enum RISCVException {
>   #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>   #define MHPMEVENTH_BIT_VUINH               BIT(26)
>   
> +#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
> +                                            MHPMEVENT_BIT_SINH  | \
> +                                            MHPMEVENT_BIT_UINH  | \
> +                                            MHPMEVENT_BIT_VSINH | \
> +                                            MHPMEVENT_BIT_VUINH)
>   #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
>   #define MHPMEVENT_IDX_MASK                 0xFFFFF
>   #define MHPMEVENT_SSCOF_RESVD              16
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 10d3fdaed376..395a1d914061 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -695,9 +695,14 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>   {
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
> -    if (icount_enabled() && newpriv != env->priv) {
> -        riscv_itrigger_update_priv(env);
> +    if (newpriv != env->priv || env->virt_enabled != virt_en) {
> +        if (icount_enabled()) {
> +            riscv_itrigger_update_priv(env);
> +        }
> +
> +        riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
>       }
> +
>       /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>       env->priv = newpriv;
>       env->xl = cpu_recompute_xl(env);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 665c534db1a0..c292d036bcb2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -788,36 +788,16 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +#if defined(CONFIG_USER_ONLY)
>   /* User Timers and Counters */
> -static target_ulong get_ticks(bool shift, bool instructions)
> +static target_ulong get_ticks(bool shift)
>   {
> -    int64_t val;
> -    target_ulong result;
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (icount_enabled()) {
> -        if (instructions) {
> -            val = icount_get_raw();
> -        } else {
> -            val = icount_get();
> -        }
> -    } else {
> -        val = cpu_get_host_ticks();
> -    }
> -#else
> -    val = cpu_get_host_ticks();
> -#endif
> -
> -    if (shift) {
> -        result = val >> 32;
> -    } else {
> -        result = val;
> -    }
> +    int64_t val = cpu_get_host_ticks();
> +    target_ulong result = shift ? val >> 32 : val;
>   
>       return result;
>   }
>   
> -#if defined(CONFIG_USER_ONLY)
>   static RISCVException read_time(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>   {
> @@ -835,14 +815,14 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
>   static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>   {
> -    *val = get_ticks(false, (csrno == CSR_INSTRET));
> +    *val = get_ticks(false);
>       return RISCV_EXCP_NONE;
>   }
>   
>   static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
>                                          target_ulong *val)
>   {
> -    *val = get_ticks(true, (csrno == CSR_INSTRETH));
> +    *val = get_ticks(true);
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -956,17 +936,82 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> +                                                         int counter_idx,
> +                                                         bool upper_half)
> +{
> +    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
> +    uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
> +    uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
> +    target_ulong result = 0;
> +    uint64_t curr_val = 0;
> +    uint64_t cfg_val = 0;
> +
> +    if (counter_idx == 0) {
> +        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> +                  env->mcyclecfg;
> +    } else if (counter_idx == 2) {
> +        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
> +                  env->minstretcfg;
> +    } else {
> +        cfg_val = upper_half ?
> +                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
> +                  env->mhpmevent_val[counter_idx];
> +        cfg_val &= MHPMEVENT_FILTER_MASK;
> +    }
> +
> +    if (!cfg_val) {
> +        if (icount_enabled()) {
> +                curr_val = inst ? icount_get_raw() : icount_get();
> +        } else {
> +            curr_val = cpu_get_host_ticks();
> +        }
> +
> +        goto done;
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> +        curr_val += counter_arr[PRV_M];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> +        curr_val += counter_arr[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> +        curr_val += counter_arr[PRV_U];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> +        curr_val += counter_arr_virt[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> +        curr_val += counter_arr_virt[PRV_U];
> +    }
> +
> +done:
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        result = upper_half ? curr_val >> 32 : curr_val;
> +    } else {
> +        result = curr_val;
> +    }
> +
> +    return result;
> +}
> +
>   static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>                                           target_ulong val)
>   {
>       int ctr_idx = csrno - CSR_MCYCLE;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>       uint64_t mhpmctr_val = val;
> -    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>   
>       counter->mhpmcounter_val = val;
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        counter->mhpmcounter_prev = get_ticks(false, instr);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                                ctr_idx, false);
>           if (ctr_idx > 2) {
>               if (riscv_cpu_mxl(env) == MXL_RV32) {
>                   mhpmctr_val = mhpmctr_val |
> @@ -989,12 +1034,13 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>       uint64_t mhpmctr_val = counter->mhpmcounter_val;
>       uint64_t mhpmctrh_val = val;
> -    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>   
>       counter->mhpmcounterh_val = val;
>       mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        counter->mhpmcounterh_prev = get_ticks(true, instr);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                                 ctr_idx, true);
>           if (ctr_idx > 2) {
>               riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>           }
> @@ -1013,7 +1059,6 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                            counter->mhpmcounter_prev;
>       target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
>                                           counter->mhpmcounter_val;
> -    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>   
>       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>           /*
> @@ -1034,8 +1079,10 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>        * The kernel computes the perf delta by subtracting the current value from
>        * the value it initialized previously (ctr_val).
>        */
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        *val = get_ticks(upper_half, instr) - ctr_prev + ctr_val;
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
> +                                                    ctr_prev + ctr_val;
>       } else {
>           *val = ctr_val;
>       }
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 0e7d58b8a5c2..ac648cff8d7c 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
> +#include "qemu/timer.h"
>   #include "cpu.h"
>   #include "pmu.h"
>   #include "sysemu/cpu-timers.h"
> @@ -176,6 +177,97 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
>       return 0;
>   }
>   
> +/*
> + * Information needed to update counters:
> + *  new_priv, new_virt: To correctly save starting snapshot for the newly
> + *                      started mode. Look at array being indexed with newprv.
> + *  old_priv, old_virt: To correctly select previous snapshot for old priv
> + *                      and compute delta. Also to select correct counter
> + *                      to inc. Look at arrays being indexed with env->priv.
> + *
> + *  To avoid the complexity of calling this function, we assume that
> + *  env->priv and env->virt_enabled contain old priv and old virt and
> + *  new priv and new virt values are passed in as arguments.
> + */
> +static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> +                                         target_ulong newpriv, bool new_virt)
> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_icount;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_icount = icount_get_raw();
> +    } else {
> +        current_icount = cpu_get_host_ticks();
> +    }
> +
> +    if (env->virt_enabled) {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
> +        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter;
> +        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +    if (new_virt) {
> +        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +     /*
> +      * new_priv can be same as env->priv. So we need to calculate
> +      * delta first before updating snapshot_new[new_priv].
> +      */
> +    delta = current_icount - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] = current_icount;
> +
> +    counter_arr[env->priv] += delta;
> +}
> +
> +static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
> +                                        target_ulong newpriv, bool new_virt)
> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_ticks;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_ticks = icount_get();
> +    } else {
> +        current_ticks = cpu_get_host_ticks();
> +    }
> +
> +    if (env->virt_enabled) {
> +        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
> +        snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        counter_arr = env->pmu_fixed_ctrs[0].counter;
> +        snapshot_prev = env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    if (new_virt) {
> +        snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    delta = current_ticks - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] = current_ticks;
> +
> +    counter_arr[env->priv] += delta;
> +}
> +
> +void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
> +                                 bool new_virt)
> +{
> +    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
> +    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
> +}
> +
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>   {
>       uint32_t ctr_idx;
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 7c0ad661e050..ca40cfeed647 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -34,5 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
> +void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
> +                                 bool new_virt);
>   
>   #endif /* RISCV_PMU_H */
> 

