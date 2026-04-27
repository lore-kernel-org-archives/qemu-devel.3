Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3AAFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOR-00005k-KY; Mon, 27 Apr 2026 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNR-0007nb-5k
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNP-0005UQ-9L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso103390745e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294070; x=1777898870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JNjfatGM7VZYxrKHW8ReU78B4hS86QJtHBIQ1CnwPI=;
 b=bLWTlEwJCjPL82ydqpN0/TxStMlVp9qTwAEL+IVfGicE/21x7KIcQRMN1G3cNH4DBd
 MYD/GQ6GDWlw97Jo3sZ3IFoKRueuxUEwPV6hF61ByAmVxulCLAvHix6cLF3bTWsXXwCm
 hmwhWEwNdu7/FZNMF+xiT8aEjhya1bdzud0KFyr176R2zLj1XJWKo8TijQQKVqHAivfR
 dBXupIL5nBbM7nMiiKy41cp6db/P6eHm9rupgzlEACzugBVDXHBe/H1ixqgs8TppF+xE
 ilBfJ0bkuRqf0vgE/7KkZqs4cocm5VvqfCb18Bn1Rp9f1y+a6Am12/RaYDpy+Yda4hx2
 scrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294070; x=1777898870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3JNjfatGM7VZYxrKHW8ReU78B4hS86QJtHBIQ1CnwPI=;
 b=lczasXd9R4pUE1P8EV4+BkJx/cNv6TRW7hgTUfP4Z3f8y/g+xMyXbG1ZcO3ZFKEXQP
 jKU+27An2ofrWYM2sZfdrA6szzoKr3ot/kEufEwhjsRvpa0tx4Ibba2MxgLT6t+uIwRH
 RlZvLeIB6rQWl1IGgvR1H6eyDqAVTC12SX5NO1pdTKOpM9eUnhVp/gsGC9p45/BTB9X1
 FiiG07zE72wPKMB0fcgNoPEf/A7NEe9EBWT54NjUNS2buAgP4pgki2+Cxivm12G0y8zI
 MC51x8Gkrwzca4PQhSQ2Vn5INU1/loHMnZ8APmvtWKub/p2Zwgr/y75+pSNIbj76H+qD
 lPJw==
X-Gm-Message-State: AOJu0YxTzsXtBZ8wzO1IsQ9y+Q6Os5SAkf2v24lhvaYY+c4idMdctV/0
 w9EotyAZGFrhjWSx0Nq+2Jvmp36ukGmTRJ5IW+WHa/xCvOHR+H22yH44WKjOyVGtq/2z6KlcX0c
 Q7vr8
X-Gm-Gg: AeBDietexV3zG+E/hXIM7RZOBYxXDxLw0/KZgcoeBJvqIK+9oF1srCkeDALYQIEvUL4
 hlIMb5IJgTUy0HaPcJoZNxj+grZOLXwfRjUUb390wlnvuoBElNpBV9epDhzv4PJEMYcfUvlTV0a
 4kDiCFiVOTOanqx6tXxoe/ruDVtXXtaTHTVFD/1igQseRCDyh6igwzVCNvEHbUzig1PY2Y1B7Mr
 tavID/jQCzpLrMFHkcUUlmlW/O2Wu6lZzwfeW1qEXIhCJtrL/OkPYEwwJ+cg5pbuB9pN0m86AX/
 jgsHmVf2CUXfESJHa8VjYR8s4KSXb73yMBZcZaEbLr9M00B6NtwfcSB8OKFNQ6iCQIDEbsjYKQq
 rOiVwjg5zCgMnhOUNUv/FDgsUpBWLfSebuWRHR7vxqvTyenRJ6JuOf5rQxwv/itUUn+lahmmzff
 NuSJkOVYvNjh/sPAeGMEffp5M23qZ8fLKe/+fhGC7kjaxasbUyVc3Q7teBvpTsV//+YCH91aHNH
 jOluYAK6hDJYNNEOOLwVJjsvh4sGJTBnPZFAsLutA==
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr568744335e9.2.1777294069741; 
 Mon, 27 Apr 2026 05:47:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/63] hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
Date: Mon, 27 Apr 2026 13:46:46 +0100
Message-ID: <20260427124738.966578-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

It enables emulation of WDT in iMX8MM
Added WDT IRQ lines

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 28 ++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h |  7 +++++++
 3 files changed, 36 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e8296f9a28..42901c4383 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -629,6 +629,7 @@ config FSL_IMX8MM
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
+    select WDT_IMX2
 
 config FSL_IMX8MM_EVK
     bool
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index f433beeaf2..34645555d6 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -200,6 +200,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_WDTS; i++) {
+        g_autofree char *name = g_strdup_printf("wdt%d", i);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -496,6 +501,28 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
                     fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
 
+    /* Watchdogs */
+    for (i = 0; i < FSL_IMX8MM_NUM_WDTS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } wdog_table[FSL_IMX8MM_NUM_WDTS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG1].addr, FSL_IMX8MM_WDOG1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG2].addr, FSL_IMX8MM_WDOG2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG3].addr, FSL_IMX8MM_WDOG3_IRQ },
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
@@ -537,6 +564,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
         case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
+        case FSL_IMX8MM_WDOG1 ... FSL_IMX8MM_WDOG3:
             /* device implemented and treated above */
             break;
 
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 13c044412a..fd62b19a87 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -22,6 +22,7 @@
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -39,6 +40,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
     FSL_IMX8MM_NUM_USDHCS       = 3,
+    FSL_IMX8MM_NUM_WDTS         = 3,
 };
 
 struct FslImx8mmState {
@@ -55,6 +57,7 @@ struct FslImx8mmState {
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
 };
@@ -200,6 +203,10 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_GPIO5_LOW_IRQ  = 72,
     FSL_IMX8MM_GPIO5_HIGH_IRQ = 73,
 
+    FSL_IMX8MM_WDOG1_IRQ    = 78,
+    FSL_IMX8MM_WDOG2_IRQ    = 79,
+    FSL_IMX8MM_WDOG3_IRQ    = 10,
+
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
     FSL_IMX8MM_PCI_INTC_IRQ = 124,
-- 
2.43.0


