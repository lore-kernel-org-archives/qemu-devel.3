Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71248D5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B54-0003aZ-Pc; Wed, 30 Oct 2024 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B53-0003aH-33
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B51-0007nA-6i
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLN0f4cofvuVt5w14C5bOhSxhfhHTWPcx/PY6JtfmaI=;
 b=LjRjPsxGWhxXRPyHcP1AXqQwHKqxb5p9Sr/lwUCBEjLA+TaHtEBP/8oajIZNwEn+X9MSpg
 gwAwBDePDWoytyWLebKRuopp3d1sfbfjYTv8PKj3bGZlU2Wjq/chE3Hawmm56pwR85cIAs
 /xfXogDi1Hhhy1xhyJQhRU09nJGH5w0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-so2wkUe_NHmAcLrDJ4D35w-1; Wed, 30 Oct 2024 11:57:52 -0400
X-MC-Unique: so2wkUe_NHmAcLrDJ4D35w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3e5f2dab4a8so6864935b6e.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303871; x=1730908671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLN0f4cofvuVt5w14C5bOhSxhfhHTWPcx/PY6JtfmaI=;
 b=fByQVMTkSF7bU27tb8QNgxhIMMgzcebCn+4Gia1wifGelct9xl7/g3pmDBShF+XKe4
 W47GNn3SqS83zIWd4VvM5E8wJVhGcUZZClXMpqZLmwIc9F4DBHl65IShRJjYtVgCAaic
 TLMZgogmNti6uTGY/bCcr9OdwZuevwiTC6VCCQGZPelfDXAuE8mzh0wtXdEMjvHyGgbZ
 aAWRM1O81Vg0oNfmVo9fHn0YvfG2URB6n5qWbIwebqnpe0WuMxtWOV+iPBRq+UUP5Nso
 Xb8FVh2ufHrg39wrOqxcJeSpO+wb7ELca7fua6GqTftytSuIAZ/ily4U8hmYxOLugvay
 ZPMg==
X-Gm-Message-State: AOJu0Yywkgc+xsoe+wa9HaZTEosVlFAlJtlpVFAT5SgZfuLCAG4hZW1s
 CD7XMg11YCpuurHt3VG9Q1DhDalG+X4n1ScaaCHyNsEpdMFLRmdXUSy+B8++jAxXda9us7/8TxB
 22sqzoQqQ0mVSil1Nzll2/erCqsLkwHjpWOkNUd0YLo+NrauArEsS+AWaB5ol17pXCIlz91OQr6
 CwrdYg0r4p26yZH7Das0gLAG52ogyRY3Webg==
X-Received: by 2002:a05:6808:13d2:b0:3e6:2ae7:a2a4 with SMTP id
 5614622812f47-3e6384ce490mr12940905b6e.44.1730303871007; 
 Wed, 30 Oct 2024 08:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk1OezfiDMmVDAxXFgPiS1aYvSubfil7QFlAu/XczRVBzR4qS+d9OqavvKcm+27frMuW/giA==
X-Received: by 2002:a05:6808:13d2:b0:3e6:2ae7:a2a4 with SMTP id
 5614622812f47-3e6384ce490mr12940877b6e.44.1730303870561; 
 Wed, 30 Oct 2024 08:57:50 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 08/18] migration: Support periodic RAMBlock dirty bitmap sync
Date: Wed, 30 Oct 2024 11:57:24 -0400
Message-ID: <20241030155734.2141398-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com
[peterx: make prev_cnt global, and reset for each migration]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpu-throttle.h | 14 ++++++++
 migration/migration.h    |  1 +
 migration/cpu-throttle.c | 70 +++++++++++++++++++++++++++++++++++++++-
 migration/migration.c    | 14 ++++++--
 migration/ram.c          |  2 +-
 migration/trace-events   |  1 +
 6 files changed, 98 insertions(+), 4 deletions(-)

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
index b9ce5aa4ff..7dc59c5e8d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -551,4 +551,5 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+void migration_bitmap_sync_precopy(bool last_stage);
 #endif
diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index fa47ee2e21..3df287d8d3 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -28,16 +28,23 @@
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
+static uint64_t throttle_dirty_sync_count_prev;
 
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* Making sure RAMBlock dirty bitmap is synchronized every five seconds */
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
+    if (sync_cnt == throttle_dirty_sync_count_prev) {
+        trace_cpu_throttle_dirty_sync();
+        WITH_RCU_READ_LOCK_GUARD() {
+            migration_bitmap_sync_precopy(false);
+        }
+    }
+
+end:
+    throttle_dirty_sync_count_prev = stat64_get(&mig_stats.dirty_sync_count);
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
+            /*
+             * Always reset the dirty sync count cache, in case migration
+             * was cancelled once.
+             */
+            throttle_dirty_sync_count_prev = 0;
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
diff --git a/migration/migration.c b/migration/migration.c
index 05c8cd50b4..bcb735869b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3297,12 +3297,17 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
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
@@ -3520,6 +3525,11 @@ static void *migration_thread(void *opaque)
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
2.45.0


