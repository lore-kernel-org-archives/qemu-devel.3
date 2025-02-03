Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A59EC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 01:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1telTX-0001hH-Il; Sun, 02 Feb 2025 20:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1telTT-0001ga-7D; Sun, 02 Feb 2025 20:42:07 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1telTR-0001EZ-8p; Sun, 02 Feb 2025 20:42:06 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51873bc7377so1319709e0c.1; 
 Sun, 02 Feb 2025 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738546924; x=1739151724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZ5segUCMqRvryeQqSz/VY8Dtx4LI8ARxAROELQa2Eg=;
 b=Kha7K/FKZH8EAC9ICHFzdFkpTTdWu1GqKRDDuRdVKHVLAQbSbgBZ4VGTnxofe2H15I
 4cTO5KZpfUWcvhTyjRcnk5dLiwonriMt0idgmP0whfh/z9TpHpVzqvPp3gjpBotEoSa2
 EbF/82SGKBLh080pfmaL4d+8C2hVN8zzK7p8Z5CP0dJ+ynnyAXDBSa+OW3v8TbEt1R1X
 5KaxnSmIAFRQtPtW54oZyANzdzD1E1WRTcqtJEAwAA/y5QwvtcGal1xywRLAPw573kVy
 lyBtRAqjaDKX+IeT4bqb+HFDr05HWKiynhB6WuxE106Pu6mbwlGqiTvI68hwa3YiPOFS
 eXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738546924; x=1739151724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZ5segUCMqRvryeQqSz/VY8Dtx4LI8ARxAROELQa2Eg=;
 b=ovLNeaEP3Vw0o6RJutwatRvGbTp/SMp3yxO1EVGligfNqgYcm44m0NJZG+wC636bsb
 d5Kw+6+MqPFrrHppVV5HaZZ/muH5Yh6xlYmGUkN5zQDWWg+Qc8i15904LmUNphWEw47s
 tlCibILeUdmgnimqtkgRhdxjlmhMpiw1qyLDI6uHrsrtqof6yxztps8GoizWVAcVI2th
 2Y7KDtPErtk/otBWfNkTbgNAuC5tG+bddhf1SnLtl9Bxpbljz3YKlWnAlQyW58uyPykP
 Gd7NRHh9F7p8FDm+7h+J50x76ghIxqIpLISb6rJrghmrTKtuMy1VaESOvWjwwwudZuBA
 LGoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuLuwq51vjMQ0rzzX0xB1GGJef4FoL/uzbPOZyjy6qbSAxVgpLYB6uu4RBI5TbN5AVxvlWFy7V1bJW@nongnu.org
X-Gm-Message-State: AOJu0YyWIBTVMOW30gJYiHpciM5tXvqLi+THv5dX0ZwK/3oBIFNMQ2Wz
 e/fRXIcNX4aJqdvSJgWpto9+b6n1UjjADIEmMjXxWxmU5pWEkYLqnlrgH1okjCQ/mtAFZsxKd6t
 UOWnwH98HXyt5mqmReaM4h+EN6a8=
X-Gm-Gg: ASbGncuH7je2gB49r6GkLihv8eVDJvIx60R3I3GyGUqrHzBkAYLfvIMxKcQuv+sVfOI
 PpxvRZ/lyzYXDvLHc3itM0SRYwfGtkySExTaXw858tAD7j1ovN5/m+Ilyaw0P2eCnnDe67EfydL
 38KWwLI5t8mlUmhiwVzQ+lBka5yg==
X-Google-Smtp-Source: AGHT+IFVtJqNP2/XhUZtIba+nsl4BNS76dDz7veQxKpSs9seWL1dHUOB6maMoqPEpyHIXzR9dIiw1fXS6Qi0Bgqe/GU=
X-Received: by 2002:a05:6122:8c6:b0:517:4e40:6838 with SMTP id
 71dfb90a1353d-51e9e3f8c8cmr15572452e0c.6.1738546923636; Sun, 02 Feb 2025
 17:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-3-60b993aa567d@rivosinc.com>
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-3-60b993aa567d@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 11:41:37 +1000
X-Gm-Features: AWEUYZlGmnJYJ0Qu0kMw5Kv5fW-foWw9XSL1PIx5DlgiNjCzkdtgwLFbdX0eN88
Message-ID: <CAKmqyKNyDFc=s2XDVa8h=F6tgE=YHsNo1XjpprN8O0wYH1K7Vg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> sctrdepth CSRs handling.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |   5 ++
>  target/riscv/cpu_cfg.h |   2 +
>  target/riscv/csr.c     | 144 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 151 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 903268626374474306f0e0259f37128326b354d4..da14ac2f874b81d3f01bc31b0=
064d020f2dbdf61 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -305,6 +305,11 @@ struct CPUArchState {
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
> index ae2b019703fe4849eb7f264b4d90743d4c013b86..e365a368d71a695b1b99c3b6a=
e330347143d3422 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -130,6 +130,8 @@ struct RISCVCPUConfig {
>      bool ext_zvfhmin;
>      bool ext_smaia;
>      bool ext_ssaia;
> +    bool ext_smctr;
> +    bool ext_ssctr;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a77b6ed4c9f35fe25f0901c290cac8a666a48c27..a399d55740c7259cd1c1d8936=
87541e23ea3ce52 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -649,6 +649,48 @@ static RISCVException pointer_masking(CPURISCVState =
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
> @@ -3157,6 +3199,10 @@ static RISCVException write_mstateen0(CPURISCVStat=
e *env, int csrno,
>          wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_ssctr) {
> +        wr_mask |=3D SMSTATEEN0_CTR;
> +    }
> +
>      return write_mstateen(env, csrno, wr_mask, new_val);
>  }
>
> @@ -3196,6 +3242,10 @@ static RISCVException write_mstateen0h(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_ssctr) {
> +        wr_mask |=3D SMSTATEEN0_CTR;
> +    }
> +
>      return write_mstateenh(env, csrno, wr_mask, new_val);
>  }
>
> @@ -3250,6 +3300,10 @@ static RISCVException write_hstateen0(CPURISCVStat=
e *env, int csrno,
>          wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_ssctr) {
> +        wr_mask |=3D SMSTATEEN0_CTR;
> +    }
> +
>      return write_hstateen(env, csrno, wr_mask, new_val);
>  }
>
> @@ -3289,6 +3343,10 @@ static RISCVException write_hstateen0h(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> +    if (riscv_cpu_cfg(env)->ext_ssctr) {
> +        wr_mask |=3D SMSTATEEN0_CTR;
> +    }
> +
>      return write_hstateenh(env, csrno, wr_mask, new_val);
>  }
>
> @@ -4002,6 +4060,86 @@ static RISCVException write_satp(CPURISCVState *en=
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
> +    if (mask) {
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
> @@ -5981,6 +6119,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
>                           write_spmbase                                  =
    },
>
> +    [CSR_MCTRCTL]    =3D { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xct=
rctl    },
> +    [CSR_SCTRCTL]    =3D { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xct=
rctl    },
> +    [CSR_VSCTRCTL]   =3D { "vsctrctl",   ctr_smode,  NULL, NULL, rmw_xct=
rctl    },
> +    [CSR_SCTRDEPTH]  =3D { "sctrdepth",  ctr_smode,  NULL, NULL, rmw_sct=
rdepth  },
> +    [CSR_SCTRSTATUS] =3D { "sctrstatus", ctr_smode,  NULL, NULL, rmw_sct=
rstatus },
> +
>      /* Performance Counters */
>      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmcounter=
 },
>      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmcounter=
 },
>
> --
> 2.34.1
>
>

