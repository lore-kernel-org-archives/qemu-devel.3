Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7CFCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqf-0005Sf-Gv; Tue, 13 Oct 2026 23:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqd-0005KE-4Z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:11 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqb-0001bq-4y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:10 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso817838a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949208; x=1792554008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0xDXzW8T0fEPSFyBJJQQXuC0/LnAHdiE4OZZ65/ljw=;
 b=VcEjOTnoXDca3fBOD7z6MPfay1k7oyWLnoaOfXEeFV+nLCg2BSSGkgUf8GxussbPPN
 scPBXiO3COEOf8tAE3whk2t0d4qpwqoreIpzIhGdkVO+cZHPLjyPRfh8GT5/sju7s0mx
 EEPs3U1hYxB2B3dZEdx1xiuBKbj5qU6XwemwYbKLsBuDyLHdFVlGNdOIeo2mkm9L2TS1
 hYQMPijVoDOeAPCVcvYJRKpTqIF/Virf2tNtw/jEvlGfjfa+0bUwExLediE59m/ogN5S
 U0C7rb4XJ5hu0ThSuxHTRLYhZ3Zg6wOXz4FRecF933GSiHbIrjP0Fa8QPvDW5MtaZPHm
 Y/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949208; x=1792554008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0xDXzW8T0fEPSFyBJJQQXuC0/LnAHdiE4OZZ65/ljw=;
 b=KCfxUTxvXOMjL2G2oZlp4tRIVzu45a1CadjjqmXJYOjN32ddUqwOLlvmztUyE4EcoI
 c32DS8LEUo4zw1DliwHyTAcjtCCkl7hsnVOratHoFCJBeN1ojebZ1T8AiajaPYWOYjFl
 VgPs6LRKqNA5a0mZ4LbsrXqUK8tjeoQzGmvPEgCZ7myBHdYYCWjYNl0sIV4hQHqnUUpC
 bxGmg8/pUbR6IYWuXpD2GgZInmC6ynS2IaIZrhDnOC0V/sjbsRHTUhH8Jf5M+zOLSZ5C
 xgDrvkOGJQMLLpu/jm2wqMBzZBsMFtS4I/mXXq26CUCusQt/LuuEA/yyWGA0yxTbEoHQ
 idnw==
X-Gm-Message-State: AFq9FYI9uQajY8FqRpLvUgKrP48tmcY2Y2cirPBYCNV3p6hi3jIVhdn9
 p5SSsgekvqtr7FAq5FcTAeYCdZ0s8EX5+ECRj4bXf/UUIvKwV7jKhGN+70CT5g==
X-Gm-Gg: AYBFou27HliGftK/rT7ZYBGSvLZKy8XZvzJ48KuEdYSxIWgzbE6JE+LUYescM7eCDx0
 UCbnmmNKngUVy5M2u4avHQATWBddmv9Hg6DMXAhIBtvVXwTw08cqBl465+L9+smsPmIOPBMxwxh
 rLA1FLA+5dBVW/GsIsKD9pquT69Ifa5sJcidJp37c+hbE4dc7nO9YiPyIyz123d80Og8V0tpmw5
 sEud/crW0RZG1fCIkJpQZuPqp1vaucoWT/RJvrATrHxPvxWXA/JuMu7ki13guRn8L6zczCg74AD
 +LbRDtQAuaTS3g61OKUqACw1tAF33a8u5tTg+bX7UXh6QxOGTjBL7uq68U8mSesfVH9sB03gmUc
 v/A0H7SwsYVAk7N9AGBV6Ih+MVIMdJ9KqHlYZyveizEhuxvL/sa8hhL5S8pYUp02WbfgkpLK+X/
 2lHAautL3VaAd0RqscpB23rNT7o6D7KfPIVdpZk/LMqwQ271aDHzbc315b9Sap9HUnLCw+unwQV
 adEOuMXyKUgFpv7
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3abbe66e034mr7483344a91.20.1791949207782; 
 Tue, 13 Oct 2026 20:40:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PULL 14/52] hw/char: Add dw8250 UART
Date: Wed, 14 Oct 2026 13:38:29 +1000
Message-ID: <20261014033907.3332383-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add the dw8250 uart support. This hardware is a widely used 16550A
derivative that includes additional registers.

Without this specific device support, the Linux 8250_dw driver fails to
probe the extended registers (UCV, CPR, etc.), which are essential for
correct feature detection.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-2-visitorckw@gmail.com>
[ Changes by Portia Stephens <portias@oss.tenstorrent.com>:
 - hw/char/dw8250: Fix leak when creating child device
]
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS              |   6 ++
 include/hw/char/dw8250.h |  28 +++++++++
 hw/char/dw8250.c         | 130 +++++++++++++++++++++++++++++++++++++++
 hw/char/Kconfig          |   4 ++
 hw/char/meson.build      |   1 +
 5 files changed, 169 insertions(+)
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 hw/char/dw8250.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..913162130f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2852,6 +2852,12 @@ S: Maintained
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
diff --git a/include/hw/char/dw8250.h b/include/hw/char/dw8250.h
new file mode 100644
index 0000000000..ce0b97715b
--- /dev/null
+++ b/include/hw/char/dw8250.h
@@ -0,0 +1,28 @@
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
+#include "hw/char/serial-mm.h"
+
+#define TYPE_DW8250 "dw8250"
+OBJECT_DECLARE_SIMPLE_TYPE(DW8250State, DW8250)
+
+struct DW8250State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion container;
+    MemoryRegion ext_iomem;
+    SerialMM serial_mm;
+
+    uint8_t regshift;
+};
+
+#endif
diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
new file mode 100644
index 0000000000..50baeae62c
--- /dev/null
+++ b/hw/char/dw8250.c
@@ -0,0 +1,130 @@
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
+    object_initialize_child(obj, "serial-mm", &s->serial_mm, TYPE_SERIAL_MM);
+    object_property_add_alias(obj, "chardev", OBJECT(&s->serial_mm), "chardev");
+}
+
+static void dw8250_realize(DeviceState *dev, Error **errp)
+{
+    DW8250State *s = DW8250(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(&s->serial_mm);
+
+    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
+                       DW_UART_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    qdev_prop_set_uint8(DEVICE(&s->serial_mm), "regshift", s->regshift);
+    qdev_prop_set_uint8(DEVICE(&s->serial_mm), "endianness", DEVICE_LITTLE_ENDIAN);
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
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..7040040641 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,7 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config DW8250
+    bool
+    select SERIAL_MM
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
-- 
2.55.0


