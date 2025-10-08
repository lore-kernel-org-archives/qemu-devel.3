Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C328BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Klw-0002Ri-0J; Tue, 07 Oct 2025 23:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Klo-0002KO-83; Tue, 07 Oct 2025 23:23:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kll-0000bG-7G; Tue, 07 Oct 2025 23:23:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:13 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:13 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 15/16] hw/arm/aspeed_ast27x0-tsp: Rename type to
 TYPE_ASPEED27X0TSP_COPROCESSOR
Date: Wed, 8 Oct 2025 11:22:00 +0800
Message-ID: <20251008032207.593353-16-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename the AST27x0 TSP type from TYPE_ASPEED27X0TSP_SOC to
TYPE_ASPEED27X0TSP_COPROCESSOR to align with the naming convention used
for the SSP coprocessor (TYPE_ASPEED27X0SSP_COPROCESSOR).
This change clarifies that TSP is implemented as a coprocessor rather than
a full SoC.

This ensures consistent terminology between SSP and TSP components and
improves clarity within the coprocessor subsystem code.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h |  4 ++--
 hw/arm/aspeed_ast27x0-fc.c          |  3 ++-
 hw/arm/aspeed_ast27x0-tsp.c         | 10 +++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 77159c230b..d274e8e20e 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -55,8 +55,8 @@ struct Aspeed27x0CoprocessorState {
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState,
                            ASPEED27X0SSP_COPROCESSOR)
 
-#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
+#define TYPE_ASPEED27X0TSP_COPROCESSOR "aspeed27x0tsp-coprocessor"
 DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
-                     ASPEED27X0TSP_SOC, TYPE_ASPEED27X0TSP_SOC)
+                     ASPEED27X0TSP_COPROCESSOR, TYPE_ASPEED27X0TSP_COPROCESSOR)
 
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 67982d2fa0..a61ecff390 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -149,7 +149,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
 
-    object_initialize_child(OBJECT(s), "tsp", &s->tsp, TYPE_ASPEED27X0TSP_SOC);
+    object_initialize_child(OBJECT(s), "tsp", &s->tsp,
+                            TYPE_ASPEED27X0TSP_COPROCESSOR);
     memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
                        UINT64_MAX);
 
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index c00f7d056c..8d3d457919 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -1,5 +1,5 @@
 /*
- * ASPEED Ast27x0 TSP SoC
+ * ASPEED Ast27x0 TSP Coprocessor
  *
  * Copyright (C) 2025 ASPEED Technology Inc.
  *
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
 {
     AspeedCoprocessorState *s = (AspeedCoprocessorState *)ctx;
-    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_COPROCESSOR(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
 
 static void aspeed_soc_ast27x0tsp_init(Object *obj)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_COPROCESSOR(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
 
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_COPROCESSOR(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -287,7 +287,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
 
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
     {
-        .name           = TYPE_ASPEED27X0TSP_SOC,
+        .name           = TYPE_ASPEED27X0TSP_COPROCESSOR,
         .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0tsp_init,
-- 
2.43.0


