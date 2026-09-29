Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F84DCA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7Y-0005xP-4F; Tue, 29 Sep 2026 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7N-0005qN-FL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:46 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7K-0001ST-IH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:44 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so2493780f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697101; x=1791301901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gauZhWunVSnOWagdnaQx1CJFfB6UJ8th/qE2ie82hjc=;
 b=IReDZkh7iL0XBZWPMAupsDVuK4Kd0l8Tfd/OYkJgaFKWoOYL06C83w59Ao7NCdk3Yt
 nvY3SJFqYLJTC8mc9yE1ji+FYlj7bSo2eRTAt/ADD5IdR/+cv8OwMZGnIqODfcQWjbGi
 WS8rUTX1lXNf39+iUSbVF0WwL9QTZ5cU5Do6t1il+N1voGV+WoZUWlAWVcYUrygkZ9cJ
 Otiz2r2CcSemwV031Pb/9enDpelmtcldnNhG5aHcdWAbTTubSbpXLKYGEu+ZZVjqKHMN
 zA0iMPuAeGA4q7o6bDKYBPxG1+3sth4/rkiv9bkkv8pXPei/XDQ0teiG4VfKJRx0DuUE
 UyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697101; x=1791301901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gauZhWunVSnOWagdnaQx1CJFfB6UJ8th/qE2ie82hjc=;
 b=PxMz1EEIQ6QM4dapIYC31lh3yAwmQamA2ixteN5kEGkRhN+gvNKunshQwm7t/VutAF
 gAmohsKcUyo/mskCy4ZRGo+5HhPl8hoG7AR4hFvw0De43FcRxSINg9IVEdmO5Yg1xAtK
 64WyngBG+x9LtgQEZFux8eGco2r7+0mNScNatw29x+TPkrNULx1EoV9PlS7ZL4DZidVz
 IoM0OIziT1cst2d8jH7wWnpoyQ7cX8Mdusz9ifBfXKAEEeRoiS6NeY0zTDhpEpoxHv7d
 XkIQCXeS5Bq3HCkjvCu+d4NE3ngQXAufus8iUVOj7BTLcutuoX6HaICifruAtCpLSzVn
 vJRA==
X-Gm-Message-State: AFq9FYISPBFuHqXW2uxt6UhNepTgsDudCkMGzuIIe7x04pHav77HfdKO
 jyA72H9Krwz9bsOuHqEg/oslIHnGU2rJHjcZBUf/RvMaG0sGbfZdgwB9FaJVUlZjX8hlGQZW+eY
 c1cFv
X-Gm-Gg: AYBFou2MZHZFVawByMeiWKLnbLm3g4Vt2+B5yyTgMs27/OjSb0sNDlqGWSllZpStlrd
 bnsBBCF9DpkiU2aRrZiUiya92PJhfqNnW9g8/NSb000KrYpU/Sumj/TAVfV36kpPIrMFx9s2O0i
 8rqwNQF5zMAShD1zEvWJdO/sX2w7n4swN8QHWrojKKu4rsSX9jXqt33OntEFAlWcFvE/ih+REpJ
 LIZCOq0wwz3ew9qdxleuz17dT0DrbdWYdPiMjsfNiFQlcn6Q/mNZUBwC4vos4bzJXvbNEZ8LpwY
 WWZMvSMM58k/w8cZVT+vUjmjQef7cNKxrAP+GlRaaCA8q5b+xPW0RvkIk1mD7Sc9YD0r/2t3NPn
 O1R4n0c4nsdF/NW+NXvIGQpfBsY/O07Z6T1ucxrqs/5OY2qlUaKTIHwriqmnLnU4TUGZi9bcpfS
 2GGaV3ew9LlOAeaL/q9M5EPnWDJsuyv6NaVsmIAHNjK1NZYRu25wtgi7TLrg==
X-Received: by 2002:a05:6000:71d:b0:487:21a4:f617 with SMTP id
 ffacd0b85a97d-48871681179mr27935377f8f.19.1790697101222; 
 Tue, 29 Sep 2026 08:51:41 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:40 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 7/9] block/block-copy: track known-zero source clusters
Date: Tue, 29 Sep 2026 17:51:23 +0200
Message-ID: <20260929155125.3151111-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

block_copy_reset_unallocated()'s up-front scan already queries the
source, and the same query reports zero-ness. The copy loop re-queries
per task and, having no answer up front, can only size a task by the
copy buffer, so a mostly-zero image is cut into thousands of pieces
that each turn out to read as zero.

Cache the answer in zero_bitmap, published by zero_bitmap_valid once
the scan is done. block_copy_task_create() then picks the method from
the bitmap and ends the task where the answer changes, so a zero task
never reaches into data and a copy task never swallows a zero run. The
per-task query stays as the fallback until the flag is set, since CBW
intercepts guest writes while the scan is still running.

The scan and the query it replaces must resolve BDRV_BLOCK_ZERO against
the same part of the chain, so the scan moves from bdrv_co_is_allocated()
to bdrv_co_block_status_above() and the base selection is factored out
into block_copy_status_base().

zero_bitmap is a plain HBitmap, not a BdrvDirtyBitmap: an internal cache
has no business in query-named-block-nodes. One writer and readers gated
by the flag need no mutex, but the publish needs ordering, hence
store-release and load-acquire. It is allocated on demand, so sync=none
and a standalone copy-before-write filter do not pay for it.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             |   1 +
 block/block-copy.c         | 108 ++++++++++++++++++++++++++++++++-----
 include/block/block-copy.h |   1 +
 3 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d4713fa1cd..11d70243e2 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -280,6 +280,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
             offset += count;
         }
         block_copy_set_skip_unallocated(s->bcs, false);
+        block_copy_set_zero_bitmap_valid(s->bcs);
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
diff --git a/block/block-copy.c b/block/block-copy.c
index d71d070dbd..94d4f3dd69 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -20,6 +20,8 @@
 #include "block/block_int-io.h"
 #include "block/dirty-bitmap.h"
 #include "block/reqlist.h"
+#include "qemu/hbitmap.h"
+#include "qemu/host-utils.h"
 #include "system/block-backend.h"
 #include "qemu/units.h"
 #include "qemu/co-shared-resource.h"
@@ -157,6 +159,10 @@ typedef struct BlockCopyState {
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
     BdrvDirtyBitmap *copy_bitmap;
+    /* Clusters reading as zero; allocated on demand, frozen once valid. */
+    HBitmap *zero_bitmap;
+    /* Published only after the scan, with skip_unallocated already false. */
+    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
     ProgressMeter *progress;
     SharedResource *mem;
     RateLimit rate_limit;
@@ -190,6 +196,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
                        int64_t offset, int64_t bytes)
 {
     BlockCopyTask *task;
+    BlockCopyMethod method;
     int64_t max_chunk;
 
     QEMU_LOCK_GUARD(&s->lock);
@@ -201,6 +208,27 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
         return NULL;
     }
 
+    method = s->method;
+
+    /*
+     * The scan already knows how this range reads: pick the method here and
+     * stop the task where the answer changes.
+     */
+    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+        int64_t boundary;
+
+        if (hbitmap_get(s->zero_bitmap, offset)) {
+            method = COPY_WRITE_ZEROES;
+            boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
+        } else {
+            boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
+        }
+
+        if (boundary >= 0) {
+            bytes = boundary - offset;
+        }
+    }
+
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
 
@@ -215,7 +243,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
         .task.func = block_copy_task_entry,
         .s = s,
         .call_state = call_state,
-        .method = s->method,
+        .method = method,
     };
     reqlist_init_req(&s->reqs, &task->req, offset, bytes);
 
@@ -271,6 +299,9 @@ void block_copy_state_free(BlockCopyState *s)
 
     ratelimit_destroy(&s->rate_limit);
     bdrv_release_dirty_bitmap(s->copy_bitmap);
+    if (s->zero_bitmap) {
+        hbitmap_free(s->zero_bitmap);
+    }
     shres_destroy(s->mem);
     g_free(s);
 }
@@ -624,20 +655,24 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     return ret;
 }
 
+/* The scan and the per-task query must resolve BDRV_BLOCK_ZERO alike. */
+static GRAPH_RDLOCK BlockDriverState *block_copy_status_base(BlockCopyState *s)
+{
+    if (qatomic_read(&s->skip_unallocated)) {
+        return bdrv_backing_chain_next(s->source->bs);
+    }
+
+    return NULL;
+}
+
 static coroutine_fn GRAPH_RDLOCK
 int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
                             int64_t *pnum)
 {
     int64_t num;
-    BlockDriverState *base;
+    BlockDriverState *base = block_copy_status_base(s);
     int ret;
 
-    if (qatomic_read(&s->skip_unallocated)) {
-        base = bdrv_backing_chain_next(s->source->bs);
-    } else {
-        base = NULL;
-    }
-
     ret = bdrv_co_block_status_above(s->source->bs, base, offset, bytes, &num,
                                      NULL, NULL);
     if (ret < 0 || num < s->cluster_size) {
@@ -657,16 +692,41 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
     return ret;
 }
 
+/* Only the scan allocates, and it runs before zero_bitmap_valid. */
+static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
+{
+    if (!s->zero_bitmap) {
+        s->zero_bitmap = hbitmap_alloc(s->len, ctz32(s->cluster_size));
+    }
+
+    return s->zero_bitmap;
+}
+
+static void block_copy_mark_zero_prefix(BlockCopyState *s, int64_t offset,
+                                        int64_t zero_count)
+{
+    int64_t zero_bytes = QEMU_ALIGN_DOWN(zero_count, s->cluster_size);
+
+    if (zero_bytes > 0) {
+        hbitmap_set(block_copy_zero_bitmap(s), offset, zero_bytes);
+    }
+}
+
 /*
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this allocation.
+ * Also marks the zero prefix of the range in zero_bitmap.
  */
 static int coroutine_fn GRAPH_RDLOCK
 block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
                                 int64_t *pnum)
 {
     BlockDriverState *bs = s->source->bs;
+    BlockDriverState *base = block_copy_status_base(s);
+    int64_t orig_offset = offset;
     int64_t count, total_count = 0;
+    int64_t zero_count = 0;
+    bool zero_broken = false;
     int64_t bytes = s->len - offset;
     int ret;
 
@@ -674,25 +734,37 @@ block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
 
     while (true) {
         /* protected in backup_run() */
-        ret = bdrv_co_is_allocated(bs, offset, bytes, &count);
+        ret = bdrv_co_block_status_above(bs, base, offset, bytes, &count,
+                                         NULL, NULL);
         if (ret < 0) {
             return ret;
         }
 
+        if (!zero_broken) {
+            if (ret & BDRV_BLOCK_ZERO) {
+                zero_count += count;
+            } else {
+                zero_broken = true;
+            }
+        }
+
         total_count += count;
 
-        if (ret || count == 0) {
+        if ((ret & BDRV_BLOCK_ALLOCATED) || count == 0) {
             /*
-             * ret: partial segment(s) are considered allocated.
+             * BDRV_BLOCK_ALLOCATED: partial segment(s) are considered
+             * allocated.
              * otherwise: unallocated tail is treated as an entire segment.
              */
             *pnum = DIV_ROUND_UP(total_count, s->cluster_size);
-            return ret;
+            block_copy_mark_zero_prefix(s, orig_offset, zero_count);
+            return !!(ret & BDRV_BLOCK_ALLOCATED);
         }
 
         /* Unallocated segment(s) with uncertain following segment(s) */
         if (total_count >= s->cluster_size) {
             *pnum = total_count / s->cluster_size;
+            block_copy_mark_zero_prefix(s, orig_offset, zero_count);
             return 0;
         }
 
@@ -752,6 +824,12 @@ block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
     int ret;
     int64_t status_bytes;
 
+    /* block_copy_task_create() already decided, from zero_bitmap. */
+    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+        return true;
+    }
+
+    /* CBW filter could call this early. */
     ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
                                   &status_bytes);
     assert(ret >= 0); /* never fail */
@@ -1081,6 +1159,12 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
     qatomic_set(&s->skip_unallocated, skip);
 }
 
+void block_copy_set_zero_bitmap_valid(BlockCopyState *s)
+{
+    block_copy_zero_bitmap(s);
+    qatomic_store_release(&s->zero_bitmap_valid, true);
+}
+
 void block_copy_set_speed(BlockCopyState *s, uint64_t speed)
 {
     ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0df2771181..e4e5b56753 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -101,5 +101,6 @@ void block_copy_call_cancel(BlockCopyCallState *call_state);
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 int64_t block_copy_cluster_size(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
+void block_copy_set_zero_bitmap_valid(BlockCopyState *s);
 
 #endif /* BLOCK_COPY_H */
-- 
2.53.0


