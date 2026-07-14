Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64EC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwo-0006KE-VE; Tue, 14 Jul 2026 10:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwm-0006Ir-HZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:20 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwi-0002dQ-KD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so627520a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038635; x=1784643435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hXOeLEBDDuTdVXIHXQYAUgjtSxRd3WpCR6xjiEdoF0=;
 b=CdaQHvZr9AIhpPwDvDlBnbvVrJG35PoygDmsWPJuc01rDCk89axNBhigFHp0gpEAuc
 1ybiSgUIToLxzUNgenMo/RjurrvXGzvbfzkArvwZpVxVS6eH5XcglrZR4gIO44+5mByx
 sytXfw1y9MgU5PdfRGx2OvBaJXenpcCazwQWPmFwsqdJJ04TY1E4WVeNNSORWRl6reAP
 oyKubwx+oUyD2bpKqUwRHX/2VQqtG90Jvgc9wx903EubzzuTEblD0kVL24jL9DMAkRDQ
 DsFy9fr2TsINZPTG7Xg7bGgDn5oVucbO28rYfvi1hMzH2AqtqYYyi+J1clSPlRFlJAge
 /7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038635; x=1784643435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hXOeLEBDDuTdVXIHXQYAUgjtSxRd3WpCR6xjiEdoF0=;
 b=laXlHLhD/qP5d2QTvsDaVafdtYcbSy5pqlxLuppJz6AA3FuntbpzUawrhZxf9qlQ21
 plJvJiEz1kWvy8ug3eAgNtuQ8ShuEtnVil9ahN7zpK6rSnyW549SsW0pMNFaPjmEUrWa
 3vZwCeDZKIZfjnTxUBiq1Mg5ad+vuO1eqDyHapaMGA8PpD1KlTySct4WNoeA/1NvEyLR
 iuK7rtbF0EbD0KcTU6GLGm0ION0/yI0dr9jvgEWXl2cZQ+HoSNpzyEL1zJH20t7xr4wN
 IjwTaDwEKkuq+5WLRY/zzq0meH+ENMItnTcxUbmKtfZgok5dfFH95rqne8vgSj/XpeIV
 D/7w==
X-Gm-Message-State: AOJu0YwuNV/BN2Lr60gR6Ua+sU9R4LlgD//7QVmkB9PSZdudnNktpscj
 YWogbz2PylfjHpQJL/fZNOTLMea5iDyrm0gDkZdJoCZpUehOUDW+aTyLcPlyiLTv
X-Gm-Gg: AfdE7cm3Z93yrwIzf5RykPqmq6sdE5ZRTIihxcRoMEgBsl4ahDiURmRVfUQkEB1KKx3
 1XHWHuT7oUI9FTHGnzMweymovquLO2UhqrdOaQs8AsvJ1dAYjC2yGM2x4kMaMOCOZXCztIHykUE
 snhZzNa9EPdr9jTjwl73y+bpd3I9v9pYdZg5YsFvkJ0tUMa///egz4jAnAUlOJUM341Ot5oMVDF
 UCDncXT6dArDJPD4bLyycHMy8ogWUi26BAWc4labBBs0HIMOqkBu0IOchtZMqcCPVbtDiORj6Ch
 LM3mGNf2MOB9EIqjXkAlY8ZgZCDiOBJAdG/Lq3TAYFTwIU3kYjuQcHYhAm1b15ZKUIQ19v0mdaw
 1BwseDW5xd/k3Bst3Js074/Qryie5ypiAjRgk7GuwjOvRL8s9n4oU6sZI5xUNJWrLmN/6/1lfr/
 Iyit22cle7Z2Qgh5tiNtkmWK2R3hUuWFG90I9K6SFJ+A==
X-Received: by 2002:a05:6a21:3981:b0:3bf:6c08:2b34 with SMTP id
 adf61e73a8af0-3c110bb713dmr13525075637.60.1784038635060; 
 Tue, 14 Jul 2026 07:17:15 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:14 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 08/11] migration: add eager load thread and setup for fast
 snapshot load
Date: Tue, 14 Jul 2026 19:45:44 +0530
Message-ID: <20260714141547.1268000-9-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

In fast snapshot load a thread is needed for actively loading in pages
along with the fault path so that the guest is not dependent on fault
thread indefinitely. Considering the difference from usual network
postcopy where major chunk of RAM is already loaded here entire RAM
needs to be loaded later. Existance of background pages which are not
really accessed by the guest might never be loaded and system will be
locked in migration for indefinite time. As there should be no
assumption about how guest accesses memory, the load times can be
indefinite.

Add postcopy_ram_eager_load_thread(), for the eager thread which
iterates over all non ignored blocks calling ram_block_load_eager()
on each. ram_block_load_eager then iterates to load in all pages using
postcopy_mapped_ram_load_page(), with a different channel, which takes
care of not loading in pages already loaded by fault thread. On
completion the thread schedules postcopy_incoming_complete_bh() to
destroy the incoming migration state.

Add postcopy_ram_eager_load_setup() to create the thread. Added joining
logic in postcopy_incoming_cleanup().

Add tracepoints for entry and exit to eager load thread.

When both mapped-ram and postcopy-ram are set, divert from
qemu_loadvm_state to run fast snapshot load

Initialize postcopy RAM state and register RAM Blocks with userfaultfd
via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup() in
process_incoming_migration_co(). Fault thread needs to be launched
before VM to serve faults for some hardwares emulation that need to read
RAM (like vapic devices). Populate bitmaps and offset tables while
reading file in qemu_loadvm_state_main.

Add function qemu_loadvm_run_fast_snapshot_load() which starts the VM
using loadvm_postcopy_handle_run_bh() and launches eager load thread.

Skip scheduling process_incoming_migration_bh() in
process_incoming_migration_co(), for fast snapshot load as the state
cleanup is managed by eager load thread on completion.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c    | 36 +++++++++++++++++++--
 migration/migration.h    |  5 +++
 migration/postcopy-ram.c | 69 ++++++++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |  2 ++
 migration/savevm.c       | 16 ++++++++++
 migration/savevm.h       |  2 ++
 migration/trace-events   |  2 ++
 7 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 07394d8eea..e9c4eee6b9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -710,6 +710,11 @@ static void process_incoming_migration_bh(void *opaque)
     migration_incoming_state_destroy();
 }
 
+static bool migration_incoming_has_postcopy_thread(MigrationIncomingState *mis)
+{
+    return mis->have_listen_thread || mis->have_eager_load_thread;
+}
+
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
@@ -739,17 +744,44 @@ process_incoming_migration_co(void *opaque)
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * When loading snapshot with postcopy enabled, setup the postcopy
+     * infrastructure before loading the major part of device states.
+     * It's required because qemu_loadvm_state() may access guest memory
+     * while loading device states, which can cause page faults already.
+     */
+    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_POSTCOPY_DEVICE);
+
+        if (ram_postcopy_incoming_init(mis, &local_err)) {
+            goto fail;
+        }
+
+        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
+        if (postcopy_ram_incoming_setup(mis, &local_err)) {
+            goto fail;
+        }
+    }
+
     mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
+        qemu_loadvm_run_fast_snapshot_load(mis->from_src_file, mis);
+    }
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
     trace_process_incoming_migration_co_end(ret);
-    if (mis->have_listen_thread) {
+    if (migration_incoming_has_postcopy_thread(mis)) {
         /*
          * Postcopy was started, cleanup should happen at the end of the
-         * postcopy listen thread.
+         * postcopy listen thread or eager load thread.
          */
         trace_process_incoming_migration_co_postcopy_end_main();
         goto out;
diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..540124bc27 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,6 +42,7 @@
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
+#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapshot_load"
 
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
@@ -120,6 +121,10 @@ struct MigrationIncomingState {
     bool           have_listen_thread;
     QemuThread     listen_thread;
 
+    /* Thread to load pages eagerly in fast snapshot load case */
+    bool have_eager_load_thread;
+    QemuThread eager_load_thread;
+
     /* For the kernel to send us notifications */
     int       userfault_fd;
     /* To notify the fault_thread to wake, e.g., when need to quit */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 723070b5cd..37eb98b5b1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2342,9 +2342,78 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_listen_thread = false;
     }
 
+    if (mis->have_eager_load_thread) {
+        qemu_thread_join(&mis->eager_load_thread);
+        mis->have_eager_load_thread = false;
+    }
+
     if (migrate_postcopy_ram()) {
         rc = postcopy_ram_incoming_cleanup(mis);
     }
 
     return rc;
 }
+
+/*
+ * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
+ * pending pages of given ram block
+ */
+static int ram_block_load_eager(RAMBlock *rb, void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationState *s = migrate_get_current();
+    Error *errp = NULL;
+    void *host = qemu_ram_get_host_addr(rb);
+    void *target;
+
+    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
+         page_loc += qemu_ram_pagesize(rb)) {
+        target = (uint8_t *)host + page_loc;
+        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
+                                           RAM_CHANNEL_PRECOPY, &errp)) {
+            migrate_error_propagate(s, errp);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
+ * cleanup after entire RAM is loaded
+ */
+static void *postcopy_ram_eager_load_thread(void *opaque)
+{
+    MigrationIncomingState *mis = opaque;
+
+    trace_postcopy_ram_eager_load_thread_entry();
+    rcu_register_thread();
+    qemu_event_set(&mis->thread_sync_event);
+
+    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto out;
+    }
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_COMPLETED);
+
+out:
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
+
+    rcu_unregister_thread();
+    trace_postcopy_ram_eager_load_thread_exit();
+    return NULL;
+}
+
+/*
+ * Create thread for eager loading in fast snapshot load case
+ */
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    postcopy_thread_create(
+        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD,
+        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
+    mis->have_eager_load_thread = true;
+}
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ea879f0bc6..c58a60bc8a 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -205,4 +205,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
 int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
 int postcopy_incoming_cleanup(MigrationIncomingState *mis);
 
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 23adaf9dd9..08f614349b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2959,6 +2959,22 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
+/*
+ * Starts the VM and launches the eager thread for fast snapshot load
+ */
+void qemu_loadvm_run_fast_snapshot_load(QEMUFile *f,
+                                        MigrationIncomingState *mis)
+{
+    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+
+    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
+    postcopy_ram_eager_load_setup(mis);
+}
+
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4e..27c6becbc3 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
 int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
+void qemu_loadvm_run_fast_snapshot_load(QEMUFile *f,
+                                        MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
diff --git a/migration/trace-events b/migration/trace-events
index de99d976ab..38f11e1e9f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -314,6 +314,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
 postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
 postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
+postcopy_ram_eager_load_thread_entry(void) ""
+postcopy_ram_eager_load_thread_exit(void) ""
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.55.0


