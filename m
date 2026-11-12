Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCR8SjI8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvY-0007rJ-Ed; Thu, 12 Nov 2026 08:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUua-0006ck-Iz
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuW-0005Xs-QP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qReHvqPGmVsZymreTUo3l6q3Hxvodm/KyscqrOLrz2s=;
 b=OCR8SjI8R0xtDrYcpYFNeL9YFjto1z7xxSy/E2oG9GSPk8gg5Gl8KlFEWeGudoQMOd3H1t
 uADbZ+1d8lzi/A/rXNiFuvVvxZouHu3qIwThAsGGTs6su6iiL9pYW9A6Mk4DvljnwSDJrC
 lXUMa79gIwUha3H1zZNVIw7C9fZ8HTw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-kErDBi6GOV-RXoUr_QMZfA-1; Thu,
 12 Nov 2026 08:32:04 -0500
X-MC-Unique: kErDBi6GOV-RXoUr_QMZfA-1
X-Mimecast-MFC-AGG-ID: kErDBi6GOV-RXoUr_QMZfA_1794490323
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AADA18F4744; Thu, 12 Nov 2026 13:32:03 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C71C1956087; Thu, 12 Nov 2026 13:32:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 36/48] hw/arm: declare arm machine targets
Date: Thu, 12 Nov 2026 13:30:42 +0000
Message-ID: <20261112133054.1977618-37-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This prevents creation of arm machines unless the current selected
target is arm and enables removal of the 'is_available' callback.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 5 ++++-
 hw/arm/aspeed_ast27x0_evb.c | 7 +++++--
 hw/arm/raspi.c              | 9 ++++++---
 hw/arm/raspi4b.c            | 6 ++++--
 hw/arm/virt.c               | 6 ++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 73362b60d2a..b0d2fc091d0 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,6 +22,8 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
+#include "qom/object_interfaces.h"
+#include "qemu/base-arch-defs.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
@@ -220,12 +222,14 @@ static void ast2700fc_init(MachineState *machine)
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
     mc->desc = "ast2700 full core support";
     mc->init = ast2700fc_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
 }
 
 static const TypeInfo ast2700fc_types[] = {
@@ -234,7 +238,6 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
-        .is_available   = target_aarch64,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 9f7d4395114..d698bb25833 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -12,6 +12,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
 #include "qom/object_interfaces.h"
+#include "qemu/base-arch-defs.h"
 
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
@@ -33,7 +34,9 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a1";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
@@ -55,11 +58,13 @@ static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
     AliasedClass *alc = ALIASED_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
     static const char *const aliases[] = {
         MACHINE_TYPE_NAME("ast2700-evb"), NULL,
     };
 
     alc->aliases = aliases;
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a2";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
@@ -80,13 +85,11 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .is_available  = target_aarch64,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
-        .is_available  = target_aarch64,
     }
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..b9b79942d29 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -24,7 +24,8 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "qom/object.h"
+#include "qom/object_interfaces.h"
+#include "qemu/base-arch-defs.h"
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
 OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
@@ -370,9 +371,11 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
@@ -380,9 +383,11 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa02082;
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
@@ -403,12 +408,10 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
-        .is_available   = target_aarch64,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-        .is_available   = target_aarch64,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 600dfe686f2..69048f8b4a3 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -19,8 +19,9 @@
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
 #include "hw/arm/boot.h"
-#include "qom/object.h"
+#include "qom/object_interfaces.h"
 #include "hw/arm/bcm2838.h"
+#include "qemu/base-arch-defs.h"
 #include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
@@ -88,11 +89,13 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+    TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
+    tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64);
 }
 
 static const TypeInfo raspi4b_machine_type = {
@@ -100,7 +103,6 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
-    .is_available   = target_aarch64,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6217771032e..ca5cd3c16b8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,7 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "qom/object_interfaces.h"
+#include "qemu/base-arch-defs.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -119,10 +120,13 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
+        TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc); \
         arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM) | \
+            QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64); \
         classinitextra \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
@@ -130,7 +134,6 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("arm-virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_base_arm, \
         .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
@@ -4467,7 +4470,6 @@ static const TypeInfo virt_machine_info = {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
-    .is_available = target_base_arm,
 };
 
 static void machvirt_machine_init(void)
-- 
2.56.1


