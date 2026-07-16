Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4FC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJa-0007Pc-UE; Thu, 16 Jul 2026 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNIK-0006VE-34
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNIH-0007eN-NZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:35 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so76857975ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212952; x=1784817752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGDmrbz26I1WMwGFs2MTG5M/5fYQsJGL+TfR/qEpu9s=;
 b=YiRDpi30dnSYT146kvRW9aNEtVVOy0ps3iyljbjP/MPI6zltOTcdlweYij4DrPwkpI
 lypNjMK18hnXlJjSxAGONefIzis/btS96i2/RE1f6oLQbJXaCjr/Gwj6juibgtXRel2n
 wUOCi6iy5H5X1tgNUkW9j7EyDFlELlkWHLwOPSYrLU+udtcNSwE5ffeOemPtppvQhpNo
 +RhdbEQy54BjpfGcf0iiT4VO9AwWOiW3XntyVKeAGllsH551h2IepvpY/xB7ZnINevA/
 QGlyJ3vTFmJmee+K2u4vgsLkV69moK3RTGcILnuosW0g7CJZAx+uD97h6qHSof5B0L1E
 kj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212952; x=1784817752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGDmrbz26I1WMwGFs2MTG5M/5fYQsJGL+TfR/qEpu9s=;
 b=WmraD8wjn4wqdazkhMZCwxC8EmFIlkLIKEvCuzBazLf32YC1azFvnNHnNYqi2lrSIH
 Hd7wRywXIvVAOlrzyB632JAR2xtFyjSCsK17jBWLE6IpZrLhCGwu3CUYSYh2q3w/R9Sy
 t7lfQjEuOWs/NH+bSMAAWkiQxaZJ37i4Gf1lyIde7nK7bLiK+3/8sS3KKEWvS2ZNPgIt
 mXSpo0aSTHJLILMBWBBp3AUS0lm65D2V9CSvJ0cGiwNFMqO1cdOK/85CDOMPjJeseHTe
 VSMVYdhsUCpiiez/IfZLDWI17pWHeNPslvnly+SGgzwk3DORscBVMCUN8goQgZkITz1p
 andQ==
X-Gm-Message-State: AOJu0YwDNC5lkGSkAnuaMzRZ8d/i+JCikeJMXCQn+wBgFoCub7/UBSFq
 UfE3AOun6Sxl0v8An7tTFllZJ/OjXT0w8iwKDoRtUi+QCRc3ol4ki+Y563AlQXfe0CU=
X-Gm-Gg: AfdE7cmQjPVeRLUSQ05tPFXRRgSCPxCBcrhqc6W9klwbRjxAjAMjDMhyZZLKt6FGrDg
 CTjFLopfFQiWaSzRp8yoNrnwD8JqaUavAAwDhHZeRZwnkMRrzpBKD/x6clNUA5oVo8FKGqjz22A
 Grg2WSpRZNWcajrufb3rjRR42zi1UMjah46eUfP2+Yb2OOj27UlCSQ5qbBht1Kip7APzLkqgvkQ
 M40p2KRmjNI3itnhHlXiow2aFh1UwJo1kqE4eeBu01jGBBU8EsDX5iTKMe6mz4UNc6I3NstDQcm
 ZEf7Qb/V/92PMSNq6igxK5Ps3bsrLsyKDxupwBAZwN827SIihTqsptrZc9C0qnQXayX3GiqDaxp
 zeSVsvkzF6g+mlgBgrfM/uiGrb8UwwSFLCyO3UjcyW5KIKoaXAeMVGWV9IL8BoMOYHejUL3wanx
 kkWQAflryvOPedJ5N8UFBwJymI+Lq0s7ngltTmuRS1
X-Received: by 2002:a17:903:15c3:b0:2cc:6817:d9bc with SMTP id
 d9443c01a7336-2cf03d51383mr63003345ad.38.1784212952253; 
 Thu, 16 Jul 2026 07:42:32 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:31 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 14/15] iothread: simplify API by merging
 iothread_get_aio_context variants
Date: Thu, 16 Jul 2026 22:40:39 +0800
Message-ID: <20260716144043.76414-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
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
 block/export/export.c           |  5 ++---
 hw/block/dataplane/xen-block.c  |  4 ++--
 hw/block/virtio-blk.c           |  4 ++--
 hw/scsi/virtio-scsi-dataplane.c |  4 ++--
 hw/vfio-user/proxy.c            |  3 +--
 hw/virtio/iothread-vq-mapping.c |  3 +--
 hw/virtio/virtio-balloon.c      |  2 +-
 include/system/iothread.h       | 16 ++++++++--------
 iothread.c                      |  9 ++-------
 monitor/monitor.c               |  2 +-
 net/colo-compare.c              |  2 +-
 11 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index 4dbd71de6a..32c7ef7d28 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -146,7 +146,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             .u.block_export.export_name = (char *)holder_name,
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
index 1865890fad..2c296986ee 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1508,8 +1508,8 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
index 3cce5eeb09..3a6010b9f0 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -73,22 +73,22 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-/*
- * The iothread_get_aio_context() and iothread_put_aio_context() are not
- * thread-safe and must be called under the Big QEMU Lock (BQL).
- */
-AioContext *iothread_get_aio_context(IOThread *iothread);
+
 /*
  * Normally the IOThread's AioContext is fetched using
- * iothread_ref_and_get_aio_context(), but there are legacy callers
+ * iothread_get_aio_context(), but there are legacy callers
  * without a clear ref/unref lifecycle. They cannot unref (e.g. because
  * they do not have an IOThread pointer), so provide an unsafe way to
  * fetch the AioContext without holding a reference count. This unsafe
  * API serves legacy callers - do not use it in new code.
  */
 AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const IOThreadHolder *holder);
+/*
+ * The iothread_get_aio_context() and iothread_put_aio_context() are not
+ * thread-safe and must be called under the Big QEMU Lock (BQL).
+ */
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
diff --git a/iothread.c b/iothread.c
index 157bb4d302..9d278efc45 100644
--- a/iothread.c
+++ b/iothread.c
@@ -429,13 +429,8 @@ char *iothread_get_id(IOThread *iothread)
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
index 688bb85c81..0b75f9f69b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -749,7 +749,7 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             .u.qom_object.qom_path = path,
         };
 
-        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
+        mon->ctx = iothread_get_aio_context(mon_iothread, &io_holder);
         ctx = mon->ctx;
     } else {
         ctx = qemu_get_aio_context();
diff --git a/net/colo-compare.c b/net/colo-compare.c
index a7bbb1056d..6cd642d0b7 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -969,7 +969,7 @@ static void colo_compare_iothread(CompareState *s)
         .u.qom_object.qom_path = (char *)path,
     };
 
-    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+    AioContext *ctx = iothread_get_aio_context(s->iothread, &io_holder);
 
     s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
-- 
2.49.0


