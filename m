Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AB6C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCISG-0004Jf-LF; Wed, 29 May 2024 08:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCISF-0004Hg-1O
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCIS9-0004lT-MA
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716985847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rbBdhQhm/uqGe7RLXvABuoXrBqU73BjuA0oq49zaLy0=;
 b=EZp0EbGmq9e+qqfoTGBoPMo1HN2R8u4GVYbGXEEIhIL5+3d4ZqL4v30ICVIwq1GCV8DLPG
 P19tTUI7jTavsh2CN5PAh+3gudKmSd9legrPMHEZJDZvBqC6fV6KSBrpQZGohRWtx4Lta2
 MFVO0ymFVQYlr1tvhb1M7g+zDQz8vRg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TOKgLJu0PEqU1cNfl3l_Ig-1; Wed, 29 May 2024 08:30:45 -0400
X-MC-Unique: TOKgLJu0PEqU1cNfl3l_Ig-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2e95a1eba87so19033761fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716985843; x=1717590643;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbBdhQhm/uqGe7RLXvABuoXrBqU73BjuA0oq49zaLy0=;
 b=E+2uyE1y8jcECpkAsng+9FcXx7QepfCn9QRfgVGwi9iO293QvTEi/GSH0UGSB89MOo
 SmGUQZB/FdHFwKKiZvORgGmi3ow+hIh/wHp85OofVibJ/V4fY2SHcC2iH4PZdH2z0Tdg
 zepqaCwT87Po7Wrk6VYA+GQuoryKJCDHvTuMGIefvRYnDVB+kAdCSGwBbX0YHTKSDumT
 EJ30C7bO0isg0Tb7xamMqaIOP2jYXcMd3yqXl/AcQ0ARLxOGeiOVqdjK/362IXuk9QZ3
 hht3kp4YgLgNhUWGVaHKEzcZsSPWwECAc2bmUKEdIX+MBR+pLF4Vt1YmZ2bcyudsExdh
 qxkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwSylcqwBQo+S1JTRHOTHKKphRSHwLGIb7z0mPVklMxchx1iJSFade9z4yurBDWjE3VgfDjK6Ql0SkhOllEHo/W9X2jiA=
X-Gm-Message-State: AOJu0YzFas9gtitW2Yw07puMaarQ7xmDTLs4eJDCBnRyjFX29hjBGc4D
 fhlIZzduQkME6otdhN8lxQvDf3ozRFTz6XpMyj+9Nj9Beayd0sHzJ68z0uD6kM935u61zAg715P
 rprNO3Xh7Tp9nR6t8UTLWFtAR4C2domE+h20KO4Z9qvxzmXzRj9UT
X-Received: by 2002:a2e:a168:0:b0:2d4:3e82:117e with SMTP id
 38308e7fff4ca-2e95b240160mr100682121fa.32.1716985843711; 
 Wed, 29 May 2024 05:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCfY6Am50JQkiGOWadzmhDU3qE5xAF/vOJTvRp2nYXoTYVJpKkCPa7MIpNs+mQbeNV4bevg==
X-Received: by 2002:a2e:a168:0:b0:2d4:3e82:117e with SMTP id
 38308e7fff4ca-2e95b240160mr100681891fa.32.1716985843127; 
 Wed, 29 May 2024 05:30:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:3c00:686e:317c:3ed4:d7b8?
 (p200300cbc70c3c00686e317c3ed4d7b8.dip0.t-ipconnect.de.
 [2003:cb:c70c:3c00:686e:317c:3ed4:d7b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fad7fasm211103415e9.38.2024.05.29.05.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 05:30:42 -0700 (PDT)
Message-ID: <8a446e76-238f-410f-ad43-1821117b6e94@redhat.com>
Date: Wed, 29 May 2024 14:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backends/hostmem: Round up memory size for
 qemu_madvise() and mbind()
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1716912651.git.mprivozn@redhat.com>
 <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
 <57fabde4-3282-4d10-aaa6-e14c2169d893@redhat.com>
 <2b46e524-15b3-4c47-af50-1baa2b4c160d@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2b46e524-15b3-4c47-af50-1baa2b4c160d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On 29.05.24 08:48, Michal Prívozník wrote:
> On 5/28/24 18:47, David Hildenbrand wrote:
>> Am 28.05.24 um 18:15 schrieb Michal Privoznik:
>>> ./build/qemu-system-x86_64 \ -m
>>> size=8389632k,slots=16,maxmem=25600000k \ -object
>>> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"hugepages2M","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \ -numa node,nodeid=0,cpus=0,memdev=ram-node0
>>
>> For DIMMs and friends we now (again) enforce that the size must be
>> aligned to the page size:
>>
>> commit 540a1abbf0b243e4cfb4333c5d30a041f7080ba4
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Wed Jan 17 14:55:54 2024 +0100
>>
>>      memory-device: reintroduce memory region size check
>>
>>      We used to check that the memory region size is multiples of the
>> overall
>>      requested address alignment for the device memory address.
>>
>>      We removed that check, because there are cases (i.e., hv-balloon) where
>>      devices unconditionally request an address alignment that has a very
>> large
>>      alignment (i.e., 32 GiB), but the actual memory device size might
>> not be
>>      multiples of that alignment.
>>
>>      However, this change:
>>
>>      (a) allows for some practically impossible DIMM sizes, like "1GB+1
>> byte".
>>      (b) allows for DIMMs that partially cover hugetlb pages, previously
>>          reported in [1].
>> ...
>>
>> Partial hugetlb pages do not particularly make sense; wasting memory. Do
>> we expect people to actually ave working setup that we might break when
>> disallowing such configurations? Or would we actually help them identify
>> that something non-sensical is happening?
>>
>> When using memory-backend-memfd, we already do get a proper error:
>>
>>   ./build/qemu-system-x86_64 -m 2047m -object
>> memory-backend-memfd,id=ram-node0,hugetlb=on,size=2047m,reserve=off
>> -numa node,nodeid=0,cpus=0,memdev=ram-node0 -S
>> qemu-system-x86_64: failed to resize memfd to 2146435072: Invalid argument
>>
>> So this only applies to memory-backend-file, where we maybe should fail
>> in a similar way?
>>
> 
> Yeah, let's fail in that case. But non-aligned length is just one of
> many reasons madvise()/mbind() can fail. What about the others? Should
> we make them report an error or just a warning?

Regarding madvise(), we should report at least a warning.

In qemu_ram_setup_dump() we print an error if QEMU_MADV_DONTDUMP failed.

But we swallow any errors from memory_try_enable_merging() ... in 
general, we likely have to distinguish the "not supported by the OS" 
case from " actually supported but failed" case.

In the second patch, maybe we should really fail if something unexpected 
happens, instead of fake-changing the properties.

-- 
Cheers,

David / dhildenb


