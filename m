Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D7CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHmf-0007XJ-Ri; Wed, 24 Jun 2026 03:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHk0-000582-Tt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjz-00035r-0y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:44 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so291694a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284981; x=1782889781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDuEBYp+d3GMQU4EUX37XSBsPRXEyd9vBacPskZ6gvo=;
 b=jTa348YjRYcDKovvR5OcSE8AL4DyFadPIlnV4rCdIf6ryOadFQt/a/QF2o+/T+EBDr
 a81LfT0D8M6ZgDGz+3MAl1UPfh88gQUmYlbqM9woT8l+TEtGFXwudXgQn1tx8HEudlR2
 x4F64eTtzrBPJlqHFGYwmDh2h821a0j6223riUEjd2KhJ2dxF+0VaFr5HncbfnzejVnz
 y2hkZzvAEfUOIuC2llzhKyC0/ck4OCEs0xYDaWAhRFpuzGUOb2A3j/aDcrUECymtxruE
 l6eYc8CyK65VXPV88R4V/aegBB1znezyqLqsX3O5c1KwlMNFX5Q6VaccdpoJ0h92mnpU
 +GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284981; x=1782889781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDuEBYp+d3GMQU4EUX37XSBsPRXEyd9vBacPskZ6gvo=;
 b=JDuZEcqKa3lRwG/lydFIk9G9RN0/uK/1gp+VmtFHLDGq+dnecx9q309SHl6mSmawkK
 czFXlPVVS5O3E5KtGrw8DmQDAE8MpuoWAtUS3sIZg00bLPkI35xZCougJzMN7ZGSN+H8
 QoJTzlqrO2DDH6Rvw+vmI+eapGqQnosZ0YLLCm886ekTpjsHHleztc0ZtNyZ7UluE/Ts
 T+ELc5Mi3E1B2qA/wZMlbGPHNizmKivMDhq7/HP4k7LXLm47vDPJjtIEEfIY2ZXXj2Y7
 XX/xJDAaxGVTydwhQPOTCZGbHXsWVVdB8eJ3cQmVp1luxyALwR8sSUiT5+Zv8uw3NRMR
 CtmQ==
X-Gm-Message-State: AOJu0YyVXs8K6r1iEvxssFGGVB8UAYkQAj0mz3gmnP+CtpnxcsPXf0Kc
 xTiJf9K8NoilnUS9bf1tSlISub3IWdrq76z0mUQmKJHOipSqufGMvWijW6Fc0Riutms=
X-Gm-Gg: AfdE7cnNvKqSXApxjEdNjly3WiGTj7e6f6RK0R9xG+gFnB6DmFwhxUX+gFwlr8z8yzi
 8F5QocjlhHBACNaYRt7O2FESahTDyA3oBH7kQUEvRvSl71mjvwj+eVXed9fhEZP9BNtUYESOxoR
 YPgUQUm+tHhkrX7yynGbWtIPyzHamExDdWUtkpppFivBX+p18t3kosY5PgbEy6KPYHTA+/8kQ0T
 58LeYS+c2IvY/m2o2yFr9qfkC0qx1veh2ixA93mOZTSTdrLhev1ltChxHEm/KQF2DCUIrea0WVF
 denrDXldRWRXCetnqpahgHhh5aBRMrsFKGsMG0W/TafzGqoRJ0kt+FbjDkcYPNmrYOXaLN/d11u
 we9SxcRDNZ+P7OwfAZaB3/dvuEZRzosj9UzvCmaLDyhXapUE1Bdw1At7SRRo9nbogjYyfjMHJr3
 1RnNe1qyW3E44eKDFOPN5gw08TRj0EToUZ5ZVvOZXQioJdxdwSy6QeDufMX/QL8PE=
X-Received: by 2002:a05:6a21:7483:b0:3b4:7e2d:a3bd with SMTP id
 adf61e73a8af0-3bd2d0c463amr2781870637.29.1782284981557; 
 Wed, 24 Jun 2026 00:09:41 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 10/17] virtio: use iothread_get/put_aio_context for thread
 pinning
Date: Wed, 24 Jun 2026 15:08:44 +0800
Message-ID: <20260624070851.13342-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x530.google.com
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


