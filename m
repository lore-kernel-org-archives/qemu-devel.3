Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67379C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7iL-00048C-1g; Mon, 05 Aug 2024 20:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7iA-00044C-Lg; Mon, 05 Aug 2024 20:06:00 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7i6-0006Pc-2k; Mon, 05 Aug 2024 20:05:57 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-820f047c4e4so3210990241.0; 
 Mon, 05 Aug 2024 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722902752; x=1723507552; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcESa8umVPpDiIBHqsOCRXbMYjp0h9CBJgbsEMmzlIc=;
 b=VneJMnRFjGywOXqCKRVuIB8khy3wbimkIqkuUjvkL042AeNV+IxXCYS35H4ILPbubU
 ZCTBjpW5lwYsKtSl2ViY3uWT5iQTFPbv7NbvkTXD2lSaWDSf9rFn5C6pTL8bIBbtipFZ
 ZpkR4//bc+H2ncPRfMQQ6nFKKtoo1vEpJnuUW1bOOJSaekp4kJ5PENdGRDh9bNe/zBS0
 iu5iauIRdVJdtD1WtYSzk+qV1zqoM8ExbmV9oESyn8hPh16zNHE/VWEJuvl6uS5ensIu
 iETHpH1D1TyhPB44Wbhl4+R2HtriykPdN1SZXJ2ZDAms59PxlDXATtLOBAZiXpPHoBG9
 FrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722902752; x=1723507552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcESa8umVPpDiIBHqsOCRXbMYjp0h9CBJgbsEMmzlIc=;
 b=RdJM6zTCksHKUx74YSDG2l0KQgdev1PKaJYbFF9lZLR5FYE/T+MXkn7xZKKxRZrPWT
 RGlGOyvoNUt3meflj+MeKRbezlT7ccm4i0ELKYcv2J68fdz53TBUWMpKjmIimY9KGGMR
 THMrP1b/DGnJz1XoxE0hTyTVOFO5nGg4Pu4kjWV1VDRFXlPW6fK7PiQxQjp/7uY2t63n
 lOL+Mxx+cXA39kx4N6+dIci5Zvt+QlS+OCAwpSL9xcfHgDgzFzbnh04gxqTghjySrmqT
 owUi1Y00TA9mBT1Ede7pjGMIKtYLUp5YHGEaQc9WmtiSq4oxTpi8QK511m64V++tSwkt
 d/Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBc5qHFQ80VsyPg+bmEgif5N+mvrfEYgZDfYbYg8kYKr20JaU8wc1aQdxuzdLDQ1aRI90HUp8RWfIfoR1iZnOKUT3WSAI=
X-Gm-Message-State: AOJu0YxRVlKIzSH6QD4YwMcQO6cvKlQ22+7xP0fzVqXIsRfeCVvd3aB1
 sXnE3ufT1h6EdKry08sc3sHO0Q8+wl76FX05z8UiAyBChO1eeSJpRpQk9Vtyq7K+omWWEeUeQZY
 rfzM1ycgl/TEIKwMenNr0u0oer9Y=
X-Google-Smtp-Source: AGHT+IHh5ns0ks4F8wQM7u3ZLIXR/4ldoBUKUWyLOEF40Xe95bUC5aSaxRURymOsEIUxXxVicjhlDjDYGazvok8EG1k=
X-Received: by 2002:a05:6102:b12:b0:492:ad30:b6e8 with SMTP id
 ada2fe7eead31-4945bdc47ecmr15702802137.3.1722902751820; Mon, 05 Aug 2024
 17:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-2-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-2-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 10:05:25 +1000
Message-ID: <CAKmqyKNKcUozyBSvegSQX52W_8qpWLBtVgy2nZNk1diYZoZOSw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] target/riscv: Decouple AIA processing from
 xiselect and xireg
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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
> Since xiselect and xireg also will be of use in sxcsrind, AIA should
> have its own separated interface when those CSRs are accessed.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 165 ++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 139 insertions(+), 26 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea3560342c4f..58be8bc3cc8c 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/cpu-timers.h"
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
> +#include <stdbool.h>
>
>  /* CSR function table public API */
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
> @@ -286,6 +287,15 @@ static RISCVException aia_any32(CPURISCVState *env, =
int csrno)
>      return any32(env, csrno);
>  }
>
> +static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return any(env, csrno);
> +}
> +
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVS)) {
> @@ -322,6 +332,30 @@ static RISCVException aia_smode32(CPURISCVState *env=
, int csrno)
>      return smode32(env, csrno);
>  }
>
> +static bool csrind_extensions_present(CPURISCVState *env)
> +{
> +    return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_s=
scsrind;
> +}
> +
> +static bool aia_extensions_present(CPURISCVState *env)
> +{
> +    return riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_ssai=
a;
> +}
> +
> +static bool csrind_or_aia_extensions_present(CPURISCVState *env)
> +{
> +    return csrind_extensions_present(env) || aia_extensions_present(env)=
;
> +}
> +
> +static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_or_aia_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>  static RISCVException hmode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVH)) {
> @@ -341,6 +375,15 @@ static RISCVException hmode32(CPURISCVState *env, in=
t csrno)
>
>  }
>
> +static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_or_aia_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>  static RISCVException umode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVU)) {
> @@ -1928,6 +1971,22 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, =
int csrno)
>      };
>  }
>
> +static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
> +{
> +    if (!env->virt_enabled) {
> +        return csrno;
> +    }
> +
> +    switch (csrno) {
> +    case CSR_SISELECT:
> +        return CSR_VSISELECT;
> +    case CSR_SIREG:
> +        return CSR_VSIREG;
> +    default:
> +        return csrno;
> +    };
> +}
> +
>  static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
>                                     target_ulong *val, target_ulong new_v=
al,
>                                     target_ulong wr_mask)
> @@ -1935,7 +1994,7 @@ static RISCVException rmw_xiselect(CPURISCVState *e=
nv, int csrno,
>      target_ulong *iselect;
>
>      /* Translate CSR number for VS-mode */
> -    csrno =3D aia_xlate_vs_csrno(env, csrno);
> +    csrno =3D csrind_xlate_vs_csrno(env, csrno);
>
>      /* Find the iselect CSR based on CSR number */
>      switch (csrno) {
> @@ -1964,6 +2023,12 @@ static RISCVException rmw_xiselect(CPURISCVState *=
env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static bool xiselect_aia_range(target_ulong isel)
> +{
> +    return (ISELECT_IPRIO0 <=3D isel && isel <=3D ISELECT_IPRIO15) ||
> +           (ISELECT_IMSIC_FIRST <=3D isel && isel <=3D ISELECT_IMSIC_LAS=
T);
> +}
> +
>  static int rmw_iprio(target_ulong xlen,
>                       target_ulong iselect, uint8_t *iprio,
>                       target_ulong *val, target_ulong new_val,
> @@ -2009,45 +2074,44 @@ static int rmw_iprio(target_ulong xlen,
>      return 0;
>  }
>
> -static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> -                                target_ulong *val, target_ulong new_val,
> -                                target_ulong wr_mask)
> +static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
> +                         target_ulong isel, target_ulong *val,
> +                         target_ulong new_val, target_ulong wr_mask)
>  {
> -    bool virt, isel_reserved;
> -    uint8_t *iprio;
> +    bool virt =3D false, isel_reserved =3D false;
>      int ret =3D -EINVAL;
> -    target_ulong priv, isel, vgein;
> -
> -    /* Translate CSR number for VS-mode */
> -    csrno =3D aia_xlate_vs_csrno(env, csrno);
> +    uint8_t *iprio;
> +    target_ulong priv, vgein;
>
> -    /* Decode register details from CSR number */
> -    virt =3D false;
> -    isel_reserved =3D false;
> +    /* VS-mode CSR number passed in has already been translated */
>      switch (csrno) {
>      case CSR_MIREG:
> +        if (!riscv_cpu_cfg(env)->ext_smaia) {
> +            goto done;
> +        }
>          iprio =3D env->miprio;
> -        isel =3D env->miselect;
>          priv =3D PRV_M;
>          break;
>      case CSR_SIREG:
> -        if (env->priv =3D=3D PRV_S && env->mvien & MIP_SEIP &&
> +        if (!riscv_cpu_cfg(env)->ext_ssaia ||
> +            (env->priv =3D=3D PRV_S && env->mvien & MIP_SEIP &&
>              env->siselect >=3D ISELECT_IMSIC_EIDELIVERY &&
> -            env->siselect <=3D ISELECT_IMSIC_EIE63) {
> +            env->siselect <=3D ISELECT_IMSIC_EIE63)) {
>              goto done;
>          }
>          iprio =3D env->siprio;
> -        isel =3D env->siselect;
>          priv =3D PRV_S;
>          break;
>      case CSR_VSIREG:
> +        if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +            goto done;
> +        }
>          iprio =3D env->hviprio;
> -        isel =3D env->vsiselect;
>          priv =3D PRV_S;
>          virt =3D true;
>          break;
>      default:
> -         goto done;
> +        goto done;
>      };
>
>      /* Find the selected guest interrupt file */
> @@ -2078,10 +2142,54 @@ static RISCVException rmw_xireg(CPURISCVState *en=
v, int csrno,
>      }
>
>  done:
> +    /*
> +     * If AIA is not enabled, illegal instruction exception is always
> +     * returned regardless of whether we are in VS-mode or not
> +     */
>      if (ret) {
>          return (env->virt_enabled && virt && !isel_reserved) ?
>                 RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_IN=
ST;
>      }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> +                                target_ulong *val, target_ulong new_val,
> +                                target_ulong wr_mask)
> +{
> +    bool virt =3D false;
> +    int ret =3D -EINVAL;
> +    target_ulong isel;
> +
> +    /* Translate CSR number for VS-mode */
> +    csrno =3D csrind_xlate_vs_csrno(env, csrno);
> +
> +    /* Decode register details from CSR number */
> +    switch (csrno) {
> +    case CSR_MIREG:
> +        isel =3D env->miselect;
> +        break;
> +    case CSR_SIREG:
> +        isel =3D env->siselect;
> +        break;
> +    case CSR_VSIREG:
> +        isel =3D env->vsiselect;
> +        virt =3D true;
> +        break;
> +    default:
> +         goto done;
> +    };
> +
> +    if (xiselect_aia_range(isel)) {
> +        return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
> +    }
> +
> +done:
> +    if (ret) {
> +        return (env->virt_enabled && virt) ?
> +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_IN=
ST;
> +    }
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -4981,8 +5089,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_MIP]      =3D { "mip",      any,  NULL,    NULL, rmw_mip       =
 },
>
>      /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
> -    [CSR_MISELECT] =3D { "miselect", aia_any,   NULL, NULL,    rmw_xisel=
ect },
> -    [CSR_MIREG]    =3D { "mireg",    aia_any,   NULL, NULL,    rmw_xireg=
 },
> +    [CSR_MISELECT] =3D { "miselect", csrind_or_aia_any,   NULL, NULL,
> +                       rmw_xiselect                                    }=
,
> +    [CSR_MIREG]    =3D { "mireg",    csrind_or_aia_any,   NULL, NULL,
> +                       rmw_xireg                                       }=
,
>
>      /* Machine-Level Interrupts (AIA) */
>      [CSR_MTOPEI]   =3D { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
> @@ -5100,8 +5210,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SATP]     =3D { "satp",     satp, read_satp,     write_satp    =
 },
>
>      /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
> -    [CSR_SISELECT]   =3D { "siselect",   aia_smode, NULL, NULL, rmw_xise=
lect },
> -    [CSR_SIREG]      =3D { "sireg",      aia_smode, NULL, NULL, rmw_xire=
g },
> +    [CSR_SISELECT]   =3D { "siselect",   csrind_or_aia_smode, NULL, NULL=
,
> +                         rmw_xiselect                                   =
    },
> +    [CSR_SIREG]      =3D { "sireg",      csrind_or_aia_smode, NULL, NULL=
,
> +                         rmw_xireg                                      =
    },
>
>      /* Supervisor-Level Interrupts (AIA) */
>      [CSR_STOPEI]     =3D { "stopei",     aia_smode, NULL, NULL, rmw_xtop=
ei },
> @@ -5180,9 +5292,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      /*
>       * VS-Level Window to Indirectly Accessed Registers (H-extension wit=
h AIA)
>       */
> -    [CSR_VSISELECT]   =3D { "vsiselect",   aia_hmode, NULL, NULL,
> -                          rmw_xiselect                                  =
   },
> -    [CSR_VSIREG]      =3D { "vsireg",      aia_hmode, NULL, NULL, rmw_xi=
reg  },
> +    [CSR_VSISELECT]   =3D { "vsiselect",   csrind_or_aia_hmode, NULL, NU=
LL,
> +                          rmw_xiselect                                  =
    },
> +    [CSR_VSIREG]      =3D { "vsireg",      csrind_or_aia_hmode, NULL, NU=
LL,
> +                          rmw_xireg                                     =
    },
>
>      /* VS-Level Interrupts (H-extension with AIA) */
>      [CSR_VSTOPEI]     =3D { "vstopei",     aia_hmode, NULL, NULL, rmw_xt=
opei },
>
> --
> 2.34.1
>
>

