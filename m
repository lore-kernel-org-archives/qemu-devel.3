Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F094C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaNz-00081Q-At; Tue, 04 Mar 2025 17:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNx-0007zx-GA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:09 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNv-0000Yk-0c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:09 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNq-00000000LWm-2xET; Tue, 04 Mar 2025 23:05:02 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 03/36] thread-pool: Rename AIO pool functions to *_aio()
 and data types to *Aio
Date: Tue,  4 Mar 2025 23:03:30 +0100
Message-ID: <70f9e0fb4b01042258a1a57996c64d19779dc7f0.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

These names conflict with ones used by future generic thread pool
equivalents.
Generic names should belong to the generic pool type, not specific (AIO)
type.

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/block/aio.h         |  8 ++---
 include/block/thread-pool.h |  8 ++---
 util/async.c                |  6 ++--
 util/thread-pool.c          | 58 ++++++++++++++++++-------------------
 util/trace-events           |  4 +--
 5 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 43883a8a33a8..b2ab3514de23 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -54,7 +54,7 @@ typedef void QEMUBHFunc(void *opaque);
 typedef bool AioPollFn(void *opaque);
 typedef void IOHandler(void *opaque);
 
-struct ThreadPool;
+struct ThreadPoolAio;
 struct LinuxAioState;
 typedef struct LuringState LuringState;
 
@@ -207,7 +207,7 @@ struct AioContext {
     /* Thread pool for performing work and receiving completion callbacks.
      * Has its own locking.
      */
-    struct ThreadPool *thread_pool;
+    struct ThreadPoolAio *thread_pool;
 
 #ifdef CONFIG_LINUX_AIO
     struct LinuxAioState *linux_aio;
@@ -500,8 +500,8 @@ void aio_set_event_notifier_poll(AioContext *ctx,
  */
 GSource *aio_get_g_source(AioContext *ctx);
 
-/* Return the ThreadPool bound to this AioContext */
-struct ThreadPool *aio_get_thread_pool(AioContext *ctx);
+/* Return the ThreadPoolAio bound to this AioContext */
+struct ThreadPoolAio *aio_get_thread_pool(AioContext *ctx);
 
 /* Setup the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 4f6694026123..6f27eb085b45 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -24,10 +24,10 @@
 
 typedef int ThreadPoolFunc(void *opaque);
 
-typedef struct ThreadPool ThreadPool;
+typedef struct ThreadPoolAio ThreadPoolAio;
 
-ThreadPool *thread_pool_new(struct AioContext *ctx);
-void thread_pool_free(ThreadPool *pool);
+ThreadPoolAio *thread_pool_new_aio(struct AioContext *ctx);
+void thread_pool_free_aio(ThreadPoolAio *pool);
 
 /*
  * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
@@ -36,7 +36,7 @@ void thread_pool_free(ThreadPool *pool);
 BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
                                    BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
+void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
 
-void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
 
 #endif
diff --git a/util/async.c b/util/async.c
index 0fe29436090d..47e3d35a263f 100644
--- a/util/async.c
+++ b/util/async.c
@@ -369,7 +369,7 @@ aio_ctx_finalize(GSource     *source)
     QEMUBH *bh;
     unsigned flags;
 
-    thread_pool_free(ctx->thread_pool);
+    thread_pool_free_aio(ctx->thread_pool);
 
 #ifdef CONFIG_LINUX_AIO
     if (ctx->linux_aio) {
@@ -435,10 +435,10 @@ GSource *aio_get_g_source(AioContext *ctx)
     return &ctx->source;
 }
 
-ThreadPool *aio_get_thread_pool(AioContext *ctx)
+ThreadPoolAio *aio_get_thread_pool(AioContext *ctx)
 {
     if (!ctx->thread_pool) {
-        ctx->thread_pool = thread_pool_new(ctx);
+        ctx->thread_pool = thread_pool_new_aio(ctx);
     }
     return ctx->thread_pool;
 }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 2f751d55b33f..908194dc070f 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -23,9 +23,9 @@
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
 
-static void do_spawn_thread(ThreadPool *pool);
+static void do_spawn_thread(ThreadPoolAio *pool);
 
-typedef struct ThreadPoolElement ThreadPoolElement;
+typedef struct ThreadPoolElementAio ThreadPoolElementAio;
 
 enum ThreadState {
     THREAD_QUEUED,
@@ -33,9 +33,9 @@ enum ThreadState {
     THREAD_DONE,
 };
 
-struct ThreadPoolElement {
+struct ThreadPoolElementAio {
     BlockAIOCB common;
-    ThreadPool *pool;
+    ThreadPoolAio *pool;
     ThreadPoolFunc *func;
     void *arg;
 
@@ -47,13 +47,13 @@ struct ThreadPoolElement {
     int ret;
 
     /* Access to this list is protected by lock.  */
-    QTAILQ_ENTRY(ThreadPoolElement) reqs;
+    QTAILQ_ENTRY(ThreadPoolElementAio) reqs;
 
     /* This list is only written by the thread pool's mother thread.  */
-    QLIST_ENTRY(ThreadPoolElement) all;
+    QLIST_ENTRY(ThreadPoolElementAio) all;
 };
 
-struct ThreadPool {
+struct ThreadPoolAio {
     AioContext *ctx;
     QEMUBH *completion_bh;
     QemuMutex lock;
@@ -62,10 +62,10 @@ struct ThreadPool {
     QEMUBH *new_thread_bh;
 
     /* The following variables are only accessed from one AioContext. */
-    QLIST_HEAD(, ThreadPoolElement) head;
+    QLIST_HEAD(, ThreadPoolElementAio) head;
 
     /* The following variables are protected by lock.  */
-    QTAILQ_HEAD(, ThreadPoolElement) request_list;
+    QTAILQ_HEAD(, ThreadPoolElementAio) request_list;
     int cur_threads;
     int idle_threads;
     int new_threads;     /* backlog of threads we need to create */
@@ -76,14 +76,14 @@ struct ThreadPool {
 
 static void *worker_thread(void *opaque)
 {
-    ThreadPool *pool = opaque;
+    ThreadPoolAio *pool = opaque;
 
     qemu_mutex_lock(&pool->lock);
     pool->pending_threads--;
     do_spawn_thread(pool);
 
     while (pool->cur_threads <= pool->max_threads) {
-        ThreadPoolElement *req;
+        ThreadPoolElementAio *req;
         int ret;
 
         if (QTAILQ_EMPTY(&pool->request_list)) {
@@ -131,7 +131,7 @@ static void *worker_thread(void *opaque)
     return NULL;
 }
 
-static void do_spawn_thread(ThreadPool *pool)
+static void do_spawn_thread(ThreadPoolAio *pool)
 {
     QemuThread t;
 
@@ -148,14 +148,14 @@ static void do_spawn_thread(ThreadPool *pool)
 
 static void spawn_thread_bh_fn(void *opaque)
 {
-    ThreadPool *pool = opaque;
+    ThreadPoolAio *pool = opaque;
 
     qemu_mutex_lock(&pool->lock);
     do_spawn_thread(pool);
     qemu_mutex_unlock(&pool->lock);
 }
 
-static void spawn_thread(ThreadPool *pool)
+static void spawn_thread(ThreadPoolAio *pool)
 {
     pool->cur_threads++;
     pool->new_threads++;
@@ -173,8 +173,8 @@ static void spawn_thread(ThreadPool *pool)
 
 static void thread_pool_completion_bh(void *opaque)
 {
-    ThreadPool *pool = opaque;
-    ThreadPoolElement *elem, *next;
+    ThreadPoolAio *pool = opaque;
+    ThreadPoolElementAio *elem, *next;
 
     defer_call_begin(); /* cb() may use defer_call() to coalesce work */
 
@@ -184,8 +184,8 @@ restart:
             continue;
         }
 
-        trace_thread_pool_complete(pool, elem, elem->common.opaque,
-                                   elem->ret);
+        trace_thread_pool_complete_aio(pool, elem, elem->common.opaque,
+                                       elem->ret);
         QLIST_REMOVE(elem, all);
 
         if (elem->common.cb) {
@@ -217,10 +217,10 @@ restart:
 
 static void thread_pool_cancel(BlockAIOCB *acb)
 {
-    ThreadPoolElement *elem = (ThreadPoolElement *)acb;
-    ThreadPool *pool = elem->pool;
+    ThreadPoolElementAio *elem = (ThreadPoolElementAio *)acb;
+    ThreadPoolAio *pool = elem->pool;
 
-    trace_thread_pool_cancel(elem, elem->common.opaque);
+    trace_thread_pool_cancel_aio(elem, elem->common.opaque);
 
     QEMU_LOCK_GUARD(&pool->lock);
     if (elem->state == THREAD_QUEUED) {
@@ -234,16 +234,16 @@ static void thread_pool_cancel(BlockAIOCB *acb)
 }
 
 static const AIOCBInfo thread_pool_aiocb_info = {
-    .aiocb_size         = sizeof(ThreadPoolElement),
+    .aiocb_size         = sizeof(ThreadPoolElementAio),
     .cancel_async       = thread_pool_cancel,
 };
 
 BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
                                    BlockCompletionFunc *cb, void *opaque)
 {
-    ThreadPoolElement *req;
+    ThreadPoolElementAio *req;
     AioContext *ctx = qemu_get_current_aio_context();
-    ThreadPool *pool = aio_get_thread_pool(ctx);
+    ThreadPoolAio *pool = aio_get_thread_pool(ctx);
 
     /* Assert that the thread submitting work is the same running the pool */
     assert(pool->ctx == qemu_get_current_aio_context());
@@ -290,7 +290,7 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
     return tpc.ret;
 }
 
-void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
+void thread_pool_update_params(ThreadPoolAio *pool, AioContext *ctx)
 {
     qemu_mutex_lock(&pool->lock);
 
@@ -317,7 +317,7 @@ void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
     qemu_mutex_unlock(&pool->lock);
 }
 
-static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
+static void thread_pool_init_one(ThreadPoolAio *pool, AioContext *ctx)
 {
     if (!ctx) {
         ctx = qemu_get_aio_context();
@@ -337,14 +337,14 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
     thread_pool_update_params(pool, ctx);
 }
 
-ThreadPool *thread_pool_new(AioContext *ctx)
+ThreadPoolAio *thread_pool_new_aio(AioContext *ctx)
 {
-    ThreadPool *pool = g_new(ThreadPool, 1);
+    ThreadPoolAio *pool = g_new(ThreadPoolAio, 1);
     thread_pool_init_one(pool, ctx);
     return pool;
 }
 
-void thread_pool_free(ThreadPool *pool)
+void thread_pool_free_aio(ThreadPoolAio *pool)
 {
     if (!pool) {
         return;
diff --git a/util/trace-events b/util/trace-events
index 5be12d7fab89..bd8f25fb5920 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -15,8 +15,8 @@ reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
 
 # thread-pool.c
 thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
-thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
-thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
+thread_pool_complete_aio(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
+thread_pool_cancel_aio(void *req, void *opaque) "req %p opaque %p"
 
 # buffer.c
 buffer_resize(const char *buf, size_t olen, size_t len) "%s: old %zd, new %zd"

