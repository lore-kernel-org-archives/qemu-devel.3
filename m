Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F1FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYM-0001Fg-Br; Mon, 24 Aug 2026 01:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXs-0001CI-6b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:35 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXq-0001hb-4x
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so2251694a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550509; x=1788155309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KUPc+7xlIMFvbQpIIY3o0TpfZjkwNXRng4YhTZLGtEc=;
 b=NTUr8fY5U74k/0FKTxxokKWwow5ohraVZiuvTtogCNBMs5eCFDbhabp9JWIFGXDQCk
 n5aAleNbhOwNN/JJanZXcM4TXoegldgnGj9PzmmuU4okvoqgjyA/p1KjFrTlFUQOPOGa
 MdPMmUmw3788Pyv0ipDXDblNSEUcMxpRPgchpKfGG/bsmR9rqOaoRgf6k+L77lE8vSDi
 Lq0etfqt4GisLfNpfEiX5U42tJZeCRzLFLYl7S/HbwTuuXSNZaFbwKek+/2Yb9EDNZ+W
 6vCSPMxI1cnmr6M9o98NUSIVtZR1jFv3BPUq/YQlpZZsE8JWio+gmgJsmLlRmYmmeaY4
 9jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550509; x=1788155309;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KUPc+7xlIMFvbQpIIY3o0TpfZjkwNXRng4YhTZLGtEc=;
 b=fJqC7vHeZkzry/WhYcGC2EO3g8dIcBoijJ/bJg2cXglJeM5lsfm4hdmBiSSWG/LPQl
 8DMWeHCRUhQJuw7yyFb2Ey3ZPxov1Mt3/xT1jMwiKIZnWIFTClZ26mheCEEr9iuubcuJ
 1MwdhYxGWduDshSXZdMkFr3ZwxA90PwEWxqQq4m0Grx/G7C22DAZGVZhtwkGnPCFBXK/
 f6a4c77hHj8ZpxSy9iKiebGK5NA47xN7aaCe8iEUXDI0O9e4Lsy0FaTl95qvnMh0EcFg
 ufpjhPZaosnxxmoueQ+mQ5nm4x5CoI/55MPe0SDKHEu3YuxZesQAHeYk1O8v/VsmhjYG
 Kn1A==
X-Gm-Message-State: AFuF++ko7TBe0V5mHYW/7muUR/aCL7hvb82PIBZAakTbd6LH+HyKjI3P
 J+ASkS6mg0Ba8KWIEsxNSn1QstpvzOdw2EaDllo0UPYJ+5K0mdKW+FwyzYLwdg==
X-Gm-Gg: AR+sD11vSV2Ra0HenbrOMv6Cpjv5p789bQd2CJDBg7meAjpYzGFELOqDVmInMBiZnoP
 d1FeZ+0zeZEOnoPjzlMAyHhmLckRgR/1q9XSI63Gk8MEvGos/BT658b6TKEYLZ/qpq+CbsBJVU6
 QIXS7a17Trd6iaIZor2qGhO9IKpY4wCeQxbp33fWbqXW8XY/Xuadm7nF0dnkZud5FxL/rQCqm4Y
 MDulX1NOXWnvlWkmC/oystNbz37v4RcY4khTiNtR0+88C03vq2j3/gRoIacTpXjCyHM0JDHJaZf
 SsfoKc4xUq2ZRc/yTbdTlnkHnqTybC8+LzYktMts+fVlEVOXU/GDiPu6oqvLGGzrbDujn+uTQ+L
 07T8l2xG+LiXdGmIosOlqLCNtVv86fbSboCIl0wf/y/jpfg/M6wVpdYRSKJkkK9TH4NA0ZLjvk6
 pOwMfcu+6GvR2emhT8SNuZySkLimzHxA0eUHXwAp1491HGJ0KvoZLWz68f3EE1QwZ6mcnpxN2Dy
 jYoqQ==
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-395c3a43766mr48543544a91.15.1787550508771; 
 Sun, 23 Aug 2026 22:48:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Yanfeng Liu <yfliu2008@qq.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 04/96] riscv/virt: Add optional UART1
Date: Mon, 24 Aug 2026 15:46:34 +1000
Message-ID: <20260824054806.2790041-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Yanfeng Liu <yfliu2008@qq.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/virt.rst |  5 ++++-
 include/hw/riscv/virt.h    |  3 +++
 hw/riscv/virt-acpi-build.c | 12 ++++++++----
 hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++----------
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..3c87246891 100644
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
+with a second ``-serial`` command line option).
+
 Hardware configuration information
 ----------------------------------
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 36a2def410..7c862b0da2 100644
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
@@ -79,6 +80,7 @@ enum {
     VIRT_APLIC_S,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_UART1,
     VIRT_FW_CFG,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
@@ -94,6 +96,7 @@ enum {
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    UART1_IRQ = 12,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 59c454f4f9..8e516ec114 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -177,11 +177,11 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
 
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
@@ -490,7 +490,11 @@ static void build_dsdt(GArray *table_data,
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
index 51bac47a91..d58656f70d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -97,6 +97,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
+    /* UART1 supports page isolation from UART0 */
+    [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
@@ -187,7 +189,8 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
                           FDT_MAX_INT_MAP_WIDTH] = {};
     uint32_t *irq_map = full_irq_map;
 
-    /* This code creates a standard swizzle of interrupts such that
+    /*
+     * This code creates a standard swizzle of interrupts such that
      * each device's first interrupt is based on it's PCI_SLOT number.
      * (See pci_swizzle_map_irq_fn())
      *
@@ -805,28 +808,38 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
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
@@ -996,7 +1009,7 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_reset(s, &phandle);
 
-    create_fdt_uart(s, irq_mmio_phandle);
+    create_fdt_uarts(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
@@ -1486,6 +1499,13 @@ static void virt_machine_init(MachineState *machine)
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
 
-- 
2.54.0


