Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD72C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASg-0000GY-1N; Sun, 23 Feb 2025 06:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASY-0000BO-Sp; Sun, 23 Feb 2025 06:47:49 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASW-0005yd-4k; Sun, 23 Feb 2025 06:47:45 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so5370340a12.0; 
 Sun, 23 Feb 2025 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311262; x=1740916062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2Lu9A9jLJSYcD9Ycgwlq29IFJMPy7IYKeGsJPX571Y=;
 b=S/BZkq8WPERKNmw6LlgoaqkcVKRtuxWSPf7BNyxw4Jisrl0hv4oZd449zfcrZDJk2A
 JPjUruU/pDvaNeoVXTfHx/K5XDhRPid3IB5nOOTIN7bcNgSox+4X+dwyAZYsISm3zgRH
 ikKYbS+6vDRRfh3ekv3rOM8SNsfnf8c2CJ8PiURtRcjkKeGl/UISkedKzNKFSqd66/yI
 0j9NTWPkp/HhfwjZ4Avxx6wjOZUUgjneGdfHD6nlXaFJqcNrqyMHzQCU6zFZuQQkORs5
 s5lBNMRxX2VRuWDbecuzzi3s3T/QXQvEqXezMADtKHwZZ9Yn0eoK4igP1nPohc7O5ONg
 HvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311262; x=1740916062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2Lu9A9jLJSYcD9Ycgwlq29IFJMPy7IYKeGsJPX571Y=;
 b=fIvWS6Fu0xoGxzY5zgjI2Ury2w3xtWRon48BlH9DEYwaCg6CUQw2P0JhqT2HHC4doe
 blSjeJBHiNS/lQnUBhsqU4FNQ5bh05pMpPFzNBfHpsowZFz4JJJUERZq8R+gdwt5p+Zc
 jz66C0GOtXxyVLQZc1mNyBaU8RK3RMgjFCRS14sfC4wusrYsSRdH+kzqqEz1abh4+lAB
 gWa9221psDysI/CvJyU9dCtljCC6VIAxSdFFGHMWYfb6hqChuW3+37r5FZsg+/A1aakd
 wB4qRkVGOtnE4TRLiGeNH2y+Xvw/Czx7ksT0SIckrepjp2fSHfRbzIdpZXaSTIgqG49/
 GGVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPcRPFSBAWPOVXUnhE8mJKaH63XAy8sQLGQvOCW1pAb+yWc6Ph5vKqXJFo2TzMnfnOa5ZB/pmfCw==@nongnu.org
X-Gm-Message-State: AOJu0YwRvmqHsPmC4xwozMQ2RhkeiCsClnIyx7uCFD/SACrlqRbKRGEd
 zHv1CQJAEWaBzdCzzVIMoIhWmesgBtEEFdkOb0B41E/wLTIOG3ZDSO//Tg==
X-Gm-Gg: ASbGnctevabNx1bsM7BKqtbtuBPk9s8e9lGFCWi2tjrXUtDK0kIT22iB2SV+QFAxGo8
 bgbioq1T4mrY0ITUHXhs9NMtP7tccNV1LlmaWOnlmMZ8ay0Lr1GPGDgOP1O7BC0YxgYXaVoW8+m
 phsNtR4P278rFqyldHtvVNRovfOeTpG7sV/dbcclQhr/GaopVV3XCxQ7d+I4P1UYIB497ul1BOg
 URQxZ/tomuVk2Qoy7/7A/cfOj65r3KUTKdExGdczQfl7CgrySsEnGmqglLsvkyVDQyjUrwhiH0A
 8jR8jB0ZghomQtQupx0lnP6v2h9YuNiDwfdzISHvyWrOkRcz3cuDiOT1TQI8GqR0u7+yYNk/1km
 9LAleaXzEwHl2
X-Google-Smtp-Source: AGHT+IEZyehzgJvX8Pxn+d2CghgSjqPakCH/YuvK/lUGgghPgsxJqMt4GTvCPFNfER7tYWkh+EV4Xg==
X-Received: by 2002:a17:906:c243:b0:abc:269c:56d5 with SMTP id
 a640c23a62f3a-abc269c571emr566792566b.40.1740311262017; 
 Sun, 23 Feb 2025 03:47:42 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:41 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/18] hw/arm/fsl-imx8mp: Add Ethernet controller
Date: Sun, 23 Feb 2025 12:47:04 +0100
Message-ID: <20250223114708.1780-15-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The i.MX 8M Plus SoC actually has two ethernet controllers, the usual ENET one
and a Designware one. There is no device model for the latter, so only add the
ENET one.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 24 ++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            |  1 +
 hw/arm/Kconfig                 |  1 +
 5 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 4b195c917f..917c1d5176 100644
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
index 975887751b..e292c31a3d 100644
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
index dcf67c5889..935279ee68 100644
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
index 27d9e9e8ee..e1a7892fd7 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -36,6 +36,7 @@ static void imx8mp_evk_init(MachineState *machine)
 
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e83895b91..4d642db970 100644
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
2.48.1


