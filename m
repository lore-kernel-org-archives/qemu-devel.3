Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A53C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDD9-0002kn-Hs; Tue, 23 Jul 2024 06:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDD5-0001zd-2N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDD2-0001sw-RM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qh9R5tJPsU6nQaE9x9stYdkZI3361sYm/2KiRgpRciY=;
 b=DB7B4Gjwk0ntAzqJC0vFgXXe1bD2LnE+Y5FKAzbrB4tJyTImnlL8/wGv5oXrLqJee7hMz8
 93Vv1kipt81tM3WaXgVfrrVhgyfaZFFDd6SBNCML863gJVolW+iqM708vv8aYxgnEZv7qM
 ycb3rJExRJy0HNN3BI4GybvHmmkB9oU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-_zXZJW8qNFKqBFN-AonMSg-1; Tue, 23 Jul 2024 06:57:28 -0400
X-MC-Unique: _zXZJW8qNFKqBFN-AonMSg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a25d0755f3so3236057a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732247; x=1722337047;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qh9R5tJPsU6nQaE9x9stYdkZI3361sYm/2KiRgpRciY=;
 b=dGgXCUkjxH3+enAoZDsxA8r4JYfEolKpDZH0tu/aNiRIxiZiivGMEcUh0XQFLpjgrs
 wLi9z/bkNi43AOcAwGSY8rR8KV/4eJqm8f/HAuj/4dCrWd80pAvE5CtLQ4H47NcoUJQr
 9RHXDKd160IZNCedSO0Tniq59woa+H8ikp35LFiuir/RNGsK5nM5GH13h3szzHuFuJ00
 +KeQsdRO85OV0y2BabBWjtHrliZK1htfDBd5rXwYoO2kUpbzUWoi3fWv+r0ewXeVRjXC
 4nLkEZHLqCyzR5EOIoym+UbM/GPU0pCfchH6SDfAlJguZJ0HsKMWI/eI91Ewp20+Rzoz
 uoSw==
X-Gm-Message-State: AOJu0YzplaYcnknuXoZQmpW2piIbVDQJq/aI1jFo1A5pG6k4T8TvjakD
 /UgJ32LcR+IFkZMkmq88hAn237fYO6370SyDfKsTo50E/6wyq5/hNDlrhC/wzwXz8NT8yQNIeh4
 3hDfJLbMmldA2TCE31+8ZZE19M98iMtzVfKJvCtuSr/btIwBwhNwiJoogRfMWHzqJ0Lh83w0yoY
 DGwXaNlQHZQmVqcGdudkcMLKe/Mri2pw==
X-Received: by 2002:a05:6402:3546:b0:5a2:1f7b:dffa with SMTP id
 4fb4d7f45d1cf-5a941a3b8efmr2343590a12.3.1721732247224; 
 Tue, 23 Jul 2024 03:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpfts+xPIp1bMaRTQsfI3VQT9rHvUAt79xd2cpBbDz9kAKi1U+YS1AYWowlYiTHFtKDyTG8Q==
X-Received: by 2002:a05:6402:3546:b0:5a2:1f7b:dffa with SMTP id
 4fb4d7f45d1cf-5a941a3b8efmr2343553a12.3.1721732246195; 
 Tue, 23 Jul 2024 03:57:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f86d1sm7280295a12.73.2024.07.23.03.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:25 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 25/61] virtio: virtqueue_ordered_flush - VIRTIO_F_IN_ORDER
 support
Message-ID: <844619147c5110f335cbbbad51cda6a898c7ef33.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add VIRTIO_F_IN_ORDER feature support for the virtqueue_flush operation.

The goal of the virtqueue_ordered_flush operation when the
VIRTIO_F_IN_ORDER feature has been negotiated is to write elements to
the used/descriptor ring in-order and then update used_idx.

The function iterates through the VirtQueueElement used_elems array
in-order starting at vq->used_idx. If the element is valid (filled), the
element is written to the used/descriptor ring. This process continues
until we find an invalid (not filled) element.

For packed VQs, the first entry (at vq->used_idx) is written to the
descriptor ring last so the guest doesn't see any invalid descriptors.

If any elements were written, the used_idx is updated.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/virtio.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0000a7b41c..397c261c3c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1023,6 +1023,73 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
     }
 }
 
+static void virtqueue_ordered_flush(VirtQueue *vq)
+{
+    unsigned int i = vq->used_idx % vq->vring.num;
+    unsigned int ndescs = 0;
+    uint16_t old = vq->used_idx;
+    uint16_t new;
+    bool packed;
+    VRingUsedElem uelem;
+
+    packed = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED);
+
+    if (packed) {
+        if (unlikely(!vq->vring.desc)) {
+            return;
+        }
+    } else if (unlikely(!vq->vring.used)) {
+        return;
+    }
+
+    /* First expected in-order element isn't ready, nothing to do */
+    if (!vq->used_elems[i].in_order_filled) {
+        return;
+    }
+
+    /* Search for filled elements in-order */
+    while (vq->used_elems[i].in_order_filled) {
+        /*
+         * First entry for packed VQs is written last so the guest
+         * doesn't see invalid descriptors.
+         */
+        if (packed && i != vq->used_idx) {
+            virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
+        } else if (!packed) {
+            uelem.id = vq->used_elems[i].index;
+            uelem.len = vq->used_elems[i].len;
+            vring_used_write(vq, &uelem, i);
+        }
+
+        vq->used_elems[i].in_order_filled = false;
+        ndescs += vq->used_elems[i].ndescs;
+        i += vq->used_elems[i].ndescs;
+        if (i >= vq->vring.num) {
+            i -= vq->vring.num;
+        }
+    }
+
+    if (packed) {
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[vq->used_idx], 0, true);
+        vq->used_idx += ndescs;
+        if (vq->used_idx >= vq->vring.num) {
+            vq->used_idx -= vq->vring.num;
+            vq->used_wrap_counter ^= 1;
+            vq->signalled_used_valid = false;
+        }
+    } else {
+        /* Make sure buffer is written before we update index. */
+        smp_wmb();
+        new = old + ndescs;
+        vring_used_idx_set(vq, new);
+        if (unlikely((int16_t)(new - vq->signalled_used) <
+                     (uint16_t)(new - old))) {
+            vq->signalled_used_valid = false;
+        }
+    }
+    vq->inuse -= ndescs;
+}
+
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
     if (virtio_device_disabled(vq->vdev)) {
@@ -1030,7 +1097,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
-    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        virtqueue_ordered_flush(vq);
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
         virtqueue_packed_flush(vq, count);
     } else {
         virtqueue_split_flush(vq, count);
-- 
MST


