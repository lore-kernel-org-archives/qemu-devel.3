Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F919C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes3H-00057h-AF; Wed, 01 Jul 2026 06:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes3A-0004yJ-0j
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:12 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes38-00054m-1H
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:11 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-13b2b08a553so395413c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901208; x=1783506008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URIr4/qh/XN4evSDTcNbtk2wqLT2LjWuV3So3+2gIvU=;
 b=CkAmytuE/CVGU6Z9b802tWRVcY5gb+27a2A3HbIWiHDHHQGxSdZuJFm1sRASEStL0T
 0a4+88tq+idmsOp8I8duw44Ld7qov3akohC69kv1FXO5BVjJlOSfygVUXoBskvqgEDuC
 5EBN0WRAgbtOanCwVbyzY1iev3SXBmufR4KgrM+T3AN19nykqVfVgoIiNXxepe7CW4oH
 qzC0L8Vx/Ccw9bkB0kx6yzGZojMZraKxgWT+kw9iX3dKqu39VrI/4wHKt2AM7ICozzEi
 guwjWeGKL1dUwLeXXK2bs+0YJuakaoG/tQPAu7fOum7UAGJTO3gnUq5s6yvvYtz1+yW2
 UnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901208; x=1783506008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=URIr4/qh/XN4evSDTcNbtk2wqLT2LjWuV3So3+2gIvU=;
 b=irZR7VowYtWejBq6IckQmPvpVjbQKB09CFqhLOrH24W65HVXP98yeuU9bE+IsmLQzZ
 AAJFs4q8DnkoQV/0+hjQ0+3m3QEh6ejpx9DpOEbFwKbPegaYj0rGzfeVwD2y4xUiihaQ
 3+GLEQ5Xt0XdSnJN/FWf8Y3eSwtaq5w4M6Idg300sH67xNoP2TGU1+93n7/UA0K+8E6v
 hVjRyjikbRQ5i3HUCvEzMXtiyETHSzZo5xPbdcu64xvIHqKZN054XFK1cDdhNOUmyx4B
 46A0Rw82zcCfZsZaWRL0VGD5BBU3zxwIH+VaXJnFsTHED1E21XjOW9BLXynxrNrol3pN
 ELhg==
X-Gm-Message-State: AOJu0YzLY//QdoRCpLqTbMCNdc104AZ/kHpLHmDzy9o3ZzqibVB/by0V
 gE3SPkye06VuppiN98FT8/0yt+W3sx0AIBfjTORIKkIz1Tt1MDFsE7AwWgseNA==
X-Gm-Gg: AfdE7cnkxKICirATk0m9537hDZO/S1mt9iOlomiPanWwolp4gDXYF+/7IGH9LOm72GK
 QEfNrxLRdO9PHlFysc/z27pkRqGzO2W/FA6INjkKc25K39Vp7v6wuNBCWNRK4YyRy4/h0/Vpmh6
 GvAnnCktQ1MkQCWJp9Ehp/Lcj98gdKp6yLh7eh+7V6wdWsGxEROr/04u57C7g9OslAfRJB7+uEr
 SHlKb8hjxxL/iB0baqOmkJIQoND7lXuTNGk5eDaev9lqmH3kEYgAFkSnXzKu72+aGPMmWRS7UGC
 iEA1e1SDff1oEZ1mlBiLYOWMouTVif1xoUbbWnW3bQbINdHQgfinOGzSieL9WwfC475k1TPoaWX
 ZayspIS8UlhT8yVs1/dkhssCC00Xhwm0G5+U9eDl8Aj1lhF5/OLkRj8iH9mHnd86Y8sykHUxBLU
 mdrH3XfBZUgF/JAIsapyUCP3LmMziSnH8=
X-Received: by 2002:a05:7022:160a:b0:139:78a3:7eca with SMTP id
 a92af1059eb24-13b36dd71d2mr1088117c88.36.1782901208129; 
 Wed, 01 Jul 2026 03:20:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:20:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 37/39] hw/riscv/atlantis: Integrate i2c controllers
Date: Wed,  1 Jul 2026 20:17:50 +1000
Message-ID: <20260701101752.2522962-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122d.google.com
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

From: Joel Stanley <joel@jms.id.au>

Add DesignWare I2C controllers to the tt-atlantis machine.

Provide a fixed clock in the device tree so that the Linux driver probes
without WARNing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-12-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h | 14 ++++++++
 hw/riscv/tt_atlantis.c         | 59 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 74 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index a17732ce81..7f7d4a5a59 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -11,12 +11,15 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/sysbus.h"
+#include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TT_ATL_NUM_I2C 5
+
 struct TTAtlantisState {
     /*< private >*/
     MachineState parent;
@@ -27,11 +30,17 @@ struct TTAtlantisState {
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
 };
 
 enum {
+    TT_ATL_I2C0_IRQ = 33,
+    TT_ATL_I2C1_IRQ = 34,
+    TT_ATL_I2C2_IRQ = 35,
+    TT_ATL_I2C3_IRQ = 36,
+    TT_ATL_I2C4_IRQ = 37,
     TT_ATL_UART1_IRQ = 39,
 };
 
@@ -40,6 +49,11 @@ enum {
     TT_ATL_BOOTROM,
     TT_ATL_DDR_LO,
     TT_ATL_DDR_HI,
+    TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
+    TT_ATL_I2C4,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d4fa9c251d..5ce150fff7 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -54,6 +54,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
     [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_I2C0] =             { 0xd4040000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xd4050000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
+    [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -275,10 +280,40 @@ static void create_fdt_rng(void *fdt)
     qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
 }
 
+static void create_fdt_clk(void *fdt, const char *clock_name,
+                           uint32_t freq, uint32_t phandle)
+{
+    g_autofree char *name = g_strdup_printf("/clocks/%s", clock_name);
+
+    qemu_fdt_add_path(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop_string(fdt, name, "clock-output-names", clock_name);
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", freq);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", phandle);
+}
+
+static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
+                           uint32_t irqchip_phandle, uint32_t clk_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX, mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2c");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
+    uint32_t periph_clk_phandle = next_phandle();
     void *fdt = MACHINE(s)->fdt;
 
     create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
@@ -292,6 +327,15 @@ static void finalize_fdt(TTAtlantisState *s)
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
                     aplic_s_phandle);
+
+    create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        create_fdt_i2c(fdt,
+                       &s->memmap[TT_ATL_I2C0 + i],
+                       TT_ATL_I2C0_IRQ + i,
+                       aplic_s_phandle, periph_clk_phandle);
+    }
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -492,6 +536,21 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 s->memmap[TT_ATL_UART1].base,
                                 s->memmap[TT_ATL_UART1].size);
 
+    /* I2C */
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        SysBusDevice *sbd;
+
+        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
+        sysbus_realize(sbd, &error_fatal);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[TT_ATL_I2C0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
+    }
+
     /* Load or create device tree */
     if (machine->dtb) {
         load_fdt(s);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5033415440..dcce819bf6 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -129,6 +129,7 @@ config TENSTORRENT
     select RISCV_IMSIC
     select SERIAL_MM
     select DEVICE_TREE
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.54.0


