Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFACD4F21
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 01:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNKgY-0006x8-Ry; Wed, 13 May 2026 21:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKgX-0006wM-8t
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:16:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKgV-000113-OD
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:16:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bd2051167eso11215985ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778721378; x=1779326178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48f8zhjwiic2pmGqpnVLoLU8gNIYYQJefLG12/r1uMo=;
 b=PsDlqjPAkmuuH7oC6MgzINIdbyBohzVUOyMdf0AR4mSqX6IJfiXIFOZCA1zTpnomg5
 r0xz59d7vXzNG+J9y73Kl7Mz8Ib1IJJFA6uObSqM05509NcPXx8S0JbygoCKF6EOuLQm
 VF2x3YNLiHefouJBF469pJnW4W51ajwv0Wz3HzfXZvR3051rnoK3IgjkPk8bbOi6neTM
 9pGF8ZCoCaFr1bD5aDUEVQ11nYqMJ6Bh6Ci5b7KXiBJPmw8+pFVfFRoWRhcGcZXxF1+6
 dOK4mvqsKUQj577ia74nzEZBj/xPteh1rev9H4Lfd1tZCSIs1AoymTXP0AXJKZWiwrqc
 8Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778721378; x=1779326178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=48f8zhjwiic2pmGqpnVLoLU8gNIYYQJefLG12/r1uMo=;
 b=IT/p3S3akeW+ss/ewvyKrQH6XLfcMyp8VWZ+bJwPd8ZdcXigiZrBrGwtFURCBGWEYo
 1LafqtWQDGFuzqFqzi3YykUvAYz4eFLydmzmrij4+LlTKZdlFBiaT4uaUFbD+kiqHgmv
 to3j4Kl4r+R2YPneerN6/QcpLcqueqoMAkjIymZ1oyreBBCtUNQVWx6N5XUOWscURvFt
 dirThi/Oyn98LIyb23BOn0gSgTrO+ssZ918fCp+1cxSe1Qxcl7piqOQi9JhmSmJgQ0ap
 DWRzyi9S28/+LGC+POh63wlY6BtWM2kK9jMYP8vqtnLKM3/AOJVd6SbjnXzLPS1G9zVl
 EQyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cu2II57J6bDyR0V+hiY9zBQBFnp/hBMzFA7bMKXChYg97AyOOvvIHxGWc1nmi4xH9rBHj+8Vu+5Oo@nongnu.org
X-Gm-Message-State: AOJu0Yyt53wkBwAxOlLspwr+Z5xj6QNjbSKHZIT0QsRamYPeFmLg7JOR
 DwVzTJbrU2B4xwbpqJ7Xnv8eYjJnCfu0VRcoH65uDUrKY98WExBqcBKf
X-Gm-Gg: Acq92OEdlXjf2772UVRTeiCLLT9HzEmvWWn6Nqx4EmlVNE4g4IIZakUYC7wIVgvBWww
 BpwprM0Purvhlcg1ItJ5auKwdpryKvYJKhNvNhEqmv0+Oo3LKl37LzWAOpqDAafU+yBEo0XGE6z
 MTYaXPmxZR3FKzya+98yXvCbuUsmWLm6TGo4CaqBRiXGoV8o4Sta9grC4XbJFChSOt011jaSRof
 PQJ+diJPVbHpcFTRP5Vl/PVNh2eX8hnw9kkdHkJRVx0AN3OOrxiSwHs/Dr8VzhATvzmeia1XUk2
 54VpgiVDAUWUqfSSRg/gF7SSIku11pB0V8ic53MIYzcnAbJynuEJsJ7IJsgmmGo9Dn/AMY9ngwG
 BO9Ebaup9xXzbQ4uqEP2T3D9wuK8axoUdatx8AeVA8hL/f6/rW8XKydIZJSU2jo24s0NrToJA/z
 1v1idKYvRujZ3Td8soH0gX+t6YvCmf4zJmG1Nv/TTfvqQjJ/2PsRiWtr02wNIE+fsZ9HoXGa1o9
 Mh5aam8v5uHB85arvS7sLUOIygrevbpleYVK2F70DdU
X-Received: by 2002:a17:902:e752:b0:2b9:cd2d:6f11 with SMTP id
 d9443c01a7336-2bd2f704a2cmr56455425ad.18.1778721378014; 
 Wed, 13 May 2026 18:16:18 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600c3sm4982575ad.29.2026.05.13.18.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 18:16:17 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 6/6] tests/qtest: Add qtest for Milk-V Duo board
Date: Thu, 14 May 2026 01:15:28 +0000
Message-ID: <20260514011528.1263665-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260514011528.1263665-1-visitorckw@gmail.com>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 MAINTAINERS                  |  1 +
 tests/qtest/meson.build      |  3 +-
 tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/milkv-duo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5649fd31f..8e62809728 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,6 +1790,7 @@ F: hw/riscv/milkv_duo.c
 F: include/hw/char/dw8250.h
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/qtest/milkv-duo-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43f83ffd3a..524340276e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -290,7 +290,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+   ['milkv-duo-test']
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
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
2.54.0.563.g4f69b47b94-goog


