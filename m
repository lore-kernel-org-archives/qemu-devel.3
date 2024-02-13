Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEE6C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyII-0001Jy-QG; Tue, 13 Feb 2024 14:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyIH-0001FU-TP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyIC-0001sb-JW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso39254105ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851887; x=1708456687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDQdo/z7qixwruj+m+pHDHKLxphfmdrUK9lzjM6ZoYU=;
 b=jgYL5NWIiQ0GYpqwfELUsXLcukKFji9B6HMlp5oHBVl3HnbImnNR2deFyDL8IVfYt6
 vStx9ANzqV9BW7mLCA/d8H1W9qxGs3sTPwD5Mq5YfImzQp4ijiZMFpBi2OSqPYdoY4m2
 NG+S+dWQxFx46xlUWOO+zK1e0uIK+vvQt4iHcg9dmN28UdJGn0GyCFM/WYV1PVaLJK7b
 I5pBsatXDedma82IZH4G3EikAEpes58HU+7eLYWTqCiLGVpcbMP91HCSq+CTRj3hTfr8
 /xB0RAadEyhHoNWWeR9dDwfOw/gyoPHw7KYDmx9igdEbUeCpK/8j3DkKl4wbUz5isbrV
 9HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851887; x=1708456687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDQdo/z7qixwruj+m+pHDHKLxphfmdrUK9lzjM6ZoYU=;
 b=KKGPjsSdAmv374rNvAIF/36yTlcuDekQxYYgR/yqwsRyB0wJXhzM1xe6Qr4+adxEAU
 BBfhZiP77xSw0DBSDTm8429OL7qFCyqDQUCpEGMfh+MjOnK1CTVHA6H5DX3meYBEc6gs
 P3CbUwpq+vvgBx4inihjMB9vz7rTcxhiOTuDVHfUpAjxXQzlFzhynLNYgUdixr3zeDlj
 zpzRy67bSNOuJNKjSkZRDCySED4WGR5w1tPKLyYeOO///cIQ+LTG7XZn7gxdFBe9tX66
 heAtW01QklUEwaItPX60Dxa24l861neva1cwjTQ91EZOsFVSkM/mu8ixBwQRYlnRPW37
 dfVw==
X-Gm-Message-State: AOJu0YwN1SQVwwxerY7aO8QV9xXfi6FwddupE801j8TYb2a6hSbeJI1D
 keJbKGEOmUgyFM7gjAeLBJ5ZX0B+haCoQO2qhXhBy28hdTNG3Ac+h+jThtt6rnsSq45hSzT6WfO
 /
X-Google-Smtp-Source: AGHT+IHYRCCOb7XqFBsh1ivLJ0MPaXZBIW+jW3Ed5CaM0tSOcZ8K3QSM1UhuXLeUmz2vCbq2pQW82A==
X-Received: by 2002:a17:903:245:b0:1d9:b749:d279 with SMTP id
 j5-20020a170903024500b001d9b749d279mr510370plh.50.1707851886727; 
 Tue, 13 Feb 2024 11:18:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUonsB6lW7KbNlfEkehhzsDTW9YSQYy4ENcv25xh96LlNMY6JKY1CLkZMlwg/drI+dKCOed7mJ4jzxi3TXXSp1rlXjJ3mqm7wtWb8lis4JjTigePxHT8NEJZJ522Cm6C1opVXipnzrn9nNSlXZjLeXJCDriXCcmtq4KJXlPaGHiKXkm7wHPd8rcQW94x1rcbensC+S9ODMMwJCrmr7wAGLu9XRvkJ99wqKXSZKlJ3FdOdseGsBOHCwSXS4aQy/uHmDH3lZCC7SqCEUgxXKhMlw/OKyPVVmjjZjn3s0ugbeUcBQKeTFPPfoTuuuvKlZbhTeg2oZ+ZjEYefQRGo62TvWNjSRbBzX/h2IVlQl6+/rLORkSR5bZuXs/gxXPecC48VQcMXEfUfILmt37
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:18:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 6/6] tests/libqos: add riscv/virt machine nodes
Date: Tue, 13 Feb 2024 16:17:36 -0300
Message-ID: <20240213191736.733334-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add a RISC-V 'virt' machine to the graph. This implementation is a
modified copy of the existing arm machine in arm-virt-machine.c

It contains a virtio-mmio and a generic-pcihost controller. The
generic-pcihost controller hardcodes assumptions from the ARM 'virt'
machine, like ecam and pio_base addresses, so we'll add an extra step to
set its parameters after creating it.

Our command line is incremented with 'aclint' parameters to allow the
machine to run MSI tests.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/libqos/meson.build          |   1 +
 tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

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
-- 
2.43.0


