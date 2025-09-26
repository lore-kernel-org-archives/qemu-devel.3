Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2713CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216x-00009b-RP; Fri, 26 Sep 2025 01:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216k-0008Qo-En
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216d-0000uZ-Pi
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVN0k2RrPLWXXDfFdGf1vq4Z+Id+iJdU/HgYiYWPMDw=;
 b=dRVskXYAlXVk9HTGh2joxRCOcBu7RSZToXWRWX5b/eJOIjfae2D1LtwC9ilHWI+yvSkAbY
 /qqcIMhGdoKM+8HTh5NbYuebYgRBoBwzjPL3Kxqd3QBSy4R+GDBBNHmp2kJr+rAC1NURq4
 3Ke7B6+YaePEDTqEyv7reOTuKEIc+Sk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-kZ1t7ufYPiaZpMad8-Mz9g-1; Fri,
 26 Sep 2025 01:34:48 -0400
X-MC-Unique: kZ1t7ufYPiaZpMad8-Mz9g-1
X-Mimecast-MFC-AGG-ID: kZ1t7ufYPiaZpMad8-Mz9g_1758864887
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A408B1800290; Fri, 26 Sep 2025 05:34:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B58691800452; Fri, 26 Sep 2025 05:34:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/29] hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to
 TYPE_VFIO_PCI_DEVICE
Date: Fri, 26 Sep 2025 07:33:46 +0200
Message-ID: <20250926053358.308198-18-clg@redhat.com>
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

This brings the QOM type name in line with the underlying VFIOPCIDevice structure.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-17-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h            |  2 +-
 hw/vfio/types.h          |  4 ++--
 hw/s390x/s390-pci-vfio.c | 14 +++++++-------
 hw/vfio-user/pci.c       | 13 +++++++------
 hw/vfio/device.c         |  2 +-
 hw/vfio/pci.c            | 28 ++++++++++++++--------------
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index e0aef82a8931c78a5504411a912acddda1fd6549..0f78cf9cdbf18924f8e3f9e43c475a41e0ccd928 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -120,7 +120,7 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index c19334ff25ae2f5221f08ed863553ce7f8e3be98..5482d908088af7240e00c4e0cfe2e68e842c2520 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -9,11 +9,11 @@
 #define HW_VFIO_VFIO_TYPES_H
 
 /*
- * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * TYPE_VFIO_PCI_DEVICE is an abstract type used to share code
  * between VFIO implementations that use a kernel driver
  * with those that use user sockets.
  */
-#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+#define TYPE_VFIO_PCI_DEVICE "vfio-pci-device"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7760780aff7ae18034d8cbbb77c4d41ea95a6be5..9e31029d7acbe1f735a5c6b0c937c923e5c00061 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 {
     S390PCIDMACount *cnt;
     uint32_t avail;
-    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
     int id;
 
     assert(vpdev);
@@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
@@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
     struct vfio_device_info_cap_zpci_group *cap;
     S390pciState *s = s390_get_phb();
     ClpRspQueryPciGrp *resgrp;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint8_t start_gid = pbdev->zpci_fn.pfgid;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
@@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_util *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
 
@@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_pfip *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
 
@@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 
 static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c309784fec5feca635eb0f314f02eabb2dbf1f..efceae69dee09c6e0f695cf08519c3644178f763 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -234,9 +234,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     const char *sock_name;
+
     AddressSpace *as;
     SocketAddress addr;
     VFIOUserProxy *proxy;
@@ -346,7 +347,7 @@ error:
 static void vfio_user_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -371,7 +372,7 @@ static void vfio_user_instance_init(Object *obj)
 
 static void vfio_user_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     if (vdev->msix != NULL) {
@@ -387,7 +388,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static void vfio_user_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_pre_reset(vdev);
@@ -421,7 +422,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
-    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
+    if (VFIO_PCI_DEVICE(udev)->vbasedev.proxy) {
         error_setg(errp, "Proxy is connected");
         return;
     }
@@ -464,7 +465,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_user_pci_dev_info = {
     .name = TYPE_VFIO_USER_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_dev_class_init,
     .instance_init = vfio_user_instance_init,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 963cefc053d0959a173c7789801916dcacce552b..64f87503894791850b059b225762fd45d85ee16c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -423,7 +423,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI_BASE(obj)->vbasedev;
+        return &VFIO_PCI_DEVICE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 479def72c5823da110cfb282bc838e8ad897efad..aa9d3e0354946451a526539bc2909a97175a633c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -305,7 +305,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -660,7 +660,7 @@ void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -755,7 +755,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1346,7 +1346,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1392,7 +1392,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
@@ -1426,7 +1426,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
     int ret;
@@ -3392,7 +3392,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
     char uuid[UUID_STR_LEN];
@@ -3552,14 +3552,14 @@ error:
 
 static void vfio_pci_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
 
     vfio_pci_put_device(vdev);
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3583,7 +3583,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
 
     /* Do not reset the device during qemu_system_reset prior to cpr load */
     if (cpr_is_incoming()) {
@@ -3628,7 +3628,7 @@ post_reset:
 static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3669,7 +3669,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo vfio_pci_base_dev_info = {
-    .name = TYPE_VFIO_PCI_BASE,
+    .name = TYPE_VFIO_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
@@ -3758,7 +3758,7 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
@@ -3914,7 +3914,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_pci_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
-- 
2.51.0


