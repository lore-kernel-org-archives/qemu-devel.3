Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BE7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCl-0007Dg-64; Sun, 14 Jun 2026 15:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCZ-000763-5D
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCX-0002N5-Hq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqyz/+ku0gzWEAFCgZbWuwwj2nCCgyC/ph/YGtDa7co=;
 b=DXqdh+VdM/4VELxMe47W0nnROjyLuHmgW9qxcXYrP9tFem8fehzvQZPDvQ3Et9Fg8yxzcr
 5LvBobfpSQEV77CyEAiaRDJAVRsCerlqfHrgc1RmZkZovtRNoGYvURwozkakF+z47lslmn
 lGZdfotbV+pby1awmlXz7XqDvHLcNRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-aCSY7b1PNWKcR8RGFkLvlw-1; Sun, 14 Jun 2026 15:08:53 -0400
X-MC-Unique: aCSY7b1PNWKcR8RGFkLvlw-1
X-Mimecast-MFC-AGG-ID: aCSY7b1PNWKcR8RGFkLvlw_1781464133
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so22237485e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464132; x=1782068932; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eqyz/+ku0gzWEAFCgZbWuwwj2nCCgyC/ph/YGtDa7co=;
 b=GtEd+dcL3dxeioJ5o0PysQSQiVOJZIdT0DfgTsW78quu8fRxNO+7lxF2azLo/CkVbc
 N9qYyGW4xSDUlcn1Q/pwyn4A46g/1fd/BAS59w3Slq5c9Wf36aR68MZV+xmv+p70CkKh
 oH4oknpDkwIX7w8wp/7dq8D7Rz1tttU4XUIrqHkOFsPfUUdWFnLniV/5PRTYvbbN7FHs
 t0/nM6avgxT/b6Yn/XzEdoJnag0dXZGd2lNaYTPbIx1QvdJ3ZSd+kkxIXyXatz6fCZ/t
 aiXrIGYgubiqoYsBxI31bQNhiIhcKt748tnX8Vwmd67RYgcx143fRAFoFmISXdWmlQgB
 z0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464132; x=1782068932;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqyz/+ku0gzWEAFCgZbWuwwj2nCCgyC/ph/YGtDa7co=;
 b=PTHDKKV4+w8PvY+zFa5PsuR66mzW3+NxcwLwirgOZCCjh/Q42+hFEF4gl3J658Ehm/
 vMHeduyW83lN7sej7I+OSVnE0NIki/4j96w4wng39IN6kDj5a9WnMg1Jp7Kq3Za2QBhT
 5ctTkY0CasLBY1zfb9rah3uUA6HkamWknAZwE/rbzTbhA6pZkcFH5p0sUeHUbx0+ZMlM
 h4TE9fnWIikTDoo53HzFF1GoOY3Bj4V8VrDpq3cV9hKBndV/jDbbeKzA7hVJn98rUca/
 A9bWC8NySzBzUwWsy+2ybAe+buSON0WNg/N739U1cLdF+26EzWYznczBhMJfbMcpDT5E
 HO7w==
X-Gm-Message-State: AOJu0YyqedPYR3v8ZAC1QgFhSFWxyz0dS8gdBlFwy2QCe8vraKyf8tKL
 33jngx2Grh7LINoYvJrYzzfPdIykyV1kwHK2wZl2TpJoKAPqA2ixCVqgxH+G6Ga7ykwDVGaXNRs
 jV6plfbUxakRpjsI1Oo7IWWv3WZWJ4BzLbFIrIMiPcKSaSu4RZxgbWepNHsa9MULeEzGO3E5Flf
 O54ntQxpVbSDuva+I78Er7kCdBZDKGk3oXXw==
X-Gm-Gg: Acq92OFuacOoJJl0hAuR4XrSoqId/4Z0zn33pjAPcfKAZYXmlmCZp4MYgH6UCSIoMPE
 d78vtMAeYyqlkM4IqbGDbSrDjWGsWD/iJA0HOTDo8G3WgkmRXRnkMptX/4oW5jLS4CJfQXJgX2g
 uWOfsc8IaFROv758InUjGv4vegNB0au1ziPvYV6pk/lNlPINDFndL1OYI9IzlI8SiybxjgWuJvd
 3n5xWXAMRV0+G/Kc9xEu0q6zz/dUnFpsbx7d6u9Xpo6a3RzHmDAARqh9W43rFdCBSNUlGtNxhG6
 XxUMaBbbW3GN6hByo0Yo/IAtsvmtn6HkultevBuOdPfO9GB4TMj+cT3y5CzjRoxTvoYfD3sRyRT
 8OcCGzxEDn88qCFAKzblDBqXx367Csfx2JAlmx9d+nxQ=
X-Received: by 2002:a05:600c:314a:b0:490:e1a6:261 with SMTP id
 5b1f17b1804b1-490ec5092c8mr137629995e9.26.1781464132450; 
 Sun, 14 Jun 2026 12:08:52 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:e1a6:261 with SMTP id
 5b1f17b1804b1-490ec5092c8mr137629715e9.26.1781464131914; 
 Sun, 14 Jun 2026 12:08:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d2449sm168799475e9.14.2026.06.14.12.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 073/106] vhost: move svq next desc array to descs state struct
Message-ID: <927d0beaad0ac6db96865a96fdad0c1a93b3477d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's the right place for it as it is part of the descriptor state.  We
save the memory management of the array, and make the code changes of
the next patches easier.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-3-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 14 ++++++--------
 hw/virtio/vhost-shadow-virtqueue.h | 12 ++++++------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 6242aeb69c..901253d06e 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -175,7 +175,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     for (n = 0; n < num; n++) {
         if (more_descs || (n + 1 < num)) {
             descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
-            descs[i].next = cpu_to_le16(svq->desc_next[i]);
+            descs[i].next = cpu_to_le16(svq->desc_state[i].next);
         } else {
             descs[i].flags = flags;
         }
@@ -183,10 +183,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = svq->desc_next[i];
+        i = svq->desc_state[i].next;
     }
 
-    svq->free_head = svq->desc_next[last];
+    svq->free_head = svq->desc_state[last].next;
     return true;
 }
 
@@ -432,7 +432,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = svq->desc_next[i];
+        i = svq->desc_state[i].next;
     }
 
     return i;
@@ -473,7 +473,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
     last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
-    svq->desc_next[last_used_chain] = svq->free_head;
+    svq->desc_state[last_used_chain].next = svq->free_head;
     svq->free_head = used_elem.id;
     svq->num_free += num;
 
@@ -705,9 +705,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_next[i] = i + 1;
+        svq->desc_state[i].next = i + 1;
     }
 }
 
@@ -744,7 +743,6 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
         virtqueue_unpop(svq->vq, next_avail_elem, 0);
     }
     svq->vq = NULL;
-    g_free(svq->desc_next);
     g_free(svq->desc_state);
     munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..f52c33e650 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -23,6 +23,12 @@ typedef struct SVQDescState {
      * guest's
      */
     unsigned int ndescs;
+
+    /*
+     * Backup next field for each descriptor so we can recover securely, not
+     * needing to trust the device access.
+     */
+    uint16_t next;
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
@@ -84,12 +90,6 @@ typedef struct VhostShadowVirtqueue {
     /* Next VirtQueue element that guest made available */
     VirtQueueElement *next_guest_avail_elem;
 
-    /*
-     * Backup next field for each descriptor so we can recover securely, not
-     * needing to trust the device access.
-     */
-    uint16_t *desc_next;
-
     /* Caller callbacks */
     const VhostShadowVirtqueueOps *ops;
 
-- 
MST


