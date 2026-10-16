Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B29CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPE-0004n1-Ri; Thu, 15 Oct 2026 21:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM3-0000ML-Cz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM1-0004GR-8j
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e985106c0cso1402655ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112602; x=1792717402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=biZpLD2mSeTueWSj0jCfd+LF2VBKiGzybXAhVFEakoU=;
 b=JaAzw7Ts4mLHB9K764YxGEBh27nKSBzpIHhnlfL2l3MNXrieBaPsM9sRwXc4NrOa8w
 7tjp/bOqllMRO/MFqW6Pq1PJkBCu4yHB00RQt1e/ltlH8S2t6fHxLVp4KfSsITFpSLNk
 l53EPrYimqaz58eXsN70ZmnQnD54wz6h19B5tnWN2rx8R+8AD8Mb7idwRZfR31dsDVRu
 ESdjsIMT5Gd/KLpVJtQ3MJaJVVAVK7SUohKQ3TtieYXiOJFBY8rvoqLiuWLp8xQXLQXP
 gvhg/dOpCOTC1DlA2B3NlHpc59agodU1XhCBHrJTVm1/fc8mT80oLkx6Rb9DeEE2TiLM
 z3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112602; x=1792717402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=biZpLD2mSeTueWSj0jCfd+LF2VBKiGzybXAhVFEakoU=;
 b=0MzcFpE2RIzK8HFBPPDvBG8KPwMKAHDP9DENtmWMft47G1mqMsmNlv4WZILUScOM5n
 fINFWcypkyg0VOesZhTG8gkT/YVNkP0jVVSyajI2E5sh8m7taZlAOoqWdxKd+Nb1BzLN
 9DsZ+sCyLryPh7XhIuwxhnZUskxEMYH6a8KPiG9+7LnbiYAh9SpOlbmF1meDNoJb7Zk3
 0t2JM6LJAg5pPrD+pSjqyLYBnGnvljSxNSm2ab6xA9SzTW6f6doXQgQcRup4fG8RT65H
 3sk11MXqOVKO5hpv2JyNoHJVntVdjfEE2yx+LjIMWFMeeVevzNiDxt5COCVt3R9kkGr1
 j+NA==
X-Gm-Message-State: AFq9FYJjZACpn3xgLjO9Ns4OJ/QogJtVsXCjjLg3B0H/4Kzu8m3xIaNo
 cdpm5bP4Zffy2mZgmRjO6hHSzdKxzdSOIOnhlV6exXl6ENKXwHJKRpEwSmhglA==
X-Gm-Gg: AYBFou0jj1YRC/6dD95cCRrAHKbabOB2vzCqIaKfJkWWzvbjJnvFVNj5mWpTv3B4V8M
 CckhA2HYQDyaiKf/YjwB/2MfyDrH61W1CJgMNFQlVfM+BZfJf82sRhJUZRSipD8O9Gorj3PHeld
 4E9+hp21DrXgFlgktkWFnrfEyS9KQaY+choTfLcMYCeCBxv4ZudKOoOt8B3qQU59KnL1TNRvjPz
 R0I7D0n6J+sdvSdIOGIkTd+/YUSQAsYBx0YahQTvmJgEAf8OCJCeYBRSuHyxPzAiH5aJtDQUu/v
 GSBPwhd09b+VhFe18Vt7F0hBsjP5YcS0NCpWvXxP1Es62t2Fxeb9erVhpucCJ1AJ/seWic3IQGe
 YdLAB27dc12pAtFqEW9oWFlnyaSriOJKkpazUcli7JERDLYbV5LBBqXnHbuiio7JHgeHaXmp7BF
 SmOhXFDy0+oaIoDl/5lA+dJzeQdZYyJ6Iqjt+4B0T+9hZ5sLKEdQkEE6X8x+Uv9PIkIlhC+AneH
 1RgewqAB40v/hu8
X-Received: by 2002:a17:902:f789:b0:2e8:3534:eeab with SMTP id
 d9443c01a7336-2e842aa60c0mr192999265ad.14.1792112601813; 
 Thu, 15 Oct 2026 18:03:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL v2 12/50] hw/riscv: Add Milk-V Duo board support
Date: Fri, 16 Oct 2026 11:01:59 +1000
Message-ID: <20261016010237.1102834-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add support for the Milk-V Duo development board, which is powered by
the Sophgo CV1800B SoC.

The implementation includes:
- Board-level machine initialization with 64mb of default ram.
- Integration of the CV1800B SoC.
- Support for loading external FDT, kernel, and initrd images.
- Proper setup of the reset vector to match the CV1800B's boot flow.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260927201326.650943-5-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                 |   9 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/milkv_duo.c                        | 118 ++++++++++++++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/meson.build                        |   1 +
 5 files changed, 135 insertions(+)
 create mode 100644 hw/riscv/milkv_duo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a3c3701a5..5a615ecf95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1871,6 +1871,15 @@ F: tests/qtest/k230-wdt-test.c
 F: tests/qtest/k230-gsdma-test.c
 F: tests/qtest/k230-decomp-gzip-test.c
 
+Milk-V Duo
+M: Kuan-Wei Chiu <visitorckw@gmail.com>
+S: Maintained
+F: hw/misc/cv1800b_clk.c
+F: hw/riscv/cv1800b.c
+F: hw/riscv/milkv_duo.c
+F: include/hw/misc/cv1800b_clk.h
+F: include/hw/riscv/cv1800b.h
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index a8e4d0ab33..2ba91b14d4 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -13,3 +13,4 @@
 # CONFIG_SHAKTI_C=n
 # CONFIG_XIANGSHAN_KUNMINGHU=n
 # CONFIG_MIPS_BOSTON_AIA=n
+# CONFIG_MILKV_DUO=n
diff --git a/hw/riscv/milkv_duo.c b/hw/riscv/milkv_duo.c
new file mode 100644
index 0000000000..1285c8d34f
--- /dev/null
+++ b/hw/riscv/milkv_duo.c
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Milk-V Duo board
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/riscv/cv1800b.h"
+#include "hw/riscv/boot.h"
+#include "target/riscv/cpu-qom.h"
+#include "system/system.h"
+#include "system/device_tree.h"
+#include "qemu/error-report.h"
+#include "hw/core/loader.h"
+#include <libfdt.h>
+
+struct MilkVDuoState {
+    MachineState parent_obj;
+    CV1800BSoCState soc;
+};
+
+#define TYPE_MILK_V_DUO MACHINE_TYPE_NAME("milkv-duo")
+OBJECT_DECLARE_SIMPLE_TYPE(MilkVDuoState, MILK_V_DUO)
+
+static void milkv_duo_init(MachineState *machine)
+{
+    MilkVDuoState *s = MILK_V_DUO(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
+    const char *firmware_name;
+    hwaddr firmware_load_addr, firmware_end_addr;
+    hwaddr fdt_load_addr = 0;
+    int fdt_size = 0;
+    uint64_t kernel_entry = 0;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_CV1800B_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    memory_region_add_subregion(system_memory,
+                                cv1800b_memmap[CV1800B_DEV_DRAM].base,
+                                machine->ram);
+
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
+    firmware_name = riscv_default_firmware_name(&s->soc.cpus);
+    firmware_load_addr = cv1800b_memmap[CV1800B_DEV_DRAM].base;
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
+                                                     &firmware_load_addr, NULL);
+
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+        if (!machine->fdt) {
+            error_report("Failed to load device tree");
+            exit(1);
+        }
+
+        if (machine->kernel_cmdline && *machine->kernel_cmdline) {
+            if (fdt_path_offset(machine->fdt, "/chosen") < 0) {
+                qemu_fdt_add_subnode(machine->fdt, "/chosen");
+            }
+            qemu_fdt_setprop_string(machine->fdt, "/chosen", "bootargs",
+                                    machine->kernel_cmdline);
+        }
+    }
+
+    if (machine->kernel_filename) {
+        hwaddr kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                                firmware_end_addr);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    }
+
+    if (machine->dtb) {
+        fdt_load_addr = riscv_compute_fdt_addr(cv1800b_memmap[CV1800B_DEV_DRAM].base,
+                                               machine->ram_size, machine, &boot_info);
+        riscv_load_fdt(fdt_load_addr, machine->fdt);
+    }
+
+    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
+                              firmware_load_addr,
+                              cv1800b_memmap[CV1800B_DEV_ROM].base,
+                              cv1800b_memmap[CV1800B_DEV_ROM].size,
+                              kernel_entry,
+                              fdt_load_addr);
+}
+
+static void milkv_duo_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char *const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_THEAD_C906,
+        NULL
+    };
+
+    mc->desc = "Milk-V Duo Board (CV1800B)";
+    mc->init = milkv_duo_init;
+    mc->max_cpus = 2;
+    mc->default_cpu_type = TYPE_RISCV_CPU_THEAD_C906;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "riscv.milkv_duo.ram";
+}
+
+static const TypeInfo milkv_duo_machine_type_infos[] = {
+    {
+        .name = TYPE_MILK_V_DUO,
+        .parent = TYPE_MACHINE,
+        .instance_size = sizeof(MilkVDuoState),
+        .class_init = milkv_duo_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(milkv_duo_machine_type_infos)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b7c0871c67..70a331f7ae 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -172,3 +172,9 @@ config SOPHGO_CV1800B
     select SIFIVE_PLIC
     select SOPHGO_CV1800B_CLK
     select DW8250
+
+config MILKV_DUO
+    bool
+    depends on RISCV64
+    default y
+    select SOPHGO_CV1800B
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 45895486d4..a40e80645b 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -23,5 +23,6 @@ riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
 
 riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
+riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.55.0


