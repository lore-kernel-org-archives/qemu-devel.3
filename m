Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A1ACAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216D-0008CM-TM; Fri, 26 Sep 2025 01:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216B-0008Bk-IZ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v215z-0000jE-MN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYzizeLc0en2xd+KmRgVyE0W8r6aBUcxApESnjU8U78=;
 b=KpNjSwkIbxNCWZ4mlJufC4mQhwSU/0CBGbMIsE1RottDeEdUD+m8Jwa2Vi58lkz/b+zmYY
 UEidXJeAu5+/x66KIpXfPiIB8VAxLYunhlEaoTN9cC6nB4MMBDMP+o2Jy7I2N5mTaF5LXY
 WQD+b3hXMBywpkf6cxlKH5nhCrNL87M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-eOUtebgmN1iIwl4rDIc2xA-1; Fri,
 26 Sep 2025 01:34:09 -0400
X-MC-Unique: eOUtebgmN1iIwl4rDIc2xA-1
X-Mimecast-MFC-AGG-ID: eOUtebgmN1iIwl4rDIc2xA_1758864849
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDAEC1800365; Fri, 26 Sep 2025 05:34:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D74101800579; Fri, 26 Sep 2025 05:34:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/29] include/hw/vfio/vfio-container.h: rename VFIOContainer
 to VFIOLegacyContainer
Date: Fri, 26 Sep 2025 07:33:31 +0200
Message-ID: <20250926053358.308198-3-clg@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The VFIOContainer struct represents the legacy VFIO container even though the
name suggests it may be the common superclass of all VFIO containers. Rename it
to VFIOLegacyContainer to make this clearer, which is also a better match for
its VFIO_IOMMU_LEGACY QOM type name.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-2-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  8 +++---
 include/hw/vfio/vfio-cpr.h       |  9 ++++---
 hw/ppc/spapr_pci_vfio.c          | 10 ++++----
 hw/vfio/container.c              | 42 +++++++++++++++++---------------
 hw/vfio/cpr-legacy.c             | 27 +++++++++++---------
 hw/vfio/spapr.c                  | 18 +++++++-------
 6 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 240f56699336fb6fb3a925fe7a4d83a218a26eb2..712a6914004aeb2eb83927e8c91377eb2dde33f5 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -12,20 +12,20 @@
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-cpr.h"
 
-typedef struct VFIOContainer VFIOContainer;
+typedef struct VFIOLegacyContainer VFIOLegacyContainer;
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOGroup {
     int fd;
     int groupid;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
-struct VFIOContainer {
+struct VFIOLegacyContainer {
     VFIOContainerBase parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -34,6 +34,6 @@ struct VFIOContainer {
     VFIOContainerCPR cpr;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
 
 #endif /* HW_VFIO_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d37daffbc5b3d2bb65b60967c227df54d24437f7..04e987258719ef4cf0b6356d04787aa66ef012b4 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -12,7 +12,7 @@
 #include "migration/misc.h"
 #include "system/memory.h"
 
-struct VFIOContainer;
+struct VFIOLegacyContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 struct VFIODevice;
@@ -42,9 +42,10 @@ typedef struct VFIOPCICPR {
     NotifierWithReturn transfer_notifier;
 } VFIOPCICPR;
 
-bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+bool vfio_legacy_cpr_register_container(struct VFIOLegacyContainer *container,
                                         Error **errp);
-void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+void vfio_legacy_cpr_unregister_container(
+    struct VFIOLegacyContainer *container);
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -61,7 +62,7 @@ void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
-bool vfio_cpr_container_match(struct VFIOContainer *container,
+bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
 
 void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 7e1c71ef59d5c4d4449769b726c8c0053e607097..faa3ab3fe1ba86be262c233e8702c492978bc87c 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -32,7 +32,7 @@
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
 #ifdef CONFIG_VFIO_PCI
-static bool vfio_eeh_container_ok(VFIOContainer *container)
+static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
 {
     /*
      * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
@@ -60,7 +60,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
     return true;
 }
 
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 {
     struct vfio_eeh_pe_op pe_op = {
         .argsz = sizeof(pe_op),
@@ -83,7 +83,7 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
     return ret;
 }
 
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_address_space_get(as);
     VFIOContainerBase *bcontainer = NULL;
@@ -111,14 +111,14 @@ out:
 
 static bool vfio_eeh_as_ok(AddressSpace *as)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     return (container != NULL) && vfio_eeh_container_ok(container);
 }
 
 static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     if (!container) {
         return -ENODEV;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89cf57dc06e9bb2222f02e7803482c56..bdf415b3d639d62abfaca19987b4d90a0fe636dc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -44,7 +44,8 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
-static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
+static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
+                                          bool state)
 {
     switch (container->iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
@@ -67,7 +68,7 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
+static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
@@ -124,7 +125,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -212,7 +213,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -244,7 +245,7 @@ static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
                                     bool start, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -269,7 +270,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -413,12 +414,12 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
     return true;
 }
 
-static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
+static VFIOLegacyContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
 
     iommu_type = vfio_get_iommu_type(fd, errp);
     if (iommu_type < 0) {
@@ -442,7 +443,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     return container;
 }
 
-static int vfio_get_iommu_info(VFIOContainer *container,
+static int vfio_get_iommu_info(VFIOLegacyContainer *container,
                                struct vfio_iommu_type1_info **info)
 {
 
@@ -486,7 +487,7 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
     return NULL;
 }
 
-static void vfio_get_iommu_info_migration(VFIOContainer *container,
+static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
                                           struct vfio_iommu_type1_info *info)
 {
     struct vfio_info_cap_header *hdr;
@@ -514,7 +515,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 
 static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
     int ret;
 
@@ -540,8 +541,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_container_attach_discard_disable(VFIOContainer *container,
-                                            VFIOGroup *group, Error **errp)
+static bool vfio_container_attach_discard_disable(
+    VFIOLegacyContainer *container, VFIOGroup *group, Error **errp)
 {
     int ret;
 
@@ -587,8 +588,8 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
-static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
-                                     Error **errp)
+static bool vfio_container_group_add(VFIOLegacyContainer *container,
+                                     VFIOGroup *group, Error **errp)
 {
     if (!vfio_container_attach_discard_disable(container, group, errp)) {
         return false;
@@ -604,7 +605,8 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     return true;
 }
 
-static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+static void vfio_container_group_del(VFIOLegacyContainer *container,
+                                     VFIOGroup *group)
 {
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -616,7 +618,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     VFIOContainerBase *bcontainer;
     int ret, fd = -1;
     VFIOAddressSpace *space;
@@ -729,7 +731,7 @@ fail:
 
 static void vfio_container_disconnect(VFIOGroup *group)
 {
-    VFIOContainer *container = group->container;
+    VFIOLegacyContainer *container = group->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
@@ -1243,7 +1245,7 @@ hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 
 static void vfio_iommu_legacy_instance_init(Object *obj)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(obj);
 
     QLIST_INIT(&container->group_list);
 }
@@ -1263,7 +1265,7 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .instance_init = vfio_iommu_legacy_instance_init,
-        .instance_size = sizeof(VFIOContainer),
+        .instance_size = sizeof(VFIOLegacyContainer),
         .class_init = vfio_iommu_legacy_class_init,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 8f437194fae035b37de3f7c3f88e332c4ef88302..12bf920a7de73abb8f8bde106e7f08d57b9d6c63 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -17,7 +17,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
-static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
+                                     Error **errp)
 {
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
@@ -41,7 +42,7 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
 
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
@@ -63,12 +64,13 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
 static void vfio_region_remap(MemoryListener *listener,
                               MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            cpr.remap_listener);
+    VFIOLegacyContainer *container = container_of(listener,
+                                                  VFIOLegacyContainer,
+                                                  cpr.remap_listener);
     vfio_container_region_add(VFIO_IOMMU(container), section, true);
 }
 
-static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
+static bool vfio_cpr_supported(VFIOLegacyContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
         error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
@@ -85,7 +87,7 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 
 static int vfio_container_pre_save(void *opaque)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     Error *local_err = NULL;
 
     if (!vfio_dma_unmap_vaddr_all(container, &local_err)) {
@@ -97,7 +99,7 @@ static int vfio_container_pre_save(void *opaque)
 
 static int vfio_container_post_load(void *opaque, int version_id)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
@@ -133,8 +135,8 @@ static const VMStateDescription vfio_container_vmstate = {
 static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                   MigrationEvent *e, Error **errp)
 {
-    VFIOContainer *container =
-        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOLegacyContainer *container =
+        container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
@@ -165,7 +167,8 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
+bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
+                                        Error **errp)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
@@ -189,7 +192,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
     return true;
 }
 
-void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
@@ -263,7 +266,7 @@ static bool same_device(int fd1, int fd2)
     return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
 }
 
-bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
                               int fd)
 {
     if (container->fd == fd) {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c41e4588d6f2f0532f80720c1a32079d1ccfdef4..b8bade90d7a0f9ef3a72abaddb372418e88024b9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -31,7 +31,7 @@ typedef struct VFIOHostDMAWindow {
 } VFIOHostDMAWindow;
 
 typedef struct VFIOSpaprContainer {
-    VFIOContainer container;
+    VFIOLegacyContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     unsigned int levels;
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -218,7 +218,7 @@ static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
     return hostwin_found ? hostwin : NULL;
 }
 
-static int vfio_spapr_remove_window(VFIOContainer *container,
+static int vfio_spapr_remove_window(VFIOLegacyContainer *container,
                                     hwaddr offset_within_address_space)
 {
     struct vfio_iommu_spapr_tce_remove remove = {
@@ -239,7 +239,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
     return 0;
 }
 
-static bool vfio_spapr_create_window(VFIOContainer *container,
+static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
                                     MemoryRegionSection *section,
                                     hwaddr *pgsize, Error **errp)
 {
@@ -352,7 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
@@ -442,7 +442,7 @@ static void
 vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
 
@@ -463,7 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
 static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin, *next;
@@ -481,7 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                                        Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
-- 
2.51.0


