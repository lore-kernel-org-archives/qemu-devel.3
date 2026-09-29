Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12839CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBeNP-00067w-E1; Tue, 29 Sep 2026 16:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNN-00067L-Hy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:33 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNK-0005Dv-0m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:33 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso24633125e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790713469; x=1791318269;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tMcuylrZU9nJbUZEyATMI7HKiHj96g6+2a7biu2aCXg=;
 b=AIJap125ZOKewGb2tJhGW7ZCkzuR0alOU3kybqthR0h54mlF1T6pfrk45LQf8mJ9xV
 NI8/SvY1TqWg9grbDybkv3AVJbUtfw4VLSBX02DcYfbjTPN4K/cE7WrQh0QgM/PiWEZl
 CJAMFPFvfTNxYg9utlRfCqknzawnqkyZram79fQIwpYQGzkPrOm8nk+exP9G3n76TKI2
 uZf4rw2Zv2hCBRooKP24jfSfZxEDXgoCuiV4/aC46KimY0B1O048maljffaYBImQjf3I
 aTkqsgw2FKBlVQJzMz0Sob2XhkWgV1jzaNgfKb2sziGybCR8WmvhhLh+2Zq3fMBqYkrW
 rrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790713469; x=1791318269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tMcuylrZU9nJbUZEyATMI7HKiHj96g6+2a7biu2aCXg=;
 b=aEv36Bem/sAWjKO1Pf1EAubwXpGvJ6Vj7PJmJ7jm6qNSZcJPsaFZlh6cY4XQXl22J5
 QHLdlv7NH/JRLts46NsA+w0fJgVI1W9pI53FRDG0CFNwnSxExeovDwuVWgt9szi0E+vn
 fN8Lb8n8tdTwhPH4k+WQ6Ux05qYQgX89hUvc1/q0x18lI2BotgKTo/kk9G3Q7uIFQ44u
 MQP7+8264czzxotb/F8dnyC4SpSlAT+Ua6FWDpMJkm8S/OEAWxCzbwvDBKETUm6g+8zZ
 J9mjwfHqFptLLyrbmdDq2pUB5qLSd6j9jzf1oWmuztVFdhVGmVMJ3LzwzUcXT+hyjqwx
 w7Zw==
X-Gm-Message-State: AFuF++nzh/t47v1ARVOeKgAS0kLgZlyPrC98Egl17g8t8N47fiRshZlk
 WZtFkSlJkpiKkpRYlj3PfjsQVwJYXNUf9P2Smm2bCIOVmWBp+FPFWUNzG6EhJGtDXx+ZfYEaAXh
 fsq59KjA=
X-Gm-Gg: AYBFou0brC0DaX6Yrur9fuG0v9cJORuww8T711sknxmBgrNxuoukM4JZ2GUsrGA1Vi5
 2zGRZiCUrkjzSkOwTKGo4WTfz9Oz7nBeSgVa25ez+Kf+0c6EfQWYuL/VeJzfmiW2vgek2TTyPCJ
 ZUqINc9W/WSrJ77eQ74lFcDgZm0wJhWjil6QH/6C48KwY4wkaGpNUq/gZ4a1RZ/RdNBt29HZ6qG
 20AErN7FF/i3yHV8SW4qmQ9NUbDWizPVNrF2EdlnmhsHdlGheqpDf4VpIvB0QA/7oea26cfOEAw
 vWIqSrMyi0spTGukaJkO5946cYTSmtqpKoI0MVQ9NByjyfRN1NrtXi1DwysOYxOauv0dRT6Racd
 aG2Jgw1LwvYe4mwts99kurNR8p4f+pBOVIPWOmB84wLlP2EoBExxcleyZqVhtzp6ZkuhX6XAwK5
 NBjM5XfzCTTVRf470mjayKTVpIZveLqKfrJUzIR5TtRTedYFF7w+EEBbdNWRM6rz1XCIxp07xo6
 AG0+2L47Tss2eEa3XrioSZx/3c00Ifocsp9v8Kgxv00WRlufgkirq5E9FjZJRUQpQ==
X-Received: by 2002:a05:600c:800e:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-4a01501cf4bmr4080725e9.14.1790713468688; 
 Tue, 29 Sep 2026 13:24:28 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f77aa3sm7021525e9.7.2026.09.29.13.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 13:24:28 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: [PATCH v3 6/6] tests/qtest: Add CnuasGPU tests
Date: Tue, 29 Sep 2026 20:23:57 +0000
Message-ID: <20260929202358.725310-7-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:31::11;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Cover PCI identity, registers, device memory, reset, and link transport.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/cnuasgpu-test.c | 274 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   1 +
 3 files changed, 276 insertions(+)
 create mode 100644 tests/qtest/cnuasgpu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b2173d832..d05d3db674 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2781,6 +2781,7 @@ F: docs/specs/cnuasgpu.rst
 F: hw/misc/cnuasgpu.c
 F: hw/net/cnuas_vnic.c
 F: tests/qtest/cnuas-vnic-test.c
+F: tests/qtest/cnuasgpu-test.c
 
 VMware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
diff --git a/tests/qtest/cnuasgpu-test.c b/tests/qtest/cnuasgpu-test.c
new file mode 100644
index 0000000000..3ac3b20b32
--- /dev/null
+++ b/tests/qtest/cnuasgpu-test.c
@@ -0,0 +1,274 @@
+/*
+ * QTest for the CnuasGPU virtual accelerator
+ *
+ * Copyright (c) 2026 PacketFive
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_regs.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+#include "libqtest.h"
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#define CNUAS_GPU_DEVFN               QPCI_DEVFN(4, 0)
+#define CNUAS_GPU_BAR0_SIZE           (64 * KiB)
+#define CNUAS_GPU_BAR1_SIZE           (16 * MiB)
+#define CNUAS_GPU_REG_VENDOR_ID       0x000
+#define CNUAS_GPU_REG_DEVICE_ID       0x004
+#define CNUAS_GPU_REG_REVISION        0x008
+#define CNUAS_GPU_REG_FW_VERSION      0x00c
+#define CNUAS_GPU_REG_GPU_ID          0x010
+#define CNUAS_GPU_REG_SM_COUNT        0x014
+#define CNUAS_GPU_REG_LANES_PER_SM    0x018
+#define CNUAS_GPU_REG_TENSOR_SIZE     0x01c
+#define CNUAS_GPU_REG_DEVMEM_SIZE_LO  0x020
+#define CNUAS_GPU_REG_DEVMEM_SIZE_HI  0x024
+#define CNUAS_GPU_REG_IRQ_STATUS      0x100
+#define CNUAS_GPU_REG_IRQ_MASK        0x104
+#define CNUAS_GPU_REG_LINK_STATUS     0x200
+#define CNUAS_GPU_REG_TX_OFFSET_LO    0x204
+#define CNUAS_GPU_REG_TX_OFFSET_HI    0x208
+#define CNUAS_GPU_REG_TX_LEN          0x20c
+#define CNUAS_GPU_REG_TX_DOORBELL     0x210
+#define CNUAS_GPU_REG_RX_OFFSET_LO    0x214
+#define CNUAS_GPU_REG_RX_OFFSET_HI    0x218
+#define CNUAS_GPU_REG_RX_BUF_SIZE     0x21c
+#define CNUAS_GPU_REG_RX_LEN          0x220
+#define CNUAS_GPU_REG_RX_CONSUME      0x224
+
+typedef struct CnuasGpuTest {
+    QTestState *qts;
+    QPCIBus *bus;
+    QPCIDevice *dev;
+    QPCIBar bar0;
+    QPCIBar bar1;
+} CnuasGpuTest;
+
+static void cnuas_gpu_test_start_with_args(CnuasGpuTest *test,
+                                           const char *args)
+{
+    uint64_t bar_size;
+
+    test->qts = qtest_initf("-machine q35 "
+                            "-device cnuasgpu,addr=04.0,devmem_size=16M,"
+                            "gpu_id=7,sm_count=24,lanes_per_sm=64,"
+                            "tensor_size=32%s", args);
+    test->bus = qpci_new_pc(test->qts, NULL);
+    test->dev = qpci_device_find(test->bus, CNUAS_GPU_DEVFN);
+    g_assert_nonnull(test->dev);
+    qpci_device_enable(test->dev);
+
+    test->bar0 = qpci_iomap(test->dev, 0, &bar_size);
+    g_assert_cmpuint(bar_size, ==, CNUAS_GPU_BAR0_SIZE);
+    test->bar1 = qpci_iomap(test->dev, 1, &bar_size);
+    g_assert_cmpuint(bar_size, ==, CNUAS_GPU_BAR1_SIZE);
+}
+
+static void cnuas_gpu_test_start(CnuasGpuTest *test)
+{
+    cnuas_gpu_test_start_with_args(test, "");
+}
+
+static void cnuas_gpu_test_stop(CnuasGpuTest *test)
+{
+    g_free(test->dev);
+    qpci_free_pc(test->bus);
+    qtest_quit(test->qts);
+}
+
+static void cnuas_gpu_test_pci_config(void)
+{
+    CnuasGpuTest test;
+
+    cnuas_gpu_test_start(&test);
+
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_VENDOR_ID), ==,
+                    PCI_VENDOR_ID_REDHAT);
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_DEVICE_ID), ==,
+                    PCI_DEVICE_ID_REDHAT_CNUASGPU);
+    g_assert_cmphex(qpci_config_readw(test.dev, PCI_CLASS_DEVICE), ==,
+                    PCI_CLASS_PROCESSOR_CO);
+    g_assert_cmphex(qpci_config_readb(test.dev, PCI_REVISION_ID), ==, 1);
+    g_assert_cmphex(qpci_find_capability(test.dev, PCI_CAP_ID_MSI, 0), !=, 0);
+
+    cnuas_gpu_test_stop(&test);
+}
+
+static void cnuas_gpu_test_registers(void)
+{
+    CnuasGpuTest test;
+
+    cnuas_gpu_test_start(&test);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_VENDOR_ID), ==,
+                    PCI_VENDOR_ID_REDHAT);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_DEVICE_ID), ==,
+                    PCI_DEVICE_ID_REDHAT_CNUASGPU);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_REVISION), ==, 1);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_FW_VERSION), ==, 0x00010000);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_GPU_ID), ==, 7);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_SM_COUNT), ==, 24);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_LANES_PER_SM), ==, 64);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_TENSOR_SIZE), ==, 32);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_DEVMEM_SIZE_LO), ==,
+                    CNUAS_GPU_BAR1_SIZE);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_DEVMEM_SIZE_HI), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_LINK_STATUS), ==, 0);
+
+    cnuas_gpu_test_stop(&test);
+}
+
+static void cnuas_gpu_test_memory_and_reset(void)
+{
+    static const uint8_t pattern[] = {
+        0x43, 0x6e, 0x75, 0x61, 0x73, 0x47, 0x50, 0x55,
+    };
+    uint8_t result[sizeof(pattern)] = { 0 };
+    CnuasGpuTest test;
+
+    cnuas_gpu_test_start(&test);
+
+    qpci_memwrite(test.dev, test.bar1, 0x1000, pattern, sizeof(pattern));
+    qpci_memread(test.dev, test.bar1, 0x1000, result, sizeof(result));
+    g_assert_cmpmem(result, sizeof(result), pattern, sizeof(pattern));
+
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_IRQ_MASK, 3);
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_TX_OFFSET_LO,
+                   0x12345678);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_IRQ_MASK), ==, 3);
+
+    qtest_system_reset(test.qts);
+    qpci_device_enable(test.dev);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_IRQ_STATUS), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_IRQ_MASK), ==, 0);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_TX_OFFSET_LO), ==, 0);
+
+    cnuas_gpu_test_stop(&test);
+}
+
+static int cnuas_gpu_test_listen(char **path)
+{
+    struct sockaddr_un address = { .sun_family = AF_UNIX };
+    int fd;
+
+    *path = g_strdup_printf("/tmp/cnuasgpu-test-%u.sock", getpid());
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
+static void cnuas_gpu_test_transport(void)
+{
+    static const uint8_t tx_frame[] = {
+        0x43, 0x6e, 0x75, 0x61, 0x73, 0x4c, 0x69, 0x6e, 0x6b,
+    };
+    static const uint8_t rx_frame[] = {
+        0x70, 0x65, 0x65, 0x72, 0x2d, 0x66, 0x72, 0x61, 0x6d, 0x65,
+    };
+    uint8_t result[64] = { 0 };
+    const uint64_t tx_offset = 0x1000;
+    const uint64_t rx_offset = 0x2000;
+    g_autofree char *path = NULL;
+    g_autofree char *args = NULL;
+    CnuasGpuTest test;
+    int connection;
+    int listener;
+    unsigned int i;
+
+    listener = cnuas_gpu_test_listen(&path);
+    args = g_strdup_printf(",cnuaslink_socket=%s", path);
+    cnuas_gpu_test_start_with_args(&test, args);
+    connection = accept(listener, NULL, NULL);
+    g_assert_cmpint(connection, >=, 0);
+
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_LINK_STATUS), ==, 1);
+
+    qpci_memwrite(test.dev, test.bar1, tx_offset, tx_frame,
+                  sizeof(tx_frame));
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_TX_OFFSET_LO,
+                   tx_offset);
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_TX_OFFSET_HI,
+                   tx_offset >> 32);
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_TX_LEN,
+                   sizeof(tx_frame));
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_TX_DOORBELL, 1);
+
+    g_assert_cmpint(recv(connection, result, sizeof(result), 0), ==,
+                    sizeof(tx_frame));
+    g_assert_cmpmem(result, sizeof(tx_frame), tx_frame, sizeof(tx_frame));
+
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_RX_OFFSET_LO,
+                   rx_offset);
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_RX_OFFSET_HI,
+                   rx_offset >> 32);
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_RX_BUF_SIZE,
+                   sizeof(rx_frame));
+    g_assert_cmpint(send(connection, rx_frame, sizeof(rx_frame), 0), ==,
+                    sizeof(rx_frame));
+
+    for (i = 0; i < 1000; i++) {
+        if (qpci_io_readl(test.dev, test.bar0,
+                          CNUAS_GPU_REG_LINK_STATUS) == 3) {
+            break;
+        }
+        g_usleep(1000);
+    }
+    g_assert_cmpuint(i, <, 1000);
+    g_assert_cmpuint(qpci_io_readl(test.dev, test.bar0,
+                                   CNUAS_GPU_REG_RX_LEN), ==,
+                     sizeof(rx_frame));
+
+    memset(result, 0, sizeof(result));
+    qpci_memread(test.dev, test.bar1, rx_offset, result, sizeof(rx_frame));
+    g_assert_cmpmem(result, sizeof(rx_frame), rx_frame, sizeof(rx_frame));
+
+    qpci_io_writel(test.dev, test.bar0, CNUAS_GPU_REG_RX_CONSUME, 1);
+    g_assert_cmphex(qpci_io_readl(test.dev, test.bar0,
+                                  CNUAS_GPU_REG_LINK_STATUS), ==, 1);
+
+    close(connection);
+    close(listener);
+    unlink(path);
+    cnuas_gpu_test_stop(&test);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/cnuasgpu/pci-config", cnuas_gpu_test_pci_config);
+    qtest_add_func("/cnuasgpu/registers", cnuas_gpu_test_registers);
+    qtest_add_func("/cnuasgpu/memory-and-reset",
+                   cnuas_gpu_test_memory_and_reset);
+    qtest_add_func("/cnuasgpu/transport", cnuas_gpu_test_transport);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 84d2fa702a..719bb107ca 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -60,6 +60,7 @@ qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_CNUAS_VNIC') ? ['cnuas-vnic-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_CNUAS_GPU') ? ['cnuasgpu-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
-- 
2.43.0


