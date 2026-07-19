Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD24CC44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVrR-0006wz-Ol; Sun, 19 Jul 2026 14:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVrQ-0006we-Hd
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVrI-0004hq-Mg
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:31 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so6688713a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484203; x=1785089003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TwQYHCt7Kk8nxw2rwfRfbN3mzgvXTaoOo6RqYm4euOs=;
 b=IJd8u8w4t6i45iuB1xmNiKQKQ8lEwUanJxcDVeb8C/g87BYv+wPnaOKcpVNDAg7PJ9
 CpQRHmNTqgkmXNh85l6RsvQv3adIg6351lqOqJMwCw3lPyEtTCqNaUqCVeVK9Ar6Eumc
 f2z1JjTFZ3oE/qw1o2o/QQQRDeVN8UeAskN1tUx6vL0PAZTFppvCf95WcsZnJLtig99K
 fAmla++QGiQs0vwqtLu5yz6MMiwqYWiIUmlaybek1gzI7AkJJpzl7Aa39N9DZi8RtEtd
 2RJTuMNDFbLXkfS5kAB/AB50fQR2fF3IAgrtYwEquR69aN68ultka9fYff23GxDAou+F
 Z4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484203; x=1785089003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TwQYHCt7Kk8nxw2rwfRfbN3mzgvXTaoOo6RqYm4euOs=;
 b=ibWSXygWRAmEtLymCdvpeieZfqRIbvTOCbjaUvfpAcX/RVfPmJ7NWZKut+NlPUf8nb
 XmrqVcPW8bAk878t8zGRpnD+eEf1NSutHyDgnK2gR7u5xHU7+QzC1ABTdio5qc9cI7un
 PRFBjuOtfvrXUfOc51Ll62dlYSt6ERdCHy/gtXrPmbq5o9aWdXBR5pz3inD7P2x0pGmK
 AegsVv50uwC3zqPqwrJwRt8rTM3ssfmA7SiRd3zfYh3m5tLuLQVMaEW7oup9BhzN0KWP
 JTIw8vXUibqOSCoJtMNKtkt6Hjhb/gUJyThzMmQGkIjU/GiAdLIP9MoKxHqCkMbfQFPE
 r8gg==
X-Gm-Message-State: AOJu0YzB2UPUKPyFyxuNaoFXP6EfCuyXapMJ/jFWFul18FzNxaN6r5Pl
 5qZSy1hHchq+Wid+SkeMAZjC0lx01W/CHrv9JxHx32pZShRBsXh0jjSGX+wlsg==
X-Gm-Gg: AfdE7ck1t/+V+5T7bU2nzmctc4YhR/njiurGCU9oit2tavgowBdUOqev70hB+QdFoYB
 JrKkvjmnlRbcat8S96Q57Aop5dX6AeyMAOeiHt6R/mbwkfgxysvPsh3nzQgze6Kn/kkwr9UrZp4
 sbmMBXGSEUi49h2ExmSxTa72DScii346ruEIwOHDyXZYhKWFpV0YXZPb8/Io8VHGLVVCEwdyn6b
 oQYGVr1HKpgEtP4PUr8OLbGQILnB2kcfZ3Pc5oYqdU8S/+jf5rm4oATcJX9euSc0jYSr3erb+sz
 65TldSZHuaBgVyDv3rCOx1zyck3YxrNcD1y1BcPMJhPoH1SrBIGzR+A3mmVFpcXgCA/msQUOGDT
 a/0pfqAMzPtuzfPj/DPsBNJDbfnhKoFFD9z335ppFFtCRVFgjgMfe1S+aeo8HSIFyBAN6anvhf/
 AyZlgKWxBQdtu9KQ==
X-Received: by 2002:a05:6a21:3983:b0:3c3:68b0:e273 with SMTP id
 adf61e73a8af0-3c3ad6042c6mr12130265637.15.1784484202793; 
 Sun, 19 Jul 2026 11:03:22 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb519de3437sm3312907a12.28.2026.07.19.11.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Jul 2026 11:03:21 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jack Wang <163wangjack@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 qemu-riscv@nongnu.org (open list:K230 Machines)
Subject: [PATCH v2 2/2] hw/riscv/k230: wire up the RMU device
Date: Mon, 20 Jul 2026 02:02:47 +0800
Message-ID: <20260719180247.8660-3-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719180247.8660-1-163wangjack@gmail.com>
References: <20260719180247.8660-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The previous commit added the K230 RMU device model but left it
unconnected. This commit integrates it into the K230 SoC:

- Instantiate K230RmuState in K230SoCState structure
- Realize and memory-map the device at 0x91101000 in k230_soc_realize()
- Connect the two watchdogs via the RMU "wdt0"/"wdt1" QOM links so that a
  software reset request in PERI0 cold-resets the real WDT devices
- Remove the create_unimplemented_device("rmu") stub
- Add CONFIG_K230_RMU=y selection in hw/riscv/Kconfig
- Update documentation to list RMU in supported devices
- Add the qtest and its MAINTAINERS entry

The qtest lives here rather than with the device model so the series stays
bisectable: it drives "-machine k230", which only exists once the device is
wired up. It covers all reset types, the documented reset values, the
reserved-bit masks, the CPU1 two-step assert/deassert sequence and the real
watchdog reset propagation.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 MAINTAINERS                 |   1 +
 docs/system/riscv/k230.rst  |   1 +
 hw/riscv/Kconfig            |   1 +
 hw/riscv/k230.c             |  15 ++-
 include/hw/riscv/k230.h     |   2 +
 tests/qtest/k230-rmu-test.c | 225 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 7 files changed, 244 insertions(+), 4 deletions(-)
 create mode 100644 tests/qtest/k230-rmu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80061ce66d..91305b86fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1814,6 +1814,7 @@ F: hw/watchdog/k230_wdt.c
 F: include/hw/misc/k230_rmu.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-rmu-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..3f2313a127 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
+* K230 Reset Management Unit (RMU)
 * 5 UART
 
 Boot options
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..bffa4e69c8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -149,3 +149,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_RMU
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52c..dc008eb6fa 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-rmu",  &s->rmu,    TYPE_K230_RMU);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -206,6 +207,17 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* RMU (reset management unit) */
+    /* Link the watchdogs so the RMU can reset them (before realize). */
+    object_property_set_link(OBJECT(&s->rmu), "wdt0",
+                             OBJECT(&s->wdt[0]), &error_abort);
+    object_property_set_link(OBJECT(&s->rmu), "wdt1",
+                             OBJECT(&s->wdt[1]), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rmu), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rmu), 0, memmap[K230_DEV_RMU].base);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -268,9 +280,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
                                 memmap[K230_DEV_CMU].size);
 
-    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
-                                memmap[K230_DEV_RMU].size);
-
     create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
                                 memmap[K230_DEV_BOOT].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..13f2a1ab0b 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/misc/k230_rmu.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230RmuState rmu;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
diff --git a/tests/qtest/k230-rmu-test.c b/tests/qtest/k230-rmu-test.c
new file mode 100644
index 0000000000..a16c837382
--- /dev/null
+++ b/tests/qtest/k230-rmu-test.c
@@ -0,0 +1,225 @@
+/*
+ * QTest for the K230 Reset Management Unit.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/misc/k230_rmu.h"
+
+#define K230_RMU_BASE 0x91101000ULL
+
+static inline uint32_t rd(QTestState *qts, uint64_t off)
+{
+    return qtest_readl(qts, K230_RMU_BASE + off);
+}
+static inline void wr(QTestState *qts, uint64_t off, uint32_t val)
+{
+    qtest_writel(qts, K230_RMU_BASE + off, val);
+}
+
+/*
+ * Documented reset values (K230 TRM chapter 2.1.5, per-bit "Reset" column).
+ * The *_rst_done status bits reset to 0, so these differ from each register's
+ * summarised "Total Reset Value".
+ */
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Control registers. */
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL),  ==, 0x00000000);
+    g_assert_cmphex(rd(qts, K230_RMU_CPU1_CTRL),  ==, 0x00000001);
+    g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL),    ==, 0x00000000);
+    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, 0x000ff0ff);
+    g_assert_cmphex(rd(qts, K230_RMU_PERI1_CTRL), ==, 0x007e7fff);
+    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL), ==, 0x00000000);
+    g_assert_cmphex(rd(qts, K230_RMU_SRAM_CTRL),  ==, 0x00000002);
+    g_assert_cmphex(rd(qts, K230_RMU_ISP_CTRL),   ==, 0x0000039f);
+
+    /* A representative reset-time-control register. */
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_TIM),   ==, 0x00fff880);
+    g_assert_cmphex(rd(qts, K230_RMU_USB_TIM),    ==, 0x0008d288);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Reset-time-control registers are plain read/write storage: they come up with
+ * their documented value and accept arbitrary writes with no side effects.
+ */
+static void test_tim_storage(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(rd(qts, K230_RMU_MCTL_TIM), ==, 0x00000304);
+    wr(qts, K230_RMU_MCTL_TIM, 0x12345678);
+    g_assert_cmphex(rd(qts, K230_RMU_MCTL_TIM), ==, 0x12345678);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Reserved bits are read-only zero: a write to an undocumented bit position is
+ * dropped. ISP_CTL documents bits 0-9 and 28-29; bit 15 is reserved.
+ */
+static void test_reserved_bits(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t before = rd(qts, K230_RMU_ISP_CTRL);
+
+    wr(qts, K230_RMU_ISP_CTRL, before | BIT(15));
+    g_assert_cmphex(rd(qts, K230_RMU_ISP_CTRL) & BIT(15), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * CPU0: a low-half write without its strobe is ignored; with the strobe the
+ * reset request fires, latches done (bit12), and the request bit auto-clears.
+ */
+static void test_cpu_write_enable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* No strobe: the low-half write is dropped, reads back as 0. */
+    wr(qts, K230_RMU_CPU0_CTRL, K230_RMU_CPU_RESET);
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, 0);
+
+    /* With strobe (bit16): request bit0 takes effect, done (bit12) latches. */
+    wr(qts, K230_RMU_CPU0_CTRL,
+       K230_RMU_CPU_RESET | (K230_RMU_CPU_RESET << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, K230_RMU_CPU_DONE);
+
+    qtest_quit(qts);
+}
+
+/*
+ * HW_DONE: no write-enable needed. Writing HISYS request bit0 latches its
+ * done bit (bit4); writing 1 to the done bit clears it.
+ */
+static void test_hw_done_and_w1c(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t v;
+
+    wr(qts, K230_RMU_HISYS_CTRL, BIT(0));      /* no strobe */
+    v = rd(qts, K230_RMU_HISYS_CTRL);
+    g_assert_cmphex(v & BIT(4), ==, BIT(4));   /* done latched */
+    g_assert_cmphex(v & BIT(0), ==, 0);        /* request bit auto-cleared */
+
+    wr(qts, K230_RMU_HISYS_CTRL, BIT(4));      /* write-1-to-clear */
+    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL) & BIT(4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* Repeated resets: one HW_DONE line can be triggered again and again. */
+static void test_repeat_reset(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    for (int i = 0; i < 3; i++) {
+        wr(qts, K230_RMU_AI_CTRL, BIT(0));                 /* request */
+        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, BIT(31));
+        wr(qts, K230_RMU_AI_CTRL, BIT(31));                /* W1C done */
+        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, 0);
+    }
+
+    qtest_quit(qts);
+}
+
+/* FLUSH: the CPU0 bit4 flush request is auto-cleared, reads back as 0. */
+static void test_flush_auto_clear(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    wr(qts, K230_RMU_CPU0_CTRL,
+       K230_RMU_CPU_FLUSH | (K230_RMU_CPU_FLUSH << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL) & K230_RMU_CPU_FLUSH, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* SW_DONE: the PERI0 low half is plain storage, no strobe and no done bit. */
+static void test_sw_done_storage(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* WDT0 / WDT1 reset bits */
+    wr(qts, K230_RMU_PERI0_CTRL, BIT(12) | BIT(13));
+    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, (BIT(12) | BIT(13)));
+
+    qtest_quit(qts);
+}
+
+/*
+ * CPU1 needs separate assert and deassert operations: unlike CPU0 its reset
+ * request bit does NOT self-clear. Assert (bit0 + strobe) latches done (bit12)
+ * and keeps bit0 set; deassert (strobe only, bit0 low) clears bit0.
+ */
+static void test_cpu1_two_step(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Assert: request bit0 stays set AND done bit12 latches. */
+    wr(qts, K230_RMU_CPU1_CTRL,
+       K230_RMU_CPU_RESET | (K230_RMU_CPU_RESET << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU1_CTRL), ==,
+                    K230_RMU_CPU_RESET | K230_RMU_CPU_DONE);
+
+    /* Deassert: drive bit0 low with its strobe; bit0 clears, done stays. */
+    wr(qts, K230_RMU_CPU1_CTRL, K230_RMU_CPU_RESET << K230_RMU_WE_SHIFT);
+    g_assert_cmphex(rd(qts, K230_RMU_CPU1_CTRL), ==, K230_RMU_CPU_DONE);
+
+    /* Done is write-1-to-clear (gated by its strobe). */
+    wr(qts, K230_RMU_CPU1_CTRL,
+       K230_RMU_CPU_DONE | (K230_RMU_CPU_DONE << K230_RMU_WE_SHIFT));
+    g_assert_cmphex(rd(qts, K230_RMU_CPU1_CTRL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Reset propagation: asserting a watchdog reset line in PERI0_CTRL performs a
+ * real cold reset of the linked WDT device. Put WDT0 into a non-default state
+ * (TORR != 0), pulse the RMU, and confirm WDT0 came back to its reset value.
+ */
+#define K230_WDT0_BASE 0x91106000ULL
+#define K230_WDT_TORR  0x04
+
+static void test_wdt_reset_propagation(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Dirty WDT0: TORR reset value is 0, write a non-zero timeout range. */
+    qtest_writel(qts, K230_WDT0_BASE + K230_WDT_TORR, 0xf);
+    g_assert_cmphex(qtest_readl(qts, K230_WDT0_BASE + K230_WDT_TORR), ==, 0xf);
+
+    /* Assert WDT0's software reset line through the RMU (PERI0 bit12). */
+    wr(qts, K230_RMU_PERI0_CTRL, K230_RMU_PERI0_WDT0_RST);
+
+    /* WDT0 must be back to its reset value. */
+    g_assert_cmphex(qtest_readl(qts, K230_WDT0_BASE + K230_WDT_TORR), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230/rmu/reset_values",   test_reset_values);
+    qtest_add_func("/k230/rmu/tim_storage",    test_tim_storage);
+    qtest_add_func("/k230/rmu/reserved_bits",  test_reserved_bits);
+    qtest_add_func("/k230/rmu/cpu_we",         test_cpu_write_enable);
+    qtest_add_func("/k230/rmu/cpu1_two_step",  test_cpu1_two_step);
+    qtest_add_func("/k230/rmu/hw_done_w1c",    test_hw_done_and_w1c);
+    qtest_add_func("/k230/rmu/repeat_reset",   test_repeat_reset);
+    qtest_add_func("/k230/rmu/flush",          test_flush_auto_clear);
+    qtest_add_func("/k230/rmu/sw_done",        test_sw_done_storage);
+    qtest_add_func("/k230/rmu/wdt_reset_prop", test_wdt_reset_propagation);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd286..70c9a53454 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -294,7 +294,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test',
+                                                'k230-rmu-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


