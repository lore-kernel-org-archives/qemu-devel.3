Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41385CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYc-00057j-Rn; Mon, 30 Sep 2024 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXz-00047P-Hc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXx-000466-Ki
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZVd4Pug3ifuQz90VwbIAIsYrOTo120GMYeAvFDr5kM=;
 b=NFUAXDLV9h9hsWKVcty6O9fzpzpinC6CkqCn7RRl/6owAGKbdfHkGW6XCpwe6X1Gy7+17H
 XCMhMhCHeTFFvLYTw9OAmxlwZ1X6jklfAhlaWEe9+jBCiq14wZlFAz5jdJnwzvBMjeBvzq
 2louDRTAUa3MFIjEmQpjmpGDWg6kVqQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-eN7qVG16OPSKELawoOx-XA-1; Mon, 30 Sep 2024 15:59:02 -0400
X-MC-Unique: eN7qVG16OPSKELawoOx-XA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45832b277d9so79429461cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726342; x=1728331142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZVd4Pug3ifuQz90VwbIAIsYrOTo120GMYeAvFDr5kM=;
 b=oNUoIAVqpAGsmL+Mv4aJKObzIBd/pzzBn7cV7NSyrbqGXOlfGM8rkL/4aLR42i1hsF
 nn3mvhlAQZmp9SVsEwoCSHeCV3himeRsBPkylBmfEFKKLHcoWtu3Y+lzXcBZU3ruHivO
 zsGgbHh61ec5VaQ3w43CWQQLcxSTSs1Nz1UhSsYUfqBUH+BfPiQzzwTCnInyWP6J0dLQ
 /oE0qXxnscnYFEkJmfaCjjJbh2pBlRktf9uFJA2RQRzMG+FItPlUrDtCkIDfrGjP91kI
 OZfO4In6X/xTCZD4V4PiZMfvrXurAct4F4EdUB8LyGZRlFhjDC7/+8Rj05phIFudGykF
 wL8g==
X-Gm-Message-State: AOJu0YyUsFm8wgYs9yBum1hyGA6t5KkbPO/HgiBNhNBR05yxjF8rLjQN
 dduDVtUJr+rl9eSzMT/dBOEAIrRJLIhtkLQQK/XdJT3vjsZXRAQTy6VWmd/r9uOq1rlUJehIOM7
 kIBEC/w35Dbsb7X2sWDKM6YJzfrKNEq/XGIT4jHEaL/b8u8VuNSZ3jzTawm/v+yjJ0qlyoPwAxn
 2/nNVLh9M3fY5Nq1bYlhWK4Czq3H8nc/XF5Q==
X-Received: by 2002:a05:622a:54d:b0:45b:5cdf:54b8 with SMTP id
 d75a77b69052e-45c9f1fba6amr208457121cf.19.1727726341518; 
 Mon, 30 Sep 2024 12:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqPysoEctDd1HPNkOdQUXjHclJJZtuerEr6FAqLthVfUIXv32H0mWurxxO8/0bKDzYGmDekw==
X-Received: by 2002:a05:622a:54d:b0:45b:5cdf:54b8 with SMTP id
 d75a77b69052e-45c9f1fba6amr208456741cf.19.1727726340978; 
 Mon, 30 Sep 2024 12:59:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 5/7] migration: Add all threads with QMP query-migrationthreads
Date: Mon, 30 Sep 2024 15:58:35 -0400
Message-ID: <20240930195837.825728-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The QMP interface query-migrationthreads lacks a lot of migration threads
but only reports multifd sender threads.  That's incomplete.

Since I'm at this, make all threads available to the QMP responses.

NOTE: there're a few changes that should fix some bugs on e.g. not
unregister rcu threads on failure paths, but I didn't make them separate
because they do not exist in live migration main logics but only either
COLO or dirty rate thread on rare failures.  I'd not bother, but if anyone
things we should split it out feel free to shoot.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  3 +++
 migration/threadinfo.h   |  3 ---
 migration/colo.c         |  7 +++++--
 migration/dirtyrate.c    |  7 ++++++-
 migration/migration.c    |  7 ++++++-
 migration/multifd.c      |  6 ++++++
 migration/postcopy-ram.c | 10 +++++++---
 migration/savevm.c       | 10 ++++++----
 migration/threadinfo.c   |  1 +
 9 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b9ce5aa4ff..85ec203a01 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -551,4 +551,7 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+void migration_threads_add(const char *name);
+void migration_threads_remove(void);
+
 #endif
diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 7c86ae8763..59f334af21 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -20,6 +20,3 @@ struct MigrationThread {
     int thread_id; /* ID of the underlying host thread */
     QLIST_ENTRY(MigrationThread) node;
 };
-
-void migration_threads_add(const char *name);
-void migration_threads_remove(void);
diff --git a/migration/colo.c b/migration/colo.c
index 9590f281d0..2f5cb96a90 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -823,6 +823,7 @@ static void *colo_process_incoming_thread(void *opaque)
     QIOChannelBuffer *bioc = NULL; /* Cache incoming device state */
     Error *local_err = NULL;
 
+    migration_threads_add(MIGRATION_THREAD_DST_COLO);
     rcu_register_thread();
     qemu_sem_init(&mis->colo_incoming_sem, 0);
 
@@ -831,7 +832,7 @@ static void *colo_process_incoming_thread(void *opaque)
 
     if (get_colo_mode() != COLO_MODE_SECONDARY) {
         error_report("COLO mode must be COLO_MODE_SECONDARY");
-        return NULL;
+        goto out_last;
     }
 
     /* Make sure all file formats throw away their mutable metadata */
@@ -840,7 +841,7 @@ static void *colo_process_incoming_thread(void *opaque)
     bql_unlock();
     if (local_err) {
         error_report_err(local_err);
-        return NULL;
+        goto out_last;
     }
 
     failover_init_state();
@@ -923,7 +924,9 @@ out:
     qemu_sem_wait(&mis->colo_incoming_sem);
     qemu_sem_destroy(&mis->colo_incoming_sem);
 
+out_last:
     rcu_unregister_thread();
+    migration_threads_remove();
     return NULL;
 }
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 2339ba400d..555c599c17 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -729,13 +729,15 @@ void *get_dirtyrate_thread(void *arg)
 {
     struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
     int ret;
+
+    migration_threads_add(MIGRATION_THREAD_DIRTY_RATE);
     rcu_register_thread();
 
     ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
                               DIRTY_RATE_STATUS_MEASURING);
     if (ret == -1) {
         error_report("change dirtyrate state failed.");
-        return NULL;
+        goto out;
     }
 
     calculate_dirtyrate(config);
@@ -746,7 +748,10 @@ void *get_dirtyrate_thread(void *arg)
         error_report("change dirtyrate state failed.");
     }
 
+out:
     rcu_unregister_thread();
+    migration_threads_remove();
+
     return NULL;
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 74b2c1c627..04c4272e46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2321,6 +2321,7 @@ static void *source_return_path_thread(void *opaque)
     int res;
 
     trace_source_return_path_thread_entry();
+    migration_threads_add(MIGRATION_THREAD_SRC_RETURN);
     rcu_register_thread();
 
     while (migration_is_setup_or_active()) {
@@ -2463,8 +2464,9 @@ out:
         migration_rp_kick(ms);
     }
 
-    trace_source_return_path_thread_end();
     rcu_unregister_thread();
+    migration_threads_remove();
+    trace_source_return_path_thread_end();
 
     return NULL;
 }
@@ -3602,6 +3604,8 @@ static void *bg_migration_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
+    migration_threads_add(MIGRATION_THREAD_SNAPSHOT);
+
     rcu_register_thread();
     object_ref(OBJECT(s));
 
@@ -3726,6 +3730,7 @@ fail_setup:
     qemu_fclose(fb);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
+    migration_threads_remove();
 
     return NULL;
 }
diff --git a/migration/multifd.c b/migration/multifd.c
index 2738d78407..b96aaffebb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -685,6 +685,8 @@ static void *multifd_tls_handshake_thread(void *opaque)
 {
     MultiFDTLSThreadArgs *args = opaque;
 
+    migration_threads_add(MIGRATION_THREAD_SRC_TLS);
+
     qio_channel_tls_handshake(args->tioc,
                               multifd_new_send_channel_async,
                               args->p,
@@ -692,6 +694,8 @@ static void *multifd_tls_handshake_thread(void *opaque)
                               NULL);
     g_free(args);
 
+    migration_threads_remove();
+
     return NULL;
 }
 
@@ -1122,6 +1126,7 @@ static void *multifd_recv_thread(void *opaque)
     int ret;
 
     trace_multifd_recv_thread_start(p->id);
+    migration_threads_add(MIGRATION_THREAD_DST_MULTIFD);
     rcu_register_thread();
 
     while (true) {
@@ -1209,6 +1214,7 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
+    migration_threads_remove();
     trace_multifd_recv_thread_end(p->id, p->packets_recved);
 
     return NULL;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a535fd2e30..ee8f2eac77 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -962,6 +962,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     RAMBlock *rb = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
+    migration_threads_add(MIGRATION_THREAD_DST_FAULT);
     rcu_register_thread();
     mis->last_rb = NULL; /* last RAMBlock we sent part of */
     qemu_sem_post(&mis->thread_sync_sem);
@@ -1142,9 +1143,12 @@ retry:
             }
         }
     }
+
+    g_free(pfd);
     rcu_unregister_thread();
+    migration_threads_remove();
     trace_postcopy_ram_fault_thread_exit();
-    g_free(pfd);
+
     return NULL;
 }
 
@@ -1713,7 +1717,7 @@ void *postcopy_preempt_thread(void *opaque)
     int ret;
 
     trace_postcopy_preempt_thread_entry();
-
+    migration_threads_add(MIGRATION_THREAD_DST_PREEMPT);
     rcu_register_thread();
 
     qemu_sem_post(&mis->thread_sync_sem);
@@ -1740,7 +1744,7 @@ void *postcopy_preempt_thread(void *opaque)
     qemu_mutex_unlock(&mis->postcopy_prio_thread_mutex);
 
     rcu_unregister_thread();
-
+    migration_threads_remove();
     trace_postcopy_preempt_thread_exit();
 
     return NULL;
diff --git a/migration/savevm.c b/migration/savevm.c
index e796436979..90f87a90c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2002,14 +2002,15 @@ static void *postcopy_ram_listen_thread(void *opaque)
     int load_res;
     MigrationState *migr = migrate_get_current();
 
-    object_ref(OBJECT(migr));
+    trace_postcopy_ram_listen_thread_start();
+    migration_threads_add(MIGRATION_THREAD_DST_LISTEN);
+    rcu_register_thread();
 
+    object_ref(OBJECT(migr));
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
     qemu_sem_post(&mis->thread_sync_sem);
-    trace_postcopy_ram_listen_thread_start();
 
-    rcu_register_thread();
     /*
      * Because we're a thread and not a coroutine we can't yield
      * in qemu_file, and thus we must be blocking now.
@@ -2078,11 +2079,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
     migration_incoming_state_destroy();
     qemu_loadvm_state_cleanup();
 
-    rcu_unregister_thread();
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
     object_unref(OBJECT(migr));
+    rcu_unregister_thread();
+    migration_threads_remove();
 
     return NULL;
 }
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 25e77404e2..73db26dc82 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -14,6 +14,7 @@
 #include "qemu/queue.h"
 #include "qemu/lockable.h"
 #include "threadinfo.h"
+#include "migration.h"
 
 QemuMutex migration_threads_lock;
 static QLIST_HEAD(, MigrationThread) migration_threads;
-- 
2.45.0


