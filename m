Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A127C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp5s-000349-Cy; Wed, 19 Feb 2025 13:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Cye2ZwgKCnYqobUinmbaiiafY.WigkYgo-XYpYfhihaho.ila@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5j-0002z6-C3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:39 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Cye2ZwgKCnYqobUinmbaiiafY.WigkYgo-XYpYfhihaho.ila@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5h-0004jp-6v
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:39 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso301903a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990795; x=1740595595; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+/a005zuObVx2W1wNokhGwm8lg4fRqTP6m967Q50n2Q=;
 b=tU/m+gOUTTkx7hCV3GvESleB1aSi7zbeh91LxDuAGvEYeRNvUHKXtREh2ND6rEymUb
 uMpMpXa+kGlFE1ClcLb4jTibqqOSKoYP/YVHeiMCZxuuDnpMGeZa1kz8m8xh2cQTtHMI
 8GCh25A0tDwjC4D1sVzjwUYulKdZsWGQaz6i3oy1ytrbN08KL6ZBkU/gnbQkyj6cMPdK
 ObtmGzOA+zb3gPSGRjBD5f0qVEJl5lOyloxd/tU6Qh1nFne98FKgXVr6lmPBv7Zm++7R
 1WD4vs1kgy4EF45OQ1e582W1+kJ6SHTvt6+8aR/4+V3l6XT3Dk359fqZwJJ3pQ5AOpbk
 k3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990795; x=1740595595;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+/a005zuObVx2W1wNokhGwm8lg4fRqTP6m967Q50n2Q=;
 b=aOWyh9+ej7eVkAm1Sv7+IW6YtvPA8yd82OrqLn9w3B2FPCEf24JmZ6ySv+1bn0qMN5
 6uxsh/nHoStPl+F4DPJONnCK3l9hc0DN6iCKXdvQkFgZiYDf3Onc2azhUWEpS7INa1vS
 JWcJp/At4nXzRtJhOturpOynfGp6G1uubSX0bJce+WdrqsLci4ep7TIM96i8GkJvQJ60
 aYQd4z8O+gzvbTsi0lHMC99nZq0kxshHXk0WfvCw8TqC7IUjPjZW1yLpCzjH9KeEpImF
 Dmzs2nnBrKlqqNgmiG44DfQpVzpaEhBFSMvgCUvIgGUBMIRUjaFedmP2/qrqZnkz4c3u
 AYNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMcgEPInBE4QspC4F9vtA6PVOJjdGfO65Sa0Hrdbmfo9p8g+Tj6/ilk3VSz5HjXaING5eqSgTmxzg0@nongnu.org
X-Gm-Message-State: AOJu0YwnJtuHrSMsKni+8b510kTnlHzjHTRFvzdgNBdUAdLLdJc3XtKp
 kIzOx61PSLFUa87s5afj6K7A6vH97KaBLZ+F8A+pPnq67sBOYdISmNwj6moG3Ssx+qG3MFXS3Lr
 1ubEePwdR5A==
X-Google-Smtp-Source: AGHT+IEnSE3icajW7rTlgAcUmud7RM7Vp4o6+/m3yI4AY6uia01uzGijHo9T3fAEFu6fBl1OKsxSt3XHIryWww==
X-Received: from pji3.prod.google.com ([2002:a17:90b:3fc3:b0:2e5:5ffc:1c36])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f86:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2fc40c1d548mr31429106a91.7.1739990795507; 
 Wed, 19 Feb 2025 10:46:35 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:58 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-8-wuhaotsh@google.com>
Subject: [PATCH v5 07/17] hw/misc: Add support for NPCM8XX GCR
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3Cye2ZwgKCnYqobUinmbaiiafY.WigkYgo-XYpYfhihaho.ila@flex--wuhaotsh.bounces.google.com;
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 133 ++++++++++++++++++++++++++++++++++++-
 include/hw/misc/npcm_gcr.h |   6 +-
 2 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index d89e8c2c3b..ac22fb08cb 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -1,5 +1,5 @@
 /*
- * Nuvoton NPCM7xx System Global Control Registers.
+ * Nuvoton NPCM7xx/8xx System Global Control Registers.
  *
  * Copyright 2020 Google LLC
  *
@@ -83,6 +83,118 @@ static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
     [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
 };
 
+enum NPCM8xxGCRRegisters {
+    NPCM8XX_GCR_PDID,
+    NPCM8XX_GCR_PWRON,
+    NPCM8XX_GCR_MISCPE          = 0x014 / sizeof(uint32_t),
+    NPCM8XX_GCR_FLOCKR2         = 0x020 / sizeof(uint32_t),
+    NPCM8XX_GCR_FLOCKR3,
+    NPCM8XX_GCR_A35_MODE        = 0x034 / sizeof(uint32_t),
+    NPCM8XX_GCR_SPSWC,
+    NPCM8XX_GCR_INTCR,
+    NPCM8XX_GCR_INTSR,
+    NPCM8XX_GCR_HIFCR           = 0x050 / sizeof(uint32_t),
+    NPCM8XX_GCR_INTCR2          = 0x060 / sizeof(uint32_t),
+    NPCM8XX_GCR_SRCNT           = 0x068 / sizeof(uint32_t),
+    NPCM8XX_GCR_RESSR,
+    NPCM8XX_GCR_RLOCKR1,
+    NPCM8XX_GCR_FLOCKR1,
+    NPCM8XX_GCR_DSCNT,
+    NPCM8XX_GCR_MDLR,
+    NPCM8XX_GCR_SCRPAD_C        = 0x080 / sizeof(uint32_t),
+    NPCM8XX_GCR_SCRPAD_B,
+    NPCM8XX_GCR_DAVCLVLR        = 0x098 / sizeof(uint32_t),
+    NPCM8XX_GCR_INTCR3,
+    NPCM8XX_GCR_PCIRCTL         = 0x0a0 / sizeof(uint32_t),
+    NPCM8XX_GCR_VSINTR,
+    NPCM8XX_GCR_SD2SUR1         = 0x0b4 / sizeof(uint32_t),
+    NPCM8XX_GCR_SD2SUR2,
+    NPCM8XX_GCR_INTCR4          = 0x0c0 / sizeof(uint32_t),
+    NPCM8XX_GCR_CPCTL           = 0x0d0 / sizeof(uint32_t),
+    NPCM8XX_GCR_CP2BST,
+    NPCM8XX_GCR_B2CPNT,
+    NPCM8XX_GCR_CPPCTL,
+    NPCM8XX_GCR_I2CSEGSEL       = 0x0e0 / sizeof(uint32_t),
+    NPCM8XX_GCR_I2CSEGCTL,
+    NPCM8XX_GCR_VSRCR,
+    NPCM8XX_GCR_MLOCKR,
+    NPCM8XX_GCR_SCRPAD          = 0x13c / sizeof(uint32_t),
+    NPCM8XX_GCR_USB1PHYCTL,
+    NPCM8XX_GCR_USB2PHYCTL,
+    NPCM8XX_GCR_USB3PHYCTL,
+    NPCM8XX_GCR_MFSEL1          = 0x260 / sizeof(uint32_t),
+    NPCM8XX_GCR_MFSEL2,
+    NPCM8XX_GCR_MFSEL3,
+    NPCM8XX_GCR_MFSEL4,
+    NPCM8XX_GCR_MFSEL5,
+    NPCM8XX_GCR_MFSEL6,
+    NPCM8XX_GCR_MFSEL7,
+    NPCM8XX_GCR_MFSEL_LK1       = 0x280 / sizeof(uint32_t),
+    NPCM8XX_GCR_MFSEL_LK2,
+    NPCM8XX_GCR_MFSEL_LK3,
+    NPCM8XX_GCR_MFSEL_LK4,
+    NPCM8XX_GCR_MFSEL_LK5,
+    NPCM8XX_GCR_MFSEL_LK6,
+    NPCM8XX_GCR_MFSEL_LK7,
+    NPCM8XX_GCR_MFSEL_SET1      = 0x2a0 / sizeof(uint32_t),
+    NPCM8XX_GCR_MFSEL_SET2,
+    NPCM8XX_GCR_MFSEL_SET3,
+    NPCM8XX_GCR_MFSEL_SET4,
+    NPCM8XX_GCR_MFSEL_SET5,
+    NPCM8XX_GCR_MFSEL_SET6,
+    NPCM8XX_GCR_MFSEL_SET7,
+    NPCM8XX_GCR_MFSEL_CLR1      = 0x2c0 / sizeof(uint32_t),
+    NPCM8XX_GCR_MFSEL_CLR2,
+    NPCM8XX_GCR_MFSEL_CLR3,
+    NPCM8XX_GCR_MFSEL_CLR4,
+    NPCM8XX_GCR_MFSEL_CLR5,
+    NPCM8XX_GCR_MFSEL_CLR6,
+    NPCM8XX_GCR_MFSEL_CLR7,
+    NPCM8XX_GCR_WD0RCRLK        = 0x400 / sizeof(uint32_t),
+    NPCM8XX_GCR_WD1RCRLK,
+    NPCM8XX_GCR_WD2RCRLK,
+    NPCM8XX_GCR_SWRSTC1LK,
+    NPCM8XX_GCR_SWRSTC2LK,
+    NPCM8XX_GCR_SWRSTC3LK,
+    NPCM8XX_GCR_TIPRSTCLK,
+    NPCM8XX_GCR_CORSTCLK,
+    NPCM8XX_GCR_WD0RCRBLK,
+    NPCM8XX_GCR_WD1RCRBLK,
+    NPCM8XX_GCR_WD2RCRBLK,
+    NPCM8XX_GCR_SWRSTC1BLK,
+    NPCM8XX_GCR_SWRSTC2BLK,
+    NPCM8XX_GCR_SWRSTC3BLK,
+    NPCM8XX_GCR_TIPRSTCBLK,
+    NPCM8XX_GCR_CORSTCBLK,
+    /* 64 scratch pad registers start here. 0xe00 ~ 0xefc */
+    NPCM8XX_GCR_SCRPAD_00       = 0xe00 / sizeof(uint32_t),
+    /* 32 semaphore registers start here. 0xf00 ~ 0xf7c */
+    NPCM8XX_GCR_GP_SEMFR_00     = 0xf00 / sizeof(uint32_t),
+    NPCM8XX_GCR_GP_SEMFR_31     = 0xf7c / sizeof(uint32_t),
+};
+
+static const uint32_t npcm8xx_cold_reset_values[NPCM8XX_GCR_NR_REGS] = {
+    [NPCM8XX_GCR_PDID]          = 0x04a35850,   /* Arbel A1 */
+    [NPCM8XX_GCR_MISCPE]        = 0x0000ffff,
+    [NPCM8XX_GCR_A35_MODE]      = 0xfff4ff30,
+    [NPCM8XX_GCR_SPSWC]         = 0x00000003,
+    [NPCM8XX_GCR_INTCR]         = 0x0010035e,
+    [NPCM8XX_GCR_HIFCR]         = 0x0000004e,
+    [NPCM8XX_GCR_SD2SUR1]       = 0xfdc80000,
+    [NPCM8XX_GCR_SD2SUR2]       = 0x5200b130,
+    [NPCM8XX_GCR_INTCR2]        = (1U << 19),   /* DDR initialized */
+    [NPCM8XX_GCR_RESSR]         = 0x80000000,
+    [NPCM8XX_GCR_DAVCLVLR]      = 0x5a00f3cf,
+    [NPCM8XX_GCR_INTCR3]        = 0x5e001002,
+    [NPCM8XX_GCR_VSRCR]         = 0x00004800,
+    [NPCM8XX_GCR_SCRPAD]        = 0x00000008,
+    [NPCM8XX_GCR_USB1PHYCTL]    = 0x034730e4,
+    [NPCM8XX_GCR_USB2PHYCTL]    = 0x034730e4,
+    [NPCM8XX_GCR_USB3PHYCTL]    = 0x034730e4,
+    /* All 32 semaphores should be initialized to 1. */
+    [NPCM8XX_GCR_GP_SEMFR_00...NPCM8XX_GCR_GP_SEMFR_31] = 0x00000001,
+};
+
 static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
@@ -224,8 +336,8 @@ static void npcm_gcr_init(Object *obj)
 
 static const VMStateDescription vmstate_npcm_gcr = {
     .name = "npcm-gcr",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS),
         VMSTATE_END_OF_LIST(),
@@ -260,6 +372,16 @@ static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
     c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
+static void npcm8xx_gcr_class_init(ObjectClass *klass, void *data)
+{
+    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM8xx System Global Control Registers";
+    c->nr_regs = NPCM8XX_GCR_NR_REGS;
+    c->cold_reset_values = npcm8xx_cold_reset_values;
+}
+
 static const TypeInfo npcm_gcr_info[] = {
     {
         .name               = TYPE_NPCM_GCR,
@@ -275,5 +397,10 @@ static const TypeInfo npcm_gcr_info[] = {
         .parent             = TYPE_NPCM_GCR,
         .class_init         = npcm7xx_gcr_class_init,
     },
+    {
+        .name               = TYPE_NPCM8XX_GCR,
+        .parent             = TYPE_NPCM_GCR,
+        .class_init         = npcm8xx_gcr_class_init,
+    },
 };
 DEFINE_TYPES(npcm_gcr_info)
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9af24e5cdc..9ac76ca9ab 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -1,5 +1,5 @@
 /*
- * Nuvoton NPCM7xx System Global Control Registers.
+ * Nuvoton NPCM7xx/8xx System Global Control Registers.
  *
  * Copyright 2020 Google LLC
  *
@@ -54,8 +54,9 @@
  * Number of registers in our device state structure. Don't change this without
  * incrementing the version_id in the vmstate.
  */
-#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
+#define NPCM_GCR_MAX_NR_REGS NPCM8XX_GCR_NR_REGS
 #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
+#define NPCM8XX_GCR_NR_REGS (0xf80 / sizeof(uint32_t))
 
 typedef struct NPCMGCRState {
     SysBusDevice parent;
@@ -78,6 +79,7 @@ typedef struct NPCMGCRClass {
 
 #define TYPE_NPCM_GCR "npcm-gcr"
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
+#define TYPE_NPCM8XX_GCR "npcm8xx-gcr"
 OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
 
 #endif /* NPCM_GCR_H */
-- 
2.48.1.601.g30ceb7b040-goog


