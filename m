Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF2CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7f-00063s-7L; Tue, 29 Sep 2026 11:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7S-0005sO-VT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:51 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7N-0001TG-7Y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:48 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso3510346f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697104; x=1791301904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uSYCU2wY83TuX28IyI/gF41SHzkxKRLllFlKhgVPhn8=;
 b=Sk1oV/KI0bZIRrkz/KR/VqeuheaofJcsoQQ3N0k1uUfxD83bxC4sOmexKQ4jO+MW/b
 WJYMHHhZZ6ePI+0cIr5x+SiFCj25Ntl45U6ocVRufB4a+ANM6Rk9U2bV1y60zFdVqqgD
 Z1WnsiL81/tl3KtN8R1rB+U1Y/LN/yo9r2mMM7Dn3mJWlcrYHmpjHDQiBiS6/dtnD2bE
 09nIMvjMgyetlT1X/qSfcAPg3Sjn9YJx5mcemc0Z+YHJ6nSaa2kh+/xYsVCZaXnQjUfb
 0PFXZb1c1XZDiShEvaE0MJxyT2zujB6FTjglTuvudKc8+TyDZrvF9+FALDZ4U+UksPrY
 KPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697104; x=1791301904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uSYCU2wY83TuX28IyI/gF41SHzkxKRLllFlKhgVPhn8=;
 b=UExxudwn9Rl8eHKc4olRqEunDGsL2yeN8oIO1Xekm/xxP3cU4iUt69IFHvbZL0Bgum
 VLmb76BMTRqu4NtBS/TQ4G7bwnVBJBJ3TjEoH4EjF85PPM/6LYN9JR+Xc44CEv/TvqvZ
 C3ScklqsBWw3quJVJFNfq4SDOuBePxzjkTuHswUGxmV/SD1iLPuiq/a9NTrO1c7NtnGU
 9aNdbzy/RVvvgNYNudWCTw6AnyXxKowQvTGDUP3Q6EruN2OyLPUZJwXtRZyaXee3ukRw
 U+5Xp/K8ZkwAK5heuwUSo9bVriv7iReT3vuZ3eAPoQklrk6RAqX1XA9qn9UI6R1NZX1D
 DUgg==
X-Gm-Message-State: AFq9FYIBQ3KS8cx62KR+CGirKsQNMCxLqRG180AA2jeLSKPt93MTeo5w
 XUtrtwiubtSz7zJOO51FTRhhF5hTn5TflKT9jFqszF35nyYrFDClV/LdfH7nH1YTKU+1fgMsIBI
 uMIHu
X-Gm-Gg: AYBFou3mc25SkRZVNhkxXO0vUBcY+w+fy3DRQ6/XU9QWIwSnb9vxfxPRWAOp2/VrpOA
 oJd6Syj/GtuIV0xUELCxTLorRH6NI7kgR7+0Z0R05XKLsl/YD2DUhNDa1DM1oba6FIN8JyllgfA
 SxB3sYXNrhAvd+pgas7d+BPuxDsea7KAl6q496cv8RMGj3bTSWA4gilit6em6VqoUd5SCskIN3g
 QTZhoO+puQodf4jTWxq/WwjHHEPsdWonlBCZxMUbOi9CXyMvJQRB4/mhGTO3emJdvXzgZT8ccWq
 8te8Qmot88iS5pZnB6maqYCdZKoOjnvNMv/0bvKNrQEbdJrbIMvRputrcNL5zCmUyhfmndc9f6y
 Idji6FH2zufOtk8zaJOvaf0OGSLek97n4Dt+SDmWWWdeIRyAq6WJLd8ltmwzHTZ8cZ3G+z4MGr2
 bTSyi/7nlWPrrkrdWazpEvvmIKZmyD7HqJomx2Nl5BIp/M4ovSa/vdoEdqew==
X-Received: by 2002:a05:6000:386:b0:488:8c99:fbc8 with SMTP id
 ffacd0b85a97d-4888c99fcccmr14354971f8f.50.1790697103751; 
 Tue, 29 Sep 2026 08:51:43 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:42 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 9/9] block/block-copy: coalesce write-zeroes tasks
Date: Tue, 29 Sep 2026 17:51:25 +0200
Message-ID: <20260929155125.3151111-10-den@openvz.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Task size was capped to block_copy_chunk_size() regardless of method,
which sizes a task by the copy buffer. A write-zeroes task carries no
buffer, so that cap only splits one long known-zero run into a crowd of
small COPY_WRITE_ZEROES tasks, each with its own request against the
target.

block_copy_task_create() already decides from zero_bitmap how far a task
may run, so add block_copy_widen_zero_area() to that decision: for a
write-zeroes task, re-search the dirty area under BDRV_REQUEST_MAX_BYTES
instead of the buffer chunk size, and let the existing clamp cut it back
to where the zero run ends. That bound is INT_MAX rounded down to a
sector, so nothing has aligned it to cluster_size and it is aligned down
at the use site. Widening is safe: an overlapping caller waits on the
task's BlockReq via reqlist_wait_one() rather than observing it
mid-flight.

A request that large is only cheap where the target zeroes by metadata.
BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
cannot, qcow2 v2 and iscsi among them, but it is optimistic for the rest:
file-posix advertises it at open and only learns from a failing
fallocate. So a write-zeroes request asks for it while the target is
believed to oblige, which costs nothing when it does. A refusal ends the
widening, and the range is written in buffer-sized chunks, as is any
task widened before the refusal came. -ENOTSUP says the fast path is
unavailable, not that the target wrote nothing, so the range is
rewritten whole: zeroes over zeroes change nothing.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 94 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index c0a3359938..94ca2a10ed 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -159,6 +159,8 @@ typedef struct BlockCopyState {
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
     BdrvDirtyBitmap *copy_bitmap;
+    /* Whether a write-zeroes task may widen; see block_copy_write_zeroes(). */
+    bool zero_widen; /* atomic */
     /* Clusters reading as zero; allocated on demand, frozen once valid. */
     HBitmap *zero_bitmap;
     /* Published only after the scan, with skip_unallocated already false. */
@@ -187,6 +189,34 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
     }
 }
 
+/*
+ * A write-zeroes task carries no buffer, so it may cover far more than
+ * block_copy_chunk_size(). Return how far it may run; the caller clamps it
+ * to where the zero run ends.
+ */
+static int64_t block_copy_widen_zero_area(BlockCopyState *s,
+                                          BlockCopyCallState *call_state,
+                                          int64_t offset, int64_t search_end,
+                                          int64_t bytes)
+{
+    int64_t aligned = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                      s->cluster_size);
+    int64_t zero_chunk = MIN_NON_ZERO(MAX(aligned, s->cluster_size),
+                                      call_state->max_chunk);
+    int64_t wide_offset, wide_bytes;
+
+    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset, search_end,
+                                           zero_chunk, &wide_offset,
+                                           &wide_bytes)) {
+        return bytes;
+    }
+
+    /* @offset is dirty, so the search cannot have moved past it. */
+    assert(wide_offset == offset);
+
+    return wide_bytes;
+}
+
 /*
  * Search for the first dirty area in offset/bytes range and create task at
  * the beginning of it.
@@ -198,6 +228,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
     BlockCopyTask *task;
     BlockCopyMethod method;
     int64_t max_chunk;
+    int64_t search_end = offset + bytes;
 
     QEMU_LOCK_GUARD(&s->lock);
     max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
@@ -219,6 +250,10 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
 
         if (hbitmap_get(s->zero_bitmap, offset)) {
             method = COPY_WRITE_ZEROES;
+            if (qatomic_read(&s->zero_widen)) {
+                bytes = block_copy_widen_zero_area(s, call_state, offset,
+                                                   search_end, bytes);
+            }
             boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
         } else {
             boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
@@ -465,6 +500,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         .max_transfer = QEMU_ALIGN_DOWN(
                                     block_copy_max_transfer(source, target),
                                     cluster_size),
+        .zero_widen = target->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK,
     };
 
     s->discard_source = discard_source;
@@ -521,6 +557,56 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
     return 0;
 }
 
+/*
+ * Widening a write-zeroes request only pays off where the target zeroes by
+ * metadata, so while the target is believed to oblige, a request asks to fail
+ * instead of falling back to writing the zeroes out. That costs nothing when
+ * it does oblige, and a refusal ends the widening for the rest of the run.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+block_copy_write_zeroes(BlockCopyState *s, int64_t offset, int64_t bytes,
+                        bool *error_is_read)
+{
+    BdrvRequestFlags flags = s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED;
+    int64_t chunk;
+    int ret = 0;
+
+    if (qatomic_read(&s->zero_widen)) {
+        ret = bdrv_co_pwrite_zeroes(s->target, offset, bytes,
+                                    flags | BDRV_REQ_NO_FALLBACK);
+        if (ret != -ENOTSUP) {
+            goto out;
+        }
+
+        /* Redoing the range is safe: zeroes over zeroes change nothing. */
+        qatomic_set(&s->zero_widen, false);
+    }
+
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        chunk = block_copy_chunk_size(s);
+    }
+
+    while (bytes) {
+        int64_t n = MIN(bytes, chunk);
+
+        ret = bdrv_co_pwrite_zeroes(s->target, offset, n, flags);
+        if (ret < 0) {
+            break;
+        }
+
+        offset += n;
+        bytes -= n;
+    }
+
+out:
+    if (ret < 0) {
+        trace_block_copy_write_zeroes_fail(s, offset, ret);
+        *error_is_read = false;
+    }
+
+    return ret;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -552,13 +638,7 @@ block_copy_do_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
 
     switch (*method) {
     case COPY_WRITE_ZEROES:
-        ret = bdrv_co_pwrite_zeroes(s->target, offset, nbytes, s->write_flags &
-                                    ~BDRV_REQ_WRITE_COMPRESSED);
-        if (ret < 0) {
-            trace_block_copy_write_zeroes_fail(s, offset, ret);
-            *error_is_read = false;
-        }
-        return ret;
+        return block_copy_write_zeroes(s, offset, nbytes, error_is_read);
 
     case COPY_RANGE_SMALL:
     case COPY_RANGE_FULL:
-- 
2.53.0


