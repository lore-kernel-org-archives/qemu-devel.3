Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BA7C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkI9E-0005vV-C1; Tue, 18 Feb 2025 02:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkI9B-0005uZ-RC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkI99-0004fa-M8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739864156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8umlkfTIf0Wkn2ZiQljLCMhn6js0QWLR8+Nou1ET7jw=;
 b=S509KbHk5j2WZE1E8HMCuQbxQIjJva8HXv4/Wu2HI6CLTRoL94rL88rK8hGhFbdKukct23
 BY3WSPFqHtK8B1og0h7X3OGx1mfeCZ1yD8ejbBescMv5K6h1aW8CYymRaGNjUMdUIcR1pD
 aehYuh0XM8eZ92nx4DC66itDX9eb5M4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-6bWX6XIjOmqUVf0ieea9NA-1; Tue,
 18 Feb 2025 02:35:51 -0500
X-MC-Unique: 6bWX6XIjOmqUVf0ieea9NA-1
X-Mimecast-MFC-AGG-ID: 6bWX6XIjOmqUVf0ieea9NA_1739864149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 400D91800570; Tue, 18 Feb 2025 07:35:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB3C11956048; Tue, 18 Feb 2025 07:35:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] aspeed: Remove duplicate typename in AspeedSoCClass
Date: Tue, 18 Feb 2025 08:35:34 +0100
Message-ID: <20250218073534.585066-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SoC type name is stored under AspeedSoCClass which is
redundant. Use object_get_typename() instead where needed.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 1 -
 hw/arm/aspeed_ast10x0.c     | 3 +--
 hw/arm/aspeed_ast2400.c     | 4 +---
 hw/arm/aspeed_ast2600.c     | 3 +--
 hw/arm/aspeed_ast27x0.c     | 3 +--
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index e1cb9d5cc32c..96459d02a9bf 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -158,7 +158,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
 struct AspeedSoCClass {
     DeviceClass parent_class;
 
-    const char *name;
     /** valid_cpu_types: NULL terminated array of a single CPU type. */
     const char * const *valid_cpu_types;
     uint32_t silicon_rev;
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e76c7100a1d2..ec329f4991c9 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -116,7 +116,7 @@ static void aspeed_soc_ast1030_init(Object *obj)
     char typename[64];
     int i;
 
-    if (sscanf(sc->name, "%7s", socname) != 1) {
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
         g_assert_not_reached();
     }
 
@@ -428,7 +428,6 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
     dc->realize = aspeed_soc_ast1030_realize;
 
-    sc->name = "ast1030-a1";
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1030_A1_SILICON_REV;
     sc->sram_size = 0xc0000;
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 57540c7b2cbb..6e756fa23e61 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -157,7 +157,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
     char socname[8];
     char typename[64];
 
-    if (sscanf(sc->name, "%7s", socname) != 1) {
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
         g_assert_not_reached();
     }
 
@@ -564,7 +564,6 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
 
-    sc->name         = "ast2400-a1";
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2400_A1_SILICON_REV;
     sc->sram_size    = 0x8000;
@@ -593,7 +592,6 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
 
-    sc->name         = "ast2500-a1";
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2500_A1_SILICON_REV;
     sc->sram_size    = 0x9000;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 45cc3da39bcc..faebb2ef14a9 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -167,7 +167,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     char socname[8];
     char typename[64];
 
-    if (sscanf(sc->name, "%7s", socname) != 1) {
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
         g_assert_not_reached();
     }
 
@@ -773,7 +773,6 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     /* Reason: The Aspeed SoC can only be instantiated from a board */
     dc->user_creatable = false;
 
-    sc->name         = "ast2600-a3";
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2600_A3_SILICON_REV;
     sc->sram_size    = 0x16400;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 3e373f966b5f..6506bdfdff68 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -316,7 +316,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
     char socname[8];
     char typename[64];
 
-    if (sscanf(sc->name, "%7s", socname) != 1) {
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
         g_assert_not_reached();
     }
 
@@ -757,7 +757,6 @@ static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
     dc->realize      = aspeed_soc_ast2700_realize;
 
-    sc->name         = "ast2700-a0";
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2700_A0_SILICON_REV;
     sc->sram_size    = 0x20000;
-- 
2.48.1


