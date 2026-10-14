Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C98CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpql-0005o1-45; Tue, 13 Oct 2026 23:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqi-0005jB-Js
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqg-0001cH-B1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:16 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1236429a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949213; x=1792554013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gaUH0k4CYLBYLx6v/MK0ILicjRVWPiSXvRDNMQ2BYw0=;
 b=o/F/WIBdanfopB7H5SB5xog0qgEqmFqs9+YZ4UnFuSPxmo6c6skJTYsNTStFbMd6B7
 4SEMk09jwU295e14O4enY5bZ8skJlYVfs4Vazw71pzynVd/3yWi+UU0pbwdOQvFvkyvZ
 TtdJ4A3EHxeSORKuzeclOkJ1bOHILVzxi/gsPBVJvxPVvfmVYBqLtCzqGVkAvKmTXxK8
 xVY0nsBvRBmrfoW56a+2bdUHgJ1UFmn2j68bURaXoXAb03Zk0rw8ZugEaWGi/HshGSq3
 VsGr8qBP2KCi5jziQ4K5Qx60mJJeere3UJ3v2EuFupitBGporOAcLgm7SFMZ3iMJQstz
 bW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949213; x=1792554013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gaUH0k4CYLBYLx6v/MK0ILicjRVWPiSXvRDNMQ2BYw0=;
 b=i7d/MUx6rjQNrZvcSkIEa0+MjooGDoyRqnPve39COPuCEv5pi+BkMov9x8RGhr+5ia
 PqiBttgEvpvGazUWngAyMvPYpAt2OpAdifuODNPWdX5xaZKA4SPRgjHQiQvHSWnW9u5c
 CkP1ia9Nf/uPTgROE00UgfRuhGPhtOoDg7mDJAKLgm3jnNc/caysLzG72GGE7VCyKk2Z
 VUdHcqpm7fPBPLuQ6j7RZYMrQlwcgCj6zheHXwa3DOK+hwPdT0lKnEykPmhSTmXsfobO
 Js+mDtefEv70lo09Izi8u5inXG+Tlaz1Pan806noYHZbGU+7qIR1dm4r6KbHstdEPpl2
 PR9A==
X-Gm-Message-State: AFq9FYJ0Ni8ge5bLiwBwjZooILyEQGj/XPLF2ewR0gp2e78aKlmvvkz4
 +lMDD7immLjgB2Zc23MkCv7bNBgAQho7Q0T9+GVFs7fproeFRLZ7UMeWEhB/AQ==
X-Gm-Gg: AYBFou3Q7anYGQ3lcIENJP4odUWWSf2zK8xEfsw3SAYeRdpiiGSI1MH5UN+pJXUZkA+
 hgggY/km37ghNL8Br13zG7Bj399RSOSxX6WfmVMKQHb2WDX/YLxE7EcwzJmgGLoqIRU+Y13+bXv
 z9M2JZ+sdJwZYMopbDhY32giZrB8hWZzNFdVZZBqNILHwu8n5gq90/GRdwha/BOkYwwQ6EJQwXS
 FiexNL2Ob3xOXgWNv1p8WGFXh8VKW+vkn8R2WlB3n9u56tKZ1SlhWQEeNaSiNkQwBpPnU2hN1vw
 xgalaGPRTwydGOLxhwGEJBNz38NOYepM6EcLicCoKKGiWNwmZ7GTep3kF39fuRAdh0M+LqoO/6k
 HuDOUoPsRgw8zchx5JqcNv/qjNWRiQWnZ4w64SN97xHJTeApVM2x5HuiR5RvKDuSMh8Zr1sHLLZ
 AFvaK3Iq768+4tANppTq3fM3aj7xC3uA43KUNCvDf6h6pbGvFqjvn6kjjcUDU4cLYNZPE8BMk5e
 rvAnb3m2gX0dD8P
X-Received: by 2002:a17:90b:2886:b0:3ab:22fe:b142 with SMTP id
 98e67ed59e1d1-3ab3a47f4f4mr11632582a91.1.1791949212891; 
 Tue, 13 Oct 2026 20:40:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/52] hw/riscv: Add Sophgo CV1800B SoC support
Date: Wed, 14 Oct 2026 13:38:31 +1000
Message-ID: <20261014033907.3332383-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

Add the Sophgo CV1800B SoC, which is the heart of the Milk-V Duo board.

The SoC features a T-Head C906 CPU along with integrated PLIC, CLINT,
and dw8250 UART. The memory map and interrupts are configured according
to the CV1800B datasheet. [1]

Several peripheral blocks are included as unimplemented devices to
ensure that drivers can probe successfully without causing errors
during boot.

Link: https://github.com/milkv-duo/duo-files/tree/main/duo/datasheet [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-4-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/cv1800b.h |  56 ++++++++++++
 hw/riscv/cv1800b.c         | 177 +++++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig           |   8 ++
 hw/riscv/meson.build       |   2 +
 4 files changed, 243 insertions(+)
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100644 hw/riscv/cv1800b.c

diff --git a/include/hw/riscv/cv1800b.h b/include/hw/riscv/cv1800b.h
new file mode 100644
index 0000000000..bde5eff96b
--- /dev/null
+++ b/include/hw/riscv/cv1800b.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B SoC
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef HW_RISCV_CV1800B_H
+#define HW_RISCV_CV1800B_H
+
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/misc/cv1800b_clk.h"
+#include "hw/char/dw8250.h"
+#include "hw/sd/sdhci.h"
+
+#define TYPE_CV1800B_SOC "cv1800b-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(CV1800BSoCState, CV1800B_SOC)
+
+struct CV1800BSoCState {
+    DeviceState parent_obj;
+
+    RISCVHartArrayState cpus;
+    MemoryRegion rom;
+    DeviceState *plic;
+    CV1800BClkState clk;
+    DW8250State uart;
+    SDHCIState sdhci;
+};
+
+#define CV1800B_PLIC_NUM_SOURCES 136
+#define CV1800B_PLIC_NUM_PRIORITIES 31
+
+#define CV1800B_UART0_IRQ 44
+#define CV1800B_SD0_IRQ   36
+
+enum {
+    CV1800B_DEV_TOP_MISC,
+    CV1800B_DEV_PINMUX,
+    CV1800B_DEV_CLK,
+    CV1800B_DEV_RST,
+    CV1800B_DEV_WDT,
+    CV1800B_DEV_GPIO,
+    CV1800B_DEV_UART0,
+    CV1800B_DEV_SD0,
+    CV1800B_DEV_ROM,
+    CV1800B_DEV_RTC_GPIO,
+    CV1800B_DEV_RTC_IO,
+    CV1800B_DEV_PLIC,
+    CV1800B_DEV_CLINT,
+    CV1800B_DEV_DRAM,
+};
+
+extern const MemMapEntry cv1800b_memmap[];
+
+#endif
diff --git a/hw/riscv/cv1800b.c b/hw/riscv/cv1800b.c
new file mode 100644
index 0000000000..9386c40de8
--- /dev/null
+++ b/hw/riscv/cv1800b.c
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B SoC
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/riscv/cv1800b.h"
+#include "hw/core/qdev-properties.h"
+#include "target/riscv/cpu-qom.h"
+#include "system/system.h"
+#include "hw/intc/riscv_aclint.h"
+#include "system/address-spaces.h"
+#include "hw/intc/sifive_plic.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/boot.h"
+#include "hw/sd/sdhci.h"
+#include "hw/misc/unimp.h"
+
+const MemMapEntry cv1800b_memmap[] = {
+    [CV1800B_DEV_TOP_MISC]     = { 0x03000000,      0x1000 },
+    [CV1800B_DEV_PINMUX]       = { 0x03001000,      0x1000 },
+    [CV1800B_DEV_CLK]          = { 0x03002000,      0x1000 },
+    [CV1800B_DEV_RST]          = { 0x03003000,      0x1000 },
+    [CV1800B_DEV_WDT]          = { 0x03010000,      0x1000 },
+    [CV1800B_DEV_GPIO]         = { 0x03020000,      0x4000 },
+    [CV1800B_DEV_UART0]        = { 0x04140000,     0x10000 },
+    [CV1800B_DEV_SD0]          = { 0x04310000,     0x10000 },
+    [CV1800B_DEV_ROM]          = { 0x04400000,     0x10000 },
+    [CV1800B_DEV_RTC_GPIO]     = { 0x05021000,      0x1000 },
+    [CV1800B_DEV_RTC_IO]       = { 0x05027000,      0x1000 },
+    [CV1800B_DEV_PLIC]         = { 0x70000000,   0x4000000 },
+    [CV1800B_DEV_CLINT]        = { 0x74000000,     0x10000 },
+    [CV1800B_DEV_DRAM]         = { 0x80000000,         0x0 },
+};
+
+static void cv1800b_soc_instance_init(Object *obj)
+{
+    CV1800BSoCState *s = CV1800B_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type", TYPE_RISCV_CPU_THEAD_C906);
+    qdev_prop_set_uint64(DEVICE(&s->cpus), "resetvec",
+                         cv1800b_memmap[CV1800B_DEV_ROM].base);
+
+    object_initialize_child(obj, "clk", &s->clk, TYPE_CV1800B_CLK);
+    object_initialize_child(obj, "uart", &s->uart, TYPE_DW8250);
+    object_initialize_child(obj, "sdhci", &s->sdhci, TYPE_SYSBUS_SDHCI);
+}
+
+static void cv1800b_soc_realize(DeviceState *dev, Error **errp)
+{
+    CV1800BSoCState *s = CV1800B_SOC(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint32_t num_harts = ms->smp.cpus;
+    MemoryRegion *system_memory = get_system_memory();
+    char *plic_hart_config;
+
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
+        return;
+    }
+
+    memory_region_init_rom(&s->rom, OBJECT(dev), "cv1800b.rom",
+                           cv1800b_memmap[CV1800B_DEV_ROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                cv1800b_memmap[CV1800B_DEV_ROM].base, &s->rom);
+
+    riscv_aclint_swi_create(system_memory,
+                            cv1800b_memmap[CV1800B_DEV_CLINT].base,
+                            0, num_harts, false);
+    riscv_aclint_mtimer_create(system_memory,
+                               cv1800b_memmap[CV1800B_DEV_CLINT].base +
+                               RISCV_ACLINT_SWI_SIZE,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+
+    plic_hart_config = riscv_plic_hart_config_string(num_harts);
+    s->plic = sifive_plic_create(
+        system_memory,
+        cv1800b_memmap[CV1800B_DEV_PLIC].base,
+        plic_hart_config,
+        num_harts,
+        0,
+        CV1800B_PLIC_NUM_SOURCES,
+        CV1800B_PLIC_NUM_PRIORITIES,
+        0x0,
+        0x1000,
+        0x2000,
+        0x80,
+        0x200000,
+        0x1000,
+        cv1800b_memmap[CV1800B_DEV_PLIC].size);
+
+    g_free(plic_hart_config);
+
+    qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
+    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, cv1800b_memmap[CV1800B_DEV_UART0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
+                    qdev_get_gpio_in(DEVICE(s->plic), CV1800B_UART0_IRQ));
+
+    qdev_prop_set_uint8(DEVICE(&s->sdhci), "sd-spec-version", 3);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x056900b9);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0, cv1800b_memmap[CV1800B_DEV_SD0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
+                       qdev_get_gpio_in(DEVICE(s->plic), CV1800B_SD0_IRQ));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->clk), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0,
+                    cv1800b_memmap[CV1800B_DEV_CLK].base);
+
+    create_unimplemented_device("cv1800b.top_misc",
+                                cv1800b_memmap[CV1800B_DEV_TOP_MISC].base,
+                                cv1800b_memmap[CV1800B_DEV_TOP_MISC].size);
+
+    create_unimplemented_device("cv1800b.pinmux",
+                                cv1800b_memmap[CV1800B_DEV_PINMUX].base,
+                                cv1800b_memmap[CV1800B_DEV_PINMUX].size);
+
+    create_unimplemented_device("cv1800b.rst",
+                                cv1800b_memmap[CV1800B_DEV_RST].base,
+                                cv1800b_memmap[CV1800B_DEV_RST].size);
+
+    create_unimplemented_device("cv1800b.wdt",
+                                cv1800b_memmap[CV1800B_DEV_WDT].base,
+                                cv1800b_memmap[CV1800B_DEV_WDT].size);
+
+    create_unimplemented_device("cv1800b.gpio0_3",
+                                cv1800b_memmap[CV1800B_DEV_GPIO].base,
+                                cv1800b_memmap[CV1800B_DEV_GPIO].size);
+
+    create_unimplemented_device("cv1800b.rtc_gpio",
+                                cv1800b_memmap[CV1800B_DEV_RTC_GPIO].base,
+                                cv1800b_memmap[CV1800B_DEV_RTC_GPIO].size);
+
+    create_unimplemented_device("cv1800b.rtc_io",
+                                cv1800b_memmap[CV1800B_DEV_RTC_IO].base,
+                                cv1800b_memmap[CV1800B_DEV_RTC_IO].size);
+}
+
+static void cv1800b_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = cv1800b_soc_realize;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo cv1800b_soc_type_info = {
+    .name = TYPE_CV1800B_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CV1800BSoCState),
+    .instance_init = cv1800b_soc_instance_init,
+    .class_init = cv1800b_soc_class_init,
+};
+
+static void cv1800b_soc_register_types(void)
+{
+    type_register_static(&cv1800b_soc_type_info);
+}
+
+type_init(cv1800b_soc_register_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..b7c0871c67 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -164,3 +164,11 @@ config K230
     select K230_WDT
     select K230_GSDMA
     select K230_DECOMP_GZIP
+
+config SOPHGO_CV1800B
+    bool
+    depends on RISCV64
+    select RISCV_ACLINT
+    select SIFIVE_PLIC
+    select SOPHGO_CV1800B_CLK
+    select DW8250
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 7aa3c1578d..45895486d4 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -22,4 +22,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
 
+riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
+
 hw_arch += {'riscv': riscv_ss}
-- 
2.55.0


