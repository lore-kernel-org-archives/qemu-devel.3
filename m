Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D27C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW4p-0002a4-89; Fri, 08 Mar 2024 03:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1riW4n-0002ZW-Hu
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1riW4l-0000nV-Rq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G1pdnrWdOsdfosLHxG6IOb5DhKCyfNHTRR0+kPejn+s=;
 b=HRhgzh+Z2N2RAUULzY2yzYHoJmYOmyfEWVv4PH4G1VVepSqt4nBC/s+RESuH7hpkKHNAZd
 GhcuDfoFOQhSamiM1n8nv6B7xXGO9ySIWiK8hxA3ire8dVOV9LMnKlBmcCqOMjTfRlzYZF
 fJZFBrn2INLQwokMpbkqnsMCt5xEQCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-5qtrDflaP2SwyAlQ5RvWGg-1; Fri, 08 Mar 2024 03:59:33 -0500
X-MC-Unique: 5qtrDflaP2SwyAlQ5RvWGg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412d1f1ee7cso9996475e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709888372; x=1710493172;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1pdnrWdOsdfosLHxG6IOb5DhKCyfNHTRR0+kPejn+s=;
 b=oHAzZ+w0NwjGl2eoa64KiBwLW03xWjlpKYWzNxs3wcAYRIP/uxgVEAc79bT+KNHzJj
 AgkacMnk6RmDHCWqo9F5mfU3ng7h2f3KSzFy4RysyMNqnYas6Wr+cQFulxmHtpRGjqFt
 ORXP4eiStQPm/kmb3w+s+clAC5af50m+hp1wAp3hhaKrAAn22Le5S1lqe5FKXdpKtwjQ
 jaxlW5agXLCzEiFgYrNnzpDJ4gQUWX53lPWltfO1YR6vzRU5PO/4Da+DwzHi7hDtP17W
 x5ngaF2NYdquFn2NbWxzyKMAgebwlr4HyMeARXxqQERG03G0jQs+FKrO7h5Dd4+jZMYk
 XnWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmD5MOJ5tyZaF7sbTJvtp7+wemhS0BjeDlDkraFtIF+c39C8ybdiKsRuPty5myjT2LF7y89iKl7B65hzX4fbx78Nqs8GU=
X-Gm-Message-State: AOJu0YwaFEgBz/dvkGe6CTj2Ij6kcLUptQj5NepiT1UAk4Tzytsh+4z5
 XytDwq3v4DF93oEaR1z2Rcs4Tgf+RwZFcTGTXjGMw5dc0Mm1NzOBajAy92/rSVozat0eBBoH6XN
 NRK9IWMWIY7132llR1ihttCxO8L/A0kVcc3Vv+RrCrkn0U7IXdJDP
X-Received: by 2002:a05:600c:b93:b0:413:1aee:65c5 with SMTP id
 fl19-20020a05600c0b9300b004131aee65c5mr471644wmb.37.1709888372040; 
 Fri, 08 Mar 2024 00:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAKBG2g131N0pDfpDXXQDv2toY5P3sCuznXYbd3ULSm3kFJs0QVGQrYgcBxIdfxB2HiXEGxg==
X-Received: by 2002:a05:600c:b93:b0:413:1aee:65c5 with SMTP id
 fl19-20020a05600c0b9300b004131aee65c5mr471631wmb.37.1709888371637; 
 Fri, 08 Mar 2024 00:59:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:3500:5cd0:78d9:ca49:21f3?
 (p200300cbc70735005cd078d9ca4921f3.dip0.t-ipconnect.de.
 [2003:cb:c707:3500:5cd0:78d9:ca49:21f3])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a05600ca08300b0041304100fa9sm5206380wmb.45.2024.03.08.00.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:59:31 -0800 (PST)
Message-ID: <20315e39-549c-44f7-885d-9d0ae568f4f0@redhat.com>
Date: Fri, 8 Mar 2024 09:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] physmem: Fix wrong address in large
 address_space_read/write_cached_slow()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: linuxarm@huawei.com
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
 <20240307153710.30907-5-Jonathan.Cameron@huawei.com>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20240307153710.30907-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On 07.03.24 16:37, Jonathan Cameron wrote:
> If the access is bigger than the MemoryRegion supports,
> flatview_read/write_continue() will attempt to update the Memory Region.
> but the address passed to flatview_translate() is relative to the cache, not
> to the FlatView.
> 
> On arm/virt with interleaved CXL memory emulation and virtio-blk-pci this
> lead to the first part of descriptor being read from the CXL memory and the
> second part from PA 0x8 which happens to be a blank region
> of a flash chip and all ffs on this particular configuration.
> Note this test requires the out of tree ARM support for CXL, but
> the problem is more general.
> 
> Avoid this by adding new address_space_read_continue_cached()
> and address_space_write_continue_cached() which share all the logic
> with the flatview versions except for the MemoryRegion lookup which
> is unnecessary as the MemoryRegionCache only covers one MemoryRegion.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Review from Peter Xu
> - Drop additional lookups of the MemoryRegion via
> address_space_translate_cached() as it will always return the same
> answer.
> - Drop various parameters that are then unused.
> - rename addr1 to mr_addr.
> - Drop a fuzz_dma_read_cb(). Could put this back but it means
>    carrying the address into the inner call and the only in tree
>    fuzzer checks if it is normal RAM and if not does nothing anyway.
>    We don't hit this path for normal RAM.
> ---
>   system/physmem.c | 63 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 1264eab24b..701bea27dd 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3381,6 +3381,59 @@ static inline MemoryRegion *address_space_translate_cached(
>       return section.mr;
>   }
>   
> +/* Called within RCU critical section.  */
> +static MemTxResult address_space_write_continue_cached(MemTxAttrs attrs,
> +                                                       const void *ptr,
> +                                                       hwaddr len,
> +                                                       hwaddr mr_addr,
> +                                                       hwaddr l,
> +                                                       MemoryRegion *mr)

The only thing that is really confusing is

hwaddr len,
...
hwaddr l,

ehm, what?

... but it fits the style of flatview_read_continue(), so at least the 
level of confusion this creates is consistent with the other code.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


