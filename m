Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0108C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA70-0005wu-Ft; Thu, 06 Feb 2025 17:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yTOlZwgKCgo64rky32rqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6p-0005m4-Mo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:31 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yTOlZwgKCgo64rky32rqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6m-0001TN-B8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:31 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f9fbe0215bso3131006a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879945; x=1739484745; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zBpjYL6IlWLXjQc6w70AFHTaTlKisjuS9YTCNzjfWbI=;
 b=FWtxWGbEVHfaa+Mjeqmslv20Rc2dAk5lh9Capmre3pMBuUx9XRX/P9Ivl91uqbi54m
 8sUM67RPoIsZeQBSwAC0cKJ6VbE272oIxPTr1wtS3vbbn5zal3sLT4KW69Dsgyv4kXAW
 x06ObjggrHal2SJsFlC9l/ZzZNL07SwujFiQ4itDNrdIT4hBELHsphbpIxP2it8wOP3h
 plxaVLJZOaywrFg90OYmT1ce1o2cKWsholCZqbHiNNtbIFN/DXXSjUAyX0CXKvahgQye
 uAPRv2GPbg9l4WE9ER065V4vpSl8F8EVejt/TiTbg0oV+AVJ3FOkPtT0mMW4N1N2QAq5
 bNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879945; x=1739484745;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBpjYL6IlWLXjQc6w70AFHTaTlKisjuS9YTCNzjfWbI=;
 b=XlEopKeNQ5Kg5N9968D25STIBoobuI6Yw6eBwF4F3WnBz0Vb2HBlJzwIUZl+AZRy5y
 fnf+C9kuCO1opZkgCRm1tYFBBVoouJ0jjeMNpzADdUVEolgIwKHgi0w1uaJVMri7P0t5
 nPXPOMM+i528N2NzV+RIpTcQJbkBpp2MrId2Mt4jWc8np6VbZ+j17fTGBn1KPAE+ZpLi
 1Suu9pTDOMTleBT6VoA1bWoZzp/p1AgGA7APW1vdwI8KK8DSeKuR67h01dYZr5kQKUD2
 ChcHsUyr5Eh3JS4F7/HnCZtZLp68b7O0atxbfAiozNrRY+dHKAAoDeXrAqJ+Mloy4D+Y
 IkoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsMffUQS4ceOJYIvIBIlsRnE+rgfFzAyPUzEu6XULVIeqE4mml0VuLHNKRRtyktdLQ18VuScOQEqOM@nongnu.org
X-Gm-Message-State: AOJu0Yw3BNd7sdhfnNelX7tqKfzWt4Xz1+YhIUjzcFZRS9ozhLt7F49M
 YrvnHIHYdycETYM/jl2ESHira4dD1f5UmUn+l4AvlX270hlnBmMg0o3wDYBq++AX6ggVT0gIFU4
 eDIEeNqBM+Q==
X-Google-Smtp-Source: AGHT+IF//79HNvIoFTRMbAxThsiD2udMp3I4eUYYKSW1lykgx7EYuk03+NYpIU1aqxwXKM9anuDZ4Z77vu1iuQ==
X-Received: from pjbpb13.prod.google.com ([2002:a17:90b:3c0d:b0:2f8:4a3f:dd56])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33cf:b0:2ee:9d36:6821 with SMTP id
 98e67ed59e1d1-2fa243e0b96mr1049336a91.27.1738879945589; 
 Thu, 06 Feb 2025 14:12:25 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:57 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-12-wuhaotsh@google.com>
Subject: [PATCH v4 11/17] hw/misc: Move NPCM7XX CLK to NPCM CLK
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3yTOlZwgKCgo64rky32rqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--wuhaotsh.bounces.google.com;
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

A lot of NPCM7XX and NPCM8XX CLK modules share the same code,
this commit moves the NPCM7XX CLK to NPCM CLK for these
properties.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_clk.c         | 106 +++++++++++++++++++++----------------
 hw/misc/trace-events       |   6 +--
 include/hw/arm/npcm7xx.h   |   2 +-
 include/hw/misc/npcm_clk.h |  22 ++++----
 4 files changed, 76 insertions(+), 60 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 2bcb731099..0ecf0df3bb 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -198,7 +198,7 @@ static NPCM7xxClockPLL find_pll_by_reg(enum NPCM7xxCLKRegisters reg)
     }
 }
 
-static void npcm7xx_clk_update_all_plls(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_plls(NPCMCLKState *clk)
 {
     int i;
 
@@ -207,7 +207,7 @@ static void npcm7xx_clk_update_all_plls(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_sels(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_sels(NPCMCLKState *clk)
 {
     int i;
 
@@ -216,7 +216,7 @@ static void npcm7xx_clk_update_all_sels(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_dividers(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_dividers(NPCMCLKState *clk)
 {
     int i;
 
@@ -225,7 +225,7 @@ static void npcm7xx_clk_update_all_dividers(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_clocks(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_clocks(NPCMCLKState *clk)
 {
     clock_update_hz(clk->clkref, NPCM7XX_CLOCK_REF_HZ);
     npcm7xx_clk_update_all_plls(clk);
@@ -635,7 +635,7 @@ static void npcm7xx_clk_divider_init(Object *obj)
 }
 
 static void npcm7xx_init_clock_pll(NPCM7xxClockPLLState *pll,
-        NPCM7xxCLKState *clk, const PLLInitInfo *init_info)
+        NPCMCLKState *clk, const PLLInitInfo *init_info)
 {
     pll->name = init_info->name;
     pll->clk = clk;
@@ -647,7 +647,7 @@ static void npcm7xx_init_clock_pll(NPCM7xxClockPLLState *pll,
 }
 
 static void npcm7xx_init_clock_sel(NPCM7xxClockSELState *sel,
-        NPCM7xxCLKState *clk, const SELInitInfo *init_info)
+        NPCMCLKState *clk, const SELInitInfo *init_info)
 {
     int input_size = init_info->input_size;
 
@@ -664,7 +664,7 @@ static void npcm7xx_init_clock_sel(NPCM7xxClockSELState *sel,
 }
 
 static void npcm7xx_init_clock_divider(NPCM7xxClockDividerState *div,
-        NPCM7xxCLKState *clk, const DividerInitInfo *init_info)
+        NPCMCLKState *clk, const DividerInitInfo *init_info)
 {
     div->name = init_info->name;
     div->clk = clk;
@@ -683,7 +683,7 @@ static void npcm7xx_init_clock_divider(NPCM7xxClockDividerState *div,
     }
 }
 
-static Clock *npcm7xx_get_clock(NPCM7xxCLKState *clk, ClockSrcType type,
+static Clock *npcm7xx_get_clock(NPCMCLKState *clk, ClockSrcType type,
         int index)
 {
     switch (type) {
@@ -700,7 +700,7 @@ static Clock *npcm7xx_get_clock(NPCM7xxCLKState *clk, ClockSrcType type,
     }
 }
 
-static void npcm7xx_connect_clocks(NPCM7xxCLKState *clk)
+static void npcm7xx_connect_clocks(NPCMCLKState *clk)
 {
     int i, j;
     Clock *src;
@@ -724,10 +724,10 @@ static void npcm7xx_connect_clocks(NPCM7xxCLKState *clk)
     }
 }
 
-static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t npcm_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxCLKState *s = opaque;
+    NPCMCLKState *s = opaque;
     int64_t now_ns;
     uint32_t value = 0;
 
@@ -766,19 +766,19 @@ static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
         break;
     };
 
-    trace_npcm7xx_clk_read(offset, value);
+    trace_npcm_clk_read(offset, value);
 
     return value;
 }
 
-static void npcm7xx_clk_write(void *opaque, hwaddr offset,
+static void npcm_clk_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxCLKState *s = opaque;
+    NPCMCLKState *s = opaque;
     uint32_t value = v;
 
-    trace_npcm7xx_clk_write(offset, value);
+    trace_npcm_clk_write(offset, value);
 
     if (reg >= NPCM7XX_CLK_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -842,7 +842,7 @@ static void npcm7xx_clk_write(void *opaque, hwaddr offset,
 static void npcm7xx_clk_perform_watchdog_reset(void *opaque, int n,
         int level)
 {
-    NPCM7xxCLKState *clk = NPCM7XX_CLK(opaque);
+    NPCMCLKState *clk = NPCM_CLK(opaque);
     uint32_t rcr;
 
     g_assert(n >= 0 && n <= NPCM7XX_NR_WATCHDOGS);
@@ -856,9 +856,9 @@ static void npcm7xx_clk_perform_watchdog_reset(void *opaque, int n,
     }
 }
 
-static const struct MemoryRegionOps npcm7xx_clk_ops = {
-    .read       = npcm7xx_clk_read,
-    .write      = npcm7xx_clk_write,
+static const struct MemoryRegionOps npcm_clk_ops = {
+    .read       = npcm_clk_read,
+    .write      = npcm_clk_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid      = {
         .min_access_size        = 4,
@@ -867,9 +867,9 @@ static const struct MemoryRegionOps npcm7xx_clk_ops = {
     },
 };
 
-static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
+static void npcm_clk_enter_reset(Object *obj, ResetType type)
 {
-    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+    NPCMCLKState *s = NPCM_CLK(obj);
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
@@ -882,7 +882,7 @@ static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
      */
 }
 
-static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
+static void npcm7xx_clk_init_clock_hierarchy(NPCMCLKState *s)
 {
     int i;
 
@@ -918,19 +918,19 @@ static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
     clock_update_hz(s->clkref, NPCM7XX_CLOCK_REF_HZ);
 }
 
-static void npcm7xx_clk_init(Object *obj)
+static void npcm_clk_init(Object *obj)
 {
-    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+    NPCMCLKState *s = NPCM_CLK(obj);
 
-    memory_region_init_io(&s->iomem, obj, &npcm7xx_clk_ops, s,
-                          TYPE_NPCM7XX_CLK, 4 * KiB);
+    memory_region_init_io(&s->iomem, obj, &npcm_clk_ops, s,
+                          TYPE_NPCM_CLK, 4 * KiB);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static int npcm7xx_clk_post_load(void *opaque, int version_id)
+static int npcm_clk_post_load(void *opaque, int version_id)
 {
     if (version_id >= 1) {
-        NPCM7xxCLKState *clk = opaque;
+        NPCMCLKState *clk = opaque;
 
         npcm7xx_clk_update_all_clocks(clk);
     }
@@ -938,10 +938,10 @@ static int npcm7xx_clk_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void npcm7xx_clk_realize(DeviceState *dev, Error **errp)
+static void npcm_clk_realize(DeviceState *dev, Error **errp)
 {
     int i;
-    NPCM7xxCLKState *s = NPCM7XX_CLK(dev);
+    NPCMCLKState *s = NPCM_CLK(dev);
 
     qdev_init_gpio_in_named(DEVICE(s), npcm7xx_clk_perform_watchdog_reset,
             NPCM7XX_WATCHDOG_RESET_GPIO_IN, NPCM7XX_NR_WATCHDOGS);
@@ -996,15 +996,15 @@ static const VMStateDescription vmstate_npcm7xx_clk_divider = {
     },
 };
 
-static const VMStateDescription vmstate_npcm7xx_clk = {
-    .name = "npcm7xx-clk",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = npcm7xx_clk_post_load,
+static const VMStateDescription vmstate_npcm_clk = {
+    .name = "npcm-clk",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .post_load = npcm_clk_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCM7xxCLKState, NPCM7XX_CLK_NR_REGS),
-        VMSTATE_INT64(ref_ns, NPCM7xxCLKState),
-        VMSTATE_CLOCK(clkref, NPCM7xxCLKState),
+        VMSTATE_UINT32_ARRAY(regs, NPCMCLKState, NPCM_CLK_MAX_NR_REGS),
+        VMSTATE_INT64(ref_ns, NPCMCLKState),
+        VMSTATE_CLOCK(clkref, NPCMCLKState),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -1033,17 +1033,23 @@ static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_npcm7xx_clk_divider;
 }
 
-static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+static void npcm_clk_class_init(ObjectClass *klass, void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM7XX_CLK_NR_REGS);
+    dc->vmsd = &vmstate_npcm_clk;
+    dc->realize = npcm_clk_realize;
+    rc->phases.enter = npcm_clk_enter_reset;
+}
+
+static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
+    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
+    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
-    dc->vmsd = &vmstate_npcm7xx_clk;
-    dc->realize = npcm7xx_clk_realize;
-    rc->phases.enter = npcm7xx_clk_enter_reset;
 }
 
 static const TypeInfo npcm7xx_clk_pll_info = {
@@ -1070,11 +1076,18 @@ static const TypeInfo npcm7xx_clk_divider_info = {
     .class_init         = npcm7xx_clk_divider_class_init,
 };
 
+static const TypeInfo npcm_clk_info = {
+    .name               = TYPE_NPCM_CLK,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCMCLKState),
+    .instance_init      = npcm_clk_init,
+    .class_init         = npcm_clk_class_init,
+    .abstract           = true,
+};
+
 static const TypeInfo npcm7xx_clk_info = {
     .name               = TYPE_NPCM7XX_CLK,
-    .parent             = TYPE_SYS_BUS_DEVICE,
-    .instance_size      = sizeof(NPCM7xxCLKState),
-    .instance_init      = npcm7xx_clk_init,
+    .parent             = TYPE_NPCM_CLK,
     .class_init         = npcm7xx_clk_class_init,
 };
 
@@ -1083,6 +1096,7 @@ static void npcm7xx_clk_register_type(void)
     type_register_static(&npcm7xx_clk_pll_info);
     type_register_static(&npcm7xx_clk_sel_info);
     type_register_static(&npcm7xx_clk_divider_info);
+    type_register_static(&npcm_clk_info);
     type_register_static(&npcm7xx_clk_info);
 }
 type_init(npcm7xx_clk_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index f25dbd6030..4383808d7a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -130,9 +130,9 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, const char *name, uint64_t val) "reg=0x%"PRIx64 " [%s] val=0x%"PRIx64
 mos6522_read(uint64_t addr, const char *name, unsigned val) "reg=0x%"PRIx64 " [%s] val=0x%x"
 
-# npcm7xx_clk.c
-npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+# npcm_clk.c
+npcm_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
 # npcm_gcr.c
 npcm_gcr_read(uint64_t offset, uint64_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index e80fd91f20..56536565b7 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -90,7 +90,7 @@ struct NPCM7xxState {
     MemoryRegion        *dram;
 
     NPCMGCRState        gcr;
-    NPCM7xxCLKState     clk;
+    NPCMCLKState     clk;
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxADCState     adc;
     NPCM7xxPWMState     pwm[NPCM7XX_NR_PWM_MODULES];
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index 0aef81e10c..db03b46a52 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -20,11 +20,12 @@
 #include "hw/clock.h"
 #include "hw/sysbus.h"
 
+#define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
 /*
- * Number of registers in our device state structure. Don't change this without
- * incrementing the version_id in the vmstate.
+ * Number of maximum registers in NPCM device state structure. Don't change
+ * this without incrementing the version_id in the vmstate.
  */
-#define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
+#define NPCM_CLK_MAX_NR_REGS            NPCM7XX_CLK_NR_REGS
 
 #define NPCM7XX_WATCHDOG_RESET_GPIO_IN "npcm7xx-clk-watchdog-reset-gpio-in"
 
@@ -80,7 +81,7 @@ typedef enum NPCM7xxClockDivider {
     NPCM7XX_CLOCK_NR_DIVIDERS,
 } NPCM7xxClockConverter;
 
-typedef struct NPCM7xxCLKState NPCM7xxCLKState;
+typedef struct NPCMCLKState NPCMCLKState;
 
 /**
  * struct NPCM7xxClockPLLState - A PLL module in CLK module.
@@ -94,7 +95,7 @@ typedef struct NPCM7xxClockPLLState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     Clock *clock_in;
     Clock *clock_out;
 
@@ -115,7 +116,7 @@ typedef struct NPCM7xxClockSELState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     uint8_t input_size;
     Clock *clock_in[NPCM7XX_CLK_SEL_MAX_INPUT];
     Clock *clock_out;
@@ -140,7 +141,7 @@ typedef struct NPCM7xxClockDividerState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     Clock *clock_in;
     Clock *clock_out;
 
@@ -155,7 +156,7 @@ typedef struct NPCM7xxClockDividerState {
     };
 } NPCM7xxClockDividerState;
 
-struct NPCM7xxCLKState {
+struct NPCMCLKState {
     SysBusDevice parent;
 
     MemoryRegion iomem;
@@ -165,7 +166,7 @@ struct NPCM7xxCLKState {
     NPCM7xxClockSELState sels[NPCM7XX_CLOCK_NR_SELS];
     NPCM7xxClockDividerState dividers[NPCM7XX_CLOCK_NR_DIVIDERS];
 
-    uint32_t regs[NPCM7XX_CLK_NR_REGS];
+    uint32_t regs[NPCM_CLK_MAX_NR_REGS];
 
     /* Time reference for SECCNT and CNTR25M, initialized by power on reset */
     int64_t ref_ns;
@@ -174,7 +175,8 @@ struct NPCM7xxCLKState {
     Clock *clkref;
 };
 
+#define TYPE_NPCM_CLK "npcm-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMCLKState, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxCLKState, NPCM7XX_CLK)
 
 #endif /* NPCM_CLK_H */
-- 
2.48.1.502.g6dc24dfdaf-goog


