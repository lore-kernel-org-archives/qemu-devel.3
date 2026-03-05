Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15AEF33A73
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9e1-00045B-IX; Thu, 05 Mar 2026 09:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9ds-000415-9q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dq-0001nP-LX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:32 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso1595179a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720729; x=1773325529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AltoX2EHUlkd6Zx1BzAuYk2YoOpvYajF0em6ejcCRT8=;
 b=hhLxWrCeiEKaVo8TKYQUwP+RXm6h9tKAaPQcYuSvzr5eS4oYDdl0DMyjX6pL3OUCem
 rBNDGr2fqTOIKB46tMsrZz0kdtJ0Lu2Dlm8m/7BWdF94Pbg140zDoh5LgcQnDq6vvMm1
 M6d/WoO1rO3xbOXAEObH0Rk0JiSMROY2HVrPmyGkEEoPZNzIWxs+bVdgG/8JSrQvzCAC
 CRgtYmMZHzOi6AX5NH88t7eRNDV30QLLfzNYH3va0iGchVI6lQ/AaydmAOpjay3Y0PT+
 LJez2xhtbWc9ZJv0v1xUFr/dms3+zoBb51urVSdxwizkhUn2mk8SP+eg3CxorckjZ9hS
 TaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720729; x=1773325529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AltoX2EHUlkd6Zx1BzAuYk2YoOpvYajF0em6ejcCRT8=;
 b=WVxuPC06aB2UkCcPHjgR3q2IujqPEMS+4q7qXXG4tXU7XiH07UuaTTBopzslmIxuiT
 BiVYzli/fXL2yj/VHYxC4RlazzblaLqukn+g5PuGADlhNj+o3DANv+a8/Sg0EXdF5c52
 0Eqq1Wl3xqeMfLVzgA+QX6jyNF/LB6s4PO1M9kM3E4TgdMYn/G7AiCI7ajjfVAkxVoCH
 utbY0eTVOviK8kfYk3XqgcDbUoLAXM/7+FQyrX/ITbHD2yJzOU6bBkpTvI3y3vuXkarU
 LJFbAXfa7QVi3FTG0Oki0bL3JypaGe2ceyAzA01SDr/AMe3tv+UcrpeG/cgSa8rXE92+
 ASFw==
X-Gm-Message-State: AOJu0YxZWwznl2wcySJZlZNm0/jtfwQC/SC2+v8hhQ0JVs0VVV9iaM5o
 tIO5g25VMhFf+GqD5QUIuWEwvItX/Fpiv//T6lDPg4G9jUNpug95nXy3hY6qatEsO43iXQ==
X-Gm-Gg: ATEYQzwOlEXb1AAzN6Y2+AnFSUjBzoby9TxW9xLuYLS1cOuRiJvLkMnAXaSr0akgmIS
 rK0PwyN3/C52UEw5OT4EKjmLdBH4kB+jr6RmgFbsm4t4hyK5c4EaKg1+kbOybWgh9Trl8quHEdS
 FNaQgI4ps7Inr/f8KfgHSXF7J1gHhtnUlK/2e9yQTyFeGR4B/AXwFuoGgDLzyNAvsnlAPQ5H8lW
 3mIfj2F6bmYi1MXiVWe4WSkxFVVi8lPLo+TBZvYWWiSTpJCQA+twf0O3KCK/neHf/2kLPjmxmck
 i6A7fQOkaT4qTOzvfRelBh7C1y5P8pB9sJjPqDStWOEg+H7DQOfASMlpwH0ieF6RL/6SCt3GPMr
 BG9VaRvWIp6TLlYYYDMyKLqK3wg/ay+eCI7Y60KBA/5KN7PYhdjIfoUW6kg0ip+isCsOdLY0rP6
 aqh7MstlmDA+PljKV7oZkqXoN4kX7eTIb2+jITb3LfQnp6hH9EgxKaBNIW3DX4EvKA3tg=
X-Received: by 2002:a17:903:1508:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2ae6aa365b2mr53009305ad.21.1772720728762; 
 Thu, 05 Mar 2026 06:25:28 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:28 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 06/13] virtio: use iothread_get/put_aio_context for thread
 pinning
Date: Thu,  5 Mar 2026 22:24:52 +0800
Message-ID: <20260305142459.52559-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x535.google.com
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
 hw/block/virtio-blk.c           | 17 ++++++-----------
 hw/scsi/virtio-scsi-dataplane.c | 18 +++++++-----------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b6f74df68f..94a70c6212 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1429,6 +1429,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1453,8 +1454,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1465,15 +1464,11 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             s->vq_aio_context = NULL;
             return false;
         }
-        g_free(path);
     } else if (conf->iothread) {
-        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        AioContext *ctx = iothread_get_aio_context(conf->iothread, path);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(conf->iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1481,6 +1476,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
         }
     }
 
+    g_free(path);
     return true;
 }
 
@@ -1488,20 +1484,19 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
+    char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
-        g_free(path);
     }
 
     if (conf->iothread) {
-        object_unref(OBJECT(conf->iothread));
+        iothread_put_aio_context(conf->iothread, path);
     }
 
+    g_free(path);
     g_free(s->vq_aio_context);
     s->vq_aio_context = NULL;
 }
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index ed5304c6a9..29615ec63e 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,6 +28,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -65,8 +66,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
-        char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
                     vs->conf.num_queues, path, errp)) {
@@ -75,39 +74,36 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             s->vq_aio_context = NULL;
             return;
         }
-        g_free(path);
     } else if (vs->conf.iothread) {
-        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
+        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread, path);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
-
-        /* Released in virtio_scsi_dataplane_cleanup() */
-        object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
     }
+    g_free(path);
 }
 
 /* Context: BQL held */
 void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     if (vs->conf.iothread_vq_mapping_list) {
-        char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
-        g_free(path);
+
     }
 
     if (vs->conf.iothread) {
-        object_unref(OBJECT(vs->conf.iothread));
+        iothread_put_aio_context(vs->conf.iothread, path);
     }
 
+    g_free(path);
     g_free(s->vq_aio_context);
     s->vq_aio_context = NULL;
 }
-- 
2.49.0


