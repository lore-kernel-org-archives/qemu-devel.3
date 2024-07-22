Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B4FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkk-0007Up-W4; Sun, 21 Jul 2024 20:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkj-0007Nt-CY
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkg-0005rP-Qr
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tGGZEhtbp9ay4AH88sYN+WiW+/lZSrz5NaUQDZ8AZbM=;
 b=XXl+ktruxzup652ORPAQi8mY1yvT0/aaiynV1i2xtKq1Jk4scx42PjAs4yHOXHDt1fRy0j
 ayr1RwiZSAYgtqHYm/Nxb/cNLKtWJRsSvU6Iqk9FsjX8xrPExpd4ei6s3HI9wRAwM8FGvT
 +qzjpnYNm7r66nGsBwHCTaWC84ZRMxY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-hB-eVHUzOBeteQBWJSHIaw-1; Sun, 21 Jul 2024 20:18:02 -0400
X-MC-Unique: hB-eVHUzOBeteQBWJSHIaw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42668699453so37766545e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607481; x=1722212281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGGZEhtbp9ay4AH88sYN+WiW+/lZSrz5NaUQDZ8AZbM=;
 b=EPCaxcerBkmppil0PZObZ7FPz7KgnJ0Uowf4v+ki7DGF4tekJu0UnJk+e4DUbJ/ddb
 zU/PooYAHZcTjl8imrLV0aCAKhJ1Hb1MKxe9kJJkH+QDvEZbWSkPjdK7lPxPHL/rbiUd
 i+UdDoVxNLaGBx7cm1uRuwk4NfK7xURMmFxrMJ1k4jBSpFVjYUPWFNWbn+idWGqwvInK
 yJmWDLDy7qSNs3GsdK31D3dkLrg9jNiIG35nwEozwxHrDO08gIBZ8BuIBJLTsnXvKYED
 jRuFHrcq5+jNNWsa5AHqMztkPXM2oK8XAzdwEKcOESIIXt1hi3W8E8yGDg0DlS60TYD2
 8z5g==
X-Gm-Message-State: AOJu0YzmktMA7jfzFJfMFlyivy1y+lrukt3Ovct1E9BaHFu8mbIU/ohU
 L3iqZLeRMeMFKSt5lVKR1SiuOSovfifoXytRJh15F+BEabbGl53RA+22fyJ2kF97vxfoM87ZZXP
 wGictTCtCPTylurZFSdd2uSj/cAJYhEfuyhXY4YXyw11cfs9rn9lKHBDgu9pvYoPYH7FGKqGbrS
 AYhlR+hG7ux6xwYftNxMBe66M6+Wfi0Q==
X-Received: by 2002:a05:600c:3550:b0:426:615f:f715 with SMTP id
 5b1f17b1804b1-427dc52920fmr43222435e9.23.1721607480877; 
 Sun, 21 Jul 2024 17:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRQblEa7pPLrqaF4bc/48wGfU0JB/dmtRgJTtMsqRR/omgV+Nb56307SBn3MQrSENIHcfACw==
X-Received: by 2002:a05:600c:3550:b0:426:615f:f715 with SMTP id
 5b1f17b1804b1-427dc52920fmr43222265e9.23.1721607480273; 
 Sun, 21 Jul 2024 17:18:00 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e42bsm135528525e9.30.2024.07.21.17.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:59 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 33/63] pcie_sriov: Allow user to create SR-IOV device
Message-ID: <c77437b462b918051443162d3f703fea9954a51a.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A user can create a SR-IOV device by specifying the PF with the
sriov-pf property of the VFs. The VFs must be added before the PF.

A user-creatable VF must have PCIDeviceClass::sriov_vf_user_creatable
set. Such a VF cannot refer to the PF because it is created before the
PF.

A PF that user-creatable VFs can be attached calls
pcie_sriov_pf_init_from_user_created_vfs() during realization and
pcie_sriov_pf_exit() when exiting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-5-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  18 +++
 hw/pci/pci.c                |  62 +++++---
 hw/pci/pcie_sriov.c         | 290 ++++++++++++++++++++++++++++--------
 4 files changed, 293 insertions(+), 83 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca15132508..cefd6f7640 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -37,6 +37,8 @@ struct PCIDeviceClass {
     uint16_t subsystem_id;              /* only for header type = 0 */
 
     const char *romfile;                /* rom bar */
+
+    bool sriov_vf_user_creatable;
 };
 
 enum PCIReqIDType {
@@ -160,6 +162,8 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    char *sriov_pf;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
@@ -192,7 +196,7 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
 
 static inline int pci_is_vf(const PCIDevice *d)
 {
-    return d->exp.sriov_vf.pf != NULL;
+    return d->sriov_pf || d->exp.sriov_vf.pf != NULL;
 }
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index c5d2d318d3..f75b8f22ee 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,6 +18,7 @@
 typedef struct PCIESriovPF {
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
+    bool vf_user_created; /* If VFs are created by user */
 } PCIESriovPF;
 
 typedef struct PCIESriovVF {
@@ -40,6 +41,23 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory);
 
+/**
+ * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
+ *                                              VFs.
+ * @dev: A PCIe device being realized.
+ * @offset: The offset of the SR-IOV capability.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: The size of added capability. 0 if the user did not create VFs.
+ *         -1 if failed.
+ */
+int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
+                                                 uint16_t offset,
+                                                 Error **errp);
+
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
+void pcie_sriov_unregister_device(PCIDevice *dev);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dbd954f1fe..61699b2cb8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -959,13 +960,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
         dev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
-    /*
-     * With SR/IOV and ARI, a device at function 0 need not be a multifunction
-     * device, as it may just be a VF that ended up with function 0 in
-     * the legacy PCI interpretation. Avoid failing in such cases:
-     */
-    if (pci_is_vf(dev) &&
-        dev->exp.sriov_vf.pf->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+    /* SR/IOV is not handled here. */
+    if (pci_is_vf(dev)) {
         return;
     }
 
@@ -998,7 +994,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
     }
     /* function 0 indicates single function, so function > 0 must be NULL */
     for (func = 1; func < PCI_FUNC_MAX; ++func) {
-        if (bus->devices[PCI_DEVFN(slot, func)]) {
+        PCIDevice *device = bus->devices[PCI_DEVFN(slot, func)];
+        if (device && !pci_is_vf(device)) {
             error_setg(errp, "PCI: %x.0 indicates single function, "
                        "but %x.%x is already populated.",
                        slot, slot, func);
@@ -1283,6 +1280,7 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
+    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1314,7 +1312,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
-    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1325,7 +1322,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
-    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1333,22 +1329,35 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    wmask = ~(size - 1);
-    if (region_num == PCI_ROM_SLOT) {
-        /* ROM enable bit is writable */
-        wmask |= PCI_ROM_ADDRESS_ENABLE;
-    }
+    if (pci_is_vf(pci_dev)) {
+        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
+        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
 
-    addr = pci_bar(pci_dev, region_num);
-    pci_set_long(pci_dev->config + addr, type);
-
-    if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
-        r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-        pci_set_quad(pci_dev->wmask + addr, wmask);
-        pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
+        if (r->addr != PCI_BAR_UNMAPPED) {
+            memory_region_add_subregion_overlap(r->address_space,
+                                                r->addr, r->memory, 1);
+        }
     } else {
-        pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
-        pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        r->addr = PCI_BAR_UNMAPPED;
+
+        wmask = ~(size - 1);
+        if (region_num == PCI_ROM_SLOT) {
+            /* ROM enable bit is writable */
+            wmask |= PCI_ROM_ADDRESS_ENABLE;
+        }
+
+        addr = pci_bar(pci_dev, region_num);
+        pci_set_long(pci_dev->config + addr, type);
+
+        if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
+            r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+            pci_set_quad(pci_dev->wmask + addr, wmask);
+            pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        } else {
+            pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
+            pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        }
     }
 }
 
@@ -2109,6 +2118,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 15a4aac1f4..0fc9f810b9 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,6 +20,8 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+static GHashTable *pfs;
+
 static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
 {
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -31,14 +33,49 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
     dev->exp.sriov_pf.vf = NULL;
 }
 
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp)
+static void clear_ctrl_vfe(PCIDevice *dev)
+{
+    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
+    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+}
+
+static void register_vfs(PCIDevice *dev)
+{
+    uint16_t num_vfs;
+    uint16_t i;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+
+    assert(sriov_cap > 0);
+    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        clear_ctrl_vfe(dev);
+        return;
+    }
+
+    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
+                             PCI_FUNC(dev->devfn), num_vfs);
+    for (i = 0; i < num_vfs; i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    }
+}
+
+static void unregister_vfs(PCIDevice *dev)
+{
+    uint16_t i;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    }
+}
+
+static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
+                                      uint16_t vf_dev_id, uint16_t init_vfs,
+                                      uint16_t total_vfs, uint16_t vf_offset,
+                                      uint16_t vf_stride, Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(&dev->qdev);
-    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -100,6 +137,28 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
+    return true;
+}
+
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+                        const char *vfname, uint16_t vf_dev_id,
+                        uint16_t init_vfs, uint16_t total_vfs,
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
+{
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
+
+    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, init_vfs,
+                                   total_vfs, vf_offset, vf_stride, errp)) {
+        return false;
+    }
+
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -129,7 +188,24 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
 {
     uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
-    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    if (dev->exp.sriov_pf.vf_user_created) {
+        uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
+        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
+
+        unregister_vfs(dev);
+
+        for (uint16_t i = 0; i < total_vfs; i++) {
+            PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+
+            vf->exp.sriov_vf.pf = NULL;
+
+            pci_config_set_vendor_id(vf->config, ven_id);
+            pci_config_set_device_id(vf->config, vf_dev_id);
+        }
+    } else {
+        unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    }
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -162,74 +238,172 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory)
 {
-    PCIIORegion *r;
-    PCIBus *bus = pci_get_bus(dev);
     uint8_t type;
-    pcibus_t size = memory_region_size(memory);
 
-    assert(pci_is_vf(dev)); /* PFs must use pci_register_bar */
-    assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
+    assert(dev->exp.sriov_vf.pf);
     type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
 
-    if (!is_power_of_2(size)) {
-        error_report("%s: PCI region size must be a power"
-                     " of two - type=0x%x, size=0x%"FMT_PCIBUS,
-                     __func__, type, size);
-        exit(1);
-    }
-
-    r = &dev->io_regions[region_num];
-    r->memory = memory;
-    r->address_space =
-        type & PCI_BASE_ADDRESS_SPACE_IO
-        ? bus->address_space_io
-        : bus->address_space_mem;
-    r->size = size;
-    r->type = type;
-
-    r->addr = pci_bar_address(dev, region_num, r->type, r->size);
-    if (r->addr != PCI_BAR_UNMAPPED) {
-        memory_region_add_subregion_overlap(r->address_space,
-                                            r->addr, r->memory, 1);
-    }
+    return pci_register_bar(dev, region_num, type, memory);
 }
 
-static void clear_ctrl_vfe(PCIDevice *dev)
+static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
-    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
-    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+    return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
 }
 
-static void register_vfs(PCIDevice *dev)
+int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
+                                                 uint16_t offset,
+                                                 Error **errp)
 {
-    uint16_t num_vfs;
+    GPtrArray *pf;
+    PCIDevice **vfs;
+    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t vf_dev_id;
+    uint16_t vf_offset;
+    uint16_t vf_stride;
     uint16_t i;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
 
-    assert(sriov_cap > 0);
-    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        clear_ctrl_vfe(dev);
-        return;
+    if (!pfs || !dev->qdev.id) {
+        return 0;
     }
 
-    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
-                             PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    pf = g_hash_table_lookup(pfs, dev->qdev.id);
+    if (!pf) {
+        return 0;
     }
+
+    if (pf->len > UINT16_MAX) {
+        error_setg(errp, "too many VFs");
+        return -1;
+    }
+
+    g_ptr_array_sort(pf, compare_vf_devfns);
+    vfs = (void *)pf->pdata;
+
+    if (vfs[0]->devfn <= dev->devfn) {
+        error_setg(errp, "a VF function number is less than the PF function number");
+        return -1;
+    }
+
+    vf_dev_id = pci_get_word(vfs[0]->config + PCI_DEVICE_ID);
+    vf_offset = vfs[0]->devfn - dev->devfn;
+    vf_stride = pf->len < 2 ? 0 : vfs[1]->devfn - vfs[0]->devfn;
+
+    for (i = 0; i < pf->len; i++) {
+        if (bus != qdev_get_parent_bus(&vfs[i]->qdev)) {
+            error_setg(errp, "SR-IOV VF parent bus mismatches with PF");
+            return -1;
+        }
+
+        if (ven_id != pci_get_word(vfs[i]->config + PCI_VENDOR_ID)) {
+            error_setg(errp, "SR-IOV VF vendor ID mismatches with PF");
+            return -1;
+        }
+
+        if (vf_dev_id != pci_get_word(vfs[i]->config + PCI_DEVICE_ID)) {
+            error_setg(errp, "inconsistent SR-IOV VF device IDs");
+            return -1;
+        }
+
+        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+            if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
+                vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
+                error_setg(errp, "inconsistent SR-IOV BARs");
+                return -1;
+            }
+        }
+
+        if (vfs[i]->devfn - vfs[0]->devfn != vf_stride * i) {
+            error_setg(errp, "inconsistent SR-IOV stride");
+            return -1;
+        }
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, pf->len,
+                                   pf->len, vf_offset, vf_stride, errp)) {
+        return -1;
+    }
+
+    for (i = 0; i < pf->len; i++) {
+        vfs[i]->exp.sriov_vf.pf = dev;
+        vfs[i]->exp.sriov_vf.vf_number = i;
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vfs[i]->config, 0xffff);
+        pci_config_set_device_id(vfs[i]->config, 0xffff);
+    }
+
+    dev->exp.sriov_pf.vf = vfs;
+    dev->exp.sriov_pf.vf_user_created = true;
+
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        PCIIORegion *region = &vfs[0]->io_regions[i];
+
+        if (region->size) {
+            pcie_sriov_pf_init_vf_bar(dev, i, region->type, region->size);
+        }
+    }
+
+    return PCI_EXT_CAP_SRIOV_SIZEOF;
 }
 
-static void unregister_vfs(PCIDevice *dev)
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
 {
-    uint16_t i;
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
 
-    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    if (dev->sriov_pf) {
+        PCIDevice *pci_pf;
+        GPtrArray *pf;
+
+        if (!PCI_DEVICE_GET_CLASS(dev)->sriov_vf_user_creatable) {
+            error_setg(errp, "user cannot create SR-IOV VF with this device type");
+            return false;
+        }
+
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+
+        if (!pci_qdev_find_device(dev->sriov_pf, &pci_pf)) {
+            error_setg(errp, "PCI device specified as SR-IOV PF already exists");
+            return false;
+        }
+
+        if (!pfs) {
+            pfs = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+        }
+
+        pf = g_hash_table_lookup(pfs, dev->sriov_pf);
+        if (!pf) {
+            pf = g_ptr_array_new();
+            g_hash_table_insert(pfs, g_strdup(dev->sriov_pf), pf);
+        }
+
+        g_ptr_array_add(pf, dev);
+    }
+
+    return true;
+}
+
+void pcie_sriov_unregister_device(PCIDevice *dev)
+{
+    if (dev->sriov_pf && pfs) {
+        GPtrArray *pf = g_hash_table_lookup(pfs, dev->sriov_pf);
+
+        if (pf) {
+            g_ptr_array_remove_fast(pf, dev);
+
+            if (!pf->len) {
+                g_hash_table_remove(pfs, dev->sriov_pf);
+                g_ptr_array_free(pf, FALSE);
+            }
+        }
     }
 }
 
@@ -316,7 +490,7 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize)
 
 uint16_t pcie_sriov_vf_number(PCIDevice *dev)
 {
-    assert(pci_is_vf(dev));
+    assert(dev->exp.sriov_vf.pf);
     return dev->exp.sriov_vf.vf_number;
 }
 
-- 
MST


