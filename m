Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ECFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216F-0008Dk-AP; Fri, 26 Sep 2025 01:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216D-0008CU-ME
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2162-0000k0-Ru
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucMNux+x5QwwNBDMcT59VvC0cWSlTZSLadv146WZ2K8=;
 b=ebfD2hOONXFSv3ygoblP9G/jbV+KWsBBkYIX4P8MLzPgXWuXcnnuXXIC+XAVKy3eG675CM
 IpZF4FpBF8bNOGHfia97Qw8k102wJbEm0Fn76LOpYq3WM6FJgphso0egGgYlO21KHzhLOV
 Q/e6dgcko2EaYxzjV1jX7HmQEpR5qio=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-alCQ9DpLOkeNZAvvdwPcLw-1; Fri,
 26 Sep 2025 01:34:12 -0400
X-MC-Unique: alCQ9DpLOkeNZAvvdwPcLw-1
X-Mimecast-MFC-AGG-ID: alCQ9DpLOkeNZAvvdwPcLw_1758864851
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89EF01977309; Fri, 26 Sep 2025 05:34:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 748E11800579; Fri, 26 Sep 2025 05:34:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/29] include/hw/vfio/vfio-container-base.h: rename
 VFIOContainerBase to VFIOContainer
Date: Fri, 26 Sep 2025 07:33:32 +0200
Message-ID: <20250926053358.308198-4-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Now that the VFIOContainer struct name is available, rename VFIOContainerBase
to VFIOContainer to better indicate that it is the superclass of other
VFIOFooContainer structs.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-3-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.h              |  2 +-
 hw/vfio/vfio-iommufd.h                |  2 +-
 hw/vfio/vfio-listener.h               |  4 +-
 include/hw/vfio/vfio-container-base.h | 76 +++++++++++++--------------
 include/hw/vfio/vfio-container.h      |  2 +-
 include/hw/vfio/vfio-cpr.h            |  8 +--
 include/hw/vfio/vfio-device.h         |  4 +-
 hw/ppc/spapr_pci_vfio.c               |  2 +-
 hw/vfio-user/container.c              | 18 +++----
 hw/vfio/container-base.c              | 41 ++++++++-------
 hw/vfio/container.c                   | 22 ++++----
 hw/vfio/cpr-iommufd.c                 |  4 +-
 hw/vfio/cpr-legacy.c                  | 14 ++---
 hw/vfio/device.c                      |  2 +-
 hw/vfio/iommufd.c                     | 18 +++----
 hw/vfio/listener.c                    | 74 +++++++++++++-------------
 hw/vfio/spapr.c                       | 12 ++---
 17 files changed, 154 insertions(+), 151 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 96aa6785d9b394137f91b274a0d6a8a9e9aab672..241863ef976f5a437755358c3949dd02f7820726 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,7 +14,7 @@
 
 /* MMU container sub-class for vfio-user. */
 struct VFIOUserContainer {
-    VFIOContainerBase parent_obj;
+    VFIOContainer parent_obj;
 
     VFIOUserProxy *proxy;
 };
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 07ea0f43049645a5f3782048117fd9bf22083053..6c049d925763848b25b25cea632cf9d1874f83e9 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -23,7 +23,7 @@ typedef struct VFIOIOASHwpt {
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOMMUFDContainer {
-    VFIOContainerBase bcontainer;
+    VFIOContainer bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
index eb69ddd374fa20683007cfc4e9a7bf6fe707f27d..a90674ca96e8cb55fd445b73322c006bbf6941f3 100644
--- a/hw/vfio/vfio-listener.h
+++ b/hw/vfio/vfio-listener.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_LISTENER_H
 #define HW_VFIO_VFIO_LISTENER_H
 
-bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_listener_unregister(VFIOContainerBase *bcontainer);
+bool vfio_listener_register(VFIOContainer *bcontainer, Error **errp);
+void vfio_listener_unregister(VFIOContainer *bcontainer);
 
 #endif /* HW_VFIO_VFIO_LISTENER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index acbd48a18a3a35ba6c5484d6d0fb12c23a983f77..b580f4a02df92276ef82c953eaf6942e1bf31413 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -26,14 +26,14 @@ typedef struct {
 
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
-    QLIST_HEAD(, VFIOContainerBase) containers;
+    QLIST_HEAD(, VFIOContainer) containers;
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
 
 /*
  * This is the base object for vfio container backends
  */
-struct VFIOContainerBase {
+struct VFIOContainer {
     Object parent_obj;
 
     VFIOAddressSpace *space;
@@ -48,17 +48,17 @@ struct VFIOContainerBase {
     bool dirty_pages_started; /* Protected by BQL */
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_ENTRY(VFIOContainerBase) next;
+    QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
 };
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
-OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
+OBJECT_DECLARE_TYPE(VFIOContainer, VFIOIOMMUClass, VFIO_IOMMU)
 
 typedef struct VFIOGuestIOMMU {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     IOMMUMemoryRegion *iommu_mr;
     hwaddr iommu_offset;
     IOMMUNotifier n;
@@ -66,7 +66,7 @@ typedef struct VFIOGuestIOMMU {
 } VFIOGuestIOMMU;
 
 typedef struct VFIORamDiscardListener {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     MemoryRegion *mr;
     hwaddr offset_within_address_space;
     hwaddr size;
@@ -78,32 +78,32 @@ typedef struct VFIORamDiscardListener {
 VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
 void vfio_address_space_put(VFIOAddressSpace *space);
 void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer);
+                               VFIOContainer *bcontainer);
 
-int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr);
-int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
-bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
-void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section);
-int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
                                            bool start, Error **errp);
 bool vfio_container_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer);
+    const VFIOContainer *bcontainer);
 bool vfio_container_devices_dirty_tracking_is_supported(
-    const VFIOContainerBase *bcontainer);
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+    const VFIOContainer *bcontainer);
+int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
 
-GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
+GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
 static inline uint64_t
-vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
+vfio_container_get_page_size_mask(const VFIOContainer *bcontainer)
 {
     assert(bcontainer);
     return bcontainer->pgsizes;
@@ -123,12 +123,12 @@ struct VFIOIOMMUClass {
      * Perform basic setup of the container, including configuring IOMMU
      * capabilities, IOVA ranges, supported page sizes, etc.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns true to indicate success and false for error.
      */
-    bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    bool (*setup)(VFIOContainer *bcontainer, Error **errp);
 
     /**
      * @listener_begin
@@ -136,9 +136,9 @@ struct VFIOIOMMUClass {
      * Called at the beginning of an address space update transaction.
      * See #MemoryListener.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      */
-    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_begin)(VFIOContainer *bcontainer);
 
     /**
      * @listener_commit
@@ -146,9 +146,9 @@ struct VFIOIOMMUClass {
      * Called at the end of an address space update transaction,
      * See #MemoryListener.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      */
-    void (*listener_commit)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainer *bcontainer);
 
     /**
      * @dma_map
@@ -156,7 +156,7 @@ struct VFIOIOMMUClass {
      * Map an address range into the container. Note that the memory region is
      * referenced within an RCU read lock region across this call.
      *
-     * @bcontainer: #VFIOContainerBase to use
+     * @bcontainer: #VFIOContainer to use
      * @iova: start address to map
      * @size: size of the range to map
      * @vaddr: process virtual address of mapping
@@ -165,7 +165,7 @@ struct VFIOIOMMUClass {
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
-    int (*dma_map)(const VFIOContainerBase *bcontainer,
+    int (*dma_map)(const VFIOContainer *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
     /**
@@ -173,14 +173,14 @@ struct VFIOIOMMUClass {
      *
      * Map a file range for the container.
      *
-     * @bcontainer: #VFIOContainerBase to use for map
+     * @bcontainer: #VFIOContainer to use for map
      * @iova: start address to map
      * @size: size of the range to map
      * @fd: descriptor of the file to map
      * @start: starting file offset of the range to map
      * @readonly: map read only if true
      */
-    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+    int (*dma_map_file)(const VFIOContainer *bcontainer,
                         hwaddr iova, ram_addr_t size,
                         int fd, unsigned long start, bool readonly);
     /**
@@ -188,7 +188,7 @@ struct VFIOIOMMUClass {
      *
      * Unmap an address range from the container.
      *
-     * @bcontainer: #VFIOContainerBase to use for unmap
+     * @bcontainer: #VFIOContainer to use for unmap
      * @iova: start address to unmap
      * @size: size of the range to unmap
      * @iotlb: The IOMMU TLB mapping entry (or NULL)
@@ -196,7 +196,7 @@ struct VFIOIOMMUClass {
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
-    int (*dma_unmap)(const VFIOContainerBase *bcontainer,
+    int (*dma_unmap)(const VFIOContainer *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
 
@@ -234,21 +234,21 @@ struct VFIOIOMMUClass {
      *
      * Start or stop dirty pages tracking on VFIO container
      *
-     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
+     * @bcontainer: #VFIOContainer on which to de/activate dirty
      *              page tracking
      * @start: indicates whether to start or stop dirty pages tracking
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error.
      */
-    int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
+    int (*set_dirty_page_tracking)(const VFIOContainer *bcontainer,
                                    bool start, Error **errp);
     /**
      * @query_dirty_bitmap
      *
      * Get bitmap of dirty pages from container
      *
-     * @bcontainer: #VFIOContainerBase from which to get dirty pages
+     * @bcontainer: #VFIOContainer from which to get dirty pages
      * @vbmap: #VFIOBitmap internal bitmap structure
      * @iova: iova base address
      * @size: size of iova range
@@ -256,24 +256,24 @@ struct VFIOIOMMUClass {
      *
      * Returns zero to indicate success and negative for error.
      */
-    int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
+    int (*query_dirty_bitmap)(const VFIOContainer *bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
     /* SPAPR specific */
-    bool (*add_window)(VFIOContainerBase *bcontainer,
+    bool (*add_window)(VFIOContainer *bcontainer,
                        MemoryRegionSection *section,
                        Error **errp);
-    void (*del_window)(VFIOContainerBase *bcontainer,
+    void (*del_window)(VFIOContainer *bcontainer,
                        MemoryRegionSection *section);
-    void (*release)(VFIOContainerBase *bcontainer);
+    void (*release)(VFIOContainer *bcontainer);
 };
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+    VFIOContainer *bcontainer, MemoryRegionSection *section);
 
-void vfio_container_region_add(VFIOContainerBase *bcontainer,
+void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
 
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 712a6914004aeb2eb83927e8c91377eb2dde33f5..a84dfb0dee79d8d9e310cbcd84166c269a877b4a 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -26,7 +26,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 struct VFIOLegacyContainer {
-    VFIOContainerBase parent_obj;
+    VFIOContainer parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 04e987258719ef4cf0b6356d04787aa66ef012b4..26ee0c4fe15ac74b5123f57c20c94486171d4779 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -13,14 +13,14 @@
 #include "system/memory.h"
 
 struct VFIOLegacyContainer;
-struct VFIOContainerBase;
+struct VFIOContainer;
 struct VFIOGroup;
 struct VFIODevice;
 struct VFIOPCIDevice;
 struct VFIOIOMMUFDContainer;
 struct IOMMUFDBackend;
 
-typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
+typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
                           hwaddr iova, ram_addr_t size, void *vaddr,
                           bool readonly, MemoryRegion *mr);
 
@@ -65,11 +65,11 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
 
-void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
 bool vfio_cpr_ram_discard_register_listener(
-    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+    struct VFIOContainer *bcontainer, MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                              int nr, int fd);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index e7e6243e2dd7cf1be37d95414d6a511666f5cb39..67b9fcdd2c011234d250bcdd23fdcdfb259aba2f 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -54,7 +54,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) container_next;
     QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
@@ -252,7 +252,7 @@ struct VFIODeviceIOOps {
                         void *data, bool post);
 };
 
-void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
                          struct vfio_device_info *info);
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index faa3ab3fe1ba86be262c233e8702c492978bc87c..c8175dd8a89b16e04f464e535306abe83a4ca74f 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -86,7 +86,7 @@ static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_address_space_get(as);
-    VFIOContainerBase *bcontainer = NULL;
+    VFIOContainer *bcontainer = NULL;
 
     if (QLIST_EMPTY(&space->containers)) {
         /* No containers to act on */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 3cdbd44c1aac2153dd099139a3956a3a0bb9b48e..411eb7b28b72a25cd68d494ffc4a8f9b55b4862d 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -22,14 +22,14 @@
  * will fire during memory update transactions.  These depend on BQL being held,
  * so do any resulting map/demap ops async while keeping BQL.
  */
-static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+static void vfio_user_listener_begin(VFIOContainer *bcontainer)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     container->proxy->async_ops = true;
 }
 
-static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+static void vfio_user_listener_commit(VFIOContainer *bcontainer)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
@@ -38,7 +38,7 @@ static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
     vfio_user_wait_reqs(container->proxy);
 }
 
-static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -80,7 +80,7 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int vfio_user_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
@@ -154,14 +154,14 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 }
 
 static int
-vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+vfio_user_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                     bool start, Error **errp)
 {
     error_setg_errno(errp, ENOTSUP, "Not supported");
     return -ENOTSUP;
 }
 
-static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_user_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                          VFIOBitmap *vbmap, hwaddr iova,
                                          hwaddr size, Error **errp)
 {
@@ -169,7 +169,7 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     return -ENOTSUP;
 }
 
-static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_user_setup(VFIOContainer *bcontainer, Error **errp)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
@@ -202,7 +202,7 @@ static VFIOUserContainer *
 vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
                             Error **errp)
 {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
@@ -260,7 +260,7 @@ put_space_exit:
 
 static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     VFIOAddressSpace *space = bcontainer->space;
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 56304978e1e8ec456e0eb5f13e8bddc091e76208..98c5198e5043b0ecb679060116bbac240ac76747 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -67,13 +67,13 @@ void vfio_address_space_put(VFIOAddressSpace *space)
 }
 
 void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer)
+                               VFIOContainer *bcontainer)
 {
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
     bcontainer->space = space;
 }
 
-int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
@@ -92,7 +92,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
 
-int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -102,7 +102,7 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
 }
 
-bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp)
 {
@@ -115,7 +115,7 @@ bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
     return vioc->add_window(bcontainer, section, errp);
 }
 
-void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -127,7 +127,7 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
     return vioc->del_window(bcontainer, section);
 }
 
-int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -151,7 +151,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 }
 
 static bool vfio_container_devices_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -165,14 +165,14 @@ static bool vfio_container_devices_dirty_tracking_is_started(
 }
 
 bool vfio_container_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     return vfio_container_devices_dirty_tracking_is_started(bcontainer) ||
            bcontainer->dirty_pages_started;
 }
 
 bool vfio_container_devices_dirty_tracking_is_supported(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -210,8 +210,9 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
-static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+static int vfio_container_iommu_query_dirty_bitmap(
+    const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
+    hwaddr size, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
@@ -220,8 +221,9 @@ static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcon
                                                errp);
 }
 
-static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+static int vfio_container_devices_query_dirty_bitmap(
+    const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
+    hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -242,8 +244,9 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
     return 0;
 }
 
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp)
+int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
+                                      uint64_t iova, uint64_t size,
+                                      ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -297,7 +300,7 @@ static gpointer copy_iova_range(gconstpointer src, gpointer data)
      return dest;
 }
 
-GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
+GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer)
 {
     assert(bcontainer);
     return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, NULL);
@@ -305,7 +308,7 @@ GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
 
 static void vfio_container_instance_finalize(Object *obj)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
+    VFIOContainer *bcontainer = VFIO_IOMMU(obj);
     VFIOGuestIOMMU *giommu, *tmp;
 
     QLIST_SAFE_REMOVE(bcontainer, next);
@@ -322,7 +325,7 @@ static void vfio_container_instance_finalize(Object *obj)
 
 static void vfio_container_instance_init(Object *obj)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
+    VFIOContainer *bcontainer = VFIO_IOMMU(obj);
 
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
@@ -338,7 +341,7 @@ static const TypeInfo types[] = {
         .parent = TYPE_OBJECT,
         .instance_init = vfio_container_instance_init,
         .instance_finalize = vfio_container_instance_finalize,
-        .instance_size = sizeof(VFIOContainerBase),
+        .instance_size = sizeof(VFIOContainer),
         .class_size = sizeof(VFIOIOMMUClass),
         .abstract = true,
     },
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bdf415b3d639d62abfaca19987b4d90a0fe636dc..dc8425efb1f68eb80b17ec2ba4baa8f7cb258d36 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -72,7 +72,7 @@ static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    const VFIOContainer *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -121,7 +121,7 @@ unmap_exit:
     return ret;
 }
 
-static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
@@ -184,7 +184,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -209,7 +209,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
@@ -242,7 +242,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 }
 
 static int
-vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+vfio_legacy_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                     bool start, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -267,7 +267,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -307,7 +307,7 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
-                                     VFIOContainerBase *bcontainer)
+                                     VFIOContainer *bcontainer)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_iova_range *cap;
@@ -492,7 +492,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -513,7 +513,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
     }
 }
 
-static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_legacy_setup(VFIOContainer *bcontainer, Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
@@ -619,7 +619,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
     VFIOLegacyContainer *container;
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     int ret, fd = -1;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc = NULL;
@@ -732,7 +732,7 @@ fail:
 static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOLegacyContainer *container = group->container;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     QLIST_REMOVE(group, container_next);
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 148a06d552ff3d8e8420366c6b71437e81a1f877..6aaf6f77a25a3d90387ca60599955f54dcc308de 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -176,7 +176,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
@@ -189,7 +189,7 @@ bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
 
 void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 12bf920a7de73abb8f8bde106e7f08d57b9d6c63..bd3f6fc3d3936e7798df6a3c9f3b893e428ec771 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -38,7 +38,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
  * Set the new @vaddr for any mappings registered during cpr load.
  * The incoming state is cleared thereafter.
  */
-static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
@@ -100,7 +100,7 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOLegacyContainer *container = opaque;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
@@ -137,7 +137,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 {
     VFIOLegacyContainer *container =
         container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
         return 0;
@@ -170,7 +170,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
                                         Error **errp)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
@@ -194,7 +194,7 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
 
 void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
@@ -210,7 +210,7 @@ void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
  * The giommu already exists.  Find it and replay it, which calls
  * vfio_legacy_cpr_dma_map further down the stack.
  */
-void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
+void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
                            MemoryRegionSection *section)
 {
     VFIOGuestIOMMU *giommu = NULL;
@@ -235,7 +235,7 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
  * The ram discard listener already exists.  Call its populate function
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
-bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+bool vfio_cpr_ram_discard_register_listener(VFIOContainer *bcontainer,
                                             MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl =
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 08f12ac31f44fdebc9fc1f23f716c52f391ed53e..963cefc053d0959a173c7789801916dcacce552b 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -460,7 +460,7 @@ void vfio_device_detach(VFIODevice *vbasedev)
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
 
-void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
                          struct vfio_device_info *info)
 {
     int i;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f754a22f47fda6b6a1a86005341ec0d7f..7f2243d9d197d9aced99d8d8a9065e7e9d888e97 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,7 @@
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
-static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
@@ -46,7 +46,7 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
-static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
+static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  int fd, unsigned long start, bool readonly)
 {
@@ -58,7 +58,7 @@ static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
                                         iova, size, fd, start, readonly);
 }
 
-static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
+static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -159,7 +159,7 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
     return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 }
 
-static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+static int iommufd_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
     const VFIOIOMMUFDContainer *container =
@@ -190,7 +190,7 @@ err:
     return -EINVAL;
 }
 
-static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
                                       hwaddr size, Error **errp)
 {
@@ -464,7 +464,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
@@ -486,7 +486,7 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
 static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                              uint32_t ioas_id, Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int sz, fd = container->be->fd;
@@ -528,7 +528,7 @@ error:
 static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
                                 AddressSpace *as, Error **errp)
 {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIOIOMMUFDContainer *container;
     VFIOAddressSpace *space;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
@@ -687,7 +687,7 @@ err_connect_bind:
 
 static void iommufd_cdev_detach(VFIODevice *vbasedev)
 {
-    VFIOContainerBase *bcontainer = vbasedev->bcontainer;
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
     VFIOAddressSpace *space = bcontainer->space;
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e0938331659833bdca98e700ac42651a90fb1571..3b6f17f0c3aa7ef08091f8cc1c3230eff97b5cd7 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -52,7 +52,7 @@
  */
 
 
-static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
+static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -125,7 +125,7 @@ static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOContainerBase *bcontainer = giommu->bcontainer;
+    VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     MemoryRegion *mr;
     hwaddr xlat;
@@ -202,7 +202,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
+    VFIOContainer *bcontainer = vrdl->bcontainer;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
@@ -220,7 +220,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
+    VFIOContainer *bcontainer = vrdl->bcontainer;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -250,7 +250,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
                                                MemoryRegionSection *section,
                                                Error **errp)
 {
@@ -328,7 +328,7 @@ static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
     return true;
 }
 
-static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
+static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -396,7 +396,7 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
     return true;
 }
 
-static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
+static bool vfio_get_section_iova_range(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section,
                                         hwaddr *out_iova, hwaddr *out_end,
                                         Int128 *out_llend)
@@ -423,9 +423,9 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
 
 static void vfio_listener_begin(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
-    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
+    void (*listener_begin)(VFIOContainer *bcontainer);
 
     listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
 
@@ -436,9 +436,9 @@ static void vfio_listener_begin(MemoryListener *listener)
 
 static void vfio_listener_commit(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
-    void (*listener_commit)(VFIOContainerBase *bcontainer);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
+    void (*listener_commit)(VFIOContainer *bcontainer);
 
     listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_commit;
 
@@ -460,7 +460,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 }
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainerBase *bcontainer, MemoryRegionSection *section)
+    VFIOContainer *bcontainer, MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = NULL;
 
@@ -482,12 +482,12 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     vfio_container_region_add(bcontainer, section, false);
 }
 
-void vfio_container_region_add(VFIOContainerBase *bcontainer,
+void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section,
                                bool cpr_remap)
 {
@@ -656,8 +656,8 @@ fail:
 static void vfio_listener_region_del(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -744,13 +744,13 @@ typedef struct VFIODirtyRanges {
 } VFIODirtyRanges;
 
 typedef struct VFIODirtyRangesListener {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIODirtyRanges ranges;
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
 static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
-                                     VFIOContainerBase *bcontainer)
+                                     VFIOContainer *bcontainer)
 {
     VFIOPCIDevice *pcidev;
     VFIODevice *vbasedev;
@@ -835,7 +835,7 @@ static const MemoryListener vfio_dirty_tracking_listener = {
     .region_add = vfio_dirty_tracking_update,
 };
 
-static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
+static void vfio_dirty_tracking_init(VFIOContainer *bcontainer,
                                      VFIODirtyRanges *ranges)
 {
     VFIODirtyRangesListener dirty;
@@ -860,7 +860,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
+static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
@@ -889,7 +889,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
 }
 
 static struct vfio_device_feature *
-vfio_device_feature_dma_logging_start_create(VFIOContainerBase *bcontainer,
+vfio_device_feature_dma_logging_start_create(VFIOContainer *bcontainer,
                                              VFIODirtyRanges *tracking)
 {
     struct vfio_device_feature *feature;
@@ -962,7 +962,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
                                           Error **errp)
 {
     struct vfio_device_feature *feature;
@@ -1006,8 +1006,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
                                            Error **errp)
 {
     ERRP_GUARD();
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     bool ret;
 
     if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
@@ -1024,8 +1024,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     Error *local_err = NULL;
     int ret = 0;
 
@@ -1057,7 +1057,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     vfio_giommu_dirty_notifier *gdn = container_of(n,
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
-    VFIOContainerBase *bcontainer = giommu->bcontainer;
+    VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     Error *local_err = NULL;
@@ -1127,7 +1127,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
 }
 
 static int
-vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
+vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *bcontainer,
                                             MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -1143,7 +1143,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                                 &vrdl);
 }
 
-static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
+static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOGuestIOMMU *giommu;
@@ -1180,7 +1180,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
     return 0;
 }
 
-static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
+static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
@@ -1209,8 +1209,8 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
 static void vfio_listener_log_sync(MemoryListener *listener,
         MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     int ret;
     Error *local_err = NULL;
 
@@ -1241,7 +1241,7 @@ static const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
-bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
+bool vfio_listener_register(VFIOContainer *bcontainer, Error **errp)
 {
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
@@ -1255,7 +1255,7 @@ bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-void vfio_listener_unregister(VFIOContainerBase *bcontainer)
+void vfio_listener_unregister(VFIOContainer *bcontainer)
 {
     memory_listener_unregister(&bcontainer->listener);
 }
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index b8bade90d7a0f9ef3a72abaddb372418e88024b9..6d462aa13caecb3e91de503ca4bb2bc60c9d262a 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
     VFIOLegacyContainer *container = &scontainer->container;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
                                     hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -348,7 +348,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
 }
 
 static bool
-vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
+vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
@@ -439,7 +439,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
 }
 
 static void
-vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
+vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -461,7 +461,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
     }
 }
 
-static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
+static void vfio_spapr_container_release(VFIOContainer *bcontainer)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
@@ -478,7 +478,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
     }
 }
 
-static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
+static bool vfio_spapr_container_setup(VFIOContainer *bcontainer,
                                        Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-- 
2.51.0


