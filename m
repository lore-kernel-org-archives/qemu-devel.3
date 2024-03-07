Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC613C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGDy-0005KL-MP; Thu, 07 Mar 2024 11:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDs-0005Dg-4I
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:57 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDq-0006Ey-1F
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:55 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso807091a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827432; x=1710432232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLo75RFNZf+AAEHs9/Y6byV6ou2OhX+ofhVXr0PVmoc=;
 b=ew3FZniBsA4fsOwhDNNWMQxt8rHpYvKXTD53vy9fCJ/d3tuszkN6cFV+WObzA0icaH
 xcXx4enTSzLxJf99dFZl5paEHh/N9BAvKc412lOEprEJj2MMik16lGON4mESceALLNDN
 YUzXog27mNMa0AC3TZkejswBn9teIu6F2AzXz2fpgmRllILFdnQ7JFr+4gPmgZfgCni3
 quwAjQVZtfvwJPf4iUz5LdP9eNbSmdeGxAR+E745w/ptrfN0xKAE7zHYXwJLIcfj1PqF
 Jd/oBdGwW5katY6T3nlwJHAQ+HAOrUDTUhvoGkN8qkPzvYDGEWyd8E2d24m0V3+28TBf
 l3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827432; x=1710432232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLo75RFNZf+AAEHs9/Y6byV6ou2OhX+ofhVXr0PVmoc=;
 b=HRdoMtvPiaZc99Btk4Xiz/1dkCz+qWO9bgz4yqj9fQxTloQPhO/pGEY7fT9dK8DtNi
 8GU40rGWePETSzUR+nexsOwCGQglMOmBaYk4+Dd/LnT2cfbU62N9OnzaxIN4jnG+mDCW
 2qpwDmm4ozP1fMC1lSTSnc/wkkfjoWZDgTJiTVni9vvryGvpY7DWpUofPmejpKHrPXjP
 bske4XlHvC9q7/vCYKRwdrolt3KdriaPO/XgKXlPMJ2Jlr5Fhq4gOCSyCDJX6A3npve0
 erEMlpwADwPnM5nT0GVFHym6a1WNRmJWzLifqXy55eMUTOx1YBFLGr8V8FByiV6qcb0Q
 JSVw==
X-Gm-Message-State: AOJu0YyycKdNLqy03cqJW3IWvCqzgDPWddEUZzbNtD8hL8tBWcUxQnXC
 jegCKRkuQbVCJ33fcSI/Od8dPTY3c4hdVeBPtC9YhO1JdcMcxNCB80/p9AMYclWwWBy4LaH2byc
 4
X-Google-Smtp-Source: AGHT+IFZmqtYkWjeFnBiNWz/D9wjVsqnr5u7r0z954JMR79a+c79TUUOSy6xgBsAiGCtM/ZPFdKC+A==
X-Received: by 2002:a17:902:720c:b0:1dc:cf38:3a77 with SMTP id
 ba12-20020a170902720c00b001dccf383a77mr7311805plb.55.1709827431741; 
 Thu, 07 Mar 2024 08:03:51 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:03:51 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/15] test/qtest: add riscv-iommu-pci tests
Date: Thu,  7 Mar 2024 13:03:10 -0300
Message-ID: <20240307160319.675044-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To test the RISC-V IOMMU emulation we'll use its PCI representation.
Create a new 'riscv-iommu-pci' libqos device that will be present with
CONFIG_RISCV_IOMMU.  This config is only available for RISC-V, so this
device will only be consumed by the RISC-V libqos machine.

Start with basic tests: a PCI sanity check and a reset state register
test. The reset test was taken from the RISC-V IOMMU spec chapter 5.2,
"Reset behavior".

More tests will be added later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/libqos/meson.build   |  4 ++
 tests/qtest/libqos/riscv-iommu.c | 79 +++++++++++++++++++++++++++
 tests/qtest/libqos/riscv-iommu.h | 67 +++++++++++++++++++++++
 tests/qtest/meson.build          |  1 +
 tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
 5 files changed, 244 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 3aed6efcb8..07fe20eacb 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -67,6 +67,10 @@ if have_virtfs
   libqos_srcs += files('virtio-9p.c', 'virtio-9p-client.c')
 endif
 
+if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
+  libqos_srcs += files('riscv-iommu.c')
+endif
+
 libqos = static_library('qos', libqos_srcs + genh,
                         name_suffix: 'fa',
                         build_by_default: false)
diff --git a/tests/qtest/libqos/riscv-iommu.c b/tests/qtest/libqos/riscv-iommu.c
new file mode 100644
index 0000000000..8ae7d4888c
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.c
@@ -0,0 +1,79 @@
+/*
+ * libqos driver riscv-iommu-pci framework
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "qgraph.h"
+#include "pci.h"
+#include "riscv-iommu.h"
+
+#define PCI_VENDOR_ID_RIVOS           0x1efd
+#define PCI_DEVICE_ID_RIVOS_IOMMU     0xedf1
+
+static void *riscv_iommu_pci_get_driver(void *obj, const char *interface)
+{
+    QRISCVIOMMU *r_iommu_pci = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &r_iommu_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in riscv_iommu_pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void riscv_iommu_pci_start_hw(QOSGraphObject *obj)
+{
+    QRISCVIOMMU *pci = (QRISCVIOMMU *)obj;
+    qpci_device_enable(&pci->dev);
+}
+
+static void riscv_iommu_pci_destructor(QOSGraphObject *obj)
+{
+    QRISCVIOMMU *pci = (QRISCVIOMMU *)obj;
+    qpci_iounmap(&pci->dev, pci->reg_bar);
+}
+
+static void *riscv_iommu_pci_create(void *pci_bus, QGuestAllocator *alloc,
+                                    void *addr)
+{
+    QRISCVIOMMU *r_iommu_pci = g_new0(QRISCVIOMMU, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&r_iommu_pci->dev, bus, addr);
+    r_iommu_pci->reg_bar = qpci_iomap(&r_iommu_pci->dev, 0, NULL);
+
+    r_iommu_pci->obj.get_driver = riscv_iommu_pci_get_driver;
+    r_iommu_pci->obj.start_hw = riscv_iommu_pci_start_hw;
+    r_iommu_pci->obj.destructor = riscv_iommu_pci_destructor;
+    return &r_iommu_pci->obj;
+}
+
+static void riscv_iommu_pci_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .vendor_id = PCI_VENDOR_ID_RIVOS,
+        .device_id = PCI_DEVICE_ID_RIVOS_IOMMU,
+        .devfn = QPCI_DEVFN(1, 0),
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=01.0",
+    };
+
+    add_qpci_address(&opts, &addr);
+
+    qos_node_create_driver("riscv-iommu-pci", riscv_iommu_pci_create);
+    qos_node_produces("riscv-iommu-pci", "pci-device");
+    qos_node_consumes("riscv-iommu-pci", "pci-bus", &opts);
+}
+
+libqos_init(riscv_iommu_pci_register_nodes);
diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
new file mode 100644
index 0000000000..8c056caa7b
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -0,0 +1,67 @@
+/*
+ * libqos driver riscv-iommu-pci framework
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef TESTS_LIBQOS_RISCV_IOMMU_H
+#define TESTS_LIBQOS_RISCV_IOMMU_H
+
+#include "qgraph.h"
+#include "pci.h"
+#include "qemu/bitops.h"
+
+#ifndef GENMASK_ULL
+#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
+#endif
+
+#define RISCV_IOMMU_PCI_VENDOR_ID_RIVOS  0x1efd
+#define RISCV_IOMMU_PCI_DEVICE_ID_RIVOS  0xedf1
+#define RISCV_IOMMU_PCI_DEVICE_CLASS     0x0806
+
+/* Common field positions */
+#define RISCV_IOMMU_QUEUE_ENABLE        BIT(0)
+#define RISCV_IOMMU_QUEUE_INTR_ENABLE   BIT(1)
+#define RISCV_IOMMU_QUEUE_MEM_FAULT     BIT(8)
+#define RISCV_IOMMU_QUEUE_ACTIVE        BIT(16)
+#define RISCV_IOMMU_QUEUE_BUSY          BIT(17)
+
+#define RISCV_IOMMU_REG_CAP             0x0000
+#define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
+
+#define RISCV_IOMMU_REG_DDTP            0x0010
+#define RISCV_IOMMU_DDTP_BUSY           BIT_ULL(4)
+#define RISCV_IOMMU_DDTP_MODE           GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_DDTP_MODE_OFF       0
+
+#define RISCV_IOMMU_REG_CQCSR           0x0048
+#define RISCV_IOMMU_CQCSR_CQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_CQCSR_CIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_CQCSR_CQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_CQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_FQCSR           0x004C
+#define RISCV_IOMMU_FQCSR_FQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_FQCSR_FIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_FQCSR_FQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_FQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_PQCSR           0x0050
+#define RISCV_IOMMU_PQCSR_PQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_PQCSR_PIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_PQCSR_PQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_PQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+#define RISCV_IOMMU_REG_IPSR            0x0054
+
+typedef struct QRISCVIOMMU {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+    QPCIBar reg_bar;
+} QRISCVIOMMU;
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 31b9f4ede4..aeb7346840 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -285,6 +285,7 @@ qos_test_ss.add(
   'vmxnet3-test.c',
   'igb-test.c',
   'ufs-test.c',
+  'riscv-iommu-test.c',
 )
 
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-test.c
new file mode 100644
index 0000000000..13b887d15e
--- /dev/null
+++ b/tests/qtest/riscv-iommu-test.c
@@ -0,0 +1,93 @@
+/*
+ * QTest testcase for RISC-V IOMMU
+ *
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/riscv-iommu.h"
+#include "hw/pci/pci_regs.h"
+
+static uint32_t riscv_iommu_read_reg32(QRISCVIOMMU *r_iommu, int reg_offset)
+{
+    uint32_t reg;
+
+    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                 &reg, sizeof(reg));
+    return reg;
+}
+
+static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_offset)
+{
+    uint64_t reg;
+
+    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                 &reg, sizeof(reg));
+    return reg;
+}
+
+static void test_pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    QPCIDevice *dev = &r_iommu->dev;
+    uint16_t vendorid, deviceid, classid;
+
+    vendorid = qpci_config_readw(dev, PCI_VENDOR_ID);
+    deviceid = qpci_config_readw(dev, PCI_DEVICE_ID);
+    classid = qpci_config_readw(dev, PCI_CLASS_DEVICE);
+
+    g_assert_cmpuint(vendorid, ==, RISCV_IOMMU_PCI_VENDOR_ID_RIVOS);
+    g_assert_cmpuint(deviceid, ==, RISCV_IOMMU_PCI_DEVICE_ID_RIVOS);
+    g_assert_cmpuint(classid, ==, RISCV_IOMMU_PCI_DEVICE_CLASS);
+}
+
+static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    uint64_t cap;
+    uint32_t reg;
+
+    cap = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(cap & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQEN, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PIE, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQON, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_BUSY, ==, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_DDTP);
+    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_BUSY, ==, 0);
+    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_MODE, ==,
+                     RISCV_IOMMU_DDTP_MODE_OFF);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IPSR);
+    g_assert_cmpuint(reg, ==, 0);
+}
+
+static void register_riscv_iommu_test(void)
+{
+    qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL);
+    qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
+}
+
+libqos_init(register_riscv_iommu_test);
-- 
2.43.2


