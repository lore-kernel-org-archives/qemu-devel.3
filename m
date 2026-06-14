Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E3CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBJ-0002Wz-DR; Sun, 14 Jun 2026 15:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqB4-0002Dt-Bd
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqB2-0001wk-Pz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xn6dFnmNSImHX8MQYTUhlfN05kv5iWMDypR6RoZj2Dw=;
 b=V3+txAAcQJU0DirXIzbUMVoHV/CEvcDaRjrJ78AnR8Uq/86WTNJ/KFtS8B9LANe0nAiiCM
 ZGQq0ccHU3fVdtD3gw2tkQYbQsfDsgcVfFv1oSUdXIFvp9l53ObUXF09PN6c0FYDhczQ4e
 w5q26ebnbRTxZ2mVuTTzzErxtDy3c5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-pjWyFF_9P-ySOhhDqfgibw-1; Sun, 14 Jun 2026 15:07:22 -0400
X-MC-Unique: pjWyFF_9P-ySOhhDqfgibw-1
X-Mimecast-MFC-AGG-ID: pjWyFF_9P-ySOhhDqfgibw_1781464042
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490dad70f95so23922755e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464041; x=1782068841; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xn6dFnmNSImHX8MQYTUhlfN05kv5iWMDypR6RoZj2Dw=;
 b=IvYAYNDlKWFxtcEOI7cybaFjSmWwTZkAHjESCdY43r7ve3D7vl/B0Z5TVh7uYhYZkc
 q/ZDT6qsALwRHVKF5M3OZ57K+t9LW7ITg7oKXsQ7gwhMdRtEuQ+xpGPnwlsV1flYvyKA
 I88oNmHJsiefZBosBSiST9Y/1mIfooV7WgGyzMxBAv++s778sqsKIEc5+WSOYKzQ2Zww
 0QkHXu6AyApMqR8lL0hx79EWV1hsg130yzuzsrL4PNBFHiEOqloMI7+AeGCbMNsEh+QQ
 uXBKyW+rO1c2FFMvxdx+8TZ0+/nahufTix7feJAaowFEusU/plpA0QxF0+UeSmBbL1Km
 fSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464041; x=1782068841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xn6dFnmNSImHX8MQYTUhlfN05kv5iWMDypR6RoZj2Dw=;
 b=Wl89YjUzDnI0+P+ufiId7rTVmRe3DxC+7sN7uWb5p1kMjHbn4ChctL0v4sfkidu7xV
 LTUZZhIu0lYTg3iR/jvpMOQtPCPuvyTl5ERn+iJ5jeTD8FC6CXUvpUk1lyiwydbjVY8Z
 sA+tuRPOvq3suOqbcMS4o/BWPIK+SnSigZ9ZYkj+M2Etom8JX1TaKfqedI/Kx0wbdpG0
 9di+6qruzqUO67p75MA4YTw6EmN7JqKhgZpQhL4TRp6WnsPOmBwZdrYd1VJN1C4doACh
 hd5Nq7bBi/1FmAqhdNlXQInNH8jXTmAlWZBAJ1g4xKJu8meJNz9qOrjdkIXzjaeHRc/w
 MA2Q==
X-Gm-Message-State: AOJu0Yxdu95XYsaKXAZdjto7aMHXIvoMokXTS9nLp0/Z9cBScCebmSFt
 KjOFOFnAOj2jJJ5Qd+dvVQpVjq2KS6rDDEGPkBej4SQaf/dVx3GzMGYf9FFf2lkMklLpR2uFNYO
 /7wobrMO0P5hzOb164F06wH9Z/SjvkyHPqhST+aGbGLGD0Yn7NR4nlw91Fxanm0WL60V2VyZy9J
 vPxcSY2c1FhSX9l2XfnEwYEPnfBseCD6VSmA==
X-Gm-Gg: Acq92OFwiOkNjYfYEjWtiXZK65L5KOzrQIedoObJXtMkTC0mmRFYr4fXYdfZ3cGx82r
 R1nG1s0aX1IX9GXDborXlGe9KniBlkZ2dRrdNRWWTDKiQ7snmZ0XbYWH8vRNrO+chJUGaX+pTIO
 BZJaX6XCTJDf+5j3WRZvoLGSeXY7QvPzz8SRxhrU4uF/PJGRfs5DvzfPYukyxziPzu+FyhZc8N4
 Jjvr8MDo4Gxk9b9yQw5MqG0Iq9Qnfir2k9wS+WY9Ku/TEGGauh7Ha31L56bzxdJ2IZmp21GoSae
 fY19cjc2hHAmROkiRSQBFCc/LG+hXDZItq5y4SXa1pn1b4Ijluy8HVKvl9Iu3FZwzMqoBG2zf2i
 FZwqG/pPXa6anLjih8i/3kKr1dyPCqzSx2kFjKpfcfMk=
X-Received: by 2002:a05:600c:3583:b0:490:5466:8591 with SMTP id
 5b1f17b1804b1-490ec4e74dbmr177416215e9.12.1781464041566; 
 Sun, 14 Jun 2026 12:07:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3583:b0:490:5466:8591 with SMTP id
 5b1f17b1804b1-490ec4e74dbmr177415835e9.12.1781464041083; 
 Sun, 14 Jun 2026 12:07:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220308f13sm193020055e9.5.2026.06.14.12.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:19 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 036/106] vhost: vhost_virtqueue_start(): fix failure path
Message-ID: <c85f42703df6249452ca249bddbfb0eaa5a11c5c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We miss call to unmap in cases when vhost_memory_map() returns
lenght less than requested (still we consider such cases as an
error). Let's fix it in vhost_memory_map().

Fixes: c471ad0e9b ("vhost_net: device IOTLB support")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-11-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e39e0676e0..131a2fbf87 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -454,11 +454,20 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-                              hwaddr *plen, bool is_write)
+                              hwaddr len, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
-                                 MEMTXATTRS_UNSPECIFIED);
+        hwaddr mapped_len = len;
+        void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
+                                      is_write, MEMTXATTRS_UNSPECIFIED);
+        if (!res) {
+            return NULL;
+        }
+        if (len != mapped_len) {
+            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
+            return NULL;
+        }
+        return res;
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -1312,22 +1321,22 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     l = vq->desc_size;
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, &l, false);
-    if (!vq->desc || l != vq->desc_size) {
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
+    if (!vq->desc) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
 
     l = vq->avail_size;
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, &l, false);
-    if (!vq->avail || l != vq->avail_size) {
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
+    if (!vq->avail) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
 
     l = vq->used_size;
-    vq->used = vhost_memory_map(dev, vq->used_phys, &l, true);
-    if (!vq->used || l != vq->used_size) {
+    vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
+    if (!vq->used) {
         r = -ENOMEM;
         goto fail_alloc_used;
     }
-- 
MST


