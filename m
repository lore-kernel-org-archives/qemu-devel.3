Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FF4C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVwo-0002zc-MU; Thu, 13 Aug 2026 09:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwk-0002z5-Ky
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwi-00021X-NE
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:14 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2caf228a910so6365405ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629491; x=1787234291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3XsgUtsIrl2lrehlBIj4BnvIKNwiejGxZ2nf5LhF9fM=;
 b=YuGXzSuqK3J/oBtbVnNLb/loB+D1N/TW724XfKntVx/Ow70W+Ou/LK2RS0XOvmnbcf
 nQu3CC9rSXLOwV9LQ/gNOJ2HEmcQtvSsWqJLn6WpeLnEmEtK2GeM7gX4HZ+utf8KJVoI
 WrvZh5uyIj6Q5dOKK4ArKsnhbacsgnKVyA9HaAs1EQxTc8VurmY+6kRxuCXNl4cI+DRJ
 WoS0M/bK9mM0Uqv3LhcYaB5HOC6eGjVsmsCXHKMlDKUlQ/iTpA5kvH1DMZNshgL6dRGF
 ZYSyMh5KKnoPU24Uh27urzPm9syYRS1soUvQoElLHkvm4c3vJD9G2iTQdnMfh1FyN6bK
 NQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629491; x=1787234291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3XsgUtsIrl2lrehlBIj4BnvIKNwiejGxZ2nf5LhF9fM=;
 b=qtumPym+YqRAmNXa+KJiUdV6C9vKxse4E/yzPbp3CqXooy5Sfo3ETbnVUNvTEFbbm9
 Tn+wlj+BTQVYw3bKX+S0hB/IikTUknG2wKvkKcEHbEmcQqEjR8QCfYqktMqns9UcM3rc
 4yIfDwrkB5n+mS0AUqvPKSfU3G0dBNJ8fjq2IfBJhU2VBTj+XUwZEQHk+ue8z5UyxZTZ
 pWu4UP+BWdK7pcTbeSbsnRkmaXkD3pC3BxT+kYG/+IyvmOwLoKfXmQdT0QZLEk0asx3D
 y711EJm8SjWcQR1ubjOXyxMOOP36pE4Pq1JXdx8cGy2OgY9XPuoeDW9HNBehLBPDk4VU
 R7IQ==
X-Gm-Message-State: AOJu0YxnsRmUGo1H3SqphpJSx04hK6MY75hEubte1gzMbW2i7GALWvwH
 PNCSI2xHDCDLSrGx5UPkyAyvEDpFmyEKzDiAiyBHYj7LT8VS/eT0gscgrVjK9YcJ3Hw=
X-Gm-Gg: AR+sD13viqD6ytP5CUUXLKUoVWGsLzcI8F+YQShpgLQFiaplOIP8ctbgufVWUhA7tdM
 IEzzb0/tVYUg/M+7R0UMa+1NZCd7F/zKRZrDjtCwjiCq1X5WrAvqi/BfFGRNUwVWC7DWqKBJMTG
 UmFaovLuQ3ufzNpgCuk9jOzQ8Qri+uazfIYRq3ts72ysOYI/b89/OS75zdfl8xqk3LRlXY7/MMN
 9p99fZoFkWvi9GIB+GwYmebpZ1PaJgZvnSL15ijgnF2c1FFPd7DTUalP4TRQBSa5RbmIODOwLMp
 fft9bjr1sGuak6L8tfa/pgeQm9vK2uIXPqtfD/frxhXQEX+CIM7fO8nZEmULxVVruoCI0aV9dWv
 FxwqE2zRHf3MJp+KdQ4OUOuSpYDd3uymPADrax1jFFi6BNW+ARrZKBPbwUqJBlS2qNpuonVYwZH
 Yn3/ZLEsqp/9IEJ85y6mUr3ACx7OXH3LaNOOg2KD+SSg4JUS357rTo7+FW5/6S0t6a/cHjC0YRr
 K0QtWghI2V9cXTzkr2m
X-Received: by 2002:a17:903:4b30:b0:2c9:cb1b:64d6 with SMTP id
 d9443c01a7336-2d37ebc3947mr73344075ad.19.1786629491427; 
 Thu, 13 Aug 2026 06:58:11 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c486531sm10024395ad.57.2026.08.13.06.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:58:11 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 3/3] tests/qtest: add test for K230 IOMUX
Date: Thu, 13 Aug 2026 21:57:17 +0800
Message-ID: <20260813135717.2758-4-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x631.google.com
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

Cover the 64 documented reset values, writable field storage and
masking, read-modify-write accesses, the final IO63 register, reserved
offsets, and system reset.

Suggested-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/k230-iomux-test.c | 160 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   5 +-
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-iomux-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index adcff4bbdb..7fe147917c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1851,6 +1851,7 @@ F: include/hw/watchdog/k230_wdt.h
 F: include/hw/misc/k230_iomux.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-iomux-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-iomux-test.c b/tests/qtest/k230-iomux-test.c
new file mode 100644
index 0000000000..956656aa49
--- /dev/null
+++ b/tests/qtest/k230-iomux-test.c
@@ -0,0 +1,160 @@
+/*
+ * QTest testcase for Kendryte K230 IOMUX
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides test coverage for the Function IO configuration registers.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define K230_IOMUX_BASE 0x91105000
+#define K230_IOMUX_IO0  (K230_IOMUX_BASE + 0x00)
+#define K230_IOMUX_IO1  (K230_IOMUX_BASE + 0x04)
+#define K230_IOMUX_IO63 (K230_IOMUX_BASE + 0xfc)
+#define K230_IOMUX_RESERVED_FIRST (K230_IOMUX_BASE + 0x100)
+#define K230_IOMUX_MMIO_SIZE 0x800
+#define K230_IOMUX_NUM_REGS 64
+#define K230_IOMUX_RESERVED_LAST \
+    (K230_IOMUX_BASE + K230_IOMUX_MMIO_SIZE - 4)
+
+#define K230_IOMUX_IO_SEL_MASK (0x7 << 11)
+#define K230_IOMUX_IO_SEL(value) ((value) << 11)
+
+/* Bits 13:0 are RW; bits 30:14 are reserved; bit 31 (DI) is RO. */
+#define K230_IOMUX_EXPECTED_WRITABLE_MASK 0x00003fff
+
+static const uint32_t k230_iomux_reset_values[K230_IOMUX_NUM_REGS] = {
+    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
+    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
+    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
+    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
+};
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    for (size_t i = 0; i < G_N_ELEMENTS(k230_iomux_reset_values); i++) {
+        g_assert_cmphex(qtest_readl(qts, K230_IOMUX_BASE +
+                                    i * sizeof(uint32_t)), ==,
+                        k230_iomux_reset_values[i]);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO0, 0x00001234);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
+
+    qtest_writel(qts, K230_IOMUX_IO1, 0x00002abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0x00002abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
+
+    qtest_quit(qts);
+}
+
+static void test_write_mask(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO0, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
+                    K230_IOMUX_EXPECTED_WRITABLE_MASK);
+
+    qtest_quit(qts);
+}
+
+static void test_rmw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t value;
+
+    value = qtest_readl(qts, K230_IOMUX_IO0);
+    value = (value & ~K230_IOMUX_IO_SEL_MASK) | K230_IOMUX_IO_SEL(3);
+    qtest_writel(qts, K230_IOMUX_IO0, value);
+
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
+                    (k230_iomux_reset_values[0] &
+                     ~K230_IOMUX_IO_SEL_MASK) | K230_IOMUX_IO_SEL(3));
+
+    qtest_quit(qts);
+}
+
+static void test_io63_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO63, 0x00000abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==, 0x00000abc);
+
+    qtest_quit(qts);
+}
+
+static void test_reserved_offsets(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_RESERVED_FIRST, 0x00001234);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_RESERVED_FIRST), ==, 0);
+
+    qtest_writel(qts, K230_IOMUX_RESERVED_LAST, 0x00002abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_RESERVED_LAST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_reset_after_write(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO0, 0x00001234);
+    qtest_writel(qts, K230_IOMUX_IO1, 0x00002abc);
+    qtest_writel(qts, K230_IOMUX_IO63, 0x00000abc);
+
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0x00002abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==, 0x00000abc);
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
+                    k230_iomux_reset_values[0]);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==,
+                    k230_iomux_reset_values[1]);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==,
+                    k230_iomux_reset_values[63]);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-iomux/reset", test_reset_values);
+    qtest_add_func("/k230-iomux/rw", test_rw);
+    qtest_add_func("/k230-iomux/write-mask", test_write_mask);
+    qtest_add_func("/k230-iomux/rmw", test_rmw);
+    qtest_add_func("/k230-iomux/io63-rw", test_io63_rw);
+    qtest_add_func("/k230-iomux/reserved-offsets", test_reserved_offsets);
+    qtest_add_func("/k230-iomux/reset-after-write", test_reset_after_write);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..27378421bb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? [
+    'k230-wdt-test',
+    'k230-iomux-test',
+  ] : [])
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
-- 
2.43.0


