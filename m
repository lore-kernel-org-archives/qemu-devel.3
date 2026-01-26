Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387C0D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQdA-0001fO-1V; Mon, 26 Jan 2026 12:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcs-0001RG-Sr
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcq-00009a-SN
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:46 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso25343765e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449423; x=1770054223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJSsgywQO/rHQ4WoDlmS1OtrkxPJkG9kKCFHbCDdYFU=;
 b=JdicvjEeXkLTOLt80rTcO/X343dVA8IGjHa10nTKkwXsVT4aXiuNsfJ3cy8Uut7ajz
 po7GMT/00z2kmZxgdtTW+Mu60LoeJI8H4XISoEhBOEbLOGMg8IXmRIY4464jcMk9lN4F
 7aW4C2j6+DxZRhhZg1hQp1EtP+O8rev1q51N/YUGLdJgNsS0PlCU3d4gSDTn59bkTj9D
 7SHDef/TEt7OKragI5vKF6ZhokdzoolP43fHxe7St6jaTP+geFRPmyKX2U+4zM3yNA1K
 jsFXycoW+g141cl1GB1Ih7X8v3hDMBzSwrJnL0RUd27ZmRaffuIs6QM0RZcVyGbIAnwG
 TyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449423; x=1770054223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJSsgywQO/rHQ4WoDlmS1OtrkxPJkG9kKCFHbCDdYFU=;
 b=lDgKlJMSgHRrhv0Au6yvo9gMyBwL3f4IRVh2Yi3JKUHXR1CQT2eCkZdjSp1Zfg1T/t
 ux3VTms3Qsswk0MWVj1RxNb4WR53W0v8dHb8Epppu2U3BQQTPrZFSWhbt+qAM02Vpcih
 K8/H8iKva0ozPuwyewPN7wAOjHb0wev/buX3k9Q1HgoLHV6ycw/1QGVevFjdJgZnqaWe
 lPAkG2zjJIzCcrMT5wd0Q/+okldGa1t3WxW3wxv5rhiD90XI+jbMe3YzkW2esT3Nu9pf
 sc19+4nIgOE6GlLApyD8yQorXq25JQQOw6tsHozsi+No+4uNCBBhZh5pNQeIjjkwSh5w
 5kkw==
X-Gm-Message-State: AOJu0Yw1rOC7YQYIgtzU29pH1KZVm8wkajR2VzlY+ZjtDcmM1prmP/oL
 yE6GOToF90GkYrCarqVjDUBbhIa1KI+F/ERG/mCfNa47uSFS65tXn8pKV/wdqD78
X-Gm-Gg: AZuq6aJQxTAACOVyAyK4bWm9L0xok4q6534FlMczfDiJ+ZPE+1rrY0wVx8fuxC2m2eW
 s+KPp99ABVnf51mjKLqPVoc0DGFxoP02qrFGg1w5kkTI64QNyyesNhXywB/NDvlQ3G+ErOuplgk
 bCD+pYptZgpm2KFQpvdXNWRJtEdHWGD4Sl2sSyh6mGtnL1razqu/WeD/U6mDkE+v9Rc31Cisyz2
 E1bsj5bjmri+ZeLO7+FXk3UB1OAyBcgnbIerxdBf0THQqMAqjnZ62Nhmi5nBr/y9r//tXtvdbxU
 mbcPAbum9UDiP6Tv4ZZmBFTJtGIpQCMMzHb0rBD4xO7Em12rD8PUijTXg+BHvn2O5qpaBlxc4zO
 j7O4JPG1xF9Gd+tqNv2k/rtG0NcP4ju1TGeDuSnmdoelD4Rfd4ulwnoSCT7eyFl+REztr2PaMH+
 tQxYUYHzf5ceRyJnS4b8BLGFzq8KxYz/qQR28ToR1debskT7gbCG6UPTEMWrRTv28S
X-Received: by 2002:a05:600c:6217:b0:480:46c6:bf4b with SMTP id
 5b1f17b1804b1-4805ce3f9d2mr80383655e9.5.1769449422934; 
 Mon, 26 Jan 2026 09:43:42 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:42 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 19/27] hw/arm: add generic ARM machine initialized by FDT
Date: Mon, 26 Jan 2026 18:43:05 +0100
Message-ID: <20260126174313.1418150-20-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch introduces new ARM machine model, which is
fully instantiated from a Device Tree description.

This model uses fdt_generic framework to dynamically
construct system topology based on provided DTB, instead
of standard machines which rely on hardcoded models in
C files.

This allows to contruct machines with custom memory maps,
device structures without the need to modify and re-build
QEMU sources each time.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/arm_generic_fdt.c | 166 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   2 +
 2 files changed, 168 insertions(+)
 create mode 100644 hw/arm/arm_generic_fdt.c

diff --git a/hw/arm/arm_generic_fdt.c b/hw/arm/arm_generic_fdt.c
new file mode 100644
index 0000000000..d3912745c7
--- /dev/null
+++ b/hw/arm/arm_generic_fdt.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Xilinx. Inc
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.crosthwaite@xilinx.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/core/boards.h"
+#include "hw/core/loader.h"
+#include "hw/core/hw-error.h"
+#include "qapi/error.h"
+#include "hw/block/flash.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+
+#include <libfdt.h>
+#include "hw/core/fdt_generic_util.h"
+
+#define GENERAL_MACHINE_NAME "arm-generic-fdt"
+
+#define QTEST_RUNNING (qtest_enabled() && qtest_driver())
+
+#define SMP_BOOT_ADDR 0xfffffff0
+/* Meaningless, but keeps arm boot happy */
+#define SMP_BOOTREG_ADDR 0xfffffffc
+
+static struct arm_boot_info arm_generic_fdt_binfo = {};
+
+typedef struct {
+    ram_addr_t ram_kernel_base;
+    ram_addr_t ram_kernel_size;
+} memory_info;
+
+static memory_info init_memory(void *fdt, ram_addr_t ram_size)
+{
+    FDTMachineInfo *fdti;
+    char node_path[DT_PATH_LENGTH];
+    MemoryRegion *mem_area;
+    memory_info kernel_info;
+    Error *errp = NULL;
+
+    /* Find a memory node or add new one if needed */
+    while (qemu_devtree_get_node_by_name(fdt, node_path, "memory")) {
+        qemu_fdt_add_subnode(fdt, "/memory@0");
+        qemu_fdt_setprop_cells(fdt, "/memory@0", "reg", 0, ram_size);
+    }
+
+    if (!qemu_fdt_getprop(fdt, "/memory", "compatible", NULL, 0, NULL)) {
+        qemu_fdt_setprop_string(fdt, "/memory", "compatible",
+                                "qemu:memory-region");
+        qemu_fdt_setprop_cells(fdt, "/memory", "qemu,ram", 1);
+    }
+
+    /* Instantiate peripherals from the FDT.  */
+    fdti = fdt_generic_create_machine(fdt, NULL);
+
+    mem_area = MEMORY_REGION(object_resolve_path(node_path, NULL));
+
+    /*
+     * Look for the optional kernel-base prop. If not found fallback to
+     * start of memory.
+     */
+    kernel_info.ram_kernel_base = qemu_fdt_getprop_sized_cell(fdt, "/",
+                                              "kernel-base", 0, 2, &errp);
+    if (errp) {
+        kernel_info.ram_kernel_base = object_property_get_int(OBJECT(mem_area),
+                                                              "addr", NULL);
+    }
+
+    kernel_info.ram_kernel_size = object_property_get_int(OBJECT(mem_area),
+                                                          "size", NULL);
+
+    if (kernel_info.ram_kernel_size == -1) {
+        kernel_info.ram_kernel_size = ram_size;
+    }
+
+    fdt_init_destroy_fdti(fdti);
+
+    return kernel_info;
+}
+
+static void arm_generic_fdt_init(MachineState *machine)
+{
+    void *fdt = NULL, *sw_fdt = NULL;
+    int fdt_size, sw_fdt_size;
+    const char *dtb_arg, *hw_dtb_arg;
+    memory_info kernel_info;
+
+    dtb_arg = machine->dtb;
+    hw_dtb_arg = machine->hw_dtb;
+    if (!dtb_arg && !hw_dtb_arg) {
+        if (!QTEST_RUNNING) {
+            /*
+             * Just return without error if running qtest, as we never have a
+             * device tree
+             */
+            hw_error("DTB must be specified for %s machine model\n",
+                     MACHINE_GET_CLASS(machine)->name);
+        }
+        return;
+    }
+
+    /* Software dtb is always the -dtb arg */
+    if (dtb_arg) {
+        sw_fdt = load_device_tree(dtb_arg, &sw_fdt_size);
+        if (!sw_fdt) {
+            error_report("Error: Unable to load Device Tree %s", dtb_arg);
+            exit(1);
+        }
+    }
+
+    /* If the user provided a -hw-dtb, use it as the hw description.  */
+    if (hw_dtb_arg) {
+        fdt = load_device_tree(hw_dtb_arg, &fdt_size);
+        if (!fdt) {
+            error_report("Error: Unable to load Device Tree %s", hw_dtb_arg);
+            exit(1);
+        }
+    } else if (sw_fdt) {
+        fdt = sw_fdt;
+        fdt_size = sw_fdt_size;
+    }
+
+    kernel_info = init_memory(fdt, machine->ram_size);
+
+    arm_generic_fdt_binfo.ram_size = kernel_info.ram_kernel_size;
+    arm_generic_fdt_binfo.kernel_filename = machine->kernel_filename;
+    arm_generic_fdt_binfo.kernel_cmdline = machine->kernel_cmdline;
+    arm_generic_fdt_binfo.initrd_filename = machine->initrd_filename;
+    arm_generic_fdt_binfo.smp_loader_start = SMP_BOOT_ADDR;
+    arm_generic_fdt_binfo.smp_bootreg_addr = SMP_BOOTREG_ADDR;
+    arm_generic_fdt_binfo.board_id = 0xd32;
+    arm_generic_fdt_binfo.loader_start = kernel_info.ram_kernel_base;
+    arm_generic_fdt_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+
+    if (machine->kernel_filename) {
+        arm_load_kernel(ARM_CPU(first_cpu), machine, &arm_generic_fdt_binfo);
+    }
+
+    return;
+}
+
+static void arm_generic_fdt_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARM device tree driven machine model";
+    mc->init = arm_generic_fdt_init;
+    mc->max_cpus = 64;
+    mc->default_cpus = 64;
+}
+
+DEFINE_MACHINE_ARM("arm-generic-fdt", arm_generic_fdt_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index aeaf654790..e606630c86 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,6 @@
 arm_ss = ss.source_set()
+arm_ss.add(files('arm_generic_fdt.c'))
+
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-- 
2.43.0


