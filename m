Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE56ECCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTu-0002vS-Vt; Wed, 22 Oct 2025 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTk-0002tW-At
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTh-0001YZ-Eb
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Jc0kveFbdHXC0rLwFGTNnrLna7jwtbutSCIcOsSkwQ=;
 b=NPPWqOJDFK4u5TH+UyPuh5ShRZq6xGcU9taKEQ9gfCzKXTumQzKzcVrA9DK1PGVVWJbaA4
 +0Vem1eBBcX/l5TiLekHvyE4EbVx8XuqWi7f60kS2Zz9ys9mqpo4my9NVS75eeYxEWMxFQ
 KktHl5RKNwHprdRHTeaXkevYUydG+Lw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-i7OudJHmO7aZt45YhJhrkg-1; Wed, 22 Oct 2025 15:26:31 -0400
X-MC-Unique: i7OudJHmO7aZt45YhJhrkg-1
X-Mimecast-MFC-AGG-ID: i7OudJHmO7aZt45YhJhrkg_1761161191
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e88947a773so66678241cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161190; x=1761765990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Jc0kveFbdHXC0rLwFGTNnrLna7jwtbutSCIcOsSkwQ=;
 b=C6wJMdlt3bAg2P5F5YKP5QH68Xsc1VgLYInSXmKkZdjIiOelSkvCys/g6DUKEVKUOj
 kUXx9lidPU2ZzvblA9aPaP9spZH+KrkHQjO56xnkHpQI3xN8l7/xiHBlU+RbQ2l5mJSy
 iUXkfvPXOVKG3uAzlfGP0xqmzkY4ycyWaVaLabtJlIdn5OneIdAp6U0m3v4ZzpwZ7ZNS
 wji4x+EQamH9Nu2OARjhbwgKRj78iugTEsJEtMYlAuYue6ZDzevB9AWWV+qEtKKBwj+z
 8FSafWDgFlEFqgnt3RqQv9l32+eLUD880kePKRjo0Ap2bZotzqXS+BqNYhjfIUq45/GH
 E9TQ==
X-Gm-Message-State: AOJu0YzYvW2mX3OQ+mUONWLd13M63o8rMNkK0U/CEP8C8mlG6iK30kn1
 GQRrdut/ze5iRZrKiPUGIHVl8DYZYROa7746do6m3NqqjaOqoBTtDClHrwBCsPckAOVhtACpLMh
 dkXn8qGrdzEta8/jyQG0YaxJNWc/7BJ3GEbm9njvgjSzsINr+TAFRFEBIIMHGet49qgmDXvAvyK
 14q3Nduj++w0SZp9HbPRd5ROiZgysAObZDDEOTLQ==
X-Gm-Gg: ASbGnctd/EEf4Xmt3UCWaXZODQcaFf6HDeZCNCFF03GzMi3MTTDiIexYQeFxB5gJkxy
 BjsufbkvwM5IlPG8aji4wPF0XHMh6dFDI5fFjnsTth2FiouOtw6b9bZvdw/mWxLGNPp7/RIVe9D
 UH674vUaVeQhqaES47ckWAsEyzURiy9yxwDFeCqxg3Tv89r9kCTm1asQDFaqUYudtHhVDiqC4W+
 uYa3LZYXqpIW2UCDktgI1mfBUQXK2JWNKN//V/+wSmZqPWCwqgW4zCzRQ2fjaWGdEiE5jRyykI9
 bo9oGG4DynwclDEMxDyYRxE5lNLzWFP9tq2GIy92YyPdJGEL/Hx8Zl2i2tY3+RBd
X-Received: by 2002:a05:622a:1a90:b0:4e8:b64a:2dff with SMTP id
 d75a77b69052e-4e8b64a3083mr176110581cf.26.1761161189736; 
 Wed, 22 Oct 2025 12:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9d76WEUbLgPJ+MveugtoA2ZeQzMke6T85FxYx0xHcaktwvgcxPfQsU9h4LRtGM1Pofm1aNw==
X-Received: by 2002:a05:622a:1a90:b0:4e8:b64a:2dff with SMTP id
 d75a77b69052e-4e8b64a3083mr176109871cf.26.1761161188746; 
 Wed, 22 Oct 2025 12:26:28 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Date: Wed, 22 Oct 2025 15:26:07 -0400
Message-ID: <20251022192612.2737648-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration module was there for 10+ years.  Initially, it was in most cases
based on coroutines.  As more features were added into the framework, like
postcopy, multifd, etc.. it became a mixture of threads and coroutines.

I'm guessing coroutines just can't fix all issues that migration want to
resolve.

After all these years, migration is now heavily based on a threaded model.

Now there's still a major part of migration framework that is still not
thread-based, which is precopy load.  We do load in a separate thread in
postcopy since the 1st day postcopy was introduced, however that requires a
separate state transition from precopy loading all devices first, which
still happens in the main thread of a coroutine.

This patch tries to move the migration incoming side to be run inside a
separate thread (mig/dst/main) just like the src (mig/src/main).  The
entrance to be migration_incoming_thread().

Quite a few things are needed to make it fly..  One note here is we need to
change all these things in one patch to not break anything.  The other way
to do this is add code to make all paths (that this patch touched) be ready
for either coroutine or thread.  That may cause confusions in another way.
So reviewers, please take my sincere apology on the hardness of reviewing
this patch: it covers a few modules at the same time, and with some risky
changes.

BQL Analysis
============

Firstly, when moving it over to the thread, it means the thread cannot take
BQL during the whole process of loading anymore, because otherwise it can
block main thread from using the BQL for all kinds of other concurrent
tasks (for example, processing QMP / HMP commands).

Here the first question to ask is: what needs BQL during precopy load, and
what doesn't?

Most of the load process shouldn't need BQL, especially when it's about
RAM.  After all, RAM is still the major chunk of data to move for a live
migration process.  VFIO started to change that, though, but still, VFIO is
per-device so that shouldn't need BQL either in most cases.

Generic device loads will need BQL, likely not when receiving VMSDs, but
when applying them.  One example is any post_load() could potentially
inject memory regions causing memory transactions to happen.  That'll need
to update the global address spaces, hence requires BQL.  The other one is
CPU sync operations, even if the sync alone may not need BQL (which is
still to be further justified), run_on_cpu() will need it.

For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
to now take a "bql_held" parameter saying whether bql is held.  We could
use things like BQL_LOCK_GUARD(), but this patch goes with explicit
lockings rather than relying on bql_locked TLS variable.  In case of
migration, we always know whether BQL is held in different context as long
as we can still pass that information downwards.

COLO
====

COLO assumed the dest VM load happens in a coroutine.  After this patch,
it's not anymore.  Change that by invoking colo_incoming_co() directly from
the migration_incoming_thread().

The name (colo_incoming_co()) isn't proper anymore.  Change it to
colo_incoming_wait(), removing the coroutine annotation alongside.

Remove all the bql_lock() implications in COLO, e.g., colo_incoming_co()
used to release the lock for a short period while join().  Now it's not
needed.  Instead, taking BQL but only when needed (colo_release_ram_cache).

At the meantime, there's colo_incoming_co variable that used to store the
COLO incoming coroutine, only to be kicked off when a secondary failover
happens.

To recap, what should happen for such failover should be (taking example of
a QMP command x-colo-lost-heartbeat triggering on dest QEMU):

  - The QMP command will kick off both the coroutine and the COLO
    thread (colo_process_incoming_thread()), with something like:

    /* Notify COLO incoming thread that failover work is finished */
    qemu_event_set(&mis->colo_incoming_event);

    qemu_coroutine_enter(mis->colo_incoming_co);

  - The coroutine, which yielded itself before, now resumes after enter(),
    then it'll wait for the join():

    mis->colo_incoming_co = qemu_coroutine_self();
    qemu_coroutine_yield();
    mis->colo_incoming_co = NULL;

    /* Wait checkpoint incoming thread exit before free resource */
    qemu_thread_join(&th);

Here, when switching to a thread model, it should be fine removing
colo_incoming_co variable completely, because if so, the incoming thread
will (instead of yielding the coroutine) wait at qemu_thread_join() until
the colo thread completes execution (after receiving colo_incoming_event).

RDMA
====

With the prior patch making sure io_watch won't block for RDMA iochannels,
RDMA threads should only block at its io_readv/io_writev functions.  When a
disconnection is detected (as in rdma_cm_poll_handler()), the update to
"errored" field will be immediately reflected in the migration incoming
thread.  Hence the coroutine for RDMA is not needed anymore to kick the
thread out.

When the thread is available, we also can't have rdma_cm_poll_handler()
keep polling the fd and operate on it in the main thread.  Drop it
completely, and it should be fine because qemu_rdma_wait_comp_channel()
should also be monitoring it.

This almost reverts commit 923709896b1b01fb982c93492ad01b233e6b6023.

We need to do this change in this same patch that we introduce the thread,
unfortunately, otherwise we can have a risk of racing.

TODO
====

Currently the BQL is taken during loading of a START|FULL section.  When
the IO hangs (e.g. network issue) during this process, it could potentially
block others like the monitor servers.  One solution is breaking BQL to
smaller granule and leave IOs to be always BQL-free.  That'll need more
justifications.

For example, there are at least four things that need some closer
attention:

  - SaveVMHandlers's load_state(): this likely DO NOT need BQL, but we need
  to justify all of them (not to mention, some of them look like prone to
  be rewritten as VMSDs..)

  - VMSD's pre_load(): in most cases, this DO NOT really need BQL, but
  sometimes maybe it will!  Double checking on this will be needed.

  - VMSD's post_load(): in many cases, this DO need BQL, for example on
  address space operations.  Likely we should just take it for any
  post_load().

  - VMSD field's get(): this is tricky!  It could internally be anything
  even if it was only a field.  E.g. there can be users to use a SINGLE
  field to load a whole VMSD, which can further introduce more
  possibilities.

In general, QEMUFile IOs should not need BQL, that is when receiving the
VMSD data and waiting for e.g. the socket buffer to get refilled.  But
that's the easy part.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/colo.h |  6 ++--
 migration/migration.h    | 14 +++-----
 migration/colo-stubs.c   |  2 +-
 migration/colo.c         | 24 ++++---------
 migration/migration.c    | 77 +++++++++++++++++++++++++---------------
 migration/rdma.c         | 34 +-----------------
 migration/savevm.c       |  8 ++---
 migration/trace-events   |  4 +--
 8 files changed, 69 insertions(+), 100 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index d4fe422e4d..5de7d715a7 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -44,12 +44,10 @@ void colo_do_failover(void);
 void colo_checkpoint_delay_set(void);
 
 /*
- * Starts COLO incoming process. Called from process_incoming_migration_co()
+ * Starts COLO incoming process. Called from migration_incoming_thread()
  * after loading the state.
- *
- * Called with BQL locked, may temporary release BQL.
  */
-void coroutine_fn colo_incoming_co(void);
+void colo_incoming_wait(void);
 
 void colo_shutdown(void);
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index e1c5029110..0d22dc8cc2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -214,6 +214,10 @@ struct MigrationIncomingState {
     bool           have_listen_thread;
     QemuThread     listen_thread;
 
+    /* Migration main recv thread */
+    bool           have_recv_thread;
+    QemuThread     recv_thread;
+
     /* For the kernel to send us notifications */
     int       userfault_fd;
     /* To notify the fault_thread to wake, e.g., when need to quit */
@@ -272,15 +276,7 @@ struct MigrationIncomingState {
 
     MigrationStatus state;
 
-    /*
-     * The incoming migration coroutine, non-NULL during qemu_loadvm_state().
-     * Used to wake the migration incoming coroutine from rdma code. How much is
-     * it safe - it's a question.
-     */
-    Coroutine *loadvm_co;
-
-    /* The coroutine we should enter (back) after failover */
-    Coroutine *colo_incoming_co;
+    /* Notify secondary VM to move on */
     QemuEvent colo_incoming_event;
 
     /* Optional load threads pool and its thread exit request flag */
diff --git a/migration/colo-stubs.c b/migration/colo-stubs.c
index e22ce65234..ef77d1ab4b 100644
--- a/migration/colo-stubs.c
+++ b/migration/colo-stubs.c
@@ -9,7 +9,7 @@ void colo_shutdown(void)
 {
 }
 
-void coroutine_fn colo_incoming_co(void)
+void colo_incoming_wait(void)
 {
 }
 
diff --git a/migration/colo.c b/migration/colo.c
index 4fd586951a..81276a3e65 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -147,11 +147,6 @@ static void secondary_vm_do_failover(void)
     }
     /* Notify COLO incoming thread that failover work is finished */
     qemu_event_set(&mis->colo_incoming_event);
-
-    /* For Secondary VM, jump to incoming co */
-    if (mis->colo_incoming_co) {
-        qemu_coroutine_enter(mis->colo_incoming_co);
-    }
 }
 
 static void primary_vm_do_failover(void)
@@ -848,10 +843,8 @@ static void *colo_process_incoming_thread(void *opaque)
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
     /*
-     * Note: the communication between Primary side and Secondary side
-     * should be sequential, we set the fd to unblocked in migration incoming
-     * coroutine, and here we are in the COLO incoming thread, so it is ok to
-     * set the fd back to blocked.
+     * Here we are in the COLO incoming thread, so it is ok to set the fd
+     * to blocking.
      */
     if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
         error_report_err(local_err);
@@ -927,27 +920,22 @@ out:
     return NULL;
 }
 
-void coroutine_fn colo_incoming_co(void)
+/* Wait for failover */
+void colo_incoming_wait(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QemuThread th;
 
-    assert(bql_locked());
     assert(migration_incoming_colo_enabled());
 
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
-    mis->colo_incoming_co = qemu_coroutine_self();
-    qemu_coroutine_yield();
-    mis->colo_incoming_co = NULL;
-
-    bql_unlock();
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
-    bql_lock();
 
-    /* We hold the global BQL, so it is safe here */
+    bql_lock();
     colo_release_ram_cache();
+    bql_unlock();
 }
diff --git a/migration/migration.c b/migration/migration.c
index 38a584afae..728d02dbee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -491,6 +491,11 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    if (mis->have_recv_thread) {
+        qemu_thread_join(&mis->recv_thread);
+        mis->have_recv_thread = false;
+    }
+
     cpr_set_incoming_mode(MIG_MODE_NONE);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -861,30 +866,46 @@ static void process_incoming_migration_bh(void *opaque)
     migration_incoming_state_destroy();
 }
 
-static void coroutine_fn
-process_incoming_migration_co(void *opaque)
+static void migration_incoming_state_destroy_bh(void *opaque)
+{
+    struct MigrationIncomingState *mis = opaque;
+
+    migration_incoming_state_destroy();
+
+    if (mis->exit_on_error) {
+        /*
+         * NOTE: this exit() should better happen in the main thread, as
+         * the exit notifier may require BQL which can deadlock.  See
+         * commit e7bc0204e57836 for example.
+         */
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void *migration_incoming_thread(void *opaque)
 {
     MigrationState *s = migrate_get_current();
-    MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationIncomingState *mis = opaque;
     PostcopyState ps;
     int ret;
     Error *local_err = NULL;
 
+    rcu_register_thread();
+
     assert(mis->from_src_file);
+    assert(!bql_locked());
 
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
-    mis->loadvm_co = qemu_coroutine_self();
-    ret = qemu_loadvm_state(mis->from_src_file, true, &local_err);
-    mis->loadvm_co = NULL;
+    ret = qemu_loadvm_state(mis->from_src_file, false, &local_err);
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
     ps = postcopy_state_get();
-    trace_process_incoming_migration_co_end(ret, ps);
+    trace_process_incoming_migration_end(ret, ps);
     if (ps != POSTCOPY_INCOMING_NONE) {
         if (ps == POSTCOPY_INCOMING_ADVISE) {
             /*
@@ -898,7 +919,7 @@ process_incoming_migration_co(void *opaque)
              * Postcopy was started, cleanup should happen at the end of the
              * postcopy thread.
              */
-            trace_process_incoming_migration_co_postcopy_end_main();
+            trace_process_incoming_migration_postcopy_end_main();
             goto out;
         }
         /* Else if something went wrong then just fall out of the normal exit */
@@ -911,8 +932,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (migration_incoming_colo_enabled()) {
-        /* yield until COLO exit */
-        colo_incoming_co();
+        /* wait until COLO exits */
+        colo_incoming_wait();
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
@@ -924,28 +945,22 @@ fail:
     migrate_set_error(s, local_err);
     error_free(local_err);
 
-    migration_incoming_state_destroy();
+    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+        error_report_err(s->error);
+        s->error = NULL;
+    }
 
-    if (mis->exit_on_error) {
-        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
-            s->error = NULL;
-        }
+    /*
+     * There's some step of the destroy process that will need to happen in
+     * the main thread (e.g. joining this thread itself).  Leave to a BH.
+     */
+    migration_bh_schedule(migration_incoming_state_destroy_bh, (void *)mis);
 
-        exit(EXIT_FAILURE);
-    } else {
-        /*
-         * Report the error here in case that QEMU abruptly exits
-         * when postcopy is enabled.
-         */
-        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
-            s->error = NULL;
-        }
-    }
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
     migrate_incoming_unref_outgoing_state();
+    rcu_unregister_thread();
+    return NULL;
 }
 
 /**
@@ -963,8 +978,12 @@ static void migration_incoming_setup(QEMUFile *f)
 
 void migration_incoming_process(void)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
-    qemu_coroutine_enter(co);
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    mis->have_recv_thread = true;
+    qemu_thread_create(&mis->recv_thread, "mig/dst/main",
+                       migration_incoming_thread, mis,
+                       QEMU_THREAD_JOINABLE);
 }
 
 /* Returns true if recovered from a paused migration, otherwise false */
diff --git a/migration/rdma.c b/migration/rdma.c
index 0e5e02cdca..3389f6448b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3051,37 +3051,6 @@ int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
 static void rdma_accept_incoming_migration(void *opaque);
 
-static void rdma_cm_poll_handler(void *opaque)
-{
-    RDMAContext *rdma = opaque;
-    struct rdma_cm_event *cm_event;
-    MigrationIncomingState *mis = migration_incoming_get_current();
-
-    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
-        error_report("get_cm_event failed %d", errno);
-        return;
-    }
-
-    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
-        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
-        if (!rdma->errored &&
-            migration_incoming_get_current()->state !=
-              MIGRATION_STATUS_COMPLETED) {
-            error_report("receive cm event, cm event is %d", cm_event->event);
-            rdma->errored = true;
-            if (rdma->return_path) {
-                rdma->return_path->errored = true;
-            }
-        }
-        rdma_ack_cm_event(cm_event);
-        if (mis->loadvm_co) {
-            qemu_coroutine_enter(mis->loadvm_co);
-        }
-        return;
-    }
-    rdma_ack_cm_event(cm_event);
-}
-
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
     Error *err = NULL;
@@ -3199,8 +3168,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
     } else {
-        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
-                            NULL, rdma);
+        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
     }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
diff --git a/migration/savevm.c b/migration/savevm.c
index 44aadc2f51..991f46593c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2118,7 +2118,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, true, &local_err);
+    load_res = qemu_loadvm_state_main(f, mis, false, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2415,11 +2415,11 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Immediately following this command is a blob of data containing an embedded
  * chunk of migration stream; read it and load it.
  *
- * @mis: Incoming state
- * @length: Length of packaged data to read
+ * @mis:      Incoming state
+ * @bql_held: Whether BQL is held already
+ * @errp:     The Error** to set when returning failures.
  *
  * Returns: Negative values on error
- *
  */
 static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
                                       bool bql_held, Error **errp)
diff --git a/migration/trace-events b/migration/trace-events
index e8edd1fbba..2b7b522e73 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -193,8 +193,8 @@ source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
-process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-process_incoming_migration_co_postcopy_end_main(void) ""
+process_incoming_migration_end(int ret, int ps) "ret=%d postcopy-state=%d"
+process_incoming_migration_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 
-- 
2.50.1


