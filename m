Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F19C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzMQ-0000Qk-4Y; Tue, 25 Feb 2025 13:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJw-0000RY-MH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJq-0002OF-AH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so37566815e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506759; x=1741111559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CdhYELjdhtIlRJlP+fLG5Avb1MqK3kT9d5wcbVshIzU=;
 b=xKygLTuQk6IlzgdrU1TsNeprq0ssn07EL3VEEybcmJ5YkXsA8jEkNKpib5sNHI19Xk
 9INucgxy6h2IpJUBDtSWdx+hbckE4CMIIQApBHs6E1oxs/wyLA0C4dJY5a3ZxchcbatM
 LdNlF5z4aOBM+o+hdCQuY/Mhe9yqR0U/OoHaNPafEL1IchlM9UIHs8ehbsl0O5Ha3AMe
 SlHFLrJi5nNGDuz22G4/QC3vYUHfGRxvgJD54yhwVyt7f2LijBiUbGkVzGoBXk8EOfdB
 6K7K+4UY+lPVdGJMQTu2c7wcoZZB6/xxYD8Zv7cw/q1YHyObf38c+Tb88DSmpGL+jEhX
 We7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506759; x=1741111559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdhYELjdhtIlRJlP+fLG5Avb1MqK3kT9d5wcbVshIzU=;
 b=f1GnOFphJI4yIzxcR32vkMzvNrRiWM0bkpvHWm1fTmaN+lhV1roJvP71XaFcGdFWc2
 Ckp0Tq4lv8lL7Rnp3hVLEYkpTI5C0Anv/9PQcfBCiyVswIu4NUmarxmujYNfd6ypsyTr
 aitkIor6CAT6b8+7gb0Tt//CY6w9OsvoifCDpvtjUYZ53IoyxOB08krpSsOMKfAONOSu
 BzK6Too7mxhMjsWSkfPhdvjgA9cVQJy/dp+VWNaCaDDNfivzePA0h3wJBPgifo0Brj91
 6f9gBBPRVyWmSQqzDN93C4zbuLnruxtOl2x855+gWTqwkfNk0AfW5FrVDSJ/2z48spDI
 5nzQ==
X-Gm-Message-State: AOJu0YwY5tBhUoouCZDs7YOyet+YPnFOpZfI4yIvZeQCHI4B6S844jO8
 Bc3QAJipOh4cTT0DAFDMXO3cJ4Z7Klco1fbfEvOdDS+vRjg/fB4AgkjWfmS+WX8XfBWR443riFY
 e
X-Gm-Gg: ASbGncuDDTIyYUmpd4bh/uWpFwlbdKnp2R7P9Uh2GRJfo8pkReNVfAUWXBe7QPqJGTx
 DZ9XpV29qgEiUCcxgSY8sQodQEBmj/zzMbFYSLdru2rAyqJN8NAmNLXi5w3TkQGGAirrcyYvALq
 dU7ROrZd3GUxM3oteCEeZ+CpgXPbf4Hv2B25A7RYTfiS8Y14ZZTL/KPx7AYfdWAkiUfgiqbP5Hw
 fU1DLFV5Y/VWY/h6+x4GFmW4r+JEzYwfAFbL7kjpZgUTv4ACjqGEbDRTIFclzyuWA7di+ZGGIZ9
 wdAozs9UmYfPsNed6Vq9GiMzmhDNEnmh
X-Google-Smtp-Source: AGHT+IHBbLNGTLydnlsTpelMjBb32RJHM2crppdbSLJBe7sATt2gfy9bbfXRRGwpg1MOcJSnR3CGGw==
X-Received: by 2002:a5d:6da5:0:b0:38f:2a53:1d78 with SMTP id
 ffacd0b85a97d-390cc5f6a73mr3940093f8f.10.1740506759072; 
 Tue, 25 Feb 2025 10:05:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] hw/arm/fsl-imx8mp: Add Ethernet controller
Date: Tue, 25 Feb 2025 18:05:07 +0000
Message-ID: <20250225180510.1318207-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The i.MX 8M Plus SoC actually has two ethernet controllers, the usual ENET one
and a Designware one. There is no device model for the latter, so only add the
ENET one.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-15-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 24 ++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            |  1 +
 hw/arm/Kconfig                 |  1 +
 5 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 4b195c917f6..917c1d51769 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 4 UARTs
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
+ * 1 Ethernet Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 975887751bc..e292c31a3d0 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/net/imx_fec.h"
 #include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
@@ -58,11 +59,15 @@ struct FslImx8mpState {
     IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+    IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+
+    uint32_t           phy_num;
+    bool               phy_connected;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -253,6 +258,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_WDOG2_IRQ    = 79,
     FSL_IMX8MP_WDOG3_IRQ    = 10,
 
+    FSL_IMX8MP_ENET1_MAC_IRQ    = 118,
+    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 185c32ee587..2dd3c97a02e 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -240,6 +240,8 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -542,6 +544,21 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, spi_table[i].irq));
     }
 
+    /* ENET1 */
+    object_property_set_uint(OBJECT(&s->enet), "phy-num", s->phy_num,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->enet), "tx-ring-num", 3, &error_abort);
+    qemu_configure_nic_device(DEVICE(&s->enet), true, NULL);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->enet), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->enet), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_ENET1].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -604,6 +621,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
+        case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
@@ -624,10 +642,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const Property fsl_imx8mp_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
+    DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+};
+
 static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx8mp_properties);
     dc->realize = fsl_imx8mp_realize;
 
     dc->desc = "i.MX 8M Plus SoC";
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 27d9e9e8eed..e1a7892fd7c 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -36,6 +36,7 @@ static void imx8mp_evk_init(MachineState *machine)
 
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e83895b915..4d642db9705 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -601,6 +601,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_FEC
     select IMX_I2C
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
-- 
2.43.0


