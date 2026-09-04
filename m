Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976CC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMk-0007z4-Cm; Fri, 04 Sep 2026 01:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMY-0007QN-1J
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMW-0001RO-0V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so622754b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499273; x=1789104073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+j2ecGCmrnqWtWWsdCY5AfqDPciFgKTobOlczEqJbYI=;
 b=hBppXvYNUGU+LBF8dx85FZCHG2NDTddRiP42Oeq1htI1IvH6ZQhpG4Xkd9f6x+LtdR
 NcoD6YeTi2D0OPsNFDZ/3mLpWpEfdnzRPEZJtEz6WOoY3mh0t0hEUdbqEn3uVzPX8+Lk
 InMM6cAeR8cMELUba+rjo8AmFPf3eHl5T2EnFlyhbgsee1cRGkytpccKh0G6qT2IEJkA
 syR68DjKjhXN80nKypkGOd3Ptcs6gQTwSD5f685NAV7HQhzqYtZodFpN7Ei0ZWF5stIN
 i/8+4ZLJHe+Bo1s459LNlKvh3eBc7lE3MOXdK7tG5MgoqncfyKuT6NWhQN4idLX6pE7S
 PUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499273; x=1789104073;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+j2ecGCmrnqWtWWsdCY5AfqDPciFgKTobOlczEqJbYI=;
 b=sRcXvg3/+P0FxYMNZL2Lhad8ZYj7DfOXf67wcdjD99ptpWxWDtp3oDuoUkDX2Yg9oY
 21dZgAFOejiiYNC2hlbzhV1uO8DTHWTnM+CZpqqeoU/aIevKr8bdSPZfGI9N4wtB6UqJ
 GLR528S9TJEVrIt3aVY8vvKFcqHmhNugV3wfO7VQV3gQXbAFkpn9qq20/3id93tErK0L
 sVDllXgCBc/DEbLoDTfXvcytma3QO1uRLvKOOuRWw7j9/NPnEg4Yr3uKz9L26M5zpUPi
 ZhsVGyr1z9xPX+5Mi+5SchX5+z1Pzh+EP1Wa42b7kJ14FUrb3lym8dDh+d/HP4iTg5Hz
 B/cQ==
X-Gm-Message-State: AFuF++kRPa4Cm0fhin9/i1PPIUzpeuS/QgytzIkkT0SGpJsQVbTtJTaG
 qgyw8Dng4M9o4eLlVB2oTJJdbBExh3GCZqB7PizJL2r10CaFWv6Q/p/Q/pbewA==
X-Gm-Gg: AYBFou0172Do8dQkYokusfzgnpULY+xK5wNg+MSZdtEsRgzEGofoYQKHn5JxLTaUbSc
 lDaoZuw3IgxBW36ig6fqsxpFNmS0m4w4mdN/ltuEmop+MeGpTRcNfyMKvgW6QdVkbQPp7EjYXbs
 KQCLhErrRrYezbFV9LEf0SYEJiEDSFUNVYDiu1cJcJ2N5nihAtAekGiewdUoe0hDI4ysXwInlZ7
 AhHv4MuHEnVeV8QGvepq3yAbUCAo9GAv/vOOiyJU1EEW7wZIGf+RxKjYOYdErI8PKtNygymo39b
 DVRiiIm6ZuMNEtqKxBJjEpIuctfWRELfeii5xD55FJV2U2CUYrQlyP9MCToPmrkEx1HnaPl6E4z
 ULiAR6yNdOnjGNX9dvrQfOSI6MSt+V8c2R/23JFKVxUwU3AkcXaT1YNmCXLxRPZcuRXfW1nRI8z
 aenq6er5ZilGd86QuRUr8KXn0adQDtLTioYIG2vXbT42EZBkV8dSBkn7tzxbqC17OM3NfYuy3Pl
 zMXyw==
X-Received: by 2002:a05:6a00:3020:b0:85f:d76c:e23e with SMTP id
 d2e1a72fcca58-86169676529mr5261777b3a.23.1788499273305; 
 Thu, 03 Sep 2026 22:21:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 25/47] hw/riscv/device-common,
 virt.c: add riscv_create_platform_bus()
Date: Fri,  4 Sep 2026 15:19:21 +1000
Message-ID: <20260904051943.799041-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

There will be code repetition instances added by the 'riscv-server-ref'
board w.r.t device creation and initialization.  Instead of waiting for
that code to land we're adding helpers beforehand.  The idea is to make
the new board code shorter and more palatable for reviewers.

A new 'device-common' file is created for such helpers.  We'll start
with the platform bus, a nice piece of software that only the 'virt'
board uses so far, and the 'riscv-server-ref' will use to support TPM
devices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-13-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/device-common.h | 19 +++++++++++++
 hw/riscv/device-common.c         | 48 ++++++++++++++++++++++++++++++++
 hw/riscv/virt.c                  | 30 +++-----------------
 hw/riscv/meson.build             |  1 +
 4 files changed, 72 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/riscv/device-common.h
 create mode 100644 hw/riscv/device-common.c

diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
new file mode 100644
index 0000000000..12af031bbf
--- /dev/null
+++ b/include/hw/riscv/device-common.h
@@ -0,0 +1,19 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_DEVICE_COMMON_H
+#define RISCV_DEVICE_COMMON_H
+
+#include "exec/hwaddr.h"
+#include "hw/core/qdev.h"
+
+DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
+                                       const MemMapEntry *platform_bus_mem,
+                                       int platform_bus_base_irq,
+                                       int platform_bus_num_irqs);
+#endif
diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
new file mode 100644
index 0000000000..d3c68a9e71
--- /dev/null
+++ b/hw/riscv/device-common.c
@@ -0,0 +1,48 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/riscv/device-common.h"
+
+#include "hw/core/platform-bus.h"
+#include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+
+
+DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
+                                       const MemMapEntry *platform_bus_mem,
+                                       int platform_bus_base_irq,
+                                       int platform_bus_num_irqs)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    DeviceState *dev;
+    SysBusDevice *sysbus;
+
+    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
+    qdev_prop_set_uint32(dev, "num_irqs", platform_bus_num_irqs);
+    qdev_prop_set_uint32(dev, "mmio_size", platform_bus_mem->size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    for (int i = 0; i < platform_bus_num_irqs; i++) {
+        int irq = platform_bus_base_irq + i;
+        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
+    }
+
+    memory_region_add_subregion(sysmem,
+                                platform_bus_mem->base,
+                                sysbus_mmio_get_region(sysbus, 0));
+
+    return dev;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3a9d1e0a13..64f75646d0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -35,6 +35,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/device-common.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
@@ -682,31 +683,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
              memmap[VIRT_PLIC].size);
 }
 
-static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
-{
-    DeviceState *dev;
-    SysBusDevice *sysbus;
-    int i;
-    MemoryRegion *sysmem = get_system_memory();
-
-    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
-    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
-    qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    s->platform_bus_dev = dev;
-
-    sysbus = SYS_BUS_DEVICE(dev);
-    for (i = 0; i < VIRT_PLATFORM_BUS_NUM_IRQS; i++) {
-        int irq = VIRT_PLATFORM_BUS_IRQ + i;
-        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
-    }
-
-    memory_region_add_subregion(sysmem,
-                                s->memmap[VIRT_PLATFORM_BUS].base,
-                                sysbus_mmio_get_region(sysbus, 0));
-}
-
 static void virt_build_smbios(RISCVVirtState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
@@ -1029,7 +1005,9 @@ static void virt_machine_init(MachineState *machine)
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
 
-    create_platform_bus(s, mmio_irqchip);
+    s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
+        &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
+        VIRT_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 0d82ceacc4..7aa3c1578d 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,6 +1,7 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('aia.c'))
 riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
-- 
2.55.0


