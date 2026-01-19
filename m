Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC84CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNY-0007JJ-4a; Mon, 19 Jan 2026 13:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN9-0006Si-0s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:09 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN6-0005vc-1E
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 36C688862A;
 Mon, 19 Jan 2026 21:53:02 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-Li1QLaMd; Mon, 19 Jan 2026 21:53:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848781;
 bh=sRTUof3aR9yyqe90RtKsurcduMWfkkRXnpVvjR0pios=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DKePihZtrea51DjCowLNSgCl9J9tDCY1NrlMbyS97J7Q+tJptCe4YIpnTlI3rJsB4
 BIqK1eRiWONrdNPgJotqOuLbWDev20Q+XqRpFEN/MRvnNjX8niuVpOQ5JVcx9spwEC
 2cv9L2wsM2NYR9jUEsLUid87F03HR3FEnjzmWzYc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v4 23/23] vhost: add some useful trace-points
Date: Mon, 19 Jan 2026 21:52:27 +0300
Message-ID: <20260119185228.203296-24-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index aa1ffa5e94..2a57edc21e 100644
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
index ad49b9cc2f..d241c6110f 100644
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
@@ -1398,6 +1400,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
+    trace_vhost_virtqueue_start_out(dev, vdev->name, idx);
+
     return 0;
 
 fail:
@@ -1416,6 +1420,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     };
     int r = 0;
 
+    trace_vhost_virtqueue_stop_in(dev, vdev->name, idx);
+
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
@@ -1449,6 +1455,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     vhost_vrings_unmap(dev, vq, true);
+
+    trace_vhost_virtqueue_stop_out(dev, vdev->name, idx);
     return r;
 }
 
@@ -1582,6 +1590,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
+    trace_vhost_dev_init_in(hdev);
+
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
@@ -1695,6 +1705,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    trace_vhost_dev_init_out(hdev);
+
     return 0;
 
 fail:
@@ -2043,7 +2055,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
-    trace_vhost_dev_start(hdev, vdev->name, vrings);
+    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
 
     vdev->vhost_started = true;
     hdev->started = true;
@@ -2128,6 +2140,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         }
     }
     vhost_start_config_intr(hdev);
+
+    trace_vhost_dev_start_out(hdev, vdev->name);
     return 0;
 fail_iotlb:
     if (vhost_dev_has_iommu(hdev) &&
@@ -2177,7 +2191,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-    trace_vhost_dev_stop(hdev, vdev->name, vrings);
+    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
 
     if (hdev->vhost_ops->vhost_dev_start) {
         hdev->vhost_ops->vhost_dev_start(hdev, false);
@@ -2207,6 +2221,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+
+    trace_vhost_dev_stop_out(hdev, vdev->name);
     return rc;
 }
 
-- 
2.52.0


