Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D62C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBCz-00009J-Tf; Wed, 31 Jan 2024 09:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVBCy-000091-QV
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVBCw-0000Qc-Q4
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706709893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SHRP+PhcrkFoHMwDjJRDVYQVxwwyCCoX8kUzrhByZho=;
 b=YwPZBa1rgjeXpWrzQCY3zo0ryUg8sogLZlhQFMmW68SyAgxIi5mphQPs3gakkMqmeZHCe3
 ZpXfncrpyNsQgaCvhUuYB94U7cKYyBkhjz9FRgt/RgANDLU021n7V7CaR94VF/JSCrE8zb
 OiUsrOacVnTCD+CYPLI2OcGbwJo3YvQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-mfIqNohePgmGGre3_8pr_Q-1; Wed, 31 Jan 2024 09:04:51 -0500
X-MC-Unique: mfIqNohePgmGGre3_8pr_Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33aebf85ce9so1595779f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 06:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706709890; x=1707314690;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHRP+PhcrkFoHMwDjJRDVYQVxwwyCCoX8kUzrhByZho=;
 b=e10wYpL3HfMUTJuWKpeG4uBClwoLiODioa8WyEK5w7IafjML5CHVON+V4NeP+VTNBF
 zga9OMH2OrHDKvFXMQZlDYm6tl1LDknzjkom866Kxk9rlJOI0XnZ+Oyf468TrQRqluAw
 awub5dfbW6bgnOIOfMt7YL69FJWVUN8Dnskfe3yAqX/FdqcCWDXpMJ+HHU4ldf8lnr4Y
 191VQ9taso2Zp2Yy/QqytQutQskWtjedR0/8diy6Z3PVpeZFEvej7amudnXQj4QJtwX0
 7igNkBET5mUuXWiNKjwvg7gQ5uDF4WHFDVBssykN9koZshgEoH6G7GgkPHOSsSHqeqLp
 8xMQ==
X-Gm-Message-State: AOJu0YxEerSSLbvswCIrJbO6Ann8+fniuBOhT/iSvx8RWr5t6MjS7/nw
 5GBl4s6MclIpcU2AZRDrtgA+fP3rJgP+NMHTx3nHlO301IooGwydO+iWPWvhkuoEvfgvaYPa5WW
 HOms6if6sA69/L+M9JI+gO86umZq321sY8pWn3kVXfj1LGuyZViy6
X-Received: by 2002:a5d:6a48:0:b0:33a:ffe5:26ea with SMTP id
 t8-20020a5d6a48000000b0033affe526eamr1183449wrw.24.1706709890171; 
 Wed, 31 Jan 2024 06:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgVcNVxdAkWmWG7RxQeMe0CCr//fNJ5towgZZ0goJqN+bR+LvlGhFoGxTETwOdo3oiVdABoQ==
X-Received: by 2002:a5d:6a48:0:b0:33a:ffe5:26ea with SMTP id
 t8-20020a5d6a48000000b0033affe526eamr1183430wrw.24.1706709889755; 
 Wed, 31 Jan 2024 06:04:49 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
 by smtp.gmail.com with ESMTPSA id
 v9-20020adff689000000b0033af5c43155sm5647195wrp.56.2024.01.31.06.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 06:04:49 -0800 (PST)
Message-ID: <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
Date: Wed, 31 Jan 2024 15:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Content-Language: en-US
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
 <20240131134843.3074922-2-mark.kanda@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240131134843.3074922-2-mark.kanda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31.01.24 14:48, Mark Kanda wrote:
> QEMU initializes preallocated backend memory as the objects are parsed from
> the command line. This is not optimal in some cases (e.g. memory spanning
> multiple NUMA nodes) because the memory objects are initialized in series.
> 
> Allow the initialization to occur in parallel (asynchronously). In order to
> ensure optimal thread placement, asynchronous initialization requires prealloc
> context threads to be in use.
> 
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   backends/hostmem.c     |   8 ++-
>   hw/virtio/virtio-mem.c |   4 +-
>   include/qemu/osdep.h   |  18 +++++-
>   system/vl.c            |   8 +++
>   util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
>   util/oslib-win32.c     |   8 ++-
>   6 files changed, 140 insertions(+), 37 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 30f69b2cb5..8f602dc86f 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -20,6 +20,7 @@
>   #include "qom/object_interfaces.h"
>   #include "qemu/mmap-alloc.h"
>   #include "qemu/madvise.h"
> +#include "hw/qdev-core.h"
>   
>   #ifdef CONFIG_NUMA
>   #include <numaif.h>
> @@ -235,9 +236,10 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>           int fd = memory_region_get_fd(&backend->mr);
>           void *ptr = memory_region_get_ram_ptr(&backend->mr);
>           uint64_t sz = memory_region_size(&backend->mr);
> +        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
>   
>           if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
> -                               backend->prealloc_context, errp)) {
> +                               backend->prealloc_context, async, errp)) {
>               return;
>           }

I think we will never trigger that case: we would have to set the 
propertly after the device was already initialized, which shouldn't happen.

So I guess we can simplify and drop that.

>           backend->prealloc = true;


[...]

> +++ b/include/qemu/osdep.h
> @@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
>    * @area: start address of the are to preallocate
>    * @sz: the size of the area to preallocate
>    * @max_threads: maximum number of threads to use
> + * @tc: prealloc context threads pointer, NULL if not in use
> + * @async: request asynchronous preallocation, requires @tc
>    * @errp: returns an error if this function fails
>    *
>    * Preallocate memory (populate/prefault page tables writable) for the virtual
> @@ -687,10 +689,24 @@ typedef struct ThreadContext ThreadContext;
>    * each page in the area was faulted in writable at least once, for example,
>    * after allocating file blocks for mapped files.
>    *
> + * When setting @async, allocation might be performed asynchronously.
> + * qemu_finish_async_mem_prealloc() must be called to finish any asynchronous
> + * preallocation.
> + *
>    * Return: true on success, else false setting @errp with error.
>    */
>   bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp);
> +                       ThreadContext *tc, bool async, Error **errp);
> +
> +/**
> + * qemu_finish_async_mem_prealloc:
> + * @errp: returns an error if this function fails
> + *
> + * Finish all outstanding asynchronous memory preallocation.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
> +bool qemu_finish_async_mem_prealloc(Error **errp);

Suboptimal suggestion from my side, guess it woud be better to call this

"qemu_finish_async_prealloc_mem" to match "qemu_prealloc_mem"

>   
>   /**
>    * qemu_get_pid_name:
> diff --git a/system/vl.c b/system/vl.c
> index 788d88ea03..290bb3232b 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>   
>       object_option_foreach_add(object_create_late);
>   
> +    /*
> +     * Wait for any outstanding memory prealloc from created memory
> +     * backends to complete.
> +     */
> +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
> +        exit(1);
> +    }
> +

I'm wondering if we should have a new phase instead, like

PHASE_LATE_OBJECTS_CREATED.

and do here

phase_advance(PHASE_LATE_OBJECTS_CREATED);

and use that instead. Currently, there is a "gap" between both things. I 
don't think anything is actually broken right now (because any internal 
memory abckend wouldn't have a thread context), but it might be much 
cleaner and obvious that way.


Apart from that LGTM!

-- 
Cheers,

David / dhildenb


