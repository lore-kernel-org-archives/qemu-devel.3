Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46328E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9I-0007JR-So; Thu, 26 Dec 2024 03:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bhJtZwgKCok97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9G-0007Ix-Ng
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:14 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bhJtZwgKCok97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9E-0000XK-FY
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:14 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2166464e236so131971855ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201390; x=1735806190; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiRo5raG/ykEW6v5ck/8cMpgDmuEWhEdPQmIu7j9JY=;
 b=PluKnEd4gzJAopK5M5YhdDN2wi12P+LN55Zl0ol1uLECeVrecdu71UBinnKxrB73QI
 8Yb6VDMxF3KNKmITY1kk4pRl3YoOGWtoCZdTUACGCBcHqOAbemAnfLeCl5r7Qs+y3xB0
 MHyMTohsYLLQA48PITZjmWaBNjR+HA4WXhpEK1DOyKAnWS2ZtSTDVK0RYVXKX6651o8m
 9/HJ4YIN1CNGGZNngFWmT8Oi0/F+eP4D9WpFWdV/KdWezU27MbxxAdM++Lc6Rljw4y9e
 EgXUsIcEKm95XPWM1Hupyx8abGWRaMfOR33PoAD2qYCT0sK0K4dynxlsDBUtrkVkcwxq
 GQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201390; x=1735806190;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiRo5raG/ykEW6v5ck/8cMpgDmuEWhEdPQmIu7j9JY=;
 b=dUNWBeF2BEQdW16nGEM3bHlm1V9wSvK8ZL0gTjI3sM9twGi91KuSMx6+lEiiTZr1kV
 DLs2WB0gw7FidK6nr/K3pfFdDL74qN/Kw6GvJz6YVSkuAtOoh9zTWGbIOfSiAappyJCa
 dlfsYb237sF/b17h6ClaSxW/Blix3UJ71wvKUOr995PaPzFZwXui01bWP9dy38EdVpLw
 yUbOjMX8v1pNXF2pDXcS5MX+WwHJtIITQuNpRDWlqvv+n+v27gDCESKkhl419l3UeJRF
 VlZbvM6koCJg2D3tC+JvyFQ5GfCxC8Jh8R5KuUQxsxgobXXpWXd/01CZTK4mb25O95fy
 qfmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHFPoJu+7c8sVSxhwhIGeXnk7HdDpLdyh/3ivCLSlKwuWlvVMO1frydWmwxJI9B9A0HVlpmLnSnujU@nongnu.org
X-Gm-Message-State: AOJu0YzoK+SFG2pGJe5V/U5n2CRztMXRJWE8lyxWpPSbHzF2yi8u6Iqy
 lKGSRA7bv+AtsxkVxqXFjl3zknBzU4i1XTAnAryLpc2/smZsplvRRpW7f0SvCjhOsgCja1hTQWv
 p+J9qIhLUGg==
X-Google-Smtp-Source: AGHT+IHc9Y4xmrxe2g3pyPbokapwpY9A9eOC96U4J9DvJ7btB2pMbpJ5B8yXzPEFWp6MbWUZIEgUrhPoGZywYQ==
X-Received: from pgbcb17.prod.google.com ([2002:a05:6a02:711:b0:7fd:5437:9912])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e68b:b0:1e1:d26:6657 with SMTP id
 adf61e73a8af0-1e5e080cb8emr34657253637.42.1735201390551; 
 Thu, 26 Dec 2024 00:23:10 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:25 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-7-wuhaotsh@google.com>
Subject: [PATCH 06/17] hw/misc: Move NPCM7XX GCR to NPCM GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3bhJtZwgKCok97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

A lot of NPCM7XX and NPCM8XX GCR modules share the same code,
this commit moves the NPCM7XX GCR to NPCM GCR for these
properties.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 92 +++++++++++++++++++++-----------------
 hw/misc/trace-events       |  6 +--
 include/hw/arm/npcm7xx.h   |  2 +-
 include/hw/misc/npcm_gcr.h |  7 +--
 4 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 826fd41123..0959f2e5c4 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -84,10 +84,10 @@ static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
 };
 
-static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxGCRState *s = opaque;
+    NPCMGCRState *s = opaque;
 
     if (reg >= NPCM7XX_GCR_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -96,19 +96,19 @@ static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
     }
 
-    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
+    trace_npcm_gcr_read(offset, s->regs[reg]);
 
     return s->regs[reg];
 }
 
-static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
+static void npcm_gcr_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxGCRState *s = opaque;
+    NPCMGCRState *s = opaque;
     uint32_t value = v;
 
-    trace_npcm7xx_gcr_write(offset, value);
+    trace_npcm_gcr_write(offset, value);
 
     if (reg >= NPCM7XX_GCR_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -142,9 +142,9 @@ static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
     s->regs[reg] = value;
 }
 
-static const struct MemoryRegionOps npcm7xx_gcr_ops = {
-    .read       = npcm7xx_gcr_read,
-    .write      = npcm7xx_gcr_write,
+static const struct MemoryRegionOps npcm_gcr_ops = {
+    .read       = npcm_gcr_read,
+    .write      = npcm_gcr_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid      = {
         .min_access_size        = 4,
@@ -155,7 +155,7 @@ static const struct MemoryRegionOps npcm7xx_gcr_ops = {
 
 static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 {
-    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+    NPCMGCRState *s = NPCM_GCR(obj);
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
@@ -165,10 +165,10 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
-static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
+static void npcm_gcr_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    NPCM7xxGCRState *s = NPCM7XX_GCR(dev);
+    NPCMGCRState *s = NPCM_GCR(dev);
     uint64_t dram_size;
     Object *obj;
 
@@ -210,55 +210,65 @@ static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
     s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
 }
 
-static void npcm7xx_gcr_init(Object *obj)
+static void npcm_gcr_init(Object *obj)
 {
-    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+    NPCMGCRState *s = NPCM_GCR(obj);
 
-    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
-                          TYPE_NPCM7XX_GCR, 4 * KiB);
+    memory_region_init_io(&s->iomem, obj, &npcm_gcr_ops, s,
+                          TYPE_NPCM_GCR, 4 * KiB);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static const VMStateDescription vmstate_npcm7xx_gcr = {
-    .name = "npcm7xx-gcr",
-    .version_id = 0,
-    .minimum_version_id = 0,
+static const VMStateDescription vmstate_npcm_gcr = {
+    .name = "npcm-gcr",
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
 };
 
-static const Property npcm7xx_gcr_properties[] = {
-    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
-    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
+static const Property npcm_gcr_properties[] = {
+    DEFINE_PROP_UINT32("disabled-modules", NPCMGCRState, reset_mdlr, 0),
+    DEFINE_PROP_UINT32("power-on-straps", NPCMGCRState, reset_pwron, 0),
 };
 
-static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 {
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
+    dc->realize = npcm_gcr_realize;
+    dc->vmsd = &vmstate_npcm_gcr;
+
+    device_class_set_props(dc, npcm_gcr_properties);
+}
+
+static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
     dc->desc = "NPCM7xx System Global Control Registers";
-    dc->realize = npcm7xx_gcr_realize;
-    dc->vmsd = &vmstate_npcm7xx_gcr;
     rc->phases.enter = npcm7xx_gcr_enter_reset;
 
-    device_class_set_props(dc, npcm7xx_gcr_properties);
 }
 
-static const TypeInfo npcm7xx_gcr_info = {
-    .name               = TYPE_NPCM7XX_GCR,
-    .parent             = TYPE_SYS_BUS_DEVICE,
-    .instance_size      = sizeof(NPCM7xxGCRState),
-    .instance_init      = npcm7xx_gcr_init,
-    .class_init         = npcm7xx_gcr_class_init,
+static const TypeInfo npcm_gcr_info[] = {
+    {
+        .name               = TYPE_NPCM_GCR,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(NPCMGCRState),
+        .instance_init      = npcm_gcr_init,
+        .class_init         = npcm_gcr_class_init,
+        .abstract           = true,
+    },
+    {
+        .name               = TYPE_NPCM7XX_GCR,
+        .parent             = TYPE_NPCM_GCR,
+        .class_init         = npcm7xx_gcr_class_init,
+    },
 };
-
-static void npcm7xx_gcr_register_type(void)
-{
-    type_register_static(&npcm7xx_gcr_info);
-}
-type_init(npcm7xx_gcr_register_type);
+DEFINE_TYPES(npcm_gcr_info)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b9fbcb0924..f2d498e862 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -134,9 +134,9 @@ mos6522_read(uint64_t addr, const char *name, unsigned val) "reg=0x%"PRIx64 " [%
 npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
-# npcm7xx_gcr.c
-npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+# npcm_gcr.c
+npcm_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
 # npcm7xx_mft.c
 npcm7xx_mft_read(const char *name, uint64_t offset, uint16_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 510170471e..2e708471ec 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -89,7 +89,7 @@ struct NPCM7xxState {
     MemoryRegion        ram3;
     MemoryRegion        *dram;
 
-    NPCM7xxGCRState     gcr;
+    NPCMGCRState        gcr;
     NPCM7xxCLKState     clk;
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxADCState     adc;
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9b4998950c..6d3d00d260 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -55,7 +55,7 @@
  */
 #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
 
-struct NPCM7xxGCRState {
+typedef struct NPCMGCRState {
     SysBusDevice parent;
 
     MemoryRegion iomem;
@@ -65,9 +65,10 @@ struct NPCM7xxGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
-};
+} NPCMGCRState;
 
+#define TYPE_NPCM_GCR "npcm-gcr"
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxGCRState, NPCM7XX_GCR)
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
 
 #endif /* NPCM_GCR_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


