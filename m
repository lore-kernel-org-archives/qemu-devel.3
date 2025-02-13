Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82898C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 03:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiQ1M-0007Eu-Db; Wed, 12 Feb 2025 22:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tiQ16-0007Aa-Li; Wed, 12 Feb 2025 22:35:56 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tiQ14-0000gz-Qh; Wed, 12 Feb 2025 22:35:56 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Feb
 2025 11:35:34 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Feb 2025 11:35:34 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 07/28] hw/intc/aspeed: Rename num_ints to num_inpins for
 clarity
Date: Thu, 13 Feb 2025 11:35:10 +0800
Message-ID: <20250213033531.3367697-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
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

To support AST2700 A1, some registers of the INTC(CPU Die) support one input
pin to multiple output pins. Renamed "num_ints" to "num_inpins" in the INTC
controller code for better clarity and consistency in naming conventions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c       |  2 +-
 hw/intc/aspeed_intc.c         | 31 +++++++++++++++++--------------
 include/hw/intc/aspeed_intc.h | 11 ++++++-----
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 4862b215c1..18e14a7914 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -520,7 +520,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* GICINT orgates -> INTC -> GIC */
-    for (i = 0; i < ic->num_ints; i++) {
+    for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
                                 qdev_get_gpio_in(DEVICE(&a->intc), i));
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index cc2426fbac..95b40e1935 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -41,8 +41,9 @@ static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -54,7 +55,7 @@ static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
 /*
  * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
  * Utilize "address & 0x0f00" to get the irq and irq output pin index
- * The value of irq should be 0 to num_ints.
+ * The value of irq should be 0 to num_inpins.
  * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
  */
 static void aspeed_intc_set_irq(void *opaque, int irq, int level)
@@ -67,8 +68,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     uint32_t enable;
     int i;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -128,8 +129,9 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
 
     irq = (offset & 0x0f00) >> 8;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -184,8 +186,9 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 
     irq = (offset & 0x0f00) >> 8;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -309,8 +312,8 @@ static void aspeed_intc_instance_init(Object *obj)
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     int i;
 
-    assert(aic->num_ints <= ASPEED_INTC_NR_INTS);
-    for (i = 0; i < aic->num_ints; i++) {
+    assert(aic->num_inpins <= ASPEED_INTC_MAX_INPINS);
+    for (i = 0; i < aic->num_inpins; i++) {
         object_initialize_child(obj, "intc-orgates[*]", &s->orgates[i],
                                 TYPE_OR_IRQ);
         object_property_set_int(OBJECT(&s->orgates[i]), "num-lines",
@@ -345,9 +348,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
 
-    qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
+    qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_inpins);
 
-    for (i = 0; i < aic->num_ints; i++) {
+    for (i = 0; i < aic->num_inpins; i++) {
         if (!qdev_realize(DEVICE(&s->orgates[i]), NULL, errp)) {
             return;
         }
@@ -385,7 +388,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
-    aic->num_ints = 9;
+    aic->num_inpins = 9;
     aic->mem_size = 0x4000;
     aic->reg_size = 0x2000;
 }
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 749d7c55be..5f0429c7f9 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -18,6 +18,7 @@ OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
 #define ASPEED_INTC_NR_REGS (0x2000 >> 2)
 #define ASPEED_INTC_NR_INTS 9
+#define ASPEED_INTC_MAX_INPINS 9
 
 struct AspeedINTCState {
     /*< private >*/
@@ -28,19 +29,19 @@ struct AspeedINTCState {
     MemoryRegion iomem_container;
 
     uint32_t regs[ASPEED_INTC_NR_REGS];
-    OrIRQState orgates[ASPEED_INTC_NR_INTS];
+    OrIRQState orgates[ASPEED_INTC_MAX_INPINS];
     qemu_irq output_pins[ASPEED_INTC_NR_INTS];
 
-    uint32_t enable[ASPEED_INTC_NR_INTS];
-    uint32_t mask[ASPEED_INTC_NR_INTS];
-    uint32_t pending[ASPEED_INTC_NR_INTS];
+    uint32_t enable[ASPEED_INTC_MAX_INPINS];
+    uint32_t mask[ASPEED_INTC_MAX_INPINS];
+    uint32_t pending[ASPEED_INTC_MAX_INPINS];
 };
 
 struct AspeedINTCClass {
     SysBusDeviceClass parent_class;
 
     uint32_t num_lines;
-    uint32_t num_ints;
+    uint32_t num_inpins;
     uint64_t mem_size;
     uint64_t reg_size;
     const MemoryRegionOps *reg_ops;
-- 
2.34.1


