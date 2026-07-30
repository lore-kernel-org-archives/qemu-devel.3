Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBDCC55168
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQxO-0006Rp-9r; Thu, 30 Jul 2026 09:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQx7-0006Gr-G8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQx4-0005y3-NH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cab973140bso28812275ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418653; x=1786023453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VXeXaSmB/86trqyinsTj9cvA0T4G9xJkeVkYlBDivtA=;
 b=lTjk+BheNYIVGtq6Kc4Bd7iIyvfpi4Vbs/P+a6Vehhq2xcpKchdbhvtJrxdiN0QukO
 KSOK6/Xw1kplaPHrUHs6dTn7K8VT+fe7YIql0csq+V8hA3e2KlnwRlisxwl2NjKJRUd+
 RcbHGR/+lW2G32uMpk9qrQkfiT4cC+q27KwjH5U0WvIRCUqgqkpEnTsIqjVZlgKM5yzr
 8onale5i0XQQugguJ6lPMZ7luJNHKefkFTiB8eYglOHBAuV+7YqPGU/+hwPYYIdYsHjw
 3JEz2ekc49vdEk1zi/wgeI43FIBSzS/X+iBwAOY3/WuWCK9aPt9fPxplBo/1Gsr4FgPC
 UAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418653; x=1786023453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VXeXaSmB/86trqyinsTj9cvA0T4G9xJkeVkYlBDivtA=;
 b=Lxf22NWRylYyiwMtO7D+7Qx6bG37JqEUwTvBqatPyhGAzpbFq+o0PEmtKr11KWEAbY
 enMZze1duc+71DQS+yfUe2phDv6o0rNE5NL++ad1sXODLWUlGbbApdntiJWX9n3URVm2
 R7PVwd5NGCWcj1VMbE7pj9sRbpq+ATlw/6otnAoD+lnAxrq+rp0Rm4Idz835IV1Yqr+2
 CWGMDtorLx3XrWrbPZrgNCU84sh9leYoyYH/Gwa9xOaWPdQSnjgEC4MeHoU/Hs21MEpt
 T5oylqowWxoOz+ieDBZk5V/hYNEKtPBQikoZhaezqNVpGC1e//dO3K5JArOzkDL86avs
 JvYA==
X-Gm-Message-State: AOJu0YyjDXr44qITa6lhE4yXB6O3EUF/i56+cXV9qLL2/9uRUCw/TyFw
 fjc9BcM4PzBgZ73R7L1aJTJ8TQHr2ztV8BbzzwqzKKxAuqPFWmkFn+3S8uMiRgQEJMM=
X-Gm-Gg: AR+sD13i2rNp8dTRzW1bnu78HS5RAjieWZSzEqrpfZQtB9fvdggpsxzyeOYL+XQISbn
 9qR9klkIxQK5v2a4jlGpbg8aR/tsQFmikeVHpguQZfHaEpCunFBcPQS2mWL/HFYrE61nq7JwfhW
 zfo2BLDqBIXAQE3U5WedqfxHCm8HG/jjtuNNjjgV4xy2sMShzId40brcRMAmGmRsDRsq1pmrhdg
 L60XoBljVLY3SHHoKJjXoN6AbZJLoB4Xf4k2U+TwDg58zJpXXdJKul1eJ4dB/xVSdtjy6sUcyek
 S2A1LTEN+le/LoEYV+TvcA3wlzphr1FXoPn0r6fgqeqtYfBhQKiSRULWEZejAvw33QpBNdSct6q
 CH8UPpGO3mwMs2VE5wLNkWTXWo4K8j5xScHf2VxhJmBZ2IK3lY3oioUzpDVFwqmjn9LXznsAh9G
 duZYzx7+apmAXGi+iGyJIGpwvO5P47xjR8ZqhNXEFZnSL/7Egd0ffRcEojOPRpa25kWYFQXuc=
X-Received: by 2002:a17:902:cf4b:b0:2ca:e0ff:e696 with SMTP id
 d9443c01a7336-2d035b80aedmr27463865ad.9.1785418653146; 
 Thu, 30 Jul 2026 06:37:33 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.230.138.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf845asm26757745ad.60.2026.07.30.06.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:37:32 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v2 1/3] hw/timer: add k230 dwapb timer model
Date: Thu, 30 Jul 2026 21:37:09 +0800
Message-ID: <20260730133713.3253-2-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730133713.3253-1-rao232328@gmail.com>
References: <20260730133713.3253-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add DesignWare APB timer model for K230 machine.
The timer uses the Clock framework for frequency input,
preparing for future CMU integration.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 hw/timer/Kconfig                    |   4 +
 hw/timer/k230_dwapb_timer.c         | 317 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   9 +
 include/hw/timer/k230_dwapb_timer.h |  72 +++++++
 5 files changed, 403 insertions(+)
 create mode 100644 hw/timer/k230_dwapb_timer.c
 create mode 100644 include/hw/timer/k230_dwapb_timer.h

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b3d823ce2c..9d1f20f5cd 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -65,3 +65,7 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config K230_TIMER
+    bool
+    select PTIMER
diff --git a/hw/timer/k230_dwapb_timer.c b/hw/timer/k230_dwapb_timer.c
new file mode 100644
index 0000000000..623f84cafd
--- /dev/null
+++ b/hw/timer/k230_dwapb_timer.c
@@ -0,0 +1,317 @@
+/*
+ * K230 DW APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/timer/k230_dwapb_timer.h"
+#include "trace.h"
+
+static void k230_timer_clk_update(void *opaque, ClockEvent event)
+{
+    K230TimerState *s = K230_TIMER(opaque);
+    for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+        if (!s->timers[i].ptimer) {
+            continue;
+        }
+        ptimer_transaction_begin(s->timers[i].ptimer);
+        ptimer_set_period_from_clock(s->timers[i].ptimer, s->pclk, 1);
+        ptimer_transaction_commit(s->timers[i].ptimer);
+    }
+}
+
+static void k230_timer_enable(K230Timer *t)
+{
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_set_limit(t->ptimer, t->load ? t->load : 1, 1);
+    ptimer_run(t->ptimer, 1);
+    ptimer_transaction_commit(t->ptimer);
+
+    trace_k230_timer_enable(t->id, t->load);
+}
+
+static void k230_timer_disable(K230Timer *t)
+{
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_stop(t->ptimer);
+    ptimer_transaction_commit(t->ptimer);
+
+    t->int_status = 0;
+    qemu_set_irq(t->irq, 0);
+
+    trace_k230_timer_disable(t->id);
+}
+
+static void k230_timer_tick(void *opaque)
+{
+    K230Timer *t = opaque;
+    uint32_t reload;
+
+    trace_k230_timer_tick(t->id);
+
+    t->int_status = 1;
+
+    if (!(t->control & K230_APBTMR_CONTROL_INT)) {
+        qemu_set_irq(t->irq, 1);
+        trace_k230_timer_interrupt(t->id);
+    }
+
+    if (t->control & K230_APBTMR_CONTROL_MODE_PERIODIC) {
+        reload = t->load ? t->load : 1;
+    } else {
+        reload = UINT32_MAX;
+    }
+
+    ptimer_set_limit(t->ptimer, reload, 1);
+    ptimer_run(t->ptimer, 1);
+}
+
+static uint64_t k230_timer_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230TimerState *s = K230_TIMER(opaque);
+    uint32_t value = 0;
+
+    addr &= 0xfff;
+
+    if (addr < K230_APBTMRS_INT_STATUS) {
+        int idx = addr / K230_APBTMR_STRIDE;
+        int reg = addr % K230_APBTMR_STRIDE;
+
+        if (idx < K230_APBTMR_NUM_TIMERS) {
+            switch (reg) {
+            case K230_APBTMR_N_LOAD_COUNT:
+                value = s->timers[idx].load;
+                break;
+            case K230_APBTMR_N_CURRENT_VALUE:
+                if (s->timers[idx].control & K230_APBTMR_CONTROL_ENABLE) {
+                    value = ptimer_get_count(s->timers[idx].ptimer);
+                } else {
+                    value = 0;
+                }
+                break;
+            case K230_APBTMR_N_CONTROL:
+                value = s->timers[idx].control;
+                break;
+            case K230_APBTMR_N_EOI:
+                s->timers[idx].int_status = 0;
+                qemu_set_irq(s->timers[idx].irq, 0);
+                trace_k230_timer_irq_clear(s->timers[idx].id);
+                value = 0;
+                break;
+            case K230_APBTMR_N_INT_STATUS:
+                if (s->timers[idx].control & K230_APBTMR_CONTROL_INT) {
+                    value = 0;
+                } else {
+                    value = s->timers[idx].int_status;
+                }
+                break;
+            }
+        }
+    } else if (addr >= K230_APBTMR_N_LOAD2 &&
+               addr < K230_APBTMR_N_LOAD2 +
+                      K230_APBTMR_NUM_TIMERS * K230_APBTMR_LOAD2_STRIDE) {
+        int idx = (addr - K230_APBTMR_N_LOAD2) / K230_APBTMR_LOAD2_STRIDE;
+        value = s->timers[idx].load2;
+    } else {
+        switch (addr) {
+        case K230_APBTMRS_INT_STATUS:
+            for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+                if (!(s->timers[i].control & K230_APBTMR_CONTROL_INT)) {
+                    value |= s->timers[i].int_status << i;
+                }
+            }
+            break;
+        case K230_APBTMRS_EOI:
+            for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+                s->timers[i].int_status = 0;
+                qemu_set_irq(s->timers[i].irq, 0);
+            }
+            value = 0;
+            break;
+        case K230_APBTMRS_RAW_INT_STATUS:
+            for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+                value |= s->timers[i].int_status << i;
+            }
+            break;
+        case K230_APBTMRS_COMP_VERSION:
+            value = K230_APBTMR_COMP_VERSION_VAL;
+            break;
+        }
+    }
+
+    trace_k230_timer_read(addr, value);
+    return value;
+}
+
+static void k230_timer_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned int size)
+{
+    K230TimerState *s = K230_TIMER(opaque);
+
+    addr &= 0xfff;
+
+    if (addr < K230_APBTMRS_INT_STATUS) {
+        int idx = addr / K230_APBTMR_STRIDE;
+        int reg = addr % K230_APBTMR_STRIDE;
+
+        if (idx < K230_APBTMR_NUM_TIMERS) {
+            switch (reg) {
+            case K230_APBTMR_N_LOAD_COUNT:
+                s->timers[idx].load = value;
+                break;
+            case K230_APBTMR_N_CONTROL: {
+                uint32_t old_ctrl = s->timers[idx].control;
+                s->timers[idx].control = value & K230_APBTMR_CONTROL_RW_MASK;
+                if ((value ^ old_ctrl) & K230_APBTMR_CONTROL_ENABLE) {
+                    if (value & K230_APBTMR_CONTROL_ENABLE) {
+                        k230_timer_enable(&s->timers[idx]);
+                    } else {
+                        k230_timer_disable(&s->timers[idx]);
+                    }
+                }
+                if ((value ^ old_ctrl) & K230_APBTMR_CONTROL_INT) {
+                    if (value & K230_APBTMR_CONTROL_INT) {
+                        qemu_set_irq(s->timers[idx].irq, 0);
+                    } else if (s->timers[idx].int_status) {
+                        qemu_set_irq(s->timers[idx].irq, 1);
+                    }
+                }
+                break;
+            }
+            default:
+                break;
+            }
+        }
+    } else if (addr >= K230_APBTMR_N_LOAD2 &&
+               addr < K230_APBTMR_N_LOAD2 +
+                      K230_APBTMR_NUM_TIMERS * K230_APBTMR_LOAD2_STRIDE) {
+        int idx = (addr - K230_APBTMR_N_LOAD2) / K230_APBTMR_LOAD2_STRIDE;
+        s->timers[idx].load2 = value;
+    }
+
+    trace_k230_timer_write(addr, value);
+}
+
+static const MemoryRegionOps k230_timer_ops = {
+    .read  = k230_timer_read,
+    .write = k230_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void k230_timer_realize(DeviceState *dev, Error **errp)
+{
+    K230TimerState *s = K230_TIMER(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (!clock_has_source(s->pclk)) {
+        error_setg(errp, "K230 DW APB timer: pclk clock must be connected");
+        return;
+    }
+
+    for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+        s->timers[i].id = i;
+        s->timers[i].ptimer = ptimer_init(k230_timer_tick, &s->timers[i],
+            PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+        ptimer_transaction_begin(s->timers[i].ptimer);
+        ptimer_set_limit(s->timers[i].ptimer, UINT32_MAX, 1);
+        ptimer_transaction_commit(s->timers[i].ptimer);
+        sysbus_init_irq(sbd, &s->timers[i].irq);
+    }
+
+    k230_timer_clk_update(s, ClockUpdate);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &k230_timer_ops,
+                          s, TYPE_K230_TIMER, K230_APBTMR_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void k230_timer_reset(DeviceState *dev)
+{
+    K230TimerState *s = K230_TIMER(dev);
+
+    for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+        K230Timer *t = &s->timers[i];
+
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_stop(t->ptimer);
+        ptimer_transaction_commit(t->ptimer);
+
+        t->load = 0;
+        t->load2 = 0;
+        t->control = 0;
+        t->int_status = 0;
+        qemu_set_irq(t->irq, 0);
+    }
+}
+
+static const VMStateDescription vmstate_k230_timer_channel = {
+    .name = "k230-dwapb-timer-channel",
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(ptimer, K230Timer),
+        VMSTATE_UINT32(load, K230Timer),
+        VMSTATE_UINT32(load2, K230Timer),
+        VMSTATE_UINT32(control, K230Timer),
+        VMSTATE_UINT32(int_status, K230Timer),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_k230_timer = {
+    .name = "k230-dwapb-timer",
+    .fields = (const VMStateField[]) {
+        VMSTATE_CLOCK(pclk, K230TimerState),
+        VMSTATE_STRUCT_ARRAY(timers, K230TimerState,
+                             K230_APBTMR_NUM_TIMERS, 0,
+                             vmstate_k230_timer_channel, K230Timer),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_timer_init(Object *obj)
+{
+    K230TimerState *s = K230_TIMER(obj);
+    s->pclk = qdev_init_clock_in(DEVICE(obj), "pclk", k230_timer_clk_update,
+                                 s, ClockUpdate);
+}
+
+static void k230_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = k230_timer_realize;
+    dc->vmsd = &vmstate_k230_timer;
+    dc->desc = "K230 DW APB timer";
+    device_class_set_legacy_reset(dc, k230_timer_reset);
+}
+
+static const TypeInfo k230_timer_info = {
+    .name          = TYPE_K230_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230TimerState),
+    .instance_init = k230_timer_init,
+    .class_init    = k230_timer_class_init,
+};
+
+static void k230_timer_register_type(void)
+{
+    type_register_static(&k230_timer_info);
+}
+type_init(k230_timer_register_type)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 201b5d8316..d0a834e127 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -34,3 +34,4 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+system_ss.add(when: 'CONFIG_K230_TIMER', if_true: files('k230_dwapb_timer.c'))
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 634ba1da27..89c619bc87 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,5 +1,14 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# k230_dwapb_timer.c
+k230_timer_read(uint64_t addr, uint32_t val) "K230 timer read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_timer_write(uint64_t addr, uint64_t val) "K230 timer write: [0x%" PRIx64 "] <- 0x%" PRIx64
+k230_timer_tick(int idx) "K230 timer %d tick"
+k230_timer_interrupt(int idx) "K230 timer %d IRQ asserted"
+k230_timer_irq_clear(int idx) "K230 timer %d IRQ cleared"
+k230_timer_enable(int idx, uint32_t load) "K230 timer %d enabled load=0x%" PRIx32
+k230_timer_disable(int idx) "K230 timer %d disabled"
+
 # slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
diff --git a/include/hw/timer/k230_dwapb_timer.h b/include/hw/timer/k230_dwapb_timer.h
new file mode 100644
index 0000000000..3aba178dfa
--- /dev/null
+++ b/include/hw/timer/k230_dwapb_timer.h
@@ -0,0 +1,72 @@
+/*
+ * K230 DW APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#ifndef K230_DWAPB_TIMER_H
+#define K230_DWAPB_TIMER_H
+
+#include "qemu/bitops.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/clock.h"
+#include "qom/object.h"
+
+#define TYPE_K230_TIMER "riscv.k230.timer"
+OBJECT_DECLARE_SIMPLE_TYPE(K230TimerState, K230_TIMER)
+
+#define K230_APBTMR_MMIO_SIZE    0x800
+#define K230_APBTMR_NUM_TIMERS   6
+#define K230_APBTMR_STRIDE       0x14
+#define K230_APBTMR_DEFAULT_FREQ 6250000
+#define K230_APBTMR_COMP_VERSION_VAL 0x3231312A
+#define K230_APBTMR_LOAD2_STRIDE  0x04
+
+/* Per-timer register offsets */
+#define K230_APBTMR_N_LOAD_COUNT    0x00
+#define K230_APBTMR_N_CURRENT_VALUE 0x04
+#define K230_APBTMR_N_CONTROL       0x08
+#define K230_APBTMR_N_EOI           0x0c
+#define K230_APBTMR_N_INT_STATUS    0x10
+/* Global register offsets */
+#define K230_APBTMRS_INT_STATUS        0xa0
+#define K230_APBTMRS_EOI               0xa4
+#define K230_APBTMRS_RAW_INT_STATUS    0xa8
+#define K230_APBTMRS_COMP_VERSION      0xac
+/* PWM LoadCount2 registers */
+#define K230_APBTMR_N_LOAD2       0xb0
+
+/* Control register bits */
+#define K230_APBTMR_CONTROL_ENABLE        BIT(0)
+#define K230_APBTMR_CONTROL_MODE_PERIODIC BIT(1)
+#define K230_APBTMR_CONTROL_INT           BIT(2)
+#define K230_APBTMR_CONTROL_PWM           BIT(3)
+#define K230_APBTMR_CONTROL_RW_MASK     0xf
+
+typedef struct K230Timer {
+    struct ptimer_state *ptimer;
+    qemu_irq irq;
+    int id;
+    uint32_t load;
+    uint32_t load2;
+    uint32_t control;
+    uint32_t int_status;
+} K230Timer;
+
+struct K230TimerState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    K230Timer timers[K230_APBTMR_NUM_TIMERS];
+    Clock *pclk;
+};
+
+#endif
-- 
2.53.0


