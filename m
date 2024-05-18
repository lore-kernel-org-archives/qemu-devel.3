Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C958C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 20:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8QIY-0003g5-3V; Sat, 18 May 2024 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIW-0003fN-UR; Sat, 18 May 2024 16:04:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8QIV-00062y-4N; Sat, 18 May 2024 16:04:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so40414735ad.2; 
 Sat, 18 May 2024 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716062689; x=1716667489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaz6YUca/EDsN6sz3NrbzFJ3pzsAImLY6LO7ZyVY8kw=;
 b=XpjwQjIWp4YXUbksCREuwjvBm4K0xBBx+uqhDTrbsKi8LDo+mgcmlqoYW/MS/8cu33
 3MkeIzmraP9EQ6dXN0ufiLoShOJZX39JY9q0n9n4f4JZKk4Zb1KxucgtQMJyXzz1pEBN
 7pq8CX2e7g+VoLQrjXOpSJSGyAOOR4dFkBI8kuk6S3uqxXCHeMhPpSqipbk2HUEUGedY
 E7Kd8iDVmGAUG2hUCL0oRaWCne91xgvbZ5us/F0UhCz3TeEKaBaXTMERPH1OseI6GlhG
 8NtjVVwojSQaRowdVt3YGx5W+84SoVGKJpr9L82tpcvQagNrqKze61WuhtjSHOFkNeHH
 FnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716062689; x=1716667489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaz6YUca/EDsN6sz3NrbzFJ3pzsAImLY6LO7ZyVY8kw=;
 b=AFXPFP7ZlS9np5PBBlYqYClTavwnZVj9W/VWbkWqWg3aDGTURriaRBfsFwLXItpNCp
 vSIkcWIuAiRVCRT/tldyaGuHwAJ2mQg1uKGCKknQO3efRfgS2e8AkN2C1dWTt3p9To20
 JK8bd2A+cFskhcZbioNH2LleYi8MqQSZOMJ59rP8dWFUbH75e3oDX98jhl3TEbU4Zgwd
 B/xtOGmrR2NBzulRkFv/7V3ILXBE8yroaRcnZkJZstI8vlMRfIkmvliIrT28tDM60MKg
 WxNcEtTmbomUMkaXSq67l/Qd/pA/h4E2qluqyAJeIYXv9Awi8RNjvWtP8GvUD9rFjkJC
 m3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/dAOPUMrjQopvDk6rk/iUjIfoQghUzJP4mAXNef+CyCXSFQNHmqarS14rLKwChZmELrk/tc9Sn4O95BFtaqzMk4aS
X-Gm-Message-State: AOJu0YzVgI3alyMGfjQTC2eykAOqGP+Zmf4ogv3ZqyPAFhj1qQfVSeOo
 9wz3rCcDN1acxDE60mZkZ+KcQLcGNG6QGA8oMZ4yo6GOZalzyG6MTR7igg==
X-Google-Smtp-Source: AGHT+IH6N6nXiBweY4zQ5zuuoCf/WmlvPCc22QMTvqnCZt/5+5BkOYRlkMgZGAnobxQEXjgQ4+FAUg==
X-Received: by 2002:a05:6a20:d487:b0:1af:f8bd:1e4e with SMTP id
 adf61e73a8af0-1aff8bd202dmr19259554637.62.1716062689050; 
 Sat, 18 May 2024 13:04:49 -0700 (PDT)
Received: from localhost.localdomain ([49.47.193.102])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0de0sm16637481b3a.116.2024.05.18.13.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 13:04:48 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 3/3] hw/misc: Implement mailbox properties for customer OTP
 and device specific private keys
Date: Sun, 19 May 2024 01:31:36 +0530
Message-Id: <20240518200136.1448672-4-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240518200136.1448672-1-rayhan.faizel@gmail.com>
References: <20240518200136.1448672-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x631.google.com
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
when running the SET_CUSTOMER_OTP mailbox command. Bit 6 of row 32 indicates
this lock, which is undocumented. The lock also applies to the device-specific
private key.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  2 +
 hw/misc/bcm2835_property.c           | 87 ++++++++++++++++++++++++++++
 include/hw/arm/raspberrypi-fw-defs.h |  2 +
 include/hw/misc/bcm2835_property.h   |  2 +
 4 files changed, 93 insertions(+)

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
index bdd9a6bbce..63de3db621 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -32,6 +32,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t start_num, number, otp_row;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -322,6 +323,89 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
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
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
+                otp_row = bcm2835_otp_get_row(s->otp,
+                                              BCM2835_OTP_CUSTOMER_OTP + n);
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2), otp_row);
+            }
+            break;
+        case RPI_FWREQ_SET_CUSTOMER_OTP:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            /* Magic numbers to permanently lock customer OTP */
+            if (start_num == BCM2835_OTP_LOCK_NUM1 &&
+                number == BCM2835_OTP_LOCK_NUM2) {
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_ROW_32,
+                                    BCM2835_OTP_ROW_32_LOCK);
+                break;
+            }
+
+            /* If row 32 has the lock bit, don't allow further writes */
+            if (bcm2835_otp_get_row(s->otp, BCM2835_OTP_ROW_32) &
+                                    BCM2835_OTP_ROW_32_LOCK) {
+                break;
+            }
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_CUSTOMER_OTP + n, otp_row);
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
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
+                otp_row = bcm2835_otp_get_row(s->otp,
+                                              BCM2835_OTP_PRIVATE_KEY + n);
+                stl_le_phys(&s->dma_as,
+                            value + 20 + ((n - start_num) << 2), otp_row);
+            }
+            break;
+        case RPI_FWREQ_SET_PRIVATE_KEY:
+            start_num = ldl_le_phys(&s->dma_as, value + 12);
+            number = ldl_le_phys(&s->dma_as, value + 16);
+
+            resplen = 4;
+
+            /* If row 32 has the lock bit, don't allow further writes */
+            if (bcm2835_otp_get_row(s->otp, BCM2835_OTP_ROW_32) &
+                                    BCM2835_OTP_ROW_32_LOCK) {
+                break;
+            }
+
+            for (n = start_num; n < start_num + number &&
+                 n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
+                otp_row = ldl_le_phys(&s->dma_as,
+                                      value + 20 + ((n - start_num) << 2));
+                bcm2835_otp_set_row(s->otp,
+                                    BCM2835_OTP_PRIVATE_KEY + n, otp_row);
+            }
+            break;
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
@@ -449,6 +533,9 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
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


