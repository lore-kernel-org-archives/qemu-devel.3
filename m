Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA2F532CB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 03:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4sWO-000178-TH; Mon, 23 Mar 2026 23:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w4sWM-00016g-Gx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:33:34 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1w4sWH-0000sT-Px
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:33:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3W3cCBsJpn8FzCA--.132S2;
 Tue, 24 Mar 2026 11:33:22 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwbJLzBcJpUNsEAA--.8411S2;
 Tue, 24 Mar 2026 11:33:08 +0800 (CST)
Message-ID: <5207b39c-074a-41d1-a2f1-26c7908d6da4@phytium.com.cn>
Date: Tue, 24 Mar 2026 11:33:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>
References: <cover.1773450180.git.15fengyuan@gmail.com>
 <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwbJLzBcJpUNsEAA--.8411S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWnBk3gBTwABsM
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZFy8GFyrtrWfGr4xXFW8Zwb_yoW8Kw48Co
 W3JF429wn3uw17u34jkrs7Jw12qay09an8AFWDJw40gF18KF15CayIyws8J3ZYkw1rKr97
 Xas7J34vqrZ7Cwn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Fengyuan,

On 2026/3/14 09:11, Fengyuan Yu wrote:
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>


As Chao said, you may need commit message here, also in patch #2.


> ---
>   MAINTAINERS                          |   6 +
>   tests/qtest/libqos/meson.build       |   3 +
>   tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-intel-iommu.h | 191 +++++++++++
>   4 files changed, 654 insertions(+)
>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 247799c817..876e00ff77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -151,6 +151,9 @@ F: target/i386/meson.build
>   F: tools/i386/
>   F: tests/functional/i386/
>   F: tests/functional/x86_64/
> +F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c
>   
>   X86 VM file descriptor change on reset test
>   M: Ani Sinha <anisinha@redhat.com>
> @@ -4026,6 +4029,9 @@ F: hw/i386/intel_iommu_accel.*
>   F: include/hw/i386/intel_iommu.h
>   F: tests/functional/x86_64/test_intel_iommu.py
>   F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c
> +


nit: there is a new line which is unnecessary.


Thanks,

Tao

>   
>   AMD-Vi Emulation
>   M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> index 4a69acad0d..96f2fc48b4 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -73,6 +73,9 @@ endif
>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>     libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>   endif
> +if config_all_devices.has_key('CONFIG_VTD')
> +  libqos_srcs += files('qos-intel-iommu.c')
> +endif
>   if config_all_devices.has_key('CONFIG_TPCI200')
>     libqos_srcs += files('tpci200.c')
>   endif
> diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
> new file mode 100644
> index 0000000000..b1baf5ea7c
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-intel-iommu.c
> @@ -0,0 +1,454 @@
> +/*
> + * QOS Intel IOMMU (VT-d) Module Implementation
> + *
> + * This module provides Intel IOMMU-specific helper functions for libqos tests.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +#include "tests/qtest/libqos/pci.h"
> +#include "qos-iommu-testdev.h"
> +#include "qos-intel-iommu.h"
> +
> +#define QVTD_AW_48BIT_ENCODING    2
> +
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
> +{
> +    return ctx->config.expected_result;
> +}
> +
> +uint32_t qvtd_build_dma_attrs(void)
> +{
> +    /*
> +     * VT-d obtains the Requester ID (Source ID) from PCI bus/devfn routing
> +     * via pci_device_iommu_address_space(), not from DMA attributes.
> +     *
> +     * For scalable mode, QEMU maps MemTxAttrs.pid==0 to PCI_NO_PASID,
> +     * then remaps PCI_NO_PASID to PASID_0 when root_scalable is set.
> +     * So returning 0 here implicitly selects PASID=0, which matches
> +     * the PASID entry we configure in qvtd_build_pasid_table_entry().
> +     *
> +     */
> +    return 0;
> +}
> +
> +static void qvtd_build_root_entry(QTestState *qts, uint8_t bus,
> +                                  uint64_t context_table_ptr,
> +                                  QVTDTransMode mode)
> +{
> +    uint64_t root_entry_addr = QVTD_ROOT_TABLE_BASE +
> +                               (bus * sizeof(VTDRootEntry));
> +    uint64_t lo, hi;
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /*
> +         * Scalable-mode Root Entry (Section 9.2):
> +         * lo = Lower Context Table Pointer + LP (Lower Present)
> +         * hi = Upper Context Table Pointer + UP (Upper Present)
> +         *
> +         * Lower table covers devfn 0-127, Upper covers devfn 128-255.
> +         * Only lower half is needed for test device (devfn < 128).
> +         */
> +        lo = (context_table_ptr & VTD_ROOT_ENTRY_CTP) | VTD_ROOT_ENTRY_P;
> +        hi = 0;  /* UP=0: upper context table not present */
> +    } else {
> +        /*
> +         * Legacy Root Entry (Section 9.1):
> +         * lo = Context Table Pointer + Present
> +         * hi = Reserved
> +         */
> +        lo = (context_table_ptr & VTD_ROOT_ENTRY_CTP) | VTD_ROOT_ENTRY_P;
> +        hi = 0;
> +    }
> +
> +    qtest_writeq(qts, root_entry_addr, lo);
> +    qtest_writeq(qts, root_entry_addr + 8, hi);
> +}
> +
> +static void qvtd_build_context_entry(QTestState *qts, uint16_t sid,
> +                                     QVTDTransMode mode, uint64_t ssptptr)
> +{
> +    uint8_t devfn = sid & 0xff;
> +    uint64_t context_entry_addr = QVTD_CONTEXT_TABLE_BASE +
> +                                 (devfn * VTD_CTX_ENTRY_LEGACY_SIZE);
> +    uint64_t lo, hi;
> +
> +    if (mode == QVTD_TM_LEGACY_PT) {
> +        /*
> +         * Pass-through mode (Section 9.3):
> +         * lo: P + FPD(=0, fault enabled) + TT(=Pass-through)
> +         * hi: DID + AW
> +         */
> +        lo = VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_PASS_THROUGH;
> +        hi = ((uint64_t)QVTD_DOMAIN_ID << 8) | QVTD_AW_48BIT_ENCODING;
> +    } else {
> +        /*
> +         * Translated mode (Section 9.3):
> +         * lo: P + FPD(=0, fault enabled) + TT(=Multi-level) + SSPTPTR
> +         * hi: DID + AW(=48-bit, 4-level)
> +         */
> +        lo = VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_MULTI_LEVEL |
> +             (ssptptr & VTD_CONTEXT_ENTRY_SSPTPTR);
> +        hi = ((uint64_t)QVTD_DOMAIN_ID << 8) | QVTD_AW_48BIT_ENCODING;
> +    }
> +
> +    qtest_writeq(qts, context_entry_addr, lo);
> +    qtest_writeq(qts, context_entry_addr + 8, hi);
> +}
> +
> +static void qvtd_build_scalable_context_entry(QTestState *qts, uint16_t sid)
> +{
> +    uint8_t devfn = sid & 0xff;
> +    uint64_t ce_addr = QVTD_CONTEXT_TABLE_BASE +
> +                       (devfn * VTD_CTX_ENTRY_SCALABLE_SIZE);
> +
> +    /*
> +     * Scalable-Mode Context Entry (Section 9.4), 32 bytes = 4 qwords:
> +     *
> +     * val[0]: P + FPD(=0) + DTE(=0) + PASIDE(=0) + PRE(=0) + HPTE(=0)
> +     *         + EPTR(=0) + PDTS(=0) + PASIDDIRPTR
> +     * val[1]: RID_PASID(=0) + PDTTE(=0) + PRE(=0) + RID_CG(=0)
> +     * val[2]: Reserved (must be 0)
> +     * val[3]: Reserved (must be 0)
> +     */
> +    qtest_writeq(qts, ce_addr,
> +                 (QVTD_PASID_DIR_BASE & VTD_PASID_DIR_BASE_ADDR_MASK) |
> +                 VTD_CONTEXT_ENTRY_P);
> +    qtest_writeq(qts, ce_addr + 8, 0);
> +    qtest_writeq(qts, ce_addr + 16, 0);
> +    qtest_writeq(qts, ce_addr + 24, 0);
> +}
> +
> +static void qvtd_build_pasid_dir_entry(QTestState *qts)
> +{
> +    uint64_t addr = QVTD_PASID_DIR_BASE +
> +                    VTD_PASID_DIR_INDEX(0) * VTD_PASID_DIR_ENTRY_SIZE;
> +
> +    /*
> +     * PASID Directory Entry (Section 9.5):
> +     * P + FPD(=0, fault enabled) + SMPTBLPTR
> +     */
> +    qtest_writeq(qts, addr,
> +                 (QVTD_PASID_TABLE_BASE & VTD_PASID_TABLE_BASE_ADDR_MASK) |
> +                 VTD_PASID_ENTRY_P);
> +}
> +
> +static void qvtd_build_pasid_table_entry(QTestState *qts, QVTDTransMode mode,
> +                                         uint64_t ptptr)
> +{
> +    uint64_t addr = QVTD_PASID_TABLE_BASE +
> +                    VTD_PASID_TABLE_INDEX(0) * VTD_PASID_ENTRY_SIZE;
> +    uint64_t val0, val1, val2;
> +
> +    /*
> +     * Scalable-Mode PASID Table Entry (Section 9.6), 64 bytes = 8 qwords:
> +     *
> +     * val[0]: P + FPD(=0) + AW + PGTT + SSADE(=0) + SSPTPTR
> +     * val[1]: DID + PWSNP(=0) + PGSNP(=0)
> +     *         + CD(=0) + EMTE(=0) + PAT(=0): Memory Type,
> +     *           all Reserved(0) since QEMU ECAP.MTS=0
> +     * val[2]: SRE(=0) + FSPM(=0, 4-level) + WPE(=0) + IGN + EAFE(=0) + FSPTPTR
> +     * val[3]: Reserved (must be 0)
> +     * val[4]: HPT fields, Reserved(0) since QEMU ECAP.HPTS=0
> +     * val[5]: HPT fields, Reserved(0) since QEMU ECAP.HPTS=0
> +     * val[6]: Reserved (must be 0)
> +     * val[7]: Reserved (must be 0)
> +     */
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_PT:
> +        val0 = VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_PT << 6);
> +        val1 = (uint64_t)QVTD_DOMAIN_ID;
> +        val2 = 0;
> +        break;
> +    case QVTD_TM_SCALABLE_SLT:
> +        val0 = VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_SST << 6) |
> +               ((uint64_t)QVTD_AW_48BIT_ENCODING << 2) |
> +               (ptptr & VTD_SM_PASID_ENTRY_SSPTPTR);
> +        val1 = (uint64_t)QVTD_DOMAIN_ID;
> +        val2 = 0;
> +        break;
> +    case QVTD_TM_SCALABLE_FLT:
> +        /*
> +         * val[2] fields for FLT (Section 9.6):
> +         * SRE(=0, user-level DMA only) + FSPM(=0, 4-level) +
> +         * WPE(=0, no supervisor write-protect) + IGN + EAFE(=0) + FSPTPTR
> +         */
> +        val0 = VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_FST << 6);
> +        val1 = (uint64_t)QVTD_DOMAIN_ID;
> +        val2 = ptptr & QVTD_SM_PASID_ENTRY_FSPTPTR;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    qtest_writeq(qts, addr, val0);
> +    qtest_writeq(qts, addr + 8, val1);
> +    qtest_writeq(qts, addr + 16, val2);
> +    qtest_writeq(qts, addr + 24, 0);
> +    qtest_writeq(qts, addr + 32, 0);
> +    qtest_writeq(qts, addr + 40, 0);
> +    qtest_writeq(qts, addr + 48, 0);
> +    qtest_writeq(qts, addr + 56, 0);
> +}
> +
> +/*
> + * VT-d second-level paging helpers.
> + * 4-level, 48-bit address space, 9 bits per level index.
> + */
> +static uint32_t qvtd_get_table_index(uint64_t iova, int level)
> +{
> +    int shift = VTD_PAGE_SHIFT + VTD_LEVEL_BITS * (level - 1);
> +
> +    return (iova >> shift) & ((1u << VTD_LEVEL_BITS) - 1);
> +}
> +
> +static uint64_t qvtd_get_table_addr(uint64_t base, int level, uint64_t iova)
> +{
> +    return base + (qvtd_get_table_index(iova, level) * QVTD_PTE_SIZE);
> +}
> +
> +static uint64_t qvtd_get_pte_attrs(void)
> +{
> +    /* Second-level: R/W in every paging entry (Section 3.7.1) */
> +    return VTD_SS_R | VTD_SS_W;
> +}
> +
> +static uint64_t qvtd_get_fl_pte_attrs(bool is_leaf)
> +{
> +    /* First-level: x86 page table format (VT-d spec Section 9.9) */
> +    uint64_t attrs = VTD_FS_P | VTD_FS_RW | VTD_FS_US | VTD_FS_A;
> +
> +    if (is_leaf) {
> +        attrs |= VTD_FS_D;
> +    }
> +    return attrs;
> +}
> +
> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
> +                                   QVTDTransMode mode)
> +{
> +    bool is_fl = (mode == QVTD_TM_SCALABLE_FLT);
> +    uint64_t non_leaf_attrs, leaf_attrs;
> +
> +    if (is_fl) {
> +        non_leaf_attrs = qvtd_get_fl_pte_attrs(false);
> +        leaf_attrs = qvtd_get_fl_pte_attrs(true);
> +    } else {
> +        /* Second-level: all levels use identical R/W attrs (spec 3.7.1) */
> +        non_leaf_attrs = qvtd_get_pte_attrs();
> +        leaf_attrs = non_leaf_attrs;
> +    }
> +
> +    g_test_message("Page table setup: IOVA=0x%" PRIx64
> +                   " PA=0x%" PRIx64 " %s",
> +                   (uint64_t)iova, (uint64_t)QVTD_PT_VAL,
> +                   is_fl ? "first-level" : "second-level");
> +
> +    /* PML4 (L4) -> PDPT (L3) -> PD (L2) -> PT (L1) -> PA */
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L4_BASE, 4, iova),
> +                 QVTD_PT_L3_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L3_BASE, 3, iova),
> +                 QVTD_PT_L2_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L2_BASE, 2, iova),
> +                 QVTD_PT_L1_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L1_BASE, 1, iova),
> +                 (QVTD_PT_VAL & VTD_PAGE_MASK_4K) | leaf_attrs);
> +}
> +
> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base,
> +                        QVTDTransMode mode)
> +{
> +    uint32_t gcmd = 0;
> +    uint64_t rtaddr = QVTD_ROOT_TABLE_BASE;
> +
> +    /* Set SMT bit for scalable mode (VT-d spec Section 9.1) */
> +    if (qvtd_is_scalable(mode)) {
> +        rtaddr |= VTD_RTADDR_SMT;
> +    }
> +
> +    /* Set Root Table Address */
> +    qtest_writeq(qts, iommu_base + DMAR_RTADDR_REG, rtaddr);
> +
> +    /* Set Root Table Pointer and verify */
> +    gcmd |= VTD_GCMD_SRTP;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_RTPS);
> +
> +    /* Setup Invalidation Queue */
> +    qtest_writeq(qts, iommu_base + DMAR_IQA_REG,
> +                 QVTD_IQ_BASE | QVTD_IQ_QS);
> +    qtest_writeq(qts, iommu_base + DMAR_IQH_REG, 0);
> +    qtest_writeq(qts, iommu_base + DMAR_IQT_REG, 0);
> +
> +    /* Enable Queued Invalidation and verify */
> +    gcmd |= VTD_GCMD_QIE;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_QIES);
> +
> +    /* Setup Fault Event MSI */
> +    qtest_writel(qts, iommu_base + DMAR_FECTL_REG, 0x0);
> +    qtest_writel(qts, iommu_base + DMAR_FEDATA_REG, QVTD_FAULT_IRQ_DATA);
> +    qtest_writel(qts, iommu_base + DMAR_FEADDR_REG, QVTD_FAULT_IRQ_ADDR);
> +
> +    /* Enable translation and verify */
> +    gcmd |= VTD_GCMD_TE;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_TES);
> +}
> +
> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
> +                                uint16_t sid)
> +{
> +    uint8_t bus = (sid >> 8) & 0xff;
> +
> +    g_test_message("Build translation: IOVA=0x%" PRIx64 " PA=0x%" PRIx64
> +                   " mode=%d",
> +                   (uint64_t)QVTD_IOVA, (uint64_t)QVTD_PT_VAL, mode);
> +
> +    /* Clear IOMMU structure regions to avoid stale entries */
> +    qtest_memset(qts, QVTD_ROOT_TABLE_BASE, 0, 0x1000);
> +    qtest_memset(qts, QVTD_PT_L4_BASE, 0, 0x4000);
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /* Scalable: 32B context entries need 8KB */
> +        qtest_memset(qts, QVTD_CONTEXT_TABLE_BASE, 0, 0x2000);
> +        qtest_memset(qts, QVTD_PASID_DIR_BASE, 0, 0x1000);
> +        qtest_memset(qts, QVTD_PASID_TABLE_BASE, 0, 0x1000);
> +    } else {
> +        qtest_memset(qts, QVTD_CONTEXT_TABLE_BASE, 0, 0x1000);
> +    }
> +
> +    qvtd_build_root_entry(qts, bus, QVTD_CONTEXT_TABLE_BASE, mode);
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /* Scalable path: context -> PASID dir -> PASID entry -> page tables */
> +        qvtd_build_scalable_context_entry(qts, sid);
> +        qvtd_build_pasid_dir_entry(qts);
> +
> +        if (mode == QVTD_TM_SCALABLE_PT) {
> +            qvtd_build_pasid_table_entry(qts, mode, 0);
> +        } else {
> +            qvtd_setup_translation_tables(qts, QVTD_IOVA, mode);
> +            qvtd_build_pasid_table_entry(qts, mode, QVTD_PT_L4_BASE);
> +        }
> +    } else {
> +        /* Legacy path */
> +        if (mode == QVTD_TM_LEGACY_PT) {
> +            qvtd_build_context_entry(qts, sid, mode, 0);
> +        } else {
> +            qvtd_setup_translation_tables(qts, QVTD_IOVA, mode);
> +            qvtd_build_context_entry(qts, sid, mode, QVTD_PT_L4_BASE);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx)
> +{
> +    uint32_t build_result;
> +
> +    /* Build translation structures first */
> +    build_result = qvtd_build_translation(ctx->qts, ctx->config.trans_mode,
> +                                          ctx->sid);
> +    if (build_result != 0) {
> +        g_test_message("Build failed: mode=%u sid=%u status=0x%x",
> +                       ctx->config.trans_mode, ctx->sid, build_result);
> +        ctx->trans_status = build_result;
> +        return ctx->trans_status;
> +    }
> +
> +    /* Program IOMMU registers (sets root table pointer, enables translation) */
> +    qvtd_program_regs(ctx->qts, ctx->iommu_base, ctx->config.trans_mode);
> +
> +    ctx->trans_status = 0;
> +    return ctx->trans_status;
> +}
> +
> +static bool qvtd_validate_test_result(QVTDTestContext *ctx)
> +{
> +    uint32_t expected = qvtd_expected_dma_result(ctx);
> +
> +    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
> +                   expected, ctx->dma_result);
> +    return (ctx->dma_result == expected);
> +}
> +
> +static uint32_t qvtd_single_translation_setup(void *opaque)
> +{
> +    return qvtd_setup_and_enable_translation(opaque);
> +}
> +
> +static uint32_t qvtd_single_translation_attrs(void *opaque)
> +{
> +    return qvtd_build_dma_attrs();
> +}
> +
> +static bool qvtd_single_translation_validate(void *opaque)
> +{
> +    return qvtd_validate_test_result(opaque);
> +}
> +
> +static void qvtd_single_translation_report(void *opaque, uint32_t dma_result)
> +{
> +    QVTDTestContext *ctx = opaque;
> +
> +    if (dma_result != 0) {
> +        g_test_message("DMA failed: mode=%u result=0x%x",
> +                       ctx->config.trans_mode, dma_result);
> +    } else {
> +        g_test_message("-> DMA succeeded: mode=%u",
> +                       ctx->config.trans_mode);
> +    }
> +}
> +
> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                               QPCIBar bar, uint64_t iommu_base,
> +                               const QVTDTestConfig *cfg)
> +{
> +    QVTDTestContext ctx = {
> +        .qts = qts,
> +        .dev = dev,
> +        .bar = bar,
> +        .iommu_base = iommu_base,
> +        .config = *cfg,
> +        .sid = dev->devfn,
> +    };
> +
> +    QOSIOMMUTestdevDmaCfg dma = {
> +        .dev = dev,
> +        .bar = bar,
> +        .iova = QVTD_IOVA,
> +        .gpa = cfg->dma_gpa,
> +        .len = cfg->dma_len,
> +    };
> +
> +    qtest_memset(qts, cfg->dma_gpa, 0x00, cfg->dma_len);
> +    qos_iommu_testdev_single_translation(&dma, &ctx,
> +                                         qvtd_single_translation_setup,
> +                                         qvtd_single_translation_attrs,
> +                                         qvtd_single_translation_validate,
> +                                         qvtd_single_translation_report,
> +                                         &ctx.dma_result);
> +
> +    if (ctx.dma_result == 0 && ctx.config.expected_result == 0) {
> +        g_autofree uint8_t *buf = NULL;
> +
> +        buf = g_malloc(ctx.config.dma_len);
> +        qtest_memread(ctx.qts, ctx.config.dma_gpa, buf, ctx.config.dma_len);
> +
> +        for (int i = 0; i < ctx.config.dma_len; i++) {
> +            uint8_t expected;
> +
> +            expected = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +            g_assert_cmpuint(buf[i], ==, expected);
> +        }
> +    }
> +}
> diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qos-intel-iommu.h
> new file mode 100644
> index 0000000000..04450165af
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-intel-iommu.h
> @@ -0,0 +1,191 @@
> +/*
> + * QOS Intel IOMMU (VT-d) Module
> + *
> + * This module provides Intel IOMMU-specific helper functions for libqos tests,
> + * encapsulating VT-d setup, assertion, and cleanup operations.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QTEST_LIBQOS_INTEL_IOMMU_H
> +#define QTEST_LIBQOS_INTEL_IOMMU_H
> +
> +#include "hw/misc/iommu-testdev.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +
> +/*
> + * Intel IOMMU MMIO register base. This is the standard Q35 IOMMU address.
> + */
> +#define Q35_IOMMU_BASE            0xfed90000ULL
> +
> +/*
> + * Guest memory layout for IOMMU structures.
> + * All structures are placed in guest physical memory inside the 512MB RAM.
> + * Using 256MB mark (0x10000000) as base to ensure all structures fit in RAM.
> + */
> +#define QVTD_MEM_BASE             0x10000000ULL
> +
> +/* Root Entry Table: 256 entries * 16 bytes = 4KB */
> +#define QVTD_ROOT_TABLE_BASE      (QVTD_MEM_BASE + 0x00000000)
> +
> +/* Context Entry Table: 256 entries, 16B (legacy) or 32B (scalable) per entry */
> +#define QVTD_CONTEXT_TABLE_BASE   (QVTD_MEM_BASE + 0x00001000)
> +
> +/* Page Tables: 4-level hierarchy for 48-bit address translation */
> +#define QVTD_PT_L4_BASE           (QVTD_MEM_BASE + 0x00010000)  /* PML4 */
> +#define QVTD_PT_L3_BASE           (QVTD_MEM_BASE + 0x00011000)  /* PDPT */
> +#define QVTD_PT_L2_BASE           (QVTD_MEM_BASE + 0x00012000)  /* PD */
> +#define QVTD_PT_L1_BASE           (QVTD_MEM_BASE + 0x00013000)  /* PT */
> +
> +/*
> + * Invalidation Queue.
> + * IQA_REG bits[2:0] = QS, entries = 1 << (QS + 8), each entry 16 bytes.
> + */
> +#define QVTD_IQ_BASE              (QVTD_MEM_BASE + 0x00020000)
> +#define QVTD_IQ_QS                0    /* QS=0 → 256 entries */
> +
> +/*
> + * Fault Event MSI configuration.
> + */
> +#define QVTD_FAULT_IRQ_ADDR       0xfee00000   /* APIC base */
> +#define QVTD_FAULT_IRQ_DATA       0x0
> +
> +/* Scalable mode PASID structures */
> +#define QVTD_PASID_DIR_BASE        (QVTD_MEM_BASE + 0x00030000)
> +#define QVTD_PASID_TABLE_BASE      (QVTD_MEM_BASE + 0x00031000)
> +
> +/* Page table entry size (8 bytes per PTE) */
> +#define QVTD_PTE_SIZE             sizeof(uint64_t)
> +
> +/* FSPTPTR mask: same as VTD_SM_PASID_ENTRY_SSPTPTR, bits[63:12] */
> +#define QVTD_SM_PASID_ENTRY_FSPTPTR   VTD_SM_PASID_ENTRY_SSPTPTR
> +
> +/* Default Domain ID for single-domain tests */
> +#define QVTD_DOMAIN_ID            0
> +
> +/* Test IOVA and target physical address */
> +#define QVTD_IOVA                 0x0000000010200567ull
> +#define QVTD_PT_VAL               (QVTD_MEM_BASE + 0x00100000)
> +
> +/*
> + * Translation modes supported by Intel IOMMU
> + */
> +typedef enum QVTDTransMode {
> +    QVTD_TM_LEGACY_PT,          /* Legacy pass-through mode */
> +    QVTD_TM_LEGACY_TRANS,       /* Legacy translated mode (4-level paging) */
> +    QVTD_TM_SCALABLE_PT,        /* Scalable pass-through mode */
> +    QVTD_TM_SCALABLE_SLT,       /* Scalable Second Level Translation */
> +    QVTD_TM_SCALABLE_FLT,       /* Scalable First Level Translation */
> +    QVTD_TM_SCALABLE_NESTED,    /* Scalable Nested Translation */
> +} QVTDTransMode;
> +
> +static inline bool qvtd_is_scalable(QVTDTransMode mode)
> +{
> +    return mode == QVTD_TM_SCALABLE_PT ||
> +           mode == QVTD_TM_SCALABLE_SLT ||
> +           mode == QVTD_TM_SCALABLE_FLT;
> +}
> +
> +typedef struct QVTDTestConfig {
> +    QVTDTransMode trans_mode;     /* Translation mode */
> +    uint64_t dma_gpa;             /* GPA for readback validation */
> +    uint32_t dma_len;             /* DMA length for testing */
> +    uint32_t expected_result;     /* Expected DMA result */
> +} QVTDTestConfig;
> +
> +typedef struct QVTDTestContext {
> +    QTestState *qts;              /* QTest state handle */
> +    QPCIDevice *dev;              /* PCI device handle */
> +    QPCIBar bar;                  /* PCI BAR for MMIO access */
> +    QVTDTestConfig config;        /* Test configuration */
> +    uint64_t iommu_base;          /* Intel IOMMU base address */
> +    uint32_t trans_status;        /* Translation configuration status */
> +    uint32_t dma_result;          /* DMA operation result */
> +    uint16_t sid;                 /* Source ID (bus:devfn) */
> +} QVTDTestContext;
> +
> +/*
> + * qvtd_setup_and_enable_translation - Complete translation setup and enable
> + *
> + * @ctx: Test context containing configuration and device handles
> + *
> + * Returns: Translation status (0 = success, non-zero = error)
> + *
> + * This function performs the complete translation setup sequence:
> + * 1. Builds VT-d structures (root/context entry, page tables)
> + * 2. Programs IOMMU registers and enables translation
> + * 3. Returns configuration status
> + */
> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx);
> +
> +/*
> + * qvtd_build_translation - Build Intel IOMMU translation structures
> + *
> + * @qts: QTest state handle
> + * @mode: Translation mode (pass-through or translated)
> + * @sid: Source ID (bus:devfn)
> + *
> + * Returns: Build status (0 = success, non-zero = error)
> + *
> + * Constructs all necessary VT-d translation structures in guest memory:
> + * - Root Entry for the device's bus
> + * - Context Entry for the device
> + * - Complete 4-level page table hierarchy (if translated mode)
> + */
> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
> +                                uint16_t sid);
> +
> +/*
> + * qvtd_program_regs - Program Intel IOMMU registers and enable translation
> + *
> + * @qts: QTest state handle
> + * @iommu_base: IOMMU base address
> + * @mode: Translation mode (scalable modes set RTADDR SMT bit)
> + *
> + * Programs IOMMU registers with the following sequence:
> + * 1. Set root table pointer (SRTP), with SMT bit for scalable mode
> + * 2. Setup invalidation queue (QIE)
> + * 3. Configure fault event MSI
> + * 4. Enable translation (TE)
> + *
> + * Each step verifies completion via GSTS register read-back.
> + */
> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base,
> +                        QVTDTransMode mode);
> +
> +/*
> + * qvtd_setup_translation_tables - Setup complete VT-d page table hierarchy
> + *
> + * @qts: QTest state handle
> + * @iova: Input Virtual Address to translate
> + * @mode: Translation mode
> + *
> + * This builds the 4-level page table structure for translating
> + * the given IOVA to PA through Intel VT-d. The structure is:
> + * - PML4 (Level 4): IOVA bits [47:39]
> + * - PDPT (Level 3): IOVA bits [38:30]
> + * - PD (Level 2): IOVA bits [29:21]
> + * - PT (Level 1): IOVA bits [20:12]
> + * - Page offset: IOVA bits [11:0]
> + *
> + * The function writes all necessary Page Table Entries (PTEs) to guest
> + * memory using qtest_writeq(), setting up the complete translation path
> + * that the VT-d hardware will traverse during DMA operations.
> + */
> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
> +                                   QVTDTransMode mode);
> +
> +/* Calculate expected DMA result */
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx);
> +
> +/* Build DMA attributes for Intel VT-d */
> +uint32_t qvtd_build_dma_attrs(void);
> +
> +/* High-level test execution helpers */
> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                               QPCIBar bar, uint64_t iommu_base,
> +                               const QVTDTestConfig *cfg);
> +
> +#endif /* QTEST_LIBQOS_INTEL_IOMMU_H */


