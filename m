Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30458C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqMN-00072t-W8; Fri, 02 Aug 2024 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqML-00071t-Gm
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMJ-00078B-Gk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso72564015ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722597726; x=1723202526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVqHd/Jtlj5C7EeSylIuM3N/ujd+yEcb8T7o3eybFLk=;
 b=KDHIS2CPguPzFPgvbcKSIgGhQi9OsT15PR8xeNbvq/3f0oSF21pgYq9ENmBz9NjqfQ
 46KhLiPJk8VL7mBmq7QagfB/ofKAdH9KJZb0zVBkqydrrfPAQzzMGnNRmEDrgmirpMO4
 yG82X/DtXzFcwRXDs9ghCi4jztlFS1o7euiYSyjHwTpZh0hG7W4/E2DPeLMl6e8FOC1q
 qhLva/ox/faJEcGwLFz+ydrMJoM4XpwUEljGi/6YdN2DqrUCXaq+eA1jyWaV28ck6KVp
 i6yGgMoRCOpumP/hdxD8yMttRqQMcaU2pea8z1LtAurnG2mNKrU1H3b37UDgxW0BIdBP
 9ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597726; x=1723202526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVqHd/Jtlj5C7EeSylIuM3N/ujd+yEcb8T7o3eybFLk=;
 b=IyedEgl54fiJWmGdjW67xZzuZZPrrYUSzqot1cnIsxd97W6DmLQBn3toeOJabvmgLP
 TWDZAzwFBZfFlI+kUIRtVP2ndb5dMSG5EPEiODoipf+4+EvnF70V81DGs48iqS8fnjPG
 B0nmVQKoP2jVrAfdgkCt/OfQ5h1ICWnNf/i60GWqyHhE9O2l91ZiG2gBCkayQO8fBXsf
 JwcQc7PN+4Z0mCEOelWU8xxZ+nBNX6iIqlSybUqN0ppn9We0/Qi0ZsJSd0GQPmL+kRiI
 a3hC4tqWZi2CMAq9E8uUozsloac05nY38Eij/60nHQzQmr5a3FgDwUlgcJAR7VdZn1Qq
 gdKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRuqP8Scws6ZHx9R0YgmkJzq/DAznWAwoQr6pjxbR4vlxpL5k10YHCTyx5qXKR9s30t96xNxErpzJphmFsdlpdXYbIt2U=
X-Gm-Message-State: AOJu0Yw8mc6ft9HZMchaPUq905/wLSItGHoyp8kEYClQD+gNEENnaR0b
 sgNG8dcDQmB5/Vh+/TIiPhDY3yLPrYMur+3KEU5Yb3AiIAXHJT3b
X-Google-Smtp-Source: AGHT+IFJ535Lr2/6XauQ1F0RYmnxR8KScZsf3TZJAy1yqh2t0ufbovyShmht6HyQBmlXvyLtDruxHQ==
X-Received: by 2002:a17:902:da83:b0:1fd:9b96:32f5 with SMTP id
 d9443c01a7336-1ff572b9a30mr41782675ad.31.1722597725969; 
 Fri, 02 Aug 2024 04:22:05 -0700 (PDT)
Received: from valdaarhun.. ([223.233.85.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ae4esm14801335ad.269.2024.08.02.04.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:22:05 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, icegambit91@gmail.com,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v3 1/3] vhost: Introduce packed vq and add buffer elements
Date: Fri,  2 Aug 2024 16:51:36 +0530
Message-ID: <20240802112138.46831-2-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802112138.46831-1-sahilcdq@proton.me>
References: <20240802112138.46831-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x631.google.com
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

This is the first patch in a series to add support for packed
virtqueues in vhost_shadow_virtqueue. This patch implements the
insertion of available buffers in the descriptor area. It takes
into account descriptor chains, but does not consider indirect
descriptors.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v2 -> v3:
* vhost-shadow-virtqueue.c
  - Move parts common to "vhost_svq_add_split" and
    "vhost_svq_add_packed" to "vhost_svq_add".
  (vhost_svq_add_packed):
  - Refactor to minimize duplicate code between
    this and "vhost_svq_add_split"
  - Fix code style issues.
  (vhost_svq_add_split):
  - Merge with "vhost_svq_vring_write_descs()"
  - Refactor to minimize duplicate code between
    this and "vhost_svq_add_packed"
  (vhost_svq_add):
  - Refactor to minimize duplicate code between
    split and packed version of "vhost_svq_add"

 hw/virtio/vhost-shadow-virtqueue.c | 174 +++++++++++++++++++----------
 1 file changed, 115 insertions(+), 59 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..4c308ee53d 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -124,97 +124,132 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
 }
 
 /**
- * Write descriptors to SVQ vring
+ * Write descriptors to SVQ split vring
  *
  * @svq: The shadow virtqueue
- * @sg: Cache for hwaddr
- * @iovec: The iovec from the guest
- * @num: iovec length
- * @more_descs: True if more descriptors come in the chain
- * @write: True if they are writeable descriptors
- *
- * Return true if success, false otherwise and print error.
+ * @out_sg: The iovec to the guest
+ * @out_num: Outgoing iovec length
+ * @in_sg: The iovec from the guest
+ * @in_num: Incoming iovec length
+ * @sgs: Cache for hwaddr
+ * @head: Saves current free_head
  */
-static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
-                                        const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
+                                const struct iovec *out_sg, size_t out_num,
+                                const struct iovec *in_sg, size_t in_num,
+                                hwaddr *sgs, unsigned *head)
 {
+    unsigned avail_idx, n;
     uint16_t i = svq->free_head, last = svq->free_head;
-    unsigned n;
-    uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
+    vring_avail_t *avail = svq->vring.avail;
     vring_desc_t *descs = svq->vring.desc;
-    bool ok;
-
-    if (num == 0) {
-        return true;
-    }
+    size_t num = in_num + out_num;
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
-    if (unlikely(!ok)) {
-        return false;
-    }
+    *head = svq->free_head;
 
     for (n = 0; n < num; n++) {
-        if (more_descs || (n + 1 < num)) {
-            descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
+        descs[i].flags = cpu_to_le16(n < out_num ? 0 : VRING_DESC_F_WRITE);
+        if (n + 1 < num) {
+            descs[i].flags |= cpu_to_le16(VRING_DESC_F_NEXT);
             descs[i].next = cpu_to_le16(svq->desc_next[i]);
+        }
+
+        descs[i].addr = cpu_to_le64(sgs[n]);
+        if (n < out_num) {
+            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
         } else {
-            descs[i].flags = flags;
+            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
         }
-        descs[i].addr = cpu_to_le64(sg[n]);
-        descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
         i = cpu_to_le16(svq->desc_next[i]);
     }
 
     svq->free_head = le16_to_cpu(svq->desc_next[last]);
-    return true;
+
+    /*
+     * Put the entry in the available array (but don't update avail->idx until
+     * they do sync).
+     */
+    avail_idx = svq->shadow_avail_idx & (svq->vring.num - 1);
+    avail->ring[avail_idx] = cpu_to_le16(*head);
+    svq->shadow_avail_idx++;
+
+    /* Update the avail index after write the descriptor */
+    smp_wmb();
+    avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 }
 
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
+/**
+ * Write descriptors to SVQ packed vring
+ *
+ * @svq: The shadow virtqueue
+ * @out_sg: The iovec to the guest
+ * @out_num: Outgoing iovec length
+ * @in_sg: The iovec from the guest
+ * @in_num: Incoming iovec length
+ * @sgs: Cache for hwaddr
+ * @head: Saves current free_head
+ */
+static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                hwaddr *sgs, unsigned *head)
 {
-    unsigned avail_idx;
-    vring_avail_t *avail = svq->vring.avail;
-    bool ok;
-    g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
+    uint16_t id, curr, i, head_flags = 0;
+    size_t num = out_num + in_num;
+    unsigned n;
 
-    *head = svq->free_head;
+    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
 
-    /* We need some descriptors here */
-    if (unlikely(!out_num && !in_num)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Guest provided element with no descriptors");
-        return false;
-    }
+    *head = svq->vring_packed.next_avail_idx;
+    i = *head;
+    id = svq->free_head;
+    curr = id;
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
-    if (unlikely(!ok)) {
-        return false;
+    /* Write descriptors to SVQ packed vring */
+    for (n = 0; n < num; n++) {
+        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
+                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
+                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
+        if (i == *head) {
+            head_flags = flags;
+        } else {
+            descs[i].flags = flags;
+        }
+
+        descs[i].addr = cpu_to_le64(sgs[n]);
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
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
-    if (unlikely(!ok)) {
-        return false;
+    if (i <= *head) {
+        svq->vring_packed.avail_wrap_counter ^= 1;
     }
 
+    svq->vring_packed.next_avail_idx = i;
+    svq->free_head = curr;
+
     /*
-     * Put the entry in the available array (but don't update avail->idx until
-     * they do sync).
+     * A driver MUST NOT make the first descriptor in the list
+     * available before all subsequent descriptors comprising
+     * the list are made available.
      */
-    avail_idx = svq->shadow_avail_idx & (svq->vring.num - 1);
-    avail->ring[avail_idx] = cpu_to_le16(*head);
-    svq->shadow_avail_idx++;
-
-    /* Update the avail index after write the descriptor */
     smp_wmb();
-    avail->idx = cpu_to_le16(svq->shadow_avail_idx);
-
-    return true;
+    svq->vring_packed.vring.desc[*head].flags = head_flags;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -254,15 +289,36 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     unsigned ndescs = in_num + out_num;
     bool ok;
 
+    /* We need some descriptors here */
+    if (unlikely(!ndescs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest provided element with no descriptors");
+        return -EINVAL;
+    }
+
     if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    g_autofree hwaddr *sgs = g_new(hwaddr, ndescs);
+    ok = vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
 
+    ok = vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num);
+    if (unlikely(!ok)) {
+        return -EINVAL;
+    }
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
+                             in_num, sgs, &qemu_head);
+    } else {
+        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
+                            in_num, sgs, &qemu_head);
+    }
+
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
-- 
2.45.2


