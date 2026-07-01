Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C6C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf3ii-0001jL-7r; Wed, 01 Jul 2026 18:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ig-0001ib-WA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ie-0002b9-TE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so762424f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782946067; x=1783550867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jr7fpk6r8PJKqJlH40O3F6Precy1BYqv9tpDnBOG2xY=;
 b=b11vwGvVJ9J7YA66xJR5UvVsT6nsnRVj6mQ8iC6O4CNDjgZt5r8yvg93nEL10rDUH0
 DpKyW2ulQa4+RSIBaI2FN+uJEmSSSuVre1XbOd9C0ZDK6K28c1l3Dkiu9yD4yoBjVmgp
 3HSKDMI/SzlTzZS4hkzotfrTkSLdJWF593a6dU3kHJn5JWm8KtDVZa63qqf/MCX6yH0O
 RN8UyvPu42cb9Co62wIgVScp4ytsU8U71E1U6QzTQ6gR1DthieLEPOL0zNjzbAHYI8o5
 dlD4b01pUF8CeVTO86ShfHbY55A0fI0UBO6bMCc8/ejP2BNxrl2Z0+HbS9LBKKGAoGur
 RF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782946067; x=1783550867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jr7fpk6r8PJKqJlH40O3F6Precy1BYqv9tpDnBOG2xY=;
 b=n+f+FI/cMIFvMN0kjTd6DVv/rzSmO2/MFlSDFy9a+2jbaIdwgY16MsY1WivbeAkTuf
 VrYfW8wdS4sEppb/82lMAhZpUyuD4gGImEmVxedaA7RqIDyno97DtqOBz/LOn6va/e4g
 0eidMv+uLgYr8N+yGl+66D8TAE5AU4E4Yt11YRNCQf+TlN0CAZy2hZIpHMvY1zCu8ISc
 oZbJd4v88U45qvQAPBsd3A2Mx51VRFO7WBA8hy+MCkYmAgnyKoZhvdsBJpqUULouWYC2
 /fcEPHtWkThLKq1/tWR/8p4/s7Ssv+SHIwNcW3sHGL8d4CmvzVKf9BuS3IsV7gZ99nws
 UOxw==
X-Gm-Message-State: AOJu0YwmWpaC20vyaP9d8dOeoCnVxIXwRby7UuG7U8V31tp+NqAyj3+5
 KL3wuKKc3a0BChm5wLm6Xve4YCbVGqSsK3C48PDaNC45ZyGy1BJvVfqMbPcC4Q==
X-Gm-Gg: AfdE7cmXJSv3MEaubRxt1bdf5JtC/gj+aDDIgwdUJ1ZkE5J+muMmSn+Jd8ONa5tCbrP
 Gv5eaKy8iM1ENqIY089yqYPSLbVkuAyLKQVUgR48ucCet2vVoUImd6//wOi64US9qw8+4HlCSEI
 nc/hegkYx3g/wGQLvoF5i3thIU+wfOnpnnCWkWZWjqBq0MXbyBiz5qcgaTIgbOH4Euvgo64cxpC
 8hFCE6JwcVPibdQBXJIymVSnGNwo4taCx6t/lOT3TjkNur4VyUrd0qPAiZEJB7vWe/C0JWZ0ZPJ
 iOiHJD15+97jNuKKzuwTcH/h+HKMIsr4ZCNJGMql6lCkj3z0ttiy+bZQjdMr48F8CWAt46MHgb7
 3Qb8O76U+dj1sibxgRAdmrEuCaaq0VKDdZfN9Bwe8zPWRwwxoSeM8ZR4qOb1b2zRuEZql2FXg0c
 NDDgucbW+CJK2eyk+DFvxOnnL+ecSxnwZqcP8ywRZ2wEeTbBBj4QipzcFxiBZQJkB0YNI0Yu3Ck
 kfd9dJTzhLOvtRgVSgKGzl4xJ+q7lbuDGNK
X-Received: by 2002:a05:6000:4305:b0:471:f180:86d7 with SMTP id
 ffacd0b85a97d-47759568468mr5544177f8f.41.1782946067231; 
 Wed, 01 Jul 2026 15:47:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2d44-b300-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2d44:b300:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm3178614f8f.7.2026.07.01.15.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:47:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/4] hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and
 imx8mp-evk
Date: Thu,  2 Jul 2026 00:46:12 +0200
Message-ID: <20260701224612.48342-5-shentey@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701224612.48342-1-shentey@gmail.com>
References: <20260701224612.48342-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Real hardware supports CAN FD which is missing in the emulation and is
considered future work. Still, CAN communication already works under Linux.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8m.rst   |  1 +
 include/hw/arm/fsl-imx8mp.h |  8 ++++++++
 hw/arm/fsl-imx8mp.c         | 37 +++++++++++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c         | 21 +++++++++++++++++++++
 hw/misc/imx8mp_ccm.c        |  3 +++
 hw/arm/Kconfig              |  1 +
 6 files changed, 71 insertions(+)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index afbc33b2f4..1bcb8255be 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -18,6 +18,7 @@ following devices:
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
  * 2 Designware USB 3 Controllers
+ * 2 FlexCAN 3 CAN Controllers (``imx8mp-evk`` only)
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 3b6183ed1d..2be3c51af5 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
 #include "hw/pci-host/designware.h"
@@ -37,6 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 #define FSL_IMX8MP_RAM_SIZE_MAX     (8 * GiB)
 
 enum FslImx8mpConfiguration {
+    FSL_IMX8MP_NUM_CANS         = 2,
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
@@ -68,11 +70,14 @@ struct FslImx8mpState {
     USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
+
+    CanBusState       *canbus[FSL_IMX8MP_NUM_CANS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -279,6 +284,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
     FSL_IMX8MP_PCI_INTD_IRQ = 123,
     FSL_IMX8MP_PCI_MSI_IRQ  = 140,
+
+    FSL_IMX8MP_FLEXCAN1_IRQ  = 142,
+    FSL_IMX8MP_FLEXCAN2_IRQ  = 144,
 };
 
 #endif /* FSL_IMX8MP_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 7c03ed3c34..c7ce30a17d 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -246,6 +246,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *name = g_strdup_printf("flexcan%d", i);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN3);
+    }
+
     object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
@@ -669,6 +674,33 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* FLEXCANs */
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } flexcan_table[FSL_IMX8MP_NUM_CANS] = {
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN1].addr,
+                FSL_IMX8MP_FLEXCAN1_IRQ
+            }, {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN2].addr,
+                FSL_IMX8MP_FLEXCAN2_IRQ
+            },
+        };
+
+        s->flexcan[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                        flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
+    }
+
     /* On-Chip RAM */
     if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
@@ -684,6 +716,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         switch (i) {
         case FSL_IMX8MP_ANA_PLL:
         case FSL_IMX8MP_CCM:
+        case FSL_IMX8MP_FLEXCAN1 ... FSL_IMX8MP_FLEXCAN2:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
@@ -715,6 +748,10 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 static const Property fsl_imx8mp_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+    DEFINE_PROP_LINK("canbus0", FslImx8mpState, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslImx8mpState, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index ca0ee2d3f2..16e9722d14 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -26,6 +26,7 @@ struct FslImx8mpEvkState {
     MachineState parent_obj;
 
     FslImx8mpState soc;
+    CanBusState *canbus[FSL_IMX8MP_NUM_CANS];
 
     struct arm_boot_info boot_info;
 };
@@ -86,6 +87,12 @@ static void imx8mp_evk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX8MP);
     object_property_set_uint(OBJECT(&s->soc), "fec1-phy-num", 1, &error_fatal);
+    for (int i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
@@ -122,6 +129,19 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
+static void imx8mp_evk_machine_init(Object *obj)
+{
+    FslImx8mpEvkState *s = IMX8MPEVK_MACHINE(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link, 0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link, 0);
+}
+
 static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -140,6 +160,7 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
         .interfaces = aarch64_machine_interfaces,
     },
diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
index 911911ed86..97d363e79d 100644
--- a/hw/misc/imx8mp_ccm.c
+++ b/hw/misc/imx8mp_ccm.c
@@ -129,6 +129,9 @@ static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_HIGH:
         freq = CKIH_FREQ;
         break;
+    case CLK_CAN:
+        freq = 40000000; /* 40Mhz, taken from device tree */
+        break;
     case CLK_IPG:
     case CLK_IPG_HIGH:
         /*
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5f5c4899ad..0416ba823c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -600,6 +600,7 @@ config FSL_IMX8MP
     imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
+    select CAN_FLEXCAN
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
-- 
2.54.0


