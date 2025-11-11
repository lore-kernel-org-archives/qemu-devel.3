Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63748CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrO-0006ye-CY; Tue, 11 Nov 2025 06:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImr2-0006AX-76
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:08 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImr0-0004UC-H9
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ba599137cf7so3193877a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861684; x=1763466484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGpZjE7tpDNSik0V3pZhxubMyG3kWmXqewOoOV3rCEU=;
 b=IP/hMKKoIHfpVIwrX32BJfSApjm7kUo458imGn3q/XI4DdstDahEAxm4tE8AZvytGu
 3VYMn+a1CN8bGNbPGQBHTezmemtjtee5L1ZU3Gf90Y1JuyBdMwQMhBULjh+EPb7zUCc3
 DEihXOmudxTDbKYD4Td9PSCAIhOY/OE+4tYZNt2J+pMYF5qfLlmFs5U3wzF9HTP68JmH
 +GMu37Iy5l3nqP7utbGKB44e4zf8ztZdRSmKkBT3Qlf5aH2Wy02MDZrHTCUYyhjAoI9P
 Cv+6/aH8bJXI47bSk0MZnPs6/PYPZeN/HvqLWip5rhMQMQcX/SPgQs26IcWjcUxQ98ll
 kazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861684; x=1763466484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lGpZjE7tpDNSik0V3pZhxubMyG3kWmXqewOoOV3rCEU=;
 b=nkdwDFXZp/fiL5Qtcj8HJl9eZiVzSUHbSNk5zdaa1hQ9ie9pp/eXZbuxRNvo/fmA4f
 t8Q+p9dxmAdaXglz7MOlaXZQ/FHCVwH498GGr0OQZ49+6R5lkGvFWv0DMS3fOliUZpCY
 61EOKFuvdUmLOrgY1PGmHn/eNry1LeMKDvUi4EiS8BsEc4kkMxcb4s2jKYLM/VaO3GQL
 mCG5i1QS1wE0c/jVBv228Y5xjSjZp85vMRU82McAWAbszsetlWOGlPCbW6yIraIab7lk
 KUQiwahnvZx3buoBAfwW3vYzGcHVLMuQ+HUEkDqLHOQLxzarIfeJSfJs3cNTrpRDeqv5
 jx0Q==
X-Gm-Message-State: AOJu0YzpTLNAz0tB84FDZlzt4jsvZ6I7ExWVYHCFyn+Ilk3pDjJ2YzHH
 BwR0RR+QZXHBpfcCQyroDm5VY20RDYBLr/9oHsmOwafNwF6LOwP5TJ6I79jRLqjlBzjd2Qt/xvM
 z5dETJZ4=
X-Gm-Gg: ASbGncs5NM4g6stipLZ/ZqimssNwXM4wVuB49Bq8YNGth6W9mEjSQknNU/z0r3ObnvD
 l3SD4AncXew+LiTtrmsg1tae60iFUiIsYIWA1fs3Fp9YrA8pU6AFpzDtrYe0oj3ItDBFOT7bwh4
 FB96qb5yt0xJTHBxXawlTizw8DlOamCR/kD0fMJDi+WZNEbogz00uMDj1rLGs9W/83HgqnhTEe+
 WSOpVU7SyQa6PhQRn63/KbLtNILqv7Y6p5hUWxijQM+ToQGi3lSPlMG7NqBxDuoYX+FMnXy48V6
 PQjGJTogL4x8vj6kZXtjBnnJ/7Y86D+swE+QqpzPoQLphgCDilDrs5AEhLjpUcy+kGu7NkOevkq
 JwxlEaBQ9ZbZ0fXDu8tWmJvrjdIeoZESOVImfe6ziloiL0ukzUaZnbOz1WqMT4fY03ygxAosi7Y
 r6EhhiK9QuRCau5OjmdkaP4CcBd7o1lVnkgffIaw==
X-Google-Smtp-Source: AGHT+IFpJPgOH6VIuE7Icw/ZGRDew6iC/mNVa/DNRvRhDwelg+rp5tk9zGufpenYMAEg/x6a3DI+Og==
X-Received: by 2002:a17:902:cf04:b0:296:5e6b:e1c8 with SMTP id
 d9443c01a7336-297e5606ec8mr154168655ad.13.1762861684544; 
 Tue, 11 Nov 2025 03:48:04 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:04 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/17] test/qtest: add riscv-trace-test.c
Date: Tue, 11 Nov 2025 08:46:48 -0300
Message-ID: <20251111114656.2285048-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a simple smoke test for the trace encoder/trace ram sink integration
with the RISC-V 'virt' machine.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c                |   2 +-
 tests/qtest/meson.build        |   2 +-
 tests/qtest/riscv-trace-test.c | 120 +++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/riscv-trace-test.c

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 30e89a6c5a..fe49b1eda2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1711,7 +1711,7 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
-        if (tcg_enabled()) {
+        if (tcg_enabled()  || qtest_enabled()) {
             virt_init_socket_trace_hw(s, i);
         }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..07663c4836 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -281,7 +281,7 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
-qtests_riscv64 = ['riscv-csr-test'] + \
+qtests_riscv64 = ['riscv-csr-test', 'riscv-trace-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
diff --git a/tests/qtest/riscv-trace-test.c b/tests/qtest/riscv-trace-test.c
new file mode 100644
index 0000000000..e442f69286
--- /dev/null
+++ b/tests/qtest/riscv-trace-test.c
@@ -0,0 +1,120 @@
+/*
+ * Testcase for RISC-V Trace framework
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/registerfields.h"
+
+/* taken from virt machine memmap */
+#define TE_BASE   0x3020000
+#define TRAM_BASE 0x6000000
+
+REG32(TR_TE_CONTROL, 0x0)
+    FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 0, 32)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 0, 32)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 0, 32)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+static uint32_t test_read_te_control(QTestState *qts)
+{
+    return qtest_readl(qts, TE_BASE + A_TR_TE_CONTROL);
+}
+
+static void test_write_te_control(QTestState *qts, uint32_t val)
+{
+    qtest_writel(qts, TE_BASE + A_TR_TE_CONTROL, val);
+}
+
+static uint64_t test_read_tram_ramstart(QTestState *qts)
+{
+    uint64_t reg = qtest_readl(qts, TRAM_BASE + A_TR_RAM_START_HIGH);
+
+    reg <<= 32;
+    reg += qtest_readl(qts, TRAM_BASE + A_TR_RAM_START_LOW);
+    return reg;
+}
+
+static uint64_t test_read_tram_writep(QTestState *qts)
+{
+    uint64_t reg = qtest_readl(qts, TRAM_BASE + A_TR_RAM_WP_HIGH);
+
+    reg <<= 32;
+    reg += qtest_readl(qts, TRAM_BASE + A_TR_RAM_WP_LOW);
+    return reg;
+}
+
+static void test_trace_simple(void)
+{
+    QTestState *qts = qtest_init("-machine virt -accel tcg");
+    double timeout_sec = 0.5;
+    uint64_t reg_tram_start, reg_tram_writep;
+    uint32_t reg;
+
+    reg = test_read_te_control(qts);
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ACTIVE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ACTIVE));
+
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ENABLE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ENABLE));
+
+    /*
+     * Verify if RAM Sink write pointer is equal to
+     * ramstart before start tracing.
+     */
+    reg_tram_start = test_read_tram_ramstart(qts);
+    g_assert(reg_tram_start > 0);
+    reg_tram_writep = test_read_tram_writep(qts);
+    g_assert(reg_tram_writep == reg_tram_start);
+
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, INST_TRACING, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
+
+    g_test_timer_start();
+    for (;;) {
+        reg_tram_writep = test_read_tram_writep(qts);
+        if (reg_tram_writep > reg_tram_start) {
+            break;
+        }
+
+        g_assert(g_test_timer_elapsed() <= timeout_sec);
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/riscv-trace-test/test-trace-simple",
+                   test_trace_simple);
+    return g_test_run();
+}
-- 
2.51.1


