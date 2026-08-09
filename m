Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1719C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 11:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt1yZ-0002xB-IM; Sun, 09 Aug 2026 07:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuI-00082F-Fk
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuG-0005tb-B1
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso8674085ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786256471; x=1786861271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mPLt43svN/sH5zFPYA5PV2Pc+RgROQjcqhcSTzwdakc=;
 b=b8irZXqUxCLnsk/iNwijiRJZGd8ukNw7p4l7/0bibPmD8NMXiFsTPHjya5LFaayNnU
 LW+X7d/9ULfw1jAegxKho3Fl/VIhl3IBq9iQptPgh7pC2o2wiHYF6KGOG2e4bwyVtbNE
 cKNqosMphKEGWkj7eM6DSLf8OtjZUDjIhk8Awm18QWYZAj+iwNdycWYS0o79vrN90nvb
 CeqR3gSU49tpKtLISW7cNsheElsHWRFfY+80yVa+pAPd0wNd3A8CWpKfgnaxBc05BKlZ
 pivHftT/Dp9OXcqRW+SKaFsJqZLhnYcJXGsH4BkzQGr2wSn2XbrmdzbfcJXdY1vwK+PO
 JEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786256471; x=1786861271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mPLt43svN/sH5zFPYA5PV2Pc+RgROQjcqhcSTzwdakc=;
 b=UoU3yactABbzxUjejqYCTv4kJF9t/0mV8+ZBKgmWD1ovFRH228grU6Bk/mKHeV6Q1w
 3GrNBVFsy1Ss5oAGYPOQrV9Q1yq6aUjF+Ty0qHgP3TLVFBDXNOI5jgiRSEE9QOCVoETx
 339G1ZYIku7NrfcK1oaypBL6b4h19O5pKEYpbK8a2cBgeuhAt8/sY1vdcD+/PYJ3ulQj
 DvGPUNtX9Z+nHze4rKXPpsETDsBuH6OKr8b8Jy4AdLyb0T1hgF7iT+HiwbaqkKPS+rcI
 XVoSDeH8NboM23XpGk2xZfVc6ZMSCx6uW//uJxJtNeZLi5n+pE88d27aChyRbylECISb
 Y5CA==
X-Gm-Message-State: AOJu0Yz8QdPXtja39O4nJqFYRtBNZYF3UdSr/otvMIveLE8qMU2P8Ug4
 ddsuA0/zjmFo85iKxRpU/oc12Xt5JZZfLai3cL55a4qCxMlR2Ktm4jPqHF35Yo28Lqp4PA==
X-Gm-Gg: AR+sD12uLkzvljF3TZKv/PmXbSFdJUbMGcocHb4K76+j7/RybvGAFukP74KcuY9qCUn
 UJGR3Vkl1k40MOatCNiiqfsvvFnP01y807WKsmL4HKTImga3pEvWnjCLa5BIMpQB0qB2uQhezAp
 kXP+8saIOz4CpifVB4DVQKz8qU1g33x8L8vScQ6rTX3qtz01DkKynfcdy2MFr55/DaaHAOVI7tj
 JVVks9iyKOezQsr/23lsUDaq02fxhbagEHYsY58Prna7rO8sQCbuUR6XwqaSYRBEjO+292VU3W1
 tkzeOXYp+1kLMrOwixi1WiGgGpfy32H0cUX0YKfN2ODqLqdjfy7ess161fXLOgPAVpuNQCcdGUD
 yNt9sVLSIAK84NmWFY8DqyqyogvRih8ErE+rN/+AU1sG95RxZf6Z2fW/aTNhTHUHVg6gjFsdcwW
 gk8EBv1JMJIdoJchzmGmuRnepfcVvPrpHcGbTeA4p4aSc3tmILSEu0pem8b5cPDAeG8uKCAI/4/
 Aw3NUucyKJN4np5WOhwqg==
X-Received: by 2002:a17:902:e54f:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2d106e37776mr222815445ad.18.1786256470826; 
 Sat, 08 Aug 2026 23:21:10 -0700 (PDT)
Received: from localhost.localdomain ([159.75.12.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccac6d7sm21805265ad.6.2026.08.08.23.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 23:21:10 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 3/4] tests/qtest: add K230 CMU coverage
Date: Sun,  9 Aug 2026 14:20:43 +0800
Message-ID: <20260809-feat-k230-cmu-v1-3-8792982c446c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
References: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 07:45:49 -0400
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

Signed-off-by: Simon Law <0860734llx@gmail.com>
---
 tests/qtest/k230-cmu-test.c | 310 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 2 files changed, 312 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/k230-cmu-test.c b/tests/qtest/k230-cmu-test.c
new file mode 100644
index 0000000000..2be6400cd8
--- /dev/null
+++ b/tests/qtest/k230-cmu-test.c
@@ -0,0 +1,310 @@
+/*
+ * QTest testcase for Kendryte K230 Clock Management Unit
+ *
+ * Copyright (c) 2026 Simon Law <0860734llx@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18), CMU chapter.
+ *
+ * The reset and mask oracle in this file is intentionally independent from
+ * hw/misc/k230_cmu.c, so a descriptor-table error cannot mask itself.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+
+#define K230_PLL_BASE       0x91102000
+#define K230_SYSCLK_BASE    0x91100000
+#define K230_PLL_COUNT      4
+#define K230_PLL_STRIDE     0x10
+
+#define PLL_CFG0            0x0
+#define PLL_CFG1            0x4
+#define PLL_CTL             0x8
+#define PLL_STAT            0xc
+
+#define PLL_CFG0_RW_MASK    0x0f3f1fff
+#define PLL_CFG1_RW_MASK    0x000f0fff
+#define PLL_CTL_RW_MASK     0x00000ff4
+
+typedef struct K230SysclkOracle {
+    uint32_t offset;
+    uint32_t reset;
+    uint32_t rw_mask;
+    uint32_t w1t_mask;
+} K230SysclkOracle;
+
+static const uint32_t pll_reset[K230_PLL_COUNT][4] = {
+    { 0x0102018f, 0x000200c7, 0x00000034, 0x00000021 },
+    { 0x00000062, 0x00020031, 0x00000034, 0x00000021 },
+    { 0x00070378, 0x000201bb, 0x00000034, 0x00000021 },
+    { 0x0102018f, 0x000200c7, 0x00000074, 0x00000021 },
+};
+
+static const K230SysclkOracle sysclk_oracle[] = {
+    { 0x000, 0x0000e65f, 0x0003ffdf, BIT(31) },
+    { 0x004, 0x0009900d, 0x000f803f, BIT(31) },
+    { 0x008, 0x0000043d, 0x0000043d, BIT(31) },
+    { 0x00c, 0x00000c7f, 0x00007fff, BIT(31) },
+    { 0x010, 0x00000001, 0x00000001, 0 },
+    { 0x018, 0x7f7fffff, 0x7fffffff, 0 },
+    { 0x01c, 0x000b9248, 0x000fffff, BIT(31) },
+    { 0x020, 0x00039048, 0x0007fff8, BIT(31) },
+    { 0x024, 0xffffffff, 0xffffffff, 0 },
+    { 0x028, 0x000000ff, 0x000000ff, 0 },
+    { 0x02c, 0x1b6d9249, 0x3fffffff, BIT(31) },
+    { 0x030, 0x01dda0c3, 0x7fffffff, BIT(31) },
+    { 0x034, 0x01b9f424, 0x7fffffff, BIT(31) },
+    { 0x038, 0x006e7d09, 0x07ffffff, BIT(31) },
+    { 0x03c, 0x006e7d09, 0x07ffffff, BIT(31) },
+    { 0x040, 0x0000f424, 0x0001ffff, 0 },
+    { 0x044, 0x000001b9, 0x0000ffff, BIT(31) },
+    { 0x050, 0x003ffffe, 0x003ffffe, 0 },
+    { 0x054, 0x0003ffff, 0x0003ffff, BIT(31) },
+    { 0x058, 0x1efabef9, 0x7ffffff8, BIT(31) },
+    { 0x05c, 0x000c7ffd, 0x001c7ffd, BIT(31) },
+    { 0x060, 0x000043fd, 0x0003ffff, BIT(31) },
+    { 0x064, 0x000fffff, 0x000fffff, 0 },
+    { 0x068, 0x00820835, 0x3fffffff, BIT(31) },
+    { 0x06c, 0x003a74ef, 0x00ffffff, BIT(31) },
+    { 0x070, 0x000001ff, 0x000003ff, BIT(31) },
+    { 0x074, 0x00001fff, 0x00001fff, 0 },
+    { 0x078, 0x0000a83b, 0x00ffffff, BIT(31) },
+    { 0x080, 0x000002f3, 0x00003fff, BIT(31) },
+    { 0x100, 0x00000039, 0x0000007f, BIT(31) },
+    { 0x104, 0x00000009, 0x0000001f, BIT(31) },
+    /* TRM summary stops at 0x104; SDK/Linux ABI requires SPI2AXI at 0x108. */
+    { 0x108, 0x00000007, 0x0000000f, BIT(31) },
+};
+
+static QTestState *k230_cmu_start(void)
+{
+    return qtest_init("-machine k230");
+}
+
+static uint32_t pll_addr(unsigned index, uint32_t offset)
+{
+    g_assert_cmpuint(index, <, K230_PLL_COUNT);
+    return K230_PLL_BASE + index * K230_PLL_STRIDE + offset;
+}
+
+static uint32_t merge_rw(uint32_t old_value, uint32_t value, uint32_t mask)
+{
+    return (old_value & ~mask) | (value & mask);
+}
+
+static void assert_pll_reset(QTestState *qts)
+{
+    static const uint32_t offsets[] = { PLL_CFG0, PLL_CFG1, PLL_CTL, PLL_STAT };
+
+    for (unsigned pll = 0; pll < K230_PLL_COUNT; pll++) {
+        for (unsigned reg = 0; reg < G_N_ELEMENTS(offsets); reg++) {
+            g_assert_cmphex(qtest_readl(qts, pll_addr(pll, offsets[reg])), ==,
+                            pll_reset[pll][reg]);
+        }
+    }
+}
+
+static void assert_sysclk_reset(QTestState *qts)
+{
+    for (unsigned i = 0; i < G_N_ELEMENTS(sysclk_oracle); i++) {
+        const K230SysclkOracle *reg = &sysclk_oracle[i];
+
+        g_assert_cmphex(qtest_readl(qts, K230_SYSCLK_BASE + reg->offset), ==,
+                        reg->reset);
+    }
+}
+
+static void test_reset_pll(void)
+{
+    QTestState *qts = k230_cmu_start();
+
+    assert_pll_reset(qts);
+    qtest_quit(qts);
+}
+
+static void test_reset_sysclk(void)
+{
+    QTestState *qts = k230_cmu_start();
+
+    assert_sysclk_reset(qts);
+    qtest_quit(qts);
+}
+
+static void test_pll_cfg_masks(void)
+{
+    static const uint32_t offsets[] = { PLL_CFG0, PLL_CFG1 };
+    static const uint32_t masks[] = { PLL_CFG0_RW_MASK, PLL_CFG1_RW_MASK };
+    QTestState *qts = k230_cmu_start();
+
+    for (unsigned pll = 0; pll < K230_PLL_COUNT; pll++) {
+        for (unsigned reg = 0; reg < G_N_ELEMENTS(offsets); reg++) {
+            uint32_t addr = pll_addr(pll, offsets[reg]);
+            uint32_t reset = pll_reset[pll][reg];
+
+            qtest_writel(qts, addr, 0);
+            g_assert_cmphex(qtest_readl(qts, addr), ==,
+                            merge_rw(reset, 0, masks[reg]));
+            qtest_writel(qts, addr, UINT32_MAX);
+            g_assert_cmphex(qtest_readl(qts, addr), ==,
+                            merge_rw(merge_rw(reset, 0, masks[reg]),
+                                     UINT32_MAX, masks[reg]));
+
+            qtest_system_reset(qts);
+            qtest_writel(qts, addr, BIT(ctz32(masks[reg])));
+            g_assert_cmphex(qtest_readl(qts, addr), ==,
+                            merge_rw(reset, BIT(ctz32(masks[reg])),
+                                     masks[reg]));
+
+            qtest_system_reset(qts);
+            qtest_writel(qts, addr, reset | BIT(ctz32(~masks[reg])));
+            g_assert_cmphex(qtest_readl(qts, addr), ==, reset);
+        }
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_pll_ctl_write_enable(void)
+{
+    QTestState *qts = k230_cmu_start();
+    uint32_t addr = pll_addr(0, PLL_CTL);
+
+    qtest_writel(qts, addr, 0);
+    g_assert_cmphex(qtest_readl(qts, addr), ==, pll_reset[0][2]);
+
+    qtest_writel(qts, addr, BIT(16 + 2));
+    g_assert_cmphex(qtest_readl(qts, addr), ==,
+                    pll_reset[0][2] & ~BIT(2));
+
+    qtest_writel(qts, addr, BIT(2) | BIT(16 + 2) | BIT(16 + 4));
+    g_assert_cmphex(qtest_readl(qts, addr), ==,
+                    merge_rw(pll_reset[0][2] & ~BIT(2),
+                             BIT(2), BIT(2) | BIT(4)));
+
+    qtest_writel(qts, addr, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, addr), ==, PLL_CTL_RW_MASK);
+    qtest_quit(qts);
+}
+
+static void test_pll_status(void)
+{
+    QTestState *qts = k230_cmu_start();
+    uint32_t ctl = pll_addr(0, PLL_CTL);
+    uint32_t stat = pll_addr(0, PLL_STAT);
+
+    qtest_writel(qts, stat, 0);
+    g_assert_cmphex(qtest_readl(qts, stat), ==, 0x00000021);
+
+    qtest_writel(qts, ctl, BIT(0) | BIT(16));
+    g_assert_cmphex(qtest_readl(qts, stat), ==, 0);
+
+    qtest_writel(qts, ctl, BIT(1) | BIT(17));
+    g_assert_cmphex(qtest_readl(qts, stat), ==, 0x00000021);
+
+    qtest_writel(qts, ctl, BIT(0) | BIT(1) | BIT(16) | BIT(17));
+    g_assert_cmphex(qtest_readl(qts, stat), ==, 0x00000021);
+    qtest_quit(qts);
+}
+
+static void test_sysclk_masks(void)
+{
+    QTestState *qts = k230_cmu_start();
+
+    for (unsigned i = 0; i < G_N_ELEMENTS(sysclk_oracle); i++) {
+        const K230SysclkOracle *reg = &sysclk_oracle[i];
+        uint32_t addr = K230_SYSCLK_BASE + reg->offset;
+        uint32_t after_zero = merge_rw(reg->reset, 0, reg->rw_mask);
+
+        qtest_writel(qts, addr, 0);
+        g_assert_cmphex(qtest_readl(qts, addr), ==, after_zero);
+        qtest_writel(qts, addr, UINT32_MAX);
+        g_assert_cmphex(qtest_readl(qts, addr), ==,
+                        merge_rw(after_zero, UINT32_MAX, reg->rw_mask));
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_sysclk_update(void)
+{
+    QTestState *qts = k230_cmu_start();
+
+    for (unsigned i = 0; i < G_N_ELEMENTS(sysclk_oracle); i++) {
+        const K230SysclkOracle *reg = &sysclk_oracle[i];
+        uint32_t addr;
+
+        if (!reg->w1t_mask) {
+            continue;
+        }
+
+        addr = K230_SYSCLK_BASE + reg->offset;
+        qtest_writel(qts, addr, reg->reset | reg->w1t_mask);
+        g_assert_cmphex(qtest_readl(qts, addr), ==, reg->reset);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_spi2axi(void)
+{
+    QTestState *qts = k230_cmu_start();
+    uint32_t addr = K230_SYSCLK_BASE + 0x108;
+
+    g_assert_cmphex(qtest_readl(qts, addr), ==, 0x00000007);
+    qtest_writel(qts, addr, 0x00000001);
+    g_assert_cmphex(qtest_readl(qts, addr), ==, 0x00000001);
+    qtest_writel(qts, addr, 0x8000000f);
+    g_assert_cmphex(qtest_readl(qts, addr), ==, 0x0000000f);
+    qtest_quit(qts);
+}
+
+static void test_unknown_offsets(void)
+{
+    QTestState *qts = k230_cmu_start();
+    /* The 0x40 PLL window has no undefined aligned 32-bit word. */
+    uint32_t addr = K230_SYSCLK_BASE + 0x014;
+
+    g_assert_cmphex(qtest_readl(qts, addr), ==, 0);
+    qtest_writel(qts, addr, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, addr), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_system_reset(void)
+{
+    QTestState *qts = k230_cmu_start();
+
+    qtest_writel(qts, pll_addr(0, PLL_CFG0), 0);
+    qtest_writel(qts, pll_addr(1, PLL_CFG1), 0);
+    qtest_writel(qts, pll_addr(2, PLL_CTL), BIT(16 + 2));
+    qtest_writel(qts, pll_addr(3, PLL_CTL), BIT(0) | BIT(16));
+    qtest_writel(qts, K230_SYSCLK_BASE + 0x000, 0);
+    qtest_writel(qts, K230_SYSCLK_BASE + 0x050, 0);
+    qtest_writel(qts, K230_SYSCLK_BASE + 0x108, 0);
+
+    qtest_system_reset(qts);
+    assert_pll_reset(qts);
+    assert_sysclk_reset(qts);
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-cmu/reset/pll", test_reset_pll);
+    qtest_add_func("/k230-cmu/reset/sysclk", test_reset_sysclk);
+    qtest_add_func("/k230-cmu/pll/cfg-masks", test_pll_cfg_masks);
+    qtest_add_func("/k230-cmu/pll/ctl-write-enable", test_pll_ctl_write_enable);
+    qtest_add_func("/k230-cmu/pll/status", test_pll_status);
+    qtest_add_func("/k230-cmu/sysclk/masks", test_sysclk_masks);
+    qtest_add_func("/k230-cmu/sysclk/update", test_sysclk_update);
+    qtest_add_func("/k230-cmu/sysclk/spi2axi", test_spi2axi);
+    qtest_add_func("/k230-cmu/unknown-offsets", test_unknown_offsets);
+    qtest_add_func("/k230-cmu/system-reset", test_system_reset);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..9f5c46e0bf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-cmu-test', 'k230-wdt-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 

-- 
2.43.0

