Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C5ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsaZ-0008Kz-LK; Tue, 10 Sep 2024 00:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1snsaW-0008Jn-TV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:34:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1snsaU-0000yy-Ud
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:34:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so282904b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725942884; x=1726547684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6AHWxSeRTjnS+Qk+H/LEcAaKszVpbimWiqz6NXQMF8=;
 b=BiMIau9MhtilA4p1nLK067qVfxpfUP061KB88V/V2eVTsY4u+ftIi65xKhzTGUdbeE
 7vnOaqUv4Lgegv+ANK7OBpKIB1wTuocM50GGwhzS9t7U+ScVoxQFBY8BRTQhJ6O1x2u4
 llTsCR8LM8C4Q2EHrQNZEJvjPRvaGwrH50UtENVf7n9QKYkDvfqJIjy4dyP8E7RpEnqT
 2DrmIigLEMWYUlA1BQEn3dLL4ZhQK6tb575Pafy6ofnhxsa4MkDA5uuEbTpAX9AnTQ9/
 M/lkB6fO7PXgoSW4bmQpYwxyVM/HNvNf177lBAhVKsbhEyCqb8zrGEq6wQ7HiEraogaC
 A8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725942884; x=1726547684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6AHWxSeRTjnS+Qk+H/LEcAaKszVpbimWiqz6NXQMF8=;
 b=h8+IeU4p0rok9LH37q/HRsRcUjmTkhw3lCGNl/VL2TwA4TLDJvq7zzsPqNc4v0A7Zh
 tp3S0w08NbWUinLY/D/xSkkRM8p2TuZ6R9EM3U8ykwFRmudkivWGezTJ514QxYMrpeaW
 bWsL5/Bn6wiePYcLfEb3tNHY8W29n98jYz9jiyZQq+jn7kInhm750spwwIgBUfC9Pq/N
 ZiD8BZqCoBG7VlRMPh2Hb47Y2fjdm1MRjU2mSurMACwGSCmxKdxDkUXIwtxt0147asPc
 2SX3XCZWM3Npl4uIIDeIjTDnGbg4xHbBiuj8GqXiQVw5iMxcgxeorHbwEUPaCpZyFpdO
 op1g==
X-Gm-Message-State: AOJu0YwPNiVU8CtDxSlyo0ZrFXeEeqGJWVZ9OOotOtgWXYEFKh/OoyPR
 +KwqfqnNpr4+lGbcw7qPUAneGu8xhs8MyIeiIFMPHfaXOfxiRDwMd+Luv8a75gg=
X-Google-Smtp-Source: AGHT+IEsWa8lolslUlIep0SQYy060UZoKdF21P7BThLY2c23gPggA/T4XCODcR5YZ2nYo83HZmopiw==
X-Received: by 2002:a05:6a00:2ea5:b0:714:241d:a323 with SMTP id
 d2e1a72fcca58-718d5ef9935mr15559087b3a.17.1725942884423; 
 Mon, 09 Sep 2024 21:34:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:88b2:a50:e138:436a:6892:a724?
 ([2600:1700:88b2:a50:e138:436a:6892:a724])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909092662sm510891b3a.120.2024.09.09.21.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 21:34:43 -0700 (PDT)
Message-ID: <adb2d9d0-5088-4df8-a1aa-4572af92d877@gmail.com>
Date: Mon, 9 Sep 2024 21:34:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
Content-Language: en-US
From: Jacob Abrams <satur9nine@gmail.com>
In-Reply-To: <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=satur9nine@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/9/24 10:40, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (Cc'ing Arnaud & Inès who are listed as maintainers)
> 
> On 6/9/24 18:12, Peter Maydell wrote:
>> On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>>>
>>> These changes allow the official STM32L4xx HAL UART driver to function
>>> properly with the b-l475e-iot01a machine.
>>>
>>> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
>>> likewise for RE and REACK bit.
>>>
>>> USART registers may be accessed via 16-bit instructions.
>>>
>>> Reseting USART_CR1 UE bit should restore ISR to default value.
>>>
>>> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>>> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
>>
>> Thanks for this patch. I have one question below, and one
>> minor nit.
>>
>>> ---
>>>   hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>>>   tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>>>   2 files changed, 64 insertions(+), 4 deletions(-)
> 
> 
>>>   static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>>>   {
>>>       if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
>>> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>>>       s->brr = 0x00000000;
>>>       s->gtpr = 0x00000000;
>>>       s->rtor = 0x00000000;
>>> -    s->isr = 0x020000C0;
>>> +    s->isr = ISR_RESET_VALUE;
>>>       s->rdr = 0x00000000;
>>>       s->tdr = 0x00000000;
>>>
>>> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>>       case A_CR1:
>>>           s->cr1 = value;
>>>           stm32l4x5_update_params(s);
>>> +        stm32l4x5_update_isr(s);
>>>           stm32l4x5_update_irq(s);
>>>           return;
>>>       case A_CR2:
>>> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>>       .valid = {
>>>           .max_access_size = 4,
>>> -        .min_access_size = 4,
>>> +        .min_access_size = 2,
>>>           .unaligned = false
>>>       },
>>>       .impl = {
>>>           .max_access_size = 4,
>>> -        .min_access_size = 4,
>>> +        .min_access_size = 2,
>>>           .unaligned = false
>>>       },
>>
>> The effect of these is that a 16-bit write not aligned
>> to a (4-aligned) register offset will generate a GUEST_ERROR
>> logged message, and a 16-bit write aligned to a 4-aligned
>> register offset will write the value zero-extended to 32 bits.
>> That seems reasonable to me.
> 
> Peter, are you describing the .valid.min_access_size 4 -> 2 change
> or the .impl.min_access_size one?
> 
> My understanding of the implementation is a 32-bit one:
> 
>   REG32(CR1, 0x00)
> 
>   struct Stm32l4x5UsartBaseState {
>       ...
>       uint32_t cr1;
> 
>   static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>                                   uint64_t val64, unsigned int size)
>   {
>       ...
>       switch (addr) {
>       case A_CR1:
>           s->cr1 = value;
> 
> Am I missing something?
> 
> Now, back to .valid.min_access_size, per the section "40.8 USART
> registers" of the reference manual:
> 
>   The peripheral registers have to be accessed by words (32 bits).
> 
> So I don't get the "USART registers may be accessed via 16-bit
> instructions." part of this patch.
> 
> Jacob, for clarity, can you split this patch in 3 distinct parts
> (TE bit, UE bit, unaligned access) so this discussion doesn't delay
> the part which are OK?
> 
> Thanks,
> 
> Phil.

Hmm it does appear to be a documentation error in RM0351 section 40.8.

I have an STM32L476 board (chip is nearly identical to the STM32L475 minus the display module) which is functioning with the USART driver code provided by STM in their examples that uses 16-bit access for several of the USART registers, see:

https://github.com/STMicroelectronics/cmsis_device_l4/blob/a2530753e86dd326a75467d28feb92e2ba7d0df2/Include/stm32l475xx.h#L950

I have a contact at STM through my work that I can mention this to just to double check.

Ultimately my goal is to get an STM32CubeL4 example such as UART_Printf running as-is in Qemu and it was only while attempting to run such a project in Qemu that I ran into this problem, see:

https://github.com/STMicroelectronics/STM32CubeL4/tree/master/Projects/STM32L476G-EVAL/Examples/UART/UART_Printf

This project works on my HW dev board just fine.

Of course if you still desire I don't mind splitting this change into 3 parts.

Regards,
Jacob

