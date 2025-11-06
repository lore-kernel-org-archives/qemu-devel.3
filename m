Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64323CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5SM-0003YN-9Z; Thu, 06 Nov 2025 14:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rvMMaQYKChkNJ07CO5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--yubinz.bounces.google.com>)
 id 1vH5Rm-0003RM-7P
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:15:03 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rvMMaQYKChkNJ07CO5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--yubinz.bounces.google.com>)
 id 1vH5Rh-0006Ir-JE
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:15:01 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-297b35951b7so9230145ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 11:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762456495; x=1763061295; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3a6nhXDiCDvYLdUhRGABA5fifEWI0KyxBhXbGQPBVak=;
 b=rVjlG25NZ6dPp8J+TDSouGu0bDUIIyMRe2BCbu9gmNswuHgHrowslCgp3qq1cS2y3K
 OrPFx8TninR4i/lIzgtYUEowGgpCt55vKmS6I/E+XStFy69UERS6eggvgfN/6yJQdM3t
 Q0ZwnHwKjSJp2ljRB3mmQKYqLLL/WHZO/XnDxGknwE4oGytELd4nCyAUrCJzNoOa57M9
 4DwuAB++yWrl90Iq6oyoUfnj+C0VGuJpTkKLUPqthbuu3zUmWu3P9r8/sEfXlMl/30me
 FaSQ5/WpJenNkmK/RLvjKo1TNR3uItdTrysDgeNsdjB/xkSCjKLf8crAhlQy3iefaRGp
 qdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762456495; x=1763061295;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3a6nhXDiCDvYLdUhRGABA5fifEWI0KyxBhXbGQPBVak=;
 b=YZgLPzK1rjF098VkcwOyVXRA2DUMPWPh/J9n8QkA9DT7upMKjQumXsneCTO2BAybyF
 KilriVnho+dw1okR8V9cZc5n9kD91p3gt1p0zWtdJ/mGix2Lxswmq2qS46VdJQ5wrojz
 PaMxXyUbh9cSu22nnnxaJy2hmoqNydkDsNN2kD34JBFKnnLdTOlg26Wnvgwbojhf7ICO
 RCyqZqzmjMjb5JSPm8TN9eH/MuxKFOwBMz/kkXUgiLdvdcNvYzKzG78QNWe//pZVmrX+
 f9o3qFnMu3d3Rg2BvDEQabQ7aVXlIFuq0mNeqV5+g5xUl+zaTvoy0mE8HXwFIpqgLJyT
 lS7A==
X-Gm-Message-State: AOJu0YwcMGZFkOug2AUf4Nj7N7tJvWN4qjWkkWUT9wmEw68mrO5IqjmS
 0fZ9So3IasTpREb+TrlzrOPu6ITDCxXEeBexFVhAGymVvs2TOoJ9qBxYrt07EX4UvlBAdWnQkqP
 P7AolSx7zsJjWCNtto+xlFzd/3+VNlhv7+DVtizMpml+WIng9uynhLmuW2JsTpO/wISfq91yver
 jnkIs2S4jkCIXdVMud+cIGwTeTGNBAYogyTmM=
X-Google-Smtp-Source: AGHT+IFyr0nofr6hzK46vbRWhSvQ6E7tUVxV5w9aidvxmDLvPR3w8pNn1286NmD2y8KI0E6q5OqGJFLmjTs=
X-Received: from dlae14.prod.google.com ([2002:a05:701b:230e:b0:119:49ca:6b9d])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc87:b0:295:c2e8:dabd
 with SMTP id d9443c01a7336-297c03ed305mr7482275ad.26.1762456494754; Thu, 06
 Nov 2025 11:14:54 -0800 (PST)
Date: Thu, 06 Nov 2025 19:14:25 +0000
In-Reply-To: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
Mime-Version: 1.0
References: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251106-aspeed-sgpio-v1-2-b026093716fa@google.com>
Subject: [PATCH 2/2] hw/gpio Add the Interrupt logic to Aspeed Serial gpio
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3rvMMaQYKChkNJ07CO5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This commit establish the interrupt logic of Aspeed Serial gpio to
handle four types interrupt trigger, level high, level low, rising edge,
failing edge
Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/gpio/aspeed_sgpio.c           | 171 +++++++++++++++++++++++++++++----------
 include/hw/gpio/aspeed_sgpio.h   |  30 +++++++
 tests/qtest/ast2700-sgpio-test.c |  72 +++++++++++++++--
 3 files changed, 222 insertions(+), 51 deletions(-)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index a6f0f32d72aef3c26a143df4e7a49384aa216643..c9aa8e4818673150c4174dc18fe76ab9cbaf4993 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -12,70 +12,156 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/gpio/aspeed_sgpio.h"
 #include "hw/registerfields.h"
 
-/* AST2700 SGPIO Register Address Offsets */
-REG32(SGPIO_INT_STATUS_0, 0x40)
-REG32(SGPIO_INT_STATUS_1, 0x44)
-REG32(SGPIO_INT_STATUS_2, 0x48)
-REG32(SGPIO_INT_STATUS_3, 0x4C)
-REG32(SGPIO_INT_STATUS_4, 0x50)
-REG32(SGPIO_INT_STATUS_5, 0x54)
-REG32(SGPIO_INT_STATUS_6, 0x58)
-REG32(SGPIO_INT_STATUS_7, 0x5C)
-/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
-REG32(SGPIO_0_CONTROL, 0x80)
-    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
-    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
-    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
-    SHARED_FIELD(SGPIO_INT_TYPE0, 3, 1)
-    SHARED_FIELD(SGPIO_INT_TYPE1, 4, 1)
-    SHARED_FIELD(SGPIO_INT_TYPE2, 5, 1)
-    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
-    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
-    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
-    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
-    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
-    SHARED_FIELD(SGPIO_INTERRUPT_STATUS, 12, 1)
-    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
-    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
-    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
-    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
-REG32(SGPIO_255_CONTROL, 0x47C)
+/*
+ *  For each set of gpios there are three sensitivity registers that control
+ *  the interrupt trigger mode.
+ *
+ *  | 2 | 1 | 0 | trigger mode
+ *  -----------------------------
+ *  | 0 | 0 | 0 | falling-edge
+ *  | 0 | 0 | 1 | rising-edge
+ *  | 0 | 1 | 0 | level-low
+ *  | 0 | 1 | 1 | level-high
+ *  | 1 | X | X | dual-edge
+ */
+
+/* GPIO Interrupt Triggers */
+#define ASPEED_FALLING_EDGE 0
+#define ASPEED_RISING_EDGE  1
+#define ASPEED_LEVEL_LOW    2
+#define ASPEED_LEVEL_HIGH   3
+#define ASPEED_DUAL_EDGE    4
+
+static void aspeed_clear_irq(AspeedSGPIOState *s, int idx)
+{
+    uint32_t reg_index = idx / 32;
+    uint32_t bit_index = idx % 32;
+    uint32_t pending = extract32(s->int_regs[reg_index], bit_index, 1);
+
+    assert(s->pending >= pending);
+
+    /* No change to s->pending if pending is 0 */
+    s->pending -= pending;
+
+    /*
+     * The write acknowledged the interrupt regardless of whether it
+     * was pending or not. The post-condition is that it mustn't be
+     * pending. Unconditionally clear the status bit.
+     */
+    s->int_regs[reg_index] = deposit32(s->int_regs[reg_index], bit_index, 1, 0);
+}
+
+static void aspeed_evaluate_irq(AspeedSGPIOState *s, int sgpio_prev_high,
+                                int sgpio_curr_high, int idx)
+{
+    uint32_t ctrl = s->ctrl_regs[idx];
+    uint32_t falling_edge = 0, rising_edge = 0;
+    uint32_t int_trigger = SHARED_FIELD_EX32(ctrl, SGPIO_INT_TYPE);
+    uint32_t int_enabled = SHARED_FIELD_EX32(ctrl, SGPIO_INT_EN);
+    uint32_t reg_index = idx / 32;
+    uint32_t bit_index = idx % 32;
+
+    if (!int_enabled) {
+        return;
+    }
+
+    /* Detect edges */
+    if (sgpio_curr_high && !sgpio_prev_high) {
+        rising_edge = 1;
+    } else if (!sgpio_curr_high && sgpio_prev_high) {
+        falling_edge = 1;
+    }
+
+    if (((int_trigger == ASPEED_FALLING_EDGE)  && falling_edge)   ||
+        ((int_trigger == ASPEED_RISING_EDGE)  && rising_edge)     ||
+        ((int_trigger == ASPEED_LEVEL_LOW)  && !sgpio_curr_high)  ||
+        ((int_trigger == ASPEED_LEVEL_HIGH)  && sgpio_curr_high)  ||
+        ((int_trigger >= ASPEED_DUAL_EDGE)  && (rising_edge || falling_edge)))
+    {
+        s->int_regs[reg_index] = deposit32(s->int_regs[reg_index],
+                                              bit_index, 1, 1);
+        /* Trigger the VIC IRQ */
+        s->pending++;
+    }
+}
+
+static void aspeed_sgpio_update(AspeedSGPIOState *s, uint32_t idx,
+                                uint32_t value)
+{
+    uint32_t old = s->ctrl_regs[idx];
+    uint32_t new = value;
+    uint32_t diff = (old ^ new);
+    if (diff) {
+        /* If the interrupt clear bit is set */
+        if (SHARED_FIELD_EX32(new, SGPIO_INT_STATUS)) {
+            aspeed_clear_irq(s, idx);
+            /* Clear the interrupt clear bit */
+            new &= ~SGPIO_INT_STATUS_MASK;
+        }
+
+        /* Uppdate the control register. */
+        s->ctrl_regs[idx] = new;
+
+        /* If the output value is changed */
+        if (SHARED_FIELD_EX32(diff, SGPIO_SERIAL_OUT_VAL)) {
+            /* ...trigger the line-state IRQ */
+            qemu_set_irq(s->sgpios[idx], 1);
+        }
+
+        /* If the input value is changed */
+        if (SHARED_FIELD_EX32(diff, SGPIO_SERIAL_IN_VAL)) {
+            aspeed_evaluate_irq(s,
+                            SHARED_FIELD_EX32(old, SGPIO_SERIAL_IN_VAL),
+                            SHARED_FIELD_EX32(new, SGPIO_SERIAL_IN_VAL),
+                            idx);
+        }
+    }
+    qemu_set_irq(s->irq, !!(s->pending));
+}
 
 static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
-                                uint32_t reg)
+                                                      uint32_t reg)
 {
-    /* TODO: b/430606659 - Implement aspeed_sgpio_2700_read_int_status_reg */
-    return 0;
+    uint32_t idx = reg - R_SGPIO_INT_STATUS_0;
+    if (idx >= ASPEED_SGPIO_MAX_INT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                         "%s: interrupt status index: %d, out of bounds\n",
+                         __func__, idx);
+        return 0;
+    }
+    return s->int_regs[idx];
 }
 
+
 static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
                                 uint32_t reg)
 {
     AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
-    uint32_t pin = reg - R_SGPIO_0_CONTROL;
-    if (pin >= agc->nr_sgpio_pin_pairs) {
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
-                      __func__, pin);
+                      __func__, idx);
         return 0;
     }
-    return s->ctrl_regs[pin];
+    return s->ctrl_regs[idx];
 }
 
 static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
                                 uint32_t reg, uint64_t data)
 {
     AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
-    uint32_t pin = reg - R_SGPIO_0_CONTROL;
-    if (pin >= agc->nr_sgpio_pin_pairs) {
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
-                      __func__, pin);
+                      __func__, idx);
         return;
     }
-    s->ctrl_regs[pin] = data;
+    aspeed_sgpio_update(s, idx, data);
 }
 
 static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
@@ -89,7 +175,7 @@ static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
 
     switch (reg) {
     case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
-        aspeed_sgpio_2700_read_int_status_reg(s, reg);
+        value = aspeed_sgpio_2700_read_int_status_reg(s, reg);
         break;
     case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
         value = aspeed_sgpio_2700_read_control_reg(s, reg);
@@ -112,8 +198,6 @@ static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
     reg = offset >> 2;
 
     switch (reg) {
-    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
-        break;
     case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
         aspeed_sgpio_2700_write_control_reg(s, reg, data);
         break;
@@ -156,8 +240,7 @@ static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
     } else {
         value &= ~bit_mask;
     }
-    s->ctrl_regs[pin >> 1] = value;
-    /* TODO: b/430606659 - Implement the SGPIO Interrupt */
+    aspeed_sgpio_update(s, pin >> 1, value);
 }
 
 static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
index a7d4868eeeb2f2caedcdff9858a6047ce5a1fcd8..5dddab80848937417b5f99f1b52b44f62893bda9 100644
--- a/include/hw/gpio/aspeed_sgpio.h
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -10,6 +10,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "hw/registerfields.h"
 
 #define TYPE_ASPEED_SGPIO "aspeed.sgpio"
 OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
@@ -17,6 +18,33 @@ OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
 #define ASPEED_SGPIO_MAX_PIN_PAIR 256
 #define ASPEED_SGPIO_MAX_INT 8
 
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
 struct AspeedSGPIOClass {
     SysBusDevice parent_obj;
     uint32_t nr_sgpio_pin_pairs;
@@ -30,7 +58,9 @@ struct AspeedSGPIOState {
 
   /*< public >*/
   MemoryRegion iomem;
+  int pending;
   qemu_irq irq;
+  qemu_irq sgpios[ASPEED_SGPIO_MAX_PIN_PAIR];
   uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
   uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
 };
diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
index a24fa29250d0c47b1ca7564280055de2c53f525b..fc52839c4b149a3010c6a035d8b29f9ad295930a 100644
--- a/tests/qtest/ast2700-sgpio-test.c
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -12,11 +12,12 @@
 #include "qobject/qdict.h"
 #include "libqtest-single.h"
 #include "qemu/error-report.h"
+#include "hw/registerfields.h"
+#include "hw/gpio/aspeed_sgpio.h"
 
 #define ASPEED_SGPIO_MAX_PIN_PAIR 256
 #define AST2700_SGPIO0_BASE 0x14C0C000
 #define AST2700_SGPIO1_BASE 0x14C0D000
-#define SGPIO_0_CONTROL 0x80
 
 static void test_output_pins(const char *machine, const uint32_t base, int idx)
 {
@@ -29,17 +30,17 @@ static void test_output_pins(const char *machine, const uint32_t base, int idx)
         /* Odd index is output port */
         sprintf(name, "sgpio%d", i * 2 + 1);
         sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
-        offset = base + SGPIO_0_CONTROL + (i * 4);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
         /* set serial output */
         qtest_writel(s, offset, 0x00000001);
         value = qtest_readl(s, offset);
-        g_assert_cmphex(value, ==, 0x00000001);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 1);
         g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
 
         /* clear serial output */
         qtest_writel(s, offset, 0x00000000);
         value = qtest_readl(s, offset);
-        g_assert_cmphex(value, ==, 0);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 0);
         g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
     }
     qtest_quit(s);
@@ -56,22 +57,75 @@ static void test_input_pins(const char *machine, const uint32_t base, int idx)
         /* Even index is input port */
         sprintf(name, "sgpio%d", i * 2);
         sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
-        offset = base + SGPIO_0_CONTROL + (i * 4);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
         /* set serial input */
         qtest_qom_set_bool(s, qom_path, name, true);
         value = qtest_readl(s, offset);
-        g_assert_cmphex(value, ==, 0x00002000);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
         g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
 
         /* clear serial input */
         qtest_qom_set_bool(s, qom_path, name, false);
         value = qtest_readl(s, offset);
-        g_assert_cmphex(value, ==, 0);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
         g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
     }
     qtest_quit(s);
 }
 
+static void test_irq_level_high(const char *machine,
+                                const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t ctrl_offset = 0;
+    uint32_t int_offset = 0;
+    uint32_t int_reg_idx = 0;
+    uint32_t int_bit_idx = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        int_reg_idx = i / 32;
+        int_bit_idx = i % 32;
+        int_offset = base + (R_SGPIO_INT_STATUS_0 + int_reg_idx) * 4;
+        ctrl_offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+
+        /* Enable the interrupt */
+        value = SHARED_FIELD_DP32(value, SGPIO_INT_EN, 1);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set the interrupt type to level-high trigger */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_TYPE, 3);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set serial input high */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
+
+        /* Interrupt status is set */
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 1);
+
+        /* Clear Interrupt */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_STATUS, 1);
+        qtest_writel(s, ctrl_offset, value);
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 0);
+
+        /* Clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
+    }
+    qtest_quit(s);
+}
+
 static void test_2700_input_pins(void)
 {
     test_input_pins("-machine ast2700-evb",
@@ -82,6 +136,10 @@ static void test_2700_input_pins(void)
                     AST2700_SGPIO0_BASE, 0);
     test_output_pins("-machine ast2700-evb",
                     AST2700_SGPIO1_BASE, 1);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
 }
 
 int main(int argc, char **argv)

-- 
2.51.2.1041.gc1ab5b90ca-goog


