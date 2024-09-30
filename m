Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE06CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYc-00057A-N0; Mon, 30 Sep 2024 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXx-00045N-G2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXt-00041x-SC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64NuNC1LXyWR9BlyqFsA8AEgcMwuGH1wwkajjFosllk=;
 b=P+weIxhKjRs0gWY1vpHk4f12pj+LURxyNYL8l5tu39fCh7ivrIJp0ZGIWX57D582WW39Ku
 TlYjLbLLMu0biKy7JoV3VlAABzv72VBtKN4GsswoQLaz7AEvMDSNsc0GtHSBgUxMebB+1D
 DR6hxBzomFiip4DkhIz1RhObFgEjzwc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-w37P3WYJP4ihE5VuugavLA-1; Mon, 30 Sep 2024 15:58:59 -0400
X-MC-Unique: w37P3WYJP4ihE5VuugavLA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-45b172569a2so57190211cf.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726337; x=1728331137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64NuNC1LXyWR9BlyqFsA8AEgcMwuGH1wwkajjFosllk=;
 b=o3kKthrGP22o4tACQJyjDNo00P4bnMUxAhQD/INphVJVEoAcgVQBZY9kqTJyAKH1d5
 33Lt+a764kYMa23uWcyASKHTp1k43wYjIJDATDyRVo07gnaVxhS0/CK/wSjNhnW7chwn
 4knoODfD5FzI1kB4I8KUkZRwuKCrFQwJ89NxH386xP4tiaskegRVX+fYcrSGxPeVlPYW
 sHWBGbiWc4MO59jYabqdq41hjmi1pCFKQXwr8vAVF00sfYF8C/0XfV4G4rZjrtkBwjRz
 Wr3M2vq2zG11DAiOrUtJmMj8PIkSMC9Z9uodcPRQjKG60IIG71BlvkzkRkT1qdBMlKiN
 Iykg==
X-Gm-Message-State: AOJu0Yydmbmkho5Dd9M7SXcJV4paGTcJ8E98hKZISxuXG+SqAoNJ1iHo
 yZmSs7afUoRvoz3NfJ5Ii6gG6h7p0SLgZ1cqltsvCU8wkGjXLAHdFAyhG1xPOZlyklsXJ5CP2IV
 W1vHtRYo1qcknZojw44z3ZBWfhKzbNOebYb9AwjZbbuZ1jIDMXzXpt714mHB1/S3wIVc4miXbmA
 tWp6j80kXPYt6c1Vec51aImkQdPb3nJO8ZGw==
X-Received: by 2002:ac8:5756:0:b0:458:1749:e195 with SMTP id
 d75a77b69052e-45c9f1b1fe4mr164506131cf.10.1727726336702; 
 Mon, 30 Sep 2024 12:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqiB7b3fIawvfRZqUY0ehIHYZkiFiRJyfeO1PLeLl54hB4ha+h6XAsGKJ/AVLigYDn5juGaA==
X-Received: by 2002:ac8:5756:0:b0:458:1749:e195 with SMTP id
 d75a77b69052e-45c9f1b1fe4mr164505841cf.10.1727726336208; 
 Mon, 30 Sep 2024 12:58:56 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 4/7] migration: Simplify migration-threads API
Date: Mon, 30 Sep 2024 15:58:34 -0400
Message-ID: <20240930195837.825728-5-peterx@redhat.com>
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

There's no need to return a thread struct, because both the add/remove APIs
must be used in the working threads so tid would work.

Similar to the fact we don't need to pass in tid in each call sites, we
don't need the thread struct for removal too because tid is always in the
context.  Remove it in both add & remove APIs.  Instead making sure when
remove a thread the tid is always there.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/threadinfo.h |  4 ++--
 migration/migration.c  |  5 ++---
 migration/multifd.c    |  5 ++---
 migration/threadinfo.c | 19 ++++++++++++++-----
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index d0e4ab0aa3..7c86ae8763 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -21,5 +21,5 @@ struct MigrationThread {
     QLIST_ENTRY(MigrationThread) node;
 };
 
-MigrationThread *migration_threads_add(const char *name);
-void migration_threads_remove(MigrationThread *info);
+void migration_threads_add(const char *name);
+void migration_threads_remove(void);
diff --git a/migration/migration.c b/migration/migration.c
index 1ddcf54a70..74b2c1c627 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3460,14 +3460,13 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
 static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
-    MigrationThread *thread = NULL;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN);
+    migration_threads_add(MIGRATION_THREAD_SRC_MAIN);
 
     rcu_register_thread();
 
@@ -3566,7 +3565,7 @@ out:
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    migration_threads_remove(thread);
+    migration_threads_remove();
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 04db886c7e..2738d78407 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -570,12 +570,11 @@ int multifd_send_sync_main(void)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
-    MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
     bool use_packets = multifd_use_packets();
 
-    thread = migration_threads_add(p->name);
+    migration_threads_add(p->name);
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
@@ -669,7 +668,7 @@ out:
     }
 
     rcu_unregister_thread();
-    migration_threads_remove(thread);
+    migration_threads_remove();
     trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 8069413091..25e77404e2 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -23,7 +23,7 @@ static void __attribute__((constructor)) migration_threads_init(void)
     qemu_mutex_init(&migration_threads_lock);
 }
 
-MigrationThread *migration_threads_add(const char *name)
+void migration_threads_add(const char *name)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
 
@@ -33,17 +33,26 @@ MigrationThread *migration_threads_add(const char *name)
     WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
         QLIST_INSERT_HEAD(&migration_threads, thread, node);
     }
-
-    return thread;
 }
 
-void migration_threads_remove(MigrationThread *thread)
+void migration_threads_remove(void)
 {
+    int tid = qemu_get_thread_id();
+    MigrationThread *thread;
+
     QEMU_LOCK_GUARD(&migration_threads_lock);
-    if (thread) {
+
+    QLIST_FOREACH(thread, &migration_threads, node) {
+        if (tid != thread->thread_id) {
+            continue;
+        }
+
         QLIST_REMOVE(thread, node);
         g_free(thread);
+        return;
     }
+
+    g_assert_not_reached();
 }
 
 MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
-- 
2.45.0


