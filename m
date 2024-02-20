Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E09C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQOC-0007t5-DM; Tue, 20 Feb 2024 08:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQOA-0007rs-Cd; Tue, 20 Feb 2024 08:42:26 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQO8-0004CQ-Fv; Tue, 20 Feb 2024 08:42:26 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so745849966b.2; 
 Tue, 20 Feb 2024 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708436542; x=1709041342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=ORsgajgMVM3Tzdeowa2Bs6SZZz9icwt5BVXzvMbH8a+NM3kHbzoJmr188By7aaw9xT
 bboNe88J4/KwwHHfObpqRdQZpkKfqCTHzJzbGP8Vz37quV0Fj84mgsh1kezE/9EU4f2K
 TL2dmJ6OvY982SMlgx8g096hJzCbIJeeU9qRm6XcprWCKRRR9wZT86P70UuTZu4KxiGp
 EC4rGv/QjknVHcvfHyWaUiOpCna1R4vH1rz8X2iJFHXH0tBGK3qPkLgH1RhLe02Nuhkb
 dk6AH6IBk8i5gISaNC2oDt/aHTSz2MJRQbCDK8c0bGIEym5fNK6PSHSw1o4DGLwq8r+p
 dpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436542; x=1709041342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76PMiuvCr+h9caFqB/JdftZ0xwlXURfvkENSs4nk/uA=;
 b=hvHwTsixfqolI7JgYc+rQMSl6b4049N+D+iTvcoe8WGPxCrbQS+pOvAr8ugzzjG8AA
 5xlvyf5TXmzu2zeLMXKopm+txaZMgk1gGVMg7qljOvNUIEChoOJkMRmzkEElwlzAxfF5
 v6Yd173Y4sxgBt4g9APnqy3UycnSq2HKnGMSLTUsQlAM94DmwtHjy2SzmgFIWkPlFpZX
 gz5Wduj1QDXfHHMjOIMhvVkXT3pzLjqsD6fBLCpypRCpYaH5W59EylWOcRcFdhzb0Rfx
 eFbG2LX80emoltwDRZkzMfvm6U1osR4Dm/gAw7ItH/62sHu7DSa3NMyMaStKLNMbrqDb
 b/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqwm/VPUaEbJ0OB9rqM6YK+eBlVCoSNIv71+aEl+Ln4lDY+ArBujnuLrQaDQNmrD50gcevFl7YiLs1Vpi3/0R+QI+j
X-Gm-Message-State: AOJu0Yy4oYLW6tckVdLlW1EOIhiXCDSNppKPk0fG43is3wjALh94XJhc
 VxlvQPLT2Vh6Wz9HA43Rs9siEpJUGqj2mC23DMwJ5D8PPCEgSTPISKQpgtoa
X-Google-Smtp-Source: AGHT+IENdxUQLjrxENQ/BfE2FSE427gHH6WqwId/s5VrDgcEfGPJskqfp30En0z0wAXYM6UTpBhr0w==
X-Received: by 2002:a17:906:ce50:b0:a3e:55db:767d with SMTP id
 se16-20020a170906ce5000b00a3e55db767dmr4284036ejb.14.1708436542122; 
 Tue, 20 Feb 2024 05:42:22 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a170906591700b00a3ef17464b1sm728449ejq.9.2024.02.20.05.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:42:21 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v3 2/3] hw/arm: Connect BSC to BCM2835 board as I2C0,
 I2C1 and I2C2
Date: Tue, 20 Feb 2024 19:11:19 +0530
Message-Id: <20240220134120.2961059-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x634.google.com
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


