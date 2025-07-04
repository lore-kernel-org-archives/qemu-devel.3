Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE1DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 05:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXYat-0004qj-IR; Fri, 04 Jul 2025 01:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXYar-0004qH-Sy; Fri, 04 Jul 2025 01:04:13 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXYaq-0001sM-1p; Fri, 04 Jul 2025 01:04:13 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5347686c12cso160478e0c.0; 
 Thu, 03 Jul 2025 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751605451; x=1752210251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NU5fj9KcNrHWrP+RreAp/ncXqTZ1hK8BZOahKHM7muk=;
 b=QfhFdbq46LOCciERVfiM+MXutZeYZZGeEJ7LpsFKP1dvewvdMe9Cysdg3BD8FaZ5r3
 By1lQ33NKqxjYzixs49cbRUw6IAe2v7WcHuq9y6oBk1P8ytixKD7xnvCw7Cfhk/NU1A3
 BCrcpXHUiYJmZtl9kxG1tW+UGDKgv7iImGKAj4a61X96ucaTAToP/9vWQTdh4dcOY/rP
 hqClu5BbMy1gYP79DUeQsshzxfXGU/fCvwT/t9mH1qMgG3IrAGd27VZHfg5uLCOF9UCQ
 bVw9DL4ExCUmzKrFtrSdmdpxnWlAVd5VxcP5YT8VzRNXdaf21iNXeoM5aKDTKPoOTddB
 b95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751605451; x=1752210251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NU5fj9KcNrHWrP+RreAp/ncXqTZ1hK8BZOahKHM7muk=;
 b=vv3bXwUji48fU7+gfVmr91EGRxxq37cWcU++0bfgwkWwZQznjVQy+fehY+65nPDLbf
 34OLeqrQnSt4ybCzCDWhQBqQdmwy00JaxRI5WtGZ4rZ8SbKmMnYgHDpZuny7Bh5u2jC0
 erKawmAQKfyOtXwHYYj/bjPuJ9+glaUZOLYgURax+/nJWxlyJ7RsSNUgKXGuDEg8wszz
 OvGFYwgIKjRmvk9+XGOVdK3e7P7XKIJb2W4wj3RJ+spIY7Zkb37gft+It6nQQo/In33J
 fPxOcWRet95Jd9K1YmEIfNY2hwWxCdr4tV6exhL5913uvpkMbaufF1vB72SCTQm4crKz
 C3CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJcdY3+/pxo93jaEwWyuPhBzb4/3KzFdKpb94fZUsJ97YRSYceqMtg4nao0dNSJNRpU5brItxEYzOz@nongnu.org
X-Gm-Message-State: AOJu0YxdA//CGlLcAsugNwjeAk2yz8XhbtAJSCqnvGum3pjKErJYbcAY
 oxEsPDIRCvVw5GUXnQ7+DUe3dZ7mDzZsHo1BbgwyUKzYHhfaXM5QHgbySlOWWMCfGx92zeoP9QY
 7eDB7wLpQio0utDAbOBS7d+CR+wtuYjI=
X-Gm-Gg: ASbGnctLIXxZxBesqUYKv5z6+cv/sDLfMwXsHzVf59KNngxWSJiscA9lXfuqRtvWNiT
 Iv/JLnhWGyTBos3037a/NQbideN9lkJbsLEZkBbWNxKYeFy/fgkfKApzN5PAwu7Df3gm7e3cHEB
 5JMbWqnkWtj9sw34pK3oDe+/mEmxCABJEGqLwq/RHl2y3Fin8wNuoNJoG9QmZUuL3YSvtQZFg8x
 g==
X-Google-Smtp-Source: AGHT+IHvWv7QHEVjtiqpjtXSoXcyqrfXmr7CXXvQBjw8D/xkLQaBCcsbU8rrQcES9D//LRw1BHlgKOX50ZQLbX5n3uk=
X-Received: by 2002:a05:6122:3a1c:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-5347bf8045cmr514621e0c.5.1751605450569; Thu, 03 Jul 2025
 22:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
In-Reply-To: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 15:03:44 +1000
X-Gm-Features: Ac12FXzCC3rIPmoIHTjKMXPNnOKtu3oExrz6AJmVcMNMKYHsIvi7vBqLJ7bkDI4
Message-ID: <CAKmqyKOs-buKLdFKyXGrfsjDiE6tgUCdk1g4QCEAd8Hj5G2amQ@mail.gmail.com>
Subject: Re: [PATCH v2] target: riscv: Add Svrsw60t59b extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Deepak Gupta <debug@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Jul 2, 2025 at 5:31=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
> for software to use.
>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
>   - Fix riscv32 max config (thanks Daniel!)
>   - Add RB from Deepak
>   - Remove tab usage
> ---
>  hw/riscv/riscv-iommu-bits.h       | 1 +
>  hw/riscv/riscv-iommu.c            | 3 ++-
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_bits.h           | 3 ++-
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/cpu_helper.c         | 3 ++-
>  target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
>  7 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 1017d73fc6e7368dae9bec7314e68cde707d4bad..47fe01bee58697544104cfe16=
618307ece236132 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
>  #define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
>  #define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SVRSW60T59B     BIT_ULL(14)
>  #define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
>  #define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
>  #define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index a877e5da84b66e3d1991bb70cc58e80d9d88d0d0..36eda95a1c6e149976c1bd60b=
9f6b4753682bc0a 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2355,7 +2355,8 @@ static void riscv_iommu_realize(DeviceState *dev, E=
rror **errp)
>      }
>      if (s->enable_g_stage) {
>          s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
> -                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
> +                  RISCV_IOMMU_CAP_SVRSW60T59B;
>      }
>
>      if (s->hpm_cntrs > 0) {
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501e585bc772f3004139db363426e1596..13f1f56d9583141d913aec923=
44148f2e627b491 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -228,6 +228,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b=
),
>      ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> @@ -1282,6 +1283,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
>      MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c6178111b827dddc15a18c66f2762c43bf..97384dcfa04f55e19c0da7774=
553fee80f6ebbb4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -675,7 +675,8 @@ typedef enum {
>  #define PTE_SOFT            0x300 /* Reserved for Software */
>  #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory t=
ypes */
>  #define PTE_N               0x8000000000000000ULL /* NAPOT translation *=
/
> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
> +#define PTE_RESERVED(svrsw60t59b)    \
> +    (svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Res=
erved bits */
>  #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>
>  /* Page table PPN shift amount */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 59f134a41924e361e0a5f7ede44214823fd971ba..ab61c1ccf214bdeaea41fbf81=
5909fad24d40124 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
>  BOOL_FIELD(ext_svinval)
>  BOOL_FIELD(ext_svnapot)
>  BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
>  BOOL_FIELD(ext_zdinx)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2ed69d7c2d21e59868fea9e9e77d6d36561dfb5f..3479a62cc7f3cedc6c127dc2d=
b8e01919e3a9f15 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1309,6 +1309,7 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>      bool svade =3D riscv_cpu_cfg(env)->ext_svade;
>      bool svadu =3D riscv_cpu_cfg(env)->ext_svadu;
>      bool adue =3D svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
> +    bool svrsw60t59b =3D riscv_cpu_cfg(env)->ext_svrsw60t59b;
>
>      if (first_stage && two_stage && env->virt_enabled) {
>          pbmte =3D pbmte && (env->henvcfg & HENVCFG_PBMTE);
> @@ -1376,7 +1377,7 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>          if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>              ppn =3D pte >> PTE_PPN_SHIFT;
>          } else {
> -            if (pte & PTE_RESERVED) {
> +            if (pte & PTE_RESERVED(svrsw60t59b)) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in=
 PTE: "
>                                "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_=
FMT_lx "\n",
>                                __func__, pte_addr, pte);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55fd9e5584581b20406a7dc66037d6d88f4cf86d..96201e15c6d409414db68ba97=
6ab944ba1c8f2fd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -830,6 +830,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->cfg.ext_ssctr =3D false;
>      }
>
> +    if (cpu->cfg.ext_svrsw60t59b &&
> +        (!cpu->cfg.mmu || mcc->def->misa_mxl_max =3D=3D MXL_RV32)) {
> +        error_setg(errp, "svrsw60t59b is not supported on RV32 and MMU-l=
ess platforms");
> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> @@ -1606,6 +1612,8 @@ static void riscv_init_max_cpu_extensions(Object *o=
bj)
>
>      if (env->misa_mxl !=3D MXL_RV32) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
> +    } else {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), fal=
se);
>      }
>
>      /*
>
> ---
> base-commit: f9a3def17b2a57679902c33064cf7853263db0ef
> change-id: 20250625-dev-alex-svrsw60b59b_v2-a6b7f85be62e
>
> Best regards,
> --
> Alexandre Ghiti <alexghiti@rivosinc.com>
>
>

