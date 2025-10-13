Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C4CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hw7-0005PH-BD; Mon, 13 Oct 2025 08:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvs-00059l-Qb
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvb-0008Eq-RK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cu0/up0C34u6VgaT7VD1i2KSTdc2/ZHtKEWT6HqXxQ=;
 b=eQNunZV5pJCxAM4Z/H5X0kEDGjmsGwYgr1Vg1BjNG8EJGSH3ahqKsihf4NHclpjbdWMeNA
 dKrnWQHZ7V3G/uzT35T9KTmCuN3HGdN1VSjrFx4YKBLh0dptnWDNQYg3BYTtK4ZmEcZRak
 LS8uNg4ytkJbvQkKc3wCSb9Dgej1D+I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-oRYDNXCfP8at1-oAR7jTBA-1; Mon,
 13 Oct 2025 08:45:24 -0400
X-MC-Unique: oRYDNXCfP8at1-oAR7jTBA-1
X-Mimecast-MFC-AGG-ID: oRYDNXCfP8at1-oAR7jTBA_1760359520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 920151956095; Mon, 13 Oct 2025 12:45:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20044180141F; Mon, 13 Oct 2025 12:45:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/29] hw/arm/aspeed_ast27x0-tsp: Rename type to
 TYPE_ASPEED27X0TSP_COPROCESSOR
Date: Mon, 13 Oct 2025 14:44:19 +0200
Message-ID: <20251013124421.71977-29-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Rename the AST27x0 TSP type from TYPE_ASPEED27X0TSP_SOC to
TYPE_ASPEED27X0TSP_COPROCESSOR to align with the naming convention used
for the SSP coprocessor (TYPE_ASPEED27X0SSP_COPROCESSOR).
This change clarifies that TSP is implemented as a coprocessor rather than
a full SoC.

This ensures consistent terminology between SSP and TSP components and
improves clarity within the coprocessor subsystem code.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-16-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  4 ++--
 hw/arm/aspeed_ast27x0-fc.c          |  3 ++-
 hw/arm/aspeed_ast27x0-tsp.c         | 10 +++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 1c201a15c61c..d77655d65911 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -54,8 +54,8 @@ struct Aspeed27x0CoprocessorState {
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState,
                            ASPEED27X0SSP_COPROCESSOR)
 
-#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
+#define TYPE_ASPEED27X0TSP_COPROCESSOR "aspeed27x0tsp-coprocessor"
 DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
-                     ASPEED27X0TSP_SOC, TYPE_ASPEED27X0TSP_SOC)
+                     ASPEED27X0TSP_COPROCESSOR, TYPE_ASPEED27X0TSP_COPROCESSOR)
 
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 67982d2fa073..a61ecff3909b 100644
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
index e18c624361e2..7f109101fe44 100644
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
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_COPROCESSOR(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
 
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
@@ -286,7 +286,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
 
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
     {
-        .name           = TYPE_ASPEED27X0TSP_SOC,
+        .name           = TYPE_ASPEED27X0TSP_COPROCESSOR,
         .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0tsp_init,
-- 
2.51.0


