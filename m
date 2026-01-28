Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A4CD3F080
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7b0-00026i-DW; Wed, 28 Jan 2026 10:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vl7ag-000242-6k; Wed, 28 Jan 2026 10:36:25 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vl7ac-0007AK-Ts; Wed, 28 Jan 2026 10:36:21 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3PJjoLHppYFh6Bg--.616S2;
 Wed, 28 Jan 2026 23:36:08 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.118.162])
 by mail (Coremail) with SMTP id AQAAfwAHX+ziLHppn14XAA--.40560S2;
 Wed, 28 Jan 2026 23:36:06 +0800 (CST)
Message-ID: <e51d2f40-2afa-4e6b-a2ca-2b1d83f5f371@phytium.com.cn>
Date: Wed, 28 Jan 2026 23:36:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
 <c31147ca6db874b32dcfea6ba4ad08f59ae356b1.1769600111.git.chao.liu.zevorn@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <c31147ca6db874b32dcfea6ba4ad08f59ae356b1.1769600111.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHX+ziLHppn14XAA--.40560S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWl5G-QHbAAFsc
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3urW3uFyfZw4DuFW7AF4ruFg_yoWkKrWfpF
 95GFWakrWxJr1fJFn3Xw1jkr9Y9w4DC3W5ury5WFWDuF4DJrWjqF1qgayj9r4kGFW8Z3WU
 A3WFgrsxZr4jq3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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


There was a cross-compilation error on mingw64:

../tests/qtest/iommu-riscv-test.c: In function 'find_riscv_iommu_pci':
../tests/qtest/iommu-riscv-test.c:93:57: error: format '%lx' expects 
argument of type 'long unsigned int', but argument 2 has type 'uint64_t' 
{aka 'long long unsigned int'} [-Werror=format=]
    93 |     g_test_message("RISC-V IOMMU MMIO base address: 0x%lx", 
*iommu_base);
       |                                                       ~~^ 
  ~~~~~~~~~~~
       |                                                         |  |
       |                                                         | 
  uint64_t {aka long long unsigned int}
       |  long unsigned int
       |                                                       %llx

I think we should use PRIx64 instead.

You can check the result in this link [1]. And try it again with 
Pierrick's downstream fork [2]

[1] https://github.com/hnusdr/qemu/actions/runs/21438370066/job/61734760185

[2] https://github.com/pbo-linaro/qemu/


Thanks,

Tao

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


