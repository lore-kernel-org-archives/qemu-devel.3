Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BC1D64060
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVen9-0001DR-KX; Tue, 16 Dec 2025 18:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemy-0001An-Sn
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemw-0006lO-Q5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+fD/7JQa5FuLmN7yxAhnPUWNpgKG+9LM4Dx9os85w2w=; b=wg/kkk3rntcM+iR
 RsAQ4zBUaz+xIAdNgUeJVhbCdscVHXcNI1zmjuoFl/fqPriT0spxxipGr2naNXjDMXaAbnb/+qcoj
 hVGRuB4Xt763pwBOXge8GDjsk00eHMIEte0tDRNsaH0Kz54/3hd461gReFh1DKph599BQu9y/8NRI
 sQ=;
Date: Wed, 17 Dec 2025 00:51:08 +0100
Subject: [PATCH 03/14] hw/riscv: Filter machine types for
 qemu-system-riscv32/64 binaries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-3-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Register machines able to run in qemu-system-riscv32,
qemu-system-riscv64, or both.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/microblaze-v-generic.c | 3 ++-
 hw/riscv/microchip_pfsoc.c      | 2 ++
 hw/riscv/opentitan.c            | 2 ++
 hw/riscv/shakti_c.c             | 2 ++
 hw/riscv/sifive_e.c             | 2 ++
 hw/riscv/sifive_u.c             | 2 ++
 hw/riscv/spike.c                | 2 ++
 hw/riscv/virt.c                 | 3 +++
 hw/riscv/xiangshan_kmh.c        | 2 ++
 9 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index e863c50cbc..0df276f9fb 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -25,6 +25,7 @@
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/misc/unimp.h"
+#include "hw/riscv/machines-qom.h"
 
 #define LMB_BRAM_SIZE (128 * KiB)
 #define MEMORY_BASEADDR 0x80000000
@@ -186,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index bc4f409c19..51b53121c5 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -49,6 +49,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -748,6 +749,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index d369a8a7dc..e8c6829365 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
@@ -335,6 +336,7 @@ static const TypeInfo open_titan_types[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
+        .interfaces     = riscv32_machine_interfaces,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 3e7f441172..d4cf72de3e 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "hw/riscv/shakti_c.h"
+#include "hw/riscv/machines-qom.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/intc/sifive_plic.h"
@@ -92,6 +93,7 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void shakti_c_machine_type_info_register(void)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7baed1958e..7ed419cf69 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -40,6 +40,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -167,6 +168,7 @@ static const TypeInfo sifive_e_machine_typeinfo = {
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_e_machine_init_register_types(void)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2d27e925e8..2ff2059bb9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -51,6 +51,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -742,6 +743,7 @@ static const TypeInfo sifive_u_machine_typeinfo = {
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_u_machine_init_register_types(void)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index ce190f6c62..69eb3dfc24 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -33,6 +33,7 @@
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
@@ -374,6 +375,7 @@ static const TypeInfo spike_machine_typeinfo = {
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void spike_machine_init_register_types(void)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index aa4dd91325..f42fffb223 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
@@ -1989,6 +1990,8 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_RISCV32_MACHINE },
+         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index a95fd6174f..4d7e191098 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -41,6 +41,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/xiangshan_kmh.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/machines-qom.h"
 #include "system/system.h"
 
 static const MemMapEntry xiangshan_kmh_memmap[] = {
@@ -211,6 +212,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void xiangshan_kmh_machine_register_types(void)

-- 
2.51.0


