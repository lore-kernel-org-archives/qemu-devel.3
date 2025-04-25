Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B4C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ekj-0007SX-C2; Fri, 25 Apr 2025 04:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek7-0006Wf-DF
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek3-0003LD-Gl
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUwkpq/oOJqsHPwwOGUOK0QFXwLEV2fES2hOO8oECMA=;
 b=a7GxHpCYkOhOgnoMmWC5eaiDQW5YLo2E0Ak+mcAheneS5cgorQTBoozoCazSDpNb9o6SLP
 qkJ/LEqTDyH5LRlQUJZFj1mHmo2zx6vT644SvCWqlYqNVxud6WILeeNyrjw1tds/2D3j0W
 7+SD29RL9HCzNjKzNpEV/doIVKuw2Uc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-a5e8-8L5NpmDzktg5diqag-1; Fri,
 25 Apr 2025 04:49:00 -0400
X-MC-Unique: a5e8-8L5NpmDzktg5diqag-1
X-Mimecast-MFC-AGG-ID: a5e8-8L5NpmDzktg5diqag_1745570940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9DD619560B1; Fri, 25 Apr 2025 08:48:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B72D30001A2; Fri, 25 Apr 2025 08:48:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 40/50] vfio: Rename VFIODevice related services
Date: Fri, 25 Apr 2025 10:46:33 +0200
Message-ID: <20250425084644.102196-41-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

  vfio_disable_irqindex       -> vfio_device_irq_disable
  vfio_unmask_single_irqindex -> vfio_device_irq_unmask
  vfio_mask_single_irqindex   -> vfio_device_irq_mask
  vfio_set_irq_signaling      -> vfio_device_irq_set_signaling
  vfio_attach_device          -> vfio_device_attach
  vfio_detach_device          -> vfio_device_detach
  vfio_get_region_info        -> vfio_device_get_region_info
  vfio_get_dev_region_info    -> vfio_device_get_region_info_type
  vfio_has_region_cap         -> vfio_device_has_region_cap
  vfio_reset_handler          -> vfio_device_reset_hander

to better reflect the namespace they belong to.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-37-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 26 +++++++-------
 hw/vfio/ap.c                  | 12 +++----
 hw/vfio/ccw.c                 | 28 +++++++--------
 hw/vfio/container-base.c      |  6 ++--
 hw/vfio/container.c           |  6 ++--
 hw/vfio/device.c              | 36 +++++++++----------
 hw/vfio/display.c             |  8 ++---
 hw/vfio/igd.c                 | 10 +++---
 hw/vfio/pci.c                 | 68 +++++++++++++++++------------------
 hw/vfio/platform.c            | 14 ++++----
 hw/vfio/region.c              |  2 +-
 hw/vfio/trace-events          |  8 ++---
 12 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index cfbe254e31545818733c1b7f4f5607091fc4d871..696ed87f01038bf29df26046fa9b75051971ede3 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -115,29 +115,29 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
-void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
-void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
-void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
-bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                            int action, int fd, Error **errp);
+void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
+void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
+void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
+bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
+                                   int action, int fd, Error **errp);
 
-void vfio_reset_handler(void *opaque);
+void vfio_device_reset_handler(void *opaque);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
-bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
-void vfio_detach_device(VFIODevice *vbasedev);
+void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
-int vfio_get_region_info(VFIODevice *vbasedev, int index,
-                         struct vfio_region_info **info);
-int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
-                             uint32_t subtype, struct vfio_region_info **info);
-bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
+                                struct vfio_region_info **info);
+int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
+                                     uint32_t subtype, struct vfio_region_info **info);
+bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 9e2251437e639af64be4040bc82b34430b492640..be2e2927c24a6a9a029d18b00c0266abf5b61e98 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -117,8 +117,8 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
     fd = event_notifier_get_fd(notifier);
     qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
 
-    if (!vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                errp)) {
+    if (!vfio_device_irq_set_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                                       errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
     }
@@ -141,8 +141,8 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
         return;
     }
 
-    if (!vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_device_irq_set_signaling(&vapdev->vdev, irq, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
     }
 
@@ -162,7 +162,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!vfio_attach_device(vbasedev->name, vbasedev,
+    if (!vfio_device_attach(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
         goto error;
     }
@@ -187,7 +187,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
-    vfio_detach_device(&vapdev->vdev);
+    vfio_device_detach(&vapdev->vdev);
     g_free(vapdev->vdev.name);
 }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d0713ca4c76b31b3fe03b558c310f0455d40b97c..3a91efce81d981e66d8267a54465dcb484c96944 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -426,8 +426,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
     fd = event_notifier_get_fd(notifier);
     qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
 
-    if (!vfio_set_irq_signaling(vdev, irq, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+    if (!vfio_device_irq_set_signaling(vdev, irq, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(notifier);
     }
@@ -456,8 +456,8 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
         return;
     }
 
-    if (!vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_device_irq_set_signaling(&vcdev->vdev, irq, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
     }
 
@@ -488,7 +488,7 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         return false;
     }
 
-    ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
+    ret = vfio_device_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
     if (ret) {
         error_setg_errno(errp, -ret, "vfio: Error getting config info");
         return false;
@@ -505,8 +505,8 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
     g_free(info);
 
     /* check for the optional async command region */
-    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
-                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
+    ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
+                                           VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
     if (!ret) {
         vcdev->async_cmd_region_size = info->size;
         if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
@@ -518,8 +518,8 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         g_free(info);
     }
 
-    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
-                                   VFIO_REGION_SUBTYPE_CCW_SCHIB, &info);
+    ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
+                                           VFIO_REGION_SUBTYPE_CCW_SCHIB, &info);
     if (!ret) {
         vcdev->schib_region_size = info->size;
         if (sizeof(*vcdev->schib_region) != vcdev->schib_region_size) {
@@ -531,8 +531,8 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         g_free(info);
     }
 
-    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
-                                   VFIO_REGION_SUBTYPE_CCW_CRW, &info);
+    ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
+                                           VFIO_REGION_SUBTYPE_CCW_CRW, &info);
 
     if (!ret) {
         vcdev->crw_region_size = info->size;
@@ -583,7 +583,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_unrealize;
     }
 
-    if (!vfio_attach_device(cdev->mdevid, vbasedev,
+    if (!vfio_device_attach(cdev->mdevid, vbasedev,
                             &address_space_memory, errp)) {
         goto out_attach_dev_err;
     }
@@ -620,7 +620,7 @@ out_irq_notifier_err:
 out_io_notifier_err:
     vfio_ccw_put_region(vcdev);
 out_region_err:
-    vfio_detach_device(vbasedev);
+    vfio_device_detach(vbasedev);
 out_attach_dev_err:
     g_free(vbasedev->name);
 out_unrealize:
@@ -639,7 +639,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
-    vfio_detach_device(&vcdev->vdev);
+    vfio_device_detach(&vcdev->vdev);
     g_free(vcdev->vdev.name);
 
     if (cdc->unrealize) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index c037bafe2162d864c42e059d7630d579fde0d251..09340fd97a074c9a3b56c686e7a750530bed619f 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container-base.h"
-#include "hw/vfio/vfio-device.h" /* vfio_reset_handler */
+#include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
 #include "system/reset.h"
 #include "vfio-helpers.h"
 
@@ -44,7 +44,7 @@ VFIOAddressSpace *vfio_address_space_get(AddressSpace *as)
     QLIST_INIT(&space->containers);
 
     if (QLIST_EMPTY(&vfio_address_spaces)) {
-        qemu_register_reset(vfio_reset_handler, NULL);
+        qemu_register_reset(vfio_device_reset_handler, NULL);
     }
 
     QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
@@ -62,7 +62,7 @@ void vfio_address_space_put(VFIOAddressSpace *space)
     g_free(space);
 
     if (QLIST_EMPTY(&vfio_address_spaces)) {
-        qemu_unregister_reset(vfio_reset_handler, NULL);
+        qemu_unregister_reset(vfio_device_reset_handler, NULL);
     }
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ef1404607253cd5279c89af5d31add3c88b01aed..149ea26aff5960a40b50ff64762d52d01b11be5c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -865,7 +865,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 }
 
 /*
- * vfio_attach_device: attach a device to a security context
+ * vfio_device_attach: attach a device to a security context
  * @name and @vbasedev->name are likely to be different depending
  * on the type of the device, hence the need for passing @name
  */
@@ -881,7 +881,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    trace_vfio_attach_device(vbasedev->name, groupid);
+    trace_vfio_device_attach(vbasedev->name, groupid);
 
     if (!vfio_device_hiod_realize(vbasedev, errp)) {
         return false;
@@ -919,7 +919,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
-    trace_vfio_detach_device(vbasedev->name, group->groupid);
+    trace_vfio_device_detach(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 543750c3b13b53dbd6705d08ac8cead0ebe49ed7..4de6948cf472806ed639f629cc3d980f51021f2c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -51,11 +51,11 @@ VFIODeviceList vfio_device_list =
  * reset for the one in-use devices case, calling _multi() will do
  * nothing if a _one() would have been sufficient.
  */
-void vfio_reset_handler(void *opaque)
+void vfio_device_reset_handler(void *opaque)
 {
     VFIODevice *vbasedev;
 
-    trace_vfio_reset_handler();
+    trace_vfio_device_reset_handler();
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->dev->realized) {
             vbasedev->ops->vfio_compute_needs_reset(vbasedev);
@@ -72,7 +72,7 @@ void vfio_reset_handler(void *opaque)
 /*
  * Common VFIO interrupt disable
  */
-void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
+void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
         .argsz = sizeof(irq_set),
@@ -85,7 +85,7 @@ void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
     ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
 }
 
-void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
+void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
         .argsz = sizeof(irq_set),
@@ -98,7 +98,7 @@ void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
     ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
 }
 
-void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
+void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
         .argsz = sizeof(irq_set),
@@ -147,8 +147,8 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
     }
 }
 
-bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                            int action, int fd, Error **errp)
+bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
+                                   int action, int fd, Error **errp)
 {
     ERRP_GUARD();
     g_autofree struct vfio_irq_set *irq_set = NULL;
@@ -185,8 +185,8 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     return false;
 }
 
-int vfio_get_region_info(VFIODevice *vbasedev, int index,
-                         struct vfio_region_info **info)
+int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
+                                struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
 
@@ -212,8 +212,8 @@ retry:
     return 0;
 }
 
-int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
-                             uint32_t subtype, struct vfio_region_info **info)
+int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
+                                     uint32_t subtype, struct vfio_region_info **info)
 {
     int i;
 
@@ -221,7 +221,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
         struct vfio_info_cap_header *hdr;
         struct vfio_region_info_cap_type *cap_type;
 
-        if (vfio_get_region_info(vbasedev, i, info)) {
+        if (vfio_device_get_region_info(vbasedev, i, info)) {
             continue;
         }
 
@@ -233,8 +233,8 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
         cap_type = container_of(hdr, struct vfio_region_info_cap_type, header);
 
-        trace_vfio_get_dev_region(vbasedev->name, i,
-                                  cap_type->type, cap_type->subtype);
+        trace_vfio_device_get_region_info_type(vbasedev->name, i,
+                                               cap_type->type, cap_type->subtype);
 
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
@@ -247,12 +247,12 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
     return -ENODEV;
 }
 
-bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
+bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
     g_autofree struct vfio_region_info *info = NULL;
     bool ret = false;
 
-    if (!vfio_get_region_info(vbasedev, region, &info)) {
+    if (!vfio_device_get_region_info(vbasedev, region, &info)) {
         if (vfio_get_region_info_cap(info, cap_type)) {
             ret = true;
         }
@@ -367,7 +367,7 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
-bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp)
 {
     const VFIOIOMMUClass *ops =
@@ -395,7 +395,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
     return true;
 }
 
-void vfio_detach_device(VFIODevice *vbasedev)
+void vfio_device_detach(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
         return;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 70cfd685bd049aadf97b73d06086a0e44eb3f9cb..f3e6581f15b7033f79723e25e2097574af1feeb8 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -129,10 +129,10 @@ static bool vfio_display_edid_init(VFIOPCIDevice *vdev, Error **errp)
     int fd = vdev->vbasedev.fd;
     int ret;
 
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                                   VFIO_REGION_TYPE_GFX,
-                                   VFIO_REGION_SUBTYPE_GFX_EDID,
-                                   &dpy->edid_info);
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
+                                           VFIO_REGION_TYPE_GFX,
+                                           VFIO_REGION_SUBTYPE_GFX_EDID,
+                                           &dpy->edid_info);
     if (ret) {
         /* Failed to get GFX edid info, allow to go through without edid. */
         return true;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 265fffc2aa52d032ba619b1c3759ecebad438033..6678e0e5cd8c1e3bf489e185086ee703d657d4bd 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -200,7 +200,7 @@ static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
     if (ret) {
@@ -385,7 +385,7 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
      * Check whether we have all the vfio device specific regions to
      * support LPC quirk (added in Linux v4.6).
      */
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                         VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG, &lpc);
     if (ret) {
@@ -393,7 +393,7 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                         VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
     if (ret) {
@@ -542,8 +542,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * there's no ROM, there's no point in setting up this quirk.
          * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
          */
-        ret = vfio_get_region_info(&vdev->vbasedev,
-                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
+        ret = vfio_device_get_region_info(&vdev->vbasedev,
+                                          VFIO_PCI_ROM_REGION_INDEX, &rom);
         if ((ret || !rom->size) && !vdev->pdev.romfile) {
             error_setg(&err, "Device has no ROM");
             goto error;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bade3b80d7d98125cf84e13f0d34009b6c46992e..6fa7217db8dce10749c8cf35658376562fff8d42 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -115,7 +115,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
 
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
-    vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_unmask(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
@@ -131,7 +131,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
-    vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
 
@@ -149,15 +149,15 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         goto fail_irqfd;
     }
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_UNMASK,
-                                event_notifier_get_fd(&vdev->intx.unmask),
-                                errp)) {
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+                                       VFIO_IRQ_SET_ACTION_UNMASK,
+                                       event_notifier_get_fd(&vdev->intx.unmask),
+                                       errp)) {
         goto fail_vfio;
     }
 
     /* Let'em rip */
-    vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     vdev->intx.kvm_accel = true;
 
@@ -172,7 +172,7 @@ fail_irqfd:
     event_notifier_cleanup(&vdev->intx.unmask);
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
-    vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     return false;
 #else
     return true;
@@ -190,7 +190,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
      * Get to a known state, hardware masked, QEMU ready to accept new
      * interrupts, QEMU IRQ de-asserted.
      */
-    vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
 
@@ -210,7 +210,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vdev->intx.kvm_accel = false;
 
     /* If we've missed an event, let it re-fire through QEMU */
-    vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
 #endif
@@ -299,7 +299,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
@@ -322,7 +322,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
 
     timer_del(vdev->intx.mmap_timer);
     vfio_intx_disable_kvm(vdev);
-    vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
     vfio_mmap_set_enabled(vdev, true);
@@ -578,7 +578,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 
     if (!vdev->defer_kvm_irq_routing) {
         if (vdev->msix->noresize && resizing) {
-            vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
+            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
                 error_report("vfio: failed to enable vectors, %d", ret);
@@ -593,7 +593,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 fd = event_notifier_get_fd(&vector->interrupt);
             }
 
-            if (!vfio_set_irq_signaling(&vdev->vbasedev,
+            if (!vfio_device_irq_set_signaling(&vdev->vbasedev,
                                         VFIO_PCI_MSIX_IRQ_INDEX, nr,
                                         VFIO_IRQ_SET_ACTION_TRIGGER, fd,
                                         &err)) {
@@ -638,7 +638,7 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
         int32_t fd = event_notifier_get_fd(&vector->interrupt);
         Error *err = NULL;
 
-        if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+        if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
                                     nr, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
                                     &err)) {
             error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -835,7 +835,7 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
      * Always clear MSI-X IRQ index. A PF device could have enabled
      * MSI-X with no vectors. See vfio_msix_enable().
      */
-    vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
+    vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
 
     vfio_msi_disable_common(vdev);
     if (!vfio_intx_enable(vdev, &err)) {
@@ -852,7 +852,7 @@ static void vfio_msi_disable(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
 
-    vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSI_IRQ_INDEX);
+    vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSI_IRQ_INDEX);
     vfio_msi_disable_common(vdev);
     vfio_intx_enable(vdev, &err);
     if (err) {
@@ -886,8 +886,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     off_t off = 0;
     ssize_t bytes;
 
-    if (vfio_get_region_info(&vdev->vbasedev,
-                             VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
+    if (vfio_device_get_region_info(&vdev->vbasedev,
+                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
         error_report("vfio: Error getting ROM info: %m");
         return;
     }
@@ -1380,8 +1380,8 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
      * If the host driver allows mapping of a MSIX data, we are going to
      * do map the entire BAR and emulate MSIX table on top of that.
      */
-    if (vfio_has_region_cap(&vdev->vbasedev, region->nr,
-                            VFIO_REGION_INFO_CAP_MSIX_MAPPABLE)) {
+    if (vfio_device_has_region_cap(&vdev->vbasedev, region->nr,
+                                   VFIO_REGION_INFO_CAP_MSIX_MAPPABLE)) {
         return;
     }
 
@@ -2673,7 +2673,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     g_autofree struct vfio_region_info *reg_info = NULL;
     int ret;
 
-    ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
+    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
     if (ret) {
         error_setg_errno(errp, -ret,
                          "failed getting region info for VGA region index %d",
@@ -2771,8 +2771,8 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         QLIST_INIT(&vdev->bars[i].quirks);
     }
 
-    ret = vfio_get_region_info(vbasedev,
-                               VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
+    ret = vfio_device_get_region_info(vbasedev,
+                                      VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
     if (ret) {
         error_setg_errno(errp, -ret, "failed to get config info");
         return false;
@@ -2816,7 +2816,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
-    vfio_detach_device(&vdev->vbasedev);
+    vfio_device_detach(&vdev->vbasedev);
 
     g_free(vdev->vbasedev.name);
     g_free(vdev->msix);
@@ -2868,8 +2868,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->err_notifier);
@@ -2885,8 +2885,8 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
@@ -2933,8 +2933,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->req_notifier);
@@ -2951,8 +2951,8 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
@@ -3015,7 +3015,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
-    if (!vfio_attach_device(name, vbasedev,
+    if (!vfio_device_attach(name, vbasedev,
                             pci_device_iommu_address_space(pdev), errp)) {
         goto error;
     }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ca6528cc568db4f4666fea70896a39b650642679..49cd9816c3d8fc3c8e50032b307e9fe1b312240c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -119,8 +119,8 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
 
     qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
 
-    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+    if (!vfio_device_irq_set_signaling(vbasedev, intp->pin, 0,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
         qemu_set_fd_handler(fd, NULL, NULL, NULL);
         return -EINVAL;
@@ -301,7 +301,7 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
 
             if (vfio_irq_is_automasked(intp)) {
                 /* unmasks the physical level-sensitive IRQ */
-                vfio_unmask_single_irqindex(vbasedev, intp->pin);
+                vfio_device_irq_unmask(vbasedev, intp->pin);
             }
 
             /* a single IRQ can be active at a time */
@@ -357,8 +357,8 @@ static int vfio_set_resample_eventfd(VFIOINTp *intp)
     Error *err = NULL;
 
     qemu_set_fd_handler(fd, NULL, NULL, NULL);
-    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
-                                VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
+    if (!vfio_device_irq_set_signaling(vbasedev, intp->pin, 0,
+                                       VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
         return -EINVAL;
     }
@@ -546,7 +546,7 @@ static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return false;
     }
 
-    if (!vfio_attach_device(vbasedev->name, vbasedev,
+    if (!vfio_device_attach(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
         return false;
     }
@@ -555,7 +555,7 @@ static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return true;
     }
 
-    vfio_detach_device(vbasedev);
+    vfio_device_detach(vbasedev);
     return false;
 }
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 010b5241e15c2063051fd780c335fef80f214dc1..04bf9eb0987c0ac460e0a1c3ba5abdf4a87f7499 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -185,7 +185,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     g_autofree struct vfio_region_info *info = NULL;
     int ret;
 
-    ret = vfio_get_region_info(vbasedev, index, &info);
+    ret = vfio_device_get_region_info(vbasedev, index, &info);
     if (ret) {
         return ret;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ddb1bcc24a9cdc405713ca04d4ecc3d4a923ec42..8843560576935232a68a31d43e00be520e0284be 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -37,8 +37,6 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
-vfio_attach_device(const char *name, int group_id) " (%s) group %d"
-vfio_detach_device(const char *name, int group_id) " (%s) group %d"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
@@ -196,5 +194,7 @@ iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, i
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
 
 # device.c
-vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-vfio_reset_handler(void) ""
+vfio_device_get_region_info_type(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
+vfio_device_reset_handler(void) ""
+vfio_device_attach(const char *name, int group_id) " (%s) group %d"
+vfio_device_detach(const char *name, int group_id) " (%s) group %d"
-- 
2.49.0


