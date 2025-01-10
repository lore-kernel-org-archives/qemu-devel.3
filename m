Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E2EE7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 01:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW3gb-0007hU-H2; Thu, 09 Jan 2025 20:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW3gY-0007go-Kd; Thu, 09 Jan 2025 20:19:38 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW3gW-0008BD-9M; Thu, 09 Jan 2025 20:19:38 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4affab62589so580585137.1; 
 Thu, 09 Jan 2025 17:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736471975; x=1737076775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMaqcdjMxYO5JRkIkm3xXDMYADBrh82ICFUWaGheaqc=;
 b=ao8uIMr/2Y4Jkzt+2unohVUBpvcENfWSduVK0BGu72uZRGtr3iKyb4a7O34c6jZ1+I
 LH89I/6kDjTx2XHjQPhGBpX6F6DG8qhrPjZzbavyTJbTgiqUdRYwmegwQmjcz+OPyGup
 SxxPi4SYzxccQPnovZLUizGOD2EvYy21Tn3TM9wJOm/7AKqTEzhNxHIBDNnyyTocxT3Y
 vkMKG1TMZj2B6c6DKMOUxeOzFeLmln0w+2/9esRIlgFrzFw/Tqcc+kuTOHyv/hrdR5n8
 TrqNxkkkNys6BbDlh/59oq8aJ3zDlW3w2bdblgJUlmRJTB25Vbr9JW0Ohe8ku3vbDn2N
 Z9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736471975; x=1737076775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMaqcdjMxYO5JRkIkm3xXDMYADBrh82ICFUWaGheaqc=;
 b=bR6VTgjVOGpPAITfQHHGMUumO+WTeejAaNzAtq2EBmSUKHDgW16KvRdxA+O0RyU3xb
 XxdPgryvf1yLoj5nvP3Rl6Wz+Rr4x/Otncq0NnPQKTkv7cIwjaP8xEpNhMnhMYf1F+jm
 CR444R/GNrXoC9l+phqTkBPmZ+w9rnDLzE808DRk9Q7rNX+Mi36A/tDte7NeJb55MAXf
 Er5LU9ixjyyWtsAehbPvQOLILuMFJn//zYmAwSaMldoI/YjVOdVq25FxbV/MQHjvwMi7
 yCkDtvXhBZlDudyUnZs0BfsHslnf00WAdkIKdq7lbExFVz4y+bmTFVrm5nyDZaTSDEGn
 qRbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSiqj7hiP4WOS3fxvssRbIgOwPFQ5rqdiEawqdcgsa1gk/vMOsGhsEiTxx1MnVDWvq79Ce2fwhEfT@nongnu.org
X-Gm-Message-State: AOJu0Yy1p5xgxElL5Y/Au7fYyJSlNbm7Z9skfMhYi2XDB/y3uRgDvFwr
 2LVpc+ACbY3l13orpwfFY1LCl77jJEnzw2nPiH1rgd4+V68cjEDzieThlZBu9pmNxQ2ZYUEjWzs
 wDqVFV/WuyXONWEKybIBhgCawigc=
X-Gm-Gg: ASbGncs0Romb3+tE8avmmDR15fpDMfr+ngNm+56tOWbCq0GQK69ldjtXSAwH5K1IaJ0
 1ihKyCChskIIAQIE4IynlBNzONkZ0R/FQqq8oCw69ozmLzFu8naz1z/peEq1avIu+Fks=
X-Google-Smtp-Source: AGHT+IH3KjG0mZzfXKlCEIk0VX2a0Ai76FYkotQR4RDyL/cZrFAOn/vD9R2/s3tZfDBgePMjn6ox1mE8d3Fodh3ZSzo=
X-Received: by 2002:a05:6102:4192:b0:4b2:5ccb:1596 with SMTP id
 ada2fe7eead31-4b3d1069a8bmr9609673137.24.1736471974685; Thu, 09 Jan 2025
 17:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-4-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-4-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 11:19:08 +1000
X-Gm-Features: AbW1kvbSV5_HZjSePNXVk4uBouukIPy_GvMlB7j5JAiVdpb4JUTF1pe0ZGTaWsY
Message-ID: <CAKmqyKOoP9x_nmb3SpM095-Pyq63ooCFicqbD1SBd82p+5VTNQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] target/riscv: Support generic CSR indirect access
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
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

On Wed, Dec 4, 2024 at 9:17=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the indirect access registers required by sscsrind/smcsrind
> and the operations on them. Note that xiselect and xireg are used for
> both AIA and sxcsrind, and the behavior of accessing them depends on
> whether each extension is enabled and the value stored in xiselect.
>
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h |  28 +++++++++-
>  target/riscv/csr.c      | 144 ++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 166 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 385a2c67c24b..e13c5420a251 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -173,6 +173,13 @@
>  #define CSR_MISELECT        0x350
>  #define CSR_MIREG           0x351
>
> +/* Machine Indirect Register Alias */
> +#define CSR_MIREG2          0x352
> +#define CSR_MIREG3          0x353
> +#define CSR_MIREG4          0x355
> +#define CSR_MIREG5          0x356
> +#define CSR_MIREG6          0x357
> +
>  /* Machine-Level Interrupts (AIA) */
>  #define CSR_MTOPEI          0x35c
>  #define CSR_MTOPI           0xfb0
> @@ -222,6 +229,13 @@
>  #define CSR_SISELECT        0x150
>  #define CSR_SIREG           0x151
>
> +/* Supervisor Indirect Register Alias */
> +#define CSR_SIREG2          0x152
> +#define CSR_SIREG3          0x153
> +#define CSR_SIREG4          0x155
> +#define CSR_SIREG5          0x156
> +#define CSR_SIREG6          0x157
> +
>  /* Supervisor-Level Interrupts (AIA) */
>  #define CSR_STOPEI          0x15c
>  #define CSR_STOPI           0xdb0
> @@ -288,6 +302,13 @@
>  #define CSR_VSISELECT       0x250
>  #define CSR_VSIREG          0x251
>
> +/* Virtual Supervisor Indirect Alias */
> +#define CSR_VSIREG2         0x252
> +#define CSR_VSIREG3         0x253
> +#define CSR_VSIREG4         0x255
> +#define CSR_VSIREG5         0x256
> +#define CSR_VSIREG6         0x257
> +
>  /* VS-Level Interrupts (H-extension with AIA) */
>  #define CSR_VSTOPEI         0x25c
>  #define CSR_VSTOPI          0xeb0
> @@ -863,10 +884,13 @@ typedef enum RISCVException {
>  #define ISELECT_IMSIC_EIE63                0xff
>  #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
>  #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
> -#define ISELECT_MASK                       0x1ff
> +#define ISELECT_MASK_AIA                   0x1ff
> +
> +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> +#define ISELECT_MASK_SXCSRIND              0xfff
>
>  /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
> +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
>
>  /* IMSIC bits (AIA) */
>  #define IMSIC_TOPEI_IID_SHIFT              16
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c91a26a52ef6..424e9dbbd4ff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -306,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, =
int csrno)
>      return any32(env, csrno);
>  }
>
> +static RISCVException csrind_any(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcsrind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> @@ -389,6 +398,15 @@ static bool csrind_or_aia_extensions_present(CPURISC=
VState *env)
>      return csrind_extensions_present(env) || aia_extensions_present(env)=
;
>  }
>
> +static RISCVException csrind_smode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>  static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
>  {
>      if (!csrind_or_aia_extensions_present(env)) {
> @@ -417,6 +435,15 @@ static RISCVException hmode32(CPURISCVState *env, in=
t csrno)
>
>  }
>
> +static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>  static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
>  {
>      if (!csrind_or_aia_extensions_present(env)) {
> @@ -2065,7 +2092,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *en=
v, int csrno)
>      case CSR_SISELECT:
>          return CSR_VSISELECT;
>      case CSR_SIREG:
> -        return CSR_VSIREG;
> +    case CSR_SIREG2:
> +    case CSR_SIREG3:
> +    case CSR_SIREG4:
> +    case CSR_SIREG5:
> +    case CSR_SIREG6:
> +        return CSR_VSIREG + (csrno - CSR_SIREG);
>      default:
>          return csrno;
>      };
> @@ -2105,7 +2137,12 @@ static RISCVException rmw_xiselect(CPURISCVState *=
env, int csrno,
>          *val =3D *iselect;
>      }
>
> -    wr_mask &=3D ISELECT_MASK;
> +    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscs=
rind) {
> +        wr_mask &=3D ISELECT_MASK_SXCSRIND;
> +    } else {
> +        wr_mask &=3D ISELECT_MASK_AIA;
> +    }
> +
>      if (wr_mask) {
>          *iselect =3D (*iselect & ~wr_mask) | (new_val & wr_mask);
>      }
> @@ -2244,6 +2281,56 @@ done:
>      return RISCV_EXCP_NONE;
>  }
>
> +/*
> + * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
> + *
> + * Perform indirect access to xireg and xireg2-xireg6.
> + * This is a generic interface for all xireg CSRs. Apart from AIA, all o=
ther
> + * extension using csrind should be implemented here.
> + */
> +static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
> +                              target_ulong isel, target_ulong *val,
> +                              target_ulong new_val, target_ulong wr_mask=
)
> +{
> +    return -EINVAL;
> +}
> +
> +static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
> +                      target_ulong new_val, target_ulong wr_mask)
> +{
> +    bool virt =3D false;
> +    int ret =3D -EINVAL;
> +    target_ulong isel;
> +
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Translate CSR number for VS-mode */
> +    csrno =3D csrind_xlate_vs_csrno(env, csrno);
> +
> +    if (CSR_MIREG <=3D csrno && csrno <=3D CSR_MIREG6 &&
> +        csrno !=3D CSR_MIREG4 - 1) {
> +        isel =3D env->miselect;
> +    } else if (CSR_SIREG <=3D csrno && csrno <=3D CSR_SIREG6 &&
> +               csrno !=3D CSR_SIREG4 - 1) {
> +        isel =3D env->siselect;
> +    } else if (CSR_VSIREG <=3D csrno && csrno <=3D CSR_VSIREG6 &&
> +               csrno !=3D CSR_VSIREG4 - 1) {
> +        isel =3D env->vsiselect;
> +        virt =3D true;
> +    } else {
> +        goto done;
> +    }
> +
> +    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
> +
> +done:
> +    return (env->virt_enabled && virt) ?
> +            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>  static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
>                                  target_ulong *val, target_ulong new_val,
>                                  target_ulong wr_mask)
> @@ -2276,8 +2363,21 @@ static RISCVException rmw_xireg(CPURISCVState *env=
, int csrno,
>           goto done;
>      };
>
> +    /*
> +     * Use the xiselect range to determine actual op on xireg.
> +     *
> +     * Since we only checked the existence of AIA or Indirect Access in =
the
> +     * predicate, we should check the existence of the exact extension w=
hen
> +     * we get to a specific range and return illegal instruction excepti=
on even
> +     * in VS-mode.
> +     */
>      if (xiselect_aia_range(isel)) {
>          return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
> +               riscv_cpu_cfg(env)->ext_sscsrind) {
> +        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask)=
;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
>      }
>
>  done:
> @@ -2735,7 +2835,7 @@ static RISCVException write_mstateen0(CPURISCVState=
 *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
>
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
>          wr_mask |=3D SMSTATEEN0_SVSLCT;
>      }
>
> @@ -2828,7 +2928,7 @@ static RISCVException write_hstateen0(CPURISCVState=
 *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrin=
d) {
>          wr_mask |=3D SMSTATEEN0_SVSLCT;
>      }
>
> @@ -5261,6 +5361,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_MIREG]    =3D { "mireg",    csrind_or_aia_any,   NULL, NULL,
>                         rmw_xireg                                       }=
,
>
> +    /* Machine Indirect Register Alias */
> +    [CSR_MIREG2]   =3D { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG3]   =3D { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG4]   =3D { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG5]   =3D { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG6]   =3D { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          },
> +
>      /* Machine-Level Interrupts (AIA) */
>      [CSR_MTOPEI]   =3D { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
>      [CSR_MTOPI]    =3D { "mtopi",    aia_any, read_mtopi },
> @@ -5382,6 +5494,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SIREG]      =3D { "sireg",      csrind_or_aia_smode, NULL, NULL=
,
>                           rmw_xireg                                      =
    },
>
> +    /* Supervisor Indirect Register Alias */
> +    [CSR_SIREG2]      =3D { "sireg2", csrind_smode, NULL, NULL, rmw_xire=
gi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_SIREG3]      =3D { "sireg3", csrind_smode, NULL, NULL, rmw_xire=
gi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_SIREG4]      =3D { "sireg4", csrind_smode, NULL, NULL, rmw_xire=
gi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_SIREG5]      =3D { "sireg5", csrind_smode, NULL, NULL, rmw_xire=
gi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_SIREG6]      =3D { "sireg6", csrind_smode, NULL, NULL, rmw_xire=
gi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +
>      /* Supervisor-Level Interrupts (AIA) */
>      [CSR_STOPEI]     =3D { "stopei",     aia_smode, NULL, NULL, rmw_xtop=
ei },
>      [CSR_STOPI]      =3D { "stopi",      aia_smode, read_stopi },
> @@ -5464,6 +5588,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_VSIREG]      =3D { "vsireg",      csrind_or_aia_hmode, NULL, NU=
LL,
>                            rmw_xireg                                     =
    },
>
> +    /* Virtual Supervisor Indirect Alias */
> +    [CSR_VSIREG2]     =3D { "vsireg2", csrind_hmode, NULL, NULL, rmw_xir=
egi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_VSIREG3]     =3D { "vsireg3", csrind_hmode, NULL, NULL, rmw_xir=
egi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_VSIREG4]     =3D { "vsireg4", csrind_hmode, NULL, NULL, rmw_xir=
egi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_VSIREG5]     =3D { "vsireg5", csrind_hmode, NULL, NULL, rmw_xir=
egi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +    [CSR_VSIREG6]     =3D { "vsireg6", csrind_hmode, NULL, NULL, rmw_xir=
egi,
> +                          .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
> +
>      /* VS-Level Interrupts (H-extension with AIA) */
>      [CSR_VSTOPEI]     =3D { "vstopei",     aia_hmode, NULL, NULL, rmw_xt=
opei },
>      [CSR_VSTOPI]      =3D { "vstopi",      aia_hmode, read_vstopi },
>
> --
> 2.34.1
>
>

