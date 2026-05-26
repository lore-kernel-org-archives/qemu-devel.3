Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E20ACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyTM-00081S-6s; Tue, 26 May 2026 16:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRyTB-00080i-2v
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRyT8-0004rw-14
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779827619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXAB3Il+Ea2GNbDuAC+49QOwGTWllKgIRmAm9e07UGM=;
 b=Gn9kpYmOkjjt9B2bqaB7ZN0tevZj0CbqXDsRcxae186jVyYyEsZlLNF7J3gsPVDPqsPSO9
 owHRlpDOBCjMV87pXSgXewABCdVasQADhcUB1VEBxkpx4jmRkMb2b064orqs8JPptUFakH
 GbQPeAd87RBY26m29UsbtjXMbZ3IIpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-HLmvNHD0N8OXTgzW7ehHyQ-1; Tue, 26 May 2026 16:33:37 -0400
X-MC-Unique: HLmvNHD0N8OXTgzW7ehHyQ-1
X-Mimecast-MFC-AGG-ID: HLmvNHD0N8OXTgzW7ehHyQ_1779827617
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d51ffb59so12571521cf.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779827617; x=1780432417; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vXAB3Il+Ea2GNbDuAC+49QOwGTWllKgIRmAm9e07UGM=;
 b=I4awSQgiTwh8w7ScpMwHtBZx/96QClLwBbYamQnsV2Doee8+u4wmSjpEbSPh4JJKs5
 rthALDk/VA/j/XagbVyTqWzHOSW3jVmCYJTLf2P5dW/wk4ivIFcVUL2LXu3xFb9e+BMu
 wggwKJhY3wIruDujXuNorY7yZHV+LC60BYukAT9afTm5FqI69jQkXobx1O0SXP8M8Wsy
 68BTywsr22u5WMcNf6iGtpB6MOtMPh3xwqNq8iqTqPEve1DH60Su8fp1x2ZRys6cBiWC
 c8XtKQoxRcXl17Y6zXwWO6SL4vn/V2CaJZo95G+6rBzZKRpeLKC4e+XHv31OcvdHUonB
 xzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827617; x=1780432417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXAB3Il+Ea2GNbDuAC+49QOwGTWllKgIRmAm9e07UGM=;
 b=en7XiVdsTlku/wclruo4X7LTPFjZzH7o/VvEGa1cAZQC9bsneeq/LlChQehTePxyl2
 gWRgEoDfIEgwKMCc1Z4MT+AKZsSaHij/jbqRjDReezCG/anlqedoyWVoR6kv0f0npQzm
 /3mSVjrEVDb5itz3+Bu1sw5CKW6Y09iRkP0FB+8VVqCaOe64SYUKyNKUuqbg8019R6xu
 s8vFlorlHTxTRlTd2HpYX7J0GwmRueY2MSl/5RM+OOziFTBheTu3ZR7C2OxurJNUTFIx
 DBZSSbUVhy3AoxLh/hpgU1pe3kTJ7WYlgNbGwoJahFUOtp+P0jnXz50AJzXsVPN127/A
 R3og==
X-Forwarded-Encrypted: i=1;
 AFNElJ8n0kYE+xdjhiXpeB2kZVwSBm9h75GOdqCkqGh+hqG+9fpALIVM00L/Z4iUEs2XHV3obqyrWrb8wzG+@nongnu.org
X-Gm-Message-State: AOJu0YxnvCwikB+WqhpW41MBZVU7sWlH8OjbUj28wuuLoL7NAHmB9v2t
 hM7k5FSwOX98urE/4aRdrQyehcWTmhNQdB+u93/k47gB3Fi7WnU+262FJFp7MNcVwc49DEynP1R
 bXbPUAnXzAj/LjSz9mm+j0Nnycr6K1eMgbVduxrVg9CBq5pRSaQ31oqjM
X-Gm-Gg: Acq92OGaNwtBDVYSBB4h/ZMKCWPv/Ue7vZmvV/j8wyoTed9Sug18vNFOOkv0atZXt9b
 76VHXHDuJwnuuS8dwKVOFsT/0qq8nkl1Hhkg0TQ6w2AysVN8YGmW3IpfwGVcfwYeVp7luG80TmJ
 3UMkEp0uBipCUBELWRXKb+oZGP2PTcafT1z0zGZ5mIBy469rnf6F5SDZ9bY36PPN48uQ+uRSL3f
 WJkiVCQrYjqyJeEA6cKNp1kkNjbhnc5UTsg12MBPmecohxuBT3HNx7GO/Os986TNlA8GkhsndeX
 JQu2dGKq7Zh/FIZvI9sEbhkpk4MXLMKfCtiEcb8/NT3sn9x1jDX4K4w6FvRsrrC4OY+ZzLLShRL
 hFiZPojzRHoFKimiFjzLRXcZBTHvVRENhE3FWFso3rhvDWGs=
X-Received: by 2002:a05:622a:4892:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-516d429b279mr284140721cf.7.1779827616652; 
 Tue, 26 May 2026 13:33:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4892:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-516d429b279mr284140151cf.7.1779827616131; 
 Tue, 26 May 2026 13:33:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706adc63dsm27579341cf.16.2026.05.26.13.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 13:33:35 -0700 (PDT)
Date: Tue, 26 May 2026 16:33:34 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] thread-pool: Allow at least 1 thread in
 thread_pool_adjust_max_threads_to_work()
Message-ID: <ahYDnlAUJ8x1bipq@x1.local>
References: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 09:06:07PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> thread_pool_adjust_max_threads_to_work() is supposed to give each task its
> own thread by setting the pool max thread count limit accordingly.
> 
> However, if there aren't any tasks currently in the pool the pool max
> thread count will be set to 0, which will trigger an assertion failure
> in thread_pool_set_max_threads() - because setting this value would
> completely block the pool by not allowing it to process any submitted
> tasks.
> 
> This also can happen if a task is submitted via
> thread_pool_submit_immediate() to an empty pool but the task completes so
> quickly that by the time this function calls
> thread_pool_adjust_max_threads_to_work() the pool again has no unfinished
> tasks in it.

Sorry for a late comment. Just curious: how easy is this to reproduce?

> 
> Fix this by making sure that the pool is allowed to create at least 1
> thread.

But then it means we have no work and then we will create one thread does
nothing..

I suspect the real culprit is we released the cur_work_lock during the
whole process of thread_pool_submit_immediate().  If we take it during the
whole window this will be a no-issue too.

The other question is, if it is awkward to manually adjust num of threads,
shall we set num to be -1 (unlimited) while pool created?

Thanks,

> 
> Fixes: b5aa74968b27 ("thread-pool: Implement generic (non-AIO) pool support")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  util/thread-pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 8f8cb38d5ce0..4e75191c983e 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -493,5 +493,5 @@ bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
>  {
>      QEMU_LOCK_GUARD(&pool->cur_work_lock);
>  
> -    return thread_pool_set_max_threads(pool, pool->cur_work);
> +    return thread_pool_set_max_threads(pool, MAX(pool->cur_work, 1));
>  }
> 

-- 
Peter Xu


