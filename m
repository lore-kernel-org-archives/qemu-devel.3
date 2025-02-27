Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5097FC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngvm-0007y9-Pd; Thu, 27 Feb 2025 11:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngvO-0007jV-2S; Thu, 27 Feb 2025 11:39:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngvF-0006KH-Iv; Thu, 27 Feb 2025 11:39:49 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C15EE4E61D4;
 Thu, 27 Feb 2025 17:39:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id s4Es38NyKC_X; Thu, 27 Feb 2025 17:39:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 603DD4E60F7; Thu, 27 Feb 2025 17:39:19 +0100 (CET)
Message-Id: <3b8e54ad9220d57e7b0a33f3570e880f26677ce8.1740673173.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740673173.git.balaton@eik.bme.hu>
References: <cover.1740673173.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 5/5] ppc/amigaone: Add #defines for memory map constants
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 27 Feb 2025 17:39:19 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/amigaone.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 04ff415a6b..f6c9eb69ab 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -32,6 +32,14 @@
 #define BUS_FREQ_HZ 100000000
 
 #define INITRD_MIN_ADDR 0x600000
+#define INIT_RAM_ADDR 0x40000000
+
+#define PCI_HIGH_ADDR 0x80000000
+#define PCI_HIGH_SIZE 0x7d000000
+#define PCI_LOW_ADDR  0xfd000000
+#define PCI_LOW_SIZE  0xe0000
+
+#define ARTICIA_ADDR 0xfe000000
 
 /*
  * Firmware binary available at
@@ -287,7 +295,7 @@ static void amigaone_init(MachineState *machine)
         /* Firmware uses this area for startup */
         mr = g_new(MemoryRegion, 1);
         memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
-        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
+        memory_region_add_subregion(get_system_memory(), INIT_RAM_ADDR, mr);
     }
 
     /* nvram */
@@ -322,7 +330,7 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* Articia S */
-    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
+    dev = sysbus_create_simple(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
 
     i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
     if (machine->ram_size > 512 * MiB) {
@@ -339,12 +347,12 @@ static void amigaone_init(MachineState *machine)
     pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
-                             0, 0xe0000);
-    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
+                             0, PCI_LOW_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
-                             0x80000000, 0x7d000000);
-    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
+                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
-- 
2.30.9


