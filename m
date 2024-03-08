Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44035C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA7-0007Bp-Cm; Fri, 08 Mar 2024 06:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA4-00077B-5h
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:12 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA2-0001fp-4G
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:11 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dcc7f4717fso5839425ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896388; x=1710501188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rgNUI5qPK5WcXwsLVaiLvwCeS/y8bX/ZdTXMiRvkWE=;
 b=AVtnGA778R0li0pSnW5MGKc42ZDzV9EtYXftpcZDlwIsbxgJ7RAYQO7f7qP7nSSxDO
 ZOPzbrpHOCAo50NLz4HUFidtULaLMQ0zHsCxtLk5SMxzWlB85mGGztLPL1WKZvZtFDA3
 kK35HYRmqFLAStkdOw4hXJItrIgsgQ4U9815Rg69asXmw98tooXZ+4b3AE+jUw7v3oH0
 g5r7wDqHcGj6Y0If1Ypoxj2DHtGaNrC8hCrFbxG3ry55WZKr2hc93C/cCXJsXxOJ6Sop
 +/s6hvd2sUbTtVIK4+in/ZXe7qo5anDYNWVW7gfEaBFDUF1OMIW4RSJsGcxiaSq4xecZ
 52DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896388; x=1710501188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rgNUI5qPK5WcXwsLVaiLvwCeS/y8bX/ZdTXMiRvkWE=;
 b=f6bq0FgTQEKzghWz2+g+5MzNjF5+m2ChpoAC/uFOdsYyePTKvWiAvHku4S8THC3jKN
 pDnr7dYro9o5pzPtaKkKOyiM4GOlIeO2+x/nAd1CL4FYLJ6olqlMCwppPUZ1nLuAtaFn
 qKPNjnfb7m+hmq0ZT1orvCrT1NTlGR15M5ZD0fVVmP5kwOVWfym5gROl8KE8mqTzmgum
 ZKgImIAjqaL93sKooSTbVzTcF/z0U6kyL5cDRK+eIbPEtA2XUmKTPTJKItQQ7W6S8Xa1
 mgWuJ2ulZeGRMJcld7I+jy6cq+PJ+DYaj3mWxee7ZtgAkOcJCWjQFIJdON4/Mdaxq1JB
 3JpA==
X-Gm-Message-State: AOJu0YzAX8Pm/MLR3npYKtfFYXzD8jCeheD7G/VW60Q/mieaTTczwbDc
 y47fRlW1BOSeebyoLnwIH2nxjw3SfnB/4hi8Pi7UCYD/xSPd3v5mVRNxlnGpHU7Rbg==
X-Google-Smtp-Source: AGHT+IFgUNxYsB+Zl4dv6bt/VrL0As0Gqhlkc2SLHKDIyvRliPAqsP7J9zYY1W4QszH3p2EMbSwwQg==
X-Received: by 2002:a17:902:cf0d:b0:1dd:6414:3c5d with SMTP id
 i13-20020a170902cf0d00b001dd64143c5dmr2881004plg.7.1709896388438; 
 Fri, 08 Mar 2024 03:13:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 20/34] tests/libqos: add riscv/virt machine nodes
Date: Fri,  8 Mar 2024 21:11:38 +1000
Message-ID: <20240308111152.2856137-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a RISC-V 'virt' machine to the graph. This implementation is a
modified copy of the existing arm machine in arm-virt-machine.c

It contains a virtio-mmio and a generic-pcihost controller. The
generic-pcihost controller hardcodes assumptions from the ARM 'virt'
machine, like ecam and pio_base addresses, so we'll add an extra step to
set its parameters after creating it.

Our command line is incremented with 'aclint' parameters to allow the
machine to run MSI tests.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240217192607.32565-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
 tests/qtest/libqos/meson.build          |   1 +
 2 files changed, 138 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

diff --git a/tests/qtest/libqos/riscv-virt-machine.c b/tests/qtest/libqos/riscv-virt-machine.c
new file mode 100644
index 0000000000..c4364c9c5d
--- /dev/null
+++ b/tests/qtest/libqos/riscv-virt-machine.c
@@ -0,0 +1,137 @@
+/*
+ * libqos driver framework for risc-v
+ *
+ * Initial version based on arm-virt-machine.c
+ *
+ * Copyright (c) 2024 Ventana Micro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "libqos-malloc.h"
+#include "qgraph.h"
+#include "virtio-mmio.h"
+#include "generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+
+#define RISCV_PAGE_SIZE            4096
+
+/* VIRT_DRAM */
+#define RISCV_VIRT_RAM_ADDR        0x80000000
+#define RISCV_VIRT_RAM_SIZE        0x20000000
+
+/*
+ * VIRT_VIRTIO. BASE_ADDR  points to the last
+ * virtio_mmio device.
+ */
+#define VIRTIO_MMIO_BASE_ADDR      0x10008000
+#define VIRTIO_MMIO_SIZE           0x00001000
+
+/* VIRT_PCIE_PIO  */
+#define RISCV_GPEX_PIO_BASE        0x3000000
+#define RISCV_BUS_PIO_LIMIT        0x10000
+
+/* VIRT_PCIE_MMIO */
+#define RISCV_BUS_MMIO_ALLOC_PTR   0x40000000
+#define RISCV_BUS_MMIO_LIMIT       0x80000000
+
+/* VIRT_PCIE_ECAM */
+#define RISCV_ECAM_ALLOC_PTR   0x30000000
+
+typedef struct QVirtMachine QVirtMachine;
+
+struct QVirtMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QVirtioMMIODevice virtio_mmio;
+    QGenericPCIHost bridge;
+};
+
+static void virt_destructor(QOSGraphObject *obj)
+{
+    QVirtMachine *machine = (QVirtMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *virt_get_driver(void *object, const char *interface)
+{
+    QVirtMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in riscv/virtio\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *virt_get_device(void *obj, const char *device)
+{
+    QVirtMachine *machine = obj;
+    if (!g_strcmp0(device, "generic-pcihost")) {
+        return &machine->bridge.obj;
+    } else if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    fprintf(stderr, "%s not present in riscv/virt\n", device);
+    g_assert_not_reached();
+}
+
+static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
+{
+    qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
+    qpci->bus.pio_limit = RISCV_BUS_PIO_LIMIT;
+
+    qpci->bus.mmio_alloc_ptr = RISCV_BUS_MMIO_ALLOC_PTR;
+    qpci->bus.mmio_limit = RISCV_BUS_MMIO_LIMIT;
+
+    qpci->ecam_alloc_ptr = RISCV_ECAM_ALLOC_PTR;
+}
+
+static void *qos_create_machine_riscv_virt(QTestState *qts)
+{
+    QVirtMachine *machine = g_new0(QVirtMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               RISCV_VIRT_RAM_ADDR,
+               RISCV_VIRT_RAM_ADDR + RISCV_VIRT_RAM_SIZE,
+               RISCV_PAGE_SIZE);
+    qvirtio_mmio_init_device(&machine->virtio_mmio, qts, VIRTIO_MMIO_BASE_ADDR,
+                              VIRTIO_MMIO_SIZE);
+
+    qos_create_generic_pcihost(&machine->bridge, qts, &machine->alloc);
+    riscv_config_qpci_bus(&machine->bridge.pci);
+
+    machine->obj.get_device = virt_get_device;
+    machine->obj.get_driver = virt_get_driver;
+    machine->obj.destructor = virt_destructor;
+    return machine;
+}
+
+static void virt_machine_register_nodes(void)
+{
+    qos_node_create_machine_args("riscv32/virt", qos_create_machine_riscv_virt,
+                                 "aclint=on,aia=aplic-imsic");
+    qos_node_contains("riscv32/virt", "virtio-mmio", NULL);
+    qos_node_contains("riscv32/virt", "generic-pcihost", NULL);
+
+    qos_node_create_machine_args("riscv64/virt", qos_create_machine_riscv_virt,
+                                 "aclint=on,aia=aplic-imsic");
+    qos_node_contains("riscv64/virt", "virtio-mmio", NULL);
+    qos_node_contains("riscv64/virt", "generic-pcihost", NULL);
+}
+
+libqos_init(virt_machine_register_nodes);
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 90aae42a22..3aed6efcb8 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -60,6 +60,7 @@ libqos_srcs = files(
         'arm-xilinx-zynq-a9-machine.c',
         'ppc64_pseries-machine.c',
         'x86_64_pc-machine.c',
+        'riscv-virt-machine.c',
 )
 
 if have_virtfs
-- 
2.44.0


