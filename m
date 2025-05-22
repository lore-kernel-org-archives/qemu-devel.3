Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA3C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7O7-0003cg-GD; Thu, 22 May 2025 10:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nx-0003aI-LV
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:59:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nq-0004i0-Q0
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:59:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEuCLl008288;
 Thu, 22 May 2025 14:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=T3td0SX9rG4EV8WLXUElloQxOM6S21n8sWZvI/b5d7A=; b=
 Wq0uMmlqL6IcME1oNFDWiJzoSSY86X3uWL3dK1vCHqO79zQQuUPm65vjEfnIFMrJ
 1rIL1GpmtU1mYbqQvxXcdM8frVgKXoo6ybKkvA4hHL2Ayy3LSWDbgHST0DerA/yt
 JYSeVRK2T0WL1SmuPWJ60/dprp/TzthnyPq1cvg2IWm46Y+a+ODho+EuYo9cAzGR
 pITNfdARocOZtbOpgTMpElrx/z98DkVduiRZdp/BGgDZre6b3foEi/sMR4UhDQtH
 CgY3WmEG4g+2UCMXhdjME2p/AohQrSyEGCer4jtSQocvbEghG7PyQr8fZWvOXuAz
 CxpVYfUyBHjco8EAyCeDWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5fug5hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MEEn56034519; Thu, 22 May 2025 14:58:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer9952-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiU9010227;
 Thu, 22 May 2025 14:58:53 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-8; Thu, 22 May 2025 14:58:52 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 7/7] vdpa: move memory listener register to vhost_vdpa_init
Date: Thu, 22 May 2025 10:58:39 -0400
Message-ID: <20250522145839.59974-8-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522145839.59974-1-jonah.palmer@oracle.com>
References: <20250522145839.59974-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220152
X-Proofpoint-GUID: 6LTKYsM8lepD35ukriGzIIE2RpTgntVe
X-Proofpoint-ORIG-GUID: 6LTKYsM8lepD35ukriGzIIE2RpTgntVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfXxROXe2SKhWyo
 hOBHymfNIvhw75guGLDX2ob0Tzw/oNpJDGqsGZbVy0gbRVR6SV7E1IvIgypnCyUzBVcNQXXIPpM
 n3vAuWJ6VFcahhwgX2Cr68wMblZvfv+ehPwpklfnxLCAhIjzhaHc9b+oNoka2K8xho6kNSf/l8e
 R8bv7Vx1JRogEw+9Ss0bRu6mY1Qdk7QJfiIc95tm+4ftZfwCdXUSFktBEBX9gopI+Q9LyLFm97J
 FQlC29nAwF2J3nyhqSpPkDHHrdpecizWsfxZo49t2jkb0o5Rv8VlRFJFfWoC92wQBZVQ+DoHuPe
 Xy/yjhD0sf3UpjQiwUxiR4tPu9tPqwzYye1I/64L23b9QKqjFl8k9DTr5QgiWjPCscUr1kqdww5
 RsOveydUrML8C9uKmOkUEQ24PUxwVAEL6OgPGIOLmOYqtp3FHD6e0z5jgyELIWHxgz42XR8E
X-Authority-Analysis: v=2.4 cv=CMQqXQrD c=1 sm=1 tr=0 ts=682f3baf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=LVXLgEsTiXo56sGS4ecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: Eugenio Pérez <eperezma@redhat.com>

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as the elapsed trace time between the last
vhost_vdpa_suspend on the source and the last vhost_vdpa_set_vring_enable_one
on the destination. In other words, from "guest CPUs freeze" to the
instant the final Rx/Tx queue-pair is able to start moving data.

Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
the series reduces guest-visible downtime during back-to-back live
migrations by more than half:
- 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
- 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

---
v4:
Updated performance measurements in the commit log.

v3:
Move memory listener unregistration from vhost_vdpa_reset_status to
vhost_vdpa_reset_device. By unregistering the listener here, we can
guarantee that every reset leaves the device in an expected state.
Also remove the duplicate call in vhost_vdpa_reset_status.

Reported-by: Lei Yang <leiyang@redhat.com>
Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>

v2:
Move the memory listener registration to vhost_vdpa_set_owner function.
In case of hotplug the vdpa device, the memory is already set up, and
leaving memory listener register call in the init function made maps
occur before set owner call.

To be 100% safe, let's put it right after set_owner call.

Reported-by: Lei Yang <leiyang@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index de834f2ebd..e20da95f30 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
     trace_vhost_vdpa_reset_device(dev);
+    if (ret) {
+        return ret;
+    }
+
+    memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
     v->suspended = false;
-    return ret;
+    return 0;
 }
 
 static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
@@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
+        if (v->shared->listener_registered &&
+            dev->vdev->dma_as != v->shared->listener.address_space) {
+            memory_listener_unregister(&v->shared->listener);
+            v->shared->listener_registered = false;
+        }
         if (!v->shared->listener_registered) {
             memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
             v->shared->listener_registered = true;
@@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
-    struct vhost_vdpa *v = dev->opaque;
-
     if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
@@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
-    memory_listener_unregister(&v->shared->listener);
-    v->shared->listener_registered = false;
-
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
@@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_owner(struct vhost_dev *dev)
 {
+    int r;
+    struct vhost_vdpa *v;
+
     if (!vhost_vdpa_first_dev(dev)) {
         return 0;
     }
 
     trace_vhost_vdpa_set_owner(dev);
-    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    /*
+     * Being optimistic and listening address space memory. If the device
+     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
+     */
+    v = dev->opaque;
+    memory_listener_register(&v->shared->listener, &address_space_memory);
+    v->shared->listener_registered = true;
+    return 0;
 }
 
 static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
-- 
2.43.5


