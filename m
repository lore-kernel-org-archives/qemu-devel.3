Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21792D3F070
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6Zg-0007Bn-23; Wed, 28 Jan 2026 09:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vl6ZS-0006zV-FP
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:31:05 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vl6ZP-00087Q-Jz
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:31:01 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8c5320536bfso767445085a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1769610657; x=1770215457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hVoxakSaX0DC6+69ZjGdf+fQjZ+kFcb21sLFzUS0B/Q=;
 b=JL5IjfnSj1FlGokxmRK+UUoOZkvDEIM8Ft2RyWHdnOG69Sctfs9NcXnvEa+pff1sXv
 KtS+rXvClQ49CXHcQUW0romg4IKcjGxhOK/YtndzDRLcm7IrcGTPpAnfnPulxvEq35lG
 S1wK7J/G5WwmSAqgYOQEOgjrSrCsKjvYm2L5rLi5Y9bvAUhCWaFLwCQsshoZB2aSzlIg
 cSXdkMNFjJ2z1mzIRWRvNKnqqtdBrM5YiAG7etq9vL+DY2r2E5XTT/xkkJT/YMyrxfoo
 O4SkWavH2/QWs2bjkkMup5pDPq8FB98qM7WQZveoL9/JXJx1opZGyfcSZ00bYUe2W7u3
 O8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610657; x=1770215457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVoxakSaX0DC6+69ZjGdf+fQjZ+kFcb21sLFzUS0B/Q=;
 b=tdfgoME6Acfvn4Xys6DNVwb0T1YXw4KVSMccZKabIOPD9NLLUY0TlgqFrdF4dJC7/w
 XWh/r0HIhZmvaglUGkA15//SdJKZsekd+9E6SBRoDWTMDePs/DhYkzjG6/HIcfl2Sb5Y
 I2tUQQ9mhI21kwO5SBB9BvkVLeKpxI50mcHEQxhm20PLfrk+AT0ydId0A2wxg3IgCpxs
 Cof9hxsfkqr+/C7dLebDR8wjR1PvAdS9uAN53KVzrGjY0CDUVlD/uY3ajBE4jazIi/CJ
 DrXc6TBFdmU9bT1fmChsXNbOm9Vhz0FD6iGe86zJTTiwOoe+Sk8kct7FR7G6xPcsjvc/
 TRlQ==
X-Gm-Message-State: AOJu0Yz/kMVrJTXI7nH3G0BWNDfOd72fUjKBbejZLpOMoUz2UNMpvH/P
 hQohjc/Qbwg9/ojA1SVsbA5iLsyza7jrnuFQwWMWLUsCHPSuKAM0StXzvRhNc1QekOk=
X-Gm-Gg: AZuq6aJ02hm2j2s19flb/i/kSjwiTPBa3YKWGRMVYXVvgXzsR4+Tl1dfrQxul7mP9aK
 RREQWul451rZrNMx6S8WbMGbUwKQv5EYM3xKeAE9GUr5s4hQbqdwSu5OSv5iNFbIhpdu7XGLBj1
 cIjm+nMWiTFsp4v62dGqIp4Cyn5G090+xRUXgZKkJojeOGIS5QEAZmxKIL5VTtIOFQpz5ntWvi2
 VNA9DEGgd7cNrIYhGHS4MFdq27IEALnO3lPeoP2koXCkgQPvLpaf9scrky0MB38H79gvC2Jjb9M
 LOKjjytmdcy+UHMR9e7eKlzbGQkP6MmwhEA47MXDl0ddLrGB0pe5EKjjQT+pCN9P9G2BvOtJImR
 UrBSS9jBiUsjfqXdX6ad70e4nLioPPSINYyTwoE8D7LOKrZYuqCWtx4pABniB+z2sAb2m5Dn4ii
 ffip6tULDZiboqlSAIa+ahLMK256orSPXDgCp3h8E=
X-Received: by 2002:a05:620a:44ce:b0:8b2:db27:4261 with SMTP id
 af79cd13be357-8c70b905a89mr712860385a.70.1769610654294; 
 Wed, 28 Jan 2026 06:30:54 -0800 (PST)
Received: from [192.168.15.23] ([179.118.208.129])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b98539sm205514985a.20.2026.01.28.06.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 06:30:53 -0800 (PST)
Message-ID: <cd8bc37a-c9ef-4f31-a024-fac24b74613e@ventanamicro.com>
Date: Wed, 28 Jan 2026 11:30:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
 <c31147ca6db874b32dcfea6ba4ad08f59ae356b1.1769600111.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <c31147ca6db874b32dcfea6ba4ad08f59ae356b1.1769600111.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72d.google.com
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



On 1/28/2026 9:09 AM, Chao Liu wrote:
> Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
> The test exercises bare, S-stage, G-stage, and nested translation paths
> using iommu-testdev and the qos-riscv-iommu helpers.
> 
> The test validates:
> - Device context (DC) configuration
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraints
> 
> This provides regression coverage for the RISC-V IOMMU implementation
> without requiring a full guest OS boot.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                    |   1 +
>   tests/qtest/iommu-riscv-test.c | 279 +++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build        |   5 +-
>   3 files changed, 284 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/iommu-riscv-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 894e05bd2c..c7400c83d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -347,6 +347,7 @@ F: common-user/host/riscv*
>   F: tests/functional/riscv32
>   F: tests/functional/riscv64
>   F: tests/tcg/riscv64/
> +F: tests/qtest/iommu-riscv-test.c
>   
>   RISC-V XThead* extensions
>   M: Christoph Muellner <christoph.muellner@vrull.eu>
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> new file mode 100644
> index 0000000000..9438578e1e
> --- /dev/null
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -0,0 +1,279 @@
> +/*
> + * QTest testcase for RISC-V IOMMU with iommu-testdev
> + *
> + * This QTest file is used to test the RISC-V IOMMU with iommu-testdev so that
> + * we can test RISC-V IOMMU without any guest kernel or firmware.
> + *
> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/generic-pcihost.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "libqos/qos-riscv-iommu.h"
> +#include "libqos/riscv-iommu.h"
> +
> +#define DMA_LEN           4
> +
> +/* RISC-V virt machine PCI configuration */
> +#define RISCV_GPEX_PIO_BASE        0x3000000
> +#define RISCV_BUS_PIO_LIMIT        0x10000
> +#define RISCV_BUS_MMIO_ALLOC_PTR   0x40000000
> +#define RISCV_BUS_MMIO_LIMIT       0x80000000
> +#define RISCV_ECAM_ALLOC_PTR       0x30000000
> +
> +typedef struct RiscvIommuTestState {
> +    QTestState *qts;
> +    QGenericPCIBus gbus;
> +    QPCIDevice *iommu_dev;
> +    QPCIDevice *testdev;
> +    QPCIBar testdev_bar;
> +    uint64_t iommu_base;
> +} RiscvIommuTestState;
> +
> +static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
> +{
> +    qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
> +    qpci->bus.pio_limit = RISCV_BUS_PIO_LIMIT;
> +    qpci->bus.mmio_alloc_ptr = RISCV_BUS_MMIO_ALLOC_PTR;
> +    qpci->bus.mmio_limit = RISCV_BUS_MMIO_LIMIT;
> +    qpci->ecam_alloc_ptr = RISCV_ECAM_ALLOC_PTR;
> +}
> +
> +static uint64_t riscv_iommu_expected_gpa(uint64_t iova)
> +{
> +    return QRIOMMU_SPACE_OFFS + QRIOMMU_L2_PTE_VAL + (iova & 0xfff);
> +}
> +
> +static void save_fn(QPCIDevice *dev, int devfn, void *data)
> +{
> +    QPCIDevice **pdev = (QPCIDevice **) data;
> +    uint16_t vendor = qpci_config_readw(dev, 0);
> +    uint16_t device = qpci_config_readw(dev, 2);
> +
> +    g_test_message("Found PCI device: vendor=0x%04x device=0x%04x devfn=0x%02x",
> +                   vendor, device, devfn);
> +
> +    if (!*pdev) {
> +        *pdev = dev;
> +    }
> +}
> +
> +static QPCIDevice *find_riscv_iommu_pci(QGenericPCIBus *gbus,
> +                                        uint64_t *iommu_base)
> +{
> +    QPCIDevice *iommu_dev = NULL;
> +    QPCIBar iommu_bar;
> +
> +    g_test_message("Searching for riscv-iommu-pci "
> +                   "(vendor=0x%04x, device=0x%04x)",
> +                   RISCV_IOMMU_PCI_VENDOR_ID, RISCV_IOMMU_PCI_DEVICE_ID);
> +
> +    qpci_device_foreach(&gbus->bus, RISCV_IOMMU_PCI_VENDOR_ID,
> +                        RISCV_IOMMU_PCI_DEVICE_ID, save_fn, &iommu_dev);
> +
> +    if (!iommu_dev) {
> +        g_test_message("riscv-iommu-pci device not found!");
> +        return NULL;
> +    }
> +
> +    g_test_message("Found riscv-iommu-pci at devfn=0x%02x", iommu_dev->devfn);
> +
> +    qpci_device_enable(iommu_dev);
> +    iommu_bar = qpci_iomap(iommu_dev, 0, NULL);
> +    g_assert_false(iommu_bar.is_io);
> +
> +    *iommu_base = iommu_bar.addr;
> +    g_test_message("RISC-V IOMMU MMIO base address: 0x%lx", *iommu_base);
> +
> +    return iommu_dev;
> +}
> +
> +static QPCIDevice *find_iommu_testdev(QGenericPCIBus *gbus, QPCIBar *bar)
> +{
> +    QPCIDevice *dev = NULL;
> +
> +    g_test_message("Searching for iommu-testdev (vendor=0x%04x, device=0x%04x)",
> +                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
> +
> +    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
> +                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
> +{
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return false;
> +    }
> +
> +    state->qts = qtest_init("-machine virt,acpi=off "
> +                            "-cpu max -smp 1 -m 512 -net none "
> +                            "-device riscv-iommu-pci "
> +                            "-device iommu-testdev");
> +
> +    qpci_init_generic(&state->gbus, state->qts, NULL, false);
> +    riscv_config_qpci_bus(&state->gbus);
> +
> +    state->iommu_dev = find_riscv_iommu_pci(&state->gbus, &state->iommu_base);
> +    g_assert(state->iommu_dev);
> +
> +    state->testdev = find_iommu_testdev(&state->gbus, &state->testdev_bar);
> +    g_assert(state->testdev);
> +
> +    return true;
> +}
> +
> +static void riscv_iommu_test_teardown(RiscvIommuTestState *state)
> +{
> +    qtest_quit(state->qts);
> +}
> +
> +static uint64_t riscv_iommu_check(QTestState *qts, uint64_t iommu_base,
> +                                  QRIOMMUTransMode mode)
> +{
> +    uint64_t cap;
> +    uint64_t ddtp;
> +    uint32_t cqcsr;
> +    uint32_t fqcsr;
> +    uint32_t pqcsr;
> +    uint32_t fctl;
> +    uint32_t fctl_mask;
> +    uint32_t fctl_desired;
> +    uint32_t igs;
> +
> +    cap = qtest_readq(qts, iommu_base + RISCV_IOMMU_REG_CAP);
> +    g_assert_cmpuint((uint32_t)(cap & RISCV_IOMMU_CAP_VERSION), ==,
> +                     RISCV_IOMMU_SPEC_DOT_VER);
> +
> +    fctl = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FCTL);
> +    igs = (cap & RISCV_IOMMU_CAP_IGS) >> 28;
> +    g_assert_cmpuint(igs, <=, RISCV_IOMMU_CAP_IGS_BOTH);
> +
> +    fctl_mask = RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI |
> +                RISCV_IOMMU_FCTL_GXL;
> +    fctl_desired = fctl & ~fctl_mask;
> +    if (igs == RISCV_IOMMU_CAP_IGS_WSI) {
> +        fctl_desired |= RISCV_IOMMU_FCTL_WSI;
> +    }
> +
> +    if ((fctl & fctl_mask) != (fctl_desired & fctl_mask)) {
> +        ddtp = qtest_readq(qts, iommu_base + RISCV_IOMMU_REG_DDTP);
> +        cqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_CQCSR);
> +        fqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FQCSR);
> +        pqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_PQCSR);
> +
> +        g_assert_cmpuint((uint32_t)(ddtp & RISCV_IOMMU_DDTP_MODE), ==,
> +                         RISCV_IOMMU_DDTP_MODE_OFF);
> +        g_assert_cmpuint(cqcsr & RISCV_IOMMU_CQCSR_CQON, ==, 0);
> +        g_assert_cmpuint(fqcsr & RISCV_IOMMU_FQCSR_FQON, ==, 0);
> +        g_assert_cmpuint(pqcsr & RISCV_IOMMU_PQCSR_PQON, ==, 0);
> +
> +        qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_FCTL, fctl_desired);
> +        fctl = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FCTL);
> +    }
> +
> +    g_assert_cmpuint(fctl & fctl_mask, ==, fctl_desired & fctl_mask);
> +
> +    if (mode == QRIOMMU_TM_S_STAGE_ONLY || mode == QRIOMMU_TM_NESTED) {
> +        g_assert((cap & RISCV_IOMMU_CAP_SV39) != 0);
> +    }
> +    if (mode == QRIOMMU_TM_G_STAGE_ONLY || mode == QRIOMMU_TM_NESTED) {
> +        g_assert((cap & RISCV_IOMMU_CAP_SV39X4) != 0);
> +        g_assert_cmpuint(fctl & RISCV_IOMMU_FCTL_GXL, ==, 0);
> +    }
> +
> +    return cap;
> +}
> +
> +static void run_riscv_iommu_translation(const QRIOMMUTestConfig *cfg)
> +{
> +    RiscvIommuTestState state = { 0 };
> +
> +    if (!riscv_iommu_test_setup(&state)) {
> +        return;
> +    }
> +
> +    riscv_iommu_check(state.qts, state.iommu_base, cfg->trans_mode);
> +
> +    g_test_message("### RISC-V IOMMU translation mode=%d ###",
> +                   cfg->trans_mode);
> +    qriommu_run_translation_case(state.qts, state.testdev, state.testdev_bar,
> +                                 state.iommu_base, cfg);
> +    riscv_iommu_test_teardown(&state);
> +}
> +
> +static void test_riscv_iommu_bare(void)
> +{
> +    QRIOMMUTestConfig cfg = {
> +        .trans_mode = QRIOMMU_TM_BARE,
> +        .dma_gpa = QRIOMMU_IOVA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_riscv_iommu_translation(&cfg);
> +}
> +
> +static void test_riscv_iommu_s_stage_only(void)
> +{
> +    QRIOMMUTestConfig cfg = {
> +        .trans_mode = QRIOMMU_TM_S_STAGE_ONLY,
> +        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_riscv_iommu_translation(&cfg);
> +}
> +
> +static void test_riscv_iommu_g_stage_only(void)
> +{
> +    QRIOMMUTestConfig cfg = {
> +        .trans_mode = QRIOMMU_TM_G_STAGE_ONLY,
> +        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_riscv_iommu_translation(&cfg);
> +}
> +
> +static void test_riscv_iommu_nested(void)
> +{
> +    QRIOMMUTestConfig cfg = {
> +        .trans_mode = QRIOMMU_TM_NESTED,
> +        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_riscv_iommu_translation(&cfg);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/translation/bare",
> +                   test_riscv_iommu_bare);
> +    qtest_add_func("/iommu-testdev/translation/s-stage-only",
> +                   test_riscv_iommu_s_stage_only);
> +    qtest_add_func("/iommu-testdev/translation/g-stage-only",
> +                   test_riscv_iommu_g_stage_only);
> +    qtest_add_func("/iommu-testdev/translation/ns-nested",
> +                   test_riscv_iommu_nested);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index a8b09d065f..eb45e0f97d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -286,7 +286,10 @@ qtests_riscv32 = \
>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>   
>   qtests_riscv64 = ['riscv-csr-test'] + \
> -  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
> +   config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> +   ['iommu-riscv-test'] : [])
>   
>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(


