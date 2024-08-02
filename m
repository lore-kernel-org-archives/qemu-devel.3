Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8662C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqMj-0007NC-Oy; Fri, 02 Aug 2024 07:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMh-0007Lk-D9
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMf-0007Ag-6R
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fed72d23a7so62201705ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722597747; x=1723202547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyC2BLuXP5sFjH8Ztz03XnFHAotL08YDixT81uIemh4=;
 b=mUbtnrQVuTG0DkJaYA+be5QrKigUzwxzOnm8UEJDG+v7zzlkZUl+Ki2POraA7I9pK/
 B+YNcagVBpAfBwrF/Ao09GKhtb0brw1no+Sh2x4HRncuZHYKKLt6uw3UyqH3v/MOcpEV
 /BwiFv0F0jACEmSNOKQmHd5ZGnw1g1Cu7R0KNMDLMQSEVh0WAnXcQX+1mWsUyw6hoUyv
 Bq26ciWDbgwGcnVyfPYpUzZ3pa54i7a4RaCvYkf+/1GntOmd6p//FiuahUjRVyKCvVHi
 7ok/iH60E31YefkFSRtKk5laEyStc62Rq4vFvSlG1J5ot2rjthRD+Eah7/szJ4JcfgxL
 96PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597747; x=1723202547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyC2BLuXP5sFjH8Ztz03XnFHAotL08YDixT81uIemh4=;
 b=AHfgct0lzkc6kRwV7Qs5rlnWc4VHjDzxwa/IGJBmXox4JYXd5tLyAFLmLW1n3N/6CI
 j5RSr1xo9s5HtGxHsPffe1zcARQhAU2SuRqGmkd4/puSH6bAI7Gh/SNiLdJeDhuAUbDY
 st9mq2piEQpeIL/WoWb8qElKosGhZI+sXgU+kVqRPEQmnmaVScLQ6wH3lAPUYBC+j62a
 f8EKE1BU1zKkvX7jmItGJMLSoCPxu03RIVR1N5LVZF0Wubg1zexp5FFbxZj+SQZH/Mni
 KcDTeb5kVx84L6oZ7FZPoYiuGLCATqJmJz4wwx+6kWjMUrFo2hpgMty9BgUjx1mkxii0
 69Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Dd5At4CCV0nDlQTlgJjXK6FDZLm0nCtolQ+k9k0kh4KzWtYqWSUpdlhgs4JWkFBPk/pXadqeQL1o4l/EOH5NYSteO0g=
X-Gm-Message-State: AOJu0Yy5c7JBXSsR5NWDchQX5j78Rw7FKVU9e0K7MC+Ym8XvS8505EEu
 thy1hJTq37mqtaUa3fTawCAoSGflf7Op6zLu3bjN9GDJJGmMtAjf4O0+eg==
X-Google-Smtp-Source: AGHT+IFws+o+ly+gd7s/LSCb5p3zoW36HcGWh4dkerD+3A7XPYF9dyu6yR4cjneNy+d67WsQjEcoaQ==
X-Received: by 2002:a17:902:e541:b0:1fb:3107:ec45 with SMTP id
 d9443c01a7336-1ff5746512cmr31645505ad.54.1722597739574; 
 Fri, 02 Aug 2024 04:22:19 -0700 (PDT)
Received: from valdaarhun.. ([223.233.85.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ae4esm14801335ad.269.2024.08.02.04.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:22:19 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, icegambit91@gmail.com,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v3 2/3] vhost: Data structure changes to support packed vqs
Date: Fri,  2 Aug 2024 16:51:37 +0530
Message-ID: <20240802112138.46831-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802112138.46831-1-sahilcdq@proton.me>
References: <20240802112138.46831-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x633.google.com
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
No changes from v1/v2 -> v3

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


