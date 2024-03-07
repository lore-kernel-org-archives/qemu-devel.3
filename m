Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD11C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riA0m-0006AV-4G; Thu, 07 Mar 2024 04:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1riA0j-0006AI-Dh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:25:57 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1riA0f-0005lA-KR
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:25:56 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd2dca2007so5117925ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709803552; x=1710408352;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5OrQxlIgcunbm7YTHgdGJ0ZL3HnyooZNX2DqUotxHN0=;
 b=xH1aA40KDBCEfqbiJgWA9qm6kRYgbiqHYUoH4vUkoLnAw8C6SOZ5O9rv9cur0C1Axn
 oGIcuBZxepUofDYCNfpl6OufzQf/smAC++kbKXXyVC4++JGO5vFjdZPXPfY9k3q+HBkW
 98EwSsoLdkn871eQbT1CpMxqXiUuMzkktXevYEc28G2pJ+Cml6Htmoz5ljKPm2vM+gGB
 QUAlX/4fdlTSjW/8mNV/tT0XhQ69BW7ZpO1BIh8X8ZZ/Hl89qriamWbrOpa5a/NcURo8
 WtiQ8m47hvmFFIinUroPSkBOkaNP/W/wP4gUc3RsZweAThKaSwxQin44utdzbVrzOT0R
 oFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803552; x=1710408352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OrQxlIgcunbm7YTHgdGJ0ZL3HnyooZNX2DqUotxHN0=;
 b=MU0hAiwi6FNuX7QKEplbu4gwS9T90+VmsYsOk+oHPcQcNd+wkrPvhbs912btN8uAQW
 04LcMkWmfkwM/ocvXG5Q/g95inAQIcNbKqg9acEIIgCTzk/CLZsULfPaH0mPJDOdDjpj
 GeouA1/gTPYSOTq9hR0HtQbEaSodsXKBOyKMjcYqZMK8SzRKPDOAZ24noeo9IgRYZcAu
 OWf38cQkUyEdCj5+rmCigwYyywrwRIrUmVtqBkwJCl5I+pbSdSVReWY8+QzgdPUL1m9/
 Ip+WUA3RRW7uVncy7iTsc450FQEsbxlOV+6xEK1z4Rr0xq0A42ZPROBUHc7JGM+tjeiP
 VkTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfEDkMuezuryzQd/EMFJAbvxaOkqQLUca5u6OhxKtx/+h/jVbILGhG7HYYrIcYGnOP2o8Q6hvlWMyH5AbTWF1K+PfoBzE=
X-Gm-Message-State: AOJu0YyVEbTHiTbOQ6aSZ/6KF3v6dWqnhSetTZzLOgYmRVsBD4Eoe3Um
 jO35t+y9Ka8hneEcDsVw6Cj4Zil+2an4p7+s4Q7MI7SlSi7gMJtnswM0bF4HD40=
X-Google-Smtp-Source: AGHT+IEY9d009CCZu2HncHL/SbB1zQic8w+EkxUKWwa7Jp3dXhEs/Ucn1VNKtDKA9X6eqUnHQLb3BQ==
X-Received: by 2002:a17:902:dac9:b0:1dc:696d:ec64 with SMTP id
 q9-20020a170902dac900b001dc696dec64mr8691615plx.22.1709803551578; 
 Thu, 07 Mar 2024 01:25:51 -0800 (PST)
Received: from [172.16.0.23] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm10058252plh.35.2024.03.07.01.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:25:51 -0800 (PST)
Message-ID: <82541ad6-186f-4401-83df-38f98eb211fc@rivosinc.com>
Date: Thu, 7 Mar 2024 01:25:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-6-atishp@rivosinc.com>
 <165adab6-d41f-4d72-b059-b13219cd5ac9@linux.alibaba.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <165adab6-d41f-4d72-b059-b13219cd5ac9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 3/4/24 22:47, LIU Zhiwei wrote:
>
> On 2024/2/29 2:51, Atish Patra wrote:
>> Privilege mode filtering can also be emulated for cycle/instret by
>> tracking host_ticks/icount during each privilege mode switch. This
>> patch implements that for both cycle/instret and mhpmcounters. The
>> first one requires Smcntrpmf while the other one requires Sscofpmf
>> to be enabled.
>>
>> The cycle/instret are still computed using host ticks when icount
>> is not enabled. Otherwise, they are computed using raw icount which
>> is more accurate in icount mode.
>>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   target/riscv/cpu.h        | 11 +++++
>>   target/riscv/cpu_bits.h   |  5 ++
>>   target/riscv/cpu_helper.c | 17 ++++++-
>>   target/riscv/csr.c        | 96 ++++++++++++++++++++++++++++++---------
>>   target/riscv/pmu.c        | 64 ++++++++++++++++++++++++++
>>   target/riscv/pmu.h        |  2 +
>>   6 files changed, 171 insertions(+), 24 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 174e8ba8e847..9e21d7f7d635 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -157,6 +157,15 @@ typedef struct PMUCTRState {
>>       target_ulong irq_overflow_left;
>>   } PMUCTRState;
>>   +typedef struct PMUFixedCtrState {
>> +        /* Track cycle and icount for each privilege mode */
>> +        uint64_t counter[4];
>> +        uint64_t counter_prev[4];
>> +        /* Track cycle and icount for each privilege mode when V = 1*/
>> +        uint64_t counter_virt[2];
>> +        uint64_t counter_virt_prev[2];
>> +} PMUFixedCtrState;
>> +
>>   struct CPUArchState {
>>       target_ulong gpr[32];
>>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>> @@ -353,6 +362,8 @@ struct CPUArchState {
>>       /* PMU event selector configured values for RV32 */
>>       target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>>   +    PMUFixedCtrState pmu_fixed_ctrs[2];
>> +
>>       target_ulong sscratch;
>>       target_ulong mscratch;
>>   diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index e866c60a400c..5fe349e313dc 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -920,6 +920,11 @@ typedef enum RISCVException {
>>   #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>>   #define MHPMEVENTH_BIT_VUINH               BIT(26)
>>   +#define MHPMEVENT_FILTER_MASK (MHPMEVENT_BIT_MINH  | \
>> +                                            MHPMEVENT_BIT_SINH | \
>> +                                            MHPMEVENT_BIT_UINH | \
>> +                                            MHPMEVENT_BIT_VSINH | \
>> + MHPMEVENT_BIT_VUINH)
>>   #define MHPMEVENT_SSCOF_MASK _ULL(0xFFFF000000000000)
>>   #define MHPMEVENT_IDX_MASK                 0xFFFFF
>>   #define MHPMEVENT_SSCOF_RESVD              16
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index d462d95ee165..33965d843d46 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -718,8 +718,21 @@ void riscv_cpu_set_mode(CPURISCVState *env, 
>> target_ulong newpriv)
>>   {
>>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>>   -    if (icount_enabled() && newpriv != env->priv) {
>> -        riscv_itrigger_update_priv(env);
>> +    /*
>> +     * Invoke cycle/instret update between priv mode changes or
>> +     * VS->HS mode transition is SPV bit must be set
>> +     * HS->VS mode transition where virt_enabled must be set
>> +     * In both cases, priv will S mode only.
>> +     */
>> +    if (newpriv != env->priv ||
>> +       (env->priv == PRV_S && newpriv == PRV_S &&
>> +        (env->virt_enabled || get_field(env->hstatus, HSTATUS_SPV)))) {
>> +        if (icount_enabled()) {
>> +            riscv_itrigger_update_priv(env);
>> +            riscv_pmu_icount_update_priv(env, newpriv);
>> +        } else {
>> +            riscv_pmu_cycle_update_priv(env, newpriv);
>> +        }
>>       }
>>       /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>>       env->priv = newpriv;
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index ff9bac537593..482e212c5f74 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -788,32 +788,16 @@ static RISCVException write_vcsr(CPURISCVState 
>> *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>   +#if defined(CONFIG_USER_ONLY)
>>   /* User Timers and Counters */
>>   static target_ulong get_ticks(bool shift)
>>   {
>> -    int64_t val;
>> -    target_ulong result;
>> -
>> -#if !defined(CONFIG_USER_ONLY)
>> -    if (icount_enabled()) {
>> -        val = icount_get();
>> -    } else {
>> -        val = cpu_get_host_ticks();
>> -    }
>> -#else
>> -    val = cpu_get_host_ticks();
>> -#endif
>> -
>> -    if (shift) {
>> -        result = val >> 32;
>> -    } else {
>> -        result = val;
>> -    }
>> +    int64_t val = cpu_get_host_ticks();
>> +    target_ulong result = shift ? val >> 32 : val;
>>         return result;
>>   }
>>   -#if defined(CONFIG_USER_ONLY)
>>   static RISCVException read_time(CPURISCVState *env, int csrno,
>>                                   target_ulong *val)
>>   {
>> @@ -952,6 +936,71 @@ static RISCVException 
>> write_mhpmeventh(CPURISCVState *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>   +static target_ulong 
>> riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>> +                                                         int 
>> counter_idx,
>> +                                                         bool 
>> upper_half)
>> +{
>> +    uint64_t curr_val = 0;
>> +    target_ulong result = 0;
>> +    uint64_t *counter_arr = icount_enabled() ? 
>> env->pmu_fixed_ctrs[1].counter :
>> +                            env->pmu_fixed_ctrs[0].counter;
>> +    uint64_t *counter_arr_virt = icount_enabled() ?
>> + env->pmu_fixed_ctrs[1].counter_virt :
>> + env->pmu_fixed_ctrs[0].counter_virt;
>> +    uint64_t cfg_val = 0;
>> +
>> +    if (counter_idx == 0) {
>> +        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
>> +                  env->mcyclecfg;
>> +    } else if (counter_idx == 2) {
>> +        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
>> +                  env->minstretcfg;
>> +    } else {
>> +        cfg_val = upper_half ?
>> + ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
>> +                  env->mhpmevent_val[counter_idx];
>> +        cfg_val &= MHPMEVENT_FILTER_MASK;
>> +    }
>> +
>> +    if (!cfg_val) {
>> +        if (icount_enabled()) {
>> +            curr_val = icount_get_raw();
>> +        } else {
>> +            curr_val = cpu_get_host_ticks();
>> +        }
>> +        goto done;
>> +    }
>> +
>> +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
>> +        curr_val += counter_arr[PRV_M];
>> +    }
>> +
>> +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
>> +        curr_val += counter_arr[PRV_S];
>> +    }
>> +
>> +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
>> +        curr_val += counter_arr[PRV_U];
>> +    }
>> +
>> +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
>> +        curr_val += counter_arr_virt[PRV_S];
>> +    }
>> +
>> +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
>> +        curr_val += counter_arr_virt[PRV_U];
>> +    }
>> +
>> +done:
>> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
>> +        result = upper_half ? curr_val >> 32 : curr_val;
>> +    } else {
>> +        result = curr_val;
>> +    }
>> +
>> +    return result;
>> +}
>> +
>>   static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>>                                           target_ulong val)
>>   {
>> @@ -962,7 +1011,8 @@ static RISCVException 
>> write_mhpmcounter(CPURISCVState *env, int csrno,
>>       counter->mhpmcounter_val = val;
>>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> -        counter->mhpmcounter_prev = get_ticks(false);
>> +        counter->mhpmcounter_prev = 
>> riscv_pmu_ctr_get_fixed_counters_val(env,
>> + ctr_idx, false);
>>           if (ctr_idx > 2) {
>>               if (riscv_cpu_mxl(env) == MXL_RV32) {
>>                   mhpmctr_val = mhpmctr_val |
>> @@ -990,7 +1040,8 @@ static RISCVException 
>> write_mhpmcounterh(CPURISCVState *env, int csrno,
>>       mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
>>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> -        counter->mhpmcounterh_prev = get_ticks(true);
>> +        counter->mhpmcounterh_prev = 
>> riscv_pmu_ctr_get_fixed_counters_val(env,
>> + ctr_idx, true);
>>           if (ctr_idx > 2) {
>>               riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>>           }
>> @@ -1031,7 +1082,8 @@ static RISCVException 
>> riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>>        */
>>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> -        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
>> +        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, 
>> upper_half) -
>> +                                                    ctr_prev + ctr_val;
>>       } else {
>>           *val = ctr_val;
>>       }
>> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
>> index 0e7d58b8a5c2..37309ff64cb6 100644
>> --- a/target/riscv/pmu.c
>> +++ b/target/riscv/pmu.c
>> @@ -19,6 +19,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/log.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/timer.h"
>>   #include "cpu.h"
>>   #include "pmu.h"
>>   #include "sysemu/cpu-timers.h"
>> @@ -176,6 +177,69 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU 
>> *cpu, uint32_t ctr_idx)
>>       return 0;
>>   }
>>   +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong 
>> newpriv)
>> +{
>> +    uint64_t delta;
>> +    uint64_t *counter_arr;
>> +    uint64_t *counter_arr_prev;
>> +    uint64_t current_icount = icount_get_raw();
>> +
>> +    if (env->virt_enabled) {
>> +        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
>> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
>> +    } else {
>> +        counter_arr = env->pmu_fixed_ctrs[1].counter;
>> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_prev;
>> +    }
>> +
>> +    if (newpriv != env->priv) {
>> +        delta = current_icount - counter_arr_prev[env->priv];
>> +        counter_arr_prev[newpriv] = current_icount;
>> +    } else {
>> +        delta = current_icount - counter_arr_prev[env->priv];
>> +        if (env->virt_enabled) {
>> +            /* HS->VS transition.The previous value should 
>> correspond to HS. */
>
> Hi Atish,
>
> Dose env->virt_enabled ensure HS->VS transition?
>
As per my understanding, riscv_cpu_set_virt_enabled always invoked 
before riscv_cpu_set_mode.

That means env->virt_enabled must be enabled before we enter into this 
function. Let me know if I missed

an scenario.


> I think VS->VS also keeps  env->virt_enabled to be true, where the 
> previous value should correspond to VS.
>
yeah. good point. We should check HSTATUS_SPV here as well.


> Thanks,
> Zhiwei
>
>> + env->pmu_fixed_ctrs[1].counter_prev[PRV_S] = current_icount;
>> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
>> +            /* VS->HS transition.The previous value should 
>> correspond to VS. */
>> +            env->pmu_fixed_ctrs[1].counter_virt_prev[PRV_S] = 
>> current_icount;
>> +        }
>> +   }
>> +
>> +    counter_arr[env->priv] += delta;
>> +}
>> +
>> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong 
>> newpriv)
>> +{
>> +    uint64_t delta;
>> +    uint64_t *counter_arr;
>> +    uint64_t *counter_arr_prev;
>> +    uint64_t current_host_ticks = cpu_get_host_ticks();
>> +
>> +    if (env->virt_enabled) {
>> +        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
>> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
>> +    } else {
>> +        counter_arr = env->pmu_fixed_ctrs[0].counter;
>> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_prev;
>> +    }
>> +
>> +    if (newpriv != env->priv) {
>> +        delta = current_host_ticks - counter_arr_prev[env->priv];
>> +        counter_arr_prev[newpriv] = current_host_ticks;
>> +    } else {
>> +        delta = current_host_ticks - counter_arr_prev[env->priv];
>> +        if (env->virt_enabled) {
>> +            env->pmu_fixed_ctrs[0].counter_prev[PRV_S] = 
>> current_host_ticks;
>> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
>> +            env->pmu_fixed_ctrs[0].counter_virt_prev[PRV_S] =
>> +            current_host_ticks;
>> +        }
>> +   }
>> +
>> +    counter_arr[env->priv] += delta;
>> +}
>> +
>>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx 
>> event_idx)
>>   {
>>       uint32_t ctr_idx;
>> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
>> index 505fc850d38e..50de6031a730 100644
>> --- a/target/riscv/pmu.h
>> +++ b/target/riscv/pmu.h
>> @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum 
>> riscv_pmu_event_idx event_idx);
>>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char 
>> *pmu_name);
>>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>>                             uint32_t ctr_idx);
>> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong 
>> newpriv);
>> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong 
>> newpriv);

