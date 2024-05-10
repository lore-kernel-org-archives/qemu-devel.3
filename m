Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09ABC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R4K-0006vO-NP; Fri, 10 May 2024 10:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4J-0006v8-Mf; Fri, 10 May 2024 10:17:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4H-0001TO-OT; Fri, 10 May 2024 10:17:51 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59ce1e8609so546138866b.0; 
 Fri, 10 May 2024 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350668; x=1715955468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Qus3TP0r22uQK8njN9qr9EZfmllExJha/rVCXLGB6A=;
 b=FX2tViE0nwXey+o8k3hZOQfOqyrqf0K3Z9WvLAzd31VZ7KA13C+a8JABGObDphNSg5
 C6vc0wgGIPGmayUcILQ2vgdYo6iiwks8evHcGdLRE/rKcOGge6yPZQR06o4BaTQT0QeG
 tsuzdGEsmHeA3qJvKWS/cyag6DZikAlPp49B3MOVpeLr9u2jCnbgqcxqK/O/E9WBS0Dx
 cw9O/Gy3Zzr+7kOCKhFpecBmiqEIwACPJnSrQC+EtsbPSLPXQ1JoARYlrI4ZwRc2F79I
 6qG+/EUjdBqgFVPdfFuHRQP1/Kg9qfHGkN0Aby4lafZXRFoeg/NyGan3Loi7hwzrsJtj
 dbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350668; x=1715955468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Qus3TP0r22uQK8njN9qr9EZfmllExJha/rVCXLGB6A=;
 b=A72ImCFKYjOoV5DOzCk5Umf42gaHEr7Fd/uhrSBwkWTAaqOL8Ued7v+NRFSqyj41Qg
 xCYgXFCpQAYNn0g4+Xe3aoo5zfTXmQ4GcBlrcqqp+uD4otVZRBQc0a0WfwKrd186Bt9b
 UGvZicnl8N+Xn6QdESNo1FD9Jh8q/FEr3jLISPW47Ud3PcigTXzM8cX3W+AXbvY+CFti
 2pj6xfokAk/zKSgUn4wY346ua+y03RbCKPOitutx1g0F2mpw0O00JZQtK1abbb+Uzj3+
 vp+2Q0a8t2LYdCQRoUpQyvgqRIV2+c6ous9/BO5UXXh/Q9FEuEdFVYevFtdPBQ02/0Cn
 dbKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV7IBGcXT3xcHQUv4iS8WG4/bOvYNQLSXcVWxexVDx2eoUWnblKzzEfmml3slMPhYHzH1+CJhnIwkg0YLfQQ/idT6a
X-Gm-Message-State: AOJu0YwRcp44LU1r61yhZTfwAL4EUIR4/LTbd8hdTE2N78gwhNcYcL3Y
 fk27CeCXjYKYBMNHtvEEoUlRSGMrKMtOaGlchQwx04LFXoDGR8sCmVY7/g==
X-Google-Smtp-Source: AGHT+IH4TEv+jQ8MZ29noboyJT3On2zZ9xSn7GiznfhILTHOPneSXHnPMU5ll36F0KL47Z6EluJLEw==
X-Received: by 2002:a17:906:19d0:b0:a59:fb06:5d35 with SMTP id
 a640c23a62f3a-a5a1156665fmr471583766b.8.1715350667667; 
 Fri, 10 May 2024 07:17:47 -0700 (PDT)
Received: from localhost.localdomain ([212.70.119.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f6esm190093466b.54.2024.05.10.07.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:17:47 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 3/3] hw/misc: Implement mailbox properties for customer OTP
 and device specific private keys
Date: Fri, 10 May 2024 19:40:10 +0530
Message-Id: <20240510141010.656561-4-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510141010.656561-1-rayhan.faizel@gmail.com>
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x634.google.com
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

Four mailbox properties are implemented as follows:
1. Customer OTP: GET_CUSTOMER_OTP and SET_CUSTOMER_OTP
2. Device-specific private key: GET_PRIVATE_KEY and
SET_PRIVATE_KEY.

The customer OTP is located in the rows 36-43. The device-specific private key
is located in the rows 56-63.

The customer OTP can be locked with the magic numbers 0xffffffff 0xaffe0000
when running the SET_CUSTOMER_OTP mailbox command.

P.S I am not sure if the magic lock combo applies to the private key as well.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  2 +
 hw/misc/bcm2835_property.c           | 71 ++++++++++++++++++++++++++++
 include/hw/arm/raspberrypi-fw-defs.h |  2 +
 include/hw/misc/bcm2835_property.h   |  2 +
 4 files changed, 77 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7d735bb56c..ac153a96b9 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -132,6 +132,8 @@ static void raspi_peripherals_base_init(Object *obj)
                                    OBJECT(&s->fb));
     object_property_add_const_link(OBJECT(&s->property), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
+    object_property_add_const_link(OBJECT(&s->property), "otp",
+                                   OBJECT(&s->otp));
 
     /* Extended Mass Media Controller */
     object_initialize_child(obj, "sdhci", &s->sdhci, TYPE_SYSBUS_SDHCI);
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index bdd9a6bbce..bbd9c40af2 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -32,6 +32,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t start_num, number, otp_row;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -322,6 +323,73 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                         0);
             resplen = VCHI_BUSADDR_SIZE;
             break;
+
+        /* Customer OTP */
+
+        case RPI_FWREQ_GET_CUSTOMER_OTP:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 8 + 4 * number;
+
+            for (n = start_num; n < start_num + number && n < 8; n++) {
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2),
+                            bcm2835_otp_read_row(s->otp, 36 + n));
+            }
+            break;
+        case RPI_FWREQ_SET_CUSTOMER_OTP:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            /* Magic numbers to permanently lock customer OTP */
+            if (start_num == 0xffffffff &&
+                number == 0xaffe0000) {
+                /* Row 30 Bit 30 indicates disabled OTP programming */
+                bcm2835_otp_write_row(s->otp, 30, 1 << 30);
+                break;
+            }
+
+            /* If customer OTP is locked, don't allow further writes */
+            if (bcm2835_otp_read_row(s->otp, 30) & (1 << 30)) {
+                break;
+            }
+
+            for (n = start_num; n < start_num + number && n < 8; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_write_row(s->otp, 36 + n, otp_row);
+            }
+            break;
+
+        /* Device-specific private key */
+
+        case RPI_FWREQ_GET_PRIVATE_KEY:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 8 + 4 * number;
+
+            for (n = start_num; n < start_num + number && n < 8; n++) {
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2),
+                            bcm2835_otp_read_row(s->otp, 56 + n));
+            }
+            break;
+        case RPI_FWREQ_SET_PRIVATE_KEY:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            for (n = start_num; n < start_num + number && n < 8; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_write_row(s->otp, 56 + n, otp_row);
+            }
+            break;
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
@@ -449,6 +517,9 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-memory");
 
+    obj = object_property_get_link(OBJECT(dev), "otp", &error_abort);
+    s->otp = BCM2835_OTP(obj);
+
     /* TODO: connect to MAC address of USB NIC device, once we emulate it */
     qemu_macaddr_default_if_unset(&s->macaddr);
 
diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 8b404e0533..60b8e5b451 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -56,6 +56,7 @@ enum rpi_firmware_property_tag {
     RPI_FWREQ_GET_THROTTLED =                          0x00030046,
     RPI_FWREQ_GET_CLOCK_MEASURED =                     0x00030047,
     RPI_FWREQ_NOTIFY_REBOOT =                          0x00030048,
+    RPI_FWREQ_GET_PRIVATE_KEY =                        0x00030081,
     RPI_FWREQ_SET_CLOCK_STATE =                        0x00038001,
     RPI_FWREQ_SET_CLOCK_RATE =                         0x00038002,
     RPI_FWREQ_SET_VOLTAGE =                            0x00038003,
@@ -73,6 +74,7 @@ enum rpi_firmware_property_tag {
     RPI_FWREQ_SET_PERIPH_REG =                         0x00038045,
     RPI_FWREQ_GET_POE_HAT_VAL =                        0x00030049,
     RPI_FWREQ_SET_POE_HAT_VAL =                        0x00038049,
+    RPI_FWREQ_SET_PRIVATE_KEY =                        0x00038081,
     RPI_FWREQ_SET_POE_HAT_VAL_OLD =                    0x00030050,
     RPI_FWREQ_NOTIFY_XHCI_RESET =                      0x00030058,
     RPI_FWREQ_GET_REBOOT_FLAGS =                       0x00030064,
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index ba8896610c..2f93fd0c75 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/display/bcm2835_fb.h"
+#include "hw/nvram/bcm2835_otp.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_PROPERTY "bcm2835-property"
@@ -26,6 +27,7 @@ struct BCM2835PropertyState {
     MemoryRegion iomem;
     qemu_irq mbox_irq;
     BCM2835FBState *fbdev;
+    BCM2835OTPState *otp;
 
     MACAddr macaddr;
     uint32_t board_rev;
-- 
2.34.1


