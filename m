Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B58EB26E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqge-0003Xb-B3; Tue, 10 Feb 2026 11:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpqgc-0003WJ-07
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:34:02 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpqga-0000WL-DB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/Cuf+Ucx9P/5YzPKylvJUXVJV5Pm6GGJQgztlq4/zoI=; b=RhN/B5EmTDRfnwf
 Xtye86jFH4+3hZbxCAmSudFoS5hK+K5Pt5kzAdCwbsSKvFSgaRKiWsTafHM3jJfagUpZD4FyczMbp
 Q+ofh8OJZYvCHonUjYTjXoeyX1TOlZExVA+v+8ITSCQ6zlM+Bk3Xt0WhsKpt9WWvZeYa2wr6lpbbO
 cM=;
Date: Tue, 10 Feb 2026 17:37:18 +0100
Subject: [PATCH v2 4/4] hppa: Add C3600 machine with PA-8600 CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-hppa-c3600-v2-4-9ca09c677012@rev.ng>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
In-Reply-To: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770741450; l=5113;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=sEdxInzxjPNOkBd/9XyH18aU/tRdo/fD6FwR2HiJ2VE=;
 b=GkhkJ+x6SE2PxrFmVqMsGsVPUARXF+HW5QHx01pXs3MCTlllHOaNsvXKM+jEKE+1Th4izwVUg
 rqtaFvh6HmJBSnHYf0Ip60ZP+iXVkyENxBtFXeBolYLaKvNfKz6MXMM
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a C3600/PA-8600 machine/CPU, which from the perspective of
QEMU differ only in the size of the physical address, compared to
C3700/PA-8700.

With this addition, PA-8700 is changed to use the correct 44 bit
physical address space.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu-qom.h                 |  1 +
 hw/hppa/machine.c                     | 41 ++++++++++++++++++++++++++++++-----
 target/hppa/cpu.c                     | 10 ++++++++-
 tests/functional/hppa/test_seabios.py |  3 +++
 4 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index c6b82dc09b..078aa3b08a 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -28,6 +28,7 @@
 #define HPPA_CPU_TYPE_NAME(name) (name HPPA_CPU_TYPE_SUFFIX)
 
 #define TYPE_HPPA_CPU_PA_7300LC HPPA_CPU_TYPE_NAME("pa-7300lc")
+#define TYPE_HPPA_CPU_PA_8600   HPPA_CPU_TYPE_NAME("pa-8600")
 #define TYPE_HPPA_CPU_PA_8700   HPPA_CPU_TYPE_NAME("pa-8700")
 
 OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8246f6bf65..ab5b8b6422 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -689,9 +689,9 @@ static AstroState *astro_init(void)
 }
 
 /*
- * Create HP C3700 workstation
+ * Create HP C3000 series workstation
  */
-static void machine_HP_C3700_init(MachineState *machine)
+static void machine_HP_C3000_init(MachineState *machine)
 {
     PCIBus *pci_bus;
     AstroState *astro;
@@ -804,9 +804,30 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 512 * MiB;
 }
 
+static void HP_C3600_machine_init_class_init(ObjectClass *oc, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA_CPU_PA_8600,
+        NULL
+    };
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "HP C3600 workstation";
+    mc->default_cpu_type = TYPE_HPPA_CPU_PA_8600;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->init = machine_HP_C3000_init;
+    mc->max_cpus = HPPA_MAX_CPUS;
+    mc->default_ram_size = 1024 * MiB;
+}
+
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
+    /*
+     * SeaBIOS for C3700 currently uses a 40 bit physical address space,
+     * allow use of use the PA-8600.
+     */
     static const char * const valid_cpu_types[] = {
+        TYPE_HPPA_CPU_PA_8600,
         TYPE_HPPA_CPU_PA_8700,
         NULL
     };
@@ -815,7 +836,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->desc = "HP C3700 workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU_PA_8700;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->init = machine_HP_C3700_init;
+    mc->init = machine_HP_C3000_init;
     mc->max_cpus = HPPA_MAX_CPUS;
     mc->default_ram_size = 1024 * MiB;
 }
@@ -855,15 +876,23 @@ static const TypeInfo hppa_machine_types[] = {
             { TYPE_NMI },
             { }
         },
-    }, {
+    },
+    {
         .name = MACHINE_TYPE_NAME("B160L"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_B160L_machine_init_class_init,
-    }, {
+    },
+    {
+        .name = MACHINE_TYPE_NAME("C3600"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_C3600_machine_init_class_init,
+    },
+    {
         .name = MACHINE_TYPE_NAME("C3700"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
-    }, {
+    },
+    {
         .name = MACHINE_TYPE_NAME("715"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_715_machine_init_class_init,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1ba281df20..c88252e071 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -335,13 +335,21 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         },
     },
     {
-        .name = TYPE_HPPA_CPU_PA_8700,
+        .name = TYPE_HPPA_CPU_PA_8600,
         .parent = TYPE_HPPA_CPU,
         .class_data = &(const HPPACPUDef) {
             .phys_addr_bits = 40,
             .is_pa20 = true,
         },
     },
+    {
+        .name = TYPE_HPPA_CPU_PA_8700,
+        .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 44,
+            .is_pa20 = true,
+        },
+    },
 };
 
 DEFINE_TYPES(hppa_cpu_type_infos)
diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hppa/test_seabios.py
index 661b2464e1..41a429d4c4 100755
--- a/tests/functional/hppa/test_seabios.py
+++ b/tests/functional/hppa/test_seabios.py
@@ -29,6 +29,9 @@ def test_hppa_32(self):
 
     def test_hppa_64(self):
         self.set_machine('C3700')
+        # SeaBIOS for C3700 currently uses a 40 bit physical address space,
+        # use the PA-8600 CPU instead of the default PA-8700.
+        self.cpu = 'pa-8600'
         self.boot_seabios()
 
 if __name__ == '__main__':

-- 
2.52.0


