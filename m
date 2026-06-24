Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8724ACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjz-00056E-26; Wed, 24 Jun 2026 03:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHji-00053R-3v
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:26 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjg-00034R-AF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:25 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c89fa656ea1so234425a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284963; x=1782889763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2I8RSgxtS6zilF0lFLp60gipvFmJj5Si+EneANHl4s=;
 b=qI8JzDoOi9IpPYr9Bii5TwnTmynVESvSBzsvVwItu21eNocQtvvJJlhS0wgXXBCVOB
 0+4KjVAZ7bqg3rav+skPONi4P8fCZbGCoNqGG6pOZ1LTdmA5Sivq3VkhXVktSH14OUao
 4aMqfBI/shTVZ6WACQ746MKPuQcrcAYJ+YKadp4eSbPiZW2pz6AmDc85E8/poyaIBI0o
 xvouUCbFFRdjkWvqJnHGEvzORg2ALzBhfltbY0bfTnG6bwP3iZkDwbfYl3PlPlLY2Ukw
 tW2vbxFhVtFjhtI2DK6emOHmqBLIBkq/AMggRvRzfF43UTW8t5aFEGHFzXcsVlN7gbMe
 3iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284963; x=1782889763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2I8RSgxtS6zilF0lFLp60gipvFmJj5Si+EneANHl4s=;
 b=JL1NYWCdSwHnNRKnlVkLqLxZIUCCiL4AgYrYZ6xPxf905JQfWcT7coLfpBw+m5e/TC
 7VAN1dEazlt7oCVft3Jv714M9hay6tzbzcXY0bLR8DcN+8OB5/wkTcDvgunxQ8uTKjAM
 hJ1dobrBidLtKGaqB0yO1CdvyCk4L1GARR+nURhyE4g83l0MzYyIGsYtthRqRzMYwPXI
 nugT44PLl1+LKKwiMZ/ahfVff1uIo5Lr91pkxQWPRK5edb4A2ncfs1weOl8Zbd1OcPky
 iHK4Fk3kgq+q/C0o5x9vzQkPCpOEXajS6TFTpo7SZKPQ7F+e/yi7cZT3Vju1dqW0CVyU
 lIRg==
X-Gm-Message-State: AOJu0Yx6BacsDWfgw9u4WSCy2/N8YTPM0fpWcRxTBgZS9IrgY31WIv52
 UgffVvacMg197VVhJT6Kpblz7516ww+vMQzxoohGlZLhWjX0SiyF564AJcdKvBdRawk=
X-Gm-Gg: AfdE7cm1VQG1fhKofQtvsg9coe5qPJmYH6TcZENZ5T0sDbefm6T2MxjI2ipVoQE4CMC
 GZG5JSBkUnfe+fql2WV7Vm2Kt/k6rZYIs47K74OZMnIE0j3dhImVdnyjmbdx1a9/2JARphYSC29
 yKL2VTM1KYfiTRtMQIkNRT/twLFXpaWZ5Q49/8l+9FBqtGeWR4EFLZlwsD3jaKG4W+Ve3fSC6Vi
 9DGtSQed/CoP00XHepsjNKaYUMfmZRVw0eEcCngqjp5DC/5NT4oLtpOXlOoI8IsDHur8IdPAQsb
 qtAZQbEoF2IujjKnseEPBsmEsSn3lw1ksAEWk7yLRIXSvdnMysg6+S+WDVJeyfbXJ7SNdo6UPVn
 0ZkqzMDFxvwAW9CTLVkPfdsznWUJuf90YAnsygLS40sldqFBFKY5CO4z4cdThwyVAc30TTUtOGX
 8rgH2+ZqJTh9uNZwSUHEuBJdljlxxgwy+TOulUxZySWKBbjerB02ua
X-Received: by 2002:a05:6a21:4c06:b0:398:9b42:69f7 with SMTP id
 adf61e73a8af0-3bc53bf531fmr20143769637.39.1782284962777; 
 Wed, 24 Jun 2026 00:09:22 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:22 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 05/17] block/export: track IOThread reference in BlockExport
Date: Wed, 24 Jun 2026 15:08:39 +0800
Message-ID: <20260624070851.13342-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x536.google.com
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
 block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++------
 include/block/export.h |  6 ++++
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..b6c07f69b5 100644
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
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
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
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
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
@@ -253,6 +275,18 @@ fail:
         g_free(exp->id);
         g_free(exp);
     }
+    if (local_iothreads) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
+        };
+
+        for (size_t j = 0; j < multithread_count; j++) {
+            if (local_iothreads[j]) {
+                iothread_put_aio_context(local_iothreads[j], &holder);
+            }
+        }
+    }
     g_free(multithread_ctxs);
     return NULL;
 }
@@ -269,6 +303,17 @@ static void blk_exp_delete_bh(void *opaque)
     BlockExport *exp = opaque;
 
     assert(exp->refcount == 0);
+    if (exp->iothreads) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)exp->iothread_holder_name,
+        };
+
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_put_aio_context(exp->iothreads[i], &holder);
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


