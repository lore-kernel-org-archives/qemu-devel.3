Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5066E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCEn-0004To-B7; Tue, 07 Jan 2025 11:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVCET-0004Mm-0f
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVCER-0001bO-D8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736266501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1iGYMqi+QZeKwT3C5ia354EPfEWbfI/EmWCGmqnxdzk=;
 b=aCVbe+tfw21tYHiJFKMUNzrEEhjNU9ZBY0D0j1rlf2cdRW/k5mgf8BBt3wSuxnpP7nQM+b
 JJre8ewSUz9JfPnexTyN6GHS1AL8RBA/YgWfMq2WvYNgT0BPPsx270mj+fZsLBoD7Yu9jB
 6s/DpEuoUigw39DMzCtxygAZx7RZGhU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-NRpxf_OmN0CXvsYuw-ea-w-1; Tue, 07 Jan 2025 11:15:00 -0500
X-MC-Unique: NRpxf_OmN0CXvsYuw-ea-w-1
X-Mimecast-MFC-AGG-ID: NRpxf_OmN0CXvsYuw-ea-w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43621907030so120775695e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736266499; x=1736871299;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1iGYMqi+QZeKwT3C5ia354EPfEWbfI/EmWCGmqnxdzk=;
 b=aoGfshUj5pRRCucMcByO2lE9NrpQ2zZd3VcQNst7aop/EMKzMEd2sitUfnWx2mOGNs
 KrAUEbrblXGIkiTTHuE8dnKRUcS5e1Y+TyRGS8QC5zNa1d08ftZFiAysO0ebmXjV7hzi
 FmSK0RI/cI2UlG9KCQmzP9WW7VFDOEO1dyXiZs4oWI3el1A6vmzFb2bzwdobPwC+6O2a
 du9YXdTUanFc4ib5Yuk8X/jih+UKtTv8s81XZufTwVG63BPtRtSc2TkTbd1UjE0dIaFU
 QnzJLa1SCtZvz9cg0HUYYS4pZXaEXHQvTLtm0OFwejOsK9pmnbaZxh2Q1WEiUMcEvJMm
 9GLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxW+2StAfJ8nJJTd/ad9NOHJKT/k9GXFfRB/C0M9bMrS/Od/hXijSncT74V8QhDdYivATIbTi0pEn1@nongnu.org
X-Gm-Message-State: AOJu0YyfO5eML4R4YHnmITcu/w5HxKcS3oJuMp3DdUHW2nOT/VRVfG3Y
 Q3sbl7wXAnLEeZR6VDsVXeOGHoJlh8pOvXFxdpv6PxUestgc0l95+BcmjQLAEOubqSvB5fHQiRM
 FlckysoYeSdyr1Wj15Mt9qBTJq21OnzkXPkNiAVV8B3D86YlRJxCjecuiy3kf
X-Gm-Gg: ASbGncslG4UAbDbVOSxZ+ICPTzOp6B5vhxbEA3pkPNup0NtzGinXA20g/oAKExwtLQk
 JtmAjIZUkE+RluBeHaU9lJarwGrzXJcI07xbEkfzfmU3/b3h4bg5RK4uTWvvYjKUWRzTHWx0Zsi
 Zw8bLeVSqeF0GdDFVamkUPznzCPf1sxc20wAl2M0ln49M+yDBbJoSs1mDWovSMF8tUzq3NB0mZr
 yHe30ZUwAaTpmFtypRrA5+hhUF2wbYDWwdPk0HXTtkEHB7Sm2ocmWfsj3Qv5234leOc8NbAWPRS
 oYKYsZGs38YQQ1gT0cdOgA/NXeNZOZVPZBdt1vODlYxdUmBYWykDXggyJlYfvZH07HvNHxgNuk2
 LcfHc88rm
X-Received: by 2002:a05:600c:5129:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-43668644082mr594418295e9.15.1736266499119; 
 Tue, 07 Jan 2025 08:14:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnVooGvK9y43tKCuV3CO4X4JzfGGXPSsbsn/Y64GtAh53EmdhJhtA2muQVrauXPvOu8uu/BA==
X-Received: by 2002:a05:600c:5129:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-43668644082mr594417115e9.15.1736266497201; 
 Tue, 07 Jan 2025 08:14:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3?
 (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de.
 [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm50179800f8f.29.2025.01.07.08.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:14:56 -0800 (PST)
Message-ID: <19d3323a-a0bf-4a40-9821-b6ffc41a5885@redhat.com>
Date: Tue, 7 Jan 2025 17:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] physmem: fix qemu_ram_alloc_from_fd size calculation
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1735853532-330037-1-git-send-email-steven.sistare@oracle.com>
 <2dfd3c37-3816-470d-9f8a-9187c93c0c21@redhat.com>
 <ac5d7de0-5eaa-4816-bb5b-d3cf801a2ed8@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ac5d7de0-5eaa-4816-bb5b-d3cf801a2ed8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 07.01.25 17:11, Steven Sistare wrote:
> On 1/7/2025 5:01 AM, David Hildenbrand wrote:
>> On 02.01.25 22:32, Steve Sistare wrote:
>>> qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
>>> it uses the existing space and verifies it is large enough, but the
>>> verification was broken when the offset parameter was introduced.  As
>>> a result, a file smaller than offset passes the verification and causes
>>> errors later.  Fix that, and update the error message to include offset.
>>>
>>> Peter provides this concise reproducer:
>>>
>>>     $ touch ramfile
>>>     $ truncate -s 64M ramfile
>>>     $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
>>>     qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
>>>
>>> With the fix, the error message is:
>>>     qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    system/physmem.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index c76503a..f01325f 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -1970,10 +1970,11 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>>        size = REAL_HOST_PAGE_ALIGN(size);
>>>        file_size = get_file_size(fd);
>>> -    if (file_size > offset && file_size < (offset + size)) {
>>> -        error_setg(errp, "backing store size 0x%" PRIx64
>>> -                   " does not match 'size' option 0x" RAM_ADDR_FMT,
>>> -                   file_size, size);
>>> +    if (file_size && file_size < offset + size) {
>>> +        error_setg(errp, "%s backing store size 0x%" PRIx64
>>> +                   " is too small for 'size' option 0x" RAM_ADDR_FMT
>>> +                   " plus 'offset' option 0x" RAM_ADDR_FMT,
>>
>>
>> Note that offset is of type "off_t", not ram_addr_t.
>>
>> ram_addr_t is a uintptr_t, but off_t can be a different integer type.
>>
>> In meson.build we use "-D_FILE_OFFSET_BITS=64". So on 32bit ram_addr_t would be 32bit but off_t will be 64bit.
>>
>>
>> Printing off_t can be weird [1]. Maybe just cast it to an uint64_t and print it using PRIx64?
> 
> I will fix as you suggest, thanks.  Good catch.
> With that, should I add your ack or RB to V3?

Feel free to add

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


