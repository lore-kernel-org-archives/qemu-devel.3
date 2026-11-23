Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F3606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvdfINAY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVRcQ-0003rS-JO; Mon, 23 Nov 2026 05:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRcI-0003qs-1k
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:47 -0500
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRcF-0005Fs-Rl
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:45 -0500
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2f0440f49f4so22941055ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 02:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795430982; x=1796035782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IoFqEPgIKYB5lr0sETJjiTYDJRQ/nP1YFtTSCWKsu+4=;
 b=PvdfINAYKgISYzEyCraPBgy40Ci82X7zBaya+a11AJS3rgY2UiFIe26NGxOVX3xjYu
 DsDQg48YTkLh77fjjr1rBTgaR+4mcjOmwwHk5l+AARlm74OpqsfwvCFMKhEFtDW3PRyS
 9r+FdlEHTj+xBJoom0D8RTiUKM/vg4+T0QLxe5DuXLc5Is4FzE2P6SPnVRNfa+xU6QSy
 qljeQVQoGtnuUnvhm3fc7IFjrNiXRMR/eMRw0VPjPJTkWPP6YFAEFWsor3P+OkKm2kwJ
 mN9WAwUVWUL9ixYPaiGKA74gtiNFzq/T2aYZNvq85U9MNEuenbi8v7CnrzyIfa1zaxdD
 Z9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795430982; x=1796035782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IoFqEPgIKYB5lr0sETJjiTYDJRQ/nP1YFtTSCWKsu+4=;
 b=Qh40v2cixUqrTeStF9bg0rurtkbCihY7U6Z9sAjTU6oCYwMtQtK0iVO7N3wp1Mha92
 l2Lxgf7HWQMcC2XRpfUJ7GYg9tqzHcWjmXtRQlacm8vejPZwhjJGgGiZighzfjz46bHz
 7l9c5aR9DWdmhP1U/IcygW5Xsae47hIhjvqC+CzCkpfvPx+TpSrGG6ihNzKva1YFL2hh
 /EdIvPts+9bOpcuCtXqnrITrzBGnv0/P8311lFS9vi2U/595kcQYyCxK9pgilmrganM/
 MRGIPcxDlKbwsjx2VDLhkcQr8ZXj9SwLb+1T4hU0bsvTpv+68qAXHesH8Ak/EbhKzMEd
 U4gA==
X-Gm-Message-State: APuU4Z/VlgCxdL/7/dAddLaB8Iv8mDfbQM5NdkS82N6xXpOGpO52Ftm3
 oqq02EjbgvWBaQV7vaRWPmd3HPpXSuOyYwY83gmMQQpWuY5FEAc/JrJAVvU/Qk1a4t3Yqw==
X-Gm-Gg: AZFdTZdmvGrICeTl3+Fqj0ppsSob8VeU4YBzWgRq7u9wyNeI/ekijW/L1ingUP0nmGk
 XpPNTkPfmD1FCe7Kyd/qfXtdF6MaKHR0wIk5FLPlgKeGfW9ylWuzZtA+8mOHS7/4ofPZVCyGK7l
 KsX8k8/fuTlB5a5xhZtfGVjKo7hkls8RuBCExAsZJ0MkIL/hhYJG05DegtXEEvEGU5q7AIxkLxQ
 oRoLhxPiMdzO2XQQ3p4c2qiv5z5a+MExOJmG5BPUjR4Yr8P1XJP7SSgSmKpaIKfQx8cuNgzIDly
 Oi1TvbPs6drgbZNYzOFs2aIHyWpPqXQhikL7+I201Z9rXABmH5BjPAmE87ZEXo8EUbmHD93iRvP
 OlXNmQAH+WH25K07Zuy0hQDOiHnH/LRzANHXZI9weFzRxMpTL+t8tbZDCZVYXHJu5oOSLk4ZHLa
 Tppe71+GG6MwFrovkAS4utq2t3B7ur6K1chY0O2h+V/yApU1Xh/lsOkchccRz/LRqRpsB+cjDZR
 RdncXJhTVVxtgLVeYtTAIZA4JApwLHa02QMCapHEErEQno6aOZrJG1qU1T7kiYeZe8tK//33gzG
 XUVbfD1YBKVjulFqRUuy6DQPqA1R2YvOG3C+E3nDcN8HZw==
X-Received: by 2002:a17:90b:180b:b0:3b0:b03b:699f with SMTP id
 98e67ed59e1d1-3b41c7c7a4cmr11246620a91.1.1795430981957; 
 Mon, 23 Nov 2026 02:49:41 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3a71:c3e:fd79:a32f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b409330ae8sm20343555a91.7.2026.11.23.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:49:41 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH 2/2] tests/qtest: add a RISC-V mip regression test
Date: Mon, 23 Nov 2026 10:49:09 +0000
Message-ID: <20261123104909.197758-3-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123104909.197758-1-w1355457260@gmail.com>
References: <20261123104909.197758-1-w1355457260@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=w1355457260@gmail.com; helo=mail-pj2-x0b.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drive the ACLINT MSIP and MTIMER inputs under the qtest accelerator and
check mip through the qtest "csr" command.  The test fails while the
architectural pending state is not updated and passes with the
corresponding fix.

The "csr" command is only registered in CONFIG_TCG builds, so register
this test only when TCG is enabled.

Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
 tests/qtest/meson.build      |  1 +
 tests/qtest/riscv-mip-test.c | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tests/qtest/riscv-mip-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6e2938d913..c5e2cd6bed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -320,6 +320,7 @@ qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
+  (config_all_accel.has_key('CONFIG_TCG') ? ['riscv-mip-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
diff --git a/tests/qtest/riscv-mip-test.c b/tests/qtest/riscv-mip-test.c
new file mode 100644
index 0000000000..0ecfaaedc9
--- /dev/null
+++ b/tests/qtest/riscv-mip-test.c
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for RISC-V interrupt-pending state under qtest
+ *
+ * Copyright (c) 2026 Zixin Wang <w1355457260@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define ACLINT_MSWI_BASE     0x2000000
+#define ACLINT_MTIMECMP_BASE 0x2004000
+#define CSR_MIP              0x344
+#define MIP_MSIP             (1ULL << 3)
+#define MIP_MTIP             (1ULL << 7)
+#define NS_PER_MS            1000000
+
+#define QEMU_ARGS "-M virt,aia=none,aclint=on -cpu rv64 -smp 1 -bios none"
+
+static uint64_t read_mip(QTestState *qts)
+{
+    uint64_t val = 0;
+
+    qtest_csr_call(qts, "get_csr", 0, CSR_MIP, &val);
+    return val;
+}
+
+static void test_msip(void)
+{
+    QTestState *qts = qtest_init(QEMU_ARGS);
+
+    /* Program a far-future MTIMECMP so MTIP stays clear. */
+    qtest_writeq(qts, ACLINT_MTIMECMP_BASE, UINT64_MAX);
+    g_assert_cmphex(read_mip(qts), ==, 0);
+
+    qtest_writel(qts, ACLINT_MSWI_BASE, 1);
+    g_assert_cmphex(read_mip(qts), ==, MIP_MSIP);
+
+    qtest_writel(qts, ACLINT_MSWI_BASE, 0);
+    g_assert_cmphex(read_mip(qts), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_mtip(void)
+{
+    QTestState *qts = qtest_init(QEMU_ARGS);
+
+    /*
+     * MTIMECMP=1 is in the future at reset (MTIME is 0), so MTIP is
+     * raised by the timer callback once the clock steps past it.
+     */
+    qtest_writeq(qts, ACLINT_MTIMECMP_BASE, 1);
+    qtest_clock_step(qts, NS_PER_MS);
+    g_assert_cmphex(read_mip(qts), ==, MIP_MTIP);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("virt")) {
+        qtest_add_func("/riscv/mip/msip", test_msip);
+        qtest_add_func("/riscv/mip/mtip", test_mtip);
+    }
+
+    return g_test_run();
+}
-- 
2.54.0


