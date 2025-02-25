Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B0C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzMD-0007e7-MR; Tue, 25 Feb 2025 13:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJt-0000PL-0g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJp-0002Od-9P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so36688395e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506760; x=1741111560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vcx3zWAGrB6dLUXeCe9lss17zJ9Cf+qgt0qcq5k+Nkw=;
 b=zg9Fcs1E8P4Wzq2/9zGetsgOWda0RwQGNLUFv5rhOiHWpJkdZOZFlisWRJcG8vBNOy
 khqnt0Wuh4y9PAfALbOEgo+YKz5obzTpz0V8VOU5qNKo7lilU5fsnFAa718ym61ihXOG
 cHKj9a73kbPh9KeCo9sqJhgeSYX5Msl6cvIF31NbCSTF+dOiveCD9h6nIOzwwiX+L74o
 cI0czUm5+rP05eepID/bVkAd3Y7Uksgq+T6F53onsoWzeCG8Co74+mFjinQgk2GcpIUC
 pL6ZvJeDEoug7BVQnj4xjkJm2UzD0+kCFmFzLOv3zhPHHv8hA4DrhMxzBJpRcwP84wMw
 Fj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506760; x=1741111560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vcx3zWAGrB6dLUXeCe9lss17zJ9Cf+qgt0qcq5k+Nkw=;
 b=sfwj2DEAkt2XtCEHDOFWTss5AyLOnq+I7JtjZJlZpoy8Gyg3SuejU3k480qQiOINYq
 AbbIvq4YchDoAO7ukGFlh+yoR8LQGKeG8AdiKO8gZN4A6LNkKCGKaPPlb7/iM444Akv8
 Dbima+8Cnct++XPh5TRcgyP2X2cEGDuAa083S9b0Z3P8/WTOfVIhmmKYR4BYTEFIdaCt
 pd/9xCFBivNgqWiS269nYAraHSb6qmk/WkcrsvmaO7kFby756lbj9+/dGb9unVPYR2/e
 qWfPhJEPtEgdMa/XxUnHBQtGWg33yeDzMTpcEugogQxuNDFky6I5SUG7qL0qHA4Cp7SP
 jHng==
X-Gm-Message-State: AOJu0YyMRcsDRVX2Y6wr9aDUZWWb0DdSXSXC1VYY/KPBpl+OKl492laU
 3OhbIfTzgW1rOmtNqa3xxzA8Y3uuYcY/wkoEnRMyg7exg0sSVzT/6zk+ITAiWahiBmE/zywOM9v
 e
X-Gm-Gg: ASbGncsk1Gh6OgKzOyoL/m9/6pko4ZtSVCmA5gKvdj3mq2ApBwVBPu9hUzEiVqSDJwU
 um+8PaiSMOAXB7Vtt+jNKQ8jyUNgbsnkSwXSs6eWZr9J3F6PTgyJ7a4xkuit6GYF/PdCx/b7+si
 JtUbqtECrnnW9NWAFelCjfLNXhXQNr8T9ywt4LZkX9hdQUzsTxuawTvn+ybHdJF1AMwP85fnrKl
 dWefwMjMDmqcsWqJG/jOU6aUfwfr1vmfu9+1M/QYN+VDXyRfjQZNTiC+dsZmDie+ZtzeaGw4xZy
 ScE+GVWjiHDuxkdT2aJlQNNzVkRAo6kW
X-Google-Smtp-Source: AGHT+IGHTazHDI9FG3bXwgJZ/wbf8/vEjmHPovXracxfa9ZNEFC4xF9EwrCVBx2TJCJDAFhrhua7ZQ==
X-Received: by 2002:a05:600c:4753:b0:439:9a28:9e8d with SMTP id
 5b1f17b1804b1-43ab0f313a0mr40006925e9.12.1740506760130; 
 Tue, 25 Feb 2025 10:06:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] hw/arm/fsl-imx8mp: Add USB support
Date: Tue, 25 Feb 2025 18:05:08 +0000
Message-ID: <20250225180510.1318207-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Split the USB MMIO regions to better keep track of the implemented vs.
unimplemented regions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-16-shentey@gmail.com
[PMM: drop "static const" from usb_table for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 12 +++++++++++
 hw/arm/fsl-imx8mp.c            | 37 ++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig                 |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 917c1d51769..00527b0cbed 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
+ * 2 Designware USB 3 Controllers
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index e292c31a3d0..5247e972b88 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -24,6 +24,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -42,6 +43,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USBS         = 2,
     FSL_IMX8MP_NUM_USDHCS       = 3,
     FSL_IMX8MP_NUM_WDTS         = 3,
 };
@@ -62,6 +64,7 @@ struct FslImx8mpState {
     IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
@@ -199,6 +202,12 @@ enum FslImx8mpMemoryRegions {
     FSL_IMX8MP_UART4,
     FSL_IMX8MP_USB1,
     FSL_IMX8MP_USB2,
+    FSL_IMX8MP_USB1_DEV,
+    FSL_IMX8MP_USB2_DEV,
+    FSL_IMX8MP_USB1_OTG,
+    FSL_IMX8MP_USB2_OTG,
+    FSL_IMX8MP_USB1_GLUE,
+    FSL_IMX8MP_USB2_GLUE,
     FSL_IMX8MP_USDHC1,
     FSL_IMX8MP_USDHC2,
     FSL_IMX8MP_USDHC3,
@@ -234,6 +243,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C3_IRQ     = 37,
     FSL_IMX8MP_I2C4_IRQ     = 38,
 
+    FSL_IMX8MP_USB1_IRQ     = 40,
+    FSL_IMX8MP_USB2_IRQ     = 41,
+
     FSL_IMX8MP_GPT1_IRQ      = 55,
     FSL_IMX8MP_GPT2_IRQ      = 54,
     FSL_IMX8MP_GPT3_IRQ      = 53,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 2dd3c97a02e..0880f0c7244 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -40,8 +40,14 @@ static const struct {
     [FSL_IMX8MP_VPU_VC8000E_ENCODER] = { 0x38320000, 2 * MiB, "vpu_vc8000e_encoder" },
     [FSL_IMX8MP_VPU_G2_DECODER] = { 0x38310000, 2 * MiB, "vpu_g2_decoder" },
     [FSL_IMX8MP_VPU_G1_DECODER] = { 0x38300000, 2 * MiB, "vpu_g1_decoder" },
-    [FSL_IMX8MP_USB2] = { 0x38200000, 1 * MiB, "usb2" },
-    [FSL_IMX8MP_USB1] = { 0x38100000, 1 * MiB, "usb1" },
+    [FSL_IMX8MP_USB2_GLUE] = { 0x382f0000, 0x100, "usb2_glue" },
+    [FSL_IMX8MP_USB2_OTG] = { 0x3820cc00, 0x100, "usb2_otg" },
+    [FSL_IMX8MP_USB2_DEV] = { 0x3820c700, 0x500, "usb2_dev" },
+    [FSL_IMX8MP_USB2] = { 0x38200000, 0xc700, "usb2" },
+    [FSL_IMX8MP_USB1_GLUE] = { 0x381f0000, 0x100, "usb1_glue" },
+    [FSL_IMX8MP_USB1_OTG] = { 0x3810cc00, 0x100, "usb1_otg" },
+    [FSL_IMX8MP_USB1_DEV] = { 0x3810c700, 0x500, "usb1_dev" },
+    [FSL_IMX8MP_USB1] = { 0x38100000, 0xc700, "usb1" },
     [FSL_IMX8MP_GPU2D] = { 0x38008000, 32 * KiB, "gpu2d" },
     [FSL_IMX8MP_GPU3D] = { 0x38000000, 32 * KiB, "gpu3d" },
     [FSL_IMX8MP_QSPI1_RX_BUFFER] = { 0x34000000, 32 * MiB, "qspi1_rx_buffer" },
@@ -230,6 +236,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_USBS; i++) {
+        g_autofree char *name = g_strdup_printf("usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
         g_autofree char *name = g_strdup_printf("spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
@@ -524,6 +535,27 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* USBs */
+    for (i = 0; i < FSL_IMX8MP_NUM_USBS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX8MP_NUM_USBS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USB1].addr, FSL_IMX8MP_USB1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USB2].addr, FSL_IMX8MP_USB2_IRQ },
+        };
+
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p2", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p3", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
+                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+    }
+
     /* ECSPIs */
     for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
         struct {
@@ -628,6 +660,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USB1 ... FSL_IMX8MP_USB2:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
         case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4d642db9705..faa00d1db3b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -608,6 +608,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MP_EVK
-- 
2.43.0


