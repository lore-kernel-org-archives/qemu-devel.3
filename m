Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38A606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=qV8eyf6T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb55-0002Nt-3l; Thu, 29 Oct 2026 21:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4x-0002Ir-JQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4q-0006Gf-Jp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso74976f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322396; x=1793927196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oz8qaSH8q7QLfFH7Onpz/KPGPQOPaL0tV0IWAOGIqq0=;
 b=qV8eyf6Tl27P6BJmMS7XelrlKTpzj7A3AsbSjevtXXUXh26e2VpEMH7xrhY/ipGn1k
 MYH4D2t13wZPYiqjvFYqNBvfWmJoGqIu7KCFjJVmIkDwoOMD6h754sXt5vM27/WIYsBH
 OI3SOnBLb/5rHX9lFWlYNfHSU9klfRKeTNNpKGEc507GjNnqsPG36gMzZ58PPbi80yf+
 IlOYodsGRJD6mMm0yupG+Hbshu095PpcKEf9Ob4GYcLdIJQxUJ6eYrLEEptbDXucleS2
 0GNRyzJ3qd8Ae+rVMmFgdQZ/yaK8v+XWAVf98JANGyueJsFgHjmjsFBcZLd4lEnzW9kI
 BC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322396; x=1793927196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oz8qaSH8q7QLfFH7Onpz/KPGPQOPaL0tV0IWAOGIqq0=;
 b=o2QyhRUf8AC3PO3ZvQIFiNwS98r86Cy30jROac1tTcd5Hf7NZ3/vRwen6VBhK6AC0L
 rAg3LOY1xnoUrkxj9lGMxyh02CemjbRqNSB6NBX+czVZgf3ZxJ4bEW4oWk+anJoXc/9W
 eRplDiGBANFvO5+VaU+VT9KHBieOyIjsbW2P6r70fqn04lafTJsQlW5TLEA2pROixlF/
 fMaOdsJeEDIwuZ6rQJT8dJ2eLhpb1SXwaN8Sol/N/qbeErKfhIkQxmDzV8Q/Z/ISYa0/
 pQ8gUImlbCWByISXNN/RNXC7WE6lbis7hMp3lB85okXI7a7xR5XCD2lmuNehGjOmMdx8
 AitA==
X-Gm-Message-State: AFq9FYJB9VfFG22yDcZkcJEr1f+jMHY6dX7Z2XcgIcfy+ffnCL9o5GIr
 vwBjygy71sZnKOsYtOfyqqaeO6KC+wEC9XUi2N+EayeUipFbolh5udOcGiiVib+grtsKHfiPohn
 Ydbxb
X-Gm-Gg: AYBFou2u3UDO9HW+F747bJbY44fy3FhbBsNblJJEaCHlBYOAmtkiUKbQM3L6Zv/RC0A
 cSBM/MCBoxK1/ribFTzv29KXc0RoyLGrf17X51jNC4YwSoZCrKPfEuwEozsQnDp2IunAusKtMO7
 6bJqcHtgTuynDbJF8bGCU0oyOr/nFXt9GCbjzg+Mu3/3RvVfnhvuM8ltJGDU2asRUEs+pd4LR+F
 w0dbf3TUYcwfTlXaFfgzf2Z20ULSA6rHlvwkj3o5KJukDEkwDMR5ow5elZj62kjCmjvmPTBC0nF
 HESdcorSf1lQa19G9LuLYSy9Zcfkz5RTB9L7m6zlamjtkv/lPiSAFBAkixGtdx1uL/z08cQfg8V
 DjIMRQQ3v1GvW2ENQNFVk04mF+SzHMbYBlzN3LtIoRWOR65dSqF8gOZWVDtKRKdldrvIi8Sfmuh
 47WiMYTQ9TEVJWZ1ho/66FeGORScbiugfkzNppwXhcnYV2GAOv0cC/SYrlLbvsfKPgrMXxB7WUy
 8WvFbH7et/xCtLKTpCRsTzeeiL/RUkAnU6cmQNoNj8+stP1hqBEwK5nbw3uEGskEZbi9oblh7up
 as9g+5dSX41gMTcEaQ==
X-Received: by 2002:a05:6000:cb:b0:486:f42f:6860 with SMTP id
 ffacd0b85a97d-48e6e50361dmr1612813f8f.56.1793322396583; 
 Thu, 29 Oct 2026 18:06:36 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v4 10/12] block/block-copy: replace zero_bitmap_valid with
 scan_done
Date: Fri, 30 Oct 2026 02:06:10 +0100
Message-ID: <20261030010613.1612771-11-den@openvz.org>
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

zero_bitmap_valid says more than its name: a task created once it is
set skips its own block-status query, the sync=top skipping included,
because the scan has already settled what to copy. And the end of the
scan was announced twice, clearing skip_unallocated and then publishing
zero_bitmap_valid, with an ordering rule in a comment tying the two.

Rename the flag to scan_done, and let block_copy_set_scan_done() clear
skip_unallocated before publishing it, so backup_scan_source() makes one
call and the order is kept in one place. skip_unallocated is left to
mean that a sync=top scan is in progress. No behavior change.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             |  6 +-----
 block/block-copy.c         | 19 ++++++++++++-------
 include/block/block-copy.h |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 60c00fca67..1bf6cbedac 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -254,7 +254,6 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_scan_source(BackupBlockJob *s)
 {
     Job *job = &s->common.job;
-    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
     int64_t offset, cached_end = 0, count;
     int ret = 0;
 
@@ -279,10 +278,7 @@ static int coroutine_fn backup_scan_source(BackupBlockJob *s)
         }
     }
 
-    if (top) {
-        block_copy_set_skip_unallocated(s->bcs, false);
-    }
-    block_copy_set_zero_bitmap_valid(s->bcs);
+    block_copy_set_scan_done(s->bcs);
 
     return 0;
 }
diff --git a/block/block-copy.c b/block/block-copy.c
index 78cc855b5b..3b7e282e5b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -161,8 +161,12 @@ typedef struct BlockCopyState {
     BdrvDirtyBitmap *copy_bitmap;
     /* Clusters reading as zero; allocated on demand, frozen once valid. */
     HBitmap *zero_bitmap;
-    /* Published only after the scan, with skip_unallocated already false. */
-    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
+    /*
+     * Set when the scan is over: zero_bitmap is complete, and for sync=top
+     * copy_bitmap holds no unallocated clusters, so a task needs no
+     * block-status query of its own.
+     */
+    bool scan_done; /* atomic, store-release/load-acquire */
     ProgressMeter *progress;
     SharedResource *mem;
     RateLimit rate_limit;
@@ -214,7 +218,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
      * The scan already knows how this range reads: pick the method here and
      * stop the task where the answer changes.
      */
-    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+    if (qatomic_load_acquire(&s->scan_done)) {
         int64_t boundary;
 
         if (hbitmap_get(s->zero_bitmap, offset)) {
@@ -687,7 +691,7 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
     return ret;
 }
 
-/* Only the scan allocates, and it runs before zero_bitmap_valid. */
+/* Only the scan allocates, and it runs before scan_done. */
 static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
 {
     if (!s->zero_bitmap) {
@@ -845,7 +849,7 @@ block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
     int64_t status_bytes;
 
     /* block_copy_task_create() already decided, from zero_bitmap. */
-    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+    if (qatomic_load_acquire(&s->scan_done)) {
         return true;
     }
 
@@ -1179,10 +1183,11 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
     qatomic_set(&s->skip_unallocated, skip);
 }
 
-void block_copy_set_zero_bitmap_valid(BlockCopyState *s)
+void block_copy_set_scan_done(BlockCopyState *s)
 {
     block_copy_zero_bitmap(s);
-    qatomic_store_release(&s->zero_bitmap_valid, true);
+    qatomic_set(&s->skip_unallocated, false);
+    qatomic_store_release(&s->scan_done, true);
 }
 
 void block_copy_set_speed(BlockCopyState *s, uint64_t speed)
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index dc51316fcf..e82c96586e 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -102,6 +102,6 @@ void block_copy_call_cancel(BlockCopyCallState *call_state);
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 int64_t block_copy_cluster_size(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
-void block_copy_set_zero_bitmap_valid(BlockCopyState *s);
+void block_copy_set_scan_done(BlockCopyState *s);
 
 #endif /* BLOCK_COPY_H */
-- 
2.53.0


