Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ECCFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQC-00021f-01; Mon, 27 Apr 2026 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNz-00087h-1C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNr-0005hu-Ng
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso75998435e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294097; x=1777898897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4MgWbP/9wmOy0VZTKjCnGxeHPzbsxi09y3T5/RRhIzE=;
 b=Yxu27URy5vlLhiZo3pHH8BeEGnyrw4lDlH/D+Vsk50cUqu1CZYy6IrMWONsPOrkIAr
 hlNwjbwMbHHZyrJGEiO5u3UivrkngLnXopPX1DV9+vr6XLKj/XpVkbf78N8ibLlcHoyo
 9HApCNAKDpDRSAKFdqks9SQj7loY1s6vtxOVdXTX3HGVLVPQ8B5RmuazLF9aHejnteE9
 Jm+63lGU4kxDYf47013aj0lRBX9wp9fx43Vvx3STRfnLG0DsWgnfa368JHun5y8KFPwQ
 plgLbr5d3VZMV3o5OLp4trbgVTC5QVmjQNa54ESE1jFI02BfpCDSFKDq8issMdGMcm//
 KPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294097; x=1777898897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4MgWbP/9wmOy0VZTKjCnGxeHPzbsxi09y3T5/RRhIzE=;
 b=nUpDSy5KWz5Erpp2tF37eceOJsxRPfbcFVGNuVFskb+SD76QUeBhKoOtSItxZcravs
 o4ratrAWsKM6CsYnEYpa9ZUtZJIn8N6KvUHSmtzAGqmM/EdwrOyj4cxD6yxPjeIh/7yb
 VJZTKKHxFqc60hvkiZ2NjXYZgSxYDAOLNowm2Sh6HXRABMGAKD63r1Ak3WIw8H7D3uGl
 N9Enl4F/ICg1Q8A8nGy7NAoT2VjQ/CvU2xPEmlwRhARpO39R2egr7sTXcuKxiy5gL3vH
 IU4dPR53E+IpaJd+Uui1L/hEcGWUdOv7tpe+KUosBpi/uuOojQJSrutfNjjNa89euhpK
 boLA==
X-Gm-Message-State: AOJu0Yw5ihKxXYsjJA6VsWH8ReaZiyHFj0vOyP55L7TGxjgg38o614zJ
 UV36Wx69WCsWEFDRYp6ORxeyrLCVHC9smlJmtHgChpoAE6KrkQsDUcW0UhtaFA4J2EDob7x4kNf
 iZMX2
X-Gm-Gg: AeBDiesBM/VQuNGaCIN4vKOLaAitZoY5mkpvccCtY3PmafzIeg1AmDMPWG1ioir3tqQ
 pvlIoGw7dp+Hkdcsv2juW8CYJSlDJla6Rw0uIGslwlCPxdNhSrXg10BrESrkN8pUxg3+i7pufo/
 0UpeP6bBfMivLKLPXS/F5iEPezt5wRwnpNdpyE7ChInlFXtsmfhnnXvK9Ndl+Spofl5TnmEq1RU
 57i4dhokRRSoes6GALRwbp5xv0sRPYQ2mcy4fZOPPPp6f7klzUoBDwbzw6JXkRmklU7QX9Gbfpk
 7N9thNfkLaaYshZWBgrk5vmbqWtepqpSUD3PXlYUlqsMCen1hCfuKN5jIjkTC0RcxRnHJQZLMgb
 Xn1wVohUeh+Pn7cm5QLWh7vO2aR3SzZUHqrHHLINJ9Tz0HuDO6uUs6usT7AgiEfEdAA8ZjYWaM+
 gZrRayGUgmno5TUdQAPhl3jOx+YGw1uMeDm2C5lYfqpVBI4NopirarYiAxjdHF179RMq3LCaL8k
 9b3jQoqqJTYieS+1MORMeaVnkEO8RyO6yv0cJv9nnPXgVo8LEYf
X-Received: by 2002:a05:600c:1907:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-489201cdf13mr418319805e9.12.1777294096712; 
 Mon, 27 Apr 2026 05:48:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/63] hw/arm/fsl-imx6ul: Wire in the LCDIF device model
Date: Mon, 27 Apr 2026 13:47:14 +0100
Message-ID: <20260427124738.966578-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

From: Yucai Liu <1486344514@qq.com>

Instantiate LCDIF as a child object of the i.MX6UL SoC in init and
realize it in the SoC realize path before MMIO/IRQ hookup.

Also make FSL_IMX6UL select CONFIG_IMX6UL_LCDIF and map the LCDIF
region with a 16 KiB size to match the SoC memory map.

Signed-off-by: Yucai Liu <1486344514@qq.com>
Message-id: 20260412110240.93116-3-yangyanglan718@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx6ul.c         | 12 ++++++++++--
 include/hw/arm/fsl-imx6ul.h |  4 +++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b940af9345..c31752e83a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -656,6 +656,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select IMX
+    select IMX6UL_LCDIF
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 225e179126..1863558a0d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/core/boards.h"
@@ -136,6 +137,11 @@ static void fsl_imx6ul_init(Object *obj)
         object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
+    /*
+     * LCDIF
+     */
+    object_initialize_child(obj, "lcdif", &s->lcdif, TYPE_IMX6UL_LCDIF);
+
     /*
      * SDHCIs
      */
@@ -656,8 +662,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
-                                FSL_IMX6UL_LCDIF_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->lcdif), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->lcdif), 0, FSL_IMX6UL_LCDIF_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lcdif), 0,
+                       qdev_get_gpio_in(gic, FSL_IMX6UL_LCDIF_IRQ));
 
     /*
      * CSU
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index f8f9c249a2..6205fe6b77 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -33,6 +33,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -84,6 +85,7 @@ struct FslIMX6ULState {
     IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
     IMXUSBPHYState     usbphy[FSL_IMX6UL_NUM_USB_PHYS];
     ChipideaState      usb[FSL_IMX6UL_NUM_USBS];
+    IMX6ULLCDIFState   lcdif;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -143,7 +145,7 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
 
     FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
-    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
+    FSL_IMX6UL_LCDIF_SIZE           = (16 * KiB),
 
     FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
     FSL_IMX6UL_CSI_SIZE             = 0x100,
-- 
2.43.0


