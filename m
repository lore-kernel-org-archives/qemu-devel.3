Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA55CD5D683
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98b0-0001ZI-NE; Thu, 07 Nov 2024 14:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ExstZwYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1t98av-0001UJ-Tk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:05 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ExstZwYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1t98ar-0003KR-C1
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:05 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ea86f1df79so25569617b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009300; x=1731614100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=fh6EVdMWkSlgfhCNmuALnMqxPtdCp57WS1G6iNMbs3U=;
 b=iI02uI9q9T8o4tDYM/Rvh3pHbwtUKed0cv2/YQ8DlM3WDKcsIqLpdvlJyPA8bq6qeV
 RjJg+D/zBoAlPjEupN8uhHJxd1q+ORwDdJNB2olQm1qhJTKByxqNrgWIgoGnXTYkIA4r
 BmgenJPzGll6X/HBAgmmQVeCrf95tE0A49Fyue1lOex5CueDrvTullfBTVpGKtrNL/c4
 5ZEJ9fOSeQ8d3KL1qGOiFaxeZnuhuFI69rgbhdsdemwOgrm9L6d/8gABaGpeseUH4MBP
 XSHwIJvXC+CI5vBNwIPXp42n565X5pwSrEhQ+He5E4wSYE6Jglfnh1PAeKhOENxsC6wt
 v/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009300; x=1731614100;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fh6EVdMWkSlgfhCNmuALnMqxPtdCp57WS1G6iNMbs3U=;
 b=Uf+xu+h86JYyj080aO/tuageNhz33p4YxBn37J7VCpkUAKvk+21SEl9zXhK81Y6x4W
 e61DjvC12WcfUB/T1NeBs3KRTAIVRViCUBDtoVXdx0W/lXRggjpxhYuAYHXp+eyF2sd6
 sUbrL5x/jmiyD6o/g+3TLytcCH9IuN2I1rwuw2FNdtZLhUkIwPPIjEdok31+13V2n6ly
 5UKk2vxLz4d4V1JS8cuMqNvAtO0GRR/BZJUN7lHk7LFGARolX4GKtCsNV5pllQh4ZNLw
 GkHWK44bYY6E+wbI90P/CXTNewtVaMSglhdYS1IjE0EYzMOidrKOPCRPi0PEr6s/icCj
 ypUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzMtppCOBFaHYLN9oibFR9SzurmFey9ZnVNi2KQn4jvl7TIuHi1bnxLMtGBM+hnUJOqiH6NxSaxGE7@nongnu.org
X-Gm-Message-State: AOJu0YyfKKZ31YZ9xhKlTiMq6yXR074amiAeZv6cvJsgdVvj2s9lvggh
 dIMp9rQgU3TJ5WPoTxjjlMweIgM0KKPj48Ucnb4GG+57fTGa2MJANYRrL6Q6oG3GpXrA/Qzqh1X
 K5A==
X-Google-Smtp-Source: AGHT+IGVwOD+toJRIVcoghaApbc/ubhgXalVgYcg2t2Il/0IXMePlBEMfXj/brEhOcXS/JIcGEecMVyOSBw=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a05:690c:60ca:b0:6e6:38:8567
 with SMTP id
 00721157ae682-6eaddfe6275mr1027b3.8.1731009299737; Thu, 07 Nov 2024 11:54:59
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:49 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-3-titusr@google.com>
Subject: [PATCH 2/6] hw/gpio: add PCA953x i2c GPIO expanders
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3ExstZwYKCj4ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The PCA6416 is an i2c device with 16 GPIO pins, the PCA9538 has 8 pins.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/gpio/Kconfig                 |   5 +
 hw/gpio/meson.build             |   1 +
 hw/gpio/pca_i2c_gpio.c          | 391 ++++++++++++++++++++++++++++++++
 hw/gpio/trace-events            |   5 +
 include/hw/gpio/pca_i2c_gpio.h  |  68 ++++++
 tests/qtest/meson.build         |   1 +
 tests/qtest/pca_i2c_gpio-test.c | 188 +++++++++++++++
 7 files changed, 659 insertions(+)
 create mode 100644 hw/gpio/pca_i2c_gpio.c
 create mode 100644 include/hw/gpio/pca_i2c_gpio.h
 create mode 100644 tests/qtest/pca_i2c_gpio-test.c

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c423e10f59..fde1155424 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -13,6 +13,11 @@ config GPIO_PWR
 config SIFIVE_GPIO
     bool
=20
+config PCA_I2C_GPIO
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
 config STM32L4X5_GPIO
     bool
=20
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c0..51f3ba7fc5 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -18,3 +18,4 @@ system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: file=
s('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_PCA_I2C_GPIO', if_true: files('pca_i2c_gpio.c'=
))
diff --git a/hw/gpio/pca_i2c_gpio.c b/hw/gpio/pca_i2c_gpio.c
new file mode 100644
index 0000000000..2486c620e3
--- /dev/null
+++ b/hw/gpio/pca_i2c_gpio.c
@@ -0,0 +1,391 @@
+/*
+ * NXP PCA I2C GPIO Expanders
+ *
+ * Low-voltage translating 16-bit I2C/SMBus GPIO expander with interrupt o=
utput,
+ * reset, and configuration registers
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA6416A.pdf
+ *            https://www.ti.com/lit/ds/symlink/pca9538.pdf
+ *
+ * Copyright 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * To assert some input pins before boot, use the following in the board f=
ile of
+ * the machine:
+ *      object_property_set_uint(Object *obj, const char *name,
+ *                               uint64_t value, Error **errp);
+ * specifying name as "gpio_config" and the value as a bitfield of the inp=
uts
+ * e.g. for the pca6416, a value of 0xFFF0, configures pins 0-3 as outputs=
 and
+ * 4-15 as inputs.
+ * Then using name "gpio_input" with value "0x0F00" would raise GPIOs 8-11=
.
+ *
+ * This value can also be set at runtime through qmp externally, or by
+ * writing to the config register using i2c. The guest driver should gener=
ally
+ * control the config register, but exposing it via qmp allows external te=
sting.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/pca_i2c_gpio.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/bitops.h"
+#include "trace.h"
+
+/*
+ * compare new_output to curr_output and update irq to match new_output
+ *
+ * The Input port registers (registers 0 and 1) reflect the incoming logic
+ * levels of the pins, regardless of whether the pin is defined as an inpu=
t or
+ * an output by the Configuration register.
+ */
+static void pca_i2c_update_irqs(PCAGPIOState *ps)
+{
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_GET_CLASS(ps);
+    uint16_t out_diff =3D ps->new_output ^ ps->curr_output;
+    uint16_t in_diff =3D ps->new_input ^ ps->curr_input;
+    uint16_t mask, pin_i;
+
+    if (in_diff || out_diff) {
+        for (int i =3D 0; i < pc->num_pins; i++) {
+            mask =3D BIT(i);
+            /* pin must be configured as an output to be set here */
+            if (out_diff & ~ps->config & mask) {
+                pin_i =3D mask & ps->new_output;
+                qemu_set_irq(ps->output[i], pin_i > 0);
+                ps->curr_output &=3D ~mask;
+                ps->curr_output |=3D pin_i;
+            }
+
+            if (in_diff & mask) {
+                ps->curr_input &=3D ~mask;
+                ps->curr_input |=3D mask & ps->new_input;
+            }
+        }
+        /* make diff =3D 0 */
+        ps->new_input =3D ps->curr_input;
+    }
+}
+
+static void pca_i2c_irq_handler(void *opaque, int n, int level)
+{
+    PCAGPIOState *ps =3D opaque;
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_GET_CLASS(opaque);
+    uint16_t mask =3D BIT(n);
+
+    g_assert(n < pc->num_pins);
+    g_assert(n >=3D 0);
+
+    ps->new_input &=3D ~mask;
+
+    if (level > 0) {
+        ps->new_input |=3D BIT(n);
+    }
+
+    pca_i2c_update_irqs(ps);
+}
+
+/* slave to master */
+static uint8_t _pca953x_recv(I2CSlave *i2c, uint32_t shift)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(i2c);
+    uint8_t data;
+
+    switch (ps->command) {
+    case PCA953x_INPUT_PORT:
+        data =3D extract16(ps->curr_input, shift, 8);
+        break;
+    /*
+     * i2c reads to the output registers reflect the values written
+     * NOT the actual values of the gpios
+     */
+    case PCA953x_OUTPUT_PORT:
+        data =3D extract16(ps->new_output, shift, 8);
+        break;
+
+    case PCA953x_POLARITY_INVERSION_PORT:
+        data =3D extract16(ps->polarity_inv, shift, 8);
+        break;
+
+    case PCA953x_CONFIGURATION_PORT:
+        data =3D extract16(ps->config, shift, 8);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: reading from unsupported register 0x%02x",
+                      __func__, ps->command);
+        data =3D 0xFF;
+        break;
+    }
+
+    trace_pca_i2c_recv(DEVICE(ps)->canonical_path, ps->command, shift, dat=
a);
+    return data;
+}
+
+static uint8_t pca6416_recv(I2CSlave *i2c)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(i2c);
+    uint32_t shift =3D ps->command & 1 ? 8 : 0;
+
+    /* Transform command into 4 port equivalent */
+    ps->command =3D ps->command >> 1;
+
+    return _pca953x_recv(i2c, shift);
+}
+
+static uint8_t pca953x_recv(I2CSlave *i2c)
+{
+    return _pca953x_recv(i2c, 0);
+}
+
+/* master to slave */
+static int _pca953x_send(I2CSlave *i2c, uint32_t shift, uint8_t data)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(i2c);
+
+    if (ps->i2c_cmd) {
+        ps->command =3D data;
+        ps->i2c_cmd =3D false;
+        return 0;
+    }
+
+    trace_pca_i2c_send(DEVICE(ps)->canonical_path, ps->command, shift, dat=
a);
+
+    switch (ps->command) {
+    case PCA953x_INPUT_PORT:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: writing to read only reg: 0x%0=
2x",
+                      __func__, ps->command);
+        break;
+    case PCA953x_OUTPUT_PORT:
+        ps->new_output =3D deposit16(ps->new_output, shift, 8, data);
+        break;
+
+    case PCA953x_POLARITY_INVERSION_PORT:
+        ps->polarity_inv =3D deposit16(ps->polarity_inv, shift, 8, data);
+        break;
+
+    case PCA953x_CONFIGURATION_PORT:
+        ps->config =3D deposit16(ps->config, shift, 8, data);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: writing to unsupported register\n",
+                      __func__);
+        return -1;
+    }
+
+    pca_i2c_update_irqs(ps);
+    return 0;
+}
+
+static int pca6416_send(I2CSlave *i2c, uint8_t data)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(i2c);
+    uint32_t shift =3D ps->command & 1 ? 8 : 0;
+
+    /* Transform command into 4 port equivalent */
+    ps->command =3D ps->command >> 1;
+
+    return _pca953x_send(i2c, shift, data);
+}
+
+static int pca953x_send(I2CSlave *i2c, uint8_t data)
+{
+    return _pca953x_send(i2c, 0, data);
+}
+
+static int pca_i2c_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(i2c);
+
+    switch (event) {
+    case I2C_START_RECV:
+        trace_pca_i2c_event(DEVICE(ps)->canonical_path, "START_RECV");
+        break;
+
+    case I2C_START_SEND:
+        trace_pca_i2c_event(DEVICE(ps)->canonical_path, "START_SEND");
+        ps->i2c_cmd =3D true;
+        break;
+
+    case I2C_FINISH:
+        trace_pca_i2c_event(DEVICE(ps)->canonical_path, "FINISH");
+        break;
+
+    case I2C_NACK:
+        trace_pca_i2c_event(DEVICE(ps)->canonical_path, "NACK");
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: unknown event 0x%x\n",
+                      DEVICE(ps)->canonical_path, __func__, event);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void pca_i2c_config_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    visit_type_uint16(v, name, &ps->config, errp);
+}
+
+static void pca_i2c_config_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    if (!visit_type_uint16(v, name, &ps->config, errp)) {
+        return;
+    }
+    pca_i2c_update_irqs(ps);
+}
+
+static void pca_i2c_input_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    visit_type_uint16(v, name, &ps->curr_input, errp);
+}
+
+static void pca_i2c_input_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    if (!visit_type_uint16(v, name, &ps->new_input, errp)) {
+        return;
+    }
+    pca_i2c_update_irqs(ps);
+}
+
+static void pca_i2c_output_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    visit_type_uint16(v, name, &ps->curr_output, errp);
+}
+
+static void pca_i2c_output_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    if (!visit_type_uint16(v, name, &ps->new_output, errp)) {
+        return;
+    }
+    pca_i2c_update_irqs(ps);
+}
+
+static void pca_i2c_enter_reset(Object *obj, ResetType type)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+
+    ps->polarity_inv =3D 0;
+    ps->config =3D 0;
+    ps->new_input =3D 0;
+    ps->new_output =3D 0;
+    ps->command =3D 0;
+
+    pca_i2c_update_irqs(ps);
+}
+
+static const VMStateDescription vmstate_pca_i2c_gpio =3D {
+    .name =3D TYPE_PCA_I2C_GPIO,
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent, PCAGPIOState),
+        VMSTATE_UINT16(polarity_inv, PCAGPIOState),
+        VMSTATE_UINT16(config, PCAGPIOState),
+        VMSTATE_UINT16(curr_input, PCAGPIOState),
+        VMSTATE_UINT16(curr_output, PCAGPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pca6416_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_CLASS(klass);
+
+    dc->desc =3D "PCA6416 16-bit I/O expander";
+    pc->num_pins =3D PCA6416_NUM_PINS;
+
+    k->recv =3D pca6416_recv;
+    k->send =3D pca6416_send;
+}
+
+static void pca9538_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_CLASS(klass);
+
+    dc->desc =3D "PCA9538 8-bit I/O expander";
+    pc->num_pins =3D PCA9538_NUM_PINS;
+
+    k->recv =3D pca953x_recv;
+    k->send =3D pca953x_send;
+}
+
+static void pca_i2c_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_pca_i2c_gpio;
+    rc->phases.enter =3D pca_i2c_enter_reset;
+    k->event =3D pca_i2c_event;
+}
+
+static void pca_i2c_gpio_init(Object *obj)
+{
+    PCAGPIOState *ps =3D PCA_I2C_GPIO(obj);
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_GET_CLASS(obj);
+    DeviceState *dev =3D DEVICE(obj);
+
+    object_property_add(obj, "gpio_input", "uint16",
+                        pca_i2c_input_get,
+                        pca_i2c_input_set, NULL, NULL);
+    object_property_add(obj, "gpio_output", "uint16",
+                        pca_i2c_output_get,
+                        pca_i2c_output_set, NULL, NULL);
+    object_property_add(obj, "gpio_config", "uint16",
+                        pca_i2c_config_get,
+                        pca_i2c_config_set, NULL, NULL);
+    qdev_init_gpio_in(dev, pca_i2c_irq_handler, pc->num_pins);
+    qdev_init_gpio_out(dev, ps->output, pc->num_pins);
+}
+
+static const TypeInfo pca_gpio_types[] =3D {
+    {
+        .name =3D TYPE_PCA_I2C_GPIO,
+        .parent =3D TYPE_I2C_SLAVE,
+        .instance_size =3D sizeof(PCAGPIOState),
+        .instance_init =3D pca_i2c_gpio_init,
+        .class_size =3D sizeof(PCAGPIOClass),
+        .class_init =3D pca_i2c_gpio_class_init,
+        .abstract =3D true,
+    },
+    {
+        .name =3D TYPE_PCA6416_GPIO,
+        .parent =3D TYPE_PCA_I2C_GPIO,
+        .class_init =3D pca6416_gpio_class_init,
+    },
+    {
+    .name =3D TYPE_PCA9538_GPIO,
+    .parent =3D TYPE_PCA_I2C_GPIO,
+    .class_init =3D pca9538_gpio_class_init,
+    },
+};
+
+DEFINE_TYPES(pca_gpio_types);
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index b91cc7e9a4..722fbdd54e 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -41,3 +41,8 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s ad=
dr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s add=
r: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) =
"GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPI=
O%s disconnected pins: 0x%x levels: 0x%x"
+
+# pca_i2c_gpio.c
+pca_i2c_event(const char *id, const char *event) "%s: %s"
+pca_i2c_recv(const char *id, uint8_t cmd, uint32_t shift, uint8_t data) "%=
s cmd: 0x%" PRIx8 "shift: %" PRIi32 " data 0x%" PRIx8
+pca_i2c_send(const char *id, uint8_t cmd, uint32_t shift, uint8_t data) "%=
s cmd: 0x%" PRIx8 "shift: %" PRIi32 " data 0x%" PRIx8
diff --git a/include/hw/gpio/pca_i2c_gpio.h b/include/hw/gpio/pca_i2c_gpio.=
h
new file mode 100644
index 0000000000..61e5853c24
--- /dev/null
+++ b/include/hw/gpio/pca_i2c_gpio.h
@@ -0,0 +1,68 @@
+/*
+ * NXP PCA I2C GPIO Expanders
+ * Low-voltage translating 16-bit I2C/SMBus GPIO expander with interrupt o=
utput,
+ * reset, and configuration registers
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA6416A.pdf
+ *            https://www.ti.com/lit/ds/symlink/pca9538.pdf
+ *
+ * Note: Polarity inversion emulation not implemented
+ *
+ * Copyright 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PCA_I2C_GPIO_H
+#define PCA_I2C_GPIO_H
+
+#include "hw/i2c/i2c.h"
+#include "qom/object.h"
+
+#define PCA_I2C_MAX_PINS                     16
+#define PCA6416_NUM_PINS                     16
+#define PCA9538_NUM_PINS                     8
+
+typedef struct PCAGPIOClass {
+    I2CSlaveClass parent;
+
+    uint8_t num_pins;
+} PCAGPIOClass;
+
+typedef struct PCAGPIOState {
+    I2CSlave parent;
+
+    uint16_t polarity_inv;
+    uint16_t config;
+
+    /* the values of the gpio pins are mirrored in these integers */
+    uint16_t curr_input;
+    uint16_t curr_output;
+    uint16_t new_input;
+    uint16_t new_output;
+
+    /*
+     * Note that these outputs need to be consumed by some other input
+     * to be useful, qemu ignores writes to disconnected gpio pins
+     */
+    qemu_irq output[PCA_I2C_MAX_PINS];
+
+    /* i2c transaction info */
+    uint8_t command;
+    bool i2c_cmd;
+
+} PCAGPIOState;
+
+#define TYPE_PCA_I2C_GPIO "pca_i2c_gpio"
+OBJECT_DECLARE_TYPE(PCAGPIOState, PCAGPIOClass, PCA_I2C_GPIO)
+
+#define PCA953x_INPUT_PORT                   0x00 /* read */
+#define PCA953x_OUTPUT_PORT                  0x01 /* read/write */
+#define PCA953x_POLARITY_INVERSION_PORT      0x02 /* read/write */
+#define PCA953x_CONFIGURATION_PORT           0x03 /* read/write */
+
+#define PCA_I2C_CONFIG_DEFAULT               0
+
+#define TYPE_PCA6416_GPIO "pca6416"
+#define TYPE_PCA9538_GPIO "pca9538"
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index aa93e98418..8a02a06a06 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -291,6 +291,7 @@ qos_test_ss.add(
   'ne2000-test.c',
   'tulip-test.c',
   'nvme-test.c',
+  'pca_i2c_gpio-test.c',
   'pca9552-test.c',
   'pci-test.c',
   'pcnet-test.c',
diff --git a/tests/qtest/pca_i2c_gpio-test.c b/tests/qtest/pca_i2c_gpio-tes=
t.c
new file mode 100644
index 0000000000..2bb4c6a664
--- /dev/null
+++ b/tests/qtest/pca_i2c_gpio-test.c
@@ -0,0 +1,188 @@
+/*
+ * QTest for PCA I2C GPIO expanders
+ *
+ * Copyright 2021 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/pca_i2c_gpio.h"
+#include "libqtest-single.h"
+#include "libqos/i2c.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
+#include "qemu/bitops.h"
+
+
+#define PCA6416_INPUT_PORT_0                 0x00 /* read */
+#define PCA6416_INPUT_PORT_1                 0x01 /* read */
+#define PCA6416_OUTPUT_PORT_0                0x02 /* read/write */
+#define PCA6416_OUTPUT_PORT_1                0x03 /* read/write */
+#define PCA6416_POLARITY_INVERSION_PORT_0    0x04 /* read/write */
+#define PCA6416_POLARITY_INVERSION_PORT_1    0x05 /* read/write */
+#define PCA6416_CONFIGURATION_PORT_0         0x06 /* read/write */
+#define PCA6416_CONFIGURATION_PORT_1         0x07 /* read/write */
+
+
+#define TEST_ID "pca_i2c_gpio-test"
+#define PCA_CONFIG_BYTE         0x55
+#define PCA_CONFIG_BYTE_UPPER   0xAA
+#define PCA_CONFIG_WORD         0xAA55
+
+static uint16_t qmp_pca_gpio_get(const char *id, const char *property)
+{
+    QDict *response;
+    uint16_t ret;
+    response =3D qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s, "
+                   "'property': %s } }", id, property);
+    g_assert(qdict_haskey(response, "return"));
+    ret =3D qnum_get_uint(qobject_to(QNum, qdict_get(response, "return")))=
;
+    qobject_unref(response);
+    return ret;
+}
+
+static void qmp_pca_gpio_set(const char *id, const char *property,
+                             uint16_t value)
+{
+    QDict *response;
+
+    response =3D qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s, "
+                   "'property': %s, 'value': %u } }",
+                   id, property, value);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+}
+
+static void test_set_input(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
+    uint8_t value;
+    uint16_t qmp_value;
+    /* configure pins to be inputs */
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_0, 0xFF);
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_1, 0xFF);
+
+    qmp_pca_gpio_set(TEST_ID, "gpio_input", 0xAAAA);
+    value =3D i2c_get8(i2cdev, PCA6416_INPUT_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0xAA);
+    value =3D i2c_get8(i2cdev, PCA6416_INPUT_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0xAA);
+
+    qmp_value =3D qmp_pca_gpio_get(TEST_ID, "gpio_input");
+    g_assert_cmphex(qmp_value, =3D=3D, 0xAAAA);
+}
+static void test_config(void *obj, void *data, QGuestAllocator *alloc)
+{
+
+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
+    uint8_t value;
+    uint16_t qmp_value;
+    /* configure half the pins to be inputs */
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_0, PCA_CONFIG_BYTE);
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_1, PCA_CONFIG_BYTE_UPPER);
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_0);
+    g_assert_cmphex(value, =3D=3D, PCA_CONFIG_BYTE);
+
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_1);
+    g_assert_cmphex(value, =3D=3D, PCA_CONFIG_BYTE_UPPER);
+
+    /* the pins that match the config should be set, the rest are undef */
+    qmp_pca_gpio_set(TEST_ID, "gpio_input", 0xFFFF);
+    value =3D i2c_get8(i2cdev, PCA6416_INPUT_PORT_0);
+    g_assert_cmphex(value & PCA_CONFIG_BYTE, =3D=3D, 0x55);
+    value =3D i2c_get8(i2cdev, PCA6416_INPUT_PORT_1);
+    g_assert_cmphex(value & PCA_CONFIG_BYTE_UPPER, =3D=3D, 0xAA);
+    qmp_value =3D qmp_pca_gpio_get(TEST_ID, "gpio_input");
+    g_assert_cmphex(qmp_value & PCA_CONFIG_WORD, =3D=3D, 0xAA55);
+
+    /*
+     * i2c will return the value written to the output register, not the v=
alues
+     * of the output pins, so we check only the configured pins
+     */
+    qmp_pca_gpio_set(TEST_ID, "gpio_output", 0xFFFF);
+    value =3D i2c_get8(i2cdev, PCA6416_OUTPUT_PORT_0);
+    g_assert_cmphex(value & ~PCA_CONFIG_BYTE, =3D=3D, 0xAA);
+    value =3D i2c_get8(i2cdev, PCA6416_OUTPUT_PORT_1);
+    g_assert_cmphex(value & ~PCA_CONFIG_BYTE_UPPER, =3D=3D, 0x55);
+
+    qmp_value =3D qmp_pca_gpio_get(TEST_ID, "gpio_output");
+    g_assert_cmphex(qmp_value & ~PCA_CONFIG_WORD, =3D=3D, 0x55AA);
+}
+
+static void test_set_output(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
+    uint8_t value;
+    uint16_t qmp_value;
+    /* configure pins to be outputs */
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_0, 0);
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_1, 0);
+
+    qmp_pca_gpio_set(TEST_ID, "gpio_output", 0xBB55);
+    value =3D i2c_get8(i2cdev, PCA6416_OUTPUT_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0x55);
+    value =3D i2c_get8(i2cdev, PCA6416_OUTPUT_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0xBB);
+
+    qmp_value =3D qmp_pca_gpio_get(TEST_ID, "gpio_output");
+    g_assert_cmphex(qmp_value, =3D=3D, 0xBB55);
+}
+
+static void test_tx_rx(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
+    uint8_t value;
+
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_0, 0xFF);
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_1, 0xFF);
+    i2c_set8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_0, 0);
+    i2c_set8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_1, 0);
+
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0xFF);
+
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0xFF);
+
+    value =3D i2c_get8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0);
+
+    value =3D i2c_get8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0);
+
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_0, 0xAB);
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0xAB);
+
+    i2c_set8(i2cdev, PCA6416_CONFIGURATION_PORT_1, 0xBC);
+    value =3D i2c_get8(i2cdev, PCA6416_CONFIGURATION_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0xBC);
+
+    i2c_set8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_0, 0xAB);
+    value =3D i2c_get8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_0);
+    g_assert_cmphex(value, =3D=3D, 0xAB);
+
+    i2c_set8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_1, 0x7C);
+    value =3D i2c_get8(i2cdev, PCA6416_POLARITY_INVERSION_PORT_1);
+    g_assert_cmphex(value, =3D=3D, 0x7C);
+
+}
+
+static void pca_i2c_gpio_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts =3D {
+        .extra_device_opts =3D "id=3D" TEST_ID ",address=3D0x78"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { 0x78 });
+    g_test_set_nonfatal_assertions();
+
+    qos_node_create_driver("pca6416", i2c_device_create);
+    qos_node_consumes("pca6416", "i2c-bus", &opts);
+
+    qos_add_test("tx-rx", "pca6416", test_tx_rx, NULL);
+    qos_add_test("set_output_gpio", "pca6416", test_set_output, NULL);
+    qos_add_test("set_input_gpio", "pca6416", test_set_input, NULL);
+    qos_add_test("follow_gpio_config", "pca6416", test_config, NULL);
+}
+libqos_init(pca_i2c_gpio_register_nodes);
--=20
2.47.0.277.g8800431eea-goog


