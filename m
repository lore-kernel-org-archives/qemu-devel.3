Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9075C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 09:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8d3u-0001zr-27; Sun, 19 May 2024 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8d3s-0001ze-EP; Sun, 19 May 2024 05:42:36 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s8d3q-0004Z6-DI; Sun, 19 May 2024 05:42:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso48557825ad.3; 
 Sun, 19 May 2024 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716111752; x=1716716552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJg5/M6WveEUortmoza4Bb6kMSbVYqjSlBIu9zHnUrM=;
 b=G53xsAThnVHlYah0bN8T0CexA4moxKonQRrDshfRzcKBEymZZWZudKbzSA47a5oOCm
 Y3Lvl22vpNZTZlk8hsMIrpDj/lewn+9Zsut2eg4NFU8M+gEGZIHPM8t+Z5XWBANUzN3S
 tCG/dFjtO5dQR7JZ/3Y0Q1m2gCyvrN2agpEcQhCIzugO5VLHFNQXmixMj16d7Yfv55st
 Ycd6P/7Z1FDIzx11TPx3wDACn7MZM7K3587RgCvddWvzgJIrCApQ78iwhXDT2b4x7I1Z
 UR/Gxp4ad3FusYUqkZfvyS/UbX/SbTma1EoDWXtG6koY1qr1b6w/1/rssaAQOTUeYwVp
 YWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716111752; x=1716716552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJg5/M6WveEUortmoza4Bb6kMSbVYqjSlBIu9zHnUrM=;
 b=ZROceSz/ON/dl+Djm9wHlw7SLJBbp5qaoxxN+GWtgGN5Yp0mapMjD+sXbL1ZxtuCy/
 E9Q0ZDnxZUnfK4YTLelXqg/dqQWcEE1Bvq53BL7rQhZND/30V1Q+jfX9zTRWwfDvlpTC
 qotgOdw+weZvKyVh5egGOXW0Rl09UUKNrcOIxnzbz8W8hmKIrbHyKlZdhcJ6bXKjECVb
 6fi83+9dM7yf4COSXXJ2ASBf0Pip31nVAqFsCzIK2SUfnbjlLKSIcr6ObqOaXHPaCRab
 5kG9j5/AYLGViZfaNTms19qHHUX3H/4eQXBoynH2WvGek8iem83/8GsyYWK+BztDTyqm
 y9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPIDrL0YtBemfk+KWo/kx9VeqYnkyCM+MKnSeNjxO4OjkGvMJVhxbYQbOblxoq2pWbzDBd+/WE0SzDM1JPNlfhGKNy
X-Gm-Message-State: AOJu0Yw2cBtnevtR7WVP1K+3T0d7c8C4ewdDrUpZ1W5V5XT7LWU/SUS9
 Vya71F4MtmjF0cbBb6suPq4PQJXx23srTQEoQPhcsJgWxEPXv4cxoMP1xA==
X-Google-Smtp-Source: AGHT+IGUqR3EmCzbCZ20rTeoiJU1CmnaRJtE5epNuDlqpvq5JNVuGxIPtgjpvw369zbkY0PHChMdfw==
X-Received: by 2002:a05:6a20:5602:b0:1af:957a:75fb with SMTP id
 adf61e73a8af0-1afde1b7e87mr24361536637.41.1716111752358; 
 Sun, 19 May 2024 02:42:32 -0700 (PDT)
Received: from localhost.localdomain ([49.47.193.102])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a265sm19977932a91.10.2024.05.19.02.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 02:42:32 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v3 1/3] hw/nvram: Add BCM2835 OTP device
Date: Sun, 19 May 2024 15:11:04 +0530
Message-Id: <20240519094106.2142896-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x62b.google.com
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

The OTP device registers are currently stubbed. For now, the device
houses the OTP rows which will be accessed directly by other peripherals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/nvram/bcm2835_otp.c         | 187 +++++++++++++++++++++++++++++++++
 hw/nvram/meson.build           |   1 +
 include/hw/nvram/bcm2835_otp.h |  68 ++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 hw/nvram/bcm2835_otp.c
 create mode 100644 include/hw/nvram/bcm2835_otp.h

diff --git a/hw/nvram/bcm2835_otp.c b/hw/nvram/bcm2835_otp.c
new file mode 100644
index 0000000000..c4aed28472
--- /dev/null
+++ b/hw/nvram/bcm2835_otp.c
@@ -0,0 +1,187 @@
+/*
+ * BCM2835 One-Time Programmable (OTP) Memory
+ *
+ * The OTP implementation is mostly a stub except for the OTP rows
+ * which are accessed directly by other peripherals such as the mailbox.
+ *
+ * The OTP registers are unimplemented due to lack of documentation.
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/nvram/bcm2835_otp.h"
+#include "migration/vmstate.h"
+
+/* OTP rows are 1-indexed */
+uint32_t bcm2835_otp_get_row(BCM2835OTPState *s, unsigned int row)
+{
+    assert(row <= BCM2835_OTP_ROW_COUNT && row >= 1);
+
+    return s->otp_rows[row - 1];
+}
+
+void bcm2835_otp_set_row(BCM2835OTPState *s, unsigned int row,
+                           uint32_t value)
+{
+    assert(row <= BCM2835_OTP_ROW_COUNT && row >= 1);
+
+    /* Real OTP rows work as e-fuses */
+    s->otp_rows[row - 1] |= value;
+}
+
+static uint64_t bcm2835_otp_read(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (addr) {
+    case BCM2835_OTP_BOOTMODE_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BOOTMODE_REG\n");
+        break;
+    case BCM2835_OTP_CONFIG_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CONFIG_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_LO_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_LO_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_HI_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_HI_REG\n");
+        break;
+    case BCM2835_OTP_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_STATUS_REG\n");
+        break;
+    case BCM2835_OTP_BITSEL_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BITSEL_REG\n");
+        break;
+    case BCM2835_OTP_DATA_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_DATA_REG\n");
+        break;
+    case BCM2835_OTP_ADDR_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_ADDR_REG\n");
+        break;
+    case BCM2835_OTP_WRITE_DATA_READ_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_WRITE_DATA_READ_REG\n");
+        break;
+    case BCM2835_OTP_INIT_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_INIT_STATUS_REG\n");
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+
+    return 0;
+}
+
+static void bcm2835_otp_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned int size)
+{
+    switch (addr) {
+    case BCM2835_OTP_BOOTMODE_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BOOTMODE_REG\n");
+        break;
+    case BCM2835_OTP_CONFIG_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CONFIG_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_LO_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_LO_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_HI_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_HI_REG\n");
+        break;
+    case BCM2835_OTP_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_STATUS_REG\n");
+        break;
+    case BCM2835_OTP_BITSEL_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BITSEL_REG\n");
+        break;
+    case BCM2835_OTP_DATA_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_DATA_REG\n");
+        break;
+    case BCM2835_OTP_ADDR_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_ADDR_REG\n");
+        break;
+    case BCM2835_OTP_WRITE_DATA_READ_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_WRITE_DATA_READ_REG\n");
+        break;
+    case BCM2835_OTP_INIT_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_INIT_STATUS_REG\n");
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps bcm2835_otp_ops = {
+    .read = bcm2835_otp_read,
+    .write = bcm2835_otp_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_otp_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835OTPState *s = BCM2835_OTP(dev);
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_otp_ops, s,
+                          TYPE_BCM2835_OTP, 0x80);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
+    memset(s->otp_rows, 0x00, sizeof(s->otp_rows));
+}
+
+static const VMStateDescription vmstate_bcm2835_otp = {
+    .name = TYPE_BCM2835_OTP,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(otp_rows, BCM2835OTPState, BCM2835_OTP_ROW_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_otp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_otp_realize;
+    dc->vmsd = &vmstate_bcm2835_otp;
+}
+
+static const TypeInfo bcm2835_otp_info = {
+    .name = TYPE_BCM2835_OTP,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835OTPState),
+    .class_init = bcm2835_otp_class_init,
+};
+
+static void bcm2835_otp_register_types(void)
+{
+    type_register_static(&bcm2835_otp_info);
+}
+
+type_init(bcm2835_otp_register_types)
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 4996c72456..10f3639db6 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(files('fw_cfg-interface.c'))
 system_ss.add(files('fw_cfg.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_otp.c'))
 system_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 system_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
 system_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
diff --git a/include/hw/nvram/bcm2835_otp.h b/include/hw/nvram/bcm2835_otp.h
new file mode 100644
index 0000000000..1df33700bd
--- /dev/null
+++ b/include/hw/nvram/bcm2835_otp.h
@@ -0,0 +1,68 @@
+/*
+ * BCM2835 One-Time Programmable (OTP) Memory
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef BCM2835_OTP_H
+#define BCM2835_OTP_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2835_OTP "bcm2835-otp"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835OTPState, BCM2835_OTP)
+
+#define BCM2835_OTP_ROW_COUNT                              66
+
+/* https://elinux.org/BCM2835_registers#OTP */
+#define BCM2835_OTP_BOOTMODE_REG                         0x00
+#define BCM2835_OTP_CONFIG_REG                           0x04
+#define BCM2835_OTP_CTRL_LO_REG                          0x08
+#define BCM2835_OTP_CTRL_HI_REG                          0x0c
+#define BCM2835_OTP_STATUS_REG                           0x10
+#define BCM2835_OTP_BITSEL_REG                           0x14
+#define BCM2835_OTP_DATA_REG                             0x18
+#define BCM2835_OTP_ADDR_REG                             0x1c
+#define BCM2835_OTP_WRITE_DATA_READ_REG                  0x20
+#define BCM2835_OTP_INIT_STATUS_REG                      0x24
+
+
+/* -- Row 32: Undocumented -- */
+
+#define BCM2835_OTP_ROW_32                                 32
+
+/* Lock OTP Programming (Customer OTP and private key) */
+#define BCM2835_OTP_ROW_32_LOCK                        BIT(6)
+
+/* -- Row 36-43: Customer OTP -- */
+
+#define BCM2835_OTP_CUSTOMER_OTP                           36
+#define BCM2835_OTP_CUSTOMER_OTP_LEN                        8
+
+/* Magic numbers to lock programming of customer OTP and private key */
+#define BCM2835_OTP_LOCK_NUM1                      0xffffffff
+#define BCM2835_OTP_LOCK_NUM2                      0xaffe0000
+
+/* -- Row 56-63: Device-specific private key -- */
+
+#define BCM2835_OTP_PRIVATE_KEY                            56
+#define BCM2835_OTP_PRIVATE_KEY_LEN                         8
+
+
+struct BCM2835OTPState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    uint32_t otp_rows[BCM2835_OTP_ROW_COUNT];
+};
+
+
+uint32_t bcm2835_otp_get_row(BCM2835OTPState *s, unsigned int row);
+void bcm2835_otp_set_row(BCM2835OTPState *s, unsigned int row, uint32_t value);
+
+#endif
-- 
2.34.1


