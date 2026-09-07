Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619E3C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cRp-0008MG-C7; Mon, 07 Sep 2026 12:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRn-0008Eq-Nz
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:55 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRl-00030y-Tc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:55 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso28400995e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799432; x=1789404232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=da4bGANhf55tfJs66hIW0MEMPfCwE/DCUaxLMtQ8Qmc=;
 b=N+7AxZEKLCBor/85Zw9m97X54rfjPK1u8TlSNSMr4GGS1r88sqh5aFxD6sXRHZthtU
 K+dBZ+2mqVz9KR0w5uM1BxRTsJzH3wvevWvLBn0fS5xOT4HVBlEOKDMWk/UtFhxq+dwE
 cyRojz6Yd9+MARPt2tNQj0gIld1tTqm+EW9gO8tnDt6Vj6LGkb9im170/6/YXpcxig5g
 e4ObXdWlLvmPEJuMxtl5SNO7wp2PWocKyHnP+CyI+FJ84SdiOse+ooCsPbWulSbPXJ8C
 nmZSjGRppyWNcbVScE6dxVFWaMXpgj9N0hNBOjcV+OOdpRd4DgVDYPVs3izgCZuNOEPR
 vhsA==
X-Gm-Message-State: AFuF++mCfjwHolNajdQ992SbSuJVQ1j56Lku8s4zcp40uOoMRVYwclR0
 0xFWu/qiK32zhzRwbhYn7vlV8bxnxJOeKlhYYRt/7oWYSKpRzS1JWC9tMnnmYBYp
X-Gm-Gg: AYBFou2kyauldiR/xwBnusdfLuuQb+RzlTxW1n5NGk5Y2ltb5NkC87Bp8LVtMa0vxO4
 QJb/BMWKiQx5Y4ZvnGaP9K74PFmMLR+W52P3ZjpDChgM98LgRFaWqV1ku5KEmzO7eOJ2gRuDwJW
 gLRMssYYt5dGhzgU222Os2mbcM30IA0ZQi4whDHPbFKdEiBVXkbBogWyet7lDMzp3D2Ky83UKeB
 9/W481JogeBKalo7LUTXLyqqacShjpp7+6Ep2jMxt/0yloMoni9rSMuRuqmBNx2cIKbliu70hAi
 8IOdNmVRRp0ZNmcUF09Hvb82mRDO9WtpUy9VgjOvcqShv5jxIAF300g3uJn/03IriUn9yk1FPvh
 HUHDBGIQWYAHuFU5sLzZlLj4meOlWy+O6TvnbuMoufjguw6fgWFoSgnrY97scXdSGW0bD1cqYnS
 IKzeoWcQQXa8U6+CKmSbtj1ibJXp4ZZFyYUgl8pbFcMyThrenj7uH5FLEKmfItBM4UbUBbqaB2V
 1aquQTkVJnsClPG8Ei6JLVguFWH4lF9k1+U
X-Received: by 2002:a05:600c:b93:b0:49d:17c5:8f7a with SMTP id
 5b1f17b1804b1-49d17c58fa8mr13030315e9.18.1788799432142; 
 Mon, 07 Sep 2026 09:43:52 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0af538d0sm174307545e9.8.2026.09.07.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:43:51 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:57 +0200
Subject: [PATCH 07/50] tests/qtest: pca9545: add mux test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-7-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=4644;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=6hFsJeHQBLg1M6vZ+OK9OUMoAu/LgU1tQxS6nBl8oxg=;
 b=ro24/EbVPlNXCmusVV5Ds3KYLLwY/19fNIkBkT/SaFDB93skdxboRLmW2r4iL9nE3/LlMUifA
 kln0U2w4kIiCPuXe4eDYLi+fYgOZSNtfgkawpTT7pNLQuhp6pGEHjr5
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f49.google.com
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

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build    |   1 +
 tests/qtest/pca9545-test.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..2da91ee791 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -330,6 +330,7 @@ qos_test_ss.add(
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
2.50.1


