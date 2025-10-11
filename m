Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD7ACCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ix7-0006Jt-8M; Sat, 11 Oct 2025 19:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ix5-0006JF-O9
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ix3-0000vl-To
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9B627C01DD;
 Sun, 12 Oct 2025 02:24:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-W9WADeRZ; Sun, 12 Oct 2025 02:24:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225066;
 bh=rkKDNqLmUfNjo4O0c7dmnMJaKIu8C/BqjUGQSszHpfU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=z3+o7rhGTlgGdX+V011HX40aWdfxWoTCschahxUEhVHWcFrOHT7EQ6j8lZ8urzR7C
 p+LUU2/sSpTPfEzE6Xa+jMpZUBaEJPUYWZU3kNTJYOCHfVUVX7PZS4oq8YlrBHY5vl
 JkeyOwe/tKGSOAD95UnLhav1HdeQ2O4ILiCzNO1s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 23/23] vhost: add some useful trace-points
Date: Sun, 12 Oct 2025 02:24:02 +0300
Message-ID: <20251011232404.561024-24-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/trace-events | 12 ++++++++++--
 hw/virtio/vhost.c      | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index aa1ffa5e94..c2529814f9 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -9,8 +9,16 @@ vhost_section(const char *name) "%s"
 vhost_reject_section(const char *name, int d) "%s:%d"
 vhost_iotlb_miss(void *dev, int step) "%p step %d"
 vhost_dev_cleanup(void *dev) "%p"
-vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
-vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_start_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_start_out(void *dev, const char *name) "%p:%s"
+vhost_dev_stop_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_stop_out(void *dev, const char *name) "%p:%s"
+vhost_virtque_start_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtque_start_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtque_stop_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtque_stop_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_dev_init_in(void *dev) "%p"
+vhost_dev_init_out(void *dev) "%p"
 
 
 # vhost-user.c
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d02d1d4c34..f15ef8cff6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1333,6 +1333,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
+    trace_vhost_virtque_start_in(dev, vdev->name, idx);
+
     r = vhost_vrings_map(dev, vdev, vq, idx);
     if (r <= 0) {
         return r;
@@ -1394,6 +1396,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
+    trace_vhost_virtque_start_out(dev, vdev->name, idx);
+
     return 0;
 
 fail:
@@ -1412,6 +1416,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     };
     int r = 0;
 
+    trace_vhost_virtque_stop_in(dev, vdev->name, idx);
+
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
@@ -1445,6 +1451,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     vhost_vrings_unmap(dev, vq, true);
+
+    trace_vhost_virtque_stop_out(dev, vdev->name, idx);
     return r;
 }
 
@@ -1616,6 +1624,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 {
     int i, r, n_initialized_vqs = 0;
 
+    trace_vhost_dev_init_in(hdev);
+
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
@@ -1700,6 +1710,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    trace_vhost_dev_init_out(hdev);
+
     return 0;
 
 fail:
@@ -2048,7 +2060,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
-    trace_vhost_dev_start(hdev, vdev->name, vrings);
+    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
 
     vdev->vhost_started = true;
     hdev->started = true;
@@ -2133,6 +2145,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         }
     }
     vhost_start_config_intr(hdev);
+
+    trace_vhost_dev_start_out(hdev, vdev->name);
     return 0;
 fail_iotlb:
     if (vhost_dev_has_iommu(hdev) &&
@@ -2182,7 +2196,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-    trace_vhost_dev_stop(hdev, vdev->name, vrings);
+    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
 
     if (hdev->vhost_ops->vhost_dev_start) {
         hdev->vhost_ops->vhost_dev_start(hdev, false);
@@ -2212,6 +2226,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+
+    trace_vhost_dev_stop_out(hdev, vdev->name);
     return rc;
 }
 
-- 
2.48.1


