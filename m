Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F92C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zwd-0001pz-Cg; Mon, 31 Aug 2026 07:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwc-0001pg-4G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1x0zwY-0003Eb-Gn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:12:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-854f8068301so1949691b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788174769; x=1788779569; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jAJJ4hsDhig6g2rKa3iQToV8WIMDpaQd8tesI1K/Ozc=;
 b=C+uI5qJl3eA1ebFvTuIaiihnvQXnlN6Tzic2TkpbO3gw2MEe5uFkPb9l1/u67NqB/X
 jEI2wtg13oQBr7Ncl44slYKI9t0oLTdSNXVEZTHOVxoUVbbSyDM+pbj0QO3r3GvlFVK3
 xp3s7zjlNZ5zUS8slWKXtQyJ+zAyYFxz0x/Rd7SR7KvPaHdzTXvUK36hbqS01jWNNwjf
 5whauERTO/1HxRX6JiKIPZvdzKq7ENUN0+fwU/cKBYAoTOxucHB7FF9GTuNuCllq+4Iv
 EWTX7dtuCggjn/e4P+uhmBiPDNdqfQfL90eS0iXWnmoPTOtsoHUvlVNTqGXNHogmJoMy
 okoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788174769; x=1788779569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jAJJ4hsDhig6g2rKa3iQToV8WIMDpaQd8tesI1K/Ozc=;
 b=jVjdAabx2xTzziMaZzh2r0VMaJVapCgiDrQ0GBXeHIIgrGawqAsG2U/VzNhMX34rwB
 unQihe7WAmpwU/dTy5jz+aq6t89smw8vHcKeynxETcVyuLtKPgwMP48A8omSUlgxMwWn
 V5bvDvHoRz9p/R1eDQZq42Lo1uZGg/pkdZ6+6hhlzoWI/88sdUm9XN93zy0Hkffkqzjn
 I1N/8DJvsAzUOwjEXYULPwOsiHSLKhir1yWlwxTtHGfDaKHjpv3Zk0aE+i9OxtfvwmYN
 mIEmcsLc12Rz0JR7mU7SyCre5mpLzbTblS/IIfKuG4anDAPzprXEiNhboq65wt4/DMkA
 +PjA==
X-Gm-Message-State: AFuF++njmDYOskqyIrz2i5H8CWvIGsS69iClmzt7Ip/XhcccTMUsbxCD
 5gtw84ZyGGCpdQYm32LLCoDdzTwSXbXYYNC7MqFYloeYbFEoWmI+e59f
X-Gm-Gg: AR+sD12RbELi/Go+GPZKTpw9ppIB69BX0e5IekmaoMdfpldqxNujcbYCAx8QgieUhLo
 vbfoiJ8c4HsbT0/XUh0HZrqJosX0eCv3t4gs90AQNhLR2bEo6sHdsHFJ9H0lzl5EMZ1xSIAbJQH
 +gXZe9bOBTJULSCtmo9TMMkYLugF7p4sWc+KJMYB91JTHNJrcfdACkYiNgRy5/V3lO+Gqw+WbdI
 4wgdjt+eG+hXJYTRXDeO5kozvPOdwZ7bk2rZ6prSP3VWH42/KJ5N2Eoed8W6/IYAVkh2wN0aPD4
 M/dcBZiDzPbQ0r9pihHgyiH/UP7LfsnH2dWPHkxFmirE4J2g5zgUmVkPjTojewN8bPelrIdxIER
 6fFQRtzbxE4wgyb6J3P8GZy99LEEf0UxXwKWcwolYuoJi6WyI8auvFUCTBfWp6XDnRR/g615lpr
 2k6lApc0aNIacJnDIdnpDMS9JCf03QimGrejrMfMln6bZYJphVC/9Cta/2UOzMVdTOjim8sJfSa
 03sEuwTHrGMYfH022WY0DIQRw==
X-Received: by 2002:a05:6a00:2988:b0:857:727c:a1f7 with SMTP id
 d2e1a72fcca58-857727ca3f7mr27704618b3a.25.1788174768806; 
 Mon, 31 Aug 2026 04:12:48 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:7ad7:8121:d841:db7e:846b:ea5e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a397d927sm3367329b3a.54.2026.08.31.04.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 04:12:48 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Mon, 31 Aug 2026 19:11:13 +0800
Subject: [PATCH v4 2/3] hw/riscv/k230: Instantiate DWC SSI controllers and
 route IRQs to PLIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-t_v4_spi_patch-v4-2-370d416f26b5@gmail.com>
References: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
In-Reply-To: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
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
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42c.google.com
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

Instantiate the three DWC SSI profiles used on the K230 and map each
controller's MMIO region at the documented address.

Configure the chip-select count, FIFO depth and master-mode setting used
to derive the IMR reset value for the QSPI0, QSPI1 and SPI-OPI
instances.

Wire the nine interrupt outputs of each K230 DWC SSI controller to the
PLIC source range given in the documentation. The TXU, DONE and AXIE
lines are wired to preserve the physical K230 interrupt topology but
remain inactive until their transfer engines are modelled.

Add a K230 SSI qtest covering the three instance profiles, interrupt
routing and instance isolation.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 MAINTAINERS                     |   1 +
 docs/system/riscv/k230.rst      |   1 +
 hw/riscv/Kconfig                |   1 +
 hw/riscv/k230.c                 |  99 ++++++-
 include/hw/riscv/k230.h         |   5 +
 tests/qtest/k230-dwc-ssi-test.c | 637 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   3 +-
 7 files changed, 737 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5e76934b6..832348bd51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1877,6 +1877,7 @@ F: tests/qtest/k230-ddr-test.c
 F: tests/qtest/k230-wdt-test.c
 F: tests/qtest/k230-gsdma-test.c
 F: tests/qtest/k230-decomp-gzip-test.c
+F: tests/qtest/k230-dwc-ssi-test.c
 
 RX Machines
 -----------
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 237611eddf..a7f7a494cd 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -23,6 +23,7 @@ The ``k230`` machine supports the following devices:
 * K230 DDRC CFG and DDR PHY
 * System Direct Memory Access (SDMA)
 * GZIP Decompress Engine (Decomp_gzip)
+* 3 DWC SSI controllers (Standard SPI mode)
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..f348da6d20 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -164,3 +164,4 @@ config K230
     select K230_WDT
     select K230_GSDMA
     select K230_DECOMP_GZIP
+    select DWC_SSI
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 558f30b97e..eb40b53ba8 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -103,6 +103,55 @@ static const MemMapEntry memmap[] = {
     [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
 };
 
+typedef struct K230SsiRoute {
+    unsigned int ssi_index;
+    unsigned int irq_base;
+} K230SsiRoute;
+
+/*
+ * SDK numbering follows the address map: spi0 is the SPI-OPI instance,
+ * while spi1 and spi2 are QSPI0 and QSPI1.
+ */
+static const K230SsiRoute k230_ssi_routes[] = {
+    { .ssi_index = 2, .irq_base = K230_SPI0_IRQ_BASE },
+    { .ssi_index = 0, .irq_base = K230_SPI1_IRQ_BASE },
+    { .ssi_index = 1, .irq_base = K230_SPI2_IRQ_BASE },
+};
+
+typedef struct K230DwcSsiProfile {
+    uint32_t num_cs;
+    uint32_t fifo_depth;
+    bool master_mode;
+} K230DwcSsiProfile;
+
+static const K230DwcSsiProfile k230_dwc_ssi_profiles[] = {
+    [0] = { /* QSPI0, SDK spi1 */
+        .num_cs = 5,
+        .fifo_depth = 256,
+        .master_mode = true,
+    },
+    [1] = { /* QSPI1, SDK spi2 */
+        .num_cs = 5,
+        .fifo_depth = 256,
+        .master_mode = true,
+    },
+    [2] = { /* SPI-OPI/FMC, SDK spi0 */
+        .num_cs = 1,
+        .fifo_depth = 256,
+        .master_mode = true,
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
+    qdev_prop_set_bit(dev, "master-mode", profile->master_mode);
+}
+
 static void k230_soc_init(Object *obj)
 {
     K230SoCState *s = RISCV_K230_SOC(obj);
@@ -119,6 +168,12 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
     object_initialize_child(obj, "k230-decomp-gzip", &s->decomp_gzip,
                             TYPE_K230_DECOMP_GZIP);
+    object_initialize_child(obj, "k230-qspi0", &s->dwc_ssi[0],
+                            TYPE_DWC_SSI);
+    object_initialize_child(obj, "k230-qspi1", &s->dwc_ssi[1],
+                            TYPE_DWC_SSI);
+    object_initialize_child(obj, "k230-spi-opi", &s->dwc_ssi[2],
+                            TYPE_DWC_SSI);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -160,6 +215,25 @@ static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
                    399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
 }
 
+static void k230_connect_ssi_irqs(K230SoCState *s)
+{
+    for (size_t route_idx = 0;
+         route_idx < ARRAY_SIZE(k230_ssi_routes); route_idx++) {
+        const K230SsiRoute *route = &k230_ssi_routes[route_idx];
+        SysBusDevice *ssi;
+
+        g_assert(route->ssi_index < ARRAY_SIZE(s->dwc_ssi));
+        g_assert(route->irq_base + DWC_SSI_IRQ_COUNT <=
+                 K230_PLIC_NUM_SOURCES);
+
+        ssi = SYS_BUS_DEVICE(&s->dwc_ssi[route->ssi_index]);
+        for (unsigned int i = 0; i < DWC_SSI_IRQ_COUNT; i++) {
+            sysbus_connect_irq(ssi, i,
+                qdev_get_gpio_in(DEVICE(s->c908_plic), route->irq_base + i));
+        }
+    }
+}
+
 static void k230_soc_realize(DeviceState *dev, Error **errp)
 {
     K230SoCState *s = RISCV_K230_SOC(dev);
@@ -217,6 +291,15 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    for (int i = 0; i < ARRAY_SIZE(s->dwc_ssi); i++) {
+        k230_configure_dwc_ssi(&s->dwc_ssi[i], &k230_dwc_ssi_profiles[i]);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc_ssi[i]), errp)) {
+            return;
+        }
+    }
+
+    k230_connect_ssi_irqs(s);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
@@ -253,6 +336,13 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     /* Noc stub, the k230 decomp_gzip driver in uboot will access this region */
     create_unimplemented_device("noc-stub", 0x91302000, 0x1000);
 
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[0]), 0,
+                    memmap[K230_DEV_QSPI0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[1]), 0,
+                    memmap[K230_DEV_QSPI1].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dwc_ssi[2]), 0,
+                    memmap[K230_DEV_SPI].base);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -389,15 +479,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
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
     create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
                                 memmap[K230_DEV_HI_SYS_CFG].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 8679d09891..fdabf454be 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/misc/k230_ddr.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/ssi/dwc_ssi.h"
 #include "hw/watchdog/k230_wdt.h"
 #include "hw/dma/k230_gsdma.h"
 #include "hw/misc/k230_decomp_gzip.h"
@@ -40,6 +41,7 @@ typedef struct K230SoCState {
     K230WdtState wdt[2];
     K230GSDMAState gsdma;
     K230DecompGzipState decomp_gzip;
+    DwcSsiState dwc_ssi[3];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -138,6 +140,9 @@ enum {
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
     K230_GSDMA_IRQ  = 140,
+    K230_SPI0_IRQ_BASE = 146,
+    K230_SPI1_IRQ_BASE = 155,
+    K230_SPI2_IRQ_BASE = 164,
 };
 
 #define K230_UART_COUNT 5
diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
new file mode 100644
index 0000000000..42e3190cb4
--- /dev/null
+++ b/tests/qtest/k230-dwc-ssi-test.c
@@ -0,0 +1,637 @@
+/*
+ * QTest for the Kendryte K230 DWC SSI
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
+#define K230_PLIC_BASE          0xf00000000ULL
+#define K230_PLIC_PENDING_BASE  0x1000
+#define K230_SSI_CTRLR0          0x000
+#define K230_SSI_CTRLR1          0x004
+#define K230_SSI_SSIENR          0x008
+#define K230_SSI_MWCR            0x00c
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
+#define K230_SSI_MWCR_WRITABLE_MASK     0x00000007U
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
+#define K230_SSI_IRQ_TXE                0
+#define K230_SSI_IRQ_RXU                5
+#define K230_SSI_IRQ_DONE               7
+#define K230_SSI_IRQ_AXIE               8
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
+    uint32_t first_irq;
+} K230SsiInstance;
+
+static const K230SsiInstance k230_ssi_instances[3] = {
+    {
+        .base = K230_SPI0_BASE,
+        .num_cs = 1,
+        .imr_reset = 0x0000003fU,
+        .first_irq = 146,
+    }, {
+        .base = K230_SPI1_BASE,
+        .num_cs = 5,
+        .imr_reset = 0x0000003fU,
+        .first_irq = 155,
+    }, {
+        .base = K230_SPI2_BASE,
+        .num_cs = 5,
+        .imr_reset = 0x0000003fU,
+        .first_irq = 164,
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
+static bool k230_ssi_plic_pending(QTestState *qts, uint32_t irq)
+{
+    uint64_t addr = K230_PLIC_BASE + K230_PLIC_PENDING_BASE +
+                    (irq / 32) * sizeof(uint32_t);
+
+    return qtest_readl(qts, addr) & BIT(irq % 32);
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
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_MWCR, UINT32_MAX);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_MWCR),
+                    ==, K230_SSI_MWCR_WRITABLE_MASK);
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
+    qtest_quit(qts);
+}
+
+static void test_plic_routing(void)
+{
+    QTestState *qts = k230_ssi_start();
+    const K230SsiInstance *target = &k230_ssi_instances[1];
+
+    for (int i = 0; i < ARRAY_SIZE(k230_ssi_instances); i++) {
+        const K230SsiInstance *inst = &k230_ssi_instances[i];
+
+        g_assert_true(k230_ssi_plic_pending(qts,
+                                           inst->first_irq +
+                                           K230_SSI_IRQ_TXE));
+        k230_ssi_writel(qts, inst->base, K230_SSI_IMR, 0);
+        g_assert_false(k230_ssi_plic_pending(qts, inst->first_irq +
+                                              K230_SSI_IRQ_DONE));
+        g_assert_false(k230_ssi_plic_pending(qts, inst->first_irq +
+                                              K230_SSI_IRQ_AXIE));
+    }
+
+    k230_ssi_writel(qts, target->base, K230_SSI_IMR, K230_SSI_INT_RXU);
+    (void)k230_ssi_read_frame(qts, target->base);
+    g_assert_true(k230_ssi_plic_pending(qts,
+                                       target->first_irq +
+                                       K230_SSI_IRQ_RXU));
+    for (int i = 0; i < ARRAY_SIZE(k230_ssi_instances); i++) {
+        if (&k230_ssi_instances[i] != target) {
+            g_assert_false(k230_ssi_plic_pending(
+                qts, k230_ssi_instances[i].first_irq + K230_SSI_IRQ_RXU));
+        }
+    }
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
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_SR) &
+                    K230_SSI_SR_BUSY, ==, 0);
+    qtest_quit(qts);
+}
+
+/*
+ * An interrupt-driven guest waits for TXE without reading TXFLR or SR.
+ * The transfer must already be complete by the time the last frame is
+ * queued, since the FIFO drains synchronously on DR writes.
+ */
+static void test_tx_only_irq_ready(void)
+{
+    QTestState *qts = k230_ssi_start();
+
+    configure_loopback(qts, K230_SSI_TMOD_TO, 0);
+    k230_ssi_enable_cs(qts, K230_SPI1_BASE, BIT(0));
+    for (int i = 0; i < 8; i++) {
+        k230_ssi_write_frame(qts, K230_SPI1_BASE, 0x11 * (i + 1));
+    }
+
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_ISR) &
+                    K230_SSI_INT_TXE, ==, K230_SSI_INT_TXE);
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
+
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
+    qtest_add_func("/k230-dwc-ssi/plic-routing", test_plic_routing);
+    qtest_add_func("/k230-dwc-ssi/tx-only-mode", test_tx_only_mode);
+    qtest_add_func("/k230-dwc-ssi/tx-only-irq-ready",
+                   test_tx_only_irq_ready);
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
index cbdef5a545..1cfff1471a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -300,7 +300,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
   (config_all_devices.has_key('CONFIG_K230') ?
-   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : [])
+   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test',
+    'k230-decomp-gzip-test', 'k230-dwc-ssi-test'] : [])
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 

-- 
2.43.0


