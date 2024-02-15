Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C179DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTcy-0006S3-WD; Wed, 14 Feb 2024 23:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTcv-0006Qv-0Y; Wed, 14 Feb 2024 23:45:38 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTcs-0004h1-S2; Wed, 14 Feb 2024 23:45:36 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4c127eb4d6dso48697e0c.1; 
 Wed, 14 Feb 2024 20:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707972333; x=1708577133; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVq0HWF57K+0IsviE1SfBthtou27mZWkM9cWtpqRjhU=;
 b=RrSt+bxXQ0t5d/fvg7fRMR7ica4cjzhsBI/mF3+fHLGSovLqEQeC0V7zSBzxgX0OmD
 +fVNCWnSksbJBhZZgr2ISvq1z9q+CobPe3Iipon87RBI9drpJStBLqm02eQe3xc2jCtH
 0+ONPDcfVIoFgNAlDlYtidT/Wxlj1WUGp1d8XMKGGOBuS1qpUiRyODPfESw8XC9t4tMI
 /LkpNWr9Qa1/frDMO7UClOH/EqLoUYSj3pJ4kRn1+j5KF9wy0TrNdr4fo4aD2hGMeDpp
 mLlJ1IyVTnUqGXER7uyx51Q9gWyf/VjaY5U4WgRZnzflEVfOl1IZyFbs7RAC1xog6UFY
 b1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707972333; x=1708577133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVq0HWF57K+0IsviE1SfBthtou27mZWkM9cWtpqRjhU=;
 b=C9PW3XDvAxXgkYZE4vC0lgg351dODRgvQOlyON0MxOmFzRZxNnU0QMQKksGG1xgz4t
 IbB4qDum5gt5f5d2l1q31OibJ4mqVWWGWVhOUVwAjU94xhrRX1+SXJYnYMuK4vSB9tPa
 LohG9fzvBPzKqz7SQofFXYk/hdkhPJer2LsMO5dhjJvOlMN+5hGm/igwCn0B8ZnlvZS7
 JQvdSEwDGP3GX9TPd7YymebLLV98Wne7e5GIhrrIoFF6H5eb9HHbeJXuFDRc6vLqA2U5
 e7aR+XJObjJdg5mxechax+nZSi3V/RuH1cqxs8pexJ+EoHKcin/9ugbD/q6K7dYVM+PR
 iRIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtPq9tD0bHVVCVS4OjCon6yydCdYV2Sa6HP0Ii1YVfAhfpj8hVPnY+mY8IJrr7zdcqKg6hCp55CZswFh0ZL8AqylMqxd9HjjgthP3v6cRJ1zSqVdIsgmDF1sQ2g==
X-Gm-Message-State: AOJu0YwRbeERAaZzAq646mU3rpBw/nsZPn3PKs9JvokG7Wqg3lx8uAkQ
 aw6W26kfodMRmaqw6SkJ1pZvkOOvZb982RRoOv6fG15jA0b4YnwSlNK5D/92ZgmZq1dTlrGGIDp
 PhZx9ICboBUl3LDN0WCRXslE8oq8=
X-Google-Smtp-Source: AGHT+IFIXuTMxTchfs8I7UkTeECkTa1YwSt3Txo9D7lqVStiWrUMoAqauFKYY+8wyymOQpNjbnAtXI8CzwWzQJHfDD4=
X-Received: by 2002:a05:6122:290b:b0:4b7:2382:b4 with SMTP id
 fm11-20020a056122290b00b004b7238200b4mr3819870vkb.6.1707972333248; Wed, 14
 Feb 2024 20:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20240109002554.646572-1-atishp@rivosinc.com>
 <20240109002554.646572-6-atishp@rivosinc.com>
In-Reply-To: <20240109002554.646572-6-atishp@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:45:06 +1000
Message-ID: <CAKmqyKNEZB3XrZ=p71cOEbZabpYYRwpDhc3V8HFCY2yE-kxwgw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Atish Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 9, 2024 at 10:29=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
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
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/cpu.h        | 11 +++++
>  target/riscv/cpu_helper.c |  9 +++-
>  target/riscv/csr.c        | 95 ++++++++++++++++++++++++++++++---------
>  target/riscv/pmu.c        | 43 ++++++++++++++++++
>  target/riscv/pmu.h        |  2 +
>  5 files changed, 136 insertions(+), 24 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34617c4c4bab..40d10726155b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -136,6 +136,15 @@ typedef struct PMUCTRState {
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
> @@ -334,6 +343,8 @@ struct CPUArchState {
>      /* PMU event selector configured values for RV32 */
>      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>
> +    PMUFixedCtrState pmu_fixed_ctrs[2];
> +
>      target_ulong sscratch;
>      target_ulong mscratch;
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e7e23b34f455..3dddb1b433e8 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -715,8 +715,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_u=
long newpriv)
>  {
>      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
>
> -    if (icount_enabled() && newpriv !=3D env->priv) {
> -        riscv_itrigger_update_priv(env);
> +    if (newpriv !=3D env->priv) {
> +        if (icount_enabled()) {
> +            riscv_itrigger_update_priv(env);
> +            riscv_pmu_icount_update_priv(env, newpriv);
> +        } else {
> +            riscv_pmu_cycle_update_priv(env, newpriv);
> +        }
>      }
>      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>      env->priv =3D newpriv;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 3bd4aa22374f..307d052021c5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -782,32 +782,16 @@ static int write_vcsr(CPURISCVState *env, int csrno=
, target_ulong val)
>      return RISCV_EXCP_NONE;
>  }
>
> +#if defined(CONFIG_USER_ONLY)
>  /* User Timers and Counters */
>  static target_ulong get_ticks(bool shift)
>  {
> -    int64_t val;
> -    target_ulong result;
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (icount_enabled()) {
> -        val =3D icount_get();
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
> @@ -932,6 +916,70 @@ static int write_mhpmeventh(CPURISCVState *env, int =
csrno, target_ulong val)
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
> +    uint64_t curr_val =3D 0;
> +    target_ulong result =3D 0;
> +    uint64_t *counter_arr =3D icount_enabled() ? env->pmu_fixed_ctrs[1].=
counter :
> +                            env->pmu_fixed_ctrs[0].counter;

I don't follow why we access different arrays depending if
icount_enabled(). Can we at least comment this?

Alistair

> +    uint64_t *counter_arr_virt =3D icount_enabled() ?
> +                                 env->pmu_fixed_ctrs[1].counter_virt :
> +                                 env->pmu_fixed_ctrs[0].counter_virt;
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
> +    }
> +
> +    if (!cfg_val) {
> +        if (icount_enabled()) {
> +            curr_val =3D icount_get_raw();
> +        } else {
> +            curr_val =3D cpu_get_host_ticks();
> +        }
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
>  static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong=
 val)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLE;
> @@ -941,7 +989,8 @@ static int write_mhpmcounter(CPURISCVState *env, int =
csrno, target_ulong val)
>      counter->mhpmcounter_val =3D val;
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounter_prev =3D get_ticks(false);
> +        counter->mhpmcounter_prev =3D riscv_pmu_ctr_get_fixed_counters_v=
al(env,
> +                                                                ctr_idx,=
 false);
>          if (ctr_idx > 2) {
>              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>                  mhpmctr_val =3D mhpmctr_val |
> @@ -968,7 +1017,8 @@ static int write_mhpmcounterh(CPURISCVState *env, in=
t csrno, target_ulong val)
>      mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounterh_prev =3D get_ticks(true);
> +        counter->mhpmcounterh_prev =3D riscv_pmu_ctr_get_fixed_counters_=
val(env,
> +                                                                 ctr_idx=
, true);
>          if (ctr_idx > 2) {
>              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>          }
> @@ -1009,7 +1059,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVSt=
ate *env, target_ulong *val,
>       */
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val =3D get_ticks(upper_half) - ctr_prev + ctr_val;
> +        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, uppe=
r_half) -
> +                                                    ctr_prev + ctr_val;
>      } else {
>          *val =3D ctr_val;
>      }
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 0e7d58b8a5c2..8b6cc4c6bb4d 100644
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
> @@ -176,6 +177,48 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, ui=
nt32_t ctr_idx)
>      return 0;
>  }
>
> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpr=
iv)
> +{
> +    uint64_t delta;
> +    uint64_t *counter_arr;
> +    uint64_t *counter_arr_prev;
> +    uint64_t current_icount =3D icount_get_raw();
> +
> +    if (env->virt_enabled) {
> +        counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
> +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        counter_arr =3D env->pmu_fixed_ctrs[1].counter;
> +        counter_arr_prev =3D env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +    counter_arr_prev[newpriv] =3D current_icount;
> +    delta =3D current_icount - counter_arr_prev[env->priv];
> +
> +    counter_arr[env->priv] +=3D delta;
> +}
> +
> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpri=
v)
> +{
> +    uint64_t delta;
> +    uint64_t *counter_arr;
> +    uint64_t *counter_arr_prev;
> +    uint64_t current_host_ticks =3D cpu_get_host_ticks();
> +
> +    if (env->virt_enabled) {
> +        counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
> +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        counter_arr =3D env->pmu_fixed_ctrs[0].counter;
> +        counter_arr_prev =3D env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    counter_arr_prev[newpriv] =3D current_host_ticks;
> +    delta =3D current_host_ticks - counter_arr_prev[env->priv];
> +
> +    counter_arr[env->priv] +=3D delta;
> +}
> +
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx=
)
>  {
>      uint32_t ctr_idx;
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 505fc850d38e..50de6031a730 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_ev=
ent_idx event_idx);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_na=
me);
>  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                            uint32_t ctr_idx);
> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpr=
iv);
> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpri=
v);
> --
> 2.34.1
>
>

