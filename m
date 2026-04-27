Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5454FF886A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUq-0001pk-5x; Mon, 27 Apr 2026 08:55:32 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLSi-0004Ni-Us
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:53:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNQ-0005V6-Ua
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso69164705e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294071; x=1777898871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yll8vYw1Tp+HhU64tIRrgi8mV4trivQQ7v8Vnew7iqU=;
 b=jpfGwPb8LPHNswSyVaLddyh4gZo1tFOH1J9nGSB64Soq3VvctZ48br9/jUJ6MTfroh
 5vZzBYS9P7Bne4a6GTpqrY8n5kDy35kJsc5kf1I3pvH5KH3aAmDeY1HbEEFchSrFvZcD
 Z9zluUwQjEyAz/oRQ2GyIU2j48ZU4RbFX7DLFF5tEblVnmvD07cAeXe1wI9x5V4uSlPQ
 ntT65paPn44+ROzXUQhU0g+29BSDKA3Y+djMQHixKavCWUOPI/vO69tcdyzeb2L/D136
 9G82rAHnKBuvTygNcOURXoeSL5lfWr3Sxi53FGrE0GP4chqm4fqui4l+viMZvN7hk4Ae
 AGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294071; x=1777898871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yll8vYw1Tp+HhU64tIRrgi8mV4trivQQ7v8Vnew7iqU=;
 b=ASykjOB1dFh3dDZklHIyBgZJrdrjxpc1XhIGC0ehKchomRc/rZ6XCPYBAeTF9L8Qo/
 /EiZm+WJzJsAdRzf7afwRZWwppspyJAFnpVJPjP/nxaVq0aREIxIJL7Qfv1lAcMMM8Cj
 90AuPGBvmMiA3rnj3wsyESwGC7Ugl6vAzs1J8mcU+m8F1ajrICPeUr3sR5mvz3AP8Rpw
 Yt96cTuXQMxbDkmBBzvOIojR+2kSOtyvQyscz8VjL2dvf1IRWdqib+MA126JHHH9Yeis
 rmF5y7IjFeXZRplz4ZGjmKvebbecQ2+U9gF1zA/vDGu7W1ggkJOoLA/O34QY1GtFohY0
 CxXQ==
X-Gm-Message-State: AOJu0YwiJg5QoPCZw4nXTSlYh5zmlTjdeM9K9A5b/Vug17eu4kW23Mm6
 Z8UwIZyhUVA3fiTOG4ANKH9nXbBPayNCKtLDNzCgt7vzI1uePZXOpxs8zfcP2B4W2VuQT1kftOz
 3M1Oi
X-Gm-Gg: AeBDiespKTKIYLfKGHhBoGC41a9Ane8hfF5DJvwbDHtUyBCwGdjAMze5a7KZKGLpsKl
 3CvdSxHr52oPe3TE/2t5lfmMsJ+Doxuxo2Q5PZyZ26Q8uQTBEWRu3LNKjf4UVn7OX2etszpFOa7
 KMhKKRq37WDX8724X2dXVzPKEB6TUmRa7sOVDDFLR1FzltQMrSyUUY/54kAcXZ1urMKJFY6k7wy
 txNWIgiJHqPuEtxPXG6GaFONcrm5t2dBrCEuaBvjd7DFoOHxRkrsUVxfhPb5kWSRDfAUd6i27cX
 ypBLZm7UCPqLSPl+nn4F0jC2Aplbqm1//j89/DHSCUqpJgl/HReiNHJRavF1dybEwbkltdGFfIw
 v8KzJvSLROsYrARnbgtnlIIyySzhAcG/vsvP+MM7jrq+h15y20RMkBKqh+USmu1JKkZ5PDET7y2
 8GXk23PSiG/b1Q0Ndi1hkvnAC4NCBmaY2e5PDsh8ITQeAi9wHnca/j+hXadn21VklFWk/YXeYLb
 vkraDlIO2A8EoUCiNf9gz00m5FcceFMTok/+ThgUw==
X-Received: by 2002:a05:600c:8588:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-4892005b4e9mr301138385e9.19.1777294071347; 
 Mon, 27 Apr 2026 05:47:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/63] hw/arm/fsl-imx8mm: Adding support for ENET ethernet
 controller
Date: Mon, 27 Apr 2026 13:46:48 +0100
Message-ID: <20260427124738.966578-15-peter.maydell@linaro.org>
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

It enables emulation of ENET ethernet controller in iMX8MM
Enables testing and debugging of network dependent drivers
Added ENET MAC IRQ lines

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 24 ++++++++++++++++++++++++
 hw/arm/imx8mm-evk.c         |  1 +
 include/hw/arm/fsl-imx8mm.h | 10 +++++++++-
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 44dd401c8a..104954d90d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -625,6 +625,7 @@ config FSL_IMX8MM
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_FEC
     select IMX_I2C
     select OR_IRQ
     select SDHCI
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 3736191257..f1c173dbec 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -212,6 +212,8 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -547,6 +549,21 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
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
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ENET1].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -610,6 +627,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
         case FSL_IMX8MM_GPT1 ... FSL_IMX8MM_GPT6:
         case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
+        case FSL_IMX8MM_ENET1:
         case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
@@ -631,10 +649,16 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const Property fsl_imx8mm_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mmState, phy_num, 0),
+    DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mmState, phy_connected, true),
+};
+
 static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx8mm_properties);
     dc->realize = fsl_imx8mm_realize;
 
     dc->desc = "i.MX 8MM SoC";
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index dfdf3cd4f8..6b7774d3e2 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -79,6 +79,7 @@ static void imx8mm_evk_init(MachineState *machine)
 
     s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
                                          "soc", &error_fatal, NULL));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 607ac86666..bc5a0922ad 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -18,7 +18,8 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
-#include "hw/or-irq.h"
+#include "hw/net/imx_fec.h"
+#include "hw/core/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
@@ -60,11 +61,15 @@ struct FslImx8mmState {
     IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
+    IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+
+    uint32_t           phy_num;
+    bool               phy_connected;
 };
 
 enum FslImx8mmMemoryRegions {
@@ -218,6 +223,9 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_WDOG2_IRQ    = 79,
     FSL_IMX8MM_WDOG3_IRQ    = 10,
 
+    FSL_IMX8MM_ENET1_MAC_IRQ    = 118,
+    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
     FSL_IMX8MM_PCI_INTC_IRQ = 124,
-- 
2.43.0


