Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E963606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BA//82Kq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvm-0006v6-Si; Wed, 28 Oct 2026 05:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvl-0006us-Ix
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvj-0006hL-L2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso5919585ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179606; x=1793784406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8NQuvScWPv6bnvpxQaV6jKoAN3yBXqmJVtB7VTNiBkM=;
 b=BA//82Kq6hs6MoLoK2TBOynwwGtH4+KLMzs+ZMSH9uSEdOyvi5NWVlZn8IFPyoeiOn
 6oxjQ3Ic9GYyMD65bfO+xEXIOrdAyy2aLMIxj7oyMqjDafp4XOuSFkmPdcig5RngiMXr
 oZgjqHAjtU9Izwr6tegpRimJGS4IFJzWZspIwDpC5SxBnKTKp5Y4PtUUWc+aVAxl10F6
 4YCWTkGkIEIBPC+N46VJuAgM5lCAg8JK33Xo/QTZSztn2FAQFifdEHX40vXNefHrUMb8
 iFWR85bdXh3Q+k+C8etE4w0d8fdUUVax30rf+D21bPpw49OfW6qoFLGKxeX1lr6uufHA
 bnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179606; x=1793784406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8NQuvScWPv6bnvpxQaV6jKoAN3yBXqmJVtB7VTNiBkM=;
 b=pngue09TnBomFyhCAlyvp3AfHDEbIbV7WgS+dvPL1z23ut2xT7oW+3aFNEP2mJsWmH
 IK7lqA3B6FJ4Uy2S6E5e2Mn56UcQIjdbjYaZLLK6xCJK810aLK78iSsvZ7il6EUhDoqZ
 uIzaIxu5p8u2NiujJfSMbnXO3uV87JD9Y/ztRvO917HAMPv2jRrHK5mwF305D+uvd+03
 WbpyofolHrrg3ZKAk9XuGNV0LNqO0sB/BwvHZkJRTmj9bTZXond8QceamY0CmNyYAqjv
 1NkWmy0DWNzhfvLU4o8d2Xxx8Olxji4OonVueXg+cJ7gBfpdYG0Tr/ivgfXwIVqvQNcG
 /XyA==
X-Gm-Message-State: AFq9FYIP/08HORiJFXyjAWL9krHS92Oteto0FHeBAkL2dFllwJQ1R/qp
 F1TGINtphAEVhIuGbtA86ON8HdLfsYR+67Ex+Ooj8EZ8HJsExHux+jIAv9hmu5rv
X-Gm-Gg: AYBFou0KIQGGJJe8jrzxsxzWH07tTQuMBuwjUEs02ABUKQlNKnfwby1Gv6UOTpb8x6s
 9PI2EEecCX5M5CUx9gKYb/nS7bTtZrngFXq54xwsu82HbaDVqMZrbCLyZTZA0CjHkeMIAQhoe8H
 t86KVg9W7q5dLBWup4fQzCuW3HIfsm0+qMdYFcTT7mN4xRLmEya4GhUY8SbltKFs2RjQe1uWFWI
 q3ZGacyiyvg5esyNmiHayVJNqiJ1oijEIukShL1umBiUHu70qxL2Vv76djEzAyUgUhEiFYdQupg
 niTldXcCGpJsPgJYg1W3Qj7kuMUoMnG64y03kK2t2VBr07nE3z53ayqZJvizZp0IXZTfyI5TYrn
 GuZEBv7bN761Zx4bpg4EOAzRdBYiRvCa2RR3m/8PlnzuXztul9fKgBCcUA3K+AyZDA5nnX8J6oS
 BbftVKjYXHkUinUcJVucoienY7HKu/GRUfPxCWSY8z14mZcHPrfABQdpn8lkiCJugplkGjYZUmB
 lMH6v8hN3jZBJZN6pijQOvvRqjGhs8oNkWKdXchKYSo7HULf7WEA/ieeuZwbRPbtbxlBEf0TuXy
 9/tg2N9PhWNryKjWVfZ5kQzT1prP5/qq8i/oH0pOCqtJVIMv3PxZvyT/mUfr
X-Received: by 2002:a17:902:da87:b0:2e9:628d:e9c1 with SMTP id
 d9443c01a7336-2eb003c916fmr18381995ad.26.1793179606160; 
 Wed, 28 Oct 2026 02:26:46 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:44 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 05/14] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Wed, 28 Oct 2026 17:26:10 +0800
Message-ID: <20261028092619.1654474-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace raw object_ref/unref calls with iothread_ref_and_get/
unref_and_put_aio_context in iothread-vq-mapping. This allows
tracking IOThread users via the device's canonical QOM path,
improving lifecycle traceability for virtio-blk and
virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c                   |  8 +++++++-
 hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
 hw/virtio/iothread-vq-mapping.c         | 20 +++++++++++++++-----
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 iothread.c                              | 13 +++++++++++++
 5 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 536d71a91a..a960ae21f9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1575,9 +1575,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1609,7 +1612,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
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
index bcb6e44133..ac13f4a1ca 100644
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
index 55ce62986c..60e1d55005 100644
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
@@ -93,10 +94,13 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)holder,
+        };
 
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
+        AioContext *ctx = iothread_ref_and_get_aio_context(iothread,
+                                                           &io_holder);
 
         if (node->value->vqs) {
             uint16List *vq;
@@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
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
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)holder,
+        };
+
+        iothread_unref_and_put_aio_context(iothread, &io_holder);
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
diff --git a/iothread.c b/iothread.c
index 5a4291a2f0..5694e91bf7 100644
--- a/iothread.c
+++ b/iothread.c
@@ -376,12 +376,25 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     }
 }
 
+static bool iothread_prepare_delete(EventLoopBase *base, Error **errp)
+{
+    IOThread *iothread = IOTHREAD(base);
+
+    if (iothread->holders) {
+        error_setg(errp, "Cannot delete IOThread '%s' while it is in use",
+                   object_get_canonical_path_component(OBJECT(iothread)));
+        return false;
+    }
+    return true;
+}
+
 static void iothread_class_init(ObjectClass *klass, const void *class_data)
 {
     EventLoopBaseClass *bc = EVENT_LOOP_BASE_CLASS(klass);
 
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
+    bc->prepare_delete = iothread_prepare_delete;
 
     object_class_property_add(klass, "poll-max-ns", "int64",
                               iothread_get_poll_param,
-- 
2.53.0


