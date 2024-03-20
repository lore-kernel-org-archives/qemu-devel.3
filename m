Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D19CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqGn-0004gB-3S; Wed, 20 Mar 2024 03:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rmqGk-0004fh-K5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:21:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rmqGh-0001nA-2Y
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:21:50 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso4786127a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710919305; x=1711524105;
 darn=nongnu.org; 
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgC9BeGq+644j/uIifNPAaXQgujGgphB8utpOm6i0T8=;
 b=phXiLdAe6sSob04J9So2e0p4AEtX10i8Q8OwGlYSfaXaM3zzVrPLnVy6ji/JfFnqgg
 whFxp6v3lqcL6q7MQ0J4wRkAZaTYPSKW9W8AOor2XF3YNjlGj7Bs74wQFMWVrLc108AF
 zghgVdluHI8MIXY+oIvzOkA+NMNd3CB4dGVxrhK/Q4UspHoehaicLBdaiCDVLJNLUHGa
 Rm+1osACbmnqVDZWSIz0erEd6ukIaGpmawJ7IqzZB2Pa1wIyc3xnrMgygJys5/n4zH+R
 8sZCkz71d4pxpXViuV83wIZ0+aiPoENx5ghcSPqgCaCmy3Dj7Fn0AL8jWP0wCIZivxKC
 5N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919305; x=1711524105;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xgC9BeGq+644j/uIifNPAaXQgujGgphB8utpOm6i0T8=;
 b=EgX3F+jLIw+ypRWnPTkTXuYxF6BDFDgkTd0e+Hp63vZS19QX5N3EolFSuHh2yoHFi+
 UtvVvWlJOE35/zpbjgJmse7KL8BvtZKIlnX/ZkSuPBXIhu/CAuERdbwpRk+cwnGN6jn3
 3cYnOJpAhXEd9G+kAlJ9vczjHG7AfmQcQScpaI3Vpd0ThgUdUX3VM0PUw+Hmg39JRVE2
 MQtkNRP7L6fT/MqG0Ay+yZnWum7Dd8VGegKMpdycK1AZmoSChD1kAR/GGFGdMwUQqbSU
 TaN5oXANIk0sqC6fasQ80qAgq/k7GhvB1IVnoO4rgnWlF6pSM6Kv33LZBAPcKmz8z8Nt
 Jxhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVGt+oSvb/0C7xKBR02jIQm5ab5VkW6GhMbgiQg2NxZFyPpBk026I0B41yDXVN0eWDsyOlo1czhnIEr+ragdYq8oH2+R0=
X-Gm-Message-State: AOJu0YxqTgT0NP8KZ12jXHnyzHJPllkpaptsyybmIPSxI7Dw4wR4g11e
 BOKJ1uN9+OI96CME9wSvWFfwF9F8h99fF/O+oNGu8bNEA+gWFgM4bWo09xD88rY=
X-Google-Smtp-Source: AGHT+IHyVp3AHVLGPj3aZ9+siGEiFk9B9tgvuAzIpL4DHdt5Q4Gq/mvD7RPyEAf3IqS+0PaQv5ulfQ==
X-Received: by 2002:a05:6a20:2591:b0:1a3:6b99:33a6 with SMTP id
 k17-20020a056a20259100b001a36b9933a6mr6866476pzd.18.1710919304823; 
 Wed, 20 Mar 2024 00:21:44 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
 by smtp.gmail.com with ESMTPSA id
 qa17-20020a17090b4fd100b0029fff3fc2e9sm708499pjb.10.2024.03.20.00.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 00:21:44 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------1sOzVCqVOHdtQoDvMc8FK9D7"
Message-ID: <63fd0094-5f8f-40f9-aaea-42b3925ff6b9@rivosinc.com>
Date: Wed, 20 Mar 2024 00:21:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-6-atishp@rivosinc.com>
 <165adab6-d41f-4d72-b059-b13219cd5ac9@linux.alibaba.com>
 <82541ad6-186f-4401-83df-38f98eb211fc@rivosinc.com>
 <CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------1sOzVCqVOHdtQoDvMc8FK9D7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/19/24 21:54, Alistair Francis wrote:
> On Thu, Mar 7, 2024 at 7:26 PM Atish Patra<atishp@rivosinc.com>  wrote:
>>
>> On 3/4/24 22:47, LIU Zhiwei wrote:
>>> On 2024/2/29 2:51, Atish Patra wrote:
>>>> Privilege mode filtering can also be emulated for cycle/instret by
>>>> tracking host_ticks/icount during each privilege mode switch. This
>>>> patch implements that for both cycle/instret and mhpmcounters. The
>>>> first one requires Smcntrpmf while the other one requires Sscofpmf
>>>> to be enabled.
>>>>
>>>> The cycle/instret are still computed using host ticks when icount
>>>> is not enabled. Otherwise, they are computed using raw icount which
>>>> is more accurate in icount mode.
>>>>
>>>> Reviewed-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>>>> Signed-off-by: Atish Patra<atishp@rivosinc.com>
>>>> ---
>>>>    target/riscv/cpu.h        | 11 +++++
>>>>    target/riscv/cpu_bits.h   |  5 ++
>>>>    target/riscv/cpu_helper.c | 17 ++++++-
>>>>    target/riscv/csr.c        | 96 ++++++++++++++++++++++++++++++---------
>>>>    target/riscv/pmu.c        | 64 ++++++++++++++++++++++++++
>>>>    target/riscv/pmu.h        |  2 +
>>>>    6 files changed, 171 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>> index 174e8ba8e847..9e21d7f7d635 100644
>>>> --- a/target/riscv/cpu.h
>>>> +++ b/target/riscv/cpu.h
>>>> @@ -157,6 +157,15 @@ typedef struct PMUCTRState {
>>>>        target_ulong irq_overflow_left;
>>>>    } PMUCTRState;
>>>>    +typedef struct PMUFixedCtrState {
>>>> +        /* Track cycle and icount for each privilege mode */
>>>> +        uint64_t counter[4];
>>>> +        uint64_t counter_prev[4];
>>>> +        /* Track cycle and icount for each privilege mode when V = 1*/
>>>> +        uint64_t counter_virt[2];
>>>> +        uint64_t counter_virt_prev[2];
>>>> +} PMUFixedCtrState;
>>>> +
>>>>    struct CPUArchState {
>>>>        target_ulong gpr[32];
>>>>        target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>>>> @@ -353,6 +362,8 @@ struct CPUArchState {
>>>>        /* PMU event selector configured values for RV32 */
>>>>        target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>>>>    +    PMUFixedCtrState pmu_fixed_ctrs[2];
>>>> +
>>>>        target_ulong sscratch;
>>>>        target_ulong mscratch;
>>>>    diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>>> index e866c60a400c..5fe349e313dc 100644
>>>> --- a/target/riscv/cpu_bits.h
>>>> +++ b/target/riscv/cpu_bits.h
>>>> @@ -920,6 +920,11 @@ typedef enum RISCVException {
>>>>    #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>>>>    #define MHPMEVENTH_BIT_VUINH               BIT(26)
>>>>    +#define MHPMEVENT_FILTER_MASK (MHPMEVENT_BIT_MINH  | \
>>>> +                                            MHPMEVENT_BIT_SINH | \
>>>> +                                            MHPMEVENT_BIT_UINH | \
>>>> +                                            MHPMEVENT_BIT_VSINH | \
>>>> + MHPMEVENT_BIT_VUINH)
>>>>    #define MHPMEVENT_SSCOF_MASK _ULL(0xFFFF000000000000)
>>>>    #define MHPMEVENT_IDX_MASK                 0xFFFFF
>>>>    #define MHPMEVENT_SSCOF_RESVD              16
>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>> index d462d95ee165..33965d843d46 100644
>>>> --- a/target/riscv/cpu_helper.c
>>>> +++ b/target/riscv/cpu_helper.c
>>>> @@ -718,8 +718,21 @@ void riscv_cpu_set_mode(CPURISCVState *env,
>>>> target_ulong newpriv)
>>>>    {
>>>>        g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>>>>    -    if (icount_enabled() && newpriv != env->priv) {
>>>> -        riscv_itrigger_update_priv(env);
>>>> +    /*
>>>> +     * Invoke cycle/instret update between priv mode changes or
>>>> +     * VS->HS mode transition is SPV bit must be set
>>>> +     * HS->VS mode transition where virt_enabled must be set
>>>> +     * In both cases, priv will S mode only.
>>>> +     */
>>>> +    if (newpriv != env->priv ||
>>>> +       (env->priv == PRV_S && newpriv == PRV_S &&
>>>> +        (env->virt_enabled || get_field(env->hstatus, HSTATUS_SPV)))) {
>>>> +        if (icount_enabled()) {
>>>> +            riscv_itrigger_update_priv(env);
>>>> +            riscv_pmu_icount_update_priv(env, newpriv);
>>>> +        } else {
>>>> +            riscv_pmu_cycle_update_priv(env, newpriv);
>>>> +        }
>>>>        }
>>>>        /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>>>>        env->priv = newpriv;
>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>> index ff9bac537593..482e212c5f74 100644
>>>> --- a/target/riscv/csr.c
>>>> +++ b/target/riscv/csr.c
>>>> @@ -788,32 +788,16 @@ static RISCVException write_vcsr(CPURISCVState
>>>> *env, int csrno,
>>>>        return RISCV_EXCP_NONE;
>>>>    }
>>>>    +#if defined(CONFIG_USER_ONLY)
>>>>    /* User Timers and Counters */
>>>>    static target_ulong get_ticks(bool shift)
>>>>    {
>>>> -    int64_t val;
>>>> -    target_ulong result;
>>>> -
>>>> -#if !defined(CONFIG_USER_ONLY)
>>>> -    if (icount_enabled()) {
>>>> -        val = icount_get();
>>>> -    } else {
>>>> -        val = cpu_get_host_ticks();
>>>> -    }
>>>> -#else
>>>> -    val = cpu_get_host_ticks();
>>>> -#endif
>>>> -
>>>> -    if (shift) {
>>>> -        result = val >> 32;
>>>> -    } else {
>>>> -        result = val;
>>>> -    }
>>>> +    int64_t val = cpu_get_host_ticks();
>>>> +    target_ulong result = shift ? val >> 32 : val;
>>>>          return result;
>>>>    }
>>>>    -#if defined(CONFIG_USER_ONLY)
>>>>    static RISCVException read_time(CPURISCVState *env, int csrno,
>>>>                                    target_ulong *val)
>>>>    {
>>>> @@ -952,6 +936,71 @@ static RISCVException
>>>> write_mhpmeventh(CPURISCVState *env, int csrno,
>>>>        return RISCV_EXCP_NONE;
>>>>    }
>>>>    +static target_ulong
>>>> riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>>>> +                                                         int
>>>> counter_idx,
>>>> +                                                         bool
>>>> upper_half)
>>>> +{
>>>> +    uint64_t curr_val = 0;
>>>> +    target_ulong result = 0;
>>>> +    uint64_t *counter_arr = icount_enabled() ?
>>>> env->pmu_fixed_ctrs[1].counter :
>>>> +                            env->pmu_fixed_ctrs[0].counter;
>>>> +    uint64_t *counter_arr_virt = icount_enabled() ?
>>>> + env->pmu_fixed_ctrs[1].counter_virt :
>>>> + env->pmu_fixed_ctrs[0].counter_virt;
>>>> +    uint64_t cfg_val = 0;
>>>> +
>>>> +    if (counter_idx == 0) {
>>>> +        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
>>>> +                  env->mcyclecfg;
>>>> +    } else if (counter_idx == 2) {
>>>> +        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
>>>> +                  env->minstretcfg;
>>>> +    } else {
>>>> +        cfg_val = upper_half ?
>>>> + ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
>>>> +                  env->mhpmevent_val[counter_idx];
>>>> +        cfg_val &= MHPMEVENT_FILTER_MASK;
>>>> +    }
>>>> +
>>>> +    if (!cfg_val) {
>>>> +        if (icount_enabled()) {
>>>> +            curr_val = icount_get_raw();
>>>> +        } else {
>>>> +            curr_val = cpu_get_host_ticks();
>>>> +        }
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
>>>> +        curr_val += counter_arr[PRV_M];
>>>> +    }
>>>> +
>>>> +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
>>>> +        curr_val += counter_arr[PRV_S];
>>>> +    }
>>>> +
>>>> +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
>>>> +        curr_val += counter_arr[PRV_U];
>>>> +    }
>>>> +
>>>> +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
>>>> +        curr_val += counter_arr_virt[PRV_S];
>>>> +    }
>>>> +
>>>> +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
>>>> +        curr_val += counter_arr_virt[PRV_U];
>>>> +    }
>>>> +
>>>> +done:
>>>> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
>>>> +        result = upper_half ? curr_val >> 32 : curr_val;
>>>> +    } else {
>>>> +        result = curr_val;
>>>> +    }
>>>> +
>>>> +    return result;
>>>> +}
>>>> +
>>>>    static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>>>>                                            target_ulong val)
>>>>    {
>>>> @@ -962,7 +1011,8 @@ static RISCVException
>>>> write_mhpmcounter(CPURISCVState *env, int csrno,
>>>>        counter->mhpmcounter_val = val;
>>>>        if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>>>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>>>> -        counter->mhpmcounter_prev = get_ticks(false);
>>>> +        counter->mhpmcounter_prev =
>>>> riscv_pmu_ctr_get_fixed_counters_val(env,
>>>> + ctr_idx, false);
>>>>            if (ctr_idx > 2) {
>>>>                if (riscv_cpu_mxl(env) == MXL_RV32) {
>>>>                    mhpmctr_val = mhpmctr_val |
>>>> @@ -990,7 +1040,8 @@ static RISCVException
>>>> write_mhpmcounterh(CPURISCVState *env, int csrno,
>>>>        mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
>>>>        if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>>>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>>>> -        counter->mhpmcounterh_prev = get_ticks(true);
>>>> +        counter->mhpmcounterh_prev =
>>>> riscv_pmu_ctr_get_fixed_counters_val(env,
>>>> + ctr_idx, true);
>>>>            if (ctr_idx > 2) {
>>>>                riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>>>>            }
>>>> @@ -1031,7 +1082,8 @@ static RISCVException
>>>> riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>>>>         */
>>>>        if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>>>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>>>> -        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
>>>> +        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx,
>>>> upper_half) -
>>>> +                                                    ctr_prev + ctr_val;
>>>>        } else {
>>>>            *val = ctr_val;
>>>>        }
>>>> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
>>>> index 0e7d58b8a5c2..37309ff64cb6 100644
>>>> --- a/target/riscv/pmu.c
>>>> +++ b/target/riscv/pmu.c
>>>> @@ -19,6 +19,7 @@
>>>>    #include "qemu/osdep.h"
>>>>    #include "qemu/log.h"
>>>>    #include "qemu/error-report.h"
>>>> +#include "qemu/timer.h"
>>>>    #include "cpu.h"
>>>>    #include "pmu.h"
>>>>    #include "sysemu/cpu-timers.h"
>>>> @@ -176,6 +177,69 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU
>>>> *cpu, uint32_t ctr_idx)
>>>>        return 0;
>>>>    }
>>>>    +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
>>>> newpriv)
>>>> +{
>>>> +    uint64_t delta;
>>>> +    uint64_t *counter_arr;
>>>> +    uint64_t *counter_arr_prev;
>>>> +    uint64_t current_icount = icount_get_raw();
>>>> +
>>>> +    if (env->virt_enabled) {
>>>> +        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
>>>> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
>>>> +    } else {
>>>> +        counter_arr = env->pmu_fixed_ctrs[1].counter;
>>>> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_prev;
>>>> +    }
>>>> +
>>>> +    if (newpriv != env->priv) {
>>>> +        delta = current_icount - counter_arr_prev[env->priv];
>>>> +        counter_arr_prev[newpriv] = current_icount;
>>>> +    } else {
>>>> +        delta = current_icount - counter_arr_prev[env->priv];
>>>> +        if (env->virt_enabled) {
>>>> +            /* HS->VS transition.The previous value should
>>>> correspond to HS. */
>>> Hi Atish,
>>>
>>> Dose env->virt_enabled ensure HS->VS transition?
>>>
>> As per my understanding, riscv_cpu_set_virt_enabled always invoked
>> before riscv_cpu_set_mode.
> In helper_mret() we call riscv_cpu_set_mode() before
> riscv_cpu_set_virt_enabled().

Ahh yes. I missed the helper_mret condition.

> I don't think there is any requirement on which order we call the functions

Indeed.helper_mret and helper_sret invokes them in different order.

>> That means env->virt_enabled must be enabled before we enter into this
>> function. Let me know if I missed
> env->virt_enabled will be true if we are in HS or VS mode, but you
> don't know the transition from just env->virt_enabled being set.
Hmm. In riscv_cpu_do_interrupt(), virt_enabled is set to 0 if a trap is 
taken to HS mode
from VS mode. Am I missing something ?

> Alistair
>
>> an scenario.
>>
>>
>>> I think VS->VS also keeps  env->virt_enabled to be true, where the
>>> previous value should correspond to VS.
>>>
>> yeah. good point. We should check HSTATUS_SPV here as well.
>>
>>
>>> Thanks,
>>> Zhiwei
>>>
>>>> + env->pmu_fixed_ctrs[1].counter_prev[PRV_S] = current_icount;
>>>> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
>>>> +            /* VS->HS transition.The previous value should
>>>> correspond to VS. */
>>>> +            env->pmu_fixed_ctrs[1].counter_virt_prev[PRV_S] =
>>>> current_icount;
>>>> +        }
>>>> +   }
>>>> +
>>>> +    counter_arr[env->priv] += delta;
>>>> +}
>>>> +
>>>> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
>>>> newpriv)
>>>> +{
>>>> +    uint64_t delta;
>>>> +    uint64_t *counter_arr;
>>>> +    uint64_t *counter_arr_prev;
>>>> +    uint64_t current_host_ticks = cpu_get_host_ticks();
>>>> +
>>>> +    if (env->virt_enabled) {
>>>> +        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
>>>> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
>>>> +    } else {
>>>> +        counter_arr = env->pmu_fixed_ctrs[0].counter;
>>>> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_prev;
>>>> +    }
>>>> +
>>>> +    if (newpriv != env->priv) {
>>>> +        delta = current_host_ticks - counter_arr_prev[env->priv];
>>>> +        counter_arr_prev[newpriv] = current_host_ticks;
>>>> +    } else {
>>>> +        delta = current_host_ticks - counter_arr_prev[env->priv];
>>>> +        if (env->virt_enabled) {
>>>> +            env->pmu_fixed_ctrs[0].counter_prev[PRV_S] =
>>>> current_host_ticks;
>>>> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
>>>> +            env->pmu_fixed_ctrs[0].counter_virt_prev[PRV_S] =
>>>> +            current_host_ticks;
>>>> +        }
>>>> +   }
>>>> +
>>>> +    counter_arr[env->priv] += delta;
>>>> +}
>>>> +
>>>>    int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx
>>>> event_idx)
>>>>    {
>>>>        uint32_t ctr_idx;
>>>> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
>>>> index 505fc850d38e..50de6031a730 100644
>>>> --- a/target/riscv/pmu.h
>>>> +++ b/target/riscv/pmu.h
>>>> @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum
>>>> riscv_pmu_event_idx event_idx);
>>>>    void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char
>>>> *pmu_name);
>>>>    int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>>>>                              uint32_t ctr_idx);
>>>> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
>>>> newpriv);
>>>> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
>>>> newpriv);
--------------1sOzVCqVOHdtQoDvMc8FK9D7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/19/24 21:54, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Mar 7, 2024 at 7:26 PM Atish Patra <a class="moz-txt-link-rfc2396E" href="mailto:atishp@rivosinc.com">&lt;atishp@rivosinc.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 3/4/24 22:47, LIU Zhiwei wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
On 2024/2/29 2:51, Atish Patra wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Privilege mode filtering can also be emulated for cycle/instret by
tracking host_ticks/icount during each privilege mode switch. This
patch implements that for both cycle/instret and mhpmcounters. The
first one requires Smcntrpmf while the other one requires Sscofpmf
to be enabled.

The cycle/instret are still computed using host ticks when icount
is not enabled. Otherwise, they are computed using raw icount which
is more accurate in icount mode.

Reviewed-by: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>
Signed-off-by: Atish Patra <a class="moz-txt-link-rfc2396E" href="mailto:atishp@rivosinc.com">&lt;atishp@rivosinc.com&gt;</a>
---
  target/riscv/cpu.h        | 11 +++++
  target/riscv/cpu_bits.h   |  5 ++
  target/riscv/cpu_helper.c | 17 ++++++-
  target/riscv/csr.c        | 96 ++++++++++++++++++++++++++++++---------
  target/riscv/pmu.c        | 64 ++++++++++++++++++++++++++
  target/riscv/pmu.h        |  2 +
  6 files changed, 171 insertions(+), 24 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 174e8ba8e847..9e21d7f7d635 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -157,6 +157,15 @@ typedef struct PMUCTRState {
      target_ulong irq_overflow_left;
  } PMUCTRState;
  +typedef struct PMUFixedCtrState {
+        /* Track cycle and icount for each privilege mode */
+        uint64_t counter[4];
+        uint64_t counter_prev[4];
+        /* Track cycle and icount for each privilege mode when V = 1*/
+        uint64_t counter_virt[2];
+        uint64_t counter_virt_prev[2];
+} PMUFixedCtrState;
+
  struct CPUArchState {
      target_ulong gpr[32];
      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -353,6 +362,8 @@ struct CPUArchState {
      /* PMU event selector configured values for RV32 */
      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
  +    PMUFixedCtrState pmu_fixed_ctrs[2];
+
      target_ulong sscratch;
      target_ulong mscratch;
  diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e866c60a400c..5fe349e313dc 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -920,6 +920,11 @@ typedef enum RISCVException {
  #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
  #define MHPMEVENTH_BIT_VUINH               BIT(26)
  +#define MHPMEVENT_FILTER_MASK (MHPMEVENT_BIT_MINH  | \
+                                            MHPMEVENT_BIT_SINH | \
+                                            MHPMEVENT_BIT_UINH | \
+                                            MHPMEVENT_BIT_VSINH | \
+ MHPMEVENT_BIT_VUINH)
  #define MHPMEVENT_SSCOF_MASK _ULL(0xFFFF000000000000)
  #define MHPMEVENT_IDX_MASK                 0xFFFFF
  #define MHPMEVENT_SSCOF_RESVD              16
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee165..33965d843d46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -718,8 +718,21 @@ void riscv_cpu_set_mode(CPURISCVState *env,
target_ulong newpriv)
  {
      g_assert(newpriv &lt;= PRV_M &amp;&amp; newpriv != PRV_RESERVED);
  -    if (icount_enabled() &amp;&amp; newpriv != env-&gt;priv) {
-        riscv_itrigger_update_priv(env);
+    /*
+     * Invoke cycle/instret update between priv mode changes or
+     * VS-&gt;HS mode transition is SPV bit must be set
+     * HS-&gt;VS mode transition where virt_enabled must be set
+     * In both cases, priv will S mode only.
+     */
+    if (newpriv != env-&gt;priv ||
+       (env-&gt;priv == PRV_S &amp;&amp; newpriv == PRV_S &amp;&amp;
+        (env-&gt;virt_enabled || get_field(env-&gt;hstatus, HSTATUS_SPV)))) {
+        if (icount_enabled()) {
+            riscv_itrigger_update_priv(env);
+            riscv_pmu_icount_update_priv(env, newpriv);
+        } else {
+            riscv_pmu_cycle_update_priv(env, newpriv);
+        }
      }
      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
      env-&gt;priv = newpriv;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ff9bac537593..482e212c5f74 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -788,32 +788,16 @@ static RISCVException write_vcsr(CPURISCVState
*env, int csrno,
      return RISCV_EXCP_NONE;
  }
  +#if defined(CONFIG_USER_ONLY)
  /* User Timers and Counters */
  static target_ulong get_ticks(bool shift)
  {
-    int64_t val;
-    target_ulong result;
-
-#if !defined(CONFIG_USER_ONLY)
-    if (icount_enabled()) {
-        val = icount_get();
-    } else {
-        val = cpu_get_host_ticks();
-    }
-#else
-    val = cpu_get_host_ticks();
-#endif
-
-    if (shift) {
-        result = val &gt;&gt; 32;
-    } else {
-        result = val;
-    }
+    int64_t val = cpu_get_host_ticks();
+    target_ulong result = shift ? val &gt;&gt; 32 : val;
        return result;
  }
  -#if defined(CONFIG_USER_ONLY)
  static RISCVException read_time(CPURISCVState *env, int csrno,
                                  target_ulong *val)
  {
@@ -952,6 +936,71 @@ static RISCVException
write_mhpmeventh(CPURISCVState *env, int csrno,
      return RISCV_EXCP_NONE;
  }
  +static target_ulong
riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                         int
counter_idx,
+                                                         bool
upper_half)
+{
+    uint64_t curr_val = 0;
+    target_ulong result = 0;
+    uint64_t *counter_arr = icount_enabled() ?
env-&gt;pmu_fixed_ctrs[1].counter :
+                            env-&gt;pmu_fixed_ctrs[0].counter;
+    uint64_t *counter_arr_virt = icount_enabled() ?
+ env-&gt;pmu_fixed_ctrs[1].counter_virt :
+ env-&gt;pmu_fixed_ctrs[0].counter_virt;
+    uint64_t cfg_val = 0;
+
+    if (counter_idx == 0) {
+        cfg_val = upper_half ? ((uint64_t)env-&gt;mcyclecfgh &lt;&lt; 32) :
+                  env-&gt;mcyclecfg;
+    } else if (counter_idx == 2) {
+        cfg_val = upper_half ? ((uint64_t)env-&gt;minstretcfgh &lt;&lt; 32) :
+                  env-&gt;minstretcfg;
+    } else {
+        cfg_val = upper_half ?
+ ((uint64_t)env-&gt;mhpmeventh_val[counter_idx] &lt;&lt; 32) :
+                  env-&gt;mhpmevent_val[counter_idx];
+        cfg_val &amp;= MHPMEVENT_FILTER_MASK;
+    }
+
+    if (!cfg_val) {
+        if (icount_enabled()) {
+            curr_val = icount_get_raw();
+        } else {
+            curr_val = cpu_get_host_ticks();
+        }
+        goto done;
+    }
+
+    if (!(cfg_val &amp; MCYCLECFG_BIT_MINH)) {
+        curr_val += counter_arr[PRV_M];
+    }
+
+    if (!(cfg_val &amp; MCYCLECFG_BIT_SINH)) {
+        curr_val += counter_arr[PRV_S];
+    }
+
+    if (!(cfg_val &amp; MCYCLECFG_BIT_UINH)) {
+        curr_val += counter_arr[PRV_U];
+    }
+
+    if (!(cfg_val &amp; MCYCLECFG_BIT_VSINH)) {
+        curr_val += counter_arr_virt[PRV_S];
+    }
+
+    if (!(cfg_val &amp; MCYCLECFG_BIT_VUINH)) {
+        curr_val += counter_arr_virt[PRV_U];
+    }
+
+done:
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        result = upper_half ? curr_val &gt;&gt; 32 : curr_val;
+    } else {
+        result = curr_val;
+    }
+
+    return result;
+}
+
  static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
                                          target_ulong val)
  {
@@ -962,7 +1011,8 @@ static RISCVException
write_mhpmcounter(CPURISCVState *env, int csrno,
      counter-&gt;mhpmcounter_val = val;
      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter-&gt;mhpmcounter_prev = get_ticks(false);
+        counter-&gt;mhpmcounter_prev =
riscv_pmu_ctr_get_fixed_counters_val(env,
+ ctr_idx, false);
          if (ctr_idx &gt; 2) {
              if (riscv_cpu_mxl(env) == MXL_RV32) {
                  mhpmctr_val = mhpmctr_val |
@@ -990,7 +1040,8 @@ static RISCVException
write_mhpmcounterh(CPURISCVState *env, int csrno,
      mhpmctr_val = mhpmctr_val | (mhpmctrh_val &lt;&lt; 32);
      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter-&gt;mhpmcounterh_prev = get_ticks(true);
+        counter-&gt;mhpmcounterh_prev =
riscv_pmu_ctr_get_fixed_counters_val(env,
+ ctr_idx, true);
          if (ctr_idx &gt; 2) {
              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
          }
@@ -1031,7 +1082,8 @@ static RISCVException
riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
       */
      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx,
upper_half) -
+                                                    ctr_prev + ctr_val;
      } else {
          *val = ctr_val;
      }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0e7d58b8a5c2..37309ff64cb6 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -19,6 +19,7 @@
  #include "qemu/osdep.h"
  #include "qemu/log.h"
  #include "qemu/error-report.h"
+#include "qemu/timer.h"
  #include "cpu.h"
  #include "pmu.h"
  #include "sysemu/cpu-timers.h"
@@ -176,6 +177,69 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU
*cpu, uint32_t ctr_idx)
      return 0;
  }
  +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_icount = icount_get_raw();
+
+    if (env-&gt;virt_enabled) {
+        counter_arr = env-&gt;pmu_fixed_ctrs[1].counter_virt;
+        counter_arr_prev = env-&gt;pmu_fixed_ctrs[1].counter_virt_prev;
+    } else {
+        counter_arr = env-&gt;pmu_fixed_ctrs[1].counter;
+        counter_arr_prev = env-&gt;pmu_fixed_ctrs[1].counter_prev;
+    }
+
+    if (newpriv != env-&gt;priv) {
+        delta = current_icount - counter_arr_prev[env-&gt;priv];
+        counter_arr_prev[newpriv] = current_icount;
+    } else {
+        delta = current_icount - counter_arr_prev[env-&gt;priv];
+        if (env-&gt;virt_enabled) {
+            /* HS-&gt;VS transition.The previous value should
correspond to HS. */
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
Hi Atish,

Dose env-&gt;virt_enabled ensure HS-&gt;VS transition?

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">As per my understanding, riscv_cpu_set_virt_enabled always invoked
before riscv_cpu_set_mode.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In helper_mret() we call riscv_cpu_set_mode() before
riscv_cpu_set_virt_enabled().
</pre>
    </blockquote>
    <p>Ahh yes. I missed the helper_mret condition.<br>
    </p>
    <blockquote type="cite"
cite="mid:CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
I don't think there is any requirement on which order we call the functions
</pre>
    </blockquote>
    <p>Indeed.<font face="Helvetica, Arial, sans-serif"> helper_mret and
        helper_sret invokes them in different order.</font><br>
    </p>
    <blockquote type="cite"
cite="mid:CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
That means env-&gt;virt_enabled must be enabled before we enter into this
function. Let me know if I missed
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
env-&gt;virt_enabled will be true if we are in HS or VS mode, but you
don't know the transition from just env-&gt;virt_enabled being set.
</pre>
    </blockquote>
    Hmm. In riscv_cpu_do_interrupt(), virt_enabled is set to 0 if a trap
    is taken to HS mode<br>
    from VS mode. Am I missing something ?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKmqyKN6YW+W8yYrwrSD-BWdu-Air6AvVsmowW3nZ=6VKgeLoQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
Alistair

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
an scenario.


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I think VS-&gt;VS also keeps  env-&gt;virt_enabled to be true, where the
previous value should correspond to VS.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">yeah. good point. We should check HSTATUS_SPV here as well.


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Thanks,
Zhiwei

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+ env-&gt;pmu_fixed_ctrs[1].counter_prev[PRV_S] = current_icount;
+        } else if (get_field(env-&gt;hstatus, HSTATUS_SPV)) {
+            /* VS-&gt;HS transition.The previous value should
correspond to VS. */
+            env-&gt;pmu_fixed_ctrs[1].counter_virt_prev[PRV_S] =
current_icount;
+        }
+   }
+
+    counter_arr[env-&gt;priv] += delta;
+}
+
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_host_ticks = cpu_get_host_ticks();
+
+    if (env-&gt;virt_enabled) {
+        counter_arr = env-&gt;pmu_fixed_ctrs[0].counter_virt;
+        counter_arr_prev = env-&gt;pmu_fixed_ctrs[0].counter_virt_prev;
+    } else {
+        counter_arr = env-&gt;pmu_fixed_ctrs[0].counter;
+        counter_arr_prev = env-&gt;pmu_fixed_ctrs[0].counter_prev;
+    }
+
+    if (newpriv != env-&gt;priv) {
+        delta = current_host_ticks - counter_arr_prev[env-&gt;priv];
+        counter_arr_prev[newpriv] = current_host_ticks;
+    } else {
+        delta = current_host_ticks - counter_arr_prev[env-&gt;priv];
+        if (env-&gt;virt_enabled) {
+            env-&gt;pmu_fixed_ctrs[0].counter_prev[PRV_S] =
current_host_ticks;
+        } else if (get_field(env-&gt;hstatus, HSTATUS_SPV)) {
+            env-&gt;pmu_fixed_ctrs[0].counter_virt_prev[PRV_S] =
+            current_host_ticks;
+        }
+   }
+
+    counter_arr[env-&gt;priv] += delta;
+}
+
  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx
event_idx)
  {
      uint32_t ctr_idx;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 505fc850d38e..50de6031a730 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum
riscv_pmu_event_idx event_idx);
  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char
*pmu_name);
  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                            uint32_t ctr_idx);
+void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
newpriv);
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
newpriv);
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------1sOzVCqVOHdtQoDvMc8FK9D7--

