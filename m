Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D74C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYsx-0004v0-79; Wed, 23 Jul 2025 08:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueYr1-0003l5-0c
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueYqu-0008Dj-Ea
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753274743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mOk5fmlZ18z3RvzsGbR0jeo7FGhZJSUOO2zY7sC0E4g=;
 b=XLFUuvcjIa5Ewsf3YjvS5nSy3haR0IZHdtL/hWyd8N5h9b0ZDjHXW5CQFaW8dAioawzgWb
 MN2KZyR14dph/3+y/9RJ+UOWDOdACtp9bbMgsBkebgOEeELT/Urm2zCZkcnOjQiPszV4NZ
 u8YKFmp9m+NSrKNRCWtk8+or9vHLTDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-y-OPVuVGOzGr51HFTaqpqA-1; Wed, 23 Jul 2025 08:45:41 -0400
X-MC-Unique: y-OPVuVGOzGr51HFTaqpqA-1
X-Mimecast-MFC-AGG-ID: y-OPVuVGOzGr51HFTaqpqA_1753274740
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455f7b86aeeso33528415e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274740; x=1753879540;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mOk5fmlZ18z3RvzsGbR0jeo7FGhZJSUOO2zY7sC0E4g=;
 b=Jt+jjPSL7+E4c5mu0DrGQmIZwOmULOaUzdJhOARv0A2WyPjoyVuVYIb2TLyNLWNcfm
 hDSdzD9R2O1NTe1JV/iCyFc9W5jVOI2EEfQ79BR6X2G9wFIYqLaVL4gBlnpUlxve/BOL
 6pXLwwrvraz63XZcEVkPBi1yHIYKcCt+GrnsGvY0FfEjPQFbI+7o+hLz24fAHb4J6wSt
 mxHugVxMLbOl7loS90DI9q3pSysNJYtR5uWcR4uRb3kbWYawD9zjcuHZASJ+KjLvNVSS
 GP2+pNzr8Q8qaa+QeBOQj3mFdHSfHJNwlH5Dd21NmJsUIRs6mg21HgzAKSy9uHunPPje
 ylng==
X-Gm-Message-State: AOJu0Yw2hVM5jbOtEJUjq8renE00Q+kLl/4A0RqbnINr+SrIjfR5O1pQ
 YHbhNRNTpBhJEY1BRbLOC+fkcZY20CYlN3OwsgtObSp0p74jcjse5b2Qq4jW3UOsRbpWUZjiHm8
 BHNYoxK1IfILW5RWkQQoCxeW4kp+hqzCQLVCP/+sUX50HgRqYL4/2E7dc
X-Gm-Gg: ASbGnctxvi/hDZMj+KsQ489QSr8MB100O1JNHVzFnP7YlEKwVEKKVm+v4c6QcqWOuSs
 k2rPUAWQ8idiO7eM4VIexfB3ZKWFbNih1p1SlDHSs2KifY6X58Yu8xTXqnRkZVCOKHw5DlQEyu7
 p7yniuCN5ScC5B7aUO/eJw6+uObT8mTFT7Cwzo12DgkJAylu4Dz0RLYS9PbcUndVcwfLcNCu0ry
 94HH19mdDdDQdzLUcacHeGfCI+EH0TDrmBRfFbAjoHgGC7rCrLK/GCxBWAcD9TeesHgGakYHvNj
 GU+36cfNtSXm4OdyIi78MYUPsbdk6ABzJWB9qY+2OdiNbC0yXdtdBfHAcJFBuym62fiFK4MTpZ+
 5a9zUShMIchJ6SS9RXhvJRDu3bqlHuXTdNIJKN4nCu7CoRI3D3qcJ+SoQ/FuP4vwH4oU=
X-Received: by 2002:a05:600c:4e0d:b0:456:2dc1:a603 with SMTP id
 5b1f17b1804b1-45868c8f4fbmr22880055e9.5.1753274740279; 
 Wed, 23 Jul 2025 05:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSBwYMsdXDysi2tyItesZ0jkyiVcWVqOeTpam8PEQxHHAcA/kb43CTkEUq0OsLr+86Gd4kfg==
X-Received: by 2002:a05:600c:4e0d:b0:456:2dc1:a603 with SMTP id
 5b1f17b1804b1-45868c8f4fbmr22879765e9.5.1753274739738; 
 Wed, 23 Jul 2025 05:45:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a?
 (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de.
 [2003:d8:2f00:4000:a438:1541:1da1:723a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd07esm22752775e9.22.2025.07.23.05.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:45:39 -0700 (PDT)
Message-ID: <0d2f8367-449a-48b1-a7c5-f4c272bb7c15@redhat.com>
Date: Wed, 23 Jul 2025 14:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250723121920.1184928-1-aesteve@redhat.com>
 <f35f2cfc-2bc1-40b4-8dd2-f7ac34cbd317@linaro.org>
 <CADSE00Lp0W_nsUqqTz7=JmyzLuJjMdOq8WkFXeBAtOxe-yDCPg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CADSE00Lp0W_nsUqqTz7=JmyzLuJjMdOq8WkFXeBAtOxe-yDCPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23.07.25 14:42, Albert Esteve wrote:
> On Wed, Jul 23, 2025 at 2:32 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 23/7/25 14:19, Albert Esteve wrote:
>>> In the last version of the SHMEM MAP/UNMAP [1] there was a
>>> comment [2] from Stefan about the lifecycle of the memory
>>> regions.
>>>
>>> After some discussion, David Hildenbrand proposed
>>> to detect RAM regions and handle refcounting differently
>>> to clear the initial concern. This RFC patch is
>>> meant for gathering feedback from others
>>> (i.e., Paolo Bonzini and Peter Xu).
>>>
>>> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
>>> [2] https://patchwork.ozlabs.org/comment/3528600/
>>>
>>> ---
>>>
>>> This patch enhances memory_region_ref() and memory_region_unref()
>>> to handle RAM and MMIO memory regions differently, improving
>>> reference counting semantics.
>>>
>>> RAM regions now reference/unreference the memory region object
>>> itself, while MMIO continue to reference/unreference the owner
>>> device as before.
>>>
>>> An additional qtest has been added to stress the memory
>>> lifecycle. All tests pass as these changes keep backward
>>> compatibility (prior behaviour is kept for MMIO regions).
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com >
>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>> ---
>>>    system/memory.c            | 22 +++++++++++++----
>>>    tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 67 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 5646547940..48ab6e5592 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -1826,6 +1826,14 @@ Object *memory_region_owner(MemoryRegion *mr)
>>>
>>>    void memory_region_ref(MemoryRegion *mr)
>>>    {
>>> +    /* Regions without an owner are considered static. */
>>> +    if (!mr || !mr->owner) {
>>> +        return;
>>> +    }
>>> +    if (mr->ram) {
>>> +        object_ref(OBJECT(mr));
>>> +        return;
>>> +    }
>>>        /* MMIO callbacks most likely will access data that belongs
>>>         * to the owner, hence the need to ref/unref the owner whenever
>>>         * the memory region is in use.
>>> @@ -1836,16 +1844,20 @@ void memory_region_ref(MemoryRegion *mr)
>>>         * Memory regions without an owner are supposed to never go away;
>>
>> What are the use cases for MRs without QOM owner?
> 
> Not sure if you are asking about the logic or the actual usecases
> where these MRs would make sense.
> 
> Regarding the logic, note the early return at the beginning of the
> function, so that this comment is kept valid. In short, nothing
> changes.
> 
> Regarding the usecases for these type of memories, I can think of
> system memory or container regions as examples. But there are
> certainly more experienced people in this thread that can answer you
> better than me.

The thing is: these MRs have an owner, but to make the limitation 
spelled out in the doc (see my comment) work, we must refcount the MR 
itself.

We could likely ref both (RAM region and the owner), but it's documented 
that that results in a performance problem.

-- 
Cheers,

David / dhildenb


