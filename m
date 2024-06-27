Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B106C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlqb-0003Fn-TP; Thu, 27 Jun 2024 05:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sMlqY-0003FZ-CE; Thu, 27 Jun 2024 05:55:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sMlqW-00009O-1W; Thu, 27 Jun 2024 05:55:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so9996925ad.0; 
 Thu, 27 Jun 2024 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482112; x=1720086912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yzeO+r4PX2lm8S8aql5AUP17orUN8uDY+I4SjJM59I=;
 b=Xqu0zyzwN0lHDxLEKA9DEgCHJSOhGSTIjKBDfCBDG6qRUqLj2qDwIck28DOgXh6IoQ
 yzBzLiLUC0CLEye0zjfqGdys3Rbm0rPudhLCW/M4ZHMMzK++jRnh2rGTsMVJsOg0zK0W
 t6okirey6P8p8MCVk0TgmZ5mxzDfKp5l7RcZFRzRjuC0gj5TPih5q7uQxn7jm/JwLUQi
 eGtmFTJRXrtxArgkshz/iJgiv0y8d97zDqopzOseEZ1sS2p/Me4+B5DnJGZWlqljP0dd
 g1VhFwyct5cmNz/SXTaEZMAWew2Aa5HH8Jsl2Z31Y56dAxEZ6oowQaba7fO5lyzhpeUK
 KaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482112; x=1720086912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yzeO+r4PX2lm8S8aql5AUP17orUN8uDY+I4SjJM59I=;
 b=vx9IJIElFFiv1OhStuVpQj25abWCin4jQPQ3fr/cUSa+iDOuVizH5pIzuIZlesBIbj
 26WPLvdLtAfJ+cCAV5EY+4pVrqSNubXpM/boeZ19/NjVYWKDQL16IDresZGaeMARmt96
 ZbLhG/xWjET//lFBKi7WRx3yEpWNQZYx+8ziSwG4iMhW01eq4rQ74VGRVnuiGIFPx2fP
 Ogei/42DKh95Ga565WWbkUJfo518ZzR3DBx6Y8Pe9hyWCE2JJRyP5ffri9nrlsKZunfA
 tsQiOjNqXsxzuZ5z3VwU9avz4GO8THsbLJ0VlYnZu2lJJ9ZFLEQmmhrL0vl/ki5dA58b
 Rfeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj9IFcIaXWXk/GC0YmaS3e8rQpgEH9Dc/bQU0YqUUQuOzKmO2i19le1KW+G+kU6JDECqZ0W8/2noGktMFFrU1yTLoaxiJt
X-Gm-Message-State: AOJu0YytIjK878RLpdupGkafRLRUFh67OuaO8u4ovP07fb8S1S7XcnPq
 rCuh0z+ndccLfv+MXn55jV+WUqjj0vNdljY4UWyllL97hl9WapX3k/gdnUlyQWo=
X-Google-Smtp-Source: AGHT+IGni4vqrQdBTbCzcqPByU3w26Ute6UDaWYjv/JSl87mWxAuboC+aY315wXw9nm4rsSlqvMxKg==
X-Received: by 2002:a17:902:f693:b0:1f9:a602:5e41 with SMTP id
 d9443c01a7336-1fa1d3b7218mr148803635ad.1.1719482111619; 
 Thu, 27 Jun 2024 02:55:11 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac9c4eefsm9393565ad.294.2024.06.27.02.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:55:11 -0700 (PDT)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org,
 thomas <east.moutain.yang@gmail.com>
Subject: [PATCH v5] virtio-net: Fix network stall at the host side waiting for
 kick
Date: Thu, 27 Jun 2024 17:54:08 +0800
Message-Id: <20240627095408.22504-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: thomas <east.moutain.yang@gmail.com>

Patch 06b12970174 ("virtio-net: fix network stall under load")
added double-check to test whether the available buffer size
can satisfy the request or not, in case the guest has added
some buffers to the avail ring simultaneously after the first
check. It will be lucky if the available buffer size becomes
okay after the double-check, then the host can send the packet
to the guest. If the buffer size still can't satisfy the request,
even if the guest has added some buffers, viritio-net would
stall at the host side forever.

The patch checks whether the guest has added some buffers
after last check of avail idx when the available buffers are
not sufficient, if so then recheck the available buffers
in the loop.

The patch also reverts patch "06b12970174".

The case below can reproduce the stall.

                                       Guest 0
                                     +--------+
                                     | iperf  |
                    ---------------> | server |
         Host       |                +--------+
       +--------+   |                    ...
       | iperf  |----
       | client |----                  Guest n
       +--------+   |                +--------+
                    |                | iperf  |
                    ---------------> | server |
                                     +--------+

Boot many guests from qemu with virtio network:
 qemu ... -netdev tap,id=net_x \
    -device virtio-net-pci-non-transitional,\
    iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x

Each guest acts as iperf server with commands below:
 iperf3 -s -D -i 10 -p 8001
 iperf3 -s -D -i 10 -p 8002

The host as iperf client:
 iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
 iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000

After some time, the host loses connection to the guest,
the guest can send packet to the host, but can't receive
packet from host.

It's more likely to happen if SWIOTLB is enabled in the guest,
allocating and freeing bounce buffer takes some CPU ticks,
copying from/to bounce buffer takes more CPU ticks, compared
with that there is no bounce buffer in the guest.
Once the rate of producing packets from the host approximates
the rate of receiveing packets in the guest, the guest would
loop in NAPI.

         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               |  need kick the host?
               |  NAPI continues
               v
         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               v
              ...           ...

On the other hand, the host fetches free buf from avail
ring, if the buf in the avail ring is not enough, the
host notifies the guest the event by writing the avail
idx read from avail ring to the event idx of used ring,
then the host goes to sleep, waiting for the kick signal
from the guest.

Once the guest finds the host is waiting for kick singal
(in virtqueue_kick_prepare_split()), it kicks the host.

The host may stall forever at the sequences below:

         Host                        Guest
     ------------                 -----------
 fetch buf, send packet           receive packet ---
         ...                          ...         |
 fetch buf, send packet             add buf       |
         ...                        add buf   virtnet_poll
    buf not enough      avail idx-> add buf       |
    read avail idx                  add buf       |
                                    add buf      ---
                                  receive packet ---
    write event idx                   ...         |
    waiting for kick                 add buf   virtnet_poll
                                      ...         |
                                                 ---
                                 no more packet, exit NAPI

In the first loop of NAPI above, indicated in the range of
virtnet_poll above, the host is sending packets while the
guest is receiving packets and adding buf.
 step 1: The buf is not enough, for example, a big packet
         needs 5 buf, but the available buf count is 3.
         The host read current avail idx.
 step 2: The guest adds some buf, then checks whether the
         host is waiting for kick signal, not at this time.
         The used ring is not empty, the guest continues
         the second loop of NAPI.
 step 3: The host writes the avail idx read from avail
         ring to used ring as event idx via
         virtio_queue_set_notification(q->rx_vq, 1).
 step 4: At the end of the second loop of NAPI, recheck
         whether kick is needed, as the event idx in the
         used ring written by the host is beyound the
         range of kick condition, the guest will not
         send kick signal to the host.

Changelog:
v5:
- Modify return type of virtio_queue_set_notification() to
  bool to indicate whether the guest has added some buffers
  after last check of avail idx
- Loop in virtio_net_has_buffers() if the available buffers
  are not sufficient and the guest has added some buffers.
- Revert patch "06b12970174"
- Update the subject

v4:
- Correct spelling mistake in the subject
- Describe the issue that virtio-net is blocked at host side

v3:
- Add virtio-net tag in the subject
- Refine commit log

v2:
- Add SOB tag at the end of the commit message
- Place Fixes tag at the end of the commit message

v1:
- Initial patch

Fixes: 06b12970174 ("virtio-net: fix network stall under load")
Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 hw/net/virtio-net.c        | 19 ++++++++-----------
 hw/virtio/virtio.c         | 23 ++++++++++++++++-------
 include/hw/virtio/virtio.h |  2 +-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..13affc1f35 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1642,18 +1642,15 @@ static bool virtio_net_can_receive(NetClientState *nc)
 static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
 {
     VirtIONet *n = q->n;
-    if (virtio_queue_empty(q->rx_vq) ||
-        (n->mergeable_rx_bufs &&
-         !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
-        virtio_queue_set_notification(q->rx_vq, 1);
-
-        /* To avoid a race condition where the guest has made some buffers
-         * available after the above check but before notification was
-         * enabled, check for available buffers again.
-         */
-        if (virtio_queue_empty(q->rx_vq) ||
+
+    while (virtio_queue_empty(q->rx_vq) ||
             (n->mergeable_rx_bufs &&
-             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+            !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+        /* guest may have made some buf, try again */
+        if (virtio_queue_set_notification(q->rx_vq, 1)) {
+            virtio_queue_set_notification(q->rx_vq, 0);
+            continue;
+        } else {
             return 0;
         }
     }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..3e9b8b0d29 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -507,10 +507,13 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
 
-static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
+static bool virtio_queue_split_set_notification(VirtQueue *vq, int enable)
 {
+    uint16_t shadow_idx;
+
     RCU_READ_LOCK_GUARD();
 
+    shadow_idx = vq->shadow_avail_idx;
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -521,10 +524,14 @@ static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
     if (enable) {
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
+
+        return shadow_idx != vring_avail_idx(vq);
     }
+
+    return false;
 }
 
-static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
+static bool virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
 {
     uint16_t off_wrap;
     VRingPackedDescEvent e;
@@ -533,7 +540,7 @@ static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
     RCU_READ_LOCK_GUARD();
     caches = vring_get_region_caches(vq);
     if (!caches) {
-        return;
+        return false;
     }
 
     vring_packed_event_read(vq->vdev, &caches->used, &e);
@@ -555,6 +562,8 @@ static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
     }
+
+    return false;
 }
 
 bool virtio_queue_get_notification(VirtQueue *vq)
@@ -562,18 +571,18 @@ bool virtio_queue_get_notification(VirtQueue *vq)
     return vq->notification;
 }
 
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+bool virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
 
     if (!vq->vring.desc) {
-        return;
+        return false;
     }
 
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
-        virtio_queue_packed_set_notification(vq, enable);
+        return virtio_queue_packed_set_notification(vq, enable);
     } else {
-        virtio_queue_split_set_notification(vq, enable);
+        return virtio_queue_split_set_notification(vq, enable);
     }
 }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..e1a1621e2d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -301,7 +301,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
 void virtio_notify_config(VirtIODevice *vdev);
 
 bool virtio_queue_get_notification(VirtQueue *vq);
-void virtio_queue_set_notification(VirtQueue *vq, int enable);
+bool virtio_queue_set_notification(VirtQueue *vq, int enable);
 
 int virtio_queue_ready(VirtQueue *vq);
 
-- 
2.39.0


