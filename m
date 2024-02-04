Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56331C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 16:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWflY-0003h8-Vq; Sun, 04 Feb 2024 11:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWflX-0003gz-MO
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 11:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWflV-0006uZ-4T
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 11:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707065684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=flcDQt5O889XwnovuUDKpDvlNSZu91Tsur6tCcOw/zs=;
 b=AvYGmgNIQnFn9AF+j7ck2+DxmQj6q6tI/7B5rSCu5yHBPNdhtx/8ddm823/rrvb8kWMAFf
 CO0lSqapxYROH/wnKAokLlpKlA+SSyEq4YtaDo3M3rQc+pKWWXgm+aO7ew53vstGS71hPg
 mp9ihrlwmmg+0jrQwIbzwICSrGQi1CQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-WRlBlxe7O2OnxUGmyPFpTg-1; Sun, 04 Feb 2024 11:54:42 -0500
X-MC-Unique: WRlBlxe7O2OnxUGmyPFpTg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33b28f50eadso798510f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 08:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707065681; x=1707670481;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flcDQt5O889XwnovuUDKpDvlNSZu91Tsur6tCcOw/zs=;
 b=DZA7DpnKWoUn0a7Lv1D2sRsuXv/eU1rW5R1K+DrtFhbFnTMYIi0P+JdD0+fGY5scL8
 kQoI3I0wX+oJl9+Jf+jH3pIusKC5Md3nM5mOBq6QJoGJYTDaJHrzB3kuGaXfTkFJnDJt
 oSh6a/xvGm3plXJol8g8Y0sqPo0+bF+KXFuR0UydXfDOG89BwMYaLkGWfbt7SBOi+T6s
 XU/RDGCSERLPzNPwsLRCipsDQICOooq2zfilWzLlq8oMotIVzO7O+GGgKaa4QuXPP0Si
 othj6d+JisuGaipbSuEb8H+EBvwmjvWrrxRXsXKW4OiXjw9+Q5XgQW1Z6XONhzSK2QSR
 1r4w==
X-Gm-Message-State: AOJu0YyloRjrl7I1RL0Fd4kBbs3ccrFVmDPOiqY35kj94qa7qrxBBEXY
 KYrryaT9uBq08cbWnMJHFILcqndustWhausWBhIGvia03g23lUGF8EuvsGUCNOeOugo6E6Ibau9
 Tzn3n+gDrPMP+57oAmKbpucxZwfur610B0RrMXKenGllZRFdXqX3Q
X-Received: by 2002:a5d:64e6:0:b0:33b:3ced:a5e1 with SMTP id
 g6-20020a5d64e6000000b0033b3ceda5e1mr589248wri.20.1707065681125; 
 Sun, 04 Feb 2024 08:54:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtTGUWdyrhhA5WFXZoV+cG6NE2KfXKaQTEGC/eyi1himkCSz1DjWKGHb+D0HOLDsooVRf/Iw==
X-Received: by 2002:a5d:64e6:0:b0:33b:3ced:a5e1 with SMTP id
 g6-20020a5d64e6000000b0033b3ceda5e1mr589225wri.20.1707065680618; 
 Sun, 04 Feb 2024 08:54:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXRkw9olOvTWHtjcTahiGLcZ1KLNiVLSG1TzvA7eL1fSdxF6y+JHDgtMwoEiWFgLCdb1eZyh0H98j0/oyn076WaC7bC8OpqNwdb3xuoFc6nZQO21GEFAcqGsqJOKlnJ2/ja4x4Tn0KDzxLCIKfu8MOp3Q==
Received: from ?IPV6:2003:cb:c725:700:519c:c741:25de:232f?
 (p200300cbc7250700519cc74125de232f.dip0.t-ipconnect.de.
 [2003:cb:c725:700:519c:c741:25de:232f])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d6883000000b0033ae5b637d4sm6245279wru.35.2024.02.04.08.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 08:54:40 -0800 (PST)
Message-ID: <a4466b34-c0e0-4a80-86ea-b9af6d8c86e0@redhat.com>
Date: Sun, 4 Feb 2024 17:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] oslib-posix: initialize backend memory objects in
 parallel
To: Dongli Zhang <dongli.zhang@oracle.com>, Mark Kanda
 <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131165327.3154970-1-mark.kanda@oracle.com>
 <20240131165327.3154970-2-mark.kanda@oracle.com>
 <8bec3d5c-03a2-02bc-ffff-4b46beeb206d@oracle.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8bec3d5c-03a2-02bc-ffff-4b46beeb206d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.02.24 23:43, Dongli Zhang wrote:
> 
> 
> On 1/31/24 08:53, Mark Kanda wrote:
>> QEMU initializes preallocated backend memory as the objects are parsed from
>> the command line. This is not optimal in some cases (e.g. memory spanning
>> multiple NUMA nodes) because the memory objects are initialized in series.
>>
>> Allow the initialization to occur in parallel (asynchronously). In order to
>> ensure optimal thread placement, asynchronous initialization requires prealloc
>> context threads to be in use.
>>
>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   backends/hostmem.c     |   7 ++-
>>   hw/virtio/virtio-mem.c |   4 +-
>>   include/hw/qdev-core.h |   5 ++
>>   include/qemu/osdep.h   |  18 +++++-
>>   system/vl.c            |   9 +++
>>   util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
>>   util/oslib-win32.c     |   8 ++-
>>   7 files changed, 145 insertions(+), 37 deletions(-)
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 30f69b2cb5..17221e422a 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -20,6 +20,7 @@
>>   #include "qom/object_interfaces.h"
>>   #include "qemu/mmap-alloc.h"
>>   #include "qemu/madvise.h"
>> +#include "hw/qdev-core.h"
>>   
>>   #ifdef CONFIG_NUMA
>>   #include <numaif.h>
>> @@ -237,7 +238,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>>           uint64_t sz = memory_region_size(&backend->mr);
>>   
>>           if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
>> -                               backend->prealloc_context, errp)) {
>> +                               backend->prealloc_context, false, errp)) {
>>               return;
>>           }
>>           backend->prealloc = true;
>> @@ -323,6 +324,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>>       HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>>       void *ptr;
>>       uint64_t sz;
>> +    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
>>   
>>       if (!bc->alloc) {
>>           return;
>> @@ -398,7 +400,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>>       if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
>>                                                   ptr, sz,
>>                                                   backend->prealloc_threads,
>> -                                                backend->prealloc_context, errp)) {
>> +                                                backend->prealloc_context,
>> +                                                async, errp)) {
>>           return;
>>       }
>>   }
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index 99ab989852..ffd119ebac 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>>           int fd = memory_region_get_fd(&vmem->memdev->mr);
>>           Error *local_err = NULL;
>>   
>> -        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
>> +        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
>>               static bool warned;
>>   
>>               /*
>> @@ -1248,7 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
>>       int fd = memory_region_get_fd(&vmem->memdev->mr);
>>       Error *local_err = NULL;
>>   
>> -    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
>> +    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
>>           error_report_err(local_err);
>>           return -ENOMEM;
>>       }
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 151d968238..83dd9e2485 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -1071,6 +1071,11 @@ typedef enum MachineInitPhase {
>>        */
>>       PHASE_ACCEL_CREATED,
>>   
>> +    /*
>> +     * Late backend objects have been created and initialized.
>> +     */
>> +    PHASE_LATE_BACKENDS_CREATED,
>> +
>>       /*
>>        * machine_class->init has been called, thus creating any embedded
>>        * devices and validating machine properties.  Devices created at
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index c9692cc314..7d359dabc4 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
>>    * @area: start address of the are to preallocate
>>    * @sz: the size of the area to preallocate
>>    * @max_threads: maximum number of threads to use
>> + * @tc: prealloc context threads pointer, NULL if not in use
>> + * @async: request asynchronous preallocation, requires @tc
>>    * @errp: returns an error if this function fails
>>    *
>>    * Preallocate memory (populate/prefault page tables writable) for the virtual
>> @@ -687,10 +689,24 @@ typedef struct ThreadContext ThreadContext;
>>    * each page in the area was faulted in writable at least once, for example,
>>    * after allocating file blocks for mapped files.
>>    *
>> + * When setting @async, allocation might be performed asynchronously.
>> + * qemu_finish_async_prealloc_mem() must be called to finish any asynchronous
>> + * preallocation.
>> + *
>>    * Return: true on success, else false setting @errp with error.
>>    */
>>   bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
>> -                       ThreadContext *tc, Error **errp);
>> +                       ThreadContext *tc, bool async, Error **errp);
>> +
>> +/**
>> + * qemu_finish_async_prealloc_mem:
>> + * @errp: returns an error if this function fails
>> + *
>> + * Finish all outstanding asynchronous memory preallocation.
>> + *
>> + * Return: true on success, else false setting @errp with error.
>> + */
>> +bool qemu_finish_async_prealloc_mem(Error **errp);
>>   
>>   /**
>>    * qemu_get_pid_name:
>> diff --git a/system/vl.c b/system/vl.c
>> index 788d88ea03..e6bc5d9dd9 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>>   
>>       object_option_foreach_add(object_create_late);
>>   
>> +    /*
>> +     * Wait for any outstanding memory prealloc from created memory
>> +     * backends to complete.
>> +     */
>> +    if (!qemu_finish_async_prealloc_mem(&error_fatal)) {
>> +        exit(1);
>> +    }
>> +
>>       if (tpm_init() < 0) {
>>           exit(1);
>>       }
>> @@ -3695,6 +3703,7 @@ void qemu_init(int argc, char **argv)
>>        * over memory-backend-file objects).
>>        */
>>       qemu_create_late_backends();
>> +    phase_advance(PHASE_LATE_BACKENDS_CREATED);
>>   
>>       /*
>>        * Note: creates a QOM object, must run only after global and
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 7c297003b9..dada4722f6 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -42,6 +42,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/units.h"
>>   #include "qemu/thread-context.h"
>> +#include "qemu/main-loop.h"
>>   
>>   #ifdef CONFIG_LINUX
>>   #include <sys/syscall.h>
>> @@ -63,11 +64,15 @@
>>   
>>   struct MemsetThread;
>>   
>> +static QLIST_HEAD(, MemsetContext) memset_contexts =
>> +    QLIST_HEAD_INITIALIZER(memset_contexts);
>> +
>>   typedef struct MemsetContext {
>>       bool all_threads_created;
>>       bool any_thread_failed;
>>       struct MemsetThread *threads;
>>       int num_threads;
>> +    QLIST_ENTRY(MemsetContext) next;
>>   } MemsetContext;
>>   
>>   struct MemsetThread {
>> @@ -412,19 +417,44 @@ static inline int get_memset_num_threads(size_t hpagesize, size_t numpages,
>>       return ret;
>>   }
>>   
>> +static int wait_and_free_mem_prealloc_context(MemsetContext *context)
>> +{
>> +    int i, ret = 0, tmp;
>> +
>> +    for (i = 0; i < context->num_threads; i++) {
>> +        tmp = (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
>> +
>> +        if (tmp) {
>> +            ret = tmp;
>> +        }
>> +    }
>> +    g_free(context->threads);
>> +    g_free(context);
>> +    return ret;
>> +}
>> +
>>   static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>> -                           int max_threads, ThreadContext *tc,
>> +                           int max_threads, ThreadContext *tc, bool async,
>>                              bool use_madv_populate_write)
>>   {
>>       static gsize initialized = 0;
>> -    MemsetContext context = {
>> -        .num_threads = get_memset_num_threads(hpagesize, numpages, max_threads),
>> -    };
>> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>>       size_t numpages_per_thread, leftover;
>>       void *(*touch_fn)(void *);
>> -    int ret = 0, i = 0;
>> +    int ret, i = 0;
>>       char *addr = area;
>>   
>> +    /*
>> +     * Asynchronous preallocation is only allowed when using MADV_POPULATE_WRITE
>> +     * and prealloc context for thread placement.
>> +     */
>> +    if (!use_madv_populate_write || !tc) {
>> +        async = false;
>> +    }
>> +
>> +    context->num_threads =
>> +        get_memset_num_threads(hpagesize, numpages, max_threads);
>> +
>>       if (g_once_init_enter(&initialized)) {
>>           qemu_mutex_init(&page_mutex);
>>           qemu_cond_init(&page_cond);
>> @@ -432,8 +462,11 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>       }
>>   
>>       if (use_madv_populate_write) {
>> -        /* Avoid creating a single thread for MADV_POPULATE_WRITE */
>> -        if (context.num_threads == 1) {
>> +        /*
>> +         * Avoid creating a single thread for MADV_POPULATE_WRITE when
>> +         * preallocating synchronously.
>> +         */
>> +        if (context->num_threads == 1 && !async) {
>>               if (qemu_madvise(area, hpagesize * numpages,
>>                                QEMU_MADV_POPULATE_WRITE)) {
>>                   return -errno;
>> @@ -445,50 +478,86 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>           touch_fn = do_touch_pages;
>>       }
>>   
>> -    context.threads = g_new0(MemsetThread, context.num_threads);
>> -    numpages_per_thread = numpages / context.num_threads;
>> -    leftover = numpages % context.num_threads;
>> -    for (i = 0; i < context.num_threads; i++) {
>> -        context.threads[i].addr = addr;
>> -        context.threads[i].numpages = numpages_per_thread + (i < leftover);
>> -        context.threads[i].hpagesize = hpagesize;
>> -        context.threads[i].context = &context;
>> +    context->threads = g_new0(MemsetThread, context->num_threads);
>> +    numpages_per_thread = numpages / context->num_threads;
>> +    leftover = numpages % context->num_threads;
>> +    for (i = 0; i < context->num_threads; i++) {
>> +        context->threads[i].addr = addr;
>> +        context->threads[i].numpages = numpages_per_thread + (i < leftover);
>> +        context->threads[i].hpagesize = hpagesize;
>> +        context->threads[i].context = context;
>>           if (tc) {
>> -            thread_context_create_thread(tc, &context.threads[i].pgthread,
>> +            thread_context_create_thread(tc, &context->threads[i].pgthread,
>>                                            "touch_pages",
>> -                                         touch_fn, &context.threads[i],
>> +                                         touch_fn, &context->threads[i],
>>                                            QEMU_THREAD_JOINABLE);
>>           } else {
>> -            qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
>> -                               touch_fn, &context.threads[i],
>> +            qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
>> +                               touch_fn, &context->threads[i],
>>                                  QEMU_THREAD_JOINABLE);
>>           }
>> -        addr += context.threads[i].numpages * hpagesize;
>> +        addr += context->threads[i].numpages * hpagesize;
>> +    }
>> +
>> +    if (async) {
>> +        /*
>> +         * async requests currently require the BQL. Add it to the list and kick
>> +         * preallocation off during qemu_finish_async_prealloc_mem().
>> +         */
>> +        assert(bql_locked());
>> +        QLIST_INSERT_HEAD(&memset_contexts, context, next);
>> +        return 0;
>>       }
>>   
>>       if (!use_madv_populate_write) {
>> -        sigbus_memset_context = &context;
>> +        sigbus_memset_context = context;
>>       }
>>   
>>       qemu_mutex_lock(&page_mutex);
>> -    context.all_threads_created = true;
>> +    context->all_threads_created = true;
>>       qemu_cond_broadcast(&page_cond);
>>       qemu_mutex_unlock(&page_mutex);
>>   
>> -    for (i = 0; i < context.num_threads; i++) {
>> -        int tmp = (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
>> +    ret = wait_and_free_mem_prealloc_context(context);
>>   
>> +    if (!use_madv_populate_write) {
>> +        sigbus_memset_context = NULL;
>> +    }
>> +    return ret;
>> +}
>> +
>> +bool qemu_finish_async_prealloc_mem(Error **errp)
>> +{
>> +    int ret, tmp;
> 
> The above should be initialized?
> 
> I did a build test and encounter:
> 
> In file included from ../util/oslib-posix.c:36:
> ../util/oslib-posix.c: In function ‘qemu_finish_async_prealloc_mem’:
> /home/libvirt/vm/software/qemu/include/qapi/error.h:334:5: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    334 |     error_setg_errno_internal((errp), __FILE__, __LINE__, __func__,     \
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../util/oslib-posix.c:531:9: note: ‘ret’ was declared here
>    531 |     int ret, tmp;
>        |         ^~~
> cc1: all warnings being treated as errors
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:162: run-ninja] Error 1

Thanks! It's a false-positive, ret could only be initialized if there 
are no contexts, but we check that right at the beginning of the function.

My compiler seems to realize that and does not complain.

I fixed that up and queued the patch to

https://github.com/davidhildenbrand/qemu.git mem-next

If there are no more comments, I'm planning on sending a patch later 
this week.

-- 
Cheers,

David / dhildenb


