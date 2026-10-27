Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dhkRHj6z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLag8-0001tc-5T; Tue, 27 Oct 2026 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafx-0001rl-GZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:50 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafv-00089r-Lc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso2145326a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082526; x=1793687326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTWuU7cGxHojTicxcydbQhWRD1n7lk1Ds6wuRcXyioA=;
 b=dhkRHj6zmrdClQGxGALjAfEvKyPHoURNwrJ5PZ+vBMZzkQQIqq6CpvIJZgqbXljCj1
 V+rJKrldxQwtmEDUde+knDSIsn9KwYfRRa53/bE+HcW+7kDNExFyy4RJrCEe3At1WTwt
 r2ER97a2uDOEdaF3672hphO9QBxy+xk+LT94XN/Nc7ktUzewqK0Efc59Yv9zsbX0nUud
 t3rt8bsgwUfPWChZX2PfVYvV/lavPJ29GJj5xgAcKNfKTpqi0YdBDfxx+PPdkaU4Vc9y
 ThQsbVdbgcn2RBkjzHWgGoWLOMeK2UuSmOXk+hyNYPBJde6fdGX7+sZoc9DITUsH3pyS
 /GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082526; x=1793687326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTWuU7cGxHojTicxcydbQhWRD1n7lk1Ds6wuRcXyioA=;
 b=u9lP4E0ENl24uGtBrvsNTuNLarsrRcDdNxLR5c9dyNMYruSurAt6VaFF7IWvHxJIYD
 I858loC4KodQVDdHuU9eRIzIiCPTdC631WdgmsHXi4eQM4Oy5Qr0tmqLmWIcNkislB/g
 Fr9BGPHsD7M3DKiFCoedi2jzTBwS5+CgSU9eOMvwet8vsZxqub68kszgOHix7ZMyoAYc
 /3CRH2NwQ25FsPexzUp2v4iU2V/NUYOuNnVvl10yOSilqITgx4D3uwI9Qb4hmGG/t+EC
 NrMENfsShcCESAowHZXkl7fouOnj1wL8rshQJhWYtvZi033C9O7cKO0r8D+Lm+BgQ9CO
 FtXA==
X-Gm-Message-State: AFq9FYJO5o2Z+1jOY5FEZNYP2XWmNcjtN3C2JMn7FVS+SsmU3MlcjnQe
 ysP1j2OlvkowXJax9LjfcifII8FsJ+gFPtwt3n8oqZ/Rcrs5LJZYTj+gIO9PuQ==
X-Gm-Gg: AYBFou3HucrebTiCaoKYIgh3LOv2AGeZzbyQwInO9XDPOsz4k0h4CCOaTNZJjudGUa8
 2oBLd7wD12wmBpruLDhKd+vtkibqLeBldmM0xnOiyleJqCPHIiYYNHBA3S96lTHjfAU5MIEWspp
 qRAvEsp5QjMkCk5VEuWzJaeLVVpbCxC/WCukCDQgIyrJmJDvJYDD2prlc9ylRceHeMimChL+0mi
 3pRUTFagYmgpQKBaXveiat/kthjmIdEiv39zc/0V4gxA+N6pbQfoXWE5f2bs9uHHlL7k7/Cg/Dp
 sfO8l3e/OusZlnDH4oNieUuXdUE7ifpHF/8AY2mp0C+5yTIFc7hh/zav0dRVQ3vCCKWge5yaOc8
 ck7X2eXRQp+KlcIln0jR2u1ayrt/En0t97gpjS7S4AWmJCnfpg/WUjTOeXXvr7g83MyrxIVpLkp
 ZU41wInUQgwNASCh8LT79R7XU3e3PQSlXK0M9Qz0kutq+LX0C/EL2SpRXrKokyh7+NuK5p+vc8u
 GffkFgCjXF9KZatJI2bAvu1IVgZx0JHcmuGnTIfuXuFcEke43iCEbDPbxl8AP8RZP3STt26aw==
X-Received: by 2002:a17:90b:3bc7:b0:3a4:ca46:8d44 with SMTP id
 98e67ed59e1d1-3adead5841amr7549878a91.18.1793082526032; 
 Mon, 26 Oct 2026 23:28:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/29] hw/riscv/atlantis: Use dw8250 UART model
Date: Tue, 27 Oct 2026 16:27:45 +1000
Message-ID: <20261027062808.1995205-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Portia Stephens <portias@oss.tenstorrent.com>

Replace the ns16550 UART with a Designware UART now that a model is
available. The hack which sets the rest of the UART register space as
unimplemented can be removed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261015002849.1640109-2-portias@oss.tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  4 +--
 hw/riscv/tt_atlantis.c         | 48 +++++++++++-----------------------
 hw/riscv/Kconfig               |  2 +-
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 577c867d7142..fc7a4337cc21 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,8 +13,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/misc/unimp.h"
 #include "hw/misc/tt_atlantis_prcm.h"
+#include "hw/char/dw8250.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -41,7 +41,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    UnimplementedDeviceState uart1;
+    DW8250State uart1;
     MemoryRegion bootrom;
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 4e6c39982c55..dfd6bc6ba6ec 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -24,9 +24,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/riscv_hart.h"
 
-#include "hw/char/serial-mm.h"
+#include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
-#include "hw/misc/unimp.h"
 #include "hw/misc/tt_atlantis_prcm.h"
 
 #include "system/system.h"
@@ -268,11 +267,15 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
                             int irqchip_phandle, uint32_t clk_parent_phandle,
                             uint32_t clk_phandle)
 {
+    static const char * const compat[2] = {
+        "snps,dw-apb-uart", "ns16550a"
+    };
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
 
     qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_string_array(fdt, name, "compatible",
+                                 (char **)&compat, ARRAY_SIZE(compat));
     qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
     qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
     qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
@@ -466,17 +469,6 @@ static void load_fdt(TTAtlantisState *ams)
     create_fdt_memory(ms->fdt, &ams->soc);
 }
 
-static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
-                                   const char *name, hwaddr addr, uint64_t size)
-{
-    qdev_prop_set_string(DEVICE(dev), "name", name);
-    qdev_prop_set_uint64(DEVICE(dev), "size", size);
-    sysbus_realize(dev, &error_abort);
-
-    memory_region_add_subregion_overlap(memory, addr,
-                                        sysbus_mmio_get_region(dev, 0), -1000);
-}
-
 static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
     TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
@@ -545,8 +537,7 @@ static void tt_atlantis_soc_init(Object *obj)
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
 
     object_initialize_child(obj, "prcm-rcpu",
                             &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU],
@@ -653,11 +644,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-
     /* 4 PRCM blocks */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
                         errp)) {
@@ -695,18 +681,14 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
-    /*
-     * Atlantis contains a DesignWare uart while the QEMU machine
-     * uses the serial_mm model with the base ns16550 register set.
-     * Linux's dw driver writes outside of serial_mm's 0x20 sized
-     * mapping and faults.
-     *
-     * Create an unimplemented device region so writes don't fault
-     * and reads return zero, which keeps Linux happy.
-     */
-    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
-                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
-                           s->memmap[TT_ATL_UART1].size);
+    /* UART1, the soc console (UART0 is for the boot microcontroller) */
+    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
+    memory_region_add_subregion(s->memory,
+                                s->memmap[TT_ATL_UART1].base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
+                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb05031228ad..d89fdfcc8671 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -144,7 +144,7 @@ config TENSTORRENT
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
-    select SERIAL_MM
+    select DW8250
     select DEVICE_TREE
     select DESIGNWARE_I2C
     select DS1338
-- 
2.55.0


