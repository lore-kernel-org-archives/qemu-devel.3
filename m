Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19388E937E9
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 15:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBwis-0007FX-P8; Sun, 12 Apr 2026 11:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wBwiq-0007Bf-0E
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 11:27:40 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wBwim-00042H-IP
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 11:27:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35e576110adso369315a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776007653; x=1776612453; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J85B8JJnFLVLhJwJ99rzcqkRKgCoffmqoytBEz9RMcw=;
 b=K6ThKRBOhXnT6M9d3AJgCGVpDNIwUrOErCwOEAdkoknaX96QcMQBKbXxrCtFicA0Bn
 tqVWr+V3Frq9oYg+2n1rQvvby8XJveDOo1Tc4xhTU+iP4iq8txdSWKI4eWg/s3oeD9uj
 XkY0Pok2xDIj1p3WU1PORC8s8YNHAOmRM+LN8NwCGRrDTjnoPOcMcgQ5ILs5nkYtoHEy
 P2PPPyIo3se03A1uXQksrNURU8n3Qzf308spfU9ueAvTRgiYVDVTjzSb3XQ4nBZ03gwv
 aW6FpnZ8tapDaRtTeExGx01G0rWDEcUTFwY+FRYOx+7K5wn9e1SsZtx/oVfcsKuhDIoP
 s9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776007653; x=1776612453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J85B8JJnFLVLhJwJ99rzcqkRKgCoffmqoytBEz9RMcw=;
 b=Jxz7Likesddwq9UnA01AMwksJ6hJZDcyTFspndScRnhaauOyMlz0vfs9Hvm+4vIapa
 JkDnIWRoZxCqrDOGbU93QqOfIyZkzqzCcPtRyXEMca8mfnNraEWPeI/5GVdfsJstz+6E
 3Gycys9cRaW0YmCgO9k4mVL1RcoHYKvb/pVIUqxVGcBDwqA0ZS0hAPdouVahC3gn6Qch
 oHIsXEt946V9PJ0HjP1xXU8tg23p8gPi4E8qnIQjmrs7uxu2SNAzhnNlS4RJf30RjKq+
 /VG71/ukN/ZV2FBz+MDoDbmEgjeyJQhMbA8+IKB1wtv06jTwuXYypKTBV7hjX9ZDMGUU
 TYDw==
X-Gm-Message-State: AOJu0Yy9Pt8P6hfqTiqVR5cNJga+UqYx/Tiz0nGj5y+rkgBJFga2qJxN
 YBVc5rkWU1ikkegOxyUn1TRzRxHh+7tVo4FQvomwlc4mPq68ypdos/PiHfdIFb68UlhAaJ836Ho
 66IFdBtjUp5xRFk3iZsoqRGjOjwJh8+vMdUbVyGFqnYATf0ZNzjCZcJMDhIW0HzcP2SWiIM5vPP
 bBLpSs9yeeQLG8NOEvvVf545BFk4zJaMbi3d+HWB+fknPXsQ==
X-Gm-Gg: AeBDievegnM/jDBEBrPddOWHASubwvu2JYfc33KAaWWrX3Jn9Gom8IckS73TeDXnUgU
 k8crOKwjSd22ZdadN+WLzaCsEOJz0j/s8JINX2sAdPi+nFii0EgtB3cNu3liKkclwsLnSpPUb0i
 u+SYYOtLTQtuhW5lEgdo/VeNQhCDbjcIaUAAeYVv1MiL3ndCCNc8OGGl3Vri0TPrYkV/Fftgryy
 aB9MSsFlmJpzq38zgl63b7oP4k4iCVgFd8uxL2g7Bom2lH23t5QC5re3LTb+U2nRFdyPG6lgt5H
 trGMe14G/6x8F7OXUQiNM29Xktm60ZLGLnGv1HgzAEmmRq3Pw/S43rRLAC8PmjtkLa5nZQ5gC7k
 0pvvS3nfgBRR4qAlgP2KKknhqeuB44xuPZZJ+OCfjXIUXFtmk5x3hcbcxoP2GyIMOs/HrCad/QC
 5CshsIlkBZj0EQvnAeYjaJEPEeNGXviamG9E5MOSD2/ooKD5VtpfyQDQ77I1jdkA==
X-Received: by 2002:a17:90b:3cc5:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-35e42fe6aefmr7767982a91.3.1776007652887; 
 Sun, 12 Apr 2026 08:27:32 -0700 (PDT)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com.
 [74.125.82.53]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e412233ddsm9447046a91.5.2026.04.12.08.27.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 08:27:30 -0700 (PDT)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1274204434bso2021484c88.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 08:27:30 -0700 (PDT)
X-Received: by 2002:a05:7022:384:b0:123:2f12:60b4 with SMTP id
 a92af1059eb24-12c28c315aemr6685962c88.20.1776007649718; Sun, 12 Apr 2026
 08:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 12 Apr 2026 23:27:17 +0800
X-Gmail-Original-Message-ID: <CANzO1D2jeypk-mitgdCsDPhZsE+sS1j24_W8Ne9rqiQ8ogBPdA@mail.gmail.com>
X-Gm-Features: AQROBzCLdfX5sF4YWvecIzgWY6voiruXYdF6VIMp_5WAa_-DDIN93l41zAbWGiw
Message-ID: <CANzO1D2jeypk-mitgdCsDPhZsE+sS1j24_W8Ne9rqiQ8ogBPdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=88=
9=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:39=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> This patch lays the groundwork for the SMMPT (Supervisor Domains Access
> Protection) extension by introducing its fundamental components.
>
> It adds:
> - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
>   the extension.
> - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
> - The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
>   `csr.c`.
> - New fields in `CPUArchState` to store the state of these new CSRs.
> - A new translation failure reason `TRANSLATE_MPT_FAIL`.
>
> This provides the necessary infrastructure for the core MPT logic and
> MMU integration that will follow.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.h                |  9 ++-
>  target/riscv/cpu_bits.h           | 27 +++++++++
>  target/riscv/cpu_cfg_fields.h.inc |  2 +
>  target/riscv/csr.c                | 95 +++++++++++++++++++++++++++++++
>  target/riscv/riscv_smmpt.h        | 21 +++++++
>  5 files changed, 153 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/riscv_smmpt.h
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..f8265c2cc2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -130,7 +130,8 @@ enum {
>      TRANSLATE_SUCCESS,
>      TRANSLATE_FAIL,
>      TRANSLATE_PMP_FAIL,
> -    TRANSLATE_G_STAGE_FAIL
> +    TRANSLATE_G_STAGE_FAIL,
> +    TRANSLATE_MPT_FAIL
>  };
>
>  /* Extension context status */
> @@ -181,6 +182,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
>  #include "debug.h"
> +#include "riscv_smmpt.h"
>  #endif
>
>  #define RV_VLEN_MAX 1024
> @@ -481,6 +483,11 @@ struct CPUArchState {
>      uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t sstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t henvcfg;
> +    /* Smsdid */
> +    uint32_t mptmode;
> +    uint32_t sdid;
> +    uint64_t mptppn;
> +    uint32_t msdcfg;
>  #endif
>
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c6a34863d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -1164,4 +1164,31 @@ typedef enum CTRType {
>  #define MCONTEXT64                         0x0000000000001FFFULL
>  #define MCONTEXT32_HCONTEXT                0x0000007F
>  #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +
> +/* Smsdid */
> +#define CSR_MMPT        0xbc0
> +#define CSR_MSDCFG      0xbd1
> +
> +#define MMPT_MODE_MASK_32   0xC0000000
> +#define MMPT_SDID_MASK_32   0x3F000000
> +#define MMPT_PPN_MASK_32    0x003FFFFF
> +
> +#define MMPT_MODE_SHIFT_32  30
> +#define MMPT_SDID_SHIFT_32  24
> +
> +#define MMPT_MODE_MASK_64   0xF000000000000000ULL
> +#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
> +#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
> +
> +#define MPTE_L3_VALID       0x0000100000000000ULL
> +#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
> +
> +#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
> +#define MPTE_L2_RESERVED_32    0xFE000000
> +
> +#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
> +#define MPTE_L1_RESERVED_32    0xFFFF0000

Hi Zhiwei,

MPTE_* fields are not used in the pachset.

Otherwise,
Reviewed-by: Frank Chang <frank.chang@sifive.com>

> +
> +#define MMPT_MODE_SHIFT_64  60
> +#define MMPT_SDID_SHIFT_64  54
>  #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index cd1a5ec56b..80644948dd 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -63,6 +63,8 @@ BOOL_FIELD(ext_smpmpmt)
>  BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
> +BOOL_FIELD(ext_smmpt)
> +BOOL_FIELD(ext_smsdid)
>  BOOL_FIELD(ext_zdinx)
>  BOOL_FIELD(ext_zaamo)
>  BOOL_FIELD(ext_zacas)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..081d2fc2c3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -793,6 +793,15 @@ static RISCVException rnmi(CPURISCVState *env, int c=
srno)
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> +
> +static RISCVException smsdid(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_smsdid) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
>  #endif
>
>  static RISCVException seed(CPURISCVState *env, int csrno)
> @@ -5446,6 +5455,89 @@ static RISCVException write_mnstatus(CPURISCVState=
 *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException read_mmpt(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
> +{
> +    if (riscv_cpu_xlen(env) =3D=3D 32) {
> +        uint32_t value =3D 0;
> +        value |=3D env->mptmode << MMPT_MODE_SHIFT_32;
> +        value |=3D (env->sdid << MMPT_SDID_SHIFT_32) & MMPT_SDID_MASK_32=
;
> +        value |=3D env->mptppn & MMPT_PPN_MASK_32;
> +        *val =3D value;
> +    } else if (riscv_cpu_xlen(env) =3D=3D 64) {
> +        uint64_t value_64 =3D 0;
> +        uint32_t mode_value =3D env->mptmode;
> +        /* mpt_mode_t convert to mmpt.mode value */
> +        if (mode_value) {
> +            mode_value -=3D SMMPT43 - SMMPT34;
> +        }
> +        value_64 |=3D (uint64_t)mode_value << MMPT_MODE_SHIFT_64;
> +        value_64 |=3D ((uint64_t)env->sdid << MMPT_SDID_SHIFT_64)
> +                    & MMPT_SDID_MASK_64;
> +        value_64 |=3D (uint64_t)env->mptppn & MMPT_PPN_MASK_64;
> +        *val =3D value_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mmpt(CPURISCVState *env, int csrno,
> +                                 target_ulong val, uintptr_t ra)
> +{
> +    uint32_t mode_value =3D 0;
> +    if (!riscv_cpu_cfg(env)->ext_smmpt) {
> +        goto set_remaining_fields_zero;
> +    }
> +
> +    if (riscv_cpu_xlen(env) =3D=3D 32) {
> +        mode_value =3D (val & MMPT_MODE_MASK_32) >> MMPT_MODE_SHIFT_32;
> +        /* If mode is bare, the remaining fields in mmpt must be zero */
> +        if (mode_value =3D=3D SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value <=3D SMMPT34) {
> +            /* Only write the legal value */
> +            env->mptmode =3D mode_value;
> +        }
> +        env->sdid =3D (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
> +        env->mptppn =3D val & MMPT_PPN_MASK_32;
> +    } else if (riscv_cpu_xlen(env) =3D=3D 64) {
> +        mode_value =3D (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
> +        if (mode_value =3D=3D SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value < SMMPTMAX) {
> +            /* convert to mpt_mode_t */
> +            mode_value +=3D SMMPT43 - SMMPT34;
> +            env->mptmode =3D mode_value;
> +        }
> +        env->sdid =3D (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
> +        env->mptppn =3D val & MMPT_PPN_MASK_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +
> +set_remaining_fields_zero:
> +    env->sdid =3D 0;
> +    env->mptmode =3D SMMPTBARE;
> +    env->mptppn =3D 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_msdcfg(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    *val =3D env->msdcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_msdcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val, uintptr_t ra)
> +{
> +    env->msdcfg =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  #endif
>
>  /* Crypto Extension */
> @@ -6660,6 +6752,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                               write_mhpmcounterh                         =
},
>      [CSR_SCOUNTOVF]      =3D { "scountovf", sscofpmf,  read_scountovf,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> +    /* Supervisor Domain Identifier and Protection Registers */
> +    [CSR_MMPT] =3D    { "mmpt",   smsdid,  read_mmpt,   write_mmpt   },
> +    [CSR_MSDCFG] =3D  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },
>
>  #endif /* !CONFIG_USER_ONLY */
>  };
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> new file mode 100644
> index 0000000000..74dcccf4be
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.h
> @@ -0,0 +1,21 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_SMMPT_H
> +#define RISCV_SMMPT_H
> +
> +typedef enum {
> +    SMMPTBARE =3D 0,
> +    SMMPT34   =3D 1,
> +    SMMPT43   =3D 2,
> +    SMMPT52   =3D 3,
> +    SMMPT64   =3D 4,
> +    SMMPTMAX
> +} mpt_mode_t;
> +
> +#endif
> --
> 2.43.0
>
>

