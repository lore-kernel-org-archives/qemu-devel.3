Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E303C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexS-0008JL-9P; Sun, 16 Aug 2026 13:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexR-0008Ik-03
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexO-0003B2-Nc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:40 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so2666332a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902457; x=1787507257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvPuN1mOPbUcNrld4JT1HPanpWXvws6ECl5ytXOEZTE=;
 b=QRJ/JTJHFB9c2iL91xoI7ARWiye4OX3G5pjgnA2sC8N1V41XC7NKXuM744DUF92hEQ
 /hM31Pv4OeszBfxC4HIJ7hn2OWxX0RcFzcG0aHuhofHdH+24BsGnNrDeuT7BBGHhte81
 Wj5g3yehMQsCCF96Z14PC2/ColKqdTgtjKeysyy62o73NEq8L6tQHvK9Kcq/s2dipToc
 3B2SzOnSeHsf++px6SeXpe3/PF64Gbrod5PewMHCbspoY7BKTwdhnxIzpLvWKHo+EVXw
 R4OiwR0LQdakmjP2vPrxy65CiIo/HfHsPFVglujpkqEb+vqo4PLF9RzynMkAQo2klcoD
 AYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902457; x=1787507257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kvPuN1mOPbUcNrld4JT1HPanpWXvws6ECl5ytXOEZTE=;
 b=BvD1FLin7n/Knbns2EiQrd7+Rq6VFCOnptUEKYzH83Ky/OWJIWie9ZriXOKPepUer1
 hxiQz/tkmXVPJdyz7g6dKB7wkfw2g/WegaMxK85EUe0KTWSTBo60vTWjJGHT1BCTqy6y
 sQuYiBK4AfmbVEJKY9rQrIvcz/tGv2J0cW1d7D+hIMR01tN6TMZfr0OalN8Kq14Mj6Wo
 Gtc1qCssRgLmI2FfTnO510WDYMCjPwwZA2MbdQJ02exmNmFJuJeP4jL7OvL7NsqeP5F0
 oHI1N0I5yCVQ163BhagqLsE9FOyW63zxKC4DHRnG1kxDhmbJQBoWY+VKPvAQz+L+j4jY
 QXdg==
X-Gm-Message-State: AOJu0Yy/+bfr8y2S7E5A+tffAn9mSgYIn1bZ17tkGWawxY/T65LkaBR2
 pNrd7Va+VLBOS1tU5xp/OErZyLUez/UmMTLEWagR8hhrIGYtJZJZgw/2cmWE3A==
X-Gm-Gg: AR+sD11k8mLXYyYcti76Qh/fuXFQ+XTJkN0p3qk852JygkiUIwe1bkX740phNWLChZm
 K4YGkwQAnfKB8SjlpTTFFnBXJ281gxTdrnqtUFy9fX2UQeZQ2iFKzYbIqSKIdLPriry35RZrNZv
 wnnUSb8iYlUYR0wP0LuFomLBA15nkG7QZLGFGLuUb2FpvKiJsiwOKg0HRtnYsbWdKUpVCgJxNZn
 shxi/EgzGqI+dd17a3+ewBvhRZHek90dT1qmJRaxKIuyfwe0UenTAQjNKtqtjr3lfM+DSRbpDbx
 hO7UHTYHH57Cn5jjx/YohOk9Goy8NxZ8EpC3hxOG3mp5sAEuEpj3yoIT8jNjg+274l9b9NkiljR
 yUTL7zHhxDSx6Ag9evmJlzV82o2oCF0oAEtD4K24YjoKenXE4cBbMzP5XiO3YN7mj18y/nzKQJ/
 MwJ0CVqVoWTMO+rTs8oWH+5PgV6A45D3v7uwcXlbTBTcG2SfcsiMuI/AY6H5a8ojelqMUdLqRXr
 xnyC1FExrKsJ3w=
X-Received: by 2002:a17:90b:1f88:b0:392:c868:35af with SMTP id
 98e67ed59e1d1-3933bd46d96mr22065072a91.20.1786902457363; 
 Sun, 16 Aug 2026 10:47:37 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:36 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 08/11] migration: add eager load thread and setup for fast
 snapshot load
Date: Sun, 16 Aug 2026 23:16:28 +0530
Message-ID: <20260816174631.1547811-9-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1033.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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
index 7ff864da25..1f37dc1399 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2404,9 +2404,78 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
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
+    MigrationStatus next_state;
+
+    trace_postcopy_ram_eager_load_thread_entry();
+    rcu_register_thread();
+    qemu_event_set(&mis->thread_sync_event);
+
+    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
+        next_state = MIGRATION_STATUS_FAILED;
+    } else {
+        next_state = MIGRATION_STATUS_COMPLETED;
+    }
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      next_state);
+
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


