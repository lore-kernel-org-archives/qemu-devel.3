Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503FACA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSD-0005ln-Cj; Tue, 29 Sep 2026 04:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSA-0005ks-SN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:46 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTS7-0003lk-5Y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:46 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1834472a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671482; x=1791276282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+hZDiQJvaOmf+Qn0tSyuAWF2wzjzOq5r5lnSqYHWVac=;
 b=GQpXhWoPcsknuvoiKf3ocH6rj180PVS1dSAX8QPwly6yqcZbhwGwZGGLVcnTt6j1Bu
 5deRHvkYWuvtOCn47a0+WE5wOfa0Y290WIqNrMqZvnHUvpAi8MQPP99HOetywVisxBlf
 ec8An4tA5qGjBs4RYEGh9cd5rhWkvMYxEvxcHH8sOpqbcM/djOL37E5LYlglN4p5O8hm
 nkyGRrpcZmI601IH1yo2f3XtO22Uf0tfrjdDv0ty0J4Vl7g4dGFa1435S8vOO6rJg2MM
 bCucP3tdviNaNZ8criIedq5dWZv8/nGJ+JNx7Ns0DD73+d2pgElns09b9lbxybSVXUQk
 4I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671482; x=1791276282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+hZDiQJvaOmf+Qn0tSyuAWF2wzjzOq5r5lnSqYHWVac=;
 b=HXoM+y6r5byArE58uzZ7S9w4TpDreatDUE65/6l98XqR4iQIGND6SsazO26qa9sgp1
 VVV498tdpweGmWQp5rjhT7ftRdFeq1Xio9a19ZZ0XelAyaqZjpEqpdDK5/3op9z1giQM
 MEPZVap3zkRG9r8i+sKBvZtkbxPYJAEiurkMEKuwcCdmT7P4XKrJk3dcBPYUgvDL9Uoj
 KY30cG2ET3nQpcZp1huZ4DlSR4xZlXr0DdEH0Vi4NroHXRrRspwdEm2F103MQ9h2urqH
 Akt+iDPv/8NckznTpBUb6pfSPD/ksflvj2jS0Zse0lF8pzkneR32ia1b3VyUs7GRIC+o
 t1Iw==
X-Gm-Message-State: AFq9FYKduQNfHlN2dOYmEu0yhQO1HBcj7I8MnvjHMbp+h9c5MZNqd7Qk
 lt4nKF/rzeJTXa4Dcek+6ury50vZB20imJ5u41t4O84K67hYlE6Qi9SNZD5Dh4MO
X-Gm-Gg: AYBFou35fTEstm1w+I4s2oxga+Cg8qOW1voJyo/7Z2+j/qTyMyBJjs0P7zEjpExiGbS
 Yf6Koe6z1091IOwh9Zm56qp5q3BFe7d5fUDQvTwkDEfJOCxYcNzatSN5E0bTpX6tbYF/cZGox8d
 psyHdTmPSFo69reIsb2QpJZl1GRgkduzJsAOFxbBgoz2TCTM/r+efIUuzyoZ3znIGS1xILmuTSC
 BjdgIaL5goiapRXrsLAfGF14Q8CqmaQKvXyljSmtwsh9TCQSjGYQAJ78ShNBHOQ7+h0TzBVePkg
 Fes2oIKXZsU0GQCTSHQdNOIbC1teYBU2iwh6K6FmeXtrpxfTUMO/+gA6uR+Yz18krfcnc+a3TRo
 BymtWHtzJd/JEvwYUcDunG4+jUiTEk6dDeQ5XXQCr+3leapmP7pOfDpsVUus9uoSF2mbX5C6yaf
 2duJUMf/2QFMXwRYB/8PWBggqhJMcYHnZ5U8aTAQX2rL/pAirce4ay7vuzVjU3Ynnh8gqz22Qnz
 /xdd9tYSoYc9sinlBopXguwYzQ=
X-Received: by 2002:a17:90b:2e8c:b0:3a2:b09e:784d with SMTP id
 98e67ed59e1d1-3a2b09e7a74mr3147898a91.45.1790671481715; 
 Tue, 29 Sep 2026 01:44:41 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:41 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Tue, 29 Sep 2026 16:44:08 +0800
Message-ID: <20260929084416.1600199-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x0f.google.com
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
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 61c341ce2c..b2887d74f9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1499,9 +1499,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1533,7 +1536,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
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
-- 
2.43.0


