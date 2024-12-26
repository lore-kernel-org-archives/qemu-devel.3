Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E2E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9R-0007P5-A4; Thu, 26 Dec 2024 03:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3chJtZwgKCo0DByr5A9yx55x2v.t537v3B-uvCv2454x4B.58x@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9J-0007Jg-Jh
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:17 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3chJtZwgKCo0DByr5A9yx55x2v.t537v3B-uvCv2454x4B.58x@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9H-0000Xr-Th
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:17 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2162259a5dcso136020715ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201394; x=1735806194; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=e0yjpIGSDYAwA98JtHidNici6pMLPUvDd00lZuWT+Lw=;
 b=bGWt9Ts0WHQeum2zXoy+0aQx6j5odjSLdqu5GQUitpNJqRi9Z0js3VMTgfloNHDQ7s
 e/7s2VcNK0hcDtJ8DL+fMzCPXP4P8Ss7mb1uMFT8BReCRahPDt4/Wo1hx/49utTvUqq9
 uMruVr22SivIrH3dtJF5c2wgCjTE8hS8AsJYl7Vk7/JX4hfi3SguUOWAN3SKp/NX1qiO
 mGUoVSqNwmSqLWg9jgeTwVAY5q+w/jAbEZgC0HyVe0RbJUxyGFk7eGOSGMcGFmtUOnkc
 +4+g5hz+VVOztVy8UqqjOcxo0sI8TklLVEln8u+A+5ruoqdAnFuqCEX/Jv2GCcUjV+ZP
 v8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201394; x=1735806194;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0yjpIGSDYAwA98JtHidNici6pMLPUvDd00lZuWT+Lw=;
 b=E6zXG/vRt4L+3JVDsfoYZ6fY+yXRbadW+GVfCSOLwNw6uJ+Q5irxYH/seafMBvUkUQ
 tEkMbwS7vzZ8AlXz1hkxo3cW4xLZe2zLL17YV+MCwd/xei9lGTUljJyz9URozz1DzQPY
 N+LIHgOv8xxg0HcxxxKi3wYAK12OwMKLuVuIs/ZoEQmjLUdvyfIP8CP5pRNV9qHlgUm7
 AI6YwL0DPE8Sxh4y8eOKJ1YpmSj3/OYm6V3cHNIKfliKKVjqdECD5aWRo4Reqe7YdEB0
 R0QrWMUX1/8lgudffOLj7/7LdwF44gs1ZA6SP2+iKRJenYdlrZGhwnCsY8SMAKYmE4wT
 z6Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTnfDKtV7YpglwC+lpPhWoGpVmjb6r6sR6FlDmZ+FPLfGAQQtGuwwJrT8NIfTJMhulwKKtNfWNLjy7@nongnu.org
X-Gm-Message-State: AOJu0Yxgd4+GgQNCSiNGEiHAVrk5O6OAJr+dBWAyppc5t4PlPbKJvxIN
 ga7xkdsVKd1p7uDKnOpsR0hBGiW6+l6zh8pkzvYngh6XzxNump2Y3+R4UaMRSwwWB5v7DXWKfW+
 8/XhLFwnxlQ==
X-Google-Smtp-Source: AGHT+IHNdT4TkdBw2hK4mA73MQSwuM2FL3ZBKD3wQVSnhYRKb5nYmSS/l3Y8XXMLeHiYwR7WxG2MwYBmJJXIBA==
X-Received: from pgbbw29.prod.google.com ([2002:a05:6a02:49d:b0:801:d768:c174])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2285:b0:215:3661:747e with SMTP id
 d9443c01a7336-219e6e8bb0amr304870645ad.8.1735201394173; 
 Thu, 26 Dec 2024 00:23:14 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:26 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-8-wuhaotsh@google.com>
Subject: [PATCH 07/17] hw/misc: Add nr_regs and cold_reset_values to NPCM GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3chJtZwgKCo0DByr5A9yx55x2v.t537v3B-uvCv2454x4B.58x@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

These 2 values are different between NPCM7XX and NPCM8XX
GCRs. So we add them to the class and assign different values
to them.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 24 +++++++++++++++---------
 include/hw/misc/npcm_gcr.h | 13 +++++++++++--
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 0959f2e5c4..295073ba14 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -69,7 +69,7 @@ enum NPCM7xxGCRRegisters {
     NPCM7XX_GCR_REGS_END,
 };
 
-static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
     [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
     [NPCM7XX_GCR_SPSWC]         = 0x00000003,
@@ -88,8 +88,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
 
-    if (reg >= NPCM7XX_GCR_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -106,11 +107,12 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
     uint32_t value = v;
 
-    trace_npcm_gcr_write(offset, value);
+    trace_npcm_gcr_write(offset, v);
 
-    if (reg >= NPCM7XX_GCR_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -156,10 +158,10 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
 static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 {
     NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
     s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
     s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
@@ -224,7 +226,7 @@ static const VMStateDescription vmstate_npcm_gcr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -238,7 +240,6 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
     dc->realize = npcm_gcr_realize;
     dc->vmsd = &vmstate_npcm_gcr;
 
@@ -247,13 +248,17 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 {
+    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM_GCR_MAX_NR_REGS);
     QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
     dc->desc = "NPCM7xx System Global Control Registers";
     rc->phases.enter = npcm7xx_gcr_enter_reset;
 
+    c->nr_regs = NPCM7XX_GCR_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
@@ -262,6 +267,7 @@ static const TypeInfo npcm_gcr_info[] = {
         .parent             = TYPE_SYS_BUS_DEVICE,
         .instance_size      = sizeof(NPCMGCRState),
         .instance_init      = npcm_gcr_init,
+        .class_size         = sizeof(NPCMGCRClass),
         .class_init         = npcm_gcr_class_init,
         .abstract           = true,
     },
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 6d3d00d260..9af24e5cdc 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -18,6 +18,7 @@
 
 #include "exec/memory.h"
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 /*
  * NPCM7XX PWRON STRAP bit fields
@@ -53,6 +54,7 @@
  * Number of registers in our device state structure. Don't change this without
  * incrementing the version_id in the vmstate.
  */
+#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
 #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
 
 typedef struct NPCMGCRState {
@@ -60,15 +62,22 @@ typedef struct NPCMGCRState {
 
     MemoryRegion iomem;
 
-    uint32_t regs[NPCM7XX_GCR_NR_REGS];
+    uint32_t regs[NPCM_GCR_MAX_NR_REGS];
 
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
 } NPCMGCRState;
 
+typedef struct NPCMGCRClass {
+    SysBusDeviceClass parent;
+
+    size_t nr_regs;
+    const uint32_t *cold_reset_values;
+} NPCMGCRClass;
+
 #define TYPE_NPCM_GCR "npcm-gcr"
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
+OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
 
 #endif /* NPCM_GCR_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


