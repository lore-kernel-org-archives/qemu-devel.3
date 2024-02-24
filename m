Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFDC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYc-0004AJ-8f; Sat, 24 Feb 2024 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYV-000487-M9
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:07 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYT-0002jw-G7
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:07 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so1095633f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783143; x=1709387943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYU20oh+ltvSrpa869kLXAb6cEq3qERtoyld+C9r5WM=;
 b=dtRxF/gMCEhPFbUL9qjp6vX5jfSQq0dTUx4Z/3gQsIyjIAx9yRzzxG/Dhk3/29OuMf
 Gnu7GCWkElq6MVp1UMyuB06O1hdToZdyIyzwuMpg2d/G9vjpho6/CE1XEzXyDySySy+t
 /Q1GMhLNIA4ky12mZRgzR7457IiQsRD4KwICNT0YiiMbUs8TjXHMK4cApfgmnN+j3vR2
 VQzNyjTorHuT7BlSp+/pqBVAbrXB7FrcP5QuFuRBIxsYRNFJBtAdl3H1PgcIMjDZqT6W
 1FKLUYz0gbNz0CUxoDHdrHEkRDIJvgWmz3qIOR28i/8ALeWx73Y59iX6P6op1UhCrVg/
 AUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783143; x=1709387943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYU20oh+ltvSrpa869kLXAb6cEq3qERtoyld+C9r5WM=;
 b=e+L62jxrxVbiv4icCnjqAdK0t7DKvUJIa6wEYOoDv6mUeuVBFzUWAHJxauqclAVYzV
 6k1ZftICCV3a3Y7J3or4n07QiaH4bJyR1ygf/s8yGCsxrIuYMb8qV7m9LA0W6AVpj7tB
 XpwRZ4+8gUvxdEcFdKcRARbErZtBV8d5wJLDBHWjSjz3X9xl3i8pSmCJZcbqObxhgh4c
 J9F81g5MFHGoMeZb06//xccSCrZF3JCv1J8voe/ErEWPa0pURdgprgMvc8g/w8yDBKEO
 LjsdoIY4xOoRxvopNE+LktocGFiVfzkRTxGx+FmtK/J5y9NJn2AdjfMP7K/q0DX6pH93
 8kfA==
X-Gm-Message-State: AOJu0YwBGFFyoudsSDaRVYdI3lkPavTL2qoGVQuZPIf8oZo68hOYQfTm
 G6JwckDntdSansh/+W7AXE5LKJ7QuH8Q9TNwJmGgdktixhygjMKJ46OODRXI
X-Google-Smtp-Source: AGHT+IE5NLZR9/s6xnEAzSZGRypHlrxeMjCw8Lj9wckiyxYodtvOMWWfL84OFjn3PyDNLi9FFzTgWg==
X-Received: by 2002:adf:e3ca:0:b0:33d:1d57:6eb1 with SMTP id
 k10-20020adfe3ca000000b0033d1d576eb1mr1528491wrm.32.1708783142627; 
 Sat, 24 Feb 2024 05:59:02 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:01 -0800 (PST)
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
Subject: [PATCH v2 1/6] hw/i386/x86: Let ioapic_init_gsi() take parent as
 pointer
Date: Sat, 24 Feb 2024 14:58:46 +0100
Message-ID: <20240224135851.100361-2-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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

Rather than taking a QOM name which has to be resolved, let's pass the parent
directly as pointer. This simplifies the code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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
2.44.0


