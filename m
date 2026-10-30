Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8E606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uoyCOtXY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJ0-0004ro-SF; Fri, 30 Oct 2026 10:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoG-000600-FD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:24 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoE-0007aE-2z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:20 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-705cb6cedd5so1267522eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367497; x=1793972297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vSax/7NYgw14hOC86mZw2+h8awfxbApPP/+c4jyPbE0=;
 b=uoyCOtXYiSz8VJqHmTvA6SDp0GHrj6p184vjQrOWdP3gEK0/PgGHo9RxF4tC5E7pJQ
 7BEsjbn/YHRzcios1krpkqWcmg343CIl/WcVW1cwX34yQcty6qBTKE60If7soM0C9TZC
 RpAITSHuP017l81TTn4Rxj/BXrkVu0a0FIko0JoUV5GuR8IXJdNY/hI04N4bek/2xwgM
 kviQLIOL1TWjFiQrdL+oLN74fkfcjJLynr2yh8Zl//W5DI+uOW7/63aO7Kio7E2Wlz+8
 wnLkrby/2kjva80GQeo7UR3fOMRj/NJlB08L7HPWJtxJge/JzDSn47Y52tYx5HL9yS4W
 eShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367497; x=1793972297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vSax/7NYgw14hOC86mZw2+h8awfxbApPP/+c4jyPbE0=;
 b=t7VJ9SJYk2bOZ3Uo9k20RCy4ZMk1S+9NSGGvki6E1ItG6GNG3iApvD7epHmSZn4A+s
 ziBs5LJxVv2fCLSzh3WXtFAsA5ssCzQlzEOcBR4R8yfUHYrt5G7QghbzAWdw9obH+hMw
 uIfJrqkW5xhAapNiNLkuSAzj+qksy5zqUXLBApy/+7E/a+29bSj/Ts0nlqAAb0yczwxZ
 /vOh/DRe3dFEaK8KPFgyly8BZUOfvVuLvxwGL559GG75pO4GFaMX40LaO+vjCDSmNZpi
 v77h6vB8nmdp9iiwthWFeWwxQLhTCQPrZAhKuiCpG+g8GG7TibRxUyRWejQTVc6iwBqF
 QUFQ==
X-Gm-Message-State: AFq9FYLtrNNNuHhICsm70uAgQ1FbcQ1TJSaJ2pplreZpxnasFG4GGAhW
 fF+NOoy8pT4cT11mY3WZUkaxqS6A1y+nHbDmIkGhi78eJxv9Wfa6HoVDTUB7Mw==
X-Gm-Gg: AYBFou3jJt/H63DzGBZJGPgb8MKv0aAyoZLcN7Lg3cFxGXQKnpnIj1bpPsprGvK14kR
 aGmiIernazUPkhuYeRvmnJ0rAGwyl28Fp8KyhG9g0MnFxmxmlb2EwDQZRpW/c8gC5bG1NVOIokS
 jBjCCHLLUlHqlh1WCbXw+rbYJqf+mrjV+U+brQnClP0WN79fg/EMsWGdaHhBjUYDtk9N4nMGAGy
 1syQf35Ssr07WhxJmbl0u9RnsPvxAFkFc4a5B72aqpRTAJuxQXbDN/0GQHT7obdsx3ACXpoWPog
 w3nQnC03WV991mpM6UnLxTX+BjOej3mLTu3T/LECGL5T71lcnbvmpOVAH9LKFO+6drEej8NPy+9
 rKfoCkwQe3EV6ygZ+7i9GKHxaDckQt0ttAN/EY0eLrOQkt5TKNfIFAj7ACPkcpmJ8PGcS1bTBLM
 ujY7aROPjENQMlj/VZlBJugJ0mYu5zK7B1DMPL2aoqqoxOf1Q2zH19IXeHGd9Zv51XjM9DINWrX
 V3BxYC0VyJiVBmjkpUyHpflGa14F+EE0K+FdztDXT2Oi0EELDREn/gUB/7etkL+Sr4VPTpy8gE7
 D/P0AVfKWZ2yTyBwjgsjfvhEwxEieiQB/lkFRRcOBg==
X-Received: by 2002:a05:6820:571c:20b0:6cd:3fdc:2663 with SMTP id
 006d021491bc7-714f2aa6fc1mr674818eaf.36.1793367496767; 
 Fri, 30 Oct 2026 06:38:16 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm1861421eaf.12.2026.10.30.06.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:38:15 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v6 1/3] hw/timer: add DesignWare APB timer model
Date: Fri, 30 Oct 2026 21:37:02 +0800
Message-ID: <20261030133704.99678-2-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030133704.99678-1-rao232328@gmail.com>
References: <20261030133704.99678-1-rao232328@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=rao232328@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:09:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add generic DesignWare APB timer device model. The number
of timer channels is configurable via the num-timers property.

Add timer files to MAINTAINERS.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 MAINTAINERS                     |   2 +
 hw/timer/Kconfig                |   4 +
 hw/timer/dw-apb-timer.c         | 376 ++++++++++++++++++++++++++++++++
 hw/timer/meson.build            |   1 +
 hw/timer/trace-events           |   8 +
 include/hw/timer/dw-apb-timer.h |  40 ++++
 6 files changed, 431 insertions(+)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e9fed776..60a5664ce5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1888,11 +1888,13 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: hw/dma/k230_gsdma.c
 F: hw/misc/k230_decomp_gzip.c
+F: hw/timer/dw-apb-timer.c
 F: include/hw/misc/k230_ddr.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: include/hw/dma/k230_gsdma.h
 F: include/hw/misc/k230_decomp_gzip.h
+F: include/hw/timer/dw-apb-timer.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-ddr-test.c
 F: tests/qtest/k230-wdt-test.c
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e098376d40..996f5dfde7 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -78,3 +78,7 @@ config AVR_TIMER16
 
 config HEX_QTIMER
     bool
+
+config DW_APB_TIMER
+    bool
+    select PTIMER
diff --git a/hw/timer/dw-apb-timer.c b/hw/timer/dw-apb-timer.c
new file mode 100644
index 0000000000..86e1fac43f
--- /dev/null
+++ b/hw/timer/dw-apb-timer.c
@@ -0,0 +1,376 @@
+/*
+ * Synopsys DesignWare APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/timer/dw-apb-timer.h"
+#include "trace.h"
+
+#define DW_APB_TIMER_STRIDE       0x14
+#define DW_APB_TIMER_MMIO_SIZE    0x100
+
+/* Per-timer register offsets */
+#define DW_APB_TIMER_N_LOAD_COUNT    0x00
+#define DW_APB_TIMER_N_CURRENT_VALUE 0x04
+#define DW_APB_TIMER_N_CONTROL       0x08
+#define DW_APB_TIMER_N_EOI           0x0c
+#define DW_APB_TIMER_N_INT_STATUS    0x10
+/* Global register offsets */
+#define DW_APB_TIMER_INT_STATUS        0xa0
+#define DW_APB_TIMER_EOI               0xa4
+#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
+#define DW_APB_TIMER_COMP_VERSION      0xac
+
+/* Control register bits */
+#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
+/* 1: periodic, 0: free running. */
+#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
+#define DW_APB_TIMER_CONTROL_INT_MASK      BIT(2)
+#define DW_APB_TIMER_CONTROL_RW_MASK       0x7
+
+/*
+ * Component version of the DW_apb_timers IP, fixed in silicon.
+ * Decodes as the ASCII string "211*" (2.11a series); the model reports
+ * the version integrated in K230. Linux does not read this register.
+ */
+#define DW_APB_TIMER_COMP_VERSION_VAL 0x3231312A
+
+static void dw_apb_timer_update_irq(DWAPBTimerChannel *t)
+{
+    qemu_set_irq(t->irq, t->int_status &&
+                 !(t->control & DW_APB_TIMER_CONTROL_INT_MASK));
+}
+
+static void dw_apb_timer_clk_update(void *opaque, ClockEvent event)
+{
+    DWAPBTimerChannel *t = opaque;
+
+    if (!t->ptimer) {
+        return;
+    }
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_set_period_from_clock(t->ptimer, t->clk, 1);
+    ptimer_transaction_commit(t->ptimer);
+}
+
+static void dw_apb_timer_enable(DWAPBTimerChannel *t)
+{
+    trace_dw_apb_timer_enable(t->id, t->load);
+
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_set_limit(t->ptimer, t->load ? t->load : 1, 1);
+    ptimer_run(t->ptimer, 1);
+    ptimer_transaction_commit(t->ptimer);
+}
+
+static void dw_apb_timer_disable(DWAPBTimerChannel *t)
+{
+    trace_dw_apb_timer_disable(t->id);
+
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_stop(t->ptimer);
+    ptimer_transaction_commit(t->ptimer);
+
+    t->int_status = 0;
+    dw_apb_timer_update_irq(t);
+}
+
+static void dw_apb_timer_tick(void *opaque)
+{
+    DWAPBTimerChannel *t = opaque;
+    uint32_t reload;
+
+    trace_dw_apb_timer_tick(t->id);
+
+    t->int_status = 1;
+    dw_apb_timer_update_irq(t);
+
+    if (t->control & DW_APB_TIMER_CONTROL_MODE_PERIODIC) {
+        reload = t->load ? t->load : 1;
+    } else {
+        reload = UINT32_MAX;
+    }
+
+    ptimer_set_limit(t->ptimer, reload, 1);
+    ptimer_run(t->ptimer, 1);
+}
+
+static uint64_t dw_apb_timer_read(void *opaque, hwaddr addr,
+                                  unsigned int size)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(opaque);
+    uint32_t value = 0;
+
+    if (addr < DW_APB_TIMER_INT_STATUS) {
+        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
+        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
+
+        if (idx < s->num_timers) {
+            DWAPBTimerChannel *t = &s->timers[idx];
+
+            switch (reg) {
+            case DW_APB_TIMER_N_LOAD_COUNT:
+                value = t->load;
+                break;
+            case DW_APB_TIMER_N_CURRENT_VALUE:
+                if (t->control & DW_APB_TIMER_CONTROL_ENABLE) {
+                    value = ptimer_get_count(t->ptimer);
+                }
+                break;
+            case DW_APB_TIMER_N_CONTROL:
+                value = t->control;
+                break;
+            case DW_APB_TIMER_N_EOI:
+                t->int_status = 0;
+                dw_apb_timer_update_irq(t);
+                trace_dw_apb_timer_irq_clear(t->id);
+                break;
+            case DW_APB_TIMER_N_INT_STATUS:
+                value = t->int_status &&
+                        !(t->control & DW_APB_TIMER_CONTROL_INT_MASK);
+                break;
+            default:
+                break;
+            }
+        }
+    } else {
+        switch (addr) {
+        case DW_APB_TIMER_INT_STATUS:
+            for (int i = 0; i < s->num_timers; i++) {
+                DWAPBTimerChannel *t = &s->timers[i];
+
+                value |= (t->int_status &&
+                          !(t->control & DW_APB_TIMER_CONTROL_INT_MASK)) << i;
+            }
+            break;
+        case DW_APB_TIMER_EOI:
+            for (int i = 0; i < s->num_timers; i++) {
+                DWAPBTimerChannel *t = &s->timers[i];
+
+                t->int_status = 0;
+                dw_apb_timer_update_irq(t);
+            }
+            break;
+        case DW_APB_TIMER_RAW_INT_STATUS:
+            for (int i = 0; i < s->num_timers; i++) {
+                value |= s->timers[i].int_status << i;
+            }
+            break;
+        case DW_APB_TIMER_COMP_VERSION:
+            value = DW_APB_TIMER_COMP_VERSION_VAL;
+            break;
+        default:
+            break;
+        }
+    }
+
+    trace_dw_apb_timer_read(addr, value);
+    return value;
+}
+
+static void dw_apb_timer_write(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned int size)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(opaque);
+
+    if (addr < DW_APB_TIMER_INT_STATUS) {
+        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
+        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
+
+        if (idx < s->num_timers) {
+            DWAPBTimerChannel *t = &s->timers[idx];
+
+            switch (reg) {
+            case DW_APB_TIMER_N_LOAD_COUNT:
+                t->load = value;
+                break;
+            case DW_APB_TIMER_N_CONTROL: {
+                uint32_t old_control = t->control;
+                uint32_t new_control = value & DW_APB_TIMER_CONTROL_RW_MASK;
+
+                t->control = new_control;
+                if ((new_control ^ old_control) &
+                    DW_APB_TIMER_CONTROL_ENABLE) {
+                    if (new_control & DW_APB_TIMER_CONTROL_ENABLE) {
+                        dw_apb_timer_enable(t);
+                    } else {
+                        dw_apb_timer_disable(t);
+                    }
+                }
+                if ((new_control ^ old_control) &
+                    DW_APB_TIMER_CONTROL_INT_MASK) {
+                    dw_apb_timer_update_irq(t);
+                }
+                break;
+            }
+            default:
+                break;
+            }
+        }
+    }
+
+    trace_dw_apb_timer_write(addr, value);
+}
+
+static const MemoryRegionOps dw_apb_timer_ops = {
+    .read = dw_apb_timer_read,
+    .write = dw_apb_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void dw_apb_timer_reset_hold(Object *obj, ResetType type)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(obj);
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_stop(t->ptimer);
+        ptimer_transaction_commit(t->ptimer);
+
+        t->load = 0;
+        t->control = 0;
+        t->int_status = 0;
+        dw_apb_timer_update_irq(t);
+    }
+}
+
+static const VMStateDescription vmstate_dw_apb_timer_channel = {
+    .name = "dw-apb-timer-channel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(ptimer, DWAPBTimerChannel),
+        VMSTATE_CLOCK(clk, DWAPBTimerChannel),
+        VMSTATE_UINT32(load, DWAPBTimerChannel),
+        VMSTATE_UINT32(control, DWAPBTimerChannel),
+        VMSTATE_UINT32(int_status, DWAPBTimerChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_dw_apb_timer = {
+    .name = "dw-apb-timer",
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_UINT32(timers, DWAPBTimerState,
+                                     num_timers, 0,
+                                     vmstate_dw_apb_timer_channel,
+                                     DWAPBTimerChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property dw_apb_timer_properties[] = {
+    DEFINE_PROP_UINT32("num-timers", DWAPBTimerState, num_timers, 1),
+};
+
+static void dw_apb_timer_init(Object *obj)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(obj);
+
+    for (int i = 0; i < DW_APB_TIMER_MAX_TIMERS; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+        g_autofree char *name = g_strdup_printf("timer[%d]", i);
+
+        t->id = i;
+        t->clk = qdev_init_clock_in(DEVICE(obj), name,
+                                    dw_apb_timer_clk_update, t,
+                                    ClockUpdate);
+    }
+}
+
+static void dw_apb_timer_realize(DeviceState *dev, Error **errp)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->num_timers == 0 || s->num_timers > DW_APB_TIMER_MAX_TIMERS) {
+        error_setg(errp, "dw-apb-timer: num-timers must be between 1 and %u",
+                   DW_APB_TIMER_MAX_TIMERS);
+        return;
+    }
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        if (!clock_has_source(t->clk)) {
+            error_setg(errp, "dw-apb-timer: timer[%u] clock must be connected",
+                       i);
+            return;
+        }
+    }
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        t->ptimer = ptimer_init(dw_apb_timer_tick, t,
+            PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_set_limit(t->ptimer, UINT32_MAX, 1);
+        ptimer_transaction_commit(t->ptimer);
+        sysbus_init_irq(sbd, &t->irq);
+
+        /* The source may have been connected before the ptimer existed. */
+        dw_apb_timer_clk_update(t, ClockUpdate);
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &dw_apb_timer_ops,
+                          s, TYPE_DW_APB_TIMER, DW_APB_TIMER_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void dw_apb_timer_unrealize(DeviceState *dev)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(dev);
+
+    for (int i = 0; i < s->num_timers; i++) {
+        ptimer_free(s->timers[i].ptimer);
+    }
+}
+
+static void dw_apb_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = dw_apb_timer_realize;
+    dc->unrealize = dw_apb_timer_unrealize;
+    dc->vmsd = &vmstate_dw_apb_timer;
+    dc->desc = "Synopsys DesignWare APB timer";
+    rc->phases.hold = dw_apb_timer_reset_hold;
+    device_class_set_props(dc, dw_apb_timer_properties);
+}
+
+static const TypeInfo dw_apb_timer_info = {
+    .name          = TYPE_DW_APB_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DWAPBTimerState),
+    .instance_init = dw_apb_timer_init,
+    .class_init    = dw_apb_timer_class_init,
+};
+
+static void dw_apb_timer_register_type(void)
+{
+    type_register_static(&dw_apb_timer_info);
+}
+
+type_init(dw_apb_timer_register_type)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index e2bcdbdf65..95cf83ec73 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,3 +36,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
 
 system_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
+system_ss.add(when: 'CONFIG_DW_APB_TIMER', if_true: files('dw-apb-timer.c'))
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 636310f8ca..2393f55366 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,5 +1,13 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# dw-apb-timer.c
+dw_apb_timer_read(uint64_t addr, uint32_t val) "DW APB timer read: [0x%" PRIx64 "] -> 0x%" PRIx32
+dw_apb_timer_write(uint64_t addr, uint64_t val) "DW APB timer write: [0x%" PRIx64 "] <- 0x%" PRIx64
+dw_apb_timer_tick(int idx) "DW APB timer %d tick"
+dw_apb_timer_irq_clear(int idx) "DW APB timer %d IRQ cleared"
+dw_apb_timer_enable(int idx, uint32_t load) "DW APB timer %d enabled load=0x%" PRIx32
+dw_apb_timer_disable(int idx) "DW APB timer %d disabled"
+
 # slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
diff --git a/include/hw/timer/dw-apb-timer.h b/include/hw/timer/dw-apb-timer.h
new file mode 100644
index 0000000000..f6b83ae5ca
--- /dev/null
+++ b/include/hw/timer/dw-apb-timer.h
@@ -0,0 +1,40 @@
+/*
+ * Synopsys DesignWare APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DW_APB_TIMER_H
+#define DW_APB_TIMER_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/clock.h"
+#include "qom/object.h"
+
+#define TYPE_DW_APB_TIMER "dw-apb-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(DWAPBTimerState, DW_APB_TIMER)
+
+#define DW_APB_TIMER_MAX_TIMERS   8
+
+typedef struct DWAPBTimerChannel {
+    struct ptimer_state *ptimer;
+    Clock *clk;
+    qemu_irq irq;
+    unsigned int id;
+    uint32_t load;
+    uint32_t control;
+    uint32_t int_status;
+} DWAPBTimerChannel;
+
+struct DWAPBTimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t num_timers;
+    DWAPBTimerChannel timers[DW_APB_TIMER_MAX_TIMERS];
+};
+
+#endif
-- 
2.53.0


