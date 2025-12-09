Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E88D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlAx-0007BA-9S; Mon, 08 Dec 2025 19:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36mY3aQYKCuUfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com>)
 id 1vSlAt-0007A2-T5
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:52 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36mY3aQYKCuUfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com>)
 id 1vSlAr-0007Rm-Up
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:51 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b609c0f6522so8614439a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 16:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765238507; x=1765843307; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=/4FW5co9+fSyaHV9OmjivazZbsmT2AI4p/mhxSPLytQ=;
 b=sjUs2wKiswKjnChXLESAnwy9oozhQLYHlO7j/Nha7YzCFjUn2qjGcokkoIC1IxPXCq
 5BnoGjdYZTfFHxB6eg2+AMGenTnZi2VvB3jXC06sq9qElYOI4v1h/pbm3gmHKDU1AXjv
 1vYQ7YVMgwaFBrunDC0yJD5MqdTlF5FvDuFtp16X15VY9ZnF9Kg9hpyFsgs/5/XDTvj6
 L9XpKIZrzoPc6F8MRg2iuOxM+WfyEu7fi4G1gIt7nuDH0RdYNA3HR5z9bzzAcgyo/W/2
 0n277YOMiRL0XpoUJJByctWdIKTMN3ySOxUWU8B8OJnHtyG8Es4qLapi/iOczmv+zTa8
 l6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765238507; x=1765843307;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4FW5co9+fSyaHV9OmjivazZbsmT2AI4p/mhxSPLytQ=;
 b=ON4DfGptCdf65Rs45b3/UWcDvmTKimMHAVlUktXa24od8pLGBEAtY8v6YnuZYhPlbX
 UWBKbYRyFG5T+2+jD/15uvHfhSK2z7YgX2ukHvYkeHu4F6PKKRbhdMbU0Lk08L2qlPNq
 2899FeRSyLrfE/6vivG/4m6PA7aorI+KZ8zhUGBi+ugn5SZLQOQNZzn9JS71hdbNONsI
 RvdRpOgQ+RC2oCUqCoT3cZNrLzx4rAPMOhqNLW7Z0yM98EZZ1ZrkMmGgLd0vcZ2vs6HR
 GVSjOrR+AKNSridZ15r+bRFcy8eCSQU1ETMUWFAXqFkGnDLOFWHtneN25uLzaip8V1l9
 YPMg==
X-Gm-Message-State: AOJu0YwfNT921NscpHvWOHpc0FEOFN4vpfjF85zaCNGNP1oaqLDooj+E
 DB8fM2NPoP3WkTbcey/mPjg28qRvSv4H78blSlIDOhWOZLODTumO9mwCrRhXsvfPqrkLVQlBnzJ
 9CXqcIoCMBl7fLMj9w8DIfdRVl126m5ldhEtRGJcFKsVX4DfCdmOM1nFN5DMFn1VgsRI6asN7Kp
 5Il9AP/TsPRlpAIGSliM6DwYbH2DdGTWcgEmM=
X-Google-Smtp-Source: AGHT+IFTTdaY/bSolEJp50dgI9jX5/kXhfC9u2JP9xvgnSkoSkmpNnWNxXOINQexKTETn9RpvVYKHiuXV5U=
X-Received: from dybou4.prod.google.com ([2002:a05:7300:e5c4:b0:2a9:e065:7808])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:dd91:b0:2a4:3593:c7d1
 with SMTP id 5a478bee46e88-2abc716505fmr4846252eec.17.1765238506760; Mon, 08
 Dec 2025 16:01:46 -0800 (PST)
Date: Tue, 09 Dec 2025 00:01:33 +0000
In-Reply-To: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
Mime-Version: 1.0
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251209-aspeed-sgpio-v2-1-976e5f5790c2@google.com>
Subject: [PATCH v2 1/6] hw/gpio/aspeed_sgpio: Add basic device model for
 Aspeed SGPIO
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=36mY3aQYKCuUfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This initial implementation includes the basic device structure,
memory-mapped register definitions, and read/write handlers for the
SGPIO control registers.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/gpio/aspeed_sgpio.c         | 154 +++++++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 include/hw/gpio/aspeed_sgpio.h |  66 ++++++++++++++++++
 3 files changed, 221 insertions(+)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
new file mode 100644
index 0000000000000000000000000000000000000000..8676fa7ced134f1f62dc9e30b42c5fe6db3de268
--- /dev/null
+++ b/hw/gpio/aspeed_sgpio.c
@@ -0,0 +1,154 @@
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
+
+static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
+                                uint32_t reg)
+{
+    return 0;
+}
+
+static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+    return s->ctrl_regs[idx];
+}
+
+static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg, uint64_t data)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+    s->ctrl_regs[idx] = data;
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
diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
new file mode 100644
index 0000000000000000000000000000000000000000..ffdc54a112da8962a7bc5773d524f1d86eb85d39
--- /dev/null
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -0,0 +1,66 @@
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
+#include "hw/registerfields.h"
+
+#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
+OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
+
+#define ASPEED_SGPIO_MAX_PIN_PAIR 256
+#define ASPEED_SGPIO_MAX_INT 8
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
+    SHARED_FIELD(SGPIO_INT_TYPE, 3, 3)
+    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
+    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
+    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
+    SHARED_FIELD(SGPIO_INT_STATUS, 12, 1)
+    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
+    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
+    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
+REG32(SGPIO_255_CONTROL, 0x47C)
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

-- 
2.52.0.223.gf5cc29aaa4-goog


