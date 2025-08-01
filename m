Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526EFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnk-00083F-Hb; Fri, 01 Aug 2025 10:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh5-0005Fw-Lw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh3-0002bn-EA
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2fXDBh7v5VnR+irN7nreOzDML4kDrz0mNn1ykyGvPY=;
 b=C8hekotukoYPZ7sJSliVOnlClPsHVrkEml4verL/Zd8+W5q3mYdS82HjhVdJU02McdRldR
 VqNejWkwc7WsOhFN3A4t/m7/W3Bc+qBLSfKfSGVBgqli+TkF/NXqDHDiBcLecoeeokpO3S
 bUfKhGD9PRM8l0heCpxUuIh82IpqGjY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-s-9u01c7OK-nDF5Zfh8taw-1; Fri, 01 Aug 2025 10:25:07 -0400
X-MC-Unique: s-9u01c7OK-nDF5Zfh8taw-1
X-Mimecast-MFC-AGG-ID: s-9u01c7OK-nDF5Zfh8taw_1754058306
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b79629bd88so823724f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058306; x=1754663106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2fXDBh7v5VnR+irN7nreOzDML4kDrz0mNn1ykyGvPY=;
 b=NTtAVLCnrjynO7B1YU+63ExmGc1Uunldm5alaRucBoFWPmWtxdj7b6b5J8tbwBBYXy
 sXmSodRpTftjYHxj88wyUp0B7URE7ip9tgzC0GM09oHcJh9M//ei0p9rsFFZ1T+2Zxx2
 PAEuXasFYcxavan03yY6wCGEmDs7e+lA+aKj5TPtVf+E1RVdq92CC78D5VD32CdYBbeR
 TjGMYu6de10c5CCURFXu7HZStIjv6T+3wDmFp1OYD3c2H5CIDCtkC1uFOM0K9yflmFX4
 YwjAaEfFh16v8vtrQxWbNLGqV/eSeGHnpqkqv+am2tFd1StjaMNG50rplbum8BYTBY2e
 QEuw==
X-Gm-Message-State: AOJu0YwRMijqzwIcC/MDZRwg+KFBT6iRXUx8JmBC+Li0rVu8R4yK887Z
 yGcdWtWgFhb0OVsTRIGQ7G0zMGKx+jT4tA9074cenumk7uFJjd0WrVZq/EohOuV63j+7ZkXqpNg
 90DdMReVaMR79ITAPU8ezRYqcIDpzMMX+10QH25bDigdRj7DvonPQovlcc/Rcms/WVle4FZq+EN
 TOoOwHw7kTS2+XTMjCnhW314gFbMPpOacOBQ==
X-Gm-Gg: ASbGnctObWuwYBhCz0R33R8tNsL217olgJWxtI0zW1pO40IoF/VgCLx+7jELEcch2PE
 8Lx8EmcaT50i4ZNU363beO7tXSgvDClYL3Bi6Be7P+Au6So2VMpNJ585oQX9zU8SG+EKDxK9YnM
 ZaTmGxwszRMA+6J6RfbsUy+HKD+pGhkh/zX4Ji3W45u6S9rB8FjCw1ZUZggCnTmBGpoNJ8xqOjI
 lYhBOyUwSjPpGOTsMCL5aWyVbmcRh4lgC+PlMEunInUUZWjiiHfSJgv60Jp6Grrkbd00po2NZKy
 bBrlSun3l44jpDJlStw/61NzIHWHix/L
X-Received: by 2002:a05:6000:2013:b0:3b8:d0bb:7554 with SMTP id
 ffacd0b85a97d-3b8d3439fb4mr2277385f8f.7.1754058305572; 
 Fri, 01 Aug 2025 07:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr1wbffHADjcEsaiRas93wMWBrClYypLAph0BYQsXSdznquF98DA7JSpXkqG7CLJ/BH1Ob3A==
X-Received: by 2002:a05:6000:2013:b0:3b8:d0bb:7554 with SMTP id
 ffacd0b85a97d-3b8d3439fb4mr2277352f8f.7.1754058305045; 
 Fri, 01 Aug 2025 07:25:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm115157985e9.25.2025.08.01.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:04 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 terrynini <terrynini38514@gmail.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/17] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
Message-ID: <6fcf5ebafad65adc19a616260ca7dc90005785d1.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit b44135daa372 introduced virtqueue_ordered_fill for
VIRTIO_F_IN_ORDER support but had a few issues:

* Conditional while loop used 'steps <= max_steps' but should've been
  'steps < max_steps' since reaching steps == max_steps would indicate
  that we didn't find an element, which is an error. Without this
  change, the code would attempt to read invalid data at an index
  outside of our search range.

* Incremented 'steps' using the next chain's ndescs instead of the
  current one.

This patch corrects the loop bounds and synchronizes 'steps' and index
increments.

We also add a defensive sanity check against malicious or invalid
descriptor counts to avoid a potential infinite loop and DoS.

Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
Reported-by: terrynini <terrynini38514@gmail.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250721150208.2409779-1-jonah.palmer@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2ab1d20769..9a81ad912e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -938,18 +938,18 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
 static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
                                    unsigned int len)
 {
-    unsigned int i, steps, max_steps;
+    unsigned int i, steps, max_steps, ndescs;
 
     i = vq->used_idx % vq->vring.num;
     steps = 0;
     /*
-     * We shouldn't need to increase 'i' by more than the distance
-     * between used_idx and last_avail_idx.
+     * We shouldn't need to increase 'i' by more than or equal to
+     * the distance between used_idx and last_avail_idx (max_steps).
      */
     max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
 
     /* Search for element in vq->used_elems */
-    while (steps <= max_steps) {
+    while (steps < max_steps) {
         /* Found element, set length and mark as filled */
         if (vq->used_elems[i].index == elem->index) {
             vq->used_elems[i].len = len;
@@ -957,8 +957,18 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
             break;
         }
 
-        i += vq->used_elems[i].ndescs;
-        steps += vq->used_elems[i].ndescs;
+        ndescs = vq->used_elems[i].ndescs;
+
+        /* Defensive sanity check */
+        if (unlikely(ndescs == 0 || ndescs > vq->vring.num)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s invalid ndescs %u at position %u\n",
+                          __func__, vq->vdev->name, ndescs, i);
+            return;
+        }
+
+        i += ndescs;
+        steps += ndescs;
 
         if (i >= vq->vring.num) {
             i -= vq->vring.num;
-- 
MST


