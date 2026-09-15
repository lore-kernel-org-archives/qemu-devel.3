Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11772C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZkR-0006iP-RA; Tue, 15 Sep 2026 16:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x6ZkP-0006h9-6U
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:27:21 -0400
Received: from mail-lr2-x10.google.com ([2a00:1450:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x6ZkN-0004oE-A1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:27:20 -0400
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a5d4688decso2337711fa.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789504038; x=1790108838; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0HzlsMupkT43STyFi+zWkNuXYuyJLKJmneYJJfz5S2w=;
 b=AiINi523euK6LKiWu9oSgscR0IyDc7XABSvKTeB3rRKqdbZrhURjvSbKvqnYOiSuZ1
 vFIfp6yEvXzTpVHj+jnKIKfo5E/6AVDF389kU1HzHOrci3rxv4c5U7VHPzmzvIGTJm2c
 bDf4cDAtIIYwElNuYUpREvADl/tnAc1Dc2HSCokT6jTIQtapUGcrK5h5jyfmloWNkWsr
 hrsJkIgezk/th8NtiNKHDGST6QE40fd0lauuuFdVYWpQwYTIC8RzC7dE/t7PKUnnJiNl
 dJnYx9d+0d6FC6MIBZ7WZ/D+8raG9Nm9h+1wAvqlJo8+rJNfb6r2DLSo8s6RE5OCs/BN
 fJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504038; x=1790108838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0HzlsMupkT43STyFi+zWkNuXYuyJLKJmneYJJfz5S2w=;
 b=qyYkZ9dqquR+PocX0tgL1e1g35P/GI+Z/aL0Uoclwt/8hOhSCu3V0sZci4NE318XoR
 yehlEBbtJruKFLuNjJIHtNtQUpaNagaoYOv8aqqAiryuYki0/5Jl1orAyMlTRIzESgQA
 7NMhE8U+i5qlNMDy2oiuAhc/NtTQkqv/pEjWZcZJkUmPqHYKrZCbPyN/f1fBmul40tAH
 I99181ycWKiZT/VlfnpDdKeLAFLfwoduLPn5VOwQYexiyWYkHHOlvf38Ns3Md34PGksR
 qmXd+QjU94mfb8UUQi6W9HQ0OYDzU0jac6htW6yuLkS75J3Xr78BxWMhaUUxLhyuY0PS
 I+rw==
X-Gm-Message-State: AFuF++m8PSEAUZ4bzAyIiAKISEwh5cEKan7xE70VCJpred82o55mu8mZ
 ySrUulgAWdt63GU68act8ndY51Bv/fLtH4GYm0L9SJp9eEByXJ8N27sk
X-Gm-Gg: AYBFou12tyw6yhN8USANPIvocsPOU6CkJaAf8H5OpXL9rLykm5sPa3CIbjRqS7y4OF7
 cuHGTg0Ix/EeTHsvkRRSMHNimfP7nghGVdiDz5eMDIVPWZ2VAqFlMy3nWqutTGG+oOtyuMgvD3p
 4u6jCiSwIFpvJBQE7/NOUvTDquL0mxdBQAbNaxW2UHnVwReAW1wK1xE3OUtJyxxscXXb7ZT0L+i
 /qFuhz1hmldBaYcc8iRcaNqc87D1XJUoTcQ2T1gtzpg+6wHyT941WvaSLd7X+qOWetnTPqHm1U+
 lZNLvGdF/EMMu6eIZ6Y/E4GJCMPUNQVIJvGuLr+v6liMBwskwB1gqD4tQWCmTTSeys4/YAUyNW4
 D+orQU2NfuRSSm/MzOIBv7gGHCw3KyoSHr3xUFAx1hCGOkg9XfGU7gwN+BkE7N1mUliKOv3MjFv
 lF0rWNgWLoEq3R2ZoI1kAJUuqW24Vvqh9wQA59Y95OgWkjDyEq3/VmMYxlLsFpQ9xZMxLAvQY1v
 KMrKU3ExygHC8IR+S2zFL7z2wjsPy3r06aOybseEtKffGBO4CzVPPKWsFc=
X-Received: by 2002:a05:651c:1503:b0:3a3:7682:499f with SMTP id
 38308e7fff4ca-3a5dca188e5mr143481fa.20.1789504037359; 
 Tue, 15 Sep 2026 13:27:17 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5daf0dbacsm1621391fa.4.2026.09.15.13.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:27:15 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Tue, 15 Sep 2026 22:27:05 +0200
Subject: [PATCH v4 2/3] hw/arm: Add GPIO to Allwinner A10 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-allwinner-gpio-v4-2-b1ee1d09c9fd@gmail.com>
References: <20260915-allwinner-gpio-v4-0-b1ee1d09c9fd@gmail.com>
In-Reply-To: <20260915-allwinner-gpio-v4-0-b1ee1d09c9fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Jack wang <163wangjack@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:38::10;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lr2-x10.google.com
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

The Allwinner A10 GPIO is added to the Allwinner A10
description, so it is available when Cubieboard is emulated.

Update the documentation for Cubieboard to indicate GPIO availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cubieboard.rst | 1 +
 hw/arm/Kconfig                 | 1 +
 hw/arm/allwinner-a10.c         | 8 ++++++++
 include/hw/arm/allwinner-a10.h | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 90d24c73a1..ee9f489ead 100644
--- a/docs/system/arm/cubieboard.rst
+++ b/docs/system/arm/cubieboard.rst
@@ -12,6 +12,7 @@ Emulated devices:
 - RTC
 - EMAC
 - SDHCI
+- GPIO
 - USB controller
 - SATA controller
 - TWI (I2C) controller
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b0..4445f16f45 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -295,6 +295,7 @@ config ALLWINNER_A10
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
     select ALLWINNER_A10_SPI
+    select ALLWINNER_GPIO
     select AXP2XX_PMU
     select SERIAL_MM
     select UNIMP
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 66f30757dd..66fe484ae0 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -41,6 +41,7 @@
 #define AW_A10_EHCI_BASE        0x01c14000
 #define AW_A10_OHCI_BASE        0x01c14400
 #define AW_A10_SATA_BASE        0x01c18000
+#define AW_A10_GPIO_BASE        0x01c20800
 #define AW_A10_WDT_BASE         0x01c20c90
 #define AW_A10_RTC_BASE         0x01c20d00
 #define AW_A10_I2C0_BASE        0x01c2ac00
@@ -83,6 +84,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "spi0", &s->spi0, TYPE_AW_A10_SPI);
 
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_AW_GPIO);
+
     for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -203,6 +206,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0, AW_A10_SPI0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi0), 0, qdev_get_gpio_in(dev, 10));
 
+    /* GPIO */
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, AW_A10_GPIO_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0, qdev_get_gpio_in(dev, 28));
+
     /* WDT */
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 445ba1be21..8b7736c7bd 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -13,6 +13,7 @@
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/ssi/allwinner-a10-spi.h"
+#include "hw/gpio/allwinner-gpio.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "system/block-backend.h"
 
@@ -42,6 +43,7 @@ struct AwA10State {
     AwSdHostState mmc0;
     AWI2CState i2c0;
     AWA10SPIState spi0;
+    AWGPIOState gpio;
     AwRtcState rtc;
     AwWdtState wdt;
     MemoryRegion sram_a;

-- 
2.55.0


