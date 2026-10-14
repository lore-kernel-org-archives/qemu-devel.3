Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7726BCC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsh-0003wq-5P; Tue, 13 Oct 2026 23:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsV-0003c0-UB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsT-0001sD-PQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:07 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd5c9e52398so1566296a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949324; x=1792554124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiihykDw1z9UYJ7wIsrx75RBo1X2nec9uw2ZtUEp36U=;
 b=Fi7Lzl8xIHlZazLqbM5ukOQaTwNC/+YUspZPJFcTxOPYi6V5cYkMaUuRWyLBO8aGKA
 LHPh5nSXgEjXt++uaBY+2oxy75mxmbOrCVu+CcPn2mgeg9Ge8m6UQ6GZZKzGdFLLCtJx
 FyDTIQ80A0Ir7R7273Pt93jABpUQVFhuom0vbqIiJ8b1iAjS6YktD0OijG+MAOZpwd9t
 O1yTbxB+g25sS5m7y3HvyZ5d9cPPoav8IplT5Jczm7CsvAXTyu7x7xaUGjDstDEOQnuy
 CdCG0gfiuxh4iULgz6vrz3t2cAxfx6o/XHaXrnAXwnvpIrUpENX3mDIWa9Et7McizPWx
 9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949324; x=1792554124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiihykDw1z9UYJ7wIsrx75RBo1X2nec9uw2ZtUEp36U=;
 b=IRShnncl5GtWGs9NQQCQkjW2IrAdqCtmaPmMYviiz6dbJepbZnjfdmOVBMG6lYFXIh
 zh1QKoaLGi+MJHN8ldoriwajqsRpWtjlpYy8jaDeLNoM8VkoAct2YpTMNmIfQmNdOXdm
 SW0Qv5zFozgg/eY2I6VHWfxHOKnD9wvVEtK9crRrmslYuJ1SgorHOUvhSFUApysYdZrG
 BgP3XwC07J+sWdMXWdXpXb6TGgBYilA4WZRDuyWIiwfaEZdOM7gai4ErzpxumlDxsmT9
 D0I8AfxObJRJzyVKGaY5oCpLwYWBjLAmMEuwHkXiJ9CEQ5axNr3u5b8TTBHgpGB6QQ4r
 YEUg==
X-Gm-Message-State: AFq9FYLSjl/GLSJmgZvpu7c7qLTg9tKTCdxlLDifTNIsPDgmHBlbBlv9
 yRlhFe5H3O1T5cfrxcDXuHUcSmhQ1zF8bv3NWkYDI+NYlmyKn9fxZu3FWSlF6Q==
X-Gm-Gg: AYBFou3J7O27/G8qKRfqDs3WRV9y8BUYb1BCibPF9xG8Xyf8OPdx8oXqAoRA4l42qvm
 B0lTd8Rf3BFEtdtJvoLJQWnKJsGie5yPD9cxfse4A4sXq7tMikDIziGpTrhvzKK8u+EpTLyBmEF
 bc8MFgcy8cR3pJIaAAT2r5DxSfX203zSjx2PJJSFb1v7VE6F36l94J7FmGhHed86OqqXL1fScGC
 AoNW+f3X1vK0jWAKehVa0UIqEEhKypgHYGjy4EBU/xP15sS6zWk9GIrImD8CF+U2euhyADjAukl
 QVf3B0LyLSeApIAuJRh1mH9goAIhr7GvNe7RNfFYJATq+3qL4FlRgMI60saRUaLmZI0l25e63Bz
 54mOWXWlQxKYhWwU9F/qBts3iIiSugN9MzpfrEozVkVNxaOTRW0ZXaRPliMGLQThqHY+gGtXYZN
 zYex7kx8XNw63XVbDDaAVGHdifoqzGY4G91WwDbbSHiB0ab8L7wYfVJEM6VAS5avugKvgwKAKbv
 92yOsjYoxE+j7dw
X-Received: by 2002:a17:90b:6c5:b0:3ac:450a:f9ac with SMTP id
 98e67ed59e1d1-3ac450b4782mr2745049a91.64.1791949324398; 
 Tue, 13 Oct 2026 20:42:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:42:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/52] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model
Date: Wed, 14 Oct 2026 13:39:06 +1000
Message-ID: <20261014033907.3332383-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
(RCPU, HSIO, PCIe and MM). The remaining 2 are only accessed by the
boot cpu which isn't modelled yet.

This commit adds these 4 PRCM blocks to the tt-atlantis model, along
with necessary device tree nodes for them.

Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261001-atlantis_prcm-v4-2-95d33c470eeb@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/tt_atlantis.rst |   1 +
 include/hw/riscv/tt_atlantis.h    |  22 +++++++
 hw/riscv/tt_atlantis.c            | 104 ++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 1f2880d617..539c22354f 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -14,6 +14,7 @@ tt-atlantis QEMU model features
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
 * 16550A compatible UART
+* 4 PRCMs (Clock and Reset Controllers)
 
 Known limitations
 -----------------
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 3923308b7c..db1dfed157 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -14,6 +14,7 @@
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -23,6 +24,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 
 #define TT_ATL_NUM_I2C 5
+#define TT_ATL_NUM_PRCM 4
 
 struct TTAtlantisSoCState {
     /*< private >*/
@@ -41,6 +43,7 @@ struct TTAtlantisSoCState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
     MemoryRegion bootrom;
+    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
     uint32_t num_harts;
     char *cpu_type;
@@ -81,6 +84,25 @@ enum {
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
     TT_ATL_UART1,
+    TT_ATL_PRCM_RCPU,
+    TT_ATL_PRCM_HSIO,
+    TT_ATL_PRCM_PCIE,
+    TT_ATL_PRCM_MM,
+};
+
+/*
+ * RCPU PRCM Clock IDs, sourced from linux dt-bindings
+ * include/dt-bindings/clock/tenstorrent,atlantis-prcm-rcpu.h
+ */
+enum {
+    TT_ATL_CLK_RCPU_PLL = 0,
+    TT_ATL_CLK_RCPU_ROOT = 1,
+    TT_ATL_CLK_NOC_PLL = 25,
+    TT_ATL_CLK_NOCC_CLK = 26,
+    TT_ATL_CLK_HSIO_PLL = 54,
+    TT_ATL_CLK_PCIE_PLL = 55,
+    TT_ATL_CLK_MM_PLL0 = 56,
+    TT_ATL_CLK_MM_PLL1 = 57,
 };
 
 #endif
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8a219afef7..10ae3c2850 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -58,12 +59,16 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
     [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
     [TT_ATL_I2C0] =             { 0xd4040000,       0x10000 },
     [TT_ATL_I2C1] =             { 0xd4050000,       0x10000 },
     [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
+    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
+    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
@@ -327,11 +332,34 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
+static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
+                             const char *prcm_name)
+{
+    hwaddr base = mem->base;
+    hwaddr size = mem->size;
+    char *name = g_strdup_printf("/soc/clock-controller@%" PRIx64,
+                                 base);
+    g_autofree char *compatible =
+        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
+
+    return name;
+}
+
 static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
     uint32_t periph_clk_phandle = next_phandle();
+    uint32_t osc_24m_phandle = next_phandle();
+    uint32_t prcm_rcpu_phandle;
+    g_autofree char *rcpu_name, *hsio_name, *pcie_name, *mm_name;
 
     create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
 
@@ -348,6 +376,30 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
                     aplic_s_phandle);
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+    create_fdt_clk(fdt, "osc-24m", 24000000, osc_24m_phandle);
+
+    rcpu_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
+    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
+
+    hsio_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_HSIO], "hsio");
+    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
+
+    pcie_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_PCIE], "pcie");
+    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
+
+    mm_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_MM], "mm");
+    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         create_fdt_i2c(fdt,
@@ -491,6 +543,19 @@ static void tt_atlantis_soc_init(Object *obj)
     object_initialize_child(obj, "uart1", &s->uart1,
                             TYPE_UNIMPLEMENTED_DEVICE);
 
+    object_initialize_child(obj, "prcm-rcpu",
+                            &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU],
+                            TYPE_TT_ATLANTIS_PRCM_RCPU);
+    object_initialize_child(obj, "prcm-hsio",
+                            &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO],
+                            TYPE_TT_ATLANTIS_PRCM_HSIO);
+    object_initialize_child(obj, "prcm-pcie",
+                            &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE],
+                            TYPE_TT_ATLANTIS_PRCM_PCIE);
+    object_initialize_child(obj, "prcm-mm",
+                            &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM],
+                            TYPE_TT_ATLANTIS_PRCM_MM);
+
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
                                 TYPE_DESIGNWARE_I2C);
@@ -587,6 +652,44 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* 4 PRCM blocks */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
+                        errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_RCPU].base,
+        sysbus_mmio_get_region(
+            SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]), 0));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
+                        errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_HSIO].base,
+        sysbus_mmio_get_region(
+            SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]), 0));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
+                        errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_PCIE].base,
+        sysbus_mmio_get_region(
+            SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]), 0));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
+                        errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_MM].base,
+        sysbus_mmio_get_region(
+            SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
+
     /*
      * Atlantis contains a DesignWare uart while the QEMU machine
      * uses the serial_mm model with the base ns16550 register set.
@@ -654,6 +757,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                              OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
+
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
-- 
2.55.0


