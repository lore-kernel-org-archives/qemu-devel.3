Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7555F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQv-0008K5-1W; Fri, 10 Apr 2026 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQt-00089Q-F8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:06:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQr-0002bx-3b
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:06:06 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so1333525a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833563; x=1776438363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y84HVOhRdFiTx4rK3lNBeuuJYVZj1WfUlmRssgWUGlo=;
 b=dma3fokmW1tnDkriQi0emVjvnf4Uhph46UbJS7CjsTHSFo6bO8Z0y6dKWSyMP+dy0Y
 gB1g82KpKrSpIgsrO6ZHEv9dI8V3SXQp40q9hE7OVV4BwsAuCMKt+Gk4u8ZWKH57+PNO
 FcivUrk2SMNFJMX1bvRxZ3cnpUFr/M/LrPeXyjPVcVg2WAE2KYXEwvJZRH42dAcBXF8n
 oRFFcZ5MbxDO1Q9YgVl/RVC9dxhbgqdRf4FzQGzkJm2BRb8CEI7bRXtBCuEJ+rsdwbAq
 BsdBnPeZPbvpzvq4IVHks7mrrA/JMQMv4t/XDkPYeLWJgm81LdOO5hF5t7EQcF0xxEPx
 YwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833563; x=1776438363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y84HVOhRdFiTx4rK3lNBeuuJYVZj1WfUlmRssgWUGlo=;
 b=H3/EzJlGdvlt5MPXnUXrJDGQkxzONGvRKxptd2a+EVAsZvcgCgxKo79EvHTkAfpv5i
 tDcqSfe99na0HS9JwCID8ta/UUtbRr2eNY+C+Ch7PcjYLeRuTl44sWftCRpVC3Iwi3LZ
 km1LbhoWT9d57ra/bG1W+6BGJKSwdelw6qVfv+/RYEX5fZywBC5qhzx1Fke/zqQgCunO
 uEyUNj4tDj4OWgNIuf6XlO4ufQHJRwy7AOjdg7n+e4CHhSg8Y7Bz6OiT5NIqEeA6vBZu
 P6GijClzD9eu7k/l/u2VncoOh9TS1pEGmYtDkJQbZ0oAGLvVw97CiXAVF+39QU7g7Zd7
 Vljg==
X-Gm-Message-State: AOJu0YxxGJ+zKzRFnt+TMQXuSU2I9CJ5jRZtQF+d7m8Mk+kuOIWC1+67
 yrvU6rwrXQQJ4xzRhSwt1My0O5dUwY8Z7soCxuRQ7b+2xxftHgp4/0IlxI4uqmKc
X-Gm-Gg: AeBDieutigLJLSsf6r/HDt2YA1WUbTFn3VjYGjUwuUAat9mmyFMzugSIrDWRsYhz72S
 T3SpV/zAf/Akx06sj3kyeR08b3fcAW5KfImf6KjUTeCdiHfRgAbhM/BIkVAzNXnf6MA6lRKxTh0
 V86O08lHF4fGaGhzflZI2jphkIOekQoxZWYN6uWl7ZThIUjwFzH1WxjM8nXVkPGV03aTpe97Qg+
 vzOHG4bPNr4tOI5xKwCwXePObtd79jkvLx0/z0Kvh5KabEC3qGWHpoyGTjg9mumvtUr7Zc8B0xF
 PxjR/kdQXicgfrOu/X8DQpdt043DnQqKkp8FVmWbsPOIrMeP3N/X5mCPlQr1ZJjJ8ElFvsrpLvJ
 rEddVXBmXI2WQWmHXuYB77NmlVVJvFxSok447lF1h8hzHge0sP3FheT/VF3Vd0D9Y/oarJ7ijlx
 W6k46asC09ImubYWcvBo5V4sVlUaQ+pAyharA317KcnjxiNTh1vBYx
X-Received: by 2002:a17:90b:2fc7:b0:35d:9276:eba7 with SMTP id
 98e67ed59e1d1-35e4302d8afmr2719702a91.7.1775833562973; 
 Fri, 10 Apr 2026 08:06:02 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:06:02 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 14/14] iothread: simplify API by merging
 iothread_get_aio_context variants
Date: Fri, 10 Apr 2026 23:04:57 +0800
Message-ID: <20260410150457.85190-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1030.google.com
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
 block/export/export.c           | 6 +++---
 blockdev.c                      | 2 +-
 hw/block/dataplane/xen-block.c  | 3 +--
 hw/block/virtio-blk.c           | 3 +--
 hw/scsi/virtio-scsi-dataplane.c | 3 +--
 hw/vfio-user/proxy.c            | 2 +-
 hw/virtio/iothread-vq-mapping.c | 2 +-
 hw/virtio/virtio-balloon.c      | 2 +-
 include/system/iothread.h       | 5 ++---
 iothread.c                      | 9 ++-------
 monitor/monitor.c               | 2 +-
 net/colo-compare.c              | 2 +-
 12 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index 636633c324..37bcb4f4d6 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -141,7 +141,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         }
 
         holder_name = bdrv_get_node_name(bs);
-        new_ctx = iothread_ref_and_get_aio_context(iothread, holder_name);
+        new_ctx = iothread_get_aio_context(iothread, holder_name);
         multithread_count = 1;
         local_iothreads = g_new0(IOThread *, 1);
         local_iothreads[0] = iothread;
@@ -180,8 +180,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 goto fail;
             }
             local_iothreads[i] = iothread;
-            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
-                                                                  holder_name);
+            multithread_ctxs[i++] = iothread_get_aio_context(iothread,
+                                                             holder_name);
         }
         assert(i == multithread_count);
     }
diff --git a/blockdev.c b/blockdev.c
index 6e20579187..7eb206a02a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_ref_and_get_aio_context(obj, node_name);
+        new_context = iothread_get_aio_context(obj, node_name);
         bs->iothread = obj;
     } else {
         if (bs->iothread) {
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 552bd8b039..f5984c86e9 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -624,8 +624,7 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
         g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
 
         dataplane->iothread = iothread;
-        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
-                                                          path);
+        dataplane->ctx = iothread_get_aio_context(dataplane->iothread, path);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 70fc85bdde..8c6a3eaa1e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1464,8 +1464,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             return false;
         }
     } else if (conf->iothread) {
-        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
-                                                           path);
+        AioContext *ctx = iothread_get_aio_context(conf->iothread, path);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index cc318162f5..7b37e3d223 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -74,8 +74,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             return;
         }
     } else if (vs->conf.iothread) {
-        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
-                                                           path);
+        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread, path);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index eebe202c4a..9a9059290f 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -938,7 +938,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("VFIO user", errp);
     }
 
-    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread, path);
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread, path);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index c993281d7f..7dadc43c44 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -94,7 +94,7 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_ref_and_get_aio_context(iothread, holder);
+        AioContext *ctx = iothread_get_aio_context(iothread, holder);
 
         if (node->value->vqs) {
             uint16List *vq;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 8a4494905a..bd47ba8256 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -899,7 +899,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         precopy_add_notifier(&s->free_page_hint_notify);
 
         s->free_page_bh = aio_bh_new_guarded(
-                            iothread_ref_and_get_aio_context(s->iothread, path),
+                            iothread_get_aio_context(s->iothread, path),
                             virtio_ballloon_get_free_page_hints, s,
                             &dev->mem_reentrancy_guard);
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index dbada8249c..fde80f4149 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -47,9 +47,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const char *holder);
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const char *holder);
 void iothread_put_aio_context(IOThread *iothread, const char *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
diff --git a/iothread.c b/iothread.c
index 70bc5fb62a..470f267901 100644
--- a/iothread.c
+++ b/iothread.c
@@ -415,13 +415,8 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const char *holder)
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const char *holder)
 {
     /*
      * In some cases, iothread user need the ctx to clearup other resource.
diff --git a/monitor/monitor.c b/monitor/monitor.c
index b6efe776d6..0f9642f11a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -623,7 +623,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
          */
         g_autofree char *path = g_strdup(is_qmp ? "/monitor/qmp_mon0" :
                                                   "/monitor/hmp_mon0");
-        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, path);
+        mon->ctx = iothread_get_aio_context(mon_iothread, path);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index f3231257d2..ff58ea9e0a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -968,7 +968,7 @@ static void colo_compare_handle_event(void *opaque)
 static void colo_compare_iothread(CompareState *s)
 {
     g_autofree char *path = object_get_canonical_path(OBJECT(s));
-    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, path);
+    AioContext *ctx = iothread_get_aio_context(s->iothread, path);
 
     s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
-- 
2.49.0


