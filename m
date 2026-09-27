Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00210CA5FA2
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvGK-0008Nb-HR; Sun, 27 Sep 2026 16:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGI-0008Mi-B4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:14 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGG-0003ZV-Dj
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:13 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so1054363a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540051; x=1791144851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hi9URHHfgyd+sJWR4czUDLlcUHgZe4owe8AVysAk9CA=;
 b=GSlBdGfpB68JPFLdPNPsP/RfvzHCcFd17IvCi9i9N7RJFmLDE2Er1XW78e2A5GveyO
 skju3fxuZOR/pNWgxi/EFFq7zHbL6r8OM9F8Ypu4Ml2hQVqj7KLQzWMQE/HdZgE1fZFp
 UX4qA6lPdj9//A7C+eHv3NUI/kqPVDvE+CPHe+UOkXHquVy8yR5R8pkH7bCd5yPvcfKa
 OhODhg/V2akna9RbcsNegp0fJp8zmYntO9IPAKOXfuF/BEGuRbzlFjKZjNY18JlJciUW
 mbUCmRTo1ki7WIHpyxg8D6sg2RXiBQV68F52U8ona/3UQpbj6A3T3QQW9COzJkzmalpe
 ipBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540051; x=1791144851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hi9URHHfgyd+sJWR4czUDLlcUHgZe4owe8AVysAk9CA=;
 b=antq1iophrV+mzXD5DvzWzbwXK2wZ8KUFfJe3AAtUu29Z8LffOlSKN00En2ik+xgbV
 IWK4oZMtM386r5i1dJfc/+RYUB7fzzIUsnpQKizx0BHMm/UA8DRpq5GYz/vmvYNmTSUX
 vK9ZUGLdpQXHQh7LEnt8y/i/rGcrx/RWge5m82iXCgSHbc+nIUStjNKNSjcW8thgMlIh
 JKSL+c2pt4j1o6DnSZcwJ8WbJIu51jRRMof1quzT9cYi034qLV/ThWhStpiG7HrKLsV3
 Z3lhK4UZGfvH/ccoNNXJG5PVNOKlbI0wuHFf72ZDBIszcnm81En53DyrHLv1e/A9gLM/
 /k/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg+KXM24sX+Ccd4+rPsgl9gd2fMgpo4ybQFvRq+YzvGWICk9Gk1bHy9i/hD8jn6RvMqhpZXtFgKkjT@nongnu.org
X-Gm-Message-State: AFq9FYLiUf/kjgkJxPPFalQXrr95r9S+DtlXqEXKD7Usr2i80h1DtGh/
 RRfgbWaA5g7VwyTePWuTUzSnXOiMavOSYYKbnDQ/J3XMSMGhbfGal8JQ
X-Gm-Gg: AYBFou1w/0FRnXPK+3ugUgfIiH4JUIl9dQSEIiN6LNB9jXgJnHnKRv8p5lLYYxNE+0I
 RZ8nQP5Lfz/cc0xOgGPyePteOZa/dACujfpR5RCAUhwaZvZ0/rex3e04WjnkjEsB9c47HyEBgJM
 Jup+L8fsgQR7+Cu5QHi7JOxkzzpoActfPDPj/3J5AHRmAnYDE8NJAkxwKf3wapgDf/PZis5o2N8
 noVCvHc2YAPWXzfh9AbvM+ynfrks4AxqPUhxsRNaH2aKF7B+oTBjxx6rWVKKGjxn3vvvyK5v7aA
 H35zIVRrKUDG3OOzXHwFpFSE7wi83yRaVGr87SP81dmer/BV332r265jlVnJOl97lsqaJb+STJB
 i9JQ7nqGvUGi5F1rSozJREP3dzARzNOtuzfu0za9kY3rmFRtDiXYF90FqAOqbO+gqBKoQkoJo3P
 VIaXLTymT1QywY0IH/WnyaBHxkAjrPLmkuFDAUncp3/rhm/yYzWNw59uMlSbsIAsbFS+7IwY1RC
 cp8mBlnLnKW+1KlSRlsULQzzZBTpHyaOliUEEGj1y/QtOmbEOoojXOPypa0z9rdTyQvhr72qw==
X-Received: by 2002:a17:90b:2d8a:b0:3a0:b959:4472 with SMTP id
 98e67ed59e1d1-3a0b95947cdmr6881537a91.41.1790540051145; 
 Sun, 27 Sep 2026 13:14:11 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:14:10 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 5/7] tests/qtest: Add qtest for Milk-V Duo board
Date: Sun, 27 Sep 2026 20:13:24 +0000
Message-ID: <20260927201326.650943-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260927201326.650943-1-visitorckw@gmail.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=visitorckw@gmail.com; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS                  |  1 +
 tests/qtest/meson.build      |  3 +-
 tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/milkv-duo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bef8c2f3b0..f7e4159679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1880,6 +1880,7 @@ F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/qtest/milkv-duo-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 33f58b0e95..dc76093e24 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -309,7 +309,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
   (config_all_devices.has_key('CONFIG_K230') ?
-   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : [])
+   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : []) + \
+   ['milkv-duo-test']
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
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
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


