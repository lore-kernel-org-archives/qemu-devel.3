Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64266C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAL-00032M-54; Thu, 01 Aug 2024 06:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAJ-00031K-A2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAG-0001Zd-T8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugSEKs2cZK1SSCVwSLS6qJ+0laBmwuBRQ+6Ul2jMCzQ=;
 b=E1hgMvhVMRGOllT7b3Ef5VzMPsqqxtiYPgh+1u2r/wMVb20Kj+atXT3O4TA9kbNXYF0nwl
 slLcw/6twmGbdCGVVI+giQKdMQ1qOIy3aZiDh+5HXmagL2nSQob1z3ci1jGaVVBFACP6JW
 D+Dm+OAo1eEyfaJo2/KZ0hrx0mlYp0w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-hPb5S-zyMtisu7lJ6xsk1A-1; Thu, 01 Aug 2024 06:36:06 -0400
X-MC-Unique: hPb5S-zyMtisu7lJ6xsk1A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52f02f1773fso7684133e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508564; x=1723113364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugSEKs2cZK1SSCVwSLS6qJ+0laBmwuBRQ+6Ul2jMCzQ=;
 b=b//EZ/nxGb1XkOVYzRNINIHVrB3CTNnQ/Sk2RLZG8VLdAtdODfQYulCvpdM2j9OQ0m
 xKoWV1y/Zz4BK2Igb+kKRzMGTyzemRg35tzfbgsOGTAS7YnkmlDIxtSXscHUHclksW8Y
 KnUijsAMQfjZG3MYf1hexTewZK/KcUM+qkxXvuf/W4j9nYA7444+jU6tFV7fU97oJTjC
 X3MHEn4ddF6HTJ/rIGEoFF0xbLSj/4+WTOZiln4GF6Nu0MPOywaz4hGXV1/fgD8zCcYf
 TxSg7vBwAttJHnBnC21sitYy4CQwoh6N7gnXZyO3Xp0MC2h56DAg7arp/3MRL4V13jlN
 jiTA==
X-Gm-Message-State: AOJu0YzGTcCEg5w/nIR1WJ8cgo8JUlnPnpF7DricbLrBK8fbz8XJ4cx/
 NkebssllUv9jWhHqbqyCJmFGU+ghc53Y+DGPwclIJ8pC41TsQwd6oUzH4DLi6sXkgCz5vlvQfQy
 YElBbjk3idgOsTEmAcX5FLaea1eecO0+kzT+f4tMgVNL++8Db9D/NnE6OVpxAOSxydqnS7vNe5I
 Wt/crV+vq7H+9Em7rSq2vtUU3F8Tnasw==
X-Received: by 2002:a05:6512:250c:b0:52e:9be7:91aa with SMTP id
 2adb3069b0e04-530b619a948mr1469839e87.10.1722508564232; 
 Thu, 01 Aug 2024 03:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8eH5cOvva/QTn6roOFD6lTShcXME0/GcpKx97I1M7UUZmzOzgludeyL6aJmdRCLw6B+OaQ==
X-Received: by 2002:a05:6512:250c:b0:52e:9be7:91aa with SMTP id
 2adb3069b0e04-530b619a948mr1469773e87.10.1722508563280; 
 Thu, 01 Aug 2024 03:36:03 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2310fsm874820566b.42.2024.08.01.03.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:01 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/19] Revert "pcie_sriov: Allow user to create SR-IOV device"
Message-ID: <aa01c4914ed6f6c087ee172483e22a515c4cc66a.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 122173a5830f7757f8a94a3b1559582f312e140b.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  18 ---
 hw/pci/pci.c                |  62 +++-----
 hw/pci/pcie_sriov.c         | 290 ++++++++----------------------------
 4 files changed, 83 insertions(+), 293 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index e7e41cb939..1ff3ce94e2 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -38,8 +38,6 @@ struct PCIDeviceClass {
     uint16_t subsystem_id;              /* only for header type = 0 */
 
     const char *romfile;                /* rom bar */
-
-    bool sriov_vf_user_creatable;
 };
 
 enum PCIReqIDType {
@@ -169,8 +167,6 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
-
-    char *sriov_pf;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
@@ -203,7 +199,7 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
 
 static inline int pci_is_vf(const PCIDevice *d)
 {
-    return d->sriov_pf || d->exp.sriov_vf.pf != NULL;
+    return d->exp.sriov_vf.pf != NULL;
 }
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index f75b8f22ee..c5d2d318d3 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,7 +18,6 @@
 typedef struct PCIESriovPF {
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
-    bool vf_user_created; /* If VFs are created by user */
 } PCIESriovPF;
 
 typedef struct PCIESriovVF {
@@ -41,23 +40,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory);
 
-/**
- * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
- *                                              VFs.
- * @dev: A PCIe device being realized.
- * @offset: The offset of the SR-IOV capability.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Return: The size of added capability. 0 if the user did not create VFs.
- *         -1 if failed.
- */
-int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
-                                                 uint16_t offset,
-                                                 Error **errp);
-
-bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
-void pcie_sriov_unregister_device(PCIDevice *dev);
-
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8ad5d7e2d8..cf2794879d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,7 +85,6 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
-    DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -960,8 +959,13 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
         dev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
-    /* SR/IOV is not handled here. */
-    if (pci_is_vf(dev)) {
+    /*
+     * With SR/IOV and ARI, a device at function 0 need not be a multifunction
+     * device, as it may just be a VF that ended up with function 0 in
+     * the legacy PCI interpretation. Avoid failing in such cases:
+     */
+    if (pci_is_vf(dev) &&
+        dev->exp.sriov_vf.pf->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
         return;
     }
 
@@ -994,8 +998,7 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
     }
     /* function 0 indicates single function, so function > 0 must be NULL */
     for (func = 1; func < PCI_FUNC_MAX; ++func) {
-        PCIDevice *device = bus->devices[PCI_DEVFN(slot, func)];
-        if (device && !pci_is_vf(device)) {
+        if (bus->devices[PCI_DEVFN(slot, func)]) {
             error_setg(errp, "PCI: %x.0 indicates single function, "
                        "but %x.%x is already populated.",
                        slot, slot, func);
@@ -1280,7 +1283,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
-    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1312,6 +1314,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
+    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1322,6 +1325,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
+    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1329,35 +1333,22 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    if (pci_is_vf(pci_dev)) {
-        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
-        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
+    wmask = ~(size - 1);
+    if (region_num == PCI_ROM_SLOT) {
+        /* ROM enable bit is writable */
+        wmask |= PCI_ROM_ADDRESS_ENABLE;
+    }
 
-        r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
-        if (r->addr != PCI_BAR_UNMAPPED) {
-            memory_region_add_subregion_overlap(r->address_space,
-                                                r->addr, r->memory, 1);
-        }
+    addr = pci_bar(pci_dev, region_num);
+    pci_set_long(pci_dev->config + addr, type);
+
+    if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
+        r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+        pci_set_quad(pci_dev->wmask + addr, wmask);
+        pci_set_quad(pci_dev->cmask + addr, ~0ULL);
     } else {
-        r->addr = PCI_BAR_UNMAPPED;
-
-        wmask = ~(size - 1);
-        if (region_num == PCI_ROM_SLOT) {
-            /* ROM enable bit is writable */
-            wmask |= PCI_ROM_ADDRESS_ENABLE;
-        }
-
-        addr = pci_bar(pci_dev, region_num);
-        pci_set_long(pci_dev->config + addr, type);
-
-        if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
-            r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-            pci_set_quad(pci_dev->wmask + addr, wmask);
-            pci_set_quad(pci_dev->cmask + addr, ~0ULL);
-        } else {
-            pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
-            pci_set_long(pci_dev->cmask + addr, 0xffffffff);
-        }
+        pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
+        pci_set_long(pci_dev->cmask + addr, 0xffffffff);
     }
 }
 
@@ -2118,11 +2109,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    if (!pcie_sriov_register_device(pci_dev, errp)) {
-        pci_qdev_unrealize(DEVICE(pci_dev));
-        return;
-    }
-
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 0fc9f810b9..15a4aac1f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,8 +20,6 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-static GHashTable *pfs;
-
 static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
 {
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -33,49 +31,14 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
     dev->exp.sriov_pf.vf = NULL;
 }
 
-static void clear_ctrl_vfe(PCIDevice *dev)
-{
-    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
-    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
-}
-
-static void register_vfs(PCIDevice *dev)
-{
-    uint16_t num_vfs;
-    uint16_t i;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-
-    assert(sriov_cap > 0);
-    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        clear_ctrl_vfe(dev);
-        return;
-    }
-
-    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
-                             PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
-    }
-}
-
-static void unregister_vfs(PCIDevice *dev)
-{
-    uint16_t i;
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
-
-    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
-    }
-}
-
-static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
-                                      uint16_t vf_dev_id, uint16_t init_vfs,
-                                      uint16_t total_vfs, uint16_t vf_offset,
-                                      uint16_t vf_stride, Error **errp)
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+                        const char *vfname, uint16_t vf_dev_id,
+                        uint16_t init_vfs, uint16_t total_vfs,
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
 {
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -137,28 +100,6 @@ static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
-    return true;
-}
-
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp)
-{
-    BusState *bus = qdev_get_parent_bus(&dev->qdev);
-    int32_t devfn = dev->devfn + vf_offset;
-
-    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
-        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
-        return false;
-    }
-
-    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, init_vfs,
-                                   total_vfs, vf_offset, vf_stride, errp)) {
-        return false;
-    }
-
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -188,24 +129,7 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
 {
     uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
-    if (dev->exp.sriov_pf.vf_user_created) {
-        uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
-        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
-        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
-
-        unregister_vfs(dev);
-
-        for (uint16_t i = 0; i < total_vfs; i++) {
-            PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-
-            vf->exp.sriov_vf.pf = NULL;
-
-            pci_config_set_vendor_id(vf->config, ven_id);
-            pci_config_set_device_id(vf->config, vf_dev_id);
-        }
-    } else {
-        unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
-    }
+    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -238,172 +162,74 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory)
 {
+    PCIIORegion *r;
+    PCIBus *bus = pci_get_bus(dev);
     uint8_t type;
+    pcibus_t size = memory_region_size(memory);
 
-    assert(dev->exp.sriov_vf.pf);
+    assert(pci_is_vf(dev)); /* PFs must use pci_register_bar */
+    assert(region_num >= 0);
+    assert(region_num < PCI_NUM_REGIONS);
     type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
 
-    return pci_register_bar(dev, region_num, type, memory);
+    if (!is_power_of_2(size)) {
+        error_report("%s: PCI region size must be a power"
+                     " of two - type=0x%x, size=0x%"FMT_PCIBUS,
+                     __func__, type, size);
+        exit(1);
+    }
+
+    r = &dev->io_regions[region_num];
+    r->memory = memory;
+    r->address_space =
+        type & PCI_BASE_ADDRESS_SPACE_IO
+        ? bus->address_space_io
+        : bus->address_space_mem;
+    r->size = size;
+    r->type = type;
+
+    r->addr = pci_bar_address(dev, region_num, r->type, r->size);
+    if (r->addr != PCI_BAR_UNMAPPED) {
+        memory_region_add_subregion_overlap(r->address_space,
+                                            r->addr, r->memory, 1);
+    }
 }
 
-static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
+static void clear_ctrl_vfe(PCIDevice *dev)
 {
-    return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
+    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
+    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
 }
 
-int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
-                                                 uint16_t offset,
-                                                 Error **errp)
+static void register_vfs(PCIDevice *dev)
 {
-    GPtrArray *pf;
-    PCIDevice **vfs;
-    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
-    uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
-    uint16_t vf_dev_id;
-    uint16_t vf_offset;
-    uint16_t vf_stride;
+    uint16_t num_vfs;
     uint16_t i;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
 
-    if (!pfs || !dev->qdev.id) {
-        return 0;
+    assert(sriov_cap > 0);
+    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        clear_ctrl_vfe(dev);
+        return;
     }
 
-    pf = g_hash_table_lookup(pfs, dev->qdev.id);
-    if (!pf) {
-        return 0;
+    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
+                             PCI_FUNC(dev->devfn), num_vfs);
+    for (i = 0; i < num_vfs; i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
-
-    if (pf->len > UINT16_MAX) {
-        error_setg(errp, "too many VFs");
-        return -1;
-    }
-
-    g_ptr_array_sort(pf, compare_vf_devfns);
-    vfs = (void *)pf->pdata;
-
-    if (vfs[0]->devfn <= dev->devfn) {
-        error_setg(errp, "a VF function number is less than the PF function number");
-        return -1;
-    }
-
-    vf_dev_id = pci_get_word(vfs[0]->config + PCI_DEVICE_ID);
-    vf_offset = vfs[0]->devfn - dev->devfn;
-    vf_stride = pf->len < 2 ? 0 : vfs[1]->devfn - vfs[0]->devfn;
-
-    for (i = 0; i < pf->len; i++) {
-        if (bus != qdev_get_parent_bus(&vfs[i]->qdev)) {
-            error_setg(errp, "SR-IOV VF parent bus mismatches with PF");
-            return -1;
-        }
-
-        if (ven_id != pci_get_word(vfs[i]->config + PCI_VENDOR_ID)) {
-            error_setg(errp, "SR-IOV VF vendor ID mismatches with PF");
-            return -1;
-        }
-
-        if (vf_dev_id != pci_get_word(vfs[i]->config + PCI_DEVICE_ID)) {
-            error_setg(errp, "inconsistent SR-IOV VF device IDs");
-            return -1;
-        }
-
-        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
-            if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
-                vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
-                error_setg(errp, "inconsistent SR-IOV BARs");
-                return -1;
-            }
-        }
-
-        if (vfs[i]->devfn - vfs[0]->devfn != vf_stride * i) {
-            error_setg(errp, "inconsistent SR-IOV stride");
-            return -1;
-        }
-    }
-
-    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, pf->len,
-                                   pf->len, vf_offset, vf_stride, errp)) {
-        return -1;
-    }
-
-    for (i = 0; i < pf->len; i++) {
-        vfs[i]->exp.sriov_vf.pf = dev;
-        vfs[i]->exp.sriov_vf.vf_number = i;
-
-        /* set vid/did according to sr/iov spec - they are not used */
-        pci_config_set_vendor_id(vfs[i]->config, 0xffff);
-        pci_config_set_device_id(vfs[i]->config, 0xffff);
-    }
-
-    dev->exp.sriov_pf.vf = vfs;
-    dev->exp.sriov_pf.vf_user_created = true;
-
-    for (i = 0; i < PCI_NUM_REGIONS; i++) {
-        PCIIORegion *region = &vfs[0]->io_regions[i];
-
-        if (region->size) {
-            pcie_sriov_pf_init_vf_bar(dev, i, region->type, region->size);
-        }
-    }
-
-    return PCI_EXT_CAP_SRIOV_SIZEOF;
 }
 
-bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
+static void unregister_vfs(PCIDevice *dev)
 {
-    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
-        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
-        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
-        return false;
-    }
+    uint16_t i;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
-    if (dev->sriov_pf) {
-        PCIDevice *pci_pf;
-        GPtrArray *pf;
-
-        if (!PCI_DEVICE_GET_CLASS(dev)->sriov_vf_user_creatable) {
-            error_setg(errp, "user cannot create SR-IOV VF with this device type");
-            return false;
-        }
-
-        if (!pci_is_express(dev)) {
-            error_setg(errp, "PCI Express is required for SR-IOV VF");
-            return false;
-        }
-
-        if (!pci_qdev_find_device(dev->sriov_pf, &pci_pf)) {
-            error_setg(errp, "PCI device specified as SR-IOV PF already exists");
-            return false;
-        }
-
-        if (!pfs) {
-            pfs = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
-        }
-
-        pf = g_hash_table_lookup(pfs, dev->sriov_pf);
-        if (!pf) {
-            pf = g_ptr_array_new();
-            g_hash_table_insert(pfs, g_strdup(dev->sriov_pf), pf);
-        }
-
-        g_ptr_array_add(pf, dev);
-    }
-
-    return true;
-}
-
-void pcie_sriov_unregister_device(PCIDevice *dev)
-{
-    if (dev->sriov_pf && pfs) {
-        GPtrArray *pf = g_hash_table_lookup(pfs, dev->sriov_pf);
-
-        if (pf) {
-            g_ptr_array_remove_fast(pf, dev);
-
-            if (!pf->len) {
-                g_hash_table_remove(pfs, dev->sriov_pf);
-                g_ptr_array_free(pf, FALSE);
-            }
-        }
+    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
 }
 
@@ -490,7 +316,7 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize)
 
 uint16_t pcie_sriov_vf_number(PCIDevice *dev)
 {
-    assert(dev->exp.sriov_vf.pf);
+    assert(pci_is_vf(dev));
     return dev->exp.sriov_vf.vf_number;
 }
 
-- 
MST


