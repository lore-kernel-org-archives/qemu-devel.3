Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95534CA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7Ih-0005kU-M9; Wed, 30 Sep 2026 23:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7If-0005jX-O5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:37 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Id-00077R-Oj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:37 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so800129a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790824654; x=1791429454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZNkROv5sEyt9FBrfj2eOSYRurcGTdJ46N6xwUmkbeo=;
 b=NmhZE0sAymKi3zQd4IAcBGvIO2dnyARnIVuvV8BYd2iAkOssrJjNfBMiiGjSyKJiC8
 WrFkBrHQzEiNQJlc48G7usKd1BUDiFXNrxrNYH1qyPnscyj7uNV+VKY10130YhQy1yMT
 VmoQZC58agSl6Z+/RpOEUK5PoKlx/N94w+uwQcvBt5wWKsVapKw97AQMVPLHg1b0Dgkl
 ymn1YGEewHsSlJ4qtnBVLRWza0VS/aqFq2WwbIP4pTdyj2Qw4sbwqzaLSJoRZBwukjGU
 aprLaPkzf6wRhvPp2joUy3Obmbw9aL93sZ1C72hV+EFz3V40JN2w0ZVxP+WBX9Wco72d
 fzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790824654; x=1791429454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZNkROv5sEyt9FBrfj2eOSYRurcGTdJ46N6xwUmkbeo=;
 b=UMcr4g+sJotomEcfGYGJ1lGjpgsG1tBfXnx9bltbjwv3+XM8u4XcGUjXRqqcGhmvoR
 1SiPsWO8WpMsKUcJJHahOnACky/MPo35qBzfdJtn5deRuPQiQViQu941UGdgW/wxXZe/
 g9RduJDMrbryJOHCgIJjYiBu7EgR9St1AXEBuB2Dg/OEFS0J1R4tr0G9XN36MgU0Xeiu
 B/bmynsgUYCc3z0MyHV7/BRJgYY6TiJ9lRIA18Gkph2ebvfgpUgYnhJTyRXGr901BGot
 zcakoXYOB+zwCAcAmjyqtRBgGPH4T7F2gsU8U7IAt1ZDlEx/foLE2hPChe3tvsijEvdN
 RdiA==
X-Gm-Message-State: AFq9FYL71R8HE9FPB27/muzEMsxrYlHCanULptl1Ycdl6/Jr+O0fk1ip
 kTEcV0nNcHutwJ4r+KSMS4HM235PiqwsLcBS9gY7vTmmCgInFdZS++AYYqju5a9oyWkx2woEqez
 7NnSx
X-Gm-Gg: AYBFou2+s1DplSVqCJ0luFxBAgknjmb0Rp+3ncQnw54b6OCEqxT1HfoC2jIJ9UordV/
 hb5ByNrtWgwHIqYqEPfm2Eo5ULFlc8rRXYdeA29XQ5euqifsGnDzBzMuYibePTJmbdtE8twhBwr
 NP2npd1Qrez2uwSz32ErKAJhryFXf3/eiZv4d44zdKIOTHP6iWUaMsRfEVSNdRf6qpjxGpQlAAV
 niakqeTAdi6GVNICwY7W+ga0L77Mtp4P+xMX9+fso+bGXneRoJdEuUFIfBCkzCksqfaiZ+1PR06
 tx3XiAvQfByLVA5e/PCzI5KZRqLFjoGHZ0Rr0lWoN3jBpsslGNO77YsSytpsfdKlTcmIVR377AE
 Eov0FDOopsDsCUroYyquryScFVoSwqZYXHUwMkTTyW3MxEvm9oWEgKCa2ax2J4A1ZMETKu0YrAF
 v2p2oHYXWOlxet4DTzoIIdp4ZS60uo87k9oPlQ7SIcSjW93IgzRbfKYabJIYslMF5DkgRT61NYj
 Vjw90o7tBFUO3afvokdFMbczijdJmTfW2DZQaVZjnoLrmJa8OenEd1Oeg==
X-Received: by 2002:a17:90b:4b05:b0:3a4:88c2:32b8 with SMTP id
 98e67ed59e1d1-3a4d103cfe3mr4624086a91.1.1790824654157; 
 Wed, 30 Sep 2026 20:17:34 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f43f833asm2255552a91.6.2026.09.30.20.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 20:17:33 -0700 (PDT)
From: 'Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 1/4] hw/riscv/atlantis: Use dw8250 UART model
Date: Thu,  1 Oct 2026 13:17:17 +1000
Message-ID: <20261001031720.2334056-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Portia Stephens <portias@oss.tenstorrent.com>

Replace the ns16550 UART with a Designware UART now that a model is
available. The hack which sets the rest of the UART register space as
unimplemented can be removed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/Kconfig               |  2 +-
 hw/riscv/tt_atlantis.c         | 45 +++++++++++-----------------------
 include/hw/riscv/tt_atlantis.h |  4 +--
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..5d2abdbb67 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -127,7 +127,7 @@ config TENSTORRENT
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
-    select SERIAL_MM
+    select DW8250
     select DEVICE_TREE
     select DESIGNWARE_I2C
     select DS1338
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8a219afef7..70815e12ef 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -24,9 +24,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/riscv_hart.h"
 
-#include "hw/char/serial-mm.h"
+#include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
-#include "hw/misc/unimp.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -262,11 +261,15 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
                             int irqchip_phandle)
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
@@ -409,17 +412,6 @@ static void load_fdt(TTAtlantisState *ams)
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
@@ -488,8 +480,7 @@ static void tt_atlantis_soc_init(Object *obj)
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
@@ -584,21 +575,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                 &s->bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
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
+    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
+    memory_region_add_subregion(s->memory,
+                                s->memmap[TT_ATL_UART1].base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
+                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 3923308b7c..000988c037 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,7 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/misc/unimp.h"
+#include "hw/char/dw8250.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -39,7 +39,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    UnimplementedDeviceState uart1;
+    DW8250State uart1;
     MemoryRegion bootrom;
 
     uint32_t num_harts;
-- 
2.43.0


