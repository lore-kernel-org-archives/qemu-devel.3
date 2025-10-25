Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE3CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChR9-0000AC-0Z; Sat, 25 Oct 2025 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vChR7-0000A4-UK
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:48:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vChR6-0008AU-0Q
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:48:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F288F60350;
 Sat, 25 Oct 2025 16:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64718C4CEF5;
 Sat, 25 Oct 2025 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761410889;
 bh=qo4rZthWrQcK+3AK1ydySpYdsN44RTNav98iyPNzJ6w=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=gyVy4gqW7LwKrJVB7sWJDZqusEqhD+qFq4w2Wx/lK/RWsX+BsLQsFvlTgxsXopOxW
 iOiG9vfU6yvdbKFaH375mdlGwaZM6YAWSGR85Fu+0cEMfltTWklm21Nc3GsmbsqlGe
 iVwh1WBpu8357RST9anrGHK4m0DCq8s+8pxpueI6S8zaHXCEmkhstpZ0MpEfxKksnd
 KlBmUSub0Zo7RIXUr4c93a2jVuV0RaWx7NwklMkpmke3m7ophxPtOyo6GGP3E8cqy9
 5MAKwiewBwYbABuW9rEgqEx2lNC7f2jdmAQhsPw3Yy/S5h9cLGlDjhAzFA1hSk7a6w
 PNlOGZFzSAT4g==
Date: Sat, 25 Oct 2025 18:48:05 +0200
From: Helge Deller <deller@kernel.org>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: Re: [PATCH v3 11/11] hw/hppa: Add 715 machine type including NCR710
 SCSI
Message-ID: <aPz_RTXD7iHdIFn-@p100>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-12-deller@kernel.org>
 <a54e8e84-9b69-4144-a02f-1825b9918352@linaro.org>
 <52210596-bd63-42bf-b562-0fab03eef683@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52210596-bd63-42bf-b562-0fab03eef683@gmx.de>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a new emulation for a 715/64 machine.
This machines has no PCI bus, and has the majority of the devices (SCSI,
network, serial ports, ...) provided by a LASI multi-function I/O chip.

v2: based on feedback from Richard
- Fix indenting and use assert() to check ncr710 device availability

v3: based on feedback from Philippe Mathieu-Daudé <philmd@linaro.org>
- create SCSI device at caller site, not inside machine_HP_common_init_tail()

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 81ed050b5e..92e9fcf437 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -30,6 +30,8 @@
 #include "hw/pci-host/astro.h"
 #include "hw/pci-host/dino.h"
 #include "hw/misc/lasi.h"
+#include "hw/scsi/ncr53c710.h"
+#include "hw/scsi/lasi_ncr710.h"
 #include "hppa_hardware.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -346,7 +348,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
 }
 
 /*
- * Last creation step: Add SCSI discs, NICs, graphics & load firmware
+ * Last creation step: Add NICs, graphics & load firmware
  */
 static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                                         TranslateFn *translate)
@@ -361,12 +363,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     MemoryRegion *rom_region;
     SysBusDevice *s;
 
-    /* SCSI disk setup. */
-    if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
-    }
-
     /* Graphics setup. */
     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
         dev = qdev_new("artist");
@@ -537,6 +533,71 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     cpu[0]->env.kernel_entry = kernel_entry;
 }
 
+/*
+ * Create HP 715/64 workstation
+ */
+static void machine_HP_715_init(MachineState *machine)
+{
+    DeviceState *dev;
+    MemoryRegion *addr_space = get_system_memory();
+    TranslateFn *translate;
+    ISABus *isa_bus;
+
+    /* Create CPUs and RAM.  */
+    translate = machine_HP_common_init_cpus(machine);
+
+    if (hppa_is_pa20(&cpu[0]->env)) {
+        error_report("The HP 715/64 workstation requires a 32-bit "
+                     "CPU. Use '-machine 715' instead.");
+        exit(1);
+    }
+
+    /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
+    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
+    assert(isa_bus);
+
+    /* Init Lasi chip */
+    lasi_dev = DEVICE(lasi_init());
+    memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA_715),
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(lasi_dev), 0));
+
+    /* Serial ports: Lasi use a 7.272727 MHz clock. */
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_UART + 0x800), 0,
+        qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
+        serial_hd(0), DEVICE_BIG_ENDIAN);
+
+    /* Parallel port */
+    parallel_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_LPT + 0x800), 0,
+                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
+                     parallel_hds[0]);
+
+    /* PS/2 Keyboard/Mouse */
+    dev = qdev_new(TYPE_LASIPS2);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_HPA_715 + LASI_PS2),
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_HPA_715 + LASI_PS2 + 0x100),
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       1));
+    /* SCSI disk setup. */
+    if (drive_get_max_bus(IF_SCSI) >= 0) {
+        dev = lasi_ncr710_init(addr_space,
+                               translate(NULL, LASI_HPA_715 + 0x6000),
+                               qdev_get_gpio_in(lasi_dev, LASI_IRQ_SCSI_HPA));
+        assert(dev);
+        lasi_ncr710_handle_legacy_cmdline(dev);
+    }
+
+    /* Add NICs, graphics & load firmware */
+    machine_HP_common_init_tail(machine, NULL, translate);
+}
+
 /*
  * Create HP B160L workstation
  */
@@ -603,7 +664,13 @@ static void machine_HP_B160L_init(MachineState *machine)
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
-    /* Add SCSI discs, NICs, graphics & load firmware */
+    /* SCSI disk setup. */
+    if (drive_get_max_bus(IF_SCSI) >= 0) {
+        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
+    }
+
+    /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
@@ -646,7 +713,13 @@ static void machine_HP_C3700_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(astro->elroy[0]), "pci"));
     assert(pci_bus);
 
-    /* Add SCSI discs, NICs, graphics & load firmware */
+    /* SCSI disk setup. */
+    if (drive_get_max_bus(IF_SCSI) >= 0) {
+        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
+    }
+
+    /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
@@ -743,6 +816,25 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA_CPU,
+        NULL
+    };
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "HP 715/64 workstation";
+    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->init = machine_HP_715_init;
+    /* can only support up to max. 8 CPUs due inventory major numbers */
+    mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
+    mc->default_ram_size = 256 * MiB;
+    mc->default_nic = NULL;
+}
+
+
 static const TypeInfo hppa_machine_types[] = {
     {
         .name           = TYPE_HPPA_COMMON_MACHINE,
@@ -762,6 +854,10 @@ static const TypeInfo hppa_machine_types[] = {
         .name = MACHINE_TYPE_NAME("C3700"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
+    }, {
+        .name = MACHINE_TYPE_NAME("715"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_715_machine_init_class_init,
     },
 };
 

