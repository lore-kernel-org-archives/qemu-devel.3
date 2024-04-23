Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F6C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnH-000561-Tp; Tue, 23 Apr 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmo-0004SR-CT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmm-000089-31
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUMHGpCVxIHKiN0MLiRHD2ZyHKe2Wcki4o8FSWGa7Ro=;
 b=Vf2a5JfOeFokpOhEdW2cHDyf0Ajx4g53zRXf72stj5YyABt3xHw0cA89wjV1YYzveN8WwH
 PEDHqfpTiLUlx1U57tlzMh++DL4BnQdFI2jmlhh3wMG9wGnctv5BGKbDbxxu4tGSCmIssQ
 ooQ8XEXlpVNYH3wtHz6GnHKmv4i/IDg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-IcqTNz9HO-6AmkMANVspog-1; Tue,
 23 Apr 2024 11:10:15 -0400
X-MC-Unique: IcqTNz9HO-6AmkMANVspog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A079729ABA14;
 Tue, 23 Apr 2024 15:10:15 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7902A20296D2;
 Tue, 23 Apr 2024 15:10:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gavin Shan <gshan@redhat.com>
Subject: [PULL 22/63] hw: Add compat machines for 9.1
Date: Tue, 23 Apr 2024 17:09:10 +0200
Message-ID: <20240423150951.41600-23-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add 9.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              | 11 +++++++++--
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 17 ++++++++++++++---
 hw/i386/pc_q35.c           | 14 ++++++++++++--
 hw/m68k/virt.c             | 11 +++++++++--
 hw/ppc/spapr.c             | 17 ++++++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8b8f6d5c00d..50e0cf4278e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -425,6 +425,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_9_0[];
+extern const size_t hw_compat_9_0_len;
+
 extern GlobalProperty hw_compat_8_2[];
 extern const size_t hw_compat_8_2_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d77..349f79df086 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -198,6 +198,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_9_0[];
+extern const size_t pc_compat_9_0_len;
+
 extern GlobalProperty pc_compat_8_2[];
 extern const size_t pc_compat_8_2_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9a913aeadb..c9119ef3847 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3223,10 +3223,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_machine_9_0_options(MachineClass *mc)
+static void virt_machine_9_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
+
+static void virt_machine_9_0_options(MachineClass *mc)
+{
+    virt_machine_9_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+}
+DEFINE_VIRT_MACHINE(9, 0)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 37ede0e7d4f..a92bec23147 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,6 +33,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_9_0[] = {};
+const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
+
 GlobalProperty hw_compat_8_2[] = {
     { "migration", "zero-page-detection", "legacy"},
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5c21b0c4dbf..b0d818b2094 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_9_0[] = {};
+const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
+
 GlobalProperty pc_compat_8_2[] = {};
 const size_t pc_compat_8_2_len = G_N_ELEMENTS(pc_compat_8_2);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba0766092..8850c49c66a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -513,13 +513,26 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_9_0_machine_options(MachineClass *m)
+static void pc_i440fx_9_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
+DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
+                      pc_i440fx_9_1_machine_options);
+
+static void pc_i440fx_9_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_9_1_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+
+    compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
+}
+
 DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
                       pc_i440fx_9_0_machine_options);
 
@@ -528,8 +541,6 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_9_0_machine_options(m);
-    m->alias = NULL;
-    m->is_default = false;
 
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c7bc8a2041f..6e1180d4b60 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,12 +365,23 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_9_0_machine_options(MachineClass *m)
+static void pc_q35_9_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
+                   pc_q35_9_1_machine_options);
+
+static void pc_q35_9_0_machine_options(MachineClass *m)
+{
+    pc_q35_9_1_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
+}
+
 DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
                    pc_q35_9_0_machine_options);
 
@@ -378,7 +389,6 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_9_0_machine_options(m);
-    m->alias = NULL;
     m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index b8e5e102e6b..09bc9bdfefb 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -357,10 +357,17 @@ type_init(virt_machine_register_types)
     } \
     type_init(machvirt_machine_##major##_##minor##_init);
 
-static void virt_machine_9_0_options(MachineClass *mc)
+static void virt_machine_9_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE(9, 0, true)
+DEFINE_VIRT_MACHINE(9, 1, true)
+
+static void virt_machine_9_0_options(MachineClass *mc)
+{
+    virt_machine_9_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+}
+DEFINE_VIRT_MACHINE(9, 0, false)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9bc97fee08..36ada4d0baf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4806,14 +4806,25 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     type_init(spapr_machine_register_##suffix)
 
 /*
- * pseries-9.0
+ * pseries-9.1
  */
-static void spapr_machine_9_0_class_options(MachineClass *mc)
+static void spapr_machine_9_1_class_options(MachineClass *mc)
 {
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE(9_0, "9.0", true);
+DEFINE_SPAPR_MACHINE(9_1, "9.1", true);
+
+/*
+ * pseries-9.0
+ */
+static void spapr_machine_9_0_class_options(MachineClass *mc)
+{
+    spapr_machine_9_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+}
+
+DEFINE_SPAPR_MACHINE(9_0, "9.0", false);
 
 /*
  * pseries-8.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b1dcb3857f0..7cebbf6c02a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -859,14 +859,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_9_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_9_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(9_1, "9.1", true);
+
 static void ccw_machine_9_0_instance_options(MachineState *machine)
 {
+    ccw_machine_9_1_instance_options(machine);
 }
 
 static void ccw_machine_9_0_class_options(MachineClass *mc)
 {
+    ccw_machine_9_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
-DEFINE_CCW_MACHINE(9_0, "9.0", true);
+DEFINE_CCW_MACHINE(9_0, "9.0", false);
 
 static void ccw_machine_8_2_instance_options(MachineState *machine)
 {
-- 
2.44.0



