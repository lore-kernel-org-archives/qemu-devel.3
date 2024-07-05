Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C6C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfoz-00048p-A5; Fri, 05 Jul 2024 06:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sPfon-000415-QM; Fri, 05 Jul 2024 06:05:31 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sPfoj-00055P-K3; Fri, 05 Jul 2024 06:05:27 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d565deea08so827945b6e.1; 
 Fri, 05 Jul 2024 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720173922; x=1720778722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XAa88sDmGRRXIZB2stboyo8b8D/abonwEDM/YirviDI=;
 b=MGy2sXcZQ1JWEHNkh36/ngy96oTpJYEKjT7f2UFCDyqYgMf0S2ZAyqPYwuS63u6gcD
 BXf0kIKXgbTma6ZFyUXShcWDeyYM5e13g5XXAbuR25oDvyva018MAQtBjUXKXYsxFisM
 lu5iTXJZfGePc8jBgvFYiDxFdZCGsdWSWCLohsoZbPc/6T35oo8TQsbKTMAcA7GRiKgw
 B0ruGFTZ2JDisAXX3eV5mPeyDe/6gLpx7AOIC3YJN0XxFRvNpUzNL0+qvIIdKtP2O984
 o8l00b3UXtNXTWiAt6rG+uNoJe2v+XzQXxqscqxhmTlnqJ7rirrbAE+es/vycIrRUjzv
 BiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173922; x=1720778722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XAa88sDmGRRXIZB2stboyo8b8D/abonwEDM/YirviDI=;
 b=ph7KqLCfY55Mh6zepsQ0ntqaeVmsV6azXDPHFqyRWw/wnsAIVtFK/U8aTfZX7QoAi2
 xJppCv6sMn/kvIIgcJumHcug+X4zqj1N5IQzPhAIgEW3xJxa2pAZEDzBnawff0QGY8J9
 csYfCXtbjViwWsk2bOlJQO5mUXQm5H1+nvcbumzaMRP1Zx9iYFe3DWnGO3MgQGjk7SHH
 iZsvRqYL47r8ktCvLPJLVTzVJY6k2tNEmk7rvzTRI167yeinvNpp+SMHaB4D1hAyL5P+
 FkYgGF4x0JR1MGirAl/a6ZG20Q6ZGY6feZc7+oDAZkC6sxkhwgBtplvEfh9ByBof6a8J
 uV9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMY28nLXtweLalMsw7Xadw1ltBenn6bZOGlRvdJeGGGu3OjhBsYVOxGazkgx0IGodfNHI6tWRlUKlzAjTbkjc3vSazEIky
X-Gm-Message-State: AOJu0YxbOP1Bevws16vFV1cA62rU+UOvmcupDhy4hCLwvHrR/9fAHFZs
 yp8pI+VlmHiVU5SXVIEO8c1g2e+ODwt/GOVpAiQDeLbLgR6a0OSDdJu2ATY6rvM=
X-Google-Smtp-Source: AGHT+IFtDKZZsfpyF6yecSpHXo3zH9KwcKopV2IBHMF+RyKkcc4dyuLkdVUAHvaPxUWxXalJtLz6sA==
X-Received: by 2002:a05:6808:189e:b0:3d6:2f1c:e771 with SMTP id
 5614622812f47-3d914c54e5dmr4654755b6e.18.1720173922592; 
 Fri, 05 Jul 2024 03:05:22 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6d416554sm10732882a12.94.2024.07.05.03.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:05:22 -0700 (PDT)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 hreitz@redhat.com, qemu-stable@nongnu.org,
 thomas <east.moutain.yang@gmail.com>
Subject: [PATCH v8] virtio-net: Fix network stall at the host side waiting for
 kick
Date: Fri,  5 Jul 2024 18:05:02 +0800
Message-Id: <20240705100502.4112-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-oi1-x230.google.com
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

The patch enables notification and checks whether the guest has
added some buffers since last check of available buffers when
the available buffers are insufficient. If no buffer is added,
return false, else recheck the available buffers in the loop.
If the available buffers are sufficient, disable notification
and return true.

Changes:
1. Change the return type of virtqueue_get_avail_bytes() from void
   to int, let it return the shadow_avail_idx of the virtqueue
   on success.
2. Add a new API: virtio_queue_enable_notification_and_check(),
   it takes the return value of virtqueue_get_avail_bytes() as
   input arg, enables notification firstly, then checks whether
   the guest has added some buffers or not since last check of
   available buffers, return ture if yes.

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
packet from the host.

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
    wait for kick                   add buf   virtnet_poll
                                      ...         |
                                                 ---
                                 no more packet, exit NAPI

In the first loop of NAPI above, indicated in the range of
virtnet_poll above, the host is sending packets while the
guest is receiving packets and adding buffers.
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

Fixes: 06b12970174 ("virtio-net: fix network stall under load")
Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
Changelog:
v8:
- Change virtqueue_get_avail_bytes() return type from void
  to int, it returns shadow_avail_idx on success.
- virtio_queue_set_notification_and_check() accepts two args,
  the second arg is the shadow idx retruned from
  virtqueue_get_avail_bytes()
- Add function virtio_queue_poll(), it accepts shadow idx
  returned from virtqueue_get_avail_bytes() as the second
  arg, and tells whether guest had add some buffers since
  last check of available buffers.

v7:
- Add function virtio_queue_set_notification_and_check()
- Restore the function sequence introduce in v6

v6:
- Take packed packed queue into cosideration
- Adjust function sequence to fix compilation issue

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

 hw/net/virtio-net.c        | 34 +++++++++++++++--------
 hw/virtio/virtio.c         | 56 ++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h | 12 ++++++--
 3 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..a652aa3a16 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1641,24 +1641,34 @@ static bool virtio_net_can_receive(NetClientState *nc)
 
 static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
 {
+    int shadow_idx;
+    unsigned int in_bytes;
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
-            (n->mergeable_rx_bufs &&
-             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+
+    while (virtio_queue_empty(q->rx_vq) || n->mergeable_rx_bufs) {
+        shadow_idx = virtqueue_get_avail_bytes(q->rx_vq, &in_bytes, NULL,
+                                               bufsize, 0);
+        /* invalid shadow idx */
+        if (shadow_idx < 0) {
+            return 0;
+        }
+
+        /* buffer is enough, disable notifiaction */
+        if (bufsize <= in_bytes) {
+            break;
+        }
+
+        if (virtio_queue_enable_notification_and_check(q->rx_vq,
+                                                       (unsigned)shadow_idx)) {
+            /* guest has added some buffers, try again */
+            continue;
+        } else {
             return 0;
         }
     }
 
     virtio_queue_set_notification(q->rx_vq, 0);
+
     return 1;
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..d04f4d9b2e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -745,6 +745,56 @@ int virtio_queue_empty(VirtQueue *vq)
     }
 }
 
+static bool virtio_queue_split_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    if (unlikely(!vq->vring.avail)) {
+        return false;
+    }
+
+    return (uint16_t)shadow_idx != vring_avail_idx(vq);
+}
+
+static bool virtio_queue_packed_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    VRingPackedDesc desc;
+    VRingMemoryRegionCaches *caches;
+
+    if (unlikely(!vq->vring.desc)) {
+        return false;
+    }
+
+    caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return false;
+    }
+
+    vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
+                           shadow_idx, true);
+
+    return is_desc_avail(desc.flags, vq->shadow_avail_wrap_counter);
+}
+
+static bool virtio_queue_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    if (virtio_device_disabled(vq->vdev)) {
+        return false;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_poll(vq, shadow_idx);
+    } else {
+        return virtio_queue_split_poll(vq, shadow_idx);
+    }
+}
+
+bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
+                                                unsigned shadow_idx)
+{
+    virtio_queue_set_notification(vq, 1);
+
+    return virtio_queue_poll(vq, shadow_idx);
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
@@ -1332,7 +1382,7 @@ err:
     goto done;
 }
 
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                unsigned int *out_bytes,
                                unsigned max_in_bytes, unsigned max_out_bytes)
 {
@@ -1367,7 +1417,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                         caches);
     }
 
-    return;
+    return (int)vq->shadow_avail_idx;
 err:
     if (in_bytes) {
         *in_bytes = 0;
@@ -1375,6 +1425,8 @@ err:
     if (out_bytes) {
         *out_bytes = 0;
     }
+
+    return -1;
 }
 
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..c4ce7b544e 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -271,9 +271,9 @@ void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
                                 VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
-                               unsigned int *out_bytes,
-                               unsigned max_in_bytes, unsigned max_out_bytes);
+int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+                              unsigned int *out_bytes, unsigned max_in_bytes,
+                              unsigned max_out_bytes);
 
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
@@ -307,6 +307,12 @@ int virtio_queue_ready(VirtQueue *vq);
 
 int virtio_queue_empty(VirtQueue *vq);
 
+/**
+ * enable notification and check whether guest has added some
+ * buffers since last sync of shadow_avail_idx from the queue
+ */
+bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
+                                                unsigned shadow_idx);
 /* Host binding interface.  */
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
-- 
2.39.0


