Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C5C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CH-0004tg-VN; Thu, 20 Aug 2026 08:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CF-0004pq-HI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CC-0001Y7-NE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so4290223a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230115; x=1787834915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x1njBPUnRi7s8nimb7wTjieF3b/NWRrQDo6tfHwHCQ8=;
 b=tMtfRmsNX7/ydsffvfcCXzhbQs8sJHHKpYVm8GZgAGzzGcatlrAGzYF3pp6/nssoJf
 jA3qj70SoJtTEkF3vWzbirxP/1OgjT7LH0CZRJr4NpHPkzu/u/pA1D6+wQVrUzlb80C+
 fxi563HyPO8wA7H/J1GbyeWSe46PGgnhwC1zK/zcio3pxXArKdM20wO9fqOzr2IDivUd
 36IPBrQEGMeUMoCyJ3wLTze5rAnrnQQR62CPzEduMHVoTURHzu1BIzok6ftr73XBBSwL
 jTqZwuPaaBiSVd8R9Zgbv/LaoFYF1gr2uKbHXoJOPboPFtNJEyGUv/UYISJRYnN+en4v
 Uzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230115; x=1787834915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x1njBPUnRi7s8nimb7wTjieF3b/NWRrQDo6tfHwHCQ8=;
 b=s7ApPijzkYY4nnacvMj29l9rCq8lbNIAMtnH7orTZDi2Nxs8t9hbUWufCsJbNPpH70
 e01cGNAf61wIGo6dyGxhfECzDHrDZBXtz8+xJUc50Qz0SdFwYpm/qySTP9npS4jw3eqI
 iCf06G7kUKINuy+AVnnHNSFAG7Qi9z+TYaXHSI2CHBT+3za0/eiTBTj8fJ0a8Kn2icoX
 zmlgpJMXh0mFItbTbcTmxuCQXU2l/oW45yIpytNkme5/Q6C9zTybX+eHbXFqJ6PZm4m3
 Wq2gHym1o8KWIIsGa4Ikc6m3L9vwTPj98V7iQBUD/m4oGa6kVBhmunc3+qS6dD9AF2cu
 t9Aw==
X-Gm-Message-State: AFuF++kWhGOu/VZBlbX62gQJaf82y/p0On6tWvQQksuAXsu6GgxqU/9M
 ks8l9BG/pz7oTU4QEGA1riO+hMdLihaG/aIzATPduZT9deYIYDjijfmSSzJDuT+G
X-Gm-Gg: AR+sD10C9EwoWaWqsiEzZtji8+TKJVInjTrMA+yJLCrPJQeRkCBzRqmIKVQqgFRA12I
 1HsLBHGOVb1toa2gNPBPnccqA7w86WhZkdCY8YFHVPj63JZoNkZ4wNXPazIn83MP317I4xSGYPD
 uqyE777tq5CpdAU3kjd7IJOf+H1adD/Nu01SNnY6mCzA0J9haumB7I1ZksxIr5hhw7YDGCLJLIL
 E4zssSPTAGHDIZJdLs82AFcLSggTMIZcYZKCyY+pNYyhN8Pcd7YxHv9k2VUTQbEcX2g07eu+Rmg
 L6sWC96gyV72/LgH8RR4i7+1rpDVcGXXX430O7I0Pv3asMUZrtVGDQqqvmhmJOLYLt/g+mku6YC
 atfIkholUwgSiBZM/1mTyUGch5kqx5ZzfIPf87NToOQlUsnxj/JMjIbFRqGRcrx599a/WC38bvG
 pIcSWsKY4OprHSqqq6wsr4uO7bpc5HZsKNKj6IE6f/ODXqQB8AQYip2Gi+2mi2HsIrFfUoz/rYp
 LZufYeP0R0=
X-Received: by 2002:a05:6402:3218:b0:6a3:efe6:3ef3 with SMTP id
 4fb4d7f45d1cf-6a4032e364cmr9248971a12.7.1787230114948; 
 Thu, 20 Aug 2026 05:48:34 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:34 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 04/14] hw/char: add TI AM64x UART model
Date: Thu, 20 Aug 2026 14:48:04 +0200
Message-ID: <20260820124824.618671-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x52a.google.com
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

The AM64x UART is an 8250-compatible core with a TI-specific mode-select
register (MDR1) that has to be taken out of "disabled" state before the
UART transmits, plus a power/emulation management register. Wrap the
generic 16550 model to provide these.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/char/Kconfig                |   4 ++
 hw/char/meson.build            |   1 +
 hw/char/ti-am64-uart.c         | 109 +++++++++++++++++++++++++++++++++
 include/hw/char/ti-am64-uart.h |  28 +++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 hw/char/ti-am64-uart.c
 create mode 100644 include/hw/char/ti-am64-uart.h

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..c06811130a 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -31,6 +31,10 @@ config SERIAL_MM
     bool
     select SERIAL
 
+config AM64_UART
+    bool
+    select SERIAL
+
 config SERIAL_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..71c35af357 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -22,6 +22,7 @@ system_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-console.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen_console.c'))
 system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_uartlite.c'))
 system_ss.add(when: 'CONFIG_DIVA_GSP', if_true: files('diva-gsp.c'))
+system_ss.add(when: 'CONFIG_AM64_UART', if_true: files('ti-am64-uart.c'))
 
 system_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
diff --git a/hw/char/ti-am64-uart.c b/hw/char/ti-am64-uart.c
new file mode 100644
index 0000000000..41d02060eb
--- /dev/null
+++ b/hw/char/ti-am64-uart.c
@@ -0,0 +1,109 @@
+/*
+ * TI AM64x UART emulation
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/ti-am64-uart.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+
+static uint64_t am64_uart_read(void *opaque, hwaddr addr, unsigned size)
+{
+    AM64Uart *au = AM64_UART(opaque);
+
+    if (addr >= (8 << au->regshift)) {
+        return 0;
+    }
+
+    return serial_io_ops.read(&au->serial, addr >> au->regshift, 1);
+}
+
+static void am64_uart_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    AM64Uart *au = AM64_UART(opaque);
+    value &= 255;
+    if (addr >= (8 << au->regshift)) {
+        return;
+    }
+
+    serial_io_ops.write(&au->serial, addr >> au->regshift, value, 1);
+}
+
+/*
+ * Registers are byte-wide and little-endian.  TI-specific registers outside
+ * the 16550 window are RAZ/WI; MDR1 == 0 means the 16x mode we implement.
+ */
+static const MemoryRegionOps am64_uart_ops = {
+    .read = am64_uart_read,
+    .write = am64_uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.max_access_size = 8,
+    .impl.max_access_size = 8,
+};
+
+static void am64_uart_realize(DeviceState *dev, Error **errp)
+{
+    AM64Uart *au = AM64_UART(dev);
+    SerialState *s = &au->serial;
+
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->io, OBJECT(dev),
+                          &am64_uart_ops, au, "serial",
+                          64 << au->regshift);
+    sysbus_init_mmio(SYS_BUS_DEVICE(au), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(au), &au->serial.irq);
+}
+
+static const VMStateDescription vmstate_am64_uart = {
+    .name = "ti-am64-uart",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(serial, AM64Uart, 0, vmstate_serial, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void am64_uart_instance_init(Object *o)
+{
+    AM64Uart *au = AM64_UART(o);
+
+    object_initialize_child(o, "serial", &au->serial, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&au->serial), o);
+}
+
+static const Property am64_uart_properties[] = {
+    /* AM64x has adjacent 16550 registers four bytes apart. */
+    DEFINE_PROP_UINT8("regshift", AM64Uart, regshift, 2),
+};
+
+static void am64_uart_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, am64_uart_properties);
+    dc->realize = am64_uart_realize;
+    dc->vmsd = &vmstate_am64_uart;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_AM64_UART,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .class_init = am64_uart_class_init,
+        .instance_init = am64_uart_instance_init,
+        .instance_size = sizeof(AM64Uart),
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/include/hw/char/ti-am64-uart.h b/include/hw/char/ti-am64-uart.h
new file mode 100644
index 0000000000..5cf820dc20
--- /dev/null
+++ b/include/hw/char/ti-am64-uart.h
@@ -0,0 +1,28 @@
+/*
+ * TI AM64x UART emulation
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SERIAL_TI_AM64_H
+#define HW_SERIAL_TI_AM64_H
+
+#include "hw/char/serial.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_AM64_UART "ti-am64-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(AM64Uart, AM64_UART)
+
+struct AM64Uart {
+    SysBusDevice parent;
+
+    SerialState serial;
+
+    uint8_t regshift;
+};
+
+#endif
-- 
2.43.0


