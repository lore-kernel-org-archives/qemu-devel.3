Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452EBC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x991N-0004MW-NG; Tue, 22 Sep 2026 18:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991H-0004LN-Dn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:24 -0400
Received: from mail-ed2-x12.google.com ([2a00:1450:4864:33::12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991F-0004MQ-B4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:23 -0400
Received: by mail-ed2-x12.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9a59so560045a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790116280; x=1790721080;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7L62qwpJO3vGMxHxjmXF8JdEDxnZEQtw8mo5Q3M2Lc=;
 b=qiHATVIhvQZa2jt/vq/Iivb2KyrW7RyGo53YoV5RWFF2/ssJy6gHFTEETD4K493/dl
 iCOEdkjfaK7Nxfx+X7w0OjHtyb1YIxpQ6lgJ+TimFqSoJdQ29GUeDDlxIRosmbc5VP3/
 pd16JVNYCbO84IK7xdikmXsiASnKHyTiiB/xHXY5eP5wBdmza9hyhILnBguRI+6H7yQe
 XV+OJD3UV0BXMPW8FdYHKMfixopwEo5qkayejAln9JvQfT5rzjoFnKzyQ+EOXSWQ3pNN
 J5vKtMayAdh+mkwdUMtfjF4pNR/ACxabBq+F79W1w4swEK3XLxp6gAOjtivNq8pkd+2C
 Nn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790116280; x=1790721080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J7L62qwpJO3vGMxHxjmXF8JdEDxnZEQtw8mo5Q3M2Lc=;
 b=E/yIXWc6OO4WbzG3YPHayET3/45BBcm+TO+ESGzhf/jCDuMX+vWRoioxKlvVYID9AZ
 J2HSzFvU4BaxsvBuU3i0cspg3qet/p6vJg52X+A+NqnUqaXsjXoN8RmfGWqApudzlFfB
 QtCWTN/NqvRAcHpHkhtJq/ckcr3dnLN7S9R8eFT2lf8TW7qh4pRDj5F+qkOl/3gaU7ad
 qDO597TRrZWrAMc2GYi8SCP3hUHhRpZ85L+ALkPbRyVL4Aa7k3Akw9bmbcPS0qAem+Qn
 7fkuEST+nmjrN+oqhlxy3TgSnabjWOxSytb/66fTdFPlu1iDuLCezB0lBfFPsGMKPXVm
 cWog==
X-Gm-Message-State: AFuF++k47qczq4C8ID/YBIET2FZu2JIzPxVS0CiSrPU68yt3qGYRF70C
 ULVchYkBKnbJvQlnmdJQyYIw9N2ZaOBOv37AN5tTZOxgfBZRQs/SCMbjBArE2N49bkFouK7jF7r
 Aiw1OGkY=
X-Gm-Gg: AYBFou2XYdDAB4ZjXZZ8CJOrEqVCHMnoXnYqpN+H+HwTsMrNXUfCpg8GjCDFoNaUtV/
 hqbSuJXJ/fIxfgJlgw0ZMoPGF8gxbUnK7xsPi0cOj/pUBzmRfGZKUZQhPAxg1q4uRq5dzHH2ezC
 iPKqf+0m3HqsGDUdcGebOu+HwrAGtnvXL8L0jqt+P8+Bi9ZkWxFPEd7JnqL3Kw6KfXoWkSJYRUg
 GmkrCUs92JyzpYTwsQ+cdSazeldgmJWY9pmCc7M6cJKirWJo1I9brSv0R8+5HGm7S+Jczs7Bwhu
 ibRSMoRQhMz9bOMv33SUWStCJcsGQ+4XT6ljF/EXsKJjdJhjSfLTC8ScrE5Y+6Jk7xwC9JcrNhM
 IBs6ZcMglFAkr4jxEmzaZtd5O7zaEPb0K78V5/8+GTsO84IB4M13zCNga07VATRXO8MU03WrIDc
 nomUXtC7d4ELWp1vQ3ailwUn0BczxHB3+mMJVLYEqbz80AIuZbrS0f3+n1yPxacTxDWOEWL30Uv
 eExkgHRTnj4ISyxsAq4QR2VtH2ltsfswypUzMexz/esNzUGeJkFdTBdyA/LZXtz1Q==
X-Received: by 2002:a05:6402:50c8:b0:6a9:b89f:7bb1 with SMTP id
 4fb4d7f45d1cf-6aab3b0061emr638781a12.3.1790116279733; 
 Tue, 22 Sep 2026 15:31:19 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3883151sm411663a12.14.2026.09.22.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:31:19 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v2 3/6] tests/qtest: Add Cnuas virtual network adapter tests
Date: Tue, 22 Sep 2026 22:30:42 +0000
Message-ID: <20260922223045.190062-4-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:33::12;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ed2-x12.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Cover PCI identity, register reset, DMA, and packet transport.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/cnuas-vnic-test.c | 233 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 3 files changed, 235 insertions(+)
 create mode 100644 tests/qtest/cnuas-vnic-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f9e8db723..408fc58611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2777,6 +2777,7 @@ M: Weqaar Janjua <weqaar.janjua@packetfive.com>
 S: Maintained
 F: docs/specs/cnuas-vnic.rst
 F: hw/net/cnuas_vnic.c
+F: tests/qtest/cnuas-vnic-test.c
 
 VMware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
diff --git a/tests/qtest/cnuas-vnic-test.c b/tests/qtest/cnuas-vnic-test.c
new file mode 100644
index 0000000000..fc27b7fa8e
--- /dev/null
+++ b/tests/qtest/cnuas-vnic-test.c
@@ -0,0 +1,233 @@
+/*
+ * QTest for the Cnuas virtual network adapter
+ *
+ * Copyright (c) 2026 PacketFive
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_regs.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+#include "libqtest.h"
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#define CNUAS_VNIC_DEVFN           QPCI_DEVFN(4, 0)
+#define CNUAS_VNIC_BAR_SIZE        4096
+#define CNUAS_VNIC_REG_TX_ADDR_LO  0x00
+#define CNUAS_VNIC_REG_TX_ADDR_HI  0x04
+#define CNUAS_VNIC_REG_TX_LEN      0x08
+#define CNUAS_VNIC_REG_TX_DOORBELL 0x0c
+#define CNUAS_VNIC_REG_RX_ADDR_LO  0x10
+#define CNUAS_VNIC_REG_RX_ADDR_HI  0x14
+#define CNUAS_VNIC_REG_RX_LEN      0x18
+#define CNUAS_VNIC_REG_RX_STATUS   0x1c
+#define CNUAS_VNIC_REG_IRQ_STATUS  0x20
+#define CNUAS_VNIC_REG_IRQ_MASK    0x24
+#define CNUAS_VNIC_REG_LINK_STATUS 0x28
+#define CNUAS_VNIC_REG_MAC_LO      0x2c
+#define CNUAS_VNIC_REG_MAC_HI      0x30
+
+typedef struct CnuasVnicTest {
+    QTestState *qts;
+    QPCIBus *bus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+} CnuasVnicTest;
+
+static void cnuas_vnic_test_start_with_args(CnuasVnicTest *test,
+                                            const char *args)
+{
+    uint64_t bar_size;
+
+    test->qts = qtest_initf("-machine q35 "
+                            "-device cnuas-vnic,addr=04.0,"
+                            "mac=02:11:22:33:44:55%s", args);
+    test->bus = qpci_new_pc(test->qts, NULL);
+    test->dev = qpci_device_find(test->bus, CNUAS_VNIC_DEVFN);
+    g_assert_nonnull(test->dev);
+    qpci_device_enable(test->dev);
+    test->bar = qpci_iomap(test->dev, 0, &bar_size);
+    g_assert_cmpuint(bar_size, ==, CNUAS_VNIC_BAR_SIZE);
+}
+
+static void cnuas_vnic_test_start(CnuasVnicTest *test)
+{
+    cnuas_vnic_test_start_with_args(test, "");
+}
+
+static void cnuas_vnic_test_stop(CnuasVnicTest *test)
+{
+    g_free(test->dev);
+    qpci_free_pc(test->bus);
+    qtest_quit(test->qts);
+}
+
+static void cnuas_vnic_test_pci_config(void)
+{
+    CnuasVnicTest test;
+
+    cnuas_vnic_test_start(&test);
+
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_VENDOR_ID), ==,
+                    PCI_VENDOR_ID_REDHAT);
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_DEVICE_ID), ==,
+                    PCI_DEVICE_ID_REDHAT_CNUASNIC);
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_CLASS_DEVICE), ==,
+                    PCI_CLASS_NETWORK_OTHER);
+    g_assert_cmphex(qpci_config_readb(test.dev, PCI_REVISION_ID), ==, 1);
+    g_assert_cmphex(qpci_find_capability(test.dev, PCI_CAP_ID_MSI, 0), !=, 0);
+
+    cnuas_vnic_test_stop(&test);
+}
+
+static void cnuas_vnic_test_registers(void)
+{
+    CnuasVnicTest test;
+
+    cnuas_vnic_test_start(&test);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_LINK_STATUS), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_IRQ_STATUS), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_MAC_LO), ==, 0x33221102);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_MAC_HI), ==, 0x5544);
+
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_LO,
+                   0x89abcdef);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_HI,
+                   0x01234567);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_LEN, 4096);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_IRQ_MASK, 7);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_ADDR_LO), ==,
+                    0x89abcdef);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_ADDR_HI), ==,
+                    0x01234567);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_LEN), ==, 4096);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_IRQ_MASK), ==, 7);
+
+    qtest_system_reset(test.qts);
+    qpci_device_enable(test.dev);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_ADDR_LO), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_ADDR_HI), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_TX_LEN), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_RX_STATUS), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_IRQ_MASK), ==, 0);
+
+    cnuas_vnic_test_stop(&test);
+}
+
+static int cnuas_vnic_test_listen(char **path)
+{
+    struct sockaddr_un address = { .sun_family = AF_UNIX };
+    int fd;
+
+    *path = g_strdup_printf("/tmp/cnuas-vnic-test-%u.sock", getpid());
+    unlink(*path);
+    g_strlcpy(address.sun_path, *path, sizeof(address.sun_path));
+
+    fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(bind(fd, (struct sockaddr *)&address, sizeof(address)),
+                    ==, 0);
+    g_assert_cmpint(listen(fd, 1), ==, 0);
+    return fd;
+}
+
+static void cnuas_vnic_test_transport(void)
+{
+    static const uint8_t tx_frame[] = {
+        0x02, 0, 0, 0, 0, 2, 0x02, 0, 0, 0, 0, 1, 0x08, 0,
+        'C', 'n', 'u', 'a', 's',
+    };
+    static const uint8_t rx_frame[] = {
+        0x02, 0, 0, 0, 0, 1, 0x02, 0, 0, 0, 0, 2, 0x08, 0,
+        'R', 'D', 'M', 'A',
+    };
+    uint8_t result[64] = { 0 };
+    const uint64_t tx_address = 0x100000;
+    const uint64_t rx_address = 0x101000;
+    g_autofree char *path = NULL;
+    g_autofree char *args = NULL;
+    CnuasVnicTest test;
+    int connection;
+    int listener;
+    unsigned int i;
+
+    listener = cnuas_vnic_test_listen(&path);
+    args = g_strdup_printf(",socket_path=%s", path);
+    cnuas_vnic_test_start_with_args(&test, args);
+    connection = accept(listener, NULL, NULL);
+    g_assert_cmpint(connection, >=, 0);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
+                                  CNUAS_VNIC_REG_LINK_STATUS), ==, 1);
+
+    qtest_memwrite(test.qts, tx_address, tx_frame, sizeof(tx_frame));
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_LO,
+                   tx_address);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_HI,
+                   tx_address >> 32);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_LEN,
+                   sizeof(tx_frame));
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_DOORBELL, 1);
+
+    g_assert_cmpint(recv(connection, result, sizeof(result), 0), ==,
+                    sizeof(tx_frame));
+    g_assert_cmpmem(result, sizeof(tx_frame), tx_frame, sizeof(tx_frame));
+
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_RX_ADDR_LO,
+                   rx_address);
+    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_RX_ADDR_HI,
+                   rx_address >> 32);
+    g_assert_cmpint(send(connection, rx_frame, sizeof(rx_frame), 0), ==,
+                    sizeof(rx_frame));
+
+    for (i = 0; i < 1000; i++) {
+        if (qpci_io_readl(test.dev, test.bar,
+                          CNUAS_VNIC_REG_RX_STATUS) == 1) {
+            break;
+        }
+        g_usleep(1000);
+    }
+    g_assert_cmpuint(i, <, 1000);
+    g_assert_cmpuint(qpci_io_readl(test.dev, test.bar,
+                                   CNUAS_VNIC_REG_RX_LEN), ==,
+                     sizeof(rx_frame));
+
+    memset(result, 0, sizeof(result));
+    qtest_memread(test.qts, rx_address, result, sizeof(rx_frame));
+    g_assert_cmpmem(result, sizeof(rx_frame), rx_frame, sizeof(rx_frame));
+
+    close(connection);
+    close(listener);
+    unlink(path);
+    cnuas_vnic_test_stop(&test);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/cnuas-vnic/pci-config", cnuas_vnic_test_pci_config);
+    qtest_add_func("/cnuas-vnic/registers", cnuas_vnic_test_registers);
+    qtest_add_func("/cnuas-vnic/transport", cnuas_vnic_test_transport);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 33f58b0e95..84d2fa702a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,6 +59,7 @@ qtests_filter = \
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_CNUAS_VNIC') ? ['cnuas-vnic-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
-- 
2.43.0


