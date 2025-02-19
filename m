Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB6C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp6Q-0003L4-TG; Wed, 19 Feb 2025 13:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Eye2ZwgKCn4ywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5s-00034W-Oy
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:48 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Eye2ZwgKCn4ywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5q-0004nG-TU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:48 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-221063a808dso822685ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990804; x=1740595604; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ipQdIA04T744C2J6dFE/7rZXfs1YEtRcQyXL2+84upE=;
 b=dPyqvAKwGrvQdrc0IEnvRYuYvFchCC/X9Uqo9yWMCAzrSSmC3rjNyCTtUIrm0IoNC6
 Ji8+nYniwCseSLcggEUS2gVBhI66xcDTKdq4OEglg6hCZX3/aYoZd+0+S2BNljKOfgt1
 733lL6F9WjQbJGhZcZEOgCKaJ3+bdLAGrAJm3U8gZnFqJ3MT6JpPg4AGgG1QhPtYWTw2
 WJAFkj1wPeqjHWIjaHoP1oR9zVYkzkQD41R9uSmgIqgAcwyl+WXjKx7DadbzCwE1J1FS
 1UZbbJAZTFGqhr2jFOW772N3aqEJe7SKBp0Tx4ByssmuJ0y1Vq07wP58yb3yeCby+vGD
 H0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990804; x=1740595604;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ipQdIA04T744C2J6dFE/7rZXfs1YEtRcQyXL2+84upE=;
 b=Dc+DbUH8zLtvzI0C+1ebp9d7d4h6HScHVaANup0joN3JhKCmT/j5SmmlwaYlVOr1xP
 LDoi+lQr2Lofhef7ubIscePctey5KTzbskGdXyKmzvhuZf4/stQfbl4/G4I9pL+e42Rx
 ft+YfcODBG6oZDbIvszVmIQkb2Qievk002ZRLqz4dDTZNKoIqbbOP/oOij3xqXglRfKQ
 eQWaOBZm1EqgzwQ1FlTUmFgV+7l+wiuST1My4WQ40cEfYOGKZHqqAG3U92drgUhgtQJV
 EW4AXmX2fdn5SHulEJ7jHKMewV75dHEDsTdV3GoHuei++4Rvc+OyOGSOlHJLhXZOhmIr
 djqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhan4hGQqqx7GAQLGliFr44iFNQjah8UBN0lrL5YWaou6zDU2EgTblJlwkkhdLExql4+GHfelktV68@nongnu.org
X-Gm-Message-State: AOJu0YyKaE4jGSnJcY25bANudPNDqYxqrY623skuS0feXveJPU9szTNe
 HLMOvPoKP13+UYU1viRMCn6gVQtdn6rXnGzic2H25an2LFH/W0Vbi7dZlglDVKwBX+pGWmkAr6r
 Y0QYDPpCwrQ==
X-Google-Smtp-Source: AGHT+IG99PH2ax94yfuBilzKm8HRV5XZiorZUZw9Ps8m+LMoYNchAAQ3xKZ2ErtYebNkzvzhxL1Y3oNgmRlwYQ==
X-Received: from pjbpl7.prod.google.com ([2002:a17:90b:2687:b0:2f4:4222:ebba])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e841:b0:21f:860:6d0d with SMTP id
 d9443c01a7336-22103efb488mr324146705ad.5.1739990803946; 
 Wed, 19 Feb 2025 10:46:43 -0800 (PST)
Date: Wed, 19 Feb 2025 10:46:03 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-13-wuhaotsh@google.com>
Subject: [PATCH v5 12/17] hw/misc: Add nr_regs and cold_reset_values to NPCM
 CLK
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Eye2ZwgKCn4ywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com;
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

These 2 values are different between NPCM7XX and NPCM8XX
CLKs. So we add them to the class and assign different values
to them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_clk.c         | 18 ++++++++++++------
 hw/misc/npcm_gcr.c         |  2 ++
 include/hw/misc/npcm_clk.h |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 0ecf0df3bb..78144b14e3 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -81,7 +81,7 @@ enum NPCM7xxCLKRegisters {
  * All are loaded on power-up reset. CLKENx and SWRSTR should also be loaded on
  * core domain reset, but this reset type is not yet supported by QEMU.
  */
-static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
     [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
     [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
     [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
@@ -728,10 +728,11 @@ static uint64_t npcm_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     int64_t now_ns;
     uint32_t value = 0;
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -776,11 +777,12 @@ static void npcm_clk_write(void *opaque, hwaddr offset,
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     uint32_t value = v;
 
     trace_npcm_clk_write(offset, value);
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -870,10 +872,10 @@ static const struct MemoryRegionOps npcm_clk_ops = {
 static void npcm_clk_enter_reset(Object *obj, ResetType type)
 {
     NPCMCLKState *s = NPCM_CLK(obj);
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
+    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
     s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     npcm7xx_clk_update_all_clocks(s);
     /*
@@ -1045,11 +1047,14 @@ static void npcm_clk_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
 {
+    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
+    c->nr_regs = NPCM7XX_CLK_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm7xx_clk_pll_info = {
@@ -1081,6 +1086,7 @@ static const TypeInfo npcm_clk_info = {
     .parent             = TYPE_SYS_BUS_DEVICE,
     .instance_size      = sizeof(NPCMCLKState),
     .instance_init      = npcm_clk_init,
+    .class_size         = sizeof(NPCMCLKClass),
     .class_init         = npcm_clk_class_init,
     .abstract           = true,
 };
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index ec16ea620e..4e8ce2cb89 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -215,6 +215,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
         break;
 
     case 8:
+        g_assert(!(reg & 1));
         value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
         break;
 
@@ -270,6 +271,7 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
         break;
 
     case 8:
+        g_assert(!(reg & 1));
         s->regs[reg] = value;
         s->regs[reg + 1] = extract64(v, 32, 32);
         break;
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index db03b46a52..f47614ac8d 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -175,8 +175,15 @@ struct NPCMCLKState {
     Clock *clkref;
 };
 
+typedef struct NPCMCLKClass {
+    SysBusDeviceClass parent;
+
+    size_t nr_regs;
+    const uint32_t *cold_reset_values;
+} NPCMCLKClass;
+
 #define TYPE_NPCM_CLK "npcm-clk"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCMCLKState, NPCM_CLK)
+OBJECT_DECLARE_TYPE(NPCMCLKState, NPCMCLKClass, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 
 #endif /* NPCM_CLK_H */
-- 
2.48.1.601.g30ceb7b040-goog


