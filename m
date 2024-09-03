Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ABCCD37AD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZxg-0005Xy-E1; Tue, 03 Sep 2024 16:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxe-0005Rg-T2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxb-0004RX-9r
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20688fbaeafso15172715ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725394625; x=1725999425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcNnADrDOFPGa04t/j0GIPTKzCKMu/uFSWni0nk1/sQ=;
 b=hQ8RQVts2zkZt5/JcMM/kN5oHejfPlpxIAZf+hB5fYY+PaHQHLjIV1vSQ3VfopsfWa
 b8eeiyniymTSb5MNmJe+RJyCxQeTfJR/7okSMRBMapfQWNZ7v91GEksohYdAzRrcscLj
 myRICIbdhlIbbO6njRo4Nul+GhgGV6jwl6UZf1SseLBcVilwPCatch6Q2Gr1tjfSn8ze
 6SW7Pm2xGuUYcXf24cHCjg8/49EOD8DMHZKL8HiD0U11SJTrGkewP0HKLOz0KM6jt9At
 JSPutkTHbHZ+X9cjGOpvxHpZdC/6qoDjZrj/h35JuSYJZyIrdYrPlF30wwAGivTIj8E0
 5uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394625; x=1725999425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcNnADrDOFPGa04t/j0GIPTKzCKMu/uFSWni0nk1/sQ=;
 b=BvqWNa83UGwkRZM7Fk2gFfns+x+J3SzXyczS6a7wgsiIqCcGO9own3VC5ax93fm+6o
 j5TG4jb5yNv1TyzAm/PUhJo7X043GVI9cR5NUfmyxgewV2/nQ1BJadGLezmgwZDPAru0
 gBQYz1hJ1GNuRuWibt03mSVSCLKn2uhYiw3K5qWryFp+yT0RHx/Ve4Sfn/GMEfgVoAca
 DKS9f/r2DSVWtLB7I4lFVWVPC9QcnxPdQmX96T+iGkUdDhF18Uv87vyVDP8JsZHbsuTO
 ssvAKe+gPxfwpI9USGmuEqqL5K8Eg2zPkJef9kIkmc6DCJBxUmj7cUhEVcIQp7j/TEMW
 SDuA==
X-Gm-Message-State: AOJu0YzzuJ/RSBmz3Pq9skKbBybFkis/yK3hj96LMAROYCKZnp1asNyI
 LXha8jM+1ew4CpkLxoItdw+UzpRHChFugPZOs0hfxh8DyMSlwqediCk95heM4l/14zyU10Czs2P
 Z
X-Google-Smtp-Source: AGHT+IHbzwxsbSnWrc5/PY9s84XPnbCq28zOORiNQ3XSKHjQFLRdpzCv3YStuFoWS5GFQ5dYGUDxnw==
X-Received: by 2002:a17:902:d48a:b0:1fa:2e45:bcb8 with SMTP id
 d9443c01a7336-2058417b1bfmr81977165ad.2.1725394625491; 
 Tue, 03 Sep 2024 13:17:05 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea531b3sm2189745ad.216.2024.09.03.13.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:17:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 07/12] test/qtest: add riscv-iommu-pci tests
Date: Tue,  3 Sep 2024 17:16:26 -0300
Message-ID: <20240903201633.93182-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903201633.93182-1-dbarboza@ventanamicro.com>
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/meson.build   |  4 ++
 tests/qtest/libqos/riscv-iommu.c | 76 ++++++++++++++++++++++++++
 tests/qtest/libqos/riscv-iommu.h | 71 ++++++++++++++++++++++++
 tests/qtest/meson.build          |  1 +
 tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2f0d3ef080..19487dc6b1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,6 +297,7 @@ qos_test_ss.add(
   'vmxnet3-test.c',
   'igb-test.c',
   'ufs-test.c',
+  'riscv-iommu-test.c',
 )
 
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
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
-- 
2.45.2


