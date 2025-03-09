Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205B7C35FF2
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5R-0001Fa-Cc; Sun, 09 Mar 2025 09:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5L-00013S-OG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5J-0003Wf-Q4
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TeyI2ZvNoOQ+1/3m4h1/bu3rnf8Ko87ZNeYweXrzg0=;
 b=UCwZdj80/5c43NfF8jhUT2Ug34fP31nK2NkSoa5BgkGsF9f9aIxqULXyISVh1SeSXU/WXi
 fj3oEHZviOKaxCJ3ROBLXfvNPvCyCErZcUAmpBb9vp/hFYSnQ5JibCSR8AoqWekcvKclUU
 XLl9p0KDFG1tGGGU2A9w0wu7Y2tQghI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-_19AyY2UPZmcU2Ypng1V4g-1; Sun,
 09 Mar 2025 09:52:50 -0400
X-MC-Unique: _19AyY2UPZmcU2Ypng1V4g-1
X-Mimecast-MFC-AGG-ID: _19AyY2UPZmcU2Ypng1V4g_1741528369
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02CD0180035D; Sun,  9 Mar 2025 13:52:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 254F01956094; Sun,  9 Mar 2025 13:52:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/46] hw/intc/aspeed: Rename num_ints to num_inpins for clarity
Date: Sun,  9 Mar 2025 14:51:12 +0100
Message-ID: <20250309135130.545764-29-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

To support AST2700 A1, some registers of the INTC(CPU Die) support one input
pin to multiple output pins. Renamed "num_ints" to "num_inpins" in the INTC
controller code for better clarity and consistency in naming conventions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-12-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h | 11 ++++++-----
 hw/arm/aspeed_ast27x0.c       |  2 +-
 hw/intc/aspeed_intc.c         | 31 +++++++++++++++++--------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 3433277d8715..58be5b3e1323 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -17,6 +17,7 @@
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
 #define ASPEED_INTC_NR_INTS 9
+#define ASPEED_INTC_MAX_INPINS 9
 
 struct AspeedINTCState {
     /*< private >*/
@@ -27,19 +28,19 @@ struct AspeedINTCState {
     MemoryRegion iomem_container;
 
     uint32_t *regs;
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
     uint64_t nr_regs;
     uint64_t reg_offset;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 642a8f55212f..1a3eb02af3bf 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -535,7 +535,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* GICINT orgates -> INTC -> GIC */
-    for (i = 0; i < ic->num_ints; i++) {
+    for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
                                 qdev_get_gpio_in(DEVICE(&a->intc), i));
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index d8ee6e1c0406..217fda6fe001 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -47,8 +47,9 @@ static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
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
@@ -60,7 +61,7 @@ static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
 /*
  * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
  * Utilize "address & 0x0f00" to get the irq and irq output pin index
- * The value of irq should be 0 to num_ints.
+ * The value of irq should be 0 to num_inpins.
  * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
  */
 static void aspeed_intc_set_irq(void *opaque, int irq, int level)
@@ -73,8 +74,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     uint32_t enable;
     int i;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -134,8 +135,9 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
 
     irq = (offset & 0x0f00) >> 8;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -190,8 +192,9 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 
     irq = (offset & 0x0f00) >> 8;
 
-    if (irq >= aic->num_ints) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+    if (irq >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
                       __func__, irq);
         return;
     }
@@ -299,8 +302,8 @@ static void aspeed_intc_instance_init(Object *obj)
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     int i;
 
-    assert(aic->num_ints <= ASPEED_INTC_NR_INTS);
-    for (i = 0; i < aic->num_ints; i++) {
+    assert(aic->num_inpins <= ASPEED_INTC_MAX_INPINS);
+    for (i = 0; i < aic->num_inpins; i++) {
         object_initialize_child(obj, "intc-orgates[*]", &s->orgates[i],
                                 TYPE_OR_IRQ);
         object_property_set_int(OBJECT(&s->orgates[i]), "num-lines",
@@ -338,9 +341,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->iomem_container, aic->reg_offset,
                                 &s->iomem);
 
-    qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
+    qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_inpins);
 
-    for (i = 0; i < aic->num_ints; i++) {
+    for (i = 0; i < aic->num_inpins; i++) {
         if (!qdev_realize(DEVICE(&s->orgates[i]), NULL, errp)) {
             return;
         }
@@ -387,7 +390,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
-    aic->num_ints = 9;
+    aic->num_inpins = 9;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x808 >> 2;
     aic->reg_offset = 0x1000;
-- 
2.48.1


