Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5381C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHiw-0002el-ID; Fri, 07 Aug 2026 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wsHiu-0002dt-L0
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:22:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wsHis-0006hy-JB
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:22:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cad68425a7so3756255ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786098161; x=1786702961; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TwplKdyrp1SNw2uTkoOz6zBC6XTehcOPz4L69a33/PY=;
 b=SzJcM3OaQu5KcybLrYOJ6WZlQ4gjneoXqXbTJCaVFEuEuPoXQ64vaDGJiVZeeBVILi
 knDf40Gh8OqZk9FruKfoQJpiBILiuZjrvyvEgs3dO73f1qxVHeRMnmUJeT3ok+YuE8zW
 vJn2nYjij9Krij/b4j6P3vxQFIP8qj3uIzIPts/IcOhc+k8UcXuAtwQ5mOZzhsk+Qzlf
 8OhEL50BvGkaR4A5T81iLB6CCGtQgUWrQYph2Ps6kFur6c1YG84zHMBEujgHGhXb67Hu
 2aBTXEJC/JbaQD7qUxzKi//VcI5L/Hb6+MkUk7IpLQk573tQnx0CRmSzE6dierk9Rpo5
 1WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786098161; x=1786702961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TwplKdyrp1SNw2uTkoOz6zBC6XTehcOPz4L69a33/PY=;
 b=hGmelcZT8e69VKUZkBtSqrRXT8/a251h+tZXVSaxlQLga6WZogKTPF6c06m28CE7Ko
 gcmG15dEhqVmDvloCFuOedX5IVvH3hSm4x+Fe1mgv4xjDmJ3bqnpawbm629LZkU9bEh9
 Pk+Z1uFlip2pEumcHZ+gQ0ZXcG21plxtlI1rbmknBUw16h6Q3C2PJLT5HxotxrxgpqyD
 h+rLyT4WEAjaTa4Fot3rC1gFkrrByYB1ZabEgX8xj7dDHgQd7uBwjny1QMnmsbidh0mq
 +Qpvqvdeo7jsyqurJOutvUNAznkuL1OiFGR8m4y2f8QO/xkdgaDhgpQ/51IGCBm/dWLN
 zFCA==
X-Gm-Message-State: AOJu0Yxo/EwC2JqrnTjxiDEQ84GK7sfvJET3zKDVfg7NX8bC7rKMdNOS
 M6ehGuOJf30TEFrVGFZMdzEC+tmLrL2OAJT/IgRtkY5IfXMtedaaoOik
X-Gm-Gg: AR+sD13MPkoyw70ZUVDfpg4ZEaj6Q6poEgyqHkyY2wLVBcJyrNv3z3mFE0/2Cdxbu36
 bAtB7x+85zIzGhJflzTYqssfucknjeAPIwKcBsVMqtc5x0UBi/ZqflHt6W0LkTC5pZCWcwkMwTi
 w6zxQdFTLZ5ttgr7cqh5zgDTuE4lp2ms6BXXxlHHeMPWkEx2/IWwqptLFZHk9W3USEftY7PoZq6
 CQPEHx1UbnHpd4tNk1uZ3KKhMQAuyB/2u2DvyEAuUc1GPK7T0ffJKHTYR7zh4eHgRssxUPLDwJp
 aN1knddFuvW5Ngp0fKzeXMozPNMVZZG+XTHTukzQ/xufUG5IV/jbVEinDz0HgNyeCpDOJWuuyAD
 jGpc0XRiLnNjTWu4ZN6O4mWy/MjeEkvrQGqnFaDwk9s3j3G3XDaAdt20bh/lGWZALZxHGDQSPHL
 faqSYn/l0TIrgTG7ml4VOqBduX6DaKV8YZY2huTJ2A7x7VNmelts061gd7LQRX+uLQAmqf
X-Received: by 2002:a17:903:32c9:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d0caa4978fmr155587445ad.4.1786098160989; 
 Fri, 07 Aug 2026 03:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86d3fcsm6158337eec.4.2026.08.07.03.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:22:40 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
Date: Fri, 07 Aug 2026 18:21:18 +0800
Subject: [PATCH v2 3/3] tests/qtest: Add K230 DDR controller tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-k230-ddr-v2-v2-3-c531308ae819@gmail.com>
References: <20260807-k230-ddr-v2-v2-0-c531308ae819@gmail.com>
In-Reply-To: <20260807-k230-ddr-v2-v2-0-c531308ae819@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Junze Cao <caojunze424@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x633.google.com
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

Add qtests for DDRC and PHY reset values, register access policy, the
software-update handshake, and PHY register ownership.

Exercise PHY training and mailbox acknowledgement through the DFI
initialization sequence. Include negative coverage to ensure DFI cannot
complete before PHY training or enter Normal mode before completion is
enabled.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Junze Cao <caojunze424@gmail.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f12728ff47..cf764b2efc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1834,6 +1834,7 @@ F: include/hw/misc/k230_ddr.h
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


