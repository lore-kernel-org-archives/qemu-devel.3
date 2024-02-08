Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC576C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV2-0007F5-JP; Thu, 08 Feb 2024 17:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV1-0007Dz-3r
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:03 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCUy-0005DS-Qk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:02 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5114b1e8819so437307e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429838; x=1708034638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EMBB55jqpCJkBcQ1c0YyXXZsCM5p/S766dPr/hLwsk=;
 b=Ut5PICfQ6wqfCxT557qJF8DdFAcFFvR5K2t8Jf4hyXzG17BZLRYrzNhO5eXUMWc4wX
 eu/z3bsu+OGHiFJIaFvQwRwVCCaNCIW7EoEng0OonSVdFiJ7aV9LBa2fVw1s7JDEoSAT
 0knPiNLbpwgZKZkjTxn9H/nqGHsVHYHM4BfAxruyeKzJoQla7H3V6mijzRoLY1K/WyE4
 pgrYeaFXA6LxWt2XPvc6du4+U5yiV1IvMghp67osIUy6x1VcHurF5p8Losc9f96ZvhGZ
 IjawTK/4bn6qnbmOMGEojkcMMVmP6ldkIXCFApnRA+/9UvLGmSaQpzuOS8wusTvSpo4s
 352g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429838; x=1708034638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EMBB55jqpCJkBcQ1c0YyXXZsCM5p/S766dPr/hLwsk=;
 b=UEiFS2h9ymMeJdFtNoz2pmYxXlX/ykvbBSUKtsp7sNPpZ/v0QgekzsyTM0OyzEnRHY
 WArkmXW8xpqzlX4qfpHPEhpFjUkBq3iwmQdqPsG5x3gWf/XveGDhNNwhHcLEeHxm6F+f
 Q8LvZ46BYZcpdYn6MIxKhWkNzP5E+WYlEWvdX4yvTXPfGtuSxltwmWqVuYyHMHPqGiBb
 0aLp/wUTe6YnYOLALeO33EvRxTS4nSrrwxwt9b9AKijjy2GK2gPEUfbWKD44Xm9vaJVg
 fFeUaBaV8TJaW+8OKDGpfXUgYIkqXM2a60liNvGYt+R4soGSIfeadHuJt26zR+qGFutg
 BpTA==
X-Gm-Message-State: AOJu0YzhshkT9kqsyqmAfmucMRpBaOH+qIPSt6fpFObCUtuPl6d6QCbM
 B5z0Kttcaaaf6O/H8WHb+0azHWhZDiP8aJB4mNxeN2/mb++Q6U4faM0f3khs
X-Google-Smtp-Source: AGHT+IFIc3rAWJLljLhw0OK9ZJ2YP7B18AdbGPz/q1iXnHP/fB1pfuiop1Zfv1Asevq+8hnkcWMXtg==
X-Received: by 2002:ac2:465e:0:b0:511:5537:fb26 with SMTP id
 s30-20020ac2465e000000b005115537fb26mr369724lfo.39.1707429837900; 
 Thu, 08 Feb 2024 14:03:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU7bOUuVLV9JHzI1+sVnFJDlnciySTroAEBXgBjWPossKfVZrBLIugiscdfOieOF6YvqXy+K8Vtih09OKral58qf65IpOf+lILXq+k2/vVReYqk5ZLBlrjmIQ0do+/Ytj/WPS87rTr+UouqjDZhyGcAGh5fMROX1Htdax9s7cgJivxmdrAGjPRZTsxwmjvUV8vi5R+1iKCYgO4Dof0voU3atefTdI0HAqMKNGVUUbX+lVtScZ1C
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:03:57 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/9] hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
Date: Thu,  8 Feb 2024 23:03:41 +0100
Message-ID: <20240208220349.4948-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12a.google.com
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
---
 include/hw/i386/x86.h | 2 +-
 hw/i386/microvm.c     | 2 +-
 hw/i386/pc_piix.c     | 7 +++----
 hw/i386/pc_q35.c      | 4 ++--
 hw/i386/x86.c         | 7 +++----
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index da19ae1546..6fe29fbb87 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -138,7 +138,7 @@ typedef struct GSIState {
 
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
index 70d12bb1b5..5ed3d69181 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -109,6 +109,7 @@ static void pc_init1(MachineState *machine,
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
     PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
@@ -192,8 +193,6 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcmc->pci_enabled) {
-        Object *phb;
-
         pci_memory = g_new(MemoryRegion, 1);
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
@@ -320,8 +319,8 @@ static void pc_init1(MachineState *machine,
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (pcmc->pci_enabled) {
-        ioapic_init_gsi(gsi_state, "i440fx");
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
     }
 
     if (tcg_enabled()) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..53da8b552d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -286,8 +286,8 @@ static void pc_q35_init(MachineState *machine)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (pcmc->pci_enabled) {
-        ioapic_init_gsi(gsi_state, "q35");
+    if (phb) {
+        ioapic_init_gsi(gsi_state, OBJECT(phb));
     }
 
     if (tcg_enabled()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d..3b33d09a53 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -636,20 +636,19 @@ void gsi_handler(void *opaque, int n, int level)
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
2.43.0


