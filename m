Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E814CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Zh-0004Az-OW; Wed, 27 May 2026 02:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZW-00042b-Lt
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:55 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZR-0004Ed-Ka
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BEAE380765;
 Wed, 27 May 2026 09:16:47 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-eN3Skkiq; Wed, 27 May 2026 09:16:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862607;
 bh=cHNUGQYHpBInLb95ZLOID6Q1Am1IdFzgTlHbpH702Ng=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=upEw5rfwWv+/CDsdBP93AwYQUj4ovxUsaMUu0xJb5NWHZyUwkEWIxnyqi5zTI3HSt
 SgAZuJDiRXYFGF385eAsYk6EiYATagnbO/ZetS2PsufNJgaL9vbvkGeYs3BHsG5W50
 aaB4wCX7e9JcEEPPaGi0lXAk6HKZGhARjT1M5bBo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v7 22/22] vhost: add some useful trace-points
Date: Wed, 27 May 2026 09:16:23 +0300
Message-ID: <20260527061625.11167-23-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/trace-events | 12 ++++++++++--
 hw/virtio/vhost.c      | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index aa1ffa5e949..2a57edc21e3 100644
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
+vhost_virtqueue_start_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_start_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_stop_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_stop_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_dev_init_in(void *dev) "%p"
+vhost_dev_init_out(void *dev) "%p"
 
 
 # vhost-user.c
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 93c6a5f5e9a..c610007e812 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1337,6 +1337,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
+    trace_vhost_virtqueue_start_in(dev, vdev->name, idx);
+
     r = vhost_vrings_map(dev, vdev, vq, idx);
     if (r <= 0) {
         return r;
@@ -1397,6 +1399,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
+    trace_vhost_virtqueue_start_out(dev, vdev->name, idx);
+
     return 0;
 
 fail:
@@ -1415,6 +1419,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     };
     int r = 0;
 
+    trace_vhost_virtqueue_stop_in(dev, vdev->name, idx);
+
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
@@ -1448,6 +1454,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     vhost_vrings_unmap(dev, vq, true);
+
+    trace_vhost_virtqueue_stop_out(dev, vdev->name, idx);
     return r;
 }
 
@@ -1581,6 +1589,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
+    trace_vhost_dev_init_in(hdev);
+
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
@@ -1694,6 +1704,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    trace_vhost_dev_init_out(hdev);
+
     return 0;
 
 fail:
@@ -2098,7 +2110,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
-    trace_vhost_dev_start(hdev, vdev->name, vrings);
+    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
 
     vdev->vhost_started = true;
     hdev->started = true;
@@ -2183,6 +2195,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         }
     }
     vhost_start_config_intr(hdev);
+
+    trace_vhost_dev_start_out(hdev, vdev->name);
     return 0;
 fail_iotlb:
     if (vhost_dev_has_iommu(hdev) &&
@@ -2232,7 +2246,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-    trace_vhost_dev_stop(hdev, vdev->name, vrings);
+    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
 
     if (hdev->vhost_ops->vhost_dev_start) {
         hdev->vhost_ops->vhost_dev_start(hdev, false);
@@ -2262,6 +2276,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+
+    trace_vhost_dev_stop_out(hdev, vdev->name);
     return rc;
 }
 
-- 
2.52.0


