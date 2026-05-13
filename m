Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432AFCD4F35
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Gv-0003fZ-PA; Wed, 13 May 2026 06:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FX-00037v-6j
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FO-0001NJ-Ig
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so60389995e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669722; x=1779274522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTomJ8d/soqsaSE8O3gG0DgzgBSQSKl73BuiKRWsZCc=;
 b=Mh3gPyYakQ+f95pC1tRiWpDTjCZ9gC9WRpWzIxqEx24RcCOAwflWduiE74UnZgCue1
 IpoULZUR8wYufZ1ZJL2GdFQA82CwGRmIK+zi7OYT61dlF/XpirP7uLdKvXqen25LT/rq
 27pivVYijgHdn9FVgUhhKq7MHZkRWml9QYbWRUsCtrwzXfscNrWAr/b9QUehtEd8TbBD
 UMY6WUsv6qtRshhnA1mjgI1bZSRtn1TaumKB62J7/1CNkO9yl7fv3lAo7J4zbMXo4jtE
 ATvld/nwD9VsOAlFiv8f7WjAw83kq0StpEpDb1M+iHdZJx+o9d2E0bKgGU16EI4of1PW
 /BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669722; x=1779274522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XTomJ8d/soqsaSE8O3gG0DgzgBSQSKl73BuiKRWsZCc=;
 b=VXKq/LSj0XzQpJRA7xqvRFDlBHM3wGcoLuka6yhMz7pSv7HFqPLr1f+PLquipiXq19
 3LuEwYLVh2LRqwHMRNLmsE8ljxMYcRbJl5HIiQ/5ZlkbIrSHg/RoDKW9ngffuL0KYv9E
 i/81kuoEHFqfX1W7ykAQDQymnmFpGAFgz5Yvj5Gb6MgRD5khTi5umbjgnYyu6cKSJHLe
 L+XVRvDG+sI4Qxqp+8wM23LvPXrQn08LnoRktw+NACFYIyHilQWC3i2SzAmeSclXI0mH
 EEfcY4IywMcExQRA0oYK0tdnFxyptTeR2/WJQB/y1pkhC7IonrpeqRQiaeVyzlaABIrb
 wudQ==
X-Gm-Message-State: AOJu0YxyZQB00m0OqgiF+I7d6HmEB18zfp/eOuJDs/vxa5B/ZXa044DD
 QB9z7Z5csjBwwTzGY6tG7uB2MCxZyDRbW4ReGuyEC5ouZ+sAjjU5rwK1RmeTkxPx
X-Gm-Gg: Acq92OHj3jL8ZPgCWsdPaZVN8dsqPX99ekWTa/yPXeOYBwWDTNKMV2090xZfL1jJ6LR
 5yR3LXBToamqg7v2b85JyfggEOAaKdgx3vN9/TefSri3K02+mZSFsPEW0JhhMRqufMdTPQ7eC6T
 l5fhX2rLMXZFAtte0Kx2L4uO/j3sLQT0x8Cuzx6EArP/QNiWebqs3/D8t6zA8r1Dv8jjnvXS3bf
 eZv7u8ndvNfvcYoADoIc2ycTtDDuuXvYk5nuxiCJVDngXBFscFqd/hYNXAehk0MZNPJ+dQBtTS8
 LmKEtxaUIkaSoJVBEoifwXKtE0E4P9HFkHxzh2g3vgOPPKB6Tx9149yjCSqwlTQp0aTj4iuYDBi
 sRh+M3SLJj+4fAFQ8VseS7HO/LQb7CNMXAs8MEcdQTguL1jn2PNLTl5wtmqhN56dsJ/oCTuK1mB
 TezXGB8JbQrtBW5HYgiK8Y/ya3NP+/arU9kK5q6zVPHNkO
X-Received: by 2002:a05:600c:5397:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48fc9a089c8mr34237715e9.3.1778669721779; 
 Wed, 13 May 2026 03:55:21 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:21 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 02/15] hw/timer: Make PERIPHCLK divider configurable
Date: Wed, 13 May 2026 12:55:04 +0200
Message-ID: <20260513105517.146706-3-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32e.google.com
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

The A9 global timer and ARM MP timer use PERIPHCLK as
their clock source. The frequency of PERIPHCLK is derived
by dividing the main clock (CLK) by a configurable
divider (must be at least 2). Previously, the PERIPHCLK
divider was not configurable, which could lead to
unexspected behavior if the application exspected a
different PERIPHCLK rate.

The property periphclk-divider specifies by which value
the main clock is divided to generate PERIPHCLK. This
allows flexible configuration of the timer clocks to
match application requirements.

Information can be found in the Zynq 7000 Soc Technical
Reference Manual under Timers.
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/a9gtimer.c            | 19 ++++++++++++++++++-
 hw/timer/arm_mptimer.c         | 19 ++++++++++++++++++-
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 699cea8c89..5fb3aa6c77 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -27,6 +27,7 @@
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
@@ -62,9 +63,17 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
 
 static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
 {
+    /*
+     * Referring to the ARM-Cortex-A9 MPCore TRM
+     *
+     * The a9 global timer relies on the PERIPHCLK as its clock source.
+     * The PERIPHCLK clock period must be configured as a multiple of the
+     * main clock CLK. The conversion from the qemu clock (1GHz) to a9
+     * gtimer ticks can be calculated like this:
+     */
     uint64_t prescale = extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
                                   R_CONTROL_PRESCALER_LEN) + 1;
-    uint64_t scaled_prescaler = prescale * 10;
+    uint64_t scaled_prescaler = prescale * s->periphclk_divider;
     return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, s->freq_hz);
 }
 
@@ -312,6 +321,12 @@ static void a9_gtimer_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, a9_gtimer_update_no_sync, s);
 
+    if (s->periphclk_divider < 2) {
+        error_setg(errp, "Invalid periphclk-divider (%lu), must be >= 2",
+                   s->periphclk_divider);
+        return;
+    }
+
     for (i = 0; i < s->num_cpu; i++) {
         A9GTimerPerCPU *gtb = &s->per_cpu[i];
 
@@ -378,6 +393,8 @@ static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", A9GTimerState, freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-divider", A9GTimerState,
+                       periphclk_divider, 10),
 };
 
 static void a9_gtimer_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index f67f26ad9a..6a5bc62422 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -27,6 +27,7 @@
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
 
@@ -61,8 +62,16 @@ static inline void timerblock_update_irq(TimerBlock *tb)
 /* Return conversion factor from mpcore timer ticks to qemu timer ticks.  */
 static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control)
 {
+    /*
+     * Referring to the ARM-Cortex-A9 MPCore TRM
+     *
+     * The arm mp timer relies on the PERIPHCLK as its clock source.
+     * The PERIPHCLK clock period must be configured as a multiple of the
+     * main clock CLK. The conversion from the qemu clock (1GHz) to arm mp
+     * timer ticks can be calculated like this:
+     */
     uint64_t prescale = (((control >> 8) & 0xff) + 1);
-    uint64_t scaled_prescaler = prescale * 10;
+    uint64_t scaled_prescaler = prescale * tb->periphclk_divider;
     return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, tb->freq_hz);
 }
 
@@ -273,6 +282,12 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
         tb->freq_hz = s->freq_hz;
+        if (s->periphclk_divider < 2) {
+            error_setg(errp, "Invalid periphclk-divider (%lu), must be >= 2",
+                       s->periphclk_divider);
+            return;
+        }
+        tb->periphclk_divider = s->periphclk_divider;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
@@ -309,6 +324,8 @@ static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", ARMMPTimerState, freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-divider", ARMMPTimerState,
+                       periphclk_divider, 10),
 };
 
 static void arm_mptimer_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 571c05f638..1c65cec914 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -77,6 +77,7 @@ struct A9GTimerState {
     MemoryRegion iomem;
     /* static props */
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     uint32_t num_cpu;
 
     QEMUTimer *timer;
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 93ae532c9a..6eb0cedc90 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -32,6 +32,7 @@ typedef struct {
     uint32_t status;
     struct ptimer_state *timer;
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     qemu_irq irq;
     MemoryRegion iomem;
 } TimerBlock;
@@ -45,6 +46,7 @@ struct ARMMPTimerState {
     /*< public >*/
 
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     uint32_t num_cpu;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
-- 
2.47.3


