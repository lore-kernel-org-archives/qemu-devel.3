Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3884E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIYu-0005tL-V9; Thu, 05 Dec 2024 15:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIYu-0005t6-2O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIYs-0004aZ-Ao
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:34:59 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7258ed68cedso1345175b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430897; x=1734035697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbuG7Vt0FlvjItwImTZRJUsHMB8HutT99kgERxhxwEk=;
 b=CrLh7FV5Ww/DEZIdHYbXfxr/Tn1ZMd1vXkvez1olhYfHss3VREjrVAk1ZAOQm2h8ck
 XASHnlMNFZdPshXDxNAJAia/6HXgr5F2xXAfxFa3uFdwknuVU1rJsfXhbdvVpsAyRKa/
 pa1anxDVXDfyILh4y/LffGlZWpZ4WqkYTegFXpnGbs7vpxxv47JEaaCWuLGX8tPvrO5W
 hGTcQ0xkcH/bbki/vNLItuIRyCNpqHsP8/azzNuVI8wp92subAqZNWo6Bo8rzhuP7mNB
 pqWN8dbKKNNDXK3+TuWgDRKqhVgOVnKLaQHU/v05TVusCEgc8d6HPJvALSLZuu7PUbMG
 cQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430897; x=1734035697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbuG7Vt0FlvjItwImTZRJUsHMB8HutT99kgERxhxwEk=;
 b=QRv6+Fo28Uwk6QNXgYaiXLNXnKk8T/M9ghcA4V/2T291nixLHX9vNG+SsQe9aLpgJy
 n3PNyvIYKzhkzmXnoDK/UR77VQuKz98sjRcWqRLoaxkVk8D6xF3cYp1Lw1zWX/LNpK0h
 cqXLcPi/kXi7sOB9htgDxwJnqNs1UrihJz4iLPKvjCHr9PGTV6POaPJ3u9ET6rbTh7qe
 amwaI0v/g81AMSu9jXZOnLG94QHMLXxsfbwYF7T9vjepzWiML6XkLKaHUxd1c8r6pVU4
 zN7pf11rJNnCEiFxSClj6YUDlM2nnXwQPOG+d5m895U02Ijb8u+catirSQf2fAxsX7/a
 OcCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cQej7HI9HD0Wl9EvU+WRBfC68doJEZcY9wRv4zEaHPlwcZR6+XjnqzRNh6XI+MGC0LNgbFujNar2@nongnu.org
X-Gm-Message-State: AOJu0YwE5dXaWOj6l6sH1KTBpENdTiY9WmPQsZFGTQqia36sR3w2GKMn
 5Z3ULwf30QXnd5haRCUCvHioplxfLVGGdkIDR2EyCGS+tNgl2EW5
X-Gm-Gg: ASbGncu3Yyhho9aHueYnlS6auIIFuGqou+blHByyutA269zMarx7RS/Z4H7Lj9Vip3j
 FDI81fB3GjOJSxop2Eh03rgK7NMScbtKVFzP7uPlKzUrcVjFTnMx1ArsbZ9VedUKT+Fgxe8ZShK
 Fwmci2++lcDJssmsNK9aHvRvup/h4yxgjSwV5XXtWD8n7Wls4OTw0fDYSTJuqgECL2d65a2WFfb
 804B3AuiivTyfm6sT17raOrbmoHRSeagtrYQgJEcgk=
X-Google-Smtp-Source: AGHT+IEGOPWQMbFQp6mNHx0PzoxZi+YN+kmpcpJEvF4RLEzGniQ8auIsFh1B81AJxfPrgC7dZQc7sw==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-2ef69e12624mr900583a91.10.1733430896841; 
 Thu, 05 Dec 2024 12:34:56 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:34:56 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 1/5] vhost: Refactor vhost_svq_add_split
Date: Fri,  6 Dec 2024 02:04:26 +0530
Message-ID: <20241205203430.76251-2-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42a.google.com
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

This commit refactors vhost_svq_add_split and
vhost_svq_add to simplify their implementation
and prepare for the addition of packed vqs in
following commits.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v3 -> v4:
- Split commit #1 in v3 into 2 commits.
- Changes related to "vhost_svq_add_packed" are
  now in commit #2.

 hw/virtio/vhost-shadow-virtqueue.c | 102 ++++++++++++-----------------
 1 file changed, 41 insertions(+), 61 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 37aca8b431..bb7cf6d5db 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -124,83 +124,48 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
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
-}
-
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
-                                const struct iovec *out_sg, size_t out_num,
-                                const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
-{
-    unsigned avail_idx;
-    vring_avail_t *avail = svq->vring.avail;
-    bool ok;
-    g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
-
-    *head = svq->free_head;
-
-    /* We need some descriptors here */
-    if (unlikely(!out_num && !in_num)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Guest provided element with no descriptors");
-        return false;
-    }
-
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
-    if (unlikely(!ok)) {
-        return false;
-    }
-
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
-    if (unlikely(!ok)) {
-        return false;
-    }
 
     /*
      * Put the entry in the available array (but don't update avail->idx until
@@ -214,7 +179,6 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 
-    return true;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -254,15 +218,31 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
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
+    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
+                        in_num, sgs, &qemu_head);
+
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
-- 
2.47.0


