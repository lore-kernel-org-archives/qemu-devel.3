Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ED7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 18:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJdQ3-0001Fa-Ml; Tue, 18 Jun 2024 14:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sJdQ1-0001FC-R4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:18:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sJdPz-0005Bq-OT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:18:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-704090c11easo4794933b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718734733; x=1719339533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb0RmBk8DKISndDFokE9SRVnvALZECvTf9bzRXUYCx4=;
 b=e1cgiRqnpbY6sLEK6Oq5IMFcd/HGgKVYxalayJBE3yIHv/a3hgARGUrUGaJBAp4uYN
 4tAX7UHzXzkhjhb94/kd87Kd3bOnivPod0TU9AEwc+g5It71WHLI8u/5GElxJoJlWhyZ
 Iw/2k9KNM90qs88L47X9vmDBr9VXPK1vyhm4Vjb9JWs2mvb9sXyk0Ymu6oj51n5gu+nZ
 Xxc9RUvY/WEZG0SeKuvUJvUuLPeWNSilUloILPa/vHOVqQdHQACsFri85XkkhfLNdlZ2
 aiNFpJ7tkNovC+pJ2ugZKMob9wro3dMfcadyTJTzoegOmBDwrs9sQ/yNSSvaNll3cG6m
 NCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718734733; x=1719339533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tb0RmBk8DKISndDFokE9SRVnvALZECvTf9bzRXUYCx4=;
 b=eizZuzw39sIBtOEvBG93EPEuyxZGTTJoJYdTsXwQBf3jBF1/o4J88KQUCXbh+/C+ub
 AsodYw3vaBjQ2IK6c9Q45wrirSFxLwhtwi3iSlYb55LbioTugpiZEnkKnU546xei25YM
 nwZdyycx0M7jcyu+/yKfq1HafTMta1+OmNiyarxyvY9t1BUgZcsCjy9FMvuCsH+kvkSX
 c2aXwAZkD6CuPjoAVkZK8qtHVvaNKGJ/rIAfXuW399beCfn45qeJaNIqVWZGOW55kXvs
 ofdAzUc/YVyNnWyMIJAvUTWSCIgK8OwQyqs383Kr3dYG2uxhk+7xUYsxyEK/cTfBo87V
 zkuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxh51b59vIT6C4D/59+dvAKnrXLeudCSjZ9lF91Keh7WrY3HhZOOVeyvCfiEvGUPINCLhnTw9JsLy6zNgbuVwbqw8/gU8=
X-Gm-Message-State: AOJu0YwYyH+w7hmLM8lhIsndqhHCWWssY225/FP13l8UqmxBCAM+QQdJ
 GVZXlFUD2/6339SOBS0T7mR6tfIsnHGaEjv3Qnhp2sTn8CYolTdO
X-Google-Smtp-Source: AGHT+IEWL0yeO7Bljo+H+qGucuiiM0lcYfnh//4Cn/Aub2jYwD5dDp/hurOX/ZVkaNNPpgiLm72M8g==
X-Received: by 2002:aa7:864e:0:b0:704:3438:9c1a with SMTP id
 d2e1a72fcca58-70629c5b096mr490904b3a.16.1718734732824; 
 Tue, 18 Jun 2024 11:18:52 -0700 (PDT)
Received: from valdaarhun.. ([223.233.82.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3bf40sm9266061b3a.111.2024.06.18.11.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:18:52 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC] vhost: Introduce packed vq and add buffer elements
Date: Tue, 18 Jun 2024 23:48:34 +0530
Message-ID: <20240618181834.14173-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This is the first patch in a series to add support for packed
virtqueues in vhost_shadow_virtqueue. This patch implements the
insertion of available buffers in the descriptor area. It takes
into account descriptor chains, but does not consider indirect
descriptors.

VhostShadowVirtqueue has also been modified so it acts as a layer
of abstraction for split and packed virtqueues.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Hi,

I am currently working on adding support for packed virtqueues in
vhost_shadow_virtqueue [1]. This patch only implements the insertion of
available buffers in the descriptor area. It does not take into
account indirect descriptors, event_idx or notifications.

I don't think these changes are testable yet but I thought I would
still post this patch for feedback. The following email annotates these
changes with a few comments and questions that I have.

Thanks,
Sahil

[1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue

 hw/virtio/vhost-shadow-virtqueue.c | 124 ++++++++++++++++++++++++++++-
 hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
 2 files changed, 167 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..e3b276a9e9 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     return true;
 }
 
+/**
+ * Write descriptors to SVQ packed vring
+ *
+ * @svq: The shadow virtqueue
+ * @sg: Cache for hwaddr
+ * @out_sg: The iovec from the guest that is read-only for device
+ * @out_num: iovec length
+ * @in_sg: The iovec from the guest that is write-only for device
+ * @in_num: iovec length
+ * @head_flags: flags for first descriptor in list
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_vring_write_descs_packed(VhostShadowVirtqueue *svq, hwaddr *sg,
+                                        const struct iovec *out_sg, size_t out_num,
+                                        const struct iovec *in_sg, size_t in_num,
+                                        uint16_t *head_flags)
+{
+    uint16_t id, curr, head, i;
+    unsigned n;
+    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
+    bool ok;
+
+    head = svq->vring_packed.next_avail_idx;
+    i = head;
+    id = svq->free_head;
+    curr = id;
+
+    size_t num = out_num + in_num;
+
+    if (num == 0) {
+        return true;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sg, out_sg, out_num);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sg + out_num, in_sg, in_num);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    for (n = 0; n < num; n++) {
+        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
+                (n < out_num ? 0 : VRING_DESC_F_WRITE) |
+                (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
+        if (i == head) {
+            *head_flags = flags;
+        } else {
+            descs[i].flags = flags;
+        }
+
+        descs[i].addr = cpu_to_le64(sg[n]);
+        descs[i].id = id;
+        if (n < out_num) {
+            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
+        } else {
+            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
+        }
+
+        curr = cpu_to_le16(svq->desc_next[curr]);
+
+        if (++i >= svq->vring_packed.vring.num) {
+            i = 0;
+            svq->vring_packed.avail_used_flags ^=
+                    1 << VRING_PACKED_DESC_F_AVAIL |
+                    1 << VRING_PACKED_DESC_F_USED;
+        }
+    }
+
+    if (i <= head) {
+        svq->vring_packed.avail_wrap_counter ^= 1;
+    }
+
+    svq->vring_packed.next_avail_idx = i;
+    svq->free_head = curr;
+    return true;
+}
+
+static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
+                                const struct iovec *out_sg, size_t out_num,
+                                const struct iovec *in_sg, size_t in_num,
+                                unsigned *head)
+{
+    bool ok;
+    uint16_t head_flags = 0;
+    g_autofree hwaddr *sgs = g_new(hwaddr, out_num + in_num);
+
+    *head = svq->vring_packed.next_avail_idx;
+
+    /* We need some descriptors here */
+    if (unlikely(!out_num && !in_num)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest provided element with no descriptors");
+        return false;
+    }
+
+    ok = vhost_svq_vring_write_descs_packed(svq, sgs, out_sg, out_num,
+                                            in_sg, in_num, &head_flags);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    /*
+     * A driver MUST NOT make the first descriptor in the list
+     * available before all subsequent descriptors comprising
+     * the list are made available.
+     */
+    smp_wmb();
+    svq->vring_packed.vring.desc[*head].flags = head_flags;
+
+    return true;
+}
+
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
 {
     bool needs_kick;
@@ -258,7 +374,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+        ok = vhost_svq_add_packed(svq, out_sg, out_num,
+                                  in_sg, in_num, &qemu_head);
+    } else {
+        ok = vhost_svq_add_split(svq, out_sg, out_num,
+                                 in_sg, in_num, &qemu_head);
+    }
     if (unlikely(!ok)) {
         return -EINVAL;
     }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 19c842a15b..ee1a87f523 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -46,10 +46,53 @@ typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
 } VhostShadowVirtqueueOps;
 
+struct vring_packed {
+    /* Actual memory layout for this queue. */
+    struct {
+        unsigned int num;
+        struct vring_packed_desc *desc;
+        struct vring_packed_desc_event *driver;
+        struct vring_packed_desc_event *device;
+    } vring;
+
+    /* Avail used flags. */
+    uint16_t avail_used_flags;
+
+    /* Index of the next avail descriptor. */
+    uint16_t next_avail_idx;
+
+    /* Driver ring wrap counter */
+    bool avail_wrap_counter;
+};
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
+    /* Virtio queue shadowing */
+    VirtQueue *vq;
+
+    /* Virtio device */
+    VirtIODevice *vdev;
+
+    /* SVQ vring descriptors state */
+    SVQDescState *desc_state;
+
+    /*
+     * Backup next field for each descriptor so we can recover securely, not
+     * needing to trust the device access.
+     */
+    uint16_t *desc_next;
+
+    /* Next free descriptor */
+    uint16_t free_head;
+
+    /* Size of SVQ vring free descriptors */
+    uint16_t num_free;
+
     /* Shadow vring */
-    struct vring vring;
+    union {
+        struct vring vring;
+        struct vring_packed vring_packed;
+    };
 
     /* Shadow kick notifier, sent to vhost */
     EventNotifier hdev_kick;
@@ -69,27 +112,12 @@ typedef struct VhostShadowVirtqueue {
     /* Guest's call notifier, where the SVQ calls guest. */
     EventNotifier svq_call;
 
-    /* Virtio queue shadowing */
-    VirtQueue *vq;
-
-    /* Virtio device */
-    VirtIODevice *vdev;
-
     /* IOVA mapping */
     VhostIOVATree *iova_tree;
 
-    /* SVQ vring descriptors state */
-    SVQDescState *desc_state;
-
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
 
@@ -99,17 +127,11 @@ typedef struct VhostShadowVirtqueue {
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-    /* Next free descriptor */
-    uint16_t free_head;
-
     /* Last seen used idx */
     uint16_t shadow_used_idx;
 
     /* Next head to consume from the device */
     uint16_t last_used_idx;
-
-    /* Size of SVQ vring free descriptors */
-    uint16_t num_free;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
-- 
2.45.2


