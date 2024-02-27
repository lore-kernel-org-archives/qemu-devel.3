Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0534AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2w-0004cv-6G; Tue, 27 Feb 2024 03:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2t-0004Nj-Ot
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2k-0008PC-UO
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso3338656f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023349; x=1709628149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6n+lSFzDNPiqC0LaZPK+z4bhN6r8eJn5HjneFPDs130=;
 b=QItaDzK+d0e9PPr5rCmQlWI3GceZIPTQBLHcHoV7bWDEZfC7j6FlO4qNL/pSQ/h5y8
 ++kPyC/Xg65wDdcLOzNxCIrtJ89I7HZV/0zWRu6mqQi9Eiu1SxBm93k5BuA2j7QPNE7c
 Rm1cI+er66wOSGDmlc/JinhH+OZF5QqLTvh3RcD1ZTd70qlqG0F1g9v075hVxdEcBfST
 lW3T/raLlXmLyrYmncKo4wTAXKiedARS9H5OgqQ7xGXL+Y0oZefmm4hPNSRkLgnc/12C
 ZzZX/QD/+snYCXxjHfF73w35jSj2l0RFIv7o8r+czZhZC2yNBUmYAeOhCDXubQGkHMyX
 Cimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023349; x=1709628149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6n+lSFzDNPiqC0LaZPK+z4bhN6r8eJn5HjneFPDs130=;
 b=XSxwjHB5CnLHoQuMrumZ64E422/eMKGGMfENjS1mN0laZhpYU91nUVcCqYhE17w1zp
 REhLEzPmXxyUe2bUwIUa+NEsjb1P5AFhlOhAfYjwhRm+4HuSXwXthZm56NxPc6R2TBNt
 VhHlumETig5oMqq4HZXZ4dLDBeU8xIlOM2kP8N4hmQjAiWUmdSpyKRScMedPvyf8DARH
 rsevHWW0vLPkZJMvx+XKIYznCMq+2W70mt1kb2zMkNQbT0Qw0oX1s9Wcn/HcuGLjDqeV
 gFlHtHm12gFW2cwGNXdnxmRI/IU6og3+dHXmBSigQibmHOzs2YnT5zQdl7Lo2KI6d8Iv
 TTyA==
X-Gm-Message-State: AOJu0Yy8gF8qTL29K39v2mDG4+UETHpcQ1fQ1z3OH26Zg5Zs9GS9FSpM
 HylgkW0KLyKG5iLgw9atd+xtC9z/Pn/S7Qy2otrSlg+tQR121QPEnv7lSAAAnq/VuiP4LLl1L1g
 0
X-Google-Smtp-Source: AGHT+IF8q8gfAJHOTCX7PEWFh8PpuCnCY4f2YHr5+0f74w9LfA9EVmTiqht62H8BY2KN7xZMpzI4Xg==
X-Received: by 2002:adf:ea81:0:b0:33d:74f2:820e with SMTP id
 s1-20020adfea81000000b0033d74f2820emr7496378wrm.30.1709023349088; 
 Tue, 27 Feb 2024 00:42:29 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 h4-20020a5d4304000000b0033d6c928a95sm10651527wrq.63.2024.02.27.00.42.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 25/30] hw/i386/pc_{piix,
 q35}: Eliminate local pci_bus/pci_host variables
Date: Tue, 27 Feb 2024 09:39:41 +0100
Message-ID: <20240227083948.5427-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

There is no advantage in having these local variables which 1/ needlessly have
different identifiers in both machines and 2/ which are redundant to pcms->bus
which is almost as short.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240224135851.100361-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 549c0bc041..9e4b8f79c2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -123,7 +123,6 @@ static void pc_q35_init(MachineState *machine)
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
-    PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
     ISADevice *rtc_state;
@@ -217,8 +216,7 @@ static void pc_q35_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
-    pcms->pcibus = host_bus;
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
@@ -232,7 +230,7 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
+    pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
@@ -284,7 +282,7 @@ static void pc_q35_init(MachineState *machine)
         AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        pdev = pci_create_simple_multifunction(host_bus,
+        pdev = pci_create_simple_multifunction(pcms->pcibus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
@@ -298,14 +296,14 @@ static void pc_q35_init(MachineState *machine)
 
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
@@ -317,8 +315,8 @@ static void pc_q35_init(MachineState *machine)
     pc_cmos_init(pcms, rtc_state);
 
     /* the rest devices to which pci devfn is automatically assigned */
-    pc_vga_init(isa_bus, host_bus);
-    pc_nic_init(pcmc, isa_bus, host_bus);
+    pc_vga_init(isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-- 
2.41.0


