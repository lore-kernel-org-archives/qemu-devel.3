Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF207C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 02:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkubs-0005jP-9t; Fri, 17 Jul 2026 22:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wkubp-0005jA-P7; Fri, 17 Jul 2026 22:16:58 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wkubk-000116-5i; Fri, 17 Jul 2026 22:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784340997; bh=PKHcrFmwTmiGY5F71svbtT7BPTkfXZNyYEsftPaA1h4=;
 h=From:To:Cc:Subject:Date;
 b=KlpGdlJP5pDGuOqVuFDXPrg+yZ5ObtLIVm+SER3T3gPt5d3Wd/mR4w4Cawh5bRF6q
 7C9DmBvNKAqBwliiWPTfbehMFDG9sxxi5WvZo59SYztoaA/TlgBCdEvWla6c/IpwPL
 V/rLJEaB1sv1Gi1cJc5zW5SYjR5+uhWuxnvxToxc=
Received: from qq.com ([171.216.132.19])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 422BFE19; Sat, 18 Jul 2026 10:16:34 +0800
X-QQ-mid: xmsmtpt1784340994t5mef6viw
Message-ID: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
X-QQ-XMAILINFO: Oc3TLAADIdlpyFEVj+GimWkT8hrf3Vsj1eJtUq0HTeKXSNxHAiP9EVtY+bQU1p
 d9f11sAL44pFcPOhA4ilHWZ9fOSy4cm+N+bt+IJKkrkeWOeOdyE2hql2VJZ0BaSAOHooQ5dA2pEw
 IMO6h6qN16aGA+OMkh4vxDbrndwF/cGedH9zk0auLjj6dEWNtHDXmh20q4kz/EFaSKXCJ80NiIfy
 MjkEm8YQD3UN1L+Xstv+Db5ghTz0iUnVObsprcwitQ5NH8dEzNsZTxHg1iAVKmgjJ+FIwCNNvrrk
 FofZIqHY4fLsf/SoybjNuKixprNNzfCqfL/9pMHkxSR9eWTdgEXaP4mfmH6u72ozQQcA7oW/ei1m
 gGfMR8JwSlbbcCtwZGMZDAWZrGeQtyhDN7gl8d5DQy0ZyvOcwuFj0VcRM3fEXqLzFHQqaIAjo3na
 W5zMfDS8uyQiCY+6j1jz8lgfk9gpw6J3v/XRd6FIGOxE6HVidTDncUXHvRuXw4t+XfnmdxPwtJBI
 VNhPDLS75yJPHXOJRapQrWEDfDTOwAgL/yiasaexAQ8OK+FmShwoi27+9KSEsRML3Hg5qPZxyFmC
 ka0Kfpi217/swviPdH9WEPJ5EXAcixSs3uo44BIj09XMQ9L1OqFgnAOEfn+I9AscA53GFoSDDpY3
 zvFn9Xxj0s8YH4k588gIA+526O5jy/dJ7CS9lhFLZMavfhN/FTs11hZ/M5t4J0nWofKBvXrdQZJa
 KH7tV8cyU+seSapKu4nI8nsas4q2JTFn6rghHkkBiaoYZ5I5W7J0LygVoiEGssfL8bZ2pjKEiz3j
 tFqnkl1TGhjAlmJ0OFZFbn7QypwIHxU8en8uwJ8qaLHIxLyH8X9cnSoQNBhA+2C6bZH6P02VBV71
 j7mOE4ZkrEBKlR8Kvl6/c1wsrZE4TEn3FNoO6Z2QqXs9mOhY4BieIWY5xJ0CSeUtLMfEattgdhgk
 M65fagNgaeHKTr12RNS4mUN6m0ues8aQd4pgN/r+7bjChN1tDSLzHx7sBoXVrEbeVLeUPn9s+ljc
 HBVzQUtjnDeaztH41+eR0QKQcUZE6NNxNFKX4i7v/+8sxhu6pG
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 pierrick.bouvier@oss.qualcomm.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v3] riscv/virt: Add optional UART1
Date: Sat, 18 Jul 2026 10:16:32 +0800
X-OQ-MSGID: <20260718021632.4728-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.44; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This adds optional UART1 to RiscV virt board if required at
runtime to simplify multicore development.

Note that UART0 remains default serial_hd(0) and it is:

- the lowest address UART
- first serial in DTB
- behind /aliases/serial0 in DTB
- the /chosen/stdout-path in DTB

Note that UART1 is placed at different page from UART0 to
support page level isolation.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 docs/system/riscv/virt.rst |  5 ++++-
 hw/riscv/virt-acpi-build.c | 12 ++++++++----
 hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++----------
 include/hw/riscv/virt.h    |  3 +++
 4 files changed, 45 insertions(+), 15 deletions(-)

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
index 33775a61fd..4703ac58f8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -96,6 +96,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
+    /* UART1 supports page isolation from UART0 */
+    [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
@@ -186,7 +188,8 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
                           FDT_MAX_INT_MAP_WIDTH] = {};
     uint32_t *irq_map = full_irq_map;
 
-    /* This code creates a standard swizzle of interrupts such that
+    /*
+     * This code creates a standard swizzle of interrupts such that
      * each device's first interrupt is based on it's PCI_SLOT number.
      * (See pci_swizzle_map_irq_fn())
      *
@@ -832,28 +835,38 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
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
@@ -1023,7 +1036,7 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_reset(s, &phandle);
 
-    create_fdt_uart(s, irq_mmio_phandle);
+    create_fdt_uarts(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
@@ -1567,6 +1580,13 @@ static void virt_machine_init(MachineState *machine)
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


