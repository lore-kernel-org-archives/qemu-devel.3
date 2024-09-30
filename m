Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644D0CDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYE-0004Fj-KY; Mon, 30 Sep 2024 15:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXw-00043g-CL
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXn-0003xk-U4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBD3pQ9OiqYUxqrsoMFJzeYINwaBKJNjacu1woAbQd0=;
 b=Be5wUFpdkZQxoqbpkvcu4jqon6HP4pBuWaqLlBuPn1DPeEmuFmz3m6LAhp5Hr++G9XttX/
 pIBVSPaakz+QV54MbBJUfpYDgKpGxi63+4LpqYffp5C926PhHjVK89wrTTepa8gWNBVCCl
 82JdutpJcaZ3spY2JmMHvAIEE3hvP8c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-aLZHqKtOMLy4eJQ1k2adGw-1; Mon, 30 Sep 2024 15:58:51 -0400
X-MC-Unique: aLZHqKtOMLy4eJQ1k2adGw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4581d15ced1so77859281cf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726330; x=1728331130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBD3pQ9OiqYUxqrsoMFJzeYINwaBKJNjacu1woAbQd0=;
 b=GGVgltQOKV0TtbRXYBWAIAPnb9soj3VlOwFXxrVq00Isn8s3s4VsmnTi27BPanULvL
 ChnVh2CE32YV9R2Y94vaDo4MdSiitJe+UMVHvqjT/M+z/f4o3CVk6za0Xsxguw99AYvE
 f9P43OqZkiXz8eCgA6LJ9d70DZSGaLtiPFD0qNKeoc4U3ZIVORNhtzD+8ZX8DRz33fiZ
 hkoywm8iM4uHkPKvRuVN5l7liPgOcUYgDQULNfVts6TGSK7vTGG8powngV9O5Lz3reJ7
 Tj7i8Oa3lKQXYH3s5JyjMNDiNmPuNl4SPy5202fZz7yKP55dAX6GF29yMqWAFRJzALUZ
 9hEQ==
X-Gm-Message-State: AOJu0YwvkrVk5FSiAtHefsEAsgoVWQr2f+di71iGrKjmDNku92vjriuY
 kNKFg6GG2nZ/jBCJnQ248TBhWNY01WPrxD5L6+6Rc2p3wUPVSAK7g8SyR2ZgrnfwZavTXwQbYuJ
 vLdWUFsJU+4XgpnUZj3yohdj6scGaQqwWmunKtmr8zAmQfujj7TUEdvkb03XuwjFNKF5uiPtPiq
 1H6emBIB+e6EwFBhCVWnP7COs7+5flHyW6xA==
X-Received: by 2002:ac8:5709:0:b0:458:35f7:3952 with SMTP id
 d75a77b69052e-45c9f2877e6mr254328421cf.40.1727726329914; 
 Mon, 30 Sep 2024 12:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDCGKpRszIYZqqocL0QnCe7EYHJTqxIVWBzQMzUlfbALLGQ25mW31KBiyjc7eoOWxSygKg4w==
X-Received: by 2002:ac8:5709:0:b0:458:35f7:3952 with SMTP id
 d75a77b69052e-45c9f2877e6mr254328061cf.40.1727726329482; 
 Mon, 30 Sep 2024 12:58:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/7] migration: Put thread names together with macros
Date: Mon, 30 Sep 2024 15:58:32 -0400
Message-ID: <20240930195837.825728-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Since we have places where there can be more than one reference to the
thread names, time to clean up the thread names with macros so that they're
even cleaner when put together.

Still two functional changes below:

  - There's one dirty rate thread that we overlooked before, now we add
  that too and name it as "mig/dirtyrate" following the old rules.

  - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
  it's a thread name anyway, while "rp" can be slightly hard to read.
  Taking this chance to rename it to "mig/src/return", hopefully a better
  name.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    | 14 +++++++++++++-
 migration/colo.c         |  3 ++-
 migration/dirtyrate.c    |  6 ++++--
 migration/migration.c    |  4 ++--
 migration/multifd.c      |  6 +++---
 migration/postcopy-ram.c |  6 ++++--
 migration/savevm.c       |  3 ++-
 7 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 519455796d..b9ce5aa4ff 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -28,7 +28,19 @@
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 
-#define  MIGRATION_THREAD_SRC_MAIN  "mig/src/main"
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
 
 struct PostcopyBlocktimeContext;
 
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
index 5478d58de3..2339ba400d 100644
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
index 505b62c8f3..813c45ad04 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2478,7 +2478,7 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
+    qemu_thread_create(&ms->rp_state.rp_thread, MIGRATION_THREAD_SRC_RETURN,
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
 
@@ -3818,7 +3818,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (migrate_background_snapshot()) {
-        qemu_thread_create(&s->thread, "mig/snapshot",
+        qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
     } else {
         qemu_thread_create(&s->thread, MIGRATION_THREAD_SRC_MAIN,
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


