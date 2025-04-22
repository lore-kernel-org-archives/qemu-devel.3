Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GCg-0008UY-Ih; Tue, 22 Apr 2025 12:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G73-0001E3-8A
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G70-0005D5-E9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faPA/QEudj34UX2myMEBMLHFAw3++Y5+cIQQ+04ZwhE=;
 b=RirmQh9e+4g9tGuhtA7S/v+h+0HS34j7278BA695Mgsd230AXuztUQskCCM5mno7h64Hvy
 NnvsOPn6SjjMgevPyLKaYkyyIPgytwNH7BftGXB4xEOt/97TaC8c7LY37yOgsox0JScGyQ
 /WshafndHxPv0lcy2PCfN1oaK6lbY3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-0RTUD2B0PAO2wLGf30gVvw-1; Tue,
 22 Apr 2025 12:04:40 -0400
X-MC-Unique: 0RTUD2B0PAO2wLGf30gVvw-1
X-Mimecast-MFC-AGG-ID: 0RTUD2B0PAO2wLGf30gVvw_1745337879
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193EE1800877; Tue, 22 Apr 2025 16:04:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 745FE18001DD; Tue, 22 Apr 2025 16:04:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 37/37] vfio: Rename VFIOContainer related services
Date: Tue, 22 Apr 2025 18:02:24 +0200
Message-ID: <20250422160224.199714-38-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-30-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-38-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c  | 52 ++++++++++++++++++++++----------------------
 hw/vfio/trace-events | 12 +++++-----
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 721d10b64bc0304e73870faf3dba74f79a6fd5ad..23a337347007752556b7088295bd783ec3a412fa 100644
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
 
@@ -625,7 +625,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     return true;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    vfio_kvm_device_del_group(group);
+    vfio_group_del_kvm_device(group);
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
@@ -649,7 +649,7 @@ put_space_exit:
     return false;
 }
 
-static void vfio_disconnect_container(VFIOGroup *group)
+static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -678,7 +678,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = bcontainer->space;
 
-        trace_vfio_disconnect_container(container->fd);
+        trace_vfio_container_disconnect(container->fd);
         vfio_cpr_unregister_container(bcontainer);
         close(container->fd);
         object_unref(container);
@@ -687,7 +687,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
 {
     ERRP_GUARD();
     VFIOGroup *group;
@@ -731,7 +731,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group->groupid = groupid;
     QLIST_INIT(&group->device_list);
 
-    if (!vfio_connect_container(group, as, errp)) {
+    if (!vfio_container_connect(group, as, errp)) {
         error_prepend(errp, "failed to setup container for group %d: ",
                       groupid);
         goto close_fd_exit;
@@ -750,7 +750,7 @@ free_group_exit:
     return NULL;
 }
 
-static void vfio_put_group(VFIOGroup *group)
+static void vfio_group_put(VFIOGroup *group)
 {
     if (!group || !QLIST_EMPTY(&group->device_list)) {
         return;
@@ -759,15 +759,15 @@ static void vfio_put_group(VFIOGroup *group)
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
@@ -819,25 +819,25 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
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
@@ -872,7 +872,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
                                       AddressSpace *as, Error **errp)
 {
-    int groupid = vfio_device_groupid(vbasedev, errp);
+    int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
@@ -887,7 +887,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    group = vfio_get_group(groupid, as, errp);
+    group = vfio_group_get(groupid, as, errp);
     if (!group) {
         return false;
     }
@@ -895,12 +895,12 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
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
 
@@ -920,8 +920,8 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
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
index 8843560576935232a68a31d43e00be520e0284be..e90ec9bff8d5fa51afde7b55fb736a8d51fef1b0 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -99,16 +99,18 @@ vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t si
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
-vfio_disconnect_container(int fd) "close container->fd=%d"
-vfio_put_group(int fd) "close group->fd=%d"
-vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
-vfio_put_base_device(int fd) "close vdev->fd=%d"
-vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container-base.c
 vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 
+# container.c
+vfio_container_disconnect(int fd) "close container->fd=%d"
+vfio_group_put(int fd) "close group->fd=%d"
+vfio_device_get(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
+vfio_device_put(int fd) "close vdev->fd=%d"
+vfio_legacy_dma_unmap_overflow_workaround(void) ""
+
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-- 
2.49.0


