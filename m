Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E9DC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2n-0004Aq-0w; Sun, 18 Feb 2024 08:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2l-00048k-5R
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:19 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2j-0007uK-25
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:18 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3e75e30d36so48278666b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262235; x=1708867035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bpKjyoMDRK8juFb51Ouwz4NqlRTWYN2GO2yL0PSumY=;
 b=fSNrpO0DuSJNBGUy0gLWkxw+yFltV/6Jmsq+Lw6u965vao8rRR8fH20mPWQ8uxIu+C
 S8m7j6ZJitpFjNwioRq1QLBu+ojBnZIVK4iy+adycZXV3n+6vK8WHeh2IdX3CJgYRU0a
 MMm4m5HGNT+ZyaD2+kOuMzyZOn0/XQi900gcJaAw2nzaCw3Q142rdsg9JZMZBGgWACs7
 tp9+Dgl4HvA5qKTHWVTMnTzAgsPwy7Ydc6Hh3bpWOdjmQaQAK9QdECG5shioY2q2Euas
 cQ8++TJg2M/284BsBCi6lniEJ5We/FQzkoMsuc7oSzUHmozHGXV5wLBBqkoSvt0YWaJw
 +aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262235; x=1708867035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bpKjyoMDRK8juFb51Ouwz4NqlRTWYN2GO2yL0PSumY=;
 b=SaS1klFZpuxqAxa/10WrcY+SLtDWczcYYXleqZ7nGBMPWyGWbNKSfpkQpUeIlX4QYb
 /8ILas/ma15tgn/ZwNnB89j/6LkbmSgmFtFL78c3CZMyuydtR/guRTQK9cP1FLYD6kdc
 6eZzRAT27EZPd011mRHpSxny/nC73SFWLJp1ClWPXwrMAciUNrFJSX6hGwuewEw6qFaO
 lznfY80CoqtxyFtvHEYXiD401nkn09o3B5elZSkVSz044BaPSWKuiLLMtQ7DcTVzR402
 rYxTmERY7DIY7uWJXBVg6SAvSfHYCo3ycFklH+tRxfsbECk9bhz4f0vALH2EgHq0urGb
 If8g==
X-Gm-Message-State: AOJu0YyyCVHc8X2ROFUmaoOyi2ruU7X+DF9XIN51g6JnZhSHZEWzNXLJ
 H9FtowBN3VlqOQQsmx6DuQD+hLvGmd4zpvy5tgq/sO2y2/BQo+DLty+lIw5N
X-Google-Smtp-Source: AGHT+IFaCGKWV4X9LsCXZ7avy0rnTz2oyQT+AjXEsLotnRvLzVRimZN/2orCaDf86xpUtUgjHWoDEw==
X-Received: by 2002:a17:906:c297:b0:a3e:8b8e:8795 with SMTP id
 r23-20020a170906c29700b00a3e8b8e8795mr448002ejz.34.1708262235283; 
 Sun, 18 Feb 2024 05:17:15 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:14 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/5] hw/isa: Embed TYPE_PORT92 in south bridges used in PC
 machines
Date: Sun, 18 Feb 2024 14:16:59 +0100
Message-ID: <20240218131701.91132-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Port 92 is an integral part of the PIIX and ICH south bridges, so instantiate it
there. The isapc machine now needs to instantiate it explicitly, analoguous to
the RTC.

Note that due to migration compatibility, port92 is optional in the south
bridges. It is always instantiated the isapc machine for simplicity.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h          |  2 +-
 include/hw/southbridge/ich9.h |  4 ++++
 include/hw/southbridge/piix.h |  3 +++
 hw/i386/pc.c                  | 18 ++++++++++++------
 hw/i386/pc_piix.c             |  9 +++++++--
 hw/i386/pc_q35.c              |  8 +++++---
 hw/isa/lpc_ich9.c             |  9 +++++++++
 hw/isa/piix.c                 |  9 +++++++++
 hw/isa/Kconfig                |  2 ++
 9 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b2987209b1..a9ff1f5ab3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -178,7 +178,7 @@ uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice *rtc_state,
+                          ISADevice *rtc_state, ISADevice *port92,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_cmos_init(PCMachineState *pcms,
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index fd01649d04..d70a94f5e7 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -3,6 +3,7 @@
 
 #include "hw/isa/apm.h"
 #include "hw/acpi/ich9.h"
+#include "hw/isa/port92.h"
 #include "hw/intc/ioapic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
@@ -32,6 +33,7 @@ struct ICH9LPCState {
     uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
 
     MC146818RtcState rtc;
+    Port92State port92;
     APMState apm;
     ICH9LPCPMRegs pm;
     uint32_t sci_level; /* track sci level */
@@ -54,6 +56,8 @@ struct ICH9LPCState {
     uint8_t rst_cnt;
     MemoryRegion rst_cnt_mem;
 
+    bool has_port92;
+
     /* SMI feature negotiation via fw_cfg */
     uint64_t smi_host_features;       /* guest-invisible, host endian */
     uint8_t smi_host_features_le[8];  /* guest-visible, read-only, little
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 86709ba2e4..35058529d1 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -15,6 +15,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/acpi/piix4.h"
 #include "hw/ide/pci.h"
+#include "hw/isa/port92.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/usb/hcd-uhci.h"
 
@@ -56,6 +57,7 @@ struct PIIXState {
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
 
     MC146818RtcState rtc;
+    Port92State port92;
     PCIIDEState ide;
     UHCIState uhci;
     PIIX4PMState pm;
@@ -71,6 +73,7 @@ struct PIIXState {
     bool has_acpi;
     bool has_pic;
     bool has_pit;
+    bool has_port92;
     bool has_usb;
     bool smm_enabled;
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0b11d4576e..8b601ea6cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1160,7 +1160,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *fdc, *i8042, *port92, *vmmouse;
+    ISADevice *fdc, *i8042, *vmmouse;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1193,18 +1193,15 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
                                  &error_abort);
         isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
     }
-    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
-    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
+    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
     i8042_setup_a20_line(i8042, a20_line[0]);
-    qdev_connect_gpio_out_named(DEVICE(port92),
-                                PORT92_A20_LINE, 0, a20_line[1]);
     g_free(a20_line);
 }
 
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice *rtc_state,
+                          ISADevice *rtc_state, ISADevice *port92,
                           bool create_fdctrl,
                           uint32_t hpet_irqs)
 {
@@ -1296,6 +1293,15 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON);
+
+    if (port92) {
+        qemu_irq *a20_line;
+
+        a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
+        qdev_connect_gpio_out_named(DEVICE(port92),
+                                    PORT92_A20_LINE, 0, a20_line[0]);
+        g_free(a20_line);
+    }
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 999b7b806c..dfdfd36551 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -115,7 +115,7 @@ static void pc_init1(MachineState *machine,
     qemu_irq smi_irq;
     GSIState *gsi_state;
     BusState *idebus[MAX_IDE_BUS];
-    ISADevice *rtc_state;
+    ISADevice *rtc_state, *port92;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
@@ -269,6 +269,8 @@ static void pc_init1(MachineState *machine,
                                  &error_abort);
         object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
                                  &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-port92",
+                                 pcms->i8042_enabled, &error_abort);
         qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
         object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
                                  x86_machine_is_smm_enabled(x86ms),
@@ -296,6 +298,8 @@ static void pc_init1(MachineState *machine,
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
+        port92 = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                          "port92"));
         piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
@@ -310,6 +314,7 @@ static void pc_init1(MachineState *machine,
         qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
         isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
 
+        port92 = isa_create_simple(isa_bus, TYPE_PORT92);
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
         idebus[0] = NULL;
@@ -336,7 +341,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d346fa3b1d..26bb1c2cb9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -127,7 +127,7 @@ static void pc_q35_init(MachineState *machine)
     PCIDevice *lpc;
     DeviceState *lpc_dev;
     BusState *idebus[MAX_SATA_PORTS];
-    ISADevice *rtc_state;
+    ISADevice *rtc_state, *port92;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
@@ -238,6 +238,7 @@ static void pc_q35_init(MachineState *machine)
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     lpc_dev = DEVICE(lpc);
+    qdev_prop_set_bit(lpc_dev, "has-port92", pcms->i8042_enabled);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
     pci_realize_and_unref(lpc, host_bus, &error_fatal);
@@ -246,6 +247,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    port92 = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "port92"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -287,8 +289,8 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
-                         0xff0104);
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92,
+                         !mc->no_floppy, 0xff0104);
 
     if (pcms->sata_enabled) {
         PCIDevice *pdev;
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 70c6e8a093..3be5bc01b1 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -749,6 +749,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
     irq = object_property_get_uint(OBJECT(&lpc->rtc), "irq", &error_fatal);
     isa_connect_gpio_out(ISA_DEVICE(&lpc->rtc), 0, irq);
 
+    if (lpc->has_port92) {
+        object_initialize_child(OBJECT(lpc), "port92", &lpc->port92,
+                                TYPE_PORT92);
+        if (!qdev_realize(DEVICE(&lpc->port92), BUS(isa_bus), errp)) {
+            return;
+        }
+    }
+
     pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
     pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
     pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
@@ -821,6 +829,7 @@ static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
+    DEFINE_PROP_BOOL("has-port92", ICH9LPCState, has_port92, true),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2d30711b17..4c12855461 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -346,6 +346,14 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
     irq = object_property_get_uint(OBJECT(&d->rtc), "irq", &error_fatal);
     isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
 
+    /* Port 92 */
+    if (d->has_port92) {
+        object_initialize_child(OBJECT(d), "port92", &d->port92, TYPE_PORT92);
+        if (!qdev_realize(DEVICE(&d->port92), BUS(isa_bus), errp)) {
+            return;
+        }
+    }
+
     /* IDE */
     qdev_prop_set_int32(DEVICE(&d->ide), "addr", dev->devfn + 1);
     if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
@@ -413,6 +421,7 @@ static Property pci_piix_props[] = {
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
     DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
+    DEFINE_PROP_BOOL("has-port92", PIIXState, has_port92, true),
     DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index efdf43e92c..f42a087c07 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -47,6 +47,7 @@ config PIIX
     select IDE_PIIX
     select ISA_BUS
     select MC146818RTC
+    select PORT92
     select USB_UHCI
 
 config PORT92
@@ -78,3 +79,4 @@ config LPC_ICH9
     select ISA_BUS
     select ACPI_ICH9
     select MC146818RTC
+    select PORT92
-- 
2.43.2


