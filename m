Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE9CD46C01
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 02:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlHKS-0006bE-Sy; Wed, 28 Jan 2026 21:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlHKP-0006a6-RF; Wed, 28 Jan 2026 21:00:13 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlHKL-0001iX-5a; Wed, 28 Jan 2026 21:00:13 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHjSUcv3ppNk55Aw--.22340S2;
 Thu, 29 Jan 2026 09:59:56 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXrusJv3ppsHEXAA--.26853S2;
 Thu, 29 Jan 2026 09:59:44 +0800 (CST)
Message-ID: <7377fc98-c2f2-44d9-bb5e-0ea81fe7a369@phytium.com.cn>
Date: Thu, 29 Jan 2026 09:59:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] tests/qtest/libqos: Add RISC-V IOMMU helper
 library
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
 <bf2b4f9cfe1484b0cde5540f518f74f9fc878c8d.1769600111.git.chao.liu.zevorn@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <bf2b4f9cfe1484b0cde5540f518f74f9fc878c8d.1769600111.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwBXrusJv3ppsHEXAA--.26853S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWl6bYMA7gAAsd
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWfGry7Zw43Cw1kCw45Jr4xWFg_yoWktryxpF
 y8G3sayryftFyfJFn3Xr1jkF1Yvanrua4Yvr13GF4vkFZ7XrWIva4DtryFkrs3WrW8Jw18
 Zw4Ygr4DGr4YqFDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Chao,

On 2026/1/28 20:09, Chao Liu wrote:
> Introduce a libqos helper module for RISC-V IOMMU testing with
> iommu-testdev. The helper provides routines to:
>
> - Build device contexts (DC) and 3-level page tables for SV39/SV39x4
> - Program command queue (CQ), fault queue (FQ), and DDTP registers
>    following the RISC-V IOMMU specification
> - Execute DMA translations and verify results
>
> The current implementation supports SV39 for S-stage and SV39x4 for
> G-stage translation. Support for SV48/SV48x4/SV57/SV57x4 can be added
> in future patches.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   MAINTAINERS                          |   1 +
>   tests/qtest/libqos/meson.build       |   2 +-
>   tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
>   4 files changed, 574 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc31be033e..894e05bd2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3583,6 +3583,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
>   S: Maintained
>   F: tests/qtest/libqos/qos-iommu*
>   F: tests/qtest/libqos/qos-smmuv3*
> +F: tests/qtest/libqos/qos-riscv-iommu*
>   
>   Device Fuzzing
>   M: Alexander Bulekov <alxndr@bu.edu>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> index b4daec808f..4a69acad0d 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -71,7 +71,7 @@ if have_virtfs
>   endif
>   
>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
> -  libqos_srcs += files('riscv-iommu.c')
> +  libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>   endif
>   if config_all_devices.has_key('CONFIG_TPCI200')
>     libqos_srcs += files('tpci200.c')
> diff --git a/tests/qtest/libqos/qos-riscv-iommu.c b/tests/qtest/libqos/qos-riscv-iommu.c
> new file mode 100644
> index 0000000000..34ed3df84a
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-riscv-iommu.c
> @@ -0,0 +1,400 @@
> +/*
> + * QOS RISC-V IOMMU Module
> + *
> + * This module provides RISC-V IOMMU-specific helper functions for libqos tests,
> + * encapsulating RISC-V IOMMU setup, and assertions.
> + *
> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "tests/qtest/libqos/pci.h"
> +#include "qos-iommu-testdev.h"
> +#include "qos-riscv-iommu.h"
> +
> +/* Apply space offset to address */
> +static inline uint64_t qriommu_apply_space_offs(uint64_t address)
> +{
> +    return address + QRIOMMU_SPACE_OFFS;
> +}
> +
> +static uint64_t qriommu_encode_pte(uint64_t pa, uint64_t attrs)
> +{
> +    return ((pa >> 12) << 10) | attrs;
> +}
> +
> +static void qriommu_wait_for_queue_active(QTestState *qts, uint64_t iommu_base,
> +                                          uint32_t queue_csr, uint32_t on_bit)
> +{
> +    guint64 timeout_us = 2 * 1000 * 1000;
> +    gint64 start_time = g_get_monotonic_time();
> +    uint32_t reg;
> +
> +    for (;;) {
> +        qtest_clock_step(qts, 100);
> +
> +        reg = qtest_readl(qts, iommu_base + queue_csr);
> +        if (reg & on_bit) {
> +            return;
> +        }
> +        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
> +    }
> +}
> +
> +uint32_t qriommu_expected_dma_result(QRIOMMUTestContext *ctx)
> +{
> +    return ctx->config.expected_result;
> +}
> +
> +uint32_t qriommu_build_dma_attrs(void)
> +{
> +    /* RISC-V IOMMU uses standard AXI attributes */
> +    return 0;
> +}
> +
> +uint32_t qriommu_setup_and_enable_translation(QRIOMMUTestContext *ctx)
> +{
> +    uint32_t build_result;
> +
> +    /* Build page tables and RISC-V IOMMU structures first */
> +    build_result = qriommu_build_translation(
> +                       ctx->qts, ctx->config.trans_mode,
> +                       ctx->device_id);
> +    if (build_result != 0) {
> +        g_test_message("Build failed: mode=%u device_id=%u status=0x%x",
> +                       ctx->config.trans_mode, ctx->device_id, build_result);
> +        ctx->trans_status = build_result;
> +        return ctx->trans_status;
> +    }
> +
> +    /* Program RISC-V IOMMU registers */
> +    qriommu_program_regs(ctx->qts, ctx->iommu_base);
> +
> +    ctx->trans_status = 0;
> +    return ctx->trans_status;
> +}
> +
> +static bool qriommu_validate_test_result(QRIOMMUTestContext *ctx)
> +{
> +    uint32_t expected = qriommu_expected_dma_result(ctx);
> +    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
> +                   expected, ctx->dma_result);
> +    return (ctx->dma_result == expected);
> +}
> +
> +static uint32_t qriommu_single_translation_setup(void *opaque)
> +{
> +    return qriommu_setup_and_enable_translation(opaque);
> +}
> +
> +static uint32_t qriommu_single_translation_attrs(void *opaque)
> +{
> +    return qriommu_build_dma_attrs();
> +}
> +
> +static bool qriommu_single_translation_validate(void *opaque)
> +{
> +    return qriommu_validate_test_result(opaque);
> +}
> +
> +static void qriommu_single_translation_report(void *opaque,
> +                                              uint32_t dma_result)
> +{
> +    QRIOMMUTestContext *ctx = opaque;
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
> +void qriommu_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                                  QPCIBar bar, uint64_t iommu_base,
> +                                  const QRIOMMUTestConfig *cfg)
> +{
> +    QRIOMMUTestContext ctx = {
> +        .qts = qts,
> +        .dev = dev,
> +        .bar = bar,
> +        .iommu_base = iommu_base,
> +        .config = *cfg,
> +        .device_id = dev->devfn,
> +    };
> +
> +    QOSIOMMUTestdevDmaCfg dma = {
> +        .dev = dev,
> +        .bar = bar,
> +        .iova = QRIOMMU_IOVA,
> +        .gpa = ctx.config.dma_gpa,
> +        .len = ctx.config.dma_len,
> +    };
> +
> +    qtest_memset(qts, cfg->dma_gpa, 0x00, cfg->dma_len);
> +    qos_iommu_testdev_single_translation(&dma, &ctx,
> +                                         qriommu_single_translation_setup,
> +                                         qriommu_single_translation_attrs,
> +                                         qriommu_single_translation_validate,
> +                                         qriommu_single_translation_report,
> +                                         &ctx.dma_result);
> +
> +    if (ctx.dma_result == 0 && ctx.config.expected_result == 0) {
> +        g_autofree uint8_t *buf = NULL;


Declarations should be at the beginning of blocks. See `Declarations` in 
docs/devel/style.rst. And we also had some discussion in another thread. 
As Alex mentioned in the thread below:

https://lore.kernel.org/qemu-devel/875xb8l4ns.fsf@draig.linaro.org/

> +
> +        buf = g_malloc(ctx.config.dma_len);
> +        qtest_memread(ctx.qts, ctx.config.dma_gpa, buf, ctx.config.dma_len);
> +
> +        for (int i = 0; i < ctx.config.dma_len; i++) {


This is correct. It is explicitly allowed by the special exemption for 
loop variables inside for loops in style.rst.

> +            uint8_t expected;
> +
> +            expected = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +            g_assert_cmpuint(buf[i], ==, expected);
> +        }
> +    }
> +}
> +
> +static uint32_t qriommu_get_table_index(uint64_t addr, int level)
> +{
> +    /* SV39: 39-bit virtual address, 3-level page table */
> +    switch (level) {
> +    case 0:
> +        return (addr >> 30) & 0x1ff;   /* L0: bits [38:30] */
> +    case 1:
> +        return (addr >> 21) & 0x1ff;   /* L1: bits [29:21] */
> +    case 2:
> +        return (addr >> 12) & 0x1ff;   /* L2: bits [20:12] */
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static uint64_t qriommu_get_table_addr(uint64_t base, int level, uint64_t iova)
> +{
> +    uint32_t index = qriommu_get_table_index(iova, level);
> +    return (base & QRIOMMU_PTE_PPN_MASK) + (index * 8);
> +}
> +
> +static void qriommu_map_leaf(QTestState *qts, uint64_t root_pa,
> +                             uint64_t l0_pa, uint64_t l1_pa,
> +                             uint64_t l0_pte_val, uint64_t l1_pte_val,
> +                             uint64_t va, uint64_t pa, uint64_t leaf_attrs)
> +{
> +    uint64_t l0_addr = qriommu_get_table_addr(root_pa, 0, va);
> +    uint64_t l1_addr = qriommu_get_table_addr(l0_pa, 1, va);
> +    uint64_t l2_addr = qriommu_get_table_addr(l1_pa, 2, va);
> +
> +    qtest_writeq(qts, l0_addr, l0_pte_val);
> +    qtest_writeq(qts, l1_addr, l1_pte_val);
> +    qtest_writeq(qts, l2_addr, qriommu_encode_pte(pa, leaf_attrs));
> +}
> +
> +static uint64_t qriommu_get_pte_attrs(QRIOMMUTransMode mode, bool is_leaf)
> +{
> +    if (!is_leaf) {
> +        return QRIOMMU_NON_LEAF_PTE_MASK;
> +    }
> +
> +    /* For leaf PTE, set RWX permissions */
> +    return QRIOMMU_LEAF_PTE_RW_MASK;
> +}
> +
> +void qriommu_setup_translation_tables(QTestState *qts,
> +                                      uint64_t iova,
> +                                      QRIOMMUTransMode mode)
> +{
> +    uint64_t s_root = 0, s_l0_pte_val = 0, s_l1_pte_val = 0;
> +    uint64_t s_l0_addr = 0, s_l1_addr = 0, s_l2_addr = 0, s_l2_pte_val = 0;
> +    uint64_t s_l0_pa = 0, s_l1_pa = 0;
> +    uint64_t s_l2_pa = qriommu_apply_space_offs(QRIOMMU_L2_PTE_VAL);
> +    uint64_t s_l0_pa_real = 0, s_l1_pa_real = 0;
> +    uint64_t s_l2_pa_real = qriommu_apply_space_offs(QRIOMMU_L2_PTE_VAL);
> +    uint64_t non_leaf_attrs = qriommu_get_pte_attrs(mode, false);
> +    uint64_t leaf_attrs = qriommu_get_pte_attrs(mode, true);
> +
> +    if (mode != QRIOMMU_TM_G_STAGE_ONLY) {
> +        /* Setup S-stage 3-level page tables (SV39) */
> +        s_l0_pa = qriommu_apply_space_offs(QRIOMMU_L0_PTE_VAL);
> +        s_l1_pa = qriommu_apply_space_offs(QRIOMMU_L1_PTE_VAL);
> +        s_root = qriommu_apply_space_offs(
> +            QRIOMMU_IOHGATP & QRIOMMU_PTE_PPN_MASK);
> +        s_l2_pa = qriommu_apply_space_offs(QRIOMMU_L2_PTE_VAL);
> +
> +        s_l0_pa_real = s_l0_pa;
> +        s_l1_pa_real = s_l1_pa;
> +        s_l2_pa_real = s_l2_pa;
> +
> +        if (mode == QRIOMMU_TM_NESTED) {
> +            s_l0_pa = QRIOMMU_L0_PTE_VAL;
> +            s_l1_pa = QRIOMMU_L1_PTE_VAL;
> +            s_l2_pa = QRIOMMU_L2_PTE_VAL;
> +
> +            s_l0_pa_real = qriommu_apply_space_offs(QRIOMMU_L0_PTE_VAL);
> +            s_l1_pa_real = qriommu_apply_space_offs(QRIOMMU_L1_PTE_VAL);
> +            s_l2_pa_real = qriommu_apply_space_offs(QRIOMMU_L2_PTE_VAL);
> +        }
> +
> +        s_l0_pte_val = qriommu_encode_pte(s_l0_pa, non_leaf_attrs);
> +        s_l1_pte_val = qriommu_encode_pte(s_l1_pa, non_leaf_attrs);
> +
> +        s_l0_addr = qriommu_get_table_addr(s_root, 0, iova);
> +        qtest_writeq(qts, s_l0_addr, s_l0_pte_val);
> +
> +        s_l1_addr = qriommu_get_table_addr(s_l0_pa_real, 1, iova);
> +        qtest_writeq(qts, s_l1_addr, s_l1_pte_val);
> +
> +        s_l2_addr = qriommu_get_table_addr(s_l1_pa_real, 2, iova);
> +        s_l2_pte_val = qriommu_encode_pte(s_l2_pa, leaf_attrs);
> +        qtest_writeq(qts, s_l2_addr, s_l2_pte_val);
> +    }
> +
> +    if (mode == QRIOMMU_TM_G_STAGE_ONLY || mode == QRIOMMU_TM_NESTED) {
> +        uint64_t g_root = qriommu_apply_space_offs(


Same style issue in this if block.


Thanks,

Tao

> +            QRIOMMU_G_IOHGATP & QRIOMMU_PTE_PPN_MASK);
> +        uint64_t g_l0_pa = qriommu_apply_space_offs(QRIOMMU_G_L0_PTE_VAL);
> +        uint64_t g_l1_pa = qriommu_apply_space_offs(QRIOMMU_G_L1_PTE_VAL);
> +        uint64_t g_l0_pte_val = qriommu_encode_pte(g_l0_pa, non_leaf_attrs);
> +        uint64_t g_l1_pte_val = qriommu_encode_pte(g_l1_pa, non_leaf_attrs);
> +
> +        if (mode == QRIOMMU_TM_G_STAGE_ONLY) {
> +            qriommu_map_leaf(qts, g_root, g_l0_pa, g_l1_pa,
> +                             g_l0_pte_val, g_l1_pte_val,
> +                             iova, s_l2_pa_real, leaf_attrs);
> +        } else {
> +            qriommu_map_leaf(qts, g_root, g_l0_pa, g_l1_pa,
> +                             g_l0_pte_val, g_l1_pte_val,
> +                             QRIOMMU_IOHGATP, s_root, leaf_attrs);
> +            qriommu_map_leaf(qts, g_root, g_l0_pa, g_l1_pa,
> +                             g_l0_pte_val, g_l1_pte_val,
> +                             QRIOMMU_L0_PTE_VAL, s_l0_pa_real, leaf_attrs);
> +            qriommu_map_leaf(qts, g_root, g_l0_pa, g_l1_pa,
> +                             g_l0_pte_val, g_l1_pte_val,
> +                             QRIOMMU_L1_PTE_VAL, s_l1_pa_real, leaf_attrs);
> +            qriommu_map_leaf(qts, g_root, g_l0_pa, g_l1_pa,
> +                             g_l0_pte_val, g_l1_pte_val,
> +                             QRIOMMU_L2_PTE_VAL, s_l2_pa_real, leaf_attrs);
> +        }
> +    }
> +}


