Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C158C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaXP-00008r-1y; Thu, 15 Aug 2024 09:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaXH-0008Ps-Fe
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:29:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaXE-0003u7-VJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:29:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201fae21398so2151405ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723728539; x=1724333339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onp9iwqOkfWmTyR8umXU9RcHfvuhLdQDaaGpxll+L5g=;
 b=kn0uy7dkt4RZg4X4WqDGyuKLIqJAJH546yLhCb6HBaSJmVh8M2VIh2cN/hJcSby8FP
 MJi1uF2TdwjWB09X1dZWafw3/CRclMIxTR2Vv5kBI84p4/pI7PEc0LemnXEpri0oIblF
 41J1Cs6hY3lzq+NAfE1aJoUV78RQYUXMGoe13NcSy4wNl0Rekxmt3M9U89cEKC89lzIi
 +M6GzL4K83M6T9OjQqoiNGR8yDpd7jnWIjJPGi3Wlozl3ugYVnza0bMqELmz+dsVegAF
 D2YK+Gjetjv16SkqZ7mSSjgHZ9DMDGFRwNP+Fq4MV0Eg2uv88nVc7MKqSA+ZRL3VTS4s
 Y9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723728539; x=1724333339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onp9iwqOkfWmTyR8umXU9RcHfvuhLdQDaaGpxll+L5g=;
 b=g2Nqt6qKJBHuBuLXq1w5Qsg07fiEofc6hsE7Cx9D8qEimWTy5e/GWfH5ljCfzsM6zW
 WtZ1MzC0uJYOuAIOGYDTvHfPJ5i1ZzvK6XhRv5xXet08PL9+Ba3pzIv7q2SxRdGWG7KD
 Zaw+gYj26FH0eaZ9nKn34kf9eJvUmwGETnBv2pkGTtYlgwVzN8Sd8wDKSQsIwtKPNKJg
 UBvrYmT4gkHpiPmEDRPEUM7yjGau2JBw6I9ddIeFNMdIjatpi0WYZKT+eb2IfKmI/YMk
 GmPjYL//4DOfhE+iqSK3KddH9iZAUcU3LbGYjHLXIMyulU5tcKDtIQPTspoCzrawZMvS
 oUrQ==
X-Gm-Message-State: AOJu0YwGZOFyaJuv/BMzY6/qx3BCsR94PP+Zz+OobzvHndsXK7Eqw3Ai
 HttR9fWm2uYqDtBojj1Fc9JxrnT9y8UsYaadoptV3cTpG6kkPi2iWnUb7yQe
X-Google-Smtp-Source: AGHT+IGEjmwiU0dqDS0OPhKr4Htl7dvLzyyvIDHGCXoBfa88PUwRj8vyj0+wJfN/pS9Qj4CKot9VtA==
X-Received: by 2002:a17:903:22cb:b0:1fb:8a61:12b0 with SMTP id
 d9443c01a7336-201d64e82dbmr75199775ad.54.1723728539036; 
 Thu, 15 Aug 2024 06:28:59 -0700 (PDT)
Received: from wheely.local0.net (219-90-179-190.ip.adam.com.au.
 [219.90.179.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038b455sm10014055ad.214.2024.08.15.06.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:28:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 2/2] async: add debugging assertions for record/replay in
 bh APIs
Date: Thu, 15 Aug 2024 23:28:37 +1000
Message-ID: <20240815132838.615330-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815132838.615330-1-npiggin@gmail.com>
References: <20240815132838.615330-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001,
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

Code using old bh APIs should be updated to account for whether the
bh is related to the target machine model or host QEMU operation,
for record/replay to work properly.

Add some assertions in the old APIs to catch unconverted code when
record/replay is active. Some of the bh APIs like cancel and delete
also don't seem to be implemented in the replay-event driver, so
try to catch these being used too.

This fixes one bug in IDE code that was caught by the assertions.
That fixes the x86-64 q35 non-virtio record/replay avocado test for
me, so not entirely academic.
---
 include/block/aio.h                |  2 +-
 block.c                            |  4 +++-
 hw/ide/core.c                      |  2 +-
 hw/scsi/scsi-bus.c                 |  6 +++---
 monitor/monitor.c                  |  2 +-
 monitor/qmp.c                      |  5 +++--
 qapi/qmp-dispatch.c                |  4 ++--
 replay/replay-events.c             | 25 +++++++++++--------------
 util/aio-wait.c                    |  2 +-
 util/async.c                       | 23 ++++++++++++++++++++++-
 util/main-loop.c                   |  2 +-
 util/thread-pool.c                 |  8 ++++----
 scripts/block-coroutine-wrapper.py |  2 +-
 13 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 23c5543506..b877c6070d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -308,7 +308,7 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
  */
 #define aio_bh_schedule_oneshot(ctx, cb, opaque) \
     aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)), \
-                                 QEMU_CLOCK_REALTIME)
+                                 QEMU_CLOCK_MAX)
 
 /**
  * aio_bh_new_full: Allocate a new bottom half structure.
diff --git a/block.c b/block.c
index c317de9eaa..67c88e8c68 100644
--- a/block.c
+++ b/block.c
@@ -7144,7 +7144,9 @@ void bdrv_schedule_unref(BlockDriverState *bs)
     if (!bs) {
         return;
     }
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), bdrv_schedule_unref_bh, bs);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  bdrv_schedule_unref_bh, bs,
+                                  QEMU_CLOCK_REALTIME);
 }
 
 struct BdrvOpBlocker {
diff --git a/hw/ide/core.c b/hw/ide/core.c
index fa7fee61d9..ee77200f77 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2780,7 +2780,7 @@ static void ide_restart_cb(void *opaque, bool running, RunState state)
 
     if (!bus->bh) {
         bus->bh = qemu_bh_new(ide_restart_bh, bus);
-        qemu_bh_schedule(bus->bh);
+        qemu_bh_schedule_event(bus->bh, QEMU_CLOCK_VIRTUAL);
     }
 }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 53eff5dd3d..ef36f12031 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -166,9 +166,9 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
 
     /* Paired with blk_dec_in_flight() in scsi_device_for_each_req_async_bh() */
     blk_inc_in_flight(s->conf.blk);
-    aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
-                            scsi_device_for_each_req_async_bh,
-                            data);
+    aio_bh_schedule_oneshot_event(blk_get_aio_context(s->conf.blk),
+                                  scsi_device_for_each_req_async_bh,
+                                  data, QEMU_CLOCK_REALTIME);
 }
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
diff --git a/monitor/monitor.c b/monitor/monitor.c
index db52a9c7ef..eae4d4e7f4 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -580,7 +580,7 @@ void monitor_resume(Monitor *mon)
             ctx = qemu_get_aio_context();
         }
 
-        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
+        aio_bh_schedule_oneshot_event(ctx, monitor_accept_input, mon, QEMU_CLOCK_REALTIME);
     }
 
     trace_monitor_suspend(mon, -1);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5e538f34c0..c6fec04860 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -541,8 +541,9 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
-                                monitor_qmp_setup_handlers_bh, mon);
+        aio_bh_schedule_oneshot_event(iothread_get_aio_context(mon_iothread),
+                                      monitor_qmp_setup_handlers_bh, mon,
+                                      QEMU_CLOCK_REALTIME);
         /* The bottom half will add @mon to @mon_list */
     } else {
         qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 176b549473..cd46a0830c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -254,8 +254,8 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
             .errp       = &err,
             .co         = qemu_coroutine_self(),
         };
-        aio_bh_schedule_oneshot(iohandler_get_aio_context(), do_qmp_dispatch_bh,
-                                &data);
+        aio_bh_schedule_oneshot_event(iohandler_get_aio_context(), do_qmp_dispatch_bh,
+                                &data, QEMU_CLOCK_REALTIME);
         qemu_coroutine_yield();
     }
     qobject_unref(args);
diff --git a/replay/replay-events.c b/replay/replay-events.c
index af0721cc1a..5ac974fcac 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -132,23 +132,17 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
 void replay_bh_schedule_event(QEMUBH *bh)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
-    } else {
-        qemu_bh_schedule(bh);
-    }
+    uint64_t id = replay_get_current_icount();
+    assert(events_enabled);
+    replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
 }
 
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
+void replay_bh_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
-    } else {
-        aio_bh_schedule_oneshot(ctx, cb, opaque);
-    }
+    uint64_t id = replay_get_current_icount();
+    assert(events_enabled);
+    replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
 }
 
 void replay_add_input_event(struct InputEvent *event)
@@ -166,7 +160,10 @@ void replay_block_event(QEMUBH *bh, uint64_t id)
     if (events_enabled) {
         replay_add_event(REPLAY_ASYNC_EVENT_BLOCK, bh, NULL, id);
     } else {
-        qemu_bh_schedule(bh);
+        /*
+         * Block can be used before events come up.
+         */
+        qemu_bh_schedule_event(bh, QEMU_CLOCK_REALTIME);
     }
 }
 
diff --git a/util/aio-wait.c b/util/aio-wait.c
index b5336cf5fd..32298d41b2 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -51,7 +51,7 @@ void aio_wait_kick(void)
     smp_mb();
 
     if (qatomic_read(&global_aio_wait.num_waiters)) {
-        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
+        aio_bh_schedule_oneshot_event(qemu_get_aio_context(), dummy_bh_cb, NULL, QEMU_CLOCK_REALTIME);
     }
 }
 
diff --git a/util/async.c b/util/async.c
index 97ed40048d..6893609d8c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -57,6 +57,9 @@ enum {
 
     /* Schedule periodically when the event loop is idle */
     BH_IDLE      = (1 << 4),
+
+    /* BH being handled by replay machinery */
+    BH_REPLAY    = (1 << 4),
 };
 
 struct QEMUBH {
@@ -144,6 +147,10 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
                                   void *opaque, const char *name,
                                   QEMUClockType clock_type)
 {
+    if (clock_type == QEMU_CLOCK_MAX) {
+        assert(replay_mode == REPLAY_MODE_NONE);
+        clock_type = QEMU_CLOCK_REALTIME;
+    }
     switch (clock_type) {
     case QEMU_CLOCK_VIRTUAL:
     case QEMU_CLOCK_VIRTUAL_RT:
@@ -177,6 +184,12 @@ void aio_bh_call(QEMUBH *bh)
 {
     bool last_engaged_in_io = false;
 
+    if (bh->flags & BH_REPLAY) {
+        assert(!(bh->flags & BH_SCHEDULED));
+        assert(!(bh->flags & BH_DELETED));
+        assert(!(bh->flags & BH_PENDING));
+        bh->flags &= ~BH_REPLAY;
+    }
     /* Make a copy of the guard-pointer as cb may free the bh */
     MemReentrancyGuard *reentrancy_guard = bh->reentrancy_guard;
     if (reentrancy_guard) {
@@ -263,11 +276,15 @@ void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type)
 
 void qemu_bh_schedule_idle(QEMUBH *bh)
 {
+    /* No mechanism for scheduling idle replay-scheduled bh at the moment */
+    assert(replay_mode == REPLAY_MODE_NONE);
     aio_bh_enqueue(bh, BH_SCHEDULED | BH_IDLE);
 }
 
 void qemu_bh_schedule(QEMUBH *bh)
 {
+    /* Callers should be converted to use qemu_bh_schedule_event */
+    assert(replay_mode == REPLAY_MODE_NONE);
     aio_bh_enqueue(bh, BH_SCHEDULED);
 }
 
@@ -275,6 +292,8 @@ void qemu_bh_schedule(QEMUBH *bh)
  */
 void qemu_bh_cancel(QEMUBH *bh)
 {
+    /* No mechanism for canceling replay-scheduled bh at the moment */
+    assert(!(bh->flags & BH_REPLAY));
     qatomic_and(&bh->flags, ~BH_SCHEDULED);
 }
 
@@ -283,6 +302,8 @@ void qemu_bh_cancel(QEMUBH *bh)
  */
 void qemu_bh_delete(QEMUBH *bh)
 {
+    /* No mechanism for deleting replay-scheduled bh at the moment */
+    assert(!(bh->flags & BH_REPLAY));
     aio_bh_enqueue(bh, BH_DELETED);
 }
 
@@ -683,7 +704,7 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
 
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
-    qemu_bh_schedule(ctx->co_schedule_bh);
+    qemu_bh_schedule_event(ctx->co_schedule_bh, QEMU_CLOCK_REALTIME);
 
     aio_context_unref(ctx);
 }
diff --git a/util/main-loop.c b/util/main-loop.c
index a0386cfeb6..6180a183f5 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -148,7 +148,7 @@ void qemu_notify_event(void)
     if (!qemu_aio_context) {
         return;
     }
-    qemu_bh_schedule(qemu_notify_bh);
+    qemu_bh_schedule_event(qemu_notify_bh, QEMU_CLOCK_REALTIME);
 }
 
 static GArray *gpollfds;
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e85..010eb4ad9a 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -115,7 +115,7 @@ static void *worker_thread(void *opaque)
         smp_wmb();
         req->state = THREAD_DONE;
 
-        qemu_bh_schedule(pool->completion_bh);
+        qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
         qemu_mutex_lock(&pool->lock);
     }
 
@@ -167,7 +167,7 @@ static void spawn_thread(ThreadPool *pool)
      * inherit the correct affinity instead of the vcpu affinity.
      */
     if (!pool->pending_threads) {
-        qemu_bh_schedule(pool->new_thread_bh);
+        qemu_bh_schedule_event(pool->new_thread_bh, QEMU_CLOCK_REALTIME);
     }
 }
 
@@ -195,7 +195,7 @@ restart:
             /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
              * wait for another request that completed at the same time.
              */
-            qemu_bh_schedule(pool->completion_bh);
+            qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
 
             elem->common.cb(elem->common.opaque, elem->ret);
 
@@ -225,7 +225,7 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     QEMU_LOCK_GUARD(&pool->lock);
     if (elem->state == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
-        qemu_bh_schedule(pool->completion_bh);
+        qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
 
         elem->state = THREAD_DONE;
         elem->ret = -ECANCELED;
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39..f28e7b9200 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -292,7 +292,7 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
     }};
     assert(qemu_in_coroutine());
 
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), {name}_bh, &s);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(), {name}_bh, &s, QEMU_CLOCK_REALTIME);
     qemu_coroutine_yield();
 
     {func.ret}
-- 
2.45.2


