Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C172C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9c-0004OB-PH; Mon, 12 May 2025 11:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9a-0004GR-5i
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9X-0006fA-VL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCA0DC018776;
 Mon, 12 May 2025 15:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=yVN76vltI4t6ZE993sEnFd8vU1OWcqQeDKje3+tGCfM=; b=
 c7NvDXB4vKZcA+sFT1jgpyTiPnb35BuS4+OKomoko/SkTcce1zm3LdOMG5ParZnk
 0XDpK8FYsd08W2r5qhAK8zjWUKl73O7aKHdn3h4csm/1iXtZ8JzioSmexm7mn/CM
 DjqWvB37dXmZDAev9xsPvw79+HTSbxVeT9O5rMwgpD6wKLcbenVj3x7sknTfABiZ
 TCUiT/4ucMJeKyDJxUyfXtsMvoPLfBLjtw4CbezE/r/x8RXd/XxW5SV78Y0YeOV8
 iYXya2Cy39oz8aSouExLVmdTE8Mbl10zQgcsyQM9TeugeH1orudjabrkkLvqvbDm
 og68FBwtFBZ7jA6QnK6ZMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CFGGRH002411; Mon, 12 May 2025 15:33:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3668y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4w030605;
 Mon, 12 May 2025 15:33:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-11; Mon, 12 May 2025 15:33:01 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 10/42] vfio/container: restore DMA vaddr
Date: Mon, 12 May 2025 08:32:21 -0700
Message-Id: <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXxv5ybnRu8iAn
 srotXXOnYPvVNyP0+SQH7sHG8SUygMD/jD5NcGjBsEvZbdCaWig/t46XJc5BkXGAc9xyXRJDlqI
 1d7WWI3EHsi/DGr6fqncflLEohQnDSYWcetQZQI/uHLxrDIa1BGn8w65wN8TbjZLTIQ4k9QRYIV
 1+Xy/KmTCQ97niuJNh0j5+7JTx1SDWVaQB2/PJ1j0mVq02Oe0BBp4SQP6uYj2Z/VogKPtkP0cLu
 0PPGQ/aM9ftuEkztPcRO2tnx3ftZBlgLqE7Tjgd6VtouLxnwFYXiJZpicgDGHJ8ec1BkGcdGgU2
 0TX1RcJevEjglv+ljalfw7H81aw3izyFpUceKgSZv3z1t+FA2IX3qGB5hxz2V9jHEsYNlo6zUVB
 h5mxpkIi8T6R+Fh33RY8Tw5vvSXBf0qxHxKtiTX2ALvBqJHRBLTOLdfuyFqSXuGcLjvE61WS
X-Proofpoint-GUID: RZ8oPU63l2izSkLrm-GH3cKgym8KfJeF
X-Proofpoint-ORIG-GUID: RZ8oPU63l2izSkLrm-GH3cKgym8KfJeF
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=GhJuAjOf1PyZR_944Y0A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In new QEMU, do not register the memory listener at device creation time.
Register it later, in the container post_load handler, after all vmstate
that may affect regions and mapping boundaries has been loaded.  The
post_load registration will cause the listener to invoke its callback on
each flat section, and the calls will match the mappings remembered by the
kernel.

The listener calls a special dma_map handler that passes the new VA of each
section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
handler at the end.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c  | 15 +++++++++++++--
 hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a554683..0e02726 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    assert(!container->cpr.reused);
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     }
     group_was_added = true;
 
-    if (!vfio_listener_register(bcontainer, errp)) {
-        goto fail;
+    /*
+     * If reused, register the listener later, after all state that may
+     * affect regions and mapping boundaries has been cpr load'ed.  Later,
+     * the listener will invoke its callback on each flat section and call
+     * dma_map to supply the new vaddr, and the calls will match the mappings
+     * remembered by the kernel.
+     */
+    if (!cpr_reused) {
+        if (!vfio_listener_register(bcontainer, errp)) {
+            goto fail;
+        }
     }
 
     bcontainer->initialized = true;
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 519d772..bbcf71e 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -11,11 +11,13 @@
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 
 static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
 {
@@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
     return true;
 }
 
+/*
+ * Set the new @vaddr for any mappings registered during cpr load.
+ * Reused is cleared thereafter.
+ */
+static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   bool readonly)
+{
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
+    struct vfio_iommu_type1_dma_map map = {
+        .argsz = sizeof(map),
+        .flags = VFIO_DMA_MAP_FLAG_VADDR,
+        .vaddr = (__u64)(uintptr_t)vaddr,
+        .iova = iova,
+        .size = size,
+    };
+
+    assert(container->cpr.reused);
+
+    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
+        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
+                     iova, size, vaddr, strerror(errno));
+        return -errno;
+    }
+
+    return 0;
+}
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
@@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOGroup *group;
     VFIODevice *vbasedev;
+    Error *err = NULL;
+
+    if (!vfio_listener_register(bcontainer, &err)) {
+        error_report_err(err);
+        return -1;
+    }
 
     container->cpr.reused = false;
 
     QLIST_FOREACH(group, &container->group_list, container_next) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+        /* Restore original dma_map function */
+        vioc->dma_map = vfio_legacy_dma_map;
+
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
             vbasedev->cpr.reused = false;
         }
@@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
@@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    /* During incoming CPR, divert calls to dma_map. */
+    if (container->cpr.reused) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+    }
     return true;
 }
 
-- 
1.8.3.1


