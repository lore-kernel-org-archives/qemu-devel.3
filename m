Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22064C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBU-00087i-QG; Wed, 12 Jun 2024 10:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBT-000879-4T
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBR-0002nV-Ev
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718203360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhSChAN7rRoGGaUSPSWCzV7QQQImNhxehyAptMysuXo=;
 b=DufqvculMUpqGcNTGtk3dPs0e3tfoGiVoan8XqEQM9UKa6LHaWzA5VyUIK+xwPBKiyZVsB
 ccFygWb8DSCFBKDbIpkq/HHNRrsiaC5nKeWMijk3FK9U2u5OvtHXVKieO1RfKrLpbT1UAz
 M0ibPmJP9v3WZLTZu5wJhjZcHw2KVpw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-wXBTEOKFPbaj2KMvqegU8Q-1; Wed, 12 Jun 2024 10:42:36 -0400
X-MC-Unique: wXBTEOKFPbaj2KMvqegU8Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dfef58530cdso50927276.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203355; x=1718808155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhSChAN7rRoGGaUSPSWCzV7QQQImNhxehyAptMysuXo=;
 b=Txtgb4S1KkNdu3iKpZWwwpNxdta5fXlnFZ575IyhNuIIfUbaDnZSUIpGvu2gDk5ALA
 NZsEbMunXo5ds7mCpW7EK47hrPLh2SvC3hnqVZ/+JR4t8qBF8h/x17j9YSGbd/GBLATO
 QThJKISEwgS78Uba+NMGN4ejDyfDsnw5h1zmwgUyFdq0tfStPfw4h8VDtZAUILEQb5zz
 xWfI9SdAEl80ujDQDnBeDH8GZM6RJQxgL6Hah7YgTDeX1G+pNqRxFaHQ3gl860dAnxna
 VToq7HFzZI4Z3ha2FsQJwi58G8yLOb33j/yMEBB/MTNgT8E5RzpmKsz7sfCq7ncxxhPc
 w+Lw==
X-Gm-Message-State: AOJu0YzD4p6/LgpU4NekwA1yyNMStxdWjvhA71WFWcRMOD79bNrBCzMT
 lqxnmegq7lvBEFvxCykq3tnMiybR/lsrUSeRJn26aIqpR2rJkl00IZyrgxGkWIfO5hDxLTxYCJw
 C3lShsOoqF8aY05mGELSzfP3BrRRrpXwxyKNi80WeLuQZORnIsyRYzXIbr67Ims5sjn1u9lyj1C
 2tCx+CJdaL1lqTiSr2axxQOyYHfvgdcbpd1g==
X-Received: by 2002:a25:aac1:0:b0:df8:3484:770f with SMTP id
 3f1490d57ef6-dfe6a3c48cdmr1628047276.5.1718203355193; 
 Wed, 12 Jun 2024 07:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXuFYYrHpwSclU/HZVpITEarM/IvEfihEypfKC02ucdu7kFmB0yXS4hLJlNTkaiCCIPYeSaA==
X-Received: by 2002:a25:aac1:0:b0:df8:3484:770f with SMTP id
 3f1490d57ef6-dfe6a3c48cdmr1627999276.5.1718203354597; 
 Wed, 12 Jun 2024 07:42:34 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405e3ded65sm37581681cf.87.2024.06.12.07.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 2/4] migration: Rename thread debug names
Date: Wed, 12 Jun 2024 10:42:26 -0400
Message-ID: <20240612144228.1179240-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240612144228.1179240-1-peterx@redhat.com>
References: <20240612144228.1179240-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The postcopy thread names on dest QEMU are slightly confusing, partly I'll
need to blame myself on 36f62f11e4 ("migration: Postcopy preemption
preparation on channel creation").  E.g., "fault-fast" reads like a fast
version of "fault-default", but it's actually the fast version of
"postcopy/listen".

Taking this chance, rename all the migration threads with proper rules.
Considering we only have 15 chars usable, prefix all threads with "mig/",
meanwhile identify src/dst threads properly this time.  So now most thread
names will look like "mig/DIR/xxx", where DIR will be "src"/"dst", except
the bg-snapshot thread which doesn't have a direction.

For multifd threads, making them "mig/{src|dst}/{send|recv}_%d".

We used to have "live_migration" thread for a very long time, now it's
called "mig/src/main".  We may hope to have "mig/dst/main" soon but not
yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c         | 2 +-
 migration/migration.c    | 6 +++---
 migration/multifd.c      | 6 +++---
 migration/postcopy-ram.c | 4 ++--
 migration/savevm.c       | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index f96c2ee069..6449490221 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     assert(bql_locked());
     assert(migration_incoming_colo_enabled());
 
-    qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
+    qemu_thread_create(&th, "mig/dst/colo", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
     mis->colo_incoming_co = qemu_coroutine_self();
diff --git a/migration/migration.c b/migration/migration.c
index e1b269624c..d41e00ed4c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2408,7 +2408,7 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
 
@@ -3747,10 +3747,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (migrate_background_snapshot()) {
-        qemu_thread_create(&s->thread, "bg_snapshot",
+        qemu_thread_create(&s->thread, "mig/snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
     } else {
-        qemu_thread_create(&s->thread, "live_migration",
+        qemu_thread_create(&s->thread, "mig/src/main",
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..7afc0965f6 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1059,7 +1059,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     args->p = p;
 
     p->tls_thread_created = true;
-    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
+    qemu_thread_create(&p->tls_thread, "mig/src/tls",
                        multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -1185,7 +1185,7 @@ bool multifd_send_setup(void)
         } else {
             p->iov = g_new0(struct iovec, page_count);
         }
-        p->name = g_strdup_printf("multifdsend_%d", i);
+        p->name = g_strdup_printf("mig/src/send_%d", i);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
@@ -1601,7 +1601,7 @@ int multifd_recv_setup(Error **errp)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
         }
-        p->name = g_strdup_printf("multifdrecv_%d", i);
+        p->name = g_strdup_printf("mig/dst/recv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3419779548..97701e6bb2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1238,7 +1238,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
-    postcopy_thread_create(mis, &mis->fault_thread, "fault-default",
+    postcopy_thread_create(mis, &mis->fault_thread, "mig/dst/fault",
                            postcopy_ram_fault_thread, QEMU_THREAD_JOINABLE);
     mis->have_fault_thread = true;
 
@@ -1258,7 +1258,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
          * This thread needs to be created after the temp pages because
          * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
          */
-        postcopy_thread_create(mis, &mis->postcopy_prio_thread, "fault-fast",
+        postcopy_thread_create(mis, &mis->postcopy_prio_thread, "mig/dst/preempt",
                                postcopy_preempt_thread, QEMU_THREAD_JOINABLE);
         mis->preempt_thread_status = PREEMPT_THREAD_CREATED;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359b..e71410d8c1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2129,7 +2129,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     }
 
     mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread, "postcopy/listen",
+    postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
                            postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-- 
2.45.0


