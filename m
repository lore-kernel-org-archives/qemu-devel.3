Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3223CC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 19:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4oE-0004Zs-Ct; Mon, 05 Feb 2024 14:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rX4oC-0004ZA-RR
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:39:12 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rX4o6-0001PX-Rd
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:39:11 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-511570b2f49so417988e87.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707161943; x=1707766743;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=97pR79Loth6JFa0kAkLSoburHmPcBhPkVZfZ4J6G+6Y=;
 b=0vLaZIgprUsWko72x6TNBFLTlE4SwQZyWDUUqNPCNN6m+9/qcEX6jZ4Neflxywf4CP
 olJ4BY0PxgxRqAomlZIwXbYX+6jB7rQgpYg7L7YFkMlF0AB7i3/+UWpsOJ5UGU19IDhN
 5k/M3cu3G4by0M/IhYmpaJIRlnZrQ2msNUWU77iYWmXj1T+Jj3bOtv1417qdKuE1+ll/
 2TXg9cofSWj7KiYadOtTmbT5uMTkVR+SxjwJV9/hAoYI39M/PNhZGvpzOkKFvnVx2N6V
 2ScWNBClflv05dA1JAAooPKd/+/OW05xmjI3l+XcEWj/V0g5EXfVfUNLTrY/LWRi8Tx9
 5sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707161943; x=1707766743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97pR79Loth6JFa0kAkLSoburHmPcBhPkVZfZ4J6G+6Y=;
 b=It4hmhHiU6Yc9LtIcKqkOiMCi3YNsdiYaAlakl8PDUDnY8qwMTJyN7Ka+yAt86Em+o
 +JEO7Ik9UBGavucZOXXOUjc6dThSPSUoXJB/6hmt6RTvp0spUzVhCQxFx3LsSKWH087F
 67OY9G3IB/ZGJdQqDNZClVXXgmDNf6zIf2nn9TO5AeerJLIcuxU9rXHr3f0cA7ttvlHr
 lBjto9ROjIkqLeWP0zCOYrA6jZguYyXNtZSpt7JQbyNp6tYBVJ8+4PshEzv5teREDQnn
 crvAI65mgHWi8CPenNEq6MgYuivrxqruudx18DpT6BbsIxBhydHegDndO21hKlhrgDIq
 kE0w==
X-Gm-Message-State: AOJu0Yw3eff5//XmXVoYSKtz0EhUi3BqqzF7twJpfKLkTlVl6BpUYy10
 uvRLXXzwuY9/scqvwu1f3XVnONAQ31JMkEeUDCIbyBoAaCRy0m5Ui5Ix/whW0i0nVxpcz2Mhft6
 5MDKORIkYHBmXrMVXidjsAYcwXXpU9V5EsdiMBA==
X-Google-Smtp-Source: AGHT+IGxQJNNoCYoqu5kuz5L4jcIdf2xED2CPxO9UEJpMGl9RZuulJRMV8iL5VdIEZQsLlgedWgGPzYqfxywvptnv8A=
X-Received: by 2002:a05:6512:34cd:b0:511:3211:9266 with SMTP id
 w13-20020a05651234cd00b0051132119266mr222940lfr.18.1707161943284; Mon, 05 Feb
 2024 11:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20240109002554.646572-1-atishp@rivosinc.com>
 <20240109002554.646572-6-atishp@rivosinc.com>
 <CAKmqyKM2j=zeEObQuf+8kB78Ko3A-aaWBLpb24O0YVjg_FHcRA@mail.gmail.com>
 <CAHBxVyFC40ChLFXF2mDJLcs-J8sdrOk_fZP0K32Maf0DhOu6Zg@mail.gmail.com>
In-Reply-To: <CAHBxVyFC40ChLFXF2mDJLcs-J8sdrOk_fZP0K32Maf0DhOu6Zg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 5 Feb 2024 11:38:52 -0800
Message-ID: <CAHBxVyEPizJ4=ziNv++dauEPHcfGMT5HBOrUPJjkQfNyEKfYWw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: multipart/alternative; boundary="0000000000003433b00610a79d93"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x12d.google.com
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

--0000000000003433b00610a79d93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 4:15=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.=
com>
wrote:

> On Sun, Jan 21, 2024 at 9:04=E2=80=AFPM Alistair Francis <alistair23@gmai=
l.com>
> wrote:
> >
> > On Tue, Jan 9, 2024 at 10:29=E2=80=AFAM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > Privilege mode filtering can also be emulated for cycle/instret by
> > > tracking host_ticks/icount during each privilege mode switch. This
> > > patch implements that for both cycle/instret and mhpmcounters. The
> > > first one requires Smcntrpmf while the other one requires Sscofpmf
> > > to be enabled.
> > >
> > > The cycle/instret are still computed using host ticks when icount
> > > is not enabled. Otherwise, they are computed using raw icount which
> > > is more accurate in icount mode.
> > >
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  target/riscv/cpu.h        | 11 +++++
> > >  target/riscv/cpu_helper.c |  9 +++-
> > >  target/riscv/csr.c        | 95 ++++++++++++++++++++++++++++++-------=
--
> > >  target/riscv/pmu.c        | 43 ++++++++++++++++++
> > >  target/riscv/pmu.h        |  2 +
> > >  5 files changed, 136 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 34617c4c4bab..40d10726155b 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -136,6 +136,15 @@ typedef struct PMUCTRState {
> > >      target_ulong irq_overflow_left;
> > >  } PMUCTRState;
> > >
> > > +typedef struct PMUFixedCtrState {
> > > +        /* Track cycle and icount for each privilege mode */
> > > +        uint64_t counter[4];
> > > +        uint64_t counter_prev[4];
> >
> > Are these two used?
> >
>
> Yes. That's where it tracks the current/previous value cycle/instret.
> riscv_pmu_icount_update_priv/riscv_pmu_cycle_update_priv
>
> The priv mode based filtering is enabled in
> riscv_pmu_ctr_get_fixed_counters_val
> using "counter" afterwards.
>
> Did I misunderstand your question ?
>
>
ping ?


> > Alistair
> >
> > > +        /* Track cycle and icount for each privilege mode when V =3D=
 1*/
> > > +        uint64_t counter_virt[2];
> > > +        uint64_t counter_virt_prev[2];
> > > +} PMUFixedCtrState;
> > > +
> > >  struct CPUArchState {
> > >      target_ulong gpr[32];
> > >      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers *=
/
> > > @@ -334,6 +343,8 @@ struct CPUArchState {
> > >      /* PMU event selector configured values for RV32 */
> > >      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> > >
> > > +    PMUFixedCtrState pmu_fixed_ctrs[2];
> > > +
> > >      target_ulong sscratch;
> > >      target_ulong mscratch;
> > >
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index e7e23b34f455..3dddb1b433e8 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -715,8 +715,13 @@ void riscv_cpu_set_mode(CPURISCVState *env,
> target_ulong newpriv)
> > >  {
> > >      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
> > >
> > > -    if (icount_enabled() && newpriv !=3D env->priv) {
> > > -        riscv_itrigger_update_priv(env);
> > > +    if (newpriv !=3D env->priv) {
> > > +        if (icount_enabled()) {
> > > +            riscv_itrigger_update_priv(env);
> > > +            riscv_pmu_icount_update_priv(env, newpriv);
> > > +        } else {
> > > +            riscv_pmu_cycle_update_priv(env, newpriv);
> > > +        }
> > >      }
> > >      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
> > >      env->priv =3D newpriv;
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index 3bd4aa22374f..307d052021c5 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -782,32 +782,16 @@ static int write_vcsr(CPURISCVState *env, int
> csrno, target_ulong val)
> > >      return RISCV_EXCP_NONE;
> > >  }
> > >
> > > +#if defined(CONFIG_USER_ONLY)
> > >  /* User Timers and Counters */
> > >  static target_ulong get_ticks(bool shift)
> > >  {
> > > -    int64_t val;
> > > -    target_ulong result;
> > > -
> > > -#if !defined(CONFIG_USER_ONLY)
> > > -    if (icount_enabled()) {
> > > -        val =3D icount_get();
> > > -    } else {
> > > -        val =3D cpu_get_host_ticks();
> > > -    }
> > > -#else
> > > -    val =3D cpu_get_host_ticks();
> > > -#endif
> > > -
> > > -    if (shift) {
> > > -        result =3D val >> 32;
> > > -    } else {
> > > -        result =3D val;
> > > -    }
> > > +    int64_t val =3D cpu_get_host_ticks();
> > > +    target_ulong result =3D shift ? val >> 32 : val;
> > >
> > >      return result;
> > >  }
> > >
> > > -#if defined(CONFIG_USER_ONLY)
> > >  static RISCVException read_time(CPURISCVState *env, int csrno,
> > >                                  target_ulong *val)
> > >  {
> > > @@ -932,6 +916,70 @@ static int write_mhpmeventh(CPURISCVState *env,
> int csrno, target_ulong val)
> > >      return RISCV_EXCP_NONE;
> > >  }
> > >
> > > +static target_ulong
> riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> > > +                                                         int
> counter_idx,
> > > +                                                         bool
> upper_half)
> > > +{
> > > +    uint64_t curr_val =3D 0;
> > > +    target_ulong result =3D 0;
> > > +    uint64_t *counter_arr =3D icount_enabled() ?
> env->pmu_fixed_ctrs[1].counter :
> > > +                            env->pmu_fixed_ctrs[0].counter;
> > > +    uint64_t *counter_arr_virt =3D icount_enabled() ?
> > > +                                 env->pmu_fixed_ctrs[1].counter_virt=
 :
> > > +                                 env->pmu_fixed_ctrs[0].counter_virt=
;
> > > +    uint64_t cfg_val =3D 0;
> > > +
> > > +    if (counter_idx =3D=3D 0) {
> > > +        cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> > > +                  env->mcyclecfg;
> > > +    } else if (counter_idx =3D=3D 2) {
> > > +        cfg_val =3D upper_half ? ((uint64_t)env->minstretcfgh << 32)=
 :
> > > +                  env->minstretcfg;
> > > +    } else {
> > > +        cfg_val =3D upper_half ?
> > > +                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32)=
 :
> > > +                  env->mhpmevent_val[counter_idx];
> > > +    }
> > > +
> > > +    if (!cfg_val) {
> > > +        if (icount_enabled()) {
> > > +            curr_val =3D icount_get_raw();
> > > +        } else {
> > > +            curr_val =3D cpu_get_host_ticks();
> > > +        }
> > > +        goto done;
> > > +    }
> > > +
> > > +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> > > +        curr_val +=3D counter_arr[PRV_M];
> > > +    }
> > > +
> > > +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> > > +        curr_val +=3D counter_arr[PRV_S];
> > > +    }
> > > +
> > > +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> > > +        curr_val +=3D counter_arr[PRV_U];
> > > +    }
> > > +
> > > +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> > > +        curr_val +=3D counter_arr_virt[PRV_S];
> > > +    }
> > > +
> > > +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> > > +        curr_val +=3D counter_arr_virt[PRV_U];
> > > +    }
> > > +
> > > +done:
> > > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > > +        result =3D upper_half ? curr_val >> 32 : curr_val;
> > > +    } else {
> > > +        result =3D curr_val;
> > > +    }
> > > +
> > > +    return result;
> > > +}
> > > +
> > >  static int write_mhpmcounter(CPURISCVState *env, int csrno,
> target_ulong val)
> > >  {
> > >      int ctr_idx =3D csrno - CSR_MCYCLE;
> > > @@ -941,7 +989,8 @@ static int write_mhpmcounter(CPURISCVState *env,
> int csrno, target_ulong val)
> > >      counter->mhpmcounter_val =3D val;
> > >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> > >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > > -        counter->mhpmcounter_prev =3D get_ticks(false);
> > > +        counter->mhpmcounter_prev =3D
> riscv_pmu_ctr_get_fixed_counters_val(env,
> > > +
> ctr_idx, false);
> > >          if (ctr_idx > 2) {
> > >              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > >                  mhpmctr_val =3D mhpmctr_val |
> > > @@ -968,7 +1017,8 @@ static int write_mhpmcounterh(CPURISCVState *env=
,
> int csrno, target_ulong val)
> > >      mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
> > >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> > >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > > -        counter->mhpmcounterh_prev =3D get_ticks(true);
> > > +        counter->mhpmcounterh_prev =3D
> riscv_pmu_ctr_get_fixed_counters_val(env,
> > > +
>  ctr_idx, true);
> > >          if (ctr_idx > 2) {
> > >              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
> > >          }
> > > @@ -1009,7 +1059,8 @@ static RISCVException
> riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> > >       */
> > >      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> > >          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > > -        *val =3D get_ticks(upper_half) - ctr_prev + ctr_val;
> > > +        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx,
> upper_half) -
> > > +                                                    ctr_prev +
> ctr_val;
> > >      } else {
> > >          *val =3D ctr_val;
> > >      }
> > > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > > index 0e7d58b8a5c2..8b6cc4c6bb4d 100644
> > > --- a/target/riscv/pmu.c
> > > +++ b/target/riscv/pmu.c
> > > @@ -19,6 +19,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/log.h"
> > >  #include "qemu/error-report.h"
> > > +#include "qemu/timer.h"
> > >  #include "cpu.h"
> > >  #include "pmu.h"
> > >  #include "sysemu/cpu-timers.h"
> > > @@ -176,6 +177,48 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu=
,
> uint32_t ctr_idx)
> > >      return 0;
> > >  }
> > >
> > > +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
> newpriv)
> > > +{
> > > +    uint64_t delta;
> > > +    uint64_t *counter_arr;
> > > +    uint64_t *counter_arr_prev;
> > > +    uint64_t current_icount =3D icount_get_raw();
> > > +
> > > +    if (env->virt_enabled) {
> > > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
> > > +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_virt_pre=
v;
> > > +    } else {
> > > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter;
> > > +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_prev;
> > > +    }
> > > +
> > > +    counter_arr_prev[newpriv] =3D current_icount;
> > > +    delta =3D current_icount - counter_arr_prev[env->priv];
> > > +
> > > +    counter_arr[env->priv] +=3D delta;
> > > +}
> > > +
> > > +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
> newpriv)
> > > +{
> > > +    uint64_t delta;
> > > +    uint64_t *counter_arr;
> > > +    uint64_t *counter_arr_prev;
> > > +    uint64_t current_host_ticks =3D cpu_get_host_ticks();
> > > +
> > > +    if (env->virt_enabled) {
> > > +        counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
> > > +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_virt_pre=
v;
> > > +    } else {
> > > +        counter_arr =3D env->pmu_fixed_ctrs[0].counter;
> > > +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_prev;
> > > +    }
> > > +
> > > +    counter_arr_prev[newpriv] =3D current_host_ticks;
> > > +    delta =3D current_host_ticks - counter_arr_prev[env->priv];
> > > +
> > > +    counter_arr[env->priv] +=3D delta;
> > > +}
> > > +
> > >  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx
> event_idx)
> > >  {
> > >      uint32_t ctr_idx;
> > > diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> > > index 505fc850d38e..50de6031a730 100644
> > > --- a/target/riscv/pmu.h
> > > +++ b/target/riscv/pmu.h
> > > @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum
> riscv_pmu_event_idx event_idx);
> > >  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char
> *pmu_name);
> > >  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> > >                            uint32_t ctr_idx);
> > > +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong
> newpriv);
> > > +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong
> newpriv);
> > > --
> > > 2.34.1
> > >
> > >
>

--0000000000003433b00610a79d93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 23, 2024 at 4:15=E2=80=AF=
PM Atish Kumar Patra &lt;<a href=3D"mailto:atishp@rivosinc.com">atishp@rivo=
sinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Sun, Jan 21, 2024 at 9:04=E2=80=AFPM Alistair Francis &lt;<a hre=
f=3D"mailto:alistair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Jan 9, 2024 at 10:29=E2=80=AFAM Atish Patra &lt;<a href=3D"mai=
lto:atishp@rivosinc.com" target=3D"_blank">atishp@rivosinc.com</a>&gt; wrot=
e:<br>
&gt; &gt;<br>
&gt; &gt; Privilege mode filtering can also be emulated for cycle/instret b=
y<br>
&gt; &gt; tracking host_ticks/icount during each privilege mode switch. Thi=
s<br>
&gt; &gt; patch implements that for both cycle/instret and mhpmcounters. Th=
e<br>
&gt; &gt; first one requires Smcntrpmf while the other one requires Sscofpm=
f<br>
&gt; &gt; to be enabled.<br>
&gt; &gt;<br>
&gt; &gt; The cycle/instret are still computed using host ticks when icount=
<br>
&gt; &gt; is not enabled. Otherwise, they are computed using raw icount whi=
ch<br>
&gt; &gt; is more accurate in icount mode.<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarbo=
za@ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br=
>
&gt; &gt; Signed-off-by: Atish Patra &lt;<a href=3D"mailto:atishp@rivosinc.=
com" target=3D"_blank">atishp@rivosinc.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++++<br=
>
&gt; &gt;=C2=A0 target/riscv/cpu_helper.c |=C2=A0 9 +++-<br>
&gt; &gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 95 ++++++++=
++++++++++++++++++++++---------<br>
&gt; &gt;=C2=A0 target/riscv/pmu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 43 ++++++++=
++++++++++<br>
&gt; &gt;=C2=A0 target/riscv/pmu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +<b=
r>
&gt; &gt;=C2=A0 5 files changed, 136 insertions(+), 24 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; &gt; index 34617c4c4bab..40d10726155b 100644<br>
&gt; &gt; --- a/target/riscv/cpu.h<br>
&gt; &gt; +++ b/target/riscv/cpu.h<br>
&gt; &gt; @@ -136,6 +136,15 @@ typedef struct PMUCTRState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong irq_overflow_left;<br>
&gt; &gt;=C2=A0 } PMUCTRState;<br>
&gt; &gt;<br>
&gt; &gt; +typedef struct PMUFixedCtrState {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Track cycle and icount for each p=
rivilege mode */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t counter[4];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t counter_prev[4];<br>
&gt;<br>
&gt; Are these two used?<br>
&gt;<br>
<br>
Yes. That&#39;s where it tracks the current/previous value cycle/instret.<b=
r>
riscv_pmu_icount_update_priv/riscv_pmu_cycle_update_priv<br>
<br>
The priv mode based filtering is enabled in riscv_pmu_ctr_get_fixed_counter=
s_val<br>
using &quot;counter&quot; afterwards.<br>
<br>
Did I misunderstand your question ?<br>
<br></blockquote><div><br></div><div>ping ?</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; Alistair<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Track cycle and icount for each p=
rivilege mode when V =3D 1*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t counter_virt[2];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t counter_virt_prev[2];<br>
&gt; &gt; +} PMUFixedCtrState;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 struct CPUArchState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong gpr[32];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong gprh[32]; /* 64 top bits of the =
128-bit registers */<br>
&gt; &gt; @@ -334,6 +343,8 @@ struct CPUArchState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* PMU event selector configured values for R=
V32 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS=
];<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 PMUFixedCtrState pmu_fixed_ctrs[2];<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong sscratch;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mscratch;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.=
c<br>
&gt; &gt; index e7e23b34f455..3dddb1b433e8 100644<br>
&gt; &gt; --- a/target/riscv/cpu_helper.c<br>
&gt; &gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; &gt; @@ -715,8 +715,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, =
target_ulong newpriv)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_assert(newpriv &lt;=3D PRV_M &amp;&amp; new=
priv !=3D PRV_RESERVED);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 if (icount_enabled() &amp;&amp; newpriv !=3D env-&=
gt;priv) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_itrigger_update_priv(env);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (newpriv !=3D env-&gt;priv) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (icount_enabled()) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_itrigger_update_=
priv(env);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_icount_updat=
e_priv(env, newpriv);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_cycle_update=
_priv(env, newpriv);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* tlb_flush is unnecessary as mode is contai=
ned in mmu_idx */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;priv =3D newpriv;<br>
&gt; &gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; &gt; index 3bd4aa22374f..307d052021c5 100644<br>
&gt; &gt; --- a/target/riscv/csr.c<br>
&gt; &gt; +++ b/target/riscv/csr.c<br>
&gt; &gt; @@ -782,32 +782,16 @@ static int write_vcsr(CPURISCVState *env, i=
nt csrno, target_ulong val)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +#if defined(CONFIG_USER_ONLY)<br>
&gt; &gt;=C2=A0 /* User Timers and Counters */<br>
&gt; &gt;=C2=A0 static target_ulong get_ticks(bool shift)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t val;<br>
&gt; &gt; -=C2=A0 =C2=A0 target_ulong result;<br>
&gt; &gt; -<br>
&gt; &gt; -#if !defined(CONFIG_USER_ONLY)<br>
&gt; &gt; -=C2=A0 =C2=A0 if (icount_enabled()) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D icount_get();<br>
&gt; &gt; -=C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D cpu_get_host_ticks();<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; -#else<br>
&gt; &gt; -=C2=A0 =C2=A0 val =3D cpu_get_host_ticks();<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 if (shift) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D val &gt;&gt; 32;<br>
&gt; &gt; -=C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D val;<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 int64_t val =3D cpu_get_host_ticks();<br>
&gt; &gt; +=C2=A0 =C2=A0 target_ulong result =3D shift ? val &gt;&gt; 32 : =
val;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return result;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -#if defined(CONFIG_USER_ONLY)<br>
&gt; &gt;=C2=A0 static RISCVException read_time(CPURISCVState *env, int csr=
no,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *val)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; @@ -932,6 +916,70 @@ static int write_mhpmeventh(CPURISCVState *e=
nv, int csrno, target_ulong val)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISC=
VState *env,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int count=
er_idx,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool uppe=
r_half)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t curr_val =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 target_ulong result =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr =3D icount_enabled() ? env-&=
gt;pmu_fixed_ctrs[1].counter :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pmu_fixed_ctrs[0].counter;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr_virt =3D icount_enabled() ?<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pmu_fixed_ct=
rs[1].counter_virt :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pmu_fixed_ct=
rs[0].counter_virt;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t cfg_val =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (counter_idx =3D=3D 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg_val =3D upper_half ? ((uint64_t)=
env-&gt;mcyclecfgh &lt;&lt; 32) :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
nv-&gt;mcyclecfg;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else if (counter_idx =3D=3D 2) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg_val =3D upper_half ? ((uint64_t)=
env-&gt;minstretcfgh &lt;&lt; 32) :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
nv-&gt;minstretcfg;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg_val =3D upper_half ?<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
(uint64_t)env-&gt;mhpmeventh_val[counter_idx] &lt;&lt; 32) :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
nv-&gt;mhpmevent_val[counter_idx];<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!cfg_val) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (icount_enabled()) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val =3D icount_ge=
t_raw();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val =3D cpu_get_h=
ost_ticks();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!(cfg_val &amp; MCYCLECFG_BIT_MINH)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val +=3D counter_arr[PRV_M];<br=
>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!(cfg_val &amp; MCYCLECFG_BIT_SINH)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val +=3D counter_arr[PRV_S];<br=
>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!(cfg_val &amp; MCYCLECFG_BIT_UINH)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val +=3D counter_arr[PRV_U];<br=
>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!(cfg_val &amp; MCYCLECFG_BIT_VSINH)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val +=3D counter_arr_virt[PRV_S=
];<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!(cfg_val &amp; MCYCLECFG_BIT_VUINH)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_val +=3D counter_arr_virt[PRV_U=
];<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +done:<br>
&gt; &gt; +=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D upper_half ? curr_val &gt=
;&gt; 32 : curr_val;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D curr_val;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return result;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static int write_mhpmcounter(CPURISCVState *env, int csrno,=
 target_ulong val)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ctr_idx =3D csrno - CSR_MCYCLE;<br>
&gt; &gt; @@ -941,7 +989,8 @@ static int write_mhpmcounter(CPURISCVState *e=
nv, int csrno, target_ulong val)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 counter-&gt;mhpmcounter_val =3D val;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx=
) ||<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_ctr_monitor_instructi=
ons(env, ctr_idx)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter-&gt;mhpmcounter_prev =3D get=
_ticks(false);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter-&gt;mhpmcounter_prev =3D ris=
cv_pmu_ctr_get_fixed_counters_val(env,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ctr_idx, false);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctr_idx &gt; 2) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_mxl=
(env) =3D=3D MXL_RV32) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mhp=
mctr_val =3D mhpmctr_val |<br>
&gt; &gt; @@ -968,7 +1017,8 @@ static int write_mhpmcounterh(CPURISCVState =
*env, int csrno, target_ulong val)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val &=
lt;&lt; 32);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx=
) ||<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_ctr_monitor_instructi=
ons(env, ctr_idx)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter-&gt;mhpmcounterh_prev =3D ge=
t_ticks(true);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter-&gt;mhpmcounterh_prev =3D ri=
scv_pmu_ctr_get_fixed_counters_val(env,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ctr_idx, true);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctr_idx &gt; 2) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_setup_t=
imer(env, mhpmctr_val, ctr_idx);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -1009,7 +1059,8 @@ static RISCVException riscv_pmu_read_ctr(CP=
URISCVState *env, target_ulong *val,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx=
) ||<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_pmu_ctr_monitor_instructi=
ons(env, ctr_idx)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D get_ticks(upper_half) - ctr=
_prev + ctr_val;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D riscv_pmu_ctr_get_fixed_cou=
nters_val(env, ctr_idx, upper_half) -<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctr_prev + ctr_val;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D ctr_val;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c<br>
&gt; &gt; index 0e7d58b8a5c2..8b6cc4c6bb4d 100644<br>
&gt; &gt; --- a/target/riscv/pmu.c<br>
&gt; &gt; +++ b/target/riscv/pmu.c<br>
&gt; &gt; @@ -19,6 +19,7 @@<br>
&gt; &gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qemu/log.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt; &gt; +#include &quot;qemu/timer.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;pmu.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;sysemu/cpu-timers.h&quot;<br>
&gt; &gt; @@ -176,6 +177,48 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU =
*cpu, uint32_t ctr_idx)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulo=
ng newpriv)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t delta;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t current_icount =3D icount_get_raw();<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (env-&gt;virt_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr =3D env-&gt;pmu_fixed_ct=
rs[1].counter_virt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr_prev =3D env-&gt;pmu_fix=
ed_ctrs[1].counter_virt_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr =3D env-&gt;pmu_fixed_ct=
rs[1].counter;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr_prev =3D env-&gt;pmu_fix=
ed_ctrs[1].counter_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 counter_arr_prev[newpriv] =3D current_icount;<br>
&gt; &gt; +=C2=A0 =C2=A0 delta =3D current_icount - counter_arr_prev[env-&g=
t;priv];<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 counter_arr[env-&gt;priv] +=3D delta;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulon=
g newpriv)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t delta;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t *counter_arr_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t current_host_ticks =3D cpu_get_host_ticks=
();<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (env-&gt;virt_enabled) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr =3D env-&gt;pmu_fixed_ct=
rs[0].counter_virt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr_prev =3D env-&gt;pmu_fix=
ed_ctrs[0].counter_virt_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr =3D env-&gt;pmu_fixed_ct=
rs[0].counter;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 counter_arr_prev =3D env-&gt;pmu_fix=
ed_ctrs[0].counter_prev;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 counter_arr_prev[newpriv] =3D current_host_ticks;<=
br>
&gt; &gt; +=C2=A0 =C2=A0 delta =3D current_host_ticks - counter_arr_prev[en=
v-&gt;priv];<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 counter_arr[env-&gt;priv] +=3D delta;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_=
idx event_idx)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t ctr_idx;<br>
&gt; &gt; diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h<br>
&gt; &gt; index 505fc850d38e..50de6031a730 100644<br>
&gt; &gt; --- a/target/riscv/pmu.h<br>
&gt; &gt; +++ b/target/riscv/pmu.h<br>
&gt; &gt; @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum risc=
v_pmu_event_idx event_idx);<br>
&gt; &gt;=C2=A0 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask,=
 char *pmu_name);<br>
&gt; &gt;=C2=A0 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t valu=
e,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ctr_idx);<br>
&gt; &gt; +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulo=
ng newpriv);<br>
&gt; &gt; +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulon=
g newpriv);<br>
&gt; &gt; --<br>
&gt; &gt; 2.34.1<br>
&gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--0000000000003433b00610a79d93--

