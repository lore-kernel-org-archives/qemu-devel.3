Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCD5D65551
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 19:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG1Ff-0005th-5r; Tue, 26 Nov 2024 14:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tG1Fd-0005tU-29
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tG1Fb-0000Qr-BK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732649369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y2Nrjz4SfdaTrUA69z/4Kw/PfJutBZrDgvFnECAeDuc=;
 b=jJTQflol3yy5cl07XHprCvu0ErucKIzNC22CVRPkQYRl3+WfkSE3gymItH0s5vQ5+E9p3d
 CfkjAWByukTVClp7vU1IBsxFYNG2wi4VsdW56iRInwjwIHbWqSZvAnuPgSrSMneCr/p+gO
 3hLPsagWLUNEbnXQYiARUZvKcmITF/c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-cQl3grplOS-Ck2ubxZhwag-1; Tue, 26 Nov 2024 14:29:27 -0500
X-MC-Unique: cQl3grplOS-Ck2ubxZhwag-1
X-Mimecast-MFC-AGG-ID: cQl3grplOS-Ck2ubxZhwag
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b66df452faso11935885a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 11:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732649367; x=1733254167;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2Nrjz4SfdaTrUA69z/4Kw/PfJutBZrDgvFnECAeDuc=;
 b=QiIXGnVMmve4QIw7OoLYGHGhbQm9JaFxsARQHLC8i1cg0usPQUWz4dYDEl5A7b+42H
 gRVgm38uwxYX8EdF8afwinqSplmhqqur70fn2hlOX/TuK1vXsq0vqYhiXtSlwivkfYuM
 ixiXrtp7vonTFUuIYmzZM1Sf7lcrc8rzpXZQr+Mv4u2vC5CAomycpwY8HGUz9Lv7tlzU
 hwS7p0AWcQP0r+OElWRj06xzwpHwY2CwZ3gl6OJDjcxev+JwRSNGQr3NSUECOqY1foHN
 ftnrR/zO+zq/wApAn32T+j9zRyY0TJ0p30YcL2Cz/MviQRCItW9gbEyK//FBWEkpQR/A
 QgZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX574SARU5GWUbU5RHwQbNPApLhbeEaf1cmrDxWmzEoRX0eDXOQLAZkbLj/yz6sHqj2PowHADD70+Uf@nongnu.org
X-Gm-Message-State: AOJu0Yw40jb7uJ/X1q38SmIbgACdI6iQFKlpog/4ygrjQ3+ePjFErgGu
 huLG8ciV2w5YKxDk/QkC5Vl5JWKPDKzqxrXvrRtQeWVmjCT/GNe/rt4LmA18Azm6t7Kk9jbWGD4
 uNlqMRjKw2/4kFiQqW1hHEmGhIE5eNNyRNKKpHAOXDnb7iJzml3IP
X-Gm-Gg: ASbGncsPRnOXANPQMt8d2bFXenpR0fvHbGFxDERltiCvD4nTYWPpYFCZpr+rQwyftje
 352QbT0r/3otPieN9oMMRhsk52i+A98SMKkmJ/3aEIAw9MFOnCfR/vtJIWyZT50JOg9gKHP3H21
 vBxF9SP4P9TiUo86OfEmTNgpdyCkan6SSVHP1zYVF7cdT+XEwRVqT5QLALewQfPOJRAlHWC1L+G
 E/wMztwB9C/tfMnivTNMSrXEr+oBFViIHqMkjw8k7PMZ3gL56ufot/HET2hcsoP2x90XWQGKOCc
 xnoK+kI3es9R
X-Received: by 2002:a05:620a:1724:b0:7b6:6fb4:2967 with SMTP id
 af79cd13be357-7b67c4b3ba3mr84974585a.10.1732649366739; 
 Tue, 26 Nov 2024 11:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiZog2CM6GvKzkY48H2wKErQjCNC85tTEla0k5EHfn8HdC2Wa6inYR+o/oYZldfqiaCK8Gbw==
X-Received: by 2002:a05:620a:1724:b0:7b6:6fb4:2967 with SMTP id
 af79cd13be357-7b67c4b3ba3mr84970585a.10.1732649366424; 
 Tue, 26 Nov 2024 11:29:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513fa5e78sm496383985a.37.2024.11.26.11.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 11:29:25 -0800 (PST)
Message-ID: <455d1074-28b7-4b0b-9c67-6f6425cbf384@redhat.com>
Date: Tue, 26 Nov 2024 20:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/17/24 20:19, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Migration code wants to manage device data sending threads in one place.
> 
> QEMU has an existing thread pool implementation, however it is limited
> to queuing AIO operations only and essentially has a 1:1 mapping between
> the current AioContext and the AIO ThreadPool in use.
> 
> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
> GThreadPool.
> 
> This brings a few new operations on a pool:
> * thread_pool_wait() operation waits until all the submitted work requests
> have finished.
> 
> * thread_pool_set_max_threads() explicitly sets the maximum thread count
> in the pool.
> 
> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
> in the pool to equal the number of still waiting in queue or unfinished work.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/block/thread-pool.h |   9 +++
>   util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 118 insertions(+)
> 
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 6f27eb085b45..3f9f66307b65 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>   void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>   
> +typedef struct ThreadPool ThreadPool;
> +
> +ThreadPool *thread_pool_new(void);
> +void thread_pool_free(ThreadPool *pool);
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy);
> +void thread_pool_wait(ThreadPool *pool);
> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);

We should add documentation for these routines.

>   #endif
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 908194dc070f..d80c4181c897 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>       qemu_mutex_destroy(&pool->lock);
>       g_free(pool);
>   }
> +
> +struct ThreadPool { /* type safety */
> +    GThreadPool *t;
> +    size_t unfinished_el_ctr;
> +    QemuMutex unfinished_el_ctr_mutex;
> +    QemuCond unfinished_el_ctr_zero_cond;
> +};


I find the naming of the attributes a little confusing. Could we
use names similar to ThreadPoolAio. Something like :

struct ThreadPool { /* type safety */
     GThreadPool *t;
     int cur_threads;
     QemuMutex lock;
     QemuCond finished_cond;
};



> +
> +typedef struct {
> +    ThreadPoolFunc *func;
> +    void *opaque;
> +    GDestroyNotify opaque_destroy;
> +} ThreadPoolElement;
> +
> +static void thread_pool_func(gpointer data, gpointer user_data)
> +{
> +    ThreadPool *pool = user_data;
> +    g_autofree ThreadPoolElement *el = data;
> +
> +    el->func(el->opaque);
> +
> +    if (el->opaque_destroy) {
> +        el->opaque_destroy(el->opaque);
> +    }
> +
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    assert(pool->unfinished_el_ctr > 0);
> +    pool->unfinished_el_ctr--;
> +
> +    if (pool->unfinished_el_ctr == 0) {
> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
> +    }
> +}
> +
> +ThreadPool *thread_pool_new(void)
> +{
> +    ThreadPool *pool = g_new(ThreadPool, 1);
> +
> +    pool->unfinished_el_ctr = 0;
> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
> +
> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
> +    /*
> +     * g_thread_pool_new() can only return errors if initial thread(s)
> +     * creation fails but we ask for 0 initial threads above.
> +     */
> +    assert(pool->t);
> +
> +    return pool;
> +}
> +
> +void thread_pool_free(ThreadPool *pool)
> +{
> +    g_thread_pool_free(pool->t, FALSE, TRUE);
> +
> +    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
> +    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
> +
> +    g_free(pool);
> +}
> +
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy)
> +{
> +    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);

Where are the ThreadPool elements freed ? I am missing something
may be.

Thanks,

C.


> +
> +    el->func = func;
> +    el->opaque = opaque;
> +    el->opaque_destroy = opaque_destroy;
> +
> +    WITH_QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex) {
> +        pool->unfinished_el_ctr++;
> +    }
> +
> +    /*
> +     * Ignore the return value since this function can only return errors
> +     * if creation of an additional thread fails but even in this case the
> +     * provided work is still getting queued (just for the existing threads).
> +     */
> +    g_thread_pool_push(pool->t, el, NULL);
> +}
> +
> +void thread_pool_wait(ThreadPool *pool)
> +{
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    if (pool->unfinished_el_ctr > 0) {
> +        qemu_cond_wait(&pool->unfinished_el_ctr_zero_cond,
> +                       &pool->unfinished_el_ctr_mutex);
> +        assert(pool->unfinished_el_ctr == 0);
> +    }
> +}
> +
> +bool thread_pool_set_max_threads(ThreadPool *pool,
> +                                 int max_threads)
> +{
> +    assert(max_threads > 0);
> +
> +    return g_thread_pool_set_max_threads(pool->t, max_threads, NULL);
> +}
> +
> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
> +{
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    return thread_pool_set_max_threads(pool, pool->unfinished_el_ctr);
> +}
> 


