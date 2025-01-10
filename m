Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7721E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTn-0007ej-Be; Fri, 10 Jan 2025 11:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHT7-0007Jz-EC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHT1-0004Gt-PE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1996825f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524953; x=1737129753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qvogJW6MPYSZINAUIbPGEHr3cB+ZObTGCx80VbT3Tk=;
 b=NnhSJ4EFig71wywsBS1snCL2T8O6j3sCtHsLAs2zPd44Q/3imGPzQqIUEvyYdwwsty
 snsrffJ54wIkptJn+l2Qp6mY+thQysj6yBDt0o3F7tgd80PnU6PnEUuFh6yo3ZP+0prh
 IAWf9TCHcUGAZpzT2HR3JIMK+OWoDbGlFP5LOdp7WoA/Hmu5ohNnz5wYEoqUy5BJpWp2
 YvIJe4HZ8MHcr1OEf0yjHuGNDXaYKaMMlqi7tOwza4XSjlBaCgRi+9mmgtcoITgbKEW6
 JZGPvBMbdqqwb7xYeTLqnGOwR8MVEHneyVe8ImwPvXcUyiIYRj9Vm5D0j5vp3d0YK+eY
 mvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524953; x=1737129753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qvogJW6MPYSZINAUIbPGEHr3cB+ZObTGCx80VbT3Tk=;
 b=SfWWY9T5F0jEz6awJk3ocb6uwk/iqhAi0bmm4m37WM3tach9VnxsfXFqFEtAfKhLka
 RkFG8Ry+i1IxcyulhGw4ny4uAzV7TUTkFu24jMscJqhI0IY1vk2dmeAIC1SpMVx5oP8r
 y6AZXDBdQPWcXU82wZUg03+St9aXaxC0vYvV77122rdMhSYPea0t0D6eO5bNSIC0Ygr1
 y+wk1qU2c6ySqmn7wyeqNNQpp9aP1BboKnHD0XbQwq92ERxKl9IJMNAegOJGiGpJpMMy
 FTOJ0cf8+O4HcgKJqa+YaP3WUbeNrltHCYeDfcP+nOTenDld1OOUyxf9g4xgoffYjCMn
 BEkw==
X-Gm-Message-State: AOJu0YwPKXd3/ohZlcpk+FfqY+8m8fdoEUpzaDIjVP0poHtN3wvud8sO
 gedAh844hUNpf0+fieY6IKV36s/XywXWZZPTrzI1SvijDD1q9jVOP0YwqH0Fl7PwnTFrl0w643x
 p3IM=
X-Gm-Gg: ASbGnctb6S3PriyP+1IHY/6fQxxiP1jDa1/UjqCeW6nn+O2AYm4k9STlYJ9bKCXtfFn
 9EHmqOm+TrIxou0UjIhb9r0IPRSAUqxpPUtzvTQaTqnsv+34fmoBhWBfl1AUHhJZIKWc9l0vsD2
 RH7hKiMuCNeqxeubCzO/2gbpscamJegcOSfKJ7du5bYmYg9fUf4jjgZ14Rkndsyua9ysDU1JK62
 +5b2p+z6qkUchwuSYayIVxDUophMAsR03Ch8jv+i9rHiaXUm7Zv7PNP87uixIVMStQ4AjI4TxaX
 Jw/ncpdtdaqvDW/2U7Y85gDe8EDi7Bs=
X-Google-Smtp-Source: AGHT+IHuztzhqGtmmeM1XGjh9TiI0/vDk3b5gDotVJ2PP6qf4KBmalLz51QcajGqVyETGDfJiRISfQ==
X-Received: by 2002:a5d:5f44:0:b0:385:fa33:29ed with SMTP id
 ffacd0b85a97d-38a8730fa63mr9349216f8f.47.1736524949045; 
 Fri, 10 Jan 2025 08:02:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66e6sm91520325e9.4.2025.01.10.08.02.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] hw/arm/stellaris: Use DEVCAP macro to access
 DeviceCapability registers
Date: Fri, 10 Jan 2025 17:02:00 +0100
Message-ID: <20250110160204.74997-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Add definitions (DCx_periph) for the DeviceCapability bits,
replace direct bitmask checks with the DEV_CAP() macro,
which use the extract/deposit API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b4c3412c490..64e6797553a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "hw/core/split-irq.h"
 #include "hw/sysbus.h"
@@ -54,6 +55,26 @@
 #define NUM_GPTM    4
 #define NUM_I2C     2
 
+/*
+ * See Stellaris Data Sheet chapter 5.2.5 "System Control",
+ * Register 13 .. 17: Device Capabilities 0 .. 4 (DC0 .. DC4).
+ */
+#define DC1_WDT          3
+#define DC1_HIB          6
+#define DC1_MPU          7
+#define DC1_ADC          16
+#define DC1_PWM          20
+#define DC2_UART(n)     (n)
+#define DC2_SSI          4
+#define DC2_QEI(n)      (8 + n)
+#define DC2_I2C(n)      (12 + 2 * n)
+#define DC2_GPTM(n)     (16 + n)
+#define DC2_COMP(n)     (24 + n)
+#define DC4_GPIO(n)     (n)
+#define DC4_EMAC         28
+
+#define DEV_CAP(_dc, _cap) extract32(board->dc##_dc, DC##_dc##_##_cap, 1)
+
 typedef const struct {
     const char *name;
     uint32_t did0;
@@ -1117,7 +1138,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_mmio_map(SYS_BUS_DEVICE(ssys_dev), 0, 0x400fe000);
     sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvic, 28));
 
-    if (board->dc1 & (1 << 16)) {
+    if (DEV_CAP(1, ADC)) {
         dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
                                     qdev_get_gpio_in(nvic, 15),
@@ -1129,7 +1150,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         adc = NULL;
     }
     for (i = 0; i < NUM_GPTM; i++) {
-        if (board->dc2 & (0x10000 << i)) {
+        if (DEV_CAP(2, GPTM(i))) {
             SysBusDevice *sbd;
 
             dev = qdev_new(TYPE_STELLARIS_GPTM);
@@ -1146,7 +1167,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    if (board->dc1 & (1 << 3)) { /* watchdog present */
+    if (DEV_CAP(1, WDT)) {
         dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
         object_property_add_child(soc_container, "wdg", OBJECT(dev));
         qdev_connect_clock_in(dev, "WDOGCLK",
@@ -1163,7 +1184,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
 
     for (i = 0; i < NUM_GPIO; i++) {
-        if (board->dc4 & (1 << i)) {
+        if (DEV_CAP(4, GPIO(i))) {
             gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
                                                                 gpio_irq[i]));
@@ -1174,7 +1195,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    if (board->dc2 & (1 << 12)) {
+    if (DEV_CAP(2, I2C(0))) {
         dev = sysbus_create_simple(TYPE_STELLARIS_I2C, 0x40020000,
                                    qdev_get_gpio_in(nvic, 8));
         i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
@@ -1184,7 +1205,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
     for (i = 0; i < NUM_UART; i++) {
-        if (board->dc2 & (1 << i)) {
+        if (DEV_CAP(2, UART(i))) {
             SysBusDevice *sbd;
 
             dev = qdev_new("pl011_luminary");
@@ -1196,7 +1217,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, uart_irq[i]));
         }
     }
-    if (board->dc2 & (1 << 4)) {
+    if (DEV_CAP(2, SSI)) {
         dev = sysbus_create_simple("pl022", 0x40008000,
                                    qdev_get_gpio_in(nvic, 7));
         if (board->peripherals & BP_OLED_SSI) {
@@ -1305,7 +1326,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             qemu_irq_raise(gpio_out[GPIO_D][0]);
         }
     }
-    if (board->dc4 & (1 << 28)) {
+    if (DEV_CAP(4, EMAC)) {
         DeviceState *enet;
 
         enet = qdev_new("stellaris_enet");
-- 
2.47.1


