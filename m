Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E27CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 01:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLpA-0007eF-EO; Sun, 23 Nov 2025 20:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vNLox-0007cN-Og; Sun, 23 Nov 2025 20:56:55 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vNLon-0004nj-P0; Sun, 23 Nov 2025 20:56:46 -0500
Received: from [10.13.14.160] (unknown [218.81.29.112])
 by APP-03 (Coremail) with SMTP id rQCowAC3QdRJuyNpeBzaAQ--.62158S2;
 Mon, 24 Nov 2025 09:56:26 +0800 (CST)
Message-ID: <b1d0bc43-96cd-4919-b5c5-d004e422e902@isrc.iscas.ac.cn>
Date: Mon, 24 Nov 2025 09:56:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: alistair.francis@wdc.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wu.fei9@sanechips.com.cn,
 zhiwei_liu@linux.alibaba.com, xiaofan@iscas.ac.cn, wangjingwei@iscas.ac.cn
References: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowAC3QdRJuyNpeBzaAQ--.62158S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kKFWUZw1rCr47ZrW7XFb_yoWfuF4UpF
 4UCFs8CF4kJF1fK3sFgw1SyF15Gan3uFW5uryxuF13AF4Duw4UJrsrKw18GFyxJF4kt3ya
 kF95Gw1avayUW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU56yI5UUUUU==
X-Originating-IP: [218.81.29.112]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiBwkQAGkjuhsFKAAAsY
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 11 Nov 2025 15:29:42 -0300, Daniel Henrique Barboza wrote:
>From: Fei Wu <wu.fei9@sanechips.com.cn>
>
>The RISC-V Server Platform specification [1] defines a standardized set
>of hardware and software capabilities, that portable system software,
>such as OS and hypervisors can rely on being present in a RISC-V server
>platform.
>
>We do not have all the required extensions in QEMU: we're missing
>'sdext'. In theory we shouldn't go ahead with this work, but the
>emulation as is now is proving to be useful for development and testing
>of other parts of the SW stack (firmware, kernel) and we would like to
>make it broadly available to everyone. We're contributing it as
>'experimental', hopefully making it clear that the board does NOT
>complies 100% with [1].
>
>The main features included in this emulation are:
>
> - Based on riscv virt machine type
> - A new memory map as close as virt machine as possible
> - A new virt CPU type rvsp-ref-cpu for server platform compliance
> - AIA
> - PCIe AHCI
> - PCIe NIC
> - No virtio device
> - No fw_cfg device
> - No ACPI table provided
> - Only minimal device tree nodes
>
>[1] https://github.com/riscv-non-isa/riscv-server-platform
>
>Signed-off-by: Fei Wu <fei2.wu@intel.com>
>Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>---
> configs/devices/riscv64-softmmu/default.mak |    1 +
> hw/riscv/Kconfig                            |   14 +
> hw/riscv/meson.build                        |    1 +
> hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
> 4 files changed, 1292 insertions(+)
> create mode 100644 hw/riscv/server_platform_ref.c
>
>diff --git a/configs/devices/riscv64-softmmu/default.mak
b/configs/devices/riscv64-softmmu/default.mak
>index e485bbd1a3..e6075a7113 100644
>--- a/configs/devices/riscv64-softmmu/default.mak
>+++ b/configs/devices/riscv64-softmmu/default.mak
>@@ -9,6 +9,7 @@
> # CONFIG_SIFIVE_E=n
> # CONFIG_SIFIVE_U=n
> # CONFIG_RISCV_VIRT=n
>+# CONFIG_SERVER_PLATFORM_REF=n
> # CONFIG_MICROCHIP_PFSOC=n
> # CONFIG_SHAKTI_C=n
> # CONFIG_XIANGSHAN_KUNMINGHU=n
>diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>index fc9c35bd98..6a5085c7a5 100644
>--- a/hw/riscv/Kconfig
>+++ b/hw/riscv/Kconfig
>@@ -69,6 +69,20 @@ config RISCV_VIRT
>     select ACPI
>     select ACPI_PCI
>
>+config SERVER_PLATFORM_REF
>+    bool
>+    default y
>+    depends on RISCV64
>+    select RISCV_NUMA
>+    select GOLDFISH_RTC
>+    select PCI
>+    select PCI_EXPRESS_GENERIC_BRIDGE
>+    select PFLASH_CFI01
>+    select SERIAL
>+    select RISCV_ACLINT
>+    select RISCV_APLIC
>+    select RISCV_IMSIC
>+
> config SHAKTI_C
>     bool
>     default y
>diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>index 2a8d5b136c..0daf77e887 100644
>--- a/hw/riscv/meson.build
>+++ b/hw/riscv/meson.build
>@@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
> riscv_ss.add(files('riscv_hart.c'))
> riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>+riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true:
files('server_platform_ref.c'))
> riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
> riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>new file mode 100644
>index 0000000000..ef2891a9d7
>--- /dev/null
>+++ b/hw/riscv/server_platform_ref.c
>@@ -0,0 +1,1276 @@
>+/*
>+ * QEMU RISC-V Server Platform (RVSP) Reference Board
>+ *
>+ * Copyright (c) 2024 Intel, Inc.
>+ * Copyright (c) 2025 Ventana Micro Systems Inc.
>+ *
>+ * This board is compliant RISC-V Server platform specification and leveraging
>+ * a lot of riscv virt code.
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qemu/units.h"
>+#include "qemu/error-report.h"
>+#include "qemu/guest-random.h"
>+#include "qapi/error.h"
>+#include "qapi/qapi-visit-common.h"
>+#include "hw/boards.h"
>+#include "hw/loader.h"
>+#include "hw/sysbus.h"
>+#include "hw/qdev-properties.h"
>+#include "hw/char/serial.h"
>+#include "hw/block/flash.h"
>+#include "hw/ide/pci.h"
>+#include "hw/ide/ahci-pci.h"
>+#include "hw/pci/pci.h"
>+#include "hw/pci-host/gpex.h"
>+#include "hw/core/sysbus-fdt.h"
>+#include "hw/riscv/riscv_hart.h"
>+#include "hw/riscv/boot.h"
>+#include "hw/riscv/numa.h"
>+#include "hw/intc/riscv_aclint.h"
>+#include "hw/intc/riscv_aplic.h"
>+#include "hw/intc/riscv_imsic.h"
>+#include "chardev/char.h"
>+#include "hw/char/serial-mm.h"
>+#include "system/device_tree.h"
>+#include "system/runstate.h"
>+#include "system/system.h"
>+#include "system/tcg.h"
>+#include "system/qtest.h"
>+#include "target/riscv/cpu.h"
>+#include "target/riscv/pmu.h"
>+#include "net/net.h"
>+
>+#define RVSP_CPUS_MAX_BITS             9
>+#define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
>+#define RVSP_SOCKETS_MAX_BITS          2
>+#define RVSP_SOCKETS_MAX               (1 << RVSP_SOCKETS_MAX_BITS)
>+
>+#define RVSP_IRQCHIP_NUM_MSIS 255
>+#define RVSP_IRQCHIP_NUM_SOURCES 96
>+#define RVSP_IRQCHIP_NUM_PRIO_BITS 3
>+#define RVSP_IRQCHIP_MAX_GUESTS_BITS 3
>+#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - 1U)
>+
>+#define FDT_PCI_ADDR_CELLS    3
>+#define FDT_PCI_INT_CELLS     1
>+#define FDT_APLIC_INT_CELLS   2
>+#define FDT_IMSIC_INT_CELLS   0
>+#define FDT_MAX_INT_CELLS     2
>+#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>+                                 1 + FDT_MAX_INT_CELLS)
>+#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>+                                 1 + FDT_APLIC_INT_CELLS)
>+
>+#define NUM_SATA_PORTS  6
>+
>+#define SYSCON_RESET     0x1
>+#define SYSCON_POWEROFF  0x2
>+
>+#define TYPE_RVSP_REF_MACHINE MACHINE_TYPE_NAME("rvsp-ref")
>+OBJECT_DECLARE_SIMPLE_TYPE(RVSPMachineState, RVSP_REF_MACHINE)
>+
>+struct RVSPMachineState {
>+    /*< private >*/
>+    MachineState parent;
>+
>+    /*< public >*/
>+    Notifier machine_done;
>+    RISCVHartArrayState soc[RVSP_SOCKETS_MAX];
>+    DeviceState *irqchip[RVSP_SOCKETS_MAX];
>+    PFlashCFI01 *flash[2];
>+
>+    int fdt_size;
>+    int aia_guests;
>+    const MemMapEntry *memmap;
>+};
>+
>+enum {
>+    RVSP_DEBUG,
>+    RVSP_MROM,
>+    RVSP_RESET_SYSCON,
>+    RVSP_RTC,
>+    RVSP_ACLINT,
>+    RVSP_APLIC_M,
>+    RVSP_APLIC_S,
>+    RVSP_UART0,
>+    RVSP_IMSIC_M,
>+    RVSP_IMSIC_S,
>+    RVSP_FLASH,
>+    RVSP_DRAM,
>+    RVSP_PCIE_MMIO,
>+    RVSP_PCIE_PIO,
>+    RVSP_PCIE_ECAM,
>+    RVSP_PCIE_MMIO_HIGH
>+};
>+
>+enum {
>+    RVSP_UART0_IRQ = 10,
>+    RVSP_RTC_IRQ = 11,
>+    RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
>+};
>+
>+/*
>+ * The server soc reference machine physical address space used by some of the
>+ * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
>+ * of CPUs, and number of IMSIC guest files.
>+ *
>+ * Various limits defined by RVSP_SOCKETS_MAX_BITS, RVSP_CPUS_MAX_BITS, and
>+ * RVSP_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of server soc
>+ * reference machine physical address space.
>+ */
>+
>+#define RVSP_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
>+#if RVSP_IMSIC_GROUP_MAX_SIZE < \
>+    IMSIC_GROUP_SIZE(RVSP_CPUS_MAX_BITS, RVSP_IRQCHIP_MAX_GUESTS_BITS)
>+#error "Can't accomodate single IMSIC group in address space"
>+#endif
>+
>+#define RVSP_IMSIC_MAX_SIZE            (RVSP_SOCKETS_MAX * \
>+                                        RVSP_IMSIC_GROUP_MAX_SIZE)
>+#if 0x4000000 < RVSP_IMSIC_MAX_SIZE
>+#error "Can't accomodate all IMSIC groups in address space"
>+#endif
>+
>+static const MemMapEntry rvsp_ref_memmap[] = {
>+    [RVSP_DEBUG] =          {        0x0,         0x100 },
>+    [RVSP_MROM] =           {     0x1000,        0xf000 },
>+    [RVSP_RESET_SYSCON] =   {   0x100000,        0x1000 },
>+    [RVSP_RTC] =            {   0x101000,        0x1000 },
>+    [RVSP_ACLINT] =         {  0x2000000,       0x10000 },
>+    [RVSP_PCIE_PIO] =       {  0x3000000,       0x10000 },
>+    [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>+    [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>+    [RVSP_UART0] =          { 0x10000000,         0x100 },
>+    [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
>+    [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
>+    [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
>+    [RVSP_PCIE_ECAM] =      { 0x30000000,    0x10000000 },
>+    [RVSP_PCIE_MMIO] =      { 0x40000000,    0x40000000 },
>+    [RVSP_DRAM] =           { 0x80000000, 0xff80000000ull },
>+    [RVSP_PCIE_MMIO_HIGH] = { 0x10000000000ull, 0x10000000000ull },
The base address of RVSP_PCIE_MMIO_HIGH exceeds the 39-bit address space, while
the satp mode of the rvsp-ref-cpu is SV39 (based on the RVA23S64).

static RISCVCPUProfile RVA23S64 = {
    .u_parent = &RVA23U64,
    .s_parent = &RVA22S64,
    .name = "rva23s64",
    .misa_ext = RVS,
    .priv_spec = PRIV_VERSION_1_13_0,
    .satp_mode = VM_1_10_SV39, /* there */
    ...
}

This will cause an error when EDKII processes the address mapping of PCI MMIO,
but I am not yet sure whose issue this is.

I suggest setting the default value of satp_mode for rvsp-ref-cpu to SV48.

Thanks,
Chao


