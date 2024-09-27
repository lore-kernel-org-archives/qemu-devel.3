Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C6CDD1BB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCab-0003Tf-QU; Fri, 27 Sep 2024 11:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaV-0003Ay-6V; Fri, 27 Sep 2024 11:08:55 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaS-0002IM-JV; Fri, 27 Sep 2024 11:08:54 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f753375394so21692451fa.0; 
 Fri, 27 Sep 2024 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727449729; x=1728054529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Me/0mTA0Xg322skkBxlBm8eH0ZeXz9qs8TYeOvsO/Fk=;
 b=T+FkbHbQyrgxgIDMDMkJGnK/FRqvXoZkPGIil87KVqjakzB4SVa3mwdy94kSTXT1gv
 +wO3Dmk3NyD1PuH/5IQvdG+A++fWSfO4V13R0kttiZALfZEER2HnatpnU3apieA+bEpK
 8F71lE07HEhfNk7JuFcBJW3kIyVJCJ5v6975A4b7IY34d6M6/CBs/mDhe1NR296an8NV
 8EopjPpfP/EtNCs1GlOTkrhYRG9LogJp0NGQukYSg/KZle835Ol0uFrQWAE8QgUkzVQ5
 GwyNxvhYvZQ0Fxa6qj+ubUOAQ+oECQrtGkOEjiUBfPtS3fzuI+9Ti/Ou3w7kYyHECVTI
 qeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727449729; x=1728054529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Me/0mTA0Xg322skkBxlBm8eH0ZeXz9qs8TYeOvsO/Fk=;
 b=Fq6vJvsfsu4QbJAN4dw3VQNV51bSgVbP41SbHyp2LUA3xW9xuHAq6TM7U740eTXBnR
 8iqUt3h8J1x8exkld1Onwbd3o0ZXpLK0OTmsDxlxq9eu/DEFDxbHuJKUDUx3jN0zVBpU
 Bzy77aEZa+FXoabrRKgpV8zGd5PNzIWzQ0n1rknI2J9X1vc05InSoQIIWHaybhGwVnfg
 xTCv2Hc2Xx9zOzpYWhLBRuLYtCs4QkejRx8Mo1O2q8rfliqIbYSgnB1f4L/0wNgqIc8K
 oa3hf7ddPnctnrOXhkaybg9bthWDNIjijyjZ8pMliaS2GVnwGDehjcAXjQA7m39c4rRZ
 e/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuFz9UYOO1FMssF4jaV95r+b3mXya8j0pHpePULX28Y6UG5G8JkxZX1DM6TNDOcpZBSP1WcR513AuL@nongnu.org
X-Gm-Message-State: AOJu0YzVzL3BbGfbOHPh1ztAAvRbgUV+0wcfLvu4nGwCnBnCpWaDlS2E
 tN6RgHdpsCtriNtEOqYBmZwMeom8ZJR2wYVyoi+zHpHRQbgUo4UEjN9nE5fC
X-Google-Smtp-Source: AGHT+IE0JKIbv+fQycMcc3M6e1oxTyxQrNunNuYzbm8oCoy6pXCNWWpt91jAUrq0VvTqdd32bRQYEQ==
X-Received: by 2002:a05:651c:b23:b0:2fa:be89:3dd2 with SMTP id
 38308e7fff4ca-2fabe89403dmr5318791fa.6.1727449728706; 
 Fri, 27 Sep 2024 08:08:48 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-192-199.telecable.es.
 [93.156.192.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dd2e97sm29525905e9.4.2024.09.27.08.08.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 08:08:48 -0700 (PDT)
From: =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
To: qemu-arm@nongnu.org
Cc: alistair@alistair23.me, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
Subject: [PATCH 3/4] STM32: new GPIO device
Date: Fri, 27 Sep 2024 17:07:38 +0200
Message-Id: <20240927150738.57786-3-rcardenas.rod@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240927150738.57786-1-rcardenas.rod@gmail.com>
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=rcardenas.rod@gmail.com; helo=mail-lj1-x22d.google.com
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

Generic GPIO class for STM32 devices. It can be used for most of STM32 chips.
Note that it does not implement configuration locking mechanisms.

Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>
---
 hw/gpio/Kconfig              |   3 +
 hw/gpio/meson.build          |   1 +
 hw/gpio/stm32_gpio.c         | 386 +++++++++++++++++++++++++++++++++++
 hw/gpio/trace-events         |   8 +
 include/hw/arm/stm32.h       |  41 ++++
 include/hw/gpio/stm32_gpio.h | 109 ++++++++++
 6 files changed, 548 insertions(+)
 create mode 100644 hw/gpio/stm32_gpio.c
 create mode 100644 include/hw/arm/stm32.h
 create mode 100644 include/hw/gpio/stm32_gpio.h

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 19c97cc823..9601b7d1bf 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -17,6 +17,9 @@ config GPIO_PWR
 config SIFIVE_GPIO
     bool
 
+config STM32_GPIO
+    bool
+
 config STM32L4X5_GPIO
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index a7495d196a..81f2a5458e 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -15,6 +15,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
     'bcm2835_gpio.c',
     'bcm2838_gpio.c'
 ))
+system_ss.add(when: 'CONFIG_STM32_GPIO', if_true: files('stm32_gpio.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
diff --git a/hw/gpio/stm32_gpio.c b/hw/gpio/stm32_gpio.c
new file mode 100644
index 0000000000..825607b56a
--- /dev/null
+++ b/hw/gpio/stm32_gpio.c
@@ -0,0 +1,386 @@
+/*
+ * STM32 System-on-Chip general purpose input/output register definition
+ *
+ * Copyright 2024 Román Cárdenas <rcardenas.rod@gmail.com>
+ *
+ * Based on sifive_gpio.c:
+ *
+ * Copyright 2019 AdaCore
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/stm32.h"
+#include "hw/gpio/stm32_gpio.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static void stm32_gpio_update_state(STM32GPIOState *s)
+{
+    bool prev_id, new_id, od, in, in_mask;
+    uint8_t mode, pupd;
+
+    for (size_t i = 0; i < s->ngpio; i++) {
+        prev_id = extract32(s->idr, i, 1);
+        od = extract32(s->odr, i, 1);
+        in = extract32(s->in, i, 1);
+        in_mask = extract32(s->in_mask, i, 1);
+
+        mode = extract32(s->moder, i * 2, 2);
+        pupd = extract32(s->pupdr, i * 2, 2);
+
+        /* Pin both driven externally and internally */
+        if (mode == STM32_GPIO_MODE_OUTPUT && in_mask) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited\n", i);
+        }
+
+        if (in_mask) {
+            /* The pin is driven by external device */
+            new_id = in;
+        } else if (mode == STM32_GPIO_MODE_OUTPUT) {
+            /* The pin is driven by internal circuit */
+            new_id = od;
+        } else {
+            /* Floating? Apply pull-up resistor */
+            new_id = pupd == STM32_GPIO_PULL_UP;
+        }
+
+        /* Update IDR */
+        s->idr = deposit32(s->idr, i, 1, new_id);
+
+        /* If pin is in input mode and IDR has changed, trigger an IRQ */
+        if (new_id != prev_id) {
+            if (mode == STM32_GPIO_MODE_INPUT) {
+                qemu_set_irq(s->input_irq[i], new_id);
+            }
+        }
+    }
+    /* Notify that GPIO has changed its state */
+    qemu_irq_pulse(s->state_irq);
+}
+
+static void stm32_gpio_reset(DeviceState *dev)
+{
+    STM32GPIOState *s = STM32_GPIO(dev);
+
+    /*
+     * Enabled is not affected by reset. It is ruled by RCC IDR is not
+     * directly reset. It is updated at the end by update_state
+     */
+
+    /* By default, we set all the registers to 0 */
+    s->moder = 0;
+    s->otyper = 0;
+    s->ospeedr = 0;
+    s->pupdr = 0;
+    s->odr = 0;
+    s->lckr = 0;
+    s->aflr = 0;
+    s->afhr = 0;
+
+    /* Next, we check model particularities */
+    if (s->family == STM32_F4) {
+        if (s->port == STM32_GPIO_PORT_A) {
+            s->moder     = 0xA8000000;
+            s->pupdr   = 0x64000000;
+        } else if (s->port == STM32_GPIO_PORT_B) {
+            s->moder     = 0x00000280;
+            s->ospeedr = 0x000000C0;
+            s->pupdr   = 0x00000100;
+        }
+    }
+
+    stm32_gpio_update_state(s);
+}
+
+static void stm32_gpio_irq_reset(void *opaque, int line, int value)
+{
+    STM32GPIOState *s = STM32_GPIO(opaque);
+
+    trace_stm32_gpio_irq_reset(line, value);
+
+    bool prev_reset = s->reset;
+    s->reset = value != 0;
+    if (prev_reset != s->reset) {
+        if (s->reset) {
+            stm32_gpio_reset(DEVICE(s));
+        } else {
+            stm32_gpio_update_state(s);
+        }
+    }
+}
+
+static void stm32_gpio_irq_enable(void *opaque, int line, int value)
+{
+    STM32GPIOState *s = STM32_GPIO(opaque);
+
+    trace_stm32_gpio_irq_enable(line, value);
+
+    bool prev_enable = s->enable;
+    s->enable = value != 0;
+    if (prev_enable != s->enable) {
+        stm32_gpio_update_state(s);
+    }
+}
+
+static void stm32_gpio_irq_set(void *opaque, int line, int value)
+{
+    STM32GPIOState *s = STM32_GPIO(opaque);
+
+    trace_stm32_gpio_irq_set(line, value);
+
+    assert(line >= 0 && line < s->ngpio);
+
+    s->in_mask = deposit32(s->in_mask, line, 1, value >= 0);
+
+    /*
+     * If value < 0, the pin is connected to a load.
+     * If value == 0, the pin is low.
+     * If value > 0, the pin is high.
+     */
+    if (value >= 0) {
+        s->in = deposit32(s->in, line, 1, value != 0);
+    }
+
+    stm32_gpio_update_state(s);
+}
+
+
+static uint64_t stm32_gpio_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    STM32GPIOState *s = STM32_GPIO(opaque);
+    uint64_t r = 0;
+
+    if (!s->enable) {
+        qemu_log_mask(
+            LOG_GUEST_ERROR, "%s: GPIO peripheral is disabled\n", __func__
+        );
+        return 0;
+    }
+
+    switch (offset) {
+    case STM32_GPIO_REG_MODER:
+        r = s->moder;
+        break;
+
+    case STM32_GPIO_REG_OTYPER:
+        r = s->otyper;
+        break;
+
+    case STM32_GPIO_REG_OSPEEDR:
+        r = s->ospeedr;
+        break;
+
+    case STM32_GPIO_REG_PUPDR:
+        r = s->pupdr;
+        break;
+
+    case STM32_GPIO_REG_IDR:
+        r = s->idr;
+        break;
+
+    case STM32_GPIO_REG_ODR:
+        r = s->odr;
+        break;
+
+    case STM32_GPIO_REG_BSRR:
+        break; /* BSRR is write-only */
+
+    case STM32_GPIO_REG_LCKR:
+        r = s->lckr;
+        break;
+
+    case STM32_GPIO_REG_AFRL:
+        r = s->aflr;
+        break;
+
+    case STM32_GPIO_REG_AFRH:
+        r = s->afhr;
+        break;
+
+    case STM32_GPIO_REG_BRR:
+        if (s->family != STM32_F4) {
+            break; /* BRR is write-only */
+        }
+        /* STM32F4xx SoCs do not have this register */
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: bad read offset 0x%" HWADDR_PRIx "\n",  __func__, offset
+        );
+        break;
+
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: bad read offset 0x%" HWADDR_PRIx "\n",  __func__, offset
+        );
+    }
+
+    trace_stm32_gpio_read(offset, r);
+
+    return r;
+}
+
+static void stm32_gpio_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned int size)
+{
+    STM32GPIOState *s = STM32_GPIO(opaque);
+
+    trace_stm32_gpio_write(offset, value);
+
+    if (!s->enable) {
+        qemu_log_mask(
+            LOG_GUEST_ERROR, "%s: GPIO peripheral is disabled\n", __func__
+        );
+        return;
+    }
+
+    switch (offset) {
+
+    case STM32_GPIO_REG_MODER:
+        s->moder = value;
+        break;
+
+    case STM32_GPIO_REG_OTYPER:
+        s->otyper = value;
+        break;
+
+    case STM32_GPIO_REG_OSPEEDR:
+        s->ospeedr = value;
+        break;
+
+    case STM32_GPIO_REG_PUPDR:
+        s->pupdr = value;
+        break;
+
+    case STM32_GPIO_REG_IDR:
+        break; /* IDR is read-only */
+
+    case STM32_GPIO_REG_ODR:
+        s->odr = value; /* IDR is updated in update_state */
+        break;
+
+    case STM32_GPIO_REG_BSRR:
+        s->odr &= ~((value >> 16) & 0xFFFF);
+        /* set bits have higher priority than reset bits */
+        s->odr |= value & 0xFFFF;
+        break;
+
+    case STM32_GPIO_REG_LCKR:
+        s->lckr = value;
+        break;
+
+    case STM32_GPIO_REG_AFRL:
+        s->aflr = value;
+        break;
+
+    case STM32_GPIO_REG_AFRH:
+        s->afhr = value;
+        break;
+
+    case STM32_GPIO_REG_BRR:
+        if (s->family != STM32_F4) {
+            s->odr &= ~(value & 0xFFFF);
+            break;
+        }
+        /* STM32F4xx SoCs do not have this register */
+        qemu_log_mask(
+            LOG_GUEST_ERROR, "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+            __func__, offset
+        );
+        break;
+
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR, "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+            __func__, offset
+        );
+    }
+
+    stm32_gpio_update_state(s);
+}
+
+static const MemoryRegionOps stm32_gpio_ops = {
+    .read =  stm32_gpio_read,
+    .write = stm32_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_stm32_gpio = {
+    .name = TYPE_STM32_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(moder, STM32GPIOState),
+        VMSTATE_UINT32(otyper, STM32GPIOState),
+        VMSTATE_UINT32(ospeedr, STM32GPIOState),
+        VMSTATE_UINT32(pupdr, STM32GPIOState),
+        VMSTATE_UINT32(idr, STM32GPIOState),
+        VMSTATE_UINT32(odr, STM32GPIOState),
+        VMSTATE_UINT32(lckr, STM32GPIOState),
+        VMSTATE_UINT32(aflr, STM32GPIOState),
+        VMSTATE_UINT32(afhr, STM32GPIOState),
+        VMSTATE_BOOL(reset, STM32GPIOState),
+        VMSTATE_BOOL(enable, STM32GPIOState),
+        VMSTATE_UINT32(in, STM32GPIOState),
+        VMSTATE_UINT32(in_mask, STM32GPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property stm32_gpio_properties[] = {
+    DEFINE_PROP_UINT32("family", STM32GPIOState, family, STM32_F2),
+    DEFINE_PROP_UINT32("port", STM32GPIOState, port, STM32_GPIO_PORT_A),
+    DEFINE_PROP_UINT32("ngpio", STM32GPIOState, ngpio, STM32_GPIO_NPINS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32_gpio_realize(DeviceState *dev, Error **errp)
+{
+    STM32GPIOState *s = STM32_GPIO(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &stm32_gpio_ops, s,
+                          TYPE_STM32_GPIO, STM32_GPIO_PERIPHERAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    qdev_init_gpio_in_named(DEVICE(s), stm32_gpio_irq_reset, "reset-in", 1);
+    qdev_init_gpio_in_named(DEVICE(s), stm32_gpio_irq_enable, "enable-in", 1);
+    qdev_init_gpio_in_named(DEVICE(s), stm32_gpio_irq_set,
+                            "input-in", STM32_GPIO_NPINS);
+
+    qdev_init_gpio_out_named(DEVICE(s), &s->state_irq, "state-out", 1);
+    qdev_init_gpio_out_named(DEVICE(s), s->input_irq,
+                             "input-out", STM32_GPIO_NPINS);
+}
+
+static void stm32_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, stm32_gpio_properties);
+    dc->vmsd = &vmstate_stm32_gpio;
+    dc->realize = stm32_gpio_realize;
+    device_class_set_legacy_reset(dc, stm32_gpio_reset);
+    dc->desc = "STM32 GPIO";
+}
+
+static const TypeInfo stm32_gpio_info = {
+    .name = TYPE_STM32_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32GPIOState),
+    .class_init = stm32_gpio_class_init
+};
+
+static void stm32_gpio_register_types(void)
+{
+    type_register_static(&stm32_gpio_info);
+}
+
+type_init(stm32_gpio_register_types)
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index b91cc7e9a4..b469c5dec1 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -36,6 +36,14 @@ sifive_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " val
 aspeed_gpio_read(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 " value 0x%" PRIx64
 aspeed_gpio_write(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 " value 0x%" PRIx64
 
+# stm32_gpio.c
+stm32_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
+stm32_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
+stm32_gpio_irq_enable(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+stm32_gpio_irq_reset(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+stm32_gpio_irq_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+stm32_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+
 # stm32l4x5_gpio.c
 stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
diff --git a/include/hw/arm/stm32.h b/include/hw/arm/stm32.h
new file mode 100644
index 0000000000..7e8b9a5524
--- /dev/null
+++ b/include/hw/arm/stm32.h
@@ -0,0 +1,41 @@
+/*
+ * STM32 chip configuration parameters.
+ * These enums are used to configure STM32 chips, as well as their peripherals.
+ *
+ * Copyright 2024 Román Cárdenas <rcardenas.rod@gmail.com>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef STM32_H
+#define STM32_H
+
+enum {
+    /* High Performance */
+    STM32_F2,
+    STM32_F4,
+    STM32_H5,
+    STM32_F7,
+    STM32_H7,
+    /* Mainstream */
+    STM32_C0,
+    STM32_F0,
+    STM32_G0,
+    STM32_F1,
+    STM32_F3,
+    STM32_G4,
+    /* Ultra Low Power */
+    STM32_L0,
+    STM32_L4,
+    STM32_L4P,
+    STM32_L5,
+    STM32_U5,
+    /* Wireless */
+    STM32_WL,
+    STM32_WB0,
+    STM32_WB,
+    STM32_WBA,
+};
+
+#endif /* STM32_H */
diff --git a/include/hw/gpio/stm32_gpio.h b/include/hw/gpio/stm32_gpio.h
new file mode 100644
index 0000000000..373c2fa842
--- /dev/null
+++ b/include/hw/gpio/stm32_gpio.h
@@ -0,0 +1,109 @@
+/*
+ * STM32 System-on-Chip general purpose input/output register definition.
+ * While this implementation should work for most of STM32 SoCs, there are
+ * a few chips with different GPIO peripheral. For example, STM32F1 series.
+ *
+ * Copyright 2024 Román Cárdenas <rcardenas.rod@gmail.com>
+ *
+ * Based on sifive_gpio.c:
+ *
+ * Copyright 2019 AdaCore
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef STM32_GPIO_H
+#define STM32_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32_GPIO "stm32.gpio"
+
+typedef struct STM32GPIOState STM32GPIOState;
+
+DECLARE_INSTANCE_CHECKER(STM32GPIOState, STM32_GPIO, TYPE_STM32_GPIO)
+
+#define STM32_GPIO_REG_MODER       0x000
+#define STM32_GPIO_REG_OTYPER      0x004
+#define STM32_GPIO_REG_OSPEEDR     0x008
+#define STM32_GPIO_REG_PUPDR       0x00C
+#define STM32_GPIO_REG_IDR         0x010
+#define STM32_GPIO_REG_ODR         0x014
+#define STM32_GPIO_REG_BSRR        0x018
+#define STM32_GPIO_REG_LCKR        0x01C
+#define STM32_GPIO_REG_AFRL        0x020
+#define STM32_GPIO_REG_AFRH        0x024
+#define STM32_GPIO_REG_BRR         0x028
+
+#define STM32_GPIO_NPINS           16
+#define STM32_GPIO_PERIPHERAL_SIZE 0x400
+
+struct STM32GPIOState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    /* GPIO registers */
+    uint32_t moder;
+    uint32_t otyper;
+    uint32_t ospeedr;
+    uint32_t pupdr;
+    uint32_t idr;      /* Actual value of the pin */
+    uint32_t odr;      /* Pin value requested by the user */
+    uint32_t lckr;     /* TODO implement locking sequence */
+    uint32_t aflr;
+    uint32_t afhr;
+
+    /* state flags from RCC */
+    bool reset;
+    bool enable;
+
+    /* External input */
+    uint32_t in;
+    /*
+     * If in_mask == 0, the pin is disconnected/connected to a load.
+     * If value == 1, the pin is connected to value in in.
+     */
+    uint32_t in_mask;
+
+    /* IRQ to notify that the GPIO has updated its state */
+    qemu_irq state_irq;
+    /* IRQs to relay each input pin changes to other STM32 peripherals */
+    qemu_irq input_irq[STM32_GPIO_NPINS];
+
+    /* config */
+    uint32_t family; /* e.g. STM32_F4 */
+    uint32_t port;   /* e.g. STM32_GPIO_PORT_A */
+    uint32_t ngpio;  /* e.g. 16 */
+};
+
+enum STM32GPIOPort {
+    STM32_GPIO_PORT_A = 0,
+    STM32_GPIO_PORT_B = 1,
+    STM32_GPIO_PORT_C = 2,
+    STM32_GPIO_PORT_D = 3,
+    STM32_GPIO_PORT_E = 4,
+    STM32_GPIO_PORT_F = 5,
+    STM32_GPIO_PORT_G = 6,
+    STM32_GPIO_PORT_H = 7,
+    STM32_GPIO_PORT_I = 8,
+    STM32_GPIO_PORT_J = 9,
+    STM32_GPIO_PORT_K = 10,
+};
+
+enum STM32GPIOMode {
+    STM32_GPIO_MODE_INPUT  = 0,
+    STM32_GPIO_MODE_OUTPUT = 1,
+    STM32_GPIO_MODE_AF     = 2,
+    STM32_GPIO_MODE_ANALOG = 3,
+};
+
+enum STM32GPIOPull {
+    STM32_GPIO_PULL_NONE = 0,
+    STM32_GPIO_PULL_UP   = 1,
+    STM32_GPIO_PULL_DOWN = 2,
+};
+
+#endif /* STM32_GPIO_H */
-- 
2.39.3 (Apple Git-146)


