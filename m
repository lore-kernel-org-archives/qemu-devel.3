Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaNt-0007vY-26; Tue, 04 Mar 2025 17:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNr-0007v1-5i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:03 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNp-0000LH-Be
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:02 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNl-00000000LWc-2Pyl; Tue, 04 Mar 2025 23:04:57 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 02/36] thread-pool: Remove thread_pool_submit() function
Date: Tue,  4 Mar 2025 23:03:29 +0100
Message-ID: <6830f07777f939edaf0a2d301c39adcaaf3817f0.1741124640.git.maciej.szmigiero@oracle.com>
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

This function name conflicts with one used by a future generic thread pool
function and it was only used by one test anyway.

Update the trace event name in thread_pool_submit_aio() accordingly.

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/block/thread-pool.h   | 3 +--
 tests/unit/test-thread-pool.c | 6 +++---
 util/thread-pool.c            | 7 +------
 util/trace-events             | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 948ff5f30c31..4f6694026123 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -30,13 +30,12 @@ ThreadPool *thread_pool_new(struct AioContext *ctx);
 void thread_pool_free(ThreadPool *pool);
 
 /*
- * thread_pool_submit* API: submit I/O requests in the thread's
+ * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
  * current AioContext.
  */
 BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
                                    BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
-void thread_pool_submit(ThreadPoolFunc *func, void *arg);
 
 void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
 
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index 1483e53473db..33407b595d35 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -43,10 +43,10 @@ static void done_cb(void *opaque, int ret)
     active--;
 }
 
-static void test_submit(void)
+static void test_submit_no_complete(void)
 {
     WorkerTestData data = { .n = 0 };
-    thread_pool_submit(worker_cb, &data);
+    thread_pool_submit_aio(worker_cb, &data, NULL, NULL);
     while (data.n == 0) {
         aio_poll(ctx, true);
     }
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
     ctx = qemu_get_current_aio_context();
 
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/thread-pool/submit", test_submit);
+    g_test_add_func("/thread-pool/submit-no-complete", test_submit_no_complete);
     g_test_add_func("/thread-pool/submit-aio", test_submit_aio);
     g_test_add_func("/thread-pool/submit-co", test_submit_co);
     g_test_add_func("/thread-pool/submit-many", test_submit_many);
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e855b..2f751d55b33f 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -256,7 +256,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
 
     QLIST_INSERT_HEAD(&pool->head, req, all);
 
-    trace_thread_pool_submit(pool, req, arg);
+    trace_thread_pool_submit_aio(pool, req, arg);
 
     qemu_mutex_lock(&pool->lock);
     if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
@@ -290,11 +290,6 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
     return tpc.ret;
 }
 
-void thread_pool_submit(ThreadPoolFunc *func, void *arg)
-{
-    thread_pool_submit_aio(func, arg, NULL, NULL);
-}
-
 void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
 {
     qemu_mutex_lock(&pool->lock);
diff --git a/util/trace-events b/util/trace-events
index 49a4962e1886..5be12d7fab89 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -14,7 +14,7 @@ aio_co_schedule_bh_cb(void *ctx, void *co) "ctx %p co %p"
 reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
 
 # thread-pool.c
-thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
+thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
 thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
 thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
 

