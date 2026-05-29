Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638BECD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rQ-0003qr-Ii; Fri, 29 May 2026 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4ql-0003Vv-3o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:43 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qR-0002yk-3F
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8587427468so61894a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090457; x=1780695257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDuEBYp+d3GMQU4EUX37XSBsPRXEyd9vBacPskZ6gvo=;
 b=VkpSL/VpmZIvWc+MRzhrdBuDQLziVk3UI7pT7ZElMSoffZGHN6pL2LYKvuIskd8CnX
 bGaeQPrIiQCE8rxYCaNvUCUSc/qvfG2vPz2KwMwZC2NizMmVSMayA+XfPBoFHjVMieOk
 j39zDySQnD2HKokMTp3y5fNPBO15nJdqdLiyPa2kaIdpzVh+af4GagJ2OlBqS01USPCB
 soHwui/L1zsSnZiF+ajQMDDPq+TFqOcer2AilNoxZMQyHfBGGWcXlioN9dwPV6piX14d
 pEC5YnZe24Wp6mcLaDOcSCqyvlZ5FTYeo2d75AMJ7zrULdpQudZroR5xkmPhzA9X92XT
 hmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090457; x=1780695257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDuEBYp+d3GMQU4EUX37XSBsPRXEyd9vBacPskZ6gvo=;
 b=ZFI69TRebW/cvallMa0Fnv2O/HPdr8XK3UA+O5wPocFudTjA2drOw22B0z3/W4eAoy
 5WBZf/XHNm0E+emtwKyWESNbEEQk0Au/ze3Timnot5nMu6z4lCYRPy3DwhzqGuw4aFad
 D99GhgeZYliXDMxc1bbokwp5dACmnmt5Aqml9P0G5G3yRdk8PP8MMqYgnqsKTDNtv+Iz
 b6lzGetDsLIYroz/ulEBKkLWhVE+ymgBHFk7UT9LkxxjY37Al9H7mt/juTMpNPHdwMYU
 9elNVcYNF1/YWbRGnHHWr4kfvsOTX48zWDCGd6yvGPWuupXJT+0sdm0eTTDVQXkwNbT2
 Y2BA==
X-Gm-Message-State: AOJu0Yysy8ROLNBQ0iONEh+l99ImQWsJtfIQbtioitmKwaYv8NcU11oB
 8llJi1pLK1xisi6B7/9TyxJgYljTAALm69zJb0p9Imy366VQWHjCzB33mgkjqF3MOAM=
X-Gm-Gg: Acq92OGURkR7SqURpwOSL9hbE/grdjROnGO8CmfpQKHTT6ln65RQbHiswaj5xKlLTFX
 3hndKjDMjDt4lJqVksPmAGhm1wqJL40cXnFdUJp+3mxaVyd0EziG1m1OKiYuK5Z5G9uMDz6Gll3
 vcPqxfDiBHqJ97884QepHjq5tG5ijZb1Fv9DedxFKRgoUZz1gOBV7u/WnIuD7cAscXHDAup0aT0
 8QxNqOq7JxxxOpnlwTED5YdN663PiuVSE601qPL/pJ+a3+k3562IoTOhYvDPPbOXcEasxfX33lO
 1Lk0TgPJydicmWyZ06IbcbWjibgKeDIKAvOZhS9FAOihlEYZSWFxfufcLl2vg9e02ATlPRnWBDU
 ZAnzPBRju71vFy1/laBtlH18FhPgcApeHRl7vBBVzag1DLyvsyPkVZflmyUqNFg0n0h3iiTy3u+
 MmPWlE4ojjSayoS8vw79kbtapD1bsa0xHQCjVTG84NyRqivx3hiwu5ZbeUOnG3ZjQfmbDto6BsH
 A==
X-Received: by 2002:a05:6a00:2188:b0:842:21f0:5114 with SMTP id
 d2e1a72fcca58-84225445d05mr1251886b3a.30.1780090457308; 
 Fri, 29 May 2026 14:34:17 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:16 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 09/15] virtio: use iothread_get/put_aio_context for thread
 pinning
Date: Sat, 30 May 2026 05:33:15 +0800
Message-ID: <20260529213321.96271-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x531.google.com
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

Refactor virtio-blk and virtio-scsi to use the new iothread_get/put
APIs for AioContext management. This ensures IOThread references
are tracked via the device's canonical QOM path.

Summary of changes:
- Lift 'path' scope to cover both vq_mapping and single iothread cases.
- Replace raw object_ref/unref with iothread_get/put_aio_context.
- Ensure consistent memory cleanup of the QOM path string.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c           | 24 +++++++++++++-----------
 hw/scsi/virtio-scsi-dataplane.c | 23 +++++++++++++----------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 30e9fcf870..d8dc1dd136 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1463,6 +1463,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1487,8 +1488,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1499,13 +1498,15 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1520,21 +1521,22 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
 
-    g_free(s->vq_aio_context);
     s->vq_aio_context = NULL;
 }
 
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
2.49.0


