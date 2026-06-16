Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200CACD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjz-0008Qz-0w; Tue, 16 Jun 2026 06:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjk-0007zl-Lz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:42 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjg-000442-QH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:39 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c858014845aso1731272a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604575; x=1782209375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGkE009GNow9syyzIXj+mGbpD3051NRC2Q/viPyeNb8=;
 b=rZLlkxU8cWiTTNuQXO2Tk8sLW4x1Sn3UuZA2jmqMxnTnuFPlZ7d0Ryh8XbkgmZQ1EZ
 WkKUFcppxK1nBJ26iOvAyBkqG+2IPVUqAE2jvhIQQCtUwOqvYMv50BldY9mU3BQlBi04
 RnJjco5BOWPcK0ibLqWF5pJzQZJNs0q1TEnuzRCMYEGV7zU3hR08ZAJfDk6cTHbyrXI6
 r/DW8QQSn78kKqZ6OcqLBs1H9wHEEETsUkGkaBhqAtzKYPHtosKBRUixdIrHgzfUTDjv
 nbbsad94FvJ8nwKp3AAfXBw1RxY/A9xt5DJkegntZyQBlFi4I0q/uBbbkgxiqGksyGuE
 T5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604575; x=1782209375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FGkE009GNow9syyzIXj+mGbpD3051NRC2Q/viPyeNb8=;
 b=R0i1mVoQRObvBV+eS1rbBExWBJXdzhb6YqGt/2tSfKfr7aMAuSdJ4J65uo5XC4k+0g
 kuJu4CINhQr0lMj0e6a6xfEOAFGOnCj3JR4Ek84CU0jFNWG1J4t6dxdnLe7bkRMpOl1E
 QItcPipO5tyGy6x5Mtzg77q9XfneNgPa+EJWSsRYVMPT+TENm0JiL1dxQxayZ29cnn5A
 mNt4Zl++26tVqsDgUe6T9WBiJhaJUXboVyJNE7ROf/56+3Qh39dSf59jDndP0owGgCUX
 cK3IoluKOheLgM3wvhon8ySEKhXWpsiY7exmgk58qpOvHWyQKA8pmKc4JyRnNpZ3V4k0
 EtMQ==
X-Gm-Message-State: AOJu0YxbbaWF71kY80QXnS7L9J3rXLNrRXo45l3ewdYzgKNXo68GkU/g
 Fd+k9uj05+n+NNNosAWvy/i6TYhAP+VxwQrLpJxcfCJDJG1erEMKYpLcksF3h5Ot
X-Gm-Gg: Acq92OHs/AtPXw8trasD0udgLcVmAGxkdmHnAFOjTcfYVe44NrArIr1Y43o9NNefWM6
 CNnLBxkWrgjvMNvkZR4ziegdlgvJ7mZwho2ylGOhi0SIAkFJchUerC01nPcC2RQHwtmSq3SZVr0
 lM8Nu7J5o27bFkZFyRwWLN5eH0uOpkmXXRatMM2S9SyAjdlTU2XuiFjdjWXBn5vvtXJqMBG+RpI
 ped1WRlZGjDzIjuQt3Onlt9t4pWT5lqxxs+IVeu0+qLKNMSJqmlr68TS2DioHe5Ym1fD9bAc0Zj
 eN4FUMITt9VtgcXuAXLGuoAHJcgWqpzdPAjFSs1uFJG55bE9nIsi249bfX0PKGhOh+ZXfpV6qQa
 W3bdymkpDGZDaPW2uX8uNrQ6vk3RvBU/6RHLgqaMlNusJX85HzJelxqTFTLGthIZgv5RevjONhi
 5upZp0pSUhyKdo3NBCS4rW7ESwl2aCtGXyP0LcJn+d
X-Received: by 2002:a05:6a21:487:b0:3b4:5ea5:6bc with SMTP id
 adf61e73a8af0-3b7e2204328mr2796942637.5.1781604575056; 
 Tue, 16 Jun 2026 03:09:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Liu <chao.liu@zevorn.cn>,
 Mig Yang <temashking@foxmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 68/83] hw/watchdog: add k230 watchdog initial support
Date: Tue, 16 Jun 2026 20:05:11 +1000
Message-ID: <20260616100527.1939565-69-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Chao Liu <chao.liu@zevorn.cn>

Add programmable Watchdog Timer (WDT) peripheral for K230 machine.

Signed-off-by: Mig Yang <temashking@foxmail.com>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <805a04d9467556ee6a5f4742c9eb4bbb6fc7898c.1781246408.git.chao.liu@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                    |   2 +
 include/hw/riscv/k230.h        |   4 +
 include/hw/watchdog/k230_wdt.h | 121 ++++++++++++++
 hw/riscv/k230.c                |  18 ++
 hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |   1 +
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 9 files changed, 456 insertions(+)
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 hw/watchdog/k230_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a21796ac6f..06db33a107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1791,7 +1791,9 @@ M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/riscv/k230.c
+F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
+F: include/hw/watchdog/k230_wdt.h
 
 RX Machines
 -----------
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index dcfde39096..592e1c26bf 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,6 +17,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -31,6 +32,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -125,6 +127,8 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_WDT0_IRQ   = 107,
+    K230_WDT1_IRQ   = 108,
 };
 
 #define K230_UART_COUNT 5
diff --git a/include/hw/watchdog/k230_wdt.h b/include/hw/watchdog/k230_wdt.h
new file mode 100644
index 0000000000..ba194abebe
--- /dev/null
+++ b/include/hw/watchdog/k230_wdt.h
@@ -0,0 +1,121 @@
+/*
+ * K230 Watchdog Timer
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef K230_WDT_H
+#define K230_WDT_H
+
+#include "qemu/bitops.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/ptimer.h"
+#include "qom/object.h"
+
+#define TYPE_K230_WDT "riscv.k230.wdt"
+OBJECT_DECLARE_SIMPLE_TYPE(K230WdtState, K230_WDT)
+
+#define K230_WDT_DEFAULT_FREQ (32768)
+
+/* K230 Watchdog Register Map */
+enum K230WdtRegisters {
+    K230_WDT_CR      = 0x00,  /* Control Register */
+    K230_WDT_TORR    = 0x04,  /* Timeout Range Register */
+    K230_WDT_CCVR    = 0x08,  /* Current Counter Value Register */
+    K230_WDT_CRR     = 0x0c,  /* Counter Restart Register */
+    K230_WDT_STAT    = 0x10,  /* Interrupt Status Register */
+    K230_WDT_EOI     = 0x14,  /* Interrupt Clear Register */
+    K230_WDT_PROT_LEVEL = 0x1c, /* Protection Level Register */
+    K230_WDT_COMP_PARAM_5 = 0xe4, /* Component Parameters Register 5 */
+    K230_WDT_COMP_PARAM_4 = 0xe8, /* Component Parameters Register 4 */
+    K230_WDT_COMP_PARAM_3 = 0xec, /* Component Parameters Register 3 */
+    K230_WDT_COMP_PARAM_2 = 0xf0, /* Component Parameters Register 2 */
+    K230_WDT_COMP_PARAM_1 = 0xf4, /* Component Parameters Register 1 */
+    K230_WDT_COMP_VERSION = 0xf8, /* Component Version Register */
+    K230_WDT_COMP_TYPE = 0xfc, /* Component Type Register */
+};
+
+#define K230_WDT_MMIO_SIZE 0x100
+
+/* Control Register (WDT_CR) definitions */
+#define K230_WDT_CR_RPL_MASK    0x7        /* Reset Pulse Length */
+#define K230_WDT_CR_RPL_SHIFT   2
+#define K230_WDT_CR_RMOD        BIT(1)     /* Response Mode */
+#define K230_WDT_CR_WDT_EN      BIT(0)     /* Watchdog Enable */
+
+/* Reset Pulse Length values */
+#define K230_WDT_RPL_2_CYCLES   0x0
+#define K230_WDT_RPL_4_CYCLES   0x1
+#define K230_WDT_RPL_8_CYCLES   0x2
+#define K230_WDT_RPL_16_CYCLES  0x3
+#define K230_WDT_RPL_32_CYCLES  0x4
+#define K230_WDT_RPL_64_CYCLES  0x5
+#define K230_WDT_RPL_128_CYCLES 0x6
+#define K230_WDT_RPL_256_CYCLES 0x7
+
+/* Timeout Range Register (WDT_TORR) definitions */
+#define K230_WDT_TORR_TOP_MASK  0xf        /* Timeout Period */
+
+/* Interrupt Status Register (WDT_STAT) definitions */
+#define K230_WDT_STAT_INT       BIT(0)     /* Interrupt Status */
+
+/* Counter Restart Register (WDT_CRR) magic value */
+#define K230_WDT_CRR_RESTART    0x76       /* Restart command */
+
+/* Component Parameters Register 1 (WDT_COMP_PARAM_1) definitions */
+#define K230_WDT_CNT_WIDTH_MASK 0x1f000000 /* Counter Width */
+#define K230_WDT_CNT_WIDTH_SHIFT 24
+#define K230_WDT_DFLT_TOP_INIT_MASK 0xf00000 /* Default Initial Timeout */
+#define K230_WDT_DFLT_TOP_INIT_SHIFT 20
+#define K230_WDT_DFLT_TOP_MASK  0xf0000    /* Default Timeout */
+#define K230_WDT_DFLT_TOP_SHIFT 16
+#define K230_WDT_DFLT_RPL_MASK  0x7        /* Default Reset Pulse Length */
+#define K230_WDT_DFLT_RPL_SHIFT 10
+#define K230_WDT_APB_DATA_WIDTH_MASK 0x3   /* APB Data Width */
+#define K230_WDT_APB_DATA_WIDTH_SHIFT 8
+#define K230_WDT_USE_FIX_TOP    BIT(6)     /* Use Fixed Timeout Values */
+#define K230_WDT_HC_TOP         BIT(5)     /* Hard-coded Timeout */
+#define K230_WDT_HC_RPL         BIT(4)     /* Hard-coded Reset Pulse Length */
+#define K230_WDT_HC_RMOD        BIT(3)     /* Hard-coded Response Mode */
+#define K230_WDT_DUAL_TOP       BIT(2)     /* Dual Timeout Period */
+#define K230_WDT_DFLT_RMOD      BIT(1)     /* Default Response Mode */
+#define K230_WDT_ALWAYS_EN      BIT(0)     /* Always Enabled */
+
+/* Component Type Register value */
+#define K230_WDT_COMP_TYPE_VAL  0x44570120
+
+/* Component Version Register value */
+#define K230_WDT_COMP_VERSION_VAL 0x3131302a  /* "110*" */
+
+struct K230WdtState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    struct ptimer_state *timer;
+
+    /* Register state */
+    uint32_t cr;           /* Control Register */
+    uint32_t torr;         /* Timeout Range Register */
+    uint32_t ccvr;         /* Current Counter Value Register */
+    uint32_t stat;         /* Interrupt Status Register */
+    uint32_t prot_level;   /* Protection Level Register */
+
+    /* Internal state */
+    bool interrupt_pending;
+    bool enabled;
+    uint32_t timeout_value;
+    uint32_t current_count;
+};
+
+#endif /* K230_WDT_H */
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 26d1e20c99..502281c52c 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -108,6 +108,9 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -188,6 +191,21 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* Watchdog */
+    for (int i = 0; i < 2; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[1]), 0, memmap[K230_DEV_WDT1].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
diff --git a/hw/watchdog/k230_wdt.c b/hw/watchdog/k230_wdt.c
new file mode 100644
index 0000000000..1f83b499e8
--- /dev/null
+++ b/hw/watchdog/k230_wdt.c
@@ -0,0 +1,296 @@
+/*
+ * K230 Watchdog Compatible with kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "system/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/watchdog/k230_wdt.h"
+#include "trace.h"
+
+static void k230_wdt_timeout(void *opaque)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_timeout();
+
+    /* Set interrupt status if in interrupt mode */
+    if (s->cr & K230_WDT_CR_RMOD) {
+        s->stat |= K230_WDT_STAT_INT;
+        s->interrupt_pending = true;
+        qemu_set_irq(s->irq, 1);
+        trace_k230_wdt_interrupt();
+    } else {
+        /* Direct reset mode */
+        trace_k230_wdt_reset();
+        watchdog_perform_action();
+    }
+
+    /* Restart counter */
+    s->current_count = s->timeout_value;
+    ptimer_set_count(s->timer, s->current_count);
+    ptimer_run(s->timer, 1);
+}
+
+static void k230_wdt_reset(DeviceState *dev)
+{
+    K230WdtState *s = K230_WDT(dev);
+
+    trace_k230_wdt_reset_device();
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_transaction_commit(s->timer);
+
+    /* Reset registers to default values */
+    s->cr = 0;
+    s->torr = 0;
+    s->ccvr = 0xFFFFFFFF;
+    s->stat = 0;
+    s->prot_level = 0x2;
+
+    s->interrupt_pending = false;
+    s->enabled = false;
+    s->timeout_value = 0;
+    s->current_count = 0xFFFFFFFF;
+}
+
+static uint64_t k230_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+    uint32_t value = 0;
+
+    switch (addr) {
+    case K230_WDT_CR:
+        value = s->cr;
+        break;
+    case K230_WDT_TORR:
+        value = s->torr;
+        break;
+    case K230_WDT_CCVR:
+        if (s->enabled) {
+            value = ptimer_get_count(s->timer);
+        } else {
+            value = s->current_count;
+        }
+        break;
+    case K230_WDT_STAT:
+        value = s->stat;
+        break;
+    case K230_WDT_PROT_LEVEL:
+        value = s->prot_level;
+        break;
+    case K230_WDT_COMP_PARAM_5:
+        value = 0; /* Upper limit of Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_4:
+        value = 0; /* Upper limit of Initial Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_3:
+        value = 0; /* Derived from WDT_TOP_RST parameter */
+        break;
+    case K230_WDT_COMP_PARAM_2:
+        value = 0xFFFFFFFF; /* Derived from WDT_RST_CNT parameter */
+        break;
+    case K230_WDT_COMP_PARAM_1:
+        /* Component parameters */
+        value = (32 << K230_WDT_CNT_WIDTH_SHIFT) |  /* 32-bit counter */
+                (0 << K230_WDT_DFLT_TOP_INIT_SHIFT) |
+                (0 << K230_WDT_DFLT_TOP_SHIFT) |
+                (K230_WDT_RPL_16_CYCLES << K230_WDT_DFLT_RPL_SHIFT) |
+                (2 << K230_WDT_APB_DATA_WIDTH_SHIFT) | /* 32-bit APB */
+                K230_WDT_USE_FIX_TOP; /* Use fixed timeout values */
+        break;
+    case K230_WDT_COMP_VERSION:
+        value = K230_WDT_COMP_VERSION_VAL;
+        break;
+    case K230_WDT_COMP_TYPE:
+        value = K230_WDT_COMP_TYPE_VAL;
+        break;
+    default:
+        /* Other registers return 0 */
+        break;
+    }
+
+    trace_k230_wdt_read(addr, value);
+    return value;
+}
+
+static void k230_wdt_update_timer(K230WdtState *s)
+{
+    ptimer_transaction_begin(s->timer);
+
+    if (s->enabled && s->timeout_value > 0) {
+        ptimer_set_count(s->timer, s->current_count);
+        ptimer_run(s->timer, 1);
+    } else {
+        ptimer_stop(s->timer);
+    }
+
+    ptimer_transaction_commit(s->timer);
+}
+
+static uint32_t k230_wdt_calculate_timeout(uint32_t top_value)
+{
+    /* Calculate timeout based on TOP value */
+    /* For fixed timeout mode: 2^(16 + top_value) */
+    if (top_value <= 15) {
+        return 1 << (16 + top_value);
+    }
+    return 1 << 31; /* Maximum value for 32-bit counter */
+}
+
+static void k230_wdt_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_write(addr, value);
+
+    switch (addr) {
+    case K230_WDT_CR:
+        s->cr = value & (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT |
+                         K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+        /* Update enabled state */
+        s->enabled = (s->cr & K230_WDT_CR_WDT_EN) != 0;
+
+        /* Update timer */
+        k230_wdt_update_timer(s);
+        break;
+
+    case K230_WDT_TORR:
+        s->torr = value & K230_WDT_TORR_TOP_MASK;
+
+        /* Calculate new timeout value */
+        s->timeout_value = k230_wdt_calculate_timeout(s->torr);
+        s->current_count = s->timeout_value;
+
+        /* Update timer if enabled */
+        if (s->enabled) {
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_CRR:
+        /* Restart counter with magic value 0x76 */
+        if ((value & 0xFF) == K230_WDT_CRR_RESTART) {
+            trace_k230_wdt_restart();
+            s->current_count = s->timeout_value;
+
+            /* Clear interrupt if pending */
+            if (s->interrupt_pending) {
+                s->stat &= ~K230_WDT_STAT_INT;
+                s->interrupt_pending = false;
+                qemu_set_irq(s->irq, 0);
+            }
+
+            /* Update timer */
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_EOI:
+        /* Clear interrupt */
+        s->stat &= ~K230_WDT_STAT_INT;
+        s->interrupt_pending = false;
+        qemu_set_irq(s->irq, 0);
+        break;
+
+    case K230_WDT_PROT_LEVEL:
+        s->prot_level = value & 0x7;
+        break;
+
+    default:
+        /* Read-only registers, ignore writes */
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_wdt_ops = {
+    .read  = k230_wdt_read,
+    .write = k230_wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const VMStateDescription vmstate_k230_wdt = {
+    .name = "k230.wdt",
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(timer, K230WdtState),
+        VMSTATE_UINT32(cr, K230WdtState),
+        VMSTATE_UINT32(torr, K230WdtState),
+        VMSTATE_UINT32(ccvr, K230WdtState),
+        VMSTATE_UINT32(stat, K230WdtState),
+        VMSTATE_UINT32(prot_level, K230WdtState),
+        VMSTATE_BOOL(interrupt_pending, K230WdtState),
+        VMSTATE_BOOL(enabled, K230WdtState),
+        VMSTATE_UINT32(timeout_value, K230WdtState),
+        VMSTATE_UINT32(current_count, K230WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_wdt_realize(DeviceState *dev, Error **errp)
+{
+    K230WdtState *s = K230_WDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &k230_wdt_ops, s,
+                          TYPE_K230_WDT,
+                          K230_WDT_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = ptimer_init(k230_wdt_timeout, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, K230_WDT_DEFAULT_FREQ);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void k230_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_wdt_realize;
+    device_class_set_legacy_reset(dc, k230_wdt_reset);
+    dc->vmsd = &vmstate_k230_wdt;
+    dc->desc = "K230 watchdog timer";
+    set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
+}
+
+static const TypeInfo k230_wdt_info = {
+    .name          = TYPE_K230_WDT,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230WdtState),
+    .class_init    = k230_wdt_class_init,
+};
+
+static void k230_wdt_register_type(void)
+{
+    type_register_static(&k230_wdt_info);
+}
+type_init(k230_wdt_register_type)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f512ed65ac..54e41a6afc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -148,3 +148,4 @@ config K230
     select RISCV_IMSIC
     select SERIAL_MM
     select UNIMP
+    select K230_WDT
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd00334..55f77c5c84 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -18,6 +18,10 @@ config WDT_DIAG288
 config WDT_IMX2
     bool
 
+config K230_WDT
+    bool
+    select PTIMER
+
 config WDT_SBSA
     bool
 
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 15370565bd..5edae65a36 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -6,5 +6,6 @@ system_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 system_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 system_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+system_ss.add(when: 'CONFIG_K230_WDT', if_true: files('k230_wdt.c'))
 system_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index ad3be1e9bd..d85b3ca769 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -33,3 +33,12 @@ spapr_watchdog_expired(uint64_t num, unsigned action) "num=%" PRIu64 " action=%u
 # watchdog.c
 watchdog_perform_action(unsigned int action) "action=%u"
 watchdog_set_action(unsigned int action) "action=%u"
+
+# k230_wdt.c
+k230_wdt_read(uint64_t addr, uint32_t data) "K230 WDT read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_wdt_write(uint64_t addr, uint64_t data) "K230 WDT write: [0x%" PRIx64 "] <- 0x%" PRIx64
+k230_wdt_timeout(void) "K230 WDT timeout"
+k230_wdt_interrupt(void) "K230 WDT interrupt"
+k230_wdt_reset(void) "K230 WDT system reset"
+k230_wdt_restart(void) "K230 WDT restart"
+k230_wdt_reset_device(void) "K230 WDT device reset"
-- 
2.54.0


