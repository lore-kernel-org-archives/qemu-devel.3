Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F9C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisVH-0002Pr-02; Tue, 27 Aug 2024 05:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sisVF-0002OA-EB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:28:41 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sisVC-0005jQ-N1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:28:41 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f502086419so30721211fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1724750915; x=1725355715; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHfwPA8/9TTyAajnzUJrm8JSwIPQxcY4x0ckQ5uLFX0=;
 b=Uo5d3tlMJ8KETH9GaZw9i1GK2wNBQHHO7MSL4DE3cug9PKxF8o71NXwFWc2gXTI/Tm
 nEkgT81eRTMEPZAPyT/jF8/Mfy5sMOlB0Kjl47FBVYZ9DF3tluS538SNXLTzlLpB2UX3
 l5do2tFnc929mcTt3HWWNbFlbT3KMPrOL7BfqqllFDE1h5mxi9iYrhL0MlNUo9wCsfVI
 QLizAwRv1wpGF1E3qbfOgUUJ5qow8AFJIF1t/1Gs37oIcVj+/QpmaUVm98Nl7ImKoRtr
 tw6CLQkLonxd+yBiHlySAhgylZo0yP1nMgXAIuGPR0OJTcYcUTTVtoU2XuN6XSK8uBRg
 MCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724750915; x=1725355715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dHfwPA8/9TTyAajnzUJrm8JSwIPQxcY4x0ckQ5uLFX0=;
 b=mdHld9+lI9TyjPwromV6C896jWqHImLJslj2uD1tBInwNTl1BlDK86SaxiZ69PtaP3
 lhOG9cmXd1vNQ0SE+ter+DOYun/OrY9eTj6aD+0qMJoHNRSFm+bw8BHDIfqKkl4/N83H
 3VyqzbXuquPQwaDUF9yB4tqTKt1+wcK9UdYG/z9Zp9rwyTDcaUqdMg8zEwBIXobvdZ++
 fn+l/T2oeyxlNMm8yB+QQFl4N5aFl/k+qDWEg63e8G9DEJpfoDhKhx+bYsBG52iKIKoo
 LYmxuSONBnEATtD6HIjCbKOF1Y/3nqBzFVI8Awrwim2MUCCYHB5dXSIUx5CULB7GklSj
 yPUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbal2ROerXQUBstDgIbfQ9cKfN674WvN0rWFml9I6QtnEs8FjJ87oBK01yATviYkWJb6FQWftkk7iX@nongnu.org
X-Gm-Message-State: AOJu0YxSzQuJ9/wtCYa/HbYpGUqHwQjjaXNv+NvLvV56r0H/91Mq0s45
 Q0u7RBcRkZ1K/VZorGLZdnkuquuCm7shfvcWWc25engx9bn3NQJJRlBujKrtnTU=
X-Google-Smtp-Source: AGHT+IF1VLi9XWxJy4giA/W59YMQojiddl+JTKk1MwfwLmGe8M8yxA4Va8crqwCFXyiBQ7YYnK1/PQ==
X-Received: by 2002:a2e:90ca:0:b0:2f3:f4db:9119 with SMTP id
 38308e7fff4ca-2f4f49169femr78036721fa.22.1724750915425; 
 Tue, 27 Aug 2024 02:28:35 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f40487f949sm15557611fa.111.2024.08.27.02.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 02:28:34 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5334879ba28so6627464e87.3; 
 Tue, 27 Aug 2024 02:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+G9V/xaOpOKaZnfrOP1O6IAnTD33XKYHzMtOiNWFRNRZqf6bcCagXuyoQl7SlVHGdDVqo+bh7NK8h@nongnu.org
X-Received: by 2002:a05:6512:238b:b0:533:6f3:9844 with SMTP id
 2adb3069b0e04-5343875fdb6mr8869664e87.11.1724750914128; Tue, 27 Aug 2024
 02:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-4-rkanwal@rivosinc.com>
In-Reply-To: <20240619152708.135991-4-rkanwal@rivosinc.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 27 Aug 2024 17:28:21 +0800
X-Gmail-Original-Message-ID: <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
Message-ID: <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Rajnesh Kanwal <rkanwal@rivosinc.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> sctrdepth CSRs handling.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  target/riscv/cpu.h     |   5 ++
>  target/riscv/cpu_cfg.h |   2 +
>  target/riscv/csr.c     | 128 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a185e2d494..3d4d5172b8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -263,6 +263,11 @@ struct CPUArchState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    uint64_t mctrctl;
> +    uint32_t sctrdepth;
> +    uint32_t sctrstatus;
> +    uint64_t vsctrctl;
> +
>      /* Machine and Supervisor interrupt priorities */
>      uint8_t miprio[64];
>      uint8_t siprio[64];
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index d9354dc80a..d329a65811 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
>      bool ext_zvfhmin;
>      bool ext_smaia;
>      bool ext_ssaia;
> +    bool ext_smctr;
> +    bool ext_ssctr;

Base on: https://github.com/riscv/riscv-control-transfer-records/pull/29
Smctr and Ssctr depend on both S-mode and Sscsrind.
We should add the implied rules for Smctr and Ssctr.

Regards,
Frank Chang


>      bool ext_sscofpmf;
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 2f92e4b717..0b5bf4d050 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -621,6 +621,48 @@ static RISCVException pointer_masking(CPURISCVState =
*env, int csrno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> +/*
> + * M-mode:
> + * Without ext_smctr raise illegal inst excep.
> + * Otherwise everything is accessible to m-mode.
> + *
> + * S-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Otherwise everything other than mctrctl is accessible.
> + *
> + * VS-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Without hstateen.ctr raise virtual illegal inst excep.
> + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entry ran=
ge.
> + * Always raise illegal instruction exception for sctrdepth.
> + */
> +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
> +{
> +    /* Check if smctr-ext is present */
> +    if (riscv_cpu_cfg(env)->ext_smctr) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
> +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> +{
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> +
> +    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
> +        env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return ret;
> +}
> +
>  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>  {
>      int ret;
> @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVState *en=
v, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong w=
r_mask)
> +{
> +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->sctrdepth;
> +    }
> +
> +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
> +
> +    /* Correct depth. */
> +    if (wr_mask & SCTRDEPTH_MASK) {
> +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +
> +        if (depth > SCTRDEPTH_MAX) {
> +            depth =3D SCTRDEPTH_MAX;
> +            env->sctrdepth =3D set_field(env->sctrdepth, SCTRDEPTH_MASK,=
 depth);
> +        }
> +
> +        /* Update sctrstatus.WRPTR with a legal value */
> +        depth =3D 16 << depth;
> +        env->sctrstatus =3D
> +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> +                                     target_ulong *ret_val,
> +                                     target_ulong new_val, target_ulong =
wr_mask)
> +{
> +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->sctrstatus;
> +    }
> +
> +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask);
> +
> +    /* Update sctrstatus.WRPTR with a legal value */
> +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (dep=
th - 1));
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong w=
r_mask)
> +{
> +    uint64_t csr_mask, mask =3D wr_mask;
> +    uint64_t *ctl_ptr =3D &env->mctrctl;
> +
> +    if (csrno =3D=3D CSR_MCTRCTL) {
> +        csr_mask =3D MCTRCTL_MASK;
> +    } else if (csrno =3D=3D CSR_SCTRCTL && !env->virt_enabled) {
> +        csr_mask =3D SCTRCTL_MASK;
> +    } else {
> +        /*
> +         * This is for csrno =3D=3D CSR_SCTRCTL and env->virt_enabled =
=3D=3D true
> +         * or csrno =3D=3D CSR_VSCTRCTL.
> +         */
> +        csr_mask =3D VSCTRCTL_MASK;
> +        ctl_ptr =3D &env->vsctrctl;
> +    }
> +
> +    mask &=3D csr_mask;
> +
> +    if (ret_val) {
> +        *ret_val =3D *ctl_ptr & csr_mask;
> +    }
> +
> +    *ctl_ptr =3D (*ctl_ptr & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
>                                    target_ulong *val)
>  {
> @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
>                           write_spmbase                                  =
    },
>
> +    [CSR_MCTRCTL]    =3D { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xct=
rctl },
> +    [CSR_SCTRCTL]    =3D { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xct=
rctl },
> +    [CSR_VSCTRCTL]   =3D { "vsctrctl",   ctr_smode,  NULL, NULL, rmw_xct=
rctl },
> +    [CSR_SCTRDEPTH]  =3D { "sctrdepth",  ctr_smode,  NULL, NULL, rmw_sct=
rdepth },
> +    [CSR_SCTRSTATUS] =3D { "sctrstatus", ctr_smode,  NULL, NULL, rmw_sct=
rstatus },
> +
>      /* Performance Counters */
>      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmcounter=
 },
>      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmcounter=
 },
> --
> 2.34.1
>
>

