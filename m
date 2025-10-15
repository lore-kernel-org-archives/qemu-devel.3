Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E14CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 01:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8qAK-0000Tv-4I; Tue, 14 Oct 2025 21:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cvbuaAkKCmkSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com>)
 id 1v8qAH-0000TN-M9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:54 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cvbuaAkKCmkSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA9-0003EF-El
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:52 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-27eeb9730d9so109929325ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760491123; x=1761095923; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7/3ZvEpKFWHtnVX2g4BdVcaLMqo1fyjcOBAgiuCIWc=;
 b=OB+W8QRY2sfBoBKrOVcMUMSN4HGI9oponbyMhUJTXIyJkovWL+VaPDv9ighQsZJxcN
 mccGaKHhy8gGigharufFNOtIULacv9y4caBz9aJC1GZFU1Ifp2aBt4xDP4Nfyj0iMqWX
 KjOIN+b/DMAdMVerjnunF+8eanzFwnIGmOnqyB7k+jA84sOJQbbDSpAK7WgEcne6G/K7
 N2o7nihzZQjQFWI9zWoup6LaJ7rO7APf+Irb0fCUi6ZYut5lEjiiCDN35rrGwn62exWE
 /orBaN7f1dYE/a5e3IB4JT0/csS1QdtF5xLPnFMuzp1ZWVzchJvxAu7jkSkU1FoFODhr
 rcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760491123; x=1761095923;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7/3ZvEpKFWHtnVX2g4BdVcaLMqo1fyjcOBAgiuCIWc=;
 b=UtmTRbBFHtX2Pi+bSMhYExwkjMKHTJLEMPQB70VakuzQQdWuQustvABXc02WDYXhRV
 xIz57p1+EyNElMyiM7UXrTdREkPlawUgVWSEU3JRl+6kUKba2+YPKN9Mq8d6++0zin0g
 wpZdq8RAcgMai+sTggVX+MxwEYbFte0H2D5IvbzNGjNEYPnPsAn7AM9LxDnLBuvqDVpp
 UjGHgJis5O8JdXOhlM5Fce5D/vje95lAuc290GASIyaqldCFrRw5wXTgy/htPob8FFLE
 Z3IOQnatjot7f+gAxRtg8awmRSP08yt6O4hXoM1vWjo+W25zJ51uPBnT6nnu9MaZep88
 1uug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbmvi3MTyl4M8pKBCJGDRmjWigVWdWyhPhGBmjFdXDqKdMJrpXbKEnrItAlxbVGyxS9T6Oyq0E/Jjd@nongnu.org
X-Gm-Message-State: AOJu0YxJEkB0zxWs0+XVytVrdIvfLCHzXoqtHB7h6j+taiLY1U81irAz
 ohiEPC21o4sOVoo0qsJvIJZ1xNQT1Y3GXyyzeg7EqXfe4VcuAV8IT3olF2tCARNvm19KQnd8TmZ
 40SCVo8tCHqpp5NEJ7w==
X-Google-Smtp-Source: AGHT+IEAdrtGFaLFJ2pKtaMTcnKO4Iux0rfrD29OGpC4I1D/3asjXup5T3qscAu9V0fIZzl8UTisLBOAAM0/SSQ=
X-Received: from plsq3.prod.google.com ([2002:a17:902:bd83:b0:27e:ec80:30c6])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d54c:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-29027356c83mr273672705ad.4.1760491122665; 
 Tue, 14 Oct 2025 18:18:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:29 +0000
In-Reply-To: <20251015011830.1688468-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20251015011830.1688468-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015011830.1688468-6-lixiaoyan@google.com>
Subject: [PATCH v2 5/5] hw/gpio/npcm8xx: Implement npcm sgpio device input pin
 logic
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, philmd@linaro.org, 
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3cvbuaAkKCmkSPePHVfHUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--lixiaoyan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

Signed-off-by: Coco Li <lixiaoyan@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/gpio/npcm8xx_sgpio.c          | 119 +++++++++++++++++---
 include/hw/gpio/npcm8xx_sgpio.h  |   4 +-
 tests/qtest/npcm8xx_sgpio-test.c | 180 ++++++++++++++++++++++++++-----
 3 files changed, 259 insertions(+), 44 deletions(-)

diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c
index f7d6bbf672..fac24a2d8e 100644
--- a/hw/gpio/npcm8xx_sgpio.c
+++ b/hw/gpio/npcm8xx_sgpio.c
@@ -22,11 +22,14 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "trace.h"
 
+#include <limits.h>
+
 #define NPCM8XX_SGPIO_RD_MODE_MASK      0x6
 #define NPCM8XX_SGPIO_RD_MODE_PERIODIC  0x4
 #define NPCM8XX_SGPIO_RD_MODE_ON_DEMAND 0x0
@@ -126,24 +129,67 @@ static uint64_t npcm8xx_sgpio_regs_read_with_cfg(NPCM8xxSGPIOState *s,
     if (rd_word) {
         value = ((uint16_t)s->regs[reg] << 8) | s->regs[reg + 1];
     } else {
-        value = s->regs[reg];
+        value = (uint8_t) s->regs[reg];
     }
 
     return value;
 }
 
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
+        sts = p[i] & d[i] & (uint8_t)half_unshuffle32(type);
+        /* 1-0 transitions */
+        sts |= (~p[i]) & (d[i] & (uint8_t)half_unshuffle32(type >> 1));
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
@@ -159,7 +205,7 @@ static void npcm8xx_sgpio_update_pins_out(NPCM8xxSGPIOState *s, hwaddr reg)
                       "%s: Accessing XDOUT%d when NOUT is %d\n",
                       DEVICE(s)->canonical_path, dout, nout);
     }
-    s->pin_out_level[dout] = s->regs[NPCM8XX_SGPIO_XDOUT0 + dout];
+    p[dout] = s->regs[reg];
     /* unset WR_PEND */
     s->regs[NPCM8XX_SGPIO_IOXCTS] &= ~0x40;
 }
@@ -294,10 +340,8 @@ static void npcm8xx_sgpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
             }
             s->regs[reg] ^= hi_val;
             s->regs[reg + 1] ^= value;
-            npcm8xx_sgpio_update_event(s, 0);
         } else {
             s->regs[reg] ^= value;
-            npcm8xx_sgpio_update_event(s, 0);
         }
         break;
 
@@ -371,19 +415,70 @@ static void npcm8xx_sgpio_hold_reset(Object *obj, ResetType type)
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
@@ -391,10 +486,8 @@ static const VMStateDescription vmstate_npcm8xx_sgpio = {
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
2.51.0.788.g6d19910ace-goog


