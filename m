Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA450C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMK8-0003aN-LM; Fri, 26 Jan 2024 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMK1-0002zz-HH; Fri, 26 Jan 2024 08:32:42 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMJz-00080V-9e; Fri, 26 Jan 2024 08:32:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLzC86q36z4wx6;
 Sat, 27 Jan 2024 00:32:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLzC66hVcz4wny;
 Sat, 27 Jan 2024 00:32:34 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PULL 05/17] hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
Date: Fri, 26 Jan 2024 14:32:04 +0100
Message-ID: <20240126133217.996306-6-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133217.996306-1-clg@kaod.org>
References: <20240126133217.996306-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to alter AspeedSoCClass::cpu_type in the next
commit, introduce the aspeed_soc_cpu_type() helper to
retrieve the per-SoC CPU type from AspeedSoCClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast10x0.c     | 2 +-
 hw/arm/aspeed_ast2400.c     | 3 ++-
 hw/arm/aspeed_ast2600.c     | 3 ++-
 hw/arm/aspeed_soc_common.c  | 5 +++++
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cb832bc1ee14..a060a5991874 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -143,6 +143,7 @@ struct AspeedSoCClass {
     qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
 };
 
+const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
 
 enum {
     ASPEED_DEV_SPI_BOOT,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 8becb146a8df..dca601a3f9b6 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -211,7 +211,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     /* AST1030 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-    qdev_prop_set_string(armv7m, "cpu-type", sc->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&a->armv7m), "memory",
                              OBJECT(s->memory), &error_abort);
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 0baa2ff96e46..789e591f3ad0 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -155,7 +155,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
+        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
+                                aspeed_soc_cpu_type(sc));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 3a9a303ab8ba..589a4a6eea10 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -157,7 +157,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
+        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
+                                aspeed_soc_cpu_type(sc));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 828f61093bfa..36ca189ce960 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -18,6 +18,11 @@
 #include "hw/char/serial.h"
 
 
+const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
+{
+    return sc->cpu_type;
+}
+
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
 {
     return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
-- 
2.43.0


