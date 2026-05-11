Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F29CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRGb-0000ve-Sn; Mon, 11 May 2026 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG0-0000Ir-BB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFt-00075N-1S
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:14 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso1661887a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508302; x=1779113102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M/hoXWqBMvPhrdOYgRm4aU7iBbj+zMMvv5Gl5LllJg=;
 b=fUZ+KhH/Ef9XSJ+HfUMeBWIV9XQdT4OD8ZVen6j/X3VfBI9ukADuOuufaW4/LOtbUs
 dqdKTfhISr6Otfrd6vwbkKXDgG25wEJLC9Cgd6lYby/JyU4ZukgL/1sZj4gsZVlqCZcM
 1RCPc8jjmA4N3Yr9oogpt+VzWROKC3wOTRDq5xweefrWwLD482IEDKQgsrXyXheezFxC
 Oj9L9z65XoZ2NYJzD2oQKSP8SMxvtmpLnpg+avPj7tOG+Q9220WDzNM71417GSaaBOu3
 Bc0cXWBUUGXOZfBfebIM7tgu6qLRa55MAqLa1UJJnKAtNvLUd6Zg4V8KP5b9gOHlUflc
 Kdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508302; x=1779113102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6M/hoXWqBMvPhrdOYgRm4aU7iBbj+zMMvv5Gl5LllJg=;
 b=llqQfYAR1OGz804ae7W+EwOeBjyG8hFMKHAgPJUArcXRn07aAXfTy1t23UoQSlOdDG
 1yyNOL+R196deUzp1BuC704z2WDH3lLZWQIE9Q63bHEShNcdt+Jlm2A3cf1tg2rVJnYN
 IVXHpx1aS+90Rw1At6T5gyPZDNuvM1TGYoGC43lIr2rrGwXT9fehwd12uwiJ0Tk5INgZ
 rwKTSkKvua0XHuKXqujxKTrV2mS2i/nALblwsd2lj+Skt7WXyNDhRh2DnUgPuBu7QbUQ
 CjEH/NaDHgkdMWG1iJunrfrCt5q2LM/GbijUMstmBM8c1jw7Qh+0s4RBytwnEbW1+9EI
 SVgA==
X-Gm-Message-State: AOJu0YyVVjs1ZC2QcUWmxzm5KyXPjPsXTaxHRIoNfdkreT/Wyc7SYhlm
 GrFuaeFjRjNeTze8N7PAAaUMI5BdF2FCww0w9Iiix2PXN6DSwv/qJszCEafO6VBoDxE=
X-Gm-Gg: Acq92OGemJqkgcp6KhluX6ZwY5pEPu1FvDi9xpnHtKfrVIfPwIufmydBo8AWT28Lf+n
 5ezCOMIXHx+EMapF7WOvPOJQ1KhyjgqYU1aP9u3JAi1thqbUHS8s64yC2eHtuAGanZje2e52tpS
 6D1qKZCZMbWqoQJtpJwNRkEPrnYGbmTw/MxZMtVJ4OAkbdSAWMv1pAjR6N8ARHnsSOuWQ5ECf/j
 v61v73I3MyaivQTrmVrCLRCZP44JStM78ttTjsRZzCEsICZsA6IFW1FoKH2lsiAJS1LZraNy/D1
 ca8JBIjXqJTSKXxgwlx0qilxUCb9L4k78zWfEqdwYHeNoDV+4H49fC0K6LzWO4vNNw58IbCq4tp
 yLHn6zOBPfyvSVgqSFfA9a2QOfIri+CApD/O3gk3MTFZLF34ZeXaO0h4Sroe9qP5wuGY3I8M0L1
 mNEZrKLYrNPKzKFtYRUeirXMRM9OHVrsHhrkLy33PLQ542Pw==
X-Received: by 2002:a17:903:11c7:b0:2bc:ac76:c1cf with SMTP id
 d9443c01a7336-2bcac76c3c9mr68827715ad.24.1778508301817; 
 Mon, 11 May 2026 07:05:01 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 05/14] block/export: track IOThread reference in BlockExport
Date: Mon, 11 May 2026 22:04:07 +0800
Message-ID: <20260511140416.28271-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x529.google.com
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

Users currently lack visibility into which block exports
are utilizing specific IOThreads. This patch integrates IOThread
referencing into the BlockExport lifecycle.

- Add iothreads array and holder_name to BlockExport struct.
- Use iothread_ref_and_get_aio_context during export creation.
- Implement proper cleanup in blk_exp_add fail path and blk_exp_delete_bh.
- Support both single and multi-iothread export configurations.

This ensures IOThread 'holders' status correctly reflects active block
exports for better debugging and resource tracking.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 44 +++++++++++++++++++++++++++++++++---------
 include/block/export.h |  6 ++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..636633c324 100644
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
 
@@ -139,7 +140,11 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        holder_name = bdrv_get_node_name(bs);
+        new_ctx = iothread_ref_and_get_aio_context(iothread, holder_name);
+        multithread_count = 1;
+        local_iothreads = g_new0(IOThread *, 1);
+        local_iothreads[0] = iothread;
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
@@ -163,8 +168,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             return NULL;
         }
 
+        local_iothreads = g_new0(IOThread *, multithread_count);
         multithread_ctxs = g_new(AioContext *, multithread_count);
         i = 0;
+        holder_name = bdrv_get_node_name(bs);
         for (strList *e = iothread_list; e; e = e->next) {
             IOThread *iothread = iothread_by_id(e->value);
 
@@ -172,7 +179,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 error_setg(errp, "iothread \"%s\" not found", e->value);
                 goto fail;
             }
-            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+            local_iothreads[i] = iothread;
+            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
+                                                                  holder_name);
         }
         assert(i == multithread_count);
     }
@@ -225,12 +234,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
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
@@ -253,6 +265,13 @@ fail:
         g_free(exp->id);
         g_free(exp);
     }
+    if (local_iothreads) {
+        for (size_t j = 0; j < multithread_count; j++) {
+            if (local_iothreads[j]) {
+                iothread_put_aio_context(local_iothreads[j], holder_name);
+            }
+        }
+    }
     g_free(multithread_ctxs);
     return NULL;
 }
@@ -269,6 +288,13 @@ static void blk_exp_delete_bh(void *opaque)
     BlockExport *exp = opaque;
 
     assert(exp->refcount == 0);
+    if (exp->iothreads) {
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_put_aio_context(exp->iothreads[i],
+                                     exp->iothread_holder_name);
+        }
+        g_free(exp->iothreads);
+    }
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..2bb98aae31 100644
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
+    /* The iothreads list for block_exports */
+    IOThread **iothreads;
+    size_t iothread_count;
+    char *iothread_holder_name;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.49.0


