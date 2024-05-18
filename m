Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0D7C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 20:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8QIW-0003en-5Y; Sat, 18 May 2024 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIU-0003eQ-Qc; Sat, 18 May 2024 16:04:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIT-00062k-6n; Sat, 18 May 2024 16:04:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4302187c0so1692916b3a.1; 
 Sat, 18 May 2024 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716062687; x=1716667487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nR1fFYfnhfe8OWUbCv/jg5IVIW3zj6nZbcBspKeIn5Q=;
 b=CuekIlHJMGPeFTzwSjASRjhyrGFIe7DZvudEmnQ6gGiuA4ZVB2xBfg093BfX3TTv6F
 rSCa7E19Oc48vAB06331CxfemKEQue4ENYzFPGG6jN7v84N+106Tfodh6/C7hq0xdg6l
 VpolAf7xhJY1pZlxvSy8eQKQEzi0sEJNh2ksMelRrhNMrZelhxCHjTg0A4KeocvnMu1B
 CvPHHD3kRwDEqgon7/1uZ28ipIDVm2/PoKPULZeyVT79IbJo4YbfEDLJ1GRooFNpHXka
 JccyMImIYTZ3mDPe8tIo988bkbNcFHnDs5TVJ2s0T0oSbkMHYlD+7CE/orvQdQuGrmru
 4Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716062687; x=1716667487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nR1fFYfnhfe8OWUbCv/jg5IVIW3zj6nZbcBspKeIn5Q=;
 b=vl9J8ylOnfzchbpoXSnyBbtVByiLXDt7To1xhWnUH/rXgMSaz8CcUt1bEwZXrxh6xC
 oHZ+WBvP+wqQFvDd1NhzFq2EUMXMNeUi+5zMMuCcNHIjXlQ0LSvIpDM7ZG+eowZvBkuQ
 YoxnYm0UTFhBr/DNfVIr28j6rQejCv7NKMsJl/CPsxq1ky9vLoy9Z+e8I7HT7Tpr0h/y
 OAW7TFCC8R/3/4J/05En6xLwL4JIDyr5mtYGEbKjReFiOjyn0umJXEtnd5cdRqSdgOtj
 2hR8UfvOy+oAyiiI2v/4OwvUfETB5ckZAoUkrRhKQg8WOFMt/lI9zb0ki4lnhRo4ZfEL
 lknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeXx7N1Lric7ElccrqwKk6yh3rSgXNHw6NbZl8yM64vvuRTMLogsR0Id0OF5zb4UwEBVy4U8ngbJDLJX0gjirVDwcp
X-Gm-Message-State: AOJu0YwS6zQjQBmxBkrRFOE3FBVXuZPijj1m4y24zED2O7vsY8wv27l0
 YfLvfdxS6O+U75X7BSoFIXq/H4EIA7jl2t8s2RHjo8H94GYD6UQ0Ih0M9w==
X-Google-Smtp-Source: AGHT+IGXYgeZ921Lu3BijGCvIvEJoD8KZE4qEF2C1j3hD9AHlEnb8AvnJa4rumDEMuk/bf0KORcomQ==
X-Received: by 2002:a05:6a20:3949:b0:1af:58f8:1190 with SMTP id
 adf61e73a8af0-1b1ca3c3ebfmr3180971637.12.1716062686671; 
 Sat, 18 May 2024 13:04:46 -0700 (PDT)
Received: from localhost.localdomain ([49.47.193.102])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0de0sm16637481b3a.116.2024.05.18.13.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 13:04:46 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 2/3] hw/arm: Connect OTP device to BCM2835
Date: Sun, 19 May 2024 01:31:35 +0530
Message-Id: <20240518200136.1448672-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240518200136.1448672-1-rayhan.faizel@gmail.com>
References: <20240518200136.1448672-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pf1-x42c.google.com
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

Replace stubbed OTP memory region with the new OTP device.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         | 13 ++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1695d8b453..7d735bb56c 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -116,6 +116,10 @@ static void raspi_peripherals_base_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
+    /* OTP */
+    object_initialize_child(obj, "bcm2835-otp", &s->otp,
+                            TYPE_BCM2835_OTP);
+
     /* Property channel */
     object_initialize_child(obj, "property", &s->property,
                             TYPE_BCM2835_PROPERTY);
@@ -374,6 +378,14 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fb), 0,
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
+    /* OTP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, OTP_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->otp), 0));
+
     /* Property channel */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), errp)) {
         return;
@@ -500,7 +512,6 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
     create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 636203baa5..1eeaeec9e0 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -33,6 +33,7 @@
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
 #include "hw/i2c/bcm2835_i2c.h"
+#include "hw/nvram/bcm2835_otp.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -71,7 +72,7 @@ struct BCMSocPeripheralBaseState {
     BCM2835SPIState spi[1];
     BCM2835I2CState i2c[3];
     OrIRQState orgated_i2c_irq;
-    UnimplementedDeviceState otp;
+    BCM2835OTPState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState v3d;
-- 
2.34.1


