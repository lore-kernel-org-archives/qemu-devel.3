Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D7C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHir-0005gv-2i; Fri, 26 Jul 2024 05:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHip-0005eI-PC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHin-0006N8-Ua
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso3985315ad.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721987924; x=1722592724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVvw9f50xTkuvlwY1MV4CHABenmr7Ci+oOmj5DJaqa4=;
 b=QqRBX9gTrGGM4opiVUhCh/q4cw2f4KyhfGTzdNziNkl+/5tLdscrZ76Ho1Xe8EuzVm
 D5zwe2VuVcwPTEFrtysW/Ic3UaD/CHWh0d5VrPQ9mV/ET4LUUjxz69RpbckXzdFrSNBK
 HFe5xVvQnISGPz6lzf3RiTyroO/1+6dpaJd2KsmU2V+x7qlHC6bkWUB2CyYndb9vGNRe
 miZ26P+lR+24hLpox+f/iUDd9uOsxu8rA/bNm6T56awU3/OrHa+l5UATt6qPc5g/nscv
 i5/pq0Yhv9Ku6BWgWJbJowDKtOwum19p+DrAf9zhENUQns+CG6TstptGH5oWff1PD5oA
 /n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721987924; x=1722592724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVvw9f50xTkuvlwY1MV4CHABenmr7Ci+oOmj5DJaqa4=;
 b=VSzgLZEwlk0P6jG6uvWf6VszCpAm+a5sKKB0gKaLoumT1wTGE88Es4uDRAFpFf3nE1
 +o21r6CUMlC98XWwkC8UrMAvWbZC1lSgJwvkBJ8WA5RjZERF3IXyLyJrzi36swaICE7P
 djg+9Qc5GKHHWdlu7UzXWHTUPyjZJgZRdAhMMVss9B814Fv/fTwgjNh1FGOCyYvtLBjw
 vHMOnU0ZBtNMfgYp0+dTKr3bmv1H4uFKGPRomonZAqXSVXgMhHMCJK8gCK23BCLxq4Fk
 veV80eNQ+BuNcZ2mU5sYj9am3WMh/KVR5ZnxB9zpsiu4tEecOAyh+8uI76ge2FiaDfW9
 08yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrl8+TJrqTDtKvTkeg/4uLfZvzbErI91YqRXrQuMGnZ8RUKmyhpTtzrOtXHVDDkO7Oo+9wgpqu1eChi5d7iDf+9dZ0+B8=
X-Gm-Message-State: AOJu0YyOw6yWxvTk42AVIFfCv65dCGbbVNaGGE1iDV64EUfCsxYGh8NW
 m52vXMLQ7sHewv88+psNIJ1Zgtj0ps9UVg6owyg6ui7IoF0ZkCc2Z5FVSw==
X-Google-Smtp-Source: AGHT+IH1TkDBtKDFvI5jcyXmLrrOcOzNDBrTCqjT4hikTpMOYVdrRYDnL/f4bshWsFb2R23VDnwiEw==
X-Received: by 2002:a17:902:ec91:b0:1fd:8904:ecf6 with SMTP id
 d9443c01a7336-1fed9259301mr46266625ad.21.1721987924328; 
 Fri, 26 Jul 2024 02:58:44 -0700 (PDT)
Received: from valdaarhun.. ([223.233.82.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fcd252sm28201655ad.285.2024.07.26.02.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:58:43 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v2 1/3] vhost: Introduce packed vq and add buffer elements
Date: Fri, 26 Jul 2024 15:28:20 +0530
Message-ID: <20240726095822.104017-2-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726095822.104017-1-sahilcdq@proton.me>
References: <20240726095822.104017-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
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
Changes v1 -> v2:
* Split commit from RFC v1 into two commits.
* vhost-shadow-virtqueue.c
  (vhost_svq_add_packed):
  - Merge with "vhost_svq_vring_write_descs_packed()"
  - Remove "num == 0" check

 hw/virtio/vhost-shadow-virtqueue.c | 93 +++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..c7b7e0c477 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -217,6 +217,91 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     return true;
 }
 
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
+    uint16_t id, curr, i;
+    unsigned n;
+    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
+
+    i = *head;
+    id = svq->free_head;
+    curr = id;
+
+    size_t num = out_num + in_num;
+
+    ok = vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
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
+    }
+
+    if (i <= *head) {
+        svq->vring_packed.avail_wrap_counter ^= 1;
+    }
+
+    svq->vring_packed.next_avail_idx = i;
+    svq->free_head = curr;
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
@@ -258,7 +343,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
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
-- 
2.45.2


