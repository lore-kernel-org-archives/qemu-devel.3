Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7611FCF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsD-0006cA-Jj; Tue, 24 Sep 2024 18:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsB-0006Pf-W4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDs9-0001hB-QT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so4451742b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216343; x=1727821143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5zwS1A2D9yWVCHRNx/CAzS+zv5iCw9n6oD8yI8rPLE=;
 b=LhjVLc7AHJ1MBrdGN95P5QawBaqo2V+N58itLzw9RmF1HmNhPjJVI7UiWDE/7/eoVZ
 kc/kB3vyv+H92cGj4AZYPnAMAxw0f3I9Ny2ZbZr+hfUciUT8kq1u4+m2pFD15rm2gluN
 Pa6COMeNsP3ipzVeTsG0DFi2FnYj7nT91fTqOufaM9mYT28tr1vskxFSmBRsP158ZuEV
 16PQ6vAivVznODPZDAYjGgL1bBUYijJIrP6bwylaRqEsiYZFsCTUVSgUFD5m99FFrBpn
 O5RbbPvl9sEbE8TPZFPnltICfuwmoWSBAozxTx+APC9zpEqfAtaPTpmPIYbNnfJXBb3E
 RWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216343; x=1727821143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5zwS1A2D9yWVCHRNx/CAzS+zv5iCw9n6oD8yI8rPLE=;
 b=uhtbxJhBDH6H1Afg66bsnSfH37Jk2pJtdfxHJONXwRaSFA4ycW9Xq8V1emz4M/TqX/
 mDATkDtBgK1nKzmn4tS9P613C+uQBSz84wAjlms+9UEBTy4mtWFY3b3Z9JmOUC8jzsoe
 w9Hn9E33Rz94vJoEju5fNPJ0S4Qp31PSyr6nxBob3Uvi6GXrblmtL4cgiX8xK6K3pIVo
 Qpw2GJbseK4uLI2T3rT9bIgxTswOW0GrfHK+6QeYBm1qeiu867VUEDE3SSEn2PMpcnO2
 mQE4ul1V7bPgSOb/AvdsK7Vgg8d4GhdEB/rOeBkqMcjC31kQNbO9SIeYM6dQcQn1j2rg
 VBgQ==
X-Gm-Message-State: AOJu0Yywesm6DwJCAG23fnCftJiwJ162c3Lj4PtFZyelSx5VV+Wp1YuW
 ErrE8kKjKgojkMA7LZAEsOaZVPKmqWlpzyS976s3Wet6iH76HXxqH28lOA==
X-Google-Smtp-Source: AGHT+IERieXjd0ZQyCyfVx/9B2PUpvb2SUuoZb1KEcDGaUqz8YBjzeJAc5Bv7h0TjmUpDqd32/4Bhg==
X-Received: by 2002:a05:6a00:1989:b0:717:bce8:f8a9 with SMTP id
 d2e1a72fcca58-71b0aaa58d9mr1092982b3a.1.1727216343155; 
 Tue, 24 Sep 2024 15:19:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/47] test/qtest: add riscv-iommu-pci tests
Date: Wed, 25 Sep 2024 08:17:21 +1000
Message-ID: <20240924221751.2688389-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

To test the RISC-V IOMMU emulation we'll use its PCI representation.
Create a new 'riscv-iommu-pci' libqos device that will be present with
CONFIG_RISCV_IOMMU.  This config is only available for RISC-V, so this
device will only be consumed by the RISC-V libqos machine.

Start with basic tests: a PCI sanity check and a reset state register
test. The reset test was taken from the RISC-V IOMMU spec chapter 5.2,
"Reset behavior".

More tests will be added later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240903201633.93182-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/riscv-iommu.h | 71 ++++++++++++++++++++++++
 tests/qtest/libqos/riscv-iommu.c | 76 ++++++++++++++++++++++++++
 tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
 tests/qtest/libqos/meson.build   |  4 ++
 tests/qtest/meson.build          |  1 +
 5 files changed, 245 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/riscv-iommu-test.c

diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
new file mode 100644
index 0000000000..d123efb41f
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -0,0 +1,71 @@
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
+/*
+ * RISC-V IOMMU uses PCI_VENDOR_ID_REDHAT 0x1b36 and
+ * PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014.
+ */
+#define RISCV_IOMMU_PCI_VENDOR_ID       0x1b36
+#define RISCV_IOMMU_PCI_DEVICE_ID       0x0014
+#define RISCV_IOMMU_PCI_DEVICE_CLASS    0x0806
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
diff --git a/tests/qtest/libqos/riscv-iommu.c b/tests/qtest/libqos/riscv-iommu.c
new file mode 100644
index 0000000000..01e3b31c0b
--- /dev/null
+++ b/tests/qtest/libqos/riscv-iommu.c
@@ -0,0 +1,76 @@
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
+        .vendor_id = RISCV_IOMMU_PCI_VENDOR_ID,
+        .device_id = RISCV_IOMMU_PCI_DEVICE_ID,
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
diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-test.c
new file mode 100644
index 0000000000..7f0dbd0211
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
+    g_assert_cmpuint(vendorid, ==, RISCV_IOMMU_PCI_VENDOR_ID);
+    g_assert_cmpuint(deviceid, ==, RISCV_IOMMU_PCI_DEVICE_ID);
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
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 1b2b2dbb22..586fcacdc8 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -68,6 +68,10 @@ if have_virtfs
   libqos_srcs += files('virtio-9p.c', 'virtio-9p-client.c')
 endif
 
+if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
+  libqos_srcs += files('riscv-iommu.c')
+endif
+
 libqos = static_library('qos', libqos_srcs + genh,
                         build_by_default: false)
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 310865e49c..e5a54f342a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -301,6 +301,7 @@ qos_test_ss.add(
   'vmxnet3-test.c',
   'igb-test.c',
   'ufs-test.c',
+  'riscv-iommu-test.c',
 )
 
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
-- 
2.46.1


