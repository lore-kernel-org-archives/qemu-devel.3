Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38536C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqXJ-00026r-Vo; Tue, 28 Jan 2025 13:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcqXD-00025v-DT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcqXA-0007Yw-0H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738089713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hFdkk8WNhqsppe9MpUmgNxGQD4WSUP8nhmUn2jukSYY=;
 b=XEYz9usD0sHJOtS0ncuDWx4i/75Bz20mdoCo5CLdwXVKdXl5x6YXYCuevuQh+mJ2s96mNA
 rOwPoFBIO+R8TSzGrRQz2rQudqqiA77rullZGbYEce7eIjQXAlrZ9WjAemqYaDHvov3k1g
 u0Egs7WBKKmF2QFo4mxTZN0EeR7UOhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-OjXnke6qOD66OB6SS_H_Nw-1; Tue, 28 Jan 2025 13:41:52 -0500
X-MC-Unique: OjXnke6qOD66OB6SS_H_Nw-1
X-Mimecast-MFC-AGG-ID: OjXnke6qOD66OB6SS_H_Nw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso41776255e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738089711; x=1738694511;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hFdkk8WNhqsppe9MpUmgNxGQD4WSUP8nhmUn2jukSYY=;
 b=XNRA44U1Z1iZhkZmYlsodqDhMRuY1OTaqwn1cSeyT+Q/nQKRCfVrZdkZz6Htfyhumw
 JhPvnj9/Q3K4wBfD1Cpeck6PHYZ0EOqovv744doC4SsqSm4mKiDOkJTQQjJSYbhOOnOG
 kBpWUp8LyUrzVt4ayM+fh9NmHIjTc7mrfsZkLMU3P/Tclx4YdfyAmUzsSknx8z+siG+n
 DsSZIqRdF3fIAiU6+J1ufUtA2ixyra06v17M9bTcZSIIk8Ei9lETUflL3lwUTJ/1Tu5k
 6jYRDeQQ8QqeCGFFb/xDs8sT7YRKKOJuHSoq9wAHSzL3XA2JfJwOT7/AjUB7m8fVYwEd
 xUcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFw8NYOVm3tfBhmeFRm4O4k333Wru71cPUv3xK0PBJayJF9v67MQ4FCjJlopmmDv8D9M/GcnzCtKSn@nongnu.org
X-Gm-Message-State: AOJu0YxLJfSxzTKkn4Q21z1czhqEdBI3gdTXnu2Q4f5z+jWtasIbmLnt
 aachSEmak05r9hdD7hRW0O3dMTVzLAHuPN8jeOnciBmXR/po6C6OL2lVjDrlODYnDdSAaD6qWeP
 kS1adypjdHP2z9WvbTs77nOJeyBkTu6sJSKLVz5BB7TP0qd7ZoHTU
X-Gm-Gg: ASbGncuYGooGCua0wqZ3Xru2I/+AmaTw0G6ZpmDajCb3IaVq6vHmWmnfq7Td5lAuBDx
 QFN4tnDqCdDn3enEyRMruqAAGIVVEK//9WSsXH/2DYpj3l+IVQiuwLS1BaRC9pDpaLFmW42Iuyi
 n3h6pOh9AoxV28esuGsKfIQXfD9DBQ7Dow7kA45iWxCgz6cHddr+J7kMuF6o6vqt8GHXRmjAX3s
 rPDWvJMevPg34MH/jI8UnVbDZbZ6LzhrP1WAS8Yp6uYjZmDu77FXYkSRVvKf7z6VU7FZXd73xMv
 +wFDXzs7haRLa0uw1Kl28j/Bq7iYvBL5Ug==
X-Received: by 2002:a05:600c:500d:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-438dc40e4aamr48925e9.20.1738089710783; 
 Tue, 28 Jan 2025 10:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE12RivI6XWkz5cpG4j6QYXp+ni2gDLNCy3t8U2iLzNsy6//bb43tudEHLAF+epO8I/De14sg==
X-Received: by 2002:a05:600c:500d:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-438dc40e4aamr48715e9.20.1738089710358; 
 Tue, 28 Jan 2025 10:41:50 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6662.dip0.t-ipconnect.de. [91.12.102.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507d60sm178265115e9.18.2025.01.28.10.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:41:49 -0800 (PST)
Message-ID: <c80016f9-63f3-469f-864b-ca9a2a74735b@redhat.com>
Date: Tue, 28 Jan 2025 19:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] system/physmem: handle hugetlb correctly in
 qemu_ram_remap()
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
 <20250110211405.2284121-2-william.roche@oracle.com>
 <2a79643f-1d9e-4122-8932-954743a18c21@redhat.com>
 <26617c43-1f6c-4870-b99f-50525acd9134@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <26617c43-1f6c-4870-b99f-50525acd9134@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27.01.25 22:16, William Roche wrote:
> On 1/14/25 15:02, David Hildenbrand wrote:
>> On 10.01.25 22:14, “William Roche wrote:
>>> From: William Roche <william.roche@oracle.com>
>>>
>>> The list of hwpoison pages used to remap the memory on reset
>>> is based on the backend real page size. When dealing with
>>> hugepages, we create a single entry for the entire page.
>>>
>>> To correctly handle hugetlb, we must mmap(MAP_FIXED) a complete
>>> hugetlb page; hugetlb pages cannot be partially mapped.
>>>
>>> Co-developed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: William Roche <william.roche@oracle.com>
>>> ---
>>
>> See my comments to v4 version and my patch proposal.
> 
> I'm copying and answering your comments here:
> 
> 
> On 1/14/25 14:56, David Hildenbrand wrote:
>> On 10.01.25 21:56, William Roche wrote:
>>> On 1/8/25 22:34, David Hildenbrand wrote:
>>>> On 14.12.24 14:45, “William Roche wrote:
>>>>> From: William Roche <william.roche@oracle.com>
>>>>> [...]
>>>>> @@ -1286,6 +1286,10 @@ static void kvm_unpoison_all(void *param)
>>>>>     void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>>>>>     {
>>>>>         HWPoisonPage *page;
>>>>> +    size_t page_size = qemu_ram_pagesize_from_addr(ram_addr);
>>>>> +
>>>>> +    if (page_size > TARGET_PAGE_SIZE)
>>>>> +        ram_addr = QEMU_ALIGN_DOWN(ram_addr, page_size);
>>>>
>>>> Is that part still required? I thought it would be sufficient (at least
>>>> in the context of this patch) to handle it all in qemu_ram_remap().
>>>>
>>>> qemu_ram_remap() will calculate the range to process based on the
>>>> RAMBlock page size. IOW, the QEMU_ALIGN_DOWN() we do now in
>>>> qemu_ram_remap().
>>>>
>>>> Or am I missing something?
>>>>
>>>> (sorry if we discussed that already; if there is a good reason it might
>>>> make sense to state it in the patch description)
>>>
>>> You are right, but at this patch level we still need to round up the
>>
>> s/round up/align_down/
>>
>>> address and doing it here is small enough.
>>
>> Let me explain.
>>
>> qemu_ram_remap() in this patch here doesn't need an aligned addr. It
>> will compute the offset into the block and align that down.
>>
>> The only case where we need the addr besides from that is the
>> error_report(), where I am not 100% sure if that is actually what we
>> want to print. We want to print something like ram_block_discard_range().
>>
>>
>> Note that ram_addr_t is a weird, separate address space. The alignment
>> does not have any guarantees / semantics there.
>>
>>
>> See ram_block_add() where we set
>>       new_block->offset = find_ram_offset(new_block->max_length);
>>
>> independent of any other RAMBlock properties.
>>
>> The only alignment we do is
>>       candidate = ROUND_UP(candidate, BITS_PER_LONG << TARGET_PAGE_BITS);
>>
>> There is no guarantee that new_block->offset will be aligned to 1 GiB with
>> a 1 GiB hugetlb mapping.
>>
>>
>> Note that there is another conceptual issue in this function: offset
>> should be of type uint64_t, it's not really ram_addr_t, but an
>> offset into the RAMBlock.
> 
> Ok.
> 
>>
>>> Of course, the code changes on patch 3/7 where we change both x86 and
>>> ARM versions of the code to align the memory pointer correctly in both
>>> cases.
>>
>> Thinking about it more, we should never try aligning ram_addr_t, only
>> the offset into the memory block or the virtual address.
>>
>> So please remove this from this ram_addr_t alignment from this patch,
>> and look into
>> aligning the virtual address / offset for the other user. Again, aligning
>> ram_addr_t is not guaranteed to work correctly.
>>
> 
> Thanks for the technical details.
> 
> The ram_addr_t value alignment on the beginning of the page was useful
> to create a single entry in the hwpoison_page_list for a large page, but
> I understand that this use of ram_addr alignment may not be always accurate.
> Removing this alignment (without replacing it with something else) will
> end up creating several page entries in this list for the same hugetlb
> page. Because when we loose a large page, we can receive several MCEs
> for the sub-page locations touched on this large page before the VM crashes.

Right, although the kernel will currently only a single event IIRC. At 
least for hugetlb.

> So the recovery phase on reset will go through the list to discard/remap
> all the entries, and the same hugetlb page can be treated several times.
> But when we had a single entry for a large page, this multiple
> discard/remap does not occur.
> 
> Now, it could be technically acceptable to discard/remap a hugetlb page
> several times. Other than not being optimal and taking time, the same
> page being mapped or discarded multiple times doesn't seem to be a problem.
> So we can leave the code like that  without complicating it with a block
> and offset attributes to the hwpoison_page_list entries for example.

Right, this is something to optimize when it really becomes a problem I 
think.

-- 
Cheers,

David / dhildenb


