Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D53606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mF3vkaOy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJ4-0004xO-IN; Fri, 30 Oct 2026 10:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoc-000699-5u
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:42 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoa-0007cQ-3x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:41 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6df7f544919so455827eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367519; x=1793972319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvwnfkxM9sorbQR/zXxvf5R6xwOBdfOZMc+U57NOVTs=;
 b=mF3vkaOyEmNgBRRpRjxCjJ2XJdRBqskTbd/ZFZvn901Ra0YF9SMHjvQELxSeojnaij
 Joz/3LmSWKaMQKTjSnlgJ6fR8ha80yuSc4KLsTct7Z+jH4LFRAxKOPLS8RIVOPV8SeQ4
 OGtg18fN42ElR+bLMvl+nM3yX4LEYv7LHhrQrUIKbBm67+PjIt8NZEBbcxfrlu9nGHiE
 6Jb+lzh3GXBS0/ejhCLYwOpzRanhy0KtExqLyBSEPIVvPRFGB4bvWQCNjyAZO2Ea8az7
 kFSG28/4SxPwTgvIA1A8jT+q7gdzwMmFck9FEl9xLXKM30DoHOScIL9vOPgoOI1h5iTr
 oBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367519; x=1793972319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvwnfkxM9sorbQR/zXxvf5R6xwOBdfOZMc+U57NOVTs=;
 b=jUgIKB6Sqb9lMNT1IH8Y2DjLLfHzefRuPW0dTzTOupHdfT+0JkujBWqfJx945tCqY8
 KTDtgb0PfvBxoPEQM/AmHdA3wwwYMZMF6wLLP6WpF0tSO9jN1pROxLzoW9YU4DS3wsE/
 HINiS5cAFjC2n2u+fIoxLd+3YWHCpPqA686Eh9qUWRY+vNEQUyg2yxiTXSqihaqUVaZq
 Op0D8CYtkjquWyvjJEfoBrbvI9djg4+9j59iNaxhGHv9eaXFiRWqASDVOjYQWgbplpCb
 GhXjNUFShEqGfwRZRQJ3+SxFyZ8ToCyRAdZvPaRS6foniJCHfEQIh4LuSh6MjCgjRMVI
 lhxw==
X-Gm-Message-State: AFq9FYIJTyGa0QXSmF1Hk8qhFeJ9GU4VurRc7kb3pkPhEO5ww1WG0gD6
 R2kAQUlmy/dS/IkkMs7noWzrL05V1plDKCWgjUmGAdOHm7GhDiS/SYZGQHXc8w==
X-Gm-Gg: AYBFou2W9J0GWupuLytdcrOSlurPMomjKtAGgPYjlbdbHjNBYClPxSRgWU8ogxWV5Nr
 tGroIA4vkPR0afwByo/VGlyiFc99mgaODv4xz2ySXXm0/jKznu23d4CXWTGFI1iOFb5QNM89+N/
 ryuqbStPwlNWR8icuqNe6ZU4cCYGM3qjpJs/paJezW2KT+wFamgxgP70MA5SnWwZK3DF0G7ot3S
 YLIhqyH+3EAiOULbC+tO3ckYqnPsb8iqKXT3TLHZp3InzuJH2RqfCnIxJD2cbOCOTnv5qW6rr2U
 3oIfc/ohtvDgfDV3kdeGPsq+oiBfLHiaWnJXQP16C6D+2ysET28VMa9dIovC0/rPUYKVtQNXeBl
 3ffmjYs53FW5o04hokytWGIdYrlwSH1N0DuJOolVP6IeoyDzVbuTI7iJF1BN2tC0i39GVz8a7aJ
 g7vaEjLLdZaE25QnBwFGjr4mjoDkpIF2bERTcYIueSHWyZZZd+w16m4vOlpLtYAjvx0rS7AwLCG
 tQK6800j81EapMcjMYmSraBjUH5GlSbYwIp31AjBLksMKezLf2ORvs+Gbm3zfgkZgN/z/KECHt3
 4jNxs6q49mAPX0mKIJU/vlwjpVlQtqG0UpEM2nPGXA==
X-Received: by 2002:a05:6820:80c:b0:713:e433:7e6d with SMTP id
 006d021491bc7-714f2927fe1mr1479673eaf.36.1793367518737; 
 Fri, 30 Oct 2026 06:38:38 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm1861421eaf.12.2026.10.30.06.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:38:38 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>, Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v6 3/3] tests/qtest: add k230 dwapb timer test
Date: Fri, 30 Oct 2026 21:37:04 +0800
Message-ID: <20261030133704.99678-4-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030133704.99678-1-rao232328@gmail.com>
References: <20261030133704.99678-1-rao232328@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=rao232328@gmail.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:09:57 -0400
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

Add qtest coverage for K230 DW APB timer, including free-running,
periodic, interrupt mask, disable behavior, current value, dynamic
reload, and multi-channel scenarios.

Add timer test file to MAINTAINERS.

Signed-off-by: raoyi <rao232328@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
---
 MAINTAINERS                         |   1 +
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 3 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60a5664ce5..3817598c29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1897,6 +1897,7 @@ F: include/hw/misc/k230_decomp_gzip.h
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
index 46d4fc1d2b..9cadae79f4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,7 +318,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
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


