Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C69C5AD44
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 18:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wslpy-0000He-EP; Sat, 08 Aug 2026 14:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslpn-0000E6-4r
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:31:51 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslpi-0007ej-4Z
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:31:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so509299a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786213904; x=1786818704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HoOkEzYDKO/Xal5qtsUzU1HJQnhe4L9PoxYoel78jqs=;
 b=Omewva1F3Sd+b0Egw+9GnuK3JQH48Lf0881bfFvRSl1xCq43zEGMW5RU9fJLT+nbWX
 VN7jG0su7UtoIDdch1L4PvzMjeHNt8FJ2I93vbDdV63lNYYDT7WnxXui8UUuVO4fEyRM
 yM2a5HAThqKgACg7fH15ZVVz43OQ/jqQWrPasl5Sp/U/Kc8GgoFY9j0szuXKCnRi9kN3
 W1rOIc7q3woxv62cdtlZxExVhBWwfFn/1QOe6xXF88GhIcQ7TAp7s3QZlUaaXQW0Zg+c
 tYQO5A36vLgfxc4g5zRFP0qrUeRMzHuPajQdkJnu+4k210xF3E4MOT7k6nUuRKITEa6S
 iVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786213904; x=1786818704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HoOkEzYDKO/Xal5qtsUzU1HJQnhe4L9PoxYoel78jqs=;
 b=fb5GzZCiPQcnsZgJCL2P8z+4aONG43G7ujZqyE2zqmGYBYidvhuDFxnaU+6U5k5b+6
 800IpXM2v65jd1n4vFjD/+lZH7upZCpRwHW9ChYMjwCkAjrqK8k8yhNa3thZCCSUJi0N
 a1kpBKw5AcFqcFXEY8jY7unYi6mOBgYhSKofrg10F/+CSwHoGFOGWEG6t4NLer4/nRYI
 SwEmYo0NLnwG9B5O1Lo7NWLNLwF1QAWX5D3CZGbVxPnaH+JR/whhsadQNQrerA/h3YYZ
 8w/7GmrPVBS7ZXfgech+zHaBy2P9iaosF3hGfK6ZNfy5VoYJIZJl39+1wFss/7cosbam
 X9sw==
X-Gm-Message-State: AOJu0YxMXqXqlx0QYVkaUS0WwDh95Kj1rZkM2/szgdP7wa3PB3mVVhj8
 WB/9GLNdBbZOLadvR2Qe4md0/xUjjW36DLe2rQcMCT+SfVrFOwlPAtKc2kgMqgpLE40SVg==
X-Gm-Gg: AR+sD10FqC3MFXsak+qim7lDkc3mvFZwdARz9WctU8d4CVA2Qy0CNjP5SIRtZlUIlvL
 FZqqNY0pGRO5jRE3IAdf7DenWLOW7lpm6CCSqCLOdvx42qWYHew3XvL0jTZsLSqkMeAyghwC3+V
 G6hE50/j8IBBPstp3h2PXlzct5X0/k4+t1hkNdqz7ooN63QdZPHEFpfamQh0IctJk7J5Qmoc9Lg
 zP1uEJVXcmIyxyPsmVO3Vi2OxWOcH9w5XOxWZ3MLdl3zgbq0FJKZ0jhEHzPem1GmkOMzfG38WzB
 J14yX8x7ArmdBJAv/bqkJgNvBGLy1bpvze33ezgQHKMEND6AU8c72+aMkd3Zgvh7k3JGO7+7xTL
 sYMDL0YY+ZNB9pCBZGj6tsVim3fLBDyQL1Z47G9WkYmUiNmGIoXTXUCYPuLhwJCymoQz3Q3smjP
 MZORgs5iiY9eOm7l83yng5KPKjUYAxHpXTcUAX3ebpRTc+byYKSe63qA0FVhAq4IP9lz9FEbSoY
 4Q9j5NYdc9swyQjHisIVoj3xih1
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id
 98e67ed59e1d1-3903c66ba04mr33575106a91.20.1786213904225; 
 Sat, 08 Aug 2026 11:31:44 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8a00:6035:79d0:50fd:3a6e:508:beb2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm6772393a91.2.2026.08.08.11.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 11:31:43 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 3/5] hw/riscv/k230: Instantiate DWC SSI controllers
Date: Sun,  9 Aug 2026 02:29:54 +0800
Message-ID: <20260808182956.290561-4-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1034.google.com
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

Instantiate the three DWC SSI profiles used by K230 and map their
controller MMIO regions at the documented addresses.

Configure the QSPI0, QSPI1, and SPI-OPI instances with their chip-select,
FIFO-depth, and interrupt-mask reset profiles.

Add K230 SSI qtests for Standard PIO transfers, register masks, FIFO
behaviour, interrupt state, unsupported-register semantics, and reset
profiles. K230 is used as the hardware carrier for the generic controller
tests; PLIC routing is added by the next patch.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst      |   1 +
 hw/riscv/Kconfig                |   1 +
 hw/riscv/k230.c                 |  76 ++++-
 include/hw/riscv/k230.h         |   2 +
 tests/qtest/k230-dwc-ssi-test.c | 574 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   4 +-
 6 files changed, 642 insertions(+), 16 deletions(-)
 create mode 100644 tests/qtest/k230-dwc-ssi-test.c

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..7a49cac95b 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* 3 K230 SSI controllers for SPI only
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..0bc0d18ca2 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select DWC_SSI
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..ea7eaa35a5 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -102,6 +102,40 @@ static const MemMapEntry memmap[] = {
     [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
 };
 
+typedef struct K230DwcSsiProfile {
+    uint32_t num_cs;
+    uint32_t fifo_depth;
+    uint32_t imr_reset;
+} K230DwcSsiProfile;
+
+static const K230DwcSsiProfile k230_dwc_ssi_profiles[] = {
+    [0] = { /* QSPI0, SDK spi1 */
+        .num_cs = 5,
+        .fifo_depth = 256,
+        .imr_reset = 0x0000001f,
+    },
+    [1] = { /* QSPI1, SDK spi2 */
+        .num_cs = 5,
+        .fifo_depth = 256,
+        .imr_reset = 0x0000001f,
+    },
+    [2] = { /* SPI-OPI/FMC, SDK spi0 */
+        .num_cs = 1,
+        .fifo_depth = 256,
+        .imr_reset = 0x0000003f,
+    },
+};
+
+static void k230_configure_dwc_ssi(DwcSsiState *ssi,
+                                   const K230DwcSsiProfile *profile)
+{
+    DeviceState *dev = DEVICE(ssi);
+
+    qdev_prop_set_uint32(dev, "num-cs", profile->num_cs);
+    qdev_prop_set_uint32(dev, "fifo-depth", profile->fifo_depth);
+    qdev_prop_set_uint32(dev, "imr-reset", profile->imr_reset);
+}
+
 static void k230_soc_init(Object *obj)
 {
     K230SoCState *s = RISCV_K230_SOC(obj);
@@ -110,6 +144,12 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-qspi0", &s->dwc_ssi[0],
+                            TYPE_DWC_SSI);
+    object_initialize_child(obj, "k230-qspi1", &s->dwc_ssi[1],
+                            TYPE_DWC_SSI);
+    object_initialize_child(obj, "k230-spi-opi", &s->dwc_ssi[2],
+                            TYPE_DWC_SSI);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -198,6 +238,13 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    for (int i = 0; i < ARRAY_SIZE(s->dwc_ssi); i++) {
+        k230_configure_dwc_ssi(&s->dwc_ssi[i], &k230_dwc_ssi_profiles[i]);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc_ssi[i]), errp)) {
+            return;
+        }
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
@@ -206,6 +253,20 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[0]), 0,
+                    memmap[K230_DEV_QSPI0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[1]), 0,
+                    memmap[K230_DEV_QSPI1].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[2]), 0,
+                    memmap[K230_DEV_SPI].base);
+
+    create_unimplemented_device("spi-flash-xip",
+                                memmap[K230_DEV_FLASH].base,
+                                memmap[K230_DEV_FLASH].size);
+
+    create_unimplemented_device("hi_sys", memmap[K230_DEV_HI_SYS_CFG].base,
+                                memmap[K230_DEV_HI_SYS_CFG].size);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -349,23 +410,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
                                 memmap[K230_DEV_SD1].size);
 
-    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
-                                memmap[K230_DEV_QSPI0].size);
-
-    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
-                                memmap[K230_DEV_QSPI1].size);
-
-    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
-                                memmap[K230_DEV_SPI].size);
-
-    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
-                                memmap[K230_DEV_HI_SYS_CFG].size);
-
     create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
                                 memmap[K230_DEV_DDRC_CFG].size);
-
-    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
-                                memmap[K230_DEV_FLASH].size);
 }
 
 static void k230_soc_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..cd30fd6aaa 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,6 +17,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/ssi/dwc_ssi.h"
 #include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    DwcSsiState dwc_ssi[3];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
new file mode 100644
index 0000000000..126b73ea01
--- /dev/null
+++ b/tests/qtest/k230-dwc-ssi-test.c
@@ -0,0 +1,574 @@
+/*
+ * QTest for the Kendryte K230 DesignWare SSI
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "qemu/units.h"
+
+#define K230_SPI0_BASE          0x91584000ULL
+#define K230_SPI1_BASE          0x91582000ULL
+#define K230_SPI2_BASE          0x91583000ULL
+#define K230_SSI_CTRLR0          0x000
+#define K230_SSI_CTRLR1          0x004
+#define K230_SSI_SSIENR          0x008
+#define K230_SSI_SER             0x010
+#define K230_SSI_BAUDR           0x014
+#define K230_SSI_TXFTLR          0x018
+#define K230_SSI_TXFLR           0x020
+#define K230_SSI_RXFLR           0x024
+#define K230_SSI_SR              0x028
+#define K230_SSI_IMR             0x02c
+#define K230_SSI_ISR             0x030
+#define K230_SSI_RISR            0x034
+#define K230_SSI_RXUICR          0x040
+#define K230_SSI_IDR             0x058
+#define K230_SSI_VERSION_ID      0x05c
+#define K230_SSI_DR0             0x060
+#define K230_SSI_SPI_CTRLR0      0x0f4
+#define K230_SSI_AXIECR          0x130
+#define K230_SSI_DONECR          0x134
+
+#define K230_SSI_CTRLR0_RESET           0x00004007U
+#define K230_SSI_IDR_RESET              0xa1b2c3d5U
+#define K230_SSI_VERSION_RESET          0x3130332aU
+
+#define K230_SSI_CTRLR0_WRITABLE_MASK   0x000f7f1fU
+#define K230_SSI_BAUDR_WRITABLE_MASK    0x0000fffeU
+
+#define K230_SSI_CTRLR0_DFS_MASK        0x1fU
+#define K230_SSI_CTRLR0_TMOD_SHIFT      10
+#define K230_SSI_CTRLR0_SRL             BIT(13)
+#define K230_SSI_CTRLR0_SPI_FRF_MASK    (3U << 22)
+#define K230_SSI_TXFTLR_TXFTHR_SHIFT     16
+#define K230_SSI_TMOD_TR                0
+#define K230_SSI_TMOD_TO                1
+#define K230_SSI_TMOD_RO                2
+#define K230_SSI_TMOD_EEPROM_READ       3
+
+#define K230_SSI_SR_BUSY                BIT(0)
+#define K230_SSI_SR_TFNF                BIT(1)
+#define K230_SSI_SR_TFE                 BIT(2)
+#define K230_SSI_SR_RFNE                BIT(3)
+
+#define K230_SSI_INT_TXE                BIT(0)
+#define K230_SSI_INT_TXO                BIT(1)
+#define K230_SSI_INT_RXO                BIT(3)
+#define K230_SSI_INT_RXU                BIT(2)
+#define K230_SSI_INT_RXF                BIT(4)
+#define K230_SSI_INT_DONE               BIT(11)
+#define K230_SSI_INT_AXIE               BIT(8)
+
+#define K230_SSI_RXFTLR                 0x01c
+#define K230_SSI_RXOICR                 0x03c
+#define K230_SSI_TXEICR                 0x038
+#define K230_SSI_ICR                    0x048
+#define K230_SSI_DMACR                  0x04c
+#define K230_SSI_XIP_MODE_BITS          0x0fc
+
+#define K230_SSI_FIFO_DEPTH             256
+
+typedef struct K230SsiInstance {
+    uint64_t base;
+    uint32_t num_cs;
+    uint32_t imr_reset;
+} K230SsiInstance;
+
+static const K230SsiInstance k230_ssi_instances[3] = {
+    {
+        .base = K230_SPI0_BASE,
+        .num_cs = 1,
+        .imr_reset = 0x0000003fU,
+    }, {
+        .base = K230_SPI1_BASE,
+        .num_cs = 5,
+        .imr_reset = 0x0000001fU,
+    }, {
+        .base = K230_SPI2_BASE,
+        .num_cs = 5,
+        .imr_reset = 0x0000001fU,
+    },
+};
+
+static QTestState *k230_ssi_start(void)
+{
+    return qtest_init("-machine k230");
+}
+
+static uint32_t k230_ssi_readl(QTestState *qts, uint64_t base,
+                               uint32_t offset)
+{
+    return qtest_readl(qts, base + offset);
+}
+
+static void k230_ssi_writel(QTestState *qts, uint64_t base,
+                            uint32_t offset, uint32_t value)
+{
+    qtest_writel(qts, base + offset, value);
+}
+
+static void k230_ssi_disable(QTestState *qts, uint64_t base)
+{
+    k230_ssi_writel(qts, base, K230_SSI_SSIENR, 0);
+}
+
+static void k230_ssi_configure(QTestState *qts, uint64_t base,
+                               uint32_t tmod, uint32_t dfs_bits,
+                               uint32_t ndf)
+{
+    uint32_t ctrlr0;
+
+    g_assert_cmpuint(dfs_bits, >=, 4);
+    g_assert_cmpuint(dfs_bits, <=, 32);
+    g_assert_cmpuint(tmod, <=, K230_SSI_TMOD_EEPROM_READ);
+
+    k230_ssi_disable(qts, base);
+    ctrlr0 = (dfs_bits - 1) & K230_SSI_CTRLR0_DFS_MASK;
+    ctrlr0 |= tmod << K230_SSI_CTRLR0_TMOD_SHIFT;
+    k230_ssi_writel(qts, base, K230_SSI_CTRLR0, ctrlr0);
+    k230_ssi_writel(qts, base, K230_SSI_CTRLR1, ndf);
+    k230_ssi_writel(qts, base, K230_SSI_BAUDR, 2);
+}
+
+static void k230_ssi_enable_cs(QTestState *qts, uint64_t base, uint32_t ser)
+{
+    k230_ssi_writel(qts, base, K230_SSI_SER, ser);
+    k230_ssi_writel(qts, base, K230_SSI_SSIENR, 1);
+}
+
+static void k230_ssi_write_frame(QTestState *qts, uint64_t base,
+                                 uint32_t value)
+{
+    k230_ssi_writel(qts, base, K230_SSI_DR0, value);
+}
+
+static uint32_t k230_ssi_read_frame(QTestState *qts, uint64_t base)
+{
+    return k230_ssi_readl(qts, base, K230_SSI_DR0);
+}
+
+static void k230_ssi_wait_mask(QTestState *qts, uint64_t base,
+                               uint32_t offset, uint32_t mask,
+                               uint32_t expected)
+{
+    for (int i = 0; i < 1000; i++) {
+        uint32_t value = k230_ssi_readl(qts, base, offset);
+
+        if ((value & mask) == expected) {
+            return;
+        }
+        qtest_clock_step(qts, 1000);
+    }
+
+    g_assert_cmphex(k230_ssi_readl(qts, base, offset) & mask,
+                    ==, expected);
+}
+
+static void configure_loopback(QTestState *qts, uint32_t tmod,
+                               uint32_t ndf)
+{
+    uint32_t ctrlr0;
+
+    k230_ssi_configure(qts, K230_SPI1_BASE, tmod, 8, ndf);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0,
+                    ctrlr0 | K230_SSI_CTRLR0_SRL);
+}
+
+static void test_register_contract(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    for (int i = 0; i < ARRAY_SIZE(k230_ssi_instances); i++) {
+        const K230SsiInstance *inst = &k230_ssi_instances[i];
+
+        g_assert_cmphex(k230_ssi_readl(qts, inst->base, K230_SSI_CTRLR0),
+                        ==, K230_SSI_CTRLR0_RESET);
+        g_assert_cmphex(k230_ssi_readl(qts, inst->base, K230_SSI_SSIENR),
+                        ==, 0);
+        g_assert_cmphex(k230_ssi_readl(qts, inst->base,
+                                      K230_SSI_SPI_CTRLR0),
+                        ==, 0);
+        g_assert_cmphex(k230_ssi_readl(qts, inst->base, K230_SSI_IMR),
+                        ==, inst->imr_reset);
+        k230_ssi_writel(qts, inst->base, K230_SSI_SER, UINT32_MAX);
+        g_assert_cmphex(k230_ssi_readl(qts, inst->base, K230_SSI_SER),
+                        ==, MAKE_64BIT_MASK(0, inst->num_cs));
+    }
+
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_IDR),
+                    ==, K230_SSI_IDR_RESET);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE,
+                                  K230_SSI_VERSION_ID),
+                    ==, K230_SSI_VERSION_RESET);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0, UINT32_MAX);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0),
+                    ==, K230_SSI_CTRLR0_WRITABLE_MASK);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0,
+                    K230_SSI_CTRLR0_RESET | K230_SSI_CTRLR0_SPI_FRF_MASK);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0) &
+                    K230_SSI_CTRLR0_SPI_FRF_MASK, ==, 0);
+    /* SSTE is R/W per TRM; the frame-boundary toggle is not modelled. */
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0,
+                    K230_SSI_CTRLR0_RESET & ~BIT(14));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0) &
+                    BIT(14), ==, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_BAUDR, UINT32_MAX);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_BAUDR),
+                    ==, K230_SSI_BAUDR_WRITABLE_MASK);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0),
+                    ==, K230_SSI_CTRLR0_RESET);
+    qtest_quit(qts);
+}
+
+static void test_pio_data_path(void)
+{
+    QTestState *qts = k230_ssi_start();
+    uint32_t status;
+
+    configure_loopback(qts, K230_SSI_TMOD_TR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_SR,
+                       K230_SSI_SR_RFNE, K230_SSI_SR_RFNE);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0xa5);
+
+    configure_loopback(qts, K230_SSI_TMOD_RO, 3);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, 4);
+    for (int i = 0; i < 4; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0xa5);
+    }
+
+    k230_ssi_disable(qts, K230_SPI1_BASE);
+    status = k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR);
+    g_assert_cmpuint(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                     ==, 0);
+    g_assert_cmphex(status & (K230_SSI_SR_BUSY | K230_SSI_SR_TFNF |
+                              K230_SSI_SR_TFE | K230_SSI_SR_RFNE),
+                    ==, K230_SSI_SR_TFNF | K230_SSI_SR_TFE);
+    qtest_quit(qts);
+}
+
+static void test_interrupt_controller(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    k230_ssi_configure(qts, K230_SPI1_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_TXE, ==, K230_SSI_INT_TXE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_TXE, ==, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_TXE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_TXE, ==, K230_SSI_INT_TXE);
+
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_IMR,
+                    K230_SSI_INT_RXU);
+    (void)k230_ssi_read_frame(qts, K230_SPI1_BASE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, K230_SSI_INT_RXU);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_RXU, ==, K230_SSI_INT_RXU);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXUICR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_AXIECR, UINT32_MAX);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_DONECR, UINT32_MAX);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_AXIECR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_DONECR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    (K230_SSI_INT_DONE | K230_SSI_INT_AXIE), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_tx_only_mode(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    configure_loopback(qts, K230_SSI_TMOD_TO, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x55);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_TFE, ==, K230_SSI_SR_TFE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 0);
+
+    configure_loopback(qts, K230_SSI_TMOD_TO, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR,
+                    (K230_SSI_FIFO_DEPTH - 1) <<
+                    K230_SSI_TXFTLR_TXFTHR_SHIFT);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    for (int i = 0; i < K230_SSI_FIFO_DEPTH; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, i);
+    }
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(0));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, K230_SSI_FIFO_DEPTH - 64);
+    for (int i = 0; i < 64; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, i);
+    }
+    for (int i = 0; i < 4; i++) {
+        if (k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR) == 0) {
+            break;
+        }
+        (void)k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_eeprom_read_contract(void)
+{
+    QTestState *qts = k230_ssi_start();
+    const int frames = K230_SSI_FIFO_DEPTH + 4;
+
+    configure_loopback(qts, K230_SSI_TMOD_EEPROM_READ, 3);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x03);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(0));
+    /* EEPROM data must start without a status read driving the engine. */
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_ISR,
+                       K230_SSI_INT_RXF, K230_SSI_INT_RXF);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 4);
+    for (int i = 0; i < 4; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0);
+    }
+
+    configure_loopback(qts, K230_SSI_TMOD_EEPROM_READ, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x03);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(0));
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, 1);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0);
+
+    configure_loopback(qts, K230_SSI_TMOD_EEPROM_READ, frames - 1);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SSIENR, 1);
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x03);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(0));
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, K230_SSI_FIFO_DEPTH);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, K230_SSI_SR_BUSY);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH);
+    for (int i = 1; i < frames; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_rx_fifo_overflow(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    configure_loopback(qts, K230_SSI_TMOD_TR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    for (int i = 0; i < K230_SSI_FIFO_DEPTH; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    }
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR,
+                    (K230_SSI_FIFO_DEPTH - 1) <<
+                    K230_SSI_TXFTLR_TXFTHR_SHIFT);
+    for (int i = 0; i < K230_SSI_FIFO_DEPTH; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, K230_SSI_INT_RXO);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE,
+                                  K230_SSI_RXOICR), ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+
+    configure_loopback(qts, K230_SSI_TMOD_RO, K230_SSI_FIFO_DEPTH + 3);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, K230_SSI_SR_BUSY);
+    g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0xa5);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH);
+    for (int i = 1; i < K230_SSI_FIFO_DEPTH + 4; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI1_BASE), ==, 0xa5);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_txfthr_start_gate(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    /* TXFTHR=4: transfer starts only once 5+ frames are queued. */
+    k230_ssi_configure(qts, K230_SPI1_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_TXFTLR, 4 << 16);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x11);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 0);
+
+    for (int i = 0; i < 4; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x22 + i);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 5);
+    qtest_quit(qts);
+}
+
+static void test_baudr_zero(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    /* SCKDV=0 disables sclk_out: queued frames must not be shifted out. */
+    k230_ssi_configure(qts, K230_SPI1_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_BAUDR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_ser_terminates_ro(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    /*
+     * RO transfer with NDF larger than the RX FIFO: after the FIFO
+     * fills, SER=0 must terminate the pending transaction.  Re-selecting
+     * the slave must not resume receiving the stale remaining frames
+     * without a new dummy word.
+     */
+    k230_ssi_configure(qts, K230_SPI1_BASE, K230_SSI_TMOD_RO, 8, 0xffff);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI1_BASE, 0);
+    k230_ssi_wait_mask(qts, K230_SPI1_BASE, K230_SSI_RXFLR,
+                       UINT32_MAX, K230_SSI_FIFO_DEPTH);
+
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, 0);
+    (void)k230_ssi_read_frame(qts, K230_SPI1_BASE);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH - 1);
+
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(0));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH - 1);
+
+    /* A direct BIT(0) -> BIT(1) switch must also terminate the tx. */
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_SER, BIT(1));
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RXFLR),
+                    ==, K230_SSI_FIFO_DEPTH - 1);
+    qtest_quit(qts);
+}
+
+static void test_icr_total_clear(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    configure_loopback(qts, K230_SSI_TMOD_TR, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    (void)k230_ssi_read_frame(qts, K230_SPI1_BASE); /* latch RXU */
+    for (int i = 0; i < K230_SSI_FIFO_DEPTH + 1; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, 0xa5);
+    }
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, K230_SSI_INT_RXU);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE,
+                                  K230_SSI_ICR), ==, 1);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXU, ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
+                    K230_SSI_INT_RXO, ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_unsupported_registers(void)
+{
+    QTestState *qts = k230_ssi_start();
+    static const uint32_t unsupported[] = {
+        K230_SSI_DMACR, K230_SSI_XIP_MODE_BITS, K230_SSI_SPI_CTRLR0,
+    };
+
+    for (size_t i = 0; i < ARRAY_SIZE(unsupported); i++) {
+        uint32_t off = unsupported[i];
+
+        g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, off), ==, 0);
+        k230_ssi_writel(qts, K230_SPI1_BASE, off, UINT32_MAX);
+        g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, off), ==, 0);
+    }
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-dwc-ssi/register-contract", test_register_contract);
+    qtest_add_func("/k230-dwc-ssi/pio-data-path", test_pio_data_path);
+    qtest_add_func("/k230-dwc-ssi/interrupt-controller",
+                   test_interrupt_controller);
+    qtest_add_func("/k230-dwc-ssi/tx-only-mode", test_tx_only_mode);
+    qtest_add_func("/k230-dwc-ssi/eeprom-read-contract",
+                   test_eeprom_read_contract);
+    qtest_add_func("/k230-dwc-ssi/rx-fifo-overflow", test_rx_fifo_overflow);
+    qtest_add_func("/k230-dwc-ssi/txfthr-start-gate", test_txfthr_start_gate);
+    qtest_add_func("/k230-dwc-ssi/baudr-zero", test_baudr_zero);
+    qtest_add_func("/k230-dwc-ssi/ser-terminates-ro", test_ser_terminates_ro);
+    qtest_add_func("/k230-dwc-ssi/icr-total-clear", test_icr_total_clear);
+    qtest_add_func("/k230-dwc-ssi/unsupported-registers",
+                   test_unsupported_registers);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..43ad1596e6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-wdt-test', 'k230-dwc-ssi-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
@@ -400,6 +401,7 @@ qtests = {
                        [gio],
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+   'k230-dwc-ssi-test': files('k230-dwc-ssi-test.c'),
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
-- 
2.43.0


