Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23315C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6x-0005tz-Dd; Thu, 06 Feb 2025 17:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yzOlZwgKCgw86tm054ts00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6p-0005lM-8T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:31 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yzOlZwgKCgw86tm054ts00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6n-0001Tu-5I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:30 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so2757587a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879947; x=1739484747; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=os2VRvm8dcEj0pbDL7mJZonO8xIs20XXxswKtdErcUY=;
 b=tISbMK+xkOtri6kJ6ucMc0MnlJhXD5P2j7z1wGVqq4mgFFuVHYMdrQgqvLaskd6jf4
 PcUwkX1DLcLgHjMGcsrh5JIZOZtwUUGmBExeTiX3ZqKpdLZcmkx6y8A4DJPinMYDW43L
 oUjYhKRCVTfLBdzC+JXLp//3USSOccKINT72Z0/lIzsrikgi21A4soFhu9QzwS/GLroK
 ek5u5EeOuIa5ZZHR8l6yvWPOOMzWpD6qlrT7Mb2/5WjoEV17fQG2GCw6w4Wz4Ge1iMEC
 EA0H+qxOmiZO9HhoDWN9TDXnkppy1KdVkCbeL6rNu2KPWtkawZ5To4mII8HXFk3ljIfm
 nb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879947; x=1739484747;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=os2VRvm8dcEj0pbDL7mJZonO8xIs20XXxswKtdErcUY=;
 b=NndPXKqaWcHqi3ej/W/OTxv+P/q8TRSJriPpVikJx92JRYoxbh/rH7AByyAic6M8eE
 dQ2pVR0+S3L1WZNNTcQaHATR5dA+LOcRi9R8g2F65kFBdA0DTCaLZfzgMQItQrboNwR6
 nO+kjIaKsjm4SSygZzL+vAbDoOXOrHabrwH8cEL3p7LSIaDfMTeMEIahA/EAD6vK6F2W
 ttYmW0JWLASkqP1RrQ9uYIJABmeLjLcuvTa8Bn0rlZ5kM7aRSA5ic7lRIGK9BA0kJjWX
 KArGDYdC0iYVZF7nKtCnUwkMaIPGgUyxxaQv+8l8Y1vU1T6v3iJNKa/iX9ha4mbFZfTu
 l0lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWpqRzc4ru6hgYcZT/APkPWTJRXehpyONdeHH6irJQ9Fuzbj7TcSkvr0mYZdG427QEWfjPDy6ycKzm@nongnu.org
X-Gm-Message-State: AOJu0Yx1i7JfUCUXt6dPqyUmlTXlMSg6dq+lZbXjok5x4hXYCWStAkuG
 e4ExmMF49dCSXYBabsWHDHTOFPCiC0roBcw6neDbqMPzixwp9UeVsp464NmD3s2EfdAOkzbzzRO
 IuPJAQ5LHtQ==
X-Google-Smtp-Source: AGHT+IEDcsZweU69MeiUalJ4mR9WLruYCwCzwRM87q+yrQgJos1w9rRyr64ew0czJfBeA7bUhfeyKd4c8EhGRw==
X-Received: from pjbmn8.prod.google.com ([2002:a17:90b:1888:b0:2ef:7af4:5e8e])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38c3:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2fa2416703fmr1299033a91.18.1738879947306; 
 Thu, 06 Feb 2025 14:12:27 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:58 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-13-wuhaotsh@google.com>
Subject: [PATCH v4 12/17] hw/misc: Add nr_regs and cold_reset_values to NPCM
 CLK
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3yzOlZwgKCgw86tm054ts00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--wuhaotsh.bounces.google.com;
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
index d644d7ddd5..5930a88f28 100644
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
2.48.1.502.g6dc24dfdaf-goog


