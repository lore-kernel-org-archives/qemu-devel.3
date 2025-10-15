Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABB3CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 03:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8sdq-0001cJ-FV; Tue, 14 Oct 2025 23:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v8sdj-0001Zs-9I
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:57:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v8sdV-0006n5-Pq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:57:25 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8Bx1tCSG+9ookUWAA--.47644S3;
 Wed, 15 Oct 2025 11:57:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowJCxM+SEG+9oJMrkAA--.45496S5;
 Wed, 15 Oct 2025 11:57:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 3/4] hw/loongarch/virt: Remove header file ls7a.h
Date: Wed, 15 Oct 2025 11:56:50 +0800
Message-Id: <20251015035651.1462972-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251015035651.1462972-1-maobibo@loongson.cn>
References: <20251015035651.1462972-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+SEG+9oJMrkAA--.45496S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr1UJF1kCr1fJr48Ar4rCrX_yoW3WF48p3
 Z8CFn09rs5Ga47WryvqFy3X347JFs7C3W2vF4xurWrAF13Gr18Zry8twsYgFyUX395JFyI
 qr95K3sFg3Z8ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LoongArch virt machine uses GPEX PCIE host bridge rather than 7A host
bridge. Remove header file ls7a.h and put hardware information to file
include/hw/loongarch/virt.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS                            |  1 -
 hw/intc/loongarch_pic_kvm.c            |  1 -
 hw/loongarch/virt-acpi-build.c         |  1 -
 hw/loongarch/virt-fdt-build.c          |  1 -
 hw/loongarch/virt.c                    |  1 -
 include/hw/intc/loongarch_pic_common.h |  2 +-
 include/hw/loongarch/virt.h            | 39 ++++++++++++++++++++++++++
 include/hw/pci-host/ls7a.h             | 39 --------------------------
 8 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85e1f..0c766961f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1308,7 +1308,6 @@ F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
 
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index dd504ec6a6..6cfddf4520 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -10,7 +10,6 @@
 #include "hw/boards.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/loongarch/virt.h"
-#include "hw/pci-host/ls7a.h"
 #include "system/kvm.h"
 
 static void kvm_pch_pic_access_reg(int fd, uint64_t addr, void *val, bool write)
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8c2228a772..3694c9827f 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -21,7 +21,6 @@
 #include "system/reset.h"
 
 /* Supported chipsets: */
-#include "hw/pci-host/ls7a.h"
 #include "hw/loongarch/virt.h"
 
 #include "hw/acpi/utils.h"
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 728ce46699..1f0ba01f71 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -12,7 +12,6 @@
 #include "hw/loader.h"
 #include "hw/loongarch/virt.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/pci-host/ls7a.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
 #include "target/loongarch/cpu.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c1760423ee..efd1f9ac49 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -29,7 +29,6 @@
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_dintc.h"
-#include "hw/pci-host/ls7a.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/misc/unimp.h"
 #include "hw/loongarch/fw_cfg.h"
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index f774c975d4..675ba96e64 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -7,7 +7,7 @@
 #ifndef HW_LOONGARCH_PIC_COMMON_H
 #define HW_LOONGARCH_PIC_COMMON_H
 
-#include "hw/pci-host/ls7a.h"
+#include "hw/loongarch/virt.h"
 #include "hw/sysbus.h"
 
 #define PCH_PIC_INT_ID                  0x00
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 76fa57cd07..0cc1b499a7 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -25,6 +25,7 @@
 #define IOCSRF_VM               11
 #define IOCSRF_DMSI             15
 
+/* IOCSR region */
 #define VERSION_REG             0x0
 #define FEATURE_REG             0x8
 #define VENDOR_REG              0x10
@@ -36,6 +37,18 @@
 
 #define LOONGARCH_MAX_CPUS      256
 
+/* MMIO memory region */
+#define VIRT_PCH_REG_BASE       0x10000000UL
+#define VIRT_PCH_REG_SIZE       0x400
+#define VIRT_IOAPIC_REG_BASE    (VIRT_PCH_REG_BASE)
+#define VIRT_MISC_REG_BASE      (VIRT_PCH_REG_BASE + 0x00080000)
+#define VIRT_RTC_REG_BASE       (VIRT_MISC_REG_BASE + 0x00050100)
+#define VIRT_RTC_LEN            0x100
+#define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000UL
+#define VIRT_PLATFORM_BUS_SIZE          0x02000000
+#define VIRT_PCI_IO_BASE        0x18004000UL
+#define VIRT_PCI_IO_OFFSET      0x4000
+#define VIRT_PCI_IO_SIZE        0xC000
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
 #define VIRT_BIOS_SIZE          (16 * MiB)
@@ -44,6 +57,16 @@
 #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
 #define VIRT_FLASH1_BASE        0x1d000000UL
 #define VIRT_FLASH1_SIZE        (16 * MiB)
+#define VIRT_UART_BASE          0x1fe001e0UL
+#define VIRT_UART_SIZE          0x100
+#define VIRT_PCI_CFG_BASE       0x20000000UL
+#define VIRT_PCI_CFG_SIZE       0x08000000UL
+#define VIRT_DINTC_BASE         0x2FE00000UL
+#define VIRT_DINTC_SIZE         0x00100000UL
+#define VIRT_PCH_MSI_ADDR_LOW   0x2FF00000UL
+#define VIRT_PCH_MSI_SIZE       0x8
+#define VIRT_PCI_MEM_BASE       0x40000000UL
+#define VIRT_PCI_MEM_SIZE       0x40000000UL
 
 #define VIRT_LOWMEM_BASE        0
 #define VIRT_LOWMEM_SIZE        0x10000000
@@ -53,6 +76,22 @@
 #define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN, 4)
 #define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT, 4)
 
+/*
+ * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
+ * 0  - 15  GSI for ISA devices even if there is no ISA devices
+ * 16 - 63  GSI for CPU devices such as timers/perf monitor etc
+ * 64 -     GSI for external devices
+ */
+#define VIRT_PCH_PIC_IRQ_NUM     32
+#define VIRT_GSI_BASE            64
+#define VIRT_DEVICE_IRQS         16
+#define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
+#define VIRT_UART_COUNT          4
+#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
+#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
+#define VIRT_PLATFORM_BUS_IRQ    (VIRT_GSI_BASE + 8)
+#define VIRT_PLATFORM_BUS_NUM_IRQS      2
+
 #define COMMAND_LINE_SIZE       512
 
 #define FDT_BASE                0x100000
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index bfdbfe3614..33e7942de9 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -13,43 +13,4 @@
 #include "qemu/range.h"
 #include "qom/object.h"
 
-#define VIRT_PCI_MEM_BASE        0x40000000UL
-#define VIRT_PCI_MEM_SIZE        0x40000000UL
-#define VIRT_PCI_IO_OFFSET       0x4000
-#define VIRT_PCI_CFG_BASE        0x20000000
-#define VIRT_PCI_CFG_SIZE        0x08000000
-#define VIRT_PCI_IO_BASE         0x18004000UL
-#define VIRT_PCI_IO_SIZE         0xC000
-
-#define VIRT_PCH_REG_BASE        0x10000000UL
-#define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
-#define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
-#define VIRT_DINTC_SIZE          0x100000UL
-#define VIRT_DINTC_BASE          0x2FE00000UL
-#define VIRT_PCH_REG_SIZE        0x400
-#define VIRT_PCH_MSI_SIZE        0x8
-
-/*
- * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
- * 0  - 15  GSI for ISA devices even if there is no ISA devices
- * 16 - 63  GSI for CPU devices such as timers/perf monitor etc
- * 64 -     GSI for external devices
- */
-#define VIRT_PCH_PIC_IRQ_NUM     32
-#define VIRT_GSI_BASE            64
-#define VIRT_DEVICE_IRQS         16
-#define VIRT_UART_COUNT          4
-#define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
-#define VIRT_UART_BASE           0x1fe001e0
-#define VIRT_UART_SIZE           0x100
-#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
-#define VIRT_MISC_REG_BASE       (VIRT_PCH_REG_BASE + 0x00080000)
-#define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
-#define VIRT_RTC_LEN             0x100
-#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
-
-#define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
-#define VIRT_PLATFORM_BUS_SIZE          0x2000000
-#define VIRT_PLATFORM_BUS_NUM_IRQS      2
-#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 8)
 #endif
-- 
2.43.5


