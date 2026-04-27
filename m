Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D3FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUo-0001lQ-J6; Mon, 27 Apr 2026 08:55:30 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLSi-0004Nc-TM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:53:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNQ-0005Ug-Bt
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so93520065e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294071; x=1777898871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+EHAWxwR5gtY8WCIFdHKUvBLUSjZ15ts5pSdgClXwsM=;
 b=B83h1solGC48P64H3zkfI6EeojbG29qs3yV6SxcaQxV6RY9qL5v3WefvU4z820o+aB
 ehFpZke6/ijreui+2uj62QpZtx4/ZFktC9UITycQZlEwwDwwD0/g9PUEHzLmlnii3Iq5
 XVE7zTVNKTAnbo0m9JAL7fx6fUNCoAyOJFkzn2IUDiG1EaHcUAYkpZO6phhIrCMfWi4L
 L6/B+lenzLbJ6Q9NquYNe9Yuw+io/H32gd2bmB6AIek9g2DLsyBSsmX8wudHrx4rBbgx
 NIAdJe85peLtFGbCTrXYtpA+u/aRlutVk5OcnjzKV+fhjexWnfyspR+bISQ3Em+/bwO2
 93Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294071; x=1777898871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+EHAWxwR5gtY8WCIFdHKUvBLUSjZ15ts5pSdgClXwsM=;
 b=YIZeaJ/EaR1Ry5Q0tmrA/qSBkBymp73flZ5oJ0TXrDj13rMs4KVLih4LapDhPrbcIU
 fXhgToElddF7DWuGih7nVWWm90Q+IJWkSsZf9P6wGrVB2aAsAEZlGKQRJ5iCvUfukoDs
 MpvYt+pXHXiuzI2xF1a55kukSm4piuh1A8E2N0TBtx8YSmkM5EzH+p1Sxu7rYyIGtbD0
 M2fre5S446ga/h5b3jxCzOGw5WBatjZmkCfQiBkOIwv0Gvy5jnZxSnCVD9opfJa7RvwZ
 c99t+Po7bsaKLJxgBB9WMVQAozs1SizO2CMq5KW+an1JvXIZ1ijnKYTRWVRDFFHx+KpU
 CP2Q==
X-Gm-Message-State: AOJu0Yz9mxfyMa73IK9apBZK9iWFz1tvf7aQM6St9/T+MLlPRp3BN0Fa
 YcQ0/U23UqVLflzHDcnhCfsCYQShlegSc1DkBlfakArSI8HNHeL1vWDwKLICs2NfZpz5Z3wYBY1
 H/NOX
X-Gm-Gg: AeBDies+iN1WDfaNvgqcYw+ohX1uNP8AdHdqRQSnBvUOSMGYb7Wq/+NDAcW/siPiBkI
 8ITGBJCyeTzurbdFN82K/51FRaKRkhqGy+7vBJlzFkkHXGy1IzhWCHaFioDGpOWqZjQBWtBvZHa
 mk7l4T6bxHUdCXQxc2TyWmFH43dE6gFjrwCj/wCg556ueArpd1wPFcYnkwJzNoOSZoBg6j6uH8x
 sLrg2e+eJdsB1isOacKwqlP6XLZFnbRj6BgdVCwajFq2Hx+dlePt63E3HJc2IzFxYlzokTADrYf
 jA5K1ThYxhBW5Z+xgkhtjs7klb/1tBJug/DxrJXOfH7DtYRU6M5ycM7oyuyKr1672mgYjhYf6PO
 ljzJiTF+j/p3FcJZv3X5yTSmPJBe/AjFy4vMtblyU9pr6TasirRY2Kh4TiD3sjTKNnfq0gQTRaT
 wm6k7LlNpF3WZitH8GpG9W5NEa8a/dCumE0BNNJBl8UjHymk+uRDn06zTyo1I6FWQSkw1gXVTT9
 rABxU2s0W8ES26md5F8XzMJ9N1Cidtk07Bmw4TmmQ==
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr620309785e9.28.1777294070562; 
 Mon, 27 Apr 2026 05:47:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/63] hw/arm/fsl-imx8mm: Adding support for General Purpose
 Timers
Date: Mon, 27 Apr 2026 13:46:47 +0100
Message-ID: <20260427124738.966578-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

It enables emulation of GPT in iMX8MM
Added GPT IRQ lines

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 54 +++++++++++++++++++++++++++++++++++++
 hw/timer/imx_gpt.c          | 26 ++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h | 11 ++++++++
 include/hw/timer/imx_gpt.h  |  2 ++
 5 files changed, 94 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 42901c4383..44dd401c8a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,6 +626,7 @@ config FSL_IMX8MM
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_I2C
+    select OR_IRQ
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 34645555d6..3736191257 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -180,6 +180,13 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        g_autofree char *name = g_strdup_printf("gpt%d", i + 1);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MM_GPT);
+    }
+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
+                            TYPE_OR_IRQ);
+
     for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
         g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
@@ -385,6 +392,52 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
                                 &s->ocram);
 
+    /* GPTs */
+    object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
+                            &error_abort);
+    if (!qdev_realize(DEVICE(&s->gpt5_gpt6_irq), NULL, errp)) {
+        return;
+    }
+
+    qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
+                          qdev_get_gpio_in(gicdev, FSL_IMX8MM_GPT5_GPT6_IRQ));
+
+    for (i = 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        hwaddr gpt_addrs[FSL_IMX8MM_NUM_GPTS] = {
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT1].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT2].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT3].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT4].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT5].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT6].addr,
+        };
+
+        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_addrs[i]);
+
+        if (i < FSL_IMX8MM_NUM_GPTS - 2) {
+            static const unsigned int gpt_irqs[FSL_IMX8MM_NUM_GPTS - 2] = {
+                FSL_IMX8MM_GPT1_IRQ,
+                FSL_IMX8MM_GPT2_IRQ,
+                FSL_IMX8MM_GPT3_IRQ,
+                FSL_IMX8MM_GPT4_IRQ,
+            };
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+        } else {
+            int irq = i - FSL_IMX8MM_NUM_GPTS + 2;
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gpt5_gpt6_irq), irq));
+        }
+    }
+
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
         static const struct {
@@ -555,6 +608,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_GPT1 ... FSL_IMX8MM_GPT6:
         case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
         case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 168cadcb3f..cdc0257126 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -6,6 +6,7 @@
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois <jcd@tribudubois.net>
+ * Updated by Gaurav Sharma <gaurav.sharma_7@nxp.com>
  *
  * This code is licensed under GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
@@ -137,6 +138,17 @@ static const IMXClk imx8mp_gpt_clocks[] = {
     CLK_NONE,      /* 111 not defined */
 };
 
+static const IMXClk imx8mm_gpt_clocks[] = {
+    CLK_NONE,      /* 000 No clock source */
+    CLK_IPG,       /* 001 ipg_clk, 532MHz */
+    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
+    CLK_EXT,       /* 011 External clock */
+    CLK_32k,       /* 100 ipg_clk_32k */
+    CLK_HIGH,      /* 101 ipg_clk_16M */
+    CLK_NONE,      /* 110 not defined */
+    CLK_NONE,      /* 111 not defined */
+};
+
 /* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_set_freq(IMXGPTState *s)
 {
@@ -570,6 +582,13 @@ static void imx8mp_gpt_init(Object *obj)
     s->clocks = imx8mp_gpt_clocks;
 }
 
+static void imx8mm_gpt_init(Object *obj)
+{
+    IMXGPTState *s = IMX_GPT(obj);
+
+    s->clocks = imx8mm_gpt_clocks;
+}
+
 static const TypeInfo imx25_gpt_info = {
     .name = TYPE_IMX25_GPT,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -608,6 +627,12 @@ static const TypeInfo imx8mp_gpt_info = {
     .instance_init = imx8mp_gpt_init,
 };
 
+static const TypeInfo imx8mm_gpt_info = {
+    .name = TYPE_IMX8MM_GPT,
+    .parent = TYPE_IMX25_GPT,
+    .instance_init = imx8mm_gpt_init,
+};
+
 static void imx_gpt_register_types(void)
 {
     type_register_static(&imx25_gpt_info);
@@ -616,6 +641,7 @@ static void imx_gpt_register_types(void)
     type_register_static(&imx6ul_gpt_info);
     type_register_static(&imx7_gpt_info);
     type_register_static(&imx8mp_gpt_info);
+    type_register_static(&imx8mm_gpt_info);
 }
 
 type_init(imx_gpt_register_types)
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index fd62b19a87..607ac86666 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -18,10 +18,12 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/timer/imx_gpt.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -36,6 +38,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_ECSPIS       = 3,
     FSL_IMX8MM_NUM_GPIOS        = 5,
+    FSL_IMX8MM_NUM_GPTS         = 6,
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
@@ -48,6 +51,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMXGPTState        gpt[FSL_IMX8MM_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MM_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
@@ -60,6 +64,7 @@ struct FslImx8mmState {
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    OrIRQState         gpt5_gpt6_irq;
 };
 
 enum FslImx8mmMemoryRegions {
@@ -192,6 +197,12 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_I2C3_IRQ     = 37,
     FSL_IMX8MM_I2C4_IRQ     = 38,
 
+    FSL_IMX8MM_GPT1_IRQ      = 55,
+    FSL_IMX8MM_GPT2_IRQ      = 54,
+    FSL_IMX8MM_GPT3_IRQ      = 53,
+    FSL_IMX8MM_GPT4_IRQ      = 52,
+    FSL_IMX8MM_GPT5_GPT6_IRQ = 51,
+
     FSL_IMX8MM_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MM_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MM_GPIO2_LOW_IRQ  = 66,
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 7f0d55b349..b5d73c5e4b 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -6,6 +6,7 @@
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois <jcd@tribudubois.net>
+ * Updated by Gaurav Sharma <gaurav.sharma_7@nxp.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -81,6 +82,7 @@
 #define TYPE_IMX6UL_GPT "imx6ul.gpt"
 #define TYPE_IMX7_GPT "imx7.gpt"
 #define TYPE_IMX8MP_GPT "imx8mp.gpt"
+#define TYPE_IMX8MM_GPT "imx8mm.gpt"
 
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
 
-- 
2.43.0


