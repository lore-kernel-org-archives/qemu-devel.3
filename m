Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2AAD5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4u-0003Wo-L8; Wed, 30 Oct 2024 11:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4t-0003WK-9t
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4r-0007kw-Dp
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vMR4PZBXrmLnClQwHD7/3wsuLKI6SWDpGLbddmcqLQ=;
 b=YuAtitvqbj4DBiAp0QpcEk02799id0ArK7KlkwQKq7EjKOs3ls6E/lKM4UjdmO0ZGDZCxU
 1ZO17eabKzrUEDomoGw4NmoVyTbsaKo24gsHXvGXJvfM0UA5gKaKPRkibXcxp3qQSMz6M7
 ILej6//Mxv2DNsKOE+YfjsVrcapP/mM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-livDLeWnOECYpL3ZZpQfsA-1; Wed, 30 Oct 2024 11:57:41 -0400
X-MC-Unique: livDLeWnOECYpL3ZZpQfsA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ce2d91fa3bso45166d6.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303860; x=1730908660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vMR4PZBXrmLnClQwHD7/3wsuLKI6SWDpGLbddmcqLQ=;
 b=Y0xFB6u3uzMTKcAAdlwCLa4//J21Znzl166VK3E5psE1MNpgcW3BogbWRulmmEiKMM
 QJpLoL/nIs93P/DJhH7tVcBLtVIluCR3X8QB+Tp6y4TIvQdfyZuC50c5npvkgMh2HQa5
 rmbg0sjqzDk4V79TsVdEfM9gN8EjWbQTbmW1r4b6T3Rp1/69jXzfQdurBc+HGpy5BK0f
 0eBcdHUvKzKvzz8kGuw99H4bYVaT5KTKNRE+ivZbBk7fLuU4TDaEq+3OXLDJSoUVzIsF
 zXQ350jysT4hh0s3v5+Pw3CNynabAjNsqHn2TSryexuloCGtSNLCsEawNN9O0JcQSP42
 F6OA==
X-Gm-Message-State: AOJu0YyCZbx/hS6Yv/T16FmKut/kGmkT2L1/w18ox35FbgOfaL8BHcGj
 JUp8MB8Ff3NHHhSNErNCzuDCBG7mjwoIx2ZYrGO+raWHv6t/9g7K91Gb68GP9+wZi8LllAWEFBC
 71K48+SjaOy2KcXQPXmp1E5MendU1Tm7qd6mYAJBTEF+NMlpk+Q7LU9cjPzBAYJDrqgOOe4OtSO
 jbmtk+4v5n94U+EN2frZUq3U0Jk0q4sfKC2w==
X-Received: by 2002:a05:6214:3a84:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6d1857030c9mr293618656d6.27.1730303859960; 
 Wed, 30 Oct 2024 08:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ3lzXQOtkJYycChb+Is7T0Qi2/KhanOvAXJ+Sl+MgVkUkrTIKAFOQX9l1IoszHg9uyrteAw==
X-Received: by 2002:a05:6214:3a84:b0:6cd:4972:59b1 with SMTP id
 6a1803df08f44-6d1857030c9mr293618346d6.27.1730303859570; 
 Wed, 30 Oct 2024 08:57:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Zhang Chen <chen.zhang@intel.com>
Subject: [PULL 02/18] migration: Put thread names together with macros
Date: Wed, 30 Oct 2024 11:57:18 -0400
Message-ID: <20241030155734.2141398-3-peterx@redhat.com>
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

Keep migration thread names together, so it's easier to see a list of all
possible migration threads.

Still two functional changes below besides the macro defintions:

  - There's one dirty rate thread that we overlooked before, now we add
  that too and name it as "mig/dirtyrate" following the old rules.

  - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
  it's a thread name anyway, while "rp" can be slightly hard to read.
  Taking this chance to rename it to "mig/src/return", hopefully a better
  name.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Link: https://lore.kernel.org/r/20241011153652.517440-1-peterx@redhat.com
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


