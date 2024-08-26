Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75EEC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siceS-0003Sc-DU; Mon, 26 Aug 2024 12:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1siceQ-0003RL-Bt
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1siceO-0002gm-1h
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724689982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yfw9207dzmeyUD5utZGUQeUxf6t8Wy3hYcex3W1btCE=;
 b=bR9sFWhEwpg3fTDWgFH4LINizxR4nmGPNRY4lZ8IOnJ/CQUSsLUwQABqpvxxHWOpxYZN1i
 mAlTvkeZ5kUOWWQfkXusjCmPGdAMaEGRmPIrE8pZOzplzgcObA908SQOL8P/GzQ0l+24qs
 WJcchq4jm4jxt2u+tWtVR8KWEycVnSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-B8ktYMQtPi2Mvh7MnSGnyw-1; Mon, 26 Aug 2024 12:33:00 -0400
X-MC-Unique: B8ktYMQtPi2Mvh7MnSGnyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42808efc688so40641395e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724689979; x=1725294779;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yfw9207dzmeyUD5utZGUQeUxf6t8Wy3hYcex3W1btCE=;
 b=ZvnePCBLNr2r29WKi0UHKR2592kcbu5rh0pc3ioJjRGlY1xMT2WbRsU6x1QJuOoO6d
 udxSFhakeaWqWWxLbEx5zuzXZoB8rktNFHq9lSm98FIQiHX7gfsdWEFx4m+N41JbZ584
 Cp2EPvCKoLdvwe8Z7NjrEF1gCy+HBvG4SSTBI+gjIZnzOu7NpQWlBvvxIM1aWvk6H5ss
 swUnfH21WHdNomINGHvIHcr97by4BgTnLbX0d5faBF8Jv6pverpTU4QozqDRhAyhhamt
 cjAWgX3pdSTFkTm4SQNtJPsKKYae/cMlrHELRblG1U2wbrULrF4xwtDaTSm8zGHakyLb
 mxZg==
X-Gm-Message-State: AOJu0YzVtK4k6Fx2JJ13HWSokmIZhHV9XWFvKYfg5a9spvSHxBMJYKGW
 ahSrZsXlB88Zo17PODcTHn2qCMdGyXd8fJzKklcJjMqQTF4KgM25Wm3vvk+vYybof7qmUTT6+jm
 0bWzLDRoPNL9UyLZJBDTNkCE/mCWBzbg6cqQwMGbFiaDH0J0DMLAl
X-Received: by 2002:a05:600c:19cc:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-42acc8d492fmr69168195e9.2.1724689979374; 
 Mon, 26 Aug 2024 09:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKMcwHSyc39euvxQiDKqhnBK0WUwOisi4QBAnA0G6O8QvSxf1CMnS5hRf4sZoaUtjtJD9TTA==
X-Received: by 2002:a05:600c:19cc:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-42acc8d492fmr69167955e9.2.1724689978596; 
 Mon, 26 Aug 2024 09:32:58 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23ced.dip0.t-ipconnect.de. [79.242.60.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730813c0dcsm11117418f8f.37.2024.08.26.09.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:32:58 -0700 (PDT)
Message-ID: <ca92f14b-4758-4f8b-a069-ff45ff2ce06e@redhat.com>
Date: Mon, 26 Aug 2024 18:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent memory leak from object-add+object-del of
 memory-backend-ram
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com>
 <7f3fd493-8652-4bb9-b94a-1484d24dc3f2@redhat.com>
 <CAFEAcA-Ka+iPT4mwK6WaAbReJ2egwixyxaXwprY-Lu2Yr1v+RA@mail.gmail.com>
 <57869819-eba7-4cc6-a1b1-c5581f5fb9e0@redhat.com>
 <840943aa-c737-45d4-89ad-0b7a75fd56a6@redhat.com>
 <695e2110-684f-4438-8741-28279ea5ffd5@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <695e2110-684f-4438-8741-28279ea5ffd5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26.08.24 18:25, David Hildenbrand wrote:
> On 26.08.24 17:56, David Hildenbrand wrote:
>> On 26.08.24 17:38, David Hildenbrand wrote:
>>> On 20.08.24 10:50, Peter Maydell wrote:
>>>> On Mon, 19 Aug 2024 at 20:07, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 19.08.24 18:24, Peter Maydell wrote:
>>>>>> Hi; I'm looking at a memory leak apparently in the host memory backend
>>>>>> code that you can see from the qmp-cmd-test. Repro instructions:
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>>>
>>>>>> (1) build QEMU with '--cc=clang' '--cxx=clang++' '--enable-debug'
>>>>>> '--target-list=x86_64-softmmu' '--enable-sanitizers'
>>>>>> (2) run 'make check'. More specifically, to get just this
>>>>>> failure ('make check' on current head-of-tree produces some
>>>>>> other unrelated leak errors) you can run the relevant single test:
>>>>>>
>>>>>> (cd build/asan && ASAN_OPTIONS="fast_unwind_on_malloc=0"
>>>>>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test
>>>>>> --tap -k -p /x86_64/qmp/object-add-failure-modes)
>>>>>>
>>>>>> The test case is doing a variety of object-add then object-del
>>>>>> of the "memory-backend-ram" object, and this add-del cycle seems
>>>>>> to result in a fairly large leak:
>>>>>>
>>>>>> Direct leak of 1572864 byte(s) in 6 object(s) allocated from:
>>>>>>          #0 0x555c1336efd8 in __interceptor_calloc
>>>>>> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8)
>>>>>> (BuildId: fc7566a39db1253aed91d500b5b1784e0c438397)
>>>>>>          #1 0x7f5bf3472c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>>>>>>          #2 0x555c155bb134 in bitmap_new
>>>>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitmap.h:102:12
>>>>>>          #3 0x555c155ba4ee in dirty_memory_extend system/physmem.c:1831:37
>>>>>>          #4 0x555c15585a2b in ram_block_add system/physmem.c:1907:9
>>>>>>          #5 0x555c15589e50 in qemu_ram_alloc_internal system/physmem.c:2109:5
>>>>>>          #6 0x555c1558a096 in qemu_ram_alloc system/physmem.c:2129:12
>>>>>>          #7 0x555c15518b69 in memory_region_init_ram_flags_nomigrate
>>>>>> system/memory.c:1571:21
>>>>>>          #8 0x555c1464fd27 in ram_backend_memory_alloc backends/hostmem-ram.c:34:12
>>>>>>          #9 0x555c146510ac in host_memory_backend_memory_complete
>>>>>> backends/hostmem.c:345:10
>>>>>>          #10 0x555c1580bc90 in user_creatable_complete qom/object_interfaces.c:28:9
>>>>>>          #11 0x555c1580c6f8 in user_creatable_add_type qom/object_interfaces.c:125:10
>>>>>>          #12 0x555c1580ccc4 in user_creatable_add_qapi qom/object_interfaces.c:157:11
>>>>>>          #13 0x555c15ff0e2c in qmp_object_add qom/qom-qmp-cmds.c:227:5
>>>>>>          #14 0x555c161ce508 in qmp_marshal_object_add
>>>>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
>>>>>>          #15 0x555c162a7139 in do_qmp_dispatch_bh qapi/qmp-dispatch.c:128:5
>>>>>>          #16 0x555c16387921 in aio_bh_call util/async.c:171:5
>>>>>>          #17 0x555c163887fc in aio_bh_poll util/async.c:218:13
>>>>>>          #18 0x555c162e1288 in aio_dispatch util/aio-posix.c:423:5
>>>>>>          #19 0x555c1638f7be in aio_ctx_dispatch util/async.c:360:5
>>>>>>          #20 0x7f5bf3469d3a in g_main_dispatch
>>>>>> debian/build/deb/../../../glib/gmain.c:3419:28
>>>>>>          #21 0x7f5bf3469d3a in g_main_context_dispatch
>>>>>> debian/build/deb/../../../glib/gmain.c:4137:7
>>>>>>          #22 0x555c163935c9 in glib_pollfds_poll util/main-loop.c:287:9
>>>>>>          #23 0x555c16391f03 in os_host_main_loop_wait util/main-loop.c:310:5
>>>>>>          #24 0x555c16391acc in main_loop_wait util/main-loop.c:589:11
>>>>>>          #25 0x555c14614917 in qemu_main_loop system/runstate.c:801:9
>>>>>>          #26 0x555c16008b8c in qemu_default_main system/main.c:37:14
>>>>>>          #27 0x555c16008bd7 in main system/main.c:48:12
>>>>>>          #28 0x7f5bf12fbd8f in __libc_start_call_main
>>>>>> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>>>>>>
>>>>>> My initial suspicion here is that the problem is that
>>>>>> TYPE_MEMORY_BACKEND has a UserCreatableClass::complete method which
>>>>>> calls HostMemoryBackend::alloc, but there is no corresponding
>>>>>> "now free this" in instance_finalize. So ram_backend_memory_alloc()
>>>>>> calls memory_region_init_ram_flags_nomigrate(), which allocates
>>>>>> RAM, dirty blocks, etc, but nothing ever destroys the MR and the
>>>>>> memory is leaked when the TYPE_MEMORY_BACKEND object is finalized.
>>>>>>
>>>>>> But there isn't a "free" method in HostMemoryBackendClass,
>>>>>> only an "alloc", so this looks like an API with "leaks memory"
>>>>>> baked into it. How is the freeing of the memory on object
>>>>>> deletion intended to work?
>>>>>
>>>>> I *think* during object_del(), we would be un-refing the contained
>>>>> memory-region, which in turn will make the refcount go to 0 and end up
>>>>> calling memory_region_finalize().
>>>>
>>>> Oh, yes, I'd forgotten about the MemoryRegions being refcounted.
>>>> That explains why the MR itself doesn't show up as a leak, only
>>>> these dirty memory bitmaps.
>>>>
>>>>> In memory_region_finalize, we do various things, including calling
>>>>> mr->destructor(mr).
>>>>>
>>>>> For memory_region_init_ram_flags_nomigrate(), the deconstructor is set
>>>>> to memory_region_destructor_ram(). This is the place where we call
>>>>> qemu_ram_free(mr->ram_block);
>>>>>
>>>>> There we clean up.
>>>>>
>>>>> What we *don't* clean up is the allocation you are seeing:
>>>>> dirty_memory_extend() will extend the ram_list.dirty_memory bitmap as
>>>>> needed. It is not stored in the RAMBlock, it's a global list.
>>>>>
>>>>> It's not really a leak I think: when we object_del + object_add *I
>>>>> think* that bitmap will simply get reused.
>>>>
>>>> I think there probably is a leak here somewhere, though --
>>>> lsan will only report if the memory is unreachable from
>>>> anywhere on program exit, AIUI. If we still had the global
>>>> list available to reuse on the next object-creation
>>>> shouldn't it still be reachable from somewhere?
>>>
>>> Yes, that's what confusing me here. It's a global array that holds these
>>> bitmap chunks. I don't see how there would be a leak, but maybe I'm
>>> missing something. Let me have another look.
>>>
>>>>
>>>> It's possible the leak only happens in some of the
>>>> "check failure cases of object-add" code paths that the
>>>> test is exercising, of course.
>>>
>>> Right, but I think in any case we would keep the global array
>>> consistent. Let me try to re-understand that code.
>>>
>>
>> Ah, yes there is a memory leak. The issue is that on unplug, when the
>> RAMBlock goes away, we don't free any entries that dirty_memory_extend()
>> allocated.
>>
>> The next time a RAMBlock is added, we call last_ram_page() again, to see
>> if we have to extend. And we think we have to extend.
>>
>> As last_ram_page() is based on ramblocks, and the relevant RAMBlock
>> vanished, we would call dirty_memory_extend() again, doing a
>> bitmap_new() at spots where there would already have been a bitmap_new()
>> before.
>>
>> That whole code is quite fragile I'm afraid. It would probably be best
>> to just sore the numbers of allocated blocks per
>> ram_list.dirty_memory[i] entry, and maybe try getting rid of this
>> "old_ram_size" thingy completely.
>>
>> Of course, freeing bitmaps where possible might also be an option when
>> removing RAMBlocks ...
> 
> The following should fix it (only compile-tested so far):
> 
>   From a4d1c4ebbcb93a8ba32d86ee334e30b602ac640f Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Mon, 26 Aug 2024 18:14:46 +0200
> Subject: [PATCH v1] softmmu/physmem: fix memory leak in dirty_memory_extend()
> 
> As reported by Peter, we might be leaking memory when removing the
> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
> 
> We will fail to realize that we already allocated bitmaps for more
> dirty memory blocks, and effectively discard them to overwrite them
> with new bitmaps.
> 
> Fix it by getting rid of last_ram_page() and simply storing the number
> of dirty memory blocks that have been allocated.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>    include/exec/ramlist.h |  1 +
>    system/physmem.c       | 42 +++++++++++++-----------------------------
>    2 files changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index 2ad2a81acc..f2a965f293 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
>    #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
>    typedef struct {
>        struct rcu_head rcu;
> +    unsigned int num_blocks;
>        unsigned long *blocks[];
>    } DirtyMemoryBlocks;
>    
> diff --git a/system/physmem.c b/system/physmem.c
> index 94600a33ec..54384e6f34 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1534,18 +1534,6 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>        return offset;
>    }
>    
> -static unsigned long last_ram_page(void)
> -{
> -    RAMBlock *block;
> -    ram_addr_t last = 0;
> -
> -    RCU_READ_LOCK_GUARD();
> -    RAMBLOCK_FOREACH(block) {
> -        last = MAX(last, block->offset + block->max_length);
> -    }
> -    return last >> TARGET_PAGE_BITS;
> -}
> -
>    static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
>    {
>        int ret;
> @@ -1799,28 +1787,29 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
>    }
>    
>    /* Called with ram_list.mutex held */
> -static void dirty_memory_extend(ram_addr_t old_ram_size,
> -                                ram_addr_t new_ram_size)
> +static void dirty_memory_extend(ram_addr_t new_ram_size)
>    {
> -    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
> -                                             DIRTY_MEMORY_BLOCK_SIZE);
>        ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
>                                                 DIRTY_MEMORY_BLOCK_SIZE);
>        int i;
>    
> -    /* Only need to extend if block count increased */
> -    if (new_num_blocks <= old_num_blocks) {
> -        return;
> -    }
> -
>        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
>            DirtyMemoryBlocks *old_blocks;
>            DirtyMemoryBlocks *new_blocks;
> +        ram_addr_t old_num_blocks;
>            int j;
>    
>            old_blocks = qatomic_rcu_read(&ram_list.dirty_memory[i]);
> +        old_num_blocks = old_blocks->num_blocks;
> +
> +        /* Only need to extend if block count increased */
> +        if (new_num_blocks <= old_num_blocks) {
> +            return;
> +        }
> +
>            new_blocks = g_malloc(sizeof(*new_blocks) +
>                                  sizeof(new_blocks->blocks[0]) * new_num_blocks);
> +        new_blocks->num_blocks = new_num_blocks;
>    
>            if (old_num_blocks) {
>                memcpy(new_blocks->blocks, old_blocks->blocks,
> @@ -1846,11 +1835,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>        RAMBlock *block;
>        RAMBlock *last_block = NULL;
>        bool free_on_error = false;
> -    ram_addr_t old_ram_size, new_ram_size;
> +    ram_addr_t new_ram_size;
>        Error *err = NULL;
>    
> -    old_ram_size = last_ram_page();
> -
>        qemu_mutex_lock_ramlist();
>        new_block->offset = find_ram_offset(new_block->max_length);
>    
> @@ -1901,11 +1888,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>            }
>        }
>    
> -    new_ram_size = MAX(old_ram_size,
> -              (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
> -    if (new_ram_size > old_ram_size) {
> -        dirty_memory_extend(old_ram_size, new_ram_size);
> -    }
> +    new_ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> +    dirty_memory_extend(new_ram_size);
>        /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
>         * QLIST (which has an RCU-friendly variant) does not have insertion at
>         * tail, so save the last element in last_block.

[talking to myself] there is a BUG in above:

diff --git a/system/physmem.c b/system/physmem.c
index 54384e6f34..e744d5304a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1796,15 +1796,17 @@ static void dirty_memory_extend(ram_addr_t new_ram_size)
      for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
          DirtyMemoryBlocks *old_blocks;
          DirtyMemoryBlocks *new_blocks;
-        ram_addr_t old_num_blocks;
+        ram_addr_t old_num_blocks = 0;
          int j;
  
          old_blocks = qatomic_rcu_read(&ram_list.dirty_memory[i]);
-        old_num_blocks = old_blocks->num_blocks;
+        if (old_blocks) {
+            old_num_blocks = old_blocks->num_blocks;
  
-        /* Only need to extend if block count increased */
-        if (new_num_blocks <= old_num_blocks) {
-            return;
+            /* Only need to extend if block count increased */
+            if (new_num_blocks <= old_num_blocks) {
+                return;
+            }
          }
  
          new_blocks = g_malloc(sizeof(*new_blocks) +


Will send out a patch once I did more testing.

-- 
Cheers,

David / dhildenb


