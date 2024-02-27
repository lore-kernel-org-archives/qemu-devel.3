Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DEAC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2P-0001q5-Ia; Tue, 27 Feb 2024 03:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2N-0001X2-3R
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:07 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2L-0008Ip-7H
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:06 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5663273e390so533477a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023323; x=1709628123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX8uZlTT6wTjiMtTqjR3dj/PxPssyXNBBI6GxQRZqxI=;
 b=UiJ4RsntLYaqtxmRuL7CPxLIHVqs9MuduWTme3Dqnjxt55rTIUd153GI33+mNA1Z7T
 jzrMFh6WIE2erQYfs94AfzvMCOMHa0+W0my6wqL/ErT93VcIfqRo4PNott8wlhq1m8Sy
 kmvlPs0M7ehyiBFdkqytDQxR40L8S0uriTToEvEYfNZ4jxS8fvvB2JoLGAu7sbwaaIlJ
 b67PRfoCRcrTQcLPi5JTABMAssLXcIZG1L8Fgpjnurvpvr6iQKm+loxfNiOl7LynHxbW
 xhPefnJJdo77w9rsDFR20XgcEbfCSckhqdl4x19OQnmQBL3jdsZw+z+goR2J6+TTJVJA
 8MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023323; x=1709628123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iX8uZlTT6wTjiMtTqjR3dj/PxPssyXNBBI6GxQRZqxI=;
 b=Sf7OdukTKJ3cXNKr67JjjDyVpgx1EOp/Ls7tW/sUAxWVXTLf0GTQdjHNgAHUbBdvVR
 n6JdD8Ot6tACtwvc+q79r+bXas86HtGvJQU528uNkCHqiHOar3Oslo7KcOSDdq8DZl+e
 v2sGq7kHbMkWAAVmQkO9rJiN02nh8SA9OyhFIhkRGALYGS8WuLv4zD5aLLKllJYLX2fw
 7LG80CwhChlOKd7HEbvhsfGdTj+Nzfq/fyWXvU1DiZtthiqMvVAFkzI6122MhHrn3o7o
 MYpNTu8JM9OTT4X5g4Qh8hb1AsPWi8RQbRLSRrlI/63vEXn/Y96GZApC8eoVgFjSuJ1H
 zsxQ==
X-Gm-Message-State: AOJu0YyqFNqGLXUQJawmqnJg6g9IOrzwfCYif/oKdISW60HO8ZLoSX0y
 WGuke5T6ZCDUSoZSC2WW4xtWubDwsf3RqVNN0oq3Q4DUpHW/5Blk9alDDuPTNEsTM35wGfIT8KU
 q
X-Google-Smtp-Source: AGHT+IGisEqRQFzyQeAsM9alRoTB8oJYoLKxVH4SFxHu/nRrwo3YOttRiyP1dOLTQXa+bS/yS0uAoQ==
X-Received: by 2002:a05:6402:795:b0:566:4459:920b with SMTP id
 d21-20020a056402079500b005664459920bmr311301edy.41.1709023323449; 
 Tue, 27 Feb 2024 00:42:03 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 i2-20020a0564020f0200b005651ae4ac91sm542918eda.41.2024.02.27.00.42.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Sergio Lopez <slp@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/30] hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
Date: Tue, 27 Feb 2024 09:39:37 +0100
Message-ID: <20240227083948.5427-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Rather than taking a QOM name which has to be resolved, let's pass the parent
directly as pointer. This simplifies the code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240224135851.100361-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 2 +-
 hw/i386/microvm.c     | 2 +-
 hw/i386/pc_piix.c     | 7 +++----
 hw/i386/pc_q35.c      | 2 +-
 hw/i386/x86.c         | 7 +++----
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 8e306db7bb..4dc30dcb4d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -139,7 +139,7 @@ typedef struct GSIState {
 
 qemu_irq x86_allocate_cpu_irq(void);
 void gsi_handler(void *opaque, int n, int level);
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
+void ioapic_init_gsi(GSIState *gsi_state, Object *parent);
 DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 /* pc_sysfw.c */
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index ca55aecc3b..61a772dfe6 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -175,7 +175,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
                           &error_abort);
     isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-    ioapic_init_gsi(gsi_state, "machine");
+    ioapic_init_gsi(gsi_state, OBJECT(mms));
     if (ioapics > 1) {
         x86ms->ioapic2 = ioapic_init_secondary(gsi_state);
     }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ec7c07b362..7724396ead 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -107,6 +107,7 @@ static void pc_init1(MachineState *machine,
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
     PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
@@ -189,8 +190,6 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcmc->pci_enabled) {
-        Object *phb;
-
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
@@ -303,8 +302,8 @@ static void pc_init1(MachineState *machine,
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (pcmc->pci_enabled) {
-        ioapic_init_gsi(gsi_state, "i440fx");
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
     }
 
     if (tcg_enabled()) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 53fb3db26d..c89ff63579 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -263,7 +263,7 @@ static void pc_q35_init(MachineState *machine)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    ioapic_init_gsi(gsi_state, "q35");
+    ioapic_init_gsi(gsi_state, OBJECT(phb));
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 684dce90e9..807e09bcdb 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -640,20 +640,19 @@ void gsi_handler(void *opaque, int n, int level)
     }
 }
 
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
+void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
 {
     DeviceState *dev;
     SysBusDevice *d;
     unsigned int i;
 
-    assert(parent_name);
+    assert(parent);
     if (kvm_ioapic_in_kernel()) {
         dev = qdev_new(TYPE_KVM_IOAPIC);
     } else {
         dev = qdev_new(TYPE_IOAPIC);
     }
-    object_property_add_child(object_resolve_path(parent_name, NULL),
-                              "ioapic", OBJECT(dev));
+    object_property_add_child(parent, "ioapic", OBJECT(dev));
     d = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(d, &error_fatal);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-- 
2.41.0


