Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB6ECD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3Jg-0008AN-0r; Wed, 17 Jun 2026 23:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Je-0008A1-PS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Jb-0002IV-Gn
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:18 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c86307c4e6bso233405a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752873; x=1782357673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZAhkoUSVHRSAGY2Ipy3MCJxg2YtSmIGz0dtg14WcYo=;
 b=AESvt/kCF6ham3aZl6hwi3Gn9meL2ynKYN+7c8s8+cfmJhKqRgN50/3wrxw8axxFX2
 +y6at1rYIwyC5uMKkhi3cGWTCs5nI9LOxYv2ewh/Gx35OGIiWmz673MqX9oJrwLsZoSn
 Sw3gQ3Y4uOdJ1zEqWrHnLG9Seku535swsaiBkk6Eimruw2yPNptii0R420mp2u9eFw2H
 hunFJRBBza7rV02zBUbgivE4ufYZKaYrQpQlUs7JerRxfh4x061xV/srop491dohe3ve
 SgPFZd/0by3hkK/ugvD0VhNwGngNTTgByy5gEgGer4p0PCkXN0p3aywfndUOAxVzPAKv
 8kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752873; x=1782357673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZAhkoUSVHRSAGY2Ipy3MCJxg2YtSmIGz0dtg14WcYo=;
 b=EKymVdG02ZYJbyaBk593rcj+vmKtLd0lhc08yfaa9ImeA7jFpyhmMENH1DeXtQfmRy
 +pNI3MukhjOxkjebud9LNlQDtDJbBaSbMgx2ohK48/p3BwYkrOGLjbcZ3WccOSvzKkuY
 8ZKBElrEZUUZLHi8tSycwfhexU7G3ljwPg9yin0PrDBTcfleGBj6bKf/aFNwTLh1GuZA
 pVFC0hTIs+4a+mz3EB28UFWwMhBcjXifgHYYNgHRftCqTziRpjLzoKKr9aRAiGWeo7T+
 ehHHNPRpRmeIKZcEfjE5QyNK7LmiP9thRu9ZvKRNhSNO//RpZrfzDIaO8cw4ObSLNVsC
 IZzA==
X-Gm-Message-State: AOJu0YwCXJJq+KLwqTJGOtjpILfFhFiFs98euYamtGB9ZA7E3xWdqeAZ
 /yFJpZ49fEvx+OQdJYixSiO98uX3ozh8YISeDXvCWgEx3SUblSVs4qn8998pu6Yy
X-Gm-Gg: Acq92OG2r9PfsXCLI6+b1qgo+hP/GP4ek2bio86KzB/nLoi7tJtwyYw6WJwxVhJoBS/
 KkaH9jsG8/aRcgvVEv6qM/V69Rv2VvR2r8YFOMn2d6MuxwwchIu47NuOrnZT5qbrJpmNUbpOb6F
 8JKOmaFjPgcdr7U7RFA3+jtlM8kbiQi4B7GHPIUq/mxtAqjKkRaBno/CkSz6h3Mw2M38SVi6qI4
 K66trnIBDLIl+rcuHBuJszMlI8J604x0Rmh/1Mw7gs7ybAEBDRy3ABHiEh9ANMXmsQLDTihMuiQ
 ARmT01Z2EKfiQ+FpkM+f5rlVrRrLSthYr2rVM/UBRVxMpQIL1aFbWC+maxyj5+uXV28uhgrPr83
 0VZKwzObB4Gkiwqf+gfYEWMz9eHbJiDMsET2kGMmKScbfmn5TJo4sjTOjL70HJKHxG29COmR8Hr
 dpgZXMyVGS9fZY54LTDlZFJv5fHypEnQKYWtvMkyMpbQ==
X-Received: by 2002:a05:6a20:2d23:b0:3b2:8685:13e4 with SMTP id
 adf61e73a8af0-3ba4d7fe75fmr809874637.15.1781752873495; 
 Wed, 17 Jun 2026 20:21:13 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:21:13 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 3/5] migration: add eager load thread for fast snapshot
 load
Date: Thu, 18 Jun 2026 08:50:08 +0530
Message-ID: <20260618032010.88755-4-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x534.google.com
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
thread indefinitely.

Add postcopy_ram_eager_load_thread(), for the eager thread which
iterates over all non ignored blocks calling ram_block_load_eager()
each. ram_block_load_eager then iterates to load in all pages using
postcopy_mapped_ram_load_page(), with a different channel, which takes
care of not loading in pages already loaded by fault thread. On
completion the thread schedules postcopy_ram_eager_load_bh() to destroy
the incoming migration state and set states to completed/end.

Add postcopy_ram_eager_load_setup() to create the thread. Added joining
logic in postcopy_incoming_cleanup().

Add tracepoints for entry and exit to eager load thread.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.h    |  5 +++
 migration/postcopy-ram.c | 75 ++++++++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |  2 ++
 migration/trace-events   |  2 ++
 4 files changed, 84 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..7bb54a6584 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,6 +42,7 @@
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
+#define  MIGRATION_THREAD_DST_EAGER         "mig/dst/eager"
 
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
index 1ec20a07dd..0ee294a381 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2289,9 +2289,84 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
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
+    MigrationIncomingState *mis = opaque;
+    void *host = qemu_ram_get_host_addr(rb);
+    void *target;
+    int ret = 0;
+
+    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
+         page_loc += TARGET_PAGE_SIZE) {
+        target = (uint8_t *)host + page_loc;
+        ret = postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
+                                            0);
+        if (ret) {
+            break;
+        }
+    }
+    return ret;
+}
+
+/*
+ * Bottom half for fast snapshot load, scheduled by eager load thread
+ */
+static void postcopy_ram_eager_load_bh(void *opaque)
+{
+    MigrationIncomingState *mis = opaque;
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_COMPLETED);
+    migration_incoming_state_destroy();
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
+    if (foreach_not_ignored_block(ram_block_load_eager, mis)) {
+        error_report("ram_block_load_eager failed");
+    }
+
+    migration_bh_schedule(postcopy_ram_eager_load_bh, mis);
+
+    rcu_unregister_thread();
+    trace_postcopy_ram_eager_load_thread_exit();
+    return NULL;
+}
+
+/*
+ * Create thread for eager loading in fast snapshot load case
+ */
+int postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    postcopy_thread_create(
+        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_EAGER,
+        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
+    mis->have_eager_load_thread = true;
+    return 0;
+}
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a080dd65a7..b3ba42e447 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -202,4 +202,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
 int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
 int postcopy_incoming_cleanup(MigrationIncomingState *mis);
 
+int postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
+
 #endif
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
2.54.0


