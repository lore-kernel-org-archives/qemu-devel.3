Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6BD2628D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeX-0001Bp-BJ; Tue, 20 Jan 2026 13:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeQ-0000cm-RD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeO-0006Je-JO
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso40114365e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934423; x=1769539223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HMrUqacCaGVauSVeco7pmqIAM/xQRkgygcSUJ7ApSQw=;
 b=YguxEK1/BliAkuf5SQNyLI1yltJKRrP6VmwDXUYWly8zoGMCEn0AQRJmo6KjFhZrKN
 8YSVyRlI+RHu6Itz0aHzAHdQQ96w3lso+q3KzVAbHHApvBo5Kccfe4E09RbkRNK5M+jI
 hgXfhTkToN/B0XVyS8/iPsTJNKGc4eSJfj7WMLAFeLH9tmgixhQ2QFaIugegIWKx1fmL
 Mnm40ZlLGT4iaRb7vCX1rRi/42Uix65BF5ZHvUsteWBFvqXTIt9dZB6q2mLRS8x+Z59s
 MpoY3bypGisufQf+NhgdIB9U612XQY1pPZY4w15CrWftuXQ1KfzrpBZPTbEOwYRQ9X4D
 qXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934423; x=1769539223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HMrUqacCaGVauSVeco7pmqIAM/xQRkgygcSUJ7ApSQw=;
 b=XLM2Qu7DFpzEii18d1/MemhvTdLJXNw0Q7+cQ7VfjqnhxgwX97l6lgSFS34ynIu9gv
 dL2+fD++/FcGG9MkklXzOg8byN9VuuLI8TKFBE3GLJougxGKFGnNoAI7hl4gM2EkvAqm
 CzseRexbAL2diX1rMajB26ofDkqyHmZ1CTUHut2VTsoAlEtHWjkiBoGhSMwUu2tem3nN
 BdMv6m4bV3GevqwdZWjKpjIMTznf5gsHWM4zoLSVuyKLFdXHODC/ezBDSVKLG9O3UIHt
 mYred5fYIcFh6HITXByigmWoXqI9z0Yjpj77khwXto5WVyq9/DX9Ydx2KOH7vP2Le6oy
 B/UA==
X-Gm-Message-State: AOJu0YwX+YaZZ5viBjwr8XcHIjo8FJxFOXF++U45OxKu3dmc1sA7BTGL
 kYezFABMzPHSHK93pYiUFvq0J4Uo/i7XKxlbo2+Wz0kPj3KxKAyFzEN8eTZPhxoakPTbMcXJfoQ
 A4zwmOM4=
X-Gm-Gg: AY/fxX6NGn41mLmraB3diiXEzzeWcspF+Qb181EEwktZWcygGzGT63CUPqdOEkqPvi7
 R2E7VLXTdW0vIOlpDsFbQUlweS9ouJv6L9pPaQydT7Tr5f00xFBMqtI+8GDiXE1o2psRnk9G0tX
 yFTKgI3amvuDgJc+ALeUj4lQIJPzMNPFFCz7sS+hQDUn5D71qNxzHttN/tLnAoe3b1ubqZ77+YE
 SI9ucFXmP7nPWuDxkuCiQLgZonxR4uwNLeNkePEXqTLD9fF622LdJDFeP+C8gf9Oqhtm5soF77a
 n8DGqGcEdvnKdmFUgN1d8+GLygq/Cit0ZFhMCWFeXeKeyQS5e1lqBUo1b4wVNtp5w+bAlQHlzjM
 yJ7BMziWPZL+4sK6JPthzEeHzBGBfpapU/jBw64rQ19N5Nq7qqpp3t9ND1RFn/VDZOKC8DnDP+6
 6ahQFzRKtQdb2sbCJdJj9oYDUwv9u0gjMx++92jJExuL4ADDzgDcUjiBcE2EClgmIw0qXdAHg=
X-Received: by 2002:a05:600c:811a:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-4801ead0fd1mr178347785e9.16.1768934422521; 
 Tue, 20 Jan 2026 10:40:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8795f1sm262937425e9.6.2026.01.20.10.40.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] hw/arm/fsl-imx6: Fix naming of SDHCI related constants
 and attributes
Date: Tue, 20 Jan 2026 19:38:44 +0100
Message-ID: <20260120183902.73845-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

The i.MX 6 SoC features uSDHC controllers which are the successors of eSDHC.
Fix the naming to make this clear.

Fixes: ec46eaa83a3c ("i.MX: Add i.MX6 SOC implementation.")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx6.h |  4 ++--
 hw/arm/fsl-imx6.c         | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 5520473ba0b..bb866994dff 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -46,7 +46,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_EPITS 2
 #define FSL_IMX6_NUM_I2CS 3
 #define FSL_IMX6_NUM_GPIOS 7
-#define FSL_IMX6_NUM_ESDHCS 4
+#define FSL_IMX6_NUM_USDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
 #define FSL_IMX6_NUM_WDTS 2
 #define FSL_IMX6_NUM_USB_PHYS 2
@@ -67,7 +67,7 @@ struct FslIMX6State {
     IMXEPITState       epit[FSL_IMX6_NUM_EPITS];
     IMXI2CState        i2c[FSL_IMX6_NUM_I2CS];
     IMXGPIOState       gpio[FSL_IMX6_NUM_GPIOS];
-    SDHCIState         esdhc[FSL_IMX6_NUM_ESDHCS];
+    SDHCIState         usdhc[FSL_IMX6_NUM_USDHCS];
     IMXSPIState        spi[FSL_IMX6_NUM_ECSPIS];
     IMX2WdtState       wdt[FSL_IMX6_NUM_WDTS];
     IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 46967b74882..39667c4a49a 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -79,9 +79,9 @@ static void fsl_imx6_init(Object *obj)
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
     }
 
-    for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
+    for (i = 0; i < FSL_IMX6_NUM_USDHCS; i++) {
         snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
-        object_initialize_child(obj, name, &s->esdhc[i], TYPE_IMX_USDHC);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
@@ -311,11 +311,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* Initialize all SDHC */
-    for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
+    for (i = 0; i < FSL_IMX6_NUM_USDHCS; i++) {
         static const struct {
             hwaddr addr;
             unsigned int irq;
-        } esdhc_table[FSL_IMX6_NUM_ESDHCS] = {
+        } esdhc_table[FSL_IMX6_NUM_USDHCS] = {
             { FSL_IMX6_uSDHC1_ADDR, FSL_IMX6_uSDHC1_IRQ },
             { FSL_IMX6_uSDHC2_ADDR, FSL_IMX6_uSDHC2_IRQ },
             { FSL_IMX6_uSDHC3_ADDR, FSL_IMX6_uSDHC3_IRQ },
@@ -323,13 +323,13 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
             return;
         }
-        sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, esdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                            qdev_get_gpio_in(gic, esdhc_table[i].irq));
     }
 
-- 
2.52.0


