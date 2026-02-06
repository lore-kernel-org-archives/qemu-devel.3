Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B4DEE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQGA-0005B7-By; Fri, 06 Feb 2026 13:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQG8-0005AJ-Ie
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:08:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQG7-0001ut-1O
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:08:48 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso11059735e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401325; x=1771006125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EWrLBdWK4hMyWa5JkEVJvQfN4IH6vhLUH92xvjRaLzQ=;
 b=LGcwoqS69rWp5u+/TNc3Aaeq9MmFcetx/jqFWtEAi6szH27LALIMyWooGkv6iZ7V5U
 xp5bwUUmA1uQr7yNQRkVoxtK8gpW/iamxLi+xpEh5/rzQWX1w2N8duC+jH4KNRzv3gGu
 A+j/INbhfUBASjYLHTioSPyGo1NtHYopZWR1TniL3cKwNo9lp7p7+myZE7L7ZuIaO9HP
 m+ypuYeUNZ5GI4ote7J+KtG2b5jj1wph+/FpDebIRdBht9Lwh7M+hrFHjEYE4Eny1Qsd
 3EbFRlbFwkQzTRZFpOSgqfiG3GVJrYj4eRAW4Mrkl9p7PJshaxIKsJ89QsehFvfcM6FL
 wWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401325; x=1771006125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWrLBdWK4hMyWa5JkEVJvQfN4IH6vhLUH92xvjRaLzQ=;
 b=tFf9CABdf9CVASyVaGICy+a19UL5LsoVrAZneYpz+6Wf7LeL9J0QbU2G4MpbELvjd4
 nr0sX9qDfhD+02AX/o1GSwcN0ZrU/wQJjCzNI8DqtREt/YHShARd0HAj29p8PQe0m1em
 +cD1N958tr3aTDTYBQZp8ICPkD737uuo4zg3kCb6Ca3IOohRrb6QBNlIqn7nBE9wNEaQ
 PYnY99qF1YB9bPCfceeYGiDlQhkfk9eXq4bMoKomNxWjrjW4TKxeywDKAioF8ZEI6BgC
 YWzF3YK1T0kGcPS+GMoIeohgqZ6BE5+ZuOjbQxwpJBNGNPXzW5gMTKfFRAUXHuhoi5eD
 Yj3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw02ipRj+NRLyqRP5wyfgiik54HE8hpXAXyMijp9V7MxMrcfSL1RAsEKDUPtydxUWwpufWRXXUIA/i@nongnu.org
X-Gm-Message-State: AOJu0YwGSxyT0ny+DuwK8lGZiEowGKOyvaGYjTbhYmhMvmR0l3NO7ug9
 VjurGHooBcvdpoy3Iyrr7/MQRoFEjulVxezXft63bEjCh7y1pwJmXuJmnPQiaj1NgB0=
X-Gm-Gg: AZuq6aK0ra/Q4Dsd1uoq3/rld4Mv7PHGwBlf9fRnYaqrVnaeMfx1X+ohD+Mkp6VR86D
 /ijiK3hJk/E2GYthAFtdI2WGnihiIFxr9AOphY3U6hmZBGNDTY71JEq7tRAcg+gQ3ZSUcKjx+hf
 4zkZkuLbTRq3LNzxXS7ynE0T3yogGU1+njWwbXqPtZkHtVtQdq7t4Yd/LFWgVQdx6Uq2p1xas59
 KIo4APSkT5wbiEDMipaITOg1qr7Y3hXpuZ+sd0tqe7xy2kWfEveSRajDclLYvDrmEkJeX5UApxi
 jOrQreqbFBDqYdOnx8gIrBKEIAkTYcWzBvdjDqCKqWIYCcSdhUMPvaC3X1yDM6lR/5ZdMVgiElr
 pGwIgHcs4w7rCsXiF6u3TZjsSAEnXcLLNLOZy1XpulbZMcRcaSzTw9fnHQ5FCwUlzuBQPEH2j2u
 FhN/cL0qKDJo+qLVueBRnuWbdY0IZwNYrEKaKnWnOApQY/BzMlQddBUg==
X-Received: by 2002:a05:600c:3589:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-483201e4022mr54458775e9.9.1770401325554; 
 Fri, 06 Feb 2026 10:08:45 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209c6de6sm23284695e9.13.2026.02.06.10.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 10:08:44 -0800 (PST)
Message-ID: <cfbbfbc4-f1dd-4a6d-8554-afaf08d85ac5@linaro.org>
Date: Fri, 6 Feb 2026 19:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/s390x: Replace %target_ulong -> %vaddr
 where appropriate
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-4-philmd@linaro.org>
 <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
 <4eb5b630-dad5-4cd8-97a6-d1d4a3499400@linaro.org>
 <1c30cbc9f0c04b3da5a48bc20f8d9cacfeb11911.camel@linux.ibm.com>
 <665666b9-69a8-4b47-b706-341295d96371@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <665666b9-69a8-4b47-b706-341295d96371@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/2/26 14:09, Thomas Huth wrote:
> On 05/02/2026 22.49, Eric Farman wrote:
>> On Thu, 2026-02-05 at 22:37 +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Eric,
>>>
>>> On 5/2/26 22:23, Eric Farman wrote:
>>>> On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daudé wrote:
>>>>> Use the %vaddr type for virtual addresses.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    target/s390x/s390x-internal.h  | 5 +++--
>>>>>    target/s390x/helper.c          | 2 +-
>>>>>    target/s390x/mmu_helper.c      | 6 +++---
>>>>>    target/s390x/tcg/excp_helper.c | 3 ++-
>>>>>    4 files changed, 9 insertions(+), 7 deletions(-)
>>>
>>>
>>>>> @@ -376,9 +377,9 @@ void probe_write_access(CPUS390XState *env, 
>>>>> uint64_t addr, uint64_t len,
>>>>>    bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
>>>>>    /* Special access mode only valid for mmu_translate() */
>>>>>    #define MMU_S390_LRA        -1
>>>>> -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, 
>>>>> uint64_t asc,
>>>>> +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, 
>>>>> uint64_t asc,
>>>>>                      target_ulong *raddr, int *flags, uint64_t *tec);
>>>>> -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int 
>>>>> rw,
>>>>> +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
>>>>
>>>> I think this one should remain target_ulong, and become hwaddr in 
>>>> the next patch, no?
>>>
>>> Without s390x background, I don't understand well what real addresses
>>> are. IFAICT the single caller s390_cpu_tlb_fill() provides a virtual
>>> address. But then indeed mmu_real2abs() consumes a hwaddr as real addr.
>>
>> Hi Philippe,
>>
>> Ah, I didn't go the other direction (my bad). The usage of "real" here 
>> is kind of halfway between
>> virtual and -really- real.
> 
> Yes, real addresses are like physical addresses in s390 land - except 
> for the two so-called low-core pages that might be swapped with two 
> other pages in memory.
> 
>> I suspect the caller is mistaken here, but I think that's a research
>> project for tomorrow.
> 
> The caller s390_cpu_tlb_fill() seems to deal with both, real a virtual 
> addresses, and uses the same variable for both, so I think that's fine 
> there.
> But I agree with Eric mmu_translate_real() should use "hwaddr" for the 
> raddr parameter instead. Philippe, could you please adjust the patch?

Sure!

