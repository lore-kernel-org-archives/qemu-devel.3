Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981E8C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgGN-0001Rn-E3; Tue, 11 Aug 2026 02:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgGK-0001Ig-Aj
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:47:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgGI-0005Q8-5Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:47:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d01663d816so23813635ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786430816; x=1787035616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r/3tunvNDh+d2dbLfwBToYPitzpMWQNF1ejrM3C3nhg=;
 b=cogdzkGMIUUqh8d3LoQ86h5UeSYaZdR0Tw7Q+uNiG2kdv/bJt3rK+MO62jXihfu/Tm
 R8MbOkkb0CeQTjgKDgnUwhbbhPV+e610LGBp/F0FngZT2tRU5TuLMh3zPbm5zvcBK78o
 u+lDX+Dcf8EPtGzpfk2ZFcDHAEWzgDf+HctQ2SC1YlkxoljdGu0wBMTK675Pcx4vHmRh
 dQaMzc6USNNj5B3wME4gjr2gM8T5rCEgqDcdq+Co+q2PqTSKmfN4LHzWsDJ1ADPLm5yn
 0MOLgBb7MSyQgRuPPw2UJtXquEPPxS8aXXRqOi3OCiVlzUon7O4MVdAD441V98YSIyo/
 OSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430816; x=1787035616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r/3tunvNDh+d2dbLfwBToYPitzpMWQNF1ejrM3C3nhg=;
 b=Cq3TEi/UdgjgYUh9cRMrW0RT125yVegAS/bx0WXNwowKsd/bNrWxU/FgczgHJ3GH2j
 pWngUtaHXeQsOy8oMn0ZJADfW0F1BzDbpvIbpmYge7Knw8W1pgVNRN9JbLWmlDNJhSJM
 J6Q+IksJzwCSgTIb+gLWKFL7qzGN/TGpVhPz0MCzrwYWxy0B9jUJOItgX29Pxt3XlDJ9
 p1/YUFOx+jV1/9syKBulXmnSQSLzQZFljUcQP1owPVH3b+L7YeuoFIdPyGzEY5JW4OjB
 P5ZXHl0CKN5JG1Ha6fR5woj4qmOEZE0dvZ0nF8bZNVWnSrVf6CSaF37N9QR2q2NnKswq
 nRUw==
X-Gm-Message-State: AOJu0Yy6u/t9tLta8BLkS1ldGvHSfernxr6KVmLmmLOQlwIjHjH3Kkj6
 vSnFhpbP3yVC3iW4H9Ku6+rRALxWR8XNEQsliMlHD0zDrzVFX2hn5u8y9CtiCSKn
X-Gm-Gg: AR+sD133+VrncSODpJrM/aEXRHckFfEznSb3p3NwONTbb8MZmPn3B0BU63c3R9U17em
 0o2aw5CeFKH0e/D5mLGlzoKVYh//ceIe5TK5vP8p7J4kKNHLKRcjDnEQRCE4+X3O2E/HVqsyJU0
 CplBXRIsplQlAXZ/y2dXG+a7AQWmBZC1xnYpCXaipH1wAlxm/wUNe4YunK6Bppg0CxfieZ2eYH+
 GiiWNNfHDV5CYg307047hvd/zMu8WDVDBFctbTV2JMxEnHEaRlkQzi6YjajwS6NaqbRKBemQf7z
 WQOz6pcixu7I1fwGRmdtNRrppoN8RiVc9ewWddYzrr54dU8T8r0Sx70NeRBr6CCY4+a0Oq2Gj36
 KybCM/8JvXSyggWNKZyCnYR2R1Z9AoPKgRdtMUP+dqhinyYbiQ33Q052JrNJdyQEcQsQkM9UCeS
 vQK0L2NdQLVs3JxPDZmi/LR0tudQD5YDQjJ7Hsey7FajvftdJF4OxhsBtq0MvuFETUF3OyLPZC
X-Received: by 2002:a17:903:3248:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d31776bf4emr16642285ad.3.1786430816422; 
 Mon, 10 Aug 2026 23:46:56 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d315f3ffd5sm2591015ad.30.2026.08.10.23.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 23:46:55 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, bmeng.cn@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v3 3/3] tests/qtest: add k230 dwapb timer test
Date: Tue, 11 Aug 2026 14:46:10 +0800
Message-ID: <20260811064612.16517-4-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811064612.16517-1-rao232328@gmail.com>
References: <20260811064612.16517-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x630.google.com
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
 tests/qtest/k230-dwapb-timer-test.c | 261 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   4 +-
 3 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..b30bcba640 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,9 +1826,12 @@ S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: hw/timer/dw-apb-timer.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: include/hw/timer/dw-apb-timer.h
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/dw-apb-timer-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-dwapb-timer-test.c b/tests/qtest/k230-dwapb-timer-test.c
new file mode 100644
index 0000000000..70dc384bfa
--- /dev/null
+++ b/tests/qtest/k230-dwapb-timer-test.c
@@ -0,0 +1,261 @@
+/*
+ * QTest testcase for the DesignWare APB timer through the K230 machine
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "hw/timer/dw-apb-timer.h"
+
+#define TIMER_BASE 0x91105800
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 6250000
+#define TIMER_REG(n, reg) (TIMER_BASE + (n) * DW_APB_TIMER_STRIDE + (reg))
+#define TIMER_TICK_NS (NANOSECONDS_PER_SECOND / K230_TIMER_DEFAULT_FREQ)
+
+static void timer_load(QTestState *qts, int n, uint32_t value)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_LOAD_COUNT), value);
+}
+
+static void timer_enable(QTestState *qts, int n, uint32_t ctrl)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_CONTROL), ctrl);
+}
+
+static void timer_disable(QTestState *qts, int n)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_CONTROL), 0);
+}
+
+static uint32_t timer_get_and_clear_status(QTestState *qts, int n)
+{
+    uint32_t int_status = qtest_readl(qts,
+                            TIMER_REG(n, DW_APB_TIMER_N_INT_STATUS));
+
+    if (int_status) {
+        qtest_readl(qts, TIMER_REG(n, DW_APB_TIMER_N_EOI));
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
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur = qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+    g_assert_cmphex(cur, <, UINT32_MAX);
+    g_assert_cmphex(cur, >, 0);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)), ==, 0);
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
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    for (i = 0; i < 3; i++) {
+        qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+        g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+        uint32_t cur = qtest_readl(qts,
+                          TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
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
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC |
+                        DW_APB_TIMER_CONTROL_INT);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_INT_STATUS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_RAW_INT_STATUS) & 1, ==, 1);
+
+    /* Unmasking a pending interrupt must assert it immediately. */
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)), ==, 1);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_INT_STATUS) & 1, ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_disable_clears_irq(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 1);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 0);
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
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+
+    timer_load(qts, 0, 9999);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE);
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur_enabled = qtest_readl(qts,
+                              TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+    g_assert_cmphex(cur_enabled, >, 0);
+    g_assert_cmphex(cur_enabled, <, UINT32_MAX);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
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
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+
+    timer_load(qts, 0, 200);
+
+    qtest_clock_step(qts, 901ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+    cur = qtest_readl(qts, TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
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
+    for (i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        timer_load(qts, i, 100 + i * 50);
+        timer_enable(qts, i, DW_APB_TIMER_CONTROL_ENABLE |
+                             DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    }
+
+    /* Step past timer 0 expiry (load=100) — only timer 0 should fire */
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    uint32_t sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts & 1, ==, 1);
+    g_assert_cmphex(sts & 0x3e, ==, 0);
+
+    /* Step to timer 1 expiry (another 50 ticks) */
+    qtest_clock_step(qts, 50ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts & 0x3, ==, 0x3);
+    g_assert_cmphex(sts & 0x3c, ==, 0);
+
+    /* Step to expiry of all remaining timers (another 200 ticks) */
+    qtest_clock_step(qts, 200ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0x3f);
+
+    /* EOI_ALL clears all */
+    qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_EOI);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_reset(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_LOAD_COUNT)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CONTROL)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_RAW_INT_STATUS), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/dw-apb-timer/free_running", test_timer_free_running);
+    qtest_add_func("/dw-apb-timer/periodic", test_timer_periodic);
+    qtest_add_func("/dw-apb-timer/int_mask", test_timer_int_mask);
+    qtest_add_func("/dw-apb-timer/disable_clears_irq",
+                   test_timer_disable_clears_irq);
+    qtest_add_func("/dw-apb-timer/current_disabled",
+                   test_timer_current_disabled);
+    qtest_add_func("/dw-apb-timer/dynamic_reload",
+                   test_timer_dynamic_reload);
+    qtest_add_func("/dw-apb-timer/all_channels", test_timer_all_channels);
+    qtest_add_func("/dw-apb-timer/reset", test_timer_reset);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..295a724116 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,9 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') and
+   config_all_devices.has_key('CONFIG_DW_APB_TIMER') ?
+   ['k230-wdt-test', 'k230-dwapb-timer-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


