Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058A0C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2aJ-0003re-K9; Thu, 20 Feb 2025 04:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl2aH-0003rP-QY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl2aE-0008Mp-F1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740042660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=43XqcaoJq7/VG6POTKwN9EsU9DPe/mSSXvvx9NYEmIg=;
 b=YsZ0tnQXJqNpIH1F6BZNS3h1YMsUTK8fqqhmV7OPJc1j3DlEv8BNoyW7cS1aI6F+du03TB
 cOALa3wTJum4KqUPTBlqOdFjzfuuMoOijLXFwkgJ2v9OdTm729V/eauvOc93+juzMdeH2Q
 ipyVlraH69IoSbdJS0IWeC+KKMyFV5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-c_LgiPIXOaeLlri3pa6COA-1; Thu, 20 Feb 2025 04:10:55 -0500
X-MC-Unique: c_LgiPIXOaeLlri3pa6COA-1
X-Mimecast-MFC-AGG-ID: c_LgiPIXOaeLlri3pa6COA_1740042655
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso8153005e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740042654; x=1740647454;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43XqcaoJq7/VG6POTKwN9EsU9DPe/mSSXvvx9NYEmIg=;
 b=OLdZRo+GD3KCnAOUkVdzcMUQKW12/mgMzjkIJj0ThoEniwpopv2tZXXKZizVVMgMse
 Di8tCMdZI+ijxdywlVq8zxvZHv5X+bR+SoE/WDg0nhS/kphVcsUDuWdns3FQpyJjAORp
 m6Of143Ty8RWqdDb3HatX5DI2cpR4R8R0BHNLV0qKe/zvSC2L/0X2sNmFsvfPop0BVmx
 Lvu4l3ijuyWZcKaoUPVjuwdDGm1WE/IfVkMWY00AaYkyRh5mzUr/kAjxFwUySqkPvKyo
 FyeHULVMGxRVtxAOuLm4MK7JR2C8CUa1HAhSfwHvbftk7xiOhNqVS1rcxpJjuLLHLWV7
 do2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3OGxqMHIs4p9s69EKmFw3pIHu1bleEzJJUldfYXcrjkRzyEWufr9+JvEaAihGbflTjVk907qRjyEp@nongnu.org
X-Gm-Message-State: AOJu0YyL21d2cFPUqf65wxVkfgaBd9aB236gylb7s9CxknOYP2XxbWUI
 VMQ+IqTYNRlvDrM7IKwMSTMGaxbqAl2cxFSY7xcAEVknkzhSIk0v6DYKpMGRC7C0XVJ05xuybuQ
 /ban/qsTPzyXrcLYqrPA0wXK2XK48oUhiFnkIgIFJgLkLvNZ9MLpq
X-Gm-Gg: ASbGncvw1OxW3sPoQiL4IALbM6Ie/1uIASavVtrRcX8KXrjRTq2IV/lq1l1of4ZQD/A
 5mcmZVGdrvdkTmmtpTNtJfXCxDGmtp4JkK5UIClujAvGyObcsAgn4ntmU/gGPIA2i7vLDR/kEZg
 Fytq5fGtN1i+DdRs2QOsfAtPF3UvUno7kKw6LRoghZpQif/xh/6gJQBZwoZmAi+31/ggAkSqafY
 sfR84KEk0QMJzRzJUkQjF4qVUwGyf5sEavQCfUsKUHqxQZ5GZ0Aabmr+bcvpirBwSekz6uFeB5S
 T5KzBHo8hgQ=
X-Received: by 2002:a05:600c:19ce:b0:439:a30f:2e67 with SMTP id
 5b1f17b1804b1-439a30f30aemr21214735e9.17.1740042654617; 
 Thu, 20 Feb 2025 01:10:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzYI+bFOaIlfaAb+5V2P/wI07Q9vYag6AeMA7DsJx+id4IXOS0dGcqEfZVpk2EvbtEdnbyqQ==
X-Received: by 2002:a05:600c:19ce:b0:439:a30f:2e67 with SMTP id
 5b1f17b1804b1-439a30f30aemr21214495e9.17.1740042654264; 
 Thu, 20 Feb 2025 01:10:54 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4398c9deb59sm91545445e9.32.2025.02.20.01.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 01:10:53 -0800 (PST)
Message-ID: <286270ed-cc59-4fe9-88c2-ad08798ed08a@redhat.com>
Date: Thu, 20 Feb 2025 10:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix data race with the state Field of ThreadPoolElement
To: Vitalii Mordan <mordan@ispras.ru>, Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Vadim Mutilin <mutilin@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20250219161223.3340431-1-mordan@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250219161223.3340431-1-mordan@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/19/25 17:12, Vitalii Mordan wrote:
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 27eb777e85..6c5f4d085b 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -111,9 +111,8 @@ static void *worker_thread(void *opaque)
>           ret = req->func(req->arg);
>   
>           req->ret = ret;
> -        /* Write ret before state.  */
> -        smp_wmb();
> -        req->state = THREAD_DONE;
> +        /* Atomically update state after setting ret.  */
> +        qatomic_store_release(&req->state, THREAD_DONE);

This is good.

> @@ -180,7 +179,7 @@ static void thread_pool_completion_bh(void *opaque)
>   
>   restart:
>       QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
> -        if (elem->state != THREAD_DONE) {
> +        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {

This is good, but it needs a comment and it can replace the smp_rmb() below.

>               continue;
>           }
>   
> @@ -223,12 +222,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
>       trace_thread_pool_cancel(elem, elem->common.opaque);
>   
>       QEMU_LOCK_GUARD(&pool->lock);
> -    if (elem->state == THREAD_QUEUED) {
> +    if (qatomic_load_acquire(&elem->state) == THREAD_QUEUED) {

This is not ordering anything so it can be qatomic_read/qatomic_set 
(technically the one below doesn't even need that, but it's fine).

>           QTAILQ_REMOVE(&pool->request_list, elem, reqs);
>           qemu_bh_schedule(pool->completion_bh);
>   
> -        elem->state = THREAD_DONE;
>           elem->ret = -ECANCELED;
> +        qatomic_store_release(&elem->state, THREAD_DONE);
>       }
>   
>   }
> @@ -251,8 +250,8 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>       req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
>       req->func = func;
>       req->arg = arg;
> -    req->state = THREAD_QUEUED;
>       req->pool = pool;
> +    qatomic_store_release(&req->state, THREAD_QUEUED);

This does not need any atomic access, because there is ordering via 
pool->lock (which protects the request_list).  There's no need to do 
store-release and load-acquire except to order with another store or 
load, and in fact adding unnecessary acquire/release is harder to 
understand.

Paolo

>       QLIST_INSERT_HEAD(&pool->head, req, all);
>   


