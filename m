Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDDC5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwti3-0006sZ-K8; Wed, 19 Aug 2026 23:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwti2-0006sO-JC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:44:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwti0-0003bz-H4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:44:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1231755a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197490; x=1787802290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YLZW+WC6XzwXmMPSObI4jtS6Mg2Ad7TYWfRIDenp+Hw=;
 b=K274oJ2nS9wqC8IPZFeCvSuXEMzxv5j0JeGyRGeflMvQBKDo5fT71foCxcf3AkRKE6
 aht+IYp8QEkhi8GxvirMdY0GvKf4UOqoBe6l+AfYgh8NKPQ5Q5W9gWjWqn4hCevWp+cG
 FVnC1Am1/X6iSO2RT1qZVUnJmHua56UJACKYlULLOVBOu6GgleEhegNh0isZzIdQE0jw
 lgBuLDe4B/iJ3kWWisN0nY6alqAkTJyt8inSvpZrLDnKrg7Fx03pttFHiXTKdQN8F+Sg
 mejG0iBT28JcF49oySWcoBTHvsGzo8gT1OCtW2WN3CFWJuG+DZ2Ocnw2IjZ/0Gz4qvw9
 PyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197490; x=1787802290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YLZW+WC6XzwXmMPSObI4jtS6Mg2Ad7TYWfRIDenp+Hw=;
 b=hTP/Ub2IwB0gyrGl66eklHSvlWxFc25oKUz8P66X7sOT3uPCfxacCiEJ2SKp1CcmVN
 w1SYcKAbjZPHMpetPCwZl9q1Dr1O4JziRnaXtOE3EH1JaI4IF9lthn01XzhLzEGF4X2B
 eJkAjTKclml/VnFbHTEf+USC2DR8iWynVmyLeD7BqKGFfKAegyzt9RxmKylEYiaVNyhr
 vnYldoz0gsKiTUksxl/A2zC34sXrGKbN3gUl8M3S5cwXRQpX1A0yvjRycnWyZuwoWqGF
 hrDrKc18GI98kC7edjHWLrQglhTjEyokWbX2Ez5itqCX0zth2YcHIWM6Dj54g6PSGzwM
 XKTw==
X-Gm-Message-State: AFuF++mVIBOv/BWDtF+EYd6/ukZqvwBswR3iSrruv+SGi107lMgRGSB7
 +GNZmDFN6Ty/YBCd4EoADZophBpBnZ1lfpgrJHQcAbEnEE3nZOhujXZdtVLdOA==
X-Gm-Gg: AR+sD11Q3AF9Xk3cHRtJ2qu5qIdCWzaiXsaqan1HH9+AOGdC+v8LA5q6yPJXclmN0x9
 DV7jUDnMpC3wiEFNwOXcw/LhPTwsEybKZpsEXH2nXeNCwfIV2F9qQeowBcRLHPgiYjbdTKelk8+
 qPDlQ32wGX8D3S1kvjfUhNzWaRrG+vIA39FPpDzqVp9sBJf0XS20f5zr8wMOW0prX7vfuq3iEY4
 tocaCvum0B1rSwrxGVeSVp1COx4Fy5pi7DRxZLTD8vr+mOTWVYxCaL8as/K+hbJIz1ck0LrIRqR
 1nYHUGCvN9+UZ/7bfEzFz1AWSDPnFB+rL90WSQlTT2MOwLmerRGV3WL0oKoGCjcNTfeibWU9Nyv
 mtQiom9s67MAe7LhPxcyif+gA2CVUXOtUC1tZbv7EMKgzOnCWes7fmA+dLBofraLNRbZ6QhiWJt
 BixPcI9rpeVNXT+lQ3maHGe5X4rX6D5aAt2fg3YzLx0tNIqjiUuSzpBNknSeV4QEvMO+lA2onxu
 YQetg==
X-Received: by 2002:a17:90b:4d81:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39580a7c832mr17918754a91.7.1787197490223; 
 Wed, 19 Aug 2026 20:44:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:44:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/93] tests/qtest: Add K230 DDR controller tests
Date: Thu, 20 Aug 2026 13:43:00 +1000
Message-ID: <20260820034430.1186695-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Junze Cao <caojunze424@gmail.com>

Add qtests for DDRC and PHY reset values, register access policy, the
software-update handshake, and PHY register ownership.

Exercise PHY training and mailbox acknowledgement through the DFI
initialization sequence. Include negative coverage to ensure DFI cannot
complete before PHY training or enter Normal mode before completion is
enabled.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Junze Cao <caojunze424@gmail.com>
Message-ID: <20260807-k230-ddr-v2-v2-3-c531308ae819@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-ddr-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b957fa74d9..b6fb59fdf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,6 +1850,7 @@ F: include/hw/misc/k230_ddr.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
+F: tests/qtest/k230-ddr-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/qtest/k230-ddr-test.c b/tests/qtest/k230-ddr-test.c
new file mode 100644
index 0000000000..72362929bc
--- /dev/null
+++ b/tests/qtest/k230-ddr-test.c
@@ -0,0 +1,226 @@
+/*
+ * QTest testcase for the K230 DDR controller and PHY
+ *
+ * Exercises register access, reset, PHY ownership, training mailbox, and DFI
+ * initialization.
+ *
+ * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define K230_DDRC_BASE    UINT64_C(0x98000000)
+#define K230_DDR_PHY_BASE UINT64_C(0x9a000000)
+
+#define K230_DDRC_MSTR    0x000
+#define K230_DDRC_STAT    0x004
+#define K230_DDRC_DRAMTMG4 0x110
+#define K230_DDRC_DFIMISC 0x1b0
+#define K230_DDRC_DFISTAT 0x1bc
+#define K230_DDRC_SWCTL   0x320
+#define K230_DDRC_SWSTAT  0x324
+
+#define K230_DDRC_STAT_OPERATING_MODE_MASK          0x7
+#define K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK    0x1
+
+#define K230_DDR_PHY_CSR(index) \
+    (K230_DDR_PHY_BASE + (uint64_t)(index) * sizeof(uint32_t))
+
+#define K230_DDR_PHY_ATX_IMPEDANCE      0x00043
+#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1 0x10049
+#define K230_DDR_PHY_VREF_IN_GLOBAL     0x200b2
+#define K230_DDR_PHY_MICRO_CONT_MUX_SEL 0xd0000
+#define K230_DDR_PHY_TRAINING_STATUS    0xd0004
+#define K230_DDR_PHY_TRAINING_ACK       0xd0031
+#define K230_DDR_PHY_TRAINING_MESSAGE   0xd0032
+#define K230_DDR_PHY_TRAINING_TRIGGER   0xd0099
+
+static void complete_phy_training(QTestState *qts)
+{
+    qtest_writel(qts,
+                 K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL), 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 9);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 0);
+}
+
+static void test_reset_and_register_access(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
+                    ==, 0x00000000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
+                    ==, 0x05040405);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC),
+                    ==, 0x00000001);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWCTL),
+                    ==, 0x00000001);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 0x00000001);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE)),
+                    ==, 0x03ff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TX_IMPEDANCE_CTRL1)),
+                    ==, 0x0fff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x0200);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_MSTR, 0x01040008);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040008);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_STAT, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
+                    ==, 0x00000000);
+
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL),
+                 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x7fff);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4, 0);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
+                    ==, 0x05040405);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x0200);
+
+    qtest_quit(qts);
+}
+
+static void test_software_update_handshake(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 0);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_phy_ownership(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint64_t atx = K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE);
+    uint64_t mux = K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL);
+
+    qtest_writel(qts, atx, 0x155);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
+
+    qtest_writel(qts, mux, 1);
+    qtest_writel(qts, atx, 0x2aa);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
+
+    qtest_writel(qts, mux, 0);
+    qtest_writel(qts, atx, 0x2aa);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x2aa);
+
+    qtest_quit(qts);
+}
+
+static void test_dfi_prerequisites(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
+                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
+                    K230_DDRC_STAT_OPERATING_MODE_MASK,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_dfi_complete_enable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    complete_phy_training(qts);
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
+                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
+                    K230_DDRC_STAT_OPERATING_MODE_MASK,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_training_and_dfi_handshake(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    complete_phy_training(qts);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_MESSAGE)),
+                    ==, 0x07);
+
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 0);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
+                    ==, 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFISTAT),
+                    ==, 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0);
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) & 0x7,
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-ddr/reset-and-register-access",
+                   test_reset_and_register_access);
+    qtest_add_func("/k230-ddr/software-update-handshake",
+                   test_software_update_handshake);
+    qtest_add_func("/k230-ddr/phy-ownership", test_phy_ownership);
+    qtest_add_func("/k230-ddr/dfi-prerequisites", test_dfi_prerequisites);
+    qtest_add_func("/k230-ddr/dfi-complete-enable",
+                   test_dfi_complete_enable);
+    qtest_add_func("/k230-ddr/training-and-dfi-handshake",
+                   test_training_and_dfi_handshake);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..49b654036a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-ddr-test', 'k230-wdt-test'] : [])
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
-- 
2.54.0


