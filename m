Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65208C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA73-0005zO-HV; Thu, 06 Feb 2025 17:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zDOlZwgKCg097un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6r-0005p5-4w
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:33 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zDOlZwgKCg097un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6o-0001UV-PE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:32 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f9e1bf0a3bso4555487a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879949; x=1739484749; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xzvDReluW51gJqsTtXIqTvbj8esz/+E1M3Xk4GW42fQ=;
 b=iC7RJBKv+WwKj3M624FGusGT/42+DZUTeoY5qCTYNZZf+jnj5HAMkCXDtCfGrZxbEs
 C4vswtezO5giQVeSaBLeILbDqvQi2Q3shTOf2rwGcMsyEt96TvWYmhG46htDUk9H5HJM
 ajOetR53G705PDFQd+bGxXFnsfPXwt4ZkLDJ+ftMHbvsj0UvcMBpVqQuxZYXBz+wTCv1
 EosRaGggk9S1C0QMvQJOwaItEn74kRX13L4GLQVEV2H8EIdCdoVXLfBf6r7RhbAvreK9
 23MP7W/pz2uLx/k9CkjH7dwQH2T1nnieSSNPQEOMYEOG3UUp84JGuEneHvT4+AE/zWaU
 eKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879949; x=1739484749;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzvDReluW51gJqsTtXIqTvbj8esz/+E1M3Xk4GW42fQ=;
 b=Gl+gkdK7qUD/HvL7U6KotV3E8AWs8BtcH2p0ymB2+rHkuO0tmg/s/zw97CS6mq32VQ
 /CRyocPYZ+J18tJ+QIE15tW92Eawu1PY2JruXvbstEYjA0h4UaQLH+P/F21qICwdUo4h
 GQr76VGsz3EuLdftVdXdjeNqUbyV7g9rYZ8wrb9oI6e9ZiZTfdVvhdSU8CoTPMtbZdmO
 u58htEg1KdQmhXEz2G/t9+QItN3A8eR4UB8BtZNCdvS2EjJiQGi2HNRFXZ2D4cLC+Wb/
 uwnrCqDnxZNg8du35vtttDIQ1AEuc8q7pemVc9VrOweu/h1dZ4SCKt9GQu5oe31Py/36
 SuZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOnGpaX0Uu9DfVTXj/hVPyVw3TNQup45v2L0ZpFVytxufvCVmcU6xxFXSXi/J9Od9W7fK+rrQBmj6v@nongnu.org
X-Gm-Message-State: AOJu0YwJJNlXICeTW3U7fxbqB3wJ6SGxP/JnlnfQ7aNU49hLAAiUvQ0r
 zw+WCJbzFFo6Hq4gX2BMnA4iYVEct/WIjXsK5KvbDzwIS7hp72NSHOC9SpS9sgBnh0uLF4EzRNp
 9gsyYFLuzKw==
X-Google-Smtp-Source: AGHT+IHouP1CpW/b/zqgemhMGw3lBkxdYfCwKYZ3fdg+6aY7OAxvjo0AmGesK3VEsMOJEt5YBaB5+EqPTyn8qw==
X-Received: from pjbpb9.prod.google.com ([2002:a17:90b:3c09:b0:2da:5868:311c])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38c3:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2fa24177361mr1322228a91.16.1738879948942; 
 Thu, 06 Feb 2025 14:12:28 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:59 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-14-wuhaotsh@google.com>
Subject: [PATCH v4 13/17] hw/misc: Support NPCM8XX CLK Module Registers
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3zDOlZwgKCg097un165ut11tyr.p1z3rz7-qr8ry010t07.14t@flex--wuhaotsh.bounces.google.com;
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

NPCM8XX adds a few new registers and have a different set of reset
values to the CLK modules. This patch supports them.

This patch doesn't support the new clock values generated by these
registers. Currently no modules use these new clock values so they
are not necessary at this point.
Implementation of these clocks might be required when implementing
these modules.

Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_clk.c         | 113 +++++++++++++++++++++++++++++++++++--
 include/hw/misc/npcm_clk.h |  10 +++-
 2 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 78144b14e3..97559d4d07 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -1,5 +1,5 @@
 /*
- * Nuvoton NPCM7xx Clock Control Registers.
+ * Nuvoton NPCM7xx/8xx Clock Control Registers.
  *
  * Copyright 2020 Google LLC
  *
@@ -72,7 +72,57 @@ enum NPCM7xxCLKRegisters {
     NPCM7XX_CLK_AHBCKFI,
     NPCM7XX_CLK_SECCNT,
     NPCM7XX_CLK_CNTR25M,
-    NPCM7XX_CLK_REGS_END,
+};
+
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
 };
 
 /*
@@ -103,6 +153,46 @@ static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
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
 
@@ -1050,13 +1140,21 @@ static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
     NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
-    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
     c->nr_regs = NPCM7XX_CLK_NR_REGS;
     c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
+static void npcm8xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM8xx Clock Control Registers";
+    c->nr_regs = NPCM8XX_CLK_NR_REGS;
+    c->cold_reset_values = npcm8xx_cold_reset_values;
+}
+
 static const TypeInfo npcm7xx_clk_pll_info = {
     .name               = TYPE_NPCM7XX_CLOCK_PLL,
     .parent             = TYPE_DEVICE,
@@ -1097,6 +1195,12 @@ static const TypeInfo npcm7xx_clk_info = {
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
@@ -1104,5 +1208,6 @@ static void npcm7xx_clk_register_type(void)
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
2.48.1.502.g6dc24dfdaf-goog


