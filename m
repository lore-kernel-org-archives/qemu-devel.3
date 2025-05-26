Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07ECC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWeq-0006N2-NC; Mon, 26 May 2025 08:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJWen-0006ID-0i
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJWee-0007gW-SW
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748261405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Wk87Cm7jjBBm8iiBlCN+GurF/4VqzUoHWzk9TpnoUU=;
 b=YDSUbvmNkUU6wg513O6EbQP8hz9jFy/J3DITAlr1N/0RRzFaWnt0S11A1p+9PbkcBQcaxf
 O6JrGwi3p6GiIVEhxkxBeIeuYxKwlY1c4ZZIFeJCK+ZhBn6hVLQCnm3LSi/vN5gXobCJwP
 3ioFqCwSB5b4ihRg7uSIh9wNrTCp4PE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Vf97I-8fPKC68V8b-g_sUg-1; Mon, 26 May 2025 08:10:04 -0400
X-MC-Unique: Vf97I-8fPKC68V8b-g_sUg-1
X-Mimecast-MFC-AGG-ID: Vf97I-8fPKC68V8b-g_sUg_1748261403
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so9692155e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748261403; x=1748866203;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2Wk87Cm7jjBBm8iiBlCN+GurF/4VqzUoHWzk9TpnoUU=;
 b=mVnQPI8nor7eK7yR9wtCDg1s13cNLf8UgK9BOkJHXQ8dVVsbz+ETMOcSd+oE33xeBc
 mfyg46DgFEzzrqio99piBntxTB50YzQ1sSQkTk3sLWueiKhkOYg6kgGzfYtyESDgI5kC
 OsFy9Dm4QfVYfiYx+DkUV1BKmEXpHzGug8Nbyrt1p2m/OAKz5Jl4bNN53+KN8Hkwjs6J
 STjbuD4ChR9g4n2dCD+R9hat+WzvULv4obYIKC009A9U7METltNwDTyKOCu7V2md4NOG
 zURV5RKA+sWzSH/03OF/og/Gi2Tp6DOmCZCHJOpBMqfdTAyxZwZ9cGKgrLjEexn2TBx3
 vIQQ==
X-Gm-Message-State: AOJu0YyJr/VJQw4fgWzPVrjF8PDPwu0q5gDmoqHxmDSPcJT5eeraq9dA
 9cnphU0PRsEDNjAwpD2lNac+A/fdKreWfXYhmT0mN/O8QLANYzNd5fAPgkDPnb6XeEaDx9dnChA
 cDN2lenH9L2v+tMumDq3h1/57CLfDjNhkSnbdYG9qNhAqmGxig9D79BTH
X-Gm-Gg: ASbGncut1e0+1StfEJTA+PGNeasvlaAsBimOtm+aq1NpVdDQwUv2lx8FjobqCFmqOLT
 /itKBFB8wy1VRB/o2y3b5YwhLvX1cRZl1upeHxUcTVA0WiLw8bi9K724EsYDj8IGcuKiglaOWf1
 8kAZsAeHgeuSbA7eTa/CKph7ym7weUcHbNu7f2g2NhuwCNtxWx8FFzOwZ62ItsPu+IC6mg2CT61
 Qg/IGxIs4Lpnu9hnZsuRJePhr1dS9tSB6fk6Q/csp7jN4dmtiXUz04QbuGHBPuGj2jSqstUA5IJ
 UcGeW6B13IUMLjNC3sxK9lkyZqjAOpLnUcuZs5nc6Z4=
X-Received: by 2002:a05:600c:3588:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-44c7aa382c7mr80905435e9.6.1748261402624; 
 Mon, 26 May 2025 05:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuXOWKXwKh3t9jsw1KbvqY/91/N1BDZCPncjgfrfmKEI0om76KSci+fI8LxzWcVgWgV7QZGQ==
X-Received: by 2002:a05:600c:3588:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-44c7aa382c7mr80905135e9.6.1748261402211; 
 Mon, 26 May 2025 05:10:02 -0700 (PDT)
Received: from [192.168.3.141] (p57a1aec8.dip0.t-ipconnect.de.
 [87.161.174.200]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm244727325e9.17.2025.05.26.05.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:10:01 -0700 (PDT)
Message-ID: <f2e8c15a-cbb9-4d17-9ee2-87567e36e8ea@redhat.com>
Date: Mon, 26 May 2025 14:10:00 +0200
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
 <6b5957fa-8036-40b6-b79d-db5babb5f7b9@redhat.com>
 <1674a16c-e4fb-4702-a21d-9c4923528b2f@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1674a16c-e4fb-4702-a21d-9c4923528b2f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26.05.25 12:19, Chenyi Qiang wrote:
> 
> 
> On 5/26/2025 5:17 PM, David Hildenbrand wrote:
>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>> The current error handling is simple with the following assumption:
>>> - QEMU will quit instead of resuming the guest if kvm_convert_memory()
>>>     fails, thus no need to do rollback.
>>> - The convert range is required to be in the desired state. It is not
>>>     allowed to handle the mixture case.
>>> - The conversion from shared to private is a non-failure operation.
>>>
>>> This is sufficient for now as complext error handling is not required.
>>> For future extension, add some potential error handling.
>>> - For private to shared conversion, do the rollback operation if
>>>     ram_block_attribute_notify_to_populated() fails.
>>> - For shared to private conversion, still assert it as a non-failure
>>>     operation for now. It could be an easy fail path with in-place
>>>     conversion, which will likely have to retry the conversion until it
>>>     works in the future.
>>> - For mixture case, process individual blocks for ease of rollback.
>>>
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> ---
>>>    system/ram-block-attribute.c | 116 +++++++++++++++++++++++++++--------
>>>    1 file changed, 90 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
>>> index 387501b569..0af3396aa4 100644
>>> --- a/system/ram-block-attribute.c
>>> +++ b/system/ram-block-attribute.c
>>> @@ -289,7 +289,12 @@ static int
>>> ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
>>>            }
>>>            ret = rdl->notify_discard(rdl, &tmp);
>>>            if (ret) {
>>> -            break;
>>> +            /*
>>> +             * The current to_private listeners (VFIO dma_unmap and
>>> +             * KVM set_attribute_private) are non-failing operations.
>>> +             * TODO: add rollback operations if it is allowed to fail.
>>> +             */
>>> +            g_assert(ret);
>>>            }
>>>        }
>>>    
>>
>> If it's not allowed to fail for now, then patch #8 does not make sense
>> and should be dropped :)
> 
> It was intended for future extension as in-place conversion to_private
> allows it to fail. So I add the patch #8.
> 
> But as you mentioned, since the conversion path is changing, and maybe
> it is easier to handle from KVM code directly. Let me drop patch #8 and
> wait for the in-place conversion to mature.

Makes sense. I'm afraid it might all be a bit complicated to handle: 
vfio can fail private -> shared conversion and KVM the shared -> private 
conversion.

So recovering ... will not be straight forward once multiple pages are 
converted.

> 
>>
>> The implementations (vfio) should likely exit() instead on unexpected
>> errors when discarding.
> 
> After drop patch #8, maybe keep vfio discard handling as it was. Adding
> an additional exit() is also OK to me since it's non-fail case.
> 
>>
>>
>>
>> Why not squash all the below into the corresponding patch? Looks mostly
>> like handling partial conversions correctly (as discussed previously)?
> 
> I extract these two handling 1) mixture conversion; 2) operation
> rollback into this individual patch because they are not the practical
> cases and are untested.
> 
> For 1), I still don't see any real case which will convert a range with
> mixture attributes.

Okay. I thought we were not sure if the guest could trigger that?

I think it would be better to just include the "mixture" handling in the 
original patch.

> 
> For 2), current failure of memory conversion (as seen in kvm_cpu_exec()
> ->kvm_convert_memory()) will cause the QEMU to quit instead of resuming
> guest. Doing the rollback seems useless at present.

Makes sense.

-- 
Cheers,

David / dhildenb


