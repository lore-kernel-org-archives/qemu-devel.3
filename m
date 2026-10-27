Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEC606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxM0sGDg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiD3-0007St-GV; Tue, 27 Oct 2026 10:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCP-0007HF-Oa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:30:50 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCM-00056w-HY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:30:49 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-93cbc3ab2fdso187382185a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111444; x=1793716244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MXjfXnsz0n4mGNLPzNx5J+lJe24Ukh1Jl/JQuSIMCQ=;
 b=qxM0sGDg032EBO91iGHfpvYyZSDKV4k7xsN+OAqvt/SCVJAzMCyWXO33LFk5qeRGYR
 OfSjeO/U+OE1gCv98A8JY/TDQlT6J7V8if76wJVT2SW7wUWlaHsT+S1xN3heD0V9pJEl
 j+A3BBtP/no8Zoen8hCIdn54WkdbmHz/5cGAzGHi4aapaLEn/YDCttwMoMhqavAUvGtf
 94dCj7jBVE4JcQZW2e2kK4sQ/kzE65nuooB2iG1iu+MJFLqH5mq6V6tAAt2g6fVsnl7i
 ioF4MrEItLgn6GPy15aV//iLJpBF3v0J3ZseCVOt5dxPx3weK7Qowbu3H1WCBj60NJXu
 DcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111444; x=1793716244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9MXjfXnsz0n4mGNLPzNx5J+lJe24Ukh1Jl/JQuSIMCQ=;
 b=YEh0EQgy46Af5OMIMR9A4ocxDp4qlWKVu1R7JAZ13BFMUzPgNqcm77TqXX6wnafSJ+
 ne2aKMsNIcdPgAP57lBaree5A0xgmE45zTl8u82d3paPAOussQfS+xpS6rPI/2cq+WAM
 fWKjrWbcy0tdTELk/VKU/vmIgzJkP3s9wT4bzV+s7IN490gtNWZ3qo6Z8eK9PARmQvxP
 wS6tPeD+y8Xu8O4Bavj+OrwOLs40r/aAEUFHPRhPxpNXTaRjqHMhAe79wINgiMZf8oWy
 q39mNGSVyDwLJ3/V11KVlJfI/HuR7Yplgoqbujxy9U8XNUOGSQmCuHQcjX941ccJzG7x
 Eudg==
X-Gm-Message-State: AFq9FYL1SBJLzF322EhEHG3798stIq8gu9eT4M75MCypwwEm0vBlpnxc
 s15YBIICOwxUrHxkzvqqXkPECx+RcDvHFANOK5Hu2HL/Nd4mBluRlYJFmw1+Qrz+
X-Gm-Gg: AYBFou0VGJbsTBf/mDj/vkDTsoV9DNXZPPt6s6/AYFQGpOgduUKvEjMtYZwxHt/k7Pz
 s9GdCSPtZOYcJzePnHTANFeitFR7O5XmWjaZdadgTrWtocZYJotrhjO3sHRnN0UD4ao9MK78yqK
 D/aEuLNYXJ5maqdLHgjytcCsM2DQN+w3+HXJf1MHQMKMpdLY3qshwq2KPJMuwHHczEcWWq6imJu
 XvhGyd7w4/KHsLfq5PXKVq+VzihK+GzY0hz0+XA2kZNJfxPsl5P0kvlVFUpNhhM5kqilnaeNmj0
 1hUIkeTPIfg/KlptqIKBa5PydC0cwd1KIaegU0uxae1hOjzEqWYCX+J1+7smdispT1fecZv1uN8
 NjTVM+fW6USCz8X1L5Oxpnt5ekWdRoNoccsZ/YxJO8ZcngSE9whwSstffCRILnT8tnJN63/F1cr
 SwOzmDwqB9FBUgNvnzDx9qftcERQcc0bRvERhKA4/6ZtRQX6Pdr+GlSEDkbhkfghyXDsswU71bG
 KcOnC0uq7RE06p3ZPMOqdlhqQa3JRyGLt7xcWFVjsKlYoKuQ9V5uAcwjZASOuAvQ160xzvQsfRP
 Zb6mRf/IxwdtA0M6PDoI6zU27y7jwaypYPH5+zvC3P4+EizkwsY=
X-Received: by 2002:a05:620a:468c:b0:939:2d77:d6a8 with SMTP id
 af79cd13be357-940ef938c5dmr1496240385a.34.1793111444081; 
 Tue, 27 Oct 2026 07:30:44 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:30:43 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v6 02/17] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
Date: Tue, 27 Oct 2026 10:30:21 -0400
Message-ID: <20261027143036.44973-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the BCM2838 PCIe host bridge model: config space, MMIO window,
and register access for the root port.

Per Peter Maydell's review of a later follow-up series, fold in what
was originally a separate bugfix here, since this device isn't in
upstream git yet and the bug was in code this patch itself introduces.
Two defects fixed, both on the enumeration path (none of this was
exercised until a later patch actually attaches a PCI device):

1. bcm2838_pcie_host_read/write computed
   "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
   underflows for every offset below 4KB. The root port's own config
   space -- including vendor/device ID at offset 0 -- therefore always
   fell into the out-of-range branch and read back as all-ones, i.e.
   "no device present", so the guest stopped scanning immediately.

2. The root port overrode PCIDeviceClass::config_read/config_write with
   plain pci_default_*_config(). That bypasses rp_write_config() ->
   pci_bridge_write_config(), so programming the bridge's memory window
   never updated the bridge's address space and BARs behind the root
   port stayed unreachable. Drop the overrides and dispatch through
   pci_host_config_{read,write}_common() so the device's real handlers
   run.

Accesses to the EXT_CFG_DATA window are passed on to
pci_host_config_{read,write}_common() for the function that EXT_CFG_INDEX
selects.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2838_pcie.c         | 212 ++++++++++++++++++++++++++++++++++
 hw/arm/trace-events           |   4 +
 include/hw/arm/bcm2838_pcie.h |  19 +++
 3 files changed, 235 insertions(+)

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index edd174c376..e580f0f976 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci/pci_host.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -19,6 +20,216 @@
 #include "hw/arm/bcm2838_pcie.h"
 #include "trace.h"
 
+/*
+ * The register bytes in root_port.regs[] are little-endian whatever the host
+ * is, so access them with the ld*_le_p()/st*_le_p() helpers.
+ */
+static uint32_t bcm2838_pcie_ext_cfg_index(const uint8_t *root_regs)
+{
+    return ldl_le_p(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                    - PCIE_CONFIG_SPACE_SIZE);
+}
+
+/*
+ * EXT_CFG_INDEX selects the bus/device/function (in ECAM address layout) that
+ * the EXT_CFG_DATA window accesses; the offset within the window selects the
+ * register in that function's config space.
+ */
+static PCIDevice *bcm2838_pcie_ext_cfg_dev(BCM2838PcieHostState *s,
+                                           hwaddr data_offset,
+                                           uint32_t *conf_offset)
+{
+    uint32_t mmcfg_addr = bcm2838_pcie_ext_cfg_index(s->root_port.regs)
+        | PCIE_MMCFG_CONFOFFSET(data_offset);
+
+    *conf_offset = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
+    return pci_find_device(PCI_HOST_BRIDGE(s)->bus,
+                           PCIE_MMCFG_BUS(mmcfg_addr),
+                           PCIE_MMCFG_DEVFN(mmcfg_addr));
+}
+
+static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
+                                       unsigned size) {
+    uint64_t value = ~0;
+    BCM2838PcieHostState *s = opaque;
+    uint8_t *root_regs = s->root_port.regs;
+    PCIDevice *pci_dev;
+    uint32_t conf_offset;
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /*
+         * The first 4KB of the window is the root port's own PCI config
+         * space (vendor/device ID, BARs, capabilities). Serve it from the
+         * real PCIDevice, not from the raw regs[] shadow buffer, which is
+         * only backing store for the controller registers above 4KB.
+         */
+        value = pci_host_config_read_common(PCI_DEVICE(&s->root_port),
+                                            offset, PCIE_CONFIG_SPACE_SIZE,
+                                            size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            pci_dev = bcm2838_pcie_ext_cfg_dev(
+                s, offset - BCM2838_PCIE_EXT_CFG_DATA, &conf_offset);
+            if (pci_dev) {
+                value = pci_host_config_read_common(
+                    pci_dev, conf_offset, pci_config_size(pci_dev), size);
+            }
+            break;
+        default:
+            value = ldn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+
+    trace_bcm2838_pcie_host_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size) {
+    BCM2838PcieHostState *s = opaque;
+    uint8_t *root_regs = s->root_port.regs;
+    PCIDevice *pci_dev;
+    uint32_t conf_offset;
+
+    trace_bcm2838_pcie_host_write(size, offset, value);
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /* Root port's own PCI config space -- see read path above */
+        pci_host_config_write_common(PCI_DEVICE(&s->root_port), offset,
+                                     PCIE_CONFIG_SPACE_SIZE, value, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            pci_dev = bcm2838_pcie_ext_cfg_dev(
+                s, offset - BCM2838_PCIE_EXT_CFG_DATA, &conf_offset);
+            if (pci_dev) {
+                pci_host_config_write_common(
+                    pci_dev, conf_offset, pci_config_size(pci_dev),
+                    value, size);
+            }
+            break;
+        default:
+            stn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size, value);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+}
+
+static const MemoryRegionOps bcm2838_pcie_host_ops = {
+    .read = bcm2838_pcie_host_read,
+    .write = bcm2838_pcie_host_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {.max_access_size = 8},
+};
+
+static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
+{
+    BCM2838PcieHostState *s = opaque;
+
+    qemu_set_irq(s->irq[irq_num], level);
+}
+
+static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
+{
+    /* Only slot 0 exists behind the root port: nothing to swizzle */
+    return pin;
+}
+
+static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    int i;
+
+    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
+                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->cfg_regs);
+
+    /*
+     * io_mmio and io_ioport are the PCI view of the PCI address space that we
+     * pass to pci_register_root_bus(). The io_mmio_window and io_ioport_window
+     * containers hold them as subregions and are what we expose as SysBus
+     * MRs: accesses to addresses where no PCI device has been mapped read as
+     * -1 and ignore writes.
+     */
+    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
+    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
+                       64 * 1024);
+
+    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
+                            &unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_mmio_window", UINT64_MAX);
+    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
+                            &unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
+    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
+    sysbus_init_mmio(sbd, &s->io_mmio_window);
+    sysbus_init_mmio(sbd, &s->io_ioport_window);
+
+    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+
+    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
+                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
+                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
+                                     TYPE_PCIE_BUS);
+    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
+}
+
+static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
+                                                   PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void bcm2838_pcie_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = bcm2838_pcie_host_root_bus_path;
+    dc->realize = bcm2838_pcie_host_realize;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static void bcm2838_pcie_host_initfn(Object *obj)
+{
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
+    BCM2838PcieRootState *root = &s->root_port;
+
+    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
+}
+
+static const TypeInfo bcm2838_pcie_host_info = {
+    .name       = TYPE_BCM2838_PCIE_HOST,
+    .parent     = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(BCM2838PcieHostState),
+    .instance_init = bcm2838_pcie_host_initfn,
+    .class_init = bcm2838_pcie_host_class_init,
+};
+
 /*
  * RC root part (D0:F0)
  */
@@ -96,6 +307,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
 static void bcm2838_pcie_register(void)
 {
     type_register_static(&bcm2838_pcie_root_info);
+    type_register_static(&bcm2838_pcie_host_info);
 }
 
 type_init(bcm2838_pcie_register)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 1b16f710fe..579d4b12c2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -96,3 +96,7 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 
 # bcm2838.c
 bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
+
+# bcm2838_pcie.c
+bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
index cb95c65331..2cbea3062e 100644
--- a/include/hw/arm/bcm2838_pcie.h
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -16,6 +16,9 @@
 #include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
+#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
+
 #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
 OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
                     BCM2838_PCIE_ROOT)
@@ -51,4 +54,20 @@ struct BCM2838PcieRootClass {
 };
 
 
+struct BCM2838PcieHostState {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+
+    /*< public >*/
+    BCM2838PcieRootState root_port;
+
+    MemoryRegion cfg_regs;
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+
+    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
+};
+
 #endif /* BCM2838_PCIE_H */
-- 
2.55.0


