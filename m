Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A42C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOokn-0000wf-Uh; Tue, 02 Jul 2024 21:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOokj-0000vj-S1; Tue, 02 Jul 2024 21:25:45 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOokh-0006EN-9r; Tue, 02 Jul 2024 21:25:45 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-48fdbf49663so168236137.3; 
 Tue, 02 Jul 2024 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719969941; x=1720574741; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMeAU8myokrDj6PCMHPTElxY4TsuTaFs9l05Mb7FxZ8=;
 b=eI2COMNSmZGMxlVG0dWp65+XlcNHCs+uwJhRufs6Saz88yW5yKfufA3Z6lk6XsqSfC
 cQeAdJIvZZiqf1z4gcoKEMGJmwsd11XE2UZkcoux23gy7ZFY0QWnaS86u4QQ4969JaO0
 C2x2yIQw/tXoYrc+LS8Pb/zlk+qsuqY8FyAd5Txd7aTRFxFJG/6VZRLNOC4Hzfnjiimq
 YL4tLJmnFsK5qPz/Fu6bj0kyrXDdAuITia4oVybTXGZQm5P7+5mpd2AtP7i74ZDPRPBD
 ps60UryP9uA0QVl9+e6rwEz38kgbiSxFS4QE/+35Zup2jXl7bILuEc+NoUJrtLxBCZ8F
 cGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719969941; x=1720574741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMeAU8myokrDj6PCMHPTElxY4TsuTaFs9l05Mb7FxZ8=;
 b=Y7VDJlHG5oCxUbI6P42Xj61kD2j4MLOhrQbNX9dgC/jSLR0vHZQpO08gO5GJtTNUYG
 W0WuHQvAjP74GbDN5AvMWoALTAvl06sen3D0+mEVu5FAKVj8ykkLVtuZ+DPegZdQ3Oow
 Dwb4K6OE42JFM++H/ohN5IzlPALdPr0U3EAZYwkf7mUfbW3sgyxbenSUK3HjSQnUMWiq
 QmDO8njRpE+Phvn4FBrkGfC87aPVyjRJgnZ80leF/YLRkxJZmEMVS6bLAVpaGIcNMUYs
 Er1lbIN8spayy0oUPxp0MJhJxvP/qvMrPLMvnCTalZ2XrJ4hMtMcAiBVb7jRamlvkM5h
 97jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUK046Wh/vL26tT4cSsFiB+vkLQTfUd86Y6gbxsSkYU47wSUdZMJxWg+DR07wuuVwVT6E4Lzy3i1+DqdZEFn9WYEHd4U=
X-Gm-Message-State: AOJu0YwcQN8dnUHdpSRtKUOkhQtXGkEHhgi6rHFvlwu3JjzpS8DK/Aia
 JYU0cAmrySjnN3OmlC7PoRzCg8xapfhhes32bYgJeYabTLXWk8FME2SeMIAavpw+0pJoe3Lmry0
 dsdb+Q3mzrQignEpbKmuERjZHVlY=
X-Google-Smtp-Source: AGHT+IEgglc1bjb4pU0ZI1cah1/RHfCFM/I16FDMXXWYcHHgmt/detwNpbf8lX0YlRLBOiGDxW6yC1zQjSqL4jhagv8=
X-Received: by 2002:a67:af02:0:b0:48f:26f7:61f4 with SMTP id
 ada2fe7eead31-48faf15dc7amr10734881137.30.1719969940814; Tue, 02 Jul 2024
 18:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-6-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-6-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 11:25:14 +1000
Message-ID: <CAKmqyKMGvLNoD8m76QQ_2hsSBz2p+SZGpzKoaaRZ5OK6oJDFOA@mail.gmail.com>
Subject: Re: [PATCH v7 06/11] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 27, 2024 at 9:59=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  11 +++++
>  target/riscv/cpu_bits.h   |   5 ++
>  target/riscv/cpu_helper.c |   9 +++-
>  target/riscv/csr.c        | 117 ++++++++++++++++++++++++++++++++--------=
------
>  target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++++++++
>  target/riscv/pmu.h        |   2 +
>  6 files changed, 199 insertions(+), 37 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c5d289e5f4b9..d56d640b06be 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -158,6 +158,15 @@ typedef struct PMUCTRState {
>      target_ulong irq_overflow_left;
>  } PMUCTRState;
>
> +typedef struct PMUFixedCtrState {
> +        /* Track cycle and icount for each privilege mode */
> +        uint64_t counter[4];
> +        uint64_t counter_prev[4];
> +        /* Track cycle and icount for each privilege mode when V =3D 1*/
> +        uint64_t counter_virt[2];
> +        uint64_t counter_virt_prev[2];
> +} PMUFixedCtrState;
> +
>  struct CPUArchState {
>      target_ulong gpr[32];
>      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> @@ -354,6 +363,8 @@ struct CPUArchState {
>      /* PMU event selector configured values for RV32 */
>      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>
> +    PMUFixedCtrState pmu_fixed_ctrs[2];
> +
>      target_ulong sscratch;
>      target_ulong mscratch;
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5faa817453bb..18f19615e4fe 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -926,6 +926,11 @@ typedef enum RISCVException {
>  #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>  #define MHPMEVENTH_BIT_VUINH               BIT(26)
>
> +#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
> +                                            MHPMEVENT_BIT_SINH  | \
> +                                            MHPMEVENT_BIT_UINH  | \
> +                                            MHPMEVENT_BIT_VSINH | \
> +                                            MHPMEVENT_BIT_VUINH)
>  #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
>  #define MHPMEVENT_IDX_MASK                 0xFFFFF
>  #define MHPMEVENT_SSCOF_RESVD              16
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 10d3fdaed376..395a1d914061 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -695,9 +695,14 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_u=
long newpriv, bool virt_en)
>  {
>      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
>
> -    if (icount_enabled() && newpriv !=3D env->priv) {
> -        riscv_itrigger_update_priv(env);
> +    if (newpriv !=3D env->priv || env->virt_enabled !=3D virt_en) {
> +        if (icount_enabled()) {
> +            riscv_itrigger_update_priv(env);
> +        }
> +
> +        riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
>      }
> +
>      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>      env->priv =3D newpriv;
>      env->xl =3D cpu_recompute_xl(env);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 665c534db1a0..c292d036bcb2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -788,36 +788,16 @@ static RISCVException write_vcsr(CPURISCVState *env=
, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +#if defined(CONFIG_USER_ONLY)
>  /* User Timers and Counters */
> -static target_ulong get_ticks(bool shift, bool instructions)
> +static target_ulong get_ticks(bool shift)
>  {
> -    int64_t val;
> -    target_ulong result;
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (icount_enabled()) {
> -        if (instructions) {
> -            val =3D icount_get_raw();
> -        } else {
> -            val =3D icount_get();
> -        }
> -    } else {
> -        val =3D cpu_get_host_ticks();
> -    }
> -#else
> -    val =3D cpu_get_host_ticks();
> -#endif
> -
> -    if (shift) {
> -        result =3D val >> 32;
> -    } else {
> -        result =3D val;
> -    }
> +    int64_t val =3D cpu_get_host_ticks();
> +    target_ulong result =3D shift ? val >> 32 : val;
>
>      return result;
>  }
>
> -#if defined(CONFIG_USER_ONLY)
>  static RISCVException read_time(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
>  {
> @@ -835,14 +815,14 @@ static RISCVException read_timeh(CPURISCVState *env=
, int csrno,
>  static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>  {
> -    *val =3D get_ticks(false, (csrno =3D=3D CSR_INSTRET));
> +    *val =3D get_ticks(false);
>      return RISCV_EXCP_NONE;
>  }
>
>  static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>  {
> -    *val =3D get_ticks(true, (csrno =3D=3D CSR_INSTRETH));
> +    *val =3D get_ticks(true);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -956,17 +936,82 @@ static RISCVException write_mhpmeventh(CPURISCVStat=
e *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *=
env,
> +                                                         int counter_idx=
,
> +                                                         bool upper_half=
)
> +{
> +    int inst =3D riscv_pmu_ctr_monitor_instructions(env, counter_idx);
> +    uint64_t *counter_arr_virt =3D env->pmu_fixed_ctrs[inst].counter_vir=
t;
> +    uint64_t *counter_arr =3D env->pmu_fixed_ctrs[inst].counter;
> +    target_ulong result =3D 0;
> +    uint64_t curr_val =3D 0;
> +    uint64_t cfg_val =3D 0;
> +
> +    if (counter_idx =3D=3D 0) {
> +        cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> +                  env->mcyclecfg;
> +    } else if (counter_idx =3D=3D 2) {
> +        cfg_val =3D upper_half ? ((uint64_t)env->minstretcfgh << 32) :
> +                  env->minstretcfg;
> +    } else {
> +        cfg_val =3D upper_half ?
> +                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
> +                  env->mhpmevent_val[counter_idx];
> +        cfg_val &=3D MHPMEVENT_FILTER_MASK;
> +    }
> +
> +    if (!cfg_val) {
> +        if (icount_enabled()) {
> +                curr_val =3D inst ? icount_get_raw() : icount_get();
> +        } else {
> +            curr_val =3D cpu_get_host_ticks();
> +        }
> +
> +        goto done;
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> +        curr_val +=3D counter_arr[PRV_M];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> +        curr_val +=3D counter_arr[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> +        curr_val +=3D counter_arr[PRV_U];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> +        curr_val +=3D counter_arr_virt[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> +        curr_val +=3D counter_arr_virt[PRV_U];
> +    }
> +
> +done:
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        result =3D upper_half ? curr_val >> 32 : curr_val;
> +    } else {
> +        result =3D curr_val;
> +    }
> +
> +    return result;
> +}
> +
>  static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>                                          target_ulong val)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLE;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D val;
> -    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      counter->mhpmcounter_val =3D val;
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        counter->mhpmcounter_prev =3D get_ticks(false, instr);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        counter->mhpmcounter_prev =3D riscv_pmu_ctr_get_fixed_counters_v=
al(env,
> +                                                                ctr_idx,=
 false);
>          if (ctr_idx > 2) {
>              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>                  mhpmctr_val =3D mhpmctr_val |
> @@ -989,12 +1034,13 @@ static RISCVException write_mhpmcounterh(CPURISCVS=
tate *env, int csrno,
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
>      uint64_t mhpmctrh_val =3D val;
> -    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      counter->mhpmcounterh_val =3D val;
>      mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        counter->mhpmcounterh_prev =3D get_ticks(true, instr);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        counter->mhpmcounterh_prev =3D riscv_pmu_ctr_get_fixed_counters_=
val(env,
> +                                                                 ctr_idx=
, true);
>          if (ctr_idx > 2) {
>              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>          }
> @@ -1013,7 +1059,6 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVSt=
ate *env, target_ulong *val,
>                                           counter->mhpmcounter_prev;
>      target_ulong ctr_val =3D upper_half ? counter->mhpmcounterh_val :
>                                          counter->mhpmcounter_val;
> -    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>          /*
> @@ -1034,8 +1079,10 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVS=
tate *env, target_ulong *val,
>       * The kernel computes the perf delta by subtracting the current val=
ue from
>       * the value it initialized previously (ctr_val).
>       */
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> -        *val =3D get_ticks(upper_half, instr) - ctr_prev + ctr_val;
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, uppe=
r_half) -
> +                                                    ctr_prev + ctr_val;
>      } else {
>          *val =3D ctr_val;
>      }
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 0e7d58b8a5c2..ac648cff8d7c 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -19,6 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
> +#include "qemu/timer.h"
>  #include "cpu.h"
>  #include "pmu.h"
>  #include "sysemu/cpu-timers.h"
> @@ -176,6 +177,97 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, ui=
nt32_t ctr_idx)
>      return 0;
>  }
>
> +/*
> + * Information needed to update counters:
> + *  new_priv, new_virt: To correctly save starting snapshot for the newl=
y
> + *                      started mode. Look at array being indexed with n=
ewprv.
> + *  old_priv, old_virt: To correctly select previous snapshot for old pr=
iv
> + *                      and compute delta. Also to select correct counte=
r
> + *                      to inc. Look at arrays being indexed with env->p=
riv.
> + *
> + *  To avoid the complexity of calling this function, we assume that
> + *  env->priv and env->virt_enabled contain old priv and old virt and
> + *  new priv and new virt values are passed in as arguments.
> + */
> +static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> +                                         target_ulong newpriv, bool new_=
virt)
> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_icount;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_icount =3D icount_get_raw();
> +    } else {
> +        current_icount =3D cpu_get_host_ticks();
> +    }
> +
> +    if (env->virt_enabled) {
> +        counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
> +        snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        counter_arr =3D env->pmu_fixed_ctrs[1].counter;
> +        snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +    if (new_virt) {
> +        snapshot_new =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        snapshot_new =3D env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +     /*
> +      * new_priv can be same as env->priv. So we need to calculate
> +      * delta first before updating snapshot_new[new_priv].
> +      */
> +    delta =3D current_icount - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] =3D current_icount;
> +
> +    counter_arr[env->priv] +=3D delta;
> +}
> +
> +static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
> +                                        target_ulong newpriv, bool new_v=
irt)
> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_ticks;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_ticks =3D icount_get();
> +    } else {
> +        current_ticks =3D cpu_get_host_ticks();
> +    }
> +
> +    if (env->virt_enabled) {
> +        counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
> +        snapshot_prev =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        counter_arr =3D env->pmu_fixed_ctrs[0].counter;
> +        snapshot_prev =3D env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    if (new_virt) {
> +        snapshot_new =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        snapshot_new =3D env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    delta =3D current_ticks - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] =3D current_ticks;
> +
> +    counter_arr[env->priv] +=3D delta;
> +}
> +
> +void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpri=
v,
> +                                 bool new_virt)
> +{
> +    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
> +    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
> +}
> +
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx=
)
>  {
>      uint32_t ctr_idx;
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 7c0ad661e050..ca40cfeed647 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -34,5 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_ev=
ent_idx event_idx);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_na=
me);
>  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                            uint32_t ctr_idx);
> +void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpri=
v,
> +                                 bool new_virt);
>
>  #endif /* RISCV_PMU_H */
>
> --
> 2.34.1
>
>

