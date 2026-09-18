Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD986C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VZl-0003LY-SL; Fri, 18 Sep 2026 06:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZi-0003JL-50
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:10 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZe-0007a8-Bg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:09 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so3512595e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726325; x=1790331125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8qhuk4KwzL/1LZSqGhpwv+j6d0tavaRE6YHH5uT2Sk=;
 b=p5aPdy4mrg/VpK4Wk5ZsqqZz7Favk5fEUeretCtMU55qkYGspQcRLNrQOHCeJtQN+a
 Tz2ZZnrf43orxciz+ekgqUomvS1RGdMT+E9A3rIrqO/iPS2r1yM6nUc/qTHvFX/+W30u
 /R8PKlKSeEyalrGHVLI+/dhdjixnAiQBNw4SxaiSmXvysxv1WGuEIu0+k4kVhomXy33H
 YjVMEW7t09ImPyM6LOYiKg2trxV2g3BrPaqkbcBCRZjRHjoVhIe7fX1rKjdkgLDvXHy7
 p8a1S5mJzOEpV5EZ8x0xx/h1IRu95GRJisWLxGf85qwcxCAZ5qyxvOr2fEtGeqwPoU3X
 vELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726325; x=1790331125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y8qhuk4KwzL/1LZSqGhpwv+j6d0tavaRE6YHH5uT2Sk=;
 b=gwCGvegaQ6I+GK7eYxLkoOSZLCSH3jrIVtnvRH9Wnm20LrNFcCvtb5k8vUmQasDM4U
 hugZmQNy+bP2eHR3etI2AstcCrs6fkBB/+kHIdpcS0EaMSGg1qqCLwVehbQ0bAbnhshM
 Mmr6NfmCyf28f0nkxTo6axYW6ObPaUxjeVjvkABggC+syfyOIXxNLSPDc1/hFFkI8kbV
 VFCK/MFd6U9o6YWLqVHK0c02It4y5oKS9wx+bxMnZVjnzgZg1lIK8F17tm4VKh+7DE6R
 Ghc/pNiaUnp/ReEjAMxvUtoQRwhum7lYebH5IZ9BR419EBWIMbj2As+NMUcsSEf6FQqs
 T83A==
X-Gm-Message-State: AFuF++lEl/TqnC+TF5gdoRFNCM4q9Nxpvt9ix/ahYDXfqNi/HVGc4WaX
 S192GswIj6Ekv+i7ToyOUKAyfTbeHouP6uFtMejfyMzJEefkn2f51TMr/ulljiI3
X-Gm-Gg: AYBFou0Ffge/Nor/lKxhudsAxfFM/qR+mjweCn4HWiP/eTmG0aOfvBjy1rFpm21IGUo
 uka1+c/xvIhRJseS4wDthI0puJPpaXkQi/5QB7NqisnQEVQZo0qftYhUgYb/bCTMD8KgkJevo0k
 OjlGGUZK455T6rjogmEj9WKym1PVgmduWWHJzN43qidWPm70uWYaUaEbn4TrKmuc33jab3QSrWZ
 sT2usKl/H/LX+paXLEvbIwwBEmRxFyyK/PulX2y/9HEUxluDL6m1LbDferkgvIK/+on+mOB32Zf
 K12ER2uscQYu4USy5xOsEfJsXCqTHI3k7obNd/Gwhe+UY3FqiFzAcCbAw1u2OpnuQyYtYU/dQJn
 n1N8yzVyD++13pZHAnJXyhnC6o025IsZ3rHl6MSzkv1HDDMLqlapERvlsse4aBIMT7Z3qRYI2c8
 B5nxH7lG1kyAE1ZcEOJPIDzUdS/oc7b6z2gqIyRq90zYdfMlD9kVY3T1ztuJpcc1wTZ4zF1kCX4
 ydLVnxeGKEHM6/s64baCcwbkFVzaxjY
X-Received: by 2002:a05:600c:8b72:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49fc566458cmr56237025e9.2.1789726324658; 
 Fri, 18 Sep 2026 03:12:04 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:12:04 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 4/7] hw/timer, cpu: Add Clock API support to A9MPCore timers
Date: Fri, 18 Sep 2026 12:11:55 +0200
Message-ID: <20260918101158.42101-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918101158.42101-1-corvin.koehne@gmail.com>
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/cpu/a9mpcore.c              | 12 ++++++++++
 hw/timer/a9gtimer.c            | 42 +++++++++++++++++++++++++++++-----
 hw/timer/arm_mptimer.c         | 19 +++++++++++----
 include/hw/cpu/a9mpcore.h      |  1 +
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 7 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 31d5b5e5caa5..f7190118f7ff 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -265,6 +265,7 @@ static void zynq_init(MachineState *machine)
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
+    qdev_connect_clock_in(dev, "clk", qdev_get_clock_out(slcr, "cpu_3x2x"));
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 2127f9557892..5ffdc9277b4a 100644
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
index 3a086915c817..6c6b7afb398c 100644
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
@@ -60,12 +63,30 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
     return current_cpu->cpu_index;
 }
 
-static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
+static inline uint32_t a9_gtimer_get_prescale(A9GTimerState *s)
 {
-    uint64_t prescale = extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
-                                  R_CONTROL_PRESCALER_LEN);
+    return extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
+                     R_CONTROL_PRESCALER_LEN) + 1;
+}
 
-    return (prescale + 1) * 10;
+static inline uint64_t a9_gtimer_ns_to_ticks(A9GTimerState *s, uint64_t ns)
+{
+    assert(!(s->control & R_CONTROL_TIMER_ENABLE) || clock_get(s->clk) != 0);
+
+    return clock_ns_to_ticks(s->clk, ns) /
+           a9_gtimer_get_prescale(s);
+}
+
+static inline uint64_t a9_gtimer_ticks_to_ns(A9GTimerState *s, uint64_t ticks)
+{
+    uint32_t prescale = a9_gtimer_get_prescale(s);
+
+    assert(!(s->control & R_CONTROL_TIMER_ENABLE) || clock_get(s->clk) != 0);
+    if (ticks > UINT64_MAX / prescale) {
+        return INT64_MAX;
+    }
+
+    return clock_ticks_to_ns(s->clk, ticks * prescale);
 }
 
 static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
@@ -74,7 +95,7 @@ static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
 
     ret.now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ret.new = s->ref_counter +
-              (ret.now - s->cpu_ref_time) / a9_gtimer_get_conv(s);
+              a9_gtimer_ns_to_ticks(s, ret.now - s->cpu_ref_time);
     return ret;
 }
 
@@ -117,7 +138,8 @@ static void a9_gtimer_update(A9GTimerState *s, bool sync)
     if (next_cdiff) {
         DB_PRINT("scheduling qemu_timer to fire again in %"
                  PRIx64 " cycles\n", next_cdiff);
-        timer_mod(s->timer, update.now + next_cdiff * a9_gtimer_get_conv(s));
+        timer_mod(s->timer, update.now +
+                  a9_gtimer_ticks_to_ns(s, next_cdiff));
     }
 
     if (s->control & R_CONTROL_TIMER_ENABLE) {
@@ -295,6 +317,13 @@ static void a9_gtimer_reset(DeviceState *dev)
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
@@ -391,6 +420,7 @@ static const TypeInfo a9_gtimer_info = {
     .name          = TYPE_A9_GTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(A9GTimerState),
+    .instance_init = a9_gtimer_init,
     .class_init    = a9_gtimer_class_init,
 };
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 88158144b23f..6802ca29c927 100644
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
+static inline void timerblock_set_period(TimerBlock *tb, uint32_t control)
 {
-    return (((control >> 8) & 0xff) + 1) * 10;
+    uint32_t prescale = (((control >> 8) & 0xff) + 1);
+
+    assert((control & 1) == 0 || clock_get(tb->clk) != 0);
+    ptimer_set_period_from_clock(tb->timer, tb->clk, prescale);
 }
 
 /* Must be called within a ptimer transaction block */
@@ -155,7 +161,7 @@ static void timerblock_write(void *opaque, hwaddr addr,
             ptimer_stop(tb->timer);
         }
         if ((control & 0xff00) != (value & 0xff00)) {
-            ptimer_set_period(tb->timer, timerblock_scale(value));
+            timerblock_set_period(tb, value);
         }
         if (value & 1) {
             uint64_t count = ptimer_get_count(tb->timer);
@@ -222,7 +228,7 @@ static void timerblock_reset(TimerBlock *tb)
         ptimer_transaction_begin(tb->timer);
         ptimer_stop(tb->timer);
         ptimer_set_limit(tb->timer, 0, 1);
-        ptimer_set_period(tb->timer, timerblock_scale(0));
+        timerblock_set_period(tb, 0);
         ptimer_transaction_commit(tb->timer);
     }
 }
@@ -244,6 +250,8 @@ static void arm_mptimer_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &arm_thistimer_ops, s,
                           "arm_mptimer_timer", 0x20);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", NULL, NULL, 0);
 }
 
 static void arm_mptimer_realize(DeviceState *dev, Error **errp)
@@ -269,6 +277,7 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
      */
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
+        tb->clk = s->clk;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index 60765990247b..11b4b7cfe952 100644
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
index 5c9b048b9545..ef198a969e75 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -87,6 +87,7 @@ struct A9GTimerState {
     uint32_t control; /* only non per cpu banked bits valid */
 
     A9GTimerPerCPU per_cpu[A9_GTIMER_MAX_CPUS];
+    Clock *clk;
 };
 
 typedef struct A9GTimerUpdate {
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 4c6f5696319c..723f9b931997 100644
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


