Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTIs-00006L-Kq; Tue, 19 Mar 2024 02:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmTIm-00005y-Ty
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:50:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmTIj-0001GU-Ih
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:50:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41466dcd397so626425e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710831019; x=1711435819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzOiIzNN7L6bOsYcpUY9BAGzHMI1ryenrtpgtQ8l1fY=;
 b=vX4W7Sh6sdjkJZf/DyEwcJsMuhZOLnGe8+0/RAkNVnQNbWBd4sf27tqmXtxkXTAcNc
 tNUhGMX0EVG4+7kufXcyPWm3eLW5vHmZ40frPBT2VK9I1gCTqKtG6j8TJvzHC/xqzOSw
 jUOgoIswJc6orzn2SJbU65/tbrQswnZaRxgxanU3TdeW5anNPsyBN5c+dgQH49G3Klw5
 caGhm+dnRtyLuLGvX4lRPUSBg+VGYXITjv8jMivj6EnjGXGj0PiAwsyTTOeolc8Fj6sp
 /H1drmeWj4kZb2hyHa1fVkRbsaSrF0u5YcBe7TQ21vVqLNNWzSi72Zx4pO9XLWCMLefB
 /4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710831019; x=1711435819;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzOiIzNN7L6bOsYcpUY9BAGzHMI1ryenrtpgtQ8l1fY=;
 b=IKbo4nxRFR46rs3SOB6SFwx9IiL0amSOV0tWM7j40ppZDKd/1A4+LW8D7pi+mzTDlp
 JpZAfARXadOLuR2wVm6F9t+4F+slh+eQbIJwjjBRCthv6fEr227CAWdkIjiAVb9w7y5h
 EbyPEKOozr6dC1VgItnaKXzCjXoutKNwHOahaxaqSVntnZcfsG7EB1maaZOnsrODvIGO
 iSy9TxGUvih33B8P5Lq+yvQSX8QPWZAILJGmGBSN6MC0QMOIq4OBSz5dczNWZQaPyGmJ
 V1ahnOd2ha+DIH8011t1q1s49QkdyyvMT0jKO0kZYIlDrObb5NtON39lSltOMwdgitgp
 ejlg==
X-Gm-Message-State: AOJu0Yz1y4WCCN/M3aHelUTvEeQ+MbOFmO6yObO660Kb7bFcI8CGbLoN
 httHrQWKkxREqNuWT1xOUdPg+qJTP5/ao4B1or9gyQ/OiYgxsj7lsrJBtOosq0o=
X-Google-Smtp-Source: AGHT+IFODjIG/W7P6XUMQJ0t2v1eSpf/fnXi0WJMF1oP4fuD815RTDkVZUQAgSgy9WLLw+qNvXSGQA==
X-Received: by 2002:a05:600c:294c:b0:412:9dd0:f7e7 with SMTP id
 n12-20020a05600c294c00b004129dd0f7e7mr8112292wmd.22.1710831018845; 
 Mon, 18 Mar 2024 23:50:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b004146346602csm1461290wmb.32.2024.03.18.23.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 23:50:18 -0700 (PDT)
Message-ID: <8681f8ba-44c0-4d01-8981-1d308774419f@linaro.org>
Date: Tue, 19 Mar 2024 07:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Xu <peterx@redhat.com>, Tomoyuki HIROSE
 <tomoyuki.hirose@igel.co.jp>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp> <ZfholB7fuWEbuBss@x1n>
 <fca8ecfc-f6b0-48f2-9590-867b0f8e4d9f@linaro.org>
In-Reply-To: <fca8ecfc-f6b0-48f2-9590-867b0f8e4d9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Tomoyuki,

On 19/3/24 07:43, Philippe Mathieu-Daudé wrote:
> On 18/3/24 17:15, Peter Xu wrote:
>> Hi,
>>
>> On Thu, Feb 01, 2024 at 05:13:12PM +0900, Tomoyuki HIROSE wrote:
>>> The previous code ignored 'impl.unaligned' and handled unaligned 
>>> accesses
>>> as is. But this implementation cannot emulate specific registers of some
>>> devices that allow unaligned access such as xHCI Host Controller 
>>> Capability
>>> Registers.
>>> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
>>> unaligned access with multiple aligned access.
>>
>> This patch looks mostly good to me.  Just a few trivial comments.
>>
>> Firstly, can we provide the USB example here (or also the bug link) so 
>> that
>> we can still pick up the context of why this will start to be useful when
>> people read about this commit separately?
>>
>>>
>>> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
>>> ---
>>>   system/memory.c | 38 +++++++++++++++++++++++++-------------
>>>   1 file changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index a229a79988..a7ca0c9f54 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -535,10 +535,17 @@ static MemTxResult 
>>> access_with_adjusted_size(hwaddr addr,
>>>                                         MemTxAttrs attrs)
>>>   {
>>>       uint64_t access_mask;
>>> +    unsigned access_mask_shift;
>>> +    unsigned access_mask_start_offset;
>>> +    unsigned access_mask_end_offset;
>>>       unsigned access_size;
>>> -    unsigned i;
>>>       MemTxResult r = MEMTX_OK;
>>>       bool reentrancy_guard_applied = false;
>>> +    bool is_big_endian = memory_region_big_endian(mr);
>>> +    signed start_diff;
>>> +    signed current_offset;
>>> +    signed access_shift;
>>> +    hwaddr current_addr;
>>>       if (!access_size_min) {
>>>           access_size_min = 1;
>>> @@ -560,19 +567,24 @@ static MemTxResult 
>>> access_with_adjusted_size(hwaddr addr,
>>>           reentrancy_guard_applied = true;
>>>       }
>>> -    /* FIXME: support unaligned access? */
>>>       access_size = MAX(MIN(size, access_size_max), access_size_min);
>>> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>>> -    if (memory_region_big_endian(mr)) {
>>> -        for (i = 0; i < size; i += access_size) {
>>> -            r |= access_fn(mr, addr + i, value, access_size,
>>> -                        (size - access_size - i) * 8, access_mask, 
>>> attrs);
>>> -        }
>>> -    } else {
>>> -        for (i = 0; i < size; i += access_size) {
>>> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
>>> -                        access_mask, attrs);
>>> -        }
>>> +    start_diff = mr->ops->impl.unaligned ? 0 : addr & (access_size - 
>>> 1);
>>> +    current_addr = addr - start_diff;
>>> +    for (current_offset = -start_diff; current_offset < (signed)size;
>>> +         current_offset += access_size, current_addr += access_size) {
>>> +        access_shift = is_big_endian
>>> +                          ? (signed)size - (signed)access_size - 
>>> current_offset
>>> +                          : current_offset;
>>> +        access_mask_shift = current_offset > 0 ? 0 : -current_offset;
>>> +        access_mask_start_offset = current_offset > 0 ? 
>>> current_offset : 0;
>>> +        access_mask_end_offset = current_offset + access_size > size
>>> +                                     ? size
>>> +                                     : current_offset + access_size;
>>
>> Maybe this looks slightly easier to read?
>>
>>          if (current_offset < 0) {
>>              access_mask_shift = -current_offset;
>>              access_mask_start_offset = 0;
>>          } else {
>>              access_mask_shift = 0;
>>              access_mask_start_offset = current_offset;
>>          }
>>          access_mask_end_offset = MIN(current_offset + access_size, 
>> size);
>>
>> But I confess this can be pretty subjective..
>>
>> Since PeterM used to comment, please remember to copy PeterM too in the
>> future post in case this got overlooked.
>>
>> Peter, do you still have any other comments or concerns?
> 
> See also this thread:
> https://lore.kernel.org/qemu-devel/20200331144225.67dadl6crwd57qvi@sirius.home.kraxel.org/
> ->
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html

Now I noticed this thread was mentioned on v1, but not all person Cc'ed
there are on v2.

What I'd like to see to get confidence and avoid regression is some
harness qtests triggering this problem. See for example:
https://lore.kernel.org/qemu-devel/20200817161853.593247-8-f4bug@amsat.org/

> 
> Also I guess remembering Richard mentioning we should unify this
> code for softmmu / physmem, but I might be wrong ...
> 
>>
>> Thanks,
>>
>>> +        access_mask = MAKE_64BIT_MASK(access_mask_shift * 8,
>>> +            (access_mask_end_offset - access_mask_start_offset) * 8);
>>> +
>>> +        r |= access_fn(mr, current_addr, value, access_size, 
>>> access_shift * 8,
>>> +                       access_mask, attrs);
>>>       }
>>>       if (mr->dev && reentrancy_guard_applied) {
>>>           mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>>> -- 
>>> 2.39.2
>>>
>>
> 


