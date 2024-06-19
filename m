Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CDFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pV-0001p8-0t; Wed, 19 Jun 2024 18:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pT-0001ov-8C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pR-0008PC-GA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVgyQ4Kda41lFezAoCJvwqQ9sH77GJyjC/aLYSrLjWM=;
 b=PMXbO9LE3j4jxwfemLpKv3ecli0WWLdawiitJDJcS59B+XpykMKnMl6j+WGAIGlmWJdM2j
 4U5pHQ8vRL1wT5lGFfUAlmyASTcY0WkJki2uzoQjxeWi/M6N1oyJD1yVl3P0aQ28IvW5bp
 3XPEPNlpFheDqT0Gb9DraQnFpYMXHkQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-s3cBWSBPP9mvV5mgRVT8uA-1; Wed, 19 Jun 2024 18:30:55 -0400
X-MC-Unique: s3cBWSBPP9mvV5mgRVT8uA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dfde150e20bso59155276.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836253; x=1719441053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVgyQ4Kda41lFezAoCJvwqQ9sH77GJyjC/aLYSrLjWM=;
 b=BkqCVGHdCGTqK0gvzKZJ4Rt6Rl2Do0r8PAMKLWlG9mmRH4/TxAGu5wvxBfSsG6wI8C
 Tw0B5QaQwKKu9Bugnr7+d1BwAtuGtZXR8+yYr1/I2Wn5keKP8bHFS06LdLhvMajwpGay
 me4pjgnbWBP9KGamRyRuokSDXNL065C4Zi5sZPpWojzipAvJW850DYG7SNKguqkICfKY
 N8vqli0icmRv51bQwd3ngM/RwmAnYfJM1ziaZxQDc5COLGTYXe09OpCRT8WXN97bPVdm
 Xh2GrcZWm1SwNt5H9b7DatT2RvfH3EBKxavz8yMHXizF6ElYspwxuJMJjsWfKjUUOt3n
 1eLQ==
X-Gm-Message-State: AOJu0YyZZF5guDuLr8M2whYBjaTC/OGVsD3o/ULOdJATMWPhy643o4Gl
 1qdXEETZQQoY793kw6azdZyd5mMq/q5sIule34KJ4C3H0iXOABvKLh8fwVS1ktltjdmF1TIiOu2
 oGJK01GkUsnHAGQGpklaiyvyyHPe4I8yZOcVcpphiCUN+Tnw/fDY8EmVCbKasDLjgYhizwUL9dI
 HAZJJTRSprCwyEPKMqHAp1Q7Piwfj0Imv+1A==
X-Received: by 2002:a25:d041:0:b0:df7:8a41:3009 with SMTP id
 3f1490d57ef6-e02be297ccamr3566071276.6.1718836252604; 
 Wed, 19 Jun 2024 15:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQonPrnxwwZ4xPsGoly96e3QjDxumRGwVtM02UqPVFi6zrw1prO9yd6f2aL7JNB09+Hy/kQg==
X-Received: by 2002:a25:d041:0:b0:df7:8a41:3009 with SMTP id
 3f1490d57ef6-e02be297ccamr3566044276.6.1718836251970; 
 Wed, 19 Jun 2024 15:30:51 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 02/11] migration: Rename thread debug names
Date: Wed, 19 Jun 2024 18:30:37 -0400
Message-ID: <20240619223046.1798968-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
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
index e03c80b3aa..f9b69af62f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2431,7 +2431,7 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
 
@@ -3770,10 +3770,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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
index d82885fdbb..0b4cbaddfe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1069,7 +1069,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     args->p = p;
 
     p->tls_thread_created = true;
-    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
+    qemu_thread_create(&p->tls_thread, "mig/src/tls",
                        multifd_tls_handshake_thread, args,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -1190,7 +1190,7 @@ bool multifd_send_setup(void)
             p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         }
-        p->name = g_strdup_printf("multifdsend_%d", i);
+        p->name = g_strdup_printf("mig/src/send_%d", i);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
@@ -1604,7 +1604,7 @@ int multifd_recv_setup(Error **errp)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
         }
-        p->name = g_strdup_printf("multifdrecv_%d", i);
+        p->name = g_strdup_printf("mig/dst/recv_%d", i);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
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


