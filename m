Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0013C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gB-00043H-Qs; Thu, 06 Aug 2026 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fy-0003vJ-Iu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fw-000503-SA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso38608055ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048007; x=1786652807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5X0V8jZCbDKykpmj6x9x0QhtPxCJ1NJOlHyWr2doyqQ=;
 b=b90SdWbjX229vjnUW746MJD9WaeHy91h8IejfN6miK6D67C6g8aayZx2DH1nfAV2lU
 KoJp0TMmtV2stZLDfH8Shwssa1leSSyHQP2mmDopRqUVeNUur89YLQycCRXqReCQIMbp
 Lssh3i6b7TsVaTJrC+UyXSLRdnovWtnrFHROsxN61qM5z6mTf7qYdh5fFg0SKRbQ4VRt
 ACsm7h6JkUb/OCYzIOj1TeX3REXchoK7eN7XUoliV7wXuDfymWDsh+47i7w89tfvalUc
 7lt8LSlPm8F/0Lz/K9T5NJxuUSGQ9wprXDskAuOpo0ezxBVduFKwfNe+eEAwFBIv28DD
 F6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048007; x=1786652807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5X0V8jZCbDKykpmj6x9x0QhtPxCJ1NJOlHyWr2doyqQ=;
 b=jhSVsvkrEsCsLpyIl4GuQnU8TMBSwi16EoEqku5YaBQO0fQqEyms9j8eD0cXZz4UzA
 GpU7Rgl1/0HLVrcQBqWuonvg+wn6S0cxWngyVmj1kCxGslf6hStE7J4er+3yHhEEJVst
 E3oeTZkccUDj9ev3Jpb1CnbCoxf6F3TxCKeexd2kMPypX8X8PRqX6VUvSXj/v4QhabyU
 HBpoDH07UIbF1TmP7/xP45vTVgL/2xqV5qhXUyugwl3aJMi4KZ/AaM9G9w857diyMDSH
 YUkVJfuTTfZsSMVEqjvHS9gRdKrolodMwH8n3ZPGP0xPwTvTxLZdmoLdN0i9jLfjTbWm
 LNEA==
X-Gm-Message-State: AOJu0Yw25zbkcHQHEcTF1DqQ1hWMvg7HnGKFhU+y8OsnFbGeRYOlJYUH
 Gu3vPbo4i99XTC1o7V/ulFU/E+LK4XZRe3/WJqW9+ZQMB5g73mZC6ECAnNNxDsmY3q/NjfUm
X-Gm-Gg: AR+sD12Ly0jEObk6K9oqRX8u7iI4svDWDj+RUrFlzDkSW2T8cfuRGm4C5lH4DIcKOPR
 J4za7P3t3fPFbXbZ7/2Kz2gb8Y9NTgljnGWA0vOlK43k47fzNBYfURD7nwMTFcYva8cX8ejnzVP
 rrFwS/8C9yToujhv0TF/ebd0/P7QYnrENTGgymcj2uWjnN6FRTy11zq5a1omDXxugz+fQWO2GrD
 QMvxNI+QRd1eYafd/KBcyJv7AJ6NUt7ub/ghGiwcfTb6cEWa3jD6jyd8cCQKMUfPzNJ5kpN5vxO
 URtUeIIlAJ+6EedBZBhW8fo0VWFpZPYtbL23zpghq2tz8l7Eufzohqqvy7c1IkZd7m02Z4i8bL7
 qAbDoBDsntj9U1jhi8Nzy9cUL0iIxdNYy7G2a2eBmu3EDM5DXhIkL7d6Rulw+a0521PtAfelPs+
 h95q06xtk5+r37L8/6cjBfbPWTYaMVTu+4psXFcoH+ydcSi2h7rTb0QXVIDr/ckVqcsKa1m9K5G
 MH+hAfzOCjIUhCuNEPZYy995wQ=
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d0ca71b3f0mr224490305ad.2.1786048007391; 
 Thu, 06 Aug 2026 13:26:47 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:46 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 05/15] block/export: track IOThread references
Date: Fri,  7 Aug 2026 04:25:14 +0800
Message-ID: <20260806202531.243806-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
 block/export/export.c  | 79 +++++++++++++++++++++++++++++++++++++-----
 include/block/export.h |  6 ++++
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..96d719418e 100644
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
+    const char *holder_id = NULL;
     uint64_t perm;
     int ret;
 
@@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        holder_id = export->id;
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = (char *)holder_id,
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
+        holder_id = export->id;
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = (char *)holder_id,
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
+        .iothread_holder_id   = g_strdup(holder_id),
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -250,8 +272,32 @@ fail:
         blk_unref(blk);
     }
     if (exp) {
+        if (exp->iothreads) {
+            const IOThreadHolder holder = {
+                .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+                .u.block_export.export_id = exp->iothread_holder_id,
+            };
+            for (size_t j = 0; j < exp->iothread_count; j++) {
+                if (exp->iothreads[j]) {
+                    iothread_put_aio_context(exp->iothreads[j], &holder);
+                }
+            }
+            g_free(exp->iothreads);
+        }
+        g_free(exp->iothread_holder_id);
         g_free(exp->id);
         g_free(exp);
+    } else if (local_iothreads) {
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = (char *)holder_id,
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
+            .u.block_export.export_id = exp->iothread_holder_id,
+        };
+
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_put_aio_context(exp->iothreads[i], &holder);
+        }
+        g_free(exp->iothreads);
+    }
+
+    g_free(exp->iothread_holder_id);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..a093dea0b6 100644
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
+    char *iothread_holder_id;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.53.0


