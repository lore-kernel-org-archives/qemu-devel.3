Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADBFCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvw-0005D5-Qs; Mon, 13 Oct 2025 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvr-00057a-MW
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvb-0008Eg-QX
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEUCGx+oUMjLbWrVPKVp1eS5UeVFKTbcYu+ni6eOEf0=;
 b=K9I5ushiEZp9SCU6lC75DpDlz+DjEbz1dUR2z5QftBfiQVCVJgHlaJL/32VYYCITpVMP34
 iDJ7FBG17aNF6D+PPP1RGXxdL+YKltkiuabG/osftzSlwznpqzA0tzPXUI2fJM0IcdKzZe
 vMX8MPLNuNs61mGCXqz0V368MIKuYzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-Qe660E9VNKKnPgzNox8wqA-1; Mon,
 13 Oct 2025 08:45:20 -0400
X-MC-Unique: Qe660E9VNKKnPgzNox8wqA-1
X-Mimecast-MFC-AGG-ID: Qe660E9VNKKnPgzNox8wqA_1760359518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1FAE1800447; Mon, 13 Oct 2025 12:45:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F7B1180141F; Mon, 13 Oct 2025 12:45:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/29] hw/arm/aspeed_ast27x0-ssp: Rename type to
 TYPE_ASPEED27X0SSP_COPROCESSOR
Date: Mon, 13 Oct 2025 14:44:18 +0200
Message-ID: <20251013124421.71977-28-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename the AST27x0 SSP type from TYPE_ASPEED27X0SSP_SOC to
TYPE_ASPEED27X0SSP_COPROCESSOR to better reflect its role as a coprocessor
rather than a standalone SoC. This aligns naming conventions with the
coprocessor-based design introduced in earlier refactors.

This change improves naming consistency across SSP and TSP coprocessor
implementations and clarifies their relationship to the unified
Aspeed27x0CoprocessorState.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  5 +++--
 hw/arm/aspeed_ast27x0-fc.c          |  3 ++-
 hw/arm/aspeed_ast27x0-ssp.c         | 10 +++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 110e776c6202..1c201a15c61c 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -50,8 +50,9 @@ struct Aspeed27x0CoprocessorState {
     ARMv7MState armv7m;
 };
 
-#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState, ASPEED27X0SSP_SOC)
+#define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState,
+                           ASPEED27X0SSP_COPROCESSOR)
 
 #define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
 DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index c2fa8df33ce4..67982d2fa073 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -121,7 +121,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
 
-    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp,
+                            TYPE_ASPEED27X0SSP_COPROCESSOR);
     memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
                        UINT64_MAX);
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index f8319c95fd41..d27be8b92558 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -1,5 +1,5 @@
 /*
- * ASPEED Ast27x0 SSP SoC
+ * ASPEED Ast27x0 SSP Coprocessor
  *
  * Copyright (C) 2025 ASPEED Technology Inc.
  *
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
 
 static void aspeed_soc_ast27x0ssp_init(Object *obj)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
 
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -286,7 +286,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *dat
 
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
     {
-        .name           = TYPE_ASPEED27X0SSP_SOC,
+        .name           = TYPE_ASPEED27X0SSP_COPROCESSOR,
         .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0ssp_init,
-- 
2.51.0


