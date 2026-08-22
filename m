Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D678C5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMC-0003fT-0r; Sat, 22 Aug 2026 17:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMA-0003fI-0H
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:26 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtM8-0000id-7M
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ccf2360620so18922395ad.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434463; x=1788039263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0DnY1gZpaIvaTUJhEOKC2Z/nQXIBJqQ3bcd/TsVWjI=;
 b=qUrtQz2+5QE9oQJnxl5vqqbt+vCleIksgA/5FSozl95xwNSCyIN0DD5hsyVe5WahBs
 C2CMWCNOWkb02c6KGqV1fF7coVpdux5od2GtnD0CxgpeN6zu6xe4PD3gm7f3Db6ULZl/
 /DMIiLw1xregQ1C+ctN5qiPbKVfW+tGYtVn2B9/LkOSdJa2zeMW6LIhJPOpOINHzGRhW
 QUxkwzjpM4sOV5+4f9M0EQpN9R++E688GMDxyyLRMSFYosxwPqP+UQlcXbuuCXwrHHlD
 PFPOT5ay07Lhzfl3RNaXEnuYwkwmuqkgKGmO5s89ZaVZFBc9FcLtN2JWMEwbkywNPKN3
 8Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434463; x=1788039263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c0DnY1gZpaIvaTUJhEOKC2Z/nQXIBJqQ3bcd/TsVWjI=;
 b=HBeIuh4y8KuY6VUUzEHwZ/IuK90tXZcKBTxgcvEj30VSTqUt/TtY0kptJCph2oIfs4
 LPdBIfQU1mQ9ffTnM5MgaIFPmk1FR9uxGMx4dkBEj9w/s3Fuy49980MUb6oOIxovXASQ
 ixdDPV4v+6GaJIiJuRu7XM6Cm5g0urHYJoCQ5k4Uvp4PtlwKiNkFrSJn4OXZNvnhWIfY
 NxJWUnX7Aa2sU2P3HaAfajUeFzuQBTDDMIhtsI2OsoBoO8xbhEVmHEp5KflwLkyYibF+
 ht2fXjEbjlKbM6nuCEIpnr2v2nXAw3tNmbTWkf1QhURqj202tly3tmb6/vNWN1L33T+F
 1QTw==
X-Gm-Message-State: AFuF++ntGTqMYid+EneFgBa705P6YpPztmgQMPxx7422+jseZYcy0BVe
 dh+OBFTrTOM4Pri5eFHdHdu32CglOK6NhnE0BFv1DrsiVbf8wmCKaQrGA194IWiPWAqTES0W
X-Gm-Gg: AR+sD12IlOv6yOTc/yVA0YuLMDDzVVlc7ocRG3AlfChZn+IB7JLtzO2fJtCyCzIJq6W
 XA3eQ83A39bsWm410Z8hfPi7myC+tsaigp5bt6PKkvTUtvB3E+P82ZFNxpIutSuEjAjFp8qZfzf
 fji71Zs/w3286FjR0UJbgawHenuUsOHOY7yThxK9+Z5aC0TOUudid0r7X+GMOO4WPsUCl0Afpom
 n+GFJJsjbWw6Q2k3SeXJVQaf823hgecqDuO6S1Gf+Tc8o8iLgVGW4b/aSvaLykn44jN/HCvDxvP
 6zUK475KZrqMS0n1t6YreifvL+HCPREvLOQ8kKNbSjVP8kwRHItU8tKiuP0GkrhL4JZWLBdYF/J
 irCjU/3H3HB1liNNqTr+sBt+Pa4BhElbJ4DBpLMxJtq3ZWXmCB5vTsHEpUDFuvUl+KNWg2yLmtH
 znx1kTvEbjVGWvT9y6mJE7UzjN/xeSSvRTQ/gukJdcDZhKQdn3sYI9kNWo+8QjuWUk6ZtJYI542
 riUp2CNns/6ebLyB7/B
X-Received: by 2002:a17:903:3804:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d64b0c5704mr306978135ad.13.1787434462714; 
 Sat, 22 Aug 2026 14:34:22 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:21 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 05/15] block/export: track IOThread references
Date: Sun, 23 Aug 2026 05:33:28 +0800
Message-ID: <20260822213343.661939-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.55.0


