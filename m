Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1145C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 00:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQvx-0000nj-B0; Tue, 23 Jan 2024 19:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rSQvt-0000mA-Ve
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:15:57 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rSQvr-0000XG-1N
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:15:57 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50ea9e189ebso5471021e87.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 16:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706055349; x=1706660149;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwgrPofJ79BhF0HtUZJIobT0qRcEEG/Flla285uaJv8=;
 b=AqxLdZyvN8vw1U9s7NLn7p5+dExJkY5cnMDRxYcYAX0e9bHZxg3gkNWfTj2KyXdkVJ
 1lEK0+VPO6R0zy9VWfTjaB1ft0aEeRuZiPZRuGy1HM9u6fP0eVi5HivOF0qe/bWXy0Am
 uXsdAtH9X4EM0dGWbix3D1C5LEDAxUjyX8B9w/BvTPUHznDDaINk+4aS6aoSuUITh4/3
 L5HQywKVDm73iGq+5QkPclUwx43oCU0WST+IJB3SqocHRszAemhd+EhMLWHv6zv5Susi
 lnuAUIMehNEU0DpIqPqbx3Y15pmdQEPJk7lkOMsMDbxNB0HOmDL/nIP03jrLtoeWpXe+
 iM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706055349; x=1706660149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwgrPofJ79BhF0HtUZJIobT0qRcEEG/Flla285uaJv8=;
 b=ngY0FWqqbQEpZCM53UI1/Qba99Sxp7EBqbBtcHCpjhCObUmx55VX+Rti1kUgzM989S
 xWBEhygHBHWJRqoPFj+hEh8fJ/Uz8U4x7gs7Cr7+kF3ZZoIgcJyHG4r7DGoH17WAL6Yx
 6y47r36Lm0oeyGTGtrmig0OQpsbdkLG0zokeJCZydwTkeeCp8uJBFQ8EFQeRU4n9xS6G
 LB5TyJLl+9c/VqGDSDOTIZx7818FOm4g7qCcavJUsGOJ4G78BI/2gQJTBU+64S9x4SFe
 nk/Mda5+GKjP3bLVPdHlfZr9nkXb+jJ+g45NcBS9+yXgESZ2xPIeCjF5acmzDK+A8VZp
 AcNw==
X-Gm-Message-State: AOJu0YxQVjQcIAzocSLFwiVdt97xbgoV4yrk8OQ62PH7LauZEFs4x+dJ
 Swki368vtc5yUbochQZDcKfLqijPyOAClBBgzXZ4/jxTaTQ7+kk7Wz6WLyOCgQuwFgQfruWKg1m
 Volv0gnCBmLHh0BI8idIk1xryQn7bFH9ym/Skxg==
X-Google-Smtp-Source: AGHT+IHLt2V97BFRm1znpSPTVzjpyGBv9Ynr9V+teADwsD9HJHx4sKimRYCJ3cOkH/884doUCPYqvuDopUFtz54axHc=
X-Received: by 2002:ac2:4242:0:b0:510:c63:5626 with SMTP id
 m2-20020ac24242000000b005100c635626mr562013lfl.28.1706055348950; Tue, 23 Jan
 2024 16:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20240109002554.646572-1-atishp@rivosinc.com>
 <20240109002554.646572-6-atishp@rivosinc.com>
 <CAKmqyKM2j=zeEObQuf+8kB78Ko3A-aaWBLpb24O0YVjg_FHcRA@mail.gmail.com>
In-Reply-To: <CAKmqyKM2j=zeEObQuf+8kB78Ko3A-aaWBLpb24O0YVjg_FHcRA@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Jan 2024 16:15:37 -0800
Message-ID: <CAHBxVyFC40ChLFXF2mDJLcs-J8sdrOk_fZP0K32Maf0DhOu6Zg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Jan 21, 2024 at 9:04=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, Jan 9, 2024 at 10:29=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > Privilege mode filtering can also be emulated for cycle/instret by
> > tracking host_ticks/icount during each privilege mode switch. This
> > patch implements that for both cycle/instret and mhpmcounters. The
> > first one requires Smcntrpmf while the other one requires Sscofpmf
> > to be enabled.
> >
> > The cycle/instret are still computed using host ticks when icount
> > is not enabled. Otherwise, they are computed using raw icount which
> > is more accurate in icount mode.
> >
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  target/riscv/cpu.h        | 11 +++++
> >  target/riscv/cpu_helper.c |  9 +++-
> >  target/riscv/csr.c        | 95 ++++++++++++++++++++++++++++++---------
> >  target/riscv/pmu.c        | 43 ++++++++++++++++++
> >  target/riscv/pmu.h        |  2 +
> >  5 files changed, 136 insertions(+), 24 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 34617c4c4bab..40d10726155b 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -136,6 +136,15 @@ typedef struct PMUCTRState {
> >      target_ulong irq_overflow_left;
> >  } PMUCTRState;
> >
> > +typedef struct PMUFixedCtrState {
> > +        /* Track cycle and icount for each privilege mode */
> > +        uint64_t counter[4];
> > +        uint64_t counter_prev[4];
>
> Are these two used?
>

Yes. That's where it tracks the current/previous value cycle/instret.
riscv_pmu_icount_update_priv/riscv_pmu_cycle_update_priv

The priv mode based filtering is enabled in riscv_pmu_ctr_get_fixed_counter=
s_val
using "counter" afterwards.

Did I misunderstand your question ?

> Alistair
>
> > +        /* Track cycle and icount for each privilege mode when V =3D 1=
*/
> > +        uint64_t counter_virt[2];
> > +        uint64_t counter_virt_prev[2];
> > +} PMUFixedCtrState;
> > +
> >  struct CPUArchState {
> >      target_ulong gpr[32];
> >      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> > @@ -334,6 +343,8 @@ struct CPUArchState {
> >      /* PMU event selector configured values for RV32 */
> >      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >
> > +    PMUFixedCtrState pmu_fixed_ctrs[2];
> > +
> >      target_ulong sscratch;
> >      target_ulong mscratch;
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index e7e23b34f455..3dddb1b433e8 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -715,8 +715,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, target=
_ulong newpriv)
> >  {
> >      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
> >
> > -    if (icount_enabled() && newpriv !=3D env->priv) {
> > -        riscv_itrigger_update_priv(env);
> > +    if (newpriv !=3D env->priv) {
> > +        if (icount_enabled()) {
> > +            riscv_itrigger_update_priv(env);
> > +            riscv_pmu_icount_update_priv(env, newpriv);
> > +        } else {
> > +            riscv_pmu_cycle_update_priv(env, newpriv);
> > +        }
> >      }
> >      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
> >      env->priv =3D newpriv;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 3bd4aa22374f..307d052021c5 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -782,32 +782,16 @@ static int write_vcsr(CPURISCVState *env, int csr=
no, target_ulong val)
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +#if defined(CONFIG_USER_ONLY)
> >  /* User Timers and Counters */
> >  static target_ulong get_ticks(bool shift)
> >  {
> > -    int64_t val;
> > -    target_ulong result;
> > -
> > -#if !defined(CONFIG_USER_ONLY)
> > -    if (icount_enabled()) {
> > -        val =3D icount_get();
> > -    } else {
> > -        val =3D cpu_get_host_ticks();
> > -    }
> > -#else
> > -    val =3D cpu_get_host_ticks();
> > -#endif
> > -
> > -    if (shift) {
> > -        result =3D val >> 32;
> > -    } else {
> > -        result =3D val;
> > -    }
> > +    int64_t val =3D cpu_get_host_ticks();
> > +    target_ulong result =3D shift ? val >> 32 : val;
> >
> >      return result;
> >  }
> >
> > -#if defined(CONFIG_USER_ONLY)
> >  static RISCVException read_time(CPURISCVState *env, int csrno,
> >                                  target_ulong *val)
> >  {
> > @@ -932,6 +916,70 @@ static int write_mhpmeventh(CPURISCVState *env, in=
t csrno, target_ulong val)
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState=
 *env,
> > +                                                         int counter_i=
dx,
> > +                                                         bool upper_ha=
lf)
> > +{
> > +    uint64_t curr_val =3D 0;
> > +    target_ulong result =3D 0;
> > +    uint64_t *counter_arr =3D icount_enabled() ? env->pmu_fixed_ctrs[1=
].counter :
> > +                            env->pmu_fixed_ctrs[0].counter;
> > +    uint64_t *counter_arr_virt =3D icount_enabled() ?
> > +                                 env->pmu_fixed_ctrs[1].counter_virt :
> > +                                 env->pmu_fixed_ctrs[0].counter_virt;
> > +    uint64_t cfg_val =3D 0;
> > +
> > +    if (counter_idx =3D=3D 0) {
> > +        cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> > +                  env->mcyclecfg;
> > +    } else if (counter_idx =3D=3D 2) {
> > +        cfg_val =3D upper_half ? ((uint64_t)env->minstretcfgh << 32) :
> > +                  env->minstretcfg;
> > +    } else {
> > +        cfg_val =3D upper_half ?
> > +                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
> > +                  env->mhpmevent_val[counter_idx];
> > +    }
> > +
> > +    if (!cfg_val) {
> > +        if (icount_enabled()) {
> > +            curr_val =3D icount_get_raw();
> > +        } else {
> > +            curr_val =3D cpu_get_host_ticks();
> > +        }
> > +        goto done;
> > +    }
> > +
> > +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> > +        curr_val +=3D counter_arr[PRV_M];
> > +    }
> > +
> > +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> > +        curr_val +=3D counter_arr[PRV_S];
> > +    }
> > +
> > +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> > +        curr_val +=3D counter_arr[PRV_U];
> > +    }
> > +
> > +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> > +        curr_val +=3D counter_arr_virt[PRV_S];
> > +    }
> > +
> > +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> > +        curr_val +=3D counter_arr_virt[PRV_U];
> > +    }
> > +
> > +done:
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +        result =3D upper_half ? curr_val >> 32 : curr_val;
> > +    } else {
> > +        result =3D curr_val;
> > +    }
> > +
> > +    return result;
> > +}
> > +
> >  static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulo=
ng val)
> >  {
> >      int ctr_idx =3D csrno - CSR_MCYCLE;
> > @@ -941,7 +989,8 @@ static int write_mhpmcounter(CPURISCVState *env, in=
t csrno, target_ulong val)
> >      counter->mhpmcounter_val =3D val;
> >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > -        counter->mhpmcounter_prev =3D get_ticks(false);
> > +        counter->mhpmcounter_prev =3D riscv_pmu_ctr_get_fixed_counters=
_val(env,
> > +                                                                ctr_id=
x, false);
> >          if (ctr_idx > 2) {
> >              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >                  mhpmctr_val =3D mhpmctr_val |
> > @@ -968,7 +1017,8 @@ static int write_mhpmcounterh(CPURISCVState *env, =
int csrno, target_ulong val)
> >      mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
> >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > -        counter->mhpmcounterh_prev =3D get_ticks(true);
> > +        counter->mhpmcounterh_prev =3D riscv_pmu_ctr_get_fixed_counter=
s_val(env,
> > +                                                                 ctr_i=
dx, true);
> >          if (ctr_idx > 2) {
> >              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
> >          }
> > @@ -1009,7 +1059,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCV=
State *env, target_ulong *val,
> >       */
> >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > -        *val =3D get_ticks(upper_half) - ctr_prev + ctr_val;
> > +        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, up=
per_half) -
> > +                                                    ctr_prev + ctr_val=
;
> >      } else {
> >          *val =3D ctr_val;
> >      }
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index 0e7d58b8a5c2..8b6cc4c6bb4d 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -19,6 +19,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/log.h"
> >  #include "qemu/error-report.h"
> > +#include "qemu/timer.h"
> >  #include "cpu.h"
> >  #include "pmu.h"
> >  #include "sysemu/cpu-timers.h"
> > @@ -176,6 +177,48 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, =
uint32_t ctr_idx)
> >      return 0;
> >  }
> >
> > +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong new=
priv)
> > +{
> > +    uint64_t delta;
> > +    uint64_t *counter_arr;
> > +    uint64_t *counter_arr_prev;
> > +    uint64_t current_icount =3D icount_get_raw();
> > +
> > +    if (env->virt_enabled) {
> > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
> > +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> > +    } else {
> > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter;
> > +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_prev;
> > +    }
> > +
> > +    counter_arr_prev[newpriv] =3D current_icount;
> > +    delta =3D current_icount - counter_arr_prev[env->priv];
> > +
> > +    counter_arr[env->priv] +=3D delta;
> > +}
> > +
> > +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newp=
riv)
> > +{
> > +    uint64_t delta;
> > +    uint64_t *counter_arr;
> > +    uint64_t *counter_arr_prev;
> > +    uint64_t current_host_ticks =3D cpu_get_host_ticks();
> > +
> > +    if (env->virt_enabled) {
> > +        counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
> > +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
> > +    } else {
> > +        counter_arr =3D env->pmu_fixed_ctrs[0].counter;
> > +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_prev;
> > +    }
> > +
> > +    counter_arr_prev[newpriv] =3D current_host_ticks;
> > +    delta =3D current_host_ticks - counter_arr_prev[env->priv];
> > +
> > +    counter_arr[env->priv] +=3D delta;
> > +}
> > +
> >  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_i=
dx)
> >  {
> >      uint32_t ctr_idx;
> > diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> > index 505fc850d38e..50de6031a730 100644
> > --- a/target/riscv/pmu.h
> > +++ b/target/riscv/pmu.h
> > @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_=
event_idx event_idx);
> >  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_=
name);
> >  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> >                            uint32_t ctr_idx);
> > +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong new=
priv);
> > +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newp=
riv);
> > --
> > 2.34.1
> >
> >

