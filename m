Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36955CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ3X-0001Lc-7i; Tue, 16 Jun 2026 15:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3M-0001KH-25
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3J-0007Zm-6H
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so2423440b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636544; x=1782241344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J37OOKy8I7OtViJC45dUhtotxxDTF76GzUCt9oKc+0w=;
 b=Jmk8sujtBAXUpM6n4U7UkoF/ClInTGOZKuyOabUnMF7CubgdKAdQZQsz3n4yMWYwU7
 PYA4Azgep9N6DkDz3bhDymNgSPJGoxxsXP5hl+SGl8b3YRKGPzF7scV7+Xxa1eSmgWfF
 pF+ohHRRGrMUIlTnqJEhM9qR2WoTGqsRqA0b16rSUXUyP9xm63ieiUuARAGIHQQTq5OG
 5R4JrPAa4fwPP1XLrz9qk+uk7J8JXzvEAwxQciwJNwLJuNAumgxBNGHlTGRZ7yopb299
 NQXhiSTlmOe5EIcVdAJO/mLmODxNeAn4sdRxniKXQs53pHANcb2zndMEp7p9iS9n5zVo
 t+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636544; x=1782241344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J37OOKy8I7OtViJC45dUhtotxxDTF76GzUCt9oKc+0w=;
 b=FbyquOi3JPhI8vCS7fgBPYVJ8p+GcRKaCOtbgLcbsQPH4rDPc1zjQH2B6jORfKZ47w
 TGXwVUSHQD72fq3i09ae2IVelmnypnxRBAZFMcYc9Lf/TQDMgpDQW1LIEX8gQ9Zadnmb
 bBjQsn0yUxwKYIPPZjHQph59TIr7DNFBk1w5+vS4z9rylJxpcTRb4WvvcjdB6nSMk11b
 pGB1z03q3WKKZ+yisxHkWr83jalp5bvaQL8sipS+3EpptUqmf+UzSQjxj9XIzNH4zCx6
 eHJAcJby31PPkUzwb1ISD6nqMuYSHkgEPrxEDxzslbfA86H8gY9PXgGjETQifDfswh8c
 6m+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zWxvgtxnVJsXOKb8Nb+3A+R20PfI2qKBTwZnbduaTpI5jRMWwt/EV2XR8963MNPFvZjQ4bYpFu2jU@nongnu.org
X-Gm-Message-State: AOJu0YzO2BhsZJDElkrJaZa9co8v4YdJk30jNDXsRN+pAKANy6UTbBiJ
 QE3DBx6aLcavKczjBtNRAY3JXeWy4ZbpSl6OTipSXa862Nc65fmfmWnj
X-Gm-Gg: Acq92OFQR7wpqf1s1gX+Qv6OgUAyFXfPdODbpDIedDmp6YoNeJBqVOpO0Oth7M1HCYf
 PxyGmCQAGbf1jvKO4iivhpmAAtOkXv9XASXUkQtuOLjEi5vGGHzi6G1w59BPNXsqI6OZOlpz1Wg
 lvnMsvC+vuEBvK5L81WagiNeHKC7bjqrf47SCXsyF3XFgtV96FwVbST2X+ptY0Rt9HkhLbjDPhZ
 6crwcWjXUKWLktEeltvUVWyDa4tSMI0ha0oUPg7j7oBH884z0QpLS9AP+urSAsxp6WFkqqoy+bE
 R2VzpXxXotqe5R61vXH4AhlVoQfdf2+o+j+U1VB/+w0q1kry16T9dRl5VPSbO4VQmXb/6x6UMsJ
 kqA2yM4b7hHNSHnBA58z5z9GAvdGaLDt0nZp00vlxZ76vddhl9LvVn/1OwbKtxzufRaoVknnNy7
 WM5lvPYegccpuSHQTNTVDH+ISebJTy+kMRwPfGsLt4MpdgR3BvBTz6kAOmEGp2W508nNLBTn1+U
 mPsS/aaseD7nL3sQeoZ8Hk=
X-Received: by 2002:a05:6a00:4502:b0:82a:780f:a187 with SMTP id
 d2e1a72fcca58-8452459a041mr338860b3a.36.1781636543757; 
 Tue, 16 Jun 2026 12:02:23 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c474sm12671540b3a.2.2026.06.16.12.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:02:22 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 3/5] hw/riscv: Add Sophgo CV1800B SoC support
Date: Tue, 16 Jun 2026 19:01:45 +0000
Message-ID: <20260616190147.1286316-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616190147.1286316-1-visitorckw@gmail.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add the Sophgo CV1800B SoC, which is the heart of the Milk-V Duo board.

The SoC features a T-Head C906 CPU along with integrated PLIC, CLINT,
and dw8250 UART. The memory map and interrupts are configured according
to the CV1800B datasheet. [1]

Several peripheral blocks are included as unimplemented devices to
ensure that drivers can probe successfully without causing errors
during boot.

Link: https://github.com/milkv-duo/duo-files/tree/main/duo/datasheet [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/riscv/Kconfig           |   8 ++
 hw/riscv/cv1800b.c         | 168 +++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build       |   2 +
 include/hw/riscv/cv1800b.h |  52 ++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 include/hw/riscv/cv1800b.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..299baed4a8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -149,3 +149,11 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+
+config SOPHGO_CV1800B
+    bool
+    depends on RISCV64
+    select RISCV_ACLINT
+    select SIFIVE_PLIC
+    select SOPHGO_CV1800B_CLK
+    select DW8250
diff --git a/hw/riscv/cv1800b.c b/hw/riscv/cv1800b.c
new file mode 100644
index 0000000000..c6749e1202
--- /dev/null
+++ b/hw/riscv/cv1800b.c
@@ -0,0 +1,168 @@
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
+#include "hw/char/serial.h"
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
+    object_initialize_child(obj, "clk", &s->clk, TYPE_CV1800B_CLK);
+}
+
+static void cv1800b_soc_realize(DeviceState *dev, Error **errp)
+{
+    CV1800BSoCState *s = CV1800B_SOC(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint32_t num_harts = ms->smp.cpus;
+    MemoryRegion *system_memory = get_system_memory();
+    char *plic_hart_config;
+    DeviceState *uart, *sdhci;
+
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type", TYPE_RISCV_CPU_THEAD_C906);
+
+    qdev_prop_set_uint64(DEVICE(&s->cpus), "resetvec",
+                         cv1800b_memmap[CV1800B_DEV_ROM].base);
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    memory_region_init_rom(&s->rom, OBJECT(dev), "cv1800b.rom",
+                           cv1800b_memmap[CV1800B_DEV_ROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                cv1800b_memmap[CV1800B_DEV_ROM].base, &s->rom);
+
+    riscv_aclint_swi_create(cv1800b_memmap[CV1800B_DEV_CLINT].base,
+                            0, num_harts, false);
+    riscv_aclint_mtimer_create(cv1800b_memmap[CV1800B_DEV_CLINT].base +
+                               RISCV_ACLINT_SWI_SIZE,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+
+    plic_hart_config = riscv_plic_hart_config_string(num_harts);
+    s->plic = sifive_plic_create(
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
+    uart = qdev_new("dw8250");
+    qdev_prop_set_uint8(uart, "regshift", 2);
+    qdev_prop_set_chr(uart, "chardev", serial_hd(0));
+    sysbus_realize(SYS_BUS_DEVICE(uart), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(uart), 0, cv1800b_memmap[CV1800B_DEV_UART0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart), 0,
+                       qdev_get_gpio_in(DEVICE(s->plic), CV1800B_UART0_IRQ));
+
+    sdhci = qdev_new(TYPE_SYSBUS_SDHCI);
+    qdev_prop_set_uint8(sdhci, "sd-spec-version", 3);
+    qdev_prop_set_uint64(sdhci, "capareg", 0x056900b9);
+    sysbus_realize(SYS_BUS_DEVICE(sdhci), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(sdhci), 0, cv1800b_memmap[CV1800B_DEV_SD0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(sdhci), 0,
+                       qdev_get_gpio_in(DEVICE(s->plic), CV1800B_SD0_IRQ));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->clk), &error_fatal);
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
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..6c242d77da 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -19,4 +19,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
 
+riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
+
 hw_arch += {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cv1800b.h b/include/hw/riscv/cv1800b.h
new file mode 100644
index 0000000000..a214f7a9f6
--- /dev/null
+++ b/include/hw/riscv/cv1800b.h
@@ -0,0 +1,52 @@
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
-- 
2.54.0.1136.gdb2ca164c4-goog


