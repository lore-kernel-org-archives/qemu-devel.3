Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49AFC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYl-0004Ed-4p; Sat, 24 Feb 2024 08:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYd-0004Aj-0d
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYb-0002lP-09
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so1119819f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783149; x=1709387949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTdkrGOWau5O1oWIpKtyS7r/bUo0AcrbvBTNN+p9aWY=;
 b=ccFSBSQQhACfMwGil5eNc5qmsO7t+xoBqbpA4MWRoRmwHtg4x+O7gLBwJq2ny3FRjM
 D1uAPutgrptN9VlApbgDjbXxdlYoUG0ssUyyC2WkdIaoltddUE2GhiqmWUOGqx3pH2W9
 c2k8/AW5J2KMS1zJuyasqD+6aoW/I73ceifJmDk6bPl4u1NsvoaUNf50QlxjeTLED3R/
 WxLZeG3zThDnP+/0FQeyuhoc+AbbY1mInQGUSLI9bdM4mrw9TidcpufaJaOx7vdvSXPV
 3zVGBmbOzE+aJP7HyFJF/R5dFlbvHxsZkeI8eweKA77Wo9QMS4ZTDaVi+U/CmNcKijD0
 iuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783149; x=1709387949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTdkrGOWau5O1oWIpKtyS7r/bUo0AcrbvBTNN+p9aWY=;
 b=gxU3eUWOYxDxfZQItImHSqFt/Ga8oDxBzJhvdwhUspaP7Ky7bLaxyFvFzIaw78fIy5
 SuGsBdT+k96kozjxT2GWa10eOt3QxDZu+tZR6HK2wO4ogB64UOC4SS39/mR2UtifkHEg
 MLUPVcNiXvJ9aN65z1SfthWGo7fHv9Q+L7oldh9QmqftDZCzC/vsMMuJS37ilUybxe2j
 n9lBY4hxGhhyDrB5pATvECV8DyaID7F4sPPYGJKpl9ZlD8yZ295iRjZqirViSqs/CMsa
 QVCZT4fDC1XKUFitvR25JboG8FWT0A+wp/X4F03m9xyMN5OQ3oVfHy+irEz5L/KpZur3
 aP8Q==
X-Gm-Message-State: AOJu0YzQRlv+Gzc+uSW4ijL5OrcHN8wzIFDAnp8q7E/JcJBlNA++Vkf3
 RJJzY9yhbewTXkYIwaKY90uWP85fX/kdpCRZoXr3iFbfLfV63Ka25tQ+5JRK
X-Google-Smtp-Source: AGHT+IHWG6GVhsAavmdPOpNxd/LDQlwv7DZoSQKkU5mcq7WCe8ODfHGGS7V7oq/cbihATq/Nk7KglQ==
X-Received: by 2002:a5d:56cb:0:b0:33d:6186:3ca0 with SMTP id
 m11-20020a5d56cb000000b0033d61863ca0mr1588880wrw.19.1708783148865; 
 Sat, 24 Feb 2024 05:59:08 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:08 -0800 (PST)
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
Subject: [PATCH v2 5/6] hw/i386/pc: Populate RTC attribute directly
Date: Sat, 24 Feb 2024 14:58:50 +0100
Message-ID: <20240224135851.100361-6-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c      |  8 --------
 hw/i386/pc_piix.c | 15 +++++++--------
 hw/i386/pc_q35.c  |  7 +++----
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a80f809b83..880e95de26 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -611,14 +611,6 @@ void pc_cmos_init(PCMachineState *pcms,
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
index 49d5d48db9..ce6aad758d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -112,7 +112,6 @@ static void pc_init1(MachineState *machine,
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
-    ISADevice *rtc_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
@@ -276,8 +275,8 @@ static void pc_init1(MachineState *machine,
         }
 
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                             "rtc"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
         piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
@@ -288,9 +287,9 @@ static void pc_init1(MachineState *machine,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        rtc_state = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
-        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
@@ -316,7 +315,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
@@ -343,7 +342,7 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    pc_cmos_init(pcms, rtc_state);
+    pc_cmos_init(pcms, x86ms->rtc);
 
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2fa4efb52f..e0b3f55a02 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -124,7 +124,6 @@ static void pc_q35_init(MachineState *machine)
     Object *phb;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
-    ISADevice *rtc_state;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
@@ -231,7 +230,7 @@ static void pc_q35_init(MachineState *machine)
     }
     pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
 
-    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -273,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
                          0xff0104);
 
     if (pcms->sata_enabled) {
@@ -311,7 +310,7 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, rtc_state);
+    pc_cmos_init(pcms, x86ms->rtc);
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, pcms->pcibus);
-- 
2.44.0


