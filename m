Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555E9CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIdx-0000mf-7q; Thu, 15 Oct 2026 06:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdv-0000lH-D8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:59 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIds-0003KZ-FC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:59 -0400
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso258772f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059895; x=1792664695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=61NEYluxRsQGvtMueBIKvSSCDkn5fQLszcxox8Hk6CM=;
 b=HkYkiF7IgrUI3LewkZgLlGgOFMyj8JciU/Nb2ju3Dg8M9l4R8Nv5uarb5aRi/Iydd1
 1/9kHgZr4xUNtwdTjEf83Zbd6dNamC0F2yLRrG+GjPa5f5Tv3gL7thAhHb3ucyW/px42
 jgix4YO6Pjo5oqNsotHoQGjA3eAIKCBFAa+TeLyXcLMiOFNPW8RpXgwAigZ5cFlwffPD
 RHw5SFPdFsBD3abnOW92xYyEwSp/IBEQlIW25Ke04ICI6qXHISj5SdBWr1/f1e87lyTD
 06ko2UPlcITQf8fNXjGwlu0diep0tGz5mPItHIixYXre+xzwfbGLfovJ3joqHmV1NDeT
 6vRA==
X-Gm-Message-State: AFq9FYLTUH08ZEGnadp3fOAwwFNVDwaYa8/dIn17Zy1x551VvKAjsh9r
 ovjfMT4GXCCvfOJWgWKY80Bw4NcjGzZ2+xvXoiu6nVt2Cvq/Ly5xfd51kdcreAmF
X-Gm-Gg: AYBFou01xwb/PPJqTk1GnFs6zrUyYIDx1rH/9SyBJSDmbW3YPxQpUubWJT743d0kWnA
 H1tVak9nsGbydQl0K6D/xgN00IOiIkwigdIOgteYAogUylipdzOnRv+UdJNd4cq/sUedGoxNELY
 XA+q3iokqTMq60Dm67B617eC+I5wN38hfekZW8KQQtQwFJPqyORp4ksWyGNO7oqE15rqjfSSTmh
 mpOcovyZBbPDsxPNU3WTuEATxyAkDCRn2I1xrNastRZdiNAIm979fH0W9bXOzemGh3RyzuN4uUf
 RDL0GNwVasGYd8H3dSgVjuX9q8weOfMYcvmPGxAK0plfIuHY1kzItvxP3IAK8ttWebYb6C3WckY
 pDUx2SGjfQfUwoILe7UKTg6Sx4i6tKR6Px5tnsiOryDV+lbrniPEm2Z314sQywjC+sXoj3Ubcol
 q4dEw8BtWha6N2SrHBcPBJqZLnFy7mRbcwJF+rLUxAFNNYJjPQXIciYrReQkP8BKuFe0fiEnmWY
 SKHpYEcGh6q/67nKBcNNfs0Dc12oO3Xgj6lp4bdnJ9DSohN6MajD+ab
X-Received: by 2002:a5d:588e:0:b0:48d:c186:dcc6 with SMTP id
 ffacd0b85a97d-48dc186dd62mr31665477f8f.57.1792059894704; 
 Thu, 15 Oct 2026 03:24:54 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df2619703sm5102749f8f.24.2026.10.15.03.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:24:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:54 +0200
Subject: [PATCH v3 07/50] tests/qtest: pca9545: add mux test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-7-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=4698;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=S5zD/fm1r3791LPnF7SwePv3pZV1UgFsCAKYoq/MMy0=;
 b=D06H95TZpEWtZTJY2jHv1rHgRCeRKLnJMvF0BfvIcge9GV0TDdyGcT3qsW/h9x8Dun/zRvfeY
 XrOcj4q3PW7ANte8TVHHSIBJoY80SrcK2F+5GnYiyY8b+ghIXR82+tO
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f48.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Exercise the PCA9545 4-channel I2C mux: channel selection through the
control byte, upper-nibble read-back, and interrupt logic.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build    |   1 +
 tests/qtest/pca9545-test.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36..e05d8a07b9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -336,6 +336,7 @@ qos_test_ss.add(
   'ne2000-test.c',
   'tulip-test.c',
   'nvme-test.c',
+  'pca9545-test.c',
   'pca9552-test.c',
   'pca9554-test.c',
   'pca9555-test.c',
diff --git a/tests/qtest/pca9545-test.c b/tests/qtest/pca9545-test.c
new file mode 100644
index 0000000000..91f56db92f
--- /dev/null
+++ b/tests/qtest/pca9545-test.c
@@ -0,0 +1,116 @@
+/*
+ * QTest testcase for the PCA9545 4-channel I2C switch with interrupt logic
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+
+#define PCA9545_TEST_ID   "pca9545-test"
+#define PCA9545_TEST_ADDR 0x70
+#define PCA9545_TEST_PATH "/machine/peripheral/" PCA9545_TEST_ID
+
+/* INTn and INT are active low: level 0 is asserted. */
+#define INT_ASSERTED   0
+#define INT_RELEASED   1
+
+/* The mux has no register pointer: a read/write moves a single control byte. */
+static uint8_t pca9545_get(QI2CDevice *dev)
+{
+    uint8_t val;
+
+    qi2c_recv(dev, &val, 1);
+    return val;
+}
+
+static void pca9545_set(QI2CDevice *dev, uint8_t val)
+{
+    qi2c_send(dev, &val, 1);
+}
+
+static void pca9545_set_int(unsigned chan, int level)
+{
+    qtest_set_irq_in(global_qtest, PCA9545_TEST_PATH, "interrupt", chan, level);
+}
+
+/* Channel selection is the lower nibble; the upper nibble reads back 0. */
+static void test_channel_select(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
+
+    pca9545_set(dev, 0x05); /* channels 0 and 2 */
+    g_assert_cmphex(pca9545_get(dev), ==, 0x05);
+
+    pca9545_set(dev, 0x0f); /* all channels */
+    g_assert_cmphex(pca9545_get(dev), ==, 0x0f);
+
+    pca9545_set(dev, 0x00);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
+}
+
+/*
+ * The interrupt status is reported in the upper nibble (INT3..INT0) and is
+ * latched regardless of which channels are selected (PCA9545A Table 5).
+ */
+static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    pca9545_set_int(1, INT_ASSERTED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x20);
+
+    pca9545_set(dev, 0x01);
+    pca9545_set_int(3, INT_ASSERTED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0xa1); /* INT3 | INT1 | channel 0 */
+
+    pca9545_set_int(1, INT_RELEASED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x81); /* INT3 | channel 0 */
+}
+
+/* The INT output is pulled low while any channel interrupt is active. */
+static void test_interrupt_output(void *obj, void *data, QGuestAllocator *alloc)
+{
+    qtest_irq_intercept_out_named(global_qtest, PCA9545_TEST_PATH,
+                                  "interrupt-out");
+
+    /*
+     * Interception starts with no recorded level, so drive an idle input
+     * first to make the mux publish the released state of its output.
+     */
+    pca9545_set_int(0, INT_RELEASED);
+    g_assert_true(get_irq(0));
+
+    pca9545_set_int(0, INT_ASSERTED);
+    g_assert_false(get_irq(0));
+
+    pca9545_set_int(2, INT_ASSERTED);
+    g_assert_false(get_irq(0));
+
+    pca9545_set_int(0, INT_RELEASED);
+    g_assert_false(get_irq(0));
+    pca9545_set_int(2, INT_RELEASED);
+    g_assert_true(get_irq(0));
+}
+
+static void pca9545_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" PCA9545_TEST_ID ",address=0x70"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { PCA9545_TEST_ADDR });
+
+    qos_node_create_driver("pca9545", i2c_device_create);
+    qos_node_consumes("pca9545", "i2c-bus", &opts);
+
+    qos_add_test("channel-select", "pca9545", test_channel_select, NULL);
+    qos_add_test("interrupt-status", "pca9545", test_interrupt_status, NULL);
+    qos_add_test("interrupt-output", "pca9545", test_interrupt_output, NULL);
+}
+libqos_init(pca9545_register_nodes);

-- 
2.53.0-Meta


