Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C45C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxg-0001Fj-VJ; Sun, 18 Jan 2026 17:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxe-0000xP-H5
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxc-0001fN-Ah
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f30233d8aso24804855ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774166; x=1769378966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEULzlPw6xjPe+4/C4phqMCxelohiweTDlicKl24zKE=;
 b=oMmYJtl4XXBCd336iTN1WONmzwNDjdKGh0Y8PVW/Qzw1Txjqf2WUAJykMBKhCWMXbC
 IiUlx+9foOn0C9MglnMC1M2MvPwyQhkGxNywuabWXC3lAzSpWPA5ENvprOxZPVhQJDF9
 HKg1d0qCww76tleww144/tyayrqsArRX1TT5N0kEVBOk5WocTwfoWgHyBM/iZZVIHvk9
 1cFzDEqJxQaUFsybzmyN0nCxiA/2UG3gITxkWoVHcrS3AaaVWCQZ1uWpzz3XmY2JSSj9
 9/wXfoItv36gstOjmyBg44aq5Quex8xkIKfccMaK9LS1vGAM/t5dkVAKdB+9FN1Cxfch
 G99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774166; x=1769378966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEULzlPw6xjPe+4/C4phqMCxelohiweTDlicKl24zKE=;
 b=PEb/X4YdFeucv2Al/a+qX2VH2S/iOEgDmLFhXjg+DM0nnXUU3YlnLLJ+WFP/s6HoTB
 MivG2wjj9XlDaM7jMoU/dLG0PzYkC0bgYQqv4sABmQPaH02wY408Suvu7yQPX8q/RDab
 zDZ5wGP6rPuY00zJm7tOWetaeAEBEtoAKaiol1A7MXLWLn+tILQHvdFsPFvIF35a0VJD
 5TfhSKwwsquuzds5Ra/tqJClgs0BhK7YUSbbaRpk44EwvmjlLgtDe6q1TFM2vbbHAt0V
 h6RN/lJ8gkuwwouuwmisfOFkHe0rZD0hns4lTCHzDGBgp3tFZj8HUZMzliF4EcMuuTzP
 4Ttg==
X-Gm-Message-State: AOJu0YxQwLYVRwowGdV3ibh8XLxtev1MsnGd/b58jTdbZZHuoZUxeawz
 XuSWI14iQiiXzlU8BVtxsT/1QpsUbBVLv3gXFYQe4oQ1uD4ZRAXqNI4D8f5IY9RYMK4Wlq/6dH5
 yArHaFMDQcg==
X-Gm-Gg: AY/fxX6DD0LYctbYJN0xY5dnlUdOPYDJWynAp7d6RKLqBSh09OgRwoSsyp5U+/ca7aU
 4oaRxdVLZTpKK0S0RdaoyJfQFobUAKC+A656babQqDGdGsNR3pFFooW71id4/FlsEGLMLx+wAVQ
 i7OgaBWxrGe5NKKN66CAe9anwRnnCOBc6U258+zAUVn1izTfexzyNcVjyT5CSvbIucNO79ObvnG
 XWRIHiTvrQOEVeV7zNOszqcJLtaS3LqfbM5DLwg8AyvxsRNR0M+hOo24NLYJcw0oygwR8NScI3e
 oCoJ+q3YSjyOHwEPCIcxhSw4nXisa1iMoghdDVTe5A6ezTYjXV7+AJkAJkpZ/eAYb0BZsHiqLOc
 DP9+5qzp/3Xc+3QQ2yBttOHT3RtW8dWhN8C2SsO5XoGmSthu3cE3bMhkvvLewFw9c/3FzCPoAkd
 8q8mD2Gk6BSP0/WZ7b/g==
X-Received: by 2002:a17:902:d490:b0:29e:9e97:ca70 with SMTP id
 d9443c01a7336-2a7188beff1mr81503895ad.25.1768774166194; 
 Sun, 18 Jan 2026 14:09:26 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 52/54] include/qemu/atomic: Drop qatomic_{read,set}_[iu]64
Date: Mon, 19 Jan 2026 09:04:12 +1100
Message-ID: <20260118220414.8177-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Replace all uses with the normal qatomic_{read,set}.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h      | 22 ----------
 accel/qtest/qtest.c        |  4 +-
 accel/tcg/icount-common.c  | 25 ++++++-----
 system/dirtylimit.c        |  2 +-
 tests/unit/test-rcu-list.c | 17 ++++----
 util/atomic64.c            | 85 --------------------------------------
 util/cacheflush.c          |  2 -
 util/qsp.c                 |  8 ++--
 util/meson.build           |  3 --
 9 files changed, 27 insertions(+), 141 deletions(-)
 delete mode 100644 util/atomic64.c

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index c39dc99f2f..27d98014d4 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -247,26 +247,4 @@
 typedef int64_t aligned_int64_t __attribute__((aligned(8)));
 typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));
 
-#ifdef CONFIG_ATOMIC64
-/* Use __nocheck because sizeof(void *) might be < sizeof(u64) */
-#define qatomic_read_i64(P) \
-    _Generic(*(P), int64_t: qatomic_read__nocheck(P))
-#define qatomic_read_u64(P) \
-    _Generic(*(P), uint64_t: qatomic_read__nocheck(P))
-#define qatomic_set_i64(P, V) \
-    _Generic(*(P), int64_t: qatomic_set__nocheck(P, V))
-#define qatomic_set_u64(P, V) \
-    _Generic(*(P), uint64_t: qatomic_set__nocheck(P, V))
-
-static inline void qatomic64_init(void)
-{
-}
-#else /* !CONFIG_ATOMIC64 */
-int64_t  qatomic_read_i64(const int64_t *ptr);
-uint64_t qatomic_read_u64(const uint64_t *ptr);
-void qatomic_set_i64(int64_t *ptr, int64_t val);
-void qatomic_set_u64(uint64_t *ptr, uint64_t val);
-void qatomic64_init(void);
-#endif /* !CONFIG_ATOMIC64 */
-
 #endif /* QEMU_ATOMIC_H */
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 1d4337d698..bb1491d93b 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -31,12 +31,12 @@ static int64_t qtest_clock_counter;
 
 static int64_t qtest_get_virtual_clock(void)
 {
-    return qatomic_read_i64(&qtest_clock_counter);
+    return qatomic_read(&qtest_clock_counter);
 }
 
 static void qtest_set_virtual_clock(int64_t count)
 {
-    qatomic_set_i64(&qtest_clock_counter, count);
+    qatomic_set(&qtest_clock_counter, count);
 }
 
 static int qtest_init_accel(AccelState *as, MachineState *ms)
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index d6471174a3..b1b6c005fe 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -86,8 +86,8 @@ static void icount_update_locked(CPUState *cpu)
     int64_t executed = icount_get_executed(cpu);
     cpu->icount_budget -= executed;
 
-    qatomic_set_i64(&timers_state.qemu_icount,
-                    timers_state.qemu_icount + executed);
+    qatomic_set(&timers_state.qemu_icount,
+                timers_state.qemu_icount + executed);
 }
 
 /*
@@ -116,15 +116,14 @@ static int64_t icount_get_raw_locked(void)
         /* Take into account what has run */
         icount_update_locked(cpu);
     }
-    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
-    return qatomic_read_i64(&timers_state.qemu_icount);
+    /* The read is protected by the seqlock, but needs atomic to avoid UB */
+    return qatomic_read(&timers_state.qemu_icount);
 }
 
 static int64_t icount_get_locked(void)
 {
     int64_t icount = icount_get_raw_locked();
-    return qatomic_read_i64(&timers_state.qemu_icount_bias) +
-        icount_to_ns(icount);
+    return qatomic_read(&timers_state.qemu_icount_bias) + icount_to_ns(icount);
 }
 
 int64_t icount_get_raw(void)
@@ -201,9 +200,9 @@ static void icount_adjust(void)
                     timers_state.icount_time_shift + 1);
     }
     timers_state.last_delta = delta;
-    qatomic_set_i64(&timers_state.qemu_icount_bias,
-                    cur_icount - (timers_state.qemu_icount
-                                  << timers_state.icount_time_shift));
+    qatomic_set(&timers_state.qemu_icount_bias,
+                cur_icount - (timers_state.qemu_icount
+                              << timers_state.icount_time_shift));
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                          &timers_state.vm_clock_lock);
 }
@@ -269,8 +268,8 @@ static void icount_warp_rt(void)
             }
             warp_delta = MIN(warp_delta, delta);
         }
-        qatomic_set_i64(&timers_state.qemu_icount_bias,
-                        timers_state.qemu_icount_bias + warp_delta);
+        qatomic_set(&timers_state.qemu_icount_bias,
+                    timers_state.qemu_icount_bias + warp_delta);
     }
     timers_state.vm_clock_warp_start = -1;
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
@@ -361,8 +360,8 @@ void icount_start_warp_timer(void)
              */
             seqlock_write_lock(&timers_state.vm_clock_seqlock,
                                &timers_state.vm_clock_lock);
-            qatomic_set_i64(&timers_state.qemu_icount_bias,
-                            timers_state.qemu_icount_bias + deadline);
+            qatomic_set(&timers_state.qemu_icount_bias,
+                        timers_state.qemu_icount_bias + deadline);
             seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                                  &timers_state.vm_clock_lock);
             qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index a0c327533c..50fa67f3d6 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -123,7 +123,7 @@ static void *vcpu_dirty_rate_stat_thread(void *opaque)
 int64_t vcpu_dirty_rate_get(int cpu_index)
 {
     DirtyRateVcpu *rates = vcpu_dirty_rate_stat->stat.rates;
-    return qatomic_read_i64(&rates[cpu_index].dirty_rate);
+    return qatomic_read(&rates[cpu_index].dirty_rate);
 }
 
 void vcpu_dirty_rate_stat_start(void)
diff --git a/tests/unit/test-rcu-list.c b/tests/unit/test-rcu-list.c
index 8f0adb8b00..8dde3e61a8 100644
--- a/tests/unit/test-rcu-list.c
+++ b/tests/unit/test-rcu-list.c
@@ -105,7 +105,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
     struct list_element *el = container_of(prcu, struct list_element, rcu);
     g_free(el);
     /* Accessed only from call_rcu thread.  */
-    qatomic_set_i64(&n_reclaims, n_reclaims + 1);
+    qatomic_set(&n_reclaims, n_reclaims + 1);
 }
 
 #if TEST_LIST_TYPE == 1
@@ -247,7 +247,7 @@ static void *rcu_q_updater(void *arg)
     qemu_mutex_lock(&counts_mutex);
     n_nodes += n_nodes_local;
     n_updates += n_updates_local;
-    qatomic_set_i64(&n_nodes_removed, n_nodes_removed + n_removed_local);
+    qatomic_set(&n_nodes_removed, n_nodes_removed + n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     return NULL;
 }
@@ -301,23 +301,22 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
         n_removed_local++;
     }
     qemu_mutex_lock(&counts_mutex);
-    qatomic_set_i64(&n_nodes_removed, n_nodes_removed + n_removed_local);
+    qatomic_set(&n_nodes_removed, n_nodes_removed + n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     synchronize_rcu();
-    while (qatomic_read_i64(&n_nodes_removed) >
-           qatomic_read_i64(&n_reclaims)) {
+    while (qatomic_read(&n_nodes_removed) > qatomic_read(&n_reclaims)) {
         g_usleep(100);
         synchronize_rcu();
     }
     if (g_test_in_charge) {
-        g_assert_cmpint(qatomic_read_i64(&n_nodes_removed), ==,
-                        qatomic_read_i64(&n_reclaims));
+        g_assert_cmpint(qatomic_read(&n_nodes_removed), ==,
+                        qatomic_read(&n_reclaims));
     } else {
         printf("%s: %d readers; 1 updater; nodes read: "  \
                "%lld, nodes removed: %"PRIi64"; nodes reclaimed: %"PRIi64"\n",
                test, nthreadsrunning - 1, n_reads,
-               qatomic_read_i64(&n_nodes_removed),
-               qatomic_read_i64(&n_reclaims));
+               qatomic_read(&n_nodes_removed),
+               qatomic_read(&n_reclaims));
         exit(0);
     }
 }
diff --git a/util/atomic64.c b/util/atomic64.c
deleted file mode 100644
index c20d071d8e..0000000000
--- a/util/atomic64.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
- *
- * License: GNU GPL, version 2 or later.
- *   See the COPYING file in the top-level directory.
- */
-#include "qemu/osdep.h"
-#include "qemu/atomic.h"
-#include "qemu/thread.h"
-#include "qemu/cacheinfo.h"
-#include "qemu/memalign.h"
-
-#ifdef CONFIG_ATOMIC64
-#error This file must only be compiled if !CONFIG_ATOMIC64
-#endif
-
-/*
- * When !CONFIG_ATOMIC64, we serialize both reads and writes with spinlocks.
- * We use an array of spinlocks, with padding computed at run-time based on
- * the host's dcache line size.
- * We point to the array with a void * to simplify the padding's computation.
- * Each spinlock is located every lock_size bytes.
- */
-static void *lock_array;
-static size_t lock_size;
-
-/*
- * Systems without CONFIG_ATOMIC64 are unlikely to have many cores, so we use a
- * small array of locks.
- */
-#define NR_LOCKS 16
-
-static QemuSpin *addr_to_lock(const void *addr)
-{
-    uintptr_t a = (uintptr_t)addr;
-    uintptr_t idx;
-
-    idx = a >> qemu_dcache_linesize_log;
-    idx ^= (idx >> 8) ^ (idx >> 16);
-    idx &= NR_LOCKS - 1;
-    return lock_array + idx * lock_size;
-}
-
-#define GEN_READ(name, type)                    \
-    type name(const type *ptr)                  \
-    {                                           \
-        QemuSpin *lock = addr_to_lock(ptr);     \
-        type ret;                               \
-                                                \
-        qemu_spin_lock(lock);                   \
-        ret = *ptr;                             \
-        qemu_spin_unlock(lock);                 \
-        return ret;                             \
-    }
-
-GEN_READ(qatomic_read_i64, int64_t)
-GEN_READ(qatomic_read_u64, uint64_t)
-#undef GEN_READ
-
-#define GEN_SET(name, type)                     \
-    void name(type *ptr, type val)              \
-    {                                           \
-        QemuSpin *lock = addr_to_lock(ptr);     \
-                                                \
-        qemu_spin_lock(lock);                   \
-        *ptr = val;                             \
-        qemu_spin_unlock(lock);                 \
-    }
-
-GEN_SET(qatomic_set_i64, int64_t)
-GEN_SET(qatomic_set_u64, uint64_t)
-#undef GEN_SET
-
-void qatomic64_init(void)
-{
-    int i;
-
-    lock_size = ROUND_UP(sizeof(QemuSpin), qemu_dcache_linesize);
-    lock_array = qemu_memalign(qemu_dcache_linesize, lock_size * NR_LOCKS);
-    for (i = 0; i < NR_LOCKS; i++) {
-        QemuSpin *lock = lock_array + i * lock_size;
-
-        qemu_spin_init(lock);
-    }
-}
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 99221a409f..c043c5f881 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -216,8 +216,6 @@ static void __attribute__((constructor)) init_cache_info(void)
     qemu_icache_linesize_log = ctz32(isize);
     qemu_dcache_linesize = dsize;
     qemu_dcache_linesize_log = ctz32(dsize);
-
-    qatomic64_init();
 }
 
 
diff --git a/util/qsp.c b/util/qsp.c
index 6b783e2e7f..382e4397e2 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -346,9 +346,9 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
  */
 static inline void do_qsp_entry_record(QSPEntry *e, int64_t delta, bool acq)
 {
-    qatomic_set_u64(&e->ns, e->ns + delta);
+    qatomic_set(&e->ns, e->ns + delta);
     if (acq) {
-        qatomic_set_u64(&e->n_acqs, e->n_acqs + 1);
+        qatomic_set(&e->n_acqs, e->n_acqs + 1);
     }
 }
 
@@ -538,8 +538,8 @@ static void qsp_aggregate(void *p, uint32_t h, void *up)
      * The entry is in the global hash table; read from it atomically (as in
      * "read once").
      */
-    agg->ns += qatomic_read_u64(&e->ns);
-    agg->n_acqs += qatomic_read_u64(&e->n_acqs);
+    agg->ns += qatomic_read(&e->ns);
+    agg->n_acqs += qatomic_read(&e->n_acqs);
 }
 
 static void qsp_iter_diff(void *p, uint32_t hash, void *htp)
diff --git a/util/meson.build b/util/meson.build
index d7d6b213f6..59e835a8d3 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,8 +1,5 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
 util_ss.add(files('thread-context.c'), numa)
-if not config_host_data.get('CONFIG_ATOMIC64')
-  util_ss.add(files('atomic64.c'))
-endif
 if host_os != 'windows'
   util_ss.add(files('aio-posix.c'))
   util_ss.add(files('fdmon-poll.c'))
-- 
2.43.0


