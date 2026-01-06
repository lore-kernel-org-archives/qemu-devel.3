Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6B1CD0421
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd056-0004PC-AG; Tue, 06 Jan 2026 00:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd054-0004Lq-E6
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:10 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd052-0001r3-7F
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:10 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f216280242so698555b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679087; x=1768283887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kirPME4c2SprsgmBPVngc20IlZQMj15aC0kkYiwkUuQ=;
 b=WUnHPIf0e1dIMMXJphe9UfBdNL4+nf1015y74t84e0cLxJj/o5gFFaQ1KMVydOOIg4
 uDAxefuXW4+s9aHGV/1QHHz0V9HkRcDZFFeSutPHVwWtdK0rI5mOGGbZEEpzfkATZ/CG
 Z6I1AA4zJ5PGQsJLJbyC8cxyewmyjsw7T7Mly5xEtJOOF7gdhmIqF9OawjW4qXTdKKXj
 S7JuYg8D0IabbYE24pGlj+isGPqwniXSDeGFOt+srJPve6Dfs1jWj2OYViEVDrSrGTPX
 nOh9WjgbD+r2lK3CTWK54HiFpm292EBEjFuaHD1NGZ1cWy2UQyFnJCe5K6WwTw+hBbW/
 2KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679087; x=1768283887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kirPME4c2SprsgmBPVngc20IlZQMj15aC0kkYiwkUuQ=;
 b=XPWobDfZKKZCtIWWphikUCuOzbSAjEK24xvhr/W8FqQHcQV2ihUnOZC8xSxifk9MwA
 pabklZ9BHSfoXYxBbR0CWMFvKsHJKat11hE2HQUsUgImIDgDMmVJ60Fw0iogpaFTMDpv
 xvUtY3sNvWMlK43zyPKXgnMRtbkHiWJ+Cllpnr4YwCdoap+kkpBT7DWuL5eiut/eE4ho
 3Pb/3kI4RApL56qtJhgsYzjyrpwtWT/mGJFBi9UTSlVACujb6/Rcvf/pG95eiJFWOiMT
 FKrYLZS6x/zrE6EbAJI/wLerg4LHH2+05tup2PDNJ51JYLcgaPr51e8jRokddn4OWM4w
 1rng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4qoZdQr1KzJqCf7lKYlJA3fqpZt90i6slS8h104eMTRBjJ/LHAQ7nOtIDY75hKDXuQ9SqchQfvEb7@nongnu.org
X-Gm-Message-State: AOJu0YyEoJl4yqRKn11wsvahDbNdyItFmg8hhkNXoOhOa/ad6YlbUsKU
 wWIAo8n0sT4DNsa0/CDS+n5lN/b/+Ix/5XzEt/qebv8+0GYbO0SAWS/u
X-Gm-Gg: AY/fxX7clk0bMPrHimPJ4HoZMt+5XkeAeGo1VRJYk/yb9WRA5gah9DtoeDZy292im+r
 pRimGZcQdiVDESUi7094cUTC5+ZxQRZ4albHoLGRmX/6f3xjo7r0DZoLFu4MPfVdFGHTnlsYU8F
 NHnkSqso9j8w0GYuFn61RinUvhxt7p+z4WwbND7XQCVdGXmEIpDH58eH9fTZ9n/9W4bizozkcVj
 yS5pV5X7Zevs8T0Cg6TstZwMGgHpDFdaPEsp5YNS7N1Go6gZWhrDISgMouQz9u04HTRHaUNBjBx
 J0E1ZvzR3y+8ZZXsSnvs4if+/wELbJ3t36N6jOyBAuAIXLGvme4F7GLwqPzEx+iGRlXARMcetzG
 kS3PPwaRWa/peFOy/t5TaidhfRafXm8PPaCJFMEDfx7NRjToXaWGelV66uNLz86jy5WWIfEZ3bO
 9FmxVw4MhmxfG9uiG5xVp1
X-Google-Smtp-Source: AGHT+IGxS4S0tq8etWAicPq6JoLuAuMGH3ICkbYA7jVcPKLnvQQISKpDG3V5faiPBlghAqZvWHwD4w==
X-Received: by 2002:a05:6a21:6b10:b0:35e:d94:525a with SMTP id
 adf61e73a8af0-38982a80672mr1460951637.13.1767679086896; 
 Mon, 05 Jan 2026 21:58:06 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:06 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 09/16] hw/riscv/atlantis: Add PCIe controller
Date: Tue,  6 Jan 2026 16:26:49 +1030
Message-ID: <20260106055658.209029-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

tt-atlantis is likely to use a generic ECAM compatible PCIe memory map,
so gpex is not far off the OS programming model

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |   5 +
 hw/riscv/tt_atlantis.c         | 218 +++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |   2 +
 3 files changed, 225 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index e6ed923c6a97..edce490453a8 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -18,6 +18,8 @@
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TT_ATL_NUM_I2C 4
+
 struct TTAtlantisState {
     /*< private >*/
     MachineState parent;
@@ -30,6 +32,8 @@ struct TTAtlantisState {
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    GPEXHost gpex_host;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
     int aia_guests; /* TODO: This should be hard coded once known */
@@ -42,6 +46,7 @@ enum {
     TT_ATL_UART2_IRQ = 40,
     TT_ATL_UART3_IRQ = 41,
     TT_ATL_UART4_IRQ = 42,
+    TT_ATL_PCIE0_INTA_IRQ = 96,
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1a7f7e98be22..1e296e027b77 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/misc/pvpanic.h"
+#include "hw/pci-host/gpex.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -75,6 +76,9 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_PCIE_ECAM1] =    { 0x01120000000,    0x10000000 },
     [TT_ATL_PCIE_ECAM2] =    { 0x01130000000,    0x10000000 },
     [TT_ATL_PCIE_MMIO0] =    { 0x10000000000, 0x10000000000 },
+    [TT_ATL_PCIE_PIO0]  =    { 0x10000000000,       0x10000 }, /* qemu only */
+    [TT_ATL_PCIE_MMIO0_32] = { 0x10004000000,     0x4000000 }, /* qemu only */
+    [TT_ATL_PCIE_MMIO0_64] = { 0x10010000000, 0x0fff0000000 }, /* qemu only */
     [TT_ATL_PCIE_MMIO1] =    { 0x20000000000, 0x10000000000 },
     [TT_ATL_PCIE_MMIO2] =    { 0x30000000000, 0x10000000000 },
 };
@@ -85,6 +89,59 @@ static uint32_t next_phandle(void)
     return phandle++;
 }
 
+static void create_pcie_irq_map(void *fdt, char *nodename, int legacy_irq,
+                                uint32_t irqchip_phandle)
+{
+    int pin, dev;
+    uint32_t irq_map_stride = 0;
+    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
+                          FDT_MAX_INT_MAP_WIDTH] = {};
+    uint32_t *irq_map = full_irq_map;
+
+    /*
+     * This code creates a standard swizzle of interrupts such that
+     * each device's first interrupt is based on it's PCI_SLOT number.
+     * (See pci_swizzle_map_irq_fn())
+     *
+     * We only need one entry per interrupt in the table (not one per
+     * possible slot) seeing the interrupt-map-mask will allow the table
+     * to wrap to any number of devices.
+     */
+    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
+        int devfn = dev * 0x8;
+
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
+            int irq_nr = legacy_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
+            int i = 0;
+
+            /* Fill PCI address cells */
+            irq_map[i] = cpu_to_be32(devfn << 8);
+            i += FDT_PCI_ADDR_CELLS;
+
+            /* Fill PCI Interrupt cells */
+            irq_map[i] = cpu_to_be32(pin + 1);
+            i += FDT_PCI_INT_CELLS;
+
+            /* Fill interrupt controller phandle and cells */
+            irq_map[i++] = cpu_to_be32(irqchip_phandle);
+            irq_map[i++] = cpu_to_be32(irq_nr);
+            irq_map[i++] = cpu_to_be32(0x4);
+
+            if (!irq_map_stride) {
+                irq_map_stride = i;
+            }
+            irq_map += irq_map_stride;
+        }
+    }
+
+    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
+                     PCI_NUM_PINS * PCI_NUM_PINS *
+                     irq_map_stride * sizeof(uint32_t));
+
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                           0x1800, 0, 0, 0x7);
+}
+
 static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
 {
     uint32_t cpu_phandle;
@@ -325,6 +382,54 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
                          IRQ_S_EXT, s->soc.num_harts);
 }
 
+static void create_fdt_pcie(void *fdt,
+                            const MemMapEntry *mem_ecam,
+                            const MemMapEntry *mem_pio,
+                            const MemMapEntry *mem_mmio32,
+                            const MemMapEntry *mem_mmio64,
+                            int legacy_irq,
+                            uint32_t aplic_s_phandle,
+                            uint32_t imsic_s_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                                            mem_ecam->base);
+
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
+    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
+                           mem_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, mem_ecam->base,
+                                 2, mem_ecam->size);
+    if (!(mem_mmio32->base & 0xffffffffUL)) {
+        /* XXX: this is a silly hack because it would collide with PIO */
+        error_report("mmio32 base must not be 0 mod 2^32");
+        exit(1);
+    }
+    uint32_t flags = FDT_PCI_RANGE_MMIO_64BIT | FDT_PCI_RANGE_PREFETCHABLE;
+    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
+                                 1, FDT_PCI_RANGE_IOPORT,
+                                 2, 0x0,
+                                 2, mem_pio->base,
+                                 2, mem_pio->size,
+                                 1, FDT_PCI_RANGE_MMIO,
+                                 2, (mem_mmio32->base & 0xffffffffUL),
+                                 2, mem_mmio32->base,
+                                 2, mem_mmio32->size,
+                                 1, flags,
+                                 2, mem_mmio64->base,
+                                 2, mem_mmio64->base,
+                                 2, mem_mmio64->size);
+
+    create_pcie_irq_map(fdt, name, legacy_irq, aplic_s_phandle);
+}
+
 static void create_fdt_reset(void *fdt, const MemMapEntry *mem)
 {
     uint32_t syscon_phandle = next_phandle();
@@ -390,6 +495,14 @@ static void finalize_fdt(TTAtlantisState *s)
      *                       aplic_s_phandle);
      */
 
+    create_fdt_pcie(fdt,
+                    &s->memmap[TT_ATL_PCIE_ECAM0],
+                    &s->memmap[TT_ATL_PCIE_PIO0],
+                    &s->memmap[TT_ATL_PCIE_MMIO0_32],
+                    &s->memmap[TT_ATL_PCIE_MMIO0_64],
+                    TT_ATL_PCIE0_INTA_IRQ,
+                    aplic_s_phandle, imsic_s_phandle);
+
     create_fdt_reset(fdt, &s->memmap[TT_ATL_SYSCON]);
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
@@ -422,6 +535,20 @@ static void create_fdt(TTAtlantisState *s)
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
+    /*
+     * The "/soc/pci@..." node is needed for PCIE hotplugs
+     * that might happen before finalize_fdt().
+     */
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM0].base);
+    qemu_fdt_add_subnode(fdt, name);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM1].base);
+    qemu_fdt_add_subnode(fdt, name);
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM2].base);
+    qemu_fdt_add_subnode(fdt, name);
+
     qemu_fdt_add_subnode(fdt, "/chosen");
 
     /* Pass seed to RNG */
@@ -434,6 +561,93 @@ static void create_fdt(TTAtlantisState *s)
     create_fdt_pmu(s);
 }
 
+static void gpex_pcie_init_one(TTAtlantisState *s, GPEXHost *gpex_host,
+                               MemoryRegion *mr,
+                               const MemMapEntry *mem_ecam,
+                               const MemMapEntry *mem_pio,
+                               const MemMapEntry *mem_mmio32,
+                               const MemMapEntry *mem_mmio64,
+                               int legacy_irq)
+{
+    DeviceState *dev;
+    Object *obj;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *mmio32_alias, *mmio64_alias, *mmio_reg;
+    hwaddr ecam_base = mem_ecam->base;
+    hwaddr ecam_size = mem_ecam->size;
+    hwaddr pio_base = mem_pio->base;
+    hwaddr pio_size = mem_pio->size;
+    hwaddr mmio32_base = mem_mmio32->base;
+    hwaddr mmio32_size = mem_mmio32->size;
+    hwaddr mmio64_base = mem_mmio64->base;
+    hwaddr mmio64_size = mem_mmio64->size;
+    qemu_irq irq;
+    char name[16];
+    int i;
+
+    snprintf(name, sizeof(name), "pcie");
+    object_initialize_child(OBJECT(s), name, gpex_host, TYPE_GPEX_HOST);
+    dev = DEVICE(gpex_host);
+    obj = OBJECT(dev);
+
+    object_property_set_uint(obj, PCI_HOST_ECAM_BASE, ecam_base, &error_abort);
+    object_property_set_int(obj, PCI_HOST_ECAM_SIZE, ecam_size, &error_abort);
+    object_property_set_uint(obj, PCI_HOST_BELOW_4G_MMIO_BASE, mmio32_base,
+                             &error_abort);
+    object_property_set_int(obj, PCI_HOST_BELOW_4G_MMIO_SIZE, mmio32_size,
+                            &error_abort);
+    object_property_set_uint(obj, PCI_HOST_ABOVE_4G_MMIO_BASE, mmio64_base,
+                             &error_abort);
+    object_property_set_int(obj, PCI_HOST_ABOVE_4G_MMIO_SIZE, mmio64_size,
+                            &error_abort);
+    object_property_set_uint(obj, PCI_HOST_PIO_BASE, pio_base, &error_abort);
+    object_property_set_int(obj, PCI_HOST_PIO_SIZE, pio_size, &error_abort);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    snprintf(name, sizeof(name), "pcie.ecam");
+    memory_region_init_alias(ecam_alias, obj, name,
+                             ecam_reg, 0, ecam_size);
+    memory_region_add_subregion(mr, ecam_base, ecam_alias);
+
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+
+    mmio32_alias = g_new0(MemoryRegion, 1);
+    snprintf(name, sizeof(name), "pcie.mmio32");
+    memory_region_init_alias(mmio32_alias, obj, name,
+                             mmio_reg, mmio32_base & 0xffffffffUL, mmio32_size);
+    memory_region_add_subregion(mr, mmio32_base, mmio32_alias);
+
+    mmio64_alias = g_new0(MemoryRegion, 1);
+    snprintf(name, sizeof(name), "pcie.mmio64");
+    memory_region_init_alias(mmio64_alias, obj, name,
+                             mmio_reg, mmio64_base, mmio64_size);
+    memory_region_add_subregion(mr, mmio64_base, mmio64_alias);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        irq = qdev_get_gpio_in(s->irqchip, legacy_irq + i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, legacy_irq + i);
+    }
+
+    gpex_host->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
+}
+
+static void gpex_pcie_init(TTAtlantisState *s, MemoryRegion *mr)
+{
+    gpex_pcie_init_one(s, &s->gpex_host, mr,
+                       &s->memmap[TT_ATL_PCIE_ECAM0],
+                       &s->memmap[TT_ATL_PCIE_PIO0],
+                       &s->memmap[TT_ATL_PCIE_MMIO0_32],
+                       &s->memmap[TT_ATL_PCIE_MMIO0_64],
+                       TT_ATL_PCIE0_INTA_IRQ);
+}
+
 static DeviceState *create_reboot_device(const MemMapEntry *mem)
 {
     DeviceState *dev = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
@@ -590,6 +804,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     s->fw_cfg = create_fw_cfg(&s->memmap[TT_ATL_FW_CFG], machine->smp.cpus);
     rom_set_fw(s->fw_cfg);
 
+    /* PCIe */
+    gpex_pcie_init(s, system_memory);
+
     /* Reboot and exit */
     create_reboot_device(&s->memmap[TT_ATL_SYSCON]);
 
@@ -625,6 +842,7 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->pci_allow_0_address = true;
     mc->default_ram_id = "tt_atlantis.ram";
 }
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 791db8f3b7e1..f1525254b126 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -138,6 +138,8 @@ config TENSTORRENT
     select DEVICE_TREE
     select RISCV_NUMA
     select PVPANIC_MMIO
+    select PCI
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select SERIAL_MM
     select RISCV_ACLINT
     select RISCV_APLIC
-- 
2.47.3


