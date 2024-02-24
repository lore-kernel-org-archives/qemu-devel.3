Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3EFC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 20:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdyYf-0006zb-II; Sat, 24 Feb 2024 15:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rdyYb-0006xR-IK; Sat, 24 Feb 2024 15:23:37 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rdyYZ-0004I7-Sl; Sat, 24 Feb 2024 15:23:37 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so2445809a12.1; 
 Sat, 24 Feb 2024 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708806214; x=1709411014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytWfPiHTfSX9hu1E+RJxwGcfyenLHqm6QqCMK5xCqPg=;
 b=C5dPyUr3LEdsusEbLGc4Raqyizjrzs6JZCKaWcs7FE3kyuSyfy9C67xQKZWKacwl+U
 zkWYkUf4SQaN/tEnCH0Qpf+So6MWbpyGq+icPaOj3jt+MjgbFtqQe6C2QbFRloQNJXM7
 Hc071RNpUTLMkTvpj1PwKJdNAj25gpx0jXlZYvwCkZIYhkLIipbqOefSlU5F3bIFw2QE
 M+003Mq3cSMFIzSRETUJV9oIthhhTil3ITzVJdnUkwcP8XzTVJHjbidT5joYKpT5JFrf
 GDhKqwn9CZoULZgu6zkHZ6+oZgqITBt9mik8jiV++zVgTgcT1NnGxcQQ0Oyr5I7gPjn/
 Pc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708806214; x=1709411014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytWfPiHTfSX9hu1E+RJxwGcfyenLHqm6QqCMK5xCqPg=;
 b=bkm9Zx6i9RgxBuKufsSkj9QLduZcpRAojwc/wXmsGcjDCITr59jlvpkMHyokk9TNsR
 Abuq+qgccTLiw5LlSfKUOuaMa/Ry3ph9b/1vsAVsf6FZZvhoETKJlGtZ0gnYN2/ieA+D
 oG3vqyWL3hxqQ9oJODvRLemQv0YqmZBO9KcRCMPNzwIw9QZSKMFFKDsxxNDqGQnWevpV
 lBKhqpZQAE6/1xYzVBZK4m7VMaPEROBjezkaHeoGBXoY2mgTSj7VKjpC/PMNs1k0k4/R
 z5HuSnWOdBMFjJlidTu4ykl6D9Gaz0HC7jIw9mmry82YksdEKiv3SU4xpCp1Jjgip+LM
 ZYEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeVsNSFeK7lFbcSu47oTUY+tTEMxdOkjdXu8nATN/WMqbk1g57RSfyY52v5ucP91+/3ljLO0xbJStNHfUJsXQettQi
X-Gm-Message-State: AOJu0YwqXIRmsgm9fvWPVfhEmaSDw5x2luUbe40M83vW2yAeW2LVs0Xj
 B1b713C99O0f/29e48QPnv1gaCecbFDSxuMkTxtz/Nssg//yOp8s+ey6nugC
X-Google-Smtp-Source: AGHT+IHNdHPNAtOA/Q0Da3pLMtyh5Y4VptljvbUU+ctTV+0WJYy5BQu11fzY7InUzOeldfPW7HPi+A==
X-Received: by 2002:aa7:cd19:0:b0:564:4a18:45f1 with SMTP id
 b25-20020aa7cd19000000b005644a1845f1mr2386360edw.17.1708806213426; 
 Sat, 24 Feb 2024 12:23:33 -0800 (PST)
Received: from localhost.localdomain ([212.70.108.232])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a50ee02000000b00560c6ff443esm816108eds.66.2024.02.24.12.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 12:23:33 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v4 2/3] hw/arm: Connect BSC to BCM2835 board as I2C0,
 I2C1 and I2C2
Date: Sun, 25 Feb 2024 00:32:44 +0530
Message-Id: <20240224190245.2405016-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224190245.2405016-1-rayhan.faizel@gmail.com>
References: <20240224190245.2405016-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ed1-x534.google.com
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
 hw/arm/bcm2835_peripherals.c         | 45 ++++++++++++++++++++++++++--
 include/hw/arm/bcm2835_peripherals.h |  4 ++-
 3 files changed, 46 insertions(+), 4 deletions(-)

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
index d5573fd954..9642df22cf 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -30,6 +30,9 @@
 #define SEPARATE_DMA_IRQ_MAX 10
 #define ORGATED_DMA_IRQ_COUNT 4
 
+/* All three I2C controllers share the same IRQ */
+#define ORGATED_I2C_IRQ_COUNT 3
+
 static void create_unimp(BCM2835PeripheralState *ps,
                          UnimplementedDeviceState *uds,
                          const char *name, hwaddr ofs, hwaddr size)
@@ -148,6 +151,19 @@ static void bcm2835_peripherals_init(Object *obj)
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
+
+    object_initialize_child(obj, "orgated-i2c-irq",
+                            &s->orgated_i2c_irq, TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s->orgated_i2c_irq), "num-lines",
+                            ORGATED_I2C_IRQ_COUNT, &error_abort);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -418,14 +434,37 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
+    if (!qdev_realize(DEVICE(&s->orgated_i2c_irq), NULL, errp)) {
+        return;
+    }
+    for (n = 0; n < ORGATED_I2C_IRQ_COUNT; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[n]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->orgated_i2c_irq), n));
+    }
+    qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq), 0,
+                          qdev_get_gpio_in_named(DEVICE(&s->ic),
+                              BCM2835_IC_GPU_IRQ,
+                              INTERRUPT_I2C));
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
index 0203bb79d8..09a3c06533 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -32,6 +32,7 @@
 #include "hw/timer/bcm2835_systmr.h"
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
+#include "hw/i2c/bcm2835_i2c.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -68,7 +69,8 @@ struct BCM2835PeripheralState {
     Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
     BCM2835SPIState spi[1];
-    UnimplementedDeviceState i2c[3];
+    BCM2835I2CState i2c[3];
+    OrIRQState orgated_i2c_irq;
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
-- 
2.34.1


