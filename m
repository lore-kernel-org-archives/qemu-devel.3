Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B21D74964
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 07:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWUXh-0003rO-7h; Fri, 19 Dec 2025 02:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C_lEaQYKCmIYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com>)
 id 1vWUXf-0003qq-MN
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:47 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C_lEaQYKCmIYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com>)
 id 1vWUXd-0001bX-Rn
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:47 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b99763210e5so2702353a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 23:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766127883; x=1766732683; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UEXr5Jd09L+9AgjqhDamfCsOvdLjpKDjLgvtKDEVv/A=;
 b=0d1Bn2j186Hnv8ozG0gqwzQxcRHgtrfF1mM9sQYAnYZ1xxlSu3nB5kmYUNaErJH2gy
 bP6eLzRTZkaUISy1rCp3OeTRN53bGZsjkAecW8qn8T8IKaBpH5e+bZLK2QDXx4Nt44BA
 Bf1OdGuFOU5NsSD1IhiVx6p0OQN9a5zFiKJcseKh+0DAyGFcVB78YGfFXh/N9pWdy3kv
 8Bjb0GTgIZ8ht92DOYkeA7wACgYZrXEOHsJP00qlWtFxnM2KZ7jxTwB/SDZ6jEUhtZqv
 Jte7/UoqujlCEaUmkZHA5wreDs+daSVgWqPP36SxaMPbYHXqh4jdL8OQE1TE5vtIAQk4
 FPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766127883; x=1766732683;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEXr5Jd09L+9AgjqhDamfCsOvdLjpKDjLgvtKDEVv/A=;
 b=tp3hAbNOE15aKSr+WUIE6K/2jptznjUOTZcCa7fKGKFb9iMDiEh6zDJSXpNs51e8XP
 msR8dcWtx90D3bMXigqJkxD5CweALPhYcoCGyCtOZMCgSDv2iMijwgLkvNzB2p5XPhcP
 DPYu5ps7r6I/j3jaUi8tVYm5Q/m0ezQEdSviDIUazfuGVApuyM1MjS5WCtKe1DxFT6bm
 lrzkpf2CrtCY8wkFMgcV7+Wiqsl2kBD4KXnq5F2yWzZJbo5NwHJl/xBFJfaqJdcSZPwj
 QC5uxOxb+1G/7WqZf1zkBkZ3Txv3JAEg4GCr6RqhjR2HN3TZbziOzuFlCf3K225mgRRX
 sueA==
X-Gm-Message-State: AOJu0Yx/DiCXJpu2KclHBw/IS9Ct91ioVqfU/QrMf4cWgxepFgopYiGn
 xgsnv94UT7XfrOQ3MI55kf1WbYDCakQmWHqbIZdXFqnJ6HcvcTMOev5jPN1WJxweaPpeLav2f42
 yorS93hfy0KmGZlOF9vr7IeW2WVlYHFEDbijvH5OvZxgIrhWcFsw92uTYBij2t7ciuuod8daCgv
 LU4ync0fJbdQ0K05z4MDkhSmiEdCjAACmomRU=
X-Google-Smtp-Source: AGHT+IFQQ9YZMoX0ZMrrP+p1npcnsCJjUs8Y262JyoJ75fqq4xrKIFdV5u3LRiZGW12xibCgVRtyqUfm0fo=
X-Received: from dlah10.prod.google.com ([2002:a05:701b:260a:b0:11f:4424:33c4])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:987:b0:11b:ca88:c4f7
 with SMTP id a92af1059eb24-12172309d60mr2088850c88.40.1766127883124; Thu, 18
 Dec 2025 23:04:43 -0800 (PST)
Date: Fri, 19 Dec 2025 07:04:16 +0000
In-Reply-To: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Mime-Version: 1.0
References: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251219-aspeed-sgpio-v5-3-fd5593178144@google.com>
Subject: [PATCH v5 3/6] hw/gpio/aspeed_sgpio: Implement SGPIO interrupt
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3C_lEaQYKCmIYUBINZGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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
 hw/gpio/aspeed_sgpio.c         | 126 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
index 60279a597c722f94fba406d60cb30a52ef9544bc..8a11a9998c013cb2e4be99690ecd7bcd9dcb5815 100644
--- a/include/hw/gpio/aspeed_sgpio.h
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -58,7 +58,9 @@ struct AspeedSGPIOState {
 
     /*< public >*/
     MemoryRegion iomem;
+    int pending;
     qemu_irq irq;
+    qemu_irq sgpios[ASPEED_SGPIO_MAX_PIN_PAIR];
     uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
     uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
 };
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 927c711cb3aef889c47c9a9156fe4241981c5efa..a058a3edcabd346a048e2b61740a3972a5e5a871 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -12,9 +12,130 @@
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
+        /* Update the control register. */
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
+static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
+                                                      uint32_t reg)
+{
+    uint32_t idx = reg - R_SGPIO_INT_STATUS_0;
+    if (idx >= ASPEED_SGPIO_MAX_INT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                         "%s: interrupt status index: %d, out of bounds\n",
+                         __func__, idx);
+        return 0;
+    }
+    return s->int_regs[idx];
+}
+
 static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
                                 uint32_t reg)
 {
@@ -38,7 +159,7 @@ static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
                       __func__, idx);
         return;
     }
-    s->ctrl_regs[idx] = data;
+    aspeed_sgpio_update(s, idx, data);
 }
 
 static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
@@ -52,6 +173,7 @@ static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
 
     switch (reg) {
     case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
+        value = aspeed_sgpio_2700_read_int_status_reg(s, reg);
         break;
     case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
         value = aspeed_sgpio_2700_read_control_reg(s, reg);
@@ -116,7 +238,7 @@ static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
     } else {
         value &= ~bit_mask;
     }
-    s->ctrl_regs[pin >> 1] = value;
+    aspeed_sgpio_update(s, pin >> 1, value);
 }
 
 static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,

-- 
2.52.0.351.gbe84eed79e-goog


