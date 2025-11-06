Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50A4CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5SI-0003TF-Av; Thu, 06 Nov 2025 14:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rfMMaQYKChgMIz6BN4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--yubinz.bounces.google.com>)
 id 1vH5Rk-0003Qu-5W
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:15:01 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rfMMaQYKChgMIz6BN4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--yubinz.bounces.google.com>)
 id 1vH5Rh-0006Ih-1e
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:14:59 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b9b9e8b0812so346263a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 11:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762456493; x=1763061293; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uk54xX7ogokFEs+DWE6194zZ+ftFmuUlVkxP/lINxIo=;
 b=h9BeWR45ms/dzdjm46IMCDyw44yH2BjrlmNpZVkx6LgsGZC/pj6UhQGFbS9WLbYY6Y
 ubIvFz97D3hZps9pce2eSZZjG58GPb7YwxDIHdmbs11IDFtUPceCpVR/b8YJf5TpE4Xd
 8KGlNnYJFATGDkZPxc67xxvHwMCcZZWN0gYEtzZbTLCMLhU9PBJhvFDvdxubBVnkLKcU
 TVUybCt5VrIN2HL/Ygx4ixPqPGMf5NYBAlKz/1qG/3pAqTVufGRZj2u0R10pC+qqPTOX
 JysnfVEBQbyFqbPsl/KJoYqvCIBU5xbSq9CyWv6W4kSGMpe52OhkDG99uVjmKDITMUVX
 NFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762456493; x=1763061293;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uk54xX7ogokFEs+DWE6194zZ+ftFmuUlVkxP/lINxIo=;
 b=kxfFrwMKHhdW2L8qXPpAgyx90tdWw+r+2VW3tSVDOl+RIRRHSUGDTdbcO/7TQVNJmU
 5NWsW25IoRjwj285BHlPacdm6Uieo+Ovwk7B9/veKqnXNLGW4TbIgFbDyY73LMLuG4cW
 9Ss5+RrwJnbvH7uW/rZVufNVl564aarwL5F8NJ7Qnqz5Zbl0GabutkS87D7voA8SBHuQ
 NGSb/gUmHBrMDHiOWR2uJ1RhW3ZQ1+QuBdYXY5B7Y0v7YctE6ZS+IcT9e0HO4QEbXJ+K
 LnDh58Na2kFmH6JGalKLUzX0oYeiV8DOHES+vpQLVa08fwQIIzbSZEl3lRYT1gZimnca
 XZXg==
X-Gm-Message-State: AOJu0YyxIp64o2sUeKzqfOqDoa0UP482hPArjvcRTIQfuYDE6YAzJItB
 Jhg8re7f+mkPqnXzTK5W900xo7816npufbHbFgFWkDxQe2+Dltm8KT0Hpc10GSIIDWlTk2uiw62
 0w6PFX+gyQnFPAU5PMjjncmNE8cmqB23J5r2bj6TtJ1QKomH8wpaEpHYhwXYIcOoeed49BqI3TK
 xnDw7orqEgUwEnJeEvLATCvurlCa46ttQwmXQ=
X-Google-Smtp-Source: AGHT+IEyKowV+UCpdkg/yjEb2+GmfVTkHd1yKt1znjuKtv0gXse6Y1axxwrOCXoekvVbVwitTdG35iMuQV0=
X-Received: from dlae13.prod.google.com ([2002:a05:701b:230d:b0:119:49ca:6b9e])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f790:b0:294:ec7d:969c
 with SMTP id d9443c01a7336-297c046b160mr7604985ad.49.1762456493247; Thu, 06
 Nov 2025 11:14:53 -0800 (PST)
Date: Thu, 06 Nov 2025 19:14:24 +0000
In-Reply-To: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
Mime-Version: 1.0
References: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251106-aspeed-sgpio-v1-1-b026093716fa@google.com>
Subject: [PATCH 1/2] hw/gpio: Add the skeleton of Aspeed Serial gpio
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3rfMMaQYKChgMIz6BN4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

This commit includes a minimal implementation for reading serial input
pin and sets up the necessary device registration on Aspeed 2700 SoC.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/arm/aspeed_ast10x0.c          |   6 +-
 hw/arm/aspeed_ast27x0.c          |  26 ++++
 hw/gpio/aspeed_sgpio.c           | 266 +++++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build              |   1 +
 include/hw/arm/aspeed_soc.h      |   8 +-
 include/hw/gpio/aspeed_sgpio.h   |  38 ++++++
 tests/qtest/ast2700-sgpio-test.c |  94 ++++++++++++++
 tests/qtest/meson.build          |   1 +
 8 files changed, 435 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 7f49c13391be0b923e317409a0fccfa741f5e658..c141cc080422579ca6b6965369d84dfbe416247b 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] = {
     [ASPEED_DEV_ESPI]      = 0x7E6EE000,
     [ASPEED_DEV_SBC]       = 0x7E6F2000,
     [ASPEED_DEV_GPIO]      = 0x7E780000,
-    [ASPEED_DEV_SGPIOM]    = 0x7E780500,
+    [ASPEED_DEV_SGPIOM0]   = 0x7E780500,
     [ASPEED_DEV_TIMER1]    = 0x7E782000,
     [ASPEED_DEV_UART1]     = 0x7E783000,
     [ASPEED_DEV_UART2]     = 0x7E78D000,
@@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] = {
     [ASPEED_DEV_I2C]       = 110, /* 110 ~ 123 */
     [ASPEED_DEV_KCS]       = 138, /* 138 -> 142 */
     [ASPEED_DEV_UDC]       = 9,
-    [ASPEED_DEV_SGPIOM]    = 51,
+    [ASPEED_DEV_SGPIOM0]   = 51,
     [ASPEED_DEV_JTAG0]     = 27,
     [ASPEED_DEV_JTAG1]     = 53,
 };
@@ -427,7 +427,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
                                   "aspeed.sgpiom",
-                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
                                   "aspeed.jtag",
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c484bcd4e22fb49faf9c16992ae2cdfd6cd82da4..787accadbecae376d0c747d054ec6372785375b1 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
+    [ASPEED_DEV_SGPIOM0]   =  0x14C0C000,
+    [ASPEED_DEV_SGPIOM1]   =  0x14C0D000,
     [ASPEED_DEV_I2C]       =  0x14C0F000,
     [ASPEED_DEV_INTCIO]    =  0x14C18000,
     [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
@@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_KCS]       = 128,
     [ASPEED_DEV_ADC]       = 130,
     [ASPEED_DEV_GPIO]      = 130,
+    [ASPEED_DEV_SGPIOM0]   = 130,
+    [ASPEED_DEV_SGPIOM1]   = 130,
     [ASPEED_DEV_I2C]       = 130,
     [ASPEED_DEV_FMC]       = 131,
     [ASPEED_DEV_WDT]       = 131,
@@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_I2C]       = 194,
     [ASPEED_DEV_ADC]       = 194,
     [ASPEED_DEV_GPIO]      = 194,
+    [ASPEED_DEV_SGPIOM0]   = 194,
+    [ASPEED_DEV_SGPIOM1]   = 194,
     [ASPEED_DEV_FMC]       = 195,
     [ASPEED_DEV_WDT]       = 195,
     [ASPEED_DEV_PWM]       = 195,
@@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
+    [ASPEED_DEV_SGPIOM0]    = 21,
+    [ASPEED_DEV_SGPIOM1]    = 24,
 };
 
 /* GICINT 131 */
@@ -511,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     object_initialize_child(obj, "gpio", &s->gpio, typename);
 
+    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
+    for (i = 0; i < sc->sgpio_num; i++) {
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
+    }
+
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
     snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
@@ -965,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
 
+    /* SGPIO */
+    for (i = 0; i < sc->sgpio_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
+    }
+
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
@@ -1061,6 +1085,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 0;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 8;
     sc->macs_num     = 1;
@@ -1089,6 +1114,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 3;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 4;
     sc->wdts_num     = 8;
     sc->macs_num     = 3;
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
new file mode 100644
index 0000000000000000000000000000000000000000..a6f0f32d72aef3c26a143df4e7a49384aa216643
--- /dev/null
+++ b/hw/gpio/aspeed_sgpio.c
@@ -0,0 +1,266 @@
+/*
+ * ASPEED Serial GPIO Controller
+ *
+ * Copyright 2025 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/qdev-properties.h"
+#include "hw/gpio/aspeed_sgpio.h"
+#include "hw/registerfields.h"
+
+/* AST2700 SGPIO Register Address Offsets */
+REG32(SGPIO_INT_STATUS_0, 0x40)
+REG32(SGPIO_INT_STATUS_1, 0x44)
+REG32(SGPIO_INT_STATUS_2, 0x48)
+REG32(SGPIO_INT_STATUS_3, 0x4C)
+REG32(SGPIO_INT_STATUS_4, 0x50)
+REG32(SGPIO_INT_STATUS_5, 0x54)
+REG32(SGPIO_INT_STATUS_6, 0x58)
+REG32(SGPIO_INT_STATUS_7, 0x5C)
+/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
+REG32(SGPIO_0_CONTROL, 0x80)
+    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
+    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
+    SHARED_FIELD(SGPIO_INT_TYPE0, 3, 1)
+    SHARED_FIELD(SGPIO_INT_TYPE1, 4, 1)
+    SHARED_FIELD(SGPIO_INT_TYPE2, 5, 1)
+    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
+    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
+    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
+    SHARED_FIELD(SGPIO_INTERRUPT_STATUS, 12, 1)
+    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
+    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
+    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
+REG32(SGPIO_255_CONTROL, 0x47C)
+
+static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
+                                uint32_t reg)
+{
+    /* TODO: b/430606659 - Implement aspeed_sgpio_2700_read_int_status_reg */
+    return 0;
+}
+
+static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t pin = reg - R_SGPIO_0_CONTROL;
+    if (pin >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, pin);
+        return 0;
+    }
+    return s->ctrl_regs[pin];
+}
+
+static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg, uint64_t data)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t pin = reg - R_SGPIO_0_CONTROL;
+    if (pin >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, pin);
+        return;
+    }
+    s->ctrl_regs[pin] = data;
+}
+
+static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
+                                uint32_t size)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
+    uint64_t value = 0;
+    uint64_t reg;
+
+    reg = offset >> 2;
+
+    switch (reg) {
+    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
+        aspeed_sgpio_2700_read_int_status_reg(s, reg);
+        break;
+    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
+        value = aspeed_sgpio_2700_read_control_reg(s, reg);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                      PRIx64"\n", __func__, offset);
+        return 0;
+    }
+
+    return value;
+}
+
+static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
+                                uint32_t size)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
+    uint64_t reg;
+
+    reg = offset >> 2;
+
+    switch (reg) {
+    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
+        break;
+    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
+        aspeed_sgpio_2700_write_control_reg(s, reg, data);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      PRIx64"\n", __func__, offset);
+        return;
+    }
+}
+
+static bool aspeed_sgpio_get_pin_level(AspeedSGPIOState *s, int pin)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    return value & bit_mask;
+}
+
+static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    if (level) {
+        value |= bit_mask;
+    } else {
+        value &= ~bit_mask;
+    }
+    s->ctrl_regs[pin >> 1] = value;
+    /* TODO: b/430606659 - Implement the SGPIO Interrupt */
+}
+
+static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level = true;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (sscanf(name, "sgpio%d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    level = aspeed_sgpio_get_pin_level(s, pin);
+    visit_type_bool(v, name, &level, errp);
+}
+
+static void aspeed_sgpio_set_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (!visit_type_bool(v, name, &level, errp)) {
+        return;
+    }
+    if (sscanf(name, "sgpio%d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    aspeed_sgpio_set_pin_level(s, pin, level);
+
+}
+static const MemoryRegionOps aspeed_gpio_2700_ops = {
+  .read       = aspeed_sgpio_2700_read,
+  .write      = aspeed_sgpio_2700_write,
+  .endianness = DEVICE_LITTLE_ENDIAN,
+  .valid.min_access_size = 4,
+  .valid.max_access_size = 4,
+};
+
+static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+
+    /* Interrupt parent line */
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
+                          TYPE_ASPEED_SGPIO, agc->mem_size);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_sgpio_init(Object *obj)
+{
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
+        char *name = g_strdup_printf("sgpio%d", i);
+        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+                            aspeed_sgpio_set_pin, NULL, NULL);
+        g_free(name);
+    }
+}
+
+static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_sgpio_realize;
+    dc->desc = "Aspeed SGPIO Controller";
+}
+
+static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const void *data)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_CLASS(klass);
+    agc->nr_sgpio_pin_pairs = 256;
+    agc->mem_size = 0x1000;
+    agc->reg_ops = &aspeed_gpio_2700_ops;
+}
+
+static const TypeInfo aspeed_sgpio_info = {
+    .name           = TYPE_ASPEED_SGPIO,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(AspeedSGPIOState),
+    .class_size     = sizeof(AspeedSGPIOClass),
+    .class_init     = aspeed_sgpio_class_init,
+    .abstract       = true,
+};
+
+static const TypeInfo aspeed_sgpio_ast2700_info = {
+  .name           = TYPE_ASPEED_SGPIO "-ast2700",
+  .parent         = TYPE_ASPEED_SGPIO,
+  .class_init     = aspeed_sgpio_2700_class_init,
+  .instance_init  = aspeed_sgpio_init,
+};
+
+static void aspeed_sgpio_register_types(void)
+{
+    type_register_static(&aspeed_sgpio_info);
+    type_register_static(&aspeed_sgpio_ast2700_info);
+}
+
+type_init(aspeed_sgpio_register_types);
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c01bf4d9a02c058c434c3ec9d2a55bee..6a67ee958faace69ffd3fe08e8ade31ced0faf7e 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -16,5 +16,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4b8e599f1a53bfb2e4d3196d5495cd316f799354..18ff961a38508c5df83b46e187f732d736443f20 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -32,6 +32,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qom/object.h"
@@ -46,6 +47,7 @@
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
 #define ASPEED_SPIS_NUM  3
+#define ASPEED_SGPIO_NUM 2
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
 #define ASPEED_CPUS_NUM  4
@@ -89,6 +91,7 @@ struct AspeedSoCState {
     AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
+    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
@@ -106,7 +109,6 @@ struct AspeedSoCState {
     UnimplementedDeviceState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
-    UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
@@ -166,6 +168,7 @@ struct AspeedSoCClass {
     uint64_t secsram_size;
     int pcie_num;
     int spis_num;
+    int sgpio_num;
     int ehcis_num;
     int wdts_num;
     int macs_num;
@@ -221,6 +224,8 @@ enum {
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
+    ASPEED_DEV_SGPIOM0,
+    ASPEED_DEV_SGPIOM1,
     ASPEED_DEV_RTC,
     ASPEED_DEV_TIMER1,
     ASPEED_DEV_TIMER2,
@@ -263,7 +268,6 @@ enum {
     ASPEED_DEV_I3C,
     ASPEED_DEV_ESPI,
     ASPEED_DEV_UDC,
-    ASPEED_DEV_SGPIOM,
     ASPEED_DEV_JTAG0,
     ASPEED_DEV_JTAG1,
     ASPEED_DEV_FSI1,
diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
new file mode 100644
index 0000000000000000000000000000000000000000..a7d4868eeeb2f2caedcdff9858a6047ce5a1fcd8
--- /dev/null
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -0,0 +1,38 @@
+/*
+ * ASPEED Serial GPIO Controller
+ *
+ * Copyright 2025 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_SGPIO_H
+#define ASPEED_SGPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
+OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
+
+#define ASPEED_SGPIO_MAX_PIN_PAIR 256
+#define ASPEED_SGPIO_MAX_INT 8
+
+struct AspeedSGPIOClass {
+    SysBusDevice parent_obj;
+    uint32_t nr_sgpio_pin_pairs;
+    uint64_t mem_size;
+    const MemoryRegionOps *reg_ops;
+};
+
+struct AspeedSGPIOState {
+  /* <private> */
+  SysBusDevice parent;
+
+  /*< public >*/
+  MemoryRegion iomem;
+  qemu_irq irq;
+  uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
+  uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
+};
+
+#endif /* ASPEED_SGPIO_H */
diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..a24fa29250d0c47b1ca7564280055de2c53f525b
--- /dev/null
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -0,0 +1,94 @@
+/*
+ * QTest testcase for the ASPEED AST2700 GPIO Controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Google LLC.
+ */
+
+#include "qemu/osdep.h"
+#include "qobject/qdict.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "qobject/qdict.h"
+#include "libqtest-single.h"
+#include "qemu/error-report.h"
+
+#define ASPEED_SGPIO_MAX_PIN_PAIR 256
+#define AST2700_SGPIO0_BASE 0x14C0C000
+#define AST2700_SGPIO1_BASE 0x14C0D000
+#define SGPIO_0_CONTROL 0x80
+
+static void test_output_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Odd index is output port */
+        sprintf(name, "sgpio%d", i * 2 + 1);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + SGPIO_0_CONTROL + (i * 4);
+        /* set serial output */
+        qtest_writel(s, offset, 0x00000001);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(value, ==, 0x00000001);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial output */
+        qtest_writel(s, offset, 0x00000000);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(value, ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_input_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + SGPIO_0_CONTROL + (i * 4);
+        /* set serial input */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(value, ==, 0x00002000);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(value, ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_2700_input_pins(void)
+{
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2700/sgpio/input_pins", test_2700_input_pins);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06bdedc6be0c69acadeba989dc15ddf3f..5c80b2ed6de1f453d2483db482c1b0e7801ba980 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -221,6 +221,7 @@ qtests_aspeed = \
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
    'ast2700-hace-test',
+   'ast2700-sgpio-test',
    'ast2700-smc-test']
 
 qtests_stm32l4x5 = \

-- 
2.51.2.1041.gc1ab5b90ca-goog


