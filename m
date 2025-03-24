Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17786C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiOG-0008HY-2B; Mon, 24 Mar 2025 10:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLb-0006uD-1d
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLY-0004Hl-6V
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227a8cdd241so4892325ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824806; x=1743429606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSuhcobXqPF1Pt7G4Hh20PpkvZheRGH7hYC3WNW5UTs=;
 b=ioW4VFXTl9k6FcyX+9QsBgRDn2JfRosc1jIybx063acXhy3Rztcx2ZkQUGHdYrRjYt
 bEvNkDQCY4mOEaY/x/LBJefwgvGy23wnRjTuacsWT4ZICZGv9BNhEm1QUfoeEjyZiSMl
 UKtOSmT8xaNRYYNGLN5DRI1KNaTlwsJDE1q5v5BvKApHyThIyGexu3EL2z8ALvA46+xp
 Zdgz1tQgsXsvKbzKAJhNsO/L6J9WP2ziicQNBc35vgw/4UDY2V5+QrZPhwEWMwhFhLhG
 m9mnBTIFzm64GOb/brCjm1HY21I7/dwygzH4njQNOU/3Wfkkx7sqb2TIbC6Emg9pUTPW
 SwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824806; x=1743429606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSuhcobXqPF1Pt7G4Hh20PpkvZheRGH7hYC3WNW5UTs=;
 b=k8Jo7/QZA8u9bh6UBYq15gYOBtNIfmiGSe50SeuzI2cRiskRebZjycT4LbOxrAuHDW
 DPtZBmX30ppB+qWtCtOxisY2XSN/VPMwjanElaucOnr2XASxJ1q3mcy8s3i5e3BeDG5d
 jTEtOU7E3RFmIKTXw3EzSaSZJG847lMA7cjWeFJSm5yezhp5oMMi/z04q1mUfBDmkSUo
 WNa1qUASuRHLN4yNZ7AvQ9oSy2IB8Jf0UAgqUOL2cWt1WK2PGvPzYaM0+D1Aa5is6+y6
 2kc4g7pUJ1lcZKTe9d2mZiM8tviey+S/nl0sOoRns3PoCDs5FRwkcAfbq1dqdhUwJO9I
 k/WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1kssHEpFmgbqKjXm+D1wfxw38dYBAe3/HEgCBD4+V4GQeeXSUtnK30zTCSqm2z0fppPxufE2JF8vh@nongnu.org
X-Gm-Message-State: AOJu0Yy1hehQOSbFSianJGS6tUIjvv95YNuCKLW2U9oEjdBvbW1y/a6S
 Z4gjt4MyWCsRw1BK5lF/tS2Mx+yIj61Wq2gWhjGgNTb0ncqtOXtFxjbbVg==
X-Gm-Gg: ASbGnctRjk4lvWjFeYQu5vbkLz7dV/V3pgSh20sI6xRzRNmXb5W8qh3IXnwdQO/wC6+
 duMpepKbqQD1/lUgQALg2ZR9VQ7CduSN5gIbtEriMALrMeKrkDj5IT3bEvhda85TTVa3g6NfqKc
 /gC6rCUriyCYt5bsKuUqe7Z4ZRyU6W3Nj3Pcy5Jm2NQXYrFKFsaZE9ZEyyNDZzJpsd8KgCB0frc
 EqmgDRhxUJ5iN5k+vSjmKl154Jtna63bAS1FkTXHCVtlsZGSaJpfgvPdhAsPDlG0cNdcOPGOxcy
 RIXg/L7o/56gyH3bK2NNVLJZ4HuKsNEk4OObF8I=
X-Google-Smtp-Source: AGHT+IEekDruNXqdXncn1P1P3XBll+iXRlgwpjMdQJoy43OxwketvkwdrMM6s7QD5ETYRunLFcnf9Q==
X-Received: by 2002:a05:6a00:13a0:b0:736:ab48:18f0 with SMTP id
 d2e1a72fcca58-7390597ec9amr15762013b3a.1.1742824805815; 
 Mon, 24 Mar 2025 07:00:05 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:00:05 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 4/7] vdpa: Allocate memory for SVQ and map them to vdpa
Date: Mon, 24 Mar 2025 19:29:18 +0530
Message-ID: <20250324135929.74945-5-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Allocate memory for the packed vq format and map them to the vdpa device.

Since "struct vring" and "struct vring_packed's vring" both have the same
memory layout, the implementation in SVQ start and SVQ stop should not
differ based on the vq's format.

Also initialize flags, counters and indices for packed vqs before they
are utilized.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- vhost-shadow-virtqueue.c:
  (vhost_svq_start): Initialize variables used by packed vring.

 hw/virtio/vhost-shadow-virtqueue.c | 52 +++++++++++++++++++++---------
 hw/virtio/vhost-shadow-virtqueue.h |  1 +
 hw/virtio/vhost-vdpa.c             | 37 +++++++++++++++++----
 3 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 6e16cd4bdf..126957231d 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -707,19 +707,33 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
     addr->used_user_addr = (uint64_t)(uintptr_t)svq->vring.used;
 }
 
-size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
+size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq)
 {
     size_t desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    size_t avail_size = offsetof(vring_avail_t, ring[svq->vring.num]) +
-                                                              sizeof(uint16_t);
+    return ROUND_UP(desc_size, qemu_real_host_page_size());
+}
 
-    return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size());
+size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
+{
+    size_t avail_size;
+    if (svq->is_packed) {
+        avail_size = sizeof(uint32_t);
+    } else {
+        avail_size = offsetof(vring_avail_t, ring[svq->vring.num]) +
+                                                             sizeof(uint16_t);
+    }
+    return ROUND_UP(avail_size, qemu_real_host_page_size());
 }
 
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
 {
-    size_t used_size = offsetof(vring_used_t, ring[svq->vring.num]) +
-                                                              sizeof(uint16_t);
+    size_t used_size;
+    if (svq->is_packed) {
+        used_size = sizeof(uint32_t);
+    } else {
+        used_size = offsetof(vring_used_t, ring[svq->vring.num]) +
+                                                           sizeof(uint16_t);
+    }
     return ROUND_UP(used_size, qemu_real_host_page_size());
 }
 
@@ -764,8 +778,6 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree)
 {
-    size_t desc_size;
-
     event_notifier_set_handler(&svq->hdev_call, vhost_svq_handle_call);
     svq->next_guest_avail_elem = NULL;
     svq->shadow_avail_idx = 0;
@@ -774,20 +786,29 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->vdev = vdev;
     svq->vq = vq;
     svq->iova_tree = iova_tree;
+    svq->is_packed = virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED);
+
+    if (svq->is_packed) {
+        svq->vring_packed.avail_wrap_counter = 1;
+        svq->vring_packed.next_avail_idx = 0;
+        svq->vring_packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
+        svq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+    }
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+    svq->vring.desc = mmap(NULL, vhost_svq_descriptor_area_size(svq),
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
-    desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+    svq->vring.avail = mmap(NULL, vhost_svq_driver_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
     svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
-    svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    svq->desc_next = g_new0(uint16_t, svq->vring.num);
-    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
+    svq->desc_state = g_new0(SVQDescState, svq->num_free);
+    svq->desc_next = g_new0(uint16_t, svq->num_free);
+    for (unsigned i = 0; i < svq->num_free - 1; i++) {
         svq->desc_next[i] = i + 1;
     }
 }
@@ -827,7 +848,8 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     svq->vq = NULL;
     g_free(svq->desc_next);
     g_free(svq->desc_state);
-    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+    munmap(svq->vring.desc, vhost_svq_descriptor_area_size(svq));
+    munmap(svq->vring.avail, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 5f7699da9d..12c6ea8be2 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -152,6 +152,7 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
 void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
                               struct vhost_vring_addr *addr);
+size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7efbde3d4c..58c8931d89 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1137,6 +1137,8 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
 
     vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
 
+    vhost_vdpa_svq_unmap_ring(v, svq_addr.avail_user_addr);
+
     vhost_vdpa_svq_unmap_ring(v, svq_addr.used_user_addr);
 }
 
@@ -1191,38 +1193,61 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
                                      Error **errp)
 {
     ERRP_GUARD();
-    DMAMap device_region, driver_region;
+    DMAMap descriptor_region, device_region, driver_region;
     struct vhost_vring_addr svq_addr;
     struct vhost_vdpa *v = dev->opaque;
+    size_t descriptor_size = vhost_svq_descriptor_area_size(svq);
     size_t device_size = vhost_svq_device_area_size(svq);
     size_t driver_size = vhost_svq_driver_area_size(svq);
-    size_t avail_offset;
     bool ok;
 
     vhost_svq_get_vring_addr(svq, &svq_addr);
 
+    descriptor_region = (DMAMap) {
+        .translated_addr = svq_addr.desc_user_addr,
+        .size = descriptor_size - 1,
+        .perm = IOMMU_RO,
+    };
+    if (svq->is_packed) {
+        descriptor_region.perm = IOMMU_RW;
+    }
+
+    ok = vhost_vdpa_svq_map_ring(v, &descriptor_region, svq_addr.desc_user_addr,
+                                 errp);
+    if (unlikely(!ok)) {
+        error_prepend(errp, "Cannot create vq descriptor region: ");
+        return false;
+    }
+    addr->desc_user_addr = descriptor_region.iova;
+
     driver_region = (DMAMap) {
+        .translated_addr = svq_addr.avail_user_addr,
         .size = driver_size - 1,
         .perm = IOMMU_RO,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
+    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.avail_user_addr,
                                  errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq driver region: ");
+        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
         return false;
     }
-    addr->desc_user_addr = driver_region.iova;
-    avail_offset = svq_addr.avail_user_addr - svq_addr.desc_user_addr;
-    addr->avail_user_addr = driver_region.iova + avail_offset;
+    addr->avail_user_addr = driver_region.iova;
 
     device_region = (DMAMap) {
+        .translated_addr = svq_addr.used_user_addr,
         .size = device_size - 1,
         .perm = IOMMU_RW,
     };
+    if (svq->is_packed) {
+        device_region.perm = IOMMU_WO;
+    }
+
     ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
                                  errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq device region: ");
+        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
         vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
     }
     addr->used_user_addr = device_region.iova;
-- 
2.48.1


