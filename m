Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F441C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmWw-0008Sg-3z; Tue, 30 Jan 2024 06:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rUmWp-00087X-Cp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:43:47 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rUmWi-0007Sq-3U
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:43:46 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-59a7682486aso163833eaf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1706615017; x=1707219817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5mWnqx94lL5jGF1vK7K907APo+ZPqgzHHBw7SvsQoA=;
 b=G84mcsRm0oaUQUxig0dYiFx1FZWyPE0hbCJHpAWsi0REtf+ztqlp7YeITP91NmrYl1
 V/Ei/tosszZIdvLzknTCD1L6RtoSrGvSqVP+cio4+3irHW0sV421dU4eTVo9NmSsOCz9
 kmLKDP45cE4OhmK+xmM+m+NqP9or3lQ49sAxEXVydVT25+ufL21jMrDcDHJPNiyNbgjL
 Nrj6FUnBUU5YTfRVfIoHtmvXjuEiAboVpxM/Gp9mk9gafYVg90Dv0pRc4OMFrm/VTlw3
 zV20A7NO+2fZaggUCm6sMC+fZhcUJ34jk/Zeqd5EQ6tHaRaqyV9mb2fCP5AgjW9bs81+
 da5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615017; x=1707219817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5mWnqx94lL5jGF1vK7K907APo+ZPqgzHHBw7SvsQoA=;
 b=GX/wngUsuwL+QgDM2o0RerR9pdYpo5R8vAOLmrz2AL3ZL2/OSTkklwp4RA2nLEgwo4
 HyS9+NgoXWb/0yj4vo6kW4PbdHNRfMna7szxwC2melckgnneltLCUeade4l+X2+2aszV
 e1yVkCSesswFgJjSa5uVuhmo/3n2HPQoMVYY0I0zBLNm23KMf8Wsutvv8VfEx0+ID6XH
 95BsJ9HKEbnAK4MX12Ro09FBu2JA46VekJMZIQ4pP+rAFDoXfXC4S8ZLFTBZYWcURmFV
 cDlwvR8OjsbiOdD1DnUnHUCMHj+/qsnE6WyXwPe2fIpw32i/ATEhI3ReHxThc8t1/Z/M
 3DFg==
X-Gm-Message-State: AOJu0YwzvhHH+u34R9tGxYiwqvmWtN6zeR0Xem2937WEUrUBMQBckVPg
 YIAW/fZt0guE4mTb78XfQD1JrfIFfenkmCLBx36iBhFFyjEE5rGeBwAGEbRNFNAh9UKnUrQG3AD
 3tdntL8JTQsXzaKZFeyc/koGT6jRam8QI4PcmpQ==
X-Google-Smtp-Source: AGHT+IGKTEEsExtKxg5HnzadZwFOduxNhV2aOpPOVmOp/OughQWEpwa1GO263L+s2s7MngpYW/Na5sq9ZZSt7174C5Y=
X-Received: by 2002:a05:6358:6f0d:b0:178:8559:80fa with SMTP id
 r13-20020a0563586f0d00b00178855980famr1823378rwn.62.1706615017330; Tue, 30
 Jan 2024 03:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
 <20240130111159.532-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240130111159.532-3-zhiwei_liu@linux.alibaba.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Tue, 30 Jan 2024 12:43:25 +0100
Message-ID: <CAEg0e7g7AY0YcTu4RiXtim3Ofkq3TuCWd4QjGqkF7xZNiYJ1Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Support xtheadmaee for thead-c906
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, bjorn@kernel.org, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-oo1-xc31.google.com
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

On Tue, Jan 30, 2024 at 12:12=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> thead-c906 uses some flags in pte [60-63] bits. It has history reasons th=
at
> SVPBMT didn't exist when thead-c906 came to world.
>
> We named this feature as xtheadmaee. this feature is controlled by an cus=
tom
> CSR named mxstatus, whose maee field encodes whether enable the pte [60-6=
3] bits.
>
> The sections "5.2.2.1 Page table structure" and "15.1.7.1 M-mode extensio=
n
> status register (MXSTATUS)" in document[1] give the detailed information
> about its design.

I would prefer if we would not define an extension like XTheadMaee
without a specification.
The linked document defines the bit MAEE in a custom CSR, but the
scope of XTheadMaee
is not clearly defined (the term XTheadMaee is not even part of the PDF).

We have all the XThead* extensions well described here:
  https://github.com/T-head-Semi/thead-extension-spec/tree/master
And it would not be much effort to add XTheadMaee there as well.

For those who don't know the context of this patch, here is the c906
boot regression report from Bj=C3=B6rn:
  https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg04766.html

BR
Christoph

Christoph

>
> [1]:https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//16992=
65191641/XuanTie-Openc906-UserManual.pdf
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/cpu.c         |  6 ++++
>  target/riscv/cpu.h         |  9 ++++++
>  target/riscv/cpu_bits.h    |  6 ++++
>  target/riscv/cpu_cfg.h     |  4 ++-
>  target/riscv/cpu_helper.c  | 25 ++++++++-------
>  target/riscv/meson.build   |  1 +
>  target/riscv/tcg/tcg-cpu.c |  9 ++----
>  target/riscv/xthead_csr.c  | 63 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 105 insertions(+), 18 deletions(-)
>  create mode 100644 target/riscv/xthead_csr.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2dcbc9ff32..bfdbb0539a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -171,6 +171,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(xtheadmemidx, PRIV_VERSION_1_11_0, ext_xtheadmemi=
dx),
>      ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmem=
pair),
>      ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
> +    ISA_EXT_DATA_ENTRY(xtheadmaee, PRIV_VERSION_1_11_0, ext_xtheadmaee),
>      ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentan=
aCondOps),
>
>      DEFINE_PROP_END_OF_LIST(),
> @@ -506,6 +507,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>  #ifndef CONFIG_USER_ONLY
> +    cpu->cfg.ext_xtheadmaee =3D true;
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>  #endif
>
> @@ -949,6 +951,9 @@ static void riscv_cpu_reset_hold(Object *obj)
>      }
>
>      pmp_unlock_entries(env);
> +    if (riscv_cpu_cfg(env)->ext_xtheadmaee) {
> +        env->th_mxstatus |=3D TH_MXSTATUS_MAEE;
> +    }
>  #endif
>      env->xl =3D riscv_cpu_mxl(env);
>      riscv_cpu_update_mask(env);
> @@ -1439,6 +1444,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
> +    MULTI_EXT_CFG_BOOL("xtheadmaee", ext_xtheadmaee, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
>
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5f3955c38d..1bacf40355 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -412,6 +412,14 @@ struct CPUArchState {
>      target_ulong cur_pmmask;
>      target_ulong cur_pmbase;
>
> +    union {
> +        /* Custom CSR for Xuantie CPU */
> +        struct {
> +#ifndef CONFIG_USER_ONLY
> +            target_ulong th_mxstatus;
> +#endif
> +        };
> +    };
>      /* Fields from here on are preserved across CPU reset. */
>      QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
>      QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
> @@ -799,6 +807,7 @@ void riscv_add_satp_mode_properties(Object *obj);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
>  /* CSR function table */
> +extern riscv_csr_operations th_csr_ops[CSR_TABLE_SIZE];
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e116f6c252..67ebb1cefe 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -897,4 +897,10 @@ typedef enum RISCVException {
>  /* JVT CSR bits */
>  #define JVT_MODE                           0x3F
>  #define JVT_BASE                           (~0x3F)
> +
> +/* Xuantie custom CSRs */
> +#define CSR_TH_MXSTATUS 0x7c0
> +
> +#define TH_MXSTATUS_MAEE_SHIFT  21
> +#define TH_MXSTATUS_MAEE        (0x1 << TH_MXSTATUS_MAEE_SHIFT)
>  #endif
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 780ae6ef17..3735c69fd6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>      bool ext_xtheadmemidx;
>      bool ext_xtheadmempair;
>      bool ext_xtheadsync;
> +    bool ext_xtheadmaee;
>      bool ext_XVentanaCondOps;
>
>      uint32_t pmu_mask;
> @@ -176,7 +177,8 @@ static inline bool has_xthead_p(const RISCVCPUConfig =
*cfg)
>             cfg->ext_xtheadcondmov ||
>             cfg->ext_xtheadfmemidx || cfg->ext_xtheadfmv ||
>             cfg->ext_xtheadmac || cfg->ext_xtheadmemidx ||
> -           cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
> +           cfg->ext_xtheadmempair || cfg->ext_xtheadsync ||
> +           cfg->ext_xtheadmaee;
>  }
>
>  #define MATERIALISE_EXT_PREDICATE(ext) \
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c7cc7eb423..5c1f380276 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -812,6 +812,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      int napot_bits =3D 0;
>      target_ulong napot_mask;
>
> +    bool skip_pte_check =3D env->th_mxstatus & TH_MXSTATUS_MAEE;
>      /*
>       * Check if we should use the background registers for the two
>       * stage translation. We don't need to check if we actually need
> @@ -974,18 +975,19 @@ restart:
>          if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>              ppn =3D pte >> PTE_PPN_SHIFT;
>          } else {
> -            if (pte & PTE_RESERVED) {
> -                return TRANSLATE_FAIL;
> -            }
> +            if (!skip_pte_check) {
> +                if (pte & PTE_RESERVED) {
> +                    return TRANSLATE_FAIL;
> +                }
>
> -            if (!pbmte && (pte & PTE_PBMT)) {
> -                return TRANSLATE_FAIL;
> -            }
> +                if (!pbmte && (pte & PTE_PBMT)) {
> +                    return TRANSLATE_FAIL;
> +                }
>
> -            if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> -                return TRANSLATE_FAIL;
> +                if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +                    return TRANSLATE_FAIL;
> +                }
>              }
> -
>              ppn =3D (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_SHIFT;
>          }
>
> @@ -998,7 +1000,8 @@ restart:
>          }
>
>          /* Inner PTE, continue walking */
> -        if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
> +        if ((pte & (PTE_D | PTE_A | PTE_U)) ||
> +            (!skip_pte_check && (pte & PTE_ATTR))) {
>              return TRANSLATE_FAIL;
>          }
>          base =3D ppn << PGSHIFT;
> @@ -1012,7 +1015,7 @@ restart:
>          /* Misaligned PPN */
>          return TRANSLATE_FAIL;
>      }
> -    if (!pbmte && (pte & PTE_PBMT)) {
> +    if (!skip_pte_check && !pbmte && (pte & PTE_PBMT)) {
>          /* Reserved without Svpbmt. */
>          return TRANSLATE_FAIL;
>      }
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a5e0734e7f..d7f675881d 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -12,6 +12,7 @@ riscv_ss.add(files(
>    'cpu.c',
>    'cpu_helper.c',
>    'csr.c',
> +  'xthead_csr.c',
>    'fpu_helper.c',
>    'gdbstub.c',
>    'op_helper.c',
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 408b2ebffa..18a22dfb7a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -763,7 +763,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,=
 Error **errp)
>          cpu->cfg.pmu_mask =3D 0;
>          cpu->pmu_avail_ctrs =3D 0;
>      }
> -
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> @@ -871,11 +870,9 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cp=
u)
>      }
>  }
>
> -/* This stub just works for making vendors array not empty */
> -riscv_csr_operations stub_csr_ops[CSR_TABLE_SIZE];
> -static inline bool never_p(const RISCVCPUConfig *cfg)
> +static inline bool th_csr_p(const RISCVCPUConfig *cfg)
>  {
> -    return false;
> +    return cfg->ext_xtheadmaee;
>  }
>
>  void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
> @@ -884,7 +881,7 @@ void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
>          bool (*guard_func)(const RISCVCPUConfig *);
>          riscv_csr_operations *csr_ops;
>      } vendors[] =3D {
> -        { never_p, stub_csr_ops },
> +        { th_csr_p, th_csr_ops },
>      };
>      for (size_t i =3D 0; i < ARRAY_SIZE(vendors); ++i) {
>          if (!vendors[i].guard_func(&cpu->cfg)) {
> diff --git a/target/riscv/xthead_csr.c b/target/riscv/xthead_csr.c
> new file mode 100644
> index 0000000000..c119a18789
> --- /dev/null
> +++ b/target/riscv/xthead_csr.c
> @@ -0,0 +1,63 @@
> +/*
> + * Xuantie implementation for RISC-V Control and Status Registers.
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "cpu.h"
> +#include "tcg/tcg-cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/tb-flush.h"
> +#include "qapi/error.h"
> +
> +static RISCVException th_maee_check(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_xtheadmaee) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException
> +read_th_mxstatus(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->th_mxstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException
> +write_th_mxstatus(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    uint64_t mxstatus =3D env->th_mxstatus;
> +    uint64_t mask =3D TH_MXSTATUS_MAEE;
> +
> +    if ((val ^ mxstatus) & TH_MXSTATUS_MAEE) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    mxstatus =3D (mxstatus & ~mask) | (val & mask);
> +    env->th_mxstatus =3D mxstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +riscv_csr_operations th_csr_ops[CSR_TABLE_SIZE] =3D {
> +#if !defined(CONFIG_USER_ONLY)
> +    [CSR_TH_MXSTATUS]     =3D { "th_mxstatus", th_maee_check, read_th_mx=
status,
> +                                                            write_th_mxs=
tatus},
> +#endif /* !CONFIG_USER_ONLY */
> +};
> --
> 2.25.1
>

