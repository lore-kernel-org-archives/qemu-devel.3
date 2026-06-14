Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18504CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCr-0007Mq-Nh; Sun, 14 Jun 2026 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCg-0007DB-Bo
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCe-0002O9-Bp
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yknmJ7/BrwD4b2kAfEcOvb77sRsuPj51BSB4Y0Ox3ms=;
 b=MrC1Xd8knyuIfPgh9kvtzRljgaHcsG5LIkScVgMNy1CboTZVqQycd5ZwAHyCFuQEgGVene
 4YssqIf9qGPRvFp01itkSMd3+dZF+YaSwWmj8Ozr02Ad4GoH0r9WubD3SuX5S0MxKLm7xn
 NzX1H22OQIsfG3zSmXJlMOHMrYt9mBM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-aHmtByWoMfq0mi0fzXyKMA-1; Sun, 14 Jun 2026 15:09:02 -0400
X-MC-Unique: aHmtByWoMfq0mi0fzXyKMA-1
X-Mimecast-MFC-AGG-ID: aHmtByWoMfq0mi0fzXyKMA_1781464141
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b0682d2fso23953695e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464141; x=1782068941; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yknmJ7/BrwD4b2kAfEcOvb77sRsuPj51BSB4Y0Ox3ms=;
 b=fjdQ8RaSDqcZ6l+nzDmhobKod05hqHgVAKU6jS1m6T2ahScfOr55+8PxnZmQtwZ5Le
 8MUSSwgHFX/w4UqxqskSP3/952e9/ZLUYEt9mcJZumQY37SOG7WbNN/mDpEchfvgJiY0
 XGP42k3zM4BWkCkwZVBzN64xHyN15h4s0D+IQi0UCHN/o4KrT2VpQ+KBKiqxxrzWerxa
 12zIKgL0IBrmJGtg3W1dmVgisBr5Q20/ZBZ8yEvKHy9fx//lMUufxenUvNAI3yK5HMC0
 am7rNwFbgIHm/Qx8QxDV5IMAan4c3wGTG/A8lUsMvJOUmxwcMaOVBlEUroF5FGck/jxn
 m/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464141; x=1782068941;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yknmJ7/BrwD4b2kAfEcOvb77sRsuPj51BSB4Y0Ox3ms=;
 b=fbUfqndZheW9euEgM3IBplqpFyhg3UymivRS2cO431epwia9WjZv+0jRrabJbEP/Od
 GVMHqwnDGBP/pHKdpyViVJplQKxnqy4UYzpz0dghaIG/PtMWGNB/UcPgCZwHTOX/Nc3B
 ZJjb3hRMrkYM91czCOn7cK7VQ8C6b/iT67337iU/QoKm4tgFP3z7UoDBtwCc4mw8EN2F
 +u6PTWyF7U1VPbenNeUwCcVPfdHZeVr+0Z8JEqVuwCzlzv3gL7MMvAO3OEPZGkhzVKgt
 hPWwo4BgUah4a0NGsJ+frObMj+zFJBE75BdXcgHKo1Fb9eQxGBPaL7BcGV7xL+EWH5R0
 7M4Q==
X-Gm-Message-State: AOJu0YxFfw2dEXUkYHdyDCQG5SM8AzPoY2e+g4XX3YTPNFRxppJo5GG0
 jpGM8tzTEJAE+h2uAUou7arQTqOjYZOFSXauu+aiBo9iI5XfFvm0vrqNaNCRieo8iC7xnCn7ub5
 mE9fv+R/pVgFCsnJFWHZHjBRx2L/XHQh0i/oSrGoSyaig8kZr/QiUgB6F7SG/aINNZnJ6NGTdXn
 fZPFl4OjGzusZ/ROUu3VfNvVbYDADheWtuUg==
X-Gm-Gg: Acq92OEaRBohPQr7NJahGL3cB+iYJuVHAFTbwByorlOTuK4/jtr26b/aneiMKDVkabd
 FwRxYnASJn95QhAv092upCfFN11FEpdR6DBuUPwy9aP23syVhLLz9JY4JpxxcWmEOLmgNAXsm3t
 znD4YNWiC2JTgSEpSJfqS9W3TMTtcfjRp2EfZMcJUY5lLtDjBKS+kWkAtEFg2n9ihkyRsFolIE/
 1kuyACxQIp03RyxlrBOOzp2b4vOlU5RZwmz2cxVANrESKutudS7hg1UowPrBkjN3n+8HV5QCjnl
 ss+nmFH3SanzhlpRC2/RzLIfoqjkrhMlx4QTDnoKhWa9Fny/MfrVc0VxBSXZ2r1sTF1JaB8g1O5
 JSBjGLnJiAAtrg6448mV7ZzjJZCATUaHkzPSmy/6TJO8=
X-Received: by 2002:a05:600c:154b:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-4922005e579mr99902475e9.3.1781464141167; 
 Sun, 14 Jun 2026 12:09:01 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-4922005e579mr99902105e9.3.1781464140639; 
 Sun, 14 Jun 2026 12:09:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203bfb27sm210158445e9.11.2026.06.14.12.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:00 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 077/106] vhost: add in_order feature to shadow virtqueue
Message-ID: <485c9e69ef6e9030ac368745886f07dfb56602a6.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eugenio Pérez <eperezma@redhat.com>

Some vdpa devices benefit from the in order feature.  Add support to SVQ
so QEMU can migrate these.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-7-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 137 +++++++++++++++++++++++++++--
 hw/virtio/vhost-shadow-virtqueue.h |  36 ++++++--
 2 files changed, 160 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2d8fc82cc0..60212fcd7b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -12,11 +12,14 @@
 
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
 
+#define VIRTIO_RING_NOT_IN_BATCH UINT16_MAX
+
 /**
  * Validate the transport device features that both guests can use with the SVQ
  * and SVQs can use with the device.
@@ -150,7 +153,33 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
 static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
                                     uint16_t id)
 {
-    return svq->desc_state[id].next;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        return (id == svq->vring.num) ? 0 : ++id;
+    } else {
+        return svq->desc_state[id].next;
+    }
+}
+
+/**
+ * Updates the SVQ free_head member after adding them to the SVQ avail ring.
+ * The new free_head is the next descriptor that SVQ will make available by
+ * forwarding a new guest descriptor.
+ *
+ * @svq Shadow Virtqueue
+ * @num Number of descriptors added
+ * @id ID of the last descriptor added to the SVQ avail ring.
+ */
+static void vhost_svq_update_free_head(VhostShadowVirtqueue *svq,
+                                       size_t num, uint16_t id)
+{
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->free_head += num;
+        if (svq->free_head >= svq->vring.num) {
+            svq->free_head -= svq->vring.num;
+        }
+    } else {
+        svq->free_head = vhost_svq_next_desc(svq, id);
+    }
 }
 
 /**
@@ -202,7 +231,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         i = next;
     }
 
-    svq->free_head = vhost_svq_next_desc(svq, last);
+    vhost_svq_update_free_head(svq, num, last);
     return true;
 }
 
@@ -306,6 +335,9 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->desc_state[qemu_head].in_bytes = iov_size(in_sg, in_num);
+    }
     vhost_svq_kick(svq);
     return 0;
 }
@@ -401,6 +433,12 @@ static void vhost_handle_guest_kick_notifier(EventNotifier *n)
 static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
 {
     uint16_t *used_idx = &svq->vring.used->idx;
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER) &&
+        svq->batch_last.id != VIRTIO_RING_NOT_IN_BATCH) {
+        return true;
+    }
+
     if (svq->last_used_idx != svq->shadow_used_idx) {
         return true;
     }
@@ -463,6 +501,47 @@ static uint16_t vhost_svq_get_last_used_split(VhostShadowVirtqueue *svq,
     return le32_to_cpu(used->ring[last_used].id);
 }
 
+/*
+ * Gets the next buffer id and moves forward the used idx, so the next time
+ * SVQ calls this function will get the next one.  IN_ORDER version
+ *
+ * @svq: Shadow VirtQueue
+ * @len: Consumed length by the device.
+ *
+ * Return the next descriptor consumed by the device.
+ */
+static int32_t vhost_svq_get_last_used_split_in_order(
+        VhostShadowVirtqueue *svq,
+        uint32_t *len)
+{
+    unsigned num = svq->vring.num;
+    const vring_used_t *used = svq->vring.used;
+    uint16_t last_used = svq->last_used & (num - 1);
+    uint16_t last_used_idx = svq->last_used_idx & (num - 1);
+
+    if (svq->batch_last.id == VIRTIO_RING_NOT_IN_BATCH) {
+        svq->batch_last.id = le32_to_cpu(used->ring[last_used_idx].id);
+        svq->batch_last.len = le32_to_cpu(used->ring[last_used_idx].len);
+    }
+
+    if (unlikely(last_used >= num)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
+                      svq->vdev->name, last_used);
+        return -1;
+    }
+
+    if (svq->batch_last.id == last_used) {
+        svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
+        *len = svq->batch_last.len;
+    } else {
+        *len = svq->desc_state[last_used].in_bytes;
+    }
+
+    svq->last_used += svq->desc_state[last_used].ndescs;
+    svq->last_used_idx++;
+    return last_used;
+}
+
 static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
@@ -474,8 +553,8 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
 }
 
 G_GNUC_WARN_UNUSED_RESULT
-static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
-                                              uint16_t id)
+static VirtQueueElement *vhost_svq_detach_buf_split(VhostShadowVirtqueue *svq,
+                                                    uint16_t id)
 {
     uint16_t num = svq->desc_state[id].ndescs;
     uint16_t last_used_chain = vhost_svq_last_desc_of_chain(svq, num, id);
@@ -486,6 +565,33 @@ static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
     return g_steal_pointer(&svq->desc_state[id].elem);
 }
 
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf_split_in_order(
+        VhostShadowVirtqueue *svq,
+        uint16_t id)
+{
+    return g_steal_pointer(&svq->desc_state[id].elem);
+}
+
+/*
+ * Return the descriptor id (and the chain of ids) to the free list
+ *
+ * @svq: Shadow Virtqueue
+ * @id: Id of the buffer to return.
+ *
+ * Return the element associated to the buffer if any.
+ */
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
+                                              uint16_t id)
+{
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        return vhost_svq_detach_buf_split_in_order(svq, id);
+    } else {
+        return vhost_svq_detach_buf_split(svq, id);
+    }
+}
+
 G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
@@ -498,7 +604,18 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
 
     /* Only get used array entries after they have been exposed by dev */
     smp_rmb();
-    last_used = vhost_svq_get_last_used_split(svq, len);
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        int32_t r;
+        r = vhost_svq_get_last_used_split_in_order(svq, len);
+        if (r < 0) {
+            return NULL;
+        }
+
+        last_used = r;
+    } else {
+        last_used = vhost_svq_get_last_used_split(svq, len);
+    }
 
     if (unlikely(last_used >= svq->vring.num)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
@@ -726,6 +843,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->next_guest_avail_elem = NULL;
     svq->shadow_avail_idx = 0;
     svq->shadow_used_idx = 0;
+    memset(&svq->batch_last, 0, sizeof(svq->batch_last));
+    svq->last_used = 0;
     svq->last_used_idx = 0;
     svq->vdev = vdev;
     svq->vq = vq;
@@ -742,8 +861,12 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_state[i].next = i + 1;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
+    } else {
+        for (unsigned i = 0; i < svq->vring.num - 1; i++) {
+            svq->desc_state[i].next = i + 1;
+        }
     }
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index f52c33e650..ec16a1e838 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -24,11 +24,19 @@ typedef struct SVQDescState {
      */
     unsigned int ndescs;
 
-    /*
-     * Backup next field for each descriptor so we can recover securely, not
-     * needing to trust the device access.
-     */
-    uint16_t next;
+    union {
+        /*
+         * Total length of the available buffer that is writable by the device.
+         * Only used in packed vq.
+         */
+        uint32_t in_bytes;
+
+        /*
+         * Backup next field for each descriptor so we can recover securely, not
+         * needing to trust the device access.  Only used in split vq.
+         */
+        uint16_t next;
+    };
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
@@ -99,9 +107,25 @@ typedef struct VhostShadowVirtqueue {
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-    /* Next free descriptor */
+    /*
+     * Next free descriptor.
+     *
+     * Without IN_ORDER free_head is used as a linked list head, and
+     * desc_next[id] is the next element.
+     * With IN_ORDER free_head is the next available buffer index.
+     */
     uint16_t free_head;
 
+    /*
+     * Last used element of the processing batch of used descriptors if
+     * IN_ORDER.
+     * If SVQ is not processing a batch of descriptors id is set to UINT_MAX.
+     */
+    vring_used_elem_t batch_last;
+
+    /* Last used id if IN_ORDER and split vq */
+    uint16_t last_used;
+
     /* Last seen used idx */
     uint16_t shadow_used_idx;
 
-- 
MST


