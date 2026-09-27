Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23BDC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvGE-0008Ln-U5; Sun, 27 Sep 2026 16:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGC-0008LC-OR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:08 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGA-0003Z0-Px
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:08 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1777786a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540045; x=1791144845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tkNWi6bqLSlvCJO/5RICW4jPtEBQA0a/asEIW2oEfZE=;
 b=FuT8pnt4EQWqwrLdxtYvlzDe5pdVuV/n51TpXpk/0dnc9W4S0uvkfyF1BnY//a/v0R
 B6vRuPP4G4Yq5ppeHDO8IRGkNe5JsheqZToxMsCtNKMNwe+XN1Di7ld5GiQjBbbeGHjO
 LHFHZ40kDPdpNQ8rvNK5B+m4VNvz17wO2hRlTlCRXYkFvHR9w3AH1been3jGVlKGZ9cT
 JmeKXXBQ8+mmyBB7QVxdYQt6Do3I7GE+oSPuHuByBgWZRE3IzobUor0YhEjyAT+uliXw
 wMr80n/Q2YbCbxZ+Izgb/sKX0iysB0xwyKELFME0aFT14GvkMii+HjFXqR9JLX16ZqB9
 tXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540045; x=1791144845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tkNWi6bqLSlvCJO/5RICW4jPtEBQA0a/asEIW2oEfZE=;
 b=1fD5gV3OF453dQrS9ROGqh6Ov31reLdV4g+CRPajlQeqEGVMRJKLFg9qGO3lwBB+AI
 M0cjexp5q3N32IthlV8Ojl3/SePG3s1FsjziBapD9V5621T9MTjQtO2kYvGSidz+L13S
 CWOFb6er3d1dFO/qbXQZv8gPKQPyddxGDOZYqeXHXg5VB9SmVXT9AkFL8fOFGyz3AmWH
 nHSHbOCZ9bLV5sw/S+DBRtMAZkZmVs/6IsGP9fwaxs2eU9ccMTwAwlXxWg9N5MN53/Nc
 0qxWzTWR4B5yDVXHLcque9uVd1rOmZRNHeV9tlJHYFuwzRilBSFBig3cN1UPlZPHPrNm
 ZqcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypO9cCfhHtFD9seCbo1chMgn8qW8elkH7JWB8EC+4o+WP673QFdl7a0f1TUXpgTiDBKA0EI6h3gE8B@nongnu.org
X-Gm-Message-State: AFq9FYJny+W+7qFMGY0S45zMG8cPqc51LMymTp3/6JsJnzI7Pvedjchk
 yYd9GI/ITyO5TpBtzOTCtvZhaI7v+51ivciEdjx2ihNYTZnm5qKZjdle
X-Gm-Gg: AYBFou2HfMY23ETgmMjNbq9m2wuYS9AQVSlZ6fdqcKad0EHlWVGo68u9ZmcVazTZkO0
 e+qOOLUiZQXxkmr6i1iXXCh19w9BK1p5sPO9adtmP/+MxNXvUADF+KNvc9A4orC2zDk8deCmEA3
 AylJLqirBR4eiJ3wWW1lqTcuwvcOOVB8gpuI6Pn7CaPjJFwL980zEfUS2FFvuHtOfQU1HQB7ebb
 +5nVI1f4AxbUewkKLxwWjospoRhHcoxiXTw1IvWKvk+DvScwErFAFkCsxXs1JLetPYt9ThqZHzQ
 Xi9cnNliNRXuQ2Z4XidVjeZ8PanAdp3Sex59qY8cmLfwTyT9AH/60WHmcU4/P0xT6uDiEKgcDWV
 GziZqMZjzBbe4/g01JJ4gLh1Qnf4Ls28iSdU6b7QgH4hcGrt9P8kHrMhL5Ha9nzvpgmzL9U+/Y3
 fxjN6759WsIMA3l2F57v0XvVCBTKs3Nn51CQ6oJrJ9CwnKXsN3O4v/aG7h7Cp55xH6DQ8eEMiy2
 kSV2avUjlD5RarlN1zr/zMioAA4zUMV1s6lc8qALtMcVP4G/lh/jkO3rbXR7ZCBUccdvbgyYg==
X-Received: by 2002:a17:90b:3a08:b0:3a0:7d5b:8d56 with SMTP id
 98e67ed59e1d1-3a0bb599f07mr6087169a91.28.1790540045445; 
 Sun, 27 Sep 2026 13:14:05 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:14:05 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v5 4/7] hw/riscv: Add Milk-V Duo board support
Date: Sun, 27 Sep 2026 20:13:23 +0000
Message-ID: <20260927201326.650943-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260927201326.650943-1-visitorckw@gmail.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=visitorckw@gmail.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS                                 |   9 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/milkv_duo.c                        | 118 ++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 hw/riscv/milkv_duo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d4e9cf61ea..bef8c2f3b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,6 +1872,15 @@ F: tests/qtest/k230-wdt-test.c
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
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


