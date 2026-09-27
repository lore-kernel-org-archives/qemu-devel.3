Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F62C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvFx-0008Iz-JN; Sun, 27 Sep 2026 16:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvFv-0008Hu-2X
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:51 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvFt-0003Xl-4N
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:50 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78e1a94b8so1267749a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540027; x=1791144827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bf3vR6iy7Q7v1q8bV5ZxQj6Bf/iMYhH2zfM2TdxLg7Y=;
 b=JHYg8mvf9lmlxMzdTibvA9xKn6Wb6zx2lgDdl9ml+ISvO+/efStlrrPG0CHeDramnf
 sdF5P/21ZWiGutZqo+1D9dtFFaVOC3VLT0FfHiK8DN+fykoMDmnUhzuxWgItDmM1vqzV
 ZUMJFOegUMCKqklgGS+/gGw0TpbSmpjKpN35Roh3mD/5woGlVmJm+D36if/3t2Piipjo
 tfeR4pZYSqu+1BW8JZuuQwT0ynZFaAZHoDDMnKioub0cp8Tl1safKQmTsFmNO3Qpp/lt
 UCe6/eZsvP3x4PJqpNQW1DbgKJRR6YTGr8xyXDtn94oRAWnAGfdKdBs2WsymKt6comot
 lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540027; x=1791144827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bf3vR6iy7Q7v1q8bV5ZxQj6Bf/iMYhH2zfM2TdxLg7Y=;
 b=FR1r08mknR2Cd4D3pOEh/OByRiKoaGKsqEM9/JmzAgLZt5GbkPUvkHsTABRfpZj/Ho
 PeLPARyZJDBnht4Vmmens0x2xvLrGcuXRJLCSPss2PxS4TiarQT/TBnRO6PdHQuITuZa
 +JBtHqww9a3XdLW24wWvFC9mtdt6dJGCol3ksYVCwuX5Zr4ba0XfviBHecKUVOuZoU2c
 UkAB4DEjT+DlFRqfLfjF69Uv+ELz4Kj8lmXUQE2Ynf+GWi3ZXUuH8IBzKG647s/Z5uZ2
 7/n3RpV9rnIQiGvXauwuBu+PNyTKVLOAmW2oaG8dPlm2igdyBTbW/49ppoeeSml2PWh8
 uL2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4PhRSOFjhGWJEtr44KYH2HaaJ+CBqpXqZEz7AnZc3HIQ8BrbNgSlSqg0iM6vop10COYJ0aj24OG4y@nongnu.org
X-Gm-Message-State: AFq9FYIy9HnwQ+XSkXL3gTNkwDUV2PfhY/d9Aa5b+PrWPPNafvOZu5Yl
 3ZTsWK9nwktFim0HLwCRqPWPOQ52ZYaaV/8SEAmj613dgGiP0JbhKuwd
X-Gm-Gg: AYBFou3iNSUBU19jTYEQgouVfzuGiofBuYegI9G6iixjeecRXH9MXIzo/HMoE48i4Qe
 bWXeb4cwckXq1mriyXy9cnISRm7vwpMfxzaXq867EkIedIwiWAkeREuOfyuPtFjVgURf7fEPlj6
 8Qi+Jq04rRpWwGZKCKfI7u3AP7iNEiE2l1oOeB7kKWjE7YqWjY8CIfPvtZFlauGS1seC44lU7W0
 N5bDN8ZOOUf9dUgOPcquIPEVCCvMPagQJ5oyrm6Ecj5Nzi/Y7Hy4jGW6nFNnLC+gdk0BpmKoDzp
 wFu0YwHb1F01Z9VpzAcZINIr+rWkmQQ1lfEObVysvAU7WK3LulvbXD9c7M9gGbq/5B0IWEwmJA5
 1TrcLwr/eb3EUOzYN58I3xbPZPmO2/Fd8AMRzGG0WhjHzUS2vpHg6K+ifKPQnmXNt5VQAfOig6s
 pfCGL5kZXIxE9ww8vdKCLRNNSQNzFDZDQbgVoUCOjdWmftbtGc8Pycfi0V2Uw9xe21KHVzjBBlj
 ri2bfDa6YftvP7LQ1l+RZc4rk0ZPytj6Jt2oHG2ppd5aL6YtpgkpaRmqZf6oSUcarNrwRXTqA==
X-Received: by 2002:a17:90b:4d0f:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-3a098b49032mr9577065a91.16.1790540027496; 
 Sun, 27 Sep 2026 13:13:47 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:13:47 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v5 1/7] hw/char: Add dw8250 UART
Date: Sun, 27 Sep 2026 20:13:20 +0000
Message-ID: <20260927201326.650943-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260927201326.650943-1-visitorckw@gmail.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=visitorckw@gmail.com; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the dw8250 uart support. This hardware is a widely used 16550A
derivative that includes additional registers.

Without this specific device support, the Linux 8250_dw driver fails to
probe the extended registers (UCV, CPR, etc.), which are essential for
correct feature detection.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS              |   6 ++
 hw/char/Kconfig          |   4 ++
 hw/char/dw8250.c         | 131 +++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build      |   1 +
 include/hw/char/dw8250.h |  27 ++++++++
 5 files changed, 169 insertions(+)
 create mode 100644 hw/char/dw8250.c
 create mode 100644 include/hw/char/dw8250.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b..d4e9cf61ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2848,6 +2848,12 @@ S: Maintained
 F: hw/i2c/designware_i2c.c
 F: include/hw/i2c/designware_i2c.h
 
+DesignWare 8250 UART
+M: Kuan-Wei Chiu <visitorckw@gmail.com>
+S: Maintained
+F: hw/char/dw8250.c
+F: include/hw/char/dw8250.h
+
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..418d99b757 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,7 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config DW8250
+    bool
+    select SERIAL
diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
new file mode 100644
index 0000000000..ccf05dd9ad
--- /dev/null
+++ b/hw/char/dw8250.c
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Synopsys DesignWare APB UART (DW 8250)
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/char/dw8250.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+
+#define DW_UART_REGION_SIZE 0x100
+
+#define DW_UART_RE_EN (0xB4 >> 2) /* Receiver Output Enable Register */
+#define DW_UART_DLF   (0xC0 >> 2) /* Divisor Latch Fraction Register */
+#define DW_UART_CPR   (0xF4 >> 2) /* Component Parameter Register */
+#define DW_UART_UCV   (0xF8 >> 2) /* UART Component Version */
+#define DW_UART_CTR   (0xFC >> 2) /* Component Type Register */
+
+#define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */
+#define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
+
+static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    DW8250State *s = opaque;
+
+    switch (addr >> s->regshift) {
+    case DW_UART_UCV:
+        return DW_UART_UCV_VALUE;
+    case DW_UART_CPR:
+        return 0x00000000; /* No advanced features (DMA, extra FIFOs) */
+    case DW_UART_CTR:
+        return DW_UART_CTR_VALUE;
+
+    case DW_UART_RE_EN:
+    case DW_UART_DLF:
+        /*
+         * Return 0 to indicate these optional features
+         * (RS485 and Fractional Divisor) are not implemented.
+         */
+        return 0x00000000;
+
+    default:
+        return 0;
+    }
+}
+
+static void dw8250_ext_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented write to address 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
+}
+
+static const MemoryRegionOps dw8250_ext_ops = {
+    .read = dw8250_ext_read,
+    .write = dw8250_ext_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void dw8250_instance_init(Object *obj)
+{
+    DW8250State *s = DW8250(obj);
+
+    s->serial_mm = qdev_new("serial-mm");
+    object_property_add_child(obj, "serial-mm", OBJECT(s->serial_mm));
+    object_property_add_alias(obj, "chardev", OBJECT(s->serial_mm), "chardev");
+}
+
+static void dw8250_realize(DeviceState *dev, Error **errp)
+{
+    DW8250State *s = DW8250(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(s->serial_mm);
+
+    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
+                       DW_UART_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
+    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(serial_sbd, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->ext_iomem, OBJECT(dev), &dw8250_ext_ops, s,
+                          "dw8250-ext", DW_UART_REGION_SIZE);
+    memory_region_add_subregion(&s->container, 0, &s->ext_iomem);
+
+    memory_region_add_subregion_overlap(&s->container, 0,
+                                        sysbus_mmio_get_region(serial_sbd, 0), 1);
+
+    sysbus_pass_irq(sbd, serial_sbd);
+}
+
+static const Property dw8250_properties[] = {
+    DEFINE_PROP_UINT8("regshift", DW8250State, regshift, 2),
+};
+
+static void dw8250_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = dw8250_realize;
+    device_class_set_props(dc, dw8250_properties);
+}
+
+static const TypeInfo dw8250_info = {
+    .name          = TYPE_DW8250,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DW8250State),
+    .instance_init = dw8250_instance_init,
+    .class_init    = dw8250_class_init,
+};
+
+static void dw8250_register_types(void)
+{
+    type_register_static(&dw8250_info);
+}
+
+type_init(dw8250_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..b2250ee6ae 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
+system_ss.add(when: 'CONFIG_DW8250', if_true: files('dw8250.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/include/hw/char/dw8250.h b/include/hw/char/dw8250.h
new file mode 100644
index 0000000000..59396ad202
--- /dev/null
+++ b/include/hw/char/dw8250.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Synopsys DesignWare APB UART (DW 8250)
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef HW_CHAR_DW8250_H
+#define HW_CHAR_DW8250_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_DW8250 "dw8250"
+OBJECT_DECLARE_SIMPLE_TYPE(DW8250State, DW8250)
+
+struct DW8250State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion container;
+    MemoryRegion ext_iomem;
+    DeviceState *serial_mm;
+
+    uint8_t regshift;
+};
+
+#endif
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


