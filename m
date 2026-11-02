Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1C606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dury3mP5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCc-00030y-JH; Mon, 02 Nov 2026 08:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCa-00030P-Qd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:56 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCY-0002DT-5Y
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1553097f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626553; x=1794231353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gGXeT49TZQ78QeDAdMcRUBtIImn3fGcc8fGDoMsgEkI=;
 b=Dury3mP5zjXWF5f6DokAyCbsD8/1a3Tv6UWMMolYy/vOMLlds5kG++GPfdCjek6f/i
 CqEvL36BtSKLDcvnvSwgPHx4VmkHBu5PxYnr1l7JVh+ulb7NoHshQbN6E/U0hVEjnTIC
 wzZn9Q87QfadOQSaN8t449t+R1SEqRfo4apX0+bWGljY5w7pp60zB/jooYtDXG24yP5W
 LhP/oxDwtiK/56Q5RHnryMHJEOLJbtxbgmbmsCV2yCIm/QN90REFtg7Absmr6VGEP+bm
 i7NtrpVzIA7nh/fjSDrzp5UUqCmkkuoTt446eNlq+faoXOQY6L7V0zTddczq97HgZXH8
 owvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626553; x=1794231353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gGXeT49TZQ78QeDAdMcRUBtIImn3fGcc8fGDoMsgEkI=;
 b=day7bd7eRZCxyBRBIBxmuGa1GGZhXygyAgJF2ypx9UuI2jerXzQQJLx+RMDzI3SA2v
 Bi4u+qUc7JtR/r1QxUIHVEIa2+p9C49vieQW3iKiaU0uwfPTTIppHCIaioRu8n4Vx+nO
 Kv9zf4BhS4Y+UzDMSwLYGrM33/xUP6mvtbho0/mV6eZlgbejIopZJivw3s8X1RR/C11Z
 x7Vsr/6HSR0FfhJvh76I9KMVZB1n51Q79BewNNaKNAf65/9WXQG/p1GjqgEH8HeylU5y
 qgX3NVnWeBJOuq/xXoyRRdx0L+jtMV+55MAtR+V1ShfoBCwrCp/+DEdw4dTTzHUVb4MB
 1t2w==
X-Gm-Message-State: APuU4Z8cm7xvpkNT6uF1h/SqzNihtlzjDcNZZXsaPrJwm0XjQvaehxfe
 KiduzoUDvlv9aZggi4LtMSRYTaF7PSrLl736L2pA4Pb1RFsmsMFDSsehWJ3qYQxKd/NJPuwRoSS
 tKM9fEhk=
X-Gm-Gg: AYBFou0TBRU39yrvWmv47gmQXfpMJoWKP72XZ4GIlKn3GixYkmxMpDrUh3r/psjQqN5
 p1JllCQPW4Mz7+09Lro0Y2QvHZ/nfkz/kmVphLFanTbMKLhG1KI7L594ts9qw8YwJNQwzuOyGGk
 f4Jih8gjMNrhlHATnlCYJHjsMIEys9Lc+1aUeqTOxuvL66wJFbyeJ8e/QeAwZXjcgMlBHLYijr9
 J9/gv3UAB6BBQNt1kWmGUWHEdInAyfwMVoQyysmjIbtmtLgt+bDmyheQOitplNes96+MQ9L4qZK
 j8XMxlD12pNQN3T5digGI9P8GupTKjoqqWlpMMjFM7PIH22/qGuUu3Zgg00nwDvgtM92Sk+5WHO
 pt4ff+sAPmmoxT0FJ5xCMgsUamGzUK67bNt9cVsfyPeHSENpeqOA3hchJYTRtOE+qcMJJSXpvTR
 PZ9ItOATgHbeJeerq1BAP+SZa/6ygdnZNzzjXsFLiFO8PynyYp4uC0IbtVFledZGZ5XsZygAUwk
 Z8j5JZpdjKIpHlD66mnfnGuJy33sYwCmGgsJbcxTG33Kw+qnIZm8iM6tB+YXOMDCR4Cg3s6SYZI
 e8cz/TeCjJ9YtZ0V5KITqksYU2asK6vq2tGBzXRA33sX22+/qKwgW3+3puj0P2BgbENHwwrId9h
 zXz1bp75S1n29qVF1JB/vBecFbNMqrlK8gA==
X-Received: by 2002:a5d:5f07:0:b0:48c:7caa:12cd with SMTP id
 ffacd0b85a97d-48e6e4faddbmr23593795f8f.22.1793626552525; 
 Mon, 02 Nov 2026 05:35:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/47] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
Date: Mon,  2 Nov 2026 13:35:02 +0000
Message-ID: <20261102133547.1375701-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

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
Message-id: 20261027143036.44973-3-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_pcie.h |  19 +++
 hw/arm/bcm2838_pcie.c         | 212 ++++++++++++++++++++++++++++++++++
 hw/arm/trace-events           |   4 +
 3 files changed, 235 insertions(+)

diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
index cb95c653318..2cbea3062e9 100644
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
diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index edd174c3768..e580f0f9761 100644
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
index 1b16f710fed..579d4b12c21 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -96,3 +96,7 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 
 # bcm2838.c
 bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
+
+# bcm2838_pcie.c
+bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
-- 
2.43.0


