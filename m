Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F65C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siboD-0001Ed-MC; Mon, 26 Aug 2024 11:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sibo8-0000vG-GB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sibo6-0004cj-CU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724686739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TLfXVkPwEoMA6G9VtDum4pKBrlvrR4833cygFs3iqPo=;
 b=Ehx7kGi8uaftGSC15m6bB05ulwa3CN5GNCT3cBWAABZhv2XGD42N4f3z+/nQGNKQJRsg/p
 haw8U/OQVMmL5VD0I4N5RTaqUUED0kRwowddMBPkM/M+50yjn1C+abY4tqHlBcn8Xm3d7a
 CyZqWE5cmbjX98UG6MC2zzXQmHhAH/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-R9NHjS6ZNUWNNrHi2UJxBA-1; Mon, 26 Aug 2024 11:38:58 -0400
X-MC-Unique: R9NHjS6ZNUWNNrHi2UJxBA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42816096cb8so50034565e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686737; x=1725291537;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TLfXVkPwEoMA6G9VtDum4pKBrlvrR4833cygFs3iqPo=;
 b=gJJI0Lm55v4gbBomdZgSuWdOizi5jkuGeuWLyYafFRWEwM/r4gZfU7+b6D5F4fno4H
 bIW+EHSSLxUL3cSOjEgdCWSlUeOCZkAsVsXZCgls7C2Pmta/0YRoK8H10ZMwPD/Z31sP
 P1hK8RRNSPAG/1btkma+gA1oRdGF34tUcPwIq8dYed1EHhBJd0YccbjmYNrJBgX2HEFv
 hJk2mW3cu7u3P8N5hI4JQFSMKV8fK8RuLpc7A+yXql6SXapL6dDheNJvPRYDsjTZrpCD
 Hosp4aH19MA5TQEjpUk/6LH5ihZxj/iaCa6e7xebk3PYaB1qIp+r5QDB8SLnCv9F7+jJ
 MGlA==
X-Gm-Message-State: AOJu0Yx0cSA4qe8e96iZRX5AEPqDZuH+ARQwlOrf2oBW8YdWw+ztX5Tv
 KFI/b/5nBgvxetsFhyzuC9oA6mThW98xxki4J4BZqa7ESOKVpTA90ByxoP7P+64fKfgQ2Wp2+tW
 rQYigbCY5AT8b4ZUe5u/Uc2U3LC36rrbQWHvlDwh3SUosHmIQ0RWq
X-Received: by 2002:a05:600c:4f83:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-42acd543423mr76500715e9.7.1724686737163; 
 Mon, 26 Aug 2024 08:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkCSKluRZo4M1lOgyYrQ3r+XtVxQAjezlKLpAxfcXWtKk6HZdUZyfa2qlsfQH0UpBEt2m8fw==
X-Received: by 2002:a05:600c:4f83:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-42acd543423mr76500405e9.7.1724686736359; 
 Mon, 26 Aug 2024 08:38:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1900:16b0:8dc:77e:31af?
 (p200300cbc737190016b008dc077e31af.dip0.t-ipconnect.de.
 [2003:cb:c737:1900:16b0:8dc:77e:31af])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac51579casm159282015e9.11.2024.08.26.08.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 08:38:55 -0700 (PDT)
Message-ID: <57869819-eba7-4cc6-a1b1-c5581f5fb9e0@redhat.com>
Date: Mon, 26 Aug 2024 17:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent memory leak from object-add+object-del of
 memory-backend-ram
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com>
 <7f3fd493-8652-4bb9-b94a-1484d24dc3f2@redhat.com>
 <CAFEAcA-Ka+iPT4mwK6WaAbReJ2egwixyxaXwprY-Lu2Yr1v+RA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA-Ka+iPT4mwK6WaAbReJ2egwixyxaXwprY-Lu2Yr1v+RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.08.24 10:50, Peter Maydell wrote:
> On Mon, 19 Aug 2024 at 20:07, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.08.24 18:24, Peter Maydell wrote:
>>> Hi; I'm looking at a memory leak apparently in the host memory backend
>>> code that you can see from the qmp-cmd-test. Repro instructions:
>>
>> Hi Peter,
>>
>>>
>>> (1) build QEMU with '--cc=clang' '--cxx=clang++' '--enable-debug'
>>> '--target-list=x86_64-softmmu' '--enable-sanitizers'
>>> (2) run 'make check'. More specifically, to get just this
>>> failure ('make check' on current head-of-tree produces some
>>> other unrelated leak errors) you can run the relevant single test:
>>>
>>> (cd build/asan && ASAN_OPTIONS="fast_unwind_on_malloc=0"
>>> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test
>>> --tap -k -p /x86_64/qmp/object-add-failure-modes)
>>>
>>> The test case is doing a variety of object-add then object-del
>>> of the "memory-backend-ram" object, and this add-del cycle seems
>>> to result in a fairly large leak:
>>>
>>> Direct leak of 1572864 byte(s) in 6 object(s) allocated from:
>>>       #0 0x555c1336efd8 in __interceptor_calloc
>>> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8)
>>> (BuildId: fc7566a39db1253aed91d500b5b1784e0c438397)
>>>       #1 0x7f5bf3472c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>>>       #2 0x555c155bb134 in bitmap_new
>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitmap.h:102:12
>>>       #3 0x555c155ba4ee in dirty_memory_extend system/physmem.c:1831:37
>>>       #4 0x555c15585a2b in ram_block_add system/physmem.c:1907:9
>>>       #5 0x555c15589e50 in qemu_ram_alloc_internal system/physmem.c:2109:5
>>>       #6 0x555c1558a096 in qemu_ram_alloc system/physmem.c:2129:12
>>>       #7 0x555c15518b69 in memory_region_init_ram_flags_nomigrate
>>> system/memory.c:1571:21
>>>       #8 0x555c1464fd27 in ram_backend_memory_alloc backends/hostmem-ram.c:34:12
>>>       #9 0x555c146510ac in host_memory_backend_memory_complete
>>> backends/hostmem.c:345:10
>>>       #10 0x555c1580bc90 in user_creatable_complete qom/object_interfaces.c:28:9
>>>       #11 0x555c1580c6f8 in user_creatable_add_type qom/object_interfaces.c:125:10
>>>       #12 0x555c1580ccc4 in user_creatable_add_qapi qom/object_interfaces.c:157:11
>>>       #13 0x555c15ff0e2c in qmp_object_add qom/qom-qmp-cmds.c:227:5
>>>       #14 0x555c161ce508 in qmp_marshal_object_add
>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
>>>       #15 0x555c162a7139 in do_qmp_dispatch_bh qapi/qmp-dispatch.c:128:5
>>>       #16 0x555c16387921 in aio_bh_call util/async.c:171:5
>>>       #17 0x555c163887fc in aio_bh_poll util/async.c:218:13
>>>       #18 0x555c162e1288 in aio_dispatch util/aio-posix.c:423:5
>>>       #19 0x555c1638f7be in aio_ctx_dispatch util/async.c:360:5
>>>       #20 0x7f5bf3469d3a in g_main_dispatch
>>> debian/build/deb/../../../glib/gmain.c:3419:28
>>>       #21 0x7f5bf3469d3a in g_main_context_dispatch
>>> debian/build/deb/../../../glib/gmain.c:4137:7
>>>       #22 0x555c163935c9 in glib_pollfds_poll util/main-loop.c:287:9
>>>       #23 0x555c16391f03 in os_host_main_loop_wait util/main-loop.c:310:5
>>>       #24 0x555c16391acc in main_loop_wait util/main-loop.c:589:11
>>>       #25 0x555c14614917 in qemu_main_loop system/runstate.c:801:9
>>>       #26 0x555c16008b8c in qemu_default_main system/main.c:37:14
>>>       #27 0x555c16008bd7 in main system/main.c:48:12
>>>       #28 0x7f5bf12fbd8f in __libc_start_call_main
>>> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>>>
>>> My initial suspicion here is that the problem is that
>>> TYPE_MEMORY_BACKEND has a UserCreatableClass::complete method which
>>> calls HostMemoryBackend::alloc, but there is no corresponding
>>> "now free this" in instance_finalize. So ram_backend_memory_alloc()
>>> calls memory_region_init_ram_flags_nomigrate(), which allocates
>>> RAM, dirty blocks, etc, but nothing ever destroys the MR and the
>>> memory is leaked when the TYPE_MEMORY_BACKEND object is finalized.
>>>
>>> But there isn't a "free" method in HostMemoryBackendClass,
>>> only an "alloc", so this looks like an API with "leaks memory"
>>> baked into it. How is the freeing of the memory on object
>>> deletion intended to work?
>>
>> I *think* during object_del(), we would be un-refing the contained
>> memory-region, which in turn will make the refcount go to 0 and end up
>> calling memory_region_finalize().
> 
> Oh, yes, I'd forgotten about the MemoryRegions being refcounted.
> That explains why the MR itself doesn't show up as a leak, only
> these dirty memory bitmaps.
> 
>> In memory_region_finalize, we do various things, including calling
>> mr->destructor(mr).
>>
>> For memory_region_init_ram_flags_nomigrate(), the deconstructor is set
>> to memory_region_destructor_ram(). This is the place where we call
>> qemu_ram_free(mr->ram_block);
>>
>> There we clean up.
>>
>> What we *don't* clean up is the allocation you are seeing:
>> dirty_memory_extend() will extend the ram_list.dirty_memory bitmap as
>> needed. It is not stored in the RAMBlock, it's a global list.
>>
>> It's not really a leak I think: when we object_del + object_add *I
>> think* that bitmap will simply get reused.
> 
> I think there probably is a leak here somewhere, though --
> lsan will only report if the memory is unreachable from
> anywhere on program exit, AIUI. If we still had the global
> list available to reuse on the next object-creation
> shouldn't it still be reachable from somewhere?

Yes, that's what confusing me here. It's a global array that holds these 
bitmap chunks. I don't see how there would be a leak, but maybe I'm 
missing something. Let me have another look.

> 
> It's possible the leak only happens in some of the
> "check failure cases of object-add" code paths that the
> test is exercising, of course.

Right, but I think in any case we would keep the global array 
consistent. Let me try to re-understand that code.

-- 
Cheers,

David / dhildenb


