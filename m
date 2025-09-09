Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086ECCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6aD-0007ZW-7h; Tue, 09 Sep 2025 18:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3E6bAaAYKCq4miPWbnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yubinz.bounces.google.com>)
 id 1uw6ZC-0007J4-Fk
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:58 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3E6bAaAYKCq4miPWbnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yubinz.bounces.google.com>)
 id 1uw6Ys-00050g-Pp
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:57 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b4c928089fdso9153907a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455891; x=1758060691; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=o7wOx2QtQ30ibrB/Wx+ClrOh/MdjzNOUohpSI7tIUwQ=;
 b=a2I2sx6L9HDGhxoSH2pwoyHdVcGswZ7MYrn3nqbFOtMb8/1srniqYFgpwyG1mZujgN
 HuXRtEBSTsMbmJvr9q6D2Kwf9PP+SctVmM9f4/4xWMBXrJXybjSAZwU3gXhl6spGU1f5
 pkTunZFFBqmthw2/isPMTjLts8fFTZG6MLftl/iiHPV66RMWr1NirF7XU95KOAYLHKfy
 dgzaYkS3l4NrfAxmKBDCTjlnQhWOrl7m94RcZOD3s7UXbjiHoO7AbtzHuYxoVqBJZQwR
 W1TufnVDDWpMyvtKCWBIB+4VqIZGHkZpE8boGYq81r5OewOCI0mZzn7QN3FlDRI+BdoD
 uXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455891; x=1758060691;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7wOx2QtQ30ibrB/Wx+ClrOh/MdjzNOUohpSI7tIUwQ=;
 b=e7/3aA+ZTZt6eyFT0L2gIb6CW1/oylS8yRYxHPKBIWulwhn+do5GXjn2VOm4RjOojb
 oE/PiPFdT8Nx3JJwE/q5AskNzlTDFCe2wWmf8C0NV8duxZUOb4e1YHvT/UxE9gWaUX8p
 u4Lgfy19ZdedYWk67gq9gygBWMNqwHZEXfjAbaV8BV48LmTgts5JVyZxw1PDQ4+OsghK
 lyy/Nl5cs62PzbG//fGXz0g9donTGY78t9dEW5H8Y3HMOGpTJZ/qQKxN1PNSToGbSgLe
 2dz1nGHdy/2rRYweYaXK09fLjnngjeR7xI4QZQ34B+7DoQmBebq701xZh1UiYILfnYL2
 ZfuA==
X-Gm-Message-State: AOJu0Yw7gTQjs5ad7AOxyH0gHfPhlEHCaKmiiwFYVw9A+P8XnwZBlZX3
 ugXcO9p5RXACYka8feuiIjAhklbU9Nf4uuj+9GydUbraZMRR098iCr8VmUl8v0PfV3gWF0JmWfl
 QEA1lc5r+Q9lhOV2qD0Yb8OR1PWtd4ou0oi1l5CUf32AUh+ZBOyHaS+0lwa7d2KAMGGPLPwWru+
 Vlx8qZsEzeWZVqaZCAZvjUls2pzF3hfD1Hzqc=
X-Google-Smtp-Source: AGHT+IFnT581mM9nJ8jq+1G6awfKUHa9XJUnLSRVCIf0ccUlmFWXd4T2U8NZy7Y/VL9eK3pF22jQjI7OQX0=
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:24c:cf63:a8d6])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:138a:b0:24c:9e2d:9a13
 with SMTP id d9443c01a7336-25170772b3amr162618455ad.27.1757455891523; Tue, 09
 Sep 2025 15:11:31 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:11:01 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-6-d85883b2688d@google.com>
Subject: [PATCH 6/7] hw/pci-host: rework Nuvoton PCIe windowing and memory
 regions
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3E6bAaAYKCq4miPWbnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

 This switches to a using a fully sized PCI memory region that's
 separate from system memory. Accesses to this PCI memory region are
 gated by the AXI to PCIe windows whose size and offsets are validated.

 - PCIe config space is not necessarily aliased with PCIe mmio space.
   Ignore translation addresses for config space windows.
 - Make window configuration register writes order independent.

 Tested with pci-testdev.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/npcm8xx.c                  |   1 -
 hw/pci-host/npcm_pcierc.c         | 156 ++++++++++++++++++++++++++------------
 include/hw/pci-host/npcm_pcierc.h |   9 ++-
 3 files changed, 115 insertions(+), 51 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index f7a5ae2d121ffec99c519b484503e71dc8a43695..504874c99e7d12afa92268786239ca946e8e2129 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -773,7 +773,6 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     /* PCIe RC */
     sysbus_realize(SYS_BUS_DEVICE(&s->pcierc), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 0, NPCM8XX_PCIERC_BA);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 1, NPCM8XX_PCIE_ROOT_BA);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcierc), 0,
                        npcm8xx_irq(s, NPCM8XX_PCIE_RC_IRQ));
 
diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
index 0af76d1067a78bdbb169af3e3d5c4a2514cd0ff5..3aab7d401a7be8c1b14a476ed934f521b8dfdaa7 100644
--- a/hw/pci-host/npcm_pcierc.c
+++ b/hw/pci-host/npcm_pcierc.c
@@ -17,63 +17,123 @@
 #include "qom/object.h"
 #include "trace.h"
 
+
+#define NPCM_SAL            BIT(0)
+#define NPCM_SAH            BIT(1)
+#define NPCM_TAL            BIT(2)
+#define NPCM_TAH            BIT(3)
+#define NPCM_PARAMS         BIT(4)
+#define NPCM_BITFIELDS_ALL  0x1f
+
+
+static bool npcm_pcierc_valid_window_addr(hwaddr addr, uint32_t size)
+{
+    if ((addr + size) > NPCM_PCIE_HOLE_END) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: window mapping @0x%lx, size: %d is invalid.\n",
+                      __func__, addr, size);
+        return false;
+    } else if (addr < NPCM_PCIE_HOLE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: window mapping @0x%lx, is invalid.\n",
+                      __func__, addr);
+        return false;
+    } else {
+        return true;
+    }
+};
+
+static bool npcm_pcierc_valid_window_size(hwaddr src, hwaddr dst, uint32_t size)
+{
+    if (size > 2 * GiB || size < 4 * KiB) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid PCI window size %d bytes\n",
+                      __func__, size);
+        return false;
+    }
+
+    return true;
+}
+
 /* Map enabled windows to a memory subregion */
 static void npcm_pcierc_map_enabled(NPCMPCIERCState *s, NPCMPCIEWindow *w)
 {
     MemoryRegion *system = get_system_memory();
     uint32_t size = NPCM_PCIERC_SAL_SIZE(w->sal);
-    hwaddr bar = ((uint64_t)w->sah) << 32 | (w->sal & 0xFFFFF000);
+    hwaddr src_ba = ((uint64_t)w->sah) << 32 | (w->sal & 0xFFFFF000);
+    hwaddr dest_ba = ((uint64_t)w->tah) << 32 | w->tal;
     char name[26];
 
-    /* check if window is enabled */
-    if (!(w->sal & NPCM_PCIERC_SAL_EN)) {
+    if (!(w->sal & NPCM_PCIERC_SAL_EN) || /* ignore disabled windows */
+        !npcm_pcierc_valid_window_size(src_ba, dest_ba, size) ||
+        memory_region_is_mapped(&w->mem) /* ignore existing windows */) {
         return;
     }
 
-    if (size > 2 * GiB || size < 4 * KiB) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Invalid PCI window size %d bytes\n",
-                      __func__, size);
+    /* bitfield for all 5 registers required to create a PCIe window */
+    if (w->set_fields != NPCM_BITFIELDS_ALL) {
         return;
     }
+    w->set_fields = 0;
 
+    /*
+     * This implementation of the Nuvoton root complex uses memory region
+     * aliasing to emulate the behaviour of the windowing system on hardware.
+     * AXI to PCIe windows in QEMU are system_memory subregions aliased to PCI
+     * memory at the respective source and translation addresses
+     * PCIe to AXI windows are done as PCI memory subregions aliased to system
+     * memory. PCIe to AXI windows have no address restrictions.
+     */
     if (w->type == AXI2PCIE) {
+        if (!npcm_pcierc_valid_window_addr(src_ba, size)) {
+            return;
+        };
         snprintf(name, sizeof(name), "npcm-axi2pcie-window-%d", w->id);
+        if (w->params &
+            (NPCM_PCIERC_TRSF_PARAM_CONFIG | NPCM_PCIERC_TRSL_ID_CONFIG)) {
+            memory_region_init_alias(&w->mem, OBJECT(s), name,
+                                     &s->rp_config, 0, size);
+        } else {
+            memory_region_init_alias(&w->mem, OBJECT(s), name,
+                                     &s->pcie_memory, dest_ba, size);
+        }
+        memory_region_add_subregion(system, src_ba, &w->mem);
     } else if (w->type == PCIE2AXI) {
         snprintf(name, sizeof(name), "npcm-pcie2axi-window-%d", w->id);
+        memory_region_init_alias(&w->mem, OBJECT(s), name,
+                                 system, src_ba, size);
+        memory_region_add_subregion(&s->pcie_memory, dest_ba, &w->mem);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: unable to map uninitialized PCIe window",
                       __func__);
         return;
     }
-
-    /* TODO: set subregion to target translation address */
-    /* add subregion starting at the window source address */
-    if (!memory_region_is_mapped(&w->mem)) {
-        memory_region_init(&w->mem, OBJECT(s), name, size);
-        memory_region_add_subregion(system, bar, &w->mem);
-    }
 }
 
 /* unmap windows marked as disabled */
-static void npcm_pcierc_unmap_disabled(NPCMPCIEWindow *w)
+static void npcm_pcierc_unmap_disabled(NPCMPCIERCState *s, NPCMPCIEWindow *w)
 {
     MemoryRegion *system = get_system_memory();
+
     /* Bit 0 in the Source address enables the window */
     if (memory_region_is_mapped(&w->mem) && !(w->sal & NPCM_PCIERC_SAL_EN)) {
-        memory_region_del_subregion(system, &w->mem);
+        if (w->type == AXI2PCIE) {
+            memory_region_del_subregion(system, &w->mem);
+        } else {
+            memory_region_del_subregion(&s->pcie_memory, &w->mem);
+        }
     }
 }
 
 static void npcm_pcie_update_window_maps(NPCMPCIERCState *s)
 {
     for (int i = 0; i < NPCM_PCIERC_NUM_PA_WINDOWS; i++) {
-        npcm_pcierc_unmap_disabled(&s->pcie2axi[i]);
+        npcm_pcierc_unmap_disabled(s, &s->pcie2axi[i]);
     }
 
     for (int i = 0; i < NPCM_PCIERC_NUM_AP_WINDOWS; i++) {
-        npcm_pcierc_unmap_disabled(&s->axi2pcie[i]);
+        npcm_pcierc_unmap_disabled(s, &s->axi2pcie[i]);
     }
 
     for (int i = 0; i < NPCM_PCIERC_NUM_AP_WINDOWS; i++) {
@@ -177,22 +237,27 @@ static void npcm_pcierc_write_window(NPCMPCIERCState *s, hwaddr addr,
     switch (offset) {
     case NPCM_PCIERC_SAL_OFFSET:
         window->sal = data;
+        window->set_fields |= NPCM_SAL;
         break;
 
     case NPCM_PCIERC_SAH_OFFSET:
         window->sah = data;
+        window->set_fields |= NPCM_SAH;
         break;
 
     case NPCM_PCIERC_TAL_OFFSET:
         window->tal = data;
+        window->set_fields |= NPCM_TAL;
         break;
 
     case NPCM_PCIERC_TAH_OFFSET:
         window->tah = data;
+        window->set_fields |= NPCM_TAH;
         break;
 
     case NPCM_PCIERC_PARAM_OFFSET:
         window->params = data;
+        window->set_fields |= NPCM_PARAMS;
         break;
 
     default:
@@ -305,7 +370,7 @@ static uint64_t npcm_pcie_host_config_read(void *opaque, hwaddr addr,
     PCIDevice *pcid = pci_find_device(pcih->bus, bus, devfn);
 
     if (pcid) {
-        return pci_host_config_read_common(pcid, addr,
+        return pci_host_config_read_common(pcid, (addr & 0x7FF),
                                            pci_config_size(pcid),
                                            size);
     }
@@ -323,7 +388,7 @@ static void npcm_pcie_host_config_write(void *opaque, hwaddr addr,
     PCIDevice *pcid = pci_find_device(pcih->bus, bus, devfn);
 
     if (pcid) {
-        pci_host_config_write_common(pcid, addr,
+        pci_host_config_write_common(pcid, (addr & 0x7FF),
                                      pci_config_size(pcid),
                                      data,
                                      size);
@@ -413,40 +478,43 @@ static void npcm_pcie_set_irq(void *opaque, int irq_num, int level)
 static void npcm_pcierc_realize(DeviceState *dev, Error **errp)
 {
     NPCMPCIERCState *s = NPCM_PCIERC(dev);
+    PCIHostState *phs = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     PCIDevice *root = pci_new(PCI_DEVFN(0, 0), TYPE_NPCM_PCIE_ROOT_PORT);
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &npcm_pcierc_cfg_ops,
-                          s, TYPE_NPCM_PCIERC, 4 * KiB);
-    sysbus_init_mmio(sbd, &s->mmio);
-    sysbus_init_irq(sbd, &s->irq);
+    /* init the underlying memory region for all PCI address space */
+    memory_region_init(&s->pcie_memory, OBJECT(s), "npcm-pcie-mem", UINT64_MAX);
 
-    /* IO memory region is needed to create a PCI bus, but is unused on ARM */
+    /* I/O memory region is needed to create a PCI bus, but is unused on ARM */
     memory_region_init(&s->pcie_io, OBJECT(s), "npcm-pcie-io", 16);
 
-    /*
-     * pcie_root is a 128 MiB memory region in the BMC physical address space
-     * in which all PCIe windows must have their programmable source or
-     * destination address
-     */
-    memory_region_init_io(&s->pcie_root, OBJECT(s), &npcm_pcie_cfg_space_ops,
-                          s, "npcm-pcie-config", 128 * MiB);
-    sysbus_init_mmio(sbd, &s->pcie_root);
-
-    pci->bus = pci_register_root_bus(dev, "pcie",
+    phs->bus = pci_register_root_bus(dev, "pcie",
                                      npcm_pcie_set_irq,
                                      pci_swizzle_map_irq_fn,
-                                     s, &s->pcie_root, &s->pcie_io,
+                                     s, &s->pcie_memory, &s->pcie_io,
                                      0, 4, TYPE_PCIE_BUS);
 
-    address_space_init(&s->pcie_space, &s->pcie_root, "pcie-address-space");
-    pci_realize_and_unref(root, pci->bus, &error_fatal);
-    pci_setup_iommu(pci->bus, &npcm_pcierc_iommu_ops, s);
+    address_space_init(&s->pcie_space, &s->pcie_memory, "pcie-address-space");
+    pci_setup_iommu(phs->bus, &npcm_pcierc_iommu_ops, s);
+    /* init region for root complex registers (not config space) */
+    memory_region_init_io(&s->rc_regs, OBJECT(s), &npcm_pcierc_cfg_ops,
+                          s, TYPE_NPCM_PCIERC, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->rc_regs);
+    sysbus_init_irq(sbd, &s->irq);
+
+    /* create and add region for the root port in config space */
+    memory_region_init_io(&s->rp_config, OBJECT(s),
+                          &npcm_pcie_cfg_space_ops, s, "npcm-pcie-config",
+                          4 * KiB);
 
+    /* realize the root port */
+    pci_realize_and_unref(root, phs->bus, &error_fatal);
+    /* enable MSI (non-X) in root port config space */
     msi_nonbroken = true;
     msi_init(root, NPCM_PCIERC_MSI_OFFSET, NPCM_PCIERC_MSI_NR,
              true, true, errp);
+
+    npcm_pcierc_reset_pcie_windows(s);
 }
 
 static void npcm_pcie_root_port_realize(DeviceState *dev, Error **errp)
@@ -461,13 +529,6 @@ static void npcm_pcie_root_port_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void npcm_pcierc_instance_init(Object *obj)
-{
-    NPCMPCIERCState *s = NPCM_PCIERC(obj);
-
-    npcm_pcierc_reset_pcie_windows(s);
-}
-
 static void npcm_pcierc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -507,7 +568,6 @@ static const TypeInfo npcm_pcierc_type_info = {
     .name = TYPE_NPCM_PCIERC,
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(NPCMPCIERCState),
-    .instance_init = npcm_pcierc_instance_init,
     .class_init = npcm_pcierc_class_init,
 };
 
diff --git a/include/hw/pci-host/npcm_pcierc.h b/include/hw/pci-host/npcm_pcierc.h
index 7d18177510f60d49f7fae7908dd1e3bfbe9ae12b..a986e7666abadd8c0bb97ac5e10853339f0fe815 100644
--- a/include/hw/pci-host/npcm_pcierc.h
+++ b/include/hw/pci-host/npcm_pcierc.h
@@ -96,6 +96,9 @@
 #define TYPE_NPCM_PCIERC "npcm-pcie-root-complex"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCIERCState, NPCM_PCIERC)
 
+#define NPCM_PCIE_HOLE       (0xe8000000)
+#define NPCM_PCIE_HOLE_END   (0xe8000000 + (128 * MiB))
+
 typedef enum {
     AXI2PCIE = 1,
     PCIE2AXI
@@ -111,6 +114,7 @@ typedef struct NPCMPCIEWindow {
 
     MemoryRegion mem;        /* QEMU memory subregion per window */
     NPCMPCIEWindowType type; /* translation direction */
+    uint8_t set_fields;
     uint8_t id;
 } NPCMPCIEWindow;
 
@@ -127,7 +131,7 @@ struct NPCMPCIERCState {
     qemu_irq irq;
 
     /* PCIe RC registers */
-    MemoryRegion mmio;
+    MemoryRegion rc_regs;
     uint32_t rccfgnum;
     uint32_t rcinten;
     uint32_t rcintstat;
@@ -137,8 +141,9 @@ struct NPCMPCIERCState {
 
     /* Address translation state */
     AddressSpace pcie_space;
-    MemoryRegion pcie_root;
+    MemoryRegion pcie_memory;
     MemoryRegion pcie_io; /* unused - but required for IO space PCI */
+    MemoryRegion rp_config;
     NPCMPCIERootPort port;
     /* PCIe to AXI Windows */
     NPCMPCIEWindow pcie2axi[NPCM_PCIERC_NUM_PA_WINDOWS];

-- 
2.51.0.384.g4c02a37b29-goog


