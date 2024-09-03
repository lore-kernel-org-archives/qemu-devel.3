Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2967ACD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slURV-0003yY-Sf; Tue, 03 Sep 2024 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1slURU-0003xw-EQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:23:36 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1slURR-0001xP-AJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:23:36 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4567f52bf69so28677351cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725373405; x=1725978205; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jX9zRqoTwU8AiPJxzzsVvbEGbksBbsQ50cwDOyeTFhg=;
 b=DmmaoWbW5ClZanP9HjkflFhenqevQGkssmbfvBWM4MH/m/8LuuzJKbhVxf4CmAH5Qx
 TLSETDG8lliSDSPT1OHUDuHvOR/VJKS52lN3CAbA0zYuTJjKCnouMj5rod0ZVis/wbjs
 7VSdNoN67A/d9+bKjqj03yupexBaP6JiUyIrSO3LAWNk+FSZWVIfpk8PW4QfAmgV6dPO
 IUHzpYEOZSRmwb/mCGl4NVabYR9iOwYSLULN7CjsApgUURswfItkHRh2BVBbqGnW08vp
 hMgCF35qXazKcRiiflII+76wW/gpIIrFuVd1JUt9t0zITXxLBtOxyvmHI2kB2xYyse8A
 CP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725373405; x=1725978205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jX9zRqoTwU8AiPJxzzsVvbEGbksBbsQ50cwDOyeTFhg=;
 b=Pp7n0lF18WGBYFr2NMxaOTGj027zXlywnVhWRTCIUs2gwZf6Se/rnys59lKIskyPmd
 9KMZarx6jYtJkjhff9CubeFxZ3L2M79MFlXIDVXAUO0QLVca36Gr/uBRU4s+nRPxiUi8
 e0YAS6MYntcRzGCiUQhAlPeaGZxpoAtnv+Z2A8ucs97uPGkSIhbqifFmDewhiTQ94eVi
 IzOGeWIoSdB5ByU3Rz5BYlcSzvH+Zml9ZpzgazmeFvQIahdxMjyrpWns4/uoi5yCbmvQ
 X/ApIAkYInzRcw2T7a5YgDhG7tIjeDV5TSU0OeNeDeXdOHrDcITCRoZtswHSLqW4X8Fa
 8/kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTZmEtMzdHpzxCIdsF6qAtLIxTM9jHkRU+HocYAZQn5RewbHYoGiymRfHSWZUsJgL+Z7G1iH3TevtP@nongnu.org
X-Gm-Message-State: AOJu0YydDvmTdqGoqda7tcdlHOGyI+t5oPn6VHkSINyGbnfomLzKXIBw
 mY1xjud0wgeZQzKy2qEywqFxd3WeIDehG+yc5/wloK9C2pNNx1mrr1yVXx0rd4vLykCglRL2RIM
 rUkho8X0f/QYcxPPdQUvNUrne1rWYqg==
X-Google-Smtp-Source: AGHT+IFRPD65kYubZFBGJkd++7PX9cVN/M4kiOlR1NufQLbi1XLcnv/fQ6QzAN8XOhANYMF9C8ygbk94+ZyjKy91y/k=
X-Received: by 2002:a05:6870:d8cf:b0:277:ef0f:cde4 with SMTP id
 586e51a60fabf-277ef0fe184mr7783648fac.46.1725371736488; Tue, 03 Sep 2024
 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
In-Reply-To: <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Sep 2024 09:55:24 -0400
Message-ID: <CAJSP0QU+dhh_e2LJRoGCxtCEh6C2-GBoZoFZL2W-SMSQPzUtYg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=stefanha@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 27 Aug 2024 at 13:58, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Migration code wants to manage device data sending threads in one place.
>
> QEMU has an existing thread pool implementation, however it was limited
> to queuing AIO operations only and essentially had a 1:1 mapping between
> the current AioContext and the ThreadPool in use.
>
> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
> too.
>
> This brings a few new operations on a pool:
> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
> thread count in the pool.
>
> * thread_pool_join() operation waits until all the submitted work requests
> have finished.
>
> * thread_pool_poll() lets the new thread and / or thread completion bottom
> halves run (if they are indeed scheduled to be run).
> It is useful for thread pool users that need to launch or terminate new
> threads without returning to the QEMU main loop.

Did you consider glib's GThreadPool?
https://docs.gtk.org/glib/struct.ThreadPool.html

QEMU's thread pool is integrated into the QEMU event loop. If your
goal is to bypass the QEMU event loop, then you may as well use the
glib API instead.

thread_pool_join() and thread_pool_poll() will lead to code that
blocks the event loop. QEMU's aio_poll() and nested event loops in
general are a source of hangs and re-entrancy bugs. I would prefer not
introducing these issues in the QEMU ThreadPool API.


>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/block/thread-pool.h   | 10 ++++-
>  tests/unit/test-thread-pool.c |  2 +-
>  util/thread-pool.c            | 77 ++++++++++++++++++++++++++++++-----
>  3 files changed, 76 insertions(+), 13 deletions(-)
>
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index b484c4780ea6..1769496056cd 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -37,9 +37,15 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>                                     void *arg, GDestroyNotify arg_destroy,
>                                     BlockCompletionFunc *cb, void *opaque);
>  int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
> -void thread_pool_submit(ThreadPoolFunc *func,
> -                        void *arg, GDestroyNotify arg_destroy);
> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                               void *arg, GDestroyNotify arg_destroy,
> +                               BlockCompletionFunc *cb, void *opaque);
>
> +void thread_pool_join(ThreadPool *pool);
> +void thread_pool_poll(ThreadPool *pool);
> +
> +void thread_pool_set_minmax_threads(ThreadPool *pool,
> +                                    int min_threads, int max_threads);
>  void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>
>  #endif
> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
> index e4afb9e36292..469c0f7057b6 100644
> --- a/tests/unit/test-thread-pool.c
> +++ b/tests/unit/test-thread-pool.c
> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>  static void test_submit(void)
>  {
>      WorkerTestData data = { .n = 0 };
> -    thread_pool_submit(worker_cb, &data, NULL);
> +    thread_pool_submit(NULL, worker_cb, &data, NULL, NULL, NULL);
>      while (data.n == 0) {
>          aio_poll(ctx, true);
>      }
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 69a87ee79252..2bf3be875a51 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -60,6 +60,7 @@ struct ThreadPool {
>      QemuMutex lock;
>      QemuCond worker_stopped;
>      QemuCond request_cond;
> +    QemuCond no_requests_cond;
>      QEMUBH *new_thread_bh;
>
>      /* The following variables are only accessed from one AioContext. */
> @@ -73,6 +74,7 @@ struct ThreadPool {
>      int pending_threads; /* threads created but not running yet */
>      int min_threads;
>      int max_threads;
> +    size_t requests_executing;
>  };
>
>  static void *worker_thread(void *opaque)
> @@ -107,6 +109,10 @@ static void *worker_thread(void *opaque)
>          req = QTAILQ_FIRST(&pool->request_list);
>          QTAILQ_REMOVE(&pool->request_list, req, reqs);
>          req->state = THREAD_ACTIVE;
> +
> +        assert(pool->requests_executing < SIZE_MAX);
> +        pool->requests_executing++;
> +
>          qemu_mutex_unlock(&pool->lock);
>
>          ret = req->func(req->arg);
> @@ -118,6 +124,14 @@ static void *worker_thread(void *opaque)
>
>          qemu_bh_schedule(pool->completion_bh);
>          qemu_mutex_lock(&pool->lock);
> +
> +        assert(pool->requests_executing > 0);
> +        pool->requests_executing--;
> +
> +        if (pool->requests_executing == 0 &&
> +            QTAILQ_EMPTY(&pool->request_list)) {
> +            qemu_cond_signal(&pool->no_requests_cond);
> +        }
>      }
>
>      pool->cur_threads--;
> @@ -243,13 +257,16 @@ static const AIOCBInfo thread_pool_aiocb_info = {
>      .cancel_async       = thread_pool_cancel,
>  };
>
> -BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
> -                                   void *arg, GDestroyNotify arg_destroy,
> -                                   BlockCompletionFunc *cb, void *opaque)
> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                               void *arg, GDestroyNotify arg_destroy,
> +                               BlockCompletionFunc *cb, void *opaque)
>  {
>      ThreadPoolElement *req;
>      AioContext *ctx = qemu_get_current_aio_context();
> -    ThreadPool *pool = aio_get_thread_pool(ctx);
> +
> +    if (!pool) {
> +        pool = aio_get_thread_pool(ctx);
> +    }
>
>      /* Assert that the thread submitting work is the same running the pool */
>      assert(pool->ctx == qemu_get_current_aio_context());
> @@ -275,6 +292,18 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>      return &req->common;
>  }
>
> +BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
> +                                   void *arg, GDestroyNotify arg_destroy,
> +                                   BlockCompletionFunc *cb, void *opaque)
> +{
> +    return thread_pool_submit(NULL, func, arg, arg_destroy, cb, opaque);
> +}
> +
> +void thread_pool_poll(ThreadPool *pool)
> +{
> +    aio_bh_poll(pool->ctx);
> +}
> +
>  typedef struct ThreadPoolCo {
>      Coroutine *co;
>      int ret;
> @@ -297,18 +326,38 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>      return tpc.ret;
>  }
>
> -void thread_pool_submit(ThreadPoolFunc *func,
> -                        void *arg, GDestroyNotify arg_destroy)
> +void thread_pool_join(ThreadPool *pool)
>  {
> -    thread_pool_submit_aio(func, arg, arg_destroy, NULL, NULL);
> +    /* Assert that the thread waiting is the same running the pool */
> +    assert(pool->ctx == qemu_get_current_aio_context());
> +
> +    qemu_mutex_lock(&pool->lock);
> +
> +    if (pool->requests_executing > 0 ||
> +        !QTAILQ_EMPTY(&pool->request_list)) {
> +        qemu_cond_wait(&pool->no_requests_cond, &pool->lock);
> +    }
> +    assert(pool->requests_executing == 0 &&
> +           QTAILQ_EMPTY(&pool->request_list));
> +
> +    qemu_mutex_unlock(&pool->lock);
> +
> +    aio_bh_poll(pool->ctx);
> +
> +    assert(QLIST_EMPTY(&pool->head));
>  }
>
> -void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
> +void thread_pool_set_minmax_threads(ThreadPool *pool,
> +                                    int min_threads, int max_threads)
>  {
> +    assert(min_threads >= 0);
> +    assert(max_threads > 0);
> +    assert(max_threads >= min_threads);
> +
>      qemu_mutex_lock(&pool->lock);
>
> -    pool->min_threads = ctx->thread_pool_min;
> -    pool->max_threads = ctx->thread_pool_max;
> +    pool->min_threads = min_threads;
> +    pool->max_threads = max_threads;
>
>      /*
>       * We either have to:
> @@ -330,6 +379,12 @@ void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
>      qemu_mutex_unlock(&pool->lock);
>  }
>
> +void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
> +{
> +    thread_pool_set_minmax_threads(pool,
> +                                   ctx->thread_pool_min, ctx->thread_pool_max);
> +}
> +
>  static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
>  {
>      if (!ctx) {
> @@ -342,6 +397,7 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
>      qemu_mutex_init(&pool->lock);
>      qemu_cond_init(&pool->worker_stopped);
>      qemu_cond_init(&pool->request_cond);
> +    qemu_cond_init(&pool->no_requests_cond);
>      pool->new_thread_bh = aio_bh_new(ctx, spawn_thread_bh_fn, pool);
>
>      QLIST_INIT(&pool->head);
> @@ -382,6 +438,7 @@ void thread_pool_free(ThreadPool *pool)
>      qemu_mutex_unlock(&pool->lock);
>
>      qemu_bh_delete(pool->completion_bh);
> +    qemu_cond_destroy(&pool->no_requests_cond);
>      qemu_cond_destroy(&pool->request_cond);
>      qemu_cond_destroy(&pool->worker_stopped);
>      qemu_mutex_destroy(&pool->lock);
>

