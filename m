Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358DCCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6aC-0007YN-25; Tue, 09 Sep 2025 18:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EKbAaAYKCqsjfMTYkRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--yubinz.bounces.google.com>)
 id 1uw6Z4-0007GZ-Ia
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:50 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EKbAaAYKCqsjfMTYkRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--yubinz.bounces.google.com>)
 id 1uw6Yo-0004zx-KS
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:49 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b52047b3f1dso8172078a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455888; x=1758060688; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G1ML4qhyamwpOcRy+yPMfAbVh/pECO+b10ommWu8O/E=;
 b=l0mPwyaEq9y058YoYB/XZGS11XnZANjVD1qkakrOmk+PKERb2NEb8lB9RVyGFYPFEC
 fEdalqVDUQKYI11yyhVMTEkDYX0Q2JotrFdW8amInB9C2G5VeGbZcKYo2E3FCz+kgdZn
 qqwZYkcahgFR72y444EF1YL0RlS4InLCgyjss15XeI8C+OIh4UCNKipmNnimqnTvj/jx
 JmqxM0arRwLEEIUYE+n36Ltiy1yta+cwm0h6j70d2xuGEsKPSvdeeZsDxpoSftWquhvm
 62X8gUiS4KpGBP+PgOnhxsAKO+soUtwpCMZBhhWQ0l2EgXhVv4X9+DnF3NNCSL0oEMcp
 7wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455888; x=1758060688;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1ML4qhyamwpOcRy+yPMfAbVh/pECO+b10ommWu8O/E=;
 b=OWKtq2j6Eg2haNkSG6ltX6+PnmQhMCRSceKKyEzXu8XYAPEdC+6KlUC4BvW0tHHY1L
 cMZYYPFSX8Pnh3/uZEBu100D3LDCROMcn99Pv399mHkAk0T6ChTsKhva5+6Jpv3VeL/M
 pP/UtNXNU8ycxx6Qis2+perbSERmE+7/CSPFsv2kq0AvKz+KnhskDOOfVeE2r5vJn6ln
 j2v1W8R2CSIUbZOCjvC7UzPyvYNaYUcPWDxOgu6UxH9oam5Cz6U3GBGxz33Mibp7pkh/
 8IEsdNbCu1pys+XmGPruSB0JQ5Jmmeepat5HUDotgNNOpnab8exQvBjIXoG8n3VhDwjV
 KFDw==
X-Gm-Message-State: AOJu0YxDng3uddtLl+hPDvLxqPtKraUkWMW3yxy6F9mDF4W8DNZEZ/DK
 iop4PJC4H9FJTGbVlokvK0k1iX0BoYQ4Lo+DPwn3KvWxrqE+UY/VAz10hIYaRz/fVkpfZhe9HeF
 6HhUCYq/it5cqMDBA/DIvwGog9OaNqeFB2iGxdfNq2/mR63aUT+HywEp+JYo3Frk2XRKs6cltx8
 kVoTSn5bGZt3BkCik/aV4dm+JxaFCnWaZHjSE=
X-Google-Smtp-Source: AGHT+IGjlVhmJH3VpDaIUgP7QNyejK5/bQklnQAAVV4RGC+1Ep4jwB/ky7uthfdwza4kZ70M0Xgu5WjmsY0=
X-Received: from pjzz4.prod.google.com ([2002:a17:90b:58e4:b0:32b:95bb:dbc])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a06:b0:250:720a:2915
 with SMTP id adf61e73a8af0-2534441548fmr17989067637.35.1757455888334; Tue, 09
 Sep 2025 15:11:28 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:10:59 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-4-d85883b2688d@google.com>
Subject: [PATCH 4/7] hw/pci-host: add Nuvoton PCIe root port
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3EKbAaAYKCqsjfMTYkRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:49 -0400
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

From: Titus Rwantare <titusr@google.com>

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/npcm8xx.c                  |   3 +-
 hw/pci-host/npcm_pcierc.c         | 137 ++++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/npcm_pcierc.h |  22 +++++-
 3 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 9b3e648e3fc3ca4352d5c8d310a19ea462e62cc7..f7a5ae2d121ffec99c519b484503e71dc8a43695 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -51,6 +51,7 @@
 #define NPCM8XX_MC_BA           0xf0824000
 #define NPCM8XX_RNG_BA          0xf000b000
 #define NPCM8XX_PCIERC_BA       0xe1000000
+#define NPCM8XX_PCIE_ROOT_BA    0xe8000000
 
 /* ADC Module */
 #define NPCM8XX_ADC_BA          0xf000c000
@@ -772,13 +773,13 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     /* PCIe RC */
     sysbus_realize(SYS_BUS_DEVICE(&s->pcierc), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 0, NPCM8XX_PCIERC_BA);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 1, NPCM8XX_PCIE_ROOT_BA);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcierc), 0,
                        npcm8xx_irq(s, NPCM8XX_PCIE_RC_IRQ));
 
     create_unimplemented_device("npcm8xx.shm",          0xc0001000,   4 * KiB);
     create_unimplemented_device("npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
     create_unimplemented_device("npcm8xx.vdmx",         0xe0800000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.rootc",        0xe8000000, 128 * MiB);
     create_unimplemented_device("npcm8xx.kcs",          0xf0007000,   4 * KiB);
     create_unimplemented_device("npcm8xx.gfxi",         0xf000e000,   4 * KiB);
     create_unimplemented_device("npcm8xx.fsw",          0xf000f000,   4 * KiB);
diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
index bffdec71acaba6562856b3bdd8aec07c3c153323..a1767335fe79a30464acf32ae94fc14e417c89eb 100644
--- a/hw/pci-host/npcm_pcierc.c
+++ b/hw/pci-host/npcm_pcierc.c
@@ -203,6 +203,7 @@ static void npcm_pcierc_write_window(NPCMPCIERCState *s, hwaddr addr,
     npcm_pcie_update_window_maps(s);
 }
 
+/* read root complex configuration registers */
 static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
 {
     NPCMPCIERCState *s = NPCM_PCIERC(opaque);
@@ -248,6 +249,7 @@ static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
     return ret;
 }
 
+/* write root complex configuration registers */
 static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
                                   unsigned size)
 {
@@ -291,6 +293,53 @@ static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
     }
 }
 
+/* read PCIe configuration space */
+static uint64_t npcm_pcie_host_config_read(void *opaque, hwaddr addr,
+                                           unsigned size)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+    PCIHostState *pcih = PCI_HOST_BRIDGE(opaque);
+    int bus = NPCM_PCIE_RCCFGNUM_BUS(s->rccfgnum);
+    uint8_t devfn = NPCM_PCIE_RCCFGNUM_DEVFN(s->rccfgnum);
+    PCIDevice *pcid = pci_find_device(pcih->bus, bus, devfn);
+
+    if (pcid) {
+        return pci_host_config_read_common(pcid, addr,
+                                           pci_config_size(pcid),
+                                           size);
+    }
+    return 0;
+}
+
+/* write PCIe configuration space */
+static void npcm_pcie_host_config_write(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned size)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+    PCIHostState *pcih = PCI_HOST_BRIDGE(opaque);
+    int bus = NPCM_PCIE_RCCFGNUM_BUS(s->rccfgnum);
+    uint8_t devfn = NPCM_PCIE_RCCFGNUM_DEVFN(s->rccfgnum);
+    PCIDevice *pcid = pci_find_device(pcih->bus, bus, devfn);
+
+    if (pcid) {
+        pci_host_config_write_common(pcid, addr,
+                                     pci_config_size(pcid),
+                                     data,
+                                     size);
+    }
+}
+
+static AddressSpace *npcm_pcierc_set_iommu(PCIBus *bus, void *opaque, int devfn)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+
+    return &s->pcie_space;
+}
+
+static const PCIIOMMUOps npcm_pcierc_iommu_ops = {
+    .get_address_space = npcm_pcierc_set_iommu,
+};
+
 static void npcm_pcierc_reset_pcie_windows(NPCMPCIERCState *s)
 {
     memset(s->axi2pcie, 0, sizeof(s->axi2pcie));
@@ -338,15 +387,73 @@ static const MemoryRegionOps npcm_pcierc_cfg_ops = {
     },
 };
 
+static const MemoryRegionOps npcm_pcie_cfg_space_ops = {
+    .read       = npcm_pcie_host_config_read,
+    .write      = npcm_pcie_host_config_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    }
+};
+
+static void npcm_pcie_set_irq(void *opaque, int irq_num, int level)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+
+    qemu_set_irq(s->irq, level);
+}
+
 static void npcm_pcierc_realize(DeviceState *dev, Error **errp)
 {
     NPCMPCIERCState *s = NPCM_PCIERC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    PCIDevice *root = pci_new(PCI_DEVFN(0, 0), TYPE_NPCM_PCIE_ROOT_PORT);
 
     memory_region_init_io(&s->mmio, OBJECT(s), &npcm_pcierc_cfg_ops,
                           s, TYPE_NPCM_PCIERC, 4 * KiB);
     sysbus_init_mmio(sbd, &s->mmio);
     sysbus_init_irq(sbd, &s->irq);
+
+    /* IO memory region is needed to create a PCI bus, but is unused on ARM */
+    memory_region_init(&s->pcie_io, OBJECT(s), "npcm-pcie-io", 16);
+
+    /*
+     * pcie_root is a 128 MiB memory region in the BMC physical address space
+     * in which all PCIe windows must have their programmable source or
+     * destination address
+     */
+    memory_region_init_io(&s->pcie_root, OBJECT(s), &npcm_pcie_cfg_space_ops,
+                          s, "npcm-pcie-config", 128 * MiB);
+    sysbus_init_mmio(sbd, &s->pcie_root);
+
+    pci->bus = pci_register_root_bus(dev, "pcie",
+                                     npcm_pcie_set_irq,
+                                     pci_swizzle_map_irq_fn,
+                                     s, &s->pcie_root, &s->pcie_io,
+                                     0, 4, TYPE_PCIE_BUS);
+
+    address_space_init(&s->pcie_space, &s->pcie_root, "pcie-address-space");
+    pci_realize_and_unref(root, pci->bus, &error_fatal);
+    pci_setup_iommu(pci->bus, &npcm_pcierc_iommu_ops, s);
+}
+
+static void npcm_pcie_root_port_realize(DeviceState *dev, Error **errp)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    rpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void npcm_pcierc_instance_init(Object *obj)
@@ -369,6 +476,28 @@ static void npcm_pcierc_class_init(ObjectClass *klass, const void *data)
     dc->fw_name = "pci";
 }
 
+static void npcm_pcie_rp_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pk = PCI_DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+
+    dc->desc = "Nuvoton PCIe Root Port";
+    dc->user_creatable = false;
+
+    device_class_set_parent_realize(dc,
+                                    npcm_pcie_root_port_realize,
+                                    &rpc->parent_realize);
+
+    /* TODO(b/229132071) replace with real values */
+    pk->vendor_id = PCI_VENDOR_ID_QEMU;
+    pk->device_id = 0;
+    pk->class_id = PCI_CLASS_BRIDGE_PCI;
+
+    rpc->exp_offset = NPCM_PCIE_HEADER_OFFSET; /* Express capabilities offset */
+    rpc->aer_offset = NPCM_PCIE_AER_OFFSET;
+}
+
 static const TypeInfo npcm_pcierc_type_info = {
     .name = TYPE_NPCM_PCIERC,
     .parent = TYPE_PCIE_HOST_BRIDGE,
@@ -377,9 +506,17 @@ static const TypeInfo npcm_pcierc_type_info = {
     .class_init = npcm_pcierc_class_init,
 };
 
+static const TypeInfo npcm_pcie_port_type_info = {
+    .name = TYPE_NPCM_PCIE_ROOT_PORT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(NPCMPCIERootPort),
+    .class_init = npcm_pcie_rp_class_init,
+};
+
 static void npcm_pcierc_register_types(void)
 {
     type_register_static(&npcm_pcierc_type_info);
+    type_register_static(&npcm_pcie_port_type_info);
 }
 
 type_init(npcm_pcierc_register_types)
diff --git a/include/hw/pci-host/npcm_pcierc.h b/include/hw/pci-host/npcm_pcierc.h
index 410b34d1c1ced0e25f63fc7693d87bb625a80776..a47eae0084b88ba4388681b24ab97f77a4338594 100644
--- a/include/hw/pci-host/npcm_pcierc.h
+++ b/include/hw/pci-host/npcm_pcierc.h
@@ -23,11 +23,14 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
 /* PCIe Root Complex Registers */
-#define LINKSTAT                        0x92
+#define NPCM_PCIE_LINK_CTRL             0x90
 #define NPCM_PCIERC_RCCFGNUM            0x140 /* Configuration Number */
+#define     NPCM_PCIE_RCCFGNUM_BUS(a)   (((a) >> 8) & 0xFF)
+#define     NPCM_PCIE_RCCFGNUM_DEVFN(a) ((a) & 0xFF)
 #define NPCM_PCIERC_INTEN               0x180 /* Interrupt Enable */
 #define NPCM_PCIERC_INTST               0x184 /* Interrupt Status */
 #define NPCM_PCIERC_IMSI_ADDR           0x190
@@ -84,6 +87,10 @@
 #define NPCM_PCIERC_NUM_PA_WINDOWS          2
 #define NPCM_PCIERC_NUM_AP_WINDOWS          5
 
+/* PCIe extended config space offsets */
+#define NPCM_PCIE_HEADER_OFFSET             0x80
+#define NPCM_PCIE_AER_OFFSET                0x100
+
 #define TYPE_NPCM_PCIERC "npcm-pcie-root-complex"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCIERCState, NPCM_PCIERC)
 
@@ -105,6 +112,13 @@ typedef struct NPCMPCIEWindow {
     uint8_t id;
 } NPCMPCIEWindow;
 
+#define TYPE_NPCM_PCIE_ROOT_PORT "npcm-pcie-root-port"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCIERootPort, NPCM_PCIE_ROOT_PORT)
+
+struct NPCMPCIERootPort {
+    PCIESlot parent;
+};
+
 struct NPCMPCIERCState {
     PCIExpressHost parent;
 
@@ -118,6 +132,12 @@ struct NPCMPCIERCState {
     uint32_t rcimsiaddr;
     uint32_t rcmsisstat;
     uint32_t axierr;
+
+    /* Address translation state */
+    AddressSpace pcie_space;
+    MemoryRegion pcie_root;
+    MemoryRegion pcie_io; /* unused - but required for IO space PCI */
+    NPCMPCIERootPort port;
     /* PCIe to AXI Windows */
     NPCMPCIEWindow pcie2axi[NPCM_PCIERC_NUM_PA_WINDOWS];
 

-- 
2.51.0.384.g4c02a37b29-goog


