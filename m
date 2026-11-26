Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1823606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wfbwr22p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWV6x-0001US-MK; Thu, 26 Nov 2026 03:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xWV6v-0001Rt-0m
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:45:45 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xWV6s-0003tD-Fs
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:45:44 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso3512666a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795682740; x=1796287540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZS/h51vhek5P5j+aQELeGfyM6Jc+VsEQmZQPiqkj5vc=;
 b=Wfbwr22p4f39V7Zl0r8DIIX1ac2/On1qnXby2TxBTyUZFZcA6SDZRKZYCN5mA+eZg8
 WyZprmCSTb2duYTYvYOqhCAtQCAgc1Tu0S3vP7Xsm2pgIh7LCZnkdjIuqrOawebiEsf5
 luY0FWgCJT06zf6Z8F/8wcTx/Qk8b7dIxhU1PuXiIDawPfQTGbgX5XudnDS2SH3TqE8f
 DmRLjZep7n90CvZgnQBakavFIqLDBF1E26UcMfM5+4f3gwe5KRNnK6IIFYRpg+i8AasU
 fMP0A9ut0IUgS7tbJMetW5zlUYGFrVWPyNzNzViol49kRECAjBtT2m9sAaanpDeEgS0A
 TqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795682740; x=1796287540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZS/h51vhek5P5j+aQELeGfyM6Jc+VsEQmZQPiqkj5vc=;
 b=RZvzbM4ZWu2Y1vEkwnEiYUtHSTQ6aq2U70IfXZw84iWEswBOTSyZf2HgKEjD/lu9gc
 pzWj9QNmdd/cxJePZYOQYeW6V4VysdxwMDIJJVmsUR0HnhfLobRiiiNEKOKliHLvtUaT
 9DXAaGAktK+J+TKOEej46AJuyXLXemKpHKnB6f0MibPr64hJU/9cv66sfOT8jPSiPNhn
 PTC2+eUSaNG2LExaOcI4+UUjb5RpOn1XqWwA8MZJzNczFd1I4np4IkDhLquhOx1mVqJp
 PnW11WWbcXxmi6aMDgjli4S5SMbnZ+k4kJ6ymUDQ0sOn2C2Ag8NXYZCnh9xOv99WSrEA
 fAtw==
X-Gm-Message-State: APuU4Z8X9u7I2TA6SbTs9VEvftlnwrUGHYwm1+d4gMxq50/iDDLgV68+
 Zq8s+Xfl3ARVUuu9P/Oel5qlRIhigTEJ0avuSe3OorbkEbbQRMsjAZpqC/txJw==
X-Gm-Gg: AZFdTZf900ULx8lP0PuRJMzF9xhT43k8jHqB0hp9TBM6f6rnGn4QzZr/NLY6N0VI5hL
 hJ6sHI5dQPc8t+sEtnIOBjyAVl2Khiek5vwp04J1MYTm75wD/JLtV5Yq93trBTEVPyJ1xYbom3u
 5+dXiC5UG7Wln45mHvO7xYBn4IufP8DGtIivIPJqRNAARNu3U0vZ3w43gPvoVbRp5r4mOJZD6gG
 84b73l4c+nMR8LnD8m+wC4uj4kM2PDZ46Nz2Mn99ZenPsOLqtG8n/hrTY5h6QFvgO0uNJaBNdeQ
 2Wrd9qaM7I573txYRnmpRXlM3iZQH/SQjlshFlXf2eVYbHmTt7gZMmd/CdiLe4TFMMElYmcQo6+
 lDGCCSGOLvvN2p25D/tzXXpIHpcTf1tZVQt/79iQzpsaxPU3+/fC5QC/Pt/XqFrK3WGKgo+RRPZ
 tpxsNBl2OhLjI9VIUh5VI+Foz5Ntc0qIHX6zlK4QkgUeggI25JwsP94jGYVdlzyMBQt79OOQc/T
 v8jdu7w1596RilEr52wuvsEPTfmfGFoe5MSzJBA7/Jo7V0UzgMx/xZ0DcbkKbo3okENJr6lRC8m
 QyaGGbmcHjUzHk23ov3BPk44uwo/9+zdhjNH+UheooDRtVHnSq+3B4ZMv6QaYw==
X-Received: by 2002:a17:90b:4b0e:b0:3b1:8380:a9a0 with SMTP id
 98e67ed59e1d1-3b41c95c18dmr20901408a91.46.1795682739533; 
 Thu, 26 Nov 2026 00:45:39 -0800 (PST)
Received: from DESKTOP-DFGP8OG.lan ([120.230.138.47])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d63728sm36939464a91.8.2026.11.26.00.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 00:45:39 -0800 (PST)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>, Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v7 3/3] tests/qtest: add k230 dwapb timer test
Date: Thu, 26 Nov 2026 16:44:53 +0800
Message-ID: <20261126084453.23021-4-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126084453.23021-1-rao232328@gmail.com>
References: <20261126084453.23021-1-rao232328@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=rao232328@gmail.com; helo=mail-pj1-x1035.google.com
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

Add qtest coverage for the K230 DW APB timer, exercising the
behaviors the Linux dw_apb_timer driver relies on: free-running
and periodic modes, per-channel interrupt generation and masking,
the disable/reload/enable sequence, current value readback, and
multiple channels.

Signed-off-by: raoyi <rao232328@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
---
 MAINTAINERS                         |   1 +
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 3 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 24dec5f4e8..c055ec9617 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1901,6 +1901,7 @@ F: include/hw/misc/k230_decomp_gzip.h
 F: include/hw/timer/dw-apb-timer.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-ddr-test.c
+F: tests/qtest/k230-dwapb-timer-test.c
 F: tests/qtest/k230-wdt-test.c
 F: tests/qtest/k230-gsdma-test.c
 F: tests/qtest/k230-decomp-gzip-test.c
diff --git a/tests/qtest/k230-dwapb-timer-test.c b/tests/qtest/k230-dwapb-timer-test.c
new file mode 100644
index 0000000000..01bf03a8b6
--- /dev/null
+++ b/tests/qtest/k230-dwapb-timer-test.c
@@ -0,0 +1,274 @@
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
+
+#define TIMER_BASE 0x91105800
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 50000000
+
+#define DW_APB_TIMER_STRIDE       0x14
+#define DW_APB_TIMER_N_LOAD_COUNT     0x00
+#define DW_APB_TIMER_N_CURRENT_VALUE  0x04
+#define DW_APB_TIMER_N_CONTROL        0x08
+#define DW_APB_TIMER_N_EOI            0x0c
+#define DW_APB_TIMER_N_INT_STATUS     0x10
+#define DW_APB_TIMER_INT_STATUS        0xa0
+#define DW_APB_TIMER_EOI               0xa4
+#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
+#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
+#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
+#define DW_APB_TIMER_CONTROL_INT_MASK      BIT(2)
+
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
+                        DW_APB_TIMER_CONTROL_INT_MASK);
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
+    /* Step past timer 0 expiry (load=100) - only timer 0 should fire */
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
index 6e2938d913..c0207140cd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -325,7 +325,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
   (config_all_devices.has_key('CONFIG_K230') ?
-   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : []) + \
+   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test',
+    'k230-decomp-gzip-test', 'k230-dwapb-timer-test'] : []) + \
    ['milkv-duo-test']
 
 qtests_hexagon = ['boot-serial-test', 'hexagon-config-test', 'l2vic-test',
-- 
2.53.0


