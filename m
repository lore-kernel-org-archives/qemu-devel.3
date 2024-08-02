Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC8FC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqMl-0007Qa-3h; Fri, 02 Aug 2024 07:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMh-0007Ll-Fc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMf-0007Ah-6f
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so22722025ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722597747; x=1723202547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y82r/XxOIkgx1ODHTsgWMJ/HRE9njRvzy0BrWUZyvFU=;
 b=ZGI07wNyTCn1r70xDZC8f82n/RzdPjDbGBiN1AU1Sxb58s80l7SdqPvpa3fli0jRDa
 ZyaCpookPH12b9c3jF6eli+3fjCh0XC3RhSkXdGkE6pkt5liaCMP8aXo5oNyqd0ajeNd
 0PNl20cbM1YbTIZALMJ/NmO81PFM8sh0AArS0DeO/CAoOSUPiw44K8/BspcD/lWRvkqn
 7nxOwkBAj8OAJek+E0NrzHydRos0wJK1FRxAOjmA7/A9sSukDevtrb0yuy/tl9VTv35M
 mO8gIPiV4OqvcYNbG215WamvjKzD4cVuNxMg8OSKjRNODe+rBv5N2Hli1qbDtyHTMyAq
 jCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597747; x=1723202547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y82r/XxOIkgx1ODHTsgWMJ/HRE9njRvzy0BrWUZyvFU=;
 b=tExFGnTLNcKCwL+lUVkad7th6Z7BLRwdZNJwNY8RMz/td0y/bMNdCm/OeDYmZh2aip
 OJU0S6xO8HD8wcyOfb9X+A5NpnIi24m7S4YkDUD7vSwkBHdfQ+L5lVB+hD9SHOJyB0Fo
 czvSlrL9Huq0plqd5TBE8s12tj0WCqOrxinRpRMexcKIDHekCYDI2ZF/Wmnvp8wRJVP3
 5MpXVcSL8im9saIQbkdVWS1/rVkc2NYbwjJJvRdqcEoLnBKjpqCohlK+pOWpbK3X3cH6
 HyUa5oRg3/R58SPPSC/REd5d3iQCTqpv7pWW6vuwlYIyNCyLkg+V5lCMRgd7TwR0Wp5j
 hxFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeV+NbInFt8DJYhfOOJLH28JK054FLDZ4vE00adhQmc17hVHFezn6PxPqIhyezMgRU4JlfslElyUN+YPuTzUZRzriVhxQ=
X-Gm-Message-State: AOJu0Yx+dDPYFf0f+h0qdR0o4enLNF3kHGSIADulJ8Jba7a4xhSqFiQK
 +KqLhiMD+JXDof1iRMbex2BR0VpsIlI37lkjrg2xcO0Rb7ZKFrlehoP5+g==
X-Google-Smtp-Source: AGHT+IEjKKuG/jOVKz0Pj/NChouyUQS/lojdEBLOojX6hs/DyhiHWXBnvRw81UxmzYr1f1LWIXFPIA==
X-Received: by 2002:a17:903:2443:b0:1fd:cda0:77fd with SMTP id
 d9443c01a7336-1ff523ef645mr68374335ad.3.1722597746042; 
 Fri, 02 Aug 2024 04:22:26 -0700 (PDT)
Received: from valdaarhun.. ([223.233.85.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ae4esm14801335ad.269.2024.08.02.04.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:22:25 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, icegambit91@gmail.com,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Fri,  2 Aug 2024 16:51:38 +0530
Message-ID: <20240802112138.46831-4-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802112138.46831-1-sahilcdq@proton.me>
References: <20240802112138.46831-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62a.google.com
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
packed vq in the SVQ "start" and "stop" operations.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v2 -> v3:
* vhost-shadow-virtqueue.c
  (vhost_svq_memory_packed): New function
  (vhost_svq_start):
  - Remove common variables out of if-else branch.
  (vhost_svq_stop):
  - Add support for packed vq.
  (vhost_svq_get_vring_addr): Revert changes
  (vhost_svq_get_vring_addr_packed): Likwise.
* vhost-shadow-virtqueue.h
  - Revert changes made to "vhost_svq_get_vring_addr*"
    functions.
* vhost-vdpa.c: Revert changes.

 hw/virtio/vhost-shadow-virtqueue.c | 56 +++++++++++++++++++++++-------
 hw/virtio/vhost-shadow-virtqueue.h |  4 +++
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 4c308ee53d..f4285db2b4 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -645,6 +645,8 @@ void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)
 
 /**
  * Get the shadow vq vring address.
+ * This is used irrespective of whether the
+ * split or packed vq format is used.
  * @svq: Shadow virtqueue
  * @addr: Destination to store address
  */
@@ -672,6 +674,16 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
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
@@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
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
+    svq->is_packed = virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED);
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+        svq->vring_packed.vring.desc = mmap(NULL, vhost_svq_memory_packed(svq),
+                                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                                            -1, 0);
+        desc_size = sizeof(struct vring_packed_desc) * svq->vring.num;
+        svq->vring_packed.vring.driver = (void *)((char *)svq->vring_packed.vring.desc + desc_size);
+        svq->vring_packed.vring.device = (void *)((char *)svq->vring_packed.vring.driver +
+                                                  sizeof(struct vring_packed_desc_event));
+    } else {
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
@@ -776,8 +801,13 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     svq->vq = NULL;
     g_free(svq->desc_next);
     g_free(svq->desc_state);
-    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
-    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
+
+    if (svq->is_packed) {
+        munmap(svq->vring_packed.vring.desc, vhost_svq_memory_packed(svq));
+    } else {
+        munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+        munmap(svq->vring.used, vhost_svq_device_area_size(svq));
+    }
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ee1a87f523..03b722a186 100644
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
 
@@ -150,6 +153,7 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
                               struct vhost_vring_addr *addr);
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
+size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq);
 
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree);
-- 
2.45.2


