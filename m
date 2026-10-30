Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104E606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=rHQEe2yZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb54-0002NX-Jk; Thu, 29 Oct 2026 21:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4t-0002Fl-6y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4l-0006Fu-9A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so124698f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322393; x=1793927193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f20d2Ek+xNWNYFT8dEXpzY4CN9pgSsWok3ap5ujGf/Q=;
 b=rHQEe2yZo/nr5t6mPfgMa1ysuaXmR42K0g9Q0fKvkrm5l5fhlpyTB6SJxxra1JVtya
 j1T/dahWh55Ou3by563b2Kuf/dBjzQHTKi9M6gpB9mG7weQZxMEnwY3ns+UUyNPIOlcP
 /xIFldmLXIXw11V56And884AN3vqATkUH657+DNNzEqQOWrNP68EwZUh/+D5/1AWKf2p
 42V69YrAqHMBmUsn5hXcT8E5bx6GmRNn0BQraUECOs0xMNo6v5dDU3OvtZva9bK+tZkk
 /XpRhr0Ts79nNzSlRAlxPmol3ch4xUQyyNAqXapljBwGcQXvIpCH2pz4iVz7+RMTcIdA
 7n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322393; x=1793927193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f20d2Ek+xNWNYFT8dEXpzY4CN9pgSsWok3ap5ujGf/Q=;
 b=ROCjJPf4JfmCtoddtsPgi0gTet7ZeTeBxG6p7ZoxMC8btrQzIlrQ/l6hF3DuAi/Xb5
 r3jvwtLb6rdAZUxy0K0NCVE3jh9mD5ynL2CkVUEPqtb0VJXola8UmLRiNOFCHfo6WcYw
 5hn9VCPq27fwbd+hLK7bZYVS42u5BVhLSzZ9nsq30Xgi6zqaW9VBRdw2ijSUwJ1l6JQE
 khc6+O8WO5JomSVO0cKDcwYirsMQUHGIqOYwxpt8x2uGGFysJE/cNEjYaVfRcxXlkNIW
 PGNR9AwLEmKSBvgz4YGNQPA8JW77fYdMvbm99WYcO2fYeaewtWaSJZnrezcj3Izw3xKS
 E4rw==
X-Gm-Message-State: AFq9FYJbkPxUuPD36o3JFGRzW5XqCx19X1yIcBCJC+EAnOIp70SXzM27
 Z89CA8Zlb84m1MNUBu8WCx6+ps5Qa3vZijNpQUL/MDEZmSMsRhgKFnHRLZtRmSkPnzd0AY6MRSu
 C7YT3
X-Gm-Gg: AYBFou3w0NwRCuSFYnhBm4oYIC4EErevpMPmAy7b/pqU72O0Jud+uktqXQZfIi50d+1
 EMnYY8OZ6yW7c3LfLUpkFIP5Dr2+o9RPapXdf6149GhXZJECiPFryTvIUWrjOuYukk/1r53bkks
 z7p3deGnZXz3rotKEuoebG/kZR7Xqs5kZhDGk1oApYTw3lUEBMllJEMQGQlKLwWwOL5lKYceqlX
 4p1+gTC8U/iyFzw37vAJ44TSOGB0OgFGRstrsjpluT+VIJF6swhmTkg7BOkDBescmAUtolLwLrR
 Yk5w1hYcK24w1mZRgwjEc2wjK+lIMEDYj3XOI8crDh6ERVXOGjB5ENlh42aYJBwpsuzMlOIXE09
 DM1Vs0dT8PaRLvIkq4mzFF+V8deTBkkoAOx1zvoB7yg0uzDp+IPTc5wUH+N8moGcY1GfZjWL/Zm
 NqwsFgZdy+z2qc/KQpduRcRzhueUSvKPW7M4CkfN+0xVGkDSrxd0QCJiXlBVvZgOyiCmr+xag28
 eCBXWtXPGVpQQHVYH793DRhNtWvQtYXMnTr3dksdIbYGVEPvJV6dcS/EKVJP4cRcyHXOjXCgcZJ
 hqOWnhrG/RoqWljjiw==
X-Received: by 2002:a05:6000:2c0d:b0:48e:661e:8766 with SMTP id
 ffacd0b85a97d-48e661e88c5mr9849074f8f.17.1793322392992; 
 Thu, 29 Oct 2026 18:06:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 07/12] block/backup: pre-fill zero_bitmap for full/bitmap
Date: Fri, 30 Oct 2026 02:06:07 +0100
Message-ID: <20261030010613.1612771-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=den@openvz.org; helo=mail-wr1-x42f.google.com
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

Only sync=top runs an up-front scan, so the previous patch did nothing
for the other modes. FULL and BITMAP know their complete copy_bitmap
before copying starts, and the same copy-before-write guarantee holds:
a cluster still dirty when the copy loop reaches it has not been written
since the scan.

Add block_copy_calculate_zero_bitmap(), driven one query at a time from
backup_scan_source() so the graph rdlock and the pause point are taken
per query, and query each confirmed span once however many dirty areas
it covers. Each step searches copy_bitmap only a bounded window ahead,
since for sync=full the rest of the image is one dirty area. The scan
only fills zero_bitmap and never clears copy_bitmap, so sync=full still
writes zeroes for clusters the source never allocated; it just stops
re-querying to find that out. Unlike the per-task queries it replaces
the scan is serial, so a sparsely dirtied job against a slow source may
spend more time here than it saves. The sync=top loop had the same
shape, so both fold into backup_scan_source().

sync=none keeps the per-task query. Its bitmap says "anything may be
copied", not "this will be copied", and it only ever copies what the
guest writes during the fleecing window, so scanning the whole image at
attach is the wrong trade.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             | 94 ++++++++++++++++++++++++--------------
 block/block-copy.c         | 42 +++++++++++++++++
 include/block/block-copy.h |  4 ++
 3 files changed, 106 insertions(+), 34 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 11d70243e2..38b0838d69 100644
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
+        g_assert_not_reached();
     }
 
-    return 0;
+    return backup_loop(s);
 }
 
 static void coroutine_fn backup_pause(Job *job)
diff --git a/block/block-copy.c b/block/block-copy.c
index 507c4bab90..4f128a0ebd 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -808,6 +808,48 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
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
+    int64_t max_bytes = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                        s->cluster_size);
+    int64_t dirty_offset, dirty_bytes, dirty_end;
+    bool found;
+
+    /* CBW mutates copy_bitmap from its own AioContext meanwhile. */
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        found = bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset,
+                                                  s->len, max_bytes,
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
+    *count = MIN(*cached_end, dirty_end) - offset;
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


