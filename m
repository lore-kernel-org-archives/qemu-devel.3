Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FC9D3E785
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTcw-000485-7j; Wed, 10 Dec 2025 18:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YwI6aQYKCqAYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com>)
 id 1vTTct-00047f-8A
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:43 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YwI6aQYKCqAYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com>)
 id 1vTTcr-0005hv-HC
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:43 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b99d6bd6cc9so661071a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409380; x=1766014180; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DbiJPK3isi4TO87MGtYFXPVGrO1aU7/+qi1vRbNMJMY=;
 b=AI3ikaLc0zaj+wiYOQ4TPmJSCKLubvjq0nPIn1B8T4NcOOlebZbL3xkYNk5rayHVXu
 t4FzoJGw2wTpVTquMjEAnikPZLVfjPA4X19NNju2Ag4JBPLv8WwSJQSTJVVCUZunLxzT
 rRCsfxiA1FipDz51Pd7+gHW2zE90TmDMNKodmooEd5d9AjZgeSgxkCwEe/VybmvTfYB/
 3c5dQSKf0NZlaGtgVcg0kLuM1jBSiF53BlzrFcdrmLHA2bz8+2UVGcvm3xKlqFIDDypc
 Z+SjtABg0gv9wH+8BrE5leQoOdkQT1iWgfT69QuxyZyBDaKAMOh1yOikkptkFLnqVq5y
 E4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409380; x=1766014180;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbiJPK3isi4TO87MGtYFXPVGrO1aU7/+qi1vRbNMJMY=;
 b=dW50goXEvrBI+T/cUqfIuCubUlE8vaOkrxdfrs2JTovP223M5vHj2RPq1dBiffq2GV
 6eMS5eFgH4nlLU07JOlo3GnW2WPG1b5duBPQnDOSIyZJqfV8EkKoTRzn3XN79Pr9vR+T
 J3PR7moLTNDFcL7yW12D0kKOAaaJ0nI/+lyyzOqM4XqzF3kpCAjmuK7Mwelm2y63ioWM
 p1fqfEdt5rvTH2T3EA8TTVV1CfUC60yiIR0PJJutAWIbEFWzLNmr8qDMklGNTJ5RDP+Q
 4Fu0Fwl/SZyIoYzWPmZP1Ypq/Mmdg6v6k6LwiGFTT8IuVlm/JodYKJkfdL7p6Yr2ATtF
 2rrA==
X-Gm-Message-State: AOJu0YzEX7E4FIH+7AtTkv3wb5AtatTp96D2YgYzXmxRnlcS7EXNid3g
 H1VGqJ5e4jKAsNgRizGwK7LQg2ELmbtAz5EoBvAygRwKJ4nvjDBQSQxb/t5UQLDk+cvrRi8CZiv
 6sUCklez6W81yDgbFtKL8SR2l6p7rYDaW3hjJ64bQXCA9W2ZqhHKUx+PXegADTx4rE0Q9SuL2C7
 wy5bsqdXTqeyQiSaO+JQmZqudJKRuPVjYIwkg=
X-Google-Smtp-Source: AGHT+IF/kU1Um7JytCYfQKKgIb9G+2cmH9EqURO62c94uClLHcIsqmzTXCDx3W6vx77MvJ594uvUbTlafgg=
X-Received: from dynm28.prod.google.com ([2002:a05:7300:2a9c:b0:2a4:6899:e5f0])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:2301:b0:2a4:3594:d535
 with SMTP id 5a478bee46e88-2ac0544abfbmr4041411eec.2.1765409379492; Wed, 10
 Dec 2025 15:29:39 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:14 +0000
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Mime-Version: 1.0
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-3-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 3/6] hw/gpio/aspeed_sgpio: Implement SGPIO interrupt
 handling
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3YwI6aQYKCqAYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The SGPIO controller can generate interrupts based on various pin state
changes, such as rising/falling edges or high/low levels. This change
adds the necessary logic to detect these events, update the interrupt
status registers, and signal the interrupt to the SoC.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 include/hw/gpio/aspeed_sgpio.h |   2 +
 hw/gpio/aspeed_sgpio.c         | 126 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
index ffdc54a112da8962a7bc5773d524f1d86eb85d39..5dddab80848937417b5f99f1b52b44f62893bda9 100644
--- a/include/hw/gpio/aspeed_sgpio.h
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -58,7 +58,9 @@ struct AspeedSGPIOState {
 
   /*< public >*/
   MemoryRegion iomem;
+  int pending;
   qemu_irq irq;
+  qemu_irq sgpios[ASPEED_SGPIO_MAX_PIN_PAIR];
   uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
   uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
 };
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 27c406d5042f423b914d53de000b727cb7242dc9..4b7797d46acac175249f8a8caf2daab27c384e9b 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -12,15 +12,131 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/gpio/aspeed_sgpio.h"
 
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
+
 static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
-                                uint32_t reg)
+                                                      uint32_t reg)
 {
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
@@ -44,7 +160,7 @@ static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
                       __func__, idx);
         return;
     }
-    s->ctrl_regs[idx] = data;
+    aspeed_sgpio_update(s, idx, data);
 }
 
 static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
@@ -58,7 +174,7 @@ static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
 
     switch (reg) {
     case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
-        aspeed_sgpio_2700_read_int_status_reg(s, reg);
+        value = aspeed_sgpio_2700_read_int_status_reg(s, reg);
         break;
     case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
         value = aspeed_sgpio_2700_read_control_reg(s, reg);
@@ -123,7 +239,7 @@ static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
     } else {
         value &= ~bit_mask;
     }
-    s->ctrl_regs[pin >> 1] = value;
+    aspeed_sgpio_update(s, pin >> 1, value);
 }
 
 static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,

-- 
2.52.0.239.gd5f0c6e74e-goog


