Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC9AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMq3-0007vg-DS; Mon, 01 Jul 2024 15:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMq2-0007vL-6Z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:37:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMpv-0000H2-Ta
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:37:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7067435d376so2517005b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719862634; x=1720467434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wl7VAjOwqDSQpW97KlFeJH1V5nXtoQC/SJg+XAKbIco=;
 b=FRyilfjrG3BxufYP7EwoTslaHYYc2SvNjgmYfuA96WdxUp3vX72bl/3dHZ0x4Yp/yS
 iQd6lr+n8rUerbDLZejhpyOZ82J/hgmreQ/44Fyf/LYfcJoC7YPm9/TWYPYD2HgDade4
 YAbW8ZVBitX8jIURhMULPooJtfQZcO3lOwr6mDVQA0XM+sJ5M96CdXlZHi6YkqkE7aZk
 WqbY2KzF85jNRkIKP0UNF7gvNm+VFYYqFnttxWjwTiSgcRYkG5Br1NEmpKmsXq9sAipD
 RUIjq3dKO1+PJm2+X6hSFv2HFNKBk6ZMAy2kuRMei1o2YsI7CKmBG72Kj6t8zEcsE13o
 ATNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862634; x=1720467434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wl7VAjOwqDSQpW97KlFeJH1V5nXtoQC/SJg+XAKbIco=;
 b=blF6TSGUOfdJCp3rCWJqhsjw84hPeQrYECTsZAOlemI31oq41BaKc94LmjXUmTfp3c
 a9BEBZ4Oz+30Rlbz9neSL9x1VBHGm1+MBxO4hfyTpP5ZFQf3duGL319LBlzfyeZ3fDzM
 Jl5otFyBnZsh6yGhPlwlAfRmaajwLojw4tFT0jAE/AGTGrRgk8FWHJUeVZn1Zvu1riYi
 wQLRKeQl7H9zwHiRge0yCg8SgThGlqM8TOzeyseZaMY1w18qOTkHJd9e5lGkreP87121
 T5zoMEfhNBYKwfOKJat/eBm836NGKix8xV9/yUhRPn0VJSoiulbnh3VqNshzQU14qd57
 wIdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVPU64pLtEIYh9EfltZ1klH2gRjjvjYcHCjIm1nqm3OwBUWhf/Z0Hfu2hboGRlfLCUKr/oEFcZ931kEgIJvTs+uJgqg2Q=
X-Gm-Message-State: AOJu0YwxQkK9+NB/Hf7dx7inB0kS7tjPWqcnIYyGc8wb05tuPqyNnCgi
 fMcPotwnSKvDrR1K12HK5apQ2EjKwkxg1XYeo2syncYz1Dsoy5vgfc+iabW6Ks4=
X-Google-Smtp-Source: AGHT+IE6FkuKKnQQD/tarMUkO9S6cVuKh0ZXChYmoCvEVJi+toruyoo1gB/Kcgg8uvBGkVz9Y9h/DQ==
X-Received: by 2002:a05:6a00:1256:b0:704:151d:dcce with SMTP id
 d2e1a72fcca58-70aaab17887mr11292339b3a.5.1719862634080; 
 Mon, 01 Jul 2024 12:37:14 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246f02dsm6955957b3a.72.2024.07.01.12.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:37:13 -0700 (PDT)
Message-ID: <27176bf2-3acf-4f91-9e11-4a3ad54396a7@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:37:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] target/riscv: Start counters from both
 mhpmcounter and mcountinhibit
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-9-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-9-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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
> Currently we start timer counter from write_mhpmcounter path only
> without checking for mcountinhibit bit. This changes adds mcountinhibit
> check and also programs the counter from write_mcountinhibit as well.
> 
> When a counter is stopped using mcountinhibit we simply update
> the value of the counter based on current host ticks and save
> it for future reads.
> 
> We don't need to disable running timer as pmu_timer_trigger_irq
> will discard the interrupt if the counter has been inhibited.
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 75 ++++++++++++++++++++++++++++++++++++++----------------
>   target/riscv/pmu.c |  3 +--
>   2 files changed, 54 insertions(+), 24 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6c1a884eec82..150e02f080ec 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1008,8 +1008,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>       uint64_t mhpmctr_val = val;
>   
>       counter->mhpmcounter_val = val;
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
>           counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
>                                                                   ctr_idx, false);
>           if (ctr_idx > 2) {
> @@ -1037,8 +1038,9 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>   
>       counter->mhpmcounterh_val = val;
>       mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
>           counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
>                                                                    ctr_idx, true);
>           if (ctr_idx > 2) {
> @@ -2101,31 +2103,60 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>       int cidx;
>       PMUCTRState *counter;
>       RISCVCPU *cpu = env_archcpu(env);
> +    uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
> +    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
> +    uint64_t mhpmctr_val, prev_count, curr_count;
>   
>       /* WARL register - disable unavailable counters; TM bit is always 0 */
> -    env->mcountinhibit =
> -        val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR);
> +    env->mcountinhibit = val & present_ctrs;
>   
>       /* Check if any other counter is also monitoring cycles/instructions */
>       for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> -            counter = &env->pmu_ctrs[cidx];
> -        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
> -            /*
> -             * Update the counter value for cycle/instret as we can't stop the
> -             * host ticks. But we should show the current value at this moment.
> -             */
> -            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> -                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> -                counter->mhpmcounter_val =
> -                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
> -                                           counter->mhpmcounter_prev +
> -                                           counter->mhpmcounter_val;
> +        if (!(updated_ctrs & BIT(cidx)) ||
> +            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
> +            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
> +            continue;
> +        }
> +
> +        counter = &env->pmu_ctrs[cidx];
> +
> +        if (!get_field(env->mcountinhibit, BIT(cidx))) {
> +            counter->mhpmcounter_prev =
> +                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
> +            if (riscv_cpu_mxl(env) == MXL_RV32) {
> +                counter->mhpmcounterh_prev =
> +                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
> +            }
> +
> +            if (cidx > 2) {
> +                mhpmctr_val = counter->mhpmcounter_val;
>                   if (riscv_cpu_mxl(env) == MXL_RV32) {
> -                    counter->mhpmcounterh_val =
> -                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
> -                                                counter->mhpmcounterh_prev +
> -                                                counter->mhpmcounterh_val;
> +                    mhpmctr_val = mhpmctr_val |
> +                            ((uint64_t)counter->mhpmcounterh_val << 32);
>                   }
> +                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
> +            }
> +        } else {
> +            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
> +
> +            mhpmctr_val = counter->mhpmcounter_val;
> +            prev_count = counter->mhpmcounter_prev;
> +            if (riscv_cpu_mxl(env) == MXL_RV32) {
> +                uint64_t tmp =
> +                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
> +
> +                curr_count = curr_count | (tmp << 32);
> +                mhpmctr_val = mhpmctr_val |
> +                    ((uint64_t)counter->mhpmcounterh_val << 32);
> +                prev_count = prev_count |
> +                    ((uint64_t)counter->mhpmcounterh_prev << 32);
> +            }
> +
> +            /* Adjust the counter for later reads. */
> +            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
> +            counter->mhpmcounter_val = mhpmctr_val;
> +            if (riscv_cpu_mxl(env) == MXL_RV32) {
> +                counter->mhpmcounterh_val = mhpmctr_val >> 32;
>               }
>           }
>       }
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index ac648cff8d7c..63420d9f3679 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -285,8 +285,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>       }
>   
>       ctr_idx = GPOINTER_TO_UINT(value);
> -    if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
> -        get_field(env->mcountinhibit, BIT(ctr_idx))) {
> +    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
>           return -1;
>       }
>   
> 

