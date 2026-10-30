Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D07606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=iox2hQmD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb51-0002MN-Qo; Thu, 29 Oct 2026 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4x-0002Is-JZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4n-0006GN-6L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so133857f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322395; x=1793927195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FOP9eWIZEsEM0uhGEfT1U3RerCwOgmk215ry3JCIszA=;
 b=iox2hQmDy0mMeo3i2hg01bBUGP1FXQdIhx+H5BrHxTe+bCnOWJvFQizK8S/UWmuiQ+
 Xw3RLKv8XomDHlby53NtZ6v09Z7KmATNT/4kNquD37q058k+ldXN7BvSAbKgJ9RVMxi9
 Bnt4SmzP5JuwhxhOLpYjc+y8MK6krCuWO2afJ3htuMK6fVwvvZWzCXdGElYXsOe3iw8X
 2jwTk9HSQqBWYg7pkuB0bRXl3AxMTluVG5NH8yUu5ChI7odg5fpELoAdjbNSUO9dUOXp
 RXWnxDQiVYgOLaA7uz/dpzDjL2bwAUjNE+IUr90F9jSutTfaB//piiyivr5+m/S2NM61
 2VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322395; x=1793927195;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOP9eWIZEsEM0uhGEfT1U3RerCwOgmk215ry3JCIszA=;
 b=Twu5muP5EInhyeTbD6+nGPt6kzAk+8HotQnVl9UWeEJ8pGkb8CM6s0p0QtOhE49Psl
 TLfiKKtz2SFSijexdZWp4LHA6ejAjbNyeeJmk4BcUuU/u4POn+55spiVOrS2bbLio8t4
 GQmdLjzTIKEciElurTzlfYLB0EYOUhh6usFIYrb/qrp0edgt5jlZaYqn7Q8JZvlz9oMP
 JjJ3qQBOUkCHpK830C+Ssb0fcHv456a4B3L9Mswy0iQ1MY3ocdJyqSvyGVExcjht+zWl
 xHk4c7N4ZooxAV8Cth3bo5JLPdKzfG0NnuDzT3ZVOOdnPvfgcEaNgPoFskymdgIpRdHv
 myXw==
X-Gm-Message-State: AFq9FYJ70GerjYtZLn10rZ5cYwjEpuY9P3gAGub3T4AUKQYADIfbNNYf
 OU+c4yNz9Yw33UPSZm3YXi/khSI12gTlb3jJTH/yEDkIoGjQBO1R1tvNKUO5v6U7zp+6b49J33r
 HX/UK
X-Gm-Gg: AYBFou2JH3TZLqsCreEIlKVhq1T7yZOMreXAqEH9prk2Mp9hc1yjQ1u9xFhdMIuZW39
 4mbDkykPcYyhA93mgI3tH0MEuvzu5tsq6/n66ySXmGr6H3sCuvLMSI7S/X16XkNljgKx0L2fTaO
 ch7h1B9Sv3OsqCg9UCxgfx1GS7epHAsqFeFqM1KoE7dndnR581+O5tRnv5bYM1+SuHIE9HjCnTF
 c4+xdR0fQQNVjat94BsJbAGFc4hoo1o0p63nShzFBv0J/O7tc1UsUlp/8+rEinD9QcZvQ/1l1BG
 h/P6Tl4JM2wEcSmVtqrrol8KHZZ8klKmcVVyWCqDNlwxce76zAGGcpiaBAOeYHzJzRIK38kN40m
 feE9CBaH8iqm1UfhbLxyimyZxYDpRnv1oBPy888K8WIGN/rQe350pahh1hVhAe46YlHMXSxHRQA
 6BWZZR6F795pnwRxkHK9On0p/JKX0RyXRBrZ/vm5UO2JFPQvyyk1PKP80kmzbt/AQBHqlguNVN5
 dBGS9JtdkX5IOYwV/YLdlAGap+1Zl6rRqPBSQDlAkL2Lu9znRj7VVkarwRjI3sE/0+GpLpEIIsL
 Mqn/kjcglKPwyTEyYvvFtXtkUo9JOzJhx/f0tu1u
X-Received: by 2002:a05:6000:4007:b0:48e:6812:5ef1 with SMTP id
 ffacd0b85a97d-48e6e4f55f9mr2391871f8f.25.1793322394903; 
 Thu, 29 Oct 2026 18:06:34 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v4 09/12] block/block-copy: merge the two backup scan steps
 into block_copy_prescan()
Date: Fri, 30 Oct 2026 02:06:09 +0100
Message-ID: <20261030010613.1612771-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

block_copy_reset_unallocated() and block_copy_calculate_zero_bitmap()
are both one step of the same scan and differ only in what they do with
the answer. Fold them into block_copy_prescan(), which drops unallocated
clusters from copy_bitmap while skip_unallocated is set, so
backup_scan_source() loses its per-mode branch.

sync=top now walks the dirty areas the way full and bitmap do, so it no
longer queries what copy-before-write has already copied during the
scan. A failed query still fails sync=top, as nothing else can tell
which clusters to skip, and still leaves the area to be copied as data
otherwise.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             |  7 +----
 block/block-copy.c         | 63 ++++++++++++++------------------------
 include/block/block-copy.h |  9 ++----
 3 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 38b0838d69..60c00fca67 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -271,12 +271,7 @@ static int coroutine_fn backup_scan_source(BackupBlockJob *s)
 
         /* rdlock protects the block-status queries below */
         bdrv_graph_co_rdlock();
-        if (top) {
-            ret = block_copy_reset_unallocated(s->bcs, offset, &count);
-        } else {
-            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
-                                             &count);
-        }
+        ret = block_copy_prescan(s->bcs, offset, &cached_end, &count);
         bdrv_graph_co_rdunlock();
 
         if (ret < 0) {
diff --git a/block/block-copy.c b/block/block-copy.c
index ad358f4d2f..78cc855b5b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -153,8 +153,8 @@ typedef struct BlockCopyState {
      * This is indicated by skip_unallocated.
      *
      * In this case, block_copy() will query the source’s allocation status,
-     * skip unallocated regions, clear them in the copy_bitmap, and invoke
-     * block_copy_reset_unallocated() every time it does.
+     * skip unallocated regions and clear them in the copy_bitmap, as
+     * block_copy_prescan() does.
      */
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
@@ -781,40 +781,17 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes)
 }
 
 /*
- * Reset bits in copy_bitmap starting at offset if they represent unallocated
- * data in the image. May reset subsequent contiguous bits.
- * @return 0 when the cluster at @offset was unallocated,
- *         1 otherwise, and -ret on error.
- */
-int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
-                                                  int64_t offset,
-                                                  int64_t *count)
-{
-    int ret;
-    int64_t clusters, bytes;
-
-    ret = block_copy_scan_status(s, offset, &clusters);
-    if (ret < 0) {
-        return ret;
-    }
-
-    bytes = clusters * s->cluster_size;
-
-    if (!ret) {
-        block_copy_reset(s, offset, bytes);
-    }
-
-    *count = bytes;
-    return ret;
-}
-
-/*
- * One scan step, like block_copy_reset_unallocated(); @cached_end
- * tracks progress across calls, @count how far @offset should move.
+ * One step of the scan run before copying: query the next dirty area, fill
+ * zero_bitmap and, while skip_unallocated is set, drop the clusters which
+ * are not allocated above the backing from copy_bitmap. @cached_end tracks
+ * progress across calls, @count how far @offset should move.
+ *
+ * A failed query only leaves the area unmarked, so it copies as data, but
+ * sync=top cannot tell what to skip and fails instead.
  */
-void coroutine_fn GRAPH_RDLOCK
-block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
-                                 int64_t *cached_end, int64_t *count)
+int coroutine_fn GRAPH_RDLOCK
+block_copy_prescan(BlockCopyState *s, int64_t offset, int64_t *cached_end,
+                   int64_t *count)
 {
     int64_t max_bytes = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
                                         s->cluster_size);
@@ -830,7 +807,7 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
 
     if (!found) {
         *count = s->len - offset;
-        return;
+        return 0;
     }
     dirty_end = dirty_offset + dirty_bytes;
 
@@ -839,15 +816,21 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
         int64_t query_offset = MAX(dirty_offset, *cached_end);
         int ret = block_copy_scan_status(s, query_offset, &clusters);
 
-        if (ret >= 0) {
-            *cached_end = query_offset + clusters * s->cluster_size;
-        } else {
-            /* Best-effort: leave this area unmarked; it copies as data. */
+        if (ret < 0) {
+            if (qatomic_read(&s->skip_unallocated)) {
+                return ret;
+            }
             *cached_end = dirty_end;
+        } else {
+            *cached_end = query_offset + clusters * s->cluster_size;
+            if (!ret && qatomic_read(&s->skip_unallocated)) {
+                block_copy_reset(s, query_offset, clusters * s->cluster_size);
+            }
         }
     }
 
     *count = MIN(*cached_end, dirty_end) - offset;
+    return 0;
 }
 
 /*
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 3a61066b55..dc51316fcf 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -41,12 +41,9 @@ void block_copy_state_free(BlockCopyState *s);
 
 void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);
 
-int64_t coroutine_fn GRAPH_RDLOCK
-block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);
-
-void coroutine_fn GRAPH_RDLOCK
-block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
-                                 int64_t *cached_end, int64_t *count);
+int coroutine_fn GRAPH_RDLOCK
+block_copy_prescan(BlockCopyState *s, int64_t offset, int64_t *cached_end,
+                   int64_t *count);
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool ignore_ratelimit, uint64_t timeout_ns,
-- 
2.53.0


