Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFA6C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Szh-0005jI-JM; Mon, 07 Sep 2026 02:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szf-0005io-3z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szd-00069B-9o
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d7195706f1so34063555ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763091; x=1789367891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GCwys0A7wABlzdjCSJp+U9W8UOKwT+jGbbtakz7i/jE=;
 b=TV4u1iDgmnk75lDAMg+L9gpLB65Y+p3rPzHXDbt1scoCbMI0D9fxkcnS3ChVoJk89T
 GmcSlh+ytA85ucKe03Jl6FFR6/6+tojUD4hXw8HBRnSLN8SHtgCj46Ye57uDMI4Cz8Ah
 244lF4ypBaQtaBO/iyFbillvEB4Vpt66eL8b5HPdvIaqR3qZTd1Jvwc35ZuiKcP1HT1y
 KNyg2Wz2VGE0RHq8qHWs3j3jlj4HMwWmGxPZTPaN2SSAyxO3CIeRkhKoumU7QuZsqixp
 QrbOb5jXuCpbWZUyV1dS5qC6tpBLXo/HDronSYoyAO8XA8KY15T0eL2wjG2MgOwKrfWa
 MoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763091; x=1789367891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GCwys0A7wABlzdjCSJp+U9W8UOKwT+jGbbtakz7i/jE=;
 b=DOdnezJIaMp9RDor82JrE0wdjaxal+Shyqk6H3mLWpyT2/6vWtJ/5FjJHmP3cW3ziR
 zQDmGjq1b3wg2s1ttzbFBpIvEZZJ4poz2hCfYe8ttk5KJlSWUAARyA4aNhS1jFhR72t4
 uGrn/pKvmA+E0T7dKLnD/u9IeeE47teaoXzgGhu5dmIsl3ZuvYV+PXegNNMZdgx8qh3A
 3xuN1NiEKCmWnXuleokx4DqaYxVQcD/Sgxwv774o6hD3JfoVE8z2TZmnp5glltmBULqR
 ic/s7zqgR0G9QNmqH+bK6jKFMnMFRzG84juOS3O/87JzGu6Iqi8F5Kg1eUZjtQS+nf/Y
 pi6w==
X-Gm-Message-State: AFuF++mvdUDUWnmpj4S0spUcVcMr2KkkpgPqqXp4xNOQsuM8Gg4TU+V0
 18iefZb2sb4lMXa30+Bpc6rX8+9fYR2hqCmWAI7V8OJwVhnCj4wtgo3S19TFIP2Bgaurqg==
X-Gm-Gg: AYBFou0t/dVdFNSfbNSppABpCYYYgEQThnNZJUoDYToZmgdGnqV9rV1gaL4jvbf5RdK
 IWhxm5ytOE3MDgMFLJjbamNkumZeHHmkzDREy7TNRI2xuzcXCvah8KYT1n3PNQRguFpIlo+cqGf
 Jq3E202J22F9k/B8lbyMxxJHXdqux2riDDc7PLW11SBCTOVTLuYLNILp871MaPaiyDsdtQPMisr
 5tVfW2uR/iPwiIaapelQfXvrg/NaXxCS/HY5LSk+bQXAOhmQOnei07o2ScKYDpx5lCg8ILlgNkj
 EIhpOr6fxNAl+DHkMWmAPLuJ0rZs/m1XdHWnFO22mMgZ9jmZhhV2VF60FwEx20SnZfMySKkYjTs
 k/pW2IwQ6w/YXpqtXB+er76C9ebriK0mJ1eF5sdgG2SIZg6gT+odHdKqUND66s6fhEHfW5qUSkI
 OLc4c7uK+4vppdmO7XPd/rNg/NyGrx9OqWZh0RmS1mPhmvYQfQot6UhA4VvDeIGSsauMQS5Be41
 3j9rp9laOg9ipv4
X-Received: by 2002:a17:903:2349:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2db125a5535mr309971395ad.2.1788763091497; 
 Sun, 06 Sep 2026 23:38:11 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 07/14] virtio: track IOThread references for thread pinning
Date: Mon,  7 Sep 2026 14:37:18 +0800
Message-ID: <20260907063725.626685-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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

Use the virtio device canonical QOM path as the holder when virtio-blk
and virtio-scsi acquire an IOThread AioContext.

Replace the raw object references with the holder-aware
acquire/release helpers so the users are visible through IOThread
introspection.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c           | 23 +++++++++++++----------
 hw/scsi/virtio-scsi-dataplane.c | 23 +++++++++++++----------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4b2cf3d52f..db7f513da5 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1469,6 +1469,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1493,8 +1494,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1505,13 +1504,15 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             return false;
         }
     } else if (conf->iothread) {
-        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
+                                                           &io_holder);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(conf->iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1526,18 +1527,20 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
     }
 
     if (conf->iothread) {
-        object_unref(OBJECT(conf->iothread));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        iothread_unref_and_put_aio_context(conf->iothread, &io_holder);
     }
 
     g_free(s->vq_aio_context);
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 26ecefd547..55bbf045ce 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,6 +28,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -65,8 +66,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
                     vs->conf.num_queues, path, errp)) {
@@ -75,13 +74,15 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             return;
         }
     } else if (vs->conf.iothread) {
-        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
+                                                           &io_holder);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
-
-        /* Released in virtio_scsi_dataplane_cleanup() */
-        object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < vs->conf.num_queues; i++) {
@@ -94,16 +95,18 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
 void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
     }
 
     if (vs->conf.iothread) {
-        object_unref(OBJECT(vs->conf.iothread));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        iothread_unref_and_put_aio_context(vs->conf.iothread, &io_holder);
     }
 
     g_free(s->vq_aio_context);
-- 
2.43.0


