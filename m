Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F05C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkX-0006GJ-4u; Sun, 21 Jul 2024 20:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkP-0005UG-Lu
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkN-0005nP-Fm
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/XwQGLmqpOnXFp7/p1VkjvkoBY6YC9rGIfU0QombD0=;
 b=cV1EDsLfKftHtTaKRy2dS2i4t+bttodTBVImOzNYseZAZBl0bsComtMN/ePQ02+XbvX+WT
 CgDE+WdL+W4rDIEVaxpbcKk5oZ+HPTTgazEpz9rZPGvdnMryZq1khxnloegIFV0jnTyTv7
 4PCCsifPRvXWl5x+w/SPPmeU3p75vnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-mkhygVVhMSGSN0DXmumMUw-1; Sun, 21 Jul 2024 20:17:44 -0400
X-MC-Unique: mkhygVVhMSGSN0DXmumMUw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42668857c38so27733565e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607462; x=1722212262;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/XwQGLmqpOnXFp7/p1VkjvkoBY6YC9rGIfU0QombD0=;
 b=hs6RFPuJouLjzqfpgiOX9O4q3qoB/ngPahtfDAa7yFR2Fx7wKTtmNzaKPKFtPe6HAA
 RTx2FQurx2It4kRjkXe2lFgf+07/UBSprmcBzymCjw3rZQfYBj/uL38KWNMIvn8+US4J
 LVM/+EIRDXXfh+wUqYeuu13sPII68Vd3ooqQYIpLhbe5EFhZxHJcvi2wQdwX4/QzJ1sr
 r5pXUWvGFzY288H3xpOdvNMbhwQ4wr7KbeOV2UkNSG3wSX8sTIQ3op+bBAAuj41JaJ+r
 e+EHaoNnyvsiBcyU5FGJ+ayJQicrm5CP+FrpteHAwBhidz+zu14KbgMSWoGSZxrCIjnE
 +v8A==
X-Gm-Message-State: AOJu0YxPf94Q3gEGC4Z8mCtYYiMRATKX666J8pbxchEc1qYGuscEqNS7
 Mxi0P5z6+q5U88+8Cem2bvCuIGymZjp4lHr67pZ/P4rXRn272IcEKb4bQCtEoMa9sWmohFCKTbH
 dmoBFTi6bLOzeop6IqtUnwn3f3ukRX5GnEWEAqmjfcHnFWzg0M9nqCIBx8eOSOKzj8rr6xCtdrE
 Ba/Gbr+mjMVevitTpepYqTMODL3dEyqg==
X-Received: by 2002:a5d:4e49:0:b0:368:4e4f:cec5 with SMTP id
 ffacd0b85a97d-369bae2512fmr3157333f8f.35.1721607462356; 
 Sun, 21 Jul 2024 17:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI0hcKUSqjqAPe3LpGpBgRRLTIFf68etQr4hG7y1zIoqyZNvpLZgqNuqa9ti212/xeQtGQzw==
X-Received: by 2002:a5d:4e49:0:b0:368:4e4f:cec5 with SMTP id
 ffacd0b85a97d-369bae2512fmr3157319f8f.35.1721607461659; 
 Sun, 21 Jul 2024 17:17:41 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368786943d3sm7034880f8f.50.2024.07.21.17.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:41 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 24/63] virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER
 support
Message-ID: <b44135daa3721778f4656ca3c15bd9b3060f1176.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add VIRTIO_F_IN_ORDER feature support for the virtqueue_fill operation.

The goal of the virtqueue_ordered_fill operation when the
VIRTIO_F_IN_ORDER feature has been negotiated is to search for this
now-used element, set its length, and mark the element as filled in
the VirtQueue's used_elems array.

By marking the element as filled, it will indicate that this element has
been processed and is ready to be flushed, so long as the element is
in-order.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-4-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 98eb601b09..0000a7b41c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -872,6 +872,46 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vq->used_elems[idx].ndescs = elem->ndescs;
 }
 
+static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                                   unsigned int len)
+{
+    unsigned int i, steps, max_steps;
+
+    i = vq->used_idx % vq->vring.num;
+    steps = 0;
+    /*
+     * We shouldn't need to increase 'i' by more than the distance
+     * between used_idx and last_avail_idx.
+     */
+    max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
+
+    /* Search for element in vq->used_elems */
+    while (steps <= max_steps) {
+        /* Found element, set length and mark as filled */
+        if (vq->used_elems[i].index == elem->index) {
+            vq->used_elems[i].len = len;
+            vq->used_elems[i].in_order_filled = true;
+            break;
+        }
+
+        i += vq->used_elems[i].ndescs;
+        steps += vq->used_elems[i].ndescs;
+
+        if (i >= vq->vring.num) {
+            i -= vq->vring.num;
+        }
+    }
+
+    /*
+     * We should be able to find a matching VirtQueueElement in
+     * used_elems. If we don't, this is an error.
+     */
+    if (steps >= max_steps) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s cannot fill buffer id %u\n",
+                      __func__, vq->vdev->name, elem->index);
+    }
+}
+
 static void virtqueue_packed_fill_desc(VirtQueue *vq,
                                        const VirtQueueElement *elem,
                                        unsigned int idx,
@@ -922,7 +962,9 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
         return;
     }
 
-    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        virtqueue_ordered_fill(vq, elem, len);
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
         virtqueue_packed_fill(vq, elem, len, idx);
     } else {
         virtqueue_split_fill(vq, elem, len, idx);
-- 
MST


