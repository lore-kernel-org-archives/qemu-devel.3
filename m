Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68FC02192
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkW-0005NC-77; Wed, 05 Feb 2025 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35hCkZwgKCtsTRE7LQPEDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjz-0005Db-JA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:40 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35hCkZwgKCtsTRE7LQPEDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjt-0006ti-Lu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:37 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso1034547a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805479; x=1739410279; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OJLcL1TFcbdFCkelDrA7+/R0LkvTkjIj9dXkUSOlZkI=;
 b=OTA9/mZ4EowO6upeVL27BpZsTEEN15Ctr4Kru0+olfYwUAzHx/K4+JV2Mc4g4MBpPZ
 xOzgGHawzzElsdJCeI1wroVsOF41QhpVoTTUcdWdLJZbW/3kFaKZxJM2NVjkWrTpKMDW
 s6z8sztsbB0cdZ4ZRa8eEla6R+Rg024uPfs2IVoGZ000v+ERxeea79fVTHFVUajDffLn
 Q+jnP9cam+MrlNtd5OgQAaEparRYaNc8wBWl4MykzaEqcpuxIEksNvcdQ33bPwrTVd95
 ej0UMF59s4gCh3x2evThALBuJdBHgMP6Aw0+tAAEtOdQc4yJ6zMhfLEt3Uxoxpc3Xehh
 uh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805479; x=1739410279;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJLcL1TFcbdFCkelDrA7+/R0LkvTkjIj9dXkUSOlZkI=;
 b=XzCrHxm1lINABPsI8XrqkHpwWc26a9XZYTsUaj2k+UDB84aIl8s69rQXtnIxwQdb3w
 Bizz5fTBFLvZ6VkdZRxRh9EkZ8DLJr6Xo4/vCEpVS3fNAT23jiAVY2DX+SpvFjbdEBJw
 p5XGHfnNyznd3XwDTZsVXPy8H/anVDWpgX97orWm5D/rkaTJGZETIQ3Ktqgf5t9bf9SA
 8eh4A93hmhyBRnJe0m11ZFkb7PVa7e9KHDA+PpDi+sbWAH2Rxij42kxARV0uCyZkDPtq
 7bRvHc/RFrz+QvMlQw9rMmv4YNfug0W33ah7BotJSN064GdUA7FsVg10ZA9W2qBN4uT2
 dNUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB3Sr4xsI0SbYX2J3r6zgo8uHBjRlo3D/XBGhjKYsNfirZRVB3pYvmWqQ1JCParFfJ9YU9k2wgwLI7@nongnu.org
X-Gm-Message-State: AOJu0YyQkpxs8LKRYgoN+yLE7nJTlj/QQPFrxmagwArJGo8PKExQwUFQ
 l280f889yuyWrRfTKdRgdzg1kDxmEgkA1pXPWElJ5UuCYCWzMOmhZ9FiUpDVCKRNVY6QQwGSVrb
 AtCDTHlTirg==
X-Google-Smtp-Source: AGHT+IF6vKCOwWgvX0qr94H0Whid6RJncD3YCRMFMxfQZ4Z7wYV3zo582n07G4fuKzMK4EJfODOKSDKDhDZvOw==
X-Received: from pgb12.prod.google.com ([2002:a05:6a02:340c:b0:7fd:49b7:10f7])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d705:b0:1e0:cf39:846a with SMTP id
 adf61e73a8af0-1ede88ab90amr9725757637.29.1738805478933; 
 Wed, 05 Feb 2025 17:31:18 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:53 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-6-wuhaotsh@google.com>
Subject: [PATCH v3 05/17] hw/misc: Move NPCM7XX GCR to NPCM GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=35hCkZwgKCtsTRE7LQPEDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index b35b0e77f7..0f7204a237 100644
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
2.48.1.362.g079036d154-goog


