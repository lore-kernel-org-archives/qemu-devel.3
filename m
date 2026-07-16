Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C3C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJV-0007H2-6V; Thu, 16 Jul 2026 10:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHe-00064r-4d
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHb-0007Da-W2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cab973140bso81607075ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212911; x=1784817711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DpwjeH9GaZsYh/eToeeS9DaxY2sr+39n/RM53e5yVAo=;
 b=WpJrfdMTUOzR3eop4Anoexqvo7FCZs2zWEF+pRW3aF9wwuz6JZrkhawhhG6bErVeCF
 e293zgZLbQ7MvS1zWDEoPk7vBOlUoBgPyJE/z41X+8jAGClQIWJlG8H6G9K72lcORoOz
 aPRUzqMKb6NLoLFxmanabp8f+2FLd7t/MJRMAB16m+byCpHHmGg7skxOCy9gtBO/hWXn
 EP4kgDw7RgI4dQK5HVGqCjJoc2h8WIkrCEJNsPJ3QSBacsRa74R54R5OodNI+XXrnfNR
 inHvnlcu8NB6kpD5chn5CX06mac85zImdeeirdohRXoZKEp6e7mgeVdQQyLcSc8bNYlH
 iViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212911; x=1784817711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DpwjeH9GaZsYh/eToeeS9DaxY2sr+39n/RM53e5yVAo=;
 b=LptCJOTwQQceBA4KhG2GRlMHnYbd3iboBpmlGuBAkEknKDqUodECYI7sKnVo/+B04a
 uDjSeLwTpVC6/UOBKygF9javRNgDiOy8+KBQm+R6apkjWzS0g3dDGZrm9I2+6WWR3U64
 HvqA40TtTDXyQnEJjXoCbltKK/BYx3VVg1yO50C5RmhDBFHW9vsbMY8vFz30MWLPW9Af
 BYHnunYv6mGRnjC5TmEVmBjlVnli3U7eFf1+vuHuOwMj6i+gewKmubfR8Uzh+oYOT7bV
 Bafh43bHXvAgIjFacwRK6w5whzAwgPSL+oxda0WfGN5RD+2PPjNHE5fUCPFtQRBYC87J
 6hrg==
X-Gm-Message-State: AOJu0YzC/43LrEO9S6Dq3X3Z5N1YD3ffdJ3cJNLh/XSkIu/aw1SnJQpM
 IaG3lxfCEc+yGIxNJe57wCx1wOecVFo+mLCWs+2FfxV3CzgnD4e3Tvcwk0hrv0qHC2Y=
X-Gm-Gg: AfdE7cltm+208PHefmNO5FKRoU1tiVgloxjxfNQ5g4UJbduxGMjBioo1g39yrwfbsJJ
 g1PRdBwNOF3/xYEI1xrPVqnKnZeQOWaL1yPz6JQ9+MNTxwl2UGOA+kXeeHaVgi6zY32uBdyiFTl
 a63M5p/BUFrqSGgy+UjKWnB+8wZ3dIXIsa6yi5gUXnRH1XU8HPfORd/mLuqkeFtW0gP0dZ3GGGm
 AAYn2zBvLaTXOlRnxGKioFeWlRJv2nnSdkpkmKv7X9DQ3n+TSBkJh99ZmTlaAZy3Nh7tXCfhD6P
 y/1ieEawHiqID++U4ib/OjK+Si3TrjCj4H41+6+2/7ReKYspw2ejF83mlHmjMfvYYxFG4KdZrBd
 qDI3BxT77BbovhkwXidL93jijINyauxyrHZhpL3iU2PxNdlcG4bSFS4oXPnjgalzb5lRRS4bgiq
 pJ9Sltncu6uZmSHM3pibpxYc0DkNsW3tcG3JVd22/y
X-Received: by 2002:a17:902:fc4e:b0:2c9:b8e5:5741 with SMTP id
 d9443c01a7336-2cf03d21be6mr65822655ad.35.1784212910651; 
 Thu, 16 Jul 2026 07:41:50 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:50 -0700 (PDT)
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
Subject: [PATCH V10 05/15] block/export: track IOThread reference in
 BlockExport
Date: Thu, 16 Jul 2026 22:40:30 +0800
Message-ID: <20260716144043.76414-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
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

Add an iothreads array and an iothread_holder_name string to
BlockExport to track which block exports are using specific IOThreads.

During export creation, reference the associated IOThreads using
iothread_ref_and_get_aio_context(). Clean up and release these resources
properly in the blk_exp_add() error paths and during export deletion in
blk_exp_delete_bh(). This supports both single and multi-iothread configs.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 79 +++++++++++++++++++++++++++++++++++++-----
 include/block/export.h |  6 ++++
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..4dbd71de6a 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -15,7 +15,6 @@
 
 #include "block/block.h"
 #include "system/block-backend.h"
-#include "system/iothread.h"
 #include "block/export.h"
 #include "block/fuse.h"
 #include "block/nbd.h"
@@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     AioContext *ctx;
     AioContext **multithread_ctxs = NULL;
     size_t multithread_count = 0;
+    g_autofree IOThread **local_iothreads = NULL;
+    const char *holder_name = NULL;
     uint64_t perm;
     int ret;
 
@@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        holder_name = bdrv_get_node_name(bs);
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_name = (char *)holder_name,
+        };
+
+        new_ctx = iothread_ref_and_get_aio_context(iothread, &holder);
+        multithread_count = 1;
+        local_iothreads = g_new0(IOThread *, 1);
+        local_iothreads[0] = iothread;
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
@@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             return NULL;
         }
 
+        local_iothreads = g_new0(IOThread *, multithread_count);
         multithread_ctxs = g_new(AioContext *, multithread_count);
         i = 0;
+        holder_name = bdrv_get_node_name(bs);
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_name = (char *)holder_name,
+        };
+
         for (strList *e = iothread_list; e; e = e->next) {
             IOThread *iothread = iothread_by_id(e->value);
 
@@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 error_setg(errp, "iothread \"%s\" not found", e->value);
                 goto fail;
             }
-            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+            local_iothreads[i] = iothread;
+            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
+                                                                     &holder);
         }
         assert(i == multithread_count);
     }
@@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     assert(drv->instance_size >= sizeof(BlockExport));
     exp = g_malloc0(drv->instance_size);
     *exp = (BlockExport) {
-        .drv        = drv,
-        .refcount   = 1,
-        .user_owned = true,
-        .id         = g_strdup(export->id),
-        .ctx        = ctx,
-        .blk        = blk,
+        .drv                  = drv,
+        .refcount             = 1,
+        .user_owned           = true,
+        .id                   = g_strdup(export->id),
+        .ctx                  = ctx,
+        .blk                  = blk,
+        .iothreads            = g_steal_pointer(&local_iothreads),
+        .iothread_count       = multithread_count,
+        .iothread_holder_name = g_strdup(holder_name),
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -250,8 +272,32 @@ fail:
         blk_unref(blk);
     }
     if (exp) {
+        if (exp->iothreads) {
+            const IOThreadHolder holder = {
+                .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+                .u.block_export.export_name = exp->iothread_holder_name,
+            };
+            for (size_t j = 0; j < exp->iothread_count; j++) {
+                if (exp->iothreads[j]) {
+                    iothread_put_aio_context(exp->iothreads[j], &holder);
+                }
+            }
+            g_free(exp->iothreads);
+        }
+        g_free(exp->iothread_holder_name);
         g_free(exp->id);
         g_free(exp);
+    } else if (local_iothreads) {
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_name = (char *)holder_name,
+        };
+
+        for (size_t j = 0; j < multithread_count; j++) {
+            if (local_iothreads[j]) {
+                iothread_put_aio_context(local_iothreads[j], &holder);
+            }
+        }
     }
     g_free(multithread_ctxs);
     return NULL;
@@ -269,10 +315,25 @@ static void blk_exp_delete_bh(void *opaque)
     BlockExport *exp = opaque;
 
     assert(exp->refcount == 0);
+
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(exp->blk);
+
+    if (exp->iothreads) {
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_name = exp->iothread_holder_name,
+        };
+
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_put_aio_context(exp->iothreads[i], &holder);
+        }
+        g_free(exp->iothreads);
+    }
+
+    g_free(exp->iothread_holder_name);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..8b5002ca84 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-types-block-export.h"
 #include "qemu/queue.h"
+#include "system/iothread.h"
 
 typedef struct BlockExport BlockExport;
 
@@ -89,6 +90,11 @@ struct BlockExport {
 
     /* List entry for block_exports */
     QLIST_ENTRY(BlockExport) next;
+
+    /* The IOThreads utilized by this specific block export */
+    IOThread **iothreads;
+    size_t iothread_count;
+    char *iothread_holder_name;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.49.0


