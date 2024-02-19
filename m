Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE28C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc9kz-0004Aa-4B; Mon, 19 Feb 2024 14:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9ks-000498-UY; Mon, 19 Feb 2024 14:56:47 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9kq-0000Qq-Qt; Mon, 19 Feb 2024 14:56:46 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so648288466b.2; 
 Mon, 19 Feb 2024 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708372603; x=1708977403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=H6SjbrGAsalybJsm7qGGVwiaTMY2Zs0rgEvPn7f6NtJFV1fF0ydbANRTMcv61Mizcp
 c3ZMIvxBoKYnfjr2Z4WB4WKRKEciE82DHlaoeLCDNu1xCjDiipSZZ0vfVVC/bLh/yXPn
 svEzVe6NUKszbJ+3DboBPx4PSBbhrkIsWo/3NBDXdFGAr6ROMh/1lGo2fdRhMywnJa0s
 tkXO8m3RFGQ1/yzM1izrwcXIEYn3z6cltTHbtHk3TDuDPWoKjvtlZ2W1m0l8d1WjYahv
 QBNsbz9Zm0KYhSe2mlLJjbWbgWVPDEwtu50BmzHv2LbCuniLcKkt8+Y70132HLH2kNvO
 JbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708372603; x=1708977403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=BOPmtS1mp/AEpf6UFeS0/tQ4jpG8bvDFA4P6MDrrWQ/csQT/pWX8+vQgbh3lflUXo3
 54TtgO8lwIBQWOBex2zCgTvDBXpE/2bz1CqkXmOV3ujzYqg8MFiW36BkaBOqYbdkzx2X
 Z1fPC9EhMfXkoOXHSSKBsViDdwtZ6V4mOMOPaTxoIqc4lihjhhVKH3PyMNM2QUkde+7J
 qQYdpC9DavxDSqETjkgDcL6jb0ZbYSdjB7uX0KGWR58x4aKZoG527ahRLahuJA81WRGd
 Qt+QNeWpNYtCUTa/Nm+SA0mVubwlrGmHHE2FQPLpTKiCOKKdqMR2TzlOfAiwdLJVfUOB
 YeYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVjzm9WiAsunXcbmkQ7FklCbgJ4L4XqbZnr4q6hesxNimUFyjXIAGnUwGZOcsdP1DvePSqY0kcxe4vny1ugEXR0qqj
X-Gm-Message-State: AOJu0YyXaQ9Q0Go0CLOG6Uiy8pEsOEy7sJhuAzRZYH7Ln0IC2Rslnc3m
 FcS70iDyopY26nYMCylxnAvJP90/rIpoYDWrNu5Vzhyf4l+D5hVfUoVNgxyTwOY=
X-Google-Smtp-Source: AGHT+IG141H6+zVeZMnYWx+001JwhRYpaAMHbn6lzjZXJyXh7SBv2MpE/bmLhqnmCw5tmUKjHRWfZw==
X-Received: by 2002:a17:906:80e:b0:a3d:6c76:b1a2 with SMTP id
 e14-20020a170906080e00b00a3d6c76b1a2mr8629942ejd.31.1708372602542; 
 Mon, 19 Feb 2024 11:56:42 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a170906a09300b00a3daa068f76sm3255911ejy.65.2024.02.19.11.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 11:56:42 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 2/3] hw/arm: Connect BSC to BCM2835 board as I2C0,
 I2C1 and I2C2
Date: Mon, 19 Feb 2024 22:51:32 +0300
Message-Id: <20240219195133.2304668-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219195133.2304668-1-rayhan.faizel@gmail.com>
References: <20240219195133.2304668-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x62e.google.com
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


