Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D455EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6x-0005tv-Ax; Thu, 06 Feb 2025 17:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wTOlZwgKCgIywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6h-0005da-8j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:26 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wTOlZwgKCgIywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6d-0001R1-1N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:20 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-216430a88b0so31178515ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879937; x=1739484737; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IvP54eDjsC367WmbzkmPSQcGqsW89VifxXa9QXW/jdM=;
 b=mbizO04fcuXP2PXlo1iTuxoj/wVzvqEivrEL4LrPM/1WkoutT+/I8lbsSzc7ilRux8
 Ofjfh9Z3hVz89Pu4mwFJO9YcABbHMoD0Zu5zNLsb3Yu6tl7NbsIoT6v22Od7mwmOyNat
 xmSQAgqwckX57XgQO7RExtxRkbiLXaRidHDBx5kdq+I98vl0Z0uHAFwS0TmhJtHxBSP+
 9kBx/UkPD3RQ/bsl/bXCEdYW/Aw/gmPLUaMpSdkkqlwADJ/BGmmUd8SUccOvfFK1U0kS
 +H/8vRE9fqjDy3h7u0EGewaL8HjI0Z8mhcWEfAo79jRLURaMSeAyJH34fw6EoSoDze8H
 V4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879937; x=1739484737;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IvP54eDjsC367WmbzkmPSQcGqsW89VifxXa9QXW/jdM=;
 b=bn3vULQGRoxVyOZkp9gmfvhiohx5ZC+W2wK+vth99OVl3E/nJZ7DPrPCqhutoQwpzN
 Ls4UF74z5+dChCkQkm+mqomNqnE28hkSznJ9q7SyoBti7JWSKT9c3tkO115oH0LOak7r
 yg+Wu6CAqlBoB+GWDlL/m9vvoQXjX7lgnY0vkCK5fnOXDLaKhTIeUKMHmBYSI0dVQBy4
 64v4hZ+QUDltNqWhqWRxPV4sF9nmrXSsTDroHQiG2hKjeTUAo/UdIfsm2P/JT8reAIhJ
 JAZnP9TlIfP5H3JVgRDXtiyBEywF5T+6VkAvnKqJ6iCe9VePGVFibA61UL33D2b58JKJ
 cmKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDPauooW9+FkLFtXJhp9Au9Ex8FhRLSqke7hNcVERXILlGIgFDJf1r+dy/ts6loxf2ishZ6AxcOZUJ@nongnu.org
X-Gm-Message-State: AOJu0YwmeipNxENZApalHhn8W3p4KeYJxn65vbqL88KbiYH90tmHZfdP
 dZeO6nLAof/vMsOrkGWD4prQd/QlX9obcIHsxgB2d/a1Gu4Yc56XalqQLcB9mwkN68xQ+fj1heK
 dLy9fCmfv3g==
X-Google-Smtp-Source: AGHT+IFMDAgl7TKKNuJS6kizzV3LA6n4lkhLIh1K5CG4qU0yGeD+jGsog0yWdgxcLGXuF5l0EJ+YLhREvQe1Ag==
X-Received: from pgev18.prod.google.com ([2002:a63:ac12:0:b0:abb:a12f:81a8])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:68c:b0:1db:e3c7:9974 with SMTP id
 adf61e73a8af0-1ee03a3f22emr1889105637.12.1738879937125; 
 Thu, 06 Feb 2025 14:12:17 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:52 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-7-wuhaotsh@google.com>
Subject: [PATCH v4 06/17] hw/misc: Add nr_regs and cold_reset_values to NPCM
 GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3wTOlZwgKCgIywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 27 ++++++++++++++++-----------
 include/hw/misc/npcm_gcr.h | 13 +++++++++++--
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 0959f2e5c4..d89e8c2c3b 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -66,10 +66,9 @@ enum NPCM7xxGCRRegisters {
     NPCM7XX_GCR_SCRPAD          = 0x013c / sizeof(uint32_t),
     NPCM7XX_GCR_USB1PHYCTL,
     NPCM7XX_GCR_USB2PHYCTL,
-    NPCM7XX_GCR_REGS_END,
 };
 
-static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
     [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
     [NPCM7XX_GCR_SPSWC]         = 0x00000003,
@@ -88,8 +87,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
 
-    if (reg >= NPCM7XX_GCR_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -106,11 +106,12 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
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
@@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
 static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 {
     NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+    g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values));
+    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
     s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
     s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
@@ -224,7 +227,7 @@ static const VMStateDescription vmstate_npcm_gcr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -238,7 +241,6 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
     dc->realize = npcm_gcr_realize;
     dc->vmsd = &vmstate_npcm_gcr;
 
@@ -247,13 +249,15 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 {
+    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
     dc->desc = "NPCM7xx System Global Control Registers";
     rc->phases.enter = npcm7xx_gcr_enter_reset;
 
+    c->nr_regs = NPCM7XX_GCR_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
@@ -262,6 +266,7 @@ static const TypeInfo npcm_gcr_info[] = {
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
2.48.1.502.g6dc24dfdaf-goog


