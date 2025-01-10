Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD04E7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 02:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW4LC-0005Vt-0w; Thu, 09 Jan 2025 21:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4LA-0005VA-5T; Thu, 09 Jan 2025 21:01:36 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4L8-0004gS-26; Thu, 09 Jan 2025 21:01:35 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-518808ef4a1so585357e0c.3; 
 Thu, 09 Jan 2025 18:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736474492; x=1737079292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpZQPGGF3RtqwQENlKCtFeSUuWpphgRTymiD04bgYRk=;
 b=T2l5o/RkeHW7zYMvPgqT8CUQbc1pSy3zjwm09HT8qH3y+HIkx+Di4XRWcnvFaxeUnx
 TLFlibLgsjnP+z3DAg/SMEpcYY5g5Dm4X0FXPRUOYIQO8zrYsXGa87pSwewQvD4oLhKf
 T6fMY5c5t70SB+7fAdIBfYdy81/WyFT8tUm7Ws7/HOXnyIXbwCCdfgCy6oV/UzVrXW+F
 FvcjHEuk0qIgcM3SDFX13MMd6Za6J4lJoUjy31TG3gtzzupD6GeZObQ1sTrJSrTzfXsb
 rnulDPet2rjCEitQ1/Y29JN28sou8HfwZL6S+B9t2yA4uiISXOAiKIOCCOyQpEm9xPco
 yZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736474492; x=1737079292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpZQPGGF3RtqwQENlKCtFeSUuWpphgRTymiD04bgYRk=;
 b=YFMh48P2rB5uHNrlG/UnEviMIZK8+QzTQlwoL3ylkLDOAV7jpffWKHbhaGBX0kcyH4
 uVdTjQCa7Xe8Ms9v82diZ3BQHml57naeLnvBpMCjQnVK/S4v8Ean1yOaJkH9POX7nyDX
 SlcWx4t2SIyE35JOy5k7cdajVQ/RGwLXQFs5GRt71QGUTTM02bBVZtoFsLXbaJhmtkke
 Gxu3rsxjNUeKRMlCgoOBzcx+TqJz8N+0awc7yUOFUIIdVCvCOD2N4H566H3MamAOIiRz
 dsL5fSisrLAt8uA0MUxuPiOcRsgDA6phHwl7TgBAupoagH6XlQmn1svhQIhRHSO/qBC4
 oP1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5WSveDBZoFvK4H1L7T1MMzGuDFvxE3fzkrogtRYAnPNJx8nqPJlpL7R97cww2ATJGDyU5yCau86Hj@nongnu.org
X-Gm-Message-State: AOJu0YwlFhMYsScNxMM/++p63UUxDzihfZXpjagERs6VfZMdEmWtgpOX
 KWGZk8wF+7kCvboZefs/sopvJ94Xaqgy5cov2aA+G6i3ij9es/HIDzMGa32GAAwmobjqLX87+FN
 QFMnAWLSL3DghuFrFFNGX6xuOng0=
X-Gm-Gg: ASbGncun4BfsG/YfmEDlZgwZtrjT9XjWCyoVgAEJbEug2/4rpkRkWX60UVtplIZ5Cll
 r1JSlSkntUcvlCgUnHgNz1cN+bqncr2/o5z9RjAVP5qO9VCiEt+s3GsuYiF28lRlKws4=
X-Google-Smtp-Source: AGHT+IHqFLZi10QPrTwKf8QfkRu/yCBApgXP8ivtmDXx5SoyXCuhUHXXIExkrs69Bgv7zHwZdl8PGQp80nzMgk2Fix4=
X-Received: by 2002:a05:6122:3bd6:b0:515:5008:118b with SMTP id
 71dfb90a1353d-51c6c430258mr7698211e0c.1.1736474490884; Thu, 09 Jan 2025
 18:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-8-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-8-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 12:01:04 +1000
X-Gm-Features: AbW1kvYA7TMDu3HviHAcVe0-MK8pWSuQyqPGPagnNLutpho1Rx_5Te7pDNtQuas
Message-ID: <CAKmqyKO1Gxy5zW9kem1dQ0siQZ7vnouo90uMYP9A37BkjxVO3A@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] target/riscv: Add counter
 delegation/configuration support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Wed, Dec 4, 2024 at 9:16=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> The Smcdeleg/Ssccfg adds the support for counter delegation via
> S*indcsr and Ssccfg.
>
> It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
> to enable this extension and scountovf virtualization.
>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 292 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0985dbdca76d..a77b6ed4c9f3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -383,6 +383,21 @@ static RISCVException aia_smode32(CPURISCVState *env=
, int csrno)
>      return smode32(env, csrno);
>  }
>
> +static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>  static bool csrind_extensions_present(CPURISCVState *env)
>  {
>      return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_s=
scsrind;
> @@ -1220,10 +1235,9 @@ done:
>      return result;
>  }
>
> -static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> -                                        target_ulong val)
> +static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulo=
ng val,
> +                                          uint32_t ctr_idx)
>  {
> -    int ctr_idx =3D csrno - CSR_MCYCLE;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D val;
>
> @@ -1248,10 +1262,9 @@ static RISCVException write_mhpmcounter(CPURISCVSt=
ate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> -                                         target_ulong val)
> +static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ul=
ong val,
> +                                          uint32_t ctr_idx)
>  {
> -    int ctr_idx =3D csrno - CSR_MCYCLEH;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
>      uint64_t mhpmctrh_val =3D val;
> @@ -1273,6 +1286,20 @@ static RISCVException write_mhpmcounterh(CPURISCVS=
tate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong=
 val)
> +{
> +    int ctr_idx =3D csrno - CSR_MCYCLE;
> +
> +    return riscv_pmu_write_ctr(env, val, ctr_idx);
> +}
> +
> +static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulon=
g val)
> +{
> +    int ctr_idx =3D csrno - CSR_MCYCLEH;
> +
> +    return riscv_pmu_write_ctrh(env, val, ctr_idx);
> +}
> +
>  RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                           bool upper_half, uint32_t ctr_i=
dx)
>  {
> @@ -1338,6 +1365,167 @@ static RISCVException read_hpmcounterh(CPURISCVSt=
ate *env, int csrno,
>      return riscv_pmu_read_ctr(env, val, true, ctr_index);
>  }
>
> +static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
> +                              target_ulong *val, target_ulong new_val,
> +                              target_ulong wr_mask)
> +{
> +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        riscv_pmu_read_ctr(env, val, false, ctr_idx);
> +    } else if (wr_mask) {
> +        riscv_pmu_write_ctr(env, new_val, ctr_idx);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
> +                               target_ulong *val, target_ulong new_val,
> +                               target_ulong wr_mask)
> +{
> +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        riscv_pmu_read_ctr(env, val, true, ctr_idx);
> +    } else if (wr_mask) {
> +        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> +                            target_ulong *val, target_ulong new_val,
> +                            target_ulong wr_mask)
> +{
> +    uint64_t mhpmevt_val =3D new_val;
> +
> +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        *val =3D env->mhpmevent_val[evt_index];
> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> +            *val &=3D ~MHPMEVENT_BIT_MINH;
> +        }
> +    } else if (wr_mask) {
> +        wr_mask &=3D ~MHPMEVENT_BIT_MINH;
> +        mhpmevt_val =3D (new_val & wr_mask) |
> +                      (env->mhpmevent_val[evt_index] & ~wr_mask);
> +        if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +            mhpmevt_val =3D mhpmevt_val |
> +                          ((uint64_t)env->mhpmeventh_val[evt_index] << 3=
2);
> +        }
> +        env->mhpmevent_val[evt_index] =3D mhpmevt_val;
> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> +                             target_ulong *val, target_ulong new_val,
> +                             target_ulong wr_mask)
> +{
> +    uint64_t mhpmevth_val;
> +    uint64_t mhpmevt_val =3D env->mhpmevent_val[evt_index];
> +
> +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        *val =3D env->mhpmeventh_val[evt_index];
> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> +            *val &=3D ~MHPMEVENTH_BIT_MINH;
> +        }
> +    } else if (wr_mask) {
> +        wr_mask &=3D ~MHPMEVENTH_BIT_MINH;
> +        env->mhpmeventh_val[evt_index] =3D
> +            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_=
mask);
> +        mhpmevth_val =3D env->mhpmeventh_val[evt_index];
> +        mhpmevt_val =3D mhpmevt_val | (mhpmevth_val << 32);
> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulon=
g *val,
> +                            target_ulong new_val, target_ulong wr_mask)
> +{
> +    switch (cfg_index) {
> +    case 0:             /* CYCLECFG */
> +        if (wr_mask) {
> +            wr_mask &=3D ~MCYCLECFG_BIT_MINH;
> +            env->mcyclecfg =3D (new_val & wr_mask) | (env->mcyclecfg & ~=
wr_mask);
> +        } else {
> +            *val =3D env->mcyclecfg &=3D ~MHPMEVENTH_BIT_MINH;
> +        }
> +        break;
> +    case 2:             /* INSTRETCFG */
> +        if (wr_mask) {
> +            wr_mask &=3D ~MINSTRETCFG_BIT_MINH;
> +            env->minstretcfg =3D (new_val & wr_mask) |
> +                               (env->minstretcfg & ~wr_mask);
> +        } else {
> +            *val =3D env->minstretcfg &=3D ~MHPMEVENTH_BIT_MINH;
> +        }
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulo=
ng *val,
> +                            target_ulong new_val, target_ulong wr_mask)
> +{
> +
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    switch (cfg_index) {
> +    case 0:         /* CYCLECFGH */
> +        if (wr_mask) {
> +            wr_mask &=3D ~MCYCLECFGH_BIT_MINH;
> +            env->mcyclecfgh =3D (new_val & wr_mask) |
> +                              (env->mcyclecfgh & ~wr_mask);
> +        } else {
> +            *val =3D env->mcyclecfgh;
> +        }
> +        break;
> +    case 2:          /* INSTRETCFGH */
> +        if (wr_mask) {
> +            wr_mask &=3D ~MINSTRETCFGH_BIT_MINH;
> +            env->minstretcfgh =3D (new_val & wr_mask) |
> +                                (env->minstretcfgh & ~wr_mask);
> +        } else {
> +            *val =3D env->minstretcfgh;
> +        }
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +
>  static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> @@ -1347,6 +1535,14 @@ static RISCVException read_scountovf(CPURISCVState=
 *env, int csrno,
>      target_ulong *mhpm_evt_val;
>      uint64_t of_bit_mask;
>
> +    /* Virtualize scountovf for counter delegation */
> +    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> +        riscv_cpu_cfg(env)->ext_ssccfg &&
> +        get_field(env->menvcfg, MENVCFG_CDE) &&
> +        env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>          mhpm_evt_val =3D env->mhpmeventh_val;
>          of_bit_mask =3D MHPMEVENTH_BIT_OF;
> @@ -2290,11 +2486,72 @@ static int rmw_xireg_cd(CPURISCVState *env, int c=
srno,
>                          target_ulong isel, target_ulong *val,
>                          target_ulong new_val, target_ulong wr_mask)
>  {
> -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> -        return RISCV_EXCP_ILLEGAL_INST;
> +    int ret =3D -EINVAL;
> +    int ctr_index =3D isel - ISELECT_CD_FIRST;
> +    int isel_hpm_start =3D ISELECT_CD_FIRST + 3;
> +
> +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ss=
ccfg) {
> +        ret =3D RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
>      }
> -    /* TODO: Implement the functionality later */
> -    return RISCV_EXCP_NONE;
> +
> +    /* Invalid siselect value for reserved */
> +    if (ctr_index =3D=3D 1) {
> +        goto done;
> +    }
> +
> +    /* sireg4 and sireg5 provides access RV32 only CSRs */
> +    if (((csrno =3D=3D CSR_SIREG5) || (csrno =3D=3D CSR_SIREG4)) &&
> +        (riscv_cpu_mxl(env) !=3D MXL_RV32)) {
> +        ret =3D RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
> +    }
> +
> +    /* Check Sscofpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno =3D=3D CSR_SIREG5 &&
> +        (isel_hpm_start <=3D isel && isel <=3D ISELECT_CD_LAST)) {
> +        goto done;
> +    }
> +
> +    /* Check smcntrpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
> +        (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_SIREG5) &&
> +        (ISELECT_CD_FIRST <=3D isel && isel < isel_hpm_start)) {
> +        goto done;
> +    }
> +
> +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
> +        !get_field(env->menvcfg, MENVCFG_CDE)) {
> +        goto done;
> +    }
> +
> +    switch (csrno) {
> +    case CSR_SIREG:
> +        ret =3D rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask=
);
> +        break;
> +    case CSR_SIREG4:
> +        ret =3D rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mas=
k);
> +        break;
> +    case CSR_SIREG2:
> +        if (ctr_index <=3D 2) {
> +            ret =3D rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask=
);
> +        } else {
> +            ret =3D rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_ma=
sk);
> +        }
> +        break;
> +    case CSR_SIREG5:
> +        if (ctr_index <=3D 2) {
> +            ret =3D rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mas=
k);
> +        } else {
> +            ret =3D rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_m=
ask);
> +        }
> +        break;
> +    default:
> +        goto done;
> +    }
> +
> +done:
> +    return ret;
>  }
>
>  /*
> @@ -2573,6 +2830,21 @@ static RISCVException write_mcountinhibit(CPURISCV=
State *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
> +                                         target_ulong *val)
> +{
> +    /* S-mode can only access the bits delegated by M-mode */
> +    *val =3D env->mcountinhibit & env->mcounteren;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
> +                                          target_ulong val)
> +{
> +    write_mcountinhibit(env, csrno, val & env->mcounteren);
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>  {
> @@ -2675,11 +2947,13 @@ static RISCVException write_menvcfg(CPURISCVState=
 *env, int csrno,
>                                      target_ulong val)
>  {
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> -    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENV=
CFG_CBZE;
> +    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> +                    MENVCFG_CBZE | MENVCFG_CDE;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
>          mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> +                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>
>          if (env_archcpu(env)->cfg.ext_zicfilp) {
> @@ -2708,7 +2982,8 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                      (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
>      uint64_t valh =3D (uint64_t)val << 32;
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> @@ -5493,6 +5768,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                          write_sstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>
> +    /* Supervisor Counter Delegation */
> +    [CSR_SCOUNTINHIBIT] =3D {"scountinhibit", scountinhibit_pred,
> +                            read_scountinhibit, write_scountinhibit,
> +                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> +
>      /* Supervisor Trap Setup */
>      [CSR_SSTATUS]    =3D { "sstatus",    smode, read_sstatus,    write_s=
status,
>                           NULL,                read_sstatus_i128         =
     },
>
> --
> 2.34.1
>
>

