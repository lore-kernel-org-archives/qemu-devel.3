Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0ABC88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5omM-0005kF-VS; Sun, 13 Sep 2026 14:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x5omF-0005jF-Qp
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:18:08 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x5omC-00023X-QN
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:18:07 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a49a40209dso18314701fa.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789323483; x=1789928283; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=037ghbzE2bPvmnmyrmQ1l6ZIMGVWV/tkoAnyS7laa2Q=;
 b=sotV4Q3d4iUIyVAyX7fuTSbzpNK2uQ4qhkLBxTWtCRDou8EM5LkEGENFij40ZNa+CY
 rhrVE/XDAJugnHW/kTUmoTO6yUu4VMAONVWKOvaTHPKQkVpJ0PYts2uGpbTAnJKSilYP
 duVPobKA20DzVMBIG5EbKiin9UXtcUxi0bQ8Nq7B6+8PU9IU3rzD2cZP0gMqcbnghTG8
 qJt0K4r+bhBExObSK8G4tnPSWfFvarQYAdJfMUjoD12tAt7NUbVIx6GCGWQ3NkCmH0bz
 zBZQQfTovefGMn/BWev3vxRIm2eY3/t/Z9Abm05HaF+oiLeSfipeRMxnqUB2oqB6hEGj
 PPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789323483; x=1789928283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=037ghbzE2bPvmnmyrmQ1l6ZIMGVWV/tkoAnyS7laa2Q=;
 b=Er/Lt1qXmFwBnSzwzI6qTm2sdLqG9zWpXo7FmWP8/dbanZP3irdf8Og0qCL0VG4Tbr
 Z4FinKKmi6MWpyVnu80XTuR+7tAI8A09EbtnTy+uQwW34Hhdbfyv0KXtZemLHsrAP55P
 cuExH5c/Hac6pLfDvRIIhpBcFOVhp1+4mTv3kvVGWMCX/VdAGyQne9XhhKUOpUM+fhJI
 DMf+rexyxSMW1wa4o8Qx4QHEF1kbF+507xHp702TIlefr99lPKxTwASVyWfAV0vrislJ
 ei4XiaF1q2hvpNA/ePZf9pAgXI6SOHSkEb+aN98FmC5/vPZjRzgIjtTtSijBk2HNUqkC
 lO3g==
X-Gm-Message-State: AFuF++mOwBI5eHVePw5KXicNfYGIEYRDOH5uF78Y4NwDjCjny8NxAC12
 Rr9ntPB781dUcFewB2r570pDeAxMdlW07JWej0QFW7mshGksBNjCWVUKYJqVOabguKU=
X-Gm-Gg: AYBFou17cuxbHL+AfrNL4LUliOYyfkQfhtnV2RF9bqCDJPXwyVNpK+v+1IGZdmU3WIH
 qgMMxx0/O3ELg8rZgR2bo7BlryPiwfv3r2seIKwue3t/Ec6sNfufm8I4M4wtV1kt+9pk7AtAOSZ
 1XQkWVv2f5LPdxfT0RCsGAWa01+YY3efzPBy25izPGtN1Q1+aalY0eJNsEJcVTNhtM7wqIHSkQa
 aiYoe+ffZ5KvCO+DorFjZcXNJQU35yn1ChLFgLupcMRJQZFuoXn3zZhavW137jeywYemSVUn/pZ
 SmT5mMeWonJok2lMl9X3sxWl4HieCe/X5ccLrFn+488Dhvts3rqWBKq+PuH2IYbofCyF6ahJ5yd
 rBa1gRyYCy+zYGt8ER9/8Kz1tmublMoKrpvJGMcOFzxvekSPNSxcSQ/VwdjABcGx2UGKGcm7Jd5
 w5FOXJzon/JFIZS7ltkAjiRBolizWd5OR5vPvgMBR0SJLzsqg/UkKF1ygmgeGoFL8M4N0vzyy9P
 sTJIrw3pTADY5njRRVUdQMGOer89Ha8HNL2c4dygzbU2e9S+lA82oSqwwKGEo9CIgeAeA==
X-Received: by 2002:a2e:bc89:0:b0:3a4:759f:e2c2 with SMTP id
 38308e7fff4ca-3a5be1098eemr3759511fa.2.1789323482411; 
 Sun, 13 Sep 2026 11:18:02 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a3326aecsm21122951fa.19.2026.09.13.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:18:00 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Sun, 13 Sep 2026 20:17:32 +0200
Subject: [PATCH v3 3/3] tests/qtest: Allwinner GPIO tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-allwinner-gpio-v3-3-a9affa474b3b@gmail.com>
References: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
In-Reply-To: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Jack wang <163wangjack@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add Allwinner GPIO set of qtests to validate functionality.
Tests cover input and output port setting, as well as interrupt
functionality.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 MAINTAINERS                       |   1 +
 tests/qtest/allwinner-gpio-test.c | 535 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   3 +-
 3 files changed, 538 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b453edc820..da6b588eca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -749,6 +749,7 @@ F: hw/misc/axp2xx.c
 F: hw/gpio/allwinner-gpio.c
 F: include/hw/gpio/allwinner-gpio*
 F: tests/functional/arm/test_cubieboard.py
+F: tests/qtest/allwinner-gpio-test.c
 
 Allwinner-h3
 M: Niek Linnenbank <nieklinnenbank@gmail.com>
diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
new file mode 100644
index 0000000000..c048f0f88b
--- /dev/null
+++ b/tests/qtest/allwinner-gpio-test.c
@@ -0,0 +1,535 @@
+/*
+ *  Allwinner GPIO Tests
+ *
+ *  Copyright (C) 2026 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest-single.h"
+
+#include "include/hw/gpio/allwinner-gpio-regs.h"
+
+#define AW_A10_GPIO_BASE 0x01c20800
+#define AW_A10_IRQ_LINE 28
+
+/* Port n configure register 0 */
+#define GPIO_Pn_CFG0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG0(n))
+/* Port n configure register 1 */
+#define GPIO_Pn_CFG1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG1(n))
+/* Port n configure register 2 */
+#define GPIO_Pn_CFG2_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG2(n))
+/* Port n configure register 3 */
+#define GPIO_Pn_CFG3_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_CFG3(n))
+/* Port n data register */
+#define GPIO_Pn_DAT_ADDR(n)    (AW_A10_GPIO_BASE + GPIO_Pn_DAT(n))
+/* Port n Multi-driving register 0 */
+#define GPIO_Pn_DRV0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_DRV0(n))
+/* Port n Multi-driving register 1 */
+#define GPIO_Pn_DRV1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_DRV1(n))
+/* Port n Pull register 0 */
+#define GPIO_Pn_PUL0_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_PUL0(n))
+/* Port n Pull register 1 */
+#define GPIO_Pn_PUL1_ADDR(n)   (AW_A10_GPIO_BASE + GPIO_Pn_PUL1(n))
+/* PIO interrupt configure register 0 */
+#define GPIO_INT_CFG0_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG0)
+/* PIO interrupt configure register 1 */
+#define GPIO_INT_CFG1_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG1)
+/* PIO interrupt configure register 2 */
+#define GPIO_INT_CFG2_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG2)
+/* PIO interrupt configure register 3 */
+#define GPIO_INT_CFG3_ADDR     (AW_A10_GPIO_BASE + GPIO_INT_CFG3)
+/* PIO interrupt control register */
+#define GPIO_INT_CTL_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_CTL)
+/* PIO interrupt status register */
+#define GPIO_INT_STA_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_STA)
+/* PIO interrupt debounce register */
+#define GPIO_INT_DEB_ADDR      (AW_A10_GPIO_BASE + GPIO_INT_DEB)
+/* SDRAM Pad Multi-driving register */
+#define SDR_PAD_DRV_ADDR       (AW_A10_GPIO_BASE + SDR_PAD_DRV)
+/* SDRAM Pad Pull register */
+#define SDR_PAD_PUL_ADDR       (AW_A10_GPIO_BASE + SDR_PAD_PUL)
+
+static inline uint32_t read_cfg_addr(QTestState *s, int port, int pin)
+{
+    uint32_t addr = 0;
+
+    if (pin >= 24) {
+        addr = GPIO_Pn_CFG3_ADDR(port);
+    } else if (pin >= 16) {
+        addr = GPIO_Pn_CFG2_ADDR(port);
+    } else if (pin >= 8) {
+        addr = GPIO_Pn_CFG1_ADDR(port);
+    } else {
+        addr = GPIO_Pn_CFG0_ADDR(port);
+    }
+    return addr;
+}
+
+static inline uint32_t read_int_cfg_addr(QTestState *s, int irq)
+{
+    uint32_t addr = 0;
+
+    if (irq >= 24) {
+        addr = GPIO_INT_CFG3_ADDR;
+    } else if (irq >= 16) {
+        addr = GPIO_INT_CFG2_ADDR;
+    } else if (irq >= 8) {
+        addr = GPIO_INT_CFG1_ADDR;
+    } else {
+        addr = GPIO_INT_CFG0_ADDR;
+    }
+    return addr;
+}
+
+static void update_cfg_reg(QTestState *s, int port, int pin, AWGPIOCfg val)
+{
+    uint32_t addr = read_cfg_addr(s, port, pin);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+
+    cfg = deposit32(cfg, offset, CFG_PIN_STRIDE - 1, val);
+    qtest_writel(s, addr, cfg);
+}
+
+static void assert_cfg_regval(QTestState *s, int port, int pin,
+                              AWGPIOCfg pin_choice)
+{
+    uint32_t addr = read_cfg_addr(s, port, pin);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+
+    g_assert_cmphex(extract32(cfg,
+                              offset, CFG_PIN_STRIDE - 1), ==, pin_choice);
+}
+
+static void update_data_reg(QTestState *s, int port, int pin, int val)
+{
+    uint32_t addr = GPIO_Pn_DAT_ADDR(port);
+    uint32_t data = qtest_readl(s, addr);
+
+    data = deposit32(data, pin, 1, val);
+    qtest_writel(s, addr, data);
+}
+
+static void assert_data_reg(QTestState *s, int port, int pin, int val)
+{
+    uint32_t addr = GPIO_Pn_DAT_ADDR(port);
+    uint32_t data = qtest_readl(s, addr);
+
+    g_assert_cmphex(extract32(data, pin, 1), ==, val);
+}
+
+static void update_int_cfg_reg(QTestState *s, int irq, AWGPIOIrqCfg val)
+{
+    uint32_t addr = read_int_cfg_addr(s, irq);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (irq % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE;
+
+    cfg = deposit32(cfg, offset, INT_CFG_IRQ_STRIDE - 1, val);
+    qtest_writel(s, addr, cfg);
+}
+
+static void assert_int_cfg_regval(QTestState *s, int irq, AWGPIOIrqCfg irq_cfg)
+{
+    uint32_t addr = read_int_cfg_addr(s, irq);
+    uint32_t cfg = qtest_readl(s, addr);
+    uint32_t offset = (irq % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE;
+
+    g_assert_cmphex(extract32(cfg,
+                              offset, INT_CFG_IRQ_STRIDE - 1), ==, irq_cfg);
+}
+
+static void test_reset_values(void)
+{
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    for (int port = 0; port < AW_GPIO_PORTS_NUM; port++) {
+        g_assert_cmphex(qtest_readl(s,
+                                    GPIO_Pn_DRV0_ADDR(port)), ==,
+                                    aw_gpio_port_reset[port].drv[0]);
+        g_assert_cmphex(qtest_readl(s,
+                                    GPIO_Pn_DRV1_ADDR(port)), ==,
+                                    aw_gpio_port_reset[port].drv[1]);
+        g_assert_cmphex(qtest_readl(s,
+                                    GPIO_Pn_PUL0_ADDR(port)), ==,
+                                    aw_gpio_port_reset[port].pul[0]);
+        g_assert_cmphex(qtest_readl(s,
+                                    GPIO_Pn_PUL1_ADDR(port)), ==,
+                                    aw_gpio_port_reset[port].pul[1]);
+    }
+
+    qtest_quit(s);
+}
+
+typedef struct {
+    int port;
+    int pin;
+} PortPinTestParam;
+
+const PortPinTestParam in_out_test_parameters[] = {
+    { GPIO_PA, 0 },
+    { GPIO_PA, 17 },
+    { GPIO_PB, 19 },
+    { GPIO_PC, 23 },
+    { GPIO_PD, 26 },
+    { GPIO_PE, 11 },
+    { GPIO_PF, 5 },
+    { GPIO_PG, 10 },
+    { GPIO_PH, 16 },
+    { GPIO_PI, 21 },
+};
+
+const PortPinTestParam irq_test_parameters[] = {
+    { GPIO_PH, 1 },
+    { GPIO_PH, 10 },
+    { GPIO_PH, 21 },
+    { GPIO_PI, 10 },
+    { GPIO_PI, 19 },
+};
+
+/* Set pin to output, check that it propagates */
+static void test_set_output_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *out_name = portname_out(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+    qtest_irq_intercept_out_named(s, "/machine/soc/gpio", out_name);
+
+    /* Configure pin as output */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_OUT);
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+
+    /* Check that the output pin is high */
+    g_assert_true(qtest_get_irq(s, param->pin));
+
+    /* Cleanup */
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_LOW);
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+
+    qtest_quit(s);
+}
+
+/*
+ * Set pin to input, check that the value is written but it does not propagate
+ */
+static void test_set_input_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *out_name = portname_out(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    qtest_irq_intercept_out_named(s, "/machine/soc/gpio", out_name);
+
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+    /* Set value in register */
+    update_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+    /* Check that the output pin is still low */
+    g_assert_false(qtest_get_irq(s, param->pin));
+
+    qtest_quit(s);
+}
+
+/* Test rising edge interrupt */
+static void test_irq_pin_rising(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test falling edge interrupt */
+static void test_irq_pin_falling(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_FALLING_EDGE);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_FALLING_EDGE);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test high level interrupt */
+static void test_irq_pin_high_level(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_HIGH_LEVEL);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_HIGH_LEVEL);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Try clearing interrupt, it should still be asserted */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Set line low and clear interrupt, it should be cleared now */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test low level interrupt */
+static void test_irq_pin_low_level(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_LOW_LEVEL);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_LOW_LEVEL);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Try clearing interrupt, it should still be asserted */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Set line high and clear interrupt, it should be cleared now */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+/* Test both edge interrupt */
+static void test_irq_pin_both_edge(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    QTestState *s = qtest_init("-machine cubieboard");
+    const int gpio_port = param->port;
+    const int port_pin = param->pin;
+    g_autofree char *in_name = portname_in(gpio_port);
+    int irq_pin = irq_nr(gpio_port, port_pin);
+    unsigned int irq_mask = 1u << irq_pin;
+
+    qtest_irq_intercept_in(s, "/machine/soc");
+
+    /* Configure as input and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+
+    /* Enable interrupt */
+    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_BOTH_EDGE);
+    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_BOTH_EDGE);
+    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
+
+    /* Raise interrupt - rising edge */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_HIGH);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Raise interrupt - falling edge */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, port_pin,
+                     AW_GPIO_LEVEL_LOW);
+    /* Check that value is written */
+    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_LOW);
+    /* Check interrupt status */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
+    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    /* Clear interrupt */
+    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
+
+    /* Check that IRQ line is low */
+    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
+    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
+
+    qtest_quit(s);
+}
+
+
+static void add_test(const char *type, const PortPinTestParam *p,
+                      void (*testfn)(const void *))
+{
+    g_autofree char *name =
+        g_strdup_printf("/allwinner-cubieboard/gpio/%s/%s%d",
+                        type, portname(p->port), p->pin);
+
+    qtest_add_data_func(name, p, testfn);
+}
+
+
+int main(int argc, char **argv)
+{
+    int r;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (int i = 0; i < ARRAY_SIZE(in_out_test_parameters); i++) {
+        const PortPinTestParam *p = &in_out_test_parameters[i];
+        add_test("set_output_pins", p, test_set_output_pins);
+        add_test("set_input_pins", p, test_set_input_pins);
+    }
+    qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
+                        test_reset_values);
+    for (int i = 0; i < ARRAY_SIZE(irq_test_parameters); i++) {
+        const PortPinTestParam *p = &irq_test_parameters[i];
+        add_test("irq_pin_rising", p, test_irq_pin_rising);
+        add_test("irq_pin_falling", p, test_irq_pin_falling);
+        add_test("irq_pin_high_level", p, test_irq_pin_high_level);
+        add_test("irq_pin_low_level", p, test_irq_pin_low_level);
+        add_test("irq_pin_both_edge", p, test_irq_pin_both_edge);
+    }
+    r = g_test_run();
+
+    return r;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..6c5db1a0a3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -268,7 +268,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test']
+   'boot-serial-test'] + \
+  (config_all_devices.has_key('CONFIG_ALLWINNER_A10')? ['allwinner-gpio-test'] : [])
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \

-- 
2.55.0


