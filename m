Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3971FC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV9-0007Hf-Nq; Thu, 08 Feb 2024 17:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV8-0007HM-GW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:10 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV6-0005Ee-PJ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:10 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a388c5542e9so255320066b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429846; x=1708034646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yU73Jw0joItmcVHy5knFnwYnQ3AC3ly8jcec45Sfb1c=;
 b=ZW+Pd2vgcDA4JgG+VlALUISHwhYwDtB9BdGtVmjrYMUSeZC7/CycglYVreRJD325x+
 Dt857Jv4cw17PytdVYzyIlnEOb6UjmU2mrmeZnmq5q1aQqEOZFpxZKklm4Y8SecyT8DV
 AY3llVtGgtNzr+4lxF4t57lGSLCYNQ8/LMtKgstElWP+7FP+Joo+1DQ3pe1sxnlYgdwB
 3YwZIBHxE32sZo2N2goGntkKBOFyrh38d8BYjpJxSsw7Q8UiZ/yMDFf+6Bys4KzvKDzI
 6+E5uL8vg33MbiA6aEOlX7Yw9CZqs1w16irN60FuZCTaGEeHZAyMCa8o+6xAV07BvoEA
 rBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429846; x=1708034646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yU73Jw0joItmcVHy5knFnwYnQ3AC3ly8jcec45Sfb1c=;
 b=eljKs9FD48wH44UIiGn6srG3tBsSmgZsxmc8/1eLkZOyU7hN9HIssT6+r5gnEf3T/k
 s1W6PDfRJF0kE50ne7ruUzH/EHJdqP58EcKPlpb1FC/JfQo8il+ck0HTwz+vPRTrcmve
 Pd+GSbj2DgjyHbttLE/s7GEaGulK0s7URgX4DPSjkT64zISuw0Go7CVao52uXi+NUL7/
 Uy2Evx4cDmvroJNdXFi3anF6v1WwHULiSEp2DR0QyRG/PpDU1dznpTSMc3OOkZ24X2vf
 BT1etPyjt3Nj2KLetSbE798/OI4C0TN33sEZE9gFF7M6kVasaOeagv/acKzC4J67xUwz
 UNIg==
X-Gm-Message-State: AOJu0Yw+pTOv24FFpfGkGzvCjGPEd4yD9RcdaAjphBRDk4Rz9tF/gTVg
 3d8z+u26SLtm6WftW+xAySTYYEs9/2sxxoCIZ+8QHk5BHcfEXY+2ao1vEYPg
X-Google-Smtp-Source: AGHT+IHo0vbWe7HrIHopYUHdEHBonRujcqmvjUEZCJcRzSjeMqVuavDYoeGQoTHYoA7gLruQ53F4Jw==
X-Received: by 2002:a17:906:4087:b0:a38:2ba9:7f8c with SMTP id
 u7-20020a170906408700b00a382ba97f8cmr779721ejj.21.1707429846506; 
 Thu, 08 Feb 2024 14:04:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0nZAQVZPe71j2rG7kcAIQTTKxtE2Q4Tg1y3L9J74KY02zLkWKVmYCu5UguRlY60c6iBt5mZP3b4UxuKkdIZ2djCWfLoqazoHwATcaq2eohUL1k/Dpekwzsn5cPX7f/m22YKYlfnRmw75GzFdp85RxdhxC8jAhSsm3ZnrGvz+QEgzBTU3jXKYJP2OLJC2aIqHo1oPAnrBRyWGxgSOFVTHBWL7AKkm3OseTt7H+0TTU2NyHqu2O
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:04:05 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 8/9] hw/i386/pc: Populate RTC attribute directly
Date: Thu,  8 Feb 2024 23:03:48 +0100
Message-ID: <20240208220349.4948-9-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

Both the piix and the q35 machines introduce an rtc_state variable and defer the
initialization of the X86MachineState::rtc attribute to pc_cmos_init(). Resolve
this complication which makes pc_cmos_init() do what it says on the tin.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c      |  8 --------
 hw/i386/pc_piix.c | 15 +++++++--------
 hw/i386/pc_q35.c  |  7 +++----
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e73cd8a3b..ca74c6fbae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -617,14 +617,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    object_property_add_link(OBJECT(pcms), "rtc_state",
-                             TYPE_ISA_DEVICE,
-                             (Object **)&x86ms->rtc,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
-                             &error_abort);
-
     set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5c928ac71b..adb7926b2e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -115,7 +115,6 @@ static void pc_init1(MachineState *machine,
     qemu_irq smi_irq;
     GSIState *gsi_state;
     BusState *idebus[MAX_IDE_BUS];
-    ISADevice *rtc_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
@@ -280,8 +279,8 @@ static void pc_init1(MachineState *machine,
         }
 
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                             "rtc"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
         piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
@@ -292,9 +291,9 @@ static void pc_init1(MachineState *machine,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        rtc_state = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
-        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
@@ -322,7 +321,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
@@ -349,7 +348,7 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+    pc_cmos_init(pcms, idebus[0], idebus[1], x86ms->rtc);
 
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 5184abda92..d313ba5509 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -126,7 +126,6 @@ static void pc_q35_init(MachineState *machine)
     PCIDevice *lpc;
     DeviceState *lpc_dev;
     BusState *idebus[MAX_SATA_PORTS];
-    ISADevice *rtc_state;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory;
@@ -245,7 +244,7 @@ static void pc_q35_init(MachineState *machine)
     }
     pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
-    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -289,7 +288,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
                          0xff0104);
 
     if (pcms->sata_enabled) {
@@ -325,7 +324,7 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+    pc_cmos_init(pcms, idebus[0], idebus[1], x86ms->rtc);
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
-- 
2.43.0


