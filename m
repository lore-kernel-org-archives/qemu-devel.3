Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB78ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4LbX-00082f-TN; Thu, 02 Oct 2025 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4LbU-00080F-HQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4LbG-0001Xw-ED
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759420317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3D4gNDHRD12NV0TPCdDhtyxZEZkaPtnBihphuKahckw=;
 b=RKrCEWcw88T35eBsKMwa+Afzhp927dF3N7GM7xlSV86lCRW9k9RqPVKcZnnXIRzgQ3jNxN
 9TzG01TFA7sW4vuynZy5nU51+J8T4q/NSZUZTWOYxo7l5kNzcgNgWl/KlpQrP1z1Sh6QlC
 avohnTlOsSBuJ1IwWQdqiEOCOmuxbHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-x18h4SJZPpGsRaNkhtSulg-1; Thu, 02 Oct 2025 11:51:53 -0400
X-MC-Unique: x18h4SJZPpGsRaNkhtSulg-1
X-Mimecast-MFC-AGG-ID: x18h4SJZPpGsRaNkhtSulg_1759420312
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e25f5ed85so9192315e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 08:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759420312; x=1760025112;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3D4gNDHRD12NV0TPCdDhtyxZEZkaPtnBihphuKahckw=;
 b=nIhBmlB9nxoP2f2vxf5CBwarer7Nh9h88UQw1umkVqvlZspO1a2brjqNimyl3dvADi
 t3zcZZTHjtGeMF1brkWdRuCAUCzCzk8MPMWQ9o/CZENBI30rPZJnQWHJgxQRW4UbPyUF
 Nb99XDshphg/mMQq7ynfxsRZQiutCcjESW+YUEjJJZhotJAUcmKafJhbA0yTGXYBLUBS
 O/uYitrsCKzM9vOnNZQ22lYofxFCYidC+PTTU3jPHSJG6qK6BCTaJgFlyVgrVkO3s30L
 of7laFlRnmEvzfppi6c6VPaeWdW+BkpeEEqOOjE0I2NpRxxnkigXr8vUQTikRlT+/p1b
 RHSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0osev6CxhJrvRf8S4b54VQR791oAXFS4+muHFfTS97qDxZlEZn4SP9rtzVVQsBLS3EfzQgt7MBG74@nongnu.org
X-Gm-Message-State: AOJu0YyfNTy3I/ppZdnjAilhhinLmfoUt/4iEnZ2WX+o08son8i0kzsy
 ofFdrLgt8WayokAH8Oy6BYhOyOnfGqNqXPvGwlz14vtirMQP4P2iAPMHPIItJgsDlMdPXflqLhZ
 0YNEwo6HzrDyA4OONFCKi5L1iNRbfFRl+Nk9p1ayTCyzmezyqOduqhxAe
X-Gm-Gg: ASbGnct1Biz8A/rbay454srt6DOFN2XWLzfSg/BAZqm9saoMkJmAaHZ3N5ZgXkUcfxu
 ykg6ISRinq2YsUsdC4iRiVdGG35WmxyhNSG4zXSE9qIvKRgyNMz1otWo7qih/HxlaJd5NeFBvN0
 W1p8ItJUYtnnwrIJwC6IYCcQZOmcokBplTAr3ugWGD2l3s6LgH7QW8VvREpoVtSwGQeHILwPe/m
 o2vfEAmCyBs9wL0BkHyWNf/grL7WnlIi3J01cfoV05G2FDPKwMdnpYy8pTdiy0ITgWSLBBJkUaH
 DP1FinSqKefGEXrkh/aEG9PttjNQvIfll6OHKWyFka+5XHcF/qYyFI7fDIHpKRw7LL65Nr2hA/u
 05DFcG67C
X-Received: by 2002:a05:600c:34c9:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e6126a54dmr73444385e9.24.1759420312407; 
 Thu, 02 Oct 2025 08:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5DK2XWgbxs1uXA611g4DmGaT2zQ5+ADngi0DNaH8bk90oWBMmBdv86g5RbmxmhHMLvGN6Qg==
X-Received: by 2002:a05:600c:34c9:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e6126a54dmr73444185e9.24.1759420311956; 
 Thu, 02 Oct 2025 08:51:51 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com.
 [80.187.80.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0204fsm89478225e9.14.2025.10.02.08.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 08:51:51 -0700 (PDT)
Message-ID: <6e7ad90d-a467-40cc-99fa-d0915438dd05@redhat.com>
Date: Thu, 2 Oct 2025 17:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
To: Igor Mammedov <imammedo@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
 <20251002161140.5b908e06@fedora>
 <aa461a43-0db8-482a-aabc-897cfa619dee@redhat.com>
 <20251002165936.490718f5@fedora>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251002165936.490718f5@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 02.10.25 16:59, Igor Mammedov wrote:
> On Thu, 2 Oct 2025 16:19:00 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 02.10.25 16:11, Igor Mammedov wrote:
>>> On Wed, 24 Sep 2025 18:33:23 +0800
>>> fanhuang <FangSheng.Huang@amd.com> wrote:
>>>    
>>>> Hi David,
>>>>
>>>> I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.
>>>>
>>>> Previous Discussion Summary
>>>> ===========================
>>>> Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:
>>>>
>>>> Original Approach (December 2024)
>>>> ----------------------------------
>>>> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
>>>> - QEMU cmdline example:
>>>>     -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
>>>>     -numa node,nodeid=1,memdev=m1
>>>>
>>>> Your Concerns and Suggestions
>>>> -----------------------------
>>>> You correctly identified some issues with the original approach:
>>>> - Configuration Safety: Users could create problematic configurations like:
>>>>      -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on
>>>>
>>>> - Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
>>>>      -numa node,nodeid=1,memdev=m1,spm=on
>>>
>>> that seems to me a bit backwards,
>>> aka it's just a particular case where node would have SPM memory only,
>>> which (spm) is not a property of numa node, but rather of memory device attached to it.
>>
>> The problem is that boot memory is not modeled as a memory device.
> 
> That's historical abomination we currently have.

Right, and that's what the memdev= parameter for the node is all about.

> Question is: does it have to be boot memory, and why?

I wondered the same in my reply: I'm afraid it cannot be a DIMM/NVDIMM, 
these ranges are only described in E820 as "hotplug area".

I think it must be something that's present in the memory map right from 
the start, where the OS would identify it as SP and treat it accordingly.

> 
> Also that's why I've asked for use-cases / devices example that would make use of this feature
> (VFIO was mentioned here).

Yes, good point.

-- 
Cheers

David / dhildenb


