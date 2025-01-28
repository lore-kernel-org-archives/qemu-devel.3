Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64CC02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxh-00025j-Tg; Tue, 28 Jan 2025 15:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxe-00024f-On
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxc-0001Yt-IK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so43687375e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095203; x=1738700003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vz+DUCksAsnC1qRTwgnbtO/CcSAc6rnMCs2dAAd/HyY=;
 b=BahgedeVXn7FOI87VUono/UFDOxnsVR6bA59EifdVS7vqTHZGKQ2/Oa+V3t9E/silT
 k6n14ss8/H/yvxz58098xiP+f1Z/SRe8/4McZqGX896gUY+e7NVonenjBr2LrzsCUS+G
 Mdvt4scPnnT4O3c1HwRPLLXPtrGDx7dnKsGvXcBI/6IYGMNsZJcKBMnNwubpoBIe5NA9
 IkI1lPlP1OX91C0Ufy9v8bBJp7HJEOG7pkBcUtai2WDnJfdJl4yJLMeG9qhnSj0dwLWy
 L7GVrya+wM8HlH2xQk0HFjGOBPARNM0+uPLXuLry2+g3KAfyZuF2iX3xmx4QVi39UQTr
 VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095203; x=1738700003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vz+DUCksAsnC1qRTwgnbtO/CcSAc6rnMCs2dAAd/HyY=;
 b=Lk8OfKmQ5qfYvz/L+lmzM8axIqNcjDFv2NAxHrqZSF7h7X4edSyMy23lOX5qkq3RGl
 dJq7bdobtb6s0jMIc1CuhvHHlYteixpljmtjvkAv8g1RhRTJ32JEjYLqWuP7nwqUQwY7
 pj7AcvfubHI6fU9p8P9j59rn1AAYU0YKsTfNYXs73N751ybOmDBHIBiGSJ5RuHjMkeF1
 q3alPwGE370PsYdBU0lS+b/quMCeAfkqMkMxwwBvmZMXVXAILOt1O/uOweabXZ38936H
 vMMP4ThF6vkDYDomISdNe0W5ldJrVBoEv2AywtL6Hjf8UHzoaNERFTiA6PNGTzu5o3qH
 bWDw==
X-Gm-Message-State: AOJu0YyskI7xo7KYPs+PmzGu6rDkJ9Yp76kfWdJ4Mvv7HSBpvJq+sTK2
 ylqvgNVHBTF2HGYmD+2XLY8ruH+9C55m51Sl3cvAR5JrUfVBmGibx/pGwe+DVflBB90ZYfDUk3o
 n
X-Gm-Gg: ASbGncvYUF4AW57H1FoW1NsM3fdDa0LtoystJ+GBBo90A7kPP+q2UWnBi/ayCr2Bd1g
 qLqc0SkCNNbNJVaKoS+7NdBrULQOzZt2iG7MnsoV9mYB0fEowR0YFsqIGNr8JuWKheh0zwwcEok
 HRUv2mtWu4f5cQM/II5Rac6PPcF9zM2NYNeVjwd/Q6xkAeZgDnZDZvl/2zwNIIZEuXS42fE7CSb
 mYb58xVF0M5GY0hTmW+fHobfadqGVUHsZRFHmJbvyD1jGufg/xaqvPt8igZ4nOvgob0N8mgQVw5
 Xyx7fX2GdtkiezEq9+9qOQ==
X-Google-Smtp-Source: AGHT+IHK/gt9KiZX6gxn32vFv2ft7OftFIn9xK/dHpl97vSatLolPg4SbTY2CUcvgHccQqkfTXU/dQ==
X-Received: by 2002:a05:600c:1e0e:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438dc3caa59mr2711195e9.16.1738095203009; 
 Tue, 28 Jan 2025 12:13:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] hw/pci-host/designware: Expose MSI IRQ
Date: Tue, 28 Jan 2025 20:12:44 +0000
Message-Id: <20250128201314.44038-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes INTD and MSI interrupts poking the same IRQ line without keeping track of
each other's IRQ level. Furthermore, SoCs such as the i.MX 8M Plus don't share
the MSI IRQ with the INTx lines, so expose it as a dedicated pin.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h        |  4 +++-
 include/hw/arm/fsl-imx7.h        |  4 +++-
 include/hw/pci-host/designware.h |  1 +
 hw/arm/fsl-imx6.c                | 13 ++++++++++++-
 hw/arm/fsl-imx7.c                | 13 ++++++++++++-
 hw/pci-host/designware.c         |  7 +++----
 hw/arm/Kconfig                   |  2 ++
 7 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 61c593ffd24..9da32fc1895 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -33,6 +33,7 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
+#include "hw/or-irq.h"
 #include "exec/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -73,6 +74,7 @@ struct FslIMX6State {
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
     DesignwarePCIEHost pcie;
+    OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -457,7 +459,7 @@ struct FslIMX6State {
 #define FSL_IMX6_PCIE1_IRQ 120
 #define FSL_IMX6_PCIE2_IRQ 121
 #define FSL_IMX6_PCIE3_IRQ 122
-#define FSL_IMX6_PCIE4_IRQ 123
+#define FSL_IMX6_PCIE4_MSI_IRQ 123
 #define FSL_IMX6_DCIC1_IRQ 124
 #define FSL_IMX6_DCIC2_IRQ 125
 #define FSL_IMX6_MLB150_HIGH_IRQ 126
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 411fa1c2e37..aa7818c4999 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -36,6 +36,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
+#include "hw/or-irq.h"
 #include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -85,6 +86,7 @@ struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -428,7 +430,7 @@ enum FslIMX7IRQs {
     FSL_IMX7_PCI_INTA_IRQ = 125,
     FSL_IMX7_PCI_INTB_IRQ = 124,
     FSL_IMX7_PCI_INTC_IRQ = 123,
-    FSL_IMX7_PCI_INTD_IRQ = 122,
+    FSL_IMX7_PCI_INTD_MSI_IRQ = 122,
 
     FSL_IMX7_UART7_IRQ    = 126,
 
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index c484e377a81..bf8b2789787 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -86,6 +86,7 @@ struct DesignwarePCIEHost {
         MemoryRegion io;
 
         qemu_irq     irqs[4];
+        qemu_irq     msi;
     } pci;
 
     MemoryRegion mmio;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ac8c66e242c..88b9ccff493 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -106,6 +106,8 @@ static void fsl_imx6_init(Object *obj)
     object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_OR_IRQ);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
@@ -435,14 +437,23 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX6_PCIe_REG_ADDR);
 
+    object_property_set_int(OBJECT(&s->pcie4_msi_irq), "num-lines", 2,
+                            &error_abort);
+    qdev_realize(DEVICE(&s->pcie4_msi_irq), NULL, &error_abort);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_MSI_IRQ);
+    qdev_connect_gpio_out(DEVICE(&s->pcie4_msi_irq), 0, irq);
+
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE1_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE2_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE3_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_IRQ);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4, irq);
 
     /*
      * PCIe PHY
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 05e3389fbe0..004bf499376 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -150,6 +150,8 @@ static void fsl_imx7_init(Object *obj)
      * PCIE
      */
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_OR_IRQ);
 
     /*
      * USBs
@@ -597,14 +599,23 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX7_PCIE_REG_ADDR);
 
+    object_property_set_int(OBJECT(&s->pcie4_msi_irq), "num-lines", 2,
+                            &error_abort);
+    qdev_realize(DEVICE(&s->pcie4_msi_irq), NULL, &error_abort);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_MSI_IRQ);
+    qdev_connect_gpio_out(DEVICE(&s->pcie4_msi_irq), 0, irq);
+
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTA_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTB_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTC_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_IRQ);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4, irq);
 
     /*
      * USBs
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c3fc37b9047..3e8c36e6a76 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -55,8 +55,6 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
-#define DESIGNWARE_PCIE_IRQ_MSI                    3
-
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -90,7 +88,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
     if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
-        qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
+        qemu_set_irq(host->pci.msi, 1);
     }
 }
 
@@ -335,7 +333,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
         root->msi.intr[0].status ^= val;
         if (!root->msi.intr[0].status) {
-            qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
+            qemu_set_irq(host->pci.msi, 0);
         }
         break;
 
@@ -680,6 +678,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
         sysbus_init_irq(sbd, &s->pci.irqs[i]);
     }
+    sysbus_init_irq(sbd, &s->pci.msi);
 
     memory_region_init_io(&s->mmio,
                           OBJECT(s),
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e779b5af958..256013ca808 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -516,6 +516,7 @@ config FSL_IMX6
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select OR_IRQ
 
 config ASPEED_SOC
     bool
@@ -573,6 +574,7 @@ config FSL_IMX7
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select OR_IRQ
     select UNIMP
 
 config ARM_SMMUV3
-- 
2.34.1


