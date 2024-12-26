Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2256FE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjET-0003gW-4y; Thu, 26 Dec 2024 03:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qhNtZwgKCsc97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tQjEM-0002yj-HY
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:30 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qhNtZwgKCsc97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tQjEK-0001Bj-C4
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:30 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2162f80040aso71073365ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201706; x=1735806506; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiRo5raG/ykEW6v5ck/8cMpgDmuEWhEdPQmIu7j9JY=;
 b=OVXpIMIeOqXOzmi/hSYVPz+Irf9Ap+Kh8z4qRzFoOM99gpt2jdghqxxL+EAIegy6RJ
 ew4pmq9rElPn8IDCzAv7j1opZ6K822KXeM+8th4meRjMpSV82WivQAQptB5PRO2Oyctj
 sFfD+jA4Bn+7KO/YEzVqT36eBUhrHHycdHk0Nno2nuVxcw8r/PRhMy/fi6cK8tlizcL0
 JORouqDiDFpz+IBoYvZgszFHLza1rGJ56CZjbQFHggNzud60FKqwojYiMPLjrVf2durv
 0LzmP08JD0Gxw0LbkJ3AYYKYGVbyDat21Gd9OihHgVXxyOXRf/Uv21C//G+R2kzFEdMF
 Xoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201706; x=1735806506;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiRo5raG/ykEW6v5ck/8cMpgDmuEWhEdPQmIu7j9JY=;
 b=ZQ5kccVNG4F0ff72L/ru3vB5Wz4a3xQBFyx9VmIfED2mHS+YumqbeNYas3ZaH+s6x5
 9zmJt4YLhIOzRlSQ7vjCkOiwFqcj5vvJG3P2AaB9nqPRh6U8/cB3jyZYaRckq/IIL9IJ
 fi1i6yvpPpQARS1NqlIKDYSYrk6AIzYS0g7O69Fdg3XFC3RS9d451VrS6Hdy7VdqBWyn
 ozX7aNwaUvTWV7UCC8p2B/qcmOUVqJ+Aoy6KWWSlRjaiC4n6mWOW+w+lh7nfFNYhOcLo
 X3vSSZLXzhBivrAX9b5VOIBDXuRtFc1OvG0SXQTjEgOXwdQPTasSwtZuhL8NRL6ZWQzR
 xK9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVmDSZV4FKfQO+gFs29VJj2f+RuyedVi67iDtn8aUjhAQF2cZDm05+tvgVCV4zQbtpyc9ISPgvfwC7@nongnu.org
X-Gm-Message-State: AOJu0YzbwdznNyOvW+v7C0zHAWsMRntLX7cBIW0WPdQKXuC6A51Kaol+
 6cE9+8LSXiwPb/zFj6eneNtDEKmx/SmFbdBs6mI2dZEv+8BRT+IaOfcxwaktJcX0MDSNt4uzor9
 jw12ccnllFg==
X-Google-Smtp-Source: AGHT+IEmj3GPmQBTzL/iAxTCDy+YAB2U4bP/K4mR8jNmq535VhXUn84BMZN1mfoBkP3QXOS7pGw80SJlDUIuZA==
X-Received: from plbkw6.prod.google.com ([2002:a17:902:f906:b0:216:2d2a:d873])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:244b:b0:216:34e5:6e49 with SMTP id
 d9443c01a7336-219e70dd211mr298005215ad.57.1735201706216; 
 Thu, 26 Dec 2024 00:28:26 -0800 (PST)
Date: Thu, 26 Dec 2024 08:27:49 +0000
In-Reply-To: <20241226082800.2887689-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082800.2887689-7-wuhaotsh@google.com>
Subject: [PATCH v2 06/17] hw/misc: Move NPCM7XX GCR to NPCM GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3qhNtZwgKCsc97un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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


