Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=RdxfCWuD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb58-0002QE-TY; Thu, 29 Oct 2026 21:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb50-0002Kn-98
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4t-0006H7-0H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so78807f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322400; x=1793927200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQqkfnTRKNDcpWPgKSjM/iwuCtOPgHBiaJ7/UMTgM+M=;
 b=RdxfCWuDdRm2cOEcotWNpAZw1ZmHoSG1j36BHTqAFHEZQWYvCJu/UQQ+8QdKL++69i
 uZZ9Ms2HcckwnhjRteBiGkOx055D903n9tNAqAHIaml/HBw9gmraSRbmo6JNejYPX0+i
 YkL2QkXLKOInPnM3RVNngVy8/2gFVpFhD0ACQTGbsz+vGdcRpowdlnNKDEtk6rYZujqp
 QQRZO9p1aLwlK7H5KWlb9AadCQzOacLQy0/nykeBaiNzUjI8w2/MIzIO4ievL1xpJYeJ
 mPKhMfPw0yp+8aJph/f8Xbs4GVx9GrMjqFvobDZIuhr3jolJJpJnJ8FkLvrqUgz4BOn0
 mmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322400; x=1793927200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EQqkfnTRKNDcpWPgKSjM/iwuCtOPgHBiaJ7/UMTgM+M=;
 b=NNZ8eqPYKIdjx8i1YIvJrkLZXio4pPQAdo8pjP7rL5b7gdpJ/TY2VmAMBRdaVzsQmI
 neOmjFq51wGmIYvusbXG380/h98eD+Wvix/TARhFA3I7eoSp6FAqM64xAOS44KPdWeEE
 FbysvKzWjMbYHM+5hQyeAJ01MW5+pIXxv1gZk1//gRIbyu/wa9OmJQ1Y9J+8W1RQN2eh
 Us8/aucnpx9EnUZ0wxXlaqRFgdadVVZyfEwfo0dIOgfYeKgYtcYBnp3RfUG5SBl6Stn7
 eX+m9nNGkdcBY2mkCbDm+Hi7wYmRgbDqU1UL5dxaAWMg/Fl6VOqD4Q2CzLlCWQMKkX5W
 R+qw==
X-Gm-Message-State: AFq9FYLUEDsnm1J5zyVnuvMj+Z+1WdF2bHSnKDH/YV6tEIoFOgEpEtb3
 1pB7cHFu/13jtUhF5wrvbz5adiIPTlzBjpWSh/A4Bw8MS/kmFWy8WcfxULJ5qGM47rsMwuaLSrV
 0P0oH
X-Gm-Gg: AYBFou3Kav1bVi1+7d1+RALcQFCxuDPSxTj5GWEmGY4maDs7v1K/FfArZs4gaH09+dL
 ZjbD9Y2Tj9VVRxp7cVJQpMrkzIYZIuXJ6T6H7l8xflfrClrf6cA473MjXs0t6O+eSK/Bzl1xD3c
 7iE5x21pAdryeCsJxXrR5NqkoAKSCLkFCraT3jDzH2WkGQ0SrUEH4PXc6ov36cE0U3cBOb9vIoO
 4lZYt52aNc6f3IpUWNbyPMyUfP4Wff2M3eVTZuZWtpwGpWlmY8sw9NVAZvd13yuxHU+/vX6cHaS
 HLKhQMM1dYq5tVbPHodp7gsj9ugDTZSn0ivM42nFC7yC6HZSyvEGpjY0QEFE44jeHC3TjaMAvta
 H/JszjBzMlHsy8yVaWL7KUJ7S01Tyc33A6HjqNAiROhtUuXxB5gTaaKboaUfHNKMd7CGTie2mqm
 0qSoT2zeXf1NN2AH+fO9WaZ/W3LYhHbM8jX2Wm2xudZOlmDTrByMzby/Pi2LN2RvWA1q5KQGAnb
 MQDwPMTwaUsGuBw3ppBtAp4xWFSJ1rRDEy6LBK6AFUWTkLx3iRCHWvTQax6brlNEIJQJR8hny7j
 qHBx+ZFE6B9od83n1Q==
X-Received: by 2002:a05:6000:2f84:b0:48e:e98:8b64 with SMTP id
 ffacd0b85a97d-48e6e2eb232mr2034244f8f.19.1793322399823; 
 Thu, 29 Oct 2026 18:06:39 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v4 12/12] block/block-copy: coalesce write-zeroes tasks
Date: Fri, 30 Oct 2026 02:06:12 +0100
Message-ID: <20261030010613.1612771-13-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Task size was capped to block_copy_chunk_size() regardless of method,
which sizes a task by the copy buffer. A write-zeroes task carries no
buffer, so that cap only splits one long known-zero run into a crowd of
small COPY_WRITE_ZEROES tasks, each with its own request against the
target.

block_copy_task_create() already decides from zero_bitmap how far a task
may run, so add block_copy_widen_zero_area() to that decision: a
write-zeroes task runs to the next clean cluster of copy_bitmap, at most
BDRV_REQUEST_MAX_BYTES aligned down to cluster_size, and the existing
clamp cuts it back to where the zero run ends. The experimental x-perf
max-chunk does not bound it, and its documentation now says so.
Widening is safe: an overlapping caller waits on the task's BlockReq via
reqlist_wait_one() rather than observing it mid-flight.

A request that large is only cheap where the target zeroes by metadata.
BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
cannot, qcow2 v2 and iscsi among them, but it is optimistic for the
rest: file-posix advertises it at open and only learns from a failing
fallocate. So a write-zeroes task asks for it while the target is
believed to oblige, which costs nothing when it does. A refusal ends the
widening and shrinks the task to one cluster, written with fallback
allowed. The rest of the range is dirty again, and the next pass of
block_copy_common() picks it up as buffer-sized tasks running in
parallel. Part of the refused range may already be zeroed, since
-ENOTSUP only says the fast path is unavailable, and writing zeroes over
it again changes nothing.

Such a task is also the only one sure to need no buffer: without
NO_FALLBACK, bdrv_co_do_pwrite_zeroes() writes the zeroes out through a
bounce buffer. So it alone is left out of the memory pool and of the
rate limit, where one widened request would otherwise hold the job back
for as long as speed= takes to pass its whole length. The one-cluster
write left after a refusal is not charged either, though it may bounce:
that is at most one cluster per worker, once, as tasks created after the
refusal are charged in full.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c   | 96 +++++++++++++++++++++++++++++++++++++++-----
 qapi/block-core.json |  4 +-
 2 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 3b7e282e5b..c96b9ce4f1 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -92,19 +92,21 @@ typedef struct BlockCopyTask {
     BlockCopyState *s;
     BlockCopyCallState *call_state;
     /*
-     * @method can also be set again in the while loop of
-     * block_copy_dirty_clusters(), but it is never accessed concurrently
-     * because the only other function that reads it is
+     * @method and @zero_fast can also be set again in the while loop of
+     * block_copy_dirty_clusters(), but they are never accessed concurrently
+     * because the only other function that reads them is
      * block_copy_task_entry() and it is invoked afterwards in the same
      * iteration.
      */
     BlockCopyMethod method;
+    /* A write-zeroes task asking for BDRV_REQ_NO_FALLBACK. */
+    bool zero_fast;
 
     /*
      * Generally, req is protected by lock in BlockCopyState, Still req.offset
      * is only set on task creation, so may be read concurrently after creation.
-     * req.bytes is changed at most once, and need only protecting the case of
-     * parallel read while updating @bytes value in block_copy_task_shrink().
+     * req.bytes only shrinks, and need only protecting the case of parallel
+     * read while updating @bytes value in block_copy_task_shrink().
      */
     BlockReq req;
 } BlockCopyTask;
@@ -159,6 +161,8 @@ typedef struct BlockCopyState {
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
     BdrvDirtyBitmap *copy_bitmap;
+    /* Cleared once the target refuses BDRV_REQ_NO_FALLBACK. */
+    bool zero_widen; /* atomic */
     /* Clusters reading as zero; allocated on demand, frozen once valid. */
     HBitmap *zero_bitmap;
     /*
@@ -191,6 +195,23 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
     }
 }
 
+/*
+ * A write-zeroes task carries no buffer, so it may cover far more than
+ * block_copy_chunk_size(). Return how far it may run; the caller clamps it
+ * to where the zero run ends.
+ */
+static int64_t block_copy_widen_zero_area(BlockCopyState *s, int64_t offset,
+                                          int64_t bytes)
+{
+    int64_t clean;
+
+    bytes = MIN(bytes, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                       s->cluster_size));
+    clean = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, bytes);
+
+    return clean < 0 ? bytes : clean - offset;
+}
+
 /*
  * Search for the first dirty area in offset/bytes range and create task at
  * the beginning of it.
@@ -201,7 +222,9 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
 {
     BlockCopyTask *task;
     BlockCopyMethod method;
+    bool zero_fast = false;
     int64_t max_chunk;
+    int64_t search_end = offset + bytes;
 
     QEMU_LOCK_GUARD(&s->lock);
     max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
@@ -223,6 +246,11 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
 
         if (hbitmap_get(s->zero_bitmap, offset)) {
             method = COPY_WRITE_ZEROES;
+            zero_fast = qatomic_read(&s->zero_widen);
+            if (zero_fast) {
+                bytes = block_copy_widen_zero_area(s, offset,
+                                                   search_end - offset);
+            }
             boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
         } else {
             boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
@@ -248,6 +276,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
         .s = s,
         .call_state = call_state,
         .method = method,
+        .zero_fast = zero_fast,
     };
     reqlist_init_req(&s->reqs, &task->req, offset, bytes);
 
@@ -469,6 +498,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         .max_transfer = QEMU_ALIGN_DOWN(
                                     block_copy_max_transfer(source, target),
                                     cluster_size),
+        .zero_widen = target->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK,
     };
 
     s->discard_source = discard_source;
@@ -488,6 +518,15 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
     s->progress = pm;
 }
 
+/*
+ * Bytes @task moves as data, for the memory pool and the rate limit. Only a
+ * write-zeroes request that may not fall back is sure to need no buffer.
+ */
+static uint64_t block_copy_task_data_bytes(BlockCopyTask *task)
+{
+    return task->zero_fast ? 0 : task->req.bytes;
+}
+
 /*
  * Takes ownership of @task
  *
@@ -509,7 +548,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
 
     aio_task_pool_wait_slot(pool);
     if (aio_task_pool_status(pool) < 0) {
-        co_put_to_shres(task->s->mem, task->req.bytes);
+        co_put_to_shres(task->s->mem, block_copy_task_data_bytes(task));
         block_copy_task_end(task, -ECANCELED);
         g_free(task);
         return -ECANCELED;
@@ -520,6 +559,34 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
     return 0;
 }
 
+/*
+ * Widening a write-zeroes request only pays off where the target zeroes by
+ * metadata, so while the target is believed to oblige, a request asks to fail
+ * instead of falling back to writing the zeroes out. A refusal ends the
+ * widening and shrinks @t to one cluster for the caller to write the usual
+ * way; the rest is dirty again and is picked up at the buffer chunk size.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+block_copy_write_zeroes_fast(BlockCopyTask *t, bool *error_is_read)
+{
+    BlockCopyState *s = t->s;
+    int64_t nbytes = MIN(t->req.offset + t->req.bytes, s->len) - t->req.offset;
+    int ret;
+
+    ret = bdrv_co_pwrite_zeroes(s->target, t->req.offset, nbytes,
+                                (s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED) |
+                                BDRV_REQ_NO_FALLBACK);
+    if (ret == -ENOTSUP) {
+        qatomic_set(&s->zero_widen, false);
+        block_copy_task_shrink(t, s->cluster_size);
+    } else if (ret < 0) {
+        trace_block_copy_write_zeroes_fail(s, t->req.offset, ret);
+        *error_is_read = false;
+    }
+
+    return ret;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -622,8 +689,13 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     int ret = -1;
 
     WITH_GRAPH_RDLOCK_GUARD() {
-        ret = block_copy_do_copy(s, t->req.offset, t->req.bytes, &method,
-                                 &error_is_read);
+        if (t->zero_fast) {
+            ret = block_copy_write_zeroes_fast(t, &error_is_read);
+        }
+        if (!t->zero_fast || ret == -ENOTSUP) {
+            ret = block_copy_do_copy(s, t->req.offset, t->req.bytes, &method,
+                                     &error_is_read);
+        }
     }
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
@@ -640,7 +712,7 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
             progress_work_done(s->progress, t->req.bytes);
         }
     }
-    co_put_to_shres(s->mem, t->req.bytes);
+    co_put_to_shres(s->mem, block_copy_task_data_bytes(t));
     block_copy_task_end(t, ret);
 
     if (s->discard_source && ret == 0) {
@@ -867,6 +939,7 @@ block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
     }
     if (ret & BDRV_BLOCK_ZERO) {
         task->method = COPY_WRITE_ZEROES;
+        task->zero_fast = qatomic_read(&s->zero_widen);
     }
 
     return true;
@@ -935,11 +1008,12 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
             }
         }
 
-        ratelimit_calculate_delay(&s->rate_limit, task->req.bytes);
+        ratelimit_calculate_delay(&s->rate_limit,
+                                  block_copy_task_data_bytes(task));
 
         trace_block_copy_process(s, task->req.offset);
 
-        co_get_from_shres(s->mem, task->req.bytes);
+        co_get_from_shres(s->mem, block_copy_task_data_bytes(task));
 
         offset = task_end(task);
         bytes = end - offset;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741c8165c0..2edd3bccaa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1656,7 +1656,9 @@
 #     copying process.  Doesn't influence copy-before-write
 #     operations.  0 means unlimited.  If max-chunk is non-zero then
 #     it should not be less than job cluster size which is calculated
-#     as maximum of target image cluster size and 64k.  Default 0.
+#     as maximum of target image cluster size and 64k.  Write-zeroes
+#     requests to a target which zeroes efficiently are not bounded by
+#     it.  Default 0.
 #
 # @min-cluster-size: Minimum size of blocks used by copy-before-write
 #     and background copy operations.  Has to be a power of 2.  No
-- 
2.53.0


