Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF2C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnzpa-0005wd-M6; Sun, 26 Jul 2026 10:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wnzpY-0005w4-QX
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:27:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wnzpV-0003Bl-E1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:27:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso22681695ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785076068; x=1785680868; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1sBx2kKtuxRUa86eZ7Tw3dvx7AMR/K7Ts577Kgrg7uY=;
 b=np0oK70X2K3Szhod/YYm3KbFdFT0XllKZ3fs9W48rt8d7azegyHMwz6PwoKSNnmuVO
 zmtovQqUiJZqbnsd/FXlFnxhnrdu6TLZCXsIBb7tzZ9T1RKK2JF/zgw0qbROfPNIbZdy
 AzzvDmRuy1AfsNG7usbNYIuXM8veMSHEPpv9yTqW60T86Vc4AAqbu99YT7L3BwoaqVMb
 cAEpb3R1GjU0p2DljvvqRzmz6o9VZ2WQfXgG/dFrKLNxPiiUvH+fr4X3bagcES+Kgter
 bOphy/Vt8sWZRNLFj+hCZryFHQukTwJ9QtCbxsptP6BdJiK+/yRZZjldCcsT7TRKnUw7
 WvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785076068; x=1785680868;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1sBx2kKtuxRUa86eZ7Tw3dvx7AMR/K7Ts577Kgrg7uY=;
 b=Et9bskrNWGd8WQ3lEf6+FVYRJ+XVRDrZltuSsTnHH4M57nUrJ2F5/3+nMw/Oh7oNcg
 YBChe3h1YNRvull5Mg+DtdM3Crhwrk+rCCz+3LJyrOVoFmgH5a9qlPQgKnIfC9HEchbH
 MmP2bFXsBe0ezVZ0481dUR9zGo8PpCb/4EDNpLnjTm3safD3OJbcBmQRiuUUXxRIQzxa
 nKxYG7SIYxpA9xABCn2Lq3GVA9ORtnrPJPVKR4J3m43UthrJK2J4IIsOftxt2rxl57G/
 6ktA+ltcNc32ibnMnq9msC49M+AlNbSGBg8owQ6X9iE4VnxMYwkgIy6Agi2QhRJuBqna
 gMWQ==
X-Gm-Message-State: AOJu0YwW4VPW0KOPpX8o/YLRCzpylNYfP3Wmkl9ERnR8VAgoD+Xoouvx
 +0HGUL8Vo6a4yzhNTMerpLNqf11yDqDP9dZBEfiC1fbl9Iawa9sdiqlWLC9A5KmzqCP1EQ==
X-Gm-Gg: AR+sD13S8Gg/EmeLsDXCviiFMSVyYrMDbbW04trXaSmbazNrK0xF+N6gS/DqTmCpgnW
 VCuY94G6Neu4Xl/++QP0LS6mv9KmfDbIM19OEEwCQECfJHIzcGj9uUl61CtsRdcuN2ytvlzZ/bd
 b43fKBOzu7oKWUV8wVlOd31WCDcjn8zTXu14Kl+3Wn7fIA5dG1EEw6c+6rJRXVF+m8oDSYPgN/8
 ClA+FPIjbANOcH6hL4AUrMMVZjEgSOCDwMEiQIAoP1hBSNE8mc+cXJbeBdUIkGx8eQY4RE9cIBm
 N1h6/WalxBuHjE2BE3vX9I1gRJpMZY/Kn5Lw8PWEnsHIIAiY4QUPPACo+6KAp1dOomNDo4m2kaM
 3FA45pq4FCUaP7jCKqF+TCts8VNn/K3AVo8Vh3XjQ69uiPW3bZ/Wr46khxzsKbM9F/eHnocuzce
 I8JE7eVLW0jkwU8g==
X-Received: by 2002:a17:902:d584:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2cfde792ddbmr47752695ad.16.1785076067414; 
 Sun, 26 Jul 2026 07:27:47 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.169.104])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7bc47asm20608055ad.41.2026.07.26.07.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 07:27:46 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH] hw/timer: add k230 dwapb timer
Date: Sun, 26 Jul 2026 22:26:39 +0800
Message-ID: <20260726142703.37637-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x62b.google.com
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

Add DesignWare APB timer peripheral for K230 machine.
The timer uses the Clock framework for frequency input,
preparing for future CMU integration.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  23 +-
 hw/timer/Kconfig                    |   4 +
 hw/timer/k230_dwapb_timer.c         | 332 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   9 +
 include/hw/riscv/k230.h             |   8 +
 include/hw/timer/k230_dwapb_timer.h |  68 ++++++
 tests/qtest/k230-dwapb-timer-test.c | 224 +++++++++++++++++++
 tests/qtest/meson.build             |   2 +-
 11 files changed, 671 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/k230_dwapb_timer.c
 create mode 100644 include/hw/timer/k230_dwapb_timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..ed2ba7c58a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,9 +1826,12 @@ S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: hw/timer/k230_dwapb_timer.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: include/hw/timer/k230_dwapb_timer.h
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-dwapb-timer-test.c
 
 RX Machines
 -----------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..c86968f759 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_TIMER
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..214fb3525e 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -24,6 +24,8 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/riscv/k230.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/machines-qom.h"
@@ -110,6 +112,12 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-dwapb-timer", &s->timer,
+                            TYPE_K230_TIMER);
+
+    Clock *timer_clk = clock_new(OBJECT(s), "timer-clk");
+    clock_set_hz(timer_clk, K230_APBTMR_DEFAULT_FREQ);
+    qdev_connect_clock_in(DEVICE(&s->timer), "pclk", timer_clk);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -191,6 +199,18 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* Timer */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, memmap[K230_DEV_TIMER].base);
+
+    for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), i,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic),
+                                            K230_TIMER0_IRQ + i));
+    }
+
     /* Watchdog */
     for (int i = 0; i < 2; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
@@ -283,9 +303,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
                                 memmap[K230_DEV_IOMUX].size);
 
-    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
-                                memmap[K230_DEV_TIMER].size);
-
     create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
                                 memmap[K230_DEV_WDT0].size);
 
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
index 0000000000..26578b32dd
--- /dev/null
+++ b/hw/timer/k230_dwapb_timer.c
@@ -0,0 +1,332 @@
+/*
+ * K230 DW APB timer
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/bitops.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/timer/k230_dwapb_timer.h"
+#include "migration/vmstate.h"
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
+static uint64_t k230_timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    K230TimerState *s = K230_TIMER(opaque);
+    uint32_t val = 0;
+
+    addr &= 0xfff;
+
+    if (addr < K230_APBTMRS_INT_STATUS) {
+        int idx = addr / K230_APBTMR_STRIDE;
+        int reg = addr % K230_APBTMR_STRIDE;
+
+        if (idx >= K230_APBTMR_NUM_TIMERS) {
+            return 0;
+        }
+
+        switch (reg) {
+        case K230_APBTMR_N_LOAD_COUNT:
+            val = s->timers[idx].load;
+            break;
+        case K230_APBTMR_N_CURRENT_VALUE:
+            if (s->timers[idx].control & K230_APBTMR_CONTROL_ENABLE) {
+                val = ptimer_get_count(s->timers[idx].ptimer);
+            } else {
+                val = 0;
+            }
+            break;
+        case K230_APBTMR_N_CONTROL:
+            val = s->timers[idx].control;
+            break;
+        case K230_APBTMR_N_EOI:
+            s->timers[idx].int_status = 0;
+            qemu_set_irq(s->timers[idx].irq, 0);
+            trace_k230_timer_irq_clear(s->timers[idx].id);
+            val = 0;
+            break;
+        case K230_APBTMR_N_INT_STATUS:
+            if (s->timers[idx].control & K230_APBTMR_CONTROL_INT) {
+                val = 0;
+            } else {
+                val = s->timers[idx].int_status;
+            }
+            break;
+        }
+        goto out;
+    }
+
+    if (addr >= K230_APBTMR_N_LOAD2 &&
+        addr < K230_APBTMR_N_LOAD2 +
+               K230_APBTMR_NUM_TIMERS * K230_APBTMR_LOAD2_STRIDE) {
+        /* LoadCount2: R/W implemented. PWM output not generated. */
+        int idx = (addr - K230_APBTMR_N_LOAD2) / K230_APBTMR_LOAD2_STRIDE;
+        val = s->timers[idx].load2;
+        goto out;
+    }
+
+    switch (addr) {
+    case K230_APBTMRS_INT_STATUS:
+        for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+            if (!(s->timers[i].control & K230_APBTMR_CONTROL_INT)) {
+                val |= s->timers[i].int_status << i;
+            }
+        }
+        break;
+    case K230_APBTMRS_EOI:
+        for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+            s->timers[i].int_status = 0;
+            qemu_set_irq(s->timers[i].irq, 0);
+        }
+        val = 0;
+        break;
+    case K230_APBTMRS_RAW_INT_STATUS:
+        for (int i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+            val |= s->timers[i].int_status << i;
+        }
+        break;
+    case K230_APBTMRS_COMP_VERSION:
+        val = K230_APBTMR_COMP_VERSION_VAL;
+        break;
+    }
+
+out:
+    trace_k230_timer_read(addr, val);
+    return val;
+}
+
+static void k230_timer_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    K230TimerState *s = K230_TIMER(opaque);
+
+    addr &= 0xfff;
+
+    if (addr < K230_APBTMRS_INT_STATUS) {
+        int idx = addr / K230_APBTMR_STRIDE;
+        int reg = addr % K230_APBTMR_STRIDE;
+
+        if (idx >= K230_APBTMR_NUM_TIMERS) {
+            return;
+        }
+
+        switch (reg) {
+        case K230_APBTMR_N_LOAD_COUNT:
+            s->timers[idx].load = value;
+            break;
+        case K230_APBTMR_N_CONTROL: {
+            uint32_t old_ctrl = s->timers[idx].control;
+            s->timers[idx].control = value & K230_APBTMR_CONTROL_RW_MASK;
+            if ((value ^ old_ctrl) & K230_APBTMR_CONTROL_ENABLE) {
+                if (value & K230_APBTMR_CONTROL_ENABLE) {
+                    k230_timer_enable(&s->timers[idx]);
+                } else {
+                    k230_timer_disable(&s->timers[idx]);
+                }
+            }
+            if ((value ^ old_ctrl) & K230_APBTMR_CONTROL_INT) {
+                if (value & K230_APBTMR_CONTROL_INT) {
+                    qemu_set_irq(s->timers[idx].irq, 0);
+                } else if (s->timers[idx].int_status) {
+                    qemu_set_irq(s->timers[idx].irq, 1);
+                }
+            }
+            break;
+        }
+        default:
+            break;
+        }
+        goto out;
+    }
+
+    if (addr >= K230_APBTMR_N_LOAD2 &&
+        addr < K230_APBTMR_N_LOAD2 +
+               K230_APBTMR_NUM_TIMERS * K230_APBTMR_LOAD2_STRIDE) {
+        /* LoadCount2: R/W implemented. PWM output not generated. */
+        int idx = (addr - K230_APBTMR_N_LOAD2) / K230_APBTMR_LOAD2_STRIDE;
+        s->timers[idx].load2 = value;
+    }
+
+out:
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
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..3de3b7e765 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/timer/k230_dwapb_timer.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230TimerState timer;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -127,6 +129,12 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_TIMER0_IRQ = 101,
+    K230_TIMER1_IRQ = 102,
+    K230_TIMER2_IRQ = 103,
+    K230_TIMER3_IRQ = 104,
+    K230_TIMER4_IRQ = 105,
+    K230_TIMER5_IRQ = 106,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
 };
diff --git a/include/hw/timer/k230_dwapb_timer.h b/include/hw/timer/k230_dwapb_timer.h
new file mode 100644
index 0000000000..0e3a8ece0e
--- /dev/null
+++ b/include/hw/timer/k230_dwapb_timer.h
@@ -0,0 +1,68 @@
+/*
+ * K230 DW APB timer
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
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
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    K230Timer timers[K230_APBTMR_NUM_TIMERS];
+    Clock *pclk;
+};
+
+#endif
diff --git a/tests/qtest/k230-dwapb-timer-test.c b/tests/qtest/k230-dwapb-timer-test.c
new file mode 100644
index 0000000000..e995603a36
--- /dev/null
+++ b/tests/qtest/k230-dwapb-timer-test.c
@@ -0,0 +1,224 @@
+/*
+ * QTest testcase for K230 Timer
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "hw/timer/k230_dwapb_timer.h"
+
+#define TIMER_BASE 0x91105800
+#define TIMER_REG(n, reg) (TIMER_BASE + (n) * K230_APBTMR_STRIDE + (reg))
+#define TIMER_TICK_NS (NANOSECONDS_PER_SECOND / K230_APBTMR_DEFAULT_FREQ)
+
+static void timer_load(QTestState *qts, int n, uint32_t value)
+{
+    qtest_writel(qts, TIMER_REG(n, K230_APBTMR_N_LOAD_COUNT), value);
+}
+
+static void timer_enable(QTestState *qts, int n, uint32_t ctrl)
+{
+    qtest_writel(qts, TIMER_REG(n, K230_APBTMR_N_CONTROL), ctrl);
+}
+
+static void timer_disable(QTestState *qts, int n)
+{
+    qtest_writel(qts, TIMER_REG(n, K230_APBTMR_N_CONTROL), 0);
+}
+
+static uint32_t timer_get_and_clear_irq(QTestState *qts, int n)
+{
+    uint32_t int_sts = qtest_readl(qts, TIMER_REG(n, K230_APBTMR_N_INT_STATUS));
+
+    if (int_sts) {
+        qtest_readl(qts, TIMER_REG(n, K230_APBTMR_N_EOI));
+    }
+
+    return int_sts;
+}
+
+static void test_timer_free_running(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_irq(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur = qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE));
+    g_assert_cmphex(cur, <, UINT32_MAX);
+    g_assert_cmphex(cur, >, 0);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_INT_STATUS)), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_periodic(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int i;
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE |
+                        K230_APBTMR_CONTROL_MODE_PERIODIC);
+
+    for (i = 0; i < 3; i++) {
+        qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+        g_assert_cmphex(timer_get_and_clear_irq(qts, 0), ==, 1);
+        uint32_t cur = qtest_readl(qts,
+                          TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE));
+        g_assert_cmphex(cur, <=, 100);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_timer_int_mask(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE |
+                        K230_APBTMR_CONTROL_MODE_PERIODIC |
+                        K230_APBTMR_CONTROL_INT);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_INT_STATUS)) & 1, ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + K230_APBTMRS_INT_STATUS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + K230_APBTMRS_RAW_INT_STATUS) & 1, ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_disable_clears_irq(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE |
+                        K230_APBTMR_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_INT_STATUS)) & 1, ==, 1);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_INT_STATUS)) & 1, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_current_disabled(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* TRM: "A '0' is always read back when the timer is not enabled" */
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE)), ==, 0);
+
+    timer_load(qts, 0, 9999);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE)), ==, 0);
+
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE);
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur_enabled = qtest_readl(qts,
+                              TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE));
+    g_assert_cmphex(cur_enabled, >, 0);
+    g_assert_cmphex(cur_enabled, <, UINT32_MAX);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE)), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_dynamic_reload(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cur;
+
+    timer_load(qts, 0, 1000);
+    timer_enable(qts, 0, K230_APBTMR_CONTROL_ENABLE |
+                        K230_APBTMR_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+
+    timer_load(qts, 0, 200);
+
+    qtest_clock_step(qts, 901ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_irq(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+    cur = qtest_readl(qts, TIMER_REG(0, K230_APBTMR_N_CURRENT_VALUE));
+    g_assert_cmphex(cur, ==, 99);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_all_channels(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int i;
+
+    for (i = 0; i < K230_APBTMR_NUM_TIMERS; i++) {
+        timer_load(qts, i, 100 + i * 50);
+        timer_enable(qts, i, K230_APBTMR_CONTROL_ENABLE |
+                             K230_APBTMR_CONTROL_MODE_PERIODIC);
+    }
+
+    /* Step past timer 0 expiry (load=100) — only timer 0 should fire */
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    uint32_t sts = qtest_readl(qts, TIMER_BASE + K230_APBTMRS_INT_STATUS);
+    g_assert_cmphex(sts & 1, ==, 1);
+    g_assert_cmphex(sts & 0x3e, ==, 0);
+
+    /* Step to timer 1 expiry (another 50 ticks) */
+    qtest_clock_step(qts, 50ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + K230_APBTMRS_INT_STATUS);
+    g_assert_cmphex(sts & 0x3, ==, 0x3);
+    g_assert_cmphex(sts & 0x3c, ==, 0);
+
+    /* Step to expiry of all remaining timers (another 200 ticks) */
+    qtest_clock_step(qts, 200ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + K230_APBTMRS_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0x3f);
+
+    /* EOI_ALL clears all */
+    qtest_readl(qts, TIMER_BASE + K230_APBTMRS_EOI);
+    sts = qtest_readl(qts, TIMER_BASE + K230_APBTMRS_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-dwapb-timer/free_running", test_timer_free_running);
+    qtest_add_func("/k230-dwapb-timer/periodic", test_timer_periodic);
+    qtest_add_func("/k230-dwapb-timer/int_mask", test_timer_int_mask);
+    qtest_add_func("/k230-dwapb-timer/disable_clears_irq",
+                   test_timer_disable_clears_irq);
+    qtest_add_func("/k230-dwapb-timer/current_disabled",
+                   test_timer_current_disabled);
+    qtest_add_func("/k230-dwapb-timer/dynamic_reload",
+                   test_timer_dynamic_reload);
+    qtest_add_func("/k230-dwapb-timer/all_channels", test_timer_all_channels);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..db95099481 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+   (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-dwapb-timer-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


