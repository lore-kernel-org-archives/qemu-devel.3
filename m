Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F3DC54E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXre-0006Qf-Ap; Fri, 23 Feb 2024 10:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXj7-0005eL-RB; Fri, 23 Feb 2024 10:44:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXj6-0006NR-6v; Fri, 23 Feb 2024 10:44:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso8022355ad.0; 
 Fri, 23 Feb 2024 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703078; x=1709307878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q36jhjRJi9//Rq92Z4CXsjy5rE5fVHQHoeYIuEypDgo=;
 b=hDSbfliXSt6twpr+oKyBA6Bft5OBb1qzYnvgllrFakQ6h7/ZetibfwaDEOh4GEGj/g
 frC59idmidP+EcXNnUUBKLCpKReSsRJ8zjTY6AF1htZpRtxrN4ulFJr64SFB0vYDs87x
 L4YjPvNTqSqrOd4QuQ4171pLPou2b/0gXVwtRWtRvVvWZYC4Vvj+r1T8MPk+ZR+XlSls
 mpxxzlYLu6lKTMMZik9xDH50lMR/WtXp7amxDLn/UCluuGsEsIaZfOwDtxEmdt9rS4pq
 1lW3zpnfM+tH4vm1GiLvqAa9o6QBjEC95ezekY/CkMnu+Tj0FKsowTKdel3Jcvk4+5iO
 O5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703078; x=1709307878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q36jhjRJi9//Rq92Z4CXsjy5rE5fVHQHoeYIuEypDgo=;
 b=sqR+XLLD5g/TYfFjZ1/D08Jp1ZPZCTQBVAKJk1Nrzf9WZdbZn8hWqAp6e4QjSM9gGb
 aJTC5Dqba7wq4DpPE543bNiu9f4PclcZIPyF/wqJD96cSEkKvZI/vh40FvCahjedP3Pl
 Cz51BUtkISV7787oCzB6WXl5mH5TUZRu0SZ1zDz/NK9w5IqrUFoSasUpuqMF/vVR2wVE
 EdmZMc1ATI9IdB3G1hPwsO3OAisjOuTcvR0H2wyvxFHWSvfFyHUKXkuV1ZzaLvdtWZL1
 hgq2nKtJ2RLjyRETkOnn/7In24+VPkVSajxTJunqh0i8Q4Ry0n3UpJ2L1KOFA80qOpG7
 wnkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdZZTN3LU/yFlNgEajyNupuR/Ssi69mLumEcw1E2+tuMFzvxfDC7J+VLZYpG2AakfxouywDp6mccO4jqESJMWLEgEz
X-Gm-Message-State: AOJu0Yy4348znwkkpLlOpuo2yfLpJQdRHqVlXDZSc/csOjXx00xyzg28
 Fjy7AbburE8geXS4HvuD5Vn5Yj2XD9NVMeLwKkQpaaSiIJJ6QFTotbm1NpFq
X-Google-Smtp-Source: AGHT+IGWuaQySoRuhdqboM25THBmhk2DvZUvnOxionIfcT/LCuxMuLynBhHC+3oxNzj3WdBMNUID+Q==
X-Received: by 2002:a17:902:f681:b0:1db:4213:41e8 with SMTP id
 l1-20020a170902f68100b001db421341e8mr111796plg.69.1708703078369; 
 Fri, 23 Feb 2024 07:44:38 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:38 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 22/47] misc/pca9552: Let external devices set pca9552 inputs
Date: Sat, 24 Feb 2024 01:41:41 +1000
Message-ID: <20240223154211.1001692-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Allow external devices to drive pca9552 input pins by adding
input GPIO's to the model.  This allows a device to connect
its output GPIO's to the pca9552 input GPIO's.

In order for an external device to set the state of a pca9552
pin, the pin must first be configured for high impedance (LED
is off).  If the pca9552 pin is configured to drive the pin low
(LED is on), then external input will be ignored.

Here is a table describing the logical state of a pca9552 pin
given the state being driven by the pca9552 and an external device:

                   PCA9552
                   Configured
                   State

                  | Hi-Z | Low |
            ------+------+-----+
  External   Hi-Z |  Hi  | Low |
  Device    ------+------+-----+
  State      Low  |  Low | Low |
            ------+------+-----+

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/misc/pca9552.c         | 50 +++++++++++++++++++++++++++++++++------
 include/hw/misc/pca9552.h |  3 ++-
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index f00a149d61..2ae13af35e 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -44,6 +44,8 @@ DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
 #define PCA9552_LED_PWM1 0x3
+#define PCA9552_PIN_LOW  0x0
+#define PCA9552_PIN_HIZ  0x1
 
 static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
 
@@ -110,22 +112,27 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
     for (i = 0; i < k->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
-        uint8_t input_shift = (i % 8);
+        uint8_t bit_mask = 1 << (i % 8);
         uint8_t config = pca955x_pin_get_config(s, i);
+        uint8_t old_value = s->regs[input_reg] & bit_mask;
+        uint8_t new_value;
 
         switch (config) {
         case PCA9552_LED_ON:
             /* Pin is set to 0V to turn on LED */
-            qemu_set_irq(s->gpio[i], 0);
-            s->regs[input_reg] &= ~(1 << input_shift);
+            s->regs[input_reg] &= ~bit_mask;
             break;
         case PCA9552_LED_OFF:
             /*
              * Pin is set to Hi-Z to turn off LED and
-             * pullup sets it to a logical 1.
+             * pullup sets it to a logical 1 unless
+             * external device drives it low.
              */
-            qemu_set_irq(s->gpio[i], 1);
-            s->regs[input_reg] |= 1 << input_shift;
+            if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                s->regs[input_reg] &= ~bit_mask;
+            } else {
+                s->regs[input_reg] |=  bit_mask;
+            }
             break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
@@ -133,6 +140,12 @@ static void pca955x_update_pin_input(PCA955xState *s)
         default:
             break;
         }
+
+        /* update irq state only if pin state changed */
+        new_value = s->regs[input_reg] & bit_mask;
+        if (new_value != old_value) {
+            qemu_set_irq(s->gpio_out[i], !!new_value);
+        }
     }
 }
 
@@ -340,6 +353,7 @@ static const VMStateDescription pca9552_vmstate = {
         VMSTATE_UINT8(len, PCA955xState),
         VMSTATE_UINT8(pointer, PCA955xState),
         VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
+        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
         VMSTATE_I2C_SLAVE(i2c, PCA955xState),
         VMSTATE_END_OF_LIST()
     }
@@ -358,6 +372,7 @@ static void pca9552_reset(DeviceState *dev)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
+    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -380,6 +395,26 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
+static void pca955x_set_ext_state(PCA955xState *s, int pin, int level)
+{
+    if (s->ext_state[pin] != level) {
+        uint16_t pins_status = pca955x_pins_get_status(s);
+        s->ext_state[pin] = level;
+        pca955x_update_pin_input(s);
+        pca955x_display_pins_status(s, pins_status);
+    }
+}
+
+static void pca955x_gpio_in_handler(void *opaque, int pin, int level)
+{
+
+    PCA955xState *s = PCA955X(opaque);
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    assert((pin >= 0) && (pin < k->pin_count));
+    pca955x_set_ext_state(s, pin, level);
+}
+
 static void pca955x_realize(DeviceState *dev, Error **errp)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(dev);
@@ -389,7 +424,8 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
         s->description = g_strdup("pca-unspecified");
     }
 
-    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
+    qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
+    qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
 }
 
 static Property pca955x_properties[] = {
diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index b6f4e264fe..c36525f0c3 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -30,7 +30,8 @@ struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
-    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
+    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
+    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
     char *description; /* For debugging purpose only */
 };
 
-- 
2.42.0


