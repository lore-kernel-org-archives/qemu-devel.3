Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77892606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IjKzjX3X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWK6w-0002IK-AY; Wed, 25 Nov 2026 16:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK6X-0002EI-TI
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:00:48 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK6W-0006y1-68
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:00:37 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8a594d313a3so4168640b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640432; x=1796245232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gEio/QiKIukLuSNl7u4faB7v8jeOwZE8spenjdeHZAk=;
 b=IjKzjX3XNbw4aMvjI0KV2XFWyOejq5dbYafZbOp9PYHoANx1e2JWR6sATRwqql3Q4L
 /NOSDhffs53g0Dl7fzUGiYvklp9SN0YacVMzg12z8O6op45saaHlhK2vfjE9EC1PWNyJ
 mW4/uFlNe8L9O+XQEdufbAqntIhl2CNiADVQMj5HV7tVscs/ZiwyX9o8xTDnaI40yHw0
 rxot+cJpOpWgNQxpKvRNazE63Yfjyl4A8r7gonZcOahVSnkWtykfwpE3VemaCB6/3t/v
 3zBPQmjLDXrM36GJiVLOOcubcNCdlOGVObMdHbSoUbyL6yeQm538PXDBKo/UT8wJqYkC
 ln+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640432; x=1796245232;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gEio/QiKIukLuSNl7u4faB7v8jeOwZE8spenjdeHZAk=;
 b=d9jRYVrA7os1/6PbBGPF70hhrEJ+jIC6aIcTC78IoM06C3tBVWvr7v/JRKZi+fMJev
 d9TL4VJnJcMQCvbISIHBlNSs4ofwctEKLj7h/LnrAHa2y9MYBgiIhSqgjV68WBTJ74XW
 8TsEnXG6B4Fis9+1zUrLtFVzLwAw3jY3wAZmwlsm3y322wF/BtypjFEzPBO2Kl4YvYSf
 s4hUUuQ55VLc25De2fs22dzkLaEO2zCgwtIJRDUngwDg6Z7OaUjve6ZevSfrrnl4yJJi
 T8BcuA1nshp2fpyHJ3kqRDPruPdeyi7F/Q+s0c0FzMXXpbCYVCkkfhHUho6QQkzmuYDx
 ZKaQ==
X-Gm-Message-State: APuU4Z/dXOj0+o72ojOfOWkG1tCMbxmEoAzZsBV6jB+DK+RemDSuhIdK
 s1+LICP/gvw6Ofh7KUoiRbNQhXVPJMK/WwElqz8AJM4D26dYL9I68WOoyfqPq4b7U2w=
X-Gm-Gg: AZFdTZfs6csf/ho9Ao4pafxSBxWnwxg7S6TTv0gPcH2d9h0NpsF5wqKMbj8PolQWX1i
 IyakP9H3FWFr766zI0V9sUhdBUym+X7qTZiZya35aGDslG3MnSxI2ApXIJkusq4MbYqvXIbywcf
 5jUXuo7OiUCTwG6C+PP7TWuI0KvyfsN9AdUY8glE/h53nfceSjOAC4RfAyAsUL5nphBzhHCgOkI
 64if51A/RUn999pXuAqz0vc9TPuGo/K5ZE59vHYyIGpqczASxpD8g65EfKiq/h3joX8fzxiWkFe
 C1iyz2s0KgENc5qpyDtmKu0NN751MFjb2V96BliBbavE3/YsV2OESYc94QLW7wajSQNg6wwe6Xa
 otKUZ0QZ3zpJgHDadRZK0QIQTcche83MrfnFdDrc09u4ciNG0wo4Z3LMej4378BDPjSPZ2Aaw+X
 oZ8CVgpjym2wTAY3caM/r4VcUJ1upqxvg9tgalkRZWci1dhdhFNEpCw4OVzipISO22lJAtJxUvu
 WL4GBXi9j4AS35dr5WjrhHVOJUZsyFUfWiXGf3e3Mof6kBJDecBAOvtSpYdOsY+ijgjLRt1BsWp
 +X+Bx6MRxh5bE2nwrwez92wEx/6peX+7HC8V0nlc8Ts=
X-Received: by 2002:a05:6a00:4605:b0:880:fe7b:bc56 with SMTP id
 d2e1a72fcca58-8c87d32ad6fmr19223322b3a.50.1795640431873; 
 Wed, 25 Nov 2026 13:00:31 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873b2434asm9466895b3a.45.2026.11.25.13.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 13:00:31 -0800 (PST)
Message-ID: <6da6b191-6ec2-49bf-b25d-aeedac071b40@linaro.org>
Date: Wed, 25 Nov 2026 13:00:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
 <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <5cb298ce-7f9b-40fd-b553-879a567e78a5@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5cb298ce-7f9b-40fd-b553-879a567e78a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 11:11, Philippe Mathieu-Daudé wrote:
> On 25/11/26 14:59, Peter Xu wrote:
>> On Tue, Nov 24, 2026 at 11:29:15PM +0100, Philippe Mathieu-Daudé wrote:
>>> On 24/11/26 21:20, Peter Xu wrote:
>>>> On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
>>>>> A ROM device changes its contents with direct stores while in MMIO
>>>>> mode. TCG does not see these stores, so translated blocks built from
>>>>> the old contents survive the switch back to ROMD mode and the guest
>>>>> executes stale code.
>>>>>
>>>>> Make memory_region_rom_device_set_romd() drop the TBs of the whole
>>>>> region on both transitions: before leaving ROMD mode (if currently
>>>>> in it), and after entering ROMD mode, for TBs another vCPU built
>>>>> before its TLB was flushed.
>>>>
>>>> Pure question: should we flush once, but only when ROMD->MMIO?  Said 
>>>> that,
>>>> IIUC we need to flush after switching to MMIO to avoid the race you
>>>> mentioned, that is something like:
>>>>
>>>>     if (mr_is_romd(mr) && romd_mode) {
>>>>         set_romd(false);
>>>>         flush();
>>>>     }
>>>>
>>>> It's based on my limited understanding / assumption that during MMIO 
>>>> state
>>>> TCG won't be able to cache invalid TB on these regions.
>>>>
>>>> So when switching ROMD->MMIO, invalidated TBs can exist, hence flush 
>>>> only
>>>> once, after updating romd=false.  When switching back from MMIO- 
>>>> >ROMD, no
>>>> chance caching anything wrong.
>>>
>>> This doesn't run. Its flush comes after romd is cleared, and
>>> memory_region_flush_rom_device() asserts that the region is still in
>>> romd mode. The reproducer aborts with:
>>>
>>> Assertion failed: (memory_region_is_romd(mr)), function
>>> memory_region_flush_rom_device
>>
>> IIUC that assertion was not required and can be removed, based on its
>> comment?
>>
>> So my pure question was really about why we need two TB flushes rather 
>> than
>> one: the pflash changed causing stale TB which I can understand.  What I
>> suggested was "making sure nobody caches this pflash, then drop all
>> existing TB" approach, which requries removal of the assertion.  I 
>> assumed
>> that works, but maybe not really - I tried to read slightly more into TCG
>> just now and noticed maybe there's yet another layer of caching on TLB so
>> the stale mapping can still be visible.  Said that, IMO it would be great
>> if we can explain why two flushes are needed rather than one.  That 
>> means,
>> if we think the 2nd flush guards everything somehow (including the stale
>> TLB async work hasn't flushed), then it seems to me we can then drop the
>> 1st flush (ROMD->MMIO switch).
> 
> Wow you are right, having the flush on entering romd, after the contents
> are written, is what closes the window, and is enough!
> 
> -- >8 --
> diff --git a/system/memory.c b/system/memory.c
> index 2e3ce773ce97..8e11d42bedce 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2252,12 +2252,16 @@ void memory_region_set_nonvolatile(MemoryRegion 
> *mr, bool nonvolatile)
>   void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>   {
>       if (mr->romd_mode == romd_mode) {
>           return;
>       }
>       memory_region_transaction_begin();
>       mr->romd_mode = romd_mode;
>       memory_region_update_pending |= mr->enabled;
>       memory_region_transaction_commit();
> +    if (romd_mode) {
> +        /* Drop TBs another vCPU built from the old contents, once 
> written */
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +    }
>   }
> ---
> 
> Thanks a lot for the review!

Grepping around accel/tcg/, we're also caching romd in cputlb.  We need 
to flush those entries when exiting romd mode.

I think that can wait until 12.0 though...


r~

