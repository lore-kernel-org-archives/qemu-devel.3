Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49k-0005Xz-EH; Mon, 05 Aug 2024 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eDOxZgUKCt8UBWJQHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--tavip.bounces.google.com>)
 id 1sb49f-0004pH-2u
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:07 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eDOxZgUKCt8UBWJQHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--tavip.bounces.google.com>)
 id 1sb49a-0001Xg-NC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:06 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-68dcbd6135dso64352827b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889080; x=1723493880; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4u1P5SIla3BTMDBQNng926h7zNREK6etGIfsOHcMKR0=;
 b=W+xt1ui9C6SahVsxDgI27zBE7YqWEYkpfFj86gqECR5HYzPT7azq4OWpIdNglB2YMP
 kMhr2itAneQh2CK+A+31gHSQp7G0JrihO7SrJGa8gXBn00+3vGofgf8dtdgITXOkI/Wi
 Hqs1cb6tBFkUUlOu8H02tSY0w93TZIvV6nYv5lCSZodmSjDiKtijxaRoRBfKRTaTzICF
 D9NEmivVV9xKr9EFaFke56qulBi2leOv//RMwe8IIiuQeZMBgcSu8mApkanTTnnkMAUQ
 bnm/hXOS7R0Lu7TOqdEqaFVXb+xIHCB7V1QWh78oiDnCs5Hd1MYAXLKKFcCBTgtHKEIi
 VmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889080; x=1723493880;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4u1P5SIla3BTMDBQNng926h7zNREK6etGIfsOHcMKR0=;
 b=dN914UHnS8+emjSLvBA7HKV0vu2qDqt9OLGXHWauE+WIJaxR/ORCkzzFjwuEIigH+s
 d4XMMY1iWHx9CJiSFoe30h9R+E/6ympTqEadhRHM6S8C80y2aM2fVJ8ZAKYoeFxzYC4w
 ktVaPWZBgPw5lVkC34HJql6gmxx8OYqqEV/7h0gPEBfmUoU5IUQ5tYmSbdyN7a+xpjPw
 Hi37Yxj6PUhBZZ+oisB9U5/PJACTnTOiLm15ycODBCUmdCOaz2jwvgurdh0Xjbvr8KQV
 i3AgNMUn3G+qQuXwq+wRB36FXYBKeSde8crOPxK0LAnEVhEPcppjb5vdKTJzTnXcDzgv
 6Zsw==
X-Gm-Message-State: AOJu0YyVHHVFwYzJsq0zz+hyvWNftnKg4wNNo0YDJRYYBrxlIGpQNonm
 vv0IVfnquiraY3mZXipcVvwYKmQtdN10JoBxEUuKtzK+1NmnwgU/FUe5qMAPiOBRY6X88Sz21Xr
 xOyrzkPpVCAm+5KP+y+YEGP82iXca+k4203jG4aY80w1NyTVr9IWzD3nT3x42PR9jm9hr+t1yio
 YAeNAQy4kN6/EmSyp5DMKuCIEQ0Q==
X-Google-Smtp-Source: AGHT+IETKmxMUfzjPk4qDciUlfp9GgJp/XDZSs4LIyahMhe5QVAt6LybinSSK4kDNRuQBJAnL26S8NRD1Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:660d:b0:691:2f66:4af9
 with SMTP id
 00721157ae682-6912f664f8amr3358477b3.4.1722889080107; Mon, 05 Aug 2024
 13:18:00 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:17 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-23-tavip@google.com>
Subject: [RFC PATCH 22/23] hw/arm: add basic support for the RT500 SoC
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3eDOxZgUKCt8UBWJQHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add basic support for the RT500 SoC. It supports enough peripherals to
run the NXP's microXpresso SDK hello world example.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/Kconfig         |   8 +
 hw/arm/meson.build     |   1 +
 hw/arm/rt500.c         | 348 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/svd/meson.build |   6 +
 include/hw/arm/rt500.h |  49 ++++++
 5 files changed, 412 insertions(+)
 create mode 100644 hw/arm/rt500.c
 create mode 100644 include/hw/arm/rt500.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..7ffece3dec 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -712,3 +712,11 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config RT500
+    bool
+    select FLEXCOMM
+    select RT500_CLKCTL0
+    select RT500_CLKCTL1
+    select FLEXSPI
+    select RT500_RSTCTL
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index eb604d00cf..7d827d512c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/hw/arm/rt500.c b/hw/arm/rt500.c
new file mode 100644
index 0000000000..0866ef3ef6
--- /dev/null
+++ b/hw/arm/rt500.c
@@ -0,0 +1,348 @@
+/*
+ * i.MX RT500 platforms.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/arm/boot.h"
+#include "hw/boards.h"
+#include "hw/irq.h"
+#include "qemu/log.h"
+#include "qemu/datadir.h"
+#include "exec/address-spaces.h"
+#include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/armv7m.h"
+#include "hw/loader.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/rt500.h"
+#include "hw/arm/svd/rt500.h"
+
+#define MMAP_SRAM_CODE_BASE   (0x0)
+#define MMAP_SRAM_DATA_BASE   (0x20000000)
+#define MMAP_SRAM_SIZE        (5 * MiB)
+#define MMAP_BOOT_ROM_BASE    (0x03000000)
+#define MMAP_BOOT_ROM_SIZE    (192 * KiB)
+#define MMAP_SDMA_RAM_BASE    (0x24100000)
+#define MMAP_SDMA_RAM_SIZE    (32 * KiB)
+#define MMAP_FLEXSPI0_BASE    (0x08000000)
+#define MMAP_FLEXSPI0_SIZE    (128 * MiB)
+#define MMAP_FLEXSPI1_BASE    (0x28000000)
+#define MMAP_FLEXSPI1_SIZE    (128 * MiB)
+
+#define SECURE_OFFSET    (0x10000000)
+
+typedef enum MemInfoType {
+    MEM_RAM,
+    MEM_ROM,
+    MEM_ALIAS
+} MemInfoType;
+
+static void do_sys_reset(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static void rt500_init(Object *obj)
+{
+    RT500State *s = RT500(obj);
+    int i;
+
+    /* Add ARMv7-M device */
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    for (i = 0; i < RT500_FLEXCOMM_NUM; i++) {
+        char id[] = "flexcommXX";
+
+        snprintf(id, sizeof(id), "flexcomm%d", i);
+        object_initialize_child(obj, id, &s->flexcomm[i], TYPE_FLEXCOMM);
+        DEVICE(&s->flexcomm[i])->id = g_strdup(id);
+    }
+
+    object_initialize_child(obj, "clkctl0", &s->clkctl0, TYPE_RT500_CLKCTL0);
+    object_initialize_child(obj, "clkctl1", &s->clkctl1, TYPE_RT500_CLKCTL1);
+
+    /* Initialize clocks */
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+
+    for (i = 0; i < RT500_FLEXSPI_NUM; i++) {
+        char id[] = "flexspiXX";
+
+        snprintf(id, sizeof(id), "flexspi%d", i);
+        object_initialize_child(obj, id, &s->flexspi[i], TYPE_FLEXSPI);
+        DEVICE(&s->flexspi[i])->id = g_strdup(id);
+    }
+
+    for (i = 0; i < RT500_RSTCTL_NUM; i++) {
+        char id[] = "rstctlX";
+
+        snprintf(id, sizeof(id), "rstctl%d", i);
+        object_initialize_child(obj, id, &s->rstctl[i],
+                                TYPE_RT500_RSTCTL);
+        DEVICE(&s->rstctl[i])->id = g_strdup(id);
+    }
+}
+
+static void rt500_realize_memory(RT500State *s, Error **errp)
+{
+    const struct {
+        const char *name;
+        hwaddr base;
+        size_t size;
+        MemInfoType type;
+        int alias_for;
+    } mem_info[] = {
+        {
+            .name = "SRAM (code bus)",
+            .base = MMAP_SRAM_CODE_BASE,
+            .size = MMAP_SRAM_SIZE,
+            .type = MEM_RAM,
+        },
+        {
+            .name = "BOOT-ROM",
+            .base = MMAP_BOOT_ROM_BASE,
+            .size = MMAP_BOOT_ROM_SIZE,
+            .type = MEM_ROM,
+        },
+        {
+            .name = "Smart DMA RAM",
+            .base = MMAP_SDMA_RAM_BASE,
+            .size = MMAP_SDMA_RAM_SIZE,
+            .type = MEM_RAM,
+        },
+        {
+            .name = "SRAM (data bus)",
+            .base = MMAP_SRAM_DATA_BASE,
+            .size = MMAP_SRAM_SIZE,
+            .type = MEM_ALIAS,
+            .alias_for = 0
+        },
+    };
+    int i;
+
+    s->mem = g_malloc_n(2 * ARRAY_SIZE(mem_info), sizeof(MemoryRegion));
+    for (i = 0; i < ARRAY_SIZE(mem_info); i++) {
+        const char *name = mem_info[i].name;
+        int size = mem_info[i].size;
+        int type = mem_info[i].type;
+        int alias_for = mem_info[i].alias_for;
+        MemoryRegion *mem = &s->mem[i];
+        uint32_t base = mem_info[i].base;
+        MemoryRegion *sec_mem;
+        char sec_name[256];
+
+        switch (type) {
+        case MEM_RAM:
+            memory_region_init_ram(mem, OBJECT(s), name, size, errp);
+            break;
+        case MEM_ROM:
+            memory_region_init_rom(mem, OBJECT(s), name, size, errp);
+            break;
+        case MEM_ALIAS:
+        {
+            MemoryRegion *orig = &s->mem[alias_for];
+
+            memory_region_init_alias(mem, OBJECT(s), name, orig, 0, size);
+            break;
+        }
+        default:
+            g_assert_not_reached();
+        }
+
+        memory_region_add_subregion(get_system_memory(), base, mem);
+
+        /* create secure alias */
+        snprintf(sec_name, sizeof(sec_name), "SECURE %s", name);
+        sec_mem = &s->mem[ARRAY_SIZE(mem_info) + i];
+        if (type == MEM_ALIAS) {
+            mem = &s->mem[alias_for];
+        }
+        memory_region_init_alias(sec_mem, OBJECT(s), sec_name, mem, 0, size);
+        memory_region_add_subregion(get_system_memory(), base + SECURE_OFFSET,
+                                    sec_mem);
+
+        if (mem_info[i].type == MEM_ROM) {
+            char *fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, "rt500.rom");
+
+            if (fname) {
+                int fsize = get_image_size(fname);
+                int ret;
+
+                if (fsize > size) {
+                    error_setg(errp, "rom file too big: %d > %d", fsize, size);
+                } else {
+                    ret = load_image_targphys(fname, base, size);
+                    if (ret < 0) {
+                        error_setg(errp, "could not load rom: %s", fname);
+                    }
+                }
+            }
+            g_free(fname);
+        }
+    }
+}
+
+static void rt500_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    RT500State *s = RT500(dev);
+    int i;
+
+    rt500_realize_memory(s, errp);
+
+    /* Setup ARMv7M CPU */
+    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq",
+                         RT500_FLEXCOMM16_IRQn + 1);
+    qdev_prop_set_uint8(DEVICE(&s->armv7m), "num-prio-bits", 3);
+    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type", ms->cpu_type);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    if (!ms->kernel_filename) {
+        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-nsvtor",
+                             MMAP_BOOT_ROM_BASE);
+        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-svtor",
+                             MMAP_BOOT_ROM_BASE + SECURE_OFFSET);
+    }
+
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "refclk",
+                     qdev_get_clock_out(DEVICE(&s->clkctl0), "systick_clk"));
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->armv7m), errp);
+    qdev_connect_gpio_out_named(DEVICE(&s->armv7m), "SYSRESETREQ", 0,
+                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
+
+    /* Setup FLEXCOMM */
+    for (i = 0; i < RT500_FLEXCOMM_NUM; i++) {
+        const uint32_t addr[] = {
+            RT500_FLEXCOMM0_BASE, RT500_FLEXCOMM1_BASE, RT500_FLEXCOMM2_BASE,
+            RT500_FLEXCOMM3_BASE, RT500_FLEXCOMM4_BASE, RT500_FLEXCOMM5_BASE,
+            RT500_FLEXCOMM6_BASE, RT500_FLEXCOMM7_BASE, RT500_FLEXCOMM8_BASE,
+            RT500_FLEXCOMM8_BASE, RT500_FLEXCOMM10_BASE, RT500_FLEXCOMM11_BASE,
+            RT500_FLEXCOMM12_BASE, RT500_FLEXCOMM13_BASE, RT500_FLEXCOMM14_BASE,
+            RT500_FLEXCOMM15_BASE, RT500_FLEXCOMM16_BASE
+        };
+        const int irq[] = {
+            RT500_FLEXCOMM0_IRQn, RT500_FLEXCOMM1_IRQn, RT500_FLEXCOMM2_IRQn,
+            RT500_FLEXCOMM3_IRQn, RT500_FLEXCOMM4_IRQn, RT500_FLEXCOMM5_IRQn,
+            RT500_FLEXCOMM6_IRQn, RT500_FLEXCOMM7_IRQn, RT500_FLEXCOMM8_IRQn,
+            RT500_FLEXCOMM9_IRQn, RT500_FLEXCOMM10_IRQn, RT500_FLEXCOMM11_IRQn,
+            RT500_FLEXCOMM12_IRQn, RT500_FLEXCOMM13_IRQn, RT500_FLEXCOMM14_IRQn,
+            RT500_FLEXCOMM15_IRQn, RT500_FLEXCOMM16_IRQn
+        };
+        const int functions[] = {
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
+            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_HSSPI,
+            FLEXCOMM_PMICI2C, FLEXCOMM_HSSPI
+        };
+        DeviceState *ds = DEVICE(&s->flexcomm[i]);
+        char id[] = "flexcommXX";
+
+        snprintf(id, sizeof(id), "flexcomm%d", i);
+        qdev_prop_set_uint32(ds, "functions", functions[i]);
+        qdev_prop_set_chr(ds, "chardev", qemu_chr_find(id));
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(ds), 0,
+                           qdev_get_gpio_in(DEVICE(&s->armv7m), irq[i]));
+    }
+
+    /* Setup CTLCTL0 */
+    qdev_connect_clock_in(DEVICE(&s->clkctl0), "sysclk", s->sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), 0, RT500_CLKCTL0_BASE);
+
+    /* Setup CTLCTL1 */
+    qdev_connect_clock_in(DEVICE(&s->clkctl1), "sysclk", s->sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), 0, RT500_CLKCTL1_BASE);
+
+    /* Setup FlexSPI */
+    for (i = 0; i < RT500_FLEXSPI_NUM; i++) {
+        const uint32_t addr[] = {
+            RT500_FLEXSPI0_BASE, RT500_FLEXSPI1_BASE
+        };
+        const uint32_t mmap_base[] = {
+            MMAP_FLEXSPI0_BASE, MMAP_FLEXSPI1_BASE
+        };
+        const uint32_t mmap_size[] = {
+            MMAP_FLEXSPI0_SIZE, MMAP_FLEXSPI1_SIZE,
+        };
+        DeviceState *ds = DEVICE(&s->flexspi[i]);
+
+        qdev_prop_set_uint32(ds, "mmap_base", mmap_base[i]);
+        qdev_prop_set_uint32(ds, "mmap_size", mmap_size[i]);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+    }
+
+    /* Setup reset controllers */
+    for (i = 0; i < RT500_RSTCTL_NUM; i++) {
+        DeviceState *ds = DEVICE(&s->rstctl[i]);
+
+        const uint32_t addr[] = {
+            RT500_RSTCTL0_BASE, RT500_RSTCTL1_BASE
+        };
+
+        qdev_prop_set_uint32(ds, "num", i);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
+    }
+}
+
+static void rt500_finalize(Object *obj)
+{
+    RT500State *s = RT500(obj);
+
+    g_free(s->mem);
+}
+
+static void rt500_reset(DeviceState *ds)
+{
+}
+
+static Property rt500_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rt500_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, rt500_properties);
+    dc->realize = rt500_realize;
+    dc->desc = "RT500 (ARM Cortex-M33)";
+    dc->reset = rt500_reset;
+}
+
+static const TypeInfo rt500_type_info = {
+    .name = TYPE_RT500,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RT500State),
+    .instance_init = rt500_init,
+    .instance_finalize = rt500_finalize,
+    .class_init = rt500_class_init,
+};
+
+static void rt500_register_types(void)
+{
+    type_register_static(&rt500_type_info);
+}
+
+type_init(rt500_register_types)
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 72a7421c6f..930a8b7343 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -34,3 +34,9 @@ genh += custom_target('rt500_rstctl1.h',
                       output: 'rt500_rstctl1.h',
                       input: 'MIMXRT595S_cm33.xml',
                       command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'RSTCTL1', '-t', 'RT500_RSTCTL1'])
+genh += custom_target('rt500.h',
+                      output: 'rt500.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header,'-i', '@INPUT@', '-o', '@OUTPUT@', '-s', 'RT500',
+		                 '-p', 'FLEXCOMM0', '-p', 'CLKCTL0', '-p', 'CLKCTL1',
+				 '-p', 'FLEXSPI0', '-p', 'FLEXSPI1', '-p', 'RSTCTL0', '-p', 'RSTCTL1'])
diff --git a/include/hw/arm/rt500.h b/include/hw/arm/rt500.h
new file mode 100644
index 0000000000..8ca7972f8a
--- /dev/null
+++ b/include/hw/arm/rt500.h
@@ -0,0 +1,49 @@
+/*
+ * i.MX RT500 platforms.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef HW_ARM_RT500_H
+#define HW_ARM_RT500_H
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/armv7m.h"
+#include "hw/misc/flexcomm.h"
+#include "hw/misc/rt500_clkctl0.h"
+#include "hw/misc/rt500_clkctl1.h"
+#include "hw/ssi/flexspi.h"
+#include "hw/misc/rt500_rstctl.h"
+
+#define TYPE_RT500 "rt500"
+#define RT500(obj) OBJECT_CHECK(RT500State, (obj), TYPE_RT500)
+
+#define RT500_FLEXCOMM_NUM (17)
+#define RT500_FLEXSPI_NUM (2)
+#define RT500_RSTCTL_NUM (2)
+
+typedef struct RT500State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    ARMv7MState armv7m;
+    MemoryRegion *mem;
+    FlexcommState flexcomm[RT500_FLEXCOMM_NUM];
+    RT500ClkCtl0State clkctl0;
+    RT500ClkCtl1State clkctl1;
+    FlexSpiState flexspi[RT500_FLEXSPI_NUM];
+    RT500RstCtlState rstctl[RT500_RSTCTL_NUM];
+
+    Clock *sysclk;
+    Clock *refclk;
+} RT500State;
+
+#endif /* HW_ARM_RT500_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


