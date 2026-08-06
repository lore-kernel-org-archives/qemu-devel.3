Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F98AC5AC81
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gC-00044T-P4; Thu, 06 Aug 2026 16:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4g8-00041X-Su
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:02 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4g7-000516-1l
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:00 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1808005a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048018; x=1786652818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kmPyeuWz8Pt7P5vov7sIiPPIHc2mQKkYrZZFQcAkq6E=;
 b=fOvLSOYzgWZh0CXTv6d0caOvyb2Z993XRlMGDBKzCziaG9Dj0I42WQaE1o10P03/e6
 V+pk+yE2XMO8NWQIGj1CNuz6YUBeLGoGgJ6C1ObJ+9HjcXsIzJN+X3WPQJIb1W8mrJVt
 V5zC9Z+nqL1Ku4LZaAnmNazuAjXNApIshL4u4TSiF4Y1J4zGsok/vdM2yOdWRQK9x1BV
 PAbsbn3M370ZmROzihzHJZUjwyY93gNaeZ3P8lJ5uN5SEyr7DELb9eMLHnrMavgyL+lY
 JpQFzTdQiECgAACT/dyMWwBq7Wx8+tndovpTFieSIG0qakm55AioEXezymSbwjHtUmXc
 ZB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048018; x=1786652818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kmPyeuWz8Pt7P5vov7sIiPPIHc2mQKkYrZZFQcAkq6E=;
 b=DvPtE2A5vWF7HBhM1lsxhOXpLn9t9SCorG+NZvNXsz42i20ofFOqT35/V/LUbyuSfA
 adwDKRpqvK8K0k/5zLs6cmzCRqDd/Zx2AbAfu+BN1y+GvsFEhGjCnxsJ/YdtMTmVoCJq
 hEryGI7iem+zyIZwUQAMLL46u0LV225Y+scMerXQ1RZkqn/xV3lhmM86GrBSLLYkLFKk
 KsU2AYMIzZGTCklMUXKy1GDJvnydqyh/5Rg8nxqRZ4N9NBeOpEMXqrVz9lB+GVYUqv8c
 aQgEkxt1jpqP0Lcn2a/XOJ9FD5BCPpcFxXLrlc1Jn1pyK/yEYSmoz5srfx4aanv44Gpd
 xb7g==
X-Gm-Message-State: AOJu0YwDnzbZYeS/v6R1L1nAdp2uKOr+9Usoej43zQG3HGNu8oxTkAGy
 5Ass/Z2S8fyxokaCoAukm6UiWK3f+x5sJqV7bSlES4JuZQdKHe7WSug0TIkndbKUL0DcaavA
X-Gm-Gg: AR+sD12msqyT6kbz76LuPOuk6y8xOqpyM1Ny6oRdErgi0yiIkZptO8E7dcAOF1sa4u0
 HkMsNCiCT7upSzGs30GvfmMXYWjCAsP0ZbfUGJBvmiQobR+8UapIfsxw42V2KdnQahMYB5MnPF3
 76IKBPPv5YY/iuzPIC0J31mBa5YYPSpzhj0r0D7VoRxEoQCeKDztNcb7U883lC0Qg0aPYXVQWNO
 vGe2Se0B/9KgXevpnxCDzZCA/O4Qgk/8iJoUPhiOqQd83Tm7E4r01+iKgw88LSlbkwtyn8O7uhG
 1L87nFb8qPVV3roDmLmBVt9pUkw+C+yxjr7NV6d4iWPSe2G/DTjT9Ztw+Y7AMuSmQDslLWArY5C
 atOlXrHJxQR8hYAnVp62Qr1WHAO5Y8O8VBCKH/8IGX2R0J0LBUo0jB1X0F32WrW62GJrHdoQNu1
 VQMml1odrOwHv2MzFuwRotFWYvM9vj5OEK+sU+J0rOsxHCi0xE0d8DGb5nuFUz2TEY4hQOcdVrG
 Ilji8i1r0TYxg+s
X-Received: by 2002:a17:90b:5343:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-3909d9174b2mr3985296a91.19.1786048017494; 
 Thu, 06 Aug 2026 13:26:57 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 08/15] virtio: track IOThread references for thread pinning
Date: Fri,  7 Aug 2026 04:25:17 +0800
Message-ID: <20260806202531.243806-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 4b2cf3d52f..c92c0d39e9 100644
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+        iothread_put_aio_context(conf->iothread, &io_holder);
     }
 
     g_free(s->vq_aio_context);
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 26ecefd547..c71f33b41e 100644
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+        iothread_put_aio_context(vs->conf.iothread, &io_holder);
     }
 
     g_free(s->vq_aio_context);
-- 
2.53.0


