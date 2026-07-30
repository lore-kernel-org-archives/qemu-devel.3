Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A3DC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQxP-0006a4-Kc; Thu, 30 Jul 2026 09:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQxK-0006Pq-1b
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQxH-0005z7-VQ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ceab75934dso25174605ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418667; x=1786023467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YBIc7qU1l7UiaSisuLpSrifHwV7mtioEOP66kgKIfac=;
 b=YSEbrPafuka08Sgj4R3+1HRILrVV8G/WSCeWlskpLO3XNeOGUNxgW3dv/3rwzqB3T6
 aC5uFVxXFOwYQvJb5uA949KvUi+mQU/QdOE6SQxkoNcK+FSODU465xiJCvjTglwUZiVa
 zItPwhg28UrgpKaUnMcqn3bFQdFR+kaafZInLOyOyhg5ciAN6oA4I23r1+vM+DyW2fiF
 B0UaIjFO9LZ8i5/MZYQPyCrHMcboPIK4QffguoUNMgLUd/0R9NJGlR9zpjXMp9rhk8/l
 SwM/as8YVUe9sAzh8HBPQxHdtgKgdJGYaBtdmJDILgDAPBlD9Q4kGqAOHcq5iPYBPO0R
 rdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418667; x=1786023467;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YBIc7qU1l7UiaSisuLpSrifHwV7mtioEOP66kgKIfac=;
 b=BigVCs9y7BzFMN2scGL/P881ggSaOg+fSe7ziFwHoZe8aJsQaniPxRVCABPCafSedd
 /LITe++1zKj0zZCEGk1i1m9gZl2MsDQfctmMYjjIKVopl8fJ/QWjoS+4Q91ORtC2w9zQ
 xC7TEftOe9MPNDT1jJuOP/bXQ4Gel2p/77EAk6oZwFXrVujRxvsBjiRzavu9SYYyhBvJ
 ir6z5heTuW8FviC6ySGjjkM9x06rOapHrFXmJN0hcIbmGbbBplTo/BA4+9czEsGUDfFR
 PydOfqb/LcbI2mqLvlfuDv7ZzBaziwcgaFA/Bp/Ic4lwEHBlT1pZcq6hF8IhA+SkiT5i
 +7rw==
X-Gm-Message-State: AOJu0YwLcYGcS2v8u1l1CX69YLlhDGyHys412gQh8XzWtJkNBex2Zfzr
 dL8vP4NoreDsnlX2ry7ekSSa9qdPrTZQEA4A6NVltPO5KsvwgwW6wsizGdaUU3H1feg=
X-Gm-Gg: AR+sD10PcXC9ifVSUXCGFGtoKAkeQ1OZFQTWs4CLoj8GHCgUAP9bH9ncc53aAIguLch
 YTfRKuYMeOseB6d7q9L2Vx4jE5SqyPB05CZP/RgsPuewQOw4YzsPaaT5kDAyA23n3WO3ube49d1
 6gHnMJXBR//aD9KliQpZ7s58Vm0gBPVKygV9lCxsYZaTBYq3oeTefkGgh0QqCd3jiurPXPRWOpX
 0U6M1ErnZBaVjumKUHu9DCd4TS0JbvkrkMXCU2cWBnxrya/xu1jC5Lyx7oFVFZIRASgfAESh+59
 acOMWZbNIw/L8//8YWXbC1ELE1S2LJHUMOAmHdvG6hGqO9LaZCbzuKCUeJr5LYU7XPK+GnXfpSj
 xy4WMcXDkMUKcRiwUfPekgDg00NWmTOYJKZbd/0mJdRxc3BaHUsW3nYcrczphxS3wrzqrj0JMHK
 pAhIN4CHyp/OiMKo9+RnjwWhW9pKruSQDUqfPasjXvcFAkr2lHqgf79odOR663uvKtvX/0B4Y=
X-Received: by 2002:a17:902:cf41:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d035b94236mr28369805ad.4.1785418666530; 
 Thu, 30 Jul 2026 06:37:46 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.230.138.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf845asm26757745ad.60.2026.07.30.06.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:37:46 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v2 3/3] tests/qtest: add k230 dwapb timer test
Date: Thu, 30 Jul 2026 21:37:11 +0800
Message-ID: <20260730133713.3253-4-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730133713.3253-1-rao232328@gmail.com>
References: <20260730133713.3253-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x634.google.com
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

Add qtest coverage for K230 DW APB timer including
free-running, periodic, interrupt mask, disable
behavior, current value, dynamic reload, and
multi-channel scenarios.

Add timer files to MAINTAINERS.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 MAINTAINERS                         |   3 +
 tests/qtest/k230-dwapb-timer-test.c | 227 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   2 +-
 3 files changed, 231 insertions(+), 1 deletion(-)
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
diff --git a/tests/qtest/k230-dwapb-timer-test.c b/tests/qtest/k230-dwapb-timer-test.c
new file mode 100644
index 0000000000..7fe380bb61
--- /dev/null
+++ b/tests/qtest/k230-dwapb-timer-test.c
@@ -0,0 +1,227 @@
+/*
+ * QTest testcase for K230 Timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
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
+    uint32_t int_status = qtest_readl(qts,
+                            TIMER_REG(n, K230_APBTMR_N_INT_STATUS));
+
+    if (int_status) {
+        qtest_readl(qts, TIMER_REG(n, K230_APBTMR_N_EOI));
+    }
+
+    return int_status;
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


