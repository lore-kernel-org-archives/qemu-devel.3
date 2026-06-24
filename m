Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB3CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlh-0006ir-RW; Wed, 24 Jun 2026 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkN-0005OP-Eu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkL-00037v-D4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c88d4606ec8so246256a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782285004; x=1782889804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yajFGcoHm9h0GZaIRtI9B2CHBQnTxVVpKNwZ6WZ6HJ8=;
 b=sYGmSXlqPU3vLH9ngs1ucrfHb/Vzw+yifEAiqlthvnQoE+g+Y4lfrC8xLC8Vf4whbu
 u2nHWJabgLx4P7iUAtLvkvr/FVgbiwtJwOQLsbI7ep+BvhZ+BUc6qcQCSwmjBuSFJRUx
 L1np2OHSukCs3sfuMe5bJsnFWkCKjCEdmpq+GAcoFVnVgneO/ObYVh0RacRNFS6zi22U
 Sk1Kp83JrSyXq+GU5xcEhMedWfRCKiquxvqI0ECy3xDM512cZRrCQIIG1G4XW/Sd+Jw1
 EH0j2fPG8Acc/o6j8LqZMKOg3QgwyqYH3VlZBsfhxlsdpFC9n+tyPuOLOF8+RjaQlXPY
 dChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285004; x=1782889804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yajFGcoHm9h0GZaIRtI9B2CHBQnTxVVpKNwZ6WZ6HJ8=;
 b=qHjWDCaT3Dxuw+/vHilS7o2f33KyhvKT+LRx8G6jq/sOO+i5pWBrHySSlaOfStegCP
 FKs8FUd6xYoV/qpWs0vP759bS6Xl36jefpNRRlp2yNHjxTnw/vM6fJ4Np527/hUnI1Vx
 I1EhG0Ly6EqYErtuRPsq99LTl2pmnvOVALBJXbi222nIEJO95UUHTKT6LN+ZF1bv4Kvb
 iqFud7DHi4Jkt6k+D32boP6E6ofzkfWp9qfJ2QuDWRO9gCBvzR4XkdghnqUJepc3scC8
 utC29fUslrR+C1zQxINpba3jCeW5Nc1GGiEvq4f7gA9PbRqMfphHlx2zEt4HVcDhV6n/
 oKdQ==
X-Gm-Message-State: AOJu0YxjqAZcrNhi3Ls4nrDZZ8pTgX+12Gb3SpnEUlcfs6Lm4GQEDOOC
 70dzW3lTwTi73XKzi+OVcx/fCccZxgxXAlAE9ex0UK/J6NATFvaeFxNTDkXV4WrW8BQ=
X-Gm-Gg: AfdE7clz31WdC9wm+wn9CfOlhUG/oryDPE06SCda8XLd7tZ7C6UTOlAAxg1qq9qGru7
 ApnS/6RnUiOXRSQ7tdXD7VH12vl8zRHYrXFRxpKQ3OkcwZc6gAbn7wDtNbCViPCp9+BMTy69SkQ
 tVeuA7JR0PIEfQLJyDrdo1iOswe9Eg6EVbyMGUopIK4pQwCrEJjI7DQso1vBzbd+fe8xg6RJhAn
 r0EcXFqe5S78x1dMfmPnOBL9S7LfwNsmowm9D263T7L7f560ze9G3NaRC7pi3lqBGRVkDkdEowT
 bE7me9II5aVxo3ncCdnP6Y892b2p58wYUiwIpDoGlvPmtGZkKR/SfBktbdLk3qFqdlAj6ourHxH
 0gjd+v4QevxkfRxSbBFCXFbu8B2xdQTKokny5O+7tPhBtfA6ib20P/J+MgTEdpqEv0oFYFjXGuO
 8KExae4k1tk3f2UCAyK0SRlakSNcbA7YwpT1eY2iGkVb4rk9OfsYBp
X-Received: by 2002:a05:6a21:7481:b0:3b4:85db:1bd0 with SMTP id
 adf61e73a8af0-3bd2cee4c4amr2617232637.12.1782285004000; 
 Wed, 24 Jun 2026 00:10:04 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.10.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:10:03 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 16/17] iothread: simplify API by merging
 iothread_get_aio_context variants
Date: Wed, 24 Jun 2026 15:08:50 +0800
Message-ID: <20260624070851.13342-17-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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

Simplify the interface by merging iothread_ref_and_get_aio_context()
into iothread_get_aio_context(). The updated function now requires a
'holder' parameter, ensuring that every retrieval of an AioContext for
long-term use is automatically registered in the IOThread's holder list.

Update all callers across block, virtio, scsi, net, and monitor
subsystems to match the new signature. This cleanup reduces code
redundancy and improves the reliability of IOThread introspection.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c           | 5 ++---
 hw/block/dataplane/xen-block.c  | 4 ++--
 hw/block/virtio-blk.c           | 4 ++--
 hw/scsi/virtio-scsi-dataplane.c | 4 ++--
 hw/vfio-user/proxy.c            | 3 +--
 hw/virtio/iothread-vq-mapping.c | 3 +--
 hw/virtio/virtio-balloon.c      | 2 +-
 include/system/iothread.h       | 6 +++---
 iothread.c                      | 9 ++-------
 monitor/monitor.c               | 2 +-
 net/colo-compare.c              | 2 +-
 11 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b6c07f69b5..acd061e86e 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -146,7 +146,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             .u.block_node.node_name = (char *)holder_name,
         };
 
-        new_ctx = iothread_ref_and_get_aio_context(iothread, &holder);
+        new_ctx = iothread_get_aio_context(iothread, &holder);
         multithread_count = 1;
         local_iothreads = g_new0(IOThread *, 1);
         local_iothreads[0] = iothread;
@@ -190,8 +190,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 goto fail;
             }
             local_iothreads[i] = iothread;
-            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
-                                                                     &holder);
+            multithread_ctxs[i++] = iothread_get_aio_context(iothread, &holder);
         }
         assert(i == multithread_count);
     }
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index b5bf8d359f..46bfd62f5a 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -628,8 +628,8 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
         };
 
         dataplane->iothread = iothread;
-        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
-                                                          &io_holder);
+        dataplane->ctx = iothread_get_aio_context(dataplane->iothread,
+                                                  &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index d8dc1dd136..d1d2bd7025 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1502,8 +1502,8 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
             .u.qom_object.qom_path = (char *)path,
         };
-        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(conf->iothread,
+                                                   &io_holder);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index c71f33b41e..76ab22610f 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -78,8 +78,8 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
             .u.qom_object.qom_path = (char *)path,
         };
-        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread,
+                                                   &io_holder);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index b4f749f245..8ad0f4cfd3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -942,8 +942,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
-    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
-                                                  &io_holder);
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread, &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 2cb48dd387..727358a483 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -99,8 +99,7 @@ bool iothread_vq_mapping_apply(
             .u.qom_object.qom_path = (char *)holder,
         };
 
-        AioContext *ctx = iothread_ref_and_get_aio_context(iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(iothread, &io_holder);
 
         if (node->value->vqs) {
             uint16List *vq;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e9d023b4ec..4405a87ed0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -903,7 +903,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         precopy_add_notifier(&s->free_page_hint_notify);
 
         s->free_page_bh = aio_bh_new_guarded(
-                      iothread_ref_and_get_aio_context(s->iothread, &io_holder),
+                      iothread_get_aio_context(s->iothread, &io_holder),
                       virtio_ballloon_get_free_page_hints, s,
                       &dev->mem_reentrancy_guard);
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index 064c05e78d..e5db215954 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -70,15 +70,15 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+
 /*
  * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
  * the AioContext, recommend migrating to the new API with IOThreadHolder
  * as much as possible.
  */
 AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const IOThreadHolder *holder);
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
diff --git a/iothread.c b/iothread.c
index 5949785b32..9bc8e359c1 100644
--- a/iothread.c
+++ b/iothread.c
@@ -469,13 +469,8 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const IOThreadHolder *holder)
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const IOThreadHolder *holder)
 {
     /* Add IOThreadHolder to the list */
     iothread_ref(iothread, holder);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 98727f3d20..07f2f4dbe2 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -623,7 +623,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
             .u.monitor_name.monitor_name = id ? (char *)mon->id :
                                                 (char *)mon->chr.chr->label,
         };
-        iothread_ref_and_get_aio_context(mon_iothread, &holder);
+        iothread_get_aio_context(mon_iothread, &holder);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 4f180936e3..820ea4d824 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -973,7 +973,7 @@ static void colo_compare_iothread(CompareState *s)
         .u.qom_object.qom_path = (char *)path,
     };
 
-    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+    AioContext *ctx = iothread_get_aio_context(s->iothread, &io_holder);
 
     s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
-- 
2.49.0


