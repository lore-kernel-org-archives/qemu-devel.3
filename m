Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51700C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLN-0004NN-Ar; Tue, 25 Feb 2025 13:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJr-0000Ox-Gp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJi-0002ND-9q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso501645e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506757; x=1741111557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zqLNsK4T5WhvJfF6fOD0iLHLs1+ifW05y1H6VNCDoMk=;
 b=uaxV+V3mLhhmR8bCl06LTn3xKEW3MlA2imRvCxy80qTcMlj7wSAUcs5MS84AVZtTic
 G1YwcaOVzs8SfnxkptNe+qzbw7gDQNEOeAsHbcuHfIMoqqs9hnsQKpadvU9HT4uLhFTf
 j62aHOoUSePxVzhZVfksqIKI2/7Bf4Pt0I9eosVIfKhEEJLmDKEC1qkCMWN+a+7fa61w
 e/+/dWwS3ILR3ASs74u9ni5tBe6ucay+rgt33Gj1KgfUIu5yYBcUPoSnR5QrZ8f18qGG
 sVydaxIflByPO+qo3hilrroGVTDDlFPcGrAdZYmTFfnOj7h8t1VYxQGE/xsZyYFQ4Z+s
 Eykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506757; x=1741111557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqLNsK4T5WhvJfF6fOD0iLHLs1+ifW05y1H6VNCDoMk=;
 b=qBtODqfk9tFG+Co/qMcqrna2EvwBeAtzjLO7UGxvHB/viKERdUZPAUvSQYqx4zokIX
 TZCl4ak+1762UCDpgXxt0BWtz41Lm7cFfv0d4YfMTLIMNdi3Oo+v1Hsu+MBR0eusxGYG
 l5UDFWzbTAqiKB1CR9wjKsfAGDAnmQ9ytd6fgqXgIikgJus12FKAd3OZLG3aleR+bmYi
 PiPmtJvoY3LV37cuIK6f4+pzsCagYm/Zmdcc86YklI3bAovcLuxti2nc4QfUnYIZ+tx9
 tKpvr2qU2ptwyYR8rtrun7h9sxd4G5amWsclrU0OPj8jZx5hUqyZ6SbElImYoLsv6H6u
 8aNw==
X-Gm-Message-State: AOJu0YzT0oV8eceWShjGldllc101FNeh5OuATojX8TMNQQFEihzDjtl6
 Iuup0X0NFqunQEItKiLG3QU+b9DWbBs+a2CajG3BHqbmaCEC6WHdsj3Due7h0pBz43vBeKOHPWX
 f
X-Gm-Gg: ASbGncsYEZOvcu/Zg6UGCHFPowk4yBA333H4tHpcqUDmtBFNOFRCaDFYfgU8bhh2r/P
 PXJB2AqPNq+hYe5FmOf4y2RtwsWY7OnrjzwMRKL2RuUYJApKsXUDdmrjtI2zKrvkLDhgm/uUjLr
 Va6sBRtS8KH1WvJoZL9ytMW2wjPqTIFOvzINdadmv2pd7W8a40BSlAg3RccvwMOaCPKdOY+yJq2
 mkLt4v04c61KAeB1Oe7Fsfsvw2p/V/41SqcW7S5tSf5c6kNAT20eEvE4HcfA33NVlos79er9Eoh
 diVMsDF3GEOR1j2v/nEgBx5ijyRKiaKB
X-Google-Smtp-Source: AGHT+IFK9FLrPD0UTukyMyXGEo15G1HXkGrRh0B9sHggrn5d3jmrnF5mtp00J7LKqXcnNx5TCGK1yQ==
X-Received: by 2002:a05:600c:6c46:b0:439:81e3:43ee with SMTP id
 5b1f17b1804b1-439a2fb3256mr162851545e9.6.1740506756635; 
 Tue, 25 Feb 2025 10:05:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] hw/arm/fsl-imx8mp: Add watchdog support
Date: Tue, 25 Feb 2025 18:05:05 +0000
Message-ID: <20250225180510.1318207-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20250223114708.1780-13-shentey@gmail.com
[PMM: drop static const from wdog_table for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 4 files changed, 37 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 66e58651079..904de9aa7df 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -17,6 +17,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
+ * 3 Watchdogs
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 296a87eb504..dfbdc6ac7f2 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -21,6 +21,7 @@
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -38,6 +39,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
+    FSL_IMX8MP_NUM_WDTS         = 3,
 };
 
 struct FslImx8mpState {
@@ -53,6 +55,7 @@ struct FslImx8mpState {
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
 };
@@ -235,6 +238,10 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C5_IRQ     = 76,
     FSL_IMX8MP_I2C6_IRQ     = 77,
 
+    FSL_IMX8MP_WDOG1_IRQ    = 78,
+    FSL_IMX8MP_WDOG2_IRQ    = 79,
+    FSL_IMX8MP_WDOG3_IRQ    = 10,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 63f07eca8a4..762f2a52d8d 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -228,6 +228,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_WDTS; i++) {
+        g_autofree char *name = g_strdup_printf("wdt%d", i);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -491,6 +496,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
 
+    /* Watchdogs */
+    for (i = 0; i < FSL_IMX8MP_NUM_WDTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } wdog_table[FSL_IMX8MP_NUM_WDTS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG1].addr, FSL_IMX8MP_WDOG1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG2].addr, FSL_IMX8MP_WDOG2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG3].addr, FSL_IMX8MP_WDOG3_IRQ },
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
+    }
+
     /* PCIe */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie), errp)) {
         return;
@@ -531,6 +558,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
+        case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 28ae409c859..98ac93a23fc 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -606,6 +606,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select WDT_IMX2
 
 config FSL_IMX8MP_EVK
     bool
-- 
2.43.0


