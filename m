Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5866FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgA-00077d-Cg; Mon, 29 Jun 2026 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfq-00070q-7C
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfo-0007Xl-1f
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46ee68c3b7aso2745484f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734471; x=1783339271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TkLfoKCD6Z5Gi0FYcZX7r6hIjibNz+Sx6f0GTVudYAo=;
 b=DGh7ic9ppQrUvSyeFgZJY4MqCwIoo1MjZAq/nEw4D2yYF5xihQiui4fZ4XPy3YGpFC
 a7F98cC3M4QAV0SuQCUIwuU41qlwyW56W6Nx+iNnDlcSttYR+sTksXwvyBw7ZutecIZT
 2RuOcg/+QFzB89f8bVCigxISPyo7ZuSkn1O4jWoeiIf3BChbngKkSbrB7DIXGven6xSR
 tVBocAKdbf/qmHlwppC/d5fXuDBZnyNSIq2V1+lZGPhLkYl/6wfWxZwg+Gtj3KTCUoX/
 NHqEBe1ARV0+HvV1P9flP3frBboSQ/v8bFW72kvsOAC/ikaeJm34RyuAeyQ028/Sbl6V
 h7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734471; x=1783339271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TkLfoKCD6Z5Gi0FYcZX7r6hIjibNz+Sx6f0GTVudYAo=;
 b=i3wstO1HKncuiQEE6d4yLx4U2Y5dsizmEPjsk34es/TesbXm6vynW5SQxUOIL/GFvf
 HTVH70KItUnwYcv83zoKvW/yGYFro5/JmnuXs87LeTc6McMOGcdmaFRSwt4s+iE4+5JY
 Gggss7WUg/MNtUZLGgzT8bRbkrOq3QIsG1efPycIFHtJpOnwxwiHAbtYxQSTijbdSAVf
 dtgmErnD96kB675GXBiig4oQ58+rn3OY4ALhGXV25wTq9B6M29rTb4dfQN9qb+b+PkVk
 dcO5EysfVM6H1aqjmVtFo4oDRIgMG4TavKEnUkxW3VO+RJqpSqeBfWS8/UH50YYx/Ol/
 g3Rw==
X-Gm-Message-State: AOJu0YyMxbWw0Xj1aDX0phmDR5tTfhME4sMqjfijeok3ES56BnFCTOmW
 pGVlspV/vXikaCDElaKZlgDrE0wZmr67a8X/nMucZHdIpgMBIb3rBzNsg2prmlIxkW4x2lG3Ng7
 YsvEU
X-Gm-Gg: AfdE7cljUQ8lARZgjSaqxqkTOOfSZ+TgcAhIUoLd4kygcVkzM0E7+M/WPr1wgy9wPhR
 Xg4pswIJM9uoE6Y/TNnC/v2Mz9qvLwwB30To3EvMKGmHBmIlFzB4R89sQOfcAfsgkNZpIge8ECj
 SPx+5A5+OQkAithijBdbkfaHMaxXBLyhh34U+SlRJdS7udRAp4zyyrl6orPQU15g1pc3FoQxxWH
 dCVY9Buf5S2fUuompkiEs9k/LIT1W9MQTmRa0lMiPmg+YsoeKEi0ORL8HoZCi73FLBR6mntx3Hz
 B0QbPpEQ4XfdNq/ji/S3EkIqdFz7p5ulZRk5Bh64TnOhpLZuSQtJXDlW9XH2Doz97MAr8qdUKgk
 HBArVuP75sgfbWjVaBln2L4imx4hxzZsFTe+O/e+vtn+uYpPrxVt6+4wh1xfAGIweSHi0oKL9Nj
 2OI6zhfIL0VKp2pCUMwUN3xZEfOoeyJPou7lnsNRDAO5VjElIhm/AfrBHcPuQwSqhmI2x5OaRpD
 6EEFJg=
X-Received: by 2002:a05:6000:4701:b0:470:2fb1:3db5 with SMTP id
 ffacd0b85a97d-4702fb13deemr13683665f8f.30.1782734470318; 
 Mon, 29 Jun 2026 05:01:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/54] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Date: Mon, 29 Jun 2026 13:00:13 +0100
Message-ID: <20260629120032.1645265-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Matyáš Bobek <matyas.bobek@gmail.com>

FlexcanState is added to the FslIMX6State struct like other peripherals.

Add two new machine properties to Sabrelite machine for linking
the embedded FlexCAN instances to QEMU CAN buses by name.
No other machine uses FslIMX6State.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-id: 4159df998b0508bb411284ef406de23bbc5edfd8.1782140438.git.matyas.bobek@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig            |  1 +
 hw/arm/fsl-imx6.c         | 29 +++++++++++++++++++++++++++++
 hw/arm/sabrelite.c        | 24 ++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  6 ++++++
 4 files changed, 60 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 500bfdfe2a..5f5c4899ad 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -520,6 +520,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select CAN_FLEXCAN
     select WDT_IMX2
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f663ddbf0a..bf106a9063 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -90,6 +90,10 @@ static void fsl_imx6_init(Object *obj)
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
+    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN);
+    }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
@@ -377,6 +381,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gic, spi_table[i].irq));
     }
 
+    /* Initialize all FLEXCANs */
+    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } flexcan_table[FSL_IMX6_NUM_CANS] = {
+            { FSL_IMX6_CAN1_ADDR, FSL_IMX6_FLEXCAN1_IRQ },
+            { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
+        };
+
+        s->flexcan[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0, flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                           qdev_get_gpio_in(gic, flexcan_table[i].irq));
+    }
+
     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
                              &error_abort);
     qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
@@ -480,6 +505,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
 static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
+    DEFINE_PROP_LINK("canbus0", FslIMX6State, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslIMX6State, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 7e036e6388..84bbc2f979 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -24,6 +24,7 @@ struct SabreliteMachineState {
     MachineState parent_obj;
 
     FslIMX6State soc;
+    CanBusState *canbus[FSL_IMX6_NUM_CANS];
 };
 
 #define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
@@ -64,6 +65,13 @@ static void sabrelite_init(MachineState *machine)
     /* Ethernet PHY address is 6 */
     object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fatal);
 
+    for (int i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+    }
+
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
@@ -112,6 +120,21 @@ static void sabrelite_init(MachineState *machine)
     }
 }
 
+static void sabrelite_machine_instance_init(Object *obj)
+{
+    SabreliteMachineState *s = SABRELITE_MACHINE(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
+}
+
 static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -128,6 +151,7 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
     .name          = TYPE_SABRELITE_MACHINE,
     .parent        = TYPE_MACHINE,
     .class_init    = sabrelite_machine_class_init,
+    .instance_init = sabrelite_machine_instance_init,
     .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
     .interfaces    = arm_machine_interfaces,
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index cddd100dd6..376deea3a4 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -30,12 +30,14 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/net/flexcan.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
+#include "net/can_emu.h"
 #include "qom/object.h"
 
 #define TYPE_FSL_IMX6 "fsl-imx6"
@@ -51,6 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_WDTS 2
 #define FSL_IMX6_NUM_USB_PHYS 2
 #define FSL_IMX6_NUM_USBS 4
+#define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
     /*< private >*/
@@ -73,6 +76,7 @@ struct FslIMX6State {
     IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
+    FlexcanState       flexcan[FSL_IMX6_NUM_CANS];
     DesignwarePCIEHost pcie;
     OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
@@ -80,6 +84,8 @@ struct FslIMX6State {
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
     uint32_t           phy_num;
+
+    CanBusState       *canbus[FSL_IMX6_NUM_CANS];
 };
 
 
-- 
2.43.0


