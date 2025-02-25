Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE74FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLA-0003BO-2G; Tue, 25 Feb 2025 13:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJh-0000Gd-1K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJc-0002MD-IJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so38048885e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506755; x=1741111555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WbwJf6Ufk9A1VkvSglXgDxIqPBXLdVmrbehQ439hljQ=;
 b=XzCtJT/WIVhXnU6UB3T3Nii66US6iDDSUvLgcX7tlcKjjPQ5Cb+BJNG/KEsSY0UbOv
 RWsO8OQC7/G8s/RS6I2PNxHN7Rak1dk4nEDOybWg565tbM6bCAIDEW1QQzk6+iLk8OeA
 QN6ONDjuTGYmILOO8Jum30nINmeq4SWQUmuyVYn/+bUHdAfKbiAQWe6xK5kiCuSO4G25
 H5CsW3sp+EYPOLR48oOAmRWImZRTACE0JqT3k/7Q/94aDqYsMlWF1Aw1QZKU2Z44xUzt
 Hox2JmZL+3bSpOnC1XhDgOd7nu7o39HMIICnSPnU7Rz+xt6DOmCy6NljND0NO3OYyS8G
 qkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506755; x=1741111555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbwJf6Ufk9A1VkvSglXgDxIqPBXLdVmrbehQ439hljQ=;
 b=iBIyepZmwINaAl34owDNT2tpZNew2V7DEzG47RxQa6i5m2fI3h1gsFaS99OYhjKzHR
 mJxR6TWftBqsDCltSUpTVjhAwHQvlZBMQJoLBXU9P3zyAtCt407ObyEtby6MR2ElJdKk
 DD0VX4/yQ/GYBsTDTS9dnd3VSIVHsWFO+lAcUvcd/68EfmFlGRKIH1o0k6ESJhNpfVEH
 C515TUdudsaohqjhc7zsqDVczxfn0yaXcfgBrj4CKLdfQ5hbszInYWnUbc1FKsIN2guV
 qynJaGgy4/avW5t4e/K20mxqcks4YXLGaIaVMC7hD1dS55LMQsGA2etesUCSqh33UoXl
 AFvg==
X-Gm-Message-State: AOJu0YwyGVvFnPtWomO6kg9tEOB41JFAQsCco+Hmmd0UTem2taeDK7RO
 Vv9mxDfvrxET4zTem4GFzMPWC8+epYi4UcwwVgIF5k5FQNnPjpul/rMxGsaZd96mHJRAZsefydn
 F
X-Gm-Gg: ASbGncthrbQ7nsyYTm/jmC9lCn9g/nXZ2QKF0qpxsri9UIc1mQC1E5XXZiB0xagdm51
 JGoliFXwHVmRiPELWR8+amh+UeeJhS9nDaDatfiq6/ZVlCoAIlT+ekWHzRz1X0726ff3cKGBu91
 gpu4uZ5pw93wC8GkKEVRW1q/fCAESXSWC/MLpyrO5O41E24rS4DSTsr0SphospYsElA0tasEIrd
 tLDsonIE5nyKH02FnaFeTPXBiT4D7AKOqjYo5WLjCfrZR9t10cHnuT9phnkx8+yRO+HmE5RiZsL
 R4LrVJDTHjnreCqG8UXtYq5C9exzW9Hy
X-Google-Smtp-Source: AGHT+IHZwF8GjHjyoWrcUrdIRNWFNG2OidYtnZQHzcce/P94YnG8kXT8N2cLel4AcFMlwkRHg0meVQ==
X-Received: by 2002:a05:600c:5125:b0:439:9828:c422 with SMTP id
 5b1f17b1804b1-43ab8fea14fmr4805945e9.18.1740506754739; 
 Tue, 25 Feb 2025 10:05:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] hw/arm/fsl-imx8mp: Add I2C controllers
Date: Tue, 25 Feb 2025 18:05:03 +0000
Message-ID: <20250225180510.1318207-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-11-shentey@gmail.com
[PMM: drop static const from i2c_table for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++++++
 hw/arm/fsl-imx8mp.c            | 29 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 37d3630d09c..ef0d997250b 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
+ * 6 I2C Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 18ea52d0839..25900566272 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -45,6 +47,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     DesignwarePCIEHost pcie;
@@ -205,6 +208,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_I2C1_IRQ     = 35,
+    FSL_IMX8MP_I2C2_IRQ     = 36,
+    FSL_IMX8MP_I2C3_IRQ     = 37,
+    FSL_IMX8MP_I2C4_IRQ     = 38,
+
     FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
@@ -216,6 +224,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_GPIO5_LOW_IRQ  = 72,
     FSL_IMX8MP_GPIO5_HIGH_IRQ = 73,
 
+    FSL_IMX8MP_I2C5_IRQ     = 76,
+    FSL_IMX8MP_I2C6_IRQ     = 77,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 541e4ab5b63..750dbf9eab9 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -208,6 +208,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -360,6 +365,29 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MP_NUM_I2CS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C1].addr, FSL_IMX8MP_I2C1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C2].addr, FSL_IMX8MP_I2C2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C3].addr, FSL_IMX8MP_I2C3_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C4].addr, FSL_IMX8MP_I2C4_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C5].addr, FSL_IMX8MP_I2C5_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C6].addr, FSL_IMX8MP_I2C6_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
     /* GPIOs */
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         struct {
@@ -470,6 +498,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index be5a2c02b74..28ae409c859 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -595,11 +595,13 @@ config FSL_IMX7
 
 config FSL_IMX8MP
     bool
+    imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.43.0


