Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD0EC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgV-0006lm-MP; Tue, 18 Mar 2025 05:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgQ-0006Nj-5D
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgN-0002W3-Ou
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIkkSO4llexb8oMvZzPo/G7JHHMzGISYO66rZcVs2ds=;
 b=iZTLaA204cbpiKUbO/m4fmnOrKEgkabRSXSMg999hkF25qWZv7s9pscAQxHTzhvjVI881W
 QeuUROYJy7GXjnBZu5OrSM+GskNnJGnxr6bTTNM/h+UHOZvT/nNaeByxzdmfr9RdMvPBPj
 dMEOQvASjvfTuuOODzRLke9xXy5kRXY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-9ef3OEiPNOu0eZjnc-YNhA-1; Tue,
 18 Mar 2025 05:56:19 -0400
X-MC-Unique: 9ef3OEiPNOu0eZjnc-YNhA-1
X-Mimecast-MFC-AGG-ID: 9ef3OEiPNOu0eZjnc-YNhA_1742291779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BCB918001F3; Tue, 18 Mar 2025 09:56:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D14481828A84; Tue, 18 Mar 2025 09:56:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 29/32] vfio: Rename VFIOContainer related services
Date: Tue, 18 Mar 2025 10:54:12 +0100
Message-ID: <20250318095415.670319-30-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rename these routines :

  vfio_put_group -> vfio_group_put
  vfio_get_group -> vfio_group_get
  vfio_kvm_device_del_group -> vfio_group_del_kvm_device
  vfio_kvm_device_add_group -> vfio_group_add_kvm_device
  vfio_get_device -> vfio_device_get
  vfio_put_base_device -> vfio_device_put
  vfio_device_groupid -> vfio_device_get_groupid
  vfio_connect_container -> vfio_container_connect
  vfio_disconnect_container -> vfio_container_disconnect

to better reflect the namespace they belong to.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c  | 52 ++++++++++++++++++++++----------------------
 hw/vfio/trace-events | 10 +++++----
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77e2934511a2917f6f7cf13f60c8f3ce4a493035..40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -306,7 +306,7 @@ static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
     return true;
 }
 
-static void vfio_kvm_device_add_group(VFIOGroup *group)
+static void vfio_group_add_kvm_device(VFIOGroup *group)
 {
     Error *err = NULL;
 
@@ -315,7 +315,7 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
     }
 }
 
-static void vfio_kvm_device_del_group(VFIOGroup *group)
+static void vfio_group_del_kvm_device(VFIOGroup *group)
 {
     Error *err = NULL;
 
@@ -511,7 +511,7 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
+static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
     VFIOContainer *container;
@@ -569,7 +569,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-            vfio_kvm_device_add_group(group);
+            vfio_group_add_kvm_device(group);
             return true;
         }
     }
@@ -609,7 +609,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto enable_discards_exit;
     }
 
-    vfio_kvm_device_add_group(group);
+    vfio_group_add_kvm_device(group);
 
     vfio_address_space_insert(space, bcontainer);
 
@@ -630,7 +630,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     return true;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    vfio_kvm_device_del_group(group);
+    vfio_group_del_kvm_device(group);
     memory_listener_unregister(&bcontainer->listener);
     if (vioc->release) {
         vioc->release(bcontainer);
@@ -654,7 +654,7 @@ put_space_exit:
     return false;
 }
 
-static void vfio_disconnect_container(VFIOGroup *group)
+static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -683,7 +683,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = bcontainer->space;
 
-        trace_vfio_disconnect_container(container->fd);
+        trace_vfio_container_disconnect(container->fd);
         vfio_cpr_unregister_container(bcontainer);
         close(container->fd);
         object_unref(container);
@@ -692,7 +692,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
 {
     ERRP_GUARD();
     VFIOGroup *group;
@@ -736,7 +736,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group->groupid = groupid;
     QLIST_INIT(&group->device_list);
 
-    if (!vfio_connect_container(group, as, errp)) {
+    if (!vfio_container_connect(group, as, errp)) {
         error_prepend(errp, "failed to setup container for group %d: ",
                       groupid);
         goto close_fd_exit;
@@ -755,7 +755,7 @@ free_group_exit:
     return NULL;
 }
 
-static void vfio_put_group(VFIOGroup *group)
+static void vfio_group_put(VFIOGroup *group)
 {
     if (!group || !QLIST_EMPTY(&group->device_list)) {
         return;
@@ -764,15 +764,15 @@ static void vfio_put_group(VFIOGroup *group)
     if (!group->ram_block_discard_allowed) {
         vfio_ram_block_discard_disable(group->container, false);
     }
-    vfio_kvm_device_del_group(group);
-    vfio_disconnect_container(group);
+    vfio_group_del_kvm_device(group);
+    vfio_container_disconnect(group);
     QLIST_REMOVE(group, next);
-    trace_vfio_put_group(group->fd);
+    trace_vfio_group_put(group->fd);
     close(group->fd);
     g_free(group);
 }
 
-static bool vfio_get_device(VFIOGroup *group, const char *name,
+static bool vfio_device_get(VFIOGroup *group, const char *name,
                             VFIODevice *vbasedev, Error **errp)
 {
     g_autofree struct vfio_device_info *info = NULL;
@@ -824,25 +824,25 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
 
-    trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
+    trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
     return true;
 }
 
-static void vfio_put_base_device(VFIODevice *vbasedev)
+static void vfio_device_put(VFIODevice *vbasedev)
 {
     if (!vbasedev->group) {
         return;
     }
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
-    trace_vfio_put_base_device(vbasedev->fd);
+    trace_vfio_device_put(vbasedev->fd);
     close(vbasedev->fd);
 }
 
-static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
+static int vfio_device_get_groupid(VFIODevice *vbasedev, Error **errp)
 {
     char *tmp, group_path[PATH_MAX];
     g_autofree char *group_name = NULL;
@@ -877,7 +877,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
                                       AddressSpace *as, Error **errp)
 {
-    int groupid = vfio_device_groupid(vbasedev, errp);
+    int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
@@ -892,7 +892,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    group = vfio_get_group(groupid, as, errp);
+    group = vfio_group_get(groupid, as, errp);
     if (!group) {
         return false;
     }
@@ -900,12 +900,12 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
-            vfio_put_group(group);
+            vfio_group_put(group);
             return false;
         }
     }
-    if (!vfio_get_device(group, name, vbasedev, errp)) {
-        vfio_put_group(group);
+    if (!vfio_device_get(group, name, vbasedev, errp)) {
+        vfio_group_put(group);
         return false;
     }
 
@@ -925,8 +925,8 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
-    vfio_put_base_device(vbasedev);
-    vfio_put_group(group);
+    vfio_device_put(vbasedev);
+    vfio_group_put(group);
 }
 
 static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 39d4947f94dc61e4cff06fe1a6181066e7fc4dc3..512f4913b72d9a1e8a04df24318a4947fa361e28 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -99,10 +99,6 @@ vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t si
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
-vfio_disconnect_container(int fd) "close container->fd=%d"
-vfio_put_group(int fd) "close group->fd=%d"
-vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
-vfio_put_base_device(int fd) "close vdev->fd=%d"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
@@ -194,6 +190,12 @@ iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int functi
 # container-base.c
 vfio_reset_handler(void) ""
 
+# container.c
+vfio_container_disconnect(int fd) "close container->fd=%d"
+vfio_group_put(int fd) "close group->fd=%d"
+vfio_device_get(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
+vfio_device_put(int fd) "close vdev->fd=%d"
+
 # device.c
 vfio_device_get_region_info_type(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_device_attach(const char *name, int group_id) " (%s) group %d"
-- 
2.48.1


