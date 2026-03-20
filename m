Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64720109878A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3air-00033N-Fp; Fri, 20 Mar 2026 10:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aip-00032p-Rq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aim-0007V8-Ve
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YDn53323103; Fri, 20 Mar 2026 14:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=gbqbM
 rs7LdafLAZ6yqHmxkhLZEPGK/o30SzLEplpO8w=; b=Jaq9I8lGg4T1bgkrZbV7H
 W+YdI1BFU2lpz3gWSpBOC0POEZl23Yc1T2rB00GPBN+rh9FepvQvwHgOoXfs9MVI
 s6hCxqry0mkDIn20SL8iyBQHOQParxpY1w4gU0oYz6+tmSnpGZ00Nl3pbNyzm4mu
 AfqxiBkvbx6tD9VloC0Lgfu76ddoSp2D7dlGowQagMLoEb5ViidspGeE1ecc3A/p
 lM/nLK+hM08GBo+k1susbZ2Vy7/Dqyy4zrQKNI2haAEZF/WzpJPneeoTWkrVz0M+
 k6/b9780aGFPneZu6LaD2YDKZ60BxmwwBvpvTrB5ES5Mvv+l3K9EmMLOAbINe86P
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8htke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDON7l030599; Fri, 20 Mar 2026 14:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb4cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jx016730;
 Fri, 20 Mar 2026 14:20:44 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-15; Fri, 20 Mar 2026 14:20:44 +0000
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 14/14] virtio-net,
 vhost-net: early migration support for vhost-net
Date: Fri, 20 Mar 2026 14:20:15 +0000
Message-ID: <20260320142015.3856652-15-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320142015.3856652-1-jonah.palmer@oracle.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX0hf//rzTR+cK
 ZLIcIy3xXCpBS4NNt61ZCadj6LhQOf4zdwHWEpNNyCAtlZCU6AjWMT0ilrgUIhJ5HB6owK7h8QI
 Wl06V1hsjOMg5XpyY14Lvqmt3r4+DJPlOp69uGzphzE+9HGYgQgKEBs33pBvxmQ99Q491KjyL0U
 jvL3fjnZMo2fYQDtfdRgPmgnaNPOL9yjOFCjsq9RZe6B9syiQx3eH6W2m+EcH5K+ucubeqXvA9r
 sqtn/5MzDOeV1ZNID4rxAe6FmMYQ676irm6bsvNJl7jlPUJyOlZF9xoVSPc9LzZ2yns9hcOSU7R
 UzuqSnRLo6A0F1DCYWq2Uej/XYjSECC60gLB3CAur86mq6hVAlHbzdvsBV6h5f5muo15jmSYfvp
 yXQfiwUb81P/BSHHdfZSKGWNFpPhaKTP7Dtq1+lEG0QlxDtXZBVe/hxq5GlO31IYstzQUHwhfmX
 cMR22iOUUJutW5ZCHNA==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bd57bd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=Xb7ORfVXokAGz2rkdSYA:9
X-Proofpoint-GUID: rqVfpMpNzv8eA8JQZ1ZjEyXYUfDJVTkD
X-Proofpoint-ORIG-GUID: rqVfpMpNzv8eA8JQZ1ZjEyXYUfDJVTkD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonah Palmer <jonah.palmer@oracle.com>
From:  Jonah Palmer via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements early migration support for virtio-net devices
using a TAP backend accelerated by vhost-net.

More specifically, we initiate the vhost startup routine during early
migration time but guard against binding TAP backends at this time. We
need to wait until the source VM has been paused before we want the
device to actually start.

For vhost-net, the remaining stop-and-copy work is to apply final vring
bases and bind TAP backends. This is handled via the virtio-net vhost
subsection (vmstate_virtio_net_vhost) post_load callback.

When a mid-migration delta is detected and we fall back to a full
virtio-net reload, explicitly stop any early-started vhost instance
before restart so notifier/backend state is handled safely.

Failures while starting vhost-net during early post-load, and failures
during stop-and-copy quickstart finalization, are treated as non-fatal
for migration. In those cases the destination continues migration and
falls back to userspace virtio-net datapath. After switchover, the
normal vhost start path may retry once status is set; if that retry also
fails, the device continues running on userspace virtio-net.

By moving most of the post-load startup work out of the stop-and-copy
phase, we further minimize the guest-visible downtime incurred by
migrating a virtio-net device using vhost-net.

A future improvement to this patch should handle deltas more gracefully
by updating only what was changed mid-migration instead of relying on a
full vhost/virtio-net restart.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/vhost_net.c             | 183 +++++++++++++++++++++++++++++++++
 hw/net/virtio-net.c            | 127 ++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |   2 +
 include/net/vhost_net.h        |   9 ++
 4 files changed, 319 insertions(+), 2 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a8ee18a912..f11f30b4f0 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -353,6 +353,13 @@ static int vhost_net_start_one(struct vhost_net *net,
                 /* Queue might not be ready for start */
                 continue;
             }
+            if (dev->migration && dev->migration->early_load) {
+                /*
+                 * Queue isn't ready to start as we're in the middle of an
+                 * early migration. Set the backend later when we're ready.
+                 */
+                continue;
+            }
             r = vhost_net_set_backend(&net->dev, &file);
             if (r < 0) {
                 r = -errno;
@@ -695,3 +702,179 @@ err_start:
 
     return r;
 }
+
+/*
+ * Helper function for vhost_net_post_load_migration_quickstart:
+ *
+ * Sets vring bases for all vhost virtqueues.
+ */
+int vhost_net_set_all_vring_bases(struct VirtIONet *n, VirtIODevice *vdev,
+                                  NetClientState *ncs, int queue_pairs,
+                                  int cvq, int nvhosts)
+{
+    NetClientState *peer;
+    struct vhost_net *vnet;
+    struct vhost_dev *hdev;
+    int queue_idx;
+    int i, j, r;
+
+    for (i = 0; i < nvhosts; i++) {
+        peer = qemu_get_peer(ncs, i < queue_pairs ? i : n->max_queue_pairs);
+        vnet = get_vhost_net(peer);
+        if (!vnet) {
+            continue;
+        }
+        hdev = &vnet->dev;
+
+        for (j = 0; j < hdev->nvqs; ++j) {
+            queue_idx = hdev->vq_index + j;
+            struct vhost_vring_state state = {
+                .index = hdev->vhost_ops->vhost_get_vq_index(hdev, queue_idx),
+                .num = virtio_queue_get_last_avail_idx(vdev, queue_idx),
+            };
+
+            r = hdev->vhost_ops->vhost_set_vring_base(hdev, &state);
+            if (r) {
+                error_report("vhost_set_vring_base failed (vq %d)", queue_idx);
+                goto fail;
+            }
+        }
+    }
+    return 0;
+
+fail:
+    vhost_net_stop_one(vnet, vdev);
+
+    while (--i >= 0) {
+        peer = qemu_get_peer(ncs, i < queue_pairs ? i : n->max_queue_pairs);
+        vhost_net_stop_one(get_vhost_net(peer), vdev);
+    }
+    return r;
+}
+
+/*
+ * Helper function for vhost_net_post_load_migration_quickstart:
+ *
+ * Binds TAP backends to all vhost-net virtqueues. All vring bases must be set
+ * before attempting to start any backends.
+ */
+int vhost_net_start_all_backends(struct VirtIONet *n, VirtIODevice *vdev,
+                                 NetClientState *ncs, int queue_pairs, int cvq,
+                                 int nvhosts)
+{
+    NetClientState *peer;
+    struct vhost_dev *hdev;
+    struct vhost_vring_file file = { };
+    struct vhost_net *vnet;
+    int i, r;
+
+    for (i = 0; i < nvhosts; i++) {
+        peer = qemu_get_peer(ncs, i < queue_pairs ? i : n->max_queue_pairs);
+        vnet = get_vhost_net(peer);
+        if (!vnet) {
+            continue;
+        }
+        hdev = &vnet->dev;
+
+        qemu_set_fd_handler(vnet->backend, NULL, NULL, NULL);
+        file.fd = vnet->backend;
+
+        for (file.index = 0; file.index < hdev->nvqs; ++file.index) {
+            if (!virtio_queue_enabled(vdev, hdev->vq_index + file.index)) {
+                /* Queue might not be ready to start */
+                continue;
+            }
+
+            r = vhost_net_set_backend(hdev, &file);
+            if (r < 0) {
+                r = -errno;
+                goto fail;
+            }
+        }
+    }
+    return 0;
+
+fail:
+    file.fd = -1;
+    while (file.index-- > 0) {
+        if (!virtio_queue_enabled(vdev, hdev->vq_index + file.index)) {
+            continue;
+        }
+        int ret = vhost_net_set_backend(hdev, &file);
+        assert(ret >= 0);
+    }
+    if (vnet->nc->info->poll) {
+        vnet->nc->info->poll(vnet->nc, true);
+    }
+    vhost_dev_stop(hdev, vdev, false);
+
+    while (--i >= 0) {
+        peer = qemu_get_peer(ncs, i < queue_pairs ? i : n->max_queue_pairs);
+        vhost_net_stop_one(get_vhost_net(peer), vdev);
+    }
+    return r;
+}
+
+/*
+ * Quickstart path for a virtio-net device using vhost acceleration:
+ *
+ * Used during migration of a virtio-net device that opted-in to early
+ * migration.
+ *
+ * The goal of this function is to perform any remaining startup work that
+ * can only be done during the stop-and-copy phase, once the source has been
+ * stopped.
+ *
+ * Note: By the time this function is called, the device has essentially been
+ * fully configured, albeit with a few last-minute configurations to be made.
+ * This means our error handling must completely unwind the device with
+ * full-stop semantics.
+ */
+int vhost_net_post_load_migration_quickstart(struct VirtIONet *n)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    NetClientState *ncs = qemu_get_queue(n->nic);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+
+    int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+    int cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+              n->max_ncs - n->max_queue_pairs : 0;
+    int nvhosts = queue_pairs + cvq;
+    int total_notifiers = queue_pairs * 2 + cvq;
+    NetClientState *peer = qemu_get_peer(ncs, 0);
+
+    int r, e;
+
+    /* First peer must exist for the realized virtio-net device */
+    assert(peer);
+
+    /* Apply final vring bases for all vhosts */
+    r = vhost_net_set_all_vring_bases(n, vdev, ncs, queue_pairs, cvq, nvhosts);
+    if (r < 0) {
+        goto fail;
+    }
+
+    /* Bind backends (TAP devices only) */
+    if (peer->info->type == NET_CLIENT_DRIVER_TAP) {
+        r = vhost_net_start_all_backends(n, vdev, ncs, queue_pairs, cvq, nvhosts);
+        if (r < 0) {
+            goto fail;
+        }
+    }
+    return 0;
+
+fail:
+    e = k->set_guest_notifiers(qbus->parent, total_notifiers, false);
+    if (e < 0) {
+        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
+        fflush(stderr);
+    }
+    vhost_net_disable_notifiers(vdev, ncs, queue_pairs, cvq);
+
+    error_report("unable to start vhost net: %d: "
+                 "falling back on userspace virtio", -r);
+    n->vhost_started = 0;
+    return r;
+}
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 483a43be4f..950137c568 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3864,6 +3864,38 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static int virtio_net_vhost_early_start(VirtIONet *n, VirtIODevice *vdev)
+{
+    NetClientState *ncs = qemu_get_queue(n->nic);
+    int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+    int cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+              n->max_ncs - n->max_queue_pairs : 0;
+    int r;
+
+    /* Return early if there's no vhost backend */
+    if (!ncs || !ncs->peer || !get_vhost_net(ncs->peer)) {
+        return 0;
+    }
+
+    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MTU)) {
+        r = vhost_net_set_mtu(get_vhost_net(ncs->peer), n->net_conf.mtu);
+        if (r < 0) {
+            error_report("%u bytes MTU not supported by the backend",
+                         n->net_conf.mtu);
+            return r;
+        }
+    }
+
+    n->vhost_started = 1;
+    r = vhost_net_start(vdev, n->nic->ncs, queue_pairs, cvq);
+    if (r < 0) {
+        error_report("unable to start vhost net: %d: "
+                     "falling back on userspace virtio", -r);
+        n->vhost_started = 0;
+    }
+    return r;
+}
+
 enum VirtIONetRxFlags {
     VNET_RX_F_PROMISC  = 1u << 0,
     VNET_RX_F_ALLMULTI = 1u << 1,
@@ -3892,6 +3924,9 @@ static int virtio_net_early_pre_save(void *opaque)
     VirtIONetMigration *vnet_mig = n->migration;
     size_t vlans_size = (size_t)(MAX_VLAN >> 3);
 
+    /* Reset source-side delta decision for this migration iteration. */
+    n->migration->reloaded = false;
+
     vdev_mig->status_early = vdev->status;
     vnet_mig->status_early = n->status;
 
@@ -3989,6 +4024,14 @@ static int virtio_net_early_post_load(void *opaque, int version_id)
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
 
+    /*
+     * Start the vhost backend if one is present. Note that while
+     * vdev->migration->early_load is true, not all vhost startup operations
+     * are performed. For example, we defer setting the backends (vhost-net w/
+     * TAP) until the stop-and-copy phase (see vmstate_virtio_net_vhost).
+     */
+    virtio_net_vhost_early_start(n, vdev);
+
     vdev->migration->early_load = false;
     return 0;
 }
@@ -4007,6 +4050,49 @@ static const VMStateDescription vmstate_virtio_net_early = {
     },
 };
 
+static int virtio_net_vhost_post_load(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    int r;
+
+    if (!n->vhost_started) {
+        return 0;
+    }
+
+    /* Finalize vhost startup */
+    r = vhost_net_post_load_migration_quickstart(n);
+    if (r < 0) {
+        error_report("virtio-net vhost post-load quickstart failed: %d", r);
+    }
+    return 0;
+}
+
+static bool virtio_net_vhost_needed(void *opaque)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    if (!nc || !nc->peer || !get_vhost_net(nc->peer)) {
+        return false;
+    }
+
+    /* Skip vhost quickstart section when a full virtio-net reload is needed. */
+    return !n->migration->reloaded;
+}
+
+static const VMStateDescription vmstate_virtio_net_vhost = {
+    .name = "virtio-net-vhost",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    /* Set prio low to run after vmstate_virtio_net */
+    .priority = MIG_PRI_LOW,
+    .needed = virtio_net_vhost_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .post_load = virtio_net_vhost_post_load,
+};
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -4201,9 +4287,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             vdev->migration = g_new0(VirtIODevMigration, 1);
             vdev->migration->early_load = false;
             n->migration = g_new0(VirtIONetMigration, 1);
-
             vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
             virtio_delta_vmsd_register(vdev);
+            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_vhost,
+                                 n);
         }
     }
 }
@@ -4271,6 +4358,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
 
         vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
         virtio_delta_vmsd_unregister(vdev);
+        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_vhost, n);
     }
 }
 
@@ -4336,6 +4424,37 @@ static int virtio_net_pre_save(void *opaque)
     return 0;
 }
 
+static int virtio_net_pre_load(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    /*
+     * If we're migrating with a vhost device and performed an early
+     * save/load, then reaching here means that something changed and
+     * we need to reload all of the virtio-net device's state.
+     */
+    if (n->early_mig) {
+        /*
+         * Unwind vhost-net before full reload path re-runs startup. This keeps
+         * notifier/backend state handling safe.
+         */
+        if (n->vhost_started) {
+            NetClientState *nc = qemu_get_queue(n->nic);
+            int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+            int cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+                      n->max_ncs - n->max_queue_pairs : 0;
+
+            if (nc && nc->peer && get_vhost_net(nc->peer)) {
+                vhost_net_stop(vdev, n->nic->ncs, queue_pairs, cvq);
+            }
+
+            n->vhost_started = 0;
+        }
+    }
+    return 0;
+}
+
 static bool primary_unplug_pending(void *opaque)
 {
     DeviceState *dev = opaque;
@@ -4466,12 +4585,15 @@ static bool virtio_net_needed(void *opaque)
 {
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    bool delta;
 
     if (!n->early_mig) {
         return true;
     }
 
-    return virtio_net_has_delta(n, vdev);
+    delta = virtio_net_has_delta(n, vdev);
+    n->migration->reloaded = delta;
+    return delta;
 }
 
 static const VMStateDescription vmstate_virtio_net = {
@@ -4484,6 +4606,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = virtio_net_pre_save,
+    .pre_load = virtio_net_pre_load,
     .dev_unplug_pending = dev_unplug_pending,
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index dbbacc83bb..d1d7c0b742 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -169,6 +169,7 @@ typedef struct VirtIONetQueue {
 
 /**
  * struct VirtIONetMigration - VirtIONet migration structure
+ * @reloaded: Flag to indicate the state has been reloaded.
  * @status_early: VirtIONet status snapshot.
  * @mac_early: MAC address early migration snapshot.
  * @mtable_in_use_early: In-use MAC table entries.
@@ -191,6 +192,7 @@ typedef struct VirtIONetQueue {
  * @rss_indirections_table_early: RSS indirections table.
  */
 typedef struct VirtIONetMigration {
+    bool reloaded;
     uint16_t status_early;
     uint8_t mac_early[ETH_ALEN];
     uint32_t mtable_in_use_early;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 0225207491..a8a1c1005b 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -4,6 +4,7 @@
 #include "net/net.h"
 #include "hw/virtio/virtio-features.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/virtio-net.h"
 
 struct vhost_net;
 typedef struct vhost_net VHostNetState;
@@ -88,4 +89,12 @@ int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
                                 int vq_index);
 
 void vhost_net_save_acked_features(NetClientState *nc);
+
+int vhost_net_set_all_vring_bases(struct VirtIONet *n, VirtIODevice *vdev,
+                                  NetClientState *ncs, int queue_pairs,
+                                  int cvq, int nvhosts);
+int vhost_net_start_all_backends(struct VirtIONet *n, VirtIODevice *vdev,
+                                  NetClientState *ncs, int queue_pairs,
+                                  int cvq, int nvhosts);
+int vhost_net_post_load_migration_quickstart(struct VirtIONet *n);
 #endif
-- 
2.51.0


