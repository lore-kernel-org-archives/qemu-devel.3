Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C65DF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3kP-0000wQ-Dr; Tue, 21 Apr 2026 01:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kH-0000g6-SG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:34:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kG-0004Zq-3H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:34:01 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso2578667a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749638; x=1777354438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hev7AdsgaG3fRb4LKGCXjtOa9s4nvVIm/TmtgrA6C2o=;
 b=KQCCizHqJfaG2lqwi/01OIXaFLI9Nan0OeewH5YGRyS7gGxvyBVGcz/y5oVLu/wHpk
 elaakfALJ1Me5JbR86vsM9BiNgDvZ/4zhmmBy8uiF+yVXAbvD1r/lXNXQ0jKZ7ycK2ai
 /z7VR8q6uXv8EEa2Numfk+GnmKd+4fj2Up0eXMXorvO6lCoVk6YgSHhCt8LHJzD7YlTF
 igftD0ESipffhyQArWGrW0DB7OQAkCD/MO7oYkfv+rSx5vlRMaQDdd5xl67IcNrGwxF8
 j7nRap1zfHrFGdJZa1OsU2gkEhd60jyaPgQWzl80uz3xBpJoIoL0Za5jbwOUO6MKkp6I
 56VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749638; x=1777354438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hev7AdsgaG3fRb4LKGCXjtOa9s4nvVIm/TmtgrA6C2o=;
 b=bHpC8hDU+h7mpuCdRwEE2rlWj+Y6oqyoeKqZ2bQ1KatU6MYiFCluvjdsr2VmePFtQ3
 syMlHruKXeuXTMAHJutfHyZFOnkYVZuVMQvYkNbb82rZG780K95Xvyua+It37RYY6tBt
 O8I1V7Ze0jcpjabde+3ypYQgnD6N/ADPX3bfhbVSQpYND3Bl1626rd/eHAgV1r6GJyZm
 6hMp2ARnVfv2g39ubKUOW1G07faFABTIFDaLg0Vpge62bh01RZ/6wJqgJ2XIURXwkuFp
 sYg+oKjPXtS4TZaN0gg4i8I5tLblHrrpkh475qr72f5vLbZ+oyZxAWqTYnEz+Eq+R32v
 jQqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w69YE9cpJ5NjF4cKYTauS1VkBzb3oww16TE5ciDMpLmOemklvLj9RGN1PLCn0xyYWLuPjr9ddaZfE@nongnu.org
X-Gm-Message-State: AOJu0YwAwXfoy1liaB7DE8vnWrUn9FOtntUPT83t6r5hDCqDrSyr44EY
 nfedhW5KpGgOi5cCaVIYuwrIGXum933g+H2Cka7sFmFJ+OwCfBORgr+y
X-Gm-Gg: AeBDieto/B359E+uhfv7E1d6XFomtIpm4/v/JKMzYZTOz/Ljo4cSC0EIXGOdJ7BonlH
 uOSffR+cnxJBBVH0m1T5CCChmAX/9h6Eji6t1y3GYH9cMCqLoBo8kK29yahJeqI1LeK7SGQNwiL
 bnHxXVLnYu+kzv7RxR5OVlLB0jC8h22E1m3s+To/nkfqKaNCnq4hqOrnFTN4K9apgp0qoRBxbbt
 khd4YEG+7DjLj/0YzETh8EndFjbGWC13NyVe6h+fZ5iHILxbiZIbjkIgEfAr+47Tqq+ZKzDWf/1
 zczHMmOaXReZvUWaS64ibTbAPRLO9mToh2aptv9h3Y/fGY7A5K6G3xUFkKijD09KIDhasYarmCk
 MRAHHACdl/xcNgk6IW2sZjc/Dxrr8aFd53ZkjBOgMmliSZIcsNnHrWKZAPe7cRgTh3CL9hBmNgf
 HVO1xfsunGjElzFIwZC+iHoIYlJa+s9HhI5rXjK/L80FvQfjhwKJfqTsISfApDkTYZyUGZ87gdT
 cwagAv3qjCrvNRZi2rlbNr/5xLyaCldr9Yk9w==
X-Received: by 2002:a17:90b:3808:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-361403bdcccmr18220616a91.5.1776749637755; 
 Mon, 20 Apr 2026 22:33:57 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:57 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 12/13] hw/riscv/atlantis: Integrate i2c buses
Date: Tue, 21 Apr 2026 15:31:37 +1000
Message-ID: <20260421053140.752059-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
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
index c0a0827a5167..b39c7e090e0b 100644
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
@@ -29,12 +32,18 @@ struct TTAtlantisState {
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
@@ -50,6 +59,10 @@ enum {
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
index e1753d3c1f18..bf08b7ed320e 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -64,6 +64,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
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
@@ -475,10 +480,36 @@ static void create_fdt_fw_cfg(void *fdt, const MemMapEntry *mem)
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
@@ -502,6 +533,15 @@ static void finalize_fdt(TTAtlantisState *s)
 
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
@@ -818,6 +858,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
index 2ddee591eb90..4c2cf01995e7 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -136,6 +136,7 @@ config TENSTORRENT
     select RISCV_APLIC
     select RISCV_IMSIC
     select FW_CFG_DMA
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


