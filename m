Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE4606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Ggdz6we
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8SE-0006Ws-LY; Wed, 25 Nov 2026 03:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8S8-0006W4-8k
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:34:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8S2-0006V0-RY
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:34:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so2997745e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795595641; x=1796200441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yb2Buwm8jeASngV4dS4VpMeFiVlNpSlVOJAi4jwGYFo=;
 b=0Ggdz6weTGknYxKTZ4suLW0/pP69/RNnPchfcNOuoIF+Q2QDGMBMTHzf43QyegQOTr
 yCVrAsJLhaZLBy1DkZDfHblecrHaTDJZT7DeVGqfuLB2pj6C0jue387E6Mbbu0CxN6Ub
 qP6shUqi1NR84w3hr9luy9dc3979i7L7qdhqtTtmpjnAQJLGzfgdaSH9vi2fv92dLGiW
 D0sCjfKUlwU/9bAALbgXAigzjqeu1mgNuXnPj5FEYznwhH0AY4U27jurJI2sEFqaVHwk
 Bo8/tC8meCVu8SvuyIyLT1PaEpG6KfYeCsyJmu2pyhTP+ufphqWiPiLb/U35K9yCdK4m
 U/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795595641; x=1796200441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yb2Buwm8jeASngV4dS4VpMeFiVlNpSlVOJAi4jwGYFo=;
 b=CWD5ifNtQwztHmVA9u/7tPBJiVFC3xCPti5lRkNt0uXYLt1cM0jweXF2ONA2LtlHhb
 UXbRFlNbOY5x+gxpK8tvVjBc/tqMnzlwkR8Ps0RS5MgtSMu3d+V1ybsJj9S4Gcib0x/4
 PlJeR6MtWe9sHhmXixsOBhvoCiT9SpWMDoELx+MsC4pOfkI7xCDLMCDBb2DZrB0m/+eO
 TCYIaseW1YB5tQ6s/6rpOoBgf2e2Q1YY+3ELKvz6h4Nh/eHwQ3yO4sUgrE7mFSi9baYM
 YOwXj2GRW5jEi0PXpVa6LpPu6KR66EVGjVhESKWIlBs4U8geYL6iL6w2UOb7j7qEr5gt
 npvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFaPM19N5WOrfb7omkFAEAeLBLcCDYFbg4EJnvUkbv8vxGMsJbTOQ8kR98xe+Tb06ttmjG3ERQmThGt@nongnu.org
X-Gm-Message-State: APuU4Z+PP/OXwW+AHQEIxagiadxoB57XQuF8a6TmzcXjmoSlALK2ufsc
 1KfiPgqM8ihWbHhdWt/4cnuHmIrAlNqPnGd5IO6gDlJPnN2vVPACLATD
X-Gm-Gg: AZFdTZeW3RvP45+vxqv1wVcWTd9e/m8mKE/INUo/vmopqBkLVpdIROrVBq4jlHuKoSM
 X3gsFIYPe743NsAD+7mVi03/ZRz2pShEOdWV1n+kskZvxCfSQFPrYw+fH4AbRkI7np1f+lO7v6Z
 4gJC1o4v75On977vnCKhlRFskd0dJ/PqT86QNGzFoaBRMwA18KSLqj6FnmlxbvIo78fGd9OcCO/
 mdhLTd6xALXhMgXLTUVo4OqPm6/YmIOJzbyXLjSYU3sxOTHbqHQYylhycnKhs1hforpSdqA+15I
 DEIC/5oFqDxTkT75P/+1sLyJ/8vaU29RCtTICFtI3+R4Vmb8TnL5ky+3QM3QvOc6b+A/ZKCRAgO
 V6FIK06zmOHziD4dI0bMgOPNb/Upp4R6VxggQyffjD6kHV70o7VMz2X4ro0HLTG9UIwAq4ilmkR
 0Szp5+TJ+3cbus3WasqOx4d0pGgX610T9LpXXiDLrkCvT5fqSF/wY8LkpycMweN5tLR9bBYdNju
 QZfq00vjrvQMSFjAkpYlW8Gh1o+Bu4B7HzXzF1XAoeMYxG0jQ+UEOOjIzorPHBUbG+gVG8u2emX
 a035h8kPpXtlAmbRvMeAlMc4lgjzCp6v4rMf0S9pYjHxqROdCmbDWJ1uvKKCGMEwDPe/jvBM2qM
 svLmbOJgv0Ge67nz7PKyVuPq+
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4bb887c2c98mr313560145e9.4.1795595641137; 
 Wed, 25 Nov 2026 00:34:01 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm689837675e9.13.2026.11.25.00.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:34:00 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] tests/qtest: add SJA1000 receive FIFO coverage
Date: Wed, 25 Nov 2026 13:33:50 +0500
Message-ID: <20261125083350.331457-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125083350.331457-1-haseebashraf091@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x333.google.com
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Exercise RTR followed by data frames in both standard and extended
formats, plus hardware and software reset recovery.  The cases detect
FIFO misalignment caused by storing nonexistent RTR payload bytes and
by retaining the receive write pointer across reset.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/kvaser-pci-test.c | 195 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 3 files changed, 197 insertions(+)
 create mode 100644 tests/qtest/kvaser-pci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 40bf63651c..31b8d06a1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3117,6 +3117,7 @@ F: net/can/*
 F: hw/net/can/*
 F: include/net/can_*.h
 F: docs/system/devices/can.rst
+F: tests/qtest/kvaser-pci-test.c
 
 OpenPIC interrupt controller
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
diff --git a/tests/qtest/kvaser-pci-test.c b/tests/qtest/kvaser-pci-test.c
new file mode 100644
index 0000000000..2856f017f2
--- /dev/null
+++ b/tests/qtest/kvaser-pci-test.c
@@ -0,0 +1,195 @@
+/*
+ * Kvaser PCI SJA1000 receive FIFO tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+
+typedef struct {
+    QPCIDevice *dev;
+    QPCIBar bar;
+} Controller;
+
+static void write_reg(Controller *c, unsigned reg, uint8_t value)
+{
+    qpci_io_writeb(c->dev, c->bar, reg, value);
+}
+
+static uint8_t read_reg(Controller *c, unsigned reg)
+{
+    return qpci_io_readb(c->dev, c->bar, reg);
+}
+
+static void map_controller(Controller *c, QPCIBus *bus, int slot)
+{
+    c->dev = qpci_device_find(bus, QPCI_DEVFN(slot, 0));
+    g_assert_nonnull(c->dev);
+    qpci_device_enable(c->dev);
+    c->bar = qpci_iomap(c->dev, 1, NULL);
+}
+
+static void setup_controller(Controller *c, QPCIBus *bus, int slot)
+{
+    map_controller(c, bus, slot);
+    write_reg(c, 31, 0x80);
+    write_reg(c, 0, 0x09);
+    for (int i = 20; i < 24; ++i) {
+        write_reg(c, i, 0xff);
+    }
+    write_reg(c, 0, 0x08);
+}
+
+static void send_frame(Controller *c, bool extended, bool rtr,
+                       unsigned dlc, uint32_t id)
+{
+    unsigned data_reg;
+
+    write_reg(c, 16, (extended ? 0x80 : 0) | (rtr ? 0x40 : 0) | dlc);
+    if (extended) {
+        write_reg(c, 17, id >> 21);
+        write_reg(c, 18, id >> 13);
+        write_reg(c, 19, id >> 5);
+        write_reg(c, 20, id << 3);
+        data_reg = 21;
+    } else {
+        write_reg(c, 17, id >> 3);
+        write_reg(c, 18, id << 5);
+        data_reg = 19;
+    }
+    for (unsigned i = 0; i < dlc; ++i) {
+        write_reg(c, data_reg + i, 0xa0 + i);
+    }
+    write_reg(c, 1, 0x01);
+}
+
+static void expect_frame(Controller *c, bool extended, bool rtr,
+                         unsigned dlc, uint32_t id)
+{
+    uint32_t actual_id;
+    unsigned data_reg;
+
+    g_assert_cmphex(read_reg(c, 2) & 1, ==, 1);
+    g_assert_cmphex(read_reg(c, 16), ==,
+                    (extended ? 0x80 : 0) | (rtr ? 0x40 : 0) | dlc);
+    if (extended) {
+        actual_id = (uint32_t)read_reg(c, 17) << 21 |
+                    (uint32_t)read_reg(c, 18) << 13 |
+                    (uint32_t)read_reg(c, 19) << 5 |
+                    read_reg(c, 20) >> 3;
+        data_reg = 21;
+    } else {
+        actual_id = (uint32_t)read_reg(c, 17) << 3 | read_reg(c, 18) >> 5;
+        data_reg = 19;
+    }
+    g_assert_cmphex(actual_id, ==, id);
+    if (!rtr) {
+        for (unsigned i = 0; i < dlc; ++i) {
+            g_assert_cmphex(read_reg(c, data_reg + i), ==, 0xa0 + i);
+        }
+    }
+    write_reg(c, 1, 0x04);
+}
+
+static void test_rtr_fifo(void)
+{
+    QTestState *qts = qtest_init("-machine pc -nodefaults "
+                                 "-object can-bus,id=can0 "
+                                 "-device kvaser_pci,canbus=can0,addr=04.0 "
+                                 "-device kvaser_pci,canbus=can0,addr=05.0");
+    QPCIBus *bus = qpci_new_pc(qts, NULL);
+    Controller tx, rx;
+
+    setup_controller(&tx, bus, 4);
+    setup_controller(&rx, bus, 5);
+    for (int extended = 0; extended <= 1; ++extended) {
+        for (unsigned dlc = 0; dlc <= 8; ++dlc) {
+            uint32_t id = extended ? 0x1abcdeff : 0x5e1;
+            uint32_t data_id = extended ? 0x1abcdef0 : 0x5e2;
+
+            send_frame(&tx, extended, true, dlc, id);
+            send_frame(&tx, extended, false, 8, data_id);
+            expect_frame(&rx, extended, true, dlc, id);
+            expect_frame(&rx, extended, false, 8, data_id);
+            g_assert_cmphex(read_reg(&rx, 2) & 1, ==, 0);
+        }
+    }
+    g_free(tx.dev);
+    g_free(rx.dev);
+    qpci_free_pc(bus);
+    qtest_quit(qts);
+}
+
+static void test_reset_fifo(void)
+{
+    QTestState *qts = qtest_init("-machine pc -nodefaults "
+                                 "-object can-bus,id=can0 "
+                                 "-device kvaser_pci,canbus=can0,addr=04.0 "
+                                 "-device kvaser_pci,canbus=can0,addr=05.0");
+    QPCIBus *bus = qpci_new_pc(qts, NULL);
+    Controller tx, rx;
+
+    setup_controller(&tx, bus, 4);
+    setup_controller(&rx, bus, 5);
+    send_frame(&tx, false, false, 8, 0x5e2);
+    expect_frame(&rx, false, false, 8, 0x5e2);
+    g_free(tx.dev);
+    g_free(rx.dev);
+    qpci_free_pc(bus);
+
+    qtest_system_reset(qts);
+    bus = qpci_new_pc(qts, NULL);
+    setup_controller(&tx, bus, 4);
+    setup_controller(&rx, bus, 5);
+    send_frame(&tx, false, false, 8, 0x5e3);
+    expect_frame(&rx, false, false, 8, 0x5e3);
+    g_free(tx.dev);
+    g_free(rx.dev);
+    qpci_free_pc(bus);
+    qtest_quit(qts);
+}
+
+static void test_software_reset_fifo(void)
+{
+    QTestState *qts = qtest_init("-machine pc -nodefaults "
+                                 "-object can-bus,id=can0 "
+                                 "-device kvaser_pci,canbus=can0,addr=04.0 "
+                                 "-device kvaser_pci,canbus=can0,addr=05.0");
+    QPCIBus *bus = qpci_new_pc(qts, NULL);
+    Controller tx, rx;
+
+    setup_controller(&tx, bus, 4);
+    map_controller(&rx, bus, 5);
+    write_reg(&rx, 5, 0xff);
+    write_reg(&rx, 0, 0);
+
+    send_frame(&tx, false, false, 1, 0x5e2);
+    g_assert_cmphex(read_reg(&rx, 2) & 1, ==, 1);
+    g_assert_cmphex(read_reg(&rx, 20), ==, 0x5e2 >> 3);
+    write_reg(&rx, 1, 0x04);
+
+    write_reg(&rx, 0, 0);
+    send_frame(&tx, false, false, 1, 0x123);
+    g_assert_cmphex(read_reg(&rx, 2) & 1, ==, 1);
+    g_assert_cmphex(read_reg(&rx, 20), ==, 0x123 >> 3);
+    g_assert_cmphex(read_reg(&rx, 21), ==, ((0x123 << 5) & 0xe0) | 1);
+    g_assert_cmphex(read_reg(&rx, 22), ==, 0xa0);
+    write_reg(&rx, 1, 0x04);
+
+    g_free(tx.dev);
+    g_free(rx.dev);
+    qpci_free_pc(bus);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/kvaser-pci/rtr-fifo", test_rtr_fifo);
+    qtest_add_func("/kvaser-pci/reset-fifo", test_reset_fifo);
+    qtest_add_func("/kvaser-pci/software-reset-fifo", test_software_reset_fifo);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6e2938d913..913ed17aca 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,6 +59,7 @@ qtests_filter = \
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_CAN_PCI') ? ['kvaser-pci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
-- 
2.34.1


