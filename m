Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76638C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRi2-0006S3-IL; Mon, 27 Jan 2025 11:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcRhz-0006RM-TZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcRhx-0001CN-Om
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737994286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rSokMoa/GUwQuwEHeU1bTQwF7QWHPjzMYDdvzsS+rWU=;
 b=jCscr1Fi9qdwehDMzgs3s57WbO+WBfmdgWWhy35gzX+ojrvbkEEMfu8gGGNQACp91Uvvzd
 b5TnCfgy5UDuzEP8kMDHmZnyuJFAW1VsW27i210dft1lf4llEYCWCNpEKzd15nqUSL6KTy
 +DhL6ux6gSpgDZ4CWFB9/ldA4WY1rK4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-obS0diWaNCWGuqvYM9kIqw-1; Mon, 27 Jan 2025 11:11:24 -0500
X-MC-Unique: obS0diWaNCWGuqvYM9kIqw-1
X-Mimecast-MFC-AGG-ID: obS0diWaNCWGuqvYM9kIqw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso1893051f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994284; x=1738599084;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rSokMoa/GUwQuwEHeU1bTQwF7QWHPjzMYDdvzsS+rWU=;
 b=dBdpnCFkpnOYjmGoiCyIneg0QX4n6yI4G1Oee66TV0BQO3JAjQM36Fn5mEFTG5PCRj
 488RD6Y3cQ2OxPx11WR27dIVwBPNObthiQFT3Ijw9gPFnp/9g1snZUQDIxvpE16Mf0FS
 /MjGaw5JSxOqUnHn+hoP5afmqiPEaRBSeljMbBtIqWRGKZVl14jtB4iunuhPhiQELTzS
 O1gcRUGiuZ2Rkx3lW1HzsGSVa16721Z0MeSsxIu+DZHEKb1TPk4E6qrXYfNsO4x0HM/n
 wTMtUyfWjR5ZybL5/Qxqvs2tUukqZJUHu6ZHqF20TuKrL2Dq8FjR6ETKQ3BDRtmh37dk
 gyOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7GsCKe8GxDa0GWFYoyRlAfe5EWlbcqGipX+CNwMZCknaog41RfUZHvn4VmEv7wTWUd3utdCjnewG@nongnu.org
X-Gm-Message-State: AOJu0YxKYtf6sHWCS2Om9bebIQorc1JNL3Xtmefg27m33wFdaMD1ZwxE
 XiWPrj4Nj0lWMnBmqINdBJiLDRf/6vYxlXbKJxBMyFuYhjrCF8WD5dx04TupWzBGT8+hZW339Tb
 CPq4WG+iGR9cotpcRm8OYFLmmgR7seAvLF5lhOHBsq40UHd6R+iY/
X-Gm-Gg: ASbGncu4lY/S0R8knhoZKVJGdACxKoSACmHC/kB/RNKDG8MMBBH6J9xQsUzCH1uWXmD
 7k23AaZCnt7A9r9eu1z+Zrz3FidjnNGlVRXWu9WQOogbA4HYAYUWCgyMy4SrMH/3ZceMhV+2vIy
 7FWsOgfsVFSfmGbu6PbHE/7MHaYfAeFMkW93qkACiyx+RLkz+AIh2f4jK8SPTtzVI9RWqveiegv
 db0f8+VDIaKuD7bPoctM6UAEdCxir2YKJ5G2xnYuHFQMu4ZTrDT+buJG6V1SQXR2+/GuNpfYTkj
 qwxzHuSrClHb99t6ccELPTJochoE0/YRpAn4REuYKUUKIbM0k5mRg3uzEUCILt+TMV3yvnNT0lt
 GSdo03zpGtw1t17+UWY6U+Fs0qC7IjCQf
X-Received: by 2002:a5d:6dae:0:b0:388:e3e6:69cb with SMTP id
 ffacd0b85a97d-38bf59e1fcfmr33863072f8f.37.1737994283785; 
 Mon, 27 Jan 2025 08:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8RLxIQ8rKBNwNbEQ16toc/7pFmL2I6V/zHPpi3nPr+Re/jils/z6ws5Fw0VxFNF+OHsj7Sw==
X-Received: by 2002:a5d:6dae:0:b0:388:e3e6:69cb with SMTP id
 ffacd0b85a97d-38bf59e1fcfmr33863043f8f.37.1737994283403; 
 Mon, 27 Jan 2025 08:11:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c?
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm11648605f8f.10.2025.01.27.08.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 08:11:22 -0800 (PST)
Message-ID: <b9452ab4-f40e-4f9f-94b7-31684db9c12c@redhat.com>
Date: Mon, 27 Jan 2025 17:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] virtio-mem-pci: Allow setting nvectors, so we can
 use MSI-X
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <20250127142824.494644-1-david@redhat.com>
 <20250127142824.494644-2-david@redhat.com>
 <688893cb-6ebd-4fec-b1a8-2d54d8f9225f@redhat.com>
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
In-Reply-To: <688893cb-6ebd-4fec-b1a8-2d54d8f9225f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27.01.25 16:28, Thomas Huth wrote:
> On 27/01/2025 15.28, David Hildenbrand wrote:
>> Let's do it similar as virtio-balloon-pci. With this change, we can
>> use virtio-mem-pci on s390x, although plugging will still fail until
>> properly wired up in the machine.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/core/machine.c          |  3 +++
>>    hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
>>    2 files changed, 15 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 8f396ef803..5e1d9e12ef 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,9 @@ GlobalProperty hw_compat_9_2[] = {
>>        { "virtio-balloon-pci", "vectors", "0" },
>>        { "virtio-balloon-pci-transitional", "vectors", "0" },
>>        { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>> +    { "virtio-mem-pci", "vectors", "0" },
>> +    { "virtio-mem-pci-transitional", "vectors", "0" },
>> +    { "virtio-mem-pci-non-transitional", "vectors", "0" },
> 
>    Hi!
> 
> Do we need the entries fo the -transitional and -non-transitional devices?
> Since virtio-mem is rather new, I would expect that those should not exist
> here? E.g. virtio-balloon-pci.c has:
> 
>       .transitional_name     = "virtio-balloon-pci-transitional",
>       .non_transitional_name = "virtio-balloon-pci-non-transitional",
> 
> but there are no such entries in virtio-mem-pci.c ... ?

Oh, very good point. Yes, I think we can just drop this legacy stuff.

Thanks!

-- 
Cheers,

David / dhildenb


