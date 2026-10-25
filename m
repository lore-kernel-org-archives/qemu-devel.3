Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HsF6zycT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL58Z-0006PW-8T; Sun, 25 Oct 2026 16:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan2254650260@gmail.com>)
 id 1xL3sS-0004JL-Ur
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:27:32 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cyan2254650260@gmail.com>)
 id 1xL3sQ-0007jk-H7
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:27:32 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-35943f55c06so3207033eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956448; x=1793561248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PnLTtal6ihDkStuLxAGuJ5FG1gaC4Lv739dJR0Zzrq4=;
 b=HsF6zycT/hMTTx4jyiqEx5U8Ts3q1/8btEhT1hbFtqoukWf4XSOIYkeIrV1+k9n+Tl
 Z49h/t3RxomWk0hRr1yLwh0nooPfAcTEhSwaXhR4KfH+kz/7AWs5j+vySKnExuULXY78
 FDgSA3GHjbyqjQRvUmx87UlNxYHoItErFAvckbiKHL3QspeepRNY55iQ+ecrHY/SrQ6k
 lubH4RKr2Gf4pRmXFdfzM8Lz5fERfVLqexRq7Hw1EfekS7wRC28Z16oNw5KKkHkKIvPh
 ppof7J8QCnvnOpmVkkdBTMDbxeaWcROq0MkzSyqIi3UczwG54K2eB1ZYKSLa8BRM9xyc
 BBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956448; x=1793561248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PnLTtal6ihDkStuLxAGuJ5FG1gaC4Lv739dJR0Zzrq4=;
 b=wKJlIex9BIAS/2hb2QrOQe62eeUvVKmepZB0n2TfJZacwHBqgWGnn2AEmKc0O3Yi16
 wyQsKJq4BlIGnToMSIAXCAdg8ps20r0YeV4/KkBLgyZ/uuep9BlpE0/E7rhzvSe3aeVt
 BiOxvbkr48/LmuK0vPF1VilRNOrQIIv5sr58vckpe6V0KCYIpAX3xSeP/A5A/zIJwYJa
 YYvi+qETIqKi5jCycB4wsJGuU41VrG2WJs4PzepSu5DogEdZqzK5cBhcNj9JYPu+/+PE
 PWHIO96z10jJFVSWK2cv7EbQCkDytqhHvJIPKsP8VkdKb4RbWWyKrUNRkTp4U1LoQP4S
 JXoQ==
X-Gm-Message-State: AFq9FYLQ1UJbAgwL1AmNVa/jUulM6BWR/7fn/lKUiKCo/lqpyDGf5wME
 /xO24ii0BySGL+eozjvoxkkQwxl5shKtIZOuYliMU4KtuPx/i7D5QieJ3CFjBCeSeUqMa5DJSCo
 =
X-Gm-Gg: AYBFou1prtbfGxF6nIuqwqBQOaGGIS9bZTP8yksORxn3PWEwpOOanpyDJz/2kWvHPf8
 7Eob93Dg5KT+JS3w/p9K1uI34GzXT5FV+rF2twZg7ub/wKzEY80ZBjysR+pBCXcKu28JhTAx6gb
 7lFN9vQdG4bKG35rKXhREAffqYQExaYaVd4ofzfGv3SBJY1XTTWrwfsZeO4rO70EFbuVmmTYmT5
 6WPTh+6JN+I+yKXHWJdvq7V1lYCuhwWhVBwSfBXPRVGJ2FAx/N27cowiwQKcRWqxwqXNvg0GyLN
 0xEBGUPKd1JNH0pYHOxEe0r6KpvJ/kteytupfbonQQaUYJ7rv/O+rv2zymXU1zeRqlng/61jlwF
 x3UmToUMRikac/wPEGV9e0p2oE8c7xCTKw0DoKxOrNLxkKmnKMd1L3m0bo3RBUUMHhbRyQt3Eyt
 8ZE6PS8jkpgWy/+s9xvIaMc2MA7nWt4FUmiQhS5a4wIcDUEghhKZocWlgbdFECRq9mwoLp6MS9b
 DSzSFv6J0xjYm1r+Tm07IsKXAmMt3dLh1i0n9X7vKw48MojGkdDSFhGfjJZbTWsHEtGHR/ra3pO
X-Received: by 2002:a05:693c:6093:b0:369:fe82:8d3f with SMTP id
 5a478bee46e88-369fe828ebamr2362618eec.14.1792956448025; 
 Sun, 25 Oct 2026 12:27:28 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([152.175.65.31])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8daa3a8sm23226027eec.16.2026.10.25.12.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:27:27 -0700 (PDT)
From: Pufan Jin <cyan2254650260@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 1/3] hw/gpio: Add Xilinx AXI GPIO device
Date: Mon, 26 Oct 2026 03:27:14 +0800
Message-ID: <20261025192716.239589-2-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192716.239589-1-cyan2254650260@gmail.com>
References: <20261025192716.239589-1-cyan2254650260@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=cyan2254650260@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 16:48:04 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an emulation model for the Xilinx AXI GPIO IP core (PG144).

The core provides general purpose input/output interface to the AXI
bus. It supports up to two channels, configurable data width (1 to 32
bits), per-channel 3-state direction control, global interrupt enable,
and per-channel interrupt generation on input transition.

Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
 MAINTAINERS                     |   2 +
 hw/gpio/Kconfig                 |   3 +
 hw/gpio/meson.build             |   1 +
 hw/gpio/trace-events            |   7 +
 hw/gpio/xlnx-axi-gpio.c         | 282 ++++++++++++++++++++++++++++++++
 include/hw/gpio/xlnx-axi-gpio.h |  59 +++++++
 6 files changed, 354 insertions(+)
 create mode 100644 hw/gpio/xlnx-axi-gpio.c
 create mode 100644 include/hw/gpio/xlnx-axi-gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca1751e30..8d8b9047dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1483,6 +1483,8 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
+F: hw/gpio/xlnx-axi-gpio.c
+F: include/hw/gpio/xlnx-axi-gpio.h
 F: tests/functional/microblaze/test_s3adsp1800.py
 
 petalogix_ml605
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index ea0fb72b40..9414084c11 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -36,3 +36,6 @@ config CADENCE_GPIO
 
 config ALLWINNER_GPIO
     bool
+
+config XLNX_AXI_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8ede5e88ae..80e2963651 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -21,3 +21,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
 system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_GPIO', if_true: files('allwinner-gpio.c'))
+system_ss.add(when: 'CONFIG_XLNX_AXI_GPIO', if_true: files('xlnx-axi-gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 5ef3e0b8fd..f7f50dc783 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -57,3 +57,10 @@ allwinner_gpio_set(const char *port, int line, int level) "[%s:%d] <- %d"
 allwinner_gpio_read(const char *reg, uint32_t value) "[%s] -> 0x%" PRIx32
 allwinner_gpio_write(const char *reg, uint32_t value) "[%s] <- 0x%" PRIx32
 allwinner_gpio_out_pin(const char *reg, uint32_t pin, uint32_t value) "[%s.%d] <- 0x%" PRIx32
+
+# xlnx-axi-gpio.c
+xlnx_axi_gpio_read(uint64_t addr, uint64_t val) "addr: 0x%" PRIx64 " val: 0x%" PRIx64
+xlnx_axi_gpio_write(uint64_t addr, uint64_t val) "addr: 0x%" PRIx64 " val: 0x%" PRIx64
+xlnx_axi_gpio_set_input(int ch, int line, int level) "ch: %d line: %d level: %d"
+xlnx_axi_gpio_set_output(int ch, int line, int level) "ch: %d line: %d level: %d"
+xlnx_axi_gpio_update_irq(int level) "irq level: %d"
diff --git a/hw/gpio/xlnx-axi-gpio.c b/hw/gpio/xlnx-axi-gpio.c
new file mode 100644
index 0000000000..1593ee9688
--- /dev/null
+++ b/hw/gpio/xlnx-axi-gpio.c
@@ -0,0 +1,282 @@
+/*
+ * Xilinx AXI GPIO IP core emulation
+ *
+ * Copyright (c) 2016 Xilinx Inc.
+ * Copyright (c) 2026 Pufan Jin <cyan2254650260@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/bitops.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/gpio/xlnx-axi-gpio.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static void xlnx_axi_gpio_update_irq(XlnxAXIGPIO *s)
+{
+    bool gie = (s->gier & GIER_GIE) != 0;
+    bool pending = (s->isr & s->ier) != 0;
+    int level = (gie && pending) ? 1 : 0;
+
+    trace_xlnx_axi_gpio_update_irq(level);
+    qemu_set_irq(s->irq, level);
+}
+
+static void xlnx_axi_gpio_update_outputs(XlnxAXIGPIO *s, int ch)
+{
+    qemu_irq *out = (ch == 0) ? s->out1 : s->out2;
+    uint32_t val = s->data[ch];
+    uint32_t tri = s->tri[ch];
+    int i;
+
+    for (i = 0; i < s->width[ch]; i++) {
+        if (!extract32(tri, i, 1)) {
+            int level = extract32(val, i, 1);
+            trace_xlnx_axi_gpio_set_output(ch + 1, i, level);
+            qemu_set_irq(out[i], level);
+        }
+    }
+}
+
+static void xlnx_axi_gpio_set_in(void *opaque, int line, int level)
+{
+    XlnxAXIGPIO *s = XLNX_AXI_GPIO(opaque);
+    int ch = line < 32 ? 0 : 1;
+    int bit = line < 32 ? line : (line - 32);
+    uint32_t old_in, new_in;
+
+    if (ch == 1 && !s->is_dual) {
+        return;
+    }
+
+    if (bit >= s->width[ch]) {
+        return;
+    }
+
+    old_in = s->in[ch];
+    new_in = deposit32(old_in, bit, 1, level ? 1 : 0);
+
+    trace_xlnx_axi_gpio_set_input(ch + 1, bit, level);
+
+    if (new_in != old_in) {
+        s->in[ch] = new_in;
+        if (extract32(s->tri[ch], bit, 1)) {
+            s->isr |= (ch == 0) ? IP_ISR_CH1 : IP_ISR_CH2;
+            xlnx_axi_gpio_update_irq(s);
+        }
+    }
+}
+
+static uint64_t xlnx_axi_gpio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XlnxAXIGPIO *s = XLNX_AXI_GPIO(opaque);
+    uint64_t val = 0;
+
+    switch (addr) {
+    case R_GPIO_DATA:
+        val = (s->data[0] & ~s->tri[0]) | (s->in[0] & s->tri[0]);
+        val &= MAKE_64BIT_MASK(0, s->width[0]);
+        break;
+    case R_GPIO_TRI:
+        val = s->tri[0] & MAKE_64BIT_MASK(0, s->width[0]);
+        break;
+    case R_GPIO2_DATA:
+        if (s->is_dual) {
+            val = (s->data[1] & ~s->tri[1]) | (s->in[1] & s->tri[1]);
+            val &= MAKE_64BIT_MASK(0, s->width[1]);
+        }
+        break;
+    case R_GPIO2_TRI:
+        if (s->is_dual) {
+            val = s->tri[1] & MAKE_64BIT_MASK(0, s->width[1]);
+        }
+        break;
+    case R_GIER:
+        val = s->gier;
+        break;
+    case R_IP_ISR:
+        val = s->isr;
+        break;
+    case R_IP_IER:
+        val = s->ier;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+
+    trace_xlnx_axi_gpio_read(addr, val);
+    return val;
+}
+
+static void xlnx_axi_gpio_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    XlnxAXIGPIO *s = XLNX_AXI_GPIO(opaque);
+
+    trace_xlnx_axi_gpio_write(addr, val);
+
+    switch (addr) {
+    case R_GPIO_DATA:
+        s->data[0] = val & MAKE_64BIT_MASK(0, s->width[0]);
+        xlnx_axi_gpio_update_outputs(s, 0);
+        break;
+    case R_GPIO_TRI:
+        s->tri[0] = val & MAKE_64BIT_MASK(0, s->width[0]);
+        xlnx_axi_gpio_update_outputs(s, 0);
+        break;
+    case R_GPIO2_DATA:
+        if (s->is_dual) {
+            s->data[1] = val & MAKE_64BIT_MASK(0, s->width[1]);
+            xlnx_axi_gpio_update_outputs(s, 1);
+        }
+        break;
+    case R_GPIO2_TRI:
+        if (s->is_dual) {
+            s->tri[1] = val & MAKE_64BIT_MASK(0, s->width[1]);
+            xlnx_axi_gpio_update_outputs(s, 1);
+        }
+        break;
+    case R_GIER:
+        s->gier = val & GIER_GIE;
+        xlnx_axi_gpio_update_irq(s);
+        break;
+    case R_IP_ISR:
+        /* Write 1 to clear */
+        s->isr &= ~(val & (IP_ISR_CH1 | IP_ISR_CH2));
+        xlnx_axi_gpio_update_irq(s);
+        break;
+    case R_IP_IER:
+        s->ier = val & (IP_IER_CH1_EN | IP_IER_CH2_EN);
+        xlnx_axi_gpio_update_irq(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps xlnx_axi_gpio_ops[2] = {
+    [0 ... 1] = {
+        .read = xlnx_axi_gpio_read,
+        .write = xlnx_axi_gpio_write,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    },
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void xlnx_axi_gpio_reset_hold(Object *obj, ResetType type)
+{
+    XlnxAXIGPIO *s = XLNX_AXI_GPIO(obj);
+
+    s->data[0] = 0;
+    s->data[1] = 0;
+    s->tri[0] = 0xFFFFFFFF;
+    s->tri[1] = 0xFFFFFFFF;
+    s->gier = 0;
+    s->isr = 0;
+    s->ier = 0;
+
+    xlnx_axi_gpio_update_outputs(s, 0);
+    if (s->is_dual) {
+        xlnx_axi_gpio_update_outputs(s, 1);
+    }
+    xlnx_axi_gpio_update_irq(s);
+}
+
+static void xlnx_axi_gpio_realize(DeviceState *dev, Error **errp)
+{
+    XlnxAXIGPIO *s = XLNX_AXI_GPIO(dev);
+
+    if (s->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XLNX_AXI_GPIO " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+    if (s->width[0] == 0 || s->width[0] > 32) {
+        error_setg(errp, "width1 must be between 1 and 32");
+        return;
+    }
+    if (s->is_dual && (s->width[1] == 0 || s->width[1] > 32)) {
+        error_setg(errp, "width2 must be between 1 and 32");
+        return;
+    }
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &xlnx_axi_gpio_ops[s->model_endianness ==
+                                             ENDIAN_MODE_BIG],
+                          s, TYPE_XLNX_AXI_GPIO, 0x200);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    /* 0..31 for Channel 1, 32..63 for Channel 2 */
+    qdev_init_gpio_in(dev, xlnx_axi_gpio_set_in, 64);
+    /* Output lines for Channel 1 and Channel 2 */
+    qdev_init_gpio_out(dev, s->out1, 32);
+    qdev_init_gpio_out_named(dev, s->out2, "gpio2-out", 32);
+}
+
+static const VMStateDescription vmstate_xlnx_axi_gpio = {
+    .name = TYPE_XLNX_AXI_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(data, XlnxAXIGPIO, 2),
+        VMSTATE_UINT32_ARRAY(tri, XlnxAXIGPIO, 2),
+        VMSTATE_UINT32_ARRAY(in, XlnxAXIGPIO, 2),
+        VMSTATE_UINT32(gier, XlnxAXIGPIO),
+        VMSTATE_UINT32(isr, XlnxAXIGPIO),
+        VMSTATE_UINT32(ier, XlnxAXIGPIO),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property xlnx_axi_gpio_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XlnxAXIGPIO, model_endianness),
+    DEFINE_PROP_BOOL("is-dual", XlnxAXIGPIO, is_dual, true),
+    DEFINE_PROP_UINT32("width1", XlnxAXIGPIO, width[0], 32),
+    DEFINE_PROP_UINT32("width2", XlnxAXIGPIO, width[1], 32),
+};
+
+static void xlnx_axi_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = xlnx_axi_gpio_realize;
+    dc->vmsd = &vmstate_xlnx_axi_gpio;
+    device_class_set_props(dc, xlnx_axi_gpio_properties);
+    rc->phases.hold = xlnx_axi_gpio_reset_hold;
+    dc->desc = "Xilinx AXI GPIO IP core (PG144)";
+}
+
+static const TypeInfo xlnx_axi_gpio_info = {
+    .name          = TYPE_XLNX_AXI_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxAXIGPIO),
+    .class_init    = xlnx_axi_gpio_class_init,
+};
+
+static void xlnx_axi_gpio_register_types(void)
+{
+    type_register_static(&xlnx_axi_gpio_info);
+}
+
+type_init(xlnx_axi_gpio_register_types)
diff --git a/include/hw/gpio/xlnx-axi-gpio.h b/include/hw/gpio/xlnx-axi-gpio.h
new file mode 100644
index 0000000000..534473aa45
--- /dev/null
+++ b/include/hw/gpio/xlnx-axi-gpio.h
@@ -0,0 +1,59 @@
+/*
+ * Xilinx AXI GPIO IP core emulation
+ *
+ * Copyright (c) 2016 Xilinx Inc.
+ * Copyright (c) 2026 Pufan Jin <cyan2254650260@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef XLNX_AXI_GPIO_H
+#define XLNX_AXI_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_XLNX_AXI_GPIO "xlnx.axi-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxAXIGPIO, XLNX_AXI_GPIO)
+
+#define XLNX_AXI_GPIO_NUM_PINS 32
+
+#define R_GPIO_DATA     0x000
+#define R_GPIO_TRI      0x004
+#define R_GPIO2_DATA    0x008
+#define R_GPIO2_TRI     0x00C
+#define R_GIER          0x11C
+#define R_IP_ISR        0x120
+#define R_IP_IER        0x128
+#define XLNX_AXI_GPIO_R_MAX ((0x128 / 4) + 1)
+
+#define GIER_GIE        (1U << 31)
+#define IP_ISR_CH1      (1U << 0)
+#define IP_ISR_CH2      (1U << 1)
+#define IP_IER_CH1_EN   (1U << 0)
+#define IP_IER_CH2_EN   (1U << 1)
+
+struct XlnxAXIGPIO {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+    EndianMode model_endianness;
+
+    qemu_irq out1[XLNX_AXI_GPIO_NUM_PINS];
+    qemu_irq out2[XLNX_AXI_GPIO_NUM_PINS];
+    uint32_t in[2];
+
+    /* Register state */
+    uint32_t data[2];
+    uint32_t tri[2];
+    uint32_t gier;
+    uint32_t isr;
+    uint32_t ier;
+
+    /* Properties */
+    uint32_t width[2];
+    bool is_dual;
+};
+
+#endif /* XLNX_AXI_GPIO_H */
-- 
2.56.0


