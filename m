Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B58DD2F7F2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KEF-0001iG-QC; Thu, 17 Oct 2024 02:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KED-0001hh-ST
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:21 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KEC-0005IQ-2d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:21 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so417096a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147398; x=1729752198;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkuUteniMACK6TVPruWS74ndE9dexfSbMnrEVOVSYNY=;
 b=26GoC+EOMnV3KCSGqLEOLfSJEJ5jm0FjVmVX0i2ONh1nQ+l2f7mP1Gv3f3BmgVwzYM
 +nYx0IiR9s5t3RTLlU62zC9vrmo1VUtGmyL6PiDKznnRqYufu1hQm/QbckjfXGTCzEfB
 t1CtC3d3FlYRJ5Lmg8ydIrddu/nWx/HnTxwh6Lw1tIonaV/827BO31wc2C188GB/T9j/
 g68KwBsKd7/P6f7VY4ehDdw9fOsOTJcv8P0pd/Qh/5wv6j9Sk/3IVk/IRUGq1C0fAVGk
 Grqx34lJnuRGNpDLiT8hq5jfgE9GnQjsn5Z7ZMT2LhVtX/WZh33ppkEQsptGNEhm8iMT
 xEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147398; x=1729752198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkuUteniMACK6TVPruWS74ndE9dexfSbMnrEVOVSYNY=;
 b=XE3VPMT5JgS/4uq8U/DhJVwFZjJ7WoNVVwWdnB8FvApakxs4qKAJ4xuLwqwrw7meIM
 EiAmeKTqSg6aBLu3oKrD3jhAATIErwe2tAZH+ECLelQLyvU+VFRdFA6i1EXNmLya+TbN
 nJ30uoTQ5eyEyopSnMCOBrFnfIsFuPu6mMx9WipiLnc0izv5de3XLIMW7b8QQkpHJh0Q
 GfwmGU9pjUGWUfPWJUJa6py1RwX+ioCBw5SQIBcet45pIXtDdS9dF/EO7fW2ksjmKMjh
 9up9GHaUj3N0mtgbnxQ/SKn52zVTMPUx3oyku6x1+r/gW+RF8YTaBqmPtDtxN6xp6osM
 xNcg==
X-Gm-Message-State: AOJu0YyT2xdEe6sxoeir4fbU5jE7jCDg97NIK3VLgkOXyM9uaIa4KDHM
 r5HMA/oAwuH0Y/2NkU7iv3Z3JrxRx8r0Jao0HQBqHGHF1DfZE/uF/e01mW10YVdTAhoEjSf8Gnt
 oiFUQMQ==
X-Google-Smtp-Source: AGHT+IGpjBhb0YHl1JDz/HyUUYop39j+CjmYDawSdpfuLNuqiZBUCjMSwamDkA0u51mn6rCTnCNtmw==
X-Received: by 2002:a05:6a20:438d:b0:1d6:2378:cffd with SMTP id
 adf61e73a8af0-1d8c93f5dbemr27552546637.0.1729147397880; 
 Wed, 16 Oct 2024 23:43:17 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:17 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 5/6] migration: Support periodic RAMBlock dirty bitmap sync
Date: Thu, 17 Oct 2024 14:42:54 +0800
Message-Id: <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

When VM is configured with huge memory, the current throttle logic
doesn't look like to scale, because migration_trigger_throttle()
is only called for each iteration, so it won't be invoked for a long
time if one iteration can take a long time.

The periodic dirty sync aims to fix the above issue by synchronizing
the ramblock from remote dirty bitmap and, when necessary, triggering
the CPU throttle multiple times during a long iteration.

This is a trade-off between synchronization overhead and CPU throttle
impact.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/cpu-throttle.c | 65 +++++++++++++++++++++++++++++++++++++++-
 migration/cpu-throttle.h | 14 +++++++++
 migration/migration.c    | 14 +++++++--
 migration/migration.h    |  1 +
 migration/ram.c          |  2 +-
 migration/trace-events   |  1 +
 6 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index fa47ee2e21..342681cdd4 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -28,16 +28,22 @@
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "cpu-throttle.h"
+#include "migration.h"
+#include "migration-stats.h"
 #include "trace.h"
 
 /* vcpu throttling controls */
-static QEMUTimer *throttle_timer;
+static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
 static unsigned int throttle_percentage;
+static bool throttle_dirty_sync_timer_active;
 
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* Making sure RAMBlock dirty bitmap is synchronized every five seconds */
+#define CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS 5000
+
 static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 {
     double pct;
@@ -112,6 +118,7 @@ void cpu_throttle_set(int new_throttle_pct)
 void cpu_throttle_stop(void)
 {
     qatomic_set(&throttle_percentage, 0);
+    cpu_throttle_dirty_sync_timer(false);
 }
 
 bool cpu_throttle_active(void)
@@ -124,8 +131,64 @@ int cpu_throttle_get_percentage(void)
     return qatomic_read(&throttle_percentage);
 }
 
+void cpu_throttle_dirty_sync_timer_tick(void *opaque)
+{
+    static uint64_t prev_sync_cnt;
+    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+
+    /*
+     * The first iteration copies all memory anyhow and has no
+     * effect on guest performance, therefore omit it to avoid
+     * paying extra for the sync penalty.
+     */
+    if (sync_cnt <= 1) {
+        goto end;
+    }
+
+    if (sync_cnt == prev_sync_cnt) {
+        trace_cpu_throttle_dirty_sync();
+        WITH_RCU_READ_LOCK_GUARD() {
+            migration_bitmap_sync_precopy(false);
+        }
+    }
+
+end:
+    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+
+    timer_mod(throttle_dirty_sync_timer,
+        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
+            CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
+}
+
+static bool cpu_throttle_dirty_sync_active(void)
+{
+    return qatomic_read(&throttle_dirty_sync_timer_active);
+}
+
+void cpu_throttle_dirty_sync_timer(bool enable)
+{
+    assert(throttle_dirty_sync_timer);
+
+    if (enable) {
+        if (!cpu_throttle_dirty_sync_active()) {
+            timer_mod(throttle_dirty_sync_timer,
+                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
+                    CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
+            qatomic_set(&throttle_dirty_sync_timer_active, 1);
+        }
+    } else {
+        if (cpu_throttle_dirty_sync_active()) {
+            timer_del(throttle_dirty_sync_timer);
+            qatomic_set(&throttle_dirty_sync_timer_active, 0);
+        }
+    }
+}
+
 void cpu_throttle_init(void)
 {
     throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
                                   cpu_throttle_timer_tick, NULL);
+    throttle_dirty_sync_timer =
+        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
+                     cpu_throttle_dirty_sync_timer_tick, NULL);
 }
diff --git a/migration/cpu-throttle.h b/migration/cpu-throttle.h
index d65bdef6d0..420702b8d3 100644
--- a/migration/cpu-throttle.h
+++ b/migration/cpu-throttle.h
@@ -65,4 +65,18 @@ bool cpu_throttle_active(void);
  */
 int cpu_throttle_get_percentage(void);
 
+/**
+ * cpu_throttle_dirty_sync_timer_tick:
+ *
+ * Dirty sync timer hook.
+ */
+void cpu_throttle_dirty_sync_timer_tick(void *opaque);
+
+/**
+ * cpu_throttle_dirty_sync_timer:
+ *
+ * Start or stop the dirty sync timer.
+ */
+void cpu_throttle_dirty_sync_timer(bool enable);
+
 #endif /* SYSEMU_CPU_THROTTLE_H */
diff --git a/migration/migration.c b/migration/migration.c
index 2e10ca77af..f673e30069 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3291,12 +3291,17 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
 static void migration_iteration_finish(MigrationState *s)
 {
-    /* If we enabled cpu throttling for auto-converge, turn it off. */
+    bql_lock();
+
+    /*
+     * If we enabled cpu throttling for auto-converge, turn it off.
+     * Stopping CPU throttle should be serialized by BQL to avoid
+     * racing for the throttle_dirty_sync_timer.
+     */
     if (migrate_auto_converge()) {
         cpu_throttle_stop();
     }
 
-    bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
         runstate_set(RUN_STATE_POSTMIGRATE);
@@ -3513,6 +3518,11 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_colo_enable(s->to_dst_file);
     }
 
+    if (migrate_auto_converge()) {
+        /* Start RAMBlock dirty bitmap sync timer */
+        cpu_throttle_dirty_sync_timer(true);
+    }
+
     bql_lock();
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d5..fbd0d19092 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -537,4 +537,5 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+void migration_bitmap_sync_precopy(bool last_stage);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 9b5b350405..d284f63854 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1088,7 +1088,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     }
 }
 
-static void migration_bitmap_sync_precopy(bool last_stage)
+void migration_bitmap_sync_precopy(bool last_stage)
 {
     Error *local_err = NULL;
     assert(ram_state);
diff --git a/migration/trace-events b/migration/trace-events
index 9a19599804..0638183056 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -381,3 +381,4 @@ migration_pagecache_insert(void) "Error allocating page"
 
 # cpu-throttle.c
 cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
+cpu_throttle_dirty_sync(void) ""
-- 
2.27.0


