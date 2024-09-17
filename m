Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D192C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTbb-0007s5-B8; Tue, 17 Sep 2024 04:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqTbS-0007oH-4L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqTbH-0005Gf-0l
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726561818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SX1SvKc3qhJA9BweqWQ5wzEbAblN1yICrre03rlBHb0=;
 b=SnbMFBlZVSRLpEnsI/ZsZOo9ffRp3l0FYKo4U21rwe1tOZriwoL3JCulihO1FnUi9hOoqn
 tsoljfXGWl77tz/ZZ5ks2GiDtmtbD9ahv/N0LhdQBk+PTmzAHzlO6qR2TPM6iGzuVTOSEh
 ISxDAQKWO9NgcciqFJIA5FCGJoO0aa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-03E8FGCKM2WxI23L1_ezBw-1; Tue, 17 Sep 2024 04:29:09 -0400
X-MC-Unique: 03E8FGCKM2WxI23L1_ezBw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso42101005e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726561748; x=1727166548;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX1SvKc3qhJA9BweqWQ5wzEbAblN1yICrre03rlBHb0=;
 b=Apt6UqD6t+P+tMUGDnPzSVGXp8SQ/7W4fwO7Gcw6bEsy9O8z4bDdHmockQVnslQqZr
 ooq2AxvQmzv0wzL0Nb3oLV9DawWb+MXS7TRj9fs7A2i/tZpocwW1kucdBO1q4phZh/TR
 mjzgEYdvXHx8L5nTwkNITmTaQevHncb62rDL0P50BVFiR+25jROhIw6klfKuVykaLUk8
 HciDPYpjQyITVGzu620Cmj5hNrhAY2Ic0+UAYqY+fc36TaM2qd0uNQsEFkr+7k+aW0m/
 lQUW+zQ77zv6d8yYkFZNSxRtjIXx98XIFDVN3vMcCUoPnn8MYuS6WEuP3bI6hKKEsmxj
 OmRA==
X-Gm-Message-State: AOJu0Yx3fK/Z99ncGW/kZgGo79drlgTBMcrKm+jFvF1dCbLoj3UxGT0K
 phLt7BUVQdqd2dma6OYcPerPfN2fRBO01gnb5eOMVByrI5W5MmLhn2w7j7r3nN/ufmk83/A4RMS
 Xo54XGrkw8dDkoR0NaHqFIIDEGopmUHSqarJ8U0fmzWwbBWzUHkn+pVAe92Br
X-Received: by 2002:a05:600c:4ed2:b0:42c:af06:703 with SMTP id
 5b1f17b1804b1-42cdb5753a0mr124543355e9.31.1726561748495; 
 Tue, 17 Sep 2024 01:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbV5wu3KR2jIsW00lAY7iY+T6WrIkK8gJkjzvGjSm+4tbcNNQsG++QIsLPUorhc8Dc69HDCQ==
X-Received: by 2002:a05:600c:4ed2:b0:42c:af06:703 with SMTP id
 5b1f17b1804b1-42cdb5753a0mr124543085e9.31.1726561747964; 
 Tue, 17 Sep 2024 01:29:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:8f00:64ad:8ae8:6ebc:e3e2?
 (p200300cbc7068f0064ad8ae86ebce3e2.dip0.t-ipconnect.de.
 [2003:cb:c706:8f00:64ad:8ae8:6ebc:e3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b054dd3sm130251435e9.5.2024.09.17.01.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 01:29:07 -0700 (PDT)
Message-ID: <8643546e-efb7-460d-a1f8-89251022a3d1@redhat.com>
Date: Tue, 17 Sep 2024 10:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem: Apply merge property after the memory region is
 initialized
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240915233117.478169-1-gshan@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20240915233117.478169-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16.09.24 01:31, Gavin Shan wrote:
> The semantic change has been introduced by commit 5becdc0ab0 ("hostmem:
> simplify the code for merge and dump properties") even it clarifies that
> no senmatic change has been introduced. After the commit, the merge
> property can be applied even the corresponding memory region isn't
> initialized yet. This leads to crash dump by the following command
> lines.
> 
>    # /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64  \
>      -accel kvm  -machine virt -cpu host                      \
>      -object memory-backend-ram,id=mem-memN0,size=4096M,merge=off
>      :
>      qemu-system-aarch64: ../system/memory.c:2419: memory_region_get_ram_ptr: \
>      Assertion `mr->ram_block' failed.
> 
> Fix it by applying the merge property only when the memory region is
> initialized.
> 
> Fixes: 5becdc0ab083 ("hostmem: simplify the code for merge and dump properties")
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   backends/hostmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 4e5576a4ad..181446626a 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -178,7 +178,7 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
>           return;
>       }
>   
> -    if (!host_memory_backend_mr_inited(backend) &&
> +    if (host_memory_backend_mr_inited(backend) &&
>           value != backend->merge) {
>           void *ptr = memory_region_get_ram_ptr(&backend->mr);
>           uint64_t sz = memory_region_size(&backend->mr);

Thanks, queued to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


