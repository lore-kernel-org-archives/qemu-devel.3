Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC824CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV8-000117-T8; Mon, 18 May 2026 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUZ-0000hS-P7
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUX-0000YC-8N
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso21784625e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089657; x=1779694457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS1TMnSMRJpnFpD1jJViJlPRsbWAM8DwAhvXkzKtqqo=;
 b=hTF66AYeDIs7Uk1ldslMFCYZGNA39cJuM9tQI8v5jW8ON3XDYn0eWp8cVjAHV5WnI6
 2+2zAqPDFP1RGQSzABHovgRv1TWhrcc7MN/9sCpTZWmmu2k4D8+/EH7stp8IZl8OF34r
 SMNfX/lVbCZnXSpYOy4kAJF/rYk7XTitkzJuD2TGNXSFUNoMqUGCRw9g85VIdSJIkWcE
 y3et0AtaVXKD99J12Pt/a6K24xfljhA7OAlqG9PQrZpB9jeVr/C+raKHOY23FRvw7loE
 Ic1+N9tKxHIaj2loXGkHu/rTJr0bpm+hyLP8Xe1GUU9aWDJz9EwfYHqWpWF5jqNR2JQs
 zwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089657; x=1779694457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XS1TMnSMRJpnFpD1jJViJlPRsbWAM8DwAhvXkzKtqqo=;
 b=QwTmxocOC45lIkVBsqbMblu7Aa9pM3+78yR/ArGbjPjARUQ0NXMSHkUBqvCfBPI4MB
 jKvIi+4IpOat2XH3saF/ZL6UspjFa4TflgQ9T8y6OQ5LdQGrqvEN+n6Mnrl/n8GoAgJE
 7+XPeLpuDpEegGEmeMFaYLs5btvDkVteIhNEgP5Tbb5/QfEoizM1/Gu5a/Q643pXoruX
 ACo4TLPMKelZyt5BhRAMBTPZfFgSlzkYEP7Ig27R6H4ZUH/VwqjDUfycGKSsruI4p2HS
 xOrlJZqdowYvhK1kE1r+dshpaq3T4N6sIr3WskxH5Cj32HEGQ0ZXYKnXIJlrBcLMpOqC
 4Yag==
X-Gm-Message-State: AOJu0YyV45paBmt2yTghy3M9wPe0wwRPr6UGlZCxc2WsoZf1cFIBNWA0
 SibBTpQRabHEJtv7d1xxBnIZ+55ItEfA6Ovbs86UuYD3B4zIiZ22955YyFhl8mWb
X-Gm-Gg: Acq92OFKvEvGm8zbeBTt9ImLEIeeI1TTl9qlRyrG3jB2T2OSDciKS2Wyab5dqdmnULU
 tNlzCK4ruGu/VPRznGJbMzIbrSJ441zU8MkIYR+ACXol3ITEJETklSoICne8mDJyiEjS2ZZj5Mw
 VcMinDZJVfeIFHqESckRPmeHFohp4nYV5U2+5Gas8gF8x/HwECmoatfbz7frhvj3S/FqsmsQ1QI
 JnN1aVxRtrogLlQy0M53RWQ8DBuv+588P3gSCM+9kLZrXnTXfb2msixHaMwgGC68NQSRIpQ36Vn
 bEZfIz0csX2H5zRQllxuQRvZ5AqdYKQexviLAu1bK08D+2MyFeaQ6f+jXXp5V740TZDLjfuINtl
 HRvSBmYP2wKcH4/02pq2uP1IB16sToSqilmblID3SjtXo5Qu06L0KpIh8RnwANrUTaRAkh1L2q4
 6zhslRalw6BGYbgxjSi3Yd79R7SsO9JPQXGTkPeuR4VZ4DQg==
X-Received: by 2002:a05:600c:a010:b0:48f:e230:2a1e with SMTP id
 5b1f17b1804b1-48fe66316cfmr200677175e9.33.1779089656634; 
 Mon, 18 May 2026 00:34:16 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:16 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 13/16] hw/timer,
 cpu: Add Clock API support to A9MPCore timers
Date: Mon, 18 May 2026 09:33:58 +0200
Message-ID: <20260518073401.11279-14-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

Add a clock input to a9gtimer, arm_mptimer and a9mpcore. a9mpcore
distributes the clock to the other timers. If no clock is
connected, falls back to 100 MHz for backward compatibility with
existing machine types.

Frequency calculation now uses the input clock and prescaler
values according to ARM Cortex-A9 MPCore Technical Reference Manual.

More information about the A9MPCore timers can be found here:
https://developer.arm.com/documentation/ddi0407/c/timers-and-watchdog-registers?lang=en

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c           |  1 +
 hw/cpu/a9mpcore.c              | 12 ++++++++++++
 hw/timer/a9gtimer.c            | 18 +++++++++++++++---
 hw/timer/arm_mptimer.c         | 20 +++++++++++++++-----
 include/hw/cpu/a9mpcore.h      |  1 +
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 7 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 52c9e41a76..5aac215c27 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -271,6 +271,7 @@ static void zynq_init(MachineState *machine)
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
+    qdev_connect_clock_in(dev, "clk", qdev_get_clock_out(slcr, "cpu_3x2x"));
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 2127f95578..5ffdc9277b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -14,6 +14,8 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/clock.h"
 #include "hw/core/cpu.h"
 #include "target/arm/cpu-qom.h"
 
@@ -42,6 +44,13 @@ static void a9mp_priv_initfn(Object *obj)
     object_initialize_child(obj, "mptimer", &s->mptimer, TYPE_ARM_MPTIMER);
 
     object_initialize_child(obj, "wdt", &s->wdt, TYPE_ARM_MPTIMER);
+
+    /*
+     * Register a clock input. If no clock is connected the
+     * frequency falls back to 100 MHz for backward compatibility.
+     */
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL, 0);
+    clock_set_ns(s->clk, 10);
 }
 
 static void a9mp_priv_realize(DeviceState *dev, Error **errp)
@@ -103,6 +112,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
+    qdev_connect_clock_in(gtimerdev, "clk", s->clk);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), errp)) {
         return;
     }
@@ -110,6 +120,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
+    qdev_connect_clock_in(mptimerdev, "clk", s->clk);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
@@ -117,6 +128,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
+    qdev_connect_clock_in(wdtdev, "clk", s->clk);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), errp)) {
         return;
     }
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 3a086915c8..c9ffb4e2c1 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -24,6 +24,9 @@
 #include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/clock.h"
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -63,9 +66,10 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
 static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
 {
     uint64_t prescale = extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
-                                  R_CONTROL_PRESCALER_LEN);
-
-    return (prescale + 1) * 10;
+                                  R_CONTROL_PRESCALER_LEN) + 1;
+    uint64_t clk_hz = clock_get_hz(s->clk);
+    assert(clk_hz != 0);
+    return muldiv64(prescale, NANOSECONDS_PER_SECOND, clk_hz);
 }
 
 static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
@@ -295,6 +299,13 @@ static void a9_gtimer_reset(DeviceState *dev)
     a9_gtimer_update(s, false);
 }
 
+static void a9_gtimer_init(Object *obj)
+{
+    A9GTimerState *s = A9_GTIMER(obj);
+
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL, 0);
+}
+
 static void a9_gtimer_realize(DeviceState *dev, Error **errp)
 {
     A9GTimerState *s = A9_GTIMER(dev);
@@ -391,6 +402,7 @@ static const TypeInfo a9_gtimer_info = {
     .name          = TYPE_A9_GTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(A9GTimerState),
+    .instance_init = a9_gtimer_init,
     .class_init    = a9_gtimer_class_init,
 };
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 88158144b2..eb40241ef6 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -24,9 +24,13 @@
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/clock.h"
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
 
@@ -58,10 +62,12 @@ static inline void timerblock_update_irq(TimerBlock *tb)
     qemu_set_irq(tb->irq, tb->status && (tb->control & 4));
 }
 
-/* Return conversion factor from mpcore timer ticks to qemu timer ticks.  */
-static inline uint32_t timerblock_scale(uint32_t control)
+static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control)
 {
-    return (((control >> 8) & 0xff) + 1) * 10;
+    uint64_t prescale = (((control >> 8) & 0xff) + 1);
+    uint64_t clk_hz = clock_get_hz(tb->clk);
+    assert(clk_hz != 0);
+    return muldiv64(prescale, NANOSECONDS_PER_SECOND, clk_hz);
 }
 
 /* Must be called within a ptimer transaction block */
@@ -155,7 +161,7 @@ static void timerblock_write(void *opaque, hwaddr addr,
             ptimer_stop(tb->timer);
         }
         if ((control & 0xff00) != (value & 0xff00)) {
-            ptimer_set_period(tb->timer, timerblock_scale(value));
+            ptimer_set_period(tb->timer, timerblock_scale(tb, value));
         }
         if (value & 1) {
             uint64_t count = ptimer_get_count(tb->timer);
@@ -222,7 +228,8 @@ static void timerblock_reset(TimerBlock *tb)
         ptimer_transaction_begin(tb->timer);
         ptimer_stop(tb->timer);
         ptimer_set_limit(tb->timer, 0, 1);
-        ptimer_set_period(tb->timer, timerblock_scale(0));
+        ptimer_set_period(tb->timer,
+            timerblock_scale(tb, 0));
         ptimer_transaction_commit(tb->timer);
     }
 }
@@ -244,6 +251,8 @@ static void arm_mptimer_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &arm_thistimer_ops, s,
                           "arm_mptimer_timer", 0x20);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL, 0);
 }
 
 static void arm_mptimer_realize(DeviceState *dev, Error **errp)
@@ -269,6 +278,7 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
      */
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
+        tb->clk = s->clk;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index 6076599024..11b4b7cfe9 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/a9mpcore.h
@@ -34,6 +34,7 @@ struct A9MPPrivState {
     A9GTimerState gtimer;
     ARMMPTimerState mptimer;
     ARMMPTimerState wdt;
+    Clock *clk;
 };
 
 #endif
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 5c9b048b95..ef198a969e 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -87,6 +87,7 @@ struct A9GTimerState {
     uint32_t control; /* only non per cpu banked bits valid */
 
     A9GTimerPerCPU per_cpu[A9_GTIMER_MAX_CPUS];
+    Clock *clk;
 };
 
 typedef struct A9GTimerUpdate {
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 4c6f569631..723f9b9319 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -33,6 +33,7 @@ typedef struct {
     struct ptimer_state *timer;
     qemu_irq irq;
     MemoryRegion iomem;
+    Clock *clk;
 } TimerBlock;
 
 #define TYPE_ARM_MPTIMER "arm_mptimer"
@@ -44,6 +45,7 @@ struct ARMMPTimerState {
     /*< public >*/
 
     uint32_t num_cpu;
+    Clock *clk;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
 };
-- 
2.47.3


