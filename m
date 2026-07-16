Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8774C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM76-0006ix-Lz; Thu, 16 Jul 2026 09:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM74-0006iI-Ld
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:26:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM72-0005Hi-Er
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:26:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cad85b7b5aso8962275ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208411; x=1784813211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvShPGpwKNFXEzFauLDR7uPosp0H+g1u6SP4L/tTglA=;
 b=fifAUhFruBZcCqNwHdrklBkoQpdtuNOMhXtMYQ/TdgSIepMVi4nW60bcf8xL9QTveT
 sYHdELcYWNBXm4XYmgNtcXOdiQY2VeYAYjrFR7Qx6SXNQu94eZ2uqUDEY2/Semp4fHHV
 VjXseOePUSBdhTETxdW0VpzuFFnrZIMAF1oNfWQvEsHPD3R9NaEMgCT3poVLRvBt6/bQ
 bw/hFycnMwDXQ0q40KaWfJGZB6+8KpiLjQJnEq340TNC47XWn1dHdJx8pvx+4HA3+jer
 T6dr4YV3XfaJOrH688lXpGeJ8qwcaf2rUfxd7qrEDqvCK447YC9Y1pb2RQWztVcVTgZU
 4nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208411; x=1784813211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvShPGpwKNFXEzFauLDR7uPosp0H+g1u6SP4L/tTglA=;
 b=Xl744nkGlQWlQu6ERFiiprwi+WSPLy+fG9GjNHHrCSN6p6HjEnU6US/O0OHPnXZiQF
 i2jD6lUQqFH7ny9Yc166awyHvtFv8blVma0zYxbDsLX3jajaFCk5kWQpr3w+QpdaHcFE
 BzwCsG4GWMXaBUpjzsvFWMr8fvbrriqcMkYRrAZvetsOn72wC1kSJyk3GbeS+HHGBLLV
 mRNOhmgY9nC4IFuNeQG90qqOF0UxBWIwPy873x6OVU55MZJbiK/JUUU5ybEictWdGLBC
 ESWiwI4gFUBUxDpz6/HBbLTCxDWEn9oYiEUUKTblUiKMMa53dCMgZ/rXFvFYOt1DZhJH
 OALw==
X-Gm-Message-State: AOJu0YyccpgJFCByavvaCZf3hoMJ/JR2+L1JIqLwrKE+EhHFRfIgkDHE
 EYJj8qJtHVzPc7ZjTDUFLAouxa4nBKMkKCCclxateF1724qCR1yuauGsjw7lT9rz7RF4UA==
X-Gm-Gg: AfdE7cnUjTK/TCRbcP9oiCcGw1vEWqh6d1PDyL+5cLCMD586GGofLK/NtMcXci0sIJu
 kCifGyX26BedSCjEMQte3AlKO9qUG+5tDJa1GFi3QBBggGCvY6EAqcNaILQoOg06I2FMYXeXBfS
 U8ckE43rI7yetlBgsD/HDnIxM7QnsOxluYSVSiAqqY+sn7WUuEAnNAsvqOoGUrvvnKrr4Tv7Zgp
 +snNILNKQGNJ8YVaWbx9uFXIRqXi9aXlWrs0/7Njfi+A36WVzhiEy4vwlCpsxfNGJtREQrTchTD
 nZ49uQCvnZKyOysZE5nlV1RyE3cBPmdZyZ5+jNjDJAqYvtxGMMXLm9YzSVLliWHBvXuDC8qrXDT
 n32kZoYM0Zo5Ivd2HBkJ9bgJkm4cRBrKMXJwKtovTSYBOhiyvC1ksewPMLxNwkTNQLxabHrLcb6
 hHidgFPOM3n+MSxTTv/eOgMzpnCA5/
X-Received: by 2002:a17:903:2b0e:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2ce9f038e25mr170767415ad.4.1784208410993; 
 Thu, 16 Jul 2026 06:26:50 -0700 (PDT)
Received: from DESKTOP-JUS09M1.tail12b54b.ts.net ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm11336706c88.13.2026.07.16.06.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:26:50 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Junze Cao <caojunze424@gmail.com>
Subject: [PATCH 3/3] tests/qtest: Add K230 DDR controller tests
Date: Thu, 16 Jul 2026 21:24:23 +0800
Message-ID: <20260716132423.931427-4-caojunze424@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716132423.931427-1-caojunze424@gmail.com>
References: <20260716132423.931427-1-caojunze424@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add qtests for DDRC and PHY reset values, register access policy, the
software-update handshake, and PHY register ownership.

Exercise PHY training and mailbox acknowledgement through the DFI
initialization sequence. Include negative coverage to ensure DFI cannot
complete before PHY training or enter Normal mode before completion is
enabled.

Signed-off-by: Junze Cao <caojunze424@gmail.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-ddr-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cb3ef6c02..ace7def55e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1833,6 +1833,7 @@ F: include/hw/misc/k230_ddr.h
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
index 56ff860e21..dc110f72c8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-ddr-test', 'k230-wdt-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


