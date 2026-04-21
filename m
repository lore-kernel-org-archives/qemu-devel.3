Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECFFF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3kO-0000lr-EN; Tue, 21 Apr 2026 01:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3k8-0000az-QR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3k6-0004VA-Kh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:52 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so2538939a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749629; x=1777354429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkQdP30uKyUlHIFKW9Uy40Our+7o3vknC9ZwGR+fDis=;
 b=J3Xox+EpVnJAYsQESEiJFdZcf6EZjUP3QXnpypTQI+l27pMR0/36D+ZhWIEpZMgck0
 TWfsTsYHIzCxwdV8ZnWCZ9cnGcLyOcSocpTUysvPJkzJgqrTdcdBPwKjM2UENrSHGhnY
 ARgsP1QkgEhhERjVUIvDybs1bHqjKfOmMidnf5ab/ugJAdeYGJfet9tN1EgqlyjVnvKV
 kVhQk/xvEPxMECoSH97irGIbXzwNR/2iyk4jfYmPZC1eUh3E4pBLJPRtstedXC5nr2x3
 3vvXDxag2l7r9LJvlBLODSVgWACKTKAx4rS+0zWjXnPbeVNjSxHHiMp/uNs0RikQqhCh
 Oktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749629; x=1777354429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkQdP30uKyUlHIFKW9Uy40Our+7o3vknC9ZwGR+fDis=;
 b=Ttki634iCRRIq/xeX1g0Wjf6YViQnUxUfRqFymgg9HJu+ccZdFH3Ywq5aS3pind0YV
 UzN99kBJAVjl8BPpfkTxTks2g93FnXagU1QBvThLdl75NA86GapVQVX0nSbAOKgkZAPV
 VOJQ+ckLvQXZyPFOedUJgYamr+JAqwqDAO1+uRvdTyg4pqmyTtNDm02Vef1DB4Bz+UK8
 g9EivVwrgRbpIopWZIrJUvJhi1Y4pNwJP5OyFhuuLtmQYQAzd7OJFGcAlUF8AIIGIvAt
 7Zt/F5oIBB14m276k183b0CSLwycuwvrojptsGHRAUGdUPa4feK4s1HKVXfATfB3y8ee
 nB9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LDE3mkKwauJa0Qr9JnBXr69b83J8WUXwRENXN8PlAHIwO18+CfL7PnsO5S1IqcRH2aR4ceNp5Mu0Y@nongnu.org
X-Gm-Message-State: AOJu0YyscfJaelG82nhwbZXGfeUo8BDV4DkfygGKWkbEruluSlgcjJ80
 NZAKE0v78/obz8xqauD/toRjuxc8aLAmSedX6PmOfIjuio8issCS2U5q
X-Gm-Gg: AeBDietgbNNBkjUY1uCj3bql6l88kMDgiEp08R13wzidNO1yOPlo/D7JHRhJY/Brch1
 JM0bNFAwRZAcO9vs3GjjjpH6Fd1FqXbr/8QhvS/hH9HzfC+y5C8lffd+AI1rwmR6+SLBD7NKcAP
 H+r6dByA2nAORiSAM+2Kuo41amUP4gW060WLl1E5vcmla443U+aebz/J5Dso7vYhzX7YoWVV9UG
 0UcUK8FaDwlsxLNRnNUpxV4anDqR8yQ7krvQ2DKR85hZx7uftkOytdVVhmqguiD/5H3MD3AF2Vq
 0lTI40q3q6tbEMWbScOktiSQXO4fsRjW0tHWLZSJEWZ+LenEEh/CKAk+kjgg2C1ofb+/JjH6NG4
 bFKY07HwqhfYgE1ELn9BA4ejlEysBawVr8/IFKIf0vu5GKb7ZQT/WLk9W9xZ2VKn+ZOu0geWuBW
 RyntetYUKNEp0jDMjjd/QsdLK3NbBY0anXHz+PIpbRUKn6imcCFCGNTy+xLZCNnmieR71OH13f1
 LLeiTgM7LS64obL53ra9Y/jKZ4lvt8xdc3jzhAoK+c8KeKH
X-Received: by 2002:a17:90a:da8c:b0:35e:3afb:a3ff with SMTP id
 98e67ed59e1d1-361403cbd7cmr16548218a91.3.1776749629184; 
 Mon, 20 Apr 2026 22:33:49 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:48 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 10/13] hw/riscv/atlantis: Add PCIe controller
Date: Tue, 21 Apr 2026 15:31:35 +1000
Message-ID: <20260421053140.752059-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

tt-atlantis is likely to use a generic ECAM compatible PCIe memory map,
so gpex is not far off the OS programming model

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Avoid leaks in the dt string allocation
---
 include/hw/riscv/tt_atlantis.h |   2 +
 hw/riscv/tt_atlantis.c         | 225 ++++++++++++++++++++++++++++++++-
 hw/riscv/Kconfig               |   2 +
 3 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index f7f79e9f2c53..c0a0827a5167 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -28,6 +28,7 @@ struct TTAtlantisState {
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    GPEXHost gpex_host;
 
     int fdt_size;
 };
@@ -39,6 +40,7 @@ enum {
     TT_ATL_UART2_IRQ = 40,
     TT_ATL_UART3_IRQ = 41,
     TT_ATL_UART4_IRQ = 42,
+    TT_ATL_PCIE0_INTA_IRQ = 96,
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index a556ff79c8c8..e1753d3c1f18 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/misc/pvpanic.h"
+#include "hw/pci-host/gpex.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -70,6 +71,9 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_PCIE_ECAM1] =    { 0x01120000000,    0x10000000 },
     [TT_ATL_PCIE_ECAM2] =    { 0x01130000000,    0x10000000 },
     [TT_ATL_PCIE_MMIO0] =    { 0x10000000000, 0x10000000000 },
+    [TT_ATL_PCIE_PIO0]  =    { 0x10000000000,       0x10000 }, /* qemu only */
+    [TT_ATL_PCIE_MMIO0_32] = { 0x10004000000,     0x4000000 }, /* qemu only */
+    [TT_ATL_PCIE_MMIO0_64] = { 0x10010000000, 0x0fff0000000 }, /* qemu only */
     [TT_ATL_PCIE_MMIO1] =    { 0x20000000000, 0x10000000000 },
     [TT_ATL_PCIE_MMIO2] =    { 0x30000000000, 0x10000000000 },
 };
@@ -80,6 +84,59 @@ static uint32_t next_phandle(void)
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
@@ -320,6 +377,54 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
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
@@ -385,6 +490,14 @@ static void finalize_fdt(TTAtlantisState *s)
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
@@ -395,7 +508,7 @@ static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
-    g_autofree char *name = NULL;
+    char *name;
     void *fdt;
 
     fdt = create_device_tree(&s->fdt_size);
@@ -417,6 +530,25 @@ static void create_fdt(TTAtlantisState *s)
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
+    /*
+     * The "/soc/pci@..." node is needed for PCIE hotplugs
+     * that might happen before finalize_fdt().
+     */
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM0].base);
+    qemu_fdt_add_subnode(fdt, name);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM1].base);
+    qemu_fdt_add_subnode(fdt, name);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
+                           s->memmap[TT_ATL_PCIE_ECAM2].base);
+    qemu_fdt_add_subnode(fdt, name);
+    g_free(name);
+
     qemu_fdt_add_subnode(fdt, "/chosen");
 
     /* Pass seed to RNG */
@@ -429,6 +561,93 @@ static void create_fdt(TTAtlantisState *s)
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
@@ -588,6 +807,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     s->fw_cfg = create_fw_cfg(&s->memmap[TT_ATL_FW_CFG], machine->smp.cpus);
     rom_set_fw(s->fw_cfg);
 
+    /* PCIe */
+    gpex_pcie_init(s, system_memory);
+
     /* Reboot and exit */
     create_reboot_device(&s->memmap[TT_ATL_SYSCON]);
 
@@ -623,6 +845,7 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->pci_allow_0_address = true;
     mc->default_ram_id = "tt_atlantis.ram";
 }
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0601ae1a7494..2ddee591eb90 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -129,6 +129,8 @@ config TENSTORRENT
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


