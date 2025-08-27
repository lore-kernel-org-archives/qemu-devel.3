Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44D3CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFx-0006qT-Cp; Wed, 27 Aug 2025 17:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFd-0006ix-Dz
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFX-0006rF-Gn
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=282FDB8FZ2OxZDBvgsY7roTey3+zXO4yp0CLMrwMEn0=;
 b=MwcNJb6xzINS/+KzJGlHcWSiaBeEXeLrA1yGZQ3o/NVIkhQATfngvXiFS2GMhEsdxXXfPx
 dy3/IdRYuIApmwffdFXZNUTzs03B7seE/VswleAdyDnXMlP0PxhYDlvQrI2h2fffHDlYod
 xkCgQ5jcwN0TELp20bbAmGfnuwrMVfg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-9W0XBszLO6eZEMwAdrNyoQ-1; Wed, 27 Aug 2025 17:00:02 -0400
X-MC-Unique: 9W0XBszLO6eZEMwAdrNyoQ-1
X-Mimecast-MFC-AGG-ID: 9W0XBszLO6eZEMwAdrNyoQ_1756328402
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e951ec54a4dso275375276.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328402; x=1756933202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=282FDB8FZ2OxZDBvgsY7roTey3+zXO4yp0CLMrwMEn0=;
 b=GFiK1YEIDiTRl0NPehaTdj2E9Qcb4ZlzxBX8tw9/EkanczbDngQOmjfAtVo/IJBL1U
 Ea9kpdKvkEsr/q0EOxwtK34BO5zah3N3dRQkq6uCfZzWQ/p3Zh7Ebdw8y9oOcCRiyiUj
 kVpIVA1fVDVIhB4aAr9zlZlwjIrc/XbJ8sBGDRtmy6aqdNB1nv0sHLONq9anASUIx7x+
 pqiddYwOGYhybonDLlB3MZS4rkW5ZJZrST2Qc7aVqWUsZ8egH3/d67Ng/Nh/9U8nfyVF
 ezZ46kL1sw/8uDJcdzdoMyFRug7Md4oZazfuiqf0pFkS6YS66X2/GNaXOf63/9P168fc
 kbag==
X-Gm-Message-State: AOJu0YxEq758chcXWB27qW3BjTGiZVB/NwWo/qqwa1ZvWv/QtMo53wzm
 MJzdEWGuwJ5QAlGcUZ4bhPTxASq1TSyfD6dWbRaA6ASqUnjDaIymQ5mUUOyDcM0E0Mm2xrn7PU3
 YnIYy0kypjSCKmd46bIaIUhtPS6KdmpMjmb70lam9VIwmXfhh81xHSrv43J6b16lNsQid42nDTM
 VmNqqeWW9cDevGVVacVVh1P2TDAfWBWbdteVZbDg==
X-Gm-Gg: ASbGncvsov5K/HIl7cRq99sXuEzCmGsCpz5b8My2ef94kkym/kKfRjgIuO2/c7ugmEJ
 7KL6v5c+u3uxUBmPX7NKgqeFU2lxtfT8Afphp8Mp+1nV9GNSWWTxAXcbYxWLorSLE+GL2uM7Cgi
 tTsub9t9UZLANdel8TsoGyw1deC+SfYn62TpzaIP+XEmyBliCXrSINSJ7C5M0Ym6zFTCqaugyDk
 4tmRkdOAtthGlNzrgYq2ff6lDSB+0XcblWyBBdWQJg9CQbJoNjtHUFmcKr41weCZ8l1CLuYXDpm
 J/3wlK/1PGGS5MlWVcgc5DmOdAqqIG8rjck3GBH1WFx5ZlS5ovBLBCGptL/QIhe1azbMpFSBR+t
 sDtT0VdzSK0hTqZ8SO2o=
X-Received: by 2002:a05:6902:725:b0:e96:f14a:6b59 with SMTP id
 3f1490d57ef6-e96f14a6fcfmr4642825276.20.1756328401363; 
 Wed, 27 Aug 2025 14:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVISFXAPzfChrftidGV71llgGZXY26gr4nvhJMEZiqx5Bo2hswQSY/+H6ftBbS7923L0y5FQ==
X-Received: by 2002:a05:6902:725:b0:e96:f14a:6b59 with SMTP id
 3f1490d57ef6-e96f14a6fcfmr4642760276.20.1756328400443; 
 Wed, 27 Aug 2025 14:00:00 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Date: Wed, 27 Aug 2025 16:59:44 -0400
Message-ID: <20250827205949.364606-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Quite a few things are needed to make it fly..

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
needed.

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
 migration/migration.h    | 52 ++++++++++++++++++++++++++------
 migration/savevm.h       |  5 ++--
 migration/channel.c      |  7 ++---
 migration/colo-stubs.c   |  2 +-
 migration/colo.c         | 23 ++++-----------
 migration/migration.c    | 62 ++++++++++++++++++++++++++++----------
 migration/rdma.c         |  5 ----
 migration/savevm.c       | 64 ++++++++++++++++++++++++----------------
 migration/trace-events   |  4 +--
 10 files changed, 142 insertions(+), 88 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae..bfb30eccf0 100644
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
index 01329bf824..c4a626eed4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,6 +42,44 @@
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
 
+/**
+ * WITH_BQL_HELD(): Run a task, making sure BQL is held
+ *
+ * @bql_held: Whether BQL is already held
+ * @task:     The task to run within BQL held
+ */
+#define  WITH_BQL_HELD(bql_held, task)          \
+    do {                                        \
+        if (!bql_held) {                        \
+            bql_lock();                         \
+        } else {                                \
+            assert(bql_locked());               \
+        }                                       \
+        task;                                   \
+        if (!bql_held) {                        \
+            bql_unlock();                       \
+        }                                       \
+    } while (0)
+
+/**
+ * WITHOUT_BQL_HELD(): Run a task, making sure BQL is released
+ *
+ * @bql_held: Whether BQL is already held
+ * @task:     The task to run making sure BQL released
+ */
+#define  WITHOUT_BQL_HELD(bql_held, task)       \
+    do {                                        \
+        if (bql_held) {                         \
+            bql_unlock();                       \
+        } else {                                \
+            assert(!bql_locked());              \
+        }                                       \
+        task;                                   \
+        if (bql_held) {                         \
+            bql_lock();                         \
+        }                                       \
+    } while (0)
+
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
 
@@ -119,6 +157,10 @@ struct MigrationIncomingState {
     bool           have_listen_thread;
     QemuThread     listen_thread;
 
+    /* Migration main recv thread */
+    bool           have_recv_thread;
+    QemuThread     recv_thread;
+
     /* For the kernel to send us notifications */
     int       userfault_fd;
     /* To notify the fault_thread to wake, e.g., when need to quit */
@@ -177,15 +219,7 @@ struct MigrationIncomingState {
 
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
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c7166..c07e14f61a 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,9 +64,10 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, bool bql_held);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           bool bql_held);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
diff --git a/migration/channel.c b/migration/channel.c
index a547b1fbfe..621f8a4a2a 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -136,11 +136,8 @@ int migration_channel_read_peek(QIOChannel *ioc,
         }
 
         /* 1ms sleep. */
-        if (qemu_in_coroutine()) {
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
-        } else {
-            g_usleep(1000);
-        }
+        assert(!qemu_in_coroutine());
+        g_usleep(1000);
     }
 
     return 0;
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
index e0f713c837..f5722d9d9d 100644
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
@@ -686,7 +681,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, true);
     bql_unlock();
 
     if (ret < 0) {
@@ -854,10 +849,8 @@ static void *colo_process_incoming_thread(void *opaque)
         goto out;
     }
     /*
-     * Note: the communication between Primary side and Secondary side
-     * should be sequential, we set the fd to unblocked in migration incoming
-     * coroutine, and here we are in the COLO incoming thread, so it is ok to
-     * set the fd back to blocked.
+     * Here we are in the COLO incoming thread, so it is ok to set the fd
+     * to blocked.
      */
     qemu_file_set_blocking(mis->from_src_file, true);
 
@@ -930,26 +923,20 @@ out:
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
 
     /* We hold the global BQL, so it is safe here */
     colo_release_ram_cache();
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..7e4d25b15c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -494,6 +494,11 @@ void migration_incoming_state_destroy(void)
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
@@ -864,30 +869,46 @@ static void process_incoming_migration_bh(void *opaque)
     migration_incoming_state_destroy();
 }
 
-static void coroutine_fn
-process_incoming_migration_co(void *opaque)
+static void migration_incoming_state_destroy_bh(void *opaque)
+{
+    struct MigrationIncomingState *mis = opaque;
+
+    if (mis->exit_on_error) {
+        /*
+         * NOTE: this exit() should better happen in the main thread, as
+         * the exit notifier may require BQL which can deadlock.  See
+         * commit e7bc0204e57836 for example.
+         */
+        exit(EXIT_FAILURE);
+    }
+
+    migration_incoming_state_destroy();
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
-    ret = qemu_loadvm_state(mis->from_src_file);
-    mis->loadvm_co = NULL;
+    ret = qemu_loadvm_state(mis->from_src_file, false);
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
     ps = postcopy_state_get();
-    trace_process_incoming_migration_co_end(ret, ps);
+    trace_process_incoming_migration_end(ret, ps);
     if (ps != POSTCOPY_INCOMING_NONE) {
         if (ps == POSTCOPY_INCOMING_ADVISE) {
             /*
@@ -901,7 +922,7 @@ process_incoming_migration_co(void *opaque)
              * Postcopy was started, cleanup should happen at the end of the
              * postcopy thread.
              */
-            trace_process_incoming_migration_co_postcopy_end_main();
+            trace_process_incoming_migration_postcopy_end_main();
             goto out;
         }
         /* Else if something went wrong then just fall out of the normal exit */
@@ -913,8 +934,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (migration_incoming_colo_enabled()) {
-        /* yield until COLO exit */
-        colo_incoming_co();
+        /* wait until COLO exits */
+        colo_incoming_wait();
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
@@ -926,19 +947,24 @@ fail:
     migrate_set_error(s, local_err);
     error_free(local_err);
 
-    migration_incoming_state_destroy();
-
     if (mis->exit_on_error) {
         WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
             error_report_err(s->error);
             s->error = NULL;
         }
-
-        exit(EXIT_FAILURE);
     }
+
+    /*
+     * There's some step of the destroy process that will need to happen in
+     * the main thread (e.g. joining this thread itself).  Leave to a BH.
+     */
+    migration_bh_schedule(migration_incoming_state_destroy_bh, (void *)mis);
+
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
     migrate_incoming_unref_outgoing_state();
+    rcu_unregister_thread();
+    return NULL;
 }
 
 /**
@@ -956,8 +982,12 @@ static void migration_incoming_setup(QEMUFile *f)
 
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
index bcd7aae2f2..2b995513aa 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3068,7 +3068,6 @@ static void rdma_cm_poll_handler(void *opaque)
 {
     RDMAContext *rdma = opaque;
     struct rdma_cm_event *cm_event;
-    MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
         error_report("get_cm_event failed %d", errno);
@@ -3087,10 +3086,6 @@ static void rdma_cm_poll_handler(void *opaque)
             }
         }
         rdma_ack_cm_event(cm_event);
-        if (mis->loadvm_co) {
-            qemu_coroutine_enter(mis->loadvm_co);
-        }
-        return;
     }
     rdma_ack_cm_event(cm_event);
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296a..ad606c5425 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -154,11 +154,10 @@ static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
 }
 
 static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
-                                         MigrationIncomingState *mis)
+                                         MigrationIncomingState *mis,
+                                         bool bql_held)
 {
-    bql_unlock(); /* Let load threads do work requiring BQL */
-    thread_pool_wait(mis->load_threads);
-    bql_lock();
+    WITHOUT_BQL_HELD(bql_held, thread_pool_wait(mis->load_threads));
 
     return !migrate_has_error(s);
 }
@@ -2091,14 +2090,11 @@ static void *postcopy_ram_listen_thread(void *opaque)
     trace_postcopy_ram_listen_thread_start();
 
     rcu_register_thread();
-    /*
-     * Because we're a thread and not a coroutine we can't yield
-     * in qemu_file, and thus we must be blocking now.
-     */
+    /* Because we're a thread, making sure to use blocking mode */
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, false);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2392,13 +2388,14 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Immediately following this command is a blob of data containing an embedded
  * chunk of migration stream; read it and load it.
  *
- * @mis: Incoming state
- * @length: Length of packaged data to read
+ * @mis:      Incoming state
+ * @bql_held: Whether BQL is held already
  *
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
+                                      bool bql_held)
 {
     int ret;
     size_t length;
@@ -2449,7 +2446,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, bql_held);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2539,7 +2536,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
  * LOADVM_QUIT All good, but exit the loop
  * <0          Error
  */
-static int loadvm_process_command(QEMUFile *f)
+static int loadvm_process_command(QEMUFile *f, bool bql_held)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     uint16_t cmd;
@@ -2609,7 +2606,7 @@ static int loadvm_process_command(QEMUFile *f)
         break;
 
     case MIG_CMD_PACKAGED:
-        return loadvm_handle_cmd_packaged(mis);
+        return loadvm_handle_cmd_packaged(mis, bql_held);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         return loadvm_postcopy_handle_advise(mis, len);
@@ -3028,7 +3025,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           bool bql_held)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3046,7 +3044,15 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            /*
+             * FULL should normally require BQL, e.g. during post_load()
+             * there can be memory region updates.  START may or may not
+             * require it, but just to keep it simple to always hold BQL
+             * for now.
+             */
+            WITH_BQL_HELD(
+                bql_held,
+                ret = qemu_loadvm_section_start_full(f, section_type));
             if (ret < 0) {
                 goto out;
             }
@@ -3059,7 +3065,11 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            /*
+             * Be careful; QEMU_VM_COMMAND can embed FULL sections, so it
+             * may internally need BQL.
+             */
+            ret = loadvm_process_command(f, bql_held);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3103,7 +3113,7 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f)
+int qemu_loadvm_state(QEMUFile *f, bool bql_held)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -3131,9 +3141,10 @@ int qemu_loadvm_state(QEMUFile *f)
         qemu_loadvm_state_switchover_ack_needed(mis);
     }
 
-    cpu_synchronize_all_pre_loadvm();
+    /* run_on_cpu() requires BQL */
+    WITH_BQL_HELD(bql_held, cpu_synchronize_all_pre_loadvm());
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, bql_held);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3149,7 +3160,7 @@ int qemu_loadvm_state(QEMUFile *f)
     /* When reaching here, it must be precopy */
     if (ret == 0) {
         if (migrate_has_error(migrate_get_current()) ||
-            !qemu_loadvm_thread_pool_wait(s, mis)) {
+            !qemu_loadvm_thread_pool_wait(s, mis, bql_held)) {
             ret = -EINVAL;
         } else {
             ret = qemu_file_get_error(f);
@@ -3196,7 +3207,8 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
-    cpu_synchronize_all_post_init();
+    /* run_on_cpu() requires BQL */
+    WITH_BQL_HELD(bql_held, cpu_synchronize_all_post_init());
 
     return ret;
 }
@@ -3207,7 +3219,7 @@ int qemu_load_device_state(QEMUFile *f)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, true);
     if (ret < 0) {
         error_report("Failed to load device state: %d", ret);
         return ret;
@@ -3438,7 +3450,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, true);
     qemu_fclose(f);
     if (ret < 0) {
         error_setg(errp, "loading Xen device state failed");
@@ -3512,7 +3524,7 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, true);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
diff --git a/migration/trace-events b/migration/trace-events
index 706db97def..eeb41e03f1 100644
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


