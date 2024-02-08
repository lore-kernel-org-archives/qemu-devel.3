Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D957CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV3-0007Fw-6W; Thu, 08 Feb 2024 17:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV1-0007EK-DW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:03 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCUz-0005DZ-J8
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:03 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a370e7e1e02so33473166b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429839; x=1708034639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGkMYPa+RTmey7fKt7GCaGAdkjjOt2z+kR77UOLngnA=;
 b=ErTRD+1sKzeCzmbNbeV/qYQL+tHjPB5a57hpe4MbDoUjUw/uKFUPwylN01Psrgx1BX
 INePWk0o51uRG8JjlUbPcaagC12toprgvW0B2v2fZskq93n1r9wfQ1uo4kneStNouLvD
 NUDFKhTNQ0QVayToaOuXJxAjmMCyT+EFMgRssf17Yx7WKD2W4eq+trVkgN5JPBn0c/PD
 xJj06i1GfDX0SvdLqCqlWGd0QZ8l4P1KJodrHXRKdGh/Yv/yuQfeC+yX1BIgoYYwErMq
 hCEEgXbctEpmA8DkIRGvrulsSB7FMaE3BmKSp8h+KXDIkVEgMXNUqN8bD3N7wXVuve2o
 xn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429839; x=1708034639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGkMYPa+RTmey7fKt7GCaGAdkjjOt2z+kR77UOLngnA=;
 b=pfB+cR2IZF/6yPdNxn3CFGoTYYV2rrqzDKeJM+F2ktIUQHtnkVAuH4srkcm7t5II9v
 y8OkbK6HxtqX0bwSg7Jr1HsZ8l6+G34iQdqJhEK1UOjOoOgA/rGqGTBgSzjGuvPVbxjj
 PDXkwFjOo+uRGZL2uiv5Z6hMLOipDazeEg6Kk7HNdSlsHVaidFM834LM1tXpcH3ynDKJ
 Se33Ntf3QupVB8EQCenVCN91EUfFXMJ9Dp6rHWVSFGZtugGQD2OorMjIhl7a3sc7IIB3
 1yFqL/HZC6ZSEzCKjD7z1/E07MyKW2Lus77ys6Xx0lz5+fubam2sdmEwN+WBaEE/JDS+
 R30A==
X-Gm-Message-State: AOJu0YzvxVzU4gCAapORQjgFnaRdLHU4Nm6ozX4PD2HLjEimZjS0hrdR
 dQuV1NXKmnG9EL++gr0bGItH2mDUM9AC9LrhEu2belB0VJnTbmycZA1moRS+
X-Google-Smtp-Source: AGHT+IE70RhJvm38m4K85ijmn6DrkCmTf5Z/Do+Ow2gedNT3DNH3MkJd9uJecMDbTP4tAdZ/ReuZ9w==
X-Received: by 2002:a17:906:fc09:b0:a38:5cf1:b58 with SMTP id
 ov9-20020a170906fc0900b00a385cf10b58mr437105ejb.47.1707429839171; 
 Thu, 08 Feb 2024 14:03:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVTP5j4+eaVgRgr9gGGYsJplIhXQbB7Sc8/MO7oPlYuHJl0v/0bn8Z41U4wMNUvdQdwXQfPFgkHr6OdUkKKaWq/f73HAnkVNqDN4uP56en6uZ64QyLkBLzP3qzTP74aZCa2NQbBXyXbZGJZk9jbewVVOhRPi5wbcopDmDJ3hYr71ofZF9k0wnAeR5gt+gxb+TPSJCHHzaEMOneXBGGHvumF/Y5VuTkK1VdWKhNNexE/bJZTPj5S
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:03:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/9] hw/i386/x86: Turn apic_xrupt_override into class attribute
Date: Thu,  8 Feb 2024 23:03:43 +0100
Message-ID: <20240208220349.4948-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

The attribute isn't user-changeable and only true for pc-based machines. Turn it
into a class attribute which allows for inlining pc_guest_info_init() into
pc_machine_initfn().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h | 3 ++-
 hw/i386/acpi-common.c | 3 ++-
 hw/i386/pc.c          | 5 ++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 6fe29fbb87..4dc30dcb4d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -34,6 +34,8 @@ struct X86MachineClass {
     bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
+    /* CPU and apic information: */
+    bool apic_xrupt_override;
 };
 
 struct X86MachineState {
@@ -57,7 +59,6 @@ struct X86MachineState {
     uint64_t above_4g_mem_start;
 
     /* CPU and apic information: */
-    bool apic_xrupt_override;
     unsigned pci_irq_mask;
     unsigned apic_id_limit;
     uint16_t boot_cpus;
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 43dc23f7e0..cea4b3d71c 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -100,6 +100,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     int i;
     bool x2apic_mode = false;
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+    X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -122,7 +123,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      IO_APIC_SECONDARY_ADDRESS, IO_APIC_SECONDARY_IRQBASE);
     }
 
-    if (x86ms->apic_xrupt_override) {
+    if (x86mc->apic_xrupt_override) {
         build_xrupt_override(table_data, 0, 2,
             0 /* Flags: Conforms to the specifications of the bus */);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a..12facf73b1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -708,9 +708,6 @@ void pc_machine_done(Notifier *notifier, void *data)
 
 void pc_guest_info_init(PCMachineState *pcms)
 {
-    X86MachineState *x86ms = X86_MACHINE(pcms);
-
-    x86ms->apic_xrupt_override = true;
     pcms->machine_done.notify = pc_machine_done;
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
@@ -1807,6 +1804,7 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
@@ -1826,6 +1824,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     pcmc->resizable_acpi_blob = true;
+    x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
-- 
2.43.0


