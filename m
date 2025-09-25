Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1D3CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aK5-0001nV-7T; Wed, 24 Sep 2025 20:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wpPUaAkKCokyvAvn1Bn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--lixiaoyan.bounces.google.com>)
 id 1v1aK2-0001ld-1E
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:58 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wpPUaAkKCokyvAvn1Bn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJt-0004np-HT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:57 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b522037281bso232773a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758761923; x=1759366723; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IUcVb+wUDv2vQQ6NwJq/sdFvcEeFqSqZ81IDTDRRxg4=;
 b=KNWM3tL0u09Ja24ORR2SIZiLCLEXPgTmx6oLQeBJ9QfAii3zKhVdsJt6nmr1FQ0Vco
 r8BQjDA/DtcsuZtsKB0K0molP5Hjafi4MYWzLt6su9C9GjF7lEtSTJQ2g17eXNZFIYVZ
 EYpTA53w+n9Gqt5KJNXjmLHXwvkMAV6ZnSzm9VOyolLVXBSEQAlRxfM2Tw4gYBBiKQtk
 Z/7UfmnzaGrRddHoJycGnFOOcgEpIcBkggc+rGBY3EDrlPhCDp1I9DRLim9GeUptGpFR
 XXrfLesi3QGlG5IDPYqtWsVKHAF5Ymx8/QJhwREouFRnXQlBhW9NE9bm2s9uWHf1P5ae
 smgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761923; x=1759366723;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUcVb+wUDv2vQQ6NwJq/sdFvcEeFqSqZ81IDTDRRxg4=;
 b=JSDBXoxWQOUmxxoXzwEgMACLY89zOTrysoEYXPQSs7SJyMQsX0X2eFyNYbkT7COvqF
 K/a7msHvZbXu4y1RR2rSZFPudYiq3jTp/vVY65rxlYrNXIUVxzYWB+ZcENYpcEjd0mEQ
 kumyzS4AYKD2luSnWS0erx8hBrUYmhgaXIXXUUzvYzX52lbjTp0bgUsICkRL9ZxmgwPL
 0yKx/5DsFNMQm4yqd2wzwnfVxjpzyfWMwACuie3Mof6HdIL/+cSvarZEitsvZYv1C2Dw
 y93zH8ix2FrArEXzTEpx3jB8n2/Vj3+K0QieFHtnaZl9je0fzJlQTc8whDwG8+IJzU1n
 zmfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMsG2DvjZ6y89MbvrUAjtNE+zJxOjFk8CzD2iIsR7UjnhGN4Dv/wsisRTNmwr7NK0oMyF+yx0aNIKp@nongnu.org
X-Gm-Message-State: AOJu0Yw7GPAylZG4jci59LxrNPC2WQbKLzjocUuHk7Y3gJpwjDzfpMyS
 6aOPxd0Iq9ViQft9umcSTst1mAnNDG+S4FvLC3CTTH5XlditKuOsH/5ZdyoqgjIVEws7WynIZRq
 iLp1GzM+8v+s+RIturw==
X-Google-Smtp-Source: AGHT+IE91GMKgUNRYEccwI3RL7nMQPQuyBT5sB5gYZMkw1yr5xfsr9sA6FS1N+5ts5APG4RXSGcOOUr9mgj/+Bc=
X-Received: from plbkd11.prod.google.com ([2002:a17:903:13cb:b0:269:91b2:4d0c])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc8:b0:279:fa:30fe with SMTP id
 d9443c01a7336-27ed4a57523mr18683545ad.26.1758761922766; 
 Wed, 24 Sep 2025 17:58:42 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:58:31 +0000
In-Reply-To: <20250925005832.3708492-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925005832.3708492-5-lixiaoyan@google.com>
Subject: [PATCH v1 4/5] hw/gpio/npcm8xx: Implement SIOX (SPGIO) device for
 NPCM without input pin logic
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3wpPUaAkKCokyvAvn1Bn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--lixiaoyan.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

Signed-off-by: Coco Li <lixiaoyan@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm8xx.c                 |  23 +-
 hw/gpio/meson.build              |   1 +
 hw/gpio/npcm8xx_sgpio.c          | 425 +++++++++++++++++++++++++++++++
 hw/gpio/trace-events             |   4 +
 include/hw/arm/npcm8xx.h         |   2 +
 include/hw/gpio/npcm8xx_sgpio.h  |  45 ++++
 tests/qtest/meson.build          |   3 +-
 tests/qtest/npcm8xx_sgpio-test.c | 100 ++++++++
 8 files changed, 600 insertions(+), 3 deletions(-)
 create mode 100644 hw/gpio/npcm8xx_sgpio.c
 create mode 100644 include/hw/gpio/npcm8xx_sgpio.h
 create mode 100644 tests/qtest/npcm8xx_sgpio-test.c

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 10887d07fa..ae72c6d54b 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -369,6 +369,11 @@ static const struct {
     },
 };
 
+static const hwaddr npcm8xx_sgpio_addr[] = {
+    0xf0101000,
+    0xf0102000,
+};
+
 static const struct {
     const char *name;
     hwaddr regs_addr;
@@ -474,6 +479,11 @@ static void npcm8xx_init(Object *obj)
     }
 
 
+    for (i = 0; i < ARRAY_SIZE(s->sgpio); i++) {
+        object_initialize_child(obj, "sgpio[*]",
+                                &s->sgpio[i], TYPE_NPCM8XX_SGPIO);
+    }
+
     for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
         object_initialize_child(obj, "smbus[*]", &s->smbus[i],
                                 TYPE_NPCM7XX_SMBUS);
@@ -671,6 +681,17 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
                            npcm8xx_irq(s, NPCM8XX_GPIO0_IRQ + i));
     }
 
+    /* Serial SIOX modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_sgpio_addr) != ARRAY_SIZE(s->sgpio));
+    for (i = 0; i < ARRAY_SIZE(s->sgpio); i++) {
+        Object *obj = OBJECT(&s->sgpio[i]);
+
+        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm8xx_sgpio_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+                           npcm8xx_irq(s, NPCM8XX_SIOX0_IRQ + i));
+    }
+
     /* SMBus modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_smbus_addr) != ARRAY_SIZE(s->smbus));
     for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
@@ -818,8 +839,6 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm8xx.bt",           0xf0030000,   4 * KiB);
     create_unimplemented_device("npcm8xx.espi",         0xf009f000,   4 * KiB);
     create_unimplemented_device("npcm8xx.peci",         0xf0100000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.siox[1]",      0xf0101000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.siox[2]",      0xf0102000,   4 * KiB);
     create_unimplemented_device("npcm8xx.tmps",         0xf0188000,   4 * KiB);
     create_unimplemented_device("npcm8xx.viru1",        0xf0204000,   4 * KiB);
     create_unimplemented_device("npcm8xx.viru2",        0xf0205000,   4 * KiB);
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c0..8a3879983c 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -18,3 +18,4 @@ system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx_sgpio.c'))
diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c
new file mode 100644
index 0000000000..f7d6bbf672
--- /dev/null
+++ b/hw/gpio/npcm8xx_sgpio.c
@@ -0,0 +1,425 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Nuvoton Serial I/O EXPANSION INTERFACE (SOIX)
+ *
+ * Copyright 2025 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/gpio/npcm8xx_sgpio.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+#define NPCM8XX_SGPIO_RD_MODE_MASK      0x6
+#define NPCM8XX_SGPIO_RD_MODE_PERIODIC  0x4
+#define NPCM8XX_SGPIO_RD_MODE_ON_DEMAND 0x0
+#define NPCM8XX_SGPIO_IOXCTS_IOXIF_EN   BIT(7)
+#define NPCM8XX_SGPIO_IOXCTS_WR_PEND    BIT(6)
+#define NPCM8XX_SGPIO_IOXCTS_DATA16W    BIT(3)
+#define NPCM8XX_SGPIO_REGS_SIZE         (4 * KiB)
+
+#define  NPCM8XX_SGPIO_IXOEVCFG_FALLING BIT(1)
+#define  NPCM8XX_SGPIO_IXOEVCFG_RISING  BIT(0)
+#define  NPCM8XX_SGPIO_IXOEVCFG_BOTH    (NPCM8XX_SGPIO_IXOEVCFG_FALLING | \
+                                         NPCM8XX_SGPIO_IXOEVCFG_RISING)
+
+#define  IXOEVCFG_MASK 0x3
+
+/* 8-bit register indices, with the event config registers being 16-bit */
+enum NPCM8xxSGPIORegister {
+    NPCM8XX_SGPIO_XDOUT0,
+    NPCM8XX_SGPIO_XDOUT1,
+    NPCM8XX_SGPIO_XDOUT2,
+    NPCM8XX_SGPIO_XDOUT3,
+    NPCM8XX_SGPIO_XDOUT4,
+    NPCM8XX_SGPIO_XDOUT5,
+    NPCM8XX_SGPIO_XDOUT6,
+    NPCM8XX_SGPIO_XDOUT7,
+    NPCM8XX_SGPIO_XDIN0,
+    NPCM8XX_SGPIO_XDIN1,
+    NPCM8XX_SGPIO_XDIN2,
+    NPCM8XX_SGPIO_XDIN3,
+    NPCM8XX_SGPIO_XDIN4,
+    NPCM8XX_SGPIO_XDIN5,
+    NPCM8XX_SGPIO_XDIN6,
+    NPCM8XX_SGPIO_XDIN7,
+    NPCM8XX_SGPIO_XEVCFG0 = 0x10,
+    NPCM8XX_SGPIO_XEVCFG1 = 0x12,
+    NPCM8XX_SGPIO_XEVCFG2 = 0x14,
+    NPCM8XX_SGPIO_XEVCFG3 = 0x16,
+    NPCM8XX_SGPIO_XEVCFG4 = 0x18,
+    NPCM8XX_SGPIO_XEVCFG5 = 0x1a,
+    NPCM8XX_SGPIO_XEVCFG6 = 0x1c,
+    NPCM8XX_SGPIO_XEVCFG7 = 0x1e,
+    NPCM8XX_SGPIO_XEVSTS0 = 0x20,
+    NPCM8XX_SGPIO_XEVSTS1,
+    NPCM8XX_SGPIO_XEVSTS2,
+    NPCM8XX_SGPIO_XEVSTS3,
+    NPCM8XX_SGPIO_XEVSTS4,
+    NPCM8XX_SGPIO_XEVSTS5,
+    NPCM8XX_SGPIO_XEVSTS6,
+    NPCM8XX_SGPIO_XEVSTS7,
+    NPCM8XX_SGPIO_IOXCTS,
+    NPCM8XX_SGPIO_IOXINDR,
+    NPCM8XX_SGPIO_IOXCFG1,
+    NPCM8XX_SGPIO_IOXCFG2,
+    NPCM8XX_SGPIO_IOXDATR = 0x2d,
+    NPCM8XX_SGPIO_REGS_END,
+};
+
+static uint8_t npcm8xx_sgpio_get_in_port(NPCM8xxSGPIOState *s)
+{
+    uint8_t p;
+
+    p = s->regs[NPCM8XX_SGPIO_IOXCFG2] & 0xf;
+    if (p > 8) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                     "%s: Trying to set more the allowed input ports %d\n",
+                     DEVICE(s)->canonical_path, p);
+    }
+
+    return p;
+}
+
+static uint8_t npcm8xx_sgpio_get_out_port(NPCM8xxSGPIOState *s)
+{
+    uint8_t p;
+
+    p = (s->regs[NPCM8XX_SGPIO_IOXCFG2] >> 4) & 0xf;
+    if (p > 8) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                     "%s: Trying to set more the allowed output ports %d\n",
+                     DEVICE(s)->canonical_path, p);
+    }
+
+    return p;
+}
+
+static bool npcm8xx_sgpio_is_16bit(NPCM8xxSGPIOState *s)
+{
+    return s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_DATA16W;
+}
+
+static uint64_t npcm8xx_sgpio_regs_read_with_cfg(NPCM8xxSGPIOState *s,
+                                                 hwaddr reg)
+{
+    bool rd_word = npcm8xx_sgpio_is_16bit(s);
+    uint64_t value;
+
+    if (rd_word) {
+        value = ((uint16_t)s->regs[reg] << 8) | s->regs[reg + 1];
+    } else {
+        value = s->regs[reg];
+    }
+
+    return value;
+}
+
+static void npcm8xx_sgpio_update_event(NPCM8xxSGPIOState *s, uint64_t diff)
+{
+    /* TODO in upcoming patch */
+}
+
+static void npcm8xx_sgpio_update_pins_in(NPCM8xxSGPIOState *s, uint64_t diff)
+{
+    /* TODO in upcoming patch */
+}
+
+static void npcm8xx_sgpio_update_pins_out(NPCM8xxSGPIOState *s, hwaddr reg)
+{
+    uint8_t nout, dout;
+
+    if (~(s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_IOXIF_EN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Device disabled, transaction out aborted\n",
+                      DEVICE(s)->canonical_path);
+    }
+
+    nout = npcm8xx_sgpio_get_out_port(s);
+    dout = reg - NPCM8XX_SGPIO_XDOUT0;
+    if (dout >= nout) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Accessing XDOUT%d when NOUT is %d\n",
+                      DEVICE(s)->canonical_path, dout, nout);
+    }
+    s->pin_out_level[dout] = s->regs[NPCM8XX_SGPIO_XDOUT0 + dout];
+    /* unset WR_PEND */
+    s->regs[NPCM8XX_SGPIO_IOXCTS] &= ~0x40;
+}
+
+static uint64_t npcm8xx_sgpio_regs_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    NPCM8xxSGPIOState *s = opaque;
+    uint8_t rd_mode = s->regs[NPCM8XX_SGPIO_IOXCTS] &
+                      NPCM8XX_SGPIO_RD_MODE_MASK;
+    hwaddr reg = addr / sizeof(uint8_t);
+    uint8_t nout, nin, din, dout;
+    uint64_t value = 0;
+
+    switch (reg) {
+    case NPCM8XX_SGPIO_XDOUT0 ... NPCM8XX_SGPIO_XDOUT7:
+        nout = npcm8xx_sgpio_get_out_port(s);
+        dout = reg - NPCM8XX_SGPIO_XDOUT0;
+
+        if (dout >= nout) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Accessing XDOUT%d when NOUT is %d\n",
+                          DEVICE(s)->canonical_path, dout, nout);
+            break;
+        }
+
+        value = npcm8xx_sgpio_regs_read_with_cfg(s, reg);
+        break;
+
+    case NPCM8XX_SGPIO_XDIN0 ... NPCM8XX_SGPIO_XDIN7:
+        nin = npcm8xx_sgpio_get_in_port(s);
+        din = reg - NPCM8XX_SGPIO_XDIN0;
+
+        if (din >= nin) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Accessing XDIN%d when NIN is %d\n",
+                          DEVICE(s)->canonical_path, din, nin);
+            break;
+        }
+
+        switch (rd_mode) {
+        case NPCM8XX_SGPIO_RD_MODE_PERIODIC:
+            /* XDIN are up-to-date from scanning, return directly. */
+            value = npcm8xx_sgpio_regs_read_with_cfg(s, reg);
+            break;
+        case NPCM8XX_SGPIO_RD_MODE_ON_DEMAND:
+            /*
+             * IOX_SCAN write behavior is unimplemented.
+             * Event generation is also umimplemented.
+             */
+            qemu_log_mask(LOG_UNIMP,
+                        "%s: On Demand with Polling reading mode is not implemented.\n",
+                        __func__);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown read mode\n", __func__);
+        }
+        break;
+
+    case NPCM8XX_SGPIO_XEVCFG0 ... NPCM8XX_SGPIO_XEVCFG7:
+        value = ((uint64_t)s->regs[reg] << 8) | s->regs[reg + 1];
+        break;
+
+    case NPCM8XX_SGPIO_XEVSTS0 ... NPCM8XX_SGPIO_XEVSTS7:
+        value = npcm8xx_sgpio_regs_read_with_cfg(s, reg);
+        break;
+
+    case NPCM8XX_SGPIO_IOXCTS ... NPCM8XX_SGPIO_IOXDATR:
+        value = s->regs[reg];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+    }
+
+    trace_npcm8xx_sgpio_read(DEVICE(s)->canonical_path, addr, value);
+
+    return value;
+}
+
+static void npcm8xx_sgpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
+                                    unsigned int size)
+{
+    hwaddr reg = addr / sizeof(uint8_t);
+    uint8_t hi_val = (uint8_t)(v >> 8);
+    NPCM8xxSGPIOState *s = opaque;
+    uint8_t value = (uint8_t) v;
+    uint8_t diff;
+
+    trace_npcm8xx_sgpio_write(DEVICE(s)->canonical_path, addr, v);
+
+    switch (reg) {
+    case NPCM8XX_SGPIO_XDOUT0 ... NPCM8XX_SGPIO_XDOUT7:
+        /* Set WR_PEND bit */
+        s->regs[NPCM8XX_SGPIO_IOXCTS] |= 0x40;
+        if (npcm8xx_sgpio_is_16bit(s)) {
+            if ((reg - NPCM8XX_SGPIO_XDOUT0) % 2) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: write unaligned 16 bit register @ 0x%"
+                              HWADDR_PRIx "\n",
+                              DEVICE(s)->canonical_path, addr);
+                break;
+            }
+            s->regs[reg] = hi_val;
+            s->regs[reg + 1] = value;
+            npcm8xx_sgpio_update_pins_out(s, reg + 1);
+        } else {
+            s->regs[reg] = value;
+        }
+        npcm8xx_sgpio_update_pins_out(s, reg);
+        break;
+
+    /*  2 byte long regs */
+    case NPCM8XX_SGPIO_XEVCFG0 ... NPCM8XX_SGPIO_XEVCFG7:
+        if (~(s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_IOXIF_EN)) {
+            s->regs[reg] = hi_val;
+            s->regs[reg + 1] = value;
+        }
+        break;
+
+    case NPCM8XX_SGPIO_XEVSTS0 ... NPCM8XX_SGPIO_XEVSTS7:
+        if (npcm8xx_sgpio_is_16bit(s)) {
+            if ((reg - NPCM8XX_SGPIO_XEVSTS0) % 2) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                            "%s: write unaligned 16 bit register @ 0x%"
+                            HWADDR_PRIx "\n",
+                            DEVICE(s)->canonical_path, addr);
+                break;
+            }
+            s->regs[reg] ^= hi_val;
+            s->regs[reg + 1] ^= value;
+            npcm8xx_sgpio_update_event(s, 0);
+        } else {
+            s->regs[reg] ^= value;
+            npcm8xx_sgpio_update_event(s, 0);
+        }
+        break;
+
+    case NPCM8XX_SGPIO_IOXCTS:
+        /* Make sure RO bit WR_PEND is not written to */
+        value &= ~NPCM8XX_SGPIO_IOXCTS_WR_PEND;
+        diff = s->regs[reg] ^ value;
+        s->regs[reg] = value;
+        if ((s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_IOXIF_EN) &&
+            (diff & NPCM8XX_SGPIO_RD_MODE_MASK)) {
+            /* reset RD_MODE if attempting to write with IOXIF_EN enabled */
+            s->regs[reg] ^= (diff & NPCM8XX_SGPIO_RD_MODE_MASK);
+        }
+        break;
+
+    case NPCM8XX_SGPIO_IOXINDR:
+        /*
+         * Only relevant to SIOX1.
+         * HSIOX unimplemented for both, set value and do nothing.
+         */
+        s->regs[reg] = value;
+        break;
+
+    case NPCM8XX_SGPIO_IOXCFG1:
+    case NPCM8XX_SGPIO_IOXCFG2:
+        if (~(s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_IOXIF_EN)) {
+            s->regs[reg] = value;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: trying to write to register @ 0x%"
+                    HWADDR_PRIx "while IOXIF_EN is enabled\n",
+                    DEVICE(s)->canonical_path, addr);
+        }
+        break;
+
+    case NPCM8XX_SGPIO_XDIN0 ... NPCM8XX_SGPIO_XDIN7:
+    case NPCM8XX_SGPIO_IOXDATR:
+        /* IOX_SCAN is unimplemented given no on-demand mode */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: write to read-only register @ 0x%" HWADDR_PRIx "\n",
+                    DEVICE(s)->canonical_path, addr);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps npcm8xx_sgpio_regs_ops = {
+    .read = npcm8xx_sgpio_regs_read,
+    .write = npcm8xx_sgpio_regs_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+        .unaligned = false,
+    },
+};
+
+static void npcm8xx_sgpio_enter_reset(Object *obj, ResetType type)
+{
+    NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void npcm8xx_sgpio_hold_reset(Object *obj, ResetType type)
+{
+    NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+
+    npcm8xx_sgpio_update_pins_in(s, -1);
+}
+
+static void npcm8xx_sgpio_init(Object *obj)
+{
+    NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+
+    memory_region_init_io(&s->mmio, obj, &npcm8xx_sgpio_regs_ops, s,
+                          "regs", NPCM8XX_SGPIO_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    /* TODO: Add input GPIO pins */
+}
+
+static const VMStateDescription vmstate_npcm8xx_sgpio = {
+    .name = "npcm8xx-sgpio",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(pin_in_level, NPCM8xxSGPIOState,
+                            NPCM8XX_SGPIO_NR_PINS / NPCM8XX_SGPIO_MAX_PORTS),
+        VMSTATE_UINT8_ARRAY(pin_out_level, NPCM8xxSGPIOState,
+                            NPCM8XX_SGPIO_NR_PINS / NPCM8XX_SGPIO_MAX_PORTS),
+        VMSTATE_UINT8_ARRAY(regs, NPCM8xxSGPIOState, NPCM8XX_SGPIO_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm8xx_sgpio_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *reset = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM8XX_SGPIO_REGS_END > NPCM8XX_SGPIO_NR_REGS);
+
+    dc->desc = "NPCM8xx SIOX Controller";
+    dc->vmsd = &vmstate_npcm8xx_sgpio;
+    reset->phases.enter = npcm8xx_sgpio_enter_reset;
+    reset->phases.hold = npcm8xx_sgpio_hold_reset;
+}
+
+static const TypeInfo npcm8xx_sgpio_types[] = {
+    {
+        .name = TYPE_NPCM8XX_SGPIO,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM8xxSGPIOState),
+        .class_init = npcm8xx_sgpio_class_init,
+        .instance_init = npcm8xx_sgpio_init,
+    },
+};
+DEFINE_TYPES(npcm8xx_sgpio_types);
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b28f..5a3625cabc 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -12,6 +12,10 @@ npcm7xx_gpio_set_input(const char *id, int32_t line, int32_t level) "%s line: %"
 npcm7xx_gpio_set_output(const char *id, int32_t line, int32_t level) "%s line: %" PRIi32 " level: %" PRIi32
 npcm7xx_gpio_update_events(const char *id, uint32_t evst, uint32_t even) "%s evst: 0x%08" PRIx32 " even: 0x%08" PRIx32
 
+# npcm8xx_sgpio.c
+npcm8xx_sgpio_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+npcm8xx_sgpio_write(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+
 # nrf51_gpio.c
 nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
 nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a8377db490..2d177329b8 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -21,6 +21,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
+#include "hw/gpio/npcm8xx_sgpio.h"
 #include "hw/intc/arm_gic_common.h"
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm_clk.h"
@@ -104,6 +105,7 @@ struct NPCM8xxState {
     NPCMPCSState        pcs;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi;
+    NPCM8xxSGPIOState   sgpio[2];
 };
 
 struct NPCM8xxClass {
diff --git a/include/hw/gpio/npcm8xx_sgpio.h b/include/hw/gpio/npcm8xx_sgpio.h
new file mode 100644
index 0000000000..cce844951e
--- /dev/null
+++ b/include/hw/gpio/npcm8xx_sgpio.h
@@ -0,0 +1,45 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Nuvoton NPCM8xx General Purpose Input / Output (GPIO)
+ *
+ * Copyright 2025 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM8XX_SGPIO_H
+#define NPCM8XX_SGPIO_H
+
+#include "hw/sysbus.h"
+
+/* Number of pins managed by each controller. */
+#define NPCM8XX_SGPIO_NR_PINS (64)
+
+/*
+ * Number of registers in our device state structure. Don't change this without
+ * incrementing the version_id in the vmstate.
+ */
+#define NPCM8XX_SGPIO_NR_REGS (0x2e)
+#define NPCM8XX_SGPIO_MAX_PORTS 8
+
+typedef struct NPCM8xxSGPIOState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    uint8_t pin_in_level[NPCM8XX_SGPIO_MAX_PORTS];
+    uint8_t pin_out_level[NPCM8XX_SGPIO_MAX_PORTS];
+    uint8_t regs[NPCM8XX_SGPIO_NR_REGS];
+} NPCM8xxSGPIOState;
+
+#define TYPE_NPCM8XX_SGPIO "npcm8xx-sgpio"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCM8xxSGPIOState, NPCM8XX_SGPIO)
+
+#endif /* NPCM8XX_SGPIO_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..12737ad21f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -212,7 +212,8 @@ qtests_npcm7xx = \
    'npcm7xx_watchdog_timer-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
 qtests_npcm8xx = \
-  ['npcm_gmac-test']
+  ['npcm_gmac-test',
+   'npcm8xx_sgpio-test',]
 qtests_aspeed = \
   ['aspeed_gpio-test',
    'aspeed_hace-test',
diff --git a/tests/qtest/npcm8xx_sgpio-test.c b/tests/qtest/npcm8xx_sgpio-test.c
new file mode 100644
index 0000000000..b0b11b3481
--- /dev/null
+++ b/tests/qtest/npcm8xx_sgpio-test.c
@@ -0,0 +1,100 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * QTest testcase for the Nuvoton NPCM8xx I/O EXPANSION INTERFACE (SOIX)
+ * modules.
+ *
+ * Copyright 2025 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define NR_SGPIO_DEVICES 8
+#define SGPIO(x)         (0xf0101000 + (x) * 0x1000)
+#define SGPIO_IRQ(x)     (19 + (x))
+
+/* SGPIO registers */
+#define GP_N_XDOUT(x)   (0x00 + x)
+#define GP_N_XDIN(x)    (0x08 + x)
+#define GP_N_XEVCFG(x)  (0x10 + (x) * 0x2)
+#define GP_N_XEVSTS(x)  (0x20 + x)
+#define GP_N_IOXCTS     0x28
+#define GP_N_IOXINDR    0x29
+#define GP_N_IOXCFG1    0x2a
+#define GP_N_IOXCFG2    0x2b
+#define GP_N_RD_MODE_PERIODIC  0x4
+#define GP_N_IOXIF_EN  0x80
+
+
+/* Restore the SGPIO controller to a sensible default state. */
+static void sgpio_reset(int n)
+{
+    int i;
+
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        writel(SGPIO(n) + GP_N_XDOUT(i), 0x00000000);
+        writel(SGPIO(n) + GP_N_XEVCFG(i), 0x00000000);
+        writel(SGPIO(n) + GP_N_XEVSTS(i), 0x00000000);
+    }
+    writel(SGPIO(n) + GP_N_IOXCTS, 0x00000000);
+    writel(SGPIO(n) + GP_N_IOXINDR, 0x00000000);
+    writel(SGPIO(n) + GP_N_IOXCFG1, 0x00000000);
+    writel(SGPIO(n) + GP_N_IOXCFG2, 0x00000000);
+}
+
+static void test_read_dout_byte(void)
+{
+    int i;
+
+    sgpio_reset(0);
+
+    /* set all 8 output devices */
+    writel(SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        writel(SGPIO(0) + GP_N_XDOUT(i), 0xff);
+        g_assert_cmphex(readb(SGPIO(0) + GP_N_XDOUT(i)), ==, 0xff);
+    }
+}
+
+static void test_read_dout_word(void)
+{
+    int i;
+
+    sgpio_reset(0);
+    /* set all 8 output devices */
+    writel(SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
+    /* set 16 bit aligned access */
+    writel(SGPIO(0) + GP_N_IOXCTS, 1 << 3);
+    for (i = 0; i < NR_SGPIO_DEVICES / 2; ++i) {
+        writel(SGPIO(0) + GP_N_XDOUT(i * 2), 0xf0f0);
+        g_assert_cmphex(readw(SGPIO(0) + GP_N_XDOUT(i * 2)), ==, 0xf0f0);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("/npcm8xx_sgpio/read_dout_byte", test_read_dout_byte);
+    qtest_add_func("/npcm8xx_sgpio/read_dout_word", test_read_dout_word);
+
+    qtest_start("-machine npcm845-evb");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/sgpio");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
-- 
2.51.0.536.g15c5d4f767-goog


