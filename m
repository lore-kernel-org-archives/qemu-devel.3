Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BBBCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHh-0003h7-6S; Mon, 11 May 2026 10:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGS-0000z3-JB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGO-0007Li-3V
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b9ea536877so25257935ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508337; x=1779113137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZb1GGPCvoF4z/BARiR0nVXitII8lcm428TmgYXryN0=;
 b=SLqaycl8Gb9fBQhpWmJh5CXS+msUfdhrdhjB/XrRb28QOcYMCoUd22N35ridhzg4CI
 m3Qit9Orc6dDZYYVFSJcXMqdepyOdjVgxsecr8JAdDyxANUalRFQQqhuLf5vISTCFwXp
 grc+TgmCeXkcqsVys+RuIGcZycnYOM5U7gWFTRz2MJndwQkwbx13wLRMHmLzojQ4360Q
 IqhKX6IqjJvRseK0yq9CcfAynUittlzPxNYvYxqIzMlVMnSEwqGHcbjAkKRkRvRqZ9fF
 5P2fpZgAfl+1nVjDiyRHUc7CaDgFbN1FauZCWoZIPJkHpUGuHhddNr3iPcmb+BHiHBoo
 59kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508337; x=1779113137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FZb1GGPCvoF4z/BARiR0nVXitII8lcm428TmgYXryN0=;
 b=LkN1hjNNgYvGlYWcDX/oTKhea4G2/NXrlgvdZeNzcad2e4oOWiaV23/yy05Vt6CjW7
 w79K26EQRt/e1v6A8c0GSTJ8BCOR0QMeM4b4RRpbfplV4miPFQl4jh99sJXzNaQvM/S3
 3Q0Gm7JM0BUY8Cf/0pRNB5xcvZuhwV53yU1IJ6obyV/sKc8FCi/9LCmiTuom1jw1E4vH
 5U6t8Uh/5yJFxuoVK9c0BCjACtzAg7PTcZDZnqMEkAQSvHODUrme1zxch7s4hAKe55wv
 zARF/Ksos0yUuSY5S9qHzjRs8epPcokNzUOc0rD6IyKZGp80Y8ExuF6v06aaRGLBzv33
 7BYw==
X-Gm-Message-State: AOJu0YwELxR6yEH7qCktD8VH+tM/hAhVksP1Nv5WuyzZAJM2YBfFGsKa
 BT98NACXTZNOexFL5LE0wqfu9x3fCRUSYl3pjDSQ/1ob2/ILmHRplDf6oVWhgu+cga8=
X-Gm-Gg: Acq92OFyl/5fIZeDE3gZOGTyGGc3X2KlxN43u9jaAFeUoN8BCjMN4BcAIwAqSagv48X
 vCzkPYYi17NoFDfGggWRbFRfvU99urxymb9zaSTDxJWCUW+hWjrFaXAsm3/WgzJHzChAEWcJnMl
 CSuWazS15k6KkUq2C7zRxCC0GEQ94qdRLmWn7l9n7O1clSCiTsJ4HEA/ruTz38NBm4KCmIMFPs0
 8M8F7vwkT5Nl5R+91wGfwVcdeYE3c+gPcAGhxWJ4yuZjt66rSiZUdv6gbJQ/sM0OpOXFcpJZ9B/
 m+dILVBDx9DthnCEKPNrJJKSgv29/jm//Dr5/Ab6XYJHLlP3t6kw2TZ4n9HBKyLpkOBK9RopHi2
 QobSOraLL2XQ6OxOxbJJsMFLwZLQdWSbB8fb1W26ozDnsiC+UjO0PeE/86W2Tf0U55dSLP8qu9M
 wFgVYyq760xa1axNRCqjdJJijGNgqVy4ADfrZIxqmm5AUvPA==
X-Received: by 2002:a17:902:db01:b0:2ba:76ff:57a6 with SMTP id
 d9443c01a7336-2babc858f46mr177992785ad.4.1778508337351; 
 Mon, 11 May 2026 07:05:37 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:36 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 14/14] iothread: simplify API by merging
 iothread_get_aio_context variants
Date: Mon, 11 May 2026 22:04:16 +0800
Message-ID: <20260511140416.28271-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x634.google.com
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
index e9f1dd5f8d..eaefd7d245 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1498,8 +1498,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
index 313ef61124..cdeab63f0a 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -69,9 +69,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
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
index a78744284b..d73de821c2 100644
--- a/iothread.c
+++ b/iothread.c
@@ -446,13 +446,8 @@ char *iothread_get_id(IOThread *iothread)
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
index 8c83da95e8..57d81f8bb0 100644
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


