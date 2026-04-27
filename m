Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EB3FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLU1-0005TB-3l; Mon, 27 Apr 2026 08:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNR-0007nc-D9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNP-0005UX-M7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172740695e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294069; x=1777898869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+f5ZGmX9oTLSaVcb3xFFj2b2ao74Al5SyMxc3YROTz0=;
 b=NNK6HczuEl//raLKZTdcG0N0TiMpqoyQRpeYRSj/bcSN2oxqfDCLQ3dfshxQ2OLW78
 Srs30XVXP9tdV2Baga/zTHVjjFb/a3YRz7/6qi0MTra/Ket1vit6wFHCkSIb1177fiXw
 QG0hZKBQYt3SO7I3zLu+2ZIIr8nuwBbrW4SK/vKZKygncQSdKYpc50uOkHyjq9S/b++V
 AqW1zaaxyStj3SXMrTVBHW/agVCbLPcYaFeYdSXzydAaPTE5QT0l40riZJI2Dcw/92P5
 ctxVezrN64Siogun730L4SEXKrQkwMCm/vYZInzah9Hiq3dsDiklg5H6i5geA1ND2nJu
 BxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294069; x=1777898869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+f5ZGmX9oTLSaVcb3xFFj2b2ao74Al5SyMxc3YROTz0=;
 b=iHHLlWWDkstuuYidmqTrBTPzwYwmagSvA1eXHXp2LHw4O/9PWAGgZsEhvaifriY+v+
 Tjr8EmgjRk1CN4FcqkHKyoRqjtPtLalB6Oq5bN3vDsKPU4XO0DXEHpbhfWiUQBrHlmRt
 AGMkI2wdieSnyCzvfI5zLIGAp9+vvrX4dbSzChIu14XMpYtPrnUhhMf3JES4tCjn5ktD
 rCvTs+f5pAlMZA/y6/f7w77+/b0dtp3xA/vTQvGnyhVPb+cGy0YPBfLTPjrvjcydF5Qt
 FWwCbIIfdJNaZOmZcSMA9EgLK/gqEjwCrwgLXeJGoMirInbcd5UoGznRMjrLvDbmgQI2
 DbpQ==
X-Gm-Message-State: AOJu0YzNQd6AAuRYMQtsWiMpUUvuBhuIns64vYJsJ+JVTc04nmti8Pma
 eDyJh185MViT4+qh3vTv69QzQVHg+Ao+aW96nIdK61JhTbqHy6oVIZnQPRlfo8MuWkscPhFStH+
 mGzlu
X-Gm-Gg: AeBDievLVeYUHaN7C2+emq3g8HmGJsPl7JQA793aJkZU8ZDYWGEWuLs1RfBZtxYNuiV
 2RmWFP0npX2Lry1ol8rQqorynv140x3hdmtUUk0YGMUB5mhYQjTSBDwmhvzU4p+nmIHzjEu8JHL
 25mlOS7WeZuy0fV50kGmvEChM/T/bMtk65KPKfoSWSWSthgcbROhWkDOHXYF/g38HQIBObsA5yN
 WmNtx7K7PhBXa5g/Po3QnBAZghpWkKI9JkjBShHciMltX+fjRgkz/QsHSmO/cdIo2ixKyuW/trP
 wTuxTt5yiC9vBgflmf3I51BahXrHuBt8HUxtvnVreJzdsEg844uyNidrdhncqijGVMyQJp7l/8y
 qG92F2etr4kQg3KJFQvN0f/0mP3RpE5jrlwKQV0OLFDsMRF/zBc8YGWyc5hm7Gcyo6hu9KuXHDu
 ZYRQALx8LYlC2AWdHPUEBJxQO60A1ujf4Yb0u4orkUuXXwUA70gFnbWR26rGPNT2MQueOP+GR8C
 HU8KnyqNRM0NtLkUXQP1uYi389EFosWwAB+y/jeDA==
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488fb742e7fmr358972785e9.7.1777294068924; 
 Mon, 27 Apr 2026 05:47:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/63] hw/arm/fsl-imx8mm: Adding support for SPI controller
Date: Mon, 27 Apr 2026 13:46:45 +0100
Message-ID: <20260427124738.966578-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

It enables emulation of ECSPI in iMX8MM
Added SPI IRQ lines

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mm.c         | 26 ++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 3632d85197..f433beeaf2 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -195,6 +195,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        g_autofree char *name = g_strdup_printf("spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -464,6 +469,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* ECSPIs */
+    for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } spi_table[FSL_IMX8MM_NUM_ECSPIS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI1].addr, FSL_IMX8MM_ECSPI1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI2].addr, FSL_IMX8MM_ECSPI2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI3].addr, FSL_IMX8MM_ECSPI3_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -503,6 +528,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
         case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index d6df16e9d4..13c044412a 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -21,6 +21,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -32,6 +33,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
 
 enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
+    FSL_IMX8MM_NUM_ECSPIS       = 3,
     FSL_IMX8MM_NUM_GPIOS        = 5,
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
@@ -48,6 +50,7 @@ struct FslImx8mmState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXSPIState        spi[FSL_IMX8MM_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
@@ -177,6 +180,10 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
 
+    FSL_IMX8MM_ECSPI1_IRQ   = 31,
+    FSL_IMX8MM_ECSPI2_IRQ   = 32,
+    FSL_IMX8MM_ECSPI3_IRQ   = 33,
+
     FSL_IMX8MM_I2C1_IRQ     = 35,
     FSL_IMX8MM_I2C2_IRQ     = 36,
     FSL_IMX8MM_I2C3_IRQ     = 37,
-- 
2.43.0


