Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612F0CD4F21
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 01:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNKgP-0006uS-2s; Wed, 13 May 2026 21:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKgN-0006tY-8D
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:16:11 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKgK-0000vr-Tj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:16:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-365e20fe3b8so4388138a91.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778721367; x=1779326167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glcjIMxZZysIE7r/mnimuPjUh4Szz2MUKvKWN/XEWCQ=;
 b=LBqS2E0XDMwl7QVG/NIElWpfMH5iKLjwUd/BV9b6WYpMMTZiau6vU+sR4Bb5iL8o2y
 eBZk8PsPzZ7ORyOY9Zre9dauCUVc8EeXW0Asq0ts/ydOXaVQdC23tn3dBdzjD8EMsbJ5
 QZZMKcIuh41VQhrjS1kRt7X0gtakokXYfGMPyxaqyc73E4FSijfxZ+LGRnmh/fyByOAA
 ummI8u5kPJQNwGrJ2v1cE43xLHSe4adVKaf05JYHV3dFKVirY1dHwufYiJhpFc7JZvqv
 HRisr6xqGDLum9oU+VKG/Yp4roQeFtnGVapX5bHgWGFUgz4Y2Q+vGcCeav8hWyuwHLY+
 EsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778721367; x=1779326167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=glcjIMxZZysIE7r/mnimuPjUh4Szz2MUKvKWN/XEWCQ=;
 b=RdBVR6mXX8FO3ffP4faWAATNxpbYgZuwb0UInhv4lTx1rKFspIaHVRPcTIRISsAmYK
 AhCqeqa/QoMWaUCkpJmy+awjIZpLXb6AJsULBQ1dXShSFd6YkQB9vYkadxQLxyo/vG1b
 EZMOjEPnpilq8bI6FNi+HnjaSjitMlrOgcwZ4+mmO5p0t7LYqZHZlkSJkw2mGgeEyBqm
 Ddn2IRFekbCttLEiRGcUY3khLK/as+zzaCSB8bAKkXPImq5PCnAGIjopxRX1+2Niwv8E
 wKufyYZcgxvpsciDqDe17WwI4MVv5RsZk20xwvF3cubaitULKsZSHh6wcT9Fiw94buOt
 RR/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6eoGGWJjv7JUEiFDkjS/51TtOL3LZI1aKQOHZlZP8ZyalIzmpLMk2FeEmyneTGehcfni1KlmAK3ST@nongnu.org
X-Gm-Message-State: AOJu0YzcC/PiL80iNkgp86VG9wpoY+fDWR9pRY2FHOt3u2LeNne8sj3o
 D+4+XUURFo7ui5yWJ95ieelFvKn/5Ogv0NBF0cV2J3uDxva+BXf9HMkU
X-Gm-Gg: Acq92OG/cqZZqoMpow+P/p1KcNDoVD72RLJsZJ7+xEQjl5m3E3pCiRbXc/djx/VY2r1
 yOz8P1O3gjf2CWv2cE2+D0Klde0pC2x5cVvKY7asbeAk+xoD2oj7aG6pqTTk0cMJkpTZLNNEf4e
 NAGIppKENyXm5XgIMyOvuDess+mTL2Bl1Ve4tB5aELaMMZhou40/fTebPgbpmFZCb0RQlXfF5i+
 QFgrcO70sKmSVzSZuNd06lcgjgDE1O3Qmd9aNvaN5OQPXtRTFA9rantLU5sTEBrFx3CJ4W5ZI7w
 Zrfik/CIhcui1cM29UMLExuhwZVJCBu8PRrVu5alsEqhc+Bvls4XpPPAUzl1zprvQ2jC0IwlhI2
 gKTPUCKhP13NkejbBPBkG11XHEA0Gr9TwpQiZPqY6FWzY//Vb6dNneuTKw/F7UBze+VUlfUfC6v
 DNIYPW571dbl+jgIFmaJ3bjFwo52k5qHcjSaWfE7/4HDPj1oRAR2/HtsSYCd8VeLPA7Nzk+van8
 t9fzyClXgn9DHYIeDO8YKwB6+Y7KJuvrQ==
X-Received: by 2002:a17:90b:3951:b0:35f:be09:1a2b with SMTP id
 98e67ed59e1d1-368f3bf7198mr5983966a91.10.1778721367051; 
 Wed, 13 May 2026 18:16:07 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600c3sm4982575ad.29.2026.05.13.18.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 18:16:06 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 4/6] hw/riscv: Add Sophgo CV1800B SoC support
Date: Thu, 14 May 2026 01:15:26 +0000
Message-ID: <20260514011528.1263665-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260514011528.1263665-1-visitorckw@gmail.com>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x1036.google.com
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
index 2518b04175..5b68991edb 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -138,3 +138,11 @@ config MIPS_BOSTON_AIA
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
     select RISCV_MIPS_CPS
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
index 533472e22a..04e25eeece 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -18,4 +18,6 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 
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
2.54.0.563.g4f69b47b94-goog


