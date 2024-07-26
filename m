Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B7C49EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHjG-0006Zv-I5; Fri, 26 Jul 2024 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHjE-0006VM-BD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:59:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHjC-0006QB-FW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:59:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd640a6454so4895945ad.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721987949; x=1722592749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmvhoguNY49Nv0ZaQwQuOKqF+yUD8T+WptGtXxQNvDg=;
 b=egQMsNMGoyes+ocuDrIzA+kDbptR/Le8BrWsOY2p/kVR96ue2V8iJqG8q02hgxDWf5
 uDTu0Sq2/ECXd5v3fXTOCdp/WupU01MZ/P0Z9qPExDt4x08gLvBEzdPuGIuxzKBTRe4x
 OhQnQnkYBdbuO1eKaeUbROTSJKzvu9w5Y9PKMoLRfyCmh0ztwdoxuDDCjRxAkrSlHO+B
 6sIOexwbQDStk+FozcYTAkmiffew1x/yIav/2kR6R9pdRv5B+/THpZiQ3FpA0RRPyx4f
 nbPquqOmp7TsLOksmnBL4H/ba+mIch4cdEBsqH8hWLggbf8WGcT+bz6Mfyq1ljn685YS
 dbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721987949; x=1722592749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmvhoguNY49Nv0ZaQwQuOKqF+yUD8T+WptGtXxQNvDg=;
 b=mknVMg32ByuIIlLwNoZ7Ks21hdXJNRKfdvRSwkggNFa/FbifjyAdVY8KRJrGi6t4z+
 PdIY7/d8pTzPau3AkySIiKldAtjXNQ5CDQcTS4h4dFkNfEvJ0cl+wrNWIgXgk5xn0tVz
 nVeCDdGa2h/GL9F9fx7cmscyTMKSN/JfK5p/5FgMkN23ik6MBbq7QpMl+yYsG04QrNA8
 1uDogCBHPS8fehQQRqqBrJDVH13NOPm1SdBzU9+0R+DqJrIjA8zWz5FWAaRpplDRLv+X
 dhEQoWmsjbYZr/x9kVPXUbMVuoPb9kCYTjwrUSjJ3xLEBKwYwS28BryG8IMbKRgsIIAz
 /mFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW9E9Uz5fazM9IaWimcfW/Ut40qpGiyXEwVZhhD3/vbC6VPFI7OH0RbTuqrkeVDaYYYIp2zQqTkPaIwem5lSVNaz53O/Y=
X-Gm-Message-State: AOJu0Yy5NHLFNh5tUnhqpPeNsykVSToGFjAvmbqTdSyaAF+MvJlavJFP
 PU8QFyj4stZpq0Z/GBBM0u5C8DTXqrpsitoHYc6OKUbbCc2wIdjw5jXHhA==
X-Google-Smtp-Source: AGHT+IF9+qE1+lw0IniWiXck/zsEBoxre6XA92NP8il2cjzAeXrkhzhZrye6DYfvcQoCgoVv4Llldw==
X-Received: by 2002:a17:902:e746:b0:1fb:3037:f3a0 with SMTP id
 d9443c01a7336-1fed38a44ffmr8113205ad.32.1721987948865; 
 Fri, 26 Jul 2024 02:59:08 -0700 (PDT)
Received: from valdaarhun.. ([223.233.82.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fcd252sm28201655ad.285.2024.07.26.02.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:59:08 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v2 3/3] vhost: Allocate memory for packed vring.
Date: Fri, 26 Jul 2024 15:28:22 +0530
Message-ID: <20240726095822.104017-4-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726095822.104017-1-sahilcdq@proton.me>
References: <20240726095822.104017-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Allocate memory for the packed vq format and support
packed vq in the SVQ "start" operation.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v1 -> v2:
* vhost-shadow-virtqueue.h
  (struct VhostShadowVirtqueue): New member "is_packed"
  (vhost_svq_get_vring_addr): Renamed function.
  (vhost_svq_get_vring_addr_packed): New function.
  (vhost_svq_memory_packed): Likewise.
* vhost-shadow-virtqueue.c:
  (vhost_svq_add): Use "is_packed" to check vq format.
  (vhost_svq_get_vring_addr): Rename function.
  (vhost_svq_get_vring_addr_packed): New function but is yet to be implemented.
  (vhost_svq_memory_packed): New function.
  (vhost_svq_start): Support packed vq format.
* vhost-vdpa.c
  (vhost_svq_get_vring_addr): Rename function.
  
  
 hw/virtio/vhost-shadow-virtqueue.c | 70 ++++++++++++++++++++++--------
 hw/virtio/vhost-shadow-virtqueue.h | 10 ++++-
 hw/virtio/vhost-vdpa.c             |  4 +-
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index c7b7e0c477..045c07304c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -343,7 +343,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -ENOSPC;
     }
 
-    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (svq->is_packed) {
         ok = vhost_svq_add_packed(svq, out_sg, out_num,
                                   in_sg, in_num, &qemu_head);
     } else {
@@ -679,18 +679,29 @@ void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)
 }
 
 /**
- * Get the shadow vq vring address.
+ * Get the split shadow vq vring address.
  * @svq: Shadow virtqueue
  * @addr: Destination to store address
  */
-void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
-                              struct vhost_vring_addr *addr)
+void vhost_svq_get_vring_addr_split(const VhostShadowVirtqueue *svq,
+                                    struct vhost_vring_addr *addr)
 {
     addr->desc_user_addr = (uint64_t)(uintptr_t)svq->vring.desc;
     addr->avail_user_addr = (uint64_t)(uintptr_t)svq->vring.avail;
     addr->used_user_addr = (uint64_t)(uintptr_t)svq->vring.used;
 }
 
+/**
+ * Get the packed shadow vq vring address.
+ * @svq: Shadow virtqueue
+ * @addr: Destination to store address
+ */
+void vhost_svq_get_vring_addr_packed(const VhostShadowVirtqueue *svq,
+                                     struct vhost_vring_addr *addr)
+{
+    /* TODO */
+}
+
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
 {
     size_t desc_size = sizeof(vring_desc_t) * svq->vring.num;
@@ -707,6 +718,16 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
     return ROUND_UP(used_size, qemu_real_host_page_size());
 }
 
+size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
+{
+    size_t desc_size = sizeof(struct vring_packed_desc) * svq->num_free;
+    size_t driver_event_suppression = sizeof(struct vring_packed_desc_event);
+    size_t device_event_suppression = sizeof(struct vring_packed_desc_event);
+
+    return ROUND_UP(desc_size + driver_event_suppression + device_event_suppression,
+                    qemu_real_host_page_size());
+}
+
 /**
  * Set a new file descriptor for the guest to kick the SVQ and notify for avail
  *
@@ -759,19 +780,34 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->vq = vq;
     svq->iova_tree = iova_tree;
 
-    svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
-    svq->num_free = svq->vring.num;
-    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
-    desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
-    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
-    svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    svq->desc_next = g_new0(uint16_t, svq->vring.num);
-    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+        svq->is_packed = true;
+        svq->vring_packed.vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
+        svq->num_free = svq->vring_packed.vring.num;
+        svq->vring_packed.vring.desc = mmap(NULL, vhost_svq_memory_packed(svq),
+                                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                                            -1, 0);
+        desc_size = sizeof(struct vring_packed_desc) * svq->vring.num;
+        svq->vring_packed.vring.driver = (void *)((char *)svq->vring_packed.vring.desc + desc_size);
+        svq->vring_packed.vring.device = (void *)((char *)svq->vring_packed.vring.driver +
+                                                  sizeof(struct vring_packed_desc_event));
+    } else {
+        svq->is_packed = false;
+        svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
+        svq->num_free = svq->vring.num;
+        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                               -1, 0);
+        desc_size = sizeof(vring_desc_t) * svq->vring.num;
+        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
+                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                               -1, 0);
+    }
+
+    svq->desc_state = g_new0(SVQDescState, svq->num_free);
+    svq->desc_next = g_new0(uint16_t, svq->num_free);
+    for (unsigned i = 0; i < svq->num_free - 1; i++) {
         svq->desc_next[i] = cpu_to_le16(i + 1);
     }
 }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ee1a87f523..b396daf57d 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -67,6 +67,9 @@ struct vring_packed {
 
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
+    /* True if packed virtqueue */
+    bool is_packed;
+
     /* Virtio queue shadowing */
     VirtQueue *vq;
 
@@ -146,10 +149,13 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
 
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
-void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
-                              struct vhost_vring_addr *addr);
+void vhost_svq_get_vring_addr_split(const VhostShadowVirtqueue *svq,
+                                    struct vhost_vring_addr *addr);
+void vhost_svq_get_vring_addr_packed(const VhostShadowVirtqueue *svq,
+                                     struct vhost_vring_addr *addr);
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
+size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq);
 
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..688de4a662 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1130,7 +1130,7 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
     struct vhost_vdpa *v = dev->opaque;
     struct vhost_vring_addr svq_addr;
 
-    vhost_svq_get_vring_addr(svq, &svq_addr);
+    vhost_svq_get_vring_addr_split(svq, &svq_addr);
 
     vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
 
@@ -1189,7 +1189,7 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     size_t avail_offset;
     bool ok;
 
-    vhost_svq_get_vring_addr(svq, &svq_addr);
+    vhost_svq_get_vring_addr_split(svq, &svq_addr);
 
     driver_region = (DMAMap) {
         .translated_addr = svq_addr.desc_user_addr,
-- 
2.45.2


