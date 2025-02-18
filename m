Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D47C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPnL-00086W-PI; Tue, 18 Feb 2025 10:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tkPnG-00086B-IZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tkPnE-0003RC-Fx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNQ2XNfElEwbmT0QaEglmXQcqeqTJVVES9TIY7DE+lo=;
 b=AodyBtQpcH9iHpAZyvS9PXvB5CAgLNATt2si4rkKWPaR8EBQ8tuToWvYu1mOGKZ1sxgyW7
 Mfk1YvNjndOt0h18/FPwcdeh/oY8BBiv2FDuVyF6XNr/Q8dWK206sE6wPyFQJAijj7iK5c
 4QZKqjZuwcusLa+2raZwlShNQqAqa4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500--lpOtgbiODqMmwitsXxrhA-1; Tue, 18 Feb 2025 10:45:49 -0500
X-MC-Unique: -lpOtgbiODqMmwitsXxrhA-1
X-Mimecast-MFC-AGG-ID: -lpOtgbiODqMmwitsXxrhA_1739893548
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43935e09897so47186595e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739893548; x=1740498348;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNQ2XNfElEwbmT0QaEglmXQcqeqTJVVES9TIY7DE+lo=;
 b=N4yKCwjpRK735Jzi3j6VMYe5c1yb6b1GXA+HjG4+TMhygRXiyj5YVNyIgRWnZKlUV7
 2tig30a/+KcUVdvN1BAk8MCqsVKsrgIvZTbuNXQ5k7tk73R5asKV4Cmi35E8Ve2VFEdo
 Oy+lBSi0oT9eo5knEXppsowAK/8YltiSM+3v7ck9VAexD190q7haOqHJpDISQhbCnkcq
 lAbPJONp8KXLDNa6YAf3sF9Q1mNMAT6izWCD2HHKb6vByPf5sXvHM3zZChaWMy0Kpm0a
 nvr8aq6sJbyfAVT2yzxEzpBMrWR/7tCuXabOKrZmsqv6HrolsFjTtAQm0YHBAwkb7iA6
 FTzQ==
X-Gm-Message-State: AOJu0YwX3T8vXB5++CLYQS3IzMwn4isLkHc4hkvUMnNgy9ugJAErPR1S
 nKA1CSX3PTYlYJQGopFtDZYAycGo+Uy86cE6SqHqK6int6EEP+ic+7We5iXs64VYzbEyKVuC5NJ
 WmzPc+Ko3QCmlCaOdueudaGoPVIye6CXm9GHVm7L+ms688BOieULtc9aNXil8fz6k3bSvtmOEcX
 +8nQv73M+D2fDeHXTFnpuz1see4tu8DCjg0V8=
X-Gm-Gg: ASbGnctsHPhIdKB6LlAryDUA465GDe+aJo2/5qzCd6X5zg2F9kUaofXDKpcUSkrLpWa
 OTeTxA1+am9njO93fm6aCc3sd9d141LKUjsnYBeMaj5etnT8ZOVegk39bc/46TOUEo69vIXlUrv
 wRZdUx4dxaDFo9ZPkbPjR3GaDl3Wm+HxRoGakqNmykKCpFTXrZJsCf12zSgM4l3hbNvBKV3znA9
 UD+mA+uS0Y3bAfBipstGT02CtpCa/Gj1bQjoQ+pIJmGIoo476zWI9Xyj9y90gxk4wraM6EuhEgK
 ycYiQMVLVpiIiGybs4TOQxAQs2ucUjkzhrI6UVERPDZVJLFKvXm09PigD2wLGp65ej3OMpQAul7
 2CzFSnv+xf6W07hLkcOai8LwJHwgZSHUo
X-Received: by 2002:a05:600c:3ba6:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43999dd1f1dmr754485e9.21.1739893548019; 
 Tue, 18 Feb 2025 07:45:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvbFP0cCWvaSCkEL8TmSq85dKzYOYadFymi8tzlDJ16RKbaKy/yogQaJdVMmQ84Epvw5xB2g==
X-Received: by 2002:a05:600c:3ba6:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43999dd1f1dmr754195e9.21.1739893547508; 
 Tue, 18 Feb 2025 07:45:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af?
 (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de.
 [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65bcsm15418407f8f.65.2025.02.18.07.45.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:45:46 -0800 (PST)
Message-ID: <9ce7fbe6-7a74-4749-8de6-c601c386214a@redhat.com>
Date: Tue, 18 Feb 2025 16:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace assertion with error
To: qemu-devel@nongnu.org
References: <20250217120812.396522-1-pbonzini@redhat.com>
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
In-Reply-To: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17.02.25 13:08, Paolo Bonzini wrote:
> It is possible to start QEMU with a confidential-guest-support object
> even in TCG mode.  While there is already a check in qemu_machine_creation_done:
> 
>      if (machine->cgs && !machine->cgs->ready) {
>          error_setg(errp, "accelerator does not support confidential guest %s",
>                     object_get_typename(OBJECT(machine->cgs)));
>          exit(1);
>      }
> 
> the creation of RAMBlocks happens earlier, in qemu_init_board(), if
> the command line does not override the default memory backend with
> -M memdev.  Then the RAMBlock will try to use guest_memfd (because
> machine_require_guest_memfd correctly returns true; at least correctly
> according to the current implementation) and trigger the assertion
> failure for kvm_enabled().  This happend with a command line as
> simple as the following:
> 
>      qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
>         -M q35,kernel-irqchip=split,confidential-guest-support=sev0
>      qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   system/physmem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9daad..1ddf9fb10d0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       if (new_block->flags & RAM_GUEST_MEMFD) {
>           int ret;
>   
> -        assert(kvm_enabled());
> +        if (!kvm_enabled()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }
>           assert(new_block->guest_memfd < 0);
>   
>           ret = ram_block_discard_require(true);


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


