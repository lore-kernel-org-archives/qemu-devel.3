Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E88BEE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPwh-0000q6-Pr; Fri, 06 Feb 2026 12:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1voPwd-0000ml-VT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:40 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1voPwa-0005LB-Oo
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:39 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-88a288811a4so25274206d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770400115; x=1771004915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYaICE5cuovYZkR50vMC/cPaORV4kMk0hRpV1zUEkEU=;
 b=IPDY2c6RbNI0DNKTKmuglB7P/S9oPUIYqOa/r2UM90YgLvk8Hkk+UYef934krhgTI/
 p+6+UOgahBoHMJ36N/jZRPtOyDd7bi65AoHlbl6IBcpdbX1IjKLcGtwdRRuaziUkXs1O
 UO1bvS3+Y2MOKuEAZAiTzndImme6M9L5GdG0mt52qzrdkO3OHwrN+my3IWDHvYde0For
 DP6J6hSppYsLxZtA/nocWHZFtuBGEQd5UGqCV5hYrleFbHqxiTIKgUf4swNVd/M5oHQ6
 N2E2s8nq6URy8LOSs/DsMPlJr7L48j/E2uRZ+sGXJBpS2vMSz0h/Wvssws0fUe09Whsj
 9Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400115; x=1771004915;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYaICE5cuovYZkR50vMC/cPaORV4kMk0hRpV1zUEkEU=;
 b=JfsAlVTFmYZp7AN10DZ8KK1w1qEzCKdEjNHEiZlgfCST3eujTx1s8p5Dq11KsAaGPz
 P2iR8XiMEOptDML2MK0PHKeWeWErn32n21HLruy/QGCy++rO9gaQDUaedmzV0E8D+NLC
 Thldk3cKsjDCZriT+Oo0YJPHQmdv08xGPM99c9HcqjvBdL0QZFujL0PUNgMWCuWla+x+
 QPF/rngKoM8mZdmI//86c1cLh8fdwTdoYTmR0cWluW499lWJzBWTZOz23uhY5u10zoSd
 RPhm87OoouVRne01MVUOfQUP0XgsWoLIAFJKg1aO3Pj9Z7HGlYlqXrfU7wLDLz9Bu2wA
 CgMQ==
X-Gm-Message-State: AOJu0YzXb0zJ4Yi13eWCmQZavrXujJedXdv0QcYswUiNnR2zlLW6unBJ
 r5FqUAneUi0evRwYDM1vNWuwXhLiNKsCXjLVvx/vf9O/Wdfk5p8WfFKIVaB9yuAiv9Y=
X-Gm-Gg: AZuq6aI/iW1frM/WsmLHPpJ2xO/QFBwcPYyVe/c+EE/+PaXWi/0iVbtJgHNSMmJSN3D
 6Gqm8JrnBy3bd0h88oCBGrYU74CD3CsJdGSereLFStHL5/VVZoL96PnEwYay6fg/ZeAGUrKJFow
 KHXCijhlEX+GlaKJEqQvHgiyjNCdkISiCYrDCQ5kYaouIDlS4XXiUXpzxnrwTftfMTSXQMTxXCU
 X//aTTePpgQOaIUDyMIfoxOhhQNrbCFY+p+F+sMzrud2oYZzty2Qz6CW4vaeYSFqr6GIbMFp/ye
 sSMxicEHgHMivXjjAkx591v66A8kGCyEpf64z5DJeuzbEyVuJhBQhvVdloq3C2PV8RSdvdRlPS4
 ubnLVjC/nhKyxYfkNMDIN/Fc85zPKXzgrTMrPWH4XQQcbHEqe/j6XIEFKMN+5fRX5Ra5cb+pzGL
 ANf76YY4vPhXXgNBMuWve2wg7EL2aBZy/xEJVdKA==
X-Received: by 2002:ac8:5d0b:0:b0:4ee:26bd:13f2 with SMTP id
 d75a77b69052e-506399a22ffmr43368111cf.72.1770400114787; 
 Fri, 06 Feb 2026 09:48:34 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89547aa3478sm4004676d6.35.2026.02.06.09.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 09:48:34 -0800 (PST)
Message-ID: <94837edc-936e-4cdd-af93-357b9487ddd2@ventanamicro.com>
Date: Fri, 6 Feb 2026 14:48:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/qtest/libqos: Add RISC-V IOMMU helper library
To: chao.liu.zevorn@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1770127918.git.chao.liu.zevorn@gmail.com>
 <a2edf8c44f0bce26dccb91a7d13edb58be50c1a3.1770127918.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <a2edf8c44f0bce26dccb91a7d13edb58be50c1a3.1770127918.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 2/3/2026 11:27 AM, chao.liu.zevorn@gmail.com wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
> 
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
> Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                          |   1 +
>   tests/qtest/libqos/meson.build       |   2 +-
>   tests/qtest/libqos/qos-riscv-iommu.c | 403 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
>   4 files changed, 569 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dccdf47888..830f56376b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3584,6 +3584,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
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
> index 0000000000..295583f536
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-riscv-iommu.c
> @@ -0,0 +1,403 @@
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
> +#include "hw/riscv/riscv-iommu-bits.h"
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
> +        g_autofree uint8_t *buf = g_malloc(ctx.config.dma_len);
> +
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
> +static uint64_t qriommu_get_pte_attrs(bool is_leaf)
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
> +    uint64_t non_leaf_attrs = qriommu_get_pte_attrs(false);
> +    uint64_t leaf_attrs = qriommu_get_pte_attrs(true);
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
> +        uint64_t g_root;
> +        uint64_t g_l0_pa;
> +        uint64_t g_l1_pa;
> +        uint64_t g_l0_pte_val;
> +        uint64_t g_l1_pte_val;
> +
> +        g_root = qriommu_apply_space_offs(
> +            QRIOMMU_G_IOHGATP & QRIOMMU_PTE_PPN_MASK);
> +        g_l0_pa = qriommu_apply_space_offs(QRIOMMU_G_L0_PTE_VAL);
> +        g_l1_pa = qriommu_apply_space_offs(QRIOMMU_G_L1_PTE_VAL);
> +        g_l0_pte_val = qriommu_encode_pte(g_l0_pa, non_leaf_attrs);
> +        g_l1_pte_val = qriommu_encode_pte(g_l1_pa, non_leaf_attrs);
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
> +
> +uint32_t qriommu_build_translation(QTestState *qts, QRIOMMUTransMode mode,
> +                                   uint32_t device_id)
> +{
> +    uint64_t dc_addr, dc_addr_real;
> +    struct riscv_iommu_dc dc;
> +    uint64_t iohgatp;
> +
> +    qtest_memset(qts, qriommu_apply_space_offs(QRIOMMU_DDT_BASE), 0, 0x1000);
> +
> +    dc_addr = device_id * sizeof(struct riscv_iommu_dc) + QRIOMMU_DC_BASE;
> +    dc_addr_real = qriommu_apply_space_offs(dc_addr);
> +
> +    /* Build Device Context (DC) */
> +    memset(&dc, 0, sizeof(dc));
> +
> +    switch (mode) {
> +    case QRIOMMU_TM_BARE:
> +        /* Pass-through mode: tc.V=1, no FSC/IOHGATP */
> +        dc.tc = RISCV_IOMMU_DC_TC_V;
> +        break;
> +
> +    case QRIOMMU_TM_S_STAGE_ONLY:
> +        /* S-stage only: tc.V=1, set FSC */
> +        dc.tc = RISCV_IOMMU_DC_TC_V;
> +        iohgatp = qriommu_apply_space_offs(QRIOMMU_IOHGATP);
> +        /* FSC mode: SV39 (mode=8) */
> +        dc.fsc = (iohgatp >> 12) | (8ull << 60);
> +        break;
> +
> +    case QRIOMMU_TM_G_STAGE_ONLY:
> +        /* G-stage only: tc.V=1, set IOHGATP */
> +        dc.tc = RISCV_IOMMU_DC_TC_V;
> +        iohgatp = qriommu_apply_space_offs(QRIOMMU_G_IOHGATP);
> +        /* IOHGATP mode: SV39x4 (mode=8) */
> +        dc.iohgatp = (iohgatp >> 12) | (8ull << 60);
> +        break;
> +
> +    case QRIOMMU_TM_NESTED:
> +        /* Nested: tc.V=1, set both FSC and IOHGATP */
> +        dc.tc = RISCV_IOMMU_DC_TC_V;
> +        /* FSC mode: SV39 (mode=8) */
> +        dc.fsc = (QRIOMMU_IOHGATP >> 12) | (8ull << 60);
> +        /* IOHGATP mode: SV39x4 (mode=8) */
> +        iohgatp = qriommu_apply_space_offs(QRIOMMU_G_IOHGATP);
> +        dc.iohgatp = (iohgatp >> 12) | (8ull << 60);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* Write DC to memory */
> +    qtest_writeq(qts, dc_addr_real + 0,  dc.tc);
> +    qtest_writeq(qts, dc_addr_real + 8,  dc.iohgatp);
> +    qtest_writeq(qts, dc_addr_real + 16, dc.ta);
> +    qtest_writeq(qts, dc_addr_real + 24, dc.fsc);
> +    qtest_writeq(qts, dc_addr_real + 32, dc.msiptp);
> +    qtest_writeq(qts, dc_addr_real + 40, dc.msi_addr_mask);
> +    qtest_writeq(qts, dc_addr_real + 48, dc.msi_addr_pattern);
> +    qtest_writeq(qts, dc_addr_real + 56, dc._reserved);
> +
> +    /* Setup translation tables if not in BARE mode */
> +    if (mode != QRIOMMU_TM_BARE) {
> +        qriommu_setup_translation_tables(qts, QRIOMMU_IOVA, mode);
> +    }
> +
> +    return 0;
> +}
> +
> +void qriommu_program_regs(QTestState *qts, uint64_t iommu_base)
> +{
> +    uint64_t ddtp, cqb, fqb;
> +    uint64_t cq_base, fq_base;
> +    uint64_t cq_align, fq_align;
> +    uint32_t cq_entries = QRIOMMU_QUEUE_ENTRIES;
> +    uint32_t fq_entries = QRIOMMU_QUEUE_ENTRIES;
> +    uint32_t cq_log2sz = ctz32(cq_entries) - 1;
> +    uint32_t fq_log2sz = ctz32(fq_entries) - 1;
> +
> +    cq_base = qriommu_apply_space_offs(QRIOMMU_CQ_BASE_ADDR);
> +    fq_base = qriommu_apply_space_offs(QRIOMMU_FQ_BASE_ADDR);
> +
> +    cq_align = MAX(0x1000ull, (uint64_t)cq_entries * QRIOMMU_CQ_ENTRY_SIZE);
> +    fq_align = MAX(0x1000ull, (uint64_t)fq_entries * QRIOMMU_FQ_ENTRY_SIZE);
> +    g_assert((cq_base & (cq_align - 1)) == 0);
> +    g_assert((fq_base & (fq_align - 1)) == 0);
> +
> +    /* Setup Command Queue */
> +    cqb = (cq_base >> 12) << 10 | cq_log2sz;
> +    qtest_writeq(qts, iommu_base + RISCV_IOMMU_REG_CQB, cqb);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_CQH, 0);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_CQT, 0);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_CQCSR,
> +                 RISCV_IOMMU_CQCSR_CQEN);
> +    qriommu_wait_for_queue_active(qts, iommu_base, RISCV_IOMMU_REG_CQCSR,
> +                                  RISCV_IOMMU_CQCSR_CQON);
> +
> +    /* Setup Fault Queue */
> +    fqb = (fq_base >> 12) << 10 | fq_log2sz;
> +    qtest_writeq(qts, iommu_base + RISCV_IOMMU_REG_FQB, fqb);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_FQH, 0);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_FQT, 0);
> +    qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_FQCSR,
> +                 RISCV_IOMMU_FQCSR_FQEN);
> +    qriommu_wait_for_queue_active(qts, iommu_base, RISCV_IOMMU_REG_FQCSR,
> +                                  RISCV_IOMMU_FQCSR_FQON);
> +
> +    /* Set Device Directory Table Pointer (DDTP) */
> +    ddtp = qriommu_apply_space_offs(QRIOMMU_DDT_BASE);
> +    g_assert((ddtp & 0xfff) == 0);
> +    ddtp = ((ddtp >> 12) << 10) | RISCV_IOMMU_DDTP_MODE_1LVL;
> +    qtest_writeq(qts, iommu_base + RISCV_IOMMU_REG_DDTP, ddtp);
> +    g_assert((qtest_readq(qts, iommu_base + RISCV_IOMMU_REG_DDTP) &
> +              (RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE)) ==
> +             (ddtp & (RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE)));
> +}
> diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
> new file mode 100644
> index 0000000000..90e69a5d73
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
> @@ -0,0 +1,164 @@
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
> +#ifndef QTEST_LIBQOS_RISCV_IOMMU_H
> +#define QTEST_LIBQOS_RISCV_IOMMU_H
> +
> +#include "hw/misc/iommu-testdev.h"
> +
> +/* RISC-V IOMMU MMIO register base for virt machine */
> +#define VIRT_RISCV_IOMMU_BASE      0x0000000003010000ull
> +
> +/* RISC-V IOMMU queue and table base addresses */
> +#define QRIOMMU_CQ_BASE_ADDR       0x000000000e160000ull
> +#define QRIOMMU_FQ_BASE_ADDR       0x000000000e170000ull
> +
> +/* RISC-V IOMMU queue sizing */
> +#define QRIOMMU_QUEUE_ENTRIES  1024
> +#define QRIOMMU_CQ_ENTRY_SIZE  16
> +#define QRIOMMU_FQ_ENTRY_SIZE  32
> +
> +/*
> + * Translation tables and descriptors for RISC-V IOMMU.
> + * Similar to ARM SMMUv3, but using RISC-V IOMMU terminology:
> + * - Device Context (DC) instead of STE
> + * - First-stage context (FSC) for S-stage translation
> + * - IOHGATP for G-stage translation
> + *
> + * Granule size: 4KB pages
> + * Page table levels: 3 levels for SV39 (L0, L1, L2)
> + * IOVA size: 39-bit virtual address space
> + */
> +#define QRIOMMU_IOVA                0x0000000080604567ull
> +#define QRIOMMU_IOHGATP             0x0000000000010000ull
> +#define QRIOMMU_DDT_BASE            0x0000000000014000ull
> +#define QRIOMMU_DC_BASE             (QRIOMMU_DDT_BASE)
> +
> +#define QRIOMMU_L0_PTE_VAL          0x0000000000011000ull
> +#define QRIOMMU_L1_PTE_VAL          0x0000000000012000ull
> +#define QRIOMMU_L2_PTE_VAL          0x0000000000013000ull
> +
> +#define QRIOMMU_G_IOHGATP           0x0000000000020000ull
> +#define QRIOMMU_G_L0_PTE_VAL        0x0000000000021000ull
> +#define QRIOMMU_G_L1_PTE_VAL        0x0000000000022000ull
> +
> +/*
> + * PTE masks for RISC-V IOMMU page tables.
> + * Values match PTE_V, PTE_R, PTE_W, PTE_A, PTE_D in target/riscv/cpu_bits.h
> + */
> +#define QRIOMMU_NON_LEAF_PTE_MASK   0x001  /* PTE_V */
> +#define QRIOMMU_LEAF_PTE_RW_MASK    0x0c7  /* V|R|W|A|D */
> +#define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
> +
> +/* Address-space base offset for test tables */
> +#define QRIOMMU_SPACE_OFFS          0x0000000080000000ull
> +
> +typedef enum QRIOMMUTransMode {
> +    QRIOMMU_TM_BARE         = 0,    /* No translation (pass-through) */
> +    QRIOMMU_TM_S_STAGE_ONLY = 1,    /* First-stage only (S-stage) */
> +    QRIOMMU_TM_G_STAGE_ONLY = 2,    /* Second-stage only (G-stage) */
> +    QRIOMMU_TM_NESTED       = 3,    /* Nested translation (S + G) */
> +} QRIOMMUTransMode;
> +
> +typedef struct QRIOMMUTestConfig {
> +    QRIOMMUTransMode trans_mode;    /* Translation mode */
> +    uint64_t dma_gpa;               /* GPA for readback validation */
> +    uint32_t dma_len;               /* DMA length for testing */
> +    uint32_t expected_result;       /* Expected DMA result */
> +} QRIOMMUTestConfig;
> +
> +typedef struct QRIOMMUTestContext {
> +    QTestState *qts;                /* QTest state handle */
> +    QPCIDevice *dev;                /* PCI device handle */
> +    QPCIBar bar;                    /* PCI BAR for MMIO access */
> +    QRIOMMUTestConfig config;       /* Test configuration */
> +    uint64_t iommu_base;            /* RISC-V IOMMU base address */
> +    uint32_t trans_status;          /* Translation configuration status */
> +    uint32_t dma_result;            /* DMA operation result */
> +    uint32_t device_id;             /* Device ID for the test */
> +} QRIOMMUTestContext;
> +
> +/*
> + * qriommu_setup_and_enable_translation - Complete translation setup and enable
> + *
> + * @ctx: Test context containing configuration and device handles
> + *
> + * Returns: Translation status (0 = success, non-zero = error)
> + *
> + * This function performs the complete translation setup sequence:
> + * 1. Builds all required RISC-V IOMMU structures (DC, page tables)
> + * 2. Programs RISC-V IOMMU registers
> + * 3. Returns configuration status
> + */
> +uint32_t qriommu_setup_and_enable_translation(QRIOMMUTestContext *ctx);
> +
> +/*
> + * qriommu_build_translation - Build RISC-V IOMMU translation structures
> + *
> + * @qts: QTest state handle
> + * @mode: Translation mode (BARE, S_STAGE_ONLY, G_STAGE_ONLY, NESTED)
> + * @device_id: Device ID
> + *
> + * Returns: Build status (0 = success, non-zero = error)
> + *
> + * Constructs all necessary RISC-V IOMMU translation structures in guest memory:
> + * - Device Context (DC) for the given device ID
> + * - First-stage context (FSC) if S-stage translation is involved
> + * - Complete page table hierarchy based on translation mode
> + */
> +uint32_t qriommu_build_translation(QTestState *qts, QRIOMMUTransMode mode,
> +                                   uint32_t device_id);
> +
> +/*
> + * qriommu_program_regs - Program all required RISC-V IOMMU registers
> + *
> + * @qts: QTest state handle
> + * @iommu_base: RISC-V IOMMU base address
> + *
> + * Programs RISC-V IOMMU registers:
> + * - Device Directory Table Pointer (DDTP)
> + * - Command queue (base, head, tail)
> + * - Fault queue (base, head, tail)
> + * - Control and status registers
> + */
> +void qriommu_program_regs(QTestState *qts, uint64_t iommu_base);
> +
> +/*
> + * qriommu_setup_translation_tables - Setup RISC-V IOMMU page table hierarchy
> + *
> + * @qts: QTest state handle
> + * @iova: Input Virtual Address to translate
> + * @mode: Translation mode
> + *
> + * This function builds the complete page table structure for translating
> + * the given IOVA through the RISC-V IOMMU. The structure varies based on mode:
> + *
> + * - BARE: No translation (pass-through)
> + * - S_STAGE_ONLY: Single S-stage walk (IOVA -> PA)
> + * - G_STAGE_ONLY: Single G-stage walk (IPA -> PA)
> + * - NESTED: S-stage walk (IOVA -> IPA) + G-stage walk (IPA -> PA)
> + */
> +void qriommu_setup_translation_tables(QTestState *qts,
> +                                      uint64_t iova,
> +                                      QRIOMMUTransMode mode);
> +
> +/* High-level test execution helpers */
> +void qriommu_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                                  QPCIBar bar, uint64_t iommu_base,
> +                                  const QRIOMMUTestConfig *cfg);
> +
> +/* Calculate expected DMA result */
> +uint32_t qriommu_expected_dma_result(QRIOMMUTestContext *ctx);
> +
> +/* Build DMA attributes for RISC-V IOMMU */
> +uint32_t qriommu_build_dma_attrs(void);
> +
> +#endif /* QTEST_LIBQOS_RISCV_IOMMU_H */


