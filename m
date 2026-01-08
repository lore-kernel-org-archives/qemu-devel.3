Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3E7D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdift-0004lp-Ly; Thu, 08 Jan 2026 00:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifi-0004c1-Ep
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:00 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdiff-0005yH-Bs
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso31473505ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850494; x=1768455294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35C8bc/rqZRoKoFkJ5PyHzq4PX9ela8+R4AsFKxQvAE=;
 b=dnebkfRMwYBrSpZf7A97R99Q9dGMUsgzsJIxbUtVJpfhbp93D/UfWtaJRapCb9BLyE
 cLJ6appLBeccn/Gkg8rH9aeBMFMwo4suLgebQJ4anOZ8DFxpQSmzCvTeDxPOA50oA0Og
 pYg+mHSMt5rnvd7UgJGzSWZ1yzdCSaFrdWHd07BzMD5hACq5XPP+/KrqDt8Z+L6KNpJg
 D5Pg61W5ccnlKfPFI/0KtoKgw+Q08oTqbCF1QEuMz4bKykh5LyF9wOVi299BaedI0z6E
 RYIs0aM4Br9/5oT2zvhxSGKjKPP1oOiMyecJcCDqGrXJ6EcquzWv9WWQLjtu2PCUJiCi
 pWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850494; x=1768455294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=35C8bc/rqZRoKoFkJ5PyHzq4PX9ela8+R4AsFKxQvAE=;
 b=env3huUIiKts47fg5+xm7x0PoVBzQgAErrJI5EEPunu8x2A9/rPDQfmDGgGiHJDcc8
 g+avFhZiQ6c9OH3J5gpOUE3IwUG7Ta+jMHqunKJ3YJXdHzBSyHLAlaStJYCozt3+MF/J
 sRkdLxekkibdDv2osJr9EcbNKIjgJLC3UAUhMYvVXBdFN9caOkRr7QmsvHrNoWcCEGlJ
 raLRWZQRZ48/8pxaLp5GEJgCPDLxvW5U1WubrM2ooIbZNG3wLF66yFbOHi/bI/Z9epWB
 +P0UhjgRwQH5TMzWBApUBr5yvqxFLRTzDP8IY+GveAJgg02mh66eRukfZkEVdnemuyTv
 YvZw==
X-Gm-Message-State: AOJu0Yxu/4Zz2lDODkXKujtqhTv7/CGVDthKunJdhEStF8OTHb0mh8kJ
 D2r+me1/lVaAIpaBb2wxwurzhfakkSxs9HK7wi6POkkL7iU0pOwFz5C2fW4I7mNhP7Q662LinAQ
 ukiZCKm8=
X-Gm-Gg: AY/fxX54qn1JwNwVcxmrt000grQVcvdnCoGVuaBj4uVJWj3Opg8S3aOFLpvteu2nOCn
 vdBp/uSsXAF6b1cT/VhouEY2/ipMJRMxCx6/BwBitJewufWdIVfgPoozioBleM736iS8qHHKEcs
 hmQ/RHPKhi/JhL2PWL1zmpvCmSi/2Yl51YYZPV6E9kv+119NLBIMTNSoPe8q/dHWLAvAZRqSj31
 hHGEUd5WDXGoZqTzg2v5uN+S2Irff+mQP53Dw4KQ6KLsks0HYPQEbnr0X/duF3WiJtqB82eeB8s
 V64OrCmi80yaQ/pgLrT7gxCf9Rlc+ZbGYxMHls+5LYYzc+KenlOR5eFm8bu4A6KymsCKP67Xf/X
 qLF2D+XGJNg5o/jxd/W/6xAc5ncs3XrstBM+4+Wb8Xd6DZBHxbUSolvGoGqeIOWZ82bwZ48Qk6J
 f3ejzaSdgDyA0jNitet50nKps4sxHz
X-Google-Smtp-Source: AGHT+IGM3kPQ284eDy4Ud/h9lyw0uyVQbefl8u9JPns2AUnUbdRBBEHpuvA594kY+NKHQdyx1mp01Q==
X-Received: by 2002:a17:903:11cc:b0:2a0:b62e:e012 with SMTP id
 d9443c01a7336-2a3ee491c36mr47144185ad.38.1767850493611; 
 Wed, 07 Jan 2026 21:34:53 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/50] migration: Drop use of Stat64
Date: Thu,  8 Jan 2026 16:30:13 +1100
Message-ID: <20260108053018.626690-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Stat64 structure is an aid for 32-bit hosts, and
is no longer required.  Use plain 64-bit types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/migration-stats.h   | 36 ++++++++++++++++-------------------
 migration/cpu-throttle.c      |  4 ++--
 migration/migration-stats.c   | 16 ++++++++--------
 migration/migration.c         | 24 +++++++++++------------
 migration/multifd-nocomp.c    |  2 +-
 migration/multifd-zero-page.c |  4 ++--
 migration/multifd.c           | 12 ++++--------
 migration/qemu-file.c         |  6 +++---
 migration/ram.c               | 30 ++++++++++++++---------------
 migration/rdma.c              |  8 ++++----
 10 files changed, 67 insertions(+), 75 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 05290ade76..c0f50144c9 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -13,8 +13,6 @@
 #ifndef QEMU_MIGRATION_STATS_H
 #define QEMU_MIGRATION_STATS_H
 
-#include "qemu/stats64.h"
-
 /*
  * Amount of time to allocate to each "chunk" of bandwidth-throttled
  * data.
@@ -29,9 +27,7 @@
 
 /*
  * These are the ram migration statistic counters.  It is loosely
- * based on MigrationStats.  We change to Stat64 any counter that
- * needs to be updated using atomic ops (can be accessed by more than
- * one thread).
+ * based on MigrationStats.
  */
 typedef struct {
     /*
@@ -41,66 +37,66 @@ typedef struct {
      * since last iteration, not counting what the guest has dirtied
      * since we synchronized bitmaps.
      */
-    Stat64 dirty_bytes_last_sync;
+    uint64_t dirty_bytes_last_sync;
     /*
      * Number of pages dirtied per second.
      */
-    Stat64 dirty_pages_rate;
+    uint64_t dirty_pages_rate;
     /*
      * Number of times we have synchronized guest bitmaps.
      */
-    Stat64 dirty_sync_count;
+    uint64_t dirty_sync_count;
     /*
      * Number of times zero copy failed to send any page using zero
      * copy.
      */
-    Stat64 dirty_sync_missed_zero_copy;
+    uint64_t dirty_sync_missed_zero_copy;
     /*
      * Number of bytes sent at migration completion stage while the
      * guest is stopped.
      */
-    Stat64 downtime_bytes;
+    uint64_t downtime_bytes;
     /*
      * Number of bytes sent through multifd channels.
      */
-    Stat64 multifd_bytes;
+    uint64_t multifd_bytes;
     /*
      * Number of pages transferred that were not full of zeros.
      */
-    Stat64 normal_pages;
+    uint64_t normal_pages;
     /*
      * Number of bytes sent during postcopy.
      */
-    Stat64 postcopy_bytes;
+    uint64_t postcopy_bytes;
     /*
      * Number of postcopy page faults that we have handled during
      * postcopy stage.
      */
-    Stat64 postcopy_requests;
+    uint64_t postcopy_requests;
     /*
      * Number of bytes sent during precopy stage.
      */
-    Stat64 precopy_bytes;
+    uint64_t precopy_bytes;
     /*
      * Number of bytes transferred with QEMUFile.
      */
-    Stat64 qemu_file_transferred;
+    uint64_t qemu_file_transferred;
     /*
      * Amount of transferred data at the start of current cycle.
      */
-    Stat64 rate_limit_start;
+    uint64_t rate_limit_start;
     /*
      * Maximum amount of data we can send in a cycle.
      */
-    Stat64 rate_limit_max;
+    uint64_t rate_limit_max;
     /*
      * Number of bytes sent through RDMA.
      */
-    Stat64 rdma_bytes;
+    uint64_t rdma_bytes;
     /*
      * Number of pages transferred that were full of zeros.
      */
-    Stat64 zero_pages;
+    uint64_t zero_pages;
 } MigrationAtomicStats;
 
 extern MigrationAtomicStats mig_stats;
diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 0642e6bdea..3b4d4aea52 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -134,7 +134,7 @@ int cpu_throttle_get_percentage(void)
 
 void cpu_throttle_dirty_sync_timer_tick(void *opaque)
 {
-    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+    uint64_t sync_cnt = qatomic_read(&mig_stats.dirty_sync_count);
 
     /*
      * The first iteration copies all memory anyhow and has no
@@ -153,7 +153,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
     }
 
 end:
-    throttle_dirty_sync_count_prev = stat64_get(&mig_stats.dirty_sync_count);
+    throttle_dirty_sync_count_prev = qatomic_read(&mig_stats.dirty_sync_count);
 
     timer_mod(throttle_dirty_sync_timer,
         qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index f690b98a03..3f17b6ac5c 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/stats64.h"
+#include "qemu/atomic.h"
 #include "qemu-file.h"
 #include "trace.h"
 #include "migration-stats.h"
@@ -29,7 +29,7 @@ bool migration_rate_exceeded(QEMUFile *f)
         return false;
     }
 
-    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
+    uint64_t rate_limit_start = qatomic_read(&mig_stats.rate_limit_start);
     uint64_t rate_limit_current = migration_transferred_bytes();
     uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
 
@@ -41,7 +41,7 @@ bool migration_rate_exceeded(QEMUFile *f)
 
 uint64_t migration_rate_get(void)
 {
-    return stat64_get(&mig_stats.rate_limit_max);
+    return qatomic_read(&mig_stats.rate_limit_max);
 }
 
 #define XFER_LIMIT_RATIO (1000 / BUFFER_DELAY)
@@ -51,19 +51,19 @@ void migration_rate_set(uint64_t limit)
     /*
      * 'limit' is per second.  But we check it each BUFFER_DELAY milliseconds.
      */
-    stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
+    qatomic_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
 }
 
 void migration_rate_reset(void)
 {
-    stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes());
+    qatomic_set(&mig_stats.rate_limit_start, migration_transferred_bytes());
 }
 
 uint64_t migration_transferred_bytes(void)
 {
-    uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
-    uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
-    uint64_t qemu_file = stat64_get(&mig_stats.qemu_file_transferred);
+    uint64_t multifd = qatomic_read(&mig_stats.multifd_bytes);
+    uint64_t rdma = qatomic_read(&mig_stats.rdma_bytes);
+    uint64_t qemu_file = qatomic_read(&mig_stats.qemu_file_transferred);
 
     trace_migration_transferred_bytes(qemu_file, multifd, rdma);
     return qemu_file + multifd + rdma;
diff --git a/migration/migration.c b/migration/migration.c
index 9d1bf5d276..7d216a0449 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1266,22 +1266,22 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram = g_malloc0(sizeof(*info->ram));
     info->ram->transferred = migration_transferred_bytes();
     info->ram->total = ram_bytes_total();
-    info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
-    info->ram->normal = stat64_get(&mig_stats.normal_pages);
+    info->ram->duplicate = qatomic_read(&mig_stats.zero_pages);
+    info->ram->normal = qatomic_read(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
-        stat64_get(&mig_stats.dirty_sync_count);
+        qatomic_read(&mig_stats.dirty_sync_count);
     info->ram->dirty_sync_missed_zero_copy =
-        stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
+        qatomic_read(&mig_stats.dirty_sync_missed_zero_copy);
     info->ram->postcopy_requests =
-        stat64_get(&mig_stats.postcopy_requests);
+        qatomic_read(&mig_stats.postcopy_requests);
     info->ram->page_size = page_size;
-    info->ram->multifd_bytes = stat64_get(&mig_stats.multifd_bytes);
+    info->ram->multifd_bytes = qatomic_read(&mig_stats.multifd_bytes);
     info->ram->pages_per_second = s->pages_per_second;
-    info->ram->precopy_bytes = stat64_get(&mig_stats.precopy_bytes);
-    info->ram->downtime_bytes = stat64_get(&mig_stats.downtime_bytes);
-    info->ram->postcopy_bytes = stat64_get(&mig_stats.postcopy_bytes);
+    info->ram->precopy_bytes = qatomic_read(&mig_stats.precopy_bytes);
+    info->ram->downtime_bytes = qatomic_read(&mig_stats.downtime_bytes);
+    info->ram->postcopy_bytes = qatomic_read(&mig_stats.postcopy_bytes);
 
     if (migrate_xbzrle()) {
         info->xbzrle_cache = g_malloc0(sizeof(*info->xbzrle_cache));
@@ -1302,7 +1302,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
         info->ram->dirty_pages_rate =
-           stat64_get(&mig_stats.dirty_pages_rate);
+           qatomic_read(&mig_stats.dirty_pages_rate);
     }
 
     if (migrate_dirty_limit() && dirtylimit_in_service()) {
@@ -3422,10 +3422,10 @@ static void migration_update_counters(MigrationState *s,
      * if we haven't sent anything, we don't want to
      * recalculate. 10000 is a small enough number for our purposes
      */
-    if (stat64_get(&mig_stats.dirty_pages_rate) &&
+    if (qatomic_read(&mig_stats.dirty_pages_rate) &&
         transferred > 10000) {
         s->expected_downtime =
-            stat64_get(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
+            qatomic_read(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
     }
 
     migration_rate_reset();
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index b48eae3d86..9be79b3b8e 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -141,7 +141,7 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
             return -1;
         }
 
-        stat64_add(&mig_stats.multifd_bytes, p->packet_len);
+        qatomic_add(&mig_stats.multifd_bytes, p->packet_len);
     }
 
     return 0;
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index 4cde868159..00c330416a 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -77,8 +77,8 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     pages->normal_num = i;
 
 out:
-    stat64_add(&mig_stats.normal_pages, pages->normal_num);
-    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+    qatomic_add(&mig_stats.normal_pages, pages->normal_num);
+    qatomic_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 }
 
 void multifd_recv_zero_page_process(MultiFDRecvParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index bf6da85af8..c9d4a67a46 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -58,10 +58,6 @@ struct {
      * operations on both 32bit / 64 bits hosts.  It means on 32bit systems
      * multifd will overflow the packet_num easier, but that should be
      * fine.
-     *
-     * Another option is to use QEMU's Stat64 then it'll be 64 bits on all
-     * hosts, however so far it does not support atomic fetch_add() yet.
-     * Make it easy for now.
      */
     uintptr_t packet_num;
     /*
@@ -174,7 +170,7 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
     if (ret != 0) {
         return -1;
     }
-    stat64_add(&mig_stats.multifd_bytes, size);
+    qatomic_add(&mig_stats.multifd_bytes, size);
     return 0;
 }
 
@@ -607,7 +603,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
         return -1;
     }
     if (ret == 1) {
-        stat64_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
+        qatomic_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
     }
 
     return ret;
@@ -735,7 +731,7 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes, total_size);
+            qatomic_add(&mig_stats.multifd_bytes, total_size);
 
             p->next_packet_size = 0;
             multifd_send_data_clear(p->data);
@@ -766,7 +762,7 @@ static void *multifd_send_thread(void *opaque)
                     break;
                 }
                 /* p->next_packet_size will always be zero for a SYNC packet */
-                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
+                qatomic_add(&mig_stats.multifd_bytes, p->packet_len);
             }
 
             qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 4b5a409a80..8d82d94416 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -295,7 +295,7 @@ int qemu_fflush(QEMUFile *f)
             qemu_file_set_error_obj(f, -EIO, local_error);
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
-            stat64_add(&mig_stats.qemu_file_transferred, size);
+            qatomic_add(&mig_stats.qemu_file_transferred, size);
         }
 
         qemu_iovec_release_ram(f);
@@ -552,7 +552,7 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
         return;
     }
 
-    stat64_add(&mig_stats.qemu_file_transferred, buflen);
+    qatomic_add(&mig_stats.qemu_file_transferred, buflen);
 }
 
 
@@ -785,7 +785,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
 
 uint64_t qemu_file_transferred(QEMUFile *f)
 {
-    uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
+    uint64_t ret = qatomic_read(&mig_stats.qemu_file_transferred);
     int i;
 
     g_assert(qemu_file_is_writable(f));
diff --git a/migration/ram.c b/migration/ram.c
index 04958c5603..fc7ece2c1a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -479,11 +479,11 @@ uint64_t ram_bytes_remaining(void)
 void ram_transferred_add(uint64_t bytes)
 {
     if (runstate_is_running()) {
-        stat64_add(&mig_stats.precopy_bytes, bytes);
+        qatomic_add(&mig_stats.precopy_bytes, bytes);
     } else if (migration_in_postcopy()) {
-        stat64_add(&mig_stats.postcopy_bytes, bytes);
+        qatomic_add(&mig_stats.postcopy_bytes, bytes);
     } else {
-        stat64_add(&mig_stats.downtime_bytes, bytes);
+        qatomic_add(&mig_stats.downtime_bytes, bytes);
     }
 }
 
@@ -605,7 +605,7 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
     cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
-                 stat64_get(&mig_stats.dirty_sync_count));
+                 qatomic_read(&mig_stats.dirty_sync_count));
 }
 
 #define ENCODING_FLAG_XBZRLE 0x1
@@ -631,7 +631,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
     int encoded_len = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
     QEMUFile *file = pss->pss_channel;
-    uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
+    uint64_t generation = qatomic_read(&mig_stats.dirty_sync_count);
 
     if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
         xbzrle_counters.cache_miss++;
@@ -1035,9 +1035,9 @@ uint64_t ram_pagesize_summary(void)
 
 uint64_t ram_get_total_transferred_pages(void)
 {
-    return stat64_get(&mig_stats.normal_pages) +
-        stat64_get(&mig_stats.zero_pages) +
-        xbzrle_counters.pages;
+    return (qatomic_read(&mig_stats.normal_pages) +
+            qatomic_read(&mig_stats.zero_pages) +
+            xbzrle_counters.pages);
 }
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
@@ -1045,7 +1045,7 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
 
     /* calculate period counters */
-    stat64_set(&mig_stats.dirty_pages_rate,
+    qatomic_set(&mig_stats.dirty_pages_rate,
                rs->num_dirty_pages_period * 1000 /
                (end_time - rs->time_last_bitmap_sync));
 
@@ -1136,7 +1136,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     RAMBlock *block;
     int64_t end_time;
 
-    stat64_add(&mig_stats.dirty_sync_count, 1);
+    qatomic_add(&mig_stats.dirty_sync_count, 1);
 
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -1150,7 +1150,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
             RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                 ramblock_sync_dirty_bitmap(rs, block);
             }
-            stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
+            qatomic_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
         }
     }
 
@@ -1173,7 +1173,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
         rs->bytes_xfer_prev = migration_transferred_bytes();
     }
     if (migrate_events()) {
-        uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
+        uint64_t generation = qatomic_read(&mig_stats.dirty_sync_count);
         qapi_event_send_migration_pass(generation);
     }
 }
@@ -1232,7 +1232,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
         return 0;
     }
 
-    stat64_add(&mig_stats.zero_pages, 1);
+    qatomic_add(&mig_stats.zero_pages, 1);
 
     if (migrate_mapped_ram()) {
         /* zero pages are not transferred with mapped-ram */
@@ -1291,7 +1291,7 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
         }
     }
     ram_transferred_add(TARGET_PAGE_SIZE);
-    stat64_add(&mig_stats.normal_pages, 1);
+    qatomic_add(&mig_stats.normal_pages, 1);
     return 1;
 }
 
@@ -1943,7 +1943,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
 
-    stat64_add(&mig_stats.postcopy_requests, 1);
+    qatomic_add(&mig_stats.postcopy_requests, 1);
     RCU_READ_LOCK_GUARD();
 
     if (!rbname) {
diff --git a/migration/rdma.c b/migration/rdma.c
index 337b415889..e8a8e0fb45 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1936,8 +1936,8 @@ retry:
                  * would think that head.len would be the more similar
                  * thing to a correct value.
                  */
-                stat64_add(&mig_stats.zero_pages,
-                           sge.length / qemu_target_page_size());
+                qatomic_add(&mig_stats.zero_pages,
+                            sge.length / qemu_target_page_size());
                 return 1;
             }
 
@@ -2045,7 +2045,7 @@ retry:
     }
 
     set_bit(chunk, block->transit_bitmap);
-    stat64_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
+    qatomic_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
     /*
      * We are adding to transferred the amount of data written, but no
      * overhead at all.  I will assume that RDMA is magicaly and don't
@@ -2055,7 +2055,7 @@ retry:
      *     sizeof(send_wr) + sge.length
      * but this being RDMA, who knows.
      */
-    stat64_add(&mig_stats.rdma_bytes, sge.length);
+    qatomic_add(&mig_stats.rdma_bytes, sge.length);
     ram_transferred_add(sge.length);
     rdma->total_writes++;
 
-- 
2.43.0


