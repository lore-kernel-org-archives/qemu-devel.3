Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78966CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8C9k-0003Ov-8S; Mon, 13 Oct 2025 02:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v8C9g-0003O8-IY
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:35:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v8C9Y-0008Bv-S9
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:35:32 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx2tGnnexoWnkVAA--.46503S3;
 Mon, 13 Oct 2025 14:35:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8GlnexozkDdAA--.57976S4;
 Mon, 13 Oct 2025 14:35:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/loongarch/virt: Sort order by hardware device base
 address
Date: Mon, 13 Oct 2025 14:35:16 +0800
Message-Id: <20251013063516.688936-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251013063516.688936-1-maobibo@loongson.cn>
References: <20251013063516.688936-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8GlnexozkDdAA--.57976S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With header file include/hw/loongarch/virt.h, hardware device definition
order is sorted by its base address. Add remove unused macro
VIRT_IOAPIC_REG_BASE and VIRT_MISC_REG_BASE.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         |  2 +-
 include/hw/loongarch/virt.h | 42 +++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index efd1f9ac49..49434ad182 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -520,7 +520,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         }
 
         /* PCH_PIC memory region */
-        memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
+        memory_region_add_subregion(get_system_memory(), VIRT_PCH_REG_BASE,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(pch_pic), 0));
 
         /* Connect pch_pic irqs to extioi */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 0cc1b499a7..27b1755802 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -13,50 +13,47 @@
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
-#define IOCSRF_TEMP             0
-#define IOCSRF_NODECNT          1
-#define IOCSRF_MSI              2
-#define IOCSRF_EXTIOI           3
-#define IOCSRF_CSRIPI           4
-#define IOCSRF_FREQCSR          5
-#define IOCSRF_FREQSCALE        6
-#define IOCSRF_DVFSV1           7
-#define IOCSRF_GMOD             9
-#define IOCSRF_VM               11
-#define IOCSRF_DMSI             15
-
 /* IOCSR region */
 #define VERSION_REG             0x0
 #define FEATURE_REG             0x8
+#define  IOCSRF_TEMP             0
+#define  IOCSRF_NODECNT          1
+#define  IOCSRF_MSI              2
+#define  IOCSRF_EXTIOI           3
+#define  IOCSRF_CSRIPI           4
+#define  IOCSRF_FREQCSR          5
+#define  IOCSRF_FREQSCALE        6
+#define  IOCSRF_DVFSV1           7
+#define  IOCSRF_GMOD             9
+#define  IOCSRF_VM               11
+#define  IOCSRF_DMSI             15
 #define VENDOR_REG              0x10
 #define CPUNAME_REG             0x20
 #define MISC_FUNC_REG           0x420
-#define IOCSRM_EXTIOI_EN        48
-#define IOCSRM_EXTIOI_INT_ENCODE 49
-#define IOCSRM_DMSI_EN          51
+#define  IOCSRM_EXTIOI_EN         48
+#define  IOCSRM_EXTIOI_INT_ENCODE 49
+#define  IOCSRM_DMSI_EN           51
 
 #define LOONGARCH_MAX_CPUS      256
 
 /* MMIO memory region */
 #define VIRT_PCH_REG_BASE       0x10000000UL
 #define VIRT_PCH_REG_SIZE       0x400
-#define VIRT_IOAPIC_REG_BASE    (VIRT_PCH_REG_BASE)
-#define VIRT_MISC_REG_BASE      (VIRT_PCH_REG_BASE + 0x00080000)
-#define VIRT_RTC_REG_BASE       (VIRT_MISC_REG_BASE + 0x00050100)
+#define VIRT_RTC_REG_BASE       0x100d0100UL
 #define VIRT_RTC_LEN            0x100
 #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000UL
 #define VIRT_PLATFORM_BUS_SIZE          0x02000000
 #define VIRT_PCI_IO_BASE        0x18004000UL
 #define VIRT_PCI_IO_OFFSET      0x4000
 #define VIRT_PCI_IO_SIZE        0xC000
-#define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
-#define VIRT_BIOS_SIZE          (16 * MiB)
+#define VIRT_BIOS_SIZE          0x01000000UL
 #define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
 #define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
 #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
 #define VIRT_FLASH1_BASE        0x1d000000UL
-#define VIRT_FLASH1_SIZE        (16 * MiB)
+#define VIRT_FLASH1_SIZE        0x01000000UL
+#define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_UART_BASE          0x1fe001e0UL
 #define VIRT_UART_SIZE          0x100
 #define VIRT_PCI_CFG_BASE       0x20000000UL
@@ -70,6 +67,7 @@
 
 #define VIRT_LOWMEM_BASE        0
 #define VIRT_LOWMEM_SIZE        0x10000000
+#define FDT_BASE                0x100000
 #define VIRT_HIGHMEM_BASE       0x80000000
 #define VIRT_GED_EVT_ADDR       0x100e0000
 #define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN, 4)
@@ -94,8 +92,6 @@
 
 #define COMMAND_LINE_SIZE       512
 
-#define FDT_BASE                0x100000
-
 struct LoongArchVirtMachineState {
     /*< private >*/
     MachineState parent_obj;
-- 
2.39.3


