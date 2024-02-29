Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717FDC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdYj-0005ot-0s; Thu, 29 Feb 2024 05:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfdYf-0005oC-Rg
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:22:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfdYd-0003k0-PW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:22:33 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 578AA3FB6A
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709202149;
 bh=PhIMvhhzJASnfeJcdzJ8io52I22S0z+H+aiKV0PIVe0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=NXCFimimTMxkjpPxApcsvzV2w48T7gZ4FodFTnxDQko8GfP4QR9JfuKcOIcthxp2K
 awo2nRANM8kQDovqD5Vm++0l4GBYtZgsdHbdT7+CCw+L9ypboJPMptrcOK1+E/aRK2
 1jXbLhA4aYRqdH37SO30WY3kHusfBlPtGZwCtLZwxGF6LnFnD4i5+pFPZUZ1CRjNtF
 Ohu5owoqzweNScnRB4I74GXkkb/V/JYMlDjA/3a/yM+DWtv2vK4/+NRiKuaOfgeuue
 pXIOXr3I1OQhcwnytwSJPMSF/DjzbCWrBnwCQ9SG7Ccf3sKumaD94Tzjx0NptM/w12
 KrGdjIufwJfdw==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a357c92f241so57078566b.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709202147; x=1709806947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhIMvhhzJASnfeJcdzJ8io52I22S0z+H+aiKV0PIVe0=;
 b=uSkvObNjVeI3ZLknjBhKlw8+BAk7NKxRPsrCgBcZheozvs5XsKVQuq0BQ/ku1xLb+b
 F3l9Dmin6FSDFoxOOKqi2xRqxrwwPCu12bosXMsiIaITlv4saaZ0P5u3a11TEn2J+gE0
 IYyAWxeKbu4bURfcn71T7r5VuoMuuMH2pCC63Q86TymVQqyus1xcVIYzwURhmENBG26F
 k0QC95S1dop6vqgNKYyWniVwZ9eq2MJz9thiYny3sCGSWxxqvVJZZQslZkMlD7sKx8/N
 Q6LJX6LLuJJ2+vIGU5kzWFM54fyIDNm3t8sDz9edoVLN//uholrFuFV2gYAOtHI3DFGh
 6VrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtsxA/e/SJKoHLXtZyFkeAaswTi8ZjQqeNrPUllci35MzgIYK5rUBHs2yiE+0crzUObVZ3aZJgHfSPqat/LPpiChwZEyA=
X-Gm-Message-State: AOJu0Yxo8wkDg+rneYDiua5p7VsmOOLM1mz7whLO4utFUESgxj3OjICx
 K714uxYi9fbp0bL2JZkWOceeC/YFxlayjHT1bkHWnaJIlG2Sl1OLpMk/WCs+mglA3ODy+Cw/oA9
 jFaJ7hXValV2ckSSE2Btb6ij2bF8cPGX0HAsf8beQplz+9G8EDSniysny9mX2HEUqRUh7
X-Received: by 2002:a17:906:f914:b0:a43:e77d:1670 with SMTP id
 lc20-20020a170906f91400b00a43e77d1670mr1173534ejb.39.1709202147454; 
 Thu, 29 Feb 2024 02:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzLp2XZ0owTQ1y/z671XUf6H4gRw2OB/Z0D7HjaQ3B2DbKgq8GjD5dSNyAe4cmS5yEndolVg==
X-Received: by 2002:a17:906:f914:b0:a43:e77d:1670 with SMTP id
 lc20-20020a170906f91400b00a43e77d1670mr1173509ejb.39.1709202146956; 
 Thu, 29 Feb 2024 02:22:26 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:23ea:cac0:4a99:bcbf?
 ([2a00:20:10:8f6:23ea:cac0:4a99:bcbf])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a17090646c300b00a3fbca02e17sm535560ejs.75.2024.02.29.02.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 02:22:26 -0800 (PST)
Message-ID: <2a07005c-6465-47da-ae89-dd6151e8ed74@canonical.com>
Date: Thu, 29 Feb 2024 11:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com> <Zd_Z2f-5_l3rXNbp@x1n>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <Zd_Z2f-5_l3rXNbp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29.02.24 02:11, Peter Xu wrote:
> On Wed, Feb 28, 2024 at 08:07:47PM +0100, Heinrich Schuchardt wrote:
>> On 28.02.24 19:39, Peter Maydell wrote:
>>> On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 28.02.24 16:06, Philippe Mathieu-Daudé wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On 28/2/24 13:59, Heinrich Schuchardt wrote:
>>>>>> virtqueue_map_desc() is called with values of sz exceeding that may
>>>>>> exceed
>>>>>> TARGET_PAGE_SIZE. sz = 0x2800 has been observed.
> 
> Pure (and can also be stupid) question: why virtqueue_map_desc() would map
> to !direct mem?  Shouldn't those buffers normally allocated from guest RAM?
> 
>>>>>>
>>>>>> We only support a single bounce buffer. We have to avoid
>>>>>> virtqueue_map_desc() calling address_space_map() multiple times.
>>>>>> Otherwise
>>>>>> we see an error
>>>>>>
>>>>>>        qemu: virtio: bogus descriptor or out of resources
>>>>>>
>>>>>> Increase the minimum size of the bounce buffer to 0x10000 which matches
>>>>>> the largest value of TARGET_PAGE_SIZE for all architectures.
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>> v2:
>>>>>>       remove unrelated change
>>>>>> ---
>>>>>>     system/physmem.c | 8 ++++++--
>>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>>> index e3ebc19eef..3c82da1c86 100644
>>>>>> --- a/system/physmem.c
>>>>>> +++ b/system/physmem.c
>>>>>> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
>>>>>>                 *plen = 0;
>>>>>>                 return NULL;
>>>>>>             }
>>>>>> -        /* Avoid unbounded allocations */
>>>>>> -        l = MIN(l, TARGET_PAGE_SIZE);
>>>>>> +        /*
>>>>>> +         * There is only one bounce buffer. The largest occuring
>>>>>> value of
>>>>>> +         * parameter sz of virtqueue_map_desc() must fit into the bounce
>>>>>> +         * buffer.
>>>>>> +         */
>>>>>> +        l = MIN(l, 0x10000);
>>>>>
>>>>> Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
>>>>> TARGETS_BIGGEST_PAGE_SIZE?
>>>>>
>>>>> Then along:
>>>>>      QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <= TARGETS_BIGGEST_PAGE_SIZE);
>>>>
>>>> Thank you Philippe for reviewing.
>>>>
>>>> TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by the
>>>> page size.
>>>> How about MIN_BOUNCE_BUFFER_SIZE?
>>>> Is include/exec/memory.h the right include for the constant?
>>>>
>>>> I don't think that TARGET_PAGE_SIZE has any relevance for setting the
>>>> bounce buffer size. I only mentioned it to say that we are not
>>>> decreasing the value on any existing architecture.
>>>>
>>>> I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
>>>> e3127ae0cdcd ("exec: reorganize address_space_map") does not provide a
>>>> reason for this choice. Maybe Paolo remembers.
>>>
>>> The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
>>> which was the first implementation of this function. I don't think
>>> there's a particular reason for that value beyond that it was
>>> probably a convenient value that was assumed to be likely "big enough".
>>>
>>> I think the idea with this bounce-buffer has always been that this
>>> isn't really a code path we expected to end up in very often --
>>> it's supposed to be for when devices are doing DMA, which they
>>> will typically be doing to memory (backed by host RAM), not
>>> devices (backed by MMIO and needing a bounce buffer). So the
>>> whole mechanism is a bit "last fallback to stop things breaking
>>> entirely".
>>>
>>> The address_space_map() API says that it's allowed to return
>>> a subset of the range you ask for, so if the virtio code doesn't
>>> cope with the minimum being set to TARGET_PAGE_SIZE then either
>>> we need to fix that virtio code or we need to change the API
>>> of this function. (But I think you will also get a reduced
>>> range if you try to use it across a boundary between normal
>>> host-memory-backed RAM and a device MemoryRegion.)
>>
>> If we allow a bounce buffer only to be used once (via the in_use flag), why
>> do we allow only a single bounce buffer?
>>
>> Could address_space_map() allocate a new bounce buffer on every call and
>> address_space_unmap() deallocate it?
>>
>> Isn't the design with a single bounce buffer bound to fail with a
>> multi-threaded client as collision can be expected?
> 
> See:
> 
> https://lore.kernel.org/r/20240212080617.2559498-1-mnissler@rivosinc.com
> 
> For some reason that series didn't land, but it seems to be helpful in this
> case too if e.g. there can be multiple of such devices.
> 
> Thanks,
> 

Hello Peter Xu,

thanks for pointing to your series. What I like about it is that it 
removes the limit of a single bounce buffer per AddressSpace.

Unfortunately it does not solve my problem. You limit the sum of all of 
the allocations for a single AddressSpcace to 
DEFAULT_MAX_BOUNCE_BUFFER_SIZE = 4096 which is too small for my use case.

Why do we need a limit?
Why is it so tiny?

Best regards

Heinrich




