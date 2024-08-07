Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbPi-0003Gm-LE; Wed, 07 Aug 2024 03:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbPZ-0002u4-Ci
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:48:47 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbPV-0002c2-SM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:48:44 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso22289331fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723016920; x=1723621720;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNyLFxTNZOCGzmoUjhL3DMGVo1ZMXsuEE4+z1mw+PQ4=;
 b=ADLKvTs6+y/l69A/sYAXkSDbJ/kHqJVDzNJQBcO9+Wo+M3Q3e40ViPebHAUlY7MepN
 nObdIcF8avTF1g+ktVaN5QrjmfFUSq+wl8sXAw2uu1T6svXBWAKlnlf+PeZcZbLv3ojw
 zXFjTtnoFYZ1KhDTy2X1kyoMW02DAVIUGVGhnKCs2iumzJBss1dJKTqlqx61iHTKNr0X
 qlfYLXnVGlpP1J+rOUyvBpc/mm4BeAMmy3vS6VmY2v/E+PHlemyHfaIuqUO7U20mZauo
 AQhHogWg9BrwxF/6elOv8YihufJf1JPhebMjcZXdpcH6vYAJt7VTe25C/LBtw6Ilp+Lh
 VH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723016920; x=1723621720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNyLFxTNZOCGzmoUjhL3DMGVo1ZMXsuEE4+z1mw+PQ4=;
 b=vyBaFt+ZD3jsgKl8Xqbiz97oFxxKadZaw6bB6Jr4q3RqGxaKcvFG57XgC5lHj9iTsf
 tW6ZF9unOyx086HsAAFxkXcoMcBQCqSVKunlUC3Wxq3DuYKU4JGE6+y6Ud9a+bJjHJ0M
 uR56jj9QOmH8n4aoxiDXPiVgPe9GhiMcWeB2AWgFl9w0fjHiPwrmUDg1UCUwBY4lfR2O
 IKSb4Xj59e8/fCS1i4WLr/bFiIMeI711aec7iOT10KqzsyoET0LinIyCgCXrE77pU1G5
 0lPSNTqlHaX05l0oLNt8BkOslWWYg4OaozWlbPpmoF5p+QBwJZhSGJW8NrWuQHrt8q60
 PMJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXupgYECG60R4ZjAZpSjssAnbpQ1nkmXiL9KIhP4vh7qQOnlqiLN8wYy+fpmaxE9ql2wBJeZ2+oixWYwLRyrUpApwj7UcI=
X-Gm-Message-State: AOJu0YyHBxHi8WUVckEDFFTUUOPt0/q6YWR3TRLhmtwdmPSVyNPVUFD/
 pgReU8fF3i1tS1ObglGI3cThDBMpSwXvSsMIWLIcrl0LVU9nSDbj+RSlhfd6AMlykJLrU+s7nYx
 39wPBMrQPKmHgtt+j5maKriFdLEiKvEv3WDQoUg==
X-Google-Smtp-Source: AGHT+IGMkt/JWO/0WchbGEm094rGe12qKTA/JMaDNUcTi/lROKd1SDE99BsDs8d90RWIZ2ikW95Cu/XefIxTKfFi/RY=
X-Received: by 2002:a2e:968c:0:b0:2ef:2525:be90 with SMTP id
 38308e7fff4ca-2f15aaf6231mr131489801fa.31.1723016898725; Wed, 07 Aug 2024
 00:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-7-c4170a5348ca@rivosinc.com>
 <CAKmqyKOCta5Dn_QLWQGa8b80dkbC+YJbooWHKw1vej7jWyFtcQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOCta5Dn_QLWQGa8b80dkbC+YJbooWHKw1vej7jWyFtcQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 7 Aug 2024 00:48:08 -0700
Message-ID: <CAHBxVyHBJCfbhwPXHQw7gqwdR-ODomrgx3NYT-fU022oPsnbsA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] target/riscv: Add counter
 delegation/configuration support
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Aug 5, 2024 at 6:21=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Jul 24, 2024 at 9:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > The Smcdeleg/Ssccfg adds the support for counter delegation via
> > S*indcsr and Ssccfg.
> >
> > It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE=
)
> > to enable this extension and scountovf virtualization.
> >
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  target/riscv/csr.c | 302 +++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 290 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index da27ba1b7580..2369a746a285 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -366,6 +366,21 @@ static RISCVException aia_smode32(CPURISCVState *e=
nv, int csrno)
> >      return smode32(env, csrno);
> >  }
> >
> > +static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno=
)
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    if (env->virt_enabled) {
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> > +    return smode(env, csrno);
> > +}
> > +
> >  static bool csrind_extensions_present(CPURISCVState *env)
> >  {
> >      return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext=
_sscsrind;
> > @@ -1190,10 +1205,9 @@ done:
> >      return result;
> >  }
> >
> > -static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> > -                                        target_ulong val)
> > +static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_u=
long val,
> > +                                          uint32_t ctr_idx)
> >  {
> > -    int ctr_idx =3D csrno - CSR_MCYCLE;
> >      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> >      uint64_t mhpmctr_val =3D val;
> >
> > @@ -1218,10 +1232,9 @@ static RISCVException write_mhpmcounter(CPURISCV=
State *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > -static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno=
,
> > -                                         target_ulong val)
> > +static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_=
ulong val,
> > +                                          uint32_t ctr_idx)
> >  {
> > -    int ctr_idx =3D csrno - CSR_MCYCLEH;
> >      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> >      uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
> >      uint64_t mhpmctrh_val =3D val;
> > @@ -1243,6 +1256,20 @@ static RISCVException write_mhpmcounterh(CPURISC=
VState *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulo=
ng val)
> > +{
> > +    int ctr_idx =3D csrno - CSR_MCYCLE;
> > +
> > +    return riscv_pmu_write_ctr(env, val, ctr_idx);
> > +}
> > +
> > +static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ul=
ong val)
> > +{
> > +    int ctr_idx =3D csrno - CSR_MCYCLEH;
> > +
> > +    return riscv_pmu_write_ctrh(env, val, ctr_idx);
> > +}
> > +
> >  RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *va=
l,
> >                                           bool upper_half, uint32_t ctr=
_idx)
> >  {
> > @@ -1308,6 +1335,167 @@ static RISCVException read_hpmcounterh(CPURISCV=
State *env, int csrno,
> >      return riscv_pmu_read_ctr(env, val, true, ctr_index);
> >  }
> >
> > +static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
> > +                              target_ulong *val, target_ulong new_val,
> > +                              target_ulong wr_mask)
> > +{
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        riscv_pmu_read_ctr(env, val, false, ctr_idx);
> > +    } else if (wr_mask) {
> > +        riscv_pmu_write_ctr(env, new_val, ctr_idx);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
> > +                               target_ulong *val, target_ulong new_val=
,
> > +                               target_ulong wr_mask)
> > +{
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        riscv_pmu_read_ctr(env, val, true, ctr_idx);
>
> riscv_pmu_write_ctrh?
>

My bad. Copy paste error. Thanks for pointing that out.

> Alistair
>
> > +    } else if (wr_mask) {
> > +        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> > +                            target_ulong *val, target_ulong new_val,
> > +                            target_ulong wr_mask)
> > +{
> > +    uint64_t mhpmevt_val =3D new_val;
> > +
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        *val =3D env->mhpmevent_val[evt_index];
> > +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> > +            *val &=3D ~MHPMEVENT_BIT_MINH;
> > +        }
> > +    } else if (wr_mask) {
> > +        wr_mask &=3D ~MHPMEVENT_BIT_MINH;
> > +        mhpmevt_val =3D (new_val & wr_mask) |
> > +                      (env->mhpmevent_val[evt_index] & ~wr_mask);
> > +        if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +            mhpmevt_val =3D mhpmevt_val |
> > +                          ((uint64_t)env->mhpmeventh_val[evt_index] <<=
 32);
> > +        }
> > +        env->mhpmevent_val[evt_index] =3D mhpmevt_val;
> > +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> > +                             target_ulong *val, target_ulong new_val,
> > +                             target_ulong wr_mask)
> > +{
> > +    uint64_t mhpmevth_val;
> > +    uint64_t mhpmevt_val =3D env->mhpmevent_val[evt_index];
> > +
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        *val =3D env->mhpmeventh_val[evt_index];
> > +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> > +            *val &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +    } else if (wr_mask) {
> > +        wr_mask &=3D ~MHPMEVENTH_BIT_MINH;
> > +        env->mhpmeventh_val[evt_index] =3D
> > +            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~w=
r_mask);
> > +        mhpmevth_val =3D env->mhpmeventh_val[evt_index];
> > +        mhpmevt_val =3D mhpmevt_val | (mhpmevth_val << 32);
> > +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ul=
ong *val,
> > +                            target_ulong new_val, target_ulong wr_mask=
)
> > +{
> > +    switch (cfg_index) {
> > +    case 0:             /* CYCLECFG */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MCYCLECFG_BIT_MINH;
> > +            env->mcyclecfg =3D (new_val & wr_mask) | (env->mcyclecfg &=
 ~wr_mask);
> > +        } else {
> > +            *val =3D env->mcyclecfg &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +        break;
> > +    case 2:             /* INSTRETCFG */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MINSTRETCFG_BIT_MINH;
> > +            env->minstretcfg =3D (new_val & wr_mask) |
> > +                               (env->minstretcfg & ~wr_mask);
> > +        } else {
> > +            *val =3D env->minstretcfg &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +        break;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_u=
long *val,
> > +                            target_ulong new_val, target_ulong wr_mask=
)
> > +{
> > +
> > +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    switch (cfg_index) {
> > +    case 0:         /* CYCLECFGH */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MCYCLECFGH_BIT_MINH;
> > +            env->mcyclecfgh =3D (new_val & wr_mask) |
> > +                              (env->mcyclecfgh & ~wr_mask);
> > +        } else {
> > +            *val =3D env->mcyclecfgh;
> > +        }
> > +        break;
> > +    case 2:          /* INSTRETCFGH */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MINSTRETCFGH_BIT_MINH;
> > +            env->minstretcfgh =3D (new_val & wr_mask) |
> > +                                (env->minstretcfgh & ~wr_mask);
> > +        } else {
> > +            *val =3D env->minstretcfgh;
> > +        }
> > +        break;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +
> >  static RISCVException read_scountovf(CPURISCVState *env, int csrno,
> >                                       target_ulong *val)
> >  {
> > @@ -1317,6 +1505,14 @@ static RISCVException read_scountovf(CPURISCVSta=
te *env, int csrno,
> >      target_ulong *mhpm_evt_val;
> >      uint64_t of_bit_mask;
> >
> > +    /* Virtualize scountovf for counter delegation */
> > +    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> > +        riscv_cpu_cfg(env)->ext_ssccfg &&
> > +        get_field(env->menvcfg, MENVCFG_CDE) &&
> > +        env->virt_enabled) {
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> >      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >          mhpm_evt_val =3D env->mhpmeventh_val;
> >          of_bit_mask =3D MHPMEVENTH_BIT_OF;
> > @@ -2254,11 +2450,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int=
 csrno,
> >                          target_ulong isel, target_ulong *val,
> >                          target_ulong new_val, target_ulong wr_mask)
> >  {
> > -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> > +    int ret =3D -EINVAL;
> > +    int ctr_index =3D isel - ISELECT_CD_FIRST;
> > +    int isel_hpm_start =3D ISELECT_CD_FIRST + 3;
> > +
> > +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_=
ssccfg) {
> >          return RISCV_EXCP_ILLEGAL_INST;
> >      }
> > -    /* TODO: Implement the functionality later */
> > -    return RISCV_EXCP_NONE;
> > +
> > +    /* Invalid siselect value for reserved */
> > +    if (ctr_index =3D=3D 1) {
> > +        goto done;
> > +    }
> > +
> > +    /* sireg4 and sireg5 provides access RV32 only CSRs */
> > +    if (((csrno =3D=3D CSR_SIREG5) || (csrno =3D=3D CSR_SIREG4)) &&
> > +        (riscv_cpu_mxl(env) !=3D MXL_RV32)) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    /* Check Sscofpmf dependancy */
> > +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno =3D=3D CSR_SIREG5 &=
&
> > +        (isel_hpm_start <=3D isel && isel <=3D ISELECT_CD_LAST)) {
> > +        goto done;
> > +    }
> > +
> > +    /* Check smcntrpmf dependancy */
> > +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
> > +        (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_SIREG5) &&
> > +        (ISELECT_CD_FIRST <=3D isel && isel < isel_hpm_start)) {
> > +        goto done;
> > +    }
> > +
> > +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
> > +        !get_field(env->menvcfg, MENVCFG_CDE)) {
> > +        goto done;
> > +    }
> > +
> > +    switch (csrno) {
> > +    case CSR_SIREG:
> > +        ret =3D rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_ma=
sk);
> > +        break;
> > +    case CSR_SIREG4:
> > +        ret =3D rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_m=
ask);
> > +        break;
> > +    case CSR_SIREG2:
> > +        if (ctr_index <=3D 2) {
> > +            ret =3D rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_ma=
sk);
> > +        } else {
> > +            ret =3D rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_=
mask);
> > +        }
> > +        break;
> > +    case CSR_SIREG5:
> > +        if (ctr_index <=3D 2) {
> > +            ret =3D rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_m=
ask);
> > +        } else {
> > +            ret =3D rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr=
_mask);
> > +        }
> > +        break;
> > +    default:
> > +        goto done;
> > +    }
> > +
> > +done:
> > +    return ret;
> >  }
> >
> >  /*
> > @@ -2540,6 +2795,21 @@ static RISCVException write_mcountinhibit(CPURIS=
CVState *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static RISCVException read_scountinhibit(CPURISCVState *env, int csrno=
,
> > +                                         target_ulong *val)
> > +{
> > +    /* S-mode can only access the bits delegated by M-mode */
> > +    *val =3D env->mcountinhibit & env->mcounteren;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException write_scountinhibit(CPURISCVState *env, int csrn=
o,
> > +                                          target_ulong val)
> > +{
> > +    write_mcountinhibit(env, csrno, val & env->mcounteren);
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >  static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
> >                                        target_ulong *val)
> >  {
> > @@ -2642,12 +2912,14 @@ static RISCVException write_menvcfg(CPURISCVSta=
te *env, int csrno,
> >                                      target_ulong val)
> >  {
> >      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > -    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | ME=
NVCFG_CBZE;
> > +    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> > +                    MENVCFG_CBZE | MENVCFG_CDE;
> >
> >      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> >                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> > -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> > +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> > +                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
> >      }
> >      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> >
> > @@ -2667,7 +2939,8 @@ static RISCVException write_menvcfgh(CPURISCVStat=
e *env, int csrno,
> >      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >      uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> >                      (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> > -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> > +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> > +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
> >      uint64_t valh =3D (uint64_t)val << 32;
> >
> >      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> > @@ -5417,6 +5690,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >                          write_sstateen_1_3,
> >                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> >
> > +    /* Supervisor Counter Delegation */
> > +    [CSR_SCOUNTINHIBIT] =3D {"scountinhibit", scountinhibit_pred,
> > +                            read_scountinhibit, write_scountinhibit,
> > +                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> > +
> >      /* Supervisor Trap Setup */
> >      [CSR_SSTATUS]    =3D { "sstatus",    smode, read_sstatus,    write=
_sstatus,
> >                           NULL,                read_sstatus_i128       =
       },
> >
> > --
> > 2.34.1
> >
> >

