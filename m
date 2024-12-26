Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B020BE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjA1-00086V-TV; Thu, 26 Dec 2024 03:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ihJtZwgKCqUbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9n-0007aJ-0z
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:48 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ihJtZwgKCqUbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9j-0000aP-D3
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:45 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2164861e1feso76995465ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201418; x=1735806218; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=y7VgKIyKOGLTsJ2xUWEPCl+kAMd8H5DMHmwH0IVzMCc=;
 b=oGpYEfPkmJNC4TKdkRzqYYb3WHa667TDJltbTfIo5wKmtf71DVOGGZ8b+ZRNppZEV9
 LJZYKyg3UUjGO2DM2I7/Xk+IFBHvulewWTxCVbvO4sO81bE5LpuIUMYCzsLb9RGc1rii
 4+pFf01joUIETZOzimfI1hKNZfq1W1jBWw5xsBGq6UbKgpHiO781PKIqH2vme4/iWXjt
 CaVQedlXwnH7sTuOYiVdcB6DCEqofVoRj8aAdSkh2n/ZoUqVU2W5KYqZkJcwV7I+RuM2
 zHZ77w15THdB9otq5ga5x/BogvF2Z1Rs1GsCukc6CvghxZp/jbmCH90ofA1mJ8v6f6kE
 bEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201418; x=1735806218;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7VgKIyKOGLTsJ2xUWEPCl+kAMd8H5DMHmwH0IVzMCc=;
 b=mJWrx766g8DDn/q6mfyTECtJPOyaO9aQtY2FJSHzsc6v/5oBd25mtBjkGOsIa2aUu+
 K8sBgD/mSO2YXs9T5u67+bA8Wxkg4TTAWcPoP+qfAMMv7jKC8A3fYvMVn3d46oqMxp77
 1t006+mtSW32WbAvQM0l03rvROypM4BO5LT3vncq71qh6MVm4kwJYeFR+oEf3bFB5QIT
 6mTBn/dd4NWtNdn8FgFX5gylsYaJ2/kx2Cbeg1Ml8gGboOjIsFf7dstiz2hNPR2+HBxQ
 /mXeRU8/rgJSZn8sRhpJBWhMyIdaElGt+mdjCcNlOLxeW8PbK7ijM+eYlDveDw4yB5T1
 83Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhE9LgsAQxso9XIVY59kJK1H63buDEku+KxcOpretlVJPJk8eBSn/kObnOAW3J+Z4FeTLIarsFKV+B@nongnu.org
X-Gm-Message-State: AOJu0YykQavBKDC/ysvB4oyGtVx+FrzDmjbyLAkfMaZ3Yk8Ho9TyQA5O
 kXTgNQvA77s/MvAGLEyWq5qjaBfnfKe9tvNhzlx+UTRZwS/deESj5ONnCjsMVch549odSJb9pRU
 0xHOfbX51yg==
X-Google-Smtp-Source: AGHT+IFE3s0Zd0x+q5k7Im/qdZYwLHLECc9sZWvi06lOFQTDZc9dX9yT2qTTdYb4yu/yTZC5oxRdZMlivGb75g==
X-Received: from pfbay11.prod.google.com
 ([2002:a05:6a00:300b:b0:725:ee5e:6efd])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258c:b0:1db:915b:ab11 with SMTP id
 adf61e73a8af0-1e5e04946b1mr38688520637.24.1735201418299; 
 Thu, 26 Dec 2024 00:23:38 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:33 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-15-wuhaotsh@google.com>
Subject: [PATCH 14/17] hw/misc: Support NPCM8XX CLK Module Registers
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3ihJtZwgKCqUbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com;
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

NPCM8XX adds a few new registers and have a different set of reset
values to the CLK modules. This patch supports them.

This patch doesn't support the new clock values generated by these
registers. Currently no modules use these new clock values so they
are not necessary at this point.
Implementation of these clocks might be required when implementing
these modules.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Titus Rwantare<titusr@google.com>
---
 hw/misc/npcm_clk.c         | 113 ++++++++++++++++++++++++++++++++++++-
 include/hw/misc/npcm_clk.h |  10 +++-
 2 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index eee754d31f..af127991da 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -1,5 +1,5 @@
 /*
- * Nuvoton NPCM7xx Clock Control Registers.
+ * Nuvoton NPCM7xx/8xx Clock Control Registers.
  *
  * Copyright 2020 Google LLC
  *
@@ -75,6 +75,58 @@ enum NPCM7xxCLKRegisters {
     NPCM7XX_CLK_REGS_END,
 };
 
+enum NPCM8xxCLKRegisters {
+    NPCM8XX_CLK_CLKEN1,
+    NPCM8XX_CLK_CLKSEL,
+    NPCM8XX_CLK_CLKDIV1,
+    NPCM8XX_CLK_PLLCON0,
+    NPCM8XX_CLK_PLLCON1,
+    NPCM8XX_CLK_SWRSTR,
+    NPCM8XX_CLK_IPSRST1         = 0x20 / sizeof(uint32_t),
+    NPCM8XX_CLK_IPSRST2,
+    NPCM8XX_CLK_CLKEN2,
+    NPCM8XX_CLK_CLKDIV2,
+    NPCM8XX_CLK_CLKEN3,
+    NPCM8XX_CLK_IPSRST3,
+    NPCM8XX_CLK_WD0RCR,
+    NPCM8XX_CLK_WD1RCR,
+    NPCM8XX_CLK_WD2RCR,
+    NPCM8XX_CLK_SWRSTC1,
+    NPCM8XX_CLK_SWRSTC2,
+    NPCM8XX_CLK_SWRSTC3,
+    NPCM8XX_CLK_TIPRSTC,
+    NPCM8XX_CLK_PLLCON2,
+    NPCM8XX_CLK_CLKDIV3,
+    NPCM8XX_CLK_CORSTC,
+    NPCM8XX_CLK_PLLCONG,
+    NPCM8XX_CLK_AHBCKFI,
+    NPCM8XX_CLK_SECCNT,
+    NPCM8XX_CLK_CNTR25M,
+    /* Registers unique to NPCM8XX SoC */
+    NPCM8XX_CLK_CLKEN4,
+    NPCM8XX_CLK_IPSRST4,
+    NPCM8XX_CLK_BUSTO,
+    NPCM8XX_CLK_CLKDIV4,
+    NPCM8XX_CLK_WD0RCRB,
+    NPCM8XX_CLK_WD1RCRB,
+    NPCM8XX_CLK_WD2RCRB,
+    NPCM8XX_CLK_SWRSTC1B,
+    NPCM8XX_CLK_SWRSTC2B,
+    NPCM8XX_CLK_SWRSTC3B,
+    NPCM8XX_CLK_TIPRSTCB,
+    NPCM8XX_CLK_CORSTCB,
+    NPCM8XX_CLK_IPSRSTDIS1,
+    NPCM8XX_CLK_IPSRSTDIS2,
+    NPCM8XX_CLK_IPSRSTDIS3,
+    NPCM8XX_CLK_IPSRSTDIS4,
+    NPCM8XX_CLK_CLKENDIS1,
+    NPCM8XX_CLK_CLKENDIS2,
+    NPCM8XX_CLK_CLKENDIS3,
+    NPCM8XX_CLK_CLKENDIS4,
+    NPCM8XX_CLK_THRTL_CNT,
+    NPCM8XX_CLK_REGS_END,
+};
+
 /*
  * These reset values were taken from version 0.91 of the NPCM750R data sheet.
  *
@@ -103,6 +155,46 @@ static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
     [NPCM7XX_CLK_AHBCKFI]       = 0x000000c8,
 };
 
+/*
+ * These reset values were taken from version 0.92 of the NPCM8xx data sheet.
+ */
+static const uint32_t npcm8xx_cold_reset_values[NPCM8XX_CLK_NR_REGS] = {
+    [NPCM8XX_CLK_CLKEN1]        = 0xffffffff,
+    [NPCM8XX_CLK_CLKSEL]        = 0x154aaaaa,
+    [NPCM8XX_CLK_CLKDIV1]       = 0x5413f855,
+    [NPCM8XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
+    [NPCM8XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
+    [NPCM8XX_CLK_IPSRST1]       = 0x00001000,
+    [NPCM8XX_CLK_IPSRST2]       = 0x80000000,
+    [NPCM8XX_CLK_CLKEN2]        = 0xffffffff,
+    [NPCM8XX_CLK_CLKDIV2]       = 0xaa4f8f9f,
+    [NPCM8XX_CLK_CLKEN3]        = 0xffffffff,
+    [NPCM8XX_CLK_IPSRST3]       = 0x03000000,
+    [NPCM8XX_CLK_WD0RCR]        = 0xffffffff,
+    [NPCM8XX_CLK_WD1RCR]        = 0xffffffff,
+    [NPCM8XX_CLK_WD2RCR]        = 0xffffffff,
+    [NPCM8XX_CLK_SWRSTC1]       = 0x00000003,
+    [NPCM8XX_CLK_SWRSTC2]       = 0x00000001,
+    [NPCM8XX_CLK_SWRSTC3]       = 0x00000001,
+    [NPCM8XX_CLK_TIPRSTC]       = 0x00000001,
+    [NPCM8XX_CLK_PLLCON2]       = 0x00c02105 | PLLCON_LOKI,
+    [NPCM8XX_CLK_CLKDIV3]       = 0x00009100,
+    [NPCM8XX_CLK_CORSTC]        = 0x04000003,
+    [NPCM8XX_CLK_PLLCONG]       = 0x01228606 | PLLCON_LOKI,
+    [NPCM8XX_CLK_AHBCKFI]       = 0x000000c8,
+    [NPCM8XX_CLK_CLKEN4]        = 0xffffffff,
+    [NPCM8XX_CLK_CLKDIV4]       = 0x70009000,
+    [NPCM8XX_CLK_IPSRST4]       = 0x02000000,
+    [NPCM8XX_CLK_WD0RCRB]       = 0xfffffe71,
+    [NPCM8XX_CLK_WD1RCRB]       = 0xfffffe71,
+    [NPCM8XX_CLK_WD2RCRB]       = 0xfffffe71,
+    [NPCM8XX_CLK_SWRSTC1B]      = 0xfffffe71,
+    [NPCM8XX_CLK_SWRSTC2B]      = 0xfffffe71,
+    [NPCM8XX_CLK_SWRSTC3B]      = 0xfffffe71,
+    [NPCM8XX_CLK_TIPRSTCB]      = 0xfffffe71,
+    [NPCM8XX_CLK_CORSTCB]       = 0xfffffe71,
+};
+
 /* The number of watchdogs that can trigger a reset. */
 #define NPCM7XX_NR_WATCHDOGS    (3)
 
@@ -1056,6 +1148,18 @@ static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
     c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
+static void npcm8xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM8XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
+    QEMU_BUILD_BUG_ON(NPCM8XX_CLK_REGS_END != NPCM8XX_CLK_NR_REGS);
+    dc->desc = "NPCM8xx Clock Control Registers";
+    c->nr_regs = NPCM8XX_CLK_NR_REGS;
+    c->cold_reset_values = npcm8xx_cold_reset_values;
+}
+
 static const TypeInfo npcm7xx_clk_pll_info = {
     .name               = TYPE_NPCM7XX_CLOCK_PLL,
     .parent             = TYPE_DEVICE,
@@ -1096,6 +1200,12 @@ static const TypeInfo npcm7xx_clk_info = {
     .class_init         = npcm7xx_clk_class_init,
 };
 
+static const TypeInfo npcm8xx_clk_info = {
+    .name               = TYPE_NPCM8XX_CLK,
+    .parent             = TYPE_NPCM_CLK,
+    .class_init         = npcm8xx_clk_class_init,
+};
+
 static void npcm7xx_clk_register_type(void)
 {
     type_register_static(&npcm7xx_clk_pll_info);
@@ -1103,5 +1213,6 @@ static void npcm7xx_clk_register_type(void)
     type_register_static(&npcm7xx_clk_divider_info);
     type_register_static(&npcm_clk_info);
     type_register_static(&npcm7xx_clk_info);
+    type_register_static(&npcm8xx_clk_info);
 }
 type_init(npcm7xx_clk_register_type);
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index f47614ac8d..8fa1e14bdd 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -1,5 +1,5 @@
 /*
- * Nuvoton NPCM7xx Clock Control Registers.
+ * Nuvoton NPCM7xx/8xx Clock Control Registers.
  *
  * Copyright 2020 Google LLC
  *
@@ -21,11 +21,12 @@
 #include "hw/sysbus.h"
 
 #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
+#define NPCM8XX_CLK_NR_REGS             (0xc4 / sizeof(uint32_t))
 /*
  * Number of maximum registers in NPCM device state structure. Don't change
  * this without incrementing the version_id in the vmstate.
  */
-#define NPCM_CLK_MAX_NR_REGS            NPCM7XX_CLK_NR_REGS
+#define NPCM_CLK_MAX_NR_REGS            NPCM8XX_CLK_NR_REGS
 
 #define NPCM7XX_WATCHDOG_RESET_GPIO_IN "npcm7xx-clk-watchdog-reset-gpio-in"
 
@@ -162,6 +163,10 @@ struct NPCMCLKState {
     MemoryRegion iomem;
 
     /* Clock converters */
+    /*
+     * TODO: Implement unique clock converters for NPCM8xx.
+     * NPCM8xx adds a few more clock outputs.
+     */
     NPCM7xxClockPLLState plls[NPCM7XX_CLOCK_NR_PLLS];
     NPCM7xxClockSELState sels[NPCM7XX_CLOCK_NR_SELS];
     NPCM7xxClockDividerState dividers[NPCM7XX_CLOCK_NR_DIVIDERS];
@@ -185,5 +190,6 @@ typedef struct NPCMCLKClass {
 #define TYPE_NPCM_CLK "npcm-clk"
 OBJECT_DECLARE_TYPE(NPCMCLKState, NPCMCLKClass, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
+#define TYPE_NPCM8XX_CLK "npcm8xx-clk"
 
 #endif /* NPCM_CLK_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


