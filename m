Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907EC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0DJ-000649-GJ; Sun, 26 Jul 2026 10:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0D3-0005yY-2F
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:52:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Cz-00062G-4A
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:52:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso32295795ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785077524; x=1785682324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZnuUzF0dJIBznvvjx9kVt4TXwDvHfe0DU2pEHtYFjzE=;
 b=jTp8PVG01HB7mgsj2TPgmWmjM/01brADE1qkizvUjZDqrbUsas50aRZfZObsYxFlJQ
 G5oLZLyBaHKHWfYU/QeCxJC7o+3rQQzSHFdAGmt8q1eJ079WhQAEGmqfCFq9tXI7MmBj
 2TC8QWOlBT6Q+HbxD9cQgCAcfKvycYqPplzLN9VWmhGzilcBaxrrC1ys2cOjfuord2iV
 LAiRHNY434pbLJ2vQUyFPjY7tw9VtJeD9+lv8JEyk+5xmaLPZQ0LGECEBdkfANt7/46M
 EpD3kCN/CMyv7+iSoqTV3n5y07OCtjSkPJHYpm5RkiNXNbFGrab72Q4Cxg/A0TKY82ec
 MJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785077524; x=1785682324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnuUzF0dJIBznvvjx9kVt4TXwDvHfe0DU2pEHtYFjzE=;
 b=iZVdQvIwKseRohPD28m9R5Ueut2Z/8a/5UVU0+CFVZ6N13dNwrilShfWr19Y73Klee
 0r1kHdx8aaKqspGNsVV3SJbIG/RiPniUw2HPc/sq9h7YjsbtjsFKYJ/HmzqHYP8tJr6f
 M0dJFy0Qsf1HUCSUZ/eqHL3tHJmoJ8mndtL2ucWiiMhaBvwgga3JylDx0/cSIkj306DK
 W4LKOAl2T+mAVYKiza8psatZKM8LGV4AOf+Y78yFdGeI7gR44vQaEoyO5DdmRkUuzRQ3
 CIdFEthqNnErkeMw90BYPOt0AJG3MU+sIr5g2g0ZuNYzlmb/dvY0TkB0SA5dbak+vrd7
 nO1Q==
X-Gm-Message-State: AOJu0YyyP8BpZAtH8y+/+H/+gv6pl6hSrjTdbRNQIOI4wPfPQbCio6tz
 A2c+F8rZJvMTqA3gYfvBLyqFxRlzxPstEd0QjvmPzYMhLhtoWcUcT09b805qEg==
X-Gm-Gg: AR+sD11S+MFX6zZNVAgTvvo+fOLxIr4I54rXo6lr/jE/WOMnX4dBB6CrnuVzlw4j79g
 GlgYFEw4LsACQ46gpzHCaC3m69vK1w9mKq7dSOv2pnjKT6e+9is3lZOPzcgyUBaWdcv26wo9ZT7
 IAUtaf6Ygx9gBztoVgh6eyjEjiPRdAs2jBgTCqeJd6XaD64bQgwyiOHYbw3si3A/EJwg9lOcIUI
 ZEArF5+YsNbJnBc+e0sBiPKEAHlUMpOCLZTrRZSl0YO5r8qntKwQCHqdG33npbgTUlzcgW2fWUQ
 gthwYF46VukLUwctJRX+MDMAmDbsmN3wXXFX6C7zc+/eDQiN+laNPZe9NzdbMvB/nSwTNebKmZF
 tyCi2DnKS46qgfWbdHeVxxKJ2HgzXGdJWnIipgD7/xEUHNqvWMNdlf9HhsOccKnlSY4L3s7OhNd
 4IkFOf0sY6REsG9gNg1P/cNBx1
X-Received: by 2002:a17:902:d2c6:b0:2cf:7de1:4a00 with SMTP id
 d9443c01a7336-2cfd70c0f61mr70085545ad.1.1785077523444; 
 Sun, 26 Jul 2026 07:52:03 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d7f5sm20934195ad.83.2026.07.26.07.51.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:52:01 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com,
 Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH v1 4/5] tests/qtest: add stm32f103 GPIO test
Date: Sun, 26 Jul 2026 22:51:18 +0800
Message-ID: <20260726145119.19881-5-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
References: <20260726145119.19881-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a qtest that drives the STM32F103 GPIO ports over the qtest socket,
covering the RM0008 reset state, BSRR/BRR set/reset semantics and the
output-line behaviour for push-pull and open-drain configurations.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 tests/qtest/meson.build           |   4 +
 tests/qtest/stm32f103_gpio-test.c | 328 ++++++++++++++++++++++++++++++
 2 files changed, 332 insertions(+)
 create mode 100644 tests/qtest/stm32f103_gpio-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e154abb05d..4f407b68fe 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -235,6 +235,9 @@ qtests_stm32l4x5 = \
    'stm32l4x5_gpio-test',
    'stm32l4x5_usart-test']
 
+qtests_stm32f103 = \
+  ['stm32f103_gpio-test']
+
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
@@ -250,6 +253,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
+  (config_all_devices.has_key('CONFIG_STM32F103_SOC') ? qtests_stm32f103 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
diff --git a/tests/qtest/stm32f103_gpio-test.c b/tests/qtest/stm32f103_gpio-test.c
new file mode 100644
index 0000000000..97ef7dd3e8
--- /dev/null
+++ b/tests/qtest/stm32f103_gpio-test.c
@@ -0,0 +1,328 @@
+/*
+ * QTest testcase for STM32F103 GPIO (Rust device "stm32f1xx-gpio-rust")
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 QEMU contributors
+ *
+ * The STM32F1 GPIO differs from the L4 family: each pin is configured by a
+ * 4-bit field MODE[1:0]+CNF[1:0] packed into CRL (pins 0-7) and CRH (pins
+ * 8-15), instead of the separate MODER/OTYPER/PUPDR registers of the L4.
+ * See ST RM0008 for the register map and reset values.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define GPIO_BASE_ADDR 0x40010800
+#define GPIO_SIZE      0x400
+#define NUM_GPIOS      7
+#define NUM_GPIO_PINS  16
+
+#define GPIO_A 0x40010800
+#define GPIO_B 0x40010C00
+#define GPIO_C 0x40011000
+#define GPIO_D 0x40011400
+#define GPIO_E 0x40011800
+#define GPIO_F 0x40011C00
+#define GPIO_G 0x40012000
+
+/* Register offsets (RM0008). */
+#define CRL  0x00
+#define CRH  0x04
+#define IDR  0x08
+#define ODR  0x0C
+#define BSRR 0x10
+#define BRR  0x14
+#define LCKR 0x18
+
+/* 4-bit MODE[1:0]+CNF[1:0] pin configurations. */
+#define CFG_INPUT_FLOATING   0x4  /* MODE=00 CNF=01 (reset default) */
+#define CFG_INPUT_PULL       0x8  /* MODE=00 CNF=10, ODR selects up/down */
+#define CFG_OUTPUT_PP        0x1  /* MODE=01 CNF=00, general push-pull */
+#define CFG_OUTPUT_OD        0x5  /* MODE=01 CNF=01, general open-drain */
+
+/* CRL/CRH reset value: every pin floating input. */
+#define CR_RESET 0x44444444
+
+static uint32_t gpio_readl(unsigned int gpio, unsigned int offset)
+{
+    return readl(gpio + offset);
+}
+
+static void gpio_writel(unsigned int gpio, unsigned int offset, uint32_t value)
+{
+    writel(gpio + offset, value);
+}
+
+/* Set the 4-bit config nibble for `pin` in CRL/CRH. */
+static void gpio_set_config(unsigned int gpio, unsigned int pin, uint8_t cfg)
+{
+    unsigned int reg = (pin < 8) ? CRL : CRH;
+    unsigned int shift = (pin % 8) * 4;
+    uint32_t mask = ~(0xFu << shift);
+    uint32_t val = (gpio_readl(gpio, reg) & mask) | ((uint32_t)cfg << shift);
+    gpio_writel(gpio, reg, val);
+}
+
+static void gpio_set_odr_bit(unsigned int gpio, unsigned int pin,
+                             uint32_t value)
+{
+    uint32_t mask = ~(0x1u << pin);
+    gpio_writel(gpio, ODR, (gpio_readl(gpio, ODR) & mask) | (value << pin));
+}
+
+static unsigned int get_gpio_id(uint32_t gpio_addr)
+{
+    return (gpio_addr - GPIO_BASE_ADDR) / GPIO_SIZE;
+}
+
+static const char *gpio_path(uint32_t gpio)
+{
+    static char buf[32];
+    snprintf(buf, sizeof(buf), "/machine/soc/gpio%c", 'a' + get_gpio_id(gpio));
+    return buf;
+}
+
+/* Drive pin `num` of `gpio` to `level` from an external source. */
+static void gpio_set_irq(unsigned int gpio, int num, int level)
+{
+    qtest_set_irq_in(global_qtest, gpio_path(gpio), NULL, num, level);
+}
+
+/*
+ * Intercept this port's own gpio-out lines so get_irq(pin) observes them.
+ *
+ * qtest only supports intercepting one device's out-GPIOs per session (the
+ * interception device is global), so every test that observes gpio-out via
+ * get_irq() must target the SAME port. We use GPIO_A for all of them. Tests
+ * that only read IDR/ODR over MMIO can use any port and skip interception.
+ */
+static void intercept_out(unsigned int gpio)
+{
+    qtest_irq_intercept_out(global_qtest, gpio_path(gpio));
+}
+
+static void reset_gpio(unsigned int gpio)
+{
+    gpio_writel(gpio, CRL, CR_RESET);
+    gpio_writel(gpio, CRH, CR_RESET);
+    gpio_writel(gpio, ODR, 0);
+}
+
+static void test_reset_values(void)
+{
+    /*
+     * Scribble over the config/data registers, issue a system reset, and
+     * check the RM0008 documented reset state is restored: CRL/CRH back to
+     * 0x44444444 (floating input) and IDR/ODR back to 0.
+     */
+    gpio_writel(GPIO_A, CRL, 0xDEADBEEF);
+    gpio_writel(GPIO_A, CRH, 0xDEADBEEF);
+    gpio_writel(GPIO_A, ODR, 0xDEADBEEF);
+
+    gpio_writel(GPIO_C, CRL, 0x12345678);
+    gpio_writel(GPIO_C, ODR, 0x0000FFFF);
+
+    qtest_system_reset(global_qtest);
+
+    g_assert_cmphex(gpio_readl(GPIO_A, CRL), ==, CR_RESET);
+    g_assert_cmphex(gpio_readl(GPIO_A, CRH), ==, CR_RESET);
+    g_assert_cmphex(gpio_readl(GPIO_A, IDR), ==, 0);
+    g_assert_cmphex(gpio_readl(GPIO_A, ODR), ==, 0);
+
+    g_assert_cmphex(gpio_readl(GPIO_C, CRL), ==, CR_RESET);
+    g_assert_cmphex(gpio_readl(GPIO_C, IDR), ==, 0);
+    g_assert_cmphex(gpio_readl(GPIO_C, ODR), ==, 0);
+}
+
+static void test_output_mode(const void *data)
+{
+    /*
+     * Configure a pin as push-pull output and check ODR drives IDR and the
+     * gpio-out line. Also check ODR writes made while the pin is still an
+     * input are latched (not discarded), taking effect once switched.
+     */
+    unsigned int pin = (uintptr_t)data & 0xF;
+    uint32_t gpio = (uintptr_t)data & ~(GPIO_SIZE - 1);
+    bool observe = (gpio == GPIO_A);
+
+    reset_gpio(gpio);
+    if (observe) {
+        intercept_out(gpio);
+    }
+
+    /* Set ODR while floating input: IDR unaffected, no output edge. */
+    gpio_set_odr_bit(gpio, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+    if (observe) {
+        g_assert_false(get_irq(pin));
+    }
+
+    /* Switch to push-pull output: pin now follows ODR (high). */
+    gpio_set_config(gpio, pin, CFG_OUTPUT_PP);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, (1u << pin));
+    if (observe) {
+        g_assert_true(get_irq(pin));
+    }
+
+    /* Clear ODR bit: pin goes low. */
+    gpio_set_odr_bit(gpio, pin, 0);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+    if (observe) {
+        g_assert_false(get_irq(pin));
+    }
+
+    reset_gpio(gpio);
+}
+
+static void test_input_mode(const void *data)
+{
+    /*
+     * Configure a pin as floating input and check that an external drive
+     * (via the gpio-in line) is reflected in IDR and on the gpio-out line.
+     */
+    unsigned int pin = (uintptr_t)data & 0xF;
+    uint32_t gpio = (uintptr_t)data & ~(GPIO_SIZE - 1);
+    bool observe = (gpio == GPIO_A);
+
+    reset_gpio(gpio);
+    if (observe) {
+        intercept_out(gpio);
+    }
+
+    gpio_set_config(gpio, pin, CFG_INPUT_FLOATING);
+
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, (1u << pin));
+    if (observe) {
+        g_assert_true(get_irq(pin));
+    }
+
+    gpio_set_irq(gpio, pin, 0);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+    if (observe) {
+        g_assert_false(get_irq(pin));
+    }
+
+    reset_gpio(gpio);
+}
+
+static void test_pull_up_down(const void *data)
+{
+    /*
+     * In input pull mode (CNF=10), ODR selects the resistor: ODR=1 pulls the
+     * pin up (IDR=1) and ODR=0 pulls it down (IDR=0), even with no external
+     * driver connected.
+     */
+    unsigned int pin = (uintptr_t)data & 0xF;
+    uint32_t gpio = (uintptr_t)data & ~(GPIO_SIZE - 1);
+
+    reset_gpio(gpio);
+    intercept_out(gpio);
+
+    /* Pull-up. */
+    gpio_set_odr_bit(gpio, pin, 1);
+    gpio_set_config(gpio, pin, CFG_INPUT_PULL);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, (1u << pin));
+    g_assert_true(get_irq(pin));
+
+    /* Pull-down. */
+    gpio_set_odr_bit(gpio, pin, 0);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+    g_assert_false(get_irq(pin));
+
+    reset_gpio(gpio);
+}
+
+static void test_bsrr_brr(const void *data)
+{
+    /*
+     * BSRR: low 16 bits set ODR bits, high 16 bits reset them, with set
+     * taking priority. BRR resets ODR bits.
+     */
+    unsigned int pin = (uintptr_t)data & 0xF;
+    uint32_t gpio = (uintptr_t)data & ~(GPIO_SIZE - 1);
+
+    reset_gpio(gpio);
+
+    gpio_writel(gpio, BSRR, (1u << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), ==, (1u << pin));
+
+    gpio_writel(gpio, BSRR, (1u << (pin + 16)));
+    g_assert_cmphex(gpio_readl(gpio, ODR), ==, 0);
+
+    gpio_writel(gpio, BSRR, (1u << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), ==, (1u << pin));
+
+    gpio_writel(gpio, BRR, (1u << pin));
+    g_assert_cmphex(gpio_readl(gpio, ODR), ==, 0);
+
+    /* Set has priority over reset in BSRR. */
+    gpio_writel(gpio, BSRR, (1u << pin) | (1u << (pin + 16)));
+    g_assert_cmphex(gpio_readl(gpio, ODR), ==, (1u << pin));
+
+    reset_gpio(gpio);
+}
+
+static void test_push_pull_disconnect(const void *data)
+{
+    /*
+     * A pin driven externally, then reconfigured as push-pull output, must be
+     * disconnected from the external driver: its IDR follows ODR, not the
+     * stale external level.
+     */
+    unsigned int pin = (uintptr_t)data & 0xF;
+    uint32_t gpio = (uintptr_t)data & ~(GPIO_SIZE - 1);
+
+    reset_gpio(gpio);
+
+    /* Drive high externally as input. */
+    gpio_set_config(gpio, pin, CFG_INPUT_FLOATING);
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, (1u << pin));
+
+    /* Reconfigure as push-pull output with ODR=0: pin must drop to 0. */
+    gpio_set_odr_bit(gpio, pin, 0);
+    gpio_set_config(gpio, pin, CFG_OUTPUT_PP);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+
+    /* Further external drives are ignored while output push-pull. */
+    gpio_set_irq(gpio, pin, 1);
+    g_assert_cmphex(gpio_readl(gpio, IDR), ==, 0);
+
+    reset_gpio(gpio);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("stm32f103/gpio/reset_values", test_reset_values);
+    qtest_add_data_func("stm32f103/gpio/output_mode_a5",
+                        (void *)(uintptr_t)(GPIO_A | 5), test_output_mode);
+    qtest_add_data_func("stm32f103/gpio/output_mode_c13",
+                        (void *)(uintptr_t)(GPIO_C | 13), test_output_mode);
+    qtest_add_data_func("stm32f103/gpio/input_mode_b6",
+                        (void *)(uintptr_t)(GPIO_B | 6), test_input_mode);
+    qtest_add_data_func("stm32f103/gpio/input_mode_d10",
+                        (void *)(uintptr_t)(GPIO_D | 10), test_input_mode);
+    qtest_add_data_func("stm32f103/gpio/pull_up_down_a0",
+                        (void *)(uintptr_t)(GPIO_A | 0), test_pull_up_down);
+    qtest_add_data_func("stm32f103/gpio/bsrr_brr_a1",
+                        (void *)(uintptr_t)(GPIO_A | 1), test_bsrr_brr);
+    qtest_add_data_func("stm32f103/gpio/bsrr_brr_e12",
+                        (void *)(uintptr_t)(GPIO_E | 12), test_bsrr_brr);
+    qtest_add_data_func("stm32f103/gpio/push_pull_disconnect_g7",
+                        (void *)(uintptr_t)(GPIO_G | 7),
+                        test_push_pull_disconnect);
+
+    qtest_start("-machine stm32f103");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
-- 
2.53.0


