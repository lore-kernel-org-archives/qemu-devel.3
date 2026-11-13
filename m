Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DD606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cL9NDo6n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYc-0000eW-5p; Fri, 13 Nov 2026 04:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYZ-0000dn-3S
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYX-00060R-8d
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e946155442so11636295ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562008; x=1795166808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jbDrwrBOQNI+7OEvgHCHB9D+OfHuqKqpedokOfaVpMM=;
 b=cL9NDo6nV8eihfDRqFtFf1KsAnj+xawSpoMmXEEFbp1sJnqMimrjOtJs2H4KE196wW
 6xj0YCkiJp4fbuvws8vmgVjEY3h7kCkWo1Ix1Afk2VYpxeSV0d+rybNLziBn9Q4llufu
 NUy6nEZUHWw5b2291QKZT9l8MfWt1tSsc0oH+/QM8SRsy6CMTPi7ROaip1EpOtjZZ8r8
 5VNdIoa8gBk7aQfXwJnzC6tQTf00EVsDTOyQWiQMPFTetSrA1rG74F/dUcMukpW0rhqj
 BT+DjD4g7LM/jMNNqEUQiK7OeCS07XmhSOZYsrqTsMbOcx96o16q7tTwGlR0t69DMmHU
 xKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562008; x=1795166808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jbDrwrBOQNI+7OEvgHCHB9D+OfHuqKqpedokOfaVpMM=;
 b=Yw3IUwwP5c9Nn4nUutdcZAJ4fDLVjCzffKf8YWy6ov+N8EhRAdGLYS4AkbZgs4GPYL
 chFtIdmfWFJ2upltZz/zcl/4Br38xDFvYQ0zhDSSjUf3UyoJ1y+2Orqpuym5RCPr7uik
 QM6N0AU5KUc1dV7PHhrYmADFVh6RVPTWporUhIGYK8vZowHBHe9/NNI8K1V2f/Qz5wR9
 M0aQ2TNgrKOTqxDHBr26+usI1BpdQgK2w1tzn7It6Q8Cyt3w5wLKn3Zr+5FnkUfO03TW
 A3ICP7+5mN9l7zyFZ8vmtftDlQ0qWr49ZfLukQSryZsHhL7n6pD3SKTYdG738myydCGB
 bzhQ==
X-Gm-Message-State: APuU4Z8M6RQLxuxaVTMuzpsCCgtF8M+hiJnyx5hHZz3rEaeprXGp9puM
 tuM+MS7b+pojkhJSB2pN0vwukW3STWqKMIsVIlsdgBZzwP8zcjgM6g7UMxtGbwVY
X-Gm-Gg: AYBFou0RIyTYAHoK8Mc0wJZIuDpKovMIM4ugt7c6WlZwndsMEk1sN+bkuxshSTjg6P1
 4t6aYHwIiuEYJBVNm4C2I0SrKTZjH/PJgmFEjxF8EG0xl0rH8Aom1aXV0wcn4N0r2ORhpJ/2rhg
 EySNobbq2mlToG6bXLRIELFHvUAp6AOiv5yqYlO0I2lRp3yRjWgDMnL3Pcjpwsdufuox8mTzlmS
 QlbRQQ17Tmb4dO/1JaHKN/miNyfxQtHr+25fthHQCD8a8pYKHcZwCxDlon5vPZlsqT3TlKKsGJF
 WdCxOrasiMg6KZZ3yvL+RMMOdiivVnbmaGG815GJayku+v15EkiDTv/5n/lfN4TPEQQHYPaJTRG
 zGn62DcV+QiyCO5nLhUPZiqbI0xHv2sZ2cwm5LjVlOXOGpMlQF5SozTXCjnO8PiI2Gl52UU5O9K
 QOksZh/GSmxiAqHEE/Wdcs67+GAdXmm2uWoqIeVIiZCudgViliJBVHJQJg6yrzlqN9wDpv997Cu
 kkxWab+M1yPMX2uO1FZ8CHmNfxPURl7yvP9uG/xbHzXXnAQoJy6XpUeh3dDJC4i9XPKJ9voCMIE
 y1dh296yeI8cFVxqBAsbz4E1rlHPHaNfucRNcnBPzBRHnPkGYdfP/ffh6+DY
X-Received: by 2002:a17:903:249:b0:2e4:b112:14d with SMTP id
 d9443c01a7336-2ee0dcc6572mr18688915ad.54.1794562007768; 
 Fri, 13 Nov 2026 01:26:47 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:47 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 06/14] virtio: track IOThread references for thread pinning
Date: Fri, 13 Nov 2026 17:25:57 +0800
Message-ID: <20261113092605.942292-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
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

Use the virtio device canonical QOM path as the holder when virtio-blk
and virtio-scsi acquire an IOThread AioContext.

Replace the raw object references with the holder-aware
acquire/release helpers so the users are visible through IOThread
introspection.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c           | 23 +++++++++++++----------
 hw/scsi/virtio-scsi-dataplane.c | 23 +++++++++++++----------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6d1d19fa64..933f147ab1 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1589,6 +1589,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1613,8 +1614,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1625,13 +1624,15 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1646,18 +1647,20 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
index ac13f4a1ca..d66946f279 100644
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
2.53.0


