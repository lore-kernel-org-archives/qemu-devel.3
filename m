Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE13C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc9kt-000491-52; Mon, 19 Feb 2024 14:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9kp-00048n-Qh; Mon, 19 Feb 2024 14:56:43 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9kn-0000QN-5y; Mon, 19 Feb 2024 14:56:43 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512b42b6697so1488625e87.1; 
 Mon, 19 Feb 2024 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708372598; x=1708977398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX3YFmXjbya4Do85k/7ErcX1cSvU3/lzU3eEMhm1uBw=;
 b=ZsN+oJJCsl6qI1PvStLOg4k5hyTw6rZZXJHL4yhU2KrE0TVJhVuuWf8GTtA+YKn6YT
 Qs2YbPgwUZJHVYXKk+6atXae5e7R6ev0wP8cNUEgHze55AiC6EqKp1WxIc7wuw9My+lf
 pHEUufrmDW4q7Z7ozlqJY+U6wIoQf87KOl/5hpwq53ZsJfySs+RqmvVTF3AqwtONNntM
 uxM/jkuulhxTqtRqlGHiVfNV1EGHiDBPAlfi9htkR1q2IUFxZUcVT1UrRyfrjPMxbgGf
 NdUx3areEhyFcExZBgP4bZiSBBlQyRwkCbw+GR4huMsMABiKNkYg35le5wu6wtREHVrX
 Qz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708372598; x=1708977398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX3YFmXjbya4Do85k/7ErcX1cSvU3/lzU3eEMhm1uBw=;
 b=Ypqc6p/KAOUCe7irpsz67KeJlGgi3cLm2lqGp5ARHZy9v52bH7TcO9yII+bmp9W+ys
 VN0PVGqzRsE0xNzTy+i/lWLh1ZBIp6McP66O0RZorq0tkKCjjHPGym+ArYNIG9IHnees
 7ZN338YFZRWIJ8lcezADAqjtwiZqaQXNmr7xbbPcDPzS9W6HQVph+toqVflazTDW6Pe+
 Q6vOOTgDpjjjysFSFgroBjqCHfWhQRd8osaRXgOy9Ef6+Is30r5EW6uZZs0ODB51F8LI
 zKK2FXox6vKDjo54q5at3LpRHguLW/gtxbVJu/bwAC8ZG0kjI6Bd/2n/NCg5aQ00sx4h
 AAgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJuaMlQNnePcT2ALjD7gqmYDsEmNdJXhaPqey3GWnbfWQ1Kio+HNM+oXPb6hOA/SShdfsMdEFEgm2lxq/bxi/MWQeJ
X-Gm-Message-State: AOJu0Yyer60L5d1iJZrBHqQ1xTdcWfCu8CSoP8YNUD1Bds1Y8g1mPV91
 WqH3gEqcFzct+vEE1IyLoC4Q681994Pi6HwYCFt3A9Da1g+Iv75IO76sHrTekLE=
X-Google-Smtp-Source: AGHT+IFM7FcaC5Inqj3His4xJq3uL/HnnZ8vQnAaO1YMEuXxhGoXufQGjE/fcAN5UaqPvLKybGGjcA==
X-Received: by 2002:a05:6512:6e:b0:512:ac35:381a with SMTP id
 i14-20020a056512006e00b00512ac35381amr3103197lfo.44.1708372598140; 
 Mon, 19 Feb 2024 11:56:38 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a170906a09300b00a3daa068f76sm3255911ejy.65.2024.02.19.11.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 11:56:37 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 1/3] hw/i2c: Implement Broadcom Serial Controller (BSC)
Date: Mon, 19 Feb 2024 22:51:31 +0300
Message-Id: <20240219195133.2304668-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219195133.2304668-1-rayhan.faizel@gmail.com>
References: <20240219195133.2304668-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-lf1-x12c.google.com
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

A few deficiencies in the current device model need to be noted.

1. FIFOs are not used. All sends and receives are done directly.
2. Repeated starts are not emulated. Repeated starts can be triggered in real
hardware by sending a new read transfer request in the window time between
transfer active set of write transfer request and done bit set of the same.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 docs/system/arm/raspi.rst    |   1 +
 hw/i2c/Kconfig               |   4 +
 hw/i2c/bcm2835_i2c.c         | 277 +++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build           |   1 +
 include/hw/i2c/bcm2835_i2c.h |  80 ++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 include/hw/i2c/bcm2835_i2c.h

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index d0a6f08b2b..f2c0d6d6b8 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -34,6 +34,7 @@ Implemented devices
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
+ * Broadcom Serial Controller (I2C)
 
 
 Missing devices
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 14886b35da..596a7a3165 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -45,3 +45,7 @@ config PCA954X
 config PMBUS
     bool
     select SMBUS
+
+config BCM2835_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
new file mode 100644
index 0000000000..4cb8a431a2
--- /dev/null
+++ b/hw/i2c/bcm2835_i2c.c
@@ -0,0 +1,277 @@
+/*
+ * Broadcom Serial Controller (BSC)
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/i2c/bcm2835_i2c.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+
+static void bcm2835_i2c_update_interrupt(BCM2835I2CState *s)
+{
+    int do_interrupt = 0;
+    /* Interrupt on RXR (Needs reading) */
+    if (s->c & BCM2835_I2C_C_INTR && s->s & BCM2835_I2C_S_RXR) {
+        do_interrupt = 1;
+    }
+
+    /* Interrupt on TXW (Needs writing) */
+    if (s->c & BCM2835_I2C_C_INTT && s->s & BCM2835_I2C_S_TXW) {
+        do_interrupt = 1;
+    }
+
+    /* Interrupt on DONE (Transfer complete) */
+    if (s->c & BCM2835_I2C_C_INTD && s->s & BCM2835_I2C_S_DONE) {
+        do_interrupt = 1;
+    }
+    qemu_set_irq(s->irq, do_interrupt);
+}
+
+static void bcm2835_i2c_begin_transfer(BCM2835I2CState *s)
+{
+    int direction = s->c & BCM2835_I2C_C_READ;
+    if (i2c_start_transfer(s->bus, s->a, direction)) {
+        s->s |= BCM2835_I2C_S_ERR;
+    }
+    s->s |= BCM2835_I2C_S_TA;
+
+    if (direction) {
+        s->s |= BCM2835_I2C_S_RXR | BCM2835_I2C_S_RXD;
+    } else {
+        s->s |= BCM2835_I2C_S_TXW;
+    }
+}
+static void bcm2835_i2c_finish_transfer(BCM2835I2CState *s)
+{
+    /*
+     * STOP is sent when DLEN counts down to zero.
+     *
+     * https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-bcm2835.c#L223-L261
+     * It is possible to initiate repeated starts on real hardware.
+     * However, this requires sending another ST request before the bytes in
+     * TX FIFO are shifted out.
+     *
+     * This is not emulated currently.
+     */
+    i2c_end_transfer(s->bus);
+    s->s |= BCM2835_I2C_S_DONE;
+
+    /* Ensure RXD is cleared, otherwise the driver registers an error */
+    s->s &= ~(BCM2835_I2C_S_TA | BCM2835_I2C_S_RXR |
+              BCM2835_I2C_S_TXW | BCM2835_I2C_S_RXD);
+}
+
+static uint64_t bcm2835_i2c_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BCM2835I2CState *s = opaque;
+    uint32_t readval = 0;
+
+    switch (addr) {
+    case BCM2835_I2C_C:
+        readval = s->c;
+        break;
+    case BCM2835_I2C_S:
+        readval = s->s;
+        break;
+    case BCM2835_I2C_DLEN:
+        readval = s->dlen;
+        break;
+    case BCM2835_I2C_A:
+        readval = s->a;
+        break;
+    case BCM2835_I2C_FIFO:
+        /* We receive I2C messages directly instead of using FIFOs */
+        if (s->s & BCM2835_I2C_S_TA) {
+            readval = i2c_recv(s->bus);
+            s->dlen -= 1;
+
+            if (s->dlen == 0) {
+                bcm2835_i2c_finish_transfer(s);
+            }
+        }
+        bcm2835_i2c_update_interrupt(s);
+        break;
+    case BCM2835_I2C_DIV:
+        readval = s->div;
+        break;
+    case BCM2835_I2C_DEL:
+        readval = s->del;
+        break;
+    case BCM2835_I2C_CLKT:
+        readval = s->clkt;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+
+    return readval;
+}
+
+static void bcm2835_i2c_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned int size)
+{
+    BCM2835I2CState *s = opaque;
+    uint32_t writeval = value;
+
+    switch (addr) {
+    case BCM2835_I2C_C:
+        /* ST is a one-shot operation; it must read back as 0 */
+        s->c = writeval & ~BCM2835_I2C_C_ST;
+
+        /* Start transfer */
+        if (writeval & (BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN)) {
+            bcm2835_i2c_begin_transfer(s);
+            /*
+             * Handle special case where transfer starts with zero data length.
+             * Required for zero length i2c quick messages to work.
+             */
+            if (s->dlen == 0) {
+                bcm2835_i2c_finish_transfer(s);
+            }
+        }
+
+        bcm2835_i2c_update_interrupt(s);
+        break;
+    case BCM2835_I2C_S:
+        s->s = (writeval & ~BCM2835_I2C_S_ROMASK) |
+               (s->s & BCM2835_I2C_S_ROMASK);
+
+        if (writeval & BCM2835_I2C_S_DONE && s->s & BCM2835_I2C_S_DONE) {
+            /* When DONE is cleared, DLEN should read last written value. */
+            s->dlen = s->last_dlen;
+        }
+
+        /* Clear DONE, CLKT and ERR by writing 1 */
+        s->s &= ~(writeval & (BCM2835_I2C_S_DONE |
+                  BCM2835_I2C_S_ERR | BCM2835_I2C_S_CLKT));
+        break;
+    case BCM2835_I2C_DLEN:
+        s->dlen = writeval;
+        s->last_dlen = writeval;
+        break;
+    case BCM2835_I2C_A:
+        s->a = writeval;
+        break;
+    case BCM2835_I2C_FIFO:
+        /* We send I2C messages directly instead of using FIFOs */
+        if (s->s & BCM2835_I2C_S_TA) {
+            if (s->s & BCM2835_I2C_S_TXD) {
+                if (!i2c_send(s->bus, value & 0xff)) {
+                    s->dlen -= 1;
+                } else {
+                    s->s |= BCM2835_I2C_S_ERR;
+                }
+            }
+
+            if (s->dlen == 0) {
+                bcm2835_i2c_finish_transfer(s);
+            }
+        }
+        bcm2835_i2c_update_interrupt(s);
+        break;
+    case BCM2835_I2C_DIV:
+        s->div = writeval;
+        break;
+    case BCM2835_I2C_DEL:
+        s->del = writeval;
+        break;
+    case BCM2835_I2C_CLKT:
+        s->clkt = writeval;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+static const MemoryRegionOps bcm2835_i2c_ops = {
+    .read = bcm2835_i2c_read,
+    .write = bcm2835_i2c_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2835_i2c_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835I2CState *s = BCM2835_I2C(dev);
+    s->bus = i2c_init_bus(dev, NULL);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
+                          TYPE_BCM2835_I2C, 0x24);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void bcm2835_i2c_reset(DeviceState *dev)
+{
+    BCM2835I2CState *s = BCM2835_I2C(dev);
+
+    /* Reset values according to BCM2835 Peripheral Documentation */
+    s->c = 0x0;
+    s->s = BCM2835_I2C_S_TXD | BCM2835_I2C_S_TXE;
+    s->dlen = 0x0;
+    s->a = 0x0;
+    s->div = 0x5dc;
+    s->del = 0x00300030;
+    s->clkt = 0x40;
+}
+
+static const VMStateDescription vmstate_bcm2835_i2c = {
+    .name = TYPE_BCM2835_I2C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(c, BCM2835I2CState),
+        VMSTATE_UINT32(s, BCM2835I2CState),
+        VMSTATE_UINT32(dlen, BCM2835I2CState),
+        VMSTATE_UINT32(a, BCM2835I2CState),
+        VMSTATE_UINT32(div, BCM2835I2CState),
+        VMSTATE_UINT32(del, BCM2835I2CState),
+        VMSTATE_UINT32(clkt, BCM2835I2CState),
+        VMSTATE_UINT32(last_dlen, BCM2835I2CState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = bcm2835_i2c_reset;
+    dc->realize = bcm2835_i2c_realize;
+    dc->vmsd = &vmstate_bcm2835_i2c;
+}
+
+static const TypeInfo bcm2835_i2c_info = {
+    .name = TYPE_BCM2835_I2C,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835I2CState),
+    .class_init = bcm2835_i2c_class_init,
+};
+
+static void bcm2835_i2c_register_types(void)
+{
+    type_register_static(&bcm2835_i2c_info);
+}
+
+type_init(bcm2835_i2c_register_types)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index b58bc167db..c459adcb59 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -17,4 +17,5 @@ i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
+i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
new file mode 100644
index 0000000000..7c91024b0a
--- /dev/null
+++ b/include/hw/i2c/bcm2835_i2c.h
@@ -0,0 +1,80 @@
+/*
+ * Broadcom Serial Controller (BSC)
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "hw/sysbus.h"
+#include "hw/i2c/i2c.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2835_I2C "bcm2835-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835I2CState, BCM2835_I2C)
+
+#define BCM2835_I2C_C       0x0                   /* Control */
+#define BCM2835_I2C_S       0x4                   /* Status */
+#define BCM2835_I2C_DLEN    0x8                   /* Data Length */
+#define BCM2835_I2C_A       0xc                   /* Slave Address */
+#define BCM2835_I2C_FIFO    0x10                  /* FIFO */
+#define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
+#define BCM2835_I2C_DEL     0x18                  /* Data Delay */
+#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeout */
+
+#define BCM2835_I2C_C_I2CEN     BIT(15)           /* I2C enable */
+#define BCM2835_I2C_C_INTR      BIT(10)           /* Interrupt on RXR */
+#define BCM2835_I2C_C_INTT      BIT(9)            /* Interrupt on TXW */
+#define BCM2835_I2C_C_INTD      BIT(8)            /* Interrupt on DONE */
+#define BCM2835_I2C_C_ST        BIT(7)            /* Start transfer */
+#define BCM2835_I2C_C_CLEAR     (BIT(5) | BIT(4)) /* Clear FIFO */
+#define BCM2835_I2C_C_READ      BIT(0)            /* I2C read mode */
+
+#define BCM2835_I2C_S_ROMASK    0xfd
+
+#define BCM2835_I2C_S_CLKT      BIT(9)            /* Clock stretch timeout */
+#define BCM2835_I2C_S_ERR       BIT(8)            /* Slave error */
+#define BCM2835_I2C_S_RXF       BIT(7)            /* RX FIFO full */
+#define BCM2835_I2C_S_TXE       BIT(6)            /* TX FIFO empty */
+#define BCM2835_I2C_S_RXD       BIT(5)            /* RX bytes available */
+#define BCM2835_I2C_S_TXD       BIT(4)            /* TX space available */
+#define BCM2835_I2C_S_RXR       BIT(3)            /* RX FIFO needs reading */
+#define BCM2835_I2C_S_TXW       BIT(2)            /* TX FIFO needs writing */
+#define BCM2835_I2C_S_DONE      BIT(1)            /* I2C Transfer complete */
+#define BCM2835_I2C_S_TA        BIT(0)            /* I2C Transfer active */
+
+struct BCM2835I2CState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    I2CBus *bus;
+    qemu_irq irq;
+
+    uint32_t c;
+    uint32_t s;
+    uint32_t dlen;
+    uint32_t a;
+    uint32_t div;
+    uint32_t del;
+    uint32_t clkt;
+
+    uint32_t last_dlen;
+};
-- 
2.34.1


