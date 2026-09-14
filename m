Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2CAC88E78
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683l-0002qH-SO; Mon, 14 Sep 2026 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683V-0002fA-J2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683R-0005oB-Ld
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49e6bad7b79so19388075e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397586; x=1790002386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=liBSdTP5ff8LcPYB2vyoXB7PN69e2uBoRDzt5wyNAtk=;
 b=haSwEJgXjfAkYIfwQhjN685G7Cvo53rxJ8p+0YalHD3cDSc5840+kA2I9LJWzsgbqM
 amZnffnsJae+QfMDRjYUkGG6QkXSI0WQ1Zr4bL3dyRFErkCPa8nnpowspr5VCbKOoLRl
 KtSFfQa2y2ByFrfjvW3oBJC7T/3HSjqVFZy7HSvQI3hOmQqzGEcxBYLJk4/KUiH2OCZV
 cBQSaCF8aIRO3eTsAqFPR98Llu1dtaAWxbw1el/7/ECX2/ZJKINh9c+7JjtR1IoSbFDL
 RRBbjQIM/nakI+VmXYMFklYueGa7BjwcXyvo6QU8NpKhHvncw87fKaqpAyDPiBZ0e9I5
 WLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397586; x=1790002386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=liBSdTP5ff8LcPYB2vyoXB7PN69e2uBoRDzt5wyNAtk=;
 b=TXhpFiz0tRpxU7QEoJ0VWCvfQJ3dbadBeCO7SAm2EzYBQQaOh2nUPxn/OSOVsIpNVu
 iv4QNhM2QqfFPT0bYj7ja0QDUc5fwi4MID2o0ySDv9U9d+x1c2DVGrqdxUngKHMt/How
 AwOW8FwB2WbeBYnnL27MLwwK0yM7QvXgEQkJmgk4vLzpwb1ziL6QXmS0bmiB95kHVq8/
 r+fOXA4dRpT91Sznhg7JsVMbGo8fi1f6JdOyGF3CnRcSR5PMIeEEjglGpUJRzirpHsKQ
 GslO19dQtYYJSl0dEUDizlLpvXEhMbYEWVomyUkF0QpE+Bqu48rp9ZxTI96CVQ9XZ2o6
 Typw==
X-Gm-Message-State: AFuF++ka2VUGfVE87RVGqnh9g35KZZzQ5EzlqV2EcLdacFnSM0qB02ra
 sdwE7ghJBNopFkcnSuo1C+fwiD5nuaR1S9DsrT1otrl20azL20Cq9EAVMI/g4zaAqozOLrLx0cL
 deiBb
X-Gm-Gg: AYBFou3Fiy6BxGLKSLMDoJ3iI+mY23iOSVAV2US8FD1tht/87246C/AFh26xv68A137
 yHi2ctz+5EqF/KTDFcWEvphV2mktpRMDZaU+VGzVRJFrRjy4qqJxa3nPtWIAwRSrpyVrR4LvQZK
 p5Enb+gIHI2ZAS+/i9dHbV4nOzlTb5iMLptMIhQEcDamFhnskAZaQCM7hcGGkVWMghOOMxQmhW+
 nZDkAa/nqt4JCfSqf+mGruZy+gKOTNqDS7xGKZpQypWOAbiwfn0CgHbbbFQauPbQ00z2AZNLy5W
 qb/tCjZkfwVAu9Tj8V8PaCvruuFlj370GrF5qPDSlQwIWx+hFkL6ryaoOU+qysd4gk6GdJDdQnY
 HVGXQ9r6FCjiZmjawd7yPeoExfPpEEziiVpuc0ojETsWBGNHjnFwFtAXQTEjapJD/42TN2Xzs0U
 jwccI9va8b+lw4eG8T9YiQy2xBbRQOawBaG5QFQAlguwwTELZQ3H1JeHmO39kcaA/SZO1i4ODGf
 YZ1MdI=
X-Received: by 2002:a05:600c:190d:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49e7a63a894mr37881775e9.4.1789397586155; 
 Mon, 14 Sep 2026 07:53:06 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:53:05 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 9/9] block/block-copy: coalesce write-zeroes tasks
Date: Mon, 14 Sep 2026 16:52:50 +0200
Message-ID: <20260914145250.2792879-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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
sector, so it is aligned down at the use site, nothing bounding
cluster_size. Widening is safe: an overlapping caller waits on the
task's BlockReq via reqlist_wait_one() rather than observing it
mid-flight.

A request that large is only cheap where the target zeroes by metadata.
BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
cannot, qcow2 v2 and iscsi among them, but it is optimistic for the rest:
file-posix advertises it at open and only learns from a failing
fallocate. So the first widened request also asks for it, which costs
nothing when the target obliges and fails without writing when it does
not. The run then keeps every write-zeroes request at the buffer chunk
size, and the range that found out is written in those chunks.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 99 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index c0a3359938..16f3d04819 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -38,6 +38,12 @@
 #define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
 #define BLOCK_COPY_CLUSTER_SIZE_DEFAULT (1 << 16)
 
+typedef enum {
+    ZERO_WIDEN_UNPROBED,
+    ZERO_WIDEN_ON,
+    ZERO_WIDEN_OFF,
+} BlockCopyZeroWiden;
+
 typedef enum {
     COPY_READ_WRITE_CLUSTER,
     COPY_READ_WRITE,
@@ -159,6 +165,8 @@ typedef struct BlockCopyState {
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
     BdrvDirtyBitmap *copy_bitmap;
+    /* Whether the target zeroes by metadata; see block_copy_write_zeroes(). */
+    BlockCopyZeroWiden zero_widen; /* atomic */
     /* Clusters reading as zero; allocated on demand, frozen once valid. */
     HBitmap *zero_bitmap;
     /* Published only after the scan, with skip_unallocated already false. */
@@ -187,6 +195,34 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
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
@@ -198,6 +234,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
     BlockCopyTask *task;
     BlockCopyMethod method;
     int64_t max_chunk;
+    int64_t search_end = offset + bytes;
 
     QEMU_LOCK_GUARD(&s->lock);
     max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
@@ -219,6 +256,10 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
 
         if (hbitmap_get(s->zero_bitmap, offset)) {
             method = COPY_WRITE_ZEROES;
+            if (qatomic_read(&s->zero_widen) != ZERO_WIDEN_OFF) {
+                bytes = block_copy_widen_zero_area(s, call_state, offset,
+                                                   search_end, bytes);
+            }
             boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
         } else {
             boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
@@ -465,6 +506,8 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         .max_transfer = QEMU_ALIGN_DOWN(
                                     block_copy_max_transfer(source, target),
                                     cluster_size),
+        .zero_widen = target->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK ?
+                      ZERO_WIDEN_UNPROBED : ZERO_WIDEN_OFF,
     };
 
     s->discard_source = discard_source;
@@ -521,6 +564,54 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
     return 0;
 }
 
+/*
+ * Widening a write-zeroes request only pays off where the target zeroes by
+ * metadata. Ask the first one to fail instead of falling back to writing the
+ * zeroes out: it then costs nothing, and a target which would have written
+ * them keeps its requests small for the rest of the run.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+block_copy_write_zeroes(BlockCopyState *s, int64_t offset, int64_t bytes,
+                        bool *error_is_read)
+{
+    BdrvRequestFlags flags = s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED;
+    int64_t chunk = bytes;
+    int ret = 0;
+
+    if (qatomic_read(&s->zero_widen) == ZERO_WIDEN_UNPROBED) {
+        ret = bdrv_co_pwrite_zeroes(s->target, offset, bytes,
+                                    flags | BDRV_REQ_NO_FALLBACK);
+        if (ret != -ENOTSUP) {
+            qatomic_set(&s->zero_widen, ZERO_WIDEN_ON);
+            goto out;
+        }
+
+        /* Nothing has been written, so the whole range is still to do. */
+        qatomic_set(&s->zero_widen, ZERO_WIDEN_OFF);
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
@@ -552,13 +643,7 @@ block_copy_do_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
 
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


