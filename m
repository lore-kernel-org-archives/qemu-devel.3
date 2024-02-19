Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684DCC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 23:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcCdx-0001Wd-Hx; Mon, 19 Feb 2024 18:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcCdt-0001Ud-O5; Mon, 19 Feb 2024 18:01:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcCds-00040A-2P; Mon, 19 Feb 2024 18:01:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4126ac0c32eso5893775e9.1; 
 Mon, 19 Feb 2024 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708383702; x=1708988502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=a1Y2/Ud9UZ1Rd0MyKjKfTsBOQaUvIJXmeJ1wdZiCgnM6FgHw8RD9ffspZjgjqDplq5
 ytcpO2ckNDDhrxoyClviZYZQQgD8lEWfGHNlZGAtUTTJyGb7IH5EyEOEaKyyo3+ZZQqv
 vSfxBnEGJtgoXIY0OOh5IdOG3ZskgQGKdrTfszE/G20EfoCfOua/AkNiy6m3TXuIdCv6
 F9PRP6UnbYPOohXp8lk3P160g6f3jBYGvEG/h2AqC+I/5gHMIJBozBL7EfZhx80KxeRl
 ljJLhb5mfZXNxoadnoiFnxJDoSMX6RYz6XyntHdE1MwYzr5+rma6AXNwog/4u6JIQgWv
 g5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708383702; x=1708988502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=ePU1W7BOusAsaYkI49iQQCTSo7eDKmJE854xmvXMiYOsx+QP8fT71RI2f7AU+dUMpO
 0ttH1yZm9YMTiiaYw77n/hZAXUBbODU2YFgNKTC/FTWWXSsoMN9G2/1C0tYQU9ngGeli
 XUtcKV5IuvllaLgnvufeSvhPIIpEzwD3Xr6vGn+GTHV94XFE715RxT4dPuRIVhwPJJG/
 nc6vRISNw8OPMJEMohcWi5iAzFZmXGtiTfluDFXOhC4gcPdh1SGbUl/V61W2BjZUUxaT
 BJo4dlU9rDzL3QWZ3PaqMBs/57G4ZWTc5IYgB5y/3+4ZcGqNT2Pe3IY9zH1WSDBBJmbD
 DoZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHgqWBMWSyI4x7k05kE0jjwNkSKFAivNDGtC3MYFlJLQlA9+IqPxcpLlNN8Dze+tkT8yRQ2wti/5rzi9uVUGsJnP8q
X-Gm-Message-State: AOJu0YzVdH83ioojdFQ3yU85OuCbkqX/EJ24S99wsDvSWZCAc1oo0nQH
 AXw/pXZ0w9GxbbrNiJJm+tHLw1ihSLB6YrImtM5/rEOkRnCX3uf59/zeRkEnxP0=
X-Google-Smtp-Source: AGHT+IF5N0p0O0yHlK7rc9s7Sph+LzCz1dMMjI6bMHCqdI88ehLMk35yC5brcv/okdik2ssIIQtRyA==
X-Received: by 2002:a05:600c:4896:b0:411:defc:c7df with SMTP id
 j22-20020a05600c489600b00411defcc7dfmr9712649wmp.24.1708383701005; 
 Mon, 19 Feb 2024 15:01:41 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c020d00b00410dd253008sm12508206wmi.42.2024.02.19.15.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 15:01:40 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 2/3] hw/arm: Connect BSC to BCM2835 board as I2C0,
 I2C1 and I2C2
Date: Tue, 20 Feb 2024 04:29:57 +0530
Message-Id: <20240219225958.2421873-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219225958.2421873-1-rayhan.faizel@gmail.com>
References: <20240219225958.2421873-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

BCM2835 has three I2C controllers. All of them share the same interrupt line.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/Kconfig                       |  1 +
 hw/arm/bcm2835_peripherals.c         | 32 +++++++++++++++++++++++++---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 980b14d58d..2b52cec980 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -430,6 +430,7 @@ config RASPI
     select SDHCI
     select USB_DWC2
     select BCM2835_SPI
+    select BCM2835_I2C
 
 config STM32F100_SOC
     bool
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index d5573fd954..ca692ed9a5 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -148,6 +148,14 @@ static void bcm2835_peripherals_init(Object *obj)
     /* SPI */
     object_initialize_child(obj, "bcm2835-spi0", &s->spi[0],
                             TYPE_BCM2835_SPI);
+
+    /* I2C */
+    object_initialize_child(obj, "bcm2835-i2c0", &s->i2c[0],
+                            TYPE_BCM2835_I2C);
+    object_initialize_child(obj, "bcm2835-i2c1", &s->i2c[1],
+                            TYPE_BCM2835_I2C);
+    object_initialize_child(obj, "bcm2835-i2c2", &s->i2c[2],
+                            TYPE_BCM2835_I2C);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -418,14 +426,32 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                               BCM2835_IC_GPU_IRQ,
                                               INTERRUPT_SPI));
 
+    /* I2C */
+    for (n = 0; n < 3; n++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[n]), errp)) {
+            return;
+        }
+    }
+
+    memory_region_add_subregion(&s->peri_mr, BSC0_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[0]), 0));
+    memory_region_add_subregion(&s->peri_mr, BSC1_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[1]), 0));
+    memory_region_add_subregion(&s->peri_mr, BSC2_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[2]), 0));
+
+    for (n = 0; n < 3; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[n]), 0,
+                           qdev_get_gpio_in_named(DEVICE(&s->ic),
+                                                  BCM2835_IC_GPU_IRQ,
+                                                  INTERRUPT_I2C));
+    }
+
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 0203bb79d8..9e8984b444 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -32,6 +32,7 @@
 #include "hw/timer/bcm2835_systmr.h"
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
+#include "hw/i2c/bcm2835_i2c.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -68,7 +69,7 @@ struct BCM2835PeripheralState {
     Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
     BCM2835SPIState spi[1];
-    UnimplementedDeviceState i2c[3];
+    BCM2835I2CState i2c[3];
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
-- 
2.34.1


