Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA52CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqn-0005uw-GN; Tue, 13 Oct 2026 23:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpql-0005oF-7c
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqj-0001cY-6d
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:18 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so1973119a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949216; x=1792554016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RuS9aPT1CWsrJ+rpMEr3jlkZ+iGk1uOZHmMGN7K+jZU=;
 b=FzbW026SPyCX71H55lQFKec78BgFJ6TT17AvObthTyZYriPZniMFIIPqWXz3LT7wYG
 vWAYvrX07sEsGxXDaIyGWFo9/ETLKxi341E9JVgHvZ20M7UjVcs7mHvGcWYIR8SzrZcf
 lxMvfiRs72eJuTebJZUSHTpZFFwDx/U+hEy1vv+XIE4iIqzV3RC0DKvi4Cmj1ddqRx6n
 KBhKqQty2MjwoCu4uHgrs6OfnUhR0R88xeAnj7a/+Q7MvPQGlLINTX0uri1TRdlUIDvw
 HcV1MFFrUMllKk2KjQ+k0r1HvoUZUFwpIANJr16pktgWLTxBHrmLMDEAmWpyETukozaf
 rXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949216; x=1792554016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RuS9aPT1CWsrJ+rpMEr3jlkZ+iGk1uOZHmMGN7K+jZU=;
 b=XnqhADRW+9i01MoeAl9XG1nC3XHlf7q0LbrDLcn+HrGUcCWDitpRtoQ+jXZvo656t0
 CyklxVogymwvs8CiRbiOx+Kja+08F5Hn1qDg4JGH/bAnpf5KWRCL4w8NXZw7MZhpkot+
 2eilC4VyB1z4iSi7c3mau4AlWSgKMyXcFHHWojaVZLYaGGHvMc5UwdMTzaST7aK1WNlW
 /J8y/WFjNlZfndBa7YPR/nLEyhT6Z/T78RjpV1fuv9ssdfVHBqhdEX2+JLpbZL42NmL/
 iR2zXOvyzeo7dPo4Ace7jfu+LU7kaIE6BVJsUA1TH4+XRk/Kq3OjQurJdfDZ18C9SdtG
 Ua5g==
X-Gm-Message-State: AFq9FYK9f07pSN9DTM2hM2G16No+kuUiN5oIv0EgAdgwKkIbYZk71Q21
 IpQmTTf4QeS8sdoNVhVmo9FPdv6rrXMEk4vmwnDXF0596IX8z11U0EPDz8PpuQ==
X-Gm-Gg: AYBFou15dCPxMlRfeh06MkdRONr8lTRfyK5OurRKaPdMARoHBc333UYR2hpW20OUjC6
 O9rN5AaKzYKLLbCtGi5yEDg4nWgiEPF42ZFNGX3iYRUhAjag7O02QddnCzkRsVY4n4dUEX1nCQV
 0b/P8421+1y9sDtCEYjGe0rsiou4wcSROvd4wown6yHgGjHzQIAW6y2ZP537eppBOsGsdb8wue4
 pZsfcrl1os7hzmr5goRlGt+1Ndq5bf7Uc4UzZ2EELmjiAUzrjlknQZ9F1g1heuRNQg/L8SRsvHj
 w248b4cV74GEia2PrWyq6aItnbGrxYSSal592IAbLuwrvbMGIziYi9Xay6GDfXqdLlzEl6nQTyb
 3vnard3gt8gpkVVH1ncbxN6i6DfZtBW8jOBrbCrFkWSwKgWDhnEwaEv65YJsFSXAxNh2Qu93R6D
 nRo+nVdIf82gZWosEIU22c68W0U+p9G8SSYNH15MoNsLvebMI/YX5Urp43Rdmr3R+LY5ADp5gSz
 xhq/IcTdzvl7/LwEoh60ul0YaY=
X-Received: by 2002:a17:90b:28c8:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3ab3a99825cmr10375963a91.33.1791949215674; 
 Tue, 13 Oct 2026 20:40:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 17/52] hw/riscv: Add Milk-V Duo board support
Date: Wed, 14 Oct 2026 13:38:32 +1000
Message-ID: <20261014033907.3332383-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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
index 913162130f..2e6a7721c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,6 +1875,15 @@ F: tests/qtest/k230-wdt-test.c
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


