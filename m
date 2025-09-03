Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAA8CA1012
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 22:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utvrI-0005EJ-5P; Wed, 03 Sep 2025 18:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ULW4aAkKCukWTiTLZjLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--lixiaoyan.bounces.google.com>)
 id 1utvBV-0005nG-BW
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:30 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ULW4aAkKCukWTiTLZjLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--lixiaoyan.bounces.google.com>)
 id 1utvBS-0003VC-AS
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 17:38:29 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-329e0a8337bso274590a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756935504; x=1757540304; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uenE3pCs9FFLs4/r5/tRBI0mdODh/rTI3ufCG8qlWUc=;
 b=fovB0piapkICOunFVfS8WUanMltWW2C6hKsiVb7iDLj6CI/K+Olmy37wmUS14NbtWl
 g7BfoQRKlcFRmJwnx+XsC0BY7cjZluEw4U0QENQ7sRQAAHBMfDhfCrA37s/XgkG3MXFD
 ATPfkpuWU5D++VuO3A0nuhp9SAQjZBilf0yN9uhf2be8Q/HEQnep7R6Md1lY9wdlXAko
 WLA2zWzm0stT5CqIAjhM34bjx0EiXjUEXMrGSp4jdWs9UNTWqzd3Acd0Yj7UqxGPLKw1
 /CB4xY8U/gJD6X0TUrawjNV8ZeFXquzt85afh7r1+jOEDhFcrQ6sRVdTxq4fECyH89GO
 JTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756935504; x=1757540304;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uenE3pCs9FFLs4/r5/tRBI0mdODh/rTI3ufCG8qlWUc=;
 b=SXqzSOBvyGM9Kf7H6i3h8bwPJxYSBgEKOddpmefRcDJ2QUSTDbQ4FISWiSJmKDbDl3
 FeCVoVxSIFEr+XgKjntHabZlTPyXxxY8g+5LTbHLnEXFc1mWg1CIM5IjuA/g3HuoUD7E
 kx8PbH+os85klSIDSRoOT/KYKVY/ru6gMkorivzCxOlZ6eloBpw+tzlFEiqj6qHPnL/v
 a/EOQUKDBRPtyjgDz1fssXcWrTgPiw5iV7Wkjok3A6MB3T5PtlqiS2iRIPw4vLSpH19F
 LcIWHrMkH8onmn7eno+TSmEwE+yRXRpWPj4PgOQQMWXjCufjD6Hxmk2HA4U1bKOyCKgQ
 sgPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkCLk7jwSvs12HfwAN1TcvlZDF3tEq+1Pn7tFbrtAD8iw1Z3lPNePRlX5QPbVn8Oxdbyxy8oqvksMO@nongnu.org
X-Gm-Message-State: AOJu0YyAhCKoUvUq1/676DUC4HhB03UG1F2YYEY7AcS1iue+/+iyK9Uh
 50/MYzy42qQwne7tUtWKUBTg7zGQizdVNBdzVbXOvxjRR/UkklvoK1zifzfIEE9HKbO62KpYfTi
 K2zGQuBPuNkvybJPjhg==
X-Google-Smtp-Source: AGHT+IFzkBNCdy6eibxjF6MXhtuU316d2um/jbsuFzeTSjnQJ5OvEJi+GeYPKX5HSN4hQVbLfPxOtLOlX7cxeKQ=
X-Received: from pjbpm4.prod.google.com ([2002:a17:90b:3c44:b0:327:e9ca:a5ae])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3810:b0:321:c85d:dd93 with SMTP id
 98e67ed59e1d1-32815412be5mr23616491a91.4.1756935504281; 
 Wed, 03 Sep 2025 14:38:24 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:38:09 +0000
In-Reply-To: <20250903213809.3779860-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250903213809.3779860-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903213809.3779860-6-lixiaoyan@google.com>
Subject: [PATCH 5/5] hw/gpio/npcm8xx: Implement npcm sgpio device input pin
 logic
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Coco Li <lixiaoyan@google.com>,
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3ULW4aAkKCukWTiTLZjLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--lixiaoyan.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.938, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Sep 2025 18:21:29 -0400
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

Signed-off-by: Coco Li <lixiaoyan@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/gpio/npcm8xx_sgpio.c          | 134 ++++++++++++++++++++---
 include/hw/gpio/npcm8xx_sgpio.h  |   4 +-
 tests/qtest/npcm8xx_sgpio-test.c | 180 ++++++++++++++++++++++++++-----
 3 files changed, 274 insertions(+), 44 deletions(-)

diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c
index f7d6bbf672..3b626a44e5 100644
--- a/hw/gpio/npcm8xx_sgpio.c
+++ b/hw/gpio/npcm8xx_sgpio.c
@@ -27,6 +27,8 @@
 #include "qemu/units.h"
 #include "trace.h"
 
+#include <limits.h>
+
 #define NPCM8XX_SGPIO_RD_MODE_MASK      0x6
 #define NPCM8XX_SGPIO_RD_MODE_PERIODIC  0x4
 #define NPCM8XX_SGPIO_RD_MODE_ON_DEMAND 0x0
@@ -126,24 +128,83 @@ static uint64_t npcm8xx_sgpio_regs_read_with_cfg(NPCM8xxSGPIOState *s,
     if (rd_word) {
         value = ((uint16_t)s->regs[reg] << 8) | s->regs[reg + 1];
     } else {
-        value = s->regs[reg];
+        value = (uint8_t) s->regs[reg];
     }
 
     return value;
 }
 
+static uint8_t get_even_bits(uint16_t n)
+{
+    n &= 0x5555;
+
+    n = (n | (n >> 1)) & 0x3333;
+    n = (n | (n >> 2)) & 0x0F0F;
+    n = (n | (n >> 4)) & 0x00FF;
+
+    return (uint8_t)n;
+}
+
+static uint8_t get_odd_bits(uint16_t n)
+{
+    return get_even_bits(n >> 1);
+}
+
+/*
+ *  For each pin, event can be generated from one of 3 conditions.
+ *
+ *  | 1 | 0 | event configuration
+ *  -----------------------------
+ *  | 0 | 0 | disabled
+ *  | 0 | 1 | 0-1 transition
+ *  | 1 | 0 | 1-0 transition
+ *  | 1 | 1 | even by any transition
+ */
+
 static void npcm8xx_sgpio_update_event(NPCM8xxSGPIOState *s, uint64_t diff)
 {
-    /* TODO in upcoming patch */
+    uint8_t *d = (uint8_t *)&(diff);
+    uint8_t *p = (uint8_t *)&s->pin_in_level;
+    uint16_t type;
+    uint8_t sts;
+    int i;
+
+    for (i = 0; i < npcm8xx_sgpio_get_in_port(s); ++i) {
+        type = ((uint16_t)s->regs[NPCM8XX_SGPIO_XEVCFG0 + 2 * i] << 8) |
+                        s->regs[NPCM8XX_SGPIO_XEVCFG0 + 2 * i + 1];
+
+        /* 0-1 transitions */
+        sts = p[i] & d[i] & get_even_bits(type);
+        /* 1-0 transitions */
+        sts |= (~p[i]) & (d[i] & get_odd_bits(type));
+
+        s->regs[NPCM8XX_SGPIO_XEVSTS0 + i] = sts;
+
+        /* Generate event if the event status register tells us so */
+        qemu_set_irq(s->irq, !!(s->regs[NPCM8XX_SGPIO_XEVSTS0 + i]));
+    }
 }
 
-static void npcm8xx_sgpio_update_pins_in(NPCM8xxSGPIOState *s, uint64_t diff)
+static void npcm8xx_sgpio_update_pins_in(NPCM8xxSGPIOState *s, uint64_t value)
 {
-    /* TODO in upcoming patch */
+    uint8_t *nv = (uint8_t *)&value;
+    uint8_t *ov = (uint8_t *)&s->pin_in_level;
+    uint64_t diff = s->pin_in_level ^ value;
+    int i;
+
+    for (i = 0; i < npcm8xx_sgpio_get_in_port(s); ++i) {
+        if (ov[i] == nv[i]) {
+            continue;
+        }
+        s->regs[NPCM8XX_SGPIO_XDIN0 + i] = nv[i];
+    }
+    s->pin_in_level = value;
+    npcm8xx_sgpio_update_event(s, diff);
 }
 
 static void npcm8xx_sgpio_update_pins_out(NPCM8xxSGPIOState *s, hwaddr reg)
 {
+    uint8_t *p = (uint8_t *)&s->pin_out_level;
     uint8_t nout, dout;
 
     if (~(s->regs[NPCM8XX_SGPIO_IOXCTS] & NPCM8XX_SGPIO_IOXCTS_IOXIF_EN)) {
@@ -159,7 +220,7 @@ static void npcm8xx_sgpio_update_pins_out(NPCM8xxSGPIOState *s, hwaddr reg)
                       "%s: Accessing XDOUT%d when NOUT is %d\n",
                       DEVICE(s)->canonical_path, dout, nout);
     }
-    s->pin_out_level[dout] = s->regs[NPCM8XX_SGPIO_XDOUT0 + dout];
+    p[dout] = s->regs[reg];
     /* unset WR_PEND */
     s->regs[NPCM8XX_SGPIO_IOXCTS] &= ~0x40;
 }
@@ -294,10 +355,8 @@ static void npcm8xx_sgpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
             }
             s->regs[reg] ^= hi_val;
             s->regs[reg + 1] ^= value;
-            npcm8xx_sgpio_update_event(s, 0);
         } else {
             s->regs[reg] ^= value;
-            npcm8xx_sgpio_update_event(s, 0);
         }
         break;
 
@@ -371,19 +430,70 @@ static void npcm8xx_sgpio_hold_reset(Object *obj, ResetType type)
 {
     NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
 
-    npcm8xx_sgpio_update_pins_in(s, -1);
+    npcm8xx_sgpio_update_pins_in(s, 0);
+}
+
+static void npcm8xx_sgpio_set_input_lo(void *opaque, int line, int level)
+{
+    NPCM8xxSGPIOState *s = opaque;
+
+    g_assert(line >= 0 && line < NPCM8XX_SGPIO_NR_PINS / 2);
+
+    npcm8xx_sgpio_update_pins_in(s, BIT(line) && level);
+}
+
+static void npcm8xx_sgpio_set_input_hi(void *opaque, int line, int level)
+{
+    NPCM8xxSGPIOState *s = opaque;
+    uint64_t line_ull = line;
+
+    g_assert(line >= NPCM8XX_SGPIO_NR_PINS / 2 && line < NPCM8XX_SGPIO_NR_PINS);
+
+    npcm8xx_sgpio_update_pins_in(s, BIT(line_ull << 32) && level);
+}
+
+static void npcm8xx_sgpio_get_pins_in(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+
+    visit_type_uint64(v, name, &s->pin_in_level, errp);
+}
+
+static void npcm8xx_sgpio_set_pins_in(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+    uint64_t new_pins_in;
+
+    if (!visit_type_uint64(v, name, &new_pins_in, errp)) {
+        return;
+    }
+
+    npcm8xx_sgpio_update_pins_in(s, new_pins_in);
 }
 
 static void npcm8xx_sgpio_init(Object *obj)
 {
     NPCM8xxSGPIOState *s = NPCM8XX_SGPIO(obj);
+    DeviceState *dev = DEVICE(obj);
 
     memory_region_init_io(&s->mmio, obj, &npcm8xx_sgpio_regs_ops, s,
                           "regs", NPCM8XX_SGPIO_REGS_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
-    /* TODO: Add input GPIO pins */
+    /* There are total 64 input pins that can be set */
+    QEMU_BUILD_BUG_ON(NPCM8XX_SGPIO_NR_PINS >
+                      sizeof(s->pin_in_level) * CHAR_BIT);
+    qdev_init_gpio_in(dev, npcm8xx_sgpio_set_input_hi,
+                      NPCM8XX_SGPIO_NR_PINS / 2);
+    qdev_init_gpio_in(dev, npcm8xx_sgpio_set_input_lo,
+                      NPCM8XX_SGPIO_NR_PINS / 2);
+
+    object_property_add(obj, "sgpio-pins-in", "uint64",
+                        npcm8xx_sgpio_get_pins_in, npcm8xx_sgpio_set_pins_in,
+                        NULL, NULL);
 }
 
 static const VMStateDescription vmstate_npcm8xx_sgpio = {
@@ -391,10 +501,8 @@ static const VMStateDescription vmstate_npcm8xx_sgpio = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(pin_in_level, NPCM8xxSGPIOState,
-                            NPCM8XX_SGPIO_NR_PINS / NPCM8XX_SGPIO_MAX_PORTS),
-        VMSTATE_UINT8_ARRAY(pin_out_level, NPCM8xxSGPIOState,
-                            NPCM8XX_SGPIO_NR_PINS / NPCM8XX_SGPIO_MAX_PORTS),
+        VMSTATE_UINT64(pin_in_level, NPCM8xxSGPIOState),
+        VMSTATE_UINT64(pin_out_level, NPCM8xxSGPIOState),
         VMSTATE_UINT8_ARRAY(regs, NPCM8xxSGPIOState, NPCM8XX_SGPIO_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/include/hw/gpio/npcm8xx_sgpio.h b/include/hw/gpio/npcm8xx_sgpio.h
index cce844951e..05dfafcb5e 100644
--- a/include/hw/gpio/npcm8xx_sgpio.h
+++ b/include/hw/gpio/npcm8xx_sgpio.h
@@ -34,8 +34,8 @@ typedef struct NPCM8xxSGPIOState {
     MemoryRegion mmio;
     qemu_irq irq;
 
-    uint8_t pin_in_level[NPCM8XX_SGPIO_MAX_PORTS];
-    uint8_t pin_out_level[NPCM8XX_SGPIO_MAX_PORTS];
+    uint64_t pin_in_level;
+    uint64_t pin_out_level;
     uint8_t regs[NPCM8XX_SGPIO_NR_REGS];
 } NPCM8xxSGPIOState;
 
diff --git a/tests/qtest/npcm8xx_sgpio-test.c b/tests/qtest/npcm8xx_sgpio-test.c
index b0b11b3481..b26109600c 100644
--- a/tests/qtest/npcm8xx_sgpio-test.c
+++ b/tests/qtest/npcm8xx_sgpio-test.c
@@ -36,65 +36,187 @@
 #define GP_N_IOXIF_EN  0x80
 
 
+static void qtest_qom_set_uint64(QTestState *s, const char *path,
+                                 const char *property, uint64_t value)
+{
+    QDict *r;
+    QDict *qdict;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-set', 'arguments': "
+                     "{ 'path': %s, 'property': %s, 'value': %" PRIu64 " } }",
+                     path, property, value);
+
+    qdict = qdict_get_qdict(r, "error");
+    if (qdict) {
+        printf("DEBUG: set error: %s\n", qdict_get_try_str(qdict, "desc"));
+    }
+
+    qobject_unref(r);
+}
+
+
+static uint64_t qtest_qom_get_uint64(QTestState *s, const char *path,
+                                     const char *property)
+{
+    QDict *r;
+
+    uint64_t res;
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+
+    res = qdict_get_uint(r, "return");
+    qobject_unref(r);
+
+    return res;
+}
+
 /* Restore the SGPIO controller to a sensible default state. */
-static void sgpio_reset(int n)
+static void sgpio_reset(QTestState *s, int n)
 {
     int i;
 
     for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
-        writel(SGPIO(n) + GP_N_XDOUT(i), 0x00000000);
-        writel(SGPIO(n) + GP_N_XEVCFG(i), 0x00000000);
-        writel(SGPIO(n) + GP_N_XEVSTS(i), 0x00000000);
+        qtest_writeq(s, SGPIO(n) + GP_N_XDOUT(i), 0x0);
+        qtest_writeq(s, SGPIO(n) + GP_N_XEVCFG(i), 0x0);
+        qtest_writeq(s, SGPIO(n) + GP_N_XEVSTS(i), 0x0);
     }
-    writel(SGPIO(n) + GP_N_IOXCTS, 0x00000000);
-    writel(SGPIO(n) + GP_N_IOXINDR, 0x00000000);
-    writel(SGPIO(n) + GP_N_IOXCFG1, 0x00000000);
-    writel(SGPIO(n) + GP_N_IOXCFG2, 0x00000000);
+    qtest_writeq(s, SGPIO(n) + GP_N_IOXCTS, 0x0);
+    qtest_writeq(s, SGPIO(n) + GP_N_IOXINDR, 0x0);
+    qtest_writeq(s, SGPIO(n) + GP_N_IOXCFG1, 0x0);
+    qtest_writeq(s, SGPIO(n) + GP_N_IOXCFG2, 0x0);
 }
 
-static void test_read_dout_byte(void)
+static void test_read_dout_byte(const char *machine)
 {
+    QTestState *s = qtest_init(machine);
     int i;
 
-    sgpio_reset(0);
+    sgpio_reset(s, 0);
 
     /* set all 8 output devices */
-    writel(SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
+    qtest_writeq(s, SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
     for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
-        writel(SGPIO(0) + GP_N_XDOUT(i), 0xff);
-        g_assert_cmphex(readb(SGPIO(0) + GP_N_XDOUT(i)), ==, 0xff);
+        qtest_writeq(s, SGPIO(0) + GP_N_XDOUT(i), 0xff);
+        g_assert_cmphex(qtest_readb(s, SGPIO(0) + GP_N_XDOUT(i)), ==, 0xff);
     }
+    qtest_quit(s);
 }
 
-static void test_read_dout_word(void)
+static void test_read_dout_word(const char *machine)
 {
+    QTestState *s = qtest_init(machine);
     int i;
 
-    sgpio_reset(0);
+    sgpio_reset(s, 0);
     /* set all 8 output devices */
-    writel(SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
+    qtest_writeq(s, SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES << 4);
     /* set 16 bit aligned access */
-    writel(SGPIO(0) + GP_N_IOXCTS, 1 << 3);
+    qtest_writeq(s, SGPIO(0) + GP_N_IOXCTS, 1 << 3);
     for (i = 0; i < NR_SGPIO_DEVICES / 2; ++i) {
-        writel(SGPIO(0) + GP_N_XDOUT(i * 2), 0xf0f0);
-        g_assert_cmphex(readw(SGPIO(0) + GP_N_XDOUT(i * 2)), ==, 0xf0f0);
+        qtest_writeq(s, SGPIO(0) + GP_N_XDOUT(i * 2), 0xf0f0);
+        g_assert_cmphex(qtest_readw(s, SGPIO(0) + GP_N_XDOUT(i * 2)),
+                        ==, 0xf0f0);
     }
+    qtest_quit(s);
 }
 
-int main(int argc, char **argv)
+static void test_events_din_rising_edge(const char *machine)
 {
-    int ret;
+    QTestState *s = qtest_init(machine);
+    const char path[] = "/machine/soc/sgpio[0]";
+    int i;
+
+    /* clear all inputs */
+    sgpio_reset(s, 0);
+
+    /* set all 8 input devices */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES);
+
+    /* set event detection type to be on the rising edge*/
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        qtest_writel(s, SGPIO(0) + GP_N_XEVCFG(i), 0x5555);
+    }
+    /* Set periodic reading mode, the only accepted mode */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCTS, GP_N_RD_MODE_PERIODIC);
+    /* enable device, set IOXIF_EN */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCTS,
+                 GP_N_IOXIF_EN | GP_N_RD_MODE_PERIODIC);
+
+    qtest_irq_intercept_in(s, "/machine/soc/gic");
+
+    /* raise all input pin values */
+    qtest_qom_set_uint64(s, path, "sgpio-pins-in", 0xffffffffffffffff);
+    g_assert(qtest_qom_get_uint64(s, path, "sgpio-pins-in")
+                                  == 0xffffffffffffffff);
+
+    /* set event status to implicitly change pins */
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        g_assert_cmphex(qtest_readb(s, SGPIO(0) + GP_N_XDIN(i)), ==, 0xff);
+        g_assert_cmphex(qtest_readb(s, SGPIO(0) + GP_N_XEVSTS(i)), ==, 0xff);
+        g_assert_true(qtest_get_irq(s, SGPIO_IRQ(0)));
+    }
 
+    qtest_quit(s);
+}
+
+static void test_events_din_falling_edge(const char *machine)
+{
+    QTestState *s = qtest_init(machine);
+    const char path[] = "/machine/soc/sgpio[0]";
+    int i;
+
+    /* clear all inputs */
+    sgpio_reset(s, 0);
+
+    /* set all 8 input devices */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCFG2, NR_SGPIO_DEVICES);
+
+    /* set event detection type to be on the falling edge*/
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        qtest_writel(s, SGPIO(0) + GP_N_XEVCFG(i), 0xaaaa);
+    }
+    /* Set periodic reading mode, the only accepted mode */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCTS, GP_N_RD_MODE_PERIODIC);
+    /* enable device, set IOXIF_EN */
+    qtest_writel(s, SGPIO(0) + GP_N_IOXCTS,
+                 GP_N_IOXIF_EN | GP_N_RD_MODE_PERIODIC);
+
+    qtest_irq_intercept_in(s, "/machine/soc/gic");
+
+    /* raise all input pin values */
+    qtest_qom_set_uint64(s, path, "sgpio-pins-in", 0xffffffffffffffff);
+    g_assert(qtest_qom_get_uint64(s, path, "sgpio-pins-in")
+                                  == 0xffffffffffffffff);
+
+    /* reset all input pin values */
+    qtest_qom_set_uint64(s, path, "sgpio-pins-in", 0x0);
+    g_assert(qtest_qom_get_uint64(s, path, "sgpio-pins-in") == 0x0);
+
+    /* set event status to implicitly change pins */
+    for (i = 0; i < NR_SGPIO_DEVICES; ++i) {
+        g_assert_cmphex(qtest_readb(s, SGPIO(0) + GP_N_XDIN(i)), ==, 0x00);
+        g_assert_cmphex(qtest_readb(s, SGPIO(0) + GP_N_XEVSTS(i)), ==, 0xff);
+        g_assert_true(qtest_get_irq(s, SGPIO_IRQ(0)));
+    }
+
+    qtest_quit(s);
+}
+
+
+static void test_npcm8xx(void)
+{
+    test_read_dout_byte("-machine npcm845-evb");
+    test_read_dout_word("-machine npcm845-evb");
+    test_events_din_rising_edge("-machine npcm845-evb");
+    test_events_din_falling_edge("-machine npcm845-evb");
+}
+
+int main(int argc, char **argv)
+{
     g_test_init(&argc, &argv, NULL);
     g_test_set_nonfatal_assertions();
 
-    qtest_add_func("/npcm8xx_sgpio/read_dout_byte", test_read_dout_byte);
-    qtest_add_func("/npcm8xx_sgpio/read_dout_word", test_read_dout_word);
-
-    qtest_start("-machine npcm845-evb");
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/sgpio");
-    ret = g_test_run();
-    qtest_end();
+    qtest_add_func("/npcm8xx/sgpio", test_npcm8xx);
 
-    return ret;
+    return g_test_run();
 }
-- 
2.51.0.338.gd7d06c2dae-goog


