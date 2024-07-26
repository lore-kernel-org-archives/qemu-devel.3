Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66FCC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHiz-0005tu-T1; Fri, 26 Jul 2024 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHiy-0005sw-BM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHiw-0006P2-O8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so4623475ad.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721987933; x=1722592733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BY83cplx/oeP6dLfAfpBBdfnuLxlOhXtCHD6lqzeXbU=;
 b=fZZNK5nvOLKdYMjTp1nX0Va8m1Cm9eNEK3LXEQmbhqMc/Up3CuVRPwACgO3tbQHsCN
 5TzM9wAvMX/sOjLc+udDEKaXYrDNdaq1MlDK636KPrwQhjZXrkmjw0640nklgBocQvay
 o2MJgWRjObDoo+/R55QaBEqEWUhByu+1SjYAFJoiT0nYLopMkYfFnUG8PSgJrTiJLOV2
 27ZKaD1DzGioCtFL3dtgBOili/RTo41owVTgOdETgGS9K6YOC4m+yJ1ueye0Dt1/67W2
 CRJnPkr7oN5gADWU5TwAUJW/y/G4VRIgjDJ/V+rPO+8J6BWv71ri7K7I5PK7tk+e5laL
 lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721987933; x=1722592733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BY83cplx/oeP6dLfAfpBBdfnuLxlOhXtCHD6lqzeXbU=;
 b=qYCleBtlI6I/f385HQoQAGnYN9MjuzElsI3eZ5Y55ZsyInR+pIIi5voChgu3IrDYbA
 L//WzoJdqbCb1fCUu3ypSBx8TXz8QOcvbGtLsRCeN8jBz76YUhNAToiiq/myZLSq1qFh
 P5d7xGVrSHfTLnq2blFa9zt1uhJJEKU+omqNru6pXXrcfBc2MNzU4jb/o27RW8yTe6om
 pQj3roSBv7wdEAuMsFFiZBgjRB/VOwEXrEqMpvcL7240A8QW5D7ap0gnJ9ZJQFswdJkv
 n14TPRqhMf4cWq5pldqn9M/EHlCNfQXtwUlxi76pMEK371hi8Cc7xV02MzsqVJYMy0mo
 OsAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhZn55L+7nmJn6XbN3zsp4KkHQzpRXDdJOwik3k4jO2SDkZc8pgR7Jubs7eGscn8qctQpOalpUIXWV3pqtE/XAnhJKbao=
X-Gm-Message-State: AOJu0Yy8mxsQHT2GDDChNCBnU/Yx3ZHgu8VnvvYszfoTLieVGDDbtyxh
 y1lkYPQjwiHijgjah4j+QN/nDlMmdFU9xPbEOuCXTxz1/NNgMYmS
X-Google-Smtp-Source: AGHT+IE5nSpI7Zn9iO9PAyLzBnKXZgUqBaUwZsF4WibbpIERNug29gRQTKAxjv+Z4v05R2kedWGRXw==
X-Received: by 2002:a17:902:da91:b0:1fb:81ec:26e5 with SMTP id
 d9443c01a7336-1fed922938fmr44604845ad.28.1721987933171; 
 Fri, 26 Jul 2024 02:58:53 -0700 (PDT)
Received: from valdaarhun.. ([223.233.82.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fcd252sm28201655ad.285.2024.07.26.02.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:58:52 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v2 2/3] vhost: Data structure changes to support packed vqs
Date: Fri, 26 Jul 2024 15:28:21 +0530
Message-ID: <20240726095822.104017-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726095822.104017-1-sahilcdq@proton.me>
References: <20240726095822.104017-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62f.google.com
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

Introduce "struct vring_packed".

Modify VhostShadowVirtqueue so it can support split
and packed virtqueue formats.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
No changes since v1.

 hw/virtio/vhost-shadow-virtqueue.h | 66 ++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 22 deletions(-)

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


