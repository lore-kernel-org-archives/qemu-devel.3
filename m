Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD286C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3SzT-0005hJ-Dr; Mon, 07 Sep 2026 02:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzS-0005h2-4R
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzQ-00068R-CV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2caced6038eso30590125ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763079; x=1789367879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oeURIEcCI8TbII/h58ISje3mK5oO8wJcPqe347GxoX0=;
 b=WT9sNaR6W8bDC0JkMA7G47n7VJ2afWfzgc1E30PJ1kkpqSt/XCGUwWsF4+/im6oVt6
 78EuLOPrrgTn20IUn1Skw/KoZOFf39/8q1beajYEwfbdXvZOB2PtPtdGzzmFjrJ97pl6
 uwqKJgx89RCm9/xZpBwVwdho1zkaAMnPgLgfUmSUD11Grt8BvVqSGU3BkeIGkVxBy7rN
 G6D0MC2tHbR+mu4MoBITjDN3fJmEXu4/FGXxGaCti/ydBUquUjB9LwpFTAtMQgeMJlsF
 dqi8TrssJrmX0KSPhheCIRhXk07AN4/PMnsGzdvo/841edR0jjZYcZRlyEkgaRdGIDwk
 XMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763079; x=1789367879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oeURIEcCI8TbII/h58ISje3mK5oO8wJcPqe347GxoX0=;
 b=gPLgVSJhb0fTh+Q5+sha1d+YN564pISHwkunq1gpGcunDzwqvdPvZ5Bvh5QoBFX9ah
 bBzhG1l2Hyw54xPaPb5O2psgjU6yqKcAMEUVeo+IaFdj+DZ/dYSgQClxF8AQiGcfRF66
 JZrKFZuACxKGPy2gTjSCMawcs3sDZBOxXLlxJp8rmADTUw5RXG6HxC823IUxzkqlmLol
 kHbc3VJ8RLCg4SNaZpYQEib2ziNteCdvkpAsPNnjd4aRgI+qFeIyNM/ngvHZRX/78vuz
 3Ul9Uv1iFzTwJfJDt/l00+DLGWfR8VMMiBl2pOCBCuvK801PttsjXI8J5cP5DdHzYdm3
 3n8A==
X-Gm-Message-State: AFuF++nA7Br3TeaZ6NZ1xh1U4KT8QwHAwa48/qfdI46pyDJaidAPSl6p
 jyxrSQfDYLLb/khpM7vAr31ZMc6Y3//p9cyZTMagwBzbQ96UHZL/8kT/nHio9j1s4Y/2aw==
X-Gm-Gg: AYBFou1wfL8pFURoKt8NJ7ZP+fwsHofgbSmPP97tBtlBe3YjG6eyWiRRKEw1Jx05rZL
 DzPuaLStDV1b25YTcN5USbcDWoLU3PQ9X2hXdFnH58aSp/vWxdk9Xvu1nvpi1crUtjm8hX1Leau
 60u8qlx8vlnpn2f1tsoHBvaukFyXywYMo6BS5wuIrlRJE9pYNC4/72AYFsTZzqpSNou81qAYgU2
 SP+728NnCs/rfJ+DvSxz4iyP0eeYgDymfCvHjXT8vgd+sMmB9OvFLwrWeozrkbUB7x7WOEq+GsC
 ktQACbOhpL8Tbd5C9zdOzLXyxchTNIL1df0iPNpa5M4f5Z0pAF78wm0q5yGinJtUdgKn1B/01dr
 4vmQMyBzclCMbXT46w53yiPCCHbhlAjJf4xqRVjisSQXbs8VscomcWzvWCkiaI98Sn9X8kGU2P3
 WaIBcg5kylQurKKhhTe5NjrJy5BX/6NqNWZsMn13Sr4/nZN+RJcOZgywCz0fepP+d9FQp0cbTVP
 gySRvrnP7j7/ExVKg==
X-Received: by 2002:a17:903:8d0:b0:2d6:fddf:a890 with SMTP id
 d9443c01a7336-2dafaf31cedmr268653095ad.6.1788763079005; 
 Sun, 06 Sep 2026 23:37:59 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:37:58 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 04/14] block/export: track IOThread references
Date: Mon,  7 Sep 2026 14:37:15 +0800
Message-ID: <20260907063725.626685-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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

Track the IOThreads used by a block export and identify the holder
with the unique BlockExportOptions id.

Acquire holder-aware references during export creation and release
them on error or export deletion.  Support both single- and
multi-iothread exports.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 62 ++++++++++++++++++++++++++++++++++++------
 include/block/export.h |  5 ++++
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..0e019545ef 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -15,7 +15,6 @@
 
 #include "block/block.h"
 #include "system/block-backend.h"
-#include "system/iothread.h"
 #include "block/export.h"
 #include "block/fuse.h"
 #include "block/nbd.h"
@@ -72,6 +71,32 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
     return NULL;
 }
 
+static void init_iothreads(const char *holder_id, IOThread **iothreads,
+                           size_t num_iothreads, AioContext **aio_ctxs)
+{
+    const IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+        .u.block_export.export_id = (char *)holder_id,
+    };
+
+    for (size_t i = 0; i < num_iothreads; i++) {
+        aio_ctxs[i] = iothread_ref_and_get_aio_context(iothreads[i], &holder);
+    }
+}
+
+static void cleanup_iothreads(const char *holder_id, IOThread **iothreads,
+                              size_t num_iothreads)
+{
+    const IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+        .u.block_export.export_id = (char *)holder_id,
+    };
+
+    for (size_t i = 0; i < num_iothreads; i++) {
+        iothread_unref_and_put_aio_context(iothreads[i], &holder);
+    }
+}
+
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
@@ -85,6 +110,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     AioContext *ctx;
     AioContext **multithread_ctxs = NULL;
     size_t multithread_count = 0;
+    g_autofree IOThread **local_iothreads = NULL;
+    size_t iothread_count = 0;
     uint64_t perm;
     int ret;
 
@@ -139,7 +166,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        local_iothreads = g_new0(IOThread *, 1);
+        local_iothreads[0] = iothread;
+        init_iothreads(export->id, local_iothreads, 1, &new_ctx);
+        iothread_count = 1;
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
@@ -163,8 +193,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             return NULL;
         }
 
+        local_iothreads = g_new0(IOThread *, multithread_count);
         multithread_ctxs = g_new(AioContext *, multithread_count);
         i = 0;
+
         for (strList *e = iothread_list; e; e = e->next) {
             IOThread *iothread = iothread_by_id(e->value);
 
@@ -172,9 +204,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 error_setg(errp, "iothread \"%s\" not found", e->value);
                 goto fail;
             }
-            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+            local_iothreads[i++] = iothread;
         }
         assert(i == multithread_count);
+        init_iothreads(export->id, local_iothreads, multithread_count,
+                       multithread_ctxs);
+        iothread_count = multithread_count;
     }
 
     bdrv_graph_rdlock_main_loop();
@@ -225,12 +260,14 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
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
+        .iothread_count       = iothread_count,
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -250,8 +287,12 @@ fail:
         blk_unref(blk);
     }
     if (exp) {
+        cleanup_iothreads(exp->id, exp->iothreads, exp->iothread_count);
+        g_free(exp->iothreads);
         g_free(exp->id);
         g_free(exp);
+    } else {
+        cleanup_iothreads(export->id, local_iothreads, iothread_count);
     }
     g_free(multithread_ctxs);
     return NULL;
@@ -273,6 +314,9 @@ static void blk_exp_delete_bh(void *opaque)
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(exp->blk);
+
+    cleanup_iothreads(exp->id, exp->iothreads, exp->iothread_count);
+    g_free(exp->iothreads);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..ce8e4eb604 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-types-block-export.h"
 #include "qemu/queue.h"
+#include "system/iothread.h"
 
 typedef struct BlockExport BlockExport;
 
@@ -89,6 +90,10 @@ struct BlockExport {
 
     /* List entry for block_exports */
     QLIST_ENTRY(BlockExport) next;
+
+    /* The IOThreads utilized by this specific block export */
+    IOThread **iothreads;
+    size_t iothread_count;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.43.0


