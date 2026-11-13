Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250560A2610
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIIsskFe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYW-0000ce-Og; Fri, 13 Nov 2026 04:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYN-0000XE-J0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYL-0005ze-Sa
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:39 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso4082915ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794561996; x=1795166796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8x/Kjb3LFSKjH4X1E0LG5Wat9YzKYyvVsrKHxncOxM=;
 b=OIIsskFeljCJ8rq9B6m2FFRDw6StGd+m6M4DuQzBe5W9CuTCpSa9U2Z5y79w4F+8QX
 d6aIMy1aexbttC1t6sW3/AHjzOum7pBiFU2TZtfa6dj3uzeiGc6PMvPS1JwR/4uzHzRJ
 +vnwucIz8LPGGRJ/rmh2qcUye/o1+1/WAKs51BcbwoK2PgzMR7JY/ebUVXbozoMLqhHX
 G50DsMhaQHiz/9sRN2EIPNqdMv2BDo6Wn9O4ZqXG63NLG+Kxc0FHpSd3pzUyoBZxNFuR
 mGcmjzx5oDDBuO4E8lzzkS95GlvjhkwnS30kbuCTQQPSSSE2lM0hfcFDYd2R24w8iph2
 R1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794561996; x=1795166796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z8x/Kjb3LFSKjH4X1E0LG5Wat9YzKYyvVsrKHxncOxM=;
 b=IGtJlBEtiBjSgIYvYwNwR7n1a7qcnn01p696fDR/WRLIMmTYESQ0nmtD8Y2rFrrHQ/
 xa4ofiHar97jz8I9azunvj/uKLcTrVyw0I+uDaa5qBsN8YSJKH/NExCrQs/MoHk5uJAT
 2u7nT0e8qSPaLsNLe8JeZVBb4/6/dPJaXdMlu/OVGbhLmTAZNU9Lc+BvlTMeucij7djk
 Gxe9ZutXQiooxU1puOzEhd5AUkh71H7XRW4/TifZb3HODDD5gdQ8aFyUtybW1S+Wc7EF
 uzo6uqRpmiqr6YG2dMbSqUEpWQvyew2dnE0Oqkfvh0eKKCpLlE1hqpQgQKgl56oLPTWu
 EzCQ==
X-Gm-Message-State: APuU4Z8ZcjTE6lqCmu/CZNJgxYARuMQM4O+/jN+YZnzDgAueI2jXc286
 Z/BUtwOnoLi4f5tDHWlTDzUxVMfirLSI+j4NDNx68w9b4GQLJwYxxodSskb1CR0Q
X-Gm-Gg: AYBFou2b0EaHHANDCu/4AVrNnwUQOZoZWZ1B99vENn9BSkKKKM62RypFbZpX6OgNGPT
 NQ6CPkufydzdct4sBSFi8Cc7Ak393vpXnd85NLEUwaqUGCnbZsoKVo+ObtTSjrQ9qLmIuHwkmdy
 junD9dUBkm0kuA38ucsp2yeVtDgYRUVcO7Gze+dNrFi5j78+9+vmZxATFdZVCSn5QEO6LnvOl8a
 IgsRRXK67C6/6yHbUbFv032INfvTzuGwcZircNyAE5BQIojJYoBeAeFb5y1C/cr5a+LazLiKTR5
 zrtKssjzrkFdP2G9qDo3cADpVn+OjX/DceZTq+hhLFLPdoP2mhbtgXw9WjXO9zhUmtT3g8U/McP
 lrvS4OI6dJR2zVaB8ld7jB4WI/P/zhHe9HFDEOJIbpNcAcSI5ZB3ce3salcxwT2EBDyFj76lbxR
 fxnayF656bsJp8l6RDx/kSpW/uMNvwlYp4V2TAZviwOhyjQANauFyHbDdiDA5Hsxg8j8NMGX5J9
 VEUtLMfNf8T8igjeSecJ9bDWpSVS3PW+uRp5CIBliMm9SpBhfXntAvrQ0crKxvrIkkOJZBvmC/Q
 8hD+osnsvwMnlLkt638klOTgirMv1PgUUnhZjMoMbNMlDwy0s4kxEBIAQzw=
X-Received: by 2002:a17:903:22c5:b0:2dd:c0ff:e72c with SMTP id
 d9443c01a7336-2ee0dcc8ea8mr18889945ad.62.1794561996540; 
 Fri, 13 Nov 2026 01:26:36 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:35 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 03/14] block/export: track IOThread references
Date: Fri, 13 Nov 2026 17:25:54 +0800
Message-ID: <20261113092605.942292-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.53.0


