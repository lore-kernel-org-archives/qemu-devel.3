Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2560AF459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQT-00076D-4b; Fri, 10 Apr 2026 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQR-00070q-EG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQP-0002W2-Ln
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso1777941a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833536; x=1776438336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ccoofNrZf0b3d/nWoo3fwp+WZHm2ASoYUOnT7UOhwQ=;
 b=Wqo4meYbFzIIyHs55rxrX2HdZ/l+khCiP60xVrx21mGvWZYnY/YEpI7N2SDn6Zi+Ss
 voYYTyBIiwhwMQQW6x4XRJ7FMyWqK4lh7M3opb3OLNZt6ydixL4JDoxdtkoRTJyoIbVC
 6lrqA7PU1bTMltmiZrgT2F3QJEzAHUoBGraAymxVLRMk9W2QnHezK3ImaKGB6w0OBBA4
 7vHC8dPIBHsommiQzy1K3T1jO41v1XdPbFfKSsgaFGUGVwQfy6F7WicXjRyrsco9iIQP
 SB2jwllp2aVDeaKFHf4Ht5SOtRQQwnnvdRG96Uz69GXxVbo8GvXUo27QOXW3MOqKT7tF
 kAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833536; x=1776438336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ccoofNrZf0b3d/nWoo3fwp+WZHm2ASoYUOnT7UOhwQ=;
 b=E4wxWPL9aDSqzUw4ubeGmvmCRfLABYQQk6vd0EJGqp0j9PaL9YFdRIquqdPyszfaKs
 +aaBFH/sIRK6gDR6u9inS5qf4dVgkWjETWKY+vENWgzji2SiEJx2Vh8W0E4d0cKHxSTn
 7evu5OxqMKtv4s0R6Ee7cAXaA6El7ryVWqU/r+p1nczHcl+mE95QOYFXgSgUt6CXn1kj
 YTojivtJO1mLXe3dbt+v4nt+UfDTOUPzB/HPgoGeuhyH733ex2gvbCfTtWMr/9bFr2Qq
 qk4ypAOmNwpeIbo/6+k+/26PrDU/FXR/+kcSTTZUObmeeTqdIkq09D7j2kDfjDJr+4Ue
 FYKg==
X-Gm-Message-State: AOJu0YwDRPEnmC0stKrB9v0ASl4cVEA4zy/c/XjLfJexPNkpOromz3Ix
 SwWe2UCZ6OuOErf++CcFc464BPhZp0wG2RDUX6d2qDgl4Sb/vroabYZNIgC76El+
X-Gm-Gg: AeBDiesjRqi2Pgz2dnmkDoqHSlA+YVOMdxLMMk2pQOZRZBL+7KpkLSvMqpgtRtOqkuE
 MVUNsNx6wicI7l91sm3i3Z+oHczMOJ4iUu6Yy3Tl4wUooXSsKN60+k1jJIWes9dssXD0+EXpwZB
 1omvse7LmqwtgfV7UFyHl8NrJ8ZGhXzzHAvfg3sjyeRAXM0Kh6ooWbdKsvTR0IaqQRAStOxp0iM
 Tg3wdnsczfbSFWcbniVCCHiqiys2zNe4pUfh2+Eg3c9tAQHAH70rwzCMJWEKhyfnDpOkXwzuvln
 eP2rr0lytEUJPoK5eKPDuzKbiI0YgmJf9p1NqSLKEsSLUeC4MvNO2YMfCEj5gUbrpmzxTor5BDA
 DXu6rqC9GtblKtlRX/5qehzioX/CfgHIkqpH/L2a4kSfzPSNglxfKUodG5Dj1cHp6dGch5/OfH0
 jvJEE5WYGMl0QDGKzZCojYqmqIWUzy4bcSGvN0+z3g58wI+HJhlsqV
X-Received: by 2002:a17:90b:2684:b0:35b:e4f8:7ac5 with SMTP id
 98e67ed59e1d1-35e4276f4fdmr3702742a91.7.1775833535521; 
 Fri, 10 Apr 2026 08:05:35 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:34 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 07/14] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Fri, 10 Apr 2026 23:04:50 +0800
Message-ID: <20260410150457.85190-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context
in iothread-vq-mapping. This allows tracking IOThread users via
the device's canonical QOM path, improving lifecycle traceability
for virtio-blk and virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c                   |  8 +++++++-
 hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
 hw/virtio/iothread-vq-mapping.c         | 11 +++++------
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ddf0e9ee53..762714f4ba 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1453,9 +1453,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
+                                       path,
                                        errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
@@ -1487,7 +1490,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list);
+        g_autofree char *path = object_get_canonical_path(
+                                OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
     }
 
     if (conf->iothread) {
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c2..26ecefd547 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -65,9 +65,11 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
-                    vs->conf.num_queues, errp)) {
+                    vs->conf.num_queues, path, errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return;
@@ -94,7 +96,10 @@ void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
 
     if (vs->conf.iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list);
+        g_autofree char *path = object_get_canonical_path(
+                                OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
     }
 
     if (vs->conf.iothread) {
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 55ce62986c..c993281d7f 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp)
 {
     IOThreadVirtQueueMappingList *node;
@@ -93,10 +94,7 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
+        AioContext *ctx = iothread_ref_and_get_aio_context(iothread, holder);
 
         if (node->value->vqs) {
             uint16List *vq;
@@ -120,13 +118,14 @@ bool iothread_vq_mapping_apply(
     return true;
 }
 
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder)
 {
     IOThreadVirtQueueMappingList *node;
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        object_unref(OBJECT(iothread));
+        iothread_put_aio_context(iothread, holder);
     }
 }
 
diff --git a/include/hw/virtio/iothread-vq-mapping.h b/include/hw/virtio/iothread-vq-mapping.h
index 57335c3703..0d39caddf3 100644
--- a/include/hw/virtio/iothread-vq-mapping.h
+++ b/include/hw/virtio/iothread-vq-mapping.h
@@ -17,6 +17,7 @@
  * @list: The mapping of virtqueues to IOThreads.
  * @vq_aio_context: The array of AioContext pointers to fill in.
  * @num_queues: The length of @vq_aio_context.
+ * @holder: The QOM paths for attached device.
  * @errp: If an error occurs, a pointer to the area to store the error.
  *
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
@@ -31,15 +32,18 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp);
 
 /**
  * iothread_vq_mapping_cleanup:
  * @list: The mapping of virtqueues to IOThreads.
+ * @holder: The QOM paths for attached device.
  *
  * Release IOThread object references that were acquired by
  * iothread_vq_mapping_apply().
  */
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list);
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder);
 
 #endif /* HW_VIRTIO_IOTHREAD_VQ_MAPPING_H */
-- 
2.49.0


