Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692DCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOV-0003RJ-IO; Thu, 15 Oct 2026 21:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNg-00023v-H1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNc-0004YY-IO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e98798cbddso509215ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112703; x=1792717503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiihykDw1z9UYJ7wIsrx75RBo1X2nec9uw2ZtUEp36U=;
 b=Tt+YCRO76lkBxMfGSubuYbP12olCjtyNjaYsa+hRBPEDXsQOO80Epa+/tSmFWPteET
 GIB7LgAVscfKfDQKZuGxmRoZh9i1MEtNuA31lqeSQPVRZ9ZNB3sWhHDX7O0Rkf/XzS1O
 emA3kUeGVwlY/6H/MErQjRhkdnZzQclKEKNantbz8RwD1XZfGRyTVMry0KmgO1qrEXiH
 heNThbOoEeplyKjstyuNWuN73oxSIInto2/ae107LyPY6lq+O86rSFq03hypwyLcP5vo
 SbSdzIO75Fq0ipw1WWq42ZJcqrqJc9tx7pkgRrXniQJTFJ/sglQj87GZpqyEb3LBh9UH
 J2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112703; x=1792717503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiihykDw1z9UYJ7wIsrx75RBo1X2nec9uw2ZtUEp36U=;
 b=cC6qy1mS99EF1hLa2FQhkxMFPR4trVtsWE9Wf/Jz5CFWO9StGxHf+pGhFXJdYjl54M
 /Bj73ln94qNaKAIIkZWJGWRVm9tmTMcEYDdNydHSC/P4z4adm81DMdIOzlplJL8OaM4N
 0m2m/OUrAnjQjhgoUyI4pXN5Ibk3Fpa9+Vpe+TA0yrjIrKZLAyZWM6mq4JHCx4HXjgJY
 /FMnXWkkWTHvkZn6rKi2PZL5CqO9IqOOlTEBygTXtbtje+eH1Qo7G5bipYqqUTxt7dxQ
 Kiv4Y6gTxQ2ttQl82xThpsTu4lx5PaXU2YKlBpTMODKbyrMEEvhj2dFHjc+t9Fyi3no4
 9DVw==
X-Gm-Message-State: AFq9FYKXuKaK6prsBdSdNaoo2fJVHdgonQWr6b5aYEpPOkhARbm3L866
 eriODmjw69pv9H5Y/1N1+rDeqKiLhGqhzUiECHCA8VB+oOKUSPUpP/RehAr64A==
X-Gm-Gg: AYBFou169f1auYu/fkDn7Ia1tju6jtFzWY5ycpc/ddyEkyRZTyXi+IK3Iip9vBBJYq1
 6/7HYum2vpW8q3orP8NXVrWUpzNO7CnWfCryrm/ooZz+qO1zjMHOhwomxAPMZ+MD5s6tO+5kscj
 yiSefl+Awz/mqtPZC2TrGlYbqMXE1YUUeIOgBBzy51M4trAjVH6m5VTyWCFCcV1GTtBj0nH4c+k
 7aF9QS9UrMZE1hLaUgv/cWDRA82ia3IAP1GpzpuVsQi6rJqW54Ag0qoIh295aT/26Jv4OCIyFD6
 dTuMs3G981rf9nyeB0Cvatmbtyhp77yEX125MacQ4NE8snOaZbAUqixijxVzqaNmmkX10ZQTCLm
 WCYHtdT7omyZ7dV/ilUeiUrjv7T5b0wVMDbluK4j1Moh2qdJtKRCb3JriPbav5UDD4bw8ogz6mR
 U520GQlRzdehdeAKrGx4/RvDmQ+IYeN0x1rfZvwy/DP8upjk90kWnUNb/hpz45cIZMiEFGgcl1A
 snh9bEe7yARZOIPnTiUtxAMEzmT
X-Received: by 2002:a17:903:1ad0:b0:2e9:514b:7a73 with SMTP id
 d9443c01a7336-2e9514b7dc7mr56734595ad.48.1792112703112; 
 Thu, 15 Oct 2026 18:05:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:05:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 46/50] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model
Date: Fri, 16 Oct 2026 11:02:33 +1000
Message-ID: <20261016010237.1102834-47-alistair.francis@wdc.com>
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


