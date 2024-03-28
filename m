Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A46CD128C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps65-0001SK-Cq; Thu, 28 Mar 2024 11:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5z-0001GN-7W
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5v-00023G-6T
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so154897166b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641308; x=1712246108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfY93X5jZfIbOGpoyV/9aTUl+UEfpsvUbOU4aZU0Anc=;
 b=KcDehLZUQFLKH1qMQyQfd7qkVzkHxH1kJCPkbPOwv5fq3LkHOCbg7ydwNNQvMVZ0vh
 7iTm43HX5ZO3RBPh/ikhoBgoQQjFtpMInpQpu39B3lycRIEq8XQ/zI/tAS3Pzv2fhTTi
 bu8y4BaDrcpgVUC8p+NPktKkTDbdhBRUIW8N7zezmz9CkGrz6YiDKi/H3zydbT+vK7jx
 FpDeN8V7wlUoHOaKKRbEjoub6FcDm335XzO/Terj9+Iy+ZQywBfq7G4EubyGXunw0CdZ
 rsTSnRdOTVE5ANSEE8E/q8UsGRytQvKraupCTSoNePUgZHyobP+0f9hE95NHt3vo7P9S
 h14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641308; x=1712246108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfY93X5jZfIbOGpoyV/9aTUl+UEfpsvUbOU4aZU0Anc=;
 b=K5bADfnC6gQLkGdHqYJg1f1GWU70JpDPnQVhABNXhfb5CXlzRJntH0qVYeDEIhqxq5
 i12pz9nfScxdZqRYK+QPlqigMh+4MTVUUgJGMU0Hqg2VgXd7xOFAsiK8MGbpQDLaEEQj
 dZbrEI/84P/eHHBleRyx6CJlsYHRiuE/Lz1M/UtP/68OWjKmAK+R7y1s05WAOJOPQKWb
 gUvqly/qxVeiz2y77G0dgg6pjz8W8UaUklRpafWzXV58ykoGT92JAUBS1xNlo/i0ugx/
 AVzXxB782lt5NWsHvE6xUhEqJ0zbPMXfiskereeQCcBfAbS94KGSwiKATZN0Upl6XOsO
 KTCQ==
X-Gm-Message-State: AOJu0YwO+zJlTJqq3ciNWMol5TykU4Uq0v1/vSXv/F2riAxwJr/RhsJ/
 bGI+3mAaL0xhb0gktooHaoKcNuTSPU9gd84RhYbkXEIaVnk+M64BU4Wy2iAO11XnDHMto8nx0RB
 0
X-Google-Smtp-Source: AGHT+IFlVuycGv39RKoJmMuDSzpYHIv5NkuYfdH5v63bTElq/w8DazJwyMi8sNCnbLq/4DH71CZp5g==
X-Received: by 2002:a17:906:2dce:b0:a4e:299f:7f4f with SMTP id
 h14-20020a1709062dce00b00a4e299f7f4fmr690299eji.48.1711641307840; 
 Thu, 28 Mar 2024 08:55:07 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 x15-20020a170906710f00b00a46cc48ab13sm898792ejj.62.2024.03.28.08.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 04/29] hw/i386/pc: Introduce PC_PCI_MACHINE QOM
 type
Date: Thu, 28 Mar 2024 16:54:12 +0100
Message-ID: <20240328155439.58719-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce TYPE_PC_PCI_MACHINE for machines where PCI
is expected (as opposition to the ISA-only PC machine).

This type inherits from the well known TYPE_PC_MACHINE.

Convert I440FX/PIIX and Q35 machines to use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 25 ++++++++++++++++---------
 hw/i386/pc.c         | 25 +++++++++++++++++++++++++
 hw/i386/pc_piix.c    |  6 +++---
 hw/i386/pc_q35.c     |  2 +-
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 33023ebbbe..1a4a61148a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -22,11 +22,8 @@
  * @boot_cpus: number of present VCPUs
  */
 typedef struct PCMachineState {
-    /*< private >*/
     X86MachineState parent_obj;
 
-    /* <public> */
-
     /* State for other subsystems/APIs: */
     Notifier machine_done;
 
@@ -60,6 +57,12 @@ typedef struct PCMachineState {
     CXLState cxl_devices_state;
 } PCMachineState;
 
+typedef struct PcPciMachineState {
+    PCMachineState parent_obj;
+
+    Notifier machine_done;
+} PcPciMachineState;
+
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
@@ -80,12 +83,9 @@ typedef struct PCMachineState {
  *                  way we can use 1GByte pages in the host.
  *
  */
-struct PCMachineClass {
-    /*< private >*/
+typedef struct PCMachineClass {
     X86MachineClass parent_class;
 
-    /*< public >*/
-
     /* Device configuration: */
     bool pci_enabled;
     const char *default_south_bridge;
@@ -124,13 +124,20 @@ struct PCMachineClass {
      * check for memory.
      */
     bool broken_32bit_mem_addr_check;
-};
+} PCMachineClass;
 
-#define TYPE_PC_MACHINE "generic-pc-machine"
+typedef struct PcPciMachineClass {
+    PCMachineClass parent_class;
+} PcPciMachineClass;
+
+#define TYPE_PC_MACHINE "common-pc-machine"
 OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
 
 bool pc_machine_is_pci_enabled(PCMachineState *pcms);
 
+#define TYPE_PC_PCI_MACHINE "pci-pc-machine"
+OBJECT_DECLARE_TYPE(PcPciMachineState, PcPciMachineClass, PC_PCI_MACHINE)
+
 /* ioapic.c */
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7065f11e97..eafd521489 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -621,6 +621,10 @@ void pc_machine_done(Notifier *notifier, void *data)
     pc_cmos_init_late(pcms);
 }
 
+static void pc_pci_machine_done(Notifier *notifier, void *data)
+{
+}
+
 /* setup pci memory address space mapping into system address space */
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space)
@@ -1678,6 +1682,14 @@ static void pc_machine_initfn(Object *obj)
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
+static void pc_pci_machine_initfn(Object *obj)
+{
+    PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
+
+    ppms->machine_done.notify = pc_pci_machine_done;
+    qemu_add_machine_init_done_notifier(&ppms->machine_done);
+}
+
 static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     CPUState *cs;
@@ -1812,6 +1824,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_set_fd_bootchk);
 }
 
+static void pc_pci_machine_class_init(ObjectClass *oc, void *data)
+{
+}
+
 bool pc_machine_is_pci_enabled(PCMachineState *pcms)
 {
     return PC_MACHINE_GET_CLASS(pcms)->pci_enabled;
@@ -1831,6 +1847,15 @@ static const TypeInfo pc_machine_types[] = {
              { }
         },
     },
+    {
+        .name           = TYPE_PC_PCI_MACHINE,
+        .parent         = TYPE_PC_MACHINE,
+        .abstract       = true,
+        .instance_size  = sizeof(PcPciMachineState),
+        .instance_init  = pc_pci_machine_initfn,
+        .class_size     = sizeof(PcPciMachineClass),
+        .class_init     = pc_pci_machine_class_init,
+    },
 };
 
 DEFINE_TYPES(pc_machine_types)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b9f85148e3..7ada452f91 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -463,7 +463,7 @@ static void pc_xen_hvm_init(MachineState *machine)
         pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn, \
-                      TYPE_PC_MACHINE)
+                      TYPE_PC_PCI_MACHINE)
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
@@ -838,7 +838,7 @@ static void xenfv_4_2_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_4_2_machine_options, TYPE_PC_MACHINE);
+                  xenfv_4_2_machine_options, TYPE_PC_PCI_MACHINE);
 
 static void xenfv_3_1_machine_options(MachineClass *m)
 {
@@ -850,5 +850,5 @@ static void xenfv_3_1_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_3_1_machine_options, TYPE_PC_MACHINE);
+                  xenfv_3_1_machine_options, TYPE_PC_PCI_MACHINE);
 #endif
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7dbee38f03..c3b0467ef3 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -339,7 +339,7 @@ static void pc_q35_init(MachineState *machine)
         pc_q35_init(machine); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn, \
-                      TYPE_PC_MACHINE)
+                      TYPE_PC_PCI_MACHINE)
 
 
 static void pc_q35_machine_options(MachineClass *m)
-- 
2.41.0


