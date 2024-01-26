Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D107C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHD-0002FN-Ge; Fri, 26 Jan 2024 09:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0002EJ-Fd
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH9-0007ry-0a
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-337cf4eabc9so530721f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279625; x=1706884425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lK9uzbOPuqI5nBpCiVJSQd+IeQXNzZSi8eQru0HuK+4=;
 b=jF+FcIz1Gz2B5y71zEJflTI8mDS4EjfYlTh+aO7bZVRABP4zVYPvqDFjjBUirNxuV4
 rv/1tvMtbiivRnizApXAVP7MEeILnWeBCr3yCkPV8f9YutWq33MUompHJpqXPYoRHKWi
 uzjMo6ZRO83vq8uaxh5ddu5IGLvRsVNAMHx3NBgUoTqeDqCnmmga48UaAraVkbXZXshR
 n1ji8PECchF1fgaTdasg5QVmnUDjKZ2YKvHbzSSNf8wIDrHdBxCaf9xiSzl11mIfGYXQ
 B16LlVLycc0cHxAOKX2FZBCj8dbdcFu8QRekiDSz1rDzOudG3h/NCDtTno1KbCKRdzAS
 QhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279625; x=1706884425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lK9uzbOPuqI5nBpCiVJSQd+IeQXNzZSi8eQru0HuK+4=;
 b=jwRuhg+jivqTqcB8vsO0TGAiznClcUNCp6/NHq9T467r9Uol2I/PxWBtl5rpep6abu
 r6eICVagW7Exu3hfPmVZyYV5+hYOGhB0gTFVGGwHVxmG0t1TI/5TSbyqCn4uI3AIwP3J
 nHo6AKfDkMgbxYFi/lswzU28FZo44bPdndlGJAc8UxDvOQJxda0mzXKg/iYGbti4LW1b
 qYiaDq7NcNq2VtxdCSG0dU8NMw3yXEjbf7Iz/UJ19s/9pS58g44fGt8TLyjQ9fiP3IfJ
 I1MovbrJ7L/De4ib/EkUevZ/3KSo5wymNPp4x6G8JSik7IEEhtpPqSKAXfAVn1eNwljU
 Xi2A==
X-Gm-Message-State: AOJu0YyEyu4d2u3baZTdsgJeopDJbjKjwWqY8MTSgQ0j3iH3guPip3zE
 CefZlBFL/tsYPkmUhiC3io0nQCGvQBSI43jOrRjq7rTCj3QZunjveut78TbqJ8K8GtWAFs72e0a
 j
X-Google-Smtp-Source: AGHT+IF3Xn0cb19Vjmk7Hd/V45B+ezYyoq3EPMw7NWB73nbST3ClyfyzUdBdo8SJF4B2yCKt/nlyqQ==
X-Received: by 2002:adf:a44e:0:b0:336:e161:8d with SMTP id
 e14-20020adfa44e000000b00336e161008dmr1000199wra.78.1706279625575; 
 Fri, 26 Jan 2024 06:33:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and
 Bananapi board
Date: Fri, 26 Jan 2024 14:33:12 +0000
Message-Id: <20240126143341.2101237-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Allwinner R40 supports two USB host ports shared between a USB 2.0 EHCI
host controller and a USB 1.1 OHCI host controller. Add support for both
of them.

If machine USB support is not enabled, create unimplemented devices
for the USB memory ranges to avoid crashes when booting Linux.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240115182757.1095012-2-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/bananapi_m2u.rst |  2 +-
 include/hw/arm/allwinner-r40.h   |  9 ++++++
 hw/arm/allwinner-r40.c           | 47 ++++++++++++++++++++++++++++++--
 hw/arm/Kconfig                   |  2 ++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index b09ba5c5486..e77c425e2cb 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -23,6 +23,7 @@ The Banana Pi M2U machine supports the following devices:
  * GMAC ethernet
  * Clock Control Unit
  * TWI (I2C)
+ * USB 2.0
 
 Limitations
 """""""""""
@@ -33,7 +34,6 @@ Currently, Banana Pi M2U does *not* support the following features:
 - Audio output
 - Hardware Watchdog
 - Real Time Clock
-- USB 2.0 interfaces
 
 Also see the 'unimplemented' array in the Allwinner R40 SoC module
 for a complete list of unimplemented I/O devices: ``./hw/arm/allwinner-r40.c``
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 6e1ac9d4c13..ae82822d424 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -30,6 +30,8 @@
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/net/allwinner-sun8i-emac.h"
+#include "hw/usb/hcd-ohci.h"
+#include "hw/usb/hcd-ehci.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -44,6 +46,10 @@ enum {
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
     AW_R40_DEV_MMC3,
+    AW_R40_DEV_EHCI1,
+    AW_R40_DEV_OHCI1,
+    AW_R40_DEV_EHCI2,
+    AW_R40_DEV_OHCI2,
     AW_R40_DEV_CCU,
     AW_R40_DEV_PIT,
     AW_R40_DEV_UART0,
@@ -88,6 +94,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AwR40State, AW_R40)
  * which are currently emulated by the R40 SoC code.
  */
 #define AW_R40_NUM_MMCS         4
+#define AW_R40_NUM_USB          2
 #define AW_R40_NUM_UARTS        8
 
 struct AwR40State {
@@ -106,6 +113,8 @@ struct AwR40State {
     AwSRAMCState sramc;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
+    EHCISysBusState ehci[AW_R40_NUM_USB];
+    OHCISysBusState ohci[AW_R40_NUM_USB];
     AwR40ClockCtlState ccu;
     AwR40DramCtlState dramc;
     AWI2CState i2c0;
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index a0d367c60d1..2e8943eff74 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -23,6 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
@@ -45,6 +46,10 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_EHCI1]      = 0x01c19000,
+    [AW_R40_DEV_OHCI1]      = 0x01c19400,
+    [AW_R40_DEV_EHCI2]      = 0x01c1c000,
+    [AW_R40_DEV_OHCI2]      = 0x01c1c400,
     [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
     [AW_R40_DEV_UART0]      = 0x01c28000,
@@ -89,9 +94,9 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "crypto",     0x01c15000, 4 * KiB },
     { "spi2",       0x01c17000, 4 * KiB },
     { "sata",       0x01c18000, 4 * KiB },
-    { "usb1-host",  0x01c19000, 4 * KiB },
+    { "usb1-phy",   0x01c19800, 2 * KiB },
     { "sid",        0x01c1b000, 4 * KiB },
-    { "usb2-host",  0x01c1c000, 4 * KiB },
+    { "usb2-phy",   0x01c1c800, 2 * KiB },
     { "cs1",        0x01c1d000, 4 * KiB },
     { "spi3",       0x01c1f000, 4 * KiB },
     { "rtc",        0x01c20400, 1 * KiB },
@@ -181,6 +186,10 @@ enum {
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
     AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_OHCI1     = 64,
+    AW_R40_GIC_SPI_OHCI2     = 65,
+    AW_R40_GIC_SPI_EHCI1     = 76,
+    AW_R40_GIC_SPI_EHCI2     = 78,
     AW_R40_GIC_SPI_GMAC      = 85,
 };
 
@@ -276,6 +285,13 @@ static void allwinner_r40_init(Object *obj)
                                 TYPE_AW_SDHOST_SUN50I_A64);
     }
 
+    for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
+        object_initialize_child(obj, "ohci[*]", &s->ohci[i],
+                                TYPE_SYSBUS_OHCI);
+    }
+
     object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
 
     object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
@@ -407,6 +423,33 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
 
+    /* USB */
+    for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
+        g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
+
+        object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable", true,
+                                 &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        allwinner_r40_memmap[i ? AW_R40_DEV_EHCI2
+                                               : AW_R40_DEV_EHCI1]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            i ? AW_R40_GIC_SPI_EHCI2
+                                              : AW_R40_GIC_SPI_EHCI1));
+
+        object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
+                                &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                        allwinner_r40_memmap[i ? AW_R40_DEV_OHCI2
+                                               : AW_R40_DEV_OHCI1]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            i ? AW_R40_GIC_SPI_OHCI2
+                                              : AW_R40_GIC_SPI_OHCI1));
+    }
+
     /* SD/MMC */
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 218b454e97f..4a2a5fca974 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -415,6 +415,8 @@ config ALLWINNER_R40
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
+    select USB_OHCI
+    select USB_EHCI_SYSBUS
     select SD
 
 config RASPI
-- 
2.34.1


