Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0BFD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4U-00019m-5d; Fri, 11 Oct 2024 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szJ4O-0000hD-N9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szHhU-0007kf-1T
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728661018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lv94tKV1lDi8MQTPf5ChoE9o9wiYCJxcEuRjAmBncHY=;
 b=Hf62aJ9SZxcHmFeAydR5LjY5pS51VB8z5zdw2srRYguH/NHZPsYCTlYYfqOI0HD7XKaEXC
 yf1znLlm79+HnKTCXLGfk9QYX382rl5u36leR8YFh60YyoQ9n2jvPFdluyJk9Yk5rhoREj
 dt2oz50mcOs/511nHOat/hcfYD2stpU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-rO6cOYDuPT6noYCOGPZ46Q-1; Fri, 11 Oct 2024 11:36:57 -0400
X-MC-Unique: rO6cOYDuPT6noYCOGPZ46Q-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8353599024bso167175239f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728661016; x=1729265816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lv94tKV1lDi8MQTPf5ChoE9o9wiYCJxcEuRjAmBncHY=;
 b=j4G1kBKyb9j8/BfVLiMkiKBku1hC9HRq6v9t6K+hsLry+6Tejq1ToHA/v9FEFR6vbp
 sLmz2F+KCHSNKbp0JASd+tCvgQR0hoiBkmHQ+E/cZKSXCHI1eOWhedwlZ8pPsFz/yO5+
 7aiThHqZ8sELw2kbmmw+jzZokYMn/PqjAofQFzY7s/68MBb/yrnSgm003OrdS5F4CTf9
 cuonwoO51QNhRBUhX5ltWJLtIQC0fd1gMb1EJ+a1GaZ9TIs8+/Qa8MrT82BTln0c4Vbv
 axVuUsVEMrX8FdH1k+aeaidwQjbiGy8nAIHqirN7SlrrMccuz15J54qUEh3KeF5WWVXN
 4sIA==
X-Gm-Message-State: AOJu0Yzs18MJZDU9B6jOQPCZES7I04soU33xIypA2Zi+IIIY0ry1Esbo
 4s9wnuAK/ehJ1AMlsVUHrZvQULZOpzo78oAg0DsMHAo7PqRR/34LJzjpkZpwQYvTSE2ZMwSpGa0
 Qr2GBqRKey3ewmRscdmLFmxaxZ8F3KUQvxjxZZolEp63L0RZmvgMmno7vR9NiP+EEUIYaZ0kRQM
 tpXOrGHRuxeEUXjNR6hZ8DVhfYrvg+A0vljg==
X-Received: by 2002:a05:6602:1642:b0:82d:129f:acb6 with SMTP id
 ca18e2360f4ac-83794d4446amr217058839f.14.1728661016213; 
 Fri, 11 Oct 2024 08:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1cjnlyjtSux1aCaTYccr0H+w9sOXiqJQzORh+WErFSIHEcbW22GsmogUXDImUMTomxHiHYw==
X-Received: by 2002:a05:6602:1642:b0:82d:129f:acb6 with SMTP id
 ca18e2360f4ac-83794d4446amr217046639f.14.1728661014242; 
 Fri, 11 Oct 2024 08:36:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaab1d1sm692480173.155.2024.10.11.08.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:36:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Yong Huang <yong.huang@smartx.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PATCH] migration: Put thread names together with macros
Date: Fri, 11 Oct 2024 11:36:52 -0400
Message-ID: <20241011153652.517440-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep migration thread names together, so it's easier to see a list of all
possible migration threads.

Still two functional changes below besides the macro defintions:

  - There's one dirty rate thread that we overlooked before, now we add
  that too and name it as "mig/dirtyrate" following the old rules.

  - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
  it's a thread name anyway, while "rp" can be slightly hard to read.
  Taking this chance to rename it to "mig/src/return", hopefully a better
  name.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    | 14 ++++++++++++++
 migration/colo.c         |  3 ++-
 migration/dirtyrate.c    |  6 ++++--
 migration/migration.c    |  9 +++++----
 migration/multifd.c      |  6 +++---
 migration/postcopy-ram.c |  6 ++++--
 migration/savevm.c       |  3 ++-
 7 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d5..b9ce5aa4ff 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -28,6 +28,20 @@
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 
+#define  MIGRATION_THREAD_SNAPSHOT          "mig/snapshot"
+#define  MIGRATION_THREAD_DIRTY_RATE        "mig/dirtyrate"
+
+#define  MIGRATION_THREAD_SRC_MAIN          "mig/src/main"
+#define  MIGRATION_THREAD_SRC_MULTIFD       "mig/src/send_%d"
+#define  MIGRATION_THREAD_SRC_RETURN        "mig/src/return"
+#define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
+
+#define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
+#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
+#define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
+#define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
+#define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
+
 struct PostcopyBlocktimeContext;
 
 #define  MIGRATION_RESUME_ACK_VALUE  (1)
diff --git a/migration/colo.c b/migration/colo.c
index 6449490221..9590f281d0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,8 @@ void coroutine_fn colo_incoming_co(void)
     assert(bql_locked());
     assert(migration_incoming_colo_enabled());
 
-    qemu_thread_create(&th, "mig/dst/colo", colo_process_incoming_thread,
+    qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
+                       colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
     mis->colo_incoming_co = qemu_coroutine_self();
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 233acb0855..a74a6aeb56 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -29,6 +29,7 @@
 #include "sysemu/runstate.h"
 #include "exec/memory.h"
 #include "qemu/xxhash.h"
+#include "migration.h"
 
 /*
  * total_dirty_pages is procted by BQL and is used
@@ -839,8 +840,9 @@ void qmp_calc_dirty_rate(int64_t calc_time,
 
     init_dirtyrate_stat(config);
 
-    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
-                       (void *)&config, QEMU_THREAD_DETACHED);
+    qemu_thread_create(&thread, MIGRATION_THREAD_DIRTY_RATE,
+                       get_dirtyrate_thread, (void *)&config,
+                       QEMU_THREAD_DETACHED);
 }
 
 
diff --git a/migration/migration.c b/migration/migration.c
index f5f428e764..7609e0feed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2484,7 +2484,7 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
+    qemu_thread_create(&ms->rp_state.rp_thread, MIGRATION_THREAD_SRC_RETURN,
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
 
@@ -3473,7 +3473,8 @@ static void *migration_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add("live_migration", qemu_get_thread_id());
+    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
+                                   qemu_get_thread_id());
 
     rcu_register_thread();
 
@@ -3823,10 +3824,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (migrate_background_snapshot()) {
-        qemu_thread_create(&s->thread, "mig/snapshot",
+        qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
     } else {
-        qemu_thread_create(&s->thread, "mig/src/main",
+        qemu_thread_create(&s->thread, MIGRATION_THREAD_SRC_MAIN,
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
diff --git a/migration/multifd.c b/migration/multifd.c
index 9b200f4ad9..697fe86fdf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -723,7 +723,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     args->p = p;
 
     p->tls_thread_created = true;
-    qemu_thread_create(&p->tls_thread, "mig/src/tls",
+    qemu_thread_create(&p->tls_thread, MIGRATION_THREAD_SRC_TLS,
                        multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -841,7 +841,7 @@ bool multifd_send_setup(void)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
         }
-        p->name = g_strdup_printf("mig/src/send_%d", i);
+        p->name = g_strdup_printf(MIGRATION_THREAD_SRC_MULTIFD, i);
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
@@ -1259,7 +1259,7 @@ int multifd_recv_setup(Error **errp)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
         }
-        p->name = g_strdup_printf("mig/dst/recv_%d", i);
+        p->name = g_strdup_printf(MIGRATION_THREAD_DST_MULTIFD, i);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
     }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 83f6160a36..a535fd2e30 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1230,7 +1230,8 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
-    postcopy_thread_create(mis, &mis->fault_thread, "mig/dst/fault",
+    postcopy_thread_create(mis, &mis->fault_thread,
+                           MIGRATION_THREAD_DST_FAULT,
                            postcopy_ram_fault_thread, QEMU_THREAD_JOINABLE);
     mis->have_fault_thread = true;
 
@@ -1250,7 +1251,8 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
          * This thread needs to be created after the temp pages because
          * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
          */
-        postcopy_thread_create(mis, &mis->postcopy_prio_thread, "mig/dst/preempt",
+        postcopy_thread_create(mis, &mis->postcopy_prio_thread,
+                               MIGRATION_THREAD_DST_PREEMPT,
                                postcopy_preempt_thread, QEMU_THREAD_JOINABLE);
         mis->preempt_thread_status = PREEMPT_THREAD_CREATED;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 7e1e27182a..e796436979 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2131,7 +2131,8 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     }
 
     mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
+    postcopy_thread_create(mis, &mis->listen_thread,
+                           MIGRATION_THREAD_DST_LISTEN,
                            postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-- 
2.45.0


