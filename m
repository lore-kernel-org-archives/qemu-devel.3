Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A46C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqQ-0002kz-0A; Fri, 28 Aug 2026 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqO-0002kF-N9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqM-0000i6-B5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so12750775e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928369; x=1788533169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJs5q0k6Ad65mdVAHbHvZTkV+6jv0q/NjjLKksIrv+E=;
 b=GemDAjK7mTUBdEjLsaxEdpXq0gC6xgSb65YzQeT4+4qhsvjBQ4ogptpbacH9ptjIxQ
 WbR+1ZGs5eGNowd2zF5tdyPaNrgQUIBxw6bV7a7E3UsWd9EIQQptVQmEsjEdLRbj/P6v
 srI+4MTekdHGYSd4HH/2uI8jUhc3RTQYr3+eoCoTLD6/8YOKjgMnbEgCOdFnocEMUB6E
 8q7iwb8GfNHz07tJvzG1aYBzAevwhYaUPlIZFl6JROCIumCkZQ/52m2dSDliU3yI8er4
 V0IYUbNdkREb9NAtSXv+EGTxZDpxOCCBVE5oTnXU1PiW4TwGCjsWsa/mVSnstTx1xYGD
 XXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928369; x=1788533169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJs5q0k6Ad65mdVAHbHvZTkV+6jv0q/NjjLKksIrv+E=;
 b=Yj1/TQhFsy20kniEb4RoxYjObmWXOa/X/bZuy/6QnF4SGO82oCYUXFrZAO40woj8MM
 klcpc4G97pTumw497Qz+i3w6V8mwdRjljYj2MQzw414D8TTLIu0oLr81CEjUwqVz8Q+b
 GA3BJgB4U0AT3twmMktdlyrxuxSA+FqqH1hPSqi2zGCdF0UC3gYS4HRyfdSYp3K1wJRc
 +zSdu7YkeuyFZPEOUelVALgp5rKOB5v/ddq7R86MzWjcVGCPXZQ+3Go8Aa1cp0nv101T
 Y7gdXBC8ir3bASMm5H9lHW0Kt6OLLa9z4414gVemm8shqp8T0SS+7ZoMZu4YUe5jqyZq
 HHtA==
X-Gm-Message-State: AFuF++kXi9g6r3BS2/58WSf7MIhAZhatm0DGr07DDAgQ9fV6lkZgY/pN
 xf7sAWfPa2jj3OYlsF7BHVYHS85rlYz5EC2k7+e0U9arXwQ1QrWEQ4vcxd/55/mHm9y2AwGwihH
 oO7Qw
X-Gm-Gg: AR+sD10uQe+EVRMK6adgcwH+SVa0zShCbAh9iJKypcpJRfoJ3cZ8LLBMCDreLS1ckf4
 UH6iGQUhTvn1MManKycOV0gdVX8uUg7/5EGWaDcPFBvGOBYCvYaGeGX1s1UQVQnssEMl7Yd7u4J
 tzY42PlicZJ0A4mirSWtGc2OpoxQ5udk/imlrkvsn2EeJiBLBOBT6CNETUjCq/gG8S9zHe0cSYK
 z2qCwMCLmDaxgnb2H935Cbn6HUxA2I8i9cvoPrnRsPPy/vXWKwta5l5n27QuDevP/dO2RhQeTip
 wlmYSCUMmqIuD4ziJ0Z3W7shmLYKoW0BO3wV+Q44P8DjMqgN8TPaItcrpd1s7+x+2uhNYBVP73n
 yR1ZDEb0dvVOHdZvC7RLT94sPY2J57Xi1lnDJT8RaC8zSvEtDMbEkPdZHk+b056MONwzVWLU4C/
 ZzHxwb6fw6foeovZEwf4EHTbnaw+ms2cltB7beAhOR00jKrBdVzo4S9LkXzw==
X-Received: by 2002:a05:600c:19ca:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-49b91c47b3dmr108463655e9.11.1787928368601; 
 Fri, 28 Aug 2026 07:46:08 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 8/9] block/backup: pre-fill zero_bitmap for full/bitmap
Date: Fri, 28 Aug 2026 16:45:53 +0200
Message-ID: <20260828144554.1741910-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

Only sync=top runs an up-front scan, so the previous patch did nothing
for the other modes. FULL and BITMAP know their complete copy_bitmap
before copying starts, and the same copy-before-write guarantee holds:
a cluster still dirty when the copy loop reaches it has not been written
since the scan.

Add block_copy_calculate_zero_bitmap(), driven one query at a time from
backup_scan_source() so the graph rdlock and the pause point are taken
per query, and query each confirmed span once however many dirty areas
it covers. The scan only fills zero_bitmap and never clears copy_bitmap,
so sync=full still writes zeroes for clusters the source never
allocated; it just stops re-querying to find that out. Unlike the
per-task queries it replaces the scan is serial, so a sparsely dirtied
job against a slow source may spend more time here than it saves. The
sync=top loop had the same shape, so both fold into
backup_scan_source().

sync=none keeps the per-task query. Its bitmap says "anything may be
copied", not "this will be copied", and it only ever copies what the
guest writes during the fleecing window, so scanning the whole image at
attach is the wrong trade.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             | 94 ++++++++++++++++++++++++--------------
 block/block-copy.c         | 41 +++++++++++++++++
 include/block/block-copy.h |  4 ++
 3 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 11d70243e2..b6e559a97e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -247,59 +247,85 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
     job_progress_set_remaining(&job->common.job, estimate);
 }
 
-static int coroutine_fn backup_run(Job *job, Error **errp)
+/*
+ * Walk the source before copying starts: fill zero_bitmap and, for sync=top,
+ * drop the clusters that are not allocated above the backing.
+ */
+static int coroutine_fn backup_scan_source(BackupBlockJob *s)
 {
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    int ret;
-
-    backup_init_bcs_bitmap(s);
-
-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
-        int64_t offset = 0;
-        int64_t count;
+    Job *job = &s->common.job;
+    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
+    int64_t offset, cached_end = 0, count;
+    int ret = 0;
 
-        for (offset = 0; offset < s->len; ) {
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
+    for (offset = 0; offset < s->len; offset += count) {
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
 
-            job_pause_point(job);
+        job_pause_point(job);
 
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
 
-            /* rdlock protects the subsequent call to bdrv_is_allocated() */
-            bdrv_graph_co_rdlock();
+        /* rdlock protects the block-status queries below */
+        bdrv_graph_co_rdlock();
+        if (top) {
             ret = block_copy_reset_unallocated(s->bcs, offset, &count);
-            bdrv_graph_co_rdunlock();
-            if (ret < 0) {
-                return ret;
-            }
+        } else {
+            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
+                                             &count);
+        }
+        bdrv_graph_co_rdunlock();
 
-            offset += count;
+        if (ret < 0) {
+            return ret;
         }
+    }
+
+    if (top) {
         block_copy_set_skip_unallocated(s->bcs, false);
-        block_copy_set_zero_bitmap_valid(s->bcs);
     }
+    block_copy_set_zero_bitmap_valid(s->bcs);
 
-    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    return 0;
+}
+
+static int coroutine_fn backup_run(Job *job, Error **errp)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+    int ret;
+
+    backup_init_bcs_bitmap(s);
+
+    switch (s->sync_mode) {
+    case MIRROR_SYNC_MODE_TOP:
+    case MIRROR_SYNC_MODE_FULL:
+    case MIRROR_SYNC_MODE_BITMAP:
+        ret = backup_scan_source(s);
+        if (ret < 0) {
+            return ret;
+        }
+        break;
+
+    case MIRROR_SYNC_MODE_NONE:
         /*
          * All bits are set in bcs bitmap to allow any cluster to be copied.
-         * This does not actually require them to be copied.
+         * This does not actually require them to be copied. Yield until the
+         * job is cancelled and let the before_write notify callback service
+         * CoW requests.
          */
         while (!job_is_cancelled(job)) {
-            /*
-             * Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests.
-             */
             job_yield(job);
         }
-    } else {
-        return backup_loop(s);
+        return 0;
+
+    default:
+        break;
     }
 
-    return 0;
+    return backup_loop(s);
 }
 
 static void coroutine_fn backup_pause(Job *job)
diff --git a/block/block-copy.c b/block/block-copy.c
index 94d4f3dd69..c0a3359938 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -813,6 +813,47 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
+/*
+ * One scan step, like block_copy_reset_unallocated(); @cached_end
+ * tracks progress across calls, @count how far @offset should move.
+ */
+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count)
+{
+    int64_t dirty_offset, dirty_bytes, dirty_end;
+    bool found;
+
+    /* CBW mutates copy_bitmap from its own AioContext meanwhile. */
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        found = bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset,
+                                                  s->len, INT64_MAX,
+                                                  &dirty_offset, &dirty_bytes);
+    }
+
+    if (!found) {
+        *count = s->len - offset;
+        return;
+    }
+    dirty_end = dirty_offset + dirty_bytes;
+
+    if (*cached_end < dirty_end) {
+        int64_t clusters;
+        int64_t query_offset = MAX(dirty_offset, *cached_end);
+        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
+
+        if (ret >= 0) {
+            *cached_end = query_offset + clusters * s->cluster_size;
+        } else {
+            /* Best-effort: leave this area unmarked; it copies as data. */
+            *cached_end = dirty_end;
+        }
+    }
+
+    /* 0 if the query above didn't yet reach dirty_end: try again next call. */
+    *count = *cached_end >= dirty_end ? dirty_end - offset : 0;
+}
+
 /*
  * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
  * shrink @task. Returns false if @task is to be skipped (already ended,
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index e4e5b56753..3a61066b55 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -44,6 +44,10 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);
 int64_t coroutine_fn GRAPH_RDLOCK
 block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);
 
+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count);
+
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool ignore_ratelimit, uint64_t timeout_ns,
                             BlockCopyAsyncCallbackFunc cb,
-- 
2.53.0


