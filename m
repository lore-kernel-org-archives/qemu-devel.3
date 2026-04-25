Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB199FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuy-0007v4-6t; Sat, 25 Apr 2026 09:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcue-0007bt-S8
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcud-0000MO-3w
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82735a41920so3560381b3a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123150; x=1777727950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoGuy7Y7mcp7aomRMsnsXeq4e2FJ2nZOLuRGsrIDzxY=;
 b=nzX0mzp/Ar2rwwhnA/ZlqIL3q/sjD46N/rZg6T/ZyUI8QkRSsuoaTHXQKbx6GUsso7
 TOduHPohC3byo9beY6Lt7G+DUqT4URjev1QYdu41Yb/8XnAOwvhlqMPMeolRPShcKhlA
 MjHeuOvR8Z4/Qpj5j37qwPWpSepqaTVi9wGycs5ZiX+LdrLFUOcZggHKYRRGi7rmCSMT
 byjaJ54gJnTASObF+hHu/EYKwWCT+lXdGiQ4ontthvyEojrcdnk2G26OK8ghA+CiGX3J
 tUYdg3mkEJIifxib06zS19OBnMKynhuBuADr+ICmZzCu9l1byBR+QUBSJROFwoMctpdD
 +Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123150; x=1777727950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yoGuy7Y7mcp7aomRMsnsXeq4e2FJ2nZOLuRGsrIDzxY=;
 b=igzO+BJRu3gQXzIv226gyq03gqYkYq5n/vaqZA7lLz7VA6FGizfAuJufHuOcPOJcFk
 1cORh2CELKx2uBn9V2Y8kYqiYIB9v8WOjhBwzTsO2o+CZ21pQY1EbKqEXcSO82VEycM6
 8kq0sDNND2VlJLYP/tafsnVtfVYOQAP8bvNrqNiGqZuG/84Klm1VHkq5651xITtNhkzG
 m7uaa16Fq94s2HSh4WsLaAbydBXs2vu9I1zgw+o90nP9q0tCa+/ArToeKprSu5Q8yoK8
 yEJ961zxLYFOub+/s4VqVJJnKryNkRlM9ZP2BGdg0iS+m8n55UkRD4INUyki4bj5JSp/
 zEdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IRbBN5LgVh+o42xIXHafjmsA/8aaGAN9bLJcN+XuNcn82TLwrRn2DjLAcudOqw9rR2UNJqvOLOKpz@nongnu.org
X-Gm-Message-State: AOJu0YxK3OoHTcKrZyYy64Yy+ihDIbxWR1bojA7TPNbs6PXUm0G+hB73
 kL+viY4In1suZeRsSH98a1+6hivKAWvgalWQKMZE+yiqYJ3/fhgE9y3H
X-Gm-Gg: AeBDietG4tBCFXRyhmkPKNtjMDE2hzcqBmrp5M2/bzesupWouhaPZLQvvtvSIpRNOvJ
 wT2IkZ93fd300geAr6Gqx1kM702Ib+gp+V+gSPck38ZuDsWEvlgv2sF6uPjjCMM/mi0ebwlAeFd
 yYFeRzEdoDFQGcHmep76yDqo5e44QQNQ1NWybSxNUo3Qhz0LqfCZhiRL3h+ASERIDDkgd0I65Gg
 zvg3j+xTimgjvwnRZatiVb3rtjqCAp8wCeIBWhQFf2/9Cqx+sl16ROvaCyJ9+wpvAc0EEvAgzJz
 PhUWZCrZHJQArXB4lCMFrecd65MflZBvZvNcr9RSrClNLlMhB+qBezBwT7CEfy2k5w+OtxZL3ME
 06SpjajdOl30cQLbODLDsEAGSVY7gMhye0iDdF4vsLhHqMiprIgL/JsOPdOX1xDTCGi2nHwxwZx
 5d4FoaM2lVzCzc43uDBm1CR7M3fjnHsDzj6P/sJPdxT4p2GilPDUejuw7UkWKBkjKJ+C2ZPLj55
 mdf5vQ4pFjlG5Vy2emCpDI+xBXQpGbR
X-Received: by 2002:a05:6a00:4b01:b0:82f:390a:69df with SMTP id
 d2e1a72fcca58-82f8c8d616emr38415084b3a.35.1777123149725; 
 Sat, 25 Apr 2026 06:19:09 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:19:09 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/13] hw/riscv/atlantis: Integrate i2c buses
Date: Sat, 25 Apr 2026 23:17:18 +1000
Message-ID: <20260425131721.932250-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now that we have the DesignWare model we can add buses to the
tt-atlantis machine.

Provide a fixed clock in the device tree so that the Linux driver probes
without WARNing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Add device tree clock
v2:
 - Correct count from 4 to 5
 - Fix headers location
 - Use HWADDR_PRIX to be consistent
---
 include/hw/riscv/tt_atlantis.h | 13 +++++++++
 hw/riscv/tt_atlantis.c         | 53 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 67 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 070f53eeb450..a19a8cc0773f 100644
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
 typedef struct {
     hwaddr pcie_addr; /* Device side address */
     hwaddr window_offset; /* Host side offset */
@@ -37,12 +40,18 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     GPEXHost gpex_host;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
 };
 
 enum {
     TT_ATL_SYSCON_IRQ = 10,
+    TT_ATL_I2C0_IRQ = 33,
+    TT_ATL_I2C1_IRQ = 34,
+    TT_ATL_I2C2_IRQ = 35,
+    TT_ATL_I2C3_IRQ = 36,
+    TT_ATL_I2C4_IRQ = 37,
     TT_ATL_UART0_IRQ = 38,
     TT_ATL_UART1_IRQ = 39,
     TT_ATL_UART2_IRQ = 40,
@@ -58,6 +67,10 @@ enum {
     TT_ATL_DDR_HI,
     TT_ATL_FW_CFG,
     TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
+    TT_ATL_I2C4,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_PCIE_ECAM0,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1eb473907ad7..d517d0aee2d1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -71,6 +71,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_TIMER] =            { 0xa8020000,       0x10000 },
     [TT_ATL_WDT0] =             { 0xa8030000,       0x10000 },
     [TT_ATL_UART0] =            { 0xb0100000,       0x10000 },
+    [TT_ATL_I2C0] =             { 0xb0400000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xb0500000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xb0600000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xb0700000,       0x10000 },
+    [TT_ATL_I2C4] =             { 0xb0800000,       0x10000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -484,10 +489,36 @@ static void create_fdt_fw_cfg(void *fdt, const MemMapEntry *mem)
     qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
 }
 
+static void create_fdt_clk(void *fdt, const char *name, uint32_t clk_phandle)
+{
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000000);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", clk_phandle);
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
@@ -512,6 +543,15 @@ static void finalize_fdt(TTAtlantisState *s)
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
                     aplic_s_phandle);
+
+    create_fdt_clk(fdt, "/periph-clk", periph_clk_phandle);
+
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        create_fdt_i2c(fdt,
+                       &s->memmap[TT_ATL_I2C0 + i],
+                       TT_ATL_I2C0_IRQ + i,
+                       aplic_s_phandle, periph_clk_phandle);
+    }
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -821,6 +861,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    /* I2C */
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &error_fatal);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->i2c[i]);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[TT_ATL_I2C0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
+    }
+
     /* Load or create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f13a05c7b1d1..2db8f409b926 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -135,6 +135,7 @@ config TENSTORRENT
     select RISCV_APLIC
     select RISCV_IMSIC
     select FW_CFG_DMA
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


