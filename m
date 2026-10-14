Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC54CCA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqs-00060q-Ii; Tue, 13 Oct 2026 23:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqo-0005wq-6C
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:23 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpql-0001cr-OX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so1915775a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949218; x=1792554018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S1XJDR9OtqfvoNeWCW8sQ0wmQsbt0AmE5hlrUneIK80=;
 b=KvR4DE83bZST1b6SRi4grITE7VM2rSHsGUdHliAGBLr0ipKK3hj3Fy+83+UQhBNddI
 m5y2mXIsEGv1tdqQQDIzVAXPOqELhukoZByO0y08EdTYd7FxvGgs2RzdHsaV2hKE/1Lo
 QkDBolfJooZAGaHWMM4m792I776pDRrxtS+yWh/nykDDO/maNrHoBQRu+6t0xRAEagts
 A1v5ksG7hCE6CLoN+sLDaySxTo0CXg6mwJ66KGFSRc3CtcHidnWASGRiV3Wh7tBvZvTi
 Ud3ozy8p+kTgIBkPqmGLvb9eoY/hbPIytMSC7z5D+Hz/NEzhgrzz3Tkiiu+ai6oT20wJ
 K1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949218; x=1792554018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S1XJDR9OtqfvoNeWCW8sQ0wmQsbt0AmE5hlrUneIK80=;
 b=QZFf7W6dWMpqzI76aywuNtto35typhiPtjKMxFdaAx0GIgOcxsCxE3rWy+jfNAJPO3
 XA8dcXGNOE+NxFbklq7Ke9H4Ir836c342flZN8AAmz60/kL4MRzhOKn3TTsChL2JVRpb
 J4/e0Zz1okd1cUPHpfZlYFYboFraI9i6cUyZUUtV6gE5p1XXDIMMGClR08Eu3BqqZzHX
 ehzBBZis1XcZpGP+6h/QtyM5o4wiZFshBVKxj5FHci7+B5GHQkJJgufdMtatMIkj0MEX
 8Mgf3cKd9jsr2wLT/m3yGlw+J3RyK5WJ486d0yEXEq3ARDFK3GFwR8Luf/1jEEtZr2Yo
 4zBg==
X-Gm-Message-State: AFq9FYKzmX0WpVyA1EiQhrlmvVp3stIgnu0rkOMrBDqnChuzNfzAV82d
 rIGSeUQOFlUjYQHI7UqHZYgsB///UgWpOcALArdCozLd+5/s6W4/Eyf0vJCeOA==
X-Gm-Gg: AYBFou1eTHtlka03r2zU2gRtmK0Y/bchrGzIvzYZslQ1XmUc/njFtrSvRbrhCIREdj3
 gcM2rTQ1oByljhd7JogLnVqWI9J8lTCjQPkouVLBNM7qb0z3V6fPmbQXqRgqy23eyemOqJSb/F8
 NkjGwbCiZGlOFwoM4LA7PwhMBhjsHatMCfzY5hyaXBhmB2rbePNcQHV+o/7uo3oquTcFJe59Ynr
 FiwgqBQckOJHNszFMuRAp/a1qTVjl3knlyn4ao3lqwuDzdaeRiJ+/z4Q8QcQ7lAkM3fHK7+LjsN
 7nhjAIg6U936ondg8I7S2m2OqoiKWCIzyfwW/HY2ba23V9aAiaCRBxsP0AxVjTCKKqZgVfRR16X
 6netrfSVCPZxWdNpkw1pDycQ2ywH95aUH0U+t6SqbIPO264QF7tmga/xyhCw6OXulrN2IfOxP2x
 cftcNeDzFzGrgqHxb9vooAVSon8KDEEn/2OynRbIuw7tWXiXd7SIAc9XtdN+jLlEljvMzGbD/P6
 gB8v0dk2Ln9357Z
X-Received: by 2002:a17:90b:514b:b0:3ab:22fe:b13e with SMTP id
 98e67ed59e1d1-3ab3ae6b03fmr12645196a91.53.1791949218331; 
 Tue, 13 Oct 2026 20:40:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/52] tests/qtest: Add qtest for Milk-V Duo board
Date: Wed, 14 Oct 2026 13:38:33 +1000
Message-ID: <20261014033907.3332383-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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
index 2e6a7721c5..b38e694b1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1883,6 +1883,7 @@ F: hw/riscv/cv1800b.c
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


