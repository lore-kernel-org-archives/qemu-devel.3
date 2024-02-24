Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257A7C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYd-0004Aw-Ca; Sat, 24 Feb 2024 08:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYb-0004AE-TF
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYW-0002kt-Rv
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d8739ddd4so1349883f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783146; x=1709387946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pT/MkfQa9G3Yr0W27b1GDZClhFKJrUo8tVDx3DPvdI8=;
 b=ZD2Do/Dwg7smw5D3e+NYzDf9H9V+BKAipNSEcFe4lrhvCw5BpqHb0kwQlveMD7THXA
 trtzFp9fOE3tzvCA//VjMLWZJRrKcqVqt1+Fn41g+yKJ49QE7bJtOxdAIPqo0Yp7rVec
 0w+QUM67NpQ4FFkMttJLeJqe3a8N5SnyN0AzMLWnYJqot9s5vB3ioYjweVTM8Uw5eKcj
 qras+IE//5vsFbJnObwzfKQSTGwagSuPV7uJkjAMNPPoMddTEH5MyZQ0T2ZqD8vZWEhY
 pSa27XdqwQCH1lz1UjAAPiOmBkmrbVPwRnRzh/rE2uWhaVMYGqjr60+lVCyVXTbt+oG6
 Jx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783146; x=1709387946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pT/MkfQa9G3Yr0W27b1GDZClhFKJrUo8tVDx3DPvdI8=;
 b=nT1BiMknsrKCyesTUft+NyXIFw5Uf73Efvc0ndXdek2ByzI0GLKcEZSjPAjaD25+t1
 mUIPAUh9rbELPeEq6cFRiKFYDUlG/gbMpDH9wIQIzpqCqlzWDtys43NCAJqrO+nPVj/l
 38HHPfOaCxNMGDysJGPe0j/BVyT+p2g3anLhzcuM0IuC8C9tJVljZfWkrzZffpc6PL/g
 fOA3Xilqc42j97JQlCPz3SDrOqPLwu/wae7olGGDEFfXfVVEvEegk6eGPSEhoNO7alpl
 ikuq9NCljp2HWDKJ6RwGrdfArzuMz11gdATk9BJPH7UkgDrrFZqno1BhxdSYdxU3P0ON
 Qu8g==
X-Gm-Message-State: AOJu0Yx/7yZgv0kBUxbQDFVL3+YxFbOXEestTBeDd1OWyT0Ev+UQAhbs
 KcRqW/f6ybSjE8RQqga3wGFkyGuqUh4ThD/TsZjRhJqI2mDRVmZnV4fBnWeo
X-Google-Smtp-Source: AGHT+IH/WCJrz+aCPc1Ovg9uPe8zFxNqkORGTvqlZUln24Q2C9pU7U4jcCJttq5foRJn4EXJf4QrPg==
X-Received: by 2002:a5d:6d8b:0:b0:33d:c3db:d4ae with SMTP id
 l11-20020a5d6d8b000000b0033dc3dbd4aemr731887wrs.25.1708783146000; 
 Sat, 24 Feb 2024 05:59:06 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:05 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 3/6] hw/i386/pc_{piix,
 q35}: Eliminate local pci_bus/pci_host variables
Date: Sat, 24 Feb 2024 14:58:48 +0100
Message-ID: <20240224135851.100361-4-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

There is no advantage in having these local variables which 1/ needlessly have
different identifiers in both machines and 2/ which are redundant to pcms->bus
which is almost as short.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 14 ++++++--------
 hw/i386/pc_q35.c  | 16 +++++++---------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3393b93007..814d24326d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -108,7 +108,6 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     Object *phb = NULL;
-    PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
@@ -212,11 +211,10 @@ static void pc_init1(MachineState *machine,
                                 &error_fatal);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
-        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pci_bus,
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
                          xen_enabled() ? xen_pci_slot_get_pirq
                                        : pc_pci_slot_get_pirq);
-        pcms->pcibus = pci_bus;
 
         hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
@@ -261,7 +259,7 @@ static void pc_init1(MachineState *machine,
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
         }
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
@@ -273,7 +271,7 @@ static void pc_init1(MachineState *machine,
              * connected to the IOAPIC directly.
              * These additional routes can be discovered through ACPI.
              */
-            pci_bus_irqs(pci_bus, xen_intx_set_irq, pci_dev,
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
@@ -310,7 +308,7 @@ static void pc_init1(MachineState *machine,
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
@@ -321,7 +319,7 @@ static void pc_init1(MachineState *machine,
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
                          0x4);
 
-    pc_nic_init(pcmc, isa_bus, pci_bus);
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
 #ifdef CONFIG_IDE_ISA
     if (!pcmc->pci_enabled) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 734d9bedb2..2fa4efb52f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -122,7 +122,6 @@ static void pc_q35_init(MachineState *machine)
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
-    PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
     ISADevice *rtc_state;
@@ -216,8 +215,7 @@ static void pc_q35_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
-    pcms->pcibus = host_bus;
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
@@ -231,7 +229,7 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
+    pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
@@ -283,7 +281,7 @@ static void pc_q35_init(MachineState *machine)
         AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        pdev = pci_create_simple_multifunction(host_bus,
+        pdev = pci_create_simple_multifunction(pcms->pcibus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
@@ -297,14 +295,14 @@ static void pc_q35_init(MachineState *machine)
 
     if (machine_usb(machine)) {
         /* Should we create 6 UHCI according to ich9 spec? */
-        ehci_create_ich9_with_companions(host_bus, 0x1d);
+        ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
     }
 
     if (pcms->smbus_enabled) {
         PCIDevice *smb;
 
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction(host_bus,
+        smb = pci_create_simple_multifunction(pcms->pcibus,
                                               PCI_DEVFN(ICH9_SMB_DEV,
                                                         ICH9_SMB_FUNC),
                                               TYPE_ICH9_SMB_DEVICE);
@@ -316,8 +314,8 @@ static void pc_q35_init(MachineState *machine)
     pc_cmos_init(pcms, rtc_state);
 
     /* the rest devices to which pci devfn is automatically assigned */
-    pc_vga_init(isa_bus, host_bus);
-    pc_nic_init(pcmc, isa_bus, host_bus);
+    pc_vga_init(isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-- 
2.44.0


