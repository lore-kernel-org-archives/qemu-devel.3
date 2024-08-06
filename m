Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7s5-0005YT-Cz; Mon, 05 Aug 2024 20:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7rl-0005Qa-MM; Mon, 05 Aug 2024 20:15:55 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7ri-0007Nu-OG; Mon, 05 Aug 2024 20:15:52 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-8317511fd45so143857241.1; 
 Mon, 05 Aug 2024 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722903347; x=1723508147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGxDsv0M2z+lg+6CMiDyoClNeNkq5MNaDQODQ6aSYOQ=;
 b=mEPSExah27F7M9ZYz5MjY8wlnVQtVeYIgeKhrUUiKCku2hZsvUO8pX8GEgW5R+lDNC
 1dllWJSlnOxyIqbpyAh1J5Aij4GyWXskUjHx46qXTyrQtfzPzu1eCPk3T8E7kUoS1DBZ
 fZr0xouTuFGJzdjTXsM2Itdio6/GGVLccYbnPZspfeT1gb+kHYk/sueZXaVYncuW2kw4
 OFaUZqkA+Z6pz+Ot9hcRwEbhkN14zrgGoVegPqVDtapp0gSHjPUaXuNCMSg3kKBee9mo
 +1bBX9zdhuP4XqQKv0pUfDHIXvZKrrZZ4BbUAnde3m3IuxMFFk7Vmuk5lRZ5IGNihk0Q
 /VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722903347; x=1723508147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGxDsv0M2z+lg+6CMiDyoClNeNkq5MNaDQODQ6aSYOQ=;
 b=HRpY6OTz8G50A7W08dpk8p4GdE+QQA+zdVML6XPIVMGmhJI3r874yx0fqE+P5MOHyP
 3XTKhddKp8uGkcT9jJ+UYhGZGCU/gPF2ESbAjwlWMT+aAKUcH8F1QeksO6NnMVyynC/Y
 HTfNlHmopgpOa2LoA+cMM5GMzq7wlVV77dxsv7V4Y4iAXQLb7f91fulEUkZd/3tavdbL
 oKWj+uVLSxDdNuJPDWJ7G69ar6ixyfIAuffOsEgX3kN3viqlzr6fL3lRRzPnrKO3J+bH
 Pjzrvw8d7Ny7YAzpToh9/zj6swAuDp7s3d4iQJcKyKRSPswaMT9/maFmzBpV1lLVrXLo
 DZcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCD5Iw+vqYIzq4hV4fjx/TFZRq+e0d8/xCINc3ceALuE2dwpnBdAZiFJY/pAaSRQvgHG5zA45UqrnwezVlSWrAE1kO4RQ=
X-Gm-Message-State: AOJu0YxjawQftIw27tBeG8DU+o5Va+cVPSzIvotolHlrG9q0jT6bFayv
 LCJy5rcMgSR+WsS9PZA7CKeY8PD6v+JRbbEp8Y0E7EDtQxFHYWaxMvYt7j7+E/N1Mw5qjYiVGFN
 su3+ibPgp+cDi/ez042wa3tnZEuY=
X-Google-Smtp-Source: AGHT+IFgjcapwtLwU01UbdfyWiwvhdgTagsyRergC45JuFWolfF3h0ydAxvCDaqAVdpaSwav7/lonsGQl8RcEL2nb/0=
X-Received: by 2002:a05:6102:508b:b0:493:b1e1:9dd4 with SMTP id
 ada2fe7eead31-49457a8e930mr10767327137.4.1722903346934; Mon, 05 Aug 2024
 17:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-4-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-4-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 10:15:21 +1000
Message-ID: <CAKmqyKOBKOi2NceUJNcJ9t2TE_KE2++v6qaq8DCsou9uTXwR5Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] target/riscv: Support generic CSR indirect access
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Wed, Jul 24, 2024 at 9:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
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
> ---
>  target/riscv/cpu.c      |   2 +
>  target/riscv/cpu_bits.h |  28 ++++++++-
>  target/riscv/cpu_cfg.h  |   2 +
>  target/riscv/csr.c      | 149 ++++++++++++++++++++++++++++++++++++++++++=
++++--
>  4 files changed, 175 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ebc19090b40d..ac2dce734d80 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -182,12 +182,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_12_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_12_0, ext_ssccfg),

Looks like these are in the wrong patch

>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 32b068f18aa5..2a8b53a6622e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -170,6 +170,13 @@
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
> @@ -219,6 +226,13 @@
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
> @@ -285,6 +299,13 @@
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
> @@ -846,10 +867,13 @@ typedef enum RISCVException {
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
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b8a5174bc871..b2be3d47c7a3 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -79,6 +79,8 @@ struct RISCVCPUConfig {
>      bool ext_smcntrpmf;
>      bool ext_smcsrind;
>      bool ext_sscsrind;
> +    bool ext_smcdeleg;
> +    bool ext_ssccfg;

Same here

Alistair

>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 18b9ae802b15..4ae3931f0ada 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -287,6 +287,17 @@ static RISCVException aia_any32(CPURISCVState *env, =
int csrno)
>      return any32(env, csrno);
>  }
>
> +static RISCVException csrind_any(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_smcsrind) {
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
> @@ -370,6 +381,15 @@ static bool csrind_or_aia_extensions_present(CPURISC=
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
> @@ -398,6 +418,15 @@ static RISCVException hmode32(CPURISCVState *env, in=
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
> @@ -2027,7 +2056,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *en=
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
> @@ -2067,7 +2101,12 @@ static RISCVException rmw_xiselect(CPURISCVState *=
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
> @@ -2206,6 +2245,59 @@ done:
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
> +    if (ret) {
> +        return (env->virt_enabled && virt) ?
> +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_IN=
ST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
>                                  target_ulong *val, target_ulong new_val,
>                                  target_ulong wr_mask)
> @@ -2238,8 +2330,21 @@ static RISCVException rmw_xireg(CPURISCVState *env=
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
> @@ -2671,7 +2776,7 @@ static RISCVException write_mstateen0(CPURISCVState=
 *env, int csrno,
>       * TODO: Do we need to check ssaia as well ? Can we enable ssaia wit=
hout
>       * smaia ?
>       */
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
>          wr_mask |=3D SMSTATEEN0_SVSLCT;
>      }
>
> @@ -2764,7 +2869,7 @@ static RISCVException write_hstateen0(CPURISCVState=
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
> @@ -5180,6 +5285,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
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
> @@ -5301,6 +5418,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
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
> @@ -5383,6 +5512,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
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

