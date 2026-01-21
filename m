Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F1C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viclu-0002JM-GD; Wed, 21 Jan 2026 13:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vicls-0002Fd-18; Wed, 21 Jan 2026 13:17:36 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1viclo-0003Jg-IN; Wed, 21 Jan 2026 13:17:35 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id E1933EC00A9;
 Wed, 21 Jan 2026 13:17:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 13:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1769019446;
 x=1769105846; bh=/urZx2lIvaNjqIcAfAbdzG9R7FsdKyq375tsHi04INo=; b=
 H+IQs1OntunbuDY/uSZlRUGKV/bkOvYgx9bfnZnXU6Y2RaP71SehmI06oOncDoJk
 feQCv4QeGhHIUrBlPaxQLx1wWGPCmfeZCJjeWz9bGiIFMqdyynxM0GnHFlFdk/ff
 Lo4etUYTweueeRwdUDivxMyiUE5b21qmweMeDceiSQEBcqrJaH1heDDFq1yQFM0P
 7jxVjhG0ErMdHMWlcQSaOON+1MqzeHSRLSljgs3lNv9/+i1V0imbXEDbPf3y5b3/
 aFXpp/5bdI3rOOGiDLXiwWm7X/OPEyMmmhmQiEF9whTLLtgFPiFZB2io++a0Zhnb
 g0Sm1gGSAKPxIwxGuB4h+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769019446; x=
 1769105846; bh=/urZx2lIvaNjqIcAfAbdzG9R7FsdKyq375tsHi04INo=; b=m
 Yj3cuMc8v57ps/whHgZBPHT2gx7CVi9ehqvZsX4Aoj4sK+yL+hJ4u8oYTF7gc5QM
 sbShaMAvvVo5yBptmSTWxPseKMLbyleDraWodE3X4cmgMcXPHVht3tdFOz30LV/o
 VXm7tlAL82FN7aIGA9obBqNUGS//2YOVyj2pyj4KNHL96g/6uU8crpMQApetqSQB
 neu6iiIxrIT5JdoL1EjzEeFR+g1ld6d8XxuqaNbqBMWPGaRhQGfX8P/p+k88Gpap
 x576sqZxpIf5sSdFv4Vt5xMVO9AO9JIJ5gU0V4bF+xlKvQXr7u4WBgFG7spxbYVD
 Wy15B8jPPzbiQKPKdNNmQ==
X-ME-Sender: <xms:NhhxaawLxigCcnosjqOpQw5kW-3H0mvA4M3fzt58KfhbFnMjsSqVQQ>
 <xme:NhhxaeZRXmAP5TVajvK2Yna5dsyRTrUPhjhxIAm8SXyP1Ch5irdpdHngeQa7vTlRr
 KFIXJzsYQZ1KDDkGXCUS_tlZeDDoDjJScXt19ovQrElLuZdVR5LpQ>
X-ME-Received: <xmr:Nhhxab2QXoNombgWeBYbrPOBkp8FOhb31ytRQWFEjzf2VTEniVd5KxCgsmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
 htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepveeikeduieevffefiedtheefffev
 teffgfetgeegvdegtdeiteettdehteetjeeinecuffhomhgrihhnpehtihdrtghomhenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhi
 tghksehsthiftgigrdighiiipdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
 houhhtpdhrtghpthhtoheplhgvvghtrhhohiesghhmrghilhdrtghomhdprhgtphhtthho
 pehqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmh
 grhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdgrrhhmsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtph
 htthhopehmihhlvghsgheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgu
 rhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepphgrth
 hrihgtkhesshhtfigtgidrgiihiidprhgtphhtthhopehsthgvvhgvnhgplhgvvgesrghs
 phgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:NhhxaQft84sqfL4vaR1tZvY4d31OzRFiWr7mvVbpskBzzC7h0CD3ng>
 <xmx:NhhxaYJXNM9Z89mwj3b4MSc-AcpY_VvvPGd4mPqulM_JwY9hATOAJA>
 <xmx:NhhxaeqtLQ3Tmz_aZFYTUsWsNvf7Y1NOSpwkhB_4WTSgRdHPF6ZHUw>
 <xmx:NhhxaWtTVX_WIM8lJw4kWyF6ZzF7p3b26RAaVizLaoscUlT2sruLYw>
 <xmx:NhhxadcFSgiGtJJc1G-0yrNyaA1Z5P-TVfL28tZc9EqlcyEI8hGxOUQB>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:17:26 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 21 Jan 2026 13:17:05 -0500
Subject: [PATCH 1/2] hw/gpio/pca9552: add pca9535 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pca9535-v1-1-164640e622ff@stwcx.xyz>
References: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
In-Reply-To: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9974; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=Zl4SOHWrTNyavSb9kRByEBgChA4XqNepGW6eS6nvoo0=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpcRgyXemcZy2aIqW/DJqdR84wT2khVs5ybUFtQ
 dWZ1I6lOcaJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaXEYMgAKCRCrA0fMLQDB
 GVYCD/4hZqdrx3PbAQ+wpL+R34igu3C/nNLqDeOqb/Muuf6wtQjlgQpIE+WvgpItjpHWwhTOEHa
 JbfBlethLmRxFosCQizCFQpNSfyGmJeRhs2crC3ejGAPzOmet6cWtEFi5OIAo2HdV4rVtJ3juqC
 ZYcqXjeD3c3gIx937C8EfmCz5/3uRAw+uuAt/VsKlypLw2ss63au5P/0b976h7A0tEOrdYvCJt0
 ZjsxO7/npJ+5EjVGOilUcn5jHtTwemDPMqMjXLCHwOrvojxe+OCHCUwdFtaVo1Zwph8DgCIOaOT
 xLYXcjngCzS6iI7G+YVm0L3nwCE1TyMFdYy1AXRJzteFdafV2jaoZ+1gCx0ruDVGk4dVhBYbges
 aTCbu3Mr7hs1V+MJ0+2O6on7mXUFKuBZsA6JaxddD7hLVgF06sz6SyJqG8phUpRZCcCUjdv1tbf
 JaxyLe0Qq21q1P3BsmT1Uh2PJy612avxxUf1HyP/iHuhOBVO3ruLIv/B6lN/jKi45wMYzJhz5iP
 oTjNLJLactiBl8ubgEIc6zTz55V9rFQaGMAFepV7YQebPF14XUNlt7wN7WZPohnWMl2H7kAgtLi
 bfTL/OB6zZ3hYMf72sEwVl1AUIZwb40NQM5YCcVMFt8JbXWrDZU5vnNPXaw8gIFj5bsB/xyyG2P
 ZwZpe+Mwn6rFBqA==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.145; envelope-from=patrick@stwcx.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Extend the 16-bit PCA9552 model to support non-LED devices such as
the PCA9535[1].

[1]: https://www.ti.com/lit/ds/symlink/pca9535.pdf

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/gpio/pca9552.c              | 176 ++++++++++++++++++++++++++++-------------
 include/hw/gpio/pca9552.h      |   1 +
 include/hw/gpio/pca9552_regs.h |  10 +++
 3 files changed, 133 insertions(+), 54 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index dd3c795e49..dd3f1536b6 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -31,6 +31,7 @@ struct PCA955xClass {
 
     uint8_t pin_count;
     uint8_t max_reg;
+    bool has_led_support;
 };
 typedef struct PCA955xClass PCA955xClass;
 
@@ -113,32 +114,59 @@ static void pca955x_update_pin_input(PCA955xState *s)
     for (i = 0; i < k->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t bit_mask = 1 << (i % 8);
-        uint8_t config = pca955x_pin_get_config(s, i);
         uint8_t old_value = s->regs[input_reg] & bit_mask;
         uint8_t new_value;
 
-        switch (config) {
-        case PCA9552_LED_ON:
-            /* Pin is set to 0V to turn on LED */
-            s->regs[input_reg] &= ~bit_mask;
-            break;
-        case PCA9552_LED_OFF:
-            /*
-             * Pin is set to Hi-Z to turn off LED and
-             * pullup sets it to a logical 1 unless
-             * external device drives it low.
-             */
-            if (s->ext_state[i] == PCA9552_PIN_LOW) {
+        if (k->has_led_support) {
+            /* PCA9552: LED control behavior */
+            uint8_t config = pca955x_pin_get_config(s, i);
+
+            switch (config) {
+            case PCA9552_LED_ON:
+                /* Pin is set to 0V to turn on LED */
                 s->regs[input_reg] &= ~bit_mask;
+                break;
+            case PCA9552_LED_OFF:
+                /*
+                 * Pin is set to Hi-Z to turn off LED and
+                 * pullup sets it to a logical 1 unless
+                 * external device drives it low.
+                 */
+                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                    s->regs[input_reg] &= ~bit_mask;
+                } else {
+                    s->regs[input_reg] |=  bit_mask;
+                }
+                break;
+            case PCA9552_LED_PWM0:
+            case PCA9552_LED_PWM1:
+                /* TODO */
+            default:
+                break;
+            }
+        } else {
+            /* PCA9535: Simple GPIO behavior */
+            uint8_t config_reg = PCA9535_CONFIG0 + (i / 8);
+            uint8_t output_reg = PCA9535_OUTPUT0 + (i / 8);
+            uint8_t polarity_reg = PCA9535_POLARITY0 + (i / 8);
+
+            /* Check if pin is configured as input */
+            if (s->regs[config_reg] & bit_mask) {
+                /* Input mode - reflect external state */
+                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                    s->regs[input_reg] &= ~bit_mask;
+                } else {
+                    s->regs[input_reg] |= bit_mask;
+                }
             } else {
-                s->regs[input_reg] |=  bit_mask;
+                /* Output mode - reflect output register value */
+                uint8_t output_bit = s->regs[output_reg] & bit_mask;
+                uint8_t polarity_bit = s->regs[polarity_reg] & bit_mask;
+
+                /* Apply polarity inversion if set */
+                s->regs[input_reg] = (s->regs[input_reg] & ~bit_mask) |
+                                    ((output_bit ^ polarity_bit) & bit_mask);
             }
-            break;
-        case PCA9552_LED_PWM0:
-        case PCA9552_LED_PWM1:
-            /* TODO */
-        default:
-            break;
         }
 
         /* update irq state only if pin state changed */
@@ -151,52 +179,52 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
 static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
 {
-    switch (reg) {
-    case PCA9552_INPUT0:
-    case PCA9552_INPUT1:
-    case PCA9552_PSC0:
-    case PCA9552_PWM0:
-    case PCA9552_PSC1:
-    case PCA9552_PWM1:
-    case PCA9552_LS0:
-    case PCA9552_LS1:
-    case PCA9552_LS2:
-    case PCA9552_LS3:
-        return s->regs[reg];
-    default:
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    if (reg > k->max_reg) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register %d\n",
                       __func__, reg);
         return 0xFF;
     }
+
+    return s->regs[reg];
 }
 
 static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
     uint16_t pins_status;
 
-    switch (reg) {
-    case PCA9552_PSC0:
-    case PCA9552_PWM0:
-    case PCA9552_PSC1:
-    case PCA9552_PWM1:
-        s->regs[reg] = data;
-        break;
-
-    case PCA9552_LS0:
-    case PCA9552_LS1:
-    case PCA9552_LS2:
-    case PCA9552_LS3:
-        pins_status = pca955x_pins_get_status(s);
-        s->regs[reg] = data;
-        pca955x_update_pin_input(s);
-        pca955x_display_pins_status(s, pins_status);
-        break;
-
-    case PCA9552_INPUT0:
-    case PCA9552_INPUT1:
-    default:
+    if (reg > k->max_reg) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register %d\n",
                       __func__, reg);
+        return;
+    }
+
+    /* Handle read-only registers */
+    if (reg == PCA9552_INPUT0 || reg == PCA9552_INPUT1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unexpected write to read-only register %d\n",
+                      __func__, reg);
+        return;
+    }
+
+    pins_status = pca955x_pins_get_status(s);
+    s->regs[reg] = data;
+
+    /* Update GPIO state if this register affects outputs */
+    if (k->has_led_support) {
+        /* PCA9552: Update on LED selector register writes */
+        if (reg >= PCA9552_LS0 && reg <= PCA9552_LS3) {
+            pca955x_update_pin_input(s);
+            pca955x_display_pins_status(s, pins_status);
+        }
+    } else {
+        /* PCA9535: Update on OUTPUT, POLARITY, or CONFIG register writes */
+        if (reg >= PCA9535_OUTPUT0 && reg <= PCA9535_CONFIG1) {
+            pca955x_update_pin_input(s);
+            pca955x_display_pins_status(s, pins_status);
+        }
     }
 }
 
@@ -379,6 +407,26 @@ static void pca9552_reset(DeviceState *dev)
     s->len = 0;
 }
 
+static void pca9535_reset(DeviceState *dev)
+{
+    PCA955xState *s = PCA955X(dev);
+
+    s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
+    s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
+    s->regs[PCA9535_OUTPUT0] = 0xFF;  /* All outputs high */
+    s->regs[PCA9535_OUTPUT1] = 0xFF;  /* All outputs high */
+    s->regs[PCA9535_POLARITY0] = 0x00; /* No polarity inversion */
+    s->regs[PCA9535_POLARITY1] = 0x00; /* No polarity inversion */
+    s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
+    s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
+
+    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    pca955x_update_pin_input(s);
+
+    s->pointer = 0xFF;
+    s->len = 0;
+}
+
 static void pca955x_initfn(Object *obj)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
@@ -463,6 +511,19 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
+    pc->has_led_support = true;
+}
+
+static void pca9535_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCA955xClass *pc = PCA955X_CLASS(oc);
+
+    device_class_set_legacy_reset(dc, pca9535_reset);
+    dc->vmsd = &pca9552_vmstate;
+    pc->max_reg = PCA9535_CONFIG1;
+    pc->pin_count = 16;
+    pc->has_led_support = false;
 }
 
 static const TypeInfo pca9552_info = {
@@ -471,10 +532,17 @@ static const TypeInfo pca9552_info = {
     .class_init    = pca9552_class_init,
 };
 
+static const TypeInfo pca9535_info = {
+    .name          = TYPE_PCA9535,
+    .parent        = TYPE_PCA955X,
+    .class_init    = pca9535_class_init,
+};
+
 static void pca955x_register_types(void)
 {
     type_register_static(&pca955x_info);
     type_register_static(&pca9552_info);
+    type_register_static(&pca9535_info);
 }
 
 type_init(pca955x_register_types)
diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index c36525f0c3..43b175235d 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -14,6 +14,7 @@
 
 #define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA955X "pca955x"
+#define TYPE_PCA9535 "pca9535"
 typedef struct PCA955xState PCA955xState;
 DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
                          TYPE_PCA955X)
diff --git a/include/hw/gpio/pca9552_regs.h b/include/hw/gpio/pca9552_regs.h
index d8051cfbd6..5a6bb03396 100644
--- a/include/hw/gpio/pca9552_regs.h
+++ b/include/hw/gpio/pca9552_regs.h
@@ -29,4 +29,14 @@
  */
 #define PCA9552_AUTOINC  (1 << 4)
 
+/* PCA9535 Registers (same addresses, different semantics) */
+#define PCA9535_INPUT0      0 /* read only input register 0 */
+#define PCA9535_INPUT1      1 /* read only input register 1  */
+#define PCA9535_OUTPUT0     2 /* read/write output register 0 */
+#define PCA9535_OUTPUT1     3 /* read/write output register 1 */
+#define PCA9535_POLARITY0   4 /* read/write polarity inversion register 0 */
+#define PCA9535_POLARITY1   5 /* read/write polarity inversion register 1 */
+#define PCA9535_CONFIG0     6 /* read/write configuration register 0 */
+#define PCA9535_CONFIG1     7 /* read/write configuration register 1 */
+
 #endif

-- 
2.51.2


