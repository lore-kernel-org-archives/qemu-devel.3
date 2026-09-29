Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E0ACA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSE-0005nV-Dy; Tue, 29 Sep 2026 04:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSC-0005lH-GC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:48 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSA-0003ls-LH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:48 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so2612231a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671485; x=1791276285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQ1xMXHGriuVI38M0jNZNv0jqCh3rYIFg5oTVX3Y34Q=;
 b=VBk1/jDA5BOFRFkfiiVCMpAgjLOQnJ5RPegf6rxgEz8dUpKup1LZy/33dQH0nhelv1
 wtBLWlyR2T9m06XigdChn/hTq4S/cP6VrDklbwkv62hc02YpjiLNAbE+D5mjL6nbCA8y
 uD278xIAMtFJf1f18DQvcm0VDHD7vWIZEfUHxt7sQKuaGNKXzXc+i++ol5Ga28cSKMY8
 c101XObWJBp1bK9ypL0YjktGNhgdKSqrz3NWYLy2g/+n6PSPPlPsLLdeOU2a1810ydct
 1Yh1d5h9GsSOI/XhhNqTLJbCCHXZ7m7sL2+GfntHexHvg3DWjAcQVB7D5V41rQ+J1yAD
 RgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671485; x=1791276285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQ1xMXHGriuVI38M0jNZNv0jqCh3rYIFg5oTVX3Y34Q=;
 b=zVkZviKV9KTY7o5gRplQC/btQS7+l6nbvsUOwwOh9N88UonqIj8HN7a95K+VLP/BXf
 MOGZLESAMucR3rAIf2xCrikHRLaPQJZOOlwqC1Opr0N/A2P8BwWUONK0d4elXsPSc8en
 GItcjDIUP8P62AXu4nvZ8cNwc23nhlZ82dmMBKS18iyjIJkGWUVSUkkJdmIgIwqebV8U
 aBywqvBzdR/eUyQ5CZzvjLdot4wFi7AuhkN0gAYBnBypA6LjK3e6Q0FPxir+EoXfRI+y
 mab54rWO9W522v4Ufv22Y75ODvEGtf6NmFIDUaX0itCbu/LkQV3S5hOHh6AHoPmyCR2Q
 h39w==
X-Gm-Message-State: AFq9FYLJoKjYCUoDjsCZm1mTEbkAytoAZRd5sNIBjm/R6G+6X9PXniuF
 NrCJdBUb/4QqvgiUtq+GsiUGHnf6wHseXA4cpxPlSl7uYuWK8WgfSFxkKiO6W1oW
X-Gm-Gg: AYBFou1gJpJNCbrtRCGQpZfKHxLCe0I2wkkQrtQiAMOktO0XUW8yYt99M9fZIl7Vm+m
 ndjtVSWsjjHKtEXkc+xyMhF6p/1mW5DdEzTk2LEZxizIheW71yT89ihr0Dq5LJ3U08Vv0f8BhIB
 2aTusWQYEORsPFahISZEDqeB0LWG+POeE301DW/AkgThBWTBxQD48yzhfv9R3Z3jvlsd4GU5RRy
 JogaAn6w31+NuTHrsuE35K5UabxO4cfLYlQUbWhvkCbT/HPb8mX10HlByiw+Ss9D3X0TkH519YU
 PMrvb/kurIUmHFo0pK0mYvHVLnFLFb/43ffFTlhQ3r83TTvUbXQpud/ceMkiZePwL761LkM27oI
 XHBX+Qbftoi2IDsGg1T3bw+HpA0juC4+1HwBru78n98+L5FzE3B0cv05sGRxkLI1e6FFUQL0LO8
 mhgtkwzkrzCzeeJprtnkxEEvvLfVXY4RG8EfPbOJWuZkBqvUtj9vCZacEc9NDqAyrbOMMQwkUwX
 sN8/qSfBkBY078d0zVMBWERXQDFel6TKrJyGA==
X-Received: by 2002:a17:90a:1c89:b0:3a0:a259:c67d with SMTP id
 98e67ed59e1d1-3a0a259c7a2mr8454750a91.20.1790671484804; 
 Tue, 29 Sep 2026 01:44:44 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:44 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 06/13] virtio: track IOThread references for thread pinning
Date: Tue, 29 Sep 2026 16:44:09 +0800
Message-ID: <20260929084416.1600199-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c           | 23 +++++++++++++----------
 hw/scsi/virtio-scsi-dataplane.c | 23 +++++++++++++----------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b2887d74f9..9f567f4c65 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1475,6 +1475,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1499,8 +1500,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1511,13 +1510,15 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1532,18 +1533,20 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
2.43.0


