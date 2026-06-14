Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95706CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBL-0002ez-9J; Sun, 14 Jun 2026 15:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBJ-0002Vv-0S
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBH-00021F-C8
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppGnyWYFuQsvcdkmPeeWCQHykpufEIZUSAGd/P4lOOM=;
 b=TaP5NPlq2zc2n/jTqx8S76VcONk8ccm3WArDB6QWnu7f0O4bNSY4iVNBv+91z/hET/2igv
 gf1SFUIMLOlBjJHVVCKLkCpb2FeM28OgxinsGA6jkJd8UNAgJKQwAQDTlE4fTrstoJQ9Bb
 nNOIF/zfwF7DT/IWrKXtkto0yZVW5/c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-pgu15-R0NN-xkUfs08_uyQ-1; Sun, 14 Jun 2026 15:07:36 -0400
X-MC-Unique: pgu15-R0NN-xkUfs08_uyQ-1
X-Mimecast-MFC-AGG-ID: pgu15-R0NN-xkUfs08_uyQ_1781464055
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490eca575d6so13640305e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464055; x=1782068855; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ppGnyWYFuQsvcdkmPeeWCQHykpufEIZUSAGd/P4lOOM=;
 b=hANvvyUiftTmxf33as8crOJ1i+6fqA5aJx1KWoc97PBn3zaLR3EUs5D7MKT5+aTuFj
 fZGO95c+LupZ6P6G4cTie3QHyiSTWMQtheju0K0JB7Fl1xnwWLPUp13avVCmriTjMWpe
 hYZm2v+S+8EsTTyGLPEZEZcRmIBwnsuKGtJoA9xxN6hdw0HpUJDlyq8zJ3k9fnH5WG4b
 IZxNH8r+w4Ds3VWVLnWQeF3BFqh9MFrLTBmmvMDco65RRDIbN3RaLqYjVenI1jlspAjb
 Tj8qOi8yYMXe6rvRlNzbDkamphkO4w7LgTwMFjjpoMVKqaH25SFqw4dlwG2tJNQdcQCz
 B/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464055; x=1782068855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppGnyWYFuQsvcdkmPeeWCQHykpufEIZUSAGd/P4lOOM=;
 b=tCTwefBbGXLL9FaEUXSOyxDOBCBFVwNlgh5sUqO26fNaCG47KKOPKxp0O0ASgI43D2
 /mc8CMUy1R/SDIiEKYftJA+D6VE7CB01EhV7M4kultRgikrV/uQHjsrOKflptVF/48W2
 by9KZMS8emgSogOYYuMZnvtg25fUciWxh5zcxlMfByrnrKYYZJry/kOLBIwsZ31/dnNp
 D1bhq7+uA+8DdYs9Fl1ZGaks0zr1J8BHyJL8yZYSRYB4QDffRqkagAM4NbG/Ey+/49fN
 sIGZXEhyzifiFnOmU4zwVP0jpEjCh+k54kVKaOygLpDXUmuaA0rZp5QcA2H1aZLsR6Vu
 fRoA==
X-Gm-Message-State: AOJu0YyDmUqgObnN9DjG1/u1YJtWcKiER5c/H6KMRXr7HhZH4kYY/l+z
 rpl/XBV0P/XIIdWDsePeKTjAb+E2bYMx9jSnXmM5MX/AKcVKnyFKJiCYx4bxhVM674N1hTMWH0i
 n77qxEVXbczp6isVV1W1M9s+Vjxy7CjVdWwiDH5s9lvaLRmmUTj3gqWMgmL3cQp9Db+Ic1r5+za
 tERG6pPsL+gfokJ9pRSkCpTrIcpbx7rw5ugw==
X-Gm-Gg: Acq92OGk6/7CtatKhZ00wvdeJy7OduxnRafad1NFTeIn3+kRdUhl9v579cJe5aBJN/e
 Xr3rb+LzmGbxGZBqs4Fh4e6EyLsKRYyRiXbf6bm+XYVokr6j0TkM5yqxaP+zgszEtuI5y5Cq9U8
 0fC1gHfZQxdZS1KehXpJuUxWfYVD5MZdQRWBPKgXMh/TSUq0G+74UICyNLBscEsOcIerpYaVbqd
 mlsIo8jITAaXBhm584th0MFTZejcOTHsp3yX25zVQ6gVvCXcPwd+NvCxim2+t15GvTLHfD3D5Pz
 fByChUQFp0seAL+590YOOtmIuHy0S5Uxb1A+5lpRAn0xi6Yq0ewjvqRpP1Tb5Ml9K/L9cmH9uNg
 xF1a/TiTbYt9nfU3U2kiIS+aGk9pKXFfycY8nwU5tgaM=
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id
 5b1f17b1804b1-490ec4d4f7cmr171822625e9.9.1781464054785; 
 Sun, 14 Jun 2026 12:07:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id
 5b1f17b1804b1-490ec4d4f7cmr171822215e9.9.1781464054221; 
 Sun, 14 Jun 2026 12:07:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b2e8esm170032745e9.0.2026.06.14.12.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:33 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 041/106] vhost: final refactoring of vhost vrings map/unmap
Message-ID: <4e61c89262aa7fad36df39daf5d7ab759079bd9a.1781463125.git.mst@redhat.com>
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

Introduce helper functions vhost_vrings_map() and
vhost_vrings_unmap() and use them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-16-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 89 +++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a3bf7e5a9b..c71b18cfc8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -489,6 +489,56 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
     *buffer = NULL;
 }
 
+static void vhost_vrings_unmap(struct vhost_dev *dev,
+                               struct vhost_virtqueue *vq, bool touched)
+{
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
+                       touched ? vq->used_size : 0);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
+                       touched ? vq->avail_size : 0);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0,
+                       touched ? vq->desc_size : 0);
+}
+
+static int vhost_vrings_map(struct vhost_dev *dev,
+                            struct VirtIODevice *vdev,
+                            struct vhost_virtqueue *vq,
+                            unsigned idx)
+{
+    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc = NULL;
+    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = NULL;
+    vq->used_size = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = NULL;
+
+    if (vq->desc_phys == 0) {
+        /* Queue might not be ready for start */
+        return 0;
+    }
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
+    if (!vq->desc) {
+        goto fail;
+    }
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
+    if (!vq->avail) {
+        goto fail;
+    }
+    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
+    if (!vq->used) {
+        goto fail;
+    }
+
+    return 1;
+
+fail:
+    vhost_vrings_unmap(dev, vq, false);
+    return -ENOMEM;
+}
+
 static int vhost_verify_ring_part_mapping(void *ring_hva,
                                           uint64_t ring_gpa,
                                           uint64_t ring_size,
@@ -1287,34 +1337,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = NULL;
-    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = NULL;
-    vq->used_size = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = NULL;
-
-    if (vq->desc_phys == 0) {
-        /* Queue might not be ready for start */
-        return 0;
-    }
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
-    if (!vq->desc) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
-    if (!vq->avail) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
-    if (!vq->used) {
-        r = -ENOMEM;
-        goto fail;
+    r = vhost_vrings_map(dev, vdev, vq, idx);
+    if (r <= 0) {
+        return r;
     }
 
     vq->num = state.num = virtio_queue_get_num(vdev, idx);
@@ -1375,9 +1400,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
+    vhost_vrings_unmap(dev, vq, false);
     return r;
 }
 
@@ -1424,9 +1447,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
+    vhost_vrings_unmap(dev, vq, true);
     return r;
 }
 
-- 
MST


