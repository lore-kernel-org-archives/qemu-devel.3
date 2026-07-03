Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE22C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVaf-00008l-I6; Fri, 03 Jul 2026 00:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>) id 1wfVaE-00007n-Vl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:33:00 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>) id 1wfVa9-0000h0-8i
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783053164; bh=RiFgciQA3M+IJVq0hkzAXpzV8ZJ++rWFjIm3UOgjLFM=;
 h=From:To:Cc:Subject:Date;
 b=a0yC8nn6swFZbPuWpkqjS+j+TI4ACtE6QG/Zzx2+wGLba3szQeub6jJ9eLJ6sS4oE
 kH2XIuiEySy/tQrjW+ZDg4qhydK9RfVnadjQZK0+4qSKCem8zZuJhWwWGmX7uYAesS
 yp1rT2z4b/XudVx7eCLeQyJH8lOs2Dbfd8ZQs87I=
Received: from qq.com ([118.116.35.199])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 63A1445E; Fri, 03 Jul 2026 12:24:58 +0800
X-QQ-mid: xmsmtpt1783052698trp230opd
Message-ID: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPssyRruCme3vn2d21BT1dj5ZdUF2rN8uWj7kSk3OVz+MP25pj7P
 XLC4aHRtWzrVWs3s/yw1sfSygSszlF7iES+UQbNfEa8h0YwwMKgp4aM2FMs6CbL67z2B2opzT5OD
 Fe0KVdfr7BEeB+1iIe4pZJa3JhxK00hXxnFDEfxKEdrWvEcoME7cxsTtmSMD2PLaV/ZiuPHZb1Nx
 5iM5oO6uFv57pQm+3Ju3vxrIbwq5+5Z/38NEjnV7t297Zzu5B1sSQUq8suRNn5ll7CscRMMIUfXK
 CPAQehZ1do/dA6qDyqR/bVJZcerm20jDEPuAKb1W5/3othVxTotRvqO288R13d3zmOyrqoCC8W+Y
 ZMag9AsotQLUPRTZPxQL5SBYckT4s/xpWmGwmyUnxJb+3tZoCeVqZB19QETI2VXSdrUIKly0jQ6c
 cga7HCjaCsVsFZPSV41kBSaXL6A3agthW0a5j0ay1Iix/Hcj3+VqH1Y9r7pldYxAnCSMG20VUSSR
 7pdFcnDHJ21hi/klYPZca36o4khQNMUymdJOZDiXOGnaPiAUJovjWjR0XiD0qcJ9G2sYUO/36MXs
 LY76zuPfnApDy2fDZYjsmUlBSvg3cNy3I7GK21z8uppULLOEM6YeGHGzkPsnGvh1T+w7zaOSmLmj
 DZsW3P+24y6ctTErBh/1WlxVlP7RU355SW1QrVoV+g3jtfsrmHYL55EIs86wjoJ2cszmfz7z1b17
 JA+NbJa/gm1cD/cHD3+2GKlDL72LokXnjzvAQBPcfgkCoBOwCOgBdbZfob+nyFS3DAlYMJ3qTkEJ
 3WU5sIAaYSmNOK7NjAmjgTNwL7H3D0rQ6qI9VFWstL//RVY+If7l1a6TJHIinmpZ03ed03Fw89LA
 U74AZZOz3tX02pt9hK6a+dijtJcyqOwfyfa5fQC7YtanRRJa72iV0UJqCWFrlN6IXEIPMUUVqqxj
 OwwQr25e0Qewyh6jiqC7mHr4SB8fx5IR00Q6k3a1nDThDu0zJfClKHNm5rd2f2c1DRpZw4PluH3B
 kaZwc6FrnPGfzuv3k5d61pCUuXciWJ8oPw193nuBy2SaJK/RM9
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 sunilvl@ventanamicro.com, pierrick.bouvier@oss.qualcomm.com,
 Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v2] riscv/virt: Add optional UART1
Date: Fri,  3 Jul 2026 12:24:55 +0800
X-OQ-MSGID: <20260703042455.27062-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.54; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This adds optional UART1 to RiscV virt board if required at
runtime to simplify multicore development.

Note that UART0 remains default serial_hd(0) and it is:

- the lowest address UART
- first serial in DTB
- behind /aliases/serial0 in DTB
- the /chosen/stdout-path in DTB

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 docs/system/riscv/virt.rst |  5 ++++-
 hw/riscv/virt-acpi-build.c | 12 ++++++++----
 hw/riscv/virt.c            | 39 ++++++++++++++++++++++++++++----------
 include/hw/riscv/virt.h    |  3 +++
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..45ac63ac77 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -16,7 +16,7 @@ The ``virt`` machine supports the following devices:
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
 * CFI parallel NOR flash memory
-* 1 NS16550 compatible UART
+* Either 1 or 2 NS16550 compatible UARTs
 * 1 Google Goldfish RTC
 * 1 SiFive Test device
 * 8 virtio-mmio transport devices
@@ -27,6 +27,9 @@ The hypervisor extension has been enabled for the default CPU, so virtual
 machines with hypervisor extension can simply be used without explicitly
 declaring.
 
+The second UART only exists if a backend is configured explicitly (e.g.
+with a second `-serial` command line option).
+
 Hardware configuration information
 ----------------------------------
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 413d47d70e..597751c84a 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -169,11 +169,11 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
 
 static void
 acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
-                    uint32_t uart_irq)
+                    uint32_t uart_irq, int uartidx)
 {
-    Aml *dev = aml_device("COM0");
+    Aml *dev = aml_device("COM%d", uartidx);
     aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs, aml_memory32_fixed(uart_memmap->base,
@@ -479,7 +479,11 @@ static void build_dsdt(GArray *table_data,
                                  memmap[VIRT_APLIC_S].size, "RSCV0002");
     }
 
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
+    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ, 0);
+    if (s->uart1_present) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1], UART1_IRQ, 1);
+    }
+
     if (virt_is_iommu_sys_enabled(s)) {
         acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
     }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..9a112ccdef 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -96,6 +96,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
+    [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
@@ -186,7 +187,8 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
                           FDT_MAX_INT_MAP_WIDTH] = {};
     uint32_t *irq_map = full_irq_map;
 
-    /* This code creates a standard swizzle of interrupts such that
+    /*
+     * This code creates a standard swizzle of interrupts such that
      * each device's first interrupt is based on it's PCI_SLOT number.
      * (See pci_swizzle_map_irq_fn())
      *
@@ -832,28 +834,38 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
 }
 
 static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle)
+                            uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
-                           s->memmap[VIRT_UART0].base);
+                           s->memmap[memId].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_UART0].base,
-                                 2, s->memmap[VIRT_UART0].size);
+                                 2, s->memmap[memId].base,
+                                 2, s->memmap[memId].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", UART0_IRQ);
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
     } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
+        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
+    }
+
+    if (VIRT_UART0 == memId) {
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
     }
+}
 
-    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
+static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
+{
+    if (s->uart1_present) {
+        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
+    }
+    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s,
@@ -1023,7 +1035,7 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_reset(s, &phandle);
 
-    create_fdt_uart(s, irq_mmio_phandle);
+    create_fdt_uarts(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
@@ -1567,6 +1579,13 @@ static void virt_machine_init(MachineState *machine)
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    if (serial_hd(1)) {
+        serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
+            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
+            serial_hd(1), DEVICE_LITTLE_ENDIAN);
+        s->uart1_present = true;
+    }
+
     sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..7d57c8292e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -59,6 +59,7 @@ struct RISCVVirtState {
     int aia_guests;
     char *oem_id;
     char *oem_table_id;
+    bool uart1_present;
     OnOffAuto acpi;
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
@@ -78,6 +79,7 @@ enum {
     VIRT_APLIC_S,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_UART1,
     VIRT_FW_CFG,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
@@ -93,6 +95,7 @@ enum {
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    UART1_IRQ = 12,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.34.1


