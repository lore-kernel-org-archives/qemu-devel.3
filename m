Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00312F459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQL-0006pF-EQ; Fri, 10 Apr 2026 11:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQK-0006l6-0w
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:32 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQH-0002LW-O2
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:31 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso1542931a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833528; x=1776438328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M/hoXWqBMvPhrdOYgRm4aU7iBbj+zMMvv5Gl5LllJg=;
 b=Livk5s4iJrbYf9+e4iZU96kPP0FKJVmXw1n5roxOrimeuMn7p5b0irMjci7BP+rs5b
 JzkRSC8Tis91gWmWHEi4W6Js3FXSYgtwySMIRbin9VPVc7kXNeeZNCycyPjufEvcqG0e
 sdCoSLAtfbwtB9VquJ0TJ0jPQ+qoAxtT+oVs83cOeUsETu5veDM7wD0A1mL1s15g3B8s
 3g0RkEqURNJyLshI0skHEkP+2Bg++E5KKJe9V8yRAn595jAJZibmcIeXYCR+Lrie63xJ
 8Rntfd2yT6wrmzt8UHl59Onv/eMr6m9XuUehjPercT/0Wz1RsifGzL9XlWkF6EvTWP25
 9NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833528; x=1776438328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6M/hoXWqBMvPhrdOYgRm4aU7iBbj+zMMvv5Gl5LllJg=;
 b=NeSh3xm3f8NwznlBZzMHzlIyn2tu0YjCM+qdkMAXppHWelkhGB2ASrP3J2y8zZoqK/
 H7LFD8wPEgK7p6BBTg06BJdRVWmP3IB1pMjsNPBzmZa1iP0K00jZtuL4H8Yu4QLRmD13
 O1A9N6Ag010qtlyma3EZs3fnOKUfEHsnj/czMCt6iH4Tgm3oWDRfIUD3O9stFyK4r87F
 twa6mBW8PmmlAdNnJvSfS2HVxcVUAIym+3VIHxEWOckyftKEdLmJbTmCHKvcZ7IjuSmL
 Jf2zbwMPLl3Q+L2vX2q2eEfmcALf6AND2oVUB8PQ5Rf2jBOUDhLFpbPmWI/XrVSjy2q8
 Ma5Q==
X-Gm-Message-State: AOJu0YyNeJyjMzNv3iMxVPRuFdEs/x72BaoElfbFFwWFRNEj3rnmNl6g
 CaCTT2xMUGdVMM+e7sI9QjxvK/DN5+48Yp9LI7BG1QvNwFUW9TPc1m9E3TiV5yWE
X-Gm-Gg: AeBDiev9o5iHqNN3Cdyx21Jt+3qhGyLLihu/vw0EjxkPUuw6KnC3VSMgF7EXguTt911
 CBcG34Xu3FZGQMJPzscSufPqSukh/bIdMyHbAlec/sPUuSXyJ1LvHBcfzau8uz2S2+QEAAKIfM/
 SFDpN8g4OCsaNLeDuDqxZ1SQVOw7/xH+ZfDm2n727RRwtd06vo/gPJTf+mQtn71mzRdq26f9MkL
 XIPhvFZEMl9zk5Xustx4RsRG9SB4546b10jYdPkUUV2vpzLUY26B+Vu/dtsnQclAUxrkeEq5WKb
 gZhGlNMh7ubi5EJDuWBDhD8uqkyubWB+xadLTWfA4VW3IcuhkrUvJ/UK3+2vENHtndgF/Bh5XY5
 Cf3dKSxSei1PyrPWTtQ3Ii4hT60wbnHbi2IMKqMT3SfBIGlGivbJrWn8zFCQ2u72iJf7b+Bo15Q
 FZtFVKk8De94Y2ytGEc/0Df/XKO6Hn8l4pNdRUV+JARzD5jjCeUmAr
X-Received: by 2002:a17:90b:3c48:b0:35b:e690:c5ad with SMTP id
 98e67ed59e1d1-35e42849e8cmr3830790a91.25.1775833527394; 
 Fri, 10 Apr 2026 08:05:27 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:26 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 05/14] block/export: track IOThread reference in BlockExport
Date: Fri, 10 Apr 2026 23:04:48 +0800
Message-ID: <20260410150457.85190-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102d.google.com
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


