Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C38EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRvy-0007yf-Qi; Tue, 18 Aug 2026 18:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvw-0007y1-T8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:24 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvu-0001RA-N3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:24 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5aeb24c0807so378213e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787090721; x=1787695521; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n+bFI7NMOKFyTqZjD2J643gd9nkuw7CEQP5XcBksxKI=;
 b=Zhx+hwxo4BjuC35Zupht3vp4W8MPFF2HRePwArcaXGNE4iaRq9PWNcPndpbc3+oewM
 YhUZ18Y5+DD9vmR0VTV6xc5VYcVXxbTgba2fh+xoxj7MSkM2WxpRnXzes5Sv+Fquabix
 DzsUel2h5+HJJb7bx7fLCYL0SAs12QaReAaxGyzCJ5hRgz0lRoZD2h0UL4622tm+hGYo
 nhLQMCT6CP478SA6khTzBGtUQYApHiUPdjilFnJWNd7krnP/kdBFJZ9dYbWIG8Ln6oS0
 6irEFbxqBwzIrfnqUUR/EoqL63l2RyId8axUDjtIgWtvDWfLtknZjb31413LxN33bnjq
 06Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787090721; x=1787695521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+bFI7NMOKFyTqZjD2J643gd9nkuw7CEQP5XcBksxKI=;
 b=kuphnMR3QGLM0yy0q8bSd/8xIUUTzrMIQFnp72QGjTuL4kA7WPbWC3DbMKW7aMs4Ot
 uOnZ/Nparv/3YHTuFVGs6OgCW/9lpsPU0MFtOrUuSja+m1Y8DHqx4i1t0OAbY5HrkKJd
 Jnom2g40U7EMkjFEN5IKhNDN3ADcL9wjrBaABtWjmnMhjI2HH57Uuo5cpoQ+nh5vDOdD
 WqgnDvt53eevLG/KsSR5HMI0CeoiuESG6IjXQOsJUyGHLUdG6WQ2NXyvQ5ZC99p5auzc
 Vee5qnFpA6Etf8Qjv7Gq02pfFFuibXUg7IQOoxamvcgQTiqN6ZhCw0toRVZg60Mv3Un0
 NWfw==
X-Gm-Message-State: AOJu0YydlfJ3ixDJc/xSCL5Ut+aeMaIRoyL5Ehc/T4LBlLKsxyHsUPfH
 iByrevRJXTjvQCH4wtGKU9YCqckVDbYPjmk+kcWOQeoX6tsqzlflE+9f
X-Gm-Gg: AR+sD13gx0bJyU6k26M5ra8DiRfESyLJmuTwYWA1uxpfKPgfrcSnIrFZ9nSy0Ow0orU
 UO/NsQ0fMhRIzV2Z+8oTE7D75OP4RkbGjK4sb0Yuo54NrlUBifGMs6xYRNtMGC6Ney+Y/puiULy
 6urdV+GTyj75iVPXsAxvJnAu+/Ucv6PXDvSeYQh+qJwVyGqTH/DB6HrhTxT32VoZmsF89ZS6PZt
 uCuqsWMEWwbV5o5E/9vvg49dBYCVSz9IdHU1x1l8NrpZWmrR50orRbkZwPAzgEZLSq8yVPszRUa
 wXeCG/qxM/Dl+8TddcJBOGtXdxpJCSZ12FnlXHtSIbfF//NleL0sWdF/1d+5Geh0D/VokSIeadm
 m9/vjmjJZ48HNg81aegCs7eQZGa1b7GfF7a6CblCfAVNV7bEZsodqwsOkdtHDAlx9McXiR2XwxZ
 jEWnsh5YwQ/T9yKj0uveCPawrtaqh5Dw9QYDiLU3FViJ4rKEl0OKOP3jKbKlu8VEp0ewMHmf5wd
 C2PNX2T76gt+2OnM/sH3lbPtp0hrms/hg8RGb+5rEOoKuuQ
X-Received: by 2002:ac2:4e0d:0:b0:5b2:b941:ddae with SMTP id
 2adb3069b0e04-5b478b929d8mr14872e87.4.1787090720698; 
 Tue, 18 Aug 2026 15:05:20 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b478853ae5sm21836e87.17.2026.08.18.15.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:05:19 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Wed, 19 Aug 2026 00:04:52 +0200
Subject: [PATCH 2/3] hw/arm: Add GPIO to Allwinner A10 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-allwinner-gpio-v1-2-2a64866dff11@gmail.com>
References: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
In-Reply-To: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 260d2f0751..6d326746c9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -311,6 +311,7 @@ config ALLWINNER_A10
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


