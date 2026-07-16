Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4803C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmS-0005qx-3a; Thu, 16 Jul 2026 13:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmP-0005qg-F7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmM-0000TI-Vh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38101f85591so449766a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222506; x=1784827306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DpwjeH9GaZsYh/eToeeS9DaxY2sr+39n/RM53e5yVAo=;
 b=Phw71almUw0lDR7xCNMTVikkE64Wl50SrgcS6tl5l+U74LkMzpiHL/0RKAW/a2Bw8r
 MV4RFmzFhBNoivL8J4jSnsf8IwXA5/4yTwdD+ZL+dFNLmF7GIsUULqRzFJE3NSVMSiYr
 9x5sph7VcDwVADC2358ibS2tl4LlMGTS+g0ZtV2clA0qzZzLHgD7aZ15h7GDYPodLc3G
 uKlmvqLGTS5hoEzVipSfEpt5fB0NSZO5SAoyudtIpMDIVWi4WI6+c56oZt33FR28MhMs
 yGuXJRPkF85Gj2jB4ZUHJptMpY6cJKEkJ0xuhtaZG5USQNF3AmcXvHb43SzwVqKo2+qb
 NtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222506; x=1784827306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DpwjeH9GaZsYh/eToeeS9DaxY2sr+39n/RM53e5yVAo=;
 b=ZvN03hKHLr62hyeSsEcy+6Ou8yQAoFHeFL9aHmiC2fvIDojy7lQHRt6GNKtFgeQme1
 Rmht2fhTr7no3D22KsTetFqUTLT/3dmH2VBOBV6NJfzUlXFGAvtB8OaLDdAf6+O0D7pP
 grn5n0KOZRxcF/fjMc6VyTzuoWwOyJwRJGhSaI8Wa9hj2+Sef33flIRXOpq9scGYkMlb
 IK+TOE8kJFb+dCcekoTVH1Jt60TYaTI3D2z+PWkEXNYua33m30MU3RUjj/l4mgIP40GP
 MIaZf02Jqg6Kge8nJXoC2yh2b9gcWpIzHdYunhkpsiQ97BzaSk1ZncTyWJJxYf3i0swB
 d3ag==
X-Gm-Message-State: AOJu0YzG39/6ZCziWgqf7mEhTHBpjBJHlsK5/c7uXPW0yAWSuq4ar0NN
 j4hhN14RZh5zclUVrb+R0nFsU40zNbb7t0dtDA/oxrr7EW7reUv5diVoDaZ0dD3PvcI=
X-Gm-Gg: AfdE7ckl0BIt3wCweDHPsS15BxB3CCnLgfDAA3hvCIAB3t7+JSCckElRfKhSeS7ylAa
 J741DKkMpWXLpmyvzGjMuLgLzjPKxefAd03NADoX3Hr2VIOnk1hdpPCV0JBmwLDAbxaVhOHm6Aj
 SQyjTNjkPKuvLCMm8Drbr8O+uZr2bNm4Ob7G7tDI9CEnneoicqB2SXYUAalDonZyVu2i3ReNCMz
 UaVclY3bOmGkBHfQC3cFVD8/2F+FMQRmo4XRDzIxSrs3aShcbMOkmtSOE0xBdy638WGeoom0fQG
 yURDSIrCdB5+Rv9WurqG+1wkmNVm54vttoqRc3vtSQuuhAAK5Vau9zzuCqWVBJLaU1+H4k0aa2j
 hRSo5dFqYDZwWhfn15S3NdCjAa8dA3o37+blrxpwddNoKwsRwJ4/OaShVk9FVfCcKMJTGvPO23v
 GBAHuY4mZaJX67XnUJigY6zs9jX8vwtA==
X-Received: by 2002:a17:90b:540f:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38e3d163538mr3946584a91.5.1784222505499; 
 Thu, 16 Jul 2026 10:21:45 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:45 -0700 (PDT)
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
Subject: [RESEND PATCH V10 05/15] block/export: track IOThread reference in
 BlockExport
Date: Fri, 17 Jul 2026 01:20:46 +0800
Message-ID: <20260716172108.87700-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102c.google.com
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


