Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vQTYcklx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3I-0003J4-HA; Fri, 23 Oct 2026 10:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3E-0003Hi-IJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3C-0006ZM-I2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so6008195e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764915; x=1793369715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nMZCAfOiai7Ly46dhWrHulyOMP97F/Q502GP+Kb+6S0=;
 b=vQTYcklxa6h81wsjdQmQUdPUZ+6cKqSwvVZ0r5DbbpZeTyL0vwv7e5JLmq0fj/rVma
 vLey2ZqChFi39DyyJPaa2HdEkviKUWFKBDDGb9dC02xoS7qQH5vUYz5ancJxditC9Jnu
 nPeR7yT+YVLZjV54CLq50dOffqsogPQSmv0YCi0fKVrmNKn4KKtbmBPIat0Ig/hiU5Hf
 mxGkth3FQC8ZKOSJFyOBVEgy4i42I14lmbPjSI+gAm66YINCMTw8zvCbmzliq9ZsuX0S
 vW+TQAHHzDXYnAI4tr0ZtbW329i1BST+EmA9W2VlqBmgZlduLajWXr7Qs13J8TqyDIZe
 zG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764915; x=1793369715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nMZCAfOiai7Ly46dhWrHulyOMP97F/Q502GP+Kb+6S0=;
 b=AyY3ZgwTnrzFvDWwjNbo86xV4992flBC5PEkLj04ayY+9G30PcMBLKMFgbTBlDmPzK
 B8AzjsuV643muJWgRdhfn/28RA/xtX5yRXb7e35uFPnq5A25FjAIqZl4vmdpkYR+u9gy
 RFmVnxUY5pKzI/lPYR4qLVL822MpKdJ/Dido9D4tOqXSUYVIWLXonPFibJebsRGxQ6N4
 MMdh1Cz8YdZbJuu8hMpxK4wstcGrMDpfej4U24YGGs6qKyCdN3Hy0z0EWX6JYd99ZSa4
 WsfBczEP8uUZxGcOq5+pNAIKL/+VW0jsbukNwF3paVFT+rn4sgjXEBQGIl1DARyUEZCF
 RS8w==
X-Gm-Message-State: AFq9FYIhxyxM/nYB2ESCXzhkXRBFUJYZGgmgTA3RWXiBAcU0eu0ZfiTJ
 4xetifXekT/0yTb6cWLNn0UuXoeuwcqThb0p5T35VNpqwdNwbrk/4yAguYd5H09GzEMBwmvp8ou
 PMKnEYYk=
X-Gm-Gg: AYBFou2uEktKnRUIAxzDVqmTxkFuxtkPolq7NyrsFe2mD18uKyx3Kk9zh6qzj416U7K
 CYRFNsIvrCpWk6OR2ThyFkFo8GVkizcmzvjtr/sBJ3x4gLK3xY4hRYi5WaxkLlwCqC0YO9eTmfN
 1tODLXbwE17TkKQm/anDIYxb0IkcPhCoy8OkGXzeYyJXwtVeoLnZdyQvoOadMzuhn9qO6fGFeOI
 WgrcJpQQbsj8teuF4BaIQrefq7UMmckZVSgDnZxAUZObwdD8klaAEmCGa9LzZO3jBmEPVDaCVVw
 lx7C2P0VWl+pgr4FzajDEt2MEEaP80PKUfwgfaetkVkLOaF/Rf/Hae/xF69XiM/o+UofnKaRXsT
 pN8mDm1PWNJ+OfLAR/PcxEA+huo144AaB7i6ajP2U0G3/F0K+XWqxfvgfoR8Be5WHRKDt5idNgu
 ISxc3bc1XH7RyRQNRycmjfSR9KyIn6Mj6gjfWRVXP7akJlCqJJDAIPP7LrJqMixlSh1sWoBRWMK
 reyEgmXaoHxLPI0Evng/x6ckpNIT5axYNsUcG+O/NJ5OZ3NzptK9X7PX3a4SWrJEWftLsSxqyDS
 YXsE6pBFCo3YWDCbCfhuM24t2WBl+VerIXFTy/YDVIVU2GLFpObG2Df4Sx1s
X-Received: by 2002:a05:600c:83ca:b0:4a2:e0c:2b10 with SMTP id
 5b1f17b1804b1-4a211ce3bc2mr39985915e9.19.1792764915275; 
 Fri, 23 Oct 2026 07:15:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] hw/gpio: Add EINT CFG to Allwinner GPIO,
 fix interrupt handling
Date: Fri, 23 Oct 2026 15:14:53 +0100
Message-ID: <20261023141503.1397009-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

The original Allwinner GPIO implementation assumed pin had to be
configured as input (CFG 0x0) in order to be able to handle interrupts
on interrupt-capable pins.
However, libgpiod configures those pins in EINT mode (CFG 0x06) when
gpiomon is used, so this patch fixes interrupt path to expect pin
configuration to be set to EINT.

Also update interrupt handling tests for the correct functionality.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20261017-allwinner-gpio-eint-v2-1-82906f440378@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/gpio/allwinner-gpio-regs.h |  5 +----
 hw/gpio/allwinner-gpio.c              | 19 ++++++++++++-----
 tests/qtest/allwinner-gpio-test.c     | 30 +++++++++++++--------------
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/hw/gpio/allwinner-gpio-regs.h b/include/hw/gpio/allwinner-gpio-regs.h
index a435b87ec49..5e969c23f62 100644
--- a/include/hw/gpio/allwinner-gpio-regs.h
+++ b/include/hw/gpio/allwinner-gpio-regs.h
@@ -73,9 +73,6 @@ static const AWPortResetVals aw_gpio_port_reset[] = {
 #define DEFAULT_DRV_MASK    0xffffffff
 #define DEFAULT_PUL_MASK    0xffffffff
 
-#define CFG_INPUT_MASK      0x0
-#define CFG_OUTPUT_MASK     0x1
-#define CFG_IO_MASK         0x1
 #define CFG_PIN_STRIDE      4
 #define CFG_PINS_PER_REG    (AW_GPIO_PIN_COUNT / CFG_PIN_STRIDE)
 
@@ -172,7 +169,7 @@ typedef enum AWGPIOLevel {
 typedef enum AWGPIOCfg {
     AW_GPIO_CFG_IN = 0,
     AW_GPIO_CFG_OUT = 1,
-    AW_GPIO_CFG_FUN = 2,
+    AW_GPIO_CFG_EINT = 6,
 } AWGPIOCfg;
 
 typedef enum AWGPIOIrqCfg {
diff --git a/hw/gpio/allwinner-gpio.c b/hw/gpio/allwinner-gpio.c
index e3bda7cb762..19176e7c56f 100644
--- a/hw/gpio/allwinner-gpio.c
+++ b/hw/gpio/allwinner-gpio.c
@@ -114,7 +114,7 @@ static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
     uint32_t cfg_n = pin / CFG_PINS_PER_REG;
     uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
     return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
-        CFG_OUTPUT_MASK);
+        AW_GPIO_CFG_OUT);
 }
 
 static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
@@ -122,7 +122,15 @@ static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
     uint32_t cfg_n = pin / CFG_PINS_PER_REG;
     uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
     return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
-        CFG_INPUT_MASK);
+        AW_GPIO_CFG_IN);
+}
+
+static inline bool gpio_is_eint(AWPortMap *port, uint32_t pin)
+{
+    uint32_t cfg_n = pin / CFG_PINS_PER_REG;
+    uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
+    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
+        AW_GPIO_CFG_EINT);
 }
 
 static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
@@ -155,8 +163,8 @@ static void allwinner_gpio_set_int_line(AWGPIOState *s, int port,
         return;
     }
 
-    /* if this signal isn't configured as an input signal, nothing to do */
-    if (!gpio_is_input(&o->ports[port], line)) {
+    /* if this signal isn't configured as an EINT, nothing to do */
+    if (!gpio_is_eint(&o->ports[port], line)) {
         return;
     }
 
@@ -225,7 +233,8 @@ static void allwinner_gpio_set(void *opaque, int port, int line, int level)
     AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
     AWGPIOLevel aw_level = level ? AW_GPIO_LEVEL_HIGH : AW_GPIO_LEVEL_LOW;
 
-    if (gpio_is_input(&o->ports[port], line)) {
+    if (gpio_is_input(&o->ports[port], line) ||
+        gpio_is_eint(&o->ports[port], line)) {
 
         trace_allwinner_gpio_set(portname(port), line, aw_level);
 
diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
index c048f0f88b9..7ad89f6e0a3 100644
--- a/tests/qtest/allwinner-gpio-test.c
+++ b/tests/qtest/allwinner-gpio-test.c
@@ -251,9 +251,9 @@ static void test_irq_pin_rising(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
@@ -296,9 +296,9 @@ static void test_irq_pin_falling(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin high */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_HIGH);
@@ -341,9 +341,9 @@ static void test_irq_pin_high_level(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
@@ -394,9 +394,9 @@ static void test_irq_pin_low_level(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin high */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_HIGH);
@@ -447,9 +447,9 @@ static void test_irq_pin_both_edge(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
-- 
2.43.0


