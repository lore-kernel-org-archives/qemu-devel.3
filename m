Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B572FC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMB-0006p7-PW; Fri, 04 Sep 2026 01:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMA-0006ok-Ds
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:54 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM8-0001LN-3N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1cf287ef8so682548a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499251; x=1789104051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SjyWEixDQI+vMqrQ/RXGuus76EOhpo5egl3vX8Iu9AM=;
 b=FffmHp5tE/9FBg8OX2JB4NWmOBF+Ic1/LOz3lLLDllhKTAi1cVlzzBC4nTXlYrLbXu
 6b1cdAYVbPZP+GeLlNey+SdIWokLXTr4iX4wFM2TUc/ha4JxDle8sG2GeP3M1rpM+nEX
 65PNHIsQEP5eWQaE4m81Z4rKoppsdyN3LkHWfrs/BM9QmQIZckxL1SkV+kE+PrbqR0yD
 HUedmS+uxclHXf63+txBbhFNDjiypAFoWc15Wzzud8Nj9Tx9PXirjRJ8u3eGWJZFrNrB
 EsmdN+QF4PLv+jyEgfDBD9qFtWdYhauuC9KshoG1T+Z78paJSPBnxaj74AmDCPzK6+sF
 kBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499251; x=1789104051;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SjyWEixDQI+vMqrQ/RXGuus76EOhpo5egl3vX8Iu9AM=;
 b=p5w3OYq0YT55Yb+OE5PpC6Hkpyozc6Q7ZAzlnITqVwEpjtZwaOgj0P+cm+DNcbZX7d
 zur/jAt27i6/pXOYgtoU1bds3y3O/10A8aFy1FzDHmnm6VCEOtUKMd7pmW4oj+e8wsJx
 UB2S7A7upFV/g/nwZeOp/Ip2XHhg1O+wKSjMF5jKgmk3sB8l2xLPV18xtTsbHSuQilaR
 sz7hY4blzGWMEJqxY9iPFZOEUXAAPa6Dnvp5WaOitBjqxwT6Y5QsgcDcsp3fTAtvA4G8
 mxXfGPc5XE5ZRekdi8PNP7jWI1Qad76uvi4ezAovVXwN8bkDrEbpNRMPpXnTK0dL5fUs
 I9uQ==
X-Gm-Message-State: AFuF++kiwcNTD7jf2mT/b0G5a6eMhrk9JsulFxzS8TPtWZPV/PYYlLJp
 Aqrz5JEz9c/zlrcfiCt1Qk5Vo7Gd8HxegM9PvnKXqj1tZuKI8V43yKhO+lfAQQ==
X-Gm-Gg: AYBFou0oo0TrEAthFksVRrRrJq7UObRiAR8IJnkpaE8kxHdf1pydUYI+BJqlq962nRU
 Kn1/bcRoWZdjmXrW3rj2pcU96eoiQ2lWULbA/NnlYAh4PS6iRecWh5rjdFh2D/jeh2chXazbwVV
 kenzLvOYaiH0hhY09Qy/OZRAvurLj9/GiWQ9/MDigJqAfPB4RlwYyyKxXwEbMEjQzJVm0Rx1cxz
 wH9NXAjJmRC1V1bEXI4/Dy6uLJuR7BDiV0eZg/DIrCAAt7/afQY/bXDZatWO0Lt6XqrRRZYPZPB
 ir34bvqx/rErpHdpWPyxZ4lzA4lBJbwS3pqn0hAGiduIAUjmzT2l5Kgk9EdrcSyu34RKhz3e4vt
 uJUowFMjewAgvwM7jmXoXuh9XizEWsVzILuLigm51p72P2KxvMl8AeWWvnpCDWU5Kg21TWj4DHE
 eziDDYM1dvz/paAHlmtdaKmfxtn1cY3nyPMtQIPW9WWtMEO7Zn63hT/04FonUtW1xq7g/IkqQJe
 LoLow==
X-Received: by 2002:a05:6a21:6e04:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3da39cffb2amr5770286637.1.1788499250634; 
 Thu, 03 Sep 2026 22:20:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 18/47] hw/riscv/fdt_common, virt.c: add riscv_create_fdt_pcie()
Date: Fri,  4 Sep 2026 15:19:14 +1000
Message-ID: <20260904051943.799041-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The pcie FDT is quite tedious but can be parametrized into a helper.
This is going to benefit only the 'virt' board for now but it will be
used by the 'riscv-server-ref' board in the near future too.

Some other changes made:

- FDT related macros are moved to fdt-common.h.  Only a couple are being
  used by the helper ATM but more will be added in the next patches;
- an RISCVAIAType enum is created.  There are several FDTs that depends
  on the active AIA type being used, and we want a way to represent the
  different AIA modes that doesn't re-use the 'virt' specific VIRT_AIA_*
  macros.  The enum vals are equivalent by design - we want "s->aia_type"
  to be used by 'virt' when calling the fdt helpers, and other boards
  will use "AIA_*" macros in their code.

No FDT changes made.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  29 +++++++++
 include/hw/riscv/virt.h       |  15 -----
 hw/riscv/fdt-common.c         | 111 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 111 +++-------------------------------
 4 files changed, 149 insertions(+), 117 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 65711468b8..3750230865 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,6 +11,27 @@
 
 #include "target/riscv/cpu.h"
 
+#define FDT_PCI_ADDR_CELLS    3
+#define FDT_PCI_INT_CELLS     1
+#define FDT_PLIC_ADDR_CELLS   0
+#define FDT_PLIC_INT_CELLS    1
+#define FDT_APLIC_INT_CELLS   2
+#define FDT_APLIC_ADDR_CELLS  0
+#define FDT_IMSIC_INT_CELLS   0
+#define FDT_MAX_INT_CELLS     2
+#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_MAX_INT_CELLS)
+#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_PLIC_INT_CELLS)
+#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_APLIC_INT_CELLS)
+
+typedef enum RISCVAIAType {
+    AIA_TYPE_NONE = 0,
+    AIA_TYPE_APLIC,
+    AIA_TYPE_APLIC_IMSIC,
+} RISCVAIAType;
+
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size);
 void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -48,4 +69,12 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
                                           uint32_t irq_chip,
                                           uint32_t msi_phandle,
                                           uint32_t iommu_sys_irq);
+void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                           const MemMapEntry *pcie_ecam,
+                           const MemMapEntry *pcie_pio,
+                           const MemMapEntry *pcie_mmio,
+                           const MemMapEntry *high_pcie,
+                           uint32_t irq_pcie_phandle,
+                           uint32_t msi_pcie_phandle,
+                           uint32_t iommu_sys_phandle, uint32_t pcie_irq);
 #endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7c862b0da2..e516898f9a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,21 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-#define FDT_PCI_ADDR_CELLS    3
-#define FDT_PCI_INT_CELLS     1
-#define FDT_PLIC_ADDR_CELLS   0
-#define FDT_PLIC_INT_CELLS    1
-#define FDT_APLIC_INT_CELLS   2
-#define FDT_APLIC_ADDR_CELLS  0
-#define FDT_IMSIC_INT_CELLS   0
-#define FDT_MAX_INT_CELLS     2
-#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_MAX_INT_CELLS)
-#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_PLIC_INT_CELLS)
-#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_APLIC_INT_CELLS)
-
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 88589330fb..38813b6aa7 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -15,6 +15,8 @@
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/iommu.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -384,3 +386,112 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
 
     return iommu_phandle;
 }
+
+static void create_pcie_irq_map(void *fdt, char *nodename,
+                                uint32_t irqchip_phandle,
+                                RISCVAIAType aia_type, uint32_t pcie_irq)
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
+            int irq_nr = pcie_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
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
+
+            if (aia_type != AIA_TYPE_NONE) {
+                irq_map[i++] = cpu_to_be32(0x4);
+            }
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
+/*
+ * NOTE: this function uses a "/soc/pci@..." FDT subnode that
+ * should be created beforehand.
+ */
+void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                           const MemMapEntry *pcie_ecam,
+                           const MemMapEntry *pcie_pio,
+                           const MemMapEntry *pcie_mmio,
+                           const MemMapEntry *high_pcie,
+                           uint32_t irq_pcie_phandle,
+                           uint32_t msi_pcie_phandle,
+                           uint32_t iommu_sys_phandle, uint32_t pcie_irq)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx, pcie_ecam->base);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
+    qemu_fdt_setprop_cell(fdt, name, "linux,pci-domain", 0);
+
+    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
+                           pcie_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+
+    if (aia_type == AIA_TYPE_APLIC_IMSIC) {
+        qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_pcie_phandle);
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2,
+                                 pcie_ecam->base, 2, pcie_ecam->size);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
+        1, FDT_PCI_RANGE_IOPORT, 2, 0,
+        2, pcie_pio->base, 2, pcie_pio->size,
+        1, FDT_PCI_RANGE_MMIO,
+        2, pcie_mmio->base,
+        2, pcie_mmio->base, 2, pcie_mmio->size,
+        1, FDT_PCI_RANGE_MMIO_64BIT,
+        2, high_pcie->base,
+        2, high_pcie->base, 2, high_pcie->size);
+
+    if (has_iommu_sys) {
+        qemu_fdt_setprop_cells(fdt, name, "iommu-map",
+                               0, iommu_sys_phandle, 0, 0x10000);
+    }
+
+    create_pcie_irq_map(fdt, name, irq_pcie_phandle, aia_type, pcie_irq);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b0b94af4a3..cc81def8d4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -179,61 +179,6 @@ static void virt_flash_map(RISCVVirtState *s,
                     sysmem);
 }
 
-static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
-                                uint32_t irqchip_phandle)
-{
-    int pin, dev;
-    uint32_t irq_map_stride = 0;
-    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
-                          FDT_MAX_INT_MAP_WIDTH] = {};
-    uint32_t *irq_map = full_irq_map;
-
-    /*
-     * This code creates a standard swizzle of interrupts such that
-     * each device's first interrupt is based on it's PCI_SLOT number.
-     * (See pci_swizzle_map_irq_fn())
-     *
-     * We only need one entry per interrupt in the table (not one per
-     * possible slot) seeing the interrupt-map-mask will allow the table
-     * to wrap to any number of devices.
-     */
-    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
-        int devfn = dev * 0x8;
-
-        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
-            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
-            int i = 0;
-
-            /* Fill PCI address cells */
-            irq_map[i] = cpu_to_be32(devfn << 8);
-            i += FDT_PCI_ADDR_CELLS;
-
-            /* Fill PCI Interrupt cells */
-            irq_map[i] = cpu_to_be32(pin + 1);
-            i += FDT_PCI_INT_CELLS;
-
-            /* Fill interrupt controller phandle and cells */
-            irq_map[i++] = cpu_to_be32(irqchip_phandle);
-            irq_map[i++] = cpu_to_be32(irq_nr);
-            if (s->aia_type != VIRT_AIA_TYPE_NONE) {
-                irq_map[i++] = cpu_to_be32(0x4);
-            }
-
-            if (!irq_map_stride) {
-                irq_map_stride = i;
-            }
-            irq_map += irq_map_stride;
-        }
-    }
-
-    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
-                     PCI_NUM_PINS * PCI_NUM_PINS *
-                     irq_map_stride * sizeof(uint32_t));
-
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
-                           0x1800, 0, 0, 0x7);
-}
-
 static void create_fdt_socket_aclint(RISCVVirtState *s,
                                      int socket,
                                      uint32_t *intc_phandles)
@@ -722,51 +667,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_pcie(RISCVVirtState *s,
-                            uint32_t irq_pcie_phandle,
-                            uint32_t msi_pcie_phandle,
-                            uint32_t iommu_sys_phandle)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
-                           s->memmap[VIRT_PCIE_ECAM].base);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
-        FDT_PCI_ADDR_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
-        FDT_PCI_INT_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-        "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
-    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
-    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
-        s->memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
-    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
-    }
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
-        s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
-        1, FDT_PCI_RANGE_IOPORT, 2, 0,
-        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
-        1, FDT_PCI_RANGE_MMIO,
-        2, s->memmap[VIRT_PCIE_MMIO].base,
-        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
-        1, FDT_PCI_RANGE_MMIO_64BIT,
-        2, virt_high_pcie_memmap.base,
-        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
-
-    if (virt_is_iommu_sys_enabled(s)) {
-        qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
-                               0, iommu_sys_phandle, 0, 0x10000);
-    }
-
-    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
-}
-
 static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
@@ -915,8 +815,15 @@ static void finalize_fdt(RISCVVirtState *s)
                                              msi_pcie_phandle,
                                              IOMMU_SYS_IRQ);
     }
-    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
-                    iommu_sys_phandle);
+
+    riscv_create_fdt_pcie(MACHINE(s)->fdt, s->aia_type,
+                          virt_is_iommu_sys_enabled(s),
+                          &s->memmap[VIRT_PCIE_ECAM],
+                          &s->memmap[VIRT_PCIE_PIO],
+                          &s->memmap[VIRT_PCIE_MMIO],
+                          &virt_high_pcie_memmap,
+                          irq_pcie_phandle, msi_pcie_phandle,
+                          iommu_sys_phandle, PCIE_IRQ);
 
     riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
                             s->memmap[VIRT_TEST].base,
-- 
2.55.0


