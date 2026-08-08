Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96CDC55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgu3-0006O1-Oz; Sat, 08 Aug 2026 09:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsecP-0005Gf-2V; Sat, 08 Aug 2026 06:49:33 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsecL-00022O-Kt; Sat, 08 Aug 2026 06:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786186163;
 bh=tv4zD5jPN9+L7eCtaM2d1bafGngqf5H8mYmZaNcuAD8=;
 h=In-Reply-To:References:Date:Subject:To:Cc:From;
 b=sx6JFlNo9TdLlcyWz4zEiUsrLhwE6tX6VzWbMKn0qfDgmSO+sBsFjV48IkxDbhQEp
 3flOPqdvZ3DZiuKuUuorzpcz4ggYzVprQrDPjO2Td3Jm9XiewlxZUAO5VH8WDw108E
 uyUQ1ILE0eJSODYPRhB245SrinQEdao5sL7btb4E=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id B6A948B5; Sat, 08 Aug 2026 18:45:42 +0800
X-QQ-mid: xmsmtpt1786185942t5qmir6jm
Message-ID: <tencent_4079F108A382388E90910168A31C0E838305@qq.com>
X-QQ-XMAILINFO: OENI+BIeKsiQH81TIGDRKmSHk5ksU3LYp34Ax+wxyiEyUTBLygJw4FmW/LCmXB
 Z556yjfzNClpcq30Y+y4wcXuJpV5fzLj3BVNZcqCFTu74xfH9e7eM+pwUsIqDZgUuvWRmcGXkRZK
 0/eewtvy6iI/38aFVekVzQZyUL5qfQ1tGb6+mGscy//2gtFjv/7Ytb2yVEAcwBgD6W6XBgbRuSwD
 0aRH9bNgwMyDfcEzNxkoJVmG921zO7gAGKiGxm0UCNrlETb7V/SxZ91FapmoANJrGFJSrAID3R/n
 pbXP/kJEM7revDos7HUZTx52b6VCNlNx5DlqYJU6o/dV63BiSBGPGr9zJIr9vC/sLPAYxTKL+lhv
 8GjA8DgjfPMNliInTeq7PD/3H4f0TUUXB1f0YJoNZunqlU/yU3EKBFw4gfZgQ7FqEDDs9k59RPDS
 0AwcuLJMlUANO96DB7JKq5hFgtj1+VIAXzxw40d2Ovm+nJW93Xlnfed/L/2jaLtp7kw+iRqGdwQa
 9PmSKPbumx9djjM5Bl0wkO3zWvQ07nefsXpbdH/IjftVUCrg19MKDWCY+1S94XlUo3on2z0zqWAT
 nmEM4aPZI3MeRsvmZb1yF5dCRhnQVUThuNNU+Sm+dlFuduVrDuWUiWFeKJrY+cLRMPfoSHPK8A8d
 HfmRJXzg+37xAAiBrc6LiuIGEOkHOWWaWpFm3n3/COaqekAXxJiposCjwfEiudnTAhNKgBQ4uBAB
 c8YNjczxV3ua72MXdxYzM4KStd/PC7my4PLEiD6Q7QCYePeUtTY8zp+1cuhxOxaGNGQ33YN2+j69
 ZwLi/d5Jm+U+gY63a558vc1fimz2uIfq0uL9mxY3C1pdzFs1pjaZMx3dbALUcQNaJsZThL1p3+G8
 CebvCLE629bQ0KLgHDsBctEVgDcYmn6KmCEygikad5ZyPxpJLRw31Mv3/QkHhnMZX9mKovtxAxHJ
 KTvzw815pVY3nqHZI8AfxtEwM2lvVqUAyAty4uQP6FyME9oec9vpVapWtARrRfNWQ86BnKiQhKIz
 +eJBZaKgWPD31Ayfc9esPA9nn6t8QyfnHLM+BBzsrte913Oc1l/e9C/b1fVTIoeLg452YH/c73ys
 c2crEG2qm0dcuLrhgC66v/T/Uq16OnYpu5fI1GU85ZEm/Kvxo9S2cIqXLHHA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <05eec6b577fa56e8fc6dd0693f4ab878e227401d.1786185889.git.chengkelfan@qq.com>
In-Reply-To: <cover.1786185889.git.chengkelfan@qq.com>
References: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:23 +0800
Subject: [PATCH 1/5] hw/gpio: add K230 GPIO controller.
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=43.163.128.48; envelope-from=leo-cheng@vip.qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:40 -0400
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

Model the Synopsys DW_apb_gpio controller on the Kendryte K230: direction, output, per-pin edge/level interrupts with EOI and output loopback in EXT_PORTA. Each pin drives its own PLIC line. Register layout from the K230 TRM v0.3.1. Covered by tests/qtest/k230-gpio-test.

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 hw/gpio/Kconfig              |   3 +
 hw/gpio/k230_gpio.c          | 270 +++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build          |   1 +
 hw/gpio/trace-events         |   4 +
 include/hw/gpio/k230_gpio.h  |  68 +++++++++
 tests/qtest/k230-gpio-test.c | 143 +++++++++++++++++++
 6 files changed, 489 insertions(+)
 create mode 100644 hw/gpio/k230_gpio.c
 create mode 100644 include/hw/gpio/k230_gpio.h
 create mode 100644 tests/qtest/k230-gpio-test.c

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294..07ef5a2 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -30,3 +30,6 @@ config PCF8574
 
 config ZAURUS_SCOOP
     bool
+
+config K230_GPIO
+    bool
diff --git a/hw/gpio/k230_gpio.c b/hw/gpio/k230_gpio.c
new file mode 100644
index 0000000..da4448f
--- /dev/null
+++ b/hw/gpio/k230_gpio.c
@@ -0,0 +1,270 @@
+/*
+ * K230 GPIO controller (Synopsys DW_apb_gpio) compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "hw/gpio/k230_gpio.h"
+#include "trace.h"
+
+/* Live pin levels: output pins reflect the driven value, inputs the source. */
+static uint32_t k230_gpio_pin_level(K230GpioState *s)
+{
+    return (s->in & ~s->ddr) | (s->dr & s->ddr);
+}
+
+static void k230_gpio_update(K230GpioState *s, uint32_t old_level)
+{
+    uint32_t level = k230_gpio_pin_level(s);
+
+    for (int i = 0; i < K230_GPIO_PINS; i++) {
+        uint32_t bit = 1u << i;
+
+        if (!(s->inten & bit)) {
+            continue;
+        }
+
+        bool active = (s->int_polarity & bit) ? (level & bit) : !(level & bit);
+
+        if (s->inttype_level & bit) {
+            bool was = (s->int_polarity & bit) ? (old_level & bit)
+                                               : !(old_level & bit);
+            if (active && !was) {
+                s->raw_intstatus |= bit;
+            }
+        } else if (active) {
+            s->raw_intstatus |= bit;
+        } else {
+            s->raw_intstatus &= ~bit;
+        }
+    }
+
+    s->intstatus = s->raw_intstatus & ~s->intmask;
+
+    for (int i = 0; i < K230_GPIO_PINS; i++) {
+        qemu_set_irq(s->irq[i], (s->intstatus >> i) & 1);
+    }
+}
+
+static void k230_gpio_set_input(void *opaque, int line, int level)
+{
+    K230GpioState *s = K230_GPIO(opaque);
+    uint32_t old = k230_gpio_pin_level(s);
+
+    if (level) {
+        s->in |= (1u << line);
+    } else {
+        s->in &= ~(1u << line);
+    }
+    k230_gpio_update(s, old);
+}
+
+static uint64_t k230_gpio_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230GpioState *s = K230_GPIO(opaque);
+    uint32_t value = 0;
+
+    switch (addr) {
+    case K230_GPIO_SWPORTA_DR:
+        value = s->dr;
+        break;
+    case K230_GPIO_SWPORTA_DDR:
+        value = s->ddr;
+        break;
+    case K230_GPIO_SWPORTA_CTL:
+        value = s->ctl;
+        break;
+    case K230_GPIO_INTEN:
+        value = s->inten;
+        break;
+    case K230_GPIO_INTMASK:
+        value = s->intmask;
+        break;
+    case K230_GPIO_INTTYPE_LEVEL:
+        value = s->inttype_level;
+        break;
+    case K230_GPIO_INT_POLARITY:
+        value = s->int_polarity;
+        break;
+    case K230_GPIO_INTSTATUS:
+        value = s->intstatus;
+        break;
+    case K230_GPIO_RAW_INTSTATUS:
+        value = s->raw_intstatus;
+        break;
+    case K230_GPIO_DEBOUNCE:
+        value = s->debounce;
+        break;
+    case K230_GPIO_EXT_PORTA:
+        value = k230_gpio_pin_level(s);
+        break;
+    case K230_GPIO_LS_SYNC:
+        value = s->ls_sync;
+        break;
+    case K230_GPIO_VER_ID_CODE:
+        value = K230_GPIO_VER_ID_VALUE;
+        break;
+    case K230_GPIO_CONFIG_REG2:
+        /* Port A width - 1 in bits [4:0]; single 32-bit port. */
+        value = K230_GPIO_PINS - 1;
+        break;
+    default:
+        break;
+    }
+
+    trace_k230_gpio_read(addr, value);
+    return value;
+}
+
+static void k230_gpio_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned int size)
+{
+    K230GpioState *s = K230_GPIO(opaque);
+    uint32_t old = k230_gpio_pin_level(s);
+
+    trace_k230_gpio_write(addr, value);
+
+    switch (addr) {
+    case K230_GPIO_SWPORTA_DR:
+        s->dr = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_SWPORTA_DDR:
+        s->ddr = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_SWPORTA_CTL:
+        s->ctl = value;
+        break;
+    case K230_GPIO_INTEN:
+        s->inten = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_INTMASK:
+        s->intmask = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_INTTYPE_LEVEL:
+        s->inttype_level = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_INT_POLARITY:
+        s->int_polarity = value;
+        k230_gpio_update(s, old);
+        break;
+    case K230_GPIO_DEBOUNCE:
+        s->debounce = value;
+        break;
+    case K230_GPIO_PORTA_EOI:
+        /* Write-1-to-clear latched edge interrupts only. */
+        s->raw_intstatus &= ~(value & s->inttype_level);
+        k230_gpio_update(s, k230_gpio_pin_level(s));
+        break;
+    case K230_GPIO_LS_SYNC:
+        s->ls_sync = value;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_gpio_ops = {
+    .read = k230_gpio_read,
+    .write = k230_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_gpio_reset(DeviceState *dev)
+{
+    K230GpioState *s = K230_GPIO(dev);
+
+    s->dr = 0;
+    s->ddr = 0;
+    s->ctl = 0;
+    s->inten = 0;
+    s->intmask = 0;
+    s->inttype_level = 0;
+    s->int_polarity = 0;
+    s->intstatus = 0;
+    s->raw_intstatus = 0;
+    s->debounce = 0;
+    s->ls_sync = 0;
+    s->in = 0;
+
+    for (int i = 0; i < K230_GPIO_PINS; i++) {
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static const VMStateDescription vmstate_k230_gpio = {
+    .name = "k230.gpio",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(dr, K230GpioState),
+        VMSTATE_UINT32(ddr, K230GpioState),
+        VMSTATE_UINT32(ctl, K230GpioState),
+        VMSTATE_UINT32(inten, K230GpioState),
+        VMSTATE_UINT32(intmask, K230GpioState),
+        VMSTATE_UINT32(inttype_level, K230GpioState),
+        VMSTATE_UINT32(int_polarity, K230GpioState),
+        VMSTATE_UINT32(intstatus, K230GpioState),
+        VMSTATE_UINT32(raw_intstatus, K230GpioState),
+        VMSTATE_UINT32(debounce, K230GpioState),
+        VMSTATE_UINT32(ls_sync, K230GpioState),
+        VMSTATE_UINT32(in, K230GpioState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_gpio_realize(DeviceState *dev, Error **errp)
+{
+    K230GpioState *s = K230_GPIO(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_gpio_ops, s,
+                          TYPE_K230_GPIO, K230_GPIO_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+    for (int i = 0; i < K230_GPIO_PINS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+    qdev_init_gpio_in(dev, k230_gpio_set_input, K230_GPIO_PINS);
+}
+
+static void k230_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_gpio_realize;
+    device_class_set_legacy_reset(dc, k230_gpio_reset);
+    dc->vmsd = &vmstate_k230_gpio;
+    dc->desc = "K230 GPIO controller";
+}
+
+static const TypeInfo k230_gpio_info = {
+    .name          = TYPE_K230_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230GpioState),
+    .class_init    = k230_gpio_class_init,
+};
+
+static void k230_gpio_register_type(void)
+{
+    type_register_static(&k230_gpio_info);
+}
+type_init(k230_gpio_register_type)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6a67ee9..94b5d9e 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_K230_GPIO', if_true: files('k230_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b..ac5d7fd 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) "GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
+
+# k230_gpio.c
+k230_gpio_read(uint64_t addr, uint32_t data) "K230 GPIO read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_gpio_write(uint64_t addr, uint64_t data) "K230 GPIO write: [0x%" PRIx64 "] <- 0x%" PRIx64
diff --git a/include/hw/gpio/k230_gpio.h b/include/hw/gpio/k230_gpio.h
new file mode 100644
index 0000000..10c123d
--- /dev/null
+++ b/include/hw/gpio/k230_gpio.h
@@ -0,0 +1,68 @@
+/*
+ * K230 GPIO controller (Synopsys DW_apb_gpio) compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#ifndef HW_GPIO_K230_GPIO_H
+#define HW_GPIO_K230_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_GPIO "riscv.k230.gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(K230GpioState, K230_GPIO)
+
+#define K230_GPIO_PINS      32
+#define K230_GPIO_MMIO_SIZE 0x1000
+
+enum {
+    K230_GPIO_SWPORTA_DR   = 0x00,
+    K230_GPIO_SWPORTA_DDR  = 0x04,
+    K230_GPIO_SWPORTA_CTL  = 0x08,
+    K230_GPIO_INTEN        = 0x30,
+    K230_GPIO_INTMASK      = 0x34,
+    K230_GPIO_INTTYPE_LEVEL = 0x38,
+    K230_GPIO_INT_POLARITY = 0x3c,
+    K230_GPIO_INTSTATUS    = 0x40,
+    K230_GPIO_RAW_INTSTATUS = 0x44,
+    K230_GPIO_DEBOUNCE     = 0x48,
+    K230_GPIO_PORTA_EOI    = 0x4c,
+    K230_GPIO_EXT_PORTA    = 0x50,
+    K230_GPIO_LS_SYNC      = 0x60,
+    K230_GPIO_ID_CODE      = 0x64,
+    K230_GPIO_VER_ID_CODE  = 0x6c,
+    K230_GPIO_CONFIG_REG2  = 0x70,
+    K230_GPIO_CONFIG_REG1  = 0x74,
+};
+
+#define K230_GPIO_VER_ID_VALUE 0x3230312a
+
+struct K230GpioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq[K230_GPIO_PINS];
+
+    uint32_t dr;
+    uint32_t ddr;
+    uint32_t ctl;
+    uint32_t inten;
+    uint32_t intmask;
+    uint32_t inttype_level;
+    uint32_t int_polarity;
+    uint32_t intstatus;
+    uint32_t raw_intstatus;
+    uint32_t debounce;
+    uint32_t ls_sync;
+
+    uint32_t in;
+};
+
+#endif
diff --git a/tests/qtest/k230-gpio-test.c b/tests/qtest/k230-gpio-test.c
new file mode 100644
index 0000000..42ef137
--- /dev/null
+++ b/tests/qtest/k230-gpio-test.c
@@ -0,0 +1,143 @@
+/*
+ * QTest testcase for K230 GPIO (DW_apb_gpio)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/gpio/k230_gpio.h"
+
+#define GPIO0_BASE 0x9140B000
+#define GPIO1_BASE 0x9140C000
+
+#define PLIC_BASE       0xF00000000ULL
+#define PLIC_PENDING    (PLIC_BASE + 0x1000)
+#define GPIO0_IRQ_BASE  32
+
+static bool plic_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return (word >> (irq % 32)) & 1;
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_EXT_PORTA), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Output pins loop back into EXT_PORTA */
+static void test_output_loopback(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_EXT_PORTA) & 0x1,
+                    ==, 0x1);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_EXT_PORTA) & 0x1,
+                    ==, 0x0);
+
+    /* Independent pins */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0xFFFFFFFF);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x80000001);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_EXT_PORTA),
+                    ==, 0x80000001);
+
+    qtest_quit(qts);
+}
+
+/* Rising-edge interrupt via DR toggle on an output pin, cleared by EOI */
+static void test_edge_interrupt(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTTYPE_LEVEL, 0x1); /* edge */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INT_POLARITY, 0x1);  /* rising */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTEN, 0x1);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0x1);
+    g_assert_true(plic_pending(qts, GPIO0_IRQ_BASE + 0));
+
+    /* Write-1 EOI clears the latched edge */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_PORTA_EOI, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Level interrupt follows the pin; EOI does not clear it */
+static void test_level_interrupt(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTTYPE_LEVEL, 0x0); /* level */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INT_POLARITY, 0x1);  /* high */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTEN, 0x1);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0x1);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* INTMASK hides the interrupt from INTSTATUS/PLIC but not RAW_INTSTATUS */
+static void test_mask(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTTYPE_LEVEL, 0x0);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INT_POLARITY, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTMASK, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTEN, 0x1);
+
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 0x1,
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                    GPIO0_BASE + K230_GPIO_RAW_INTSTATUS) & 0x1, ==, 0x1);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-gpio/reset_values", test_reset_values);
+    qtest_add_func("/k230-gpio/output_loopback", test_output_loopback);
+    qtest_add_func("/k230-gpio/edge_interrupt", test_edge_interrupt);
+    qtest_add_func("/k230-gpio/level_interrupt", test_level_interrupt);
+    qtest_add_func("/k230-gpio/mask", test_mask);
+
+    return g_test_run();
+}
-- 
2.43.0


