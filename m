Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56383C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsRc-00046X-HI; Wed, 02 Jul 2025 04:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWsRZ-000467-Vz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:03:50 -0400
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWsRP-0007B0-51
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751443397;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=OOAFkSN6vLzhY6gF76/yoOZRVJiJqaeV4MIlzvdixf4=;
 b=DJlueTNONzqfsLCgkocfegWv3hzML7ZaLLE58jEv5gJjiNcMS89Gl9chzoIiDNZrVuOd3k
 D/eOZoWbpWnwobXLXLNI5xtIL02OHEm9TA4g0tqyit9DXWqlj1t4qgl/algP5eIZEU4zdH
 SgCFcwhSx6e6LZMaZPTyu2yAI9TX/TTHR8GLoYAktinQkbq7yQZIy69dny1OM4W0O3Pj82
 xNrrt+tlUo1akn8JN6trcHcv+o9Lb9uQ9IRK6iiLDKRU5s/EvzkSLtRx02+VXYuZ7MZuFn
 GNFjI9o8baREm5ZyA32NifKI50G8FvqYROu9uRQzdNGCbpJdjmh5PRKGOmWIUA==
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26864e7c3+2da66a+nongnu.org+liujingqi@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH v2] target: riscv: Add Svrsw60t59b extension support
Content-Language: en-US
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Wed, 02 Jul 2025 16:03:14 +0800
To: "Alexandre Ghiti" <alexghiti@rivosinc.com>, <qemu-devel@nongnu.org>
Date: Wed, 2 Jul 2025 16:03:13 +0800
Message-Id: <1a536efb-4665-4842-a6f1-311799dfa085@lanxincomputing.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
References: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
In-Reply-To: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, 
 "Deepak Gupta" <debug@rivosinc.com>
Received-SPF: pass client-ip=118.26.132.22;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-22.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/2/2025 3:28 PM, Alexandre Ghiti wrote:
> The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
> for software to use.
>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> Changes in v2:
>    - Fix riscv32 max config (thanks Daniel!)
>    - Add RB from Deepak
>    - Remove tab usage
> ---
>   hw/riscv/riscv-iommu-bits.h       | 1 +
>   hw/riscv/riscv-iommu.c            | 3 ++-
>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_bits.h           | 3 ++-
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/cpu_helper.c         | 3 ++-
>   target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
>   7 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 1017d73fc6e7368dae9bec7314e68cde707d4bad..47fe01bee58697544104cfe16618307ece236132 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
>   #define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
>   #define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
>   #define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SVRSW60T59B     BIT_ULL(14)
>   #define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
>   #define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
>   #define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index a877e5da84b66e3d1991bb70cc58e80d9d88d0d0..36eda95a1c6e149976c1bd60b9f6b4753682bc0a 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2355,7 +2355,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>       }
>       if (s->enable_g_stage) {
>           s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
> -                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
> +                  RISCV_IOMMU_CAP_SVRSW60T59B;
>       }
>   
>       if (s->hpm_cntrs > 0) {
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501e585bc772f3004139db363426e1596..13f1f56d9583141d913aec92344148f2e627b491 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -228,6 +228,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> @@ -1282,6 +1283,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>       MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>       MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
>       MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>   
>       MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c6178111b827dddc15a18c66f2762c43bf..97384dcfa04f55e19c0da7774553fee80f6ebbb4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -675,7 +675,8 @@ typedef enum {
>   #define PTE_SOFT            0x300 /* Reserved for Software */
>   #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
>   #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
> +#define PTE_RESERVED(svrsw60t59b)    \
> +    (svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
>   #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>   
>   /* Page table PPN shift amount */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59f134a41924e361e0a5f7ede44214823fd971ba..ab61c1ccf214bdeaea41fbf815909fad24d40124 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
>   BOOL_FIELD(ext_svinval)
>   BOOL_FIELD(ext_svnapot)
>   BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_svrsw60t59b)
>   BOOL_FIELD(ext_svvptc)
>   BOOL_FIELD(ext_svukte)
>   BOOL_FIELD(ext_zdinx)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2ed69d7c2d21e59868fea9e9e77d6d36561dfb5f..3479a62cc7f3cedc6c127dc2db8e01919e3a9f15 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1309,6 +1309,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       bool svade = riscv_cpu_cfg(env)->ext_svade;
>       bool svadu = riscv_cpu_cfg(env)->ext_svadu;
>       bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
> +    bool svrsw60t59b = riscv_cpu_cfg(env)->ext_svrsw60t59b;
>   
>       if (first_stage && two_stage && env->virt_enabled) {
>           pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
> @@ -1376,7 +1377,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           if (riscv_cpu_sxl(env) == MXL_RV32) {
>               ppn = pte >> PTE_PPN_SHIFT;
>           } else {
> -            if (pte & PTE_RESERVED) {
> +            if (pte & PTE_RESERVED(svrsw60t59b)) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
>                                 "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
>                                 __func__, pte_addr, pte);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55fd9e5584581b20406a7dc66037d6d88f4cf86d..96201e15c6d409414db68ba976ab944ba1c8f2fd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -830,6 +830,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu->cfg.ext_ssctr = false;
>       }
>   
> +    if (cpu->cfg.ext_svrsw60t59b &&
> +        (!cpu->cfg.mmu || mcc->def->misa_mxl_max == MXL_RV32)) {
> +        error_setg(errp, "svrsw60t59b is not supported on RV32 and MMU-less platforms");
> +        return;
> +    }
> +
>       /*
>        * Disable isa extensions based on priv spec after we
>        * validated and set everything we need.
> @@ -1606,6 +1612,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>   
>       if (env->misa_mxl != MXL_RV32) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
> +    } else {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), false);
>       }
>   
>       /*
>
> ---
> base-commit: f9a3def17b2a57679902c33064cf7853263db0ef
> change-id: 20250625-dev-alex-svrsw60b59b_v2-a6b7f85be62e
>
> Best regards,

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

