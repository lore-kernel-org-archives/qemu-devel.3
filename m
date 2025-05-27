Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7336C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsLx-0004zO-Oy; Tue, 27 May 2025 07:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJsLu-0004xA-N8
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJsLs-0008G7-2j
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748344809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YKNVYFC2IcMe1Fm7SeSy11DsiVXZP+F286iJgXwsNUQ=;
 b=iDllUtmZLbBpzEJWYYsdVCM8SSpdVafJcRVG8PYFRRdAO0gUMRtucWSuvCnTFIH/S+CxDl
 YROAmApkyoafc0t7IONSp9Qilcks3tzs12fV6Kw25QSsi/Dnb0A71XE5krZgbe2w0Nqa0V
 pRBTGU1Lf++D0EsrhvHgWVbL2pWk9zM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-ElV0uZ30ODS-pMkhGTPjZg-1; Tue, 27 May 2025 07:20:06 -0400
X-MC-Unique: ElV0uZ30ODS-pMkhGTPjZg-1
X-Mimecast-MFC-AGG-ID: ElV0uZ30ODS-pMkhGTPjZg_1748344805
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442fda1cba7so15071675e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 04:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748344805; x=1748949605;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YKNVYFC2IcMe1Fm7SeSy11DsiVXZP+F286iJgXwsNUQ=;
 b=kecJP4Ic2UNEQNckEXIn6Sw6D70/So0Ca4jliUj6YJI+5thu+bnCw+QTSNPbXA/ow6
 qLEb0OGUXA17ysC43cvp22Lb09eHZAFqSNNKsjMBsdkYkSJXYxYvov4rfIxH7vdNOh+O
 sUiq3jr1dkjrkkpLwB5Dw33HT5Jrq3Z+q7fEXlCCku2OOpoC+Is/BLosXkDsulqSFGpD
 D+aBnCDmz83x/kZ2rIiz2bH55F6EPoZuOWX7IUQKqwYTIw1L02PIGqpTyxw+7egDNaaj
 ikAditv3XVkA9ql+y1ermfcQJqegRH1JkiQfu1w+eiT4pK3GQ1Fi7RB066YC1tp3nFFa
 1amw==
X-Gm-Message-State: AOJu0YwppDj4/UWEclPcqcC2pPnpjoBVo65dRRwePGjCsd/JgheN3Um9
 aPBLMb8P79+bGxC8J+XUyki61COvLwB/a8MLQ+zCn8zTwBSHaK0OF6R/iiQXuDUSTQuDXir4xev
 qEQU36XL2YqbrURa5xKR4fYcvU7JmSrKXfRH520kUCcCoRaK93RyD0Cqd
X-Gm-Gg: ASbGncs45R7h+8EMDRq3asHC6RsyI00V3D527vmY/F7E+NwBn6TbvEhyFH3WVV053jm
 EZPs4MK7+yrjNvLQS2CXchfiRBz17N7pa5tugT6Cf+vcoOcxMrFyVc/veGm0bx3mKhchBahnDV2
 4gq4vsfzrh5+FPpp4wmtAY9Q7FN5JlJUXkO3epzCHL1XeKBNuq+89o1A40lYzZFT2N7J20rrNsl
 JE/VNEFNhy70a3hYvy9SXjjRSDMuCYdefwJMW7L7zH8E6nFGzNL5LJimJoMOfPHreIy6kTTdIzc
 oood6Hq5kY6+3qKPkhuX5R2ensXomJHmgVRUQF2G8r5F
X-Received: by 2002:a05:600c:1547:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-44c935dca2emr106324025e9.8.1748344805156; 
 Tue, 27 May 2025 04:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlyickPkgs/njo2SCri2jqrG0yQeRWlByYHp0iamN4soyrSABHNsEoh0+qGZMhx4sYPUWZCA==
X-Received: by 2002:a05:600c:1547:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-44c935dca2emr106323715e9.8.1748344804691; 
 Tue, 27 May 2025 04:20:04 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d17266d5sm8387859f8f.68.2025.05.27.04.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 04:20:04 -0700 (PDT)
Message-ID: <e187cd31-09b4-48da-88ea-20582023e5d8@redhat.com>
Date: Tue, 27 May 2025 13:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] RAMBlock: Make guest_memfd require coordinate
 discard
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-8-chenyi.qiang@intel.com>
 <7af3f5c9-7385-432f-aad6-7c25db2fafe2@redhat.com>
 <cf9a8d77-c80f-459f-8a4b-d8b015418b98@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cf9a8d77-c80f-459f-8a4b-d8b015418b98@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27.05.25 07:47, Chenyi Qiang wrote:
> 
> 
> On 5/26/2025 5:08 PM, David Hildenbrand wrote:
>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>> As guest_memfd is now managed by RamBlockAttribute with
>>> RamDiscardManager, only block uncoordinated discard.
>>>
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> ---
>>> Changes in v5:
>>>       - Revert to use RamDiscardManager.
>>>
>>> Changes in v4:
>>>       - Modify commit message (RamDiscardManager->PrivateSharedManager).
>>>
>>> Changes in v3:
>>>       - No change.
>>>
>>> Changes in v2:
>>>       - Change the ram_block_discard_require(false) to
>>>         ram_block_coordinated_discard_require(false).
>>> ---
>>>    system/physmem.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index f05f7ff09a..58b7614660 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block,
>>> Error **errp)
>>>            }
>>>            assert(new_block->guest_memfd < 0);
>>>    -        ret = ram_block_discard_require(true);
>>> +        ret = ram_block_coordinated_discard_require(true);
>>>            if (ret < 0) {
>>>                error_setg_errno(errp, -ret,
>>>                                 "cannot set up private guest memory:
>>> discard currently blocked");
>>> @@ -1939,7 +1939,7 @@ static void ram_block_add(RAMBlock *new_block,
>>> Error **errp)
>>>                 * ever develops a need to check for errors.
>>>                 */
>>>                close(new_block->guest_memfd);
>>> -            ram_block_discard_require(false);
>>> +            ram_block_coordinated_discard_require(false);
>>>                qemu_mutex_unlock_ramlist();
>>>                goto out_free;
>>>            }
>>> @@ -2302,7 +2302,7 @@ static void reclaim_ramblock(RAMBlock *block)
>>>        if (block->guest_memfd >= 0) {
>>>            ram_block_attribute_destroy(block->ram_shared);
>>>            close(block->guest_memfd);
>>> -        ram_block_discard_require(false);
>>> +        ram_block_coordinated_discard_require(false);
>>>        }
>>>          g_free(block);
>>
>>
>> I think this patch should be squashed into the previous one, then the
>> story in that single patch is consistent.
> 
> I think this patch is a gate to allow device assignment with guest_memfd
> and want to make it separately. Can we instead add some commit message
> in previous one? like:
> 
> "Using guest_memfd with vfio is still blocked via
> ram_block_discard_disable()/ram_block_discard_require()."

For the title it should probably be something like:

"physmem: support coordinated discarding of RAM with guest_memdfd"

Then explain how we install the RAMDiscardManager that will notify 
listeners (esp. vfio).

-- 
Cheers,

David / dhildenb


