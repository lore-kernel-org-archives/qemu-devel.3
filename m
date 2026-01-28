Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C776D3F084
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7ky-0008M0-A7; Wed, 28 Jan 2026 10:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl7kr-0008KZ-Vw
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:46:54 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl7kp-0003nd-AT
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:46:53 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so4319755a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769615210; x=1770220010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf0vBqsOa0JVAExWtOJTn1wB4NoPm0WZ0woDUS8znlY=;
 b=DtkYcklAx7ZWf3/wIHiXxnvpNuIdgtiWW0/9mJ6DRN8EurosLDvS3vSc7RTPyCuDTf
 t7GzW3t+JMJ2ZvY+i1EWQ7pFTzzG7U5BurLs487slEQbTh6fhY4zt1xT4YJyhXxTA0fC
 fGzeogxvKcuQViR+AfsNz8xmcNnyDzy8oAa2cPghFYUCIrmN7n3oXj7dwQFK7q17Z1m+
 mzbX/09oRmcnqIqfeDnu3SyBsUM7mf1nGjPNJpFmGkVHOMYSEllGndp0W50Cw6hVTFbI
 rXRUsANpIYooExCnR93qiOaAPL0OHVPYLfYwCWzb+CvOuQ+Y6+Wbs8B7nbs7+mZs92oN
 QenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769615210; x=1770220010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kf0vBqsOa0JVAExWtOJTn1wB4NoPm0WZ0woDUS8znlY=;
 b=K2qEgXVYBxpTmn9/cLC+zy1vki8aV4mdnE21ZF2sTeJCnRdm83KorQb+lp5JK2J1zO
 4XtIc1V5n5HjLDNKt5ad7/m5Z0uIFRPZcY2FDSDk2pvzr/RAkHKYbRrfZHSfY+SgIz/2
 KhG2DLPiXszgRDVGBVkiJvu4dsbxNgxejYhCHYExT59mhPS/8Eeh2l1byIkbu5IHv1FH
 i1VyfT9kPnCI+rE3SsK6VLfSmREBHUHTMG4zOR6ZRUhY+g08zoX1W3XWkc6v3+bXOMGk
 kOqbg/HAsI6WgWReMcesl3H/38zi7eyiWc7nQtVOAdfyaKAj7ouOgPvMrbNtCwbgmUkO
 iFdQ==
X-Gm-Message-State: AOJu0YxdYt6DI3SU69hw1VMKs2Agpm6jvizIUPkV9iuzElvRGcpP7ku7
 jJBvwOhQ1muvnNgjIn9VGdvruLJL2eIi6mgmYXbcypw27/zmuMSchLbW
X-Gm-Gg: AZuq6aIdI5V203hH8dqR0wKrq2N7LQxrwtS1uEqSLTibEvJfPm+100DmevoRa/EQJ2z
 qTs3F9u71j0Bc2Yo/mIOKx1mnpJpoONGNRcWTuByghjyYaNwZ5GJgHx0k8hTHlVbm3+aIcXRDYz
 VnjTRcts5bz6TBs2aVVbXoL6/HIaUkleZpaQ71PCeqhg3Xo0WPHEWDx8fS07ZVI4rfjTA/Fpz3C
 LsAg6huy88+l2QmrFHVj8rFE1zqxBW7JqjWZ+fzaKdv+yMSVzyOdM9xL7GpiQjgpMb9YOyI6Sgs
 DH1I5RrOdX5n2j2MykCjPMFptTBh6tXMUyD9x9MOZ4yloTJyTwNIC6ewIcjGO22IIp3dFiEWzTB
 V84ZStX3ARWFGZFOAE8+P4PEJGAJLcAHKmaRlH8iBm1IlC4wLNY9nY3uV7mFZolYdhz3N3RKCTQ
 B4K9UEwD0kTTVtfX6peCGFf0238MDVKvZoRmIbpjNyEv4u9PEUFD4xJGafKQqAQw8Yhf4=
X-Received: by 2002:a17:90b:3c42:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-353fed74b0emr4872210a91.20.1769615209369; 
 Wed, 28 Jan 2026 07:46:49 -0800 (PST)
Received: from [192.168.1.4] ([183.195.22.224])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c24083sm2989289b3a.55.2026.01.28.07.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 07:46:48 -0800 (PST)
Message-ID: <d89f2510-22ac-47b4-adc6-b23e5cf6306e@gmail.com>
Date: Wed, 28 Jan 2026 23:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] tests/qtest/libqos: Add RISC-V IOMMU helper
 library
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
 <bf2b4f9cfe1484b0cde5540f518f74f9fc878c8d.1769600111.git.chao.liu.zevorn@gmail.com>
 <d11e9d1e-a209-4142-a742-170fcecefbf7@phytium.com.cn>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <d11e9d1e-a209-4142-a742-170fcecefbf7@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1044.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Tao,

Thanks for the review!

On 1/28/2026 11:23 PM, Tao Tang wrote:
> Hi Chao,
>
> On 2026/1/28 20:09, Chao Liu wrote:
>> Introduce a libqos helper module for RISC-V IOMMU testing with
>> iommu-testdev. The helper provides routines to:
>>
>> - Build device contexts (DC) and 3-level page tables for SV39/SV39x4
>> - Program command queue (CQ), fault queue (FQ), and DDTP registers
>>    following the RISC-V IOMMU specification
>> - Execute DMA translations and verify results
>>
>> The current implementation supports SV39 for S-stage and SV39x4 for
>> G-stage translation. Support for SV48/SV48x4/SV57/SV57x4 can be added
>> in future patches.
>>
>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> ---
>>   MAINTAINERS                          |   1 +
>>   tests/qtest/libqos/meson.build       |   2 +-
>>   tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
>>   4 files changed, 574 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dc31be033e..894e05bd2c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3583,6 +3583,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
>>   S: Maintained
>>   F: tests/qtest/libqos/qos-iommu*
>>   F: tests/qtest/libqos/qos-smmuv3*
>> +F: tests/qtest/libqos/qos-riscv-iommu*
>>     Device Fuzzing
>>   M: Alexander Bulekov <alxndr@bu.edu>
>> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
>> index b4daec808f..4a69acad0d 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -71,7 +71,7 @@ if have_virtfs
>>   endif
>>     if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>> -  libqos_srcs += files('riscv-iommu.c')
>> +  libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>>   endif
>>   if config_all_devices.has_key('CONFIG_TPCI200')
>>     libqos_srcs += files('tpci200.c')
>> diff --git a/tests/qtest/libqos/qos-riscv-iommu.c b/tests/qtest/libqos/qos-riscv-iommu.c
>> new file mode 100644
>> index 0000000000..34ed3df84a
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-riscv-iommu.c
>> @@ -0,0 +1,400 @@
>> +/*
>> + * QOS RISC-V IOMMU Module
>> + *
>> + * This module provides RISC-V IOMMU-specific helper functions for libqos tests,
>> + * encapsulating RISC-V IOMMU setup, and assertions.
>> + *
>> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/bitops.h"
>> +#include "hw/riscv/riscv-iommu-bits.h"
>> +#include "tests/qtest/libqos/pci.h"
>> +#include "qos-iommu-testdev.h"
>> +#include "qos-riscv-iommu.h"
>> +
>> +/* Apply space offset to address */
>> +static inline uint64_t qriommu_apply_space_offs(uint64_t address)
>> +{
>> +    return address + QRIOMMU_SPACE_OFFS;
>> +}
>
>
> In the original SMMU/iommu-testdev work, I introduced a similar “base offset” mainly to make room for future expansion where the same test code needs to exercise multiple security domains (e.g., Arm Non-secure vs Secure vs Realm), which in QEMU is reflected via distinct address spaces / MemTxAttrs (the space field).
>
> I’m not very familiar with the RISC-V security model. In RISC-V, do you foresee a comparable need to test multiple “security states” for DMA transactions?
>
Good question. RISC-V currently doesn't have a TrustZone-like security
model with multiple security domains (Secure/Non-secure/Realm) like ARM.
However, RISC-V does have the Hypervisor extension (H-extension) with
VS/VU modes, and there's a draft WorldGuard extension for security
isolation.

For now, the QRIOMMU_SPACE_OFFS is mainly used to avoid address conflicts
with other memory regions in the QEMU virt machine. If future RISC-V
security extensions require multi-domain testing, we can extend this
infrastructure accordingly.
>> +
>> +static uint64_t qriommu_encode_pte(uint64_t pa, uint64_t attrs)
>> +{
>> +    return ((pa >> 12) << 10) | attrs;
>> +}
>> +
>> +static void qriommu_wait_for_queue_active(QTestState *qts, uint64_t iommu_base,
>> +                                          uint32_t queue_csr, uint32_t on_bit)
>> +{
>> +    guint64 timeout_us = 2 * 1000 * 1000;
>> +    gint64 start_time = g_get_monotonic_time();
>> +    uint32_t reg;
>> +
>> +    for (;;) {
>> +        qtest_clock_step(qts, 100);
>> +
>> +        reg = qtest_readl(qts, iommu_base + queue_csr);
>> +        if (reg & on_bit) {
>> +            return;
>> +        }
>> +        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
>> +    }
>> +}
>> +
>> +uint32_t qriommu_expected_dma_result(QRIOMMUTestContext *ctx)
>> +{
>> +    return ctx->config.expected_result;
>> +}
>> +
>> +uint32_t qriommu_build_dma_attrs(void)
>> +{
>> +    /* RISC-V IOMMU uses standard AXI attributes */
>> +    return 0;
>> +}
>> +
>> +uint32_t qriommu_setup_and_enable_translation(QRIOMMUTestContext *ctx)
>> +{
>> +    uint32_t build_result;
>> +
>> +    /* Build page tables and RISC-V IOMMU structures first */
>> +    build_result = qriommu_build_translation(
>> +                       ctx->qts, ctx->config.trans_mode,
>> +                       ctx->device_id);
>> +    if (build_result != 0) {
>> +        g_test_message("Build failed: mode=%u device_id=%u status=0x%x",
>> +                       ctx->config.trans_mode, ctx->device_id, build_result);
>> +        ctx->trans_status = build_result;
>> +        return ctx->trans_status;
>> +    }
>> +
>> +    /* Program RISC-V IOMMU registers */
>> +    qriommu_program_regs(ctx->qts, ctx->iommu_base);
>> +
>> +    ctx->trans_status = 0;
>> +    return ctx->trans_status;
>> +}
>> +
>> +static bool qriommu_validate_test_result(QRIOMMUTestContext *ctx)
>> +{
>> +    uint32_t expected = qriommu_expected_dma_result(ctx);
>> +    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
>> +                   expected, ctx->dma_result);
>> +    return (ctx->dma_result == expected);
>> +}
>> +
>> +static uint32_t qriommu_single_translation_setup(void *opaque)
>> +{
>> +    return qriommu_setup_and_enable_translation(opaque);
>> +}
>> +
>> +static uint32_t qriommu_single_translation_attrs(void *opaque)
>> +{
>> +    return qriommu_build_dma_attrs();
>> +}
>> +
>> +static bool qriommu_single_translation_validate(void *opaque)
>> +{
>> +    return qriommu_validate_test_result(opaque);
>> +}
>> +
>> +static void qriommu_single_translation_report(void *opaque,
>> +                                              uint32_t dma_result)
>> +{
>> +    QRIOMMUTestContext *ctx = opaque;
>> +
>> +    if (dma_result != 0) {
>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>> +                       ctx->config.trans_mode, dma_result);
>> +    } else {
>> +        g_test_message("-> DMA succeeded: mode=%u",
>> +                       ctx->config.trans_mode);
>> +    }
>> +}
>> +
>> +void qriommu_run_translation_case(QTestState *qts, QPCIDevice *dev,
>> +                                  QPCIBar bar, uint64_t iommu_base,
>> +                                  const QRIOMMUTestConfig *cfg)
>> +{
>> +    QRIOMMUTestContext ctx = {
>> +        .qts = qts,
>> +        .dev = dev,
>> +        .bar = bar,
>> +        .iommu_base = iommu_base,
>> +        .config = *cfg,
>> +        .device_id = dev->devfn,
>> +    };
>> +
>> +    QOSIOMMUTestdevDmaCfg dma = {
>> +        .dev = dev,
>> +        .bar = bar,
>> +        .iova = QRIOMMU_IOVA,
>> +        .gpa = ctx.config.dma_gpa,
>> +        .len = ctx.config.dma_len,
>> +    };
>> +
>> +    qtest_memset(qts, cfg->dma_gpa, 0x00, cfg->dma_len);
>> +    qos_iommu_testdev_single_translation(&dma, &ctx,
>> + qriommu_single_translation_setup,
>> + qriommu_single_translation_attrs,
>> + qriommu_single_translation_validate,
>> + qriommu_single_translation_report,
>> + &ctx.dma_result);
>> +
>> +    if (ctx.dma_result == 0 && ctx.config.expected_result == 0) {
>> +        g_autofree uint8_t *buf = NULL;
>> +
>> +        buf = g_malloc(ctx.config.dma_len);
>> +        qtest_memread(ctx.qts, ctx.config.dma_gpa, buf, ctx.config.dma_len);
>> +
>> +        for (int i = 0; i < ctx.config.dma_len; i++) {
>> +            uint8_t expected;
>> +
>> +            expected = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
>> +            g_assert_cmpuint(buf[i], ==, expected);
>> +        }
>> +    }
>> +}
>> +
>> +static uint32_t qriommu_get_table_index(uint64_t addr, int level)
>> +{
>> +    /* SV39: 39-bit virtual address, 3-level page table */
>> +    switch (level) {
>> +    case 0:
>> +        return (addr >> 30) & 0x1ff;   /* L0: bits [38:30] */
>> +    case 1:
>> +        return (addr >> 21) & 0x1ff;   /* L1: bits [29:21] */
>> +    case 2:
>> +        return (addr >> 12) & 0x1ff;   /* L2: bits [20:12] */
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static uint64_t qriommu_get_table_addr(uint64_t base, int level, uint64_t iova)
>> +{
>> +    uint32_t index = qriommu_get_table_index(iova, level);
>> +    return (base & QRIOMMU_PTE_PPN_MASK) + (index * 8);
>> +}
>> +
>> +static void qriommu_map_leaf(QTestState *qts, uint64_t root_pa,
>> +                             uint64_t l0_pa, uint64_t l1_pa,
>> +                             uint64_t l0_pte_val, uint64_t l1_pte_val,
>> +                             uint64_t va, uint64_t pa, uint64_t leaf_attrs)
>> +{
>> +    uint64_t l0_addr = qriommu_get_table_addr(root_pa, 0, va);
>> +    uint64_t l1_addr = qriommu_get_table_addr(l0_pa, 1, va);
>> +    uint64_t l2_addr = qriommu_get_table_addr(l1_pa, 2, va);
>> +
>> +    qtest_writeq(qts, l0_addr, l0_pte_val);
>> +    qtest_writeq(qts, l1_addr, l1_pte_val);
>> +    qtest_writeq(qts, l2_addr, qriommu_encode_pte(pa, leaf_attrs));
>> +}
>> +
>> +static uint64_t qriommu_get_pte_attrs(QRIOMMUTransMode mode, bool is_leaf)
>
>
> mode doesn't seem to be used?
>
You're right. The `mode` parameter is currently unused. I'll remove it
in the next version.
>> +{
>> +    if (!is_leaf) {
>> +        return QRIOMMU_NON_LEAF_PTE_MASK;
>> +    }
>> +
>> +    /* For leaf PTE, set RWX permissions */
>> +    return QRIOMMU_LEAF_PTE_RW_MASK;
>> +}
>> +
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
>> new file mode 100644
>> index 0000000000..1f4efbf682
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
>> @@ -0,0 +1,172 @@
>> +/*
>> + * QOS RISC-V IOMMU Module
>> + *
>> + * This module provides RISC-V IOMMU-specific helper functions for libqos tests,
>> + * encapsulating RISC-V IOMMU setup, and assertions.
>> + *
>> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QTEST_LIBQOS_RISCV_IOMMU_H
>> +#define QTEST_LIBQOS_RISCV_IOMMU_H
>> +
>> +#include "hw/misc/iommu-testdev.h"
>> +
>> +/* RISC-V IOMMU MMIO register base for virt machine */
>> +#define VIRT_RISCV_IOMMU_BASE      0x0000000003010000ull
>> +
>> +/* RISC-V IOMMU queue and table base addresses */
>> +#define QRIOMMU_CQ_BASE_ADDR       0x000000000e160000ull
>> +#define QRIOMMU_FQ_BASE_ADDR       0x000000000e170000ull
>> +
>> +/* RISC-V IOMMU queue sizing */
>> +#define QRIOMMU_QUEUE_ENTRIES  1024
>> +#define QRIOMMU_CQ_ENTRY_SIZE  16
>> +#define QRIOMMU_FQ_ENTRY_SIZE  32
>> +
>> +/*
>> + * Translation tables and descriptors for RISC-V IOMMU.
>> + * Similar to ARM SMMUv3, but using RISC-V IOMMU terminology:
>> + * - Device Context (DC) instead of STE
>> + * - First-stage context (FSC) for S-stage translation
>> + * - IOHGATP for G-stage translation
>> + *
>> + * Granule size: 4KB pages
>> + * Page table levels: 3 levels for SV39 (L0, L1, L2)
>> + * IOVA size: 39-bit virtual address space
>> + */
>> +#define QRIOMMU_IOVA                0x0000000080604567ull
>> +#define QRIOMMU_IOHGATP             0x0000000000010000ull
>> +#define QRIOMMU_DDT_BASE            0x0000000000014000ull
>> +#define QRIOMMU_DC_BASE             (QRIOMMU_DDT_BASE)
>> +
>> +#define QRIOMMU_L0_PTE_VAL          0x0000000000011000ull
>> +#define QRIOMMU_L1_PTE_VAL          0x0000000000012000ull
>> +#define QRIOMMU_L2_PTE_VAL          0x0000000000013000ull
>> +
>> +#define QRIOMMU_G_IOHGATP           0x0000000000020000ull
>> +#define QRIOMMU_G_L0_PTE_VAL        0x0000000000021000ull
>> +#define QRIOMMU_G_L1_PTE_VAL        0x0000000000022000ull
>> +
>> +/* RISC-V page table entry masks */
>> +#define QRIOMMU_PTE_V               0x0000000000000001ull
>> +#define QRIOMMU_PTE_R               0x0000000000000002ull
>> +#define QRIOMMU_PTE_W               0x0000000000000004ull
>> +#define QRIOMMU_PTE_X               0x0000000000000008ull
>> +#define QRIOMMU_PTE_U               0x0000000000000010ull
>> +#define QRIOMMU_PTE_G               0x0000000000000020ull
>> +#define QRIOMMU_PTE_A               0x0000000000000040ull
>> +#define QRIOMMU_PTE_D               0x0000000000000080ull
>
>
> I'm not entirely sure if there are similar definitions in the RISC-V header files, but if there are, I think we should consider reusing those definitions instead of redefining them.
>
>
> Besides the correctness of the RISC-V page-table construction may need RISC-V experts to review closely.
>
Good catch. I found that `target/riscv/cpu_bits.h` already defines these
PTE bits (PTE_V, PTE_R, PTE_W, etc.). I'll reuse those definitions
instead of redefining them in the next version.


Thanks,
Chao
>
> Thanks,
>
> Tao
>
>> +
>> +#define QRIOMMU_NON_LEAF_PTE_MASK   (QRIOMMU_PTE_V)
>> +#define QRIOMMU_LEAF_PTE_RW_MASK    (QRIOMMU_PTE_V | QRIOMMU_PTE_R | \
>> +                                     QRIOMMU_PTE_W | QRIOMMU_PTE_A | \
>> +                                     QRIOMMU_PTE_D)
>> +#define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
>> +
>> +/* Address-space base offset for test tables */
>> +#define QRIOMMU_SPACE_OFFS          0x0000000080000000ull
>> +
>> +typedef enum QRIOMMUTransMode {
>> +    QRIOMMU_TM_BARE         = 0,    /* No translation (pass-through) */
>> +    QRIOMMU_TM_S_STAGE_ONLY = 1,    /* First-stage only (S-stage) */
>> +    QRIOMMU_TM_G_STAGE_ONLY = 2,    /* Second-stage only (G-stage) */
>> +    QRIOMMU_TM_NESTED       = 3,    /* Nested translation (S + G) */
>> +} QRIOMMUTransMode;
>> +
>> +typedef struct QRIOMMUTestConfig {
>> +    QRIOMMUTransMode trans_mode;    /* Translation mode */
>> +    uint64_t dma_gpa;               /* GPA for readback validation */
>> +    uint32_t dma_len;               /* DMA length for testing */
>> +    uint32_t expected_result;       /* Expected DMA result */
>> +} QRIOMMUTestConfig;
>> +
>> +typedef struct QRIOMMUTestContext {
>> +    QTestState *qts;                /* QTest state handle */
>> +    QPCIDevice *dev;                /* PCI device handle */
>> +    QPCIBar bar;                    /* PCI BAR for MMIO access */
>> +    QRIOMMUTestConfig config;       /* Test configuration */
>> +    uint64_t iommu_base;            /* RISC-V IOMMU base address */
>> +    uint32_t trans_status;          /* Translation configuration status */
>> +    uint32_t dma_result;            /* DMA operation result */
>> +    uint32_t device_id;             /* Device ID for the test */
>> +} QRIOMMUTestContext;
>> +
>> +/*
>> + * qriommu_setup_and_enable_translation - Complete translation setup and enable
>> + *
>> + * @ctx: Test context containing configuration and device handles
>> + *
>> + * Returns: Translation status (0 = success, non-zero = error)
>> + *
>> + * This function performs the complete translation setup sequence:
>> + * 1. Builds all required RISC-V IOMMU structures (DC, page tables)
>> + * 2. Programs RISC-V IOMMU registers
>> + * 3. Returns configuration status
>> + */
>> +uint32_t qriommu_setup_and_enable_translation(QRIOMMUTestContext *ctx);
>> +
>> +/*
>> + * qriommu_build_translation - Build RISC-V IOMMU translation structures
>> + *
>> + * @qts: QTest state handle
>> + * @mode: Translation mode (BARE, S_STAGE_ONLY, G_STAGE_ONLY, NESTED)
>> + * @device_id: Device ID
>> + *
>> + * Returns: Build status (0 = success, non-zero = error)
>> + *
>> + * Constructs all necessary RISC-V IOMMU translation structures in guest memory:
>> + * - Device Context (DC) for the given device ID
>> + * - First-stage context (FSC) if S-stage translation is involved
>> + * - Complete page table hierarchy based on translation mode
>> + */
>> +uint32_t qriommu_build_translation(QTestState *qts, QRIOMMUTransMode mode,
>> +                                   uint32_t device_id);
>> +
>> +/*
>> + * qriommu_program_regs - Program all required RISC-V IOMMU registers
>> + *
>> + * @qts: QTest state handle
>> + * @iommu_base: RISC-V IOMMU base address
>> + *
>> + * Programs RISC-V IOMMU registers:
>> + * - Device Directory Table Pointer (DDTP)
>> + * - Command queue (base, head, tail)
>> + * - Fault queue (base, head, tail)
>> + * - Control and status registers
>> + */
>> +void qriommu_program_regs(QTestState *qts, uint64_t iommu_base);
>> +
>> +/*
>> + * qriommu_setup_translation_tables - Setup RISC-V IOMMU page table hierarchy
>> + *
>> + * @qts: QTest state handle
>> + * @iova: Input Virtual Address to translate
>> + * @mode: Translation mode
>> + *
>> + * This function builds the complete page table structure for translating
>> + * the given IOVA through the RISC-V IOMMU. The structure varies based on mode:
>> + *
>> + * - BARE: No translation (pass-through)
>> + * - S_STAGE_ONLY: Single S-stage walk (IOVA -> PA)
>> + * - G_STAGE_ONLY: Single G-stage walk (IPA -> PA)
>> + * - NESTED: S-stage walk (IOVA -> IPA) + G-stage walk (IPA -> PA)
>> + */
>> +void qriommu_setup_translation_tables(QTestState *qts,
>> +                                      uint64_t iova,
>> +                                      QRIOMMUTransMode mode);
>> +
>> +/* High-level test execution helpers */
>> +void qriommu_run_translation_case(QTestState *qts, QPCIDevice *dev,
>> +                                  QPCIBar bar, uint64_t iommu_base,
>> +                                  const QRIOMMUTestConfig *cfg);
>> +
>> +/* Calculate expected DMA result */
>> +uint32_t qriommu_expected_dma_result(QRIOMMUTestContext *ctx);
>> +
>> +/* Build DMA attributes for RISC-V IOMMU */
>> +uint32_t qriommu_build_dma_attrs(void);
>> +
>> +#endif /* QTEST_LIBQOS_RISCV_IOMMU_H */
>
>

