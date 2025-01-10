Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77BFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTo-0007hD-Ox; Fri, 10 Jan 2025 11:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHTM-0007O4-DW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:58 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHTG-0004Jp-4f
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso22097255e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524967; x=1737129767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNENegiBgeAyoUJg+Zncnjnk99h1QRf7b0Ia8CM8ZQ4=;
 b=SQQ7wfylJnaz8sjkErBRn+ygz+rmuOFXhr6fy+JbqyS8zeWz3M1DlmnS5gAFydfMbl
 5aMBmQlMEMk9g9LTSHX6q6Y0KiADMGSEnZkrqE4rcbBb/EQdtvjsLWJnK7tKjS5QRLlP
 yzGw8ol8MjdK+LW5QtNUcZ2DXmojs4RmKhgp8jLomUivbEOu/W+PDBSfQuUPFl5YN88s
 D6t0qwiEjKvdswK0zDLFQUioH45oJPrimc9lw+ybJoD3abDe5/wQ8xES9y6cFsxpD/of
 1QhMlp9u5AboWlpPuTw+v7zQCkfsGTfLNqLGK44U4Il9PcphceP3TkV4C7FwPtkI6k7K
 Pxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524967; x=1737129767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNENegiBgeAyoUJg+Zncnjnk99h1QRf7b0Ia8CM8ZQ4=;
 b=sIERS+zjv0cgwRL+t0SuXRG7wWhxrzV1lZVhjgocW8xl9R6XHk5BBWAReQQ71XU2UR
 jK/UzXu1x+C89dMaIXv1sdQat4z35xtp7HHrWBCFvRyRaZ5+Q2qvVVkecFORyh8LAq/7
 kdcbE0+QOMVT0h3uuU7DCAv9pIdpDCL+O2Y788u9Yu2nmCOQolxRxDPiKbTQgrL43Dai
 Cx2EF8m5Fkxkhf/MEody4vIe04NKKYbrF67SOq3HLGXlE8WZ+5UPAF8JfNTqtgMiVtZT
 fLaqvsHQNx7urFIycqOZQcnrh5CKyYHI3UwP23SnPD0Naj5isYgxY2IUmZGu/qLaDNvR
 6e6g==
X-Gm-Message-State: AOJu0YwcZ7d1u28dmvCSp8e9HJn8cDvgmlG3yRPTsVJXmQgc0WGdfPON
 SDyzy4Fag4XvPPaYL3V/ESHHPuBeGic+8cULUM40K6o5QhqkPn7zfnTC14Fox2jQvR34suB4PeA
 xLns=
X-Gm-Gg: ASbGncski94FT6W1AkJKbaHDtPzsGtIEO/IVav8SQxAIslJl4F+Dd1Vu/ftPwk5Uq4X
 VFWmG90RhBl5eHmINEJAI7C5BusgAPSHxtgEt2RSxmHUccuxzrNXNSopAcVhUSjQtZ12YHOkYjO
 FF/xO+cSM6fJpkkvljTUeQf2ZYGornUShjHGtGyZtKCScAC6OjWz46bLPoYy/0Zb/pR1N4cLmzv
 xSuAfETDL43KIOOJ9V04qt8XwAkswnNBarwkdHJLjmsGfR9Hmj05pd5fBU9aiwrRezwQ6KGCUmH
 GdZevG3kkgfvlm1Wy9fRWFNIezDlNHc=
X-Google-Smtp-Source: AGHT+IEWYe2qKlFrSAOZowXui2VGzVHT3msQwz/oLZvPFwTa8WhCgmg9ND7xUasPe3hPD1WQMWo8CA==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-436e26d0cf9mr98975045e9.19.1736524967313; 
 Fri, 10 Jan 2025 08:02:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm90587775e9.14.2025.01.10.08.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] hw/arm/stellaris: Wire GPTM[#n] output to ADC input #n
Date: Fri, 10 Jan 2025 17:02:04 +0100
Message-ID: <20250110160204.74997-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ADC model is very simple, and only consider the 4 GPTM
IRQs as trigger. Currently they are all wired to the same
input IRQ. This is a QDev design mistake. We could use a
OR_IRQ, but the ADC actually really has one input for each
GPTM, so have the ADC create 4 inputs and wire each GPTM
output to them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index c89522332e2..446d6595a6d 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -701,8 +701,16 @@ static void stellaris_i2c_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-/* Analogue to Digital Converter.  This is only partially implemented,
-   enough for applications that use a combined ADC and timer tick.  */
+/*
+ * Analogue to Digital Converter.
+ *
+ * Each of the 4 trigger inputs has a MUX for 5 inputs
+ * (see Stellaris Data Sheet Figure 11-1: "ADC Module Block Diagram").
+ *
+ * This model only consider the GPTM inputs, thus MUX is not implemented.
+ */
+
+#define STELLARIS_ADC_TRIGGERS      4
 
 #define STELLARIS_ADC_EM_CONTROLLER 0
 #define STELLARIS_ADC_EM_COMP       1
@@ -986,7 +994,7 @@ static void stellaris_adc_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_adc_ops, s,
                           "adc", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
+    qdev_init_gpio_in(dev, stellaris_adc_trigger, STELLARIS_ADC_TRIGGERS);
 }
 
 /* Board init.  */
@@ -1061,7 +1069,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     DeviceState *gpio_dev[NUM_GPIO], *nvic;
     qemu_irq gpio_in[NUM_GPIO][8];
     qemu_irq gpio_out[NUM_GPIO][8];
-    qemu_irq adc;
+    DeviceState *adc;
     int sram_size;
     int flash_size;
     DeviceState *i2c_dev[NUM_I2C];
@@ -1144,15 +1152,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvic, 28));
 
     if (DEV_CAP(1, ADC)) {
-        dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
+        adc = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
                                     qdev_get_gpio_in(nvic, 15),
                                     qdev_get_gpio_in(nvic, 16),
                                     qdev_get_gpio_in(nvic, 17),
                                     NULL);
-        adc = qdev_get_gpio_in(dev, 0);
-    } else {
-        adc = NULL;
     }
     for (i = 0; i < NUM_GPTM; i++) {
         if (DEV_CAP(2, GPTM(i))) {
@@ -1166,9 +1171,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             sysbus_realize_and_unref(sbd, &error_fatal);
             sysbus_mmio_map(sbd, 0, 0x40030000 + i * 0x1000);
             sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, timer_irq[i]));
+
             /* TODO: This is incorrect, but we get away with it because
                the ADC output is only ever pulsed.  */
-            qdev_connect_gpio_out(dev, 0, adc);
+            if (adc) {
+                qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(adc, i));
+            }
         }
     }
 
-- 
2.47.1


