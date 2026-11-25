Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB257606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7osawiI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAlX-00036r-Dp; Wed, 25 Nov 2026 06:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlW-00036f-KS
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:18 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlU-00050Z-DS
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2939560f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604535; x=1796209335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5MLrHbdvqRuTnHaaS5QQsRZblRS/IcXibFtL1pwskWM=;
 b=f7osawiIlq4dbnvv6kdp0i6X0KkwW/lXC32BPOS/exBEztWXZnkDTgsVPkcw4LRnRA
 kRT3o2IWUWZL1BQklPpaRA9H3kGjMtKNiTnPc3be//PZquGxkgQXOrE9jbKxZbpvsc+s
 x6A8jGnXAlZr9lCzKkQXWY7in+oH14bY8MZdagotIePymOGjCXopuKfeKZ/JyZjEPLBZ
 Dc4v1mIE7leqEmQlHAWiueDpkato4OsCB8HM7LXPZ9MvAQ/DJW6qMVDtqSNfe85mITyB
 gZ6Kn/j+KzEE480ADPl/F43IR4X42cT3y0j+9vgAwH7UURkHTPv6Qy8pWeZB10l3ulWf
 0h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604535; x=1796209335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5MLrHbdvqRuTnHaaS5QQsRZblRS/IcXibFtL1pwskWM=;
 b=Jg9f6Ma5pDtyX2OD235kJ9w7xAz7dTxzLrurb+kF7U3rsrKZP5hWW+zTqXrbRFN3Kd
 kd6LWN9dKcbBN9TAuE4sNWg9AWUMIDJQkUIVZv/RLRBytmTsq+Mlqj5A600zxQJ/Uv/L
 fClFEyCUIZcdDEi9ocgVhE6wBWuMCpGdSICWF3sO1nsTt5WGtiqPjYZhW6syw7AkAxaN
 tyO2Uxo0/ejfV2FbzSdUrELuras22tVgLrRrxo++5uiwjoq2pYgItD+vXQ3jJta/+4vp
 blUBIHNzt1rKOyqzBE2dMUzRNpneNU871u7Zdjo7dA8Mz7AfxohYognniB3Adpkr/z4+
 CoCw==
X-Forwarded-Encrypted: i=1;
 AL+hErFK+HS9GnEC+xoauUcY+T/e4wagP1tsxqXqT0JvP8/NbTSJvUzBOEcVxEYhGlxn1x1+edLWHwKOPm7u@nongnu.org
X-Gm-Message-State: APuU4Z9zoQmnoDg9DwIP2v2qHVOeflF01l68bw7R0qkGsId9kUBn7ImJ
 bgXoSGKNeuju9+0jSQfiR0eoizfUj2sTttgHihJA/pNJAzNbXPJkrLuSFwV+YQ==
X-Gm-Gg: AZFdTZdyX4V+rgwGofnqsan3WCGKO5yxWYns6nbc5eqq+qsszUFaynC2UD/2LGKpxGR
 JtWgNGhBF9OZNSJM0y+8vh/i7ymo8cmxcH4jbCGyn8UC4F4c3+3T2T7BO7aRDVtS9AvBloYukhL
 CIV4HSV3BSctWmtCeoraXmu5NHoSFC2/SNDq01QAFzT5xgB/2mh6BsujgzODAD+DtuW/sspB+Yv
 bsBjwFbn2xbFCWzitFa93W5+qryIkvX74ESrgVZZcz4ty0exRVm08WO8qKYk1B184jS7zeumlbX
 KsRH6FL3lrLckE3+q3MlybEVlZaWj1TwYI/M2inyEfbwvd1ICDmdB46zLPZpW8sFbi3QQzLmlHK
 7AkFqSZmeOrP+4PNalBObq6DLk4VdI09YL/S0/wNat/tANGpO+lGt5gNhPGf15JBjf8YScdugR6
 whKfxt7xZoK0HBMPAIxPFta1MD8eNkzXjRaYsx8ZywXDi696l8vnaMH/PpsLmLf3lUdTrcmqkdP
 3YV5pyJqEIeulV+BlZ/aWBQdUZyisIXvZ53EEtEM1DtklwuID0eKQqVrU/rPJD+K1XYGLUaNiWN
 QBSFm1ufkbqkco/s8x7mqGRU5KM6sCjnd0B3YpzssnHiSmyLuGrb61HwbRpiuzfoVgeJ6TvIVpo
 YPTCNAilODEttyXyKmSAhHmaF
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id
 ffacd0b85a97d-4ac7595721cmr28752913f8f.40.1795604534599; 
 Wed, 25 Nov 2026 03:02:14 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm38665459f8f.55.2026.11.25.03.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:02:14 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 2/2] tests/qtest: add SJA1000 receive FIFO coverage
Date: Wed, 25 Nov 2026 16:02:02 +0500
Message-ID: <20261125110202.471181-3-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125110202.471181-1-haseebashraf091@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
 <20261125110202.471181-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wr1-x42e.google.com
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

Exercise RTR followed by data frames in PeliCAN standard and extended
formats and in BasicCAN mode, plus hardware and software reset
recovery.  The cases detect FIFO misalignment caused by storing
nonexistent RTR payload bytes, and stale receive write pointers across
reset.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/kvaser-pci-test.c | 258 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 3 files changed, 258 insertions(+)
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
index 0000000000..a29b64c361
--- /dev/null
+++ b/tests/qtest/kvaser-pci-test.c
@@ -0,0 +1,258 @@
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
+static void setup_basic_controller(Controller *c, QPCIBus *bus, int slot)
+{
+    map_controller(c, bus, slot);
+    write_reg(c, 31, 0);
+    write_reg(c, 0, 0x01);
+    write_reg(c, 4, 0);
+    write_reg(c, 5, 0xff);
+    write_reg(c, 0, 0);
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
+static void send_basic_frame(Controller *c, bool rtr, unsigned dlc,
+                             uint32_t id)
+{
+    write_reg(c, 10, id >> 3);
+    write_reg(c, 11, (id << 5) | (rtr ? 0x10 : 0) | dlc);
+    for (unsigned i = 0; i < dlc; ++i) {
+        write_reg(c, 12 + i, 0xa0 + i);
+    }
+    write_reg(c, 1, 0x01);
+}
+
+static void expect_basic_frame(Controller *c, bool rtr, unsigned dlc,
+                               uint32_t id)
+{
+    g_assert_cmphex(read_reg(c, 2) & 1, ==, 1);
+    g_assert_cmphex(read_reg(c, 21) & 0x1f, ==, (rtr ? 0x10 : 0) | dlc);
+    g_assert_cmphex((uint32_t)read_reg(c, 20) << 3 |
+                    read_reg(c, 21) >> 5, ==, id);
+    if (!rtr) {
+        for (unsigned i = 0; i < dlc; ++i) {
+            g_assert_cmphex(read_reg(c, 22 + i), ==, 0xa0 + i);
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
+    qpci_iounmap(tx.dev, tx.bar);
+    qpci_iounmap(rx.dev, rx.bar);
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
+static void test_basiccan_rtr_fifo(void)
+{
+    QTestState *qts = qtest_init("-machine pc -nodefaults "
+                                 "-object can-bus,id=can0 "
+                                 "-device kvaser_pci,canbus=can0,addr=04.0 "
+                                 "-device kvaser_pci,canbus=can0,addr=05.0");
+    QPCIBus *bus = qpci_new_pc(qts, NULL);
+    Controller tx, rx;
+
+    setup_basic_controller(&tx, bus, 4);
+    setup_basic_controller(&rx, bus, 5);
+    for (unsigned dlc = 0; dlc <= 8; ++dlc) {
+        send_basic_frame(&tx, true, dlc, 0x5e1);
+        send_basic_frame(&tx, false, 8, 0x5e2);
+        expect_basic_frame(&rx, true, dlc, 0x5e1);
+        expect_basic_frame(&rx, false, 8, 0x5e2);
+        g_assert_cmphex(read_reg(&rx, 2) & 1, ==, 0);
+    }
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
+    qtest_add_func("/kvaser-pci/basiccan-rtr-fifo", test_basiccan_rtr_fifo);
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


