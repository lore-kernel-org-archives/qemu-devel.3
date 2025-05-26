Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8108C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTxO-0007oU-Bg; Mon, 26 May 2025 05:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTxK-0007mE-UB
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTxI-0002HS-Ui
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748251030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vrgnwX+XpO3oZxobtIJdJoGMB7i4IfflekNRWvQhTmg=;
 b=eQ9xRXhmkiyihGB8mbtcnzIkBH2Ye6iCd9SUUpDdup1PHrSuwZfNCjuBJKmrSHKU9AiQ+V
 IXNCOdXyXI0TjN7X8HHdYX7Gg2uGB+fX6tR4c1jpdTUyk8FXEVCxbTreVRSAiiziFPDFNC
 ogYlevcegwV9PI3w2SVIyvSclwyFxRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-rA-3IRVlMz2WV3eVn8n8lA-1; Mon, 26 May 2025 05:17:08 -0400
X-MC-Unique: rA-3IRVlMz2WV3eVn8n8lA-1
X-Mimecast-MFC-AGG-ID: rA-3IRVlMz2WV3eVn8n8lA_1748251027
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so15525415e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251027; x=1748855827;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vrgnwX+XpO3oZxobtIJdJoGMB7i4IfflekNRWvQhTmg=;
 b=abWx50Nqu2+YXZYqacLWRXkzKUb+RDcKVmw8YB0EuzAhnfyWSJLk9L9jMf5Ibis6oa
 88kBnPu1mwPnWmyT61U/tsawl6MsMz1x3Crpqn+uCSvdmUk8Zd6wNYVIiAE+3pEuUaCO
 IwB81lsLbdS4mKfIUhULdgzuFMylhmhyfj1ff+v8YnfWfo9uOnczOKsfzaAqOVX6Sh2W
 Zek5QnruOrbWuYjaSLMjZArHXmOErw16+R4oH2y3NWa/RmHMkAAitM/wR3EYshM2elzm
 v5yXPUYyfSNnGq+CWSQ4qGPAbkoqCsrK5jcQOdb24s6BsIfkrAFczDZ0jbR5LtJ7nfUZ
 TwMg==
X-Gm-Message-State: AOJu0Yz4XXDh0A000MwVmBduqMs2abCle4TP+/1PPVnvDiqQ3A/0JnHN
 AmMSeBkN/3u5Qpgcoz6VkQXtObjCQHpI6j0i9mTwNvIKcGxJi7QjyZ+S3KMnqoVoaXxhCxRXBtj
 AtmkELAB4GltJRf8dgXE2xV5fGl/zp+ROpWGG668hQ4fzJW+TqRBWrzj+
X-Gm-Gg: ASbGncvzzbdq0THJRbLdXoV5PDaC/31xAsFUKlOnTGT6sWiMVvTkBxBXJyzz1aoiWNh
 +0QJi4Lnc1tl9yBU+3G5+WUHoiO06eAB5E2d6q4KjzRd7vlPLXj0L40nUI6Fc8FLiYPiJ0iJF0X
 N8RX7Fh74ceoCQq+/SlcPhJSpW4fPLh3//hidf/RW5DGSxXwh3dd4HiZNCiEizSe5oGJbkckUeM
 DtrtdY4RhnXByuGWK5yDQfzNQsVFqwlYP/CUhqEnOhm1bBRkWrz6VPAFfYW79eCUb7iYqKP47b4
 6+0K2LJUHu13grUs4BhVGrG9CtveRalPGt0HPpzfh8Ey1s4AU+NMrKkzlnfxIk3u97uHt77zz5e
 WArtJhMfnL/SwL3e0MudiNGrettCyrwe6TUzO9oI=
X-Received: by 2002:a05:6000:40ce:b0:3a4:dd02:f566 with SMTP id
 ffacd0b85a97d-3a4dd02f6admr831238f8f.22.1748251027289; 
 Mon, 26 May 2025 02:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAitxi3kXFt+sI/5NwSXKjBu+jB+tHOfkfiw7eNaviG6loQkSMcXUPVMmhcpMahbRnI5Nisg==
X-Received: by 2002:a05:6000:40ce:b0:3a4:dd02:f566 with SMTP id
 ffacd0b85a97d-3a4dd02f6admr831214f8f.22.1748251026872; 
 Mon, 26 May 2025 02:17:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4dc1172ecsm1414743f8f.48.2025.05.26.02.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:17:06 -0700 (PDT)
Message-ID: <6b5957fa-8036-40b6-b79d-db5babb5f7b9@redhat.com>
Date: Mon, 26 May 2025 11:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] ram-block-attribute: Add more error handling
 during state changes
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
 <20250520102856.132417-11-chenyi.qiang@intel.com>
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
In-Reply-To: <20250520102856.132417-11-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20.05.25 12:28, Chenyi Qiang wrote:
> The current error handling is simple with the following assumption:
> - QEMU will quit instead of resuming the guest if kvm_convert_memory()
>    fails, thus no need to do rollback.
> - The convert range is required to be in the desired state. It is not
>    allowed to handle the mixture case.
> - The conversion from shared to private is a non-failure operation.
> 
> This is sufficient for now as complext error handling is not required.
> For future extension, add some potential error handling.
> - For private to shared conversion, do the rollback operation if
>    ram_block_attribute_notify_to_populated() fails.
> - For shared to private conversion, still assert it as a non-failure
>    operation for now. It could be an easy fail path with in-place
>    conversion, which will likely have to retry the conversion until it
>    works in the future.
> - For mixture case, process individual blocks for ease of rollback.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   system/ram-block-attribute.c | 116 +++++++++++++++++++++++++++--------
>   1 file changed, 90 insertions(+), 26 deletions(-)
> 
> diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
> index 387501b569..0af3396aa4 100644
> --- a/system/ram-block-attribute.c
> +++ b/system/ram-block-attribute.c
> @@ -289,7 +289,12 @@ static int ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
>           }
>           ret = rdl->notify_discard(rdl, &tmp);
>           if (ret) {
> -            break;
> +            /*
> +             * The current to_private listeners (VFIO dma_unmap and
> +             * KVM set_attribute_private) are non-failing operations.
> +             * TODO: add rollback operations if it is allowed to fail.
> +             */
> +            g_assert(ret);
>           }
>       }
>   

If it's not allowed to fail for now, then patch #8 does not make sense 
and should be dropped :)

The implementations (vfio) should likely exit() instead on unexpected 
errors when discarding.



Why not squash all the below into the corresponding patch? Looks mostly 
like handling partial conversions correctly (as discussed previously)?

> @@ -300,7 +305,7 @@ static int
>   ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>                                           uint64_t offset, uint64_t size)
>   {
> -    RamDiscardListener *rdl;
> +    RamDiscardListener *rdl, *rdl2;
>       int ret = 0;
>   
>       QLIST_FOREACH(rdl, &attr->rdl_list, next) {
> @@ -315,6 +320,20 @@ ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>           }
>       }
>   
> +    if (ret) {
> +        /* Notify all already-notified listeners. */
> +        QLIST_FOREACH(rdl2, &attr->rdl_list, next) {
> +            MemoryRegionSection tmp = *rdl2->section;
> +
> +            if (rdl == rdl2) {
> +                break;
> +            }
> +            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +                continue;
> +            }
> +            rdl2->notify_discard(rdl2, &tmp);
> +        }
> +    }
>       return ret;
>   }
>   
> @@ -353,6 +372,9 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
>       const int block_size = ram_block_attribute_get_block_size(attr);
>       const unsigned long first_bit = offset / block_size;
>       const unsigned long nbits = size / block_size;
> +    const uint64_t end = offset + size;
> +    unsigned long bit;
> +    uint64_t cur;
>       int ret = 0;
>   
>       if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
> @@ -361,32 +383,74 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
>           return -1;
>       }
>   
> -    /* Already discard/populated */
> -    if ((ram_block_attribute_is_range_discard(attr, offset, size) &&
> -         to_private) ||
> -        (ram_block_attribute_is_range_populated(attr, offset, size) &&
> -         !to_private)) {
> -        return 0;
> -    }
> -
> -    /* Unexpected mixture */
> -    if ((!ram_block_attribute_is_range_populated(attr, offset, size) &&
> -         to_private) ||
> -        (!ram_block_attribute_is_range_discard(attr, offset, size) &&
> -         !to_private)) {
> -        error_report("%s, the range is not all in the desired state: "
> -                     "(offset 0x%lx, size 0x%lx), %s",
> -                     __func__, offset, size,
> -                     to_private ? "private" : "shared");
> -        return -1;
> -    }
> -
>       if (to_private) {
> -        bitmap_clear(attr->bitmap, first_bit, nbits);
> -        ret = ram_block_attribute_notify_to_discard(attr, offset, size);
> +        if (ram_block_attribute_is_range_discard(attr, offset, size)) {
> +            /* Already private */
> +        } else if (!ram_block_attribute_is_range_populated(attr, offset,
> +                                                           size)) {
> +            /* Unexpected mixture: process individual blocks */
> +            for (cur = offset; cur < end; cur += block_size) {
> +                bit = cur / block_size;
> +                if (!test_bit(bit, attr->bitmap)) {
> +                    continue;
> +                }
> +                clear_bit(bit, attr->bitmap);
> +                ram_block_attribute_notify_to_discard(attr, cur, block_size);
> +            }
> +        } else {
> +            /* Completely shared */
> +            bitmap_clear(attr->bitmap, first_bit, nbits);
> +            ram_block_attribute_notify_to_discard(attr, offset, size);
> +        }
>       } else {
> -        bitmap_set(attr->bitmap, first_bit, nbits);
> -        ret = ram_block_attribute_notify_to_populated(attr, offset, size);
> +        if (ram_block_attribute_is_range_populated(attr, offset, size)) {
> +            /* Already shared */
> +        } else if (!ram_block_attribute_is_range_discard(attr, offset, size)) {
> +            /* Unexpected mixture: process individual blocks */
> +            unsigned long *modified_bitmap = bitmap_new(nbits);
> +
> +            for (cur = offset; cur < end; cur += block_size) {
> +                bit = cur / block_size;
> +                if (test_bit(bit, attr->bitmap)) {
> +                    continue;
> +                }
> +                set_bit(bit, attr->bitmap);
> +                ret = ram_block_attribute_notify_to_populated(attr, cur,
> +                                                           block_size);
> +                if (!ret) {
> +                    set_bit(bit - first_bit, modified_bitmap);
> +                    continue;
> +                }
> +                clear_bit(bit, attr->bitmap);
> +                break;
> +            }
> +
> +            if (ret) {
> +                /*
> +                 * Very unexpected: something went wrong. Revert to the old
> +                 * state, marking only the blocks as private that we converted
> +                 * to shared.
> +                 */
> +                for (cur = offset; cur < end; cur += block_size) {
> +                    bit = cur / block_size;
> +                    if (!test_bit(bit - first_bit, modified_bitmap)) {
> +                        continue;
> +                    }
> +                    assert(test_bit(bit, attr->bitmap));
> +                    clear_bit(bit, attr->bitmap);
> +                    ram_block_attribute_notify_to_discard(attr, cur,
> +                                                          block_size);
> +                }
> +            }
> +            g_free(modified_bitmap);
> +        } else {
> +            /* Complete private */
> +            bitmap_set(attr->bitmap, first_bit, nbits);
> +            ret = ram_block_attribute_notify_to_populated(attr, offset, size);
> +            if (ret) {
> +                bitmap_clear(attr->bitmap, first_bit, nbits);
> +            }
> +        }
>       }
>   
>       return ret;


-- 
Cheers,

David / dhildenb


