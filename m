Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BEBCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOT-0003Bm-PL; Thu, 15 Oct 2026 21:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM5-0000PG-Gn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM2-0004Gf-4W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso13197405ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112605; x=1792717405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toepaO2Qnf467clvBazzgWABEQupTheKuW6gtMVLac0=;
 b=EXzdU0DoGRkyRU2mF9mQQuddzQccAW8FArgv1zE3yV+yYtKV8C/II5BFvbK7XRf8eK
 zR4m+y1K6SehCBOC7EwxVBmntrBXtWco+96fA/z6b41Q7JSWHbtcGyqQPd6LsdA3YnFw
 Eu0h58ieQoEH+xwd1JneludDmaxtu+r9nJmaAXR/t0XWMu0jKvdjLcdNHU8H9tTQstKq
 ttwkogDBfMPgHclviN/O/6kkPDfx2QgBCw1V9JYFz1Tlv4iscp0mwIWwgom3KpaiMShJ
 zRZMcTiWw1MqajMysSRftWORV8wMap533J+PMeLv7l50ckIJ3lYgF5tCWeMmr3eGo7Fs
 yzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112605; x=1792717405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=toepaO2Qnf467clvBazzgWABEQupTheKuW6gtMVLac0=;
 b=Qlvu4E9XpmnpKYKpEJPYGi4EFWYHnDyeLodqL3imv11+r94tUTZSxr89iSHd3n73mu
 7Nv3C+PVA1JByNrWzmXWG2mHPyZJW1MDgRFJlITNiiVDb5rI0rDUl2D96mseRCj/VwxY
 3P27oTRjKtIHrarqpa374KsVvcJTKwsOHcWZDMsAaUtY0xZKo6DGIvFX+yeZuZL/ZSIS
 zbx+Gr23uJBAgIe0Lry5f2uNPhsqn3n/J3Nuj6KR1y29OWBzBPDBa3ccUJroNOZnmhku
 nVeye36HSuZWKe6bRvy5o3eFC2x7j8jaiuzuUy1F21pCdmP1+xSYRhar0uJRTurdNfYV
 YE9Q==
X-Gm-Message-State: AFq9FYJiYUS7N+1G3Pv2+1M/epaZL2XQ7B2odi1axnaqbDiLq3fmFIIo
 YcVj+TPcIyw3auYl/vh+4hWLOdyutcrwgJ2VhRGXvjjT4LnSBF6m2cR1CiDJcQ==
X-Gm-Gg: AYBFou2L+s7rooL2AK3bjl+omE6XmTSJxVC7SYlfmEm1TdBOG3pDV6rq6BckIz2eTWB
 CN61kTfbRCtP0+Wl/0LBPqjr+vjnpk9kI2ZU8XRPvjR9LjtY7CEe8fvuT6fic+zeuy6shcfNbTr
 HpKr52/YhDI9olqVVkKplxL32MMqOY0RYfJspBRvxG44J8QkRVKDSslfaHkeTkxrkTg/MJSoBMO
 FMcqg/pEGldgYX3792wFAdCDqzldeVoWp07t5JZsIi0k5Urgnr5E0rj9tkomQun4daSHjnTi5aT
 hp1x5ItwTOcC8htGqagMmyB7EGJdEW/OWs1FmD3WChfY/C+XL9AndxI5R+yaRClGv1JCJDgvJAn
 9FWN0zqiYfnn3dOF80D9MxU5SYc/N06joz18jujmWMsCUv3+LfjRNz+X6UYM2xrgJBAOR0kshXC
 uXEDk57LIwRS88cIF0pbSWsQhMx0nWnxIlPIORn1DPCc5LQoCJoVpsMc0Am0x0w8rFyin0HwV4U
 igNgyOwse5olM5r
X-Received: by 2002:a17:903:120f:b0:2e8:e617:18 with SMTP id
 d9443c01a7336-2e8e617032emr118516235ad.48.1792112604445; 
 Thu, 15 Oct 2026 18:03:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 13/50] tests/qtest: Add qtest for Milk-V Duo board
Date: Fri, 16 Oct 2026 11:02:00 +1000
Message-ID: <20261016010237.1102834-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add minimal qtest coverage for the Milk-V Duo machine to validate basic
MMIO mapping and register access.

Currently tested:
- Verify DW8250 UART component version and type signatures.
- Test read/write access to CV1800B clock bypass register.

Tested with:
$ meson test -C build -v qemu:qtest-riscv64/milkv-duo-test
[...]
Ok:                 1
Fail:               0

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-6-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                  |  1 +
 tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |  3 +-
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/milkv-duo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a615ecf95..8de16c1959 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1879,6 +1879,7 @@ F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/qtest/milkv-duo-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/milkv-duo-test.c b/tests/qtest/milkv-duo-test.c
new file mode 100644
index 0000000000..06064b8733
--- /dev/null
+++ b/tests/qtest/milkv-duo-test.c
@@ -0,0 +1,70 @@
+/*
+ * QTest for Milk-V Duo Board
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define CV1800B_CLK_BASE            0x03002000
+#define CV1800B_CLK_BYPASS          0x030
+#define CV1800B_CLK_BYPASS_RESET    0xFFFFFFFF
+#define TEST_PATTERN_5A             0x5A5A5A5A
+#define TEST_PATTERN_A5             0xA5A5A5A5
+
+#define CV1800B_UART0_BASE          0x04140000
+#define DW_UART_UCV                 0xF8
+#define DW_UART_CTR                 0xFC
+#define DW_UART_VERSION_3_23A       0x3332332A
+#define DW_UART_TYPE_SIGNATURE      0x44570110
+
+static void test_milkv_duo_uart(void)
+{
+    QTestState *qts;
+    uint32_t component_version;
+    uint32_t component_type;
+
+    qts = qtest_init("-M milkv-duo");
+
+    component_version = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_UCV);
+    g_assert_cmphex(component_version, ==, DW_UART_VERSION_3_23A);
+
+    component_type = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_CTR);
+    g_assert_cmphex(component_type, ==, DW_UART_TYPE_SIGNATURE);
+
+    qtest_quit(qts);
+}
+
+static void test_milkv_duo_clk(void)
+{
+    QTestState *qts;
+    uint32_t clk_bypass_val;
+
+    qts = qtest_init("-M milkv-duo");
+
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, CV1800B_CLK_BYPASS_RESET);
+
+    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_5A);
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_5A);
+
+    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_A5);
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_A5);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/riscv/milkv-duo/uart", test_milkv_duo_uart);
+    qtest_add_func("/riscv/milkv-duo/clk", test_milkv_duo_clk);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36..18fceca421 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -315,7 +315,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
   (config_all_devices.has_key('CONFIG_K230') ?
-   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : [])
+   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : []) + \
+   ['milkv-duo-test']
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
-- 
2.55.0


