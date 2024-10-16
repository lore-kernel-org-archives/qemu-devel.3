Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D13D20684
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yu9-0003aJ-2v; Wed, 16 Oct 2024 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu3-0003ZQ-JV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu1-0000hJ-Sk
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so4334225ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729065424; x=1729670224;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9gc6WR+7vJ9WeCpYan0Utue6qlnIehIAkut2ksaHrI=;
 b=MqFy4XAya8KRZGGi1s+aIulfDNqM/aZmhmvf6Jm760CjJsnKzp106lNsySJwi6vHVl
 RyxJ/d3AH0XTWJmlKHIsBcePp6prsFxZYhZZESS6SIUJahJxGVyaE5SXigFsRWdDgJik
 1xfGzw9x6LQSvjYRItH5qoZG+hzRjo2349YZ6+76YVJjpAk4Dznq49tGN1UswP6nxJxC
 HjaNOZ4tRh3C/IWPBN4nJON9OHLL1O7LNxfVYsjsWpyD21L9l50ND1XgEyF4/svRTOG/
 PW5LIws9Ye8z/yKcdQP7b/wRlP9aRJi11Ql8YynLwgB339vnjt8J9gu0BhE52xcLhGg7
 CPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065424; x=1729670224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9gc6WR+7vJ9WeCpYan0Utue6qlnIehIAkut2ksaHrI=;
 b=FfW3PVgFSmzjZ8OaA3lqyabAq8n73ocJefVXJtokbLNq94GWPT9bSpKRd1H1LE1OA7
 Gd9iBtn0CbWMF0CHnTc5KvqwRetu4laC+fADrFJKOd3tdlROAgH6hu32JD0oCxjB45Kf
 ZrEF2Rk8+UejSoaf0OE7ZF3tqEFOsax+L8wHz19JgC1pR216nu1FAC/ZpfL6m3X80veU
 ZnLRPwiymj7uDG0osiamW0aa8ckUbUveAeCahlwIMhAAnZc7/m4ngWF4w4X9Kv+B6Gis
 tk9v3njp+vcofQS1AQcVeT87p7zOldKwF9jaoX0bxhNvNZRTvB1kCbP+Kv5TzO3hf0AQ
 RdPA==
X-Gm-Message-State: AOJu0Ywzzgvj28v4GJqt+kgyYj9yF8mXnmMWIWmxGFt/cbN0m4hGutPh
 5OkzyEtgfXYPovVpNdxAvIPixi6X6Ohg7a2vnYzfX7KLLlr5iZHHg8NDMBbcLd/p3L7mReYIALa
 1Gcq6Dw==
X-Google-Smtp-Source: AGHT+IFqq97Pzjox/ocrz8Jc/hVSVo7D5Fp55Houf3yxYVSoG16MoBaxXDO4IwAavTzUHTRU4UL5Lg==
X-Received: by 2002:a17:903:2582:b0:20c:5990:897c with SMTP id
 d9443c01a7336-20d2708c932mr44244295ad.27.1729065423675; 
 Wed, 16 Oct 2024 00:57:03 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dd1sm23608365ad.43.2024.10.16.00.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:57:03 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v3 3/4] migration: Support periodic ramblock dirty sync
Date: Wed, 16 Oct 2024 15:56:44 +0800
Message-Id: <f1067c9ddca005629e64d7e77c98686612bb1f82.1729064919.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729064919.git.yong.huang@smartx.com>
References: <cover.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
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
 migration/cpu-throttle.c | 70 +++++++++++++++++++++++++++++++++++++++-
 migration/cpu-throttle.h | 14 ++++++++
 migration/migration.h    |  1 +
 migration/ram.c          |  9 ++++--
 migration/trace-events   |  1 +
 5 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index fa47ee2e21..784b51ab35 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -28,16 +28,23 @@
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "cpu-throttle.h"
+#include "migration.h"
+#include "migration-stats.h"
+#include "options.h"
 #include "trace.h"
 
 /* vcpu throttling controls */
-static QEMUTimer *throttle_timer;
+static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
 static unsigned int throttle_percentage;
+static bool throttle_dirty_sync_timer_active;
 
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* RAMBlock dirty sync trigger every five seconds */
+#define CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS 5000
+
 static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 {
     double pct;
@@ -112,6 +119,7 @@ void cpu_throttle_set(int new_throttle_pct)
 void cpu_throttle_stop(void)
 {
     qatomic_set(&throttle_percentage, 0);
+    cpu_throttle_dirty_sync_timer(false);
 }
 
 bool cpu_throttle_active(void)
@@ -124,8 +132,68 @@ int cpu_throttle_get_percentage(void)
     return qatomic_read(&throttle_percentage);
 }
 
+void cpu_throttle_dirty_sync_timer_tick(void *opaque)
+{
+    static uint64_t prev_sync_cnt = 2;
+    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+
+    if (!migrate_auto_converge()) {
+        /* Stop the timer when auto converge is disabled */
+        return;
+    }
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
+    if (enable) {
+        assert(throttle_dirty_sync_timer);
+        if (!cpu_throttle_dirty_sync_active()) {
+            timer_mod(throttle_dirty_sync_timer,
+                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
+                    CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
+            qatomic_set(&throttle_dirty_sync_timer_active, 1);
+        }
+    } else {
+        if (throttle_dirty_sync_timer != NULL) {
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
index 9b5b350405..ac34e731e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1020,6 +1020,11 @@ static void migration_trigger_throttle(RAMState *rs)
         migration_transferred_bytes() - rs->bytes_xfer_prev;
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
+    bool auto_converge = migrate_auto_converge();
+
+    if (auto_converge) {
+        cpu_throttle_dirty_sync_timer(true);
+    }
 
     /*
      * The following detection logic can be refined later. For now:
@@ -1031,7 +1036,7 @@ static void migration_trigger_throttle(RAMState *rs)
     if ((bytes_dirty_period > bytes_dirty_threshold) &&
         (++rs->dirty_rate_high_cnt >= 2)) {
         rs->dirty_rate_high_cnt = 0;
-        if (migrate_auto_converge()) {
+        if (auto_converge) {
             trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
@@ -1088,7 +1093,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
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


