Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB6DEE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGol-0002pO-Kb; Wed, 11 Sep 2024 02:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1soGoj-0002mP-UA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:27:05 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1soGoh-0001Z4-8v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:27:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201d5af11a4so67771285ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726036021; x=1726640821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/el06rgjcCm5Qfh6ZJ45l+Leeniz8EsS5WL9yVDXZs=;
 b=dZgX7Bs9d3EzIAO7paUYuSuyAAZKKJRCCctED2dRbr0o8AWqeOWbUkkx6qgZWMydqB
 +yl7camP2h1geeEpZPwdjZ8DvooxMpnLmpTK7GyXtjqEr10N7oofAjelZ3uEP8JxnK54
 zRnYCAJz9XalW7/PfysZI8AeYITMbgpnIZvyfqf744BdgyBP0Jjxe3yTTqAn3EE3LUlE
 gK9LhNkd1vxNwUIN25Ct3d+EbtTzajhGL+A2sNWdFDTgDHTTLXRWUUgJ/KjTABEcE5QP
 ZD/IRe29QPrAGXWDlzf6iV0LaOOTU7v43ci3mlFq/HuvQ2g6ptiALhDRknLCbZR4vNib
 WEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726036021; x=1726640821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/el06rgjcCm5Qfh6ZJ45l+Leeniz8EsS5WL9yVDXZs=;
 b=kmwEi2zZcCx7ytPTe8rW6/rdHPeiUHl7dz43CDTc0ktVA/Yz2r/o5qIQULFsNJavgl
 ABQMmNF9aJ664X0U30jAc9tF696G87Jrmgkh6QqN2dKG1/xQJGnK4VFwf19puPShGcGH
 v0z2h7GRScrDaGnTfJOVcyvb2cS9j+GA4CbIKa0YXVeD5mguINII/alme0536Crs/UIu
 g1ClUbSaV4klxRNrFGZp4msM2MVe33rkct4zq2cmN9SsDBF9kHO2PAZQQ5Ui+NOMVxJh
 F7GldFdbrXdNvBhhRy08RLOMhqg6o0gX8ySMQT0C02whkOUi9A3gHcd/TUGXtAIwif7i
 Thkw==
X-Gm-Message-State: AOJu0YyH+GQ04Gm5Q1Gpbf4QrR1HW2b50zo5E0m0mkzwI7agAEMfI8Gw
 K+oEZieefqgGjL3UA/0NcDad3JmVsV+6LYUHBP6BBlJsUbVccPdG
X-Google-Smtp-Source: AGHT+IHI4TJ/RVgHHQfHY71AJ3gLSqQWFzbKUIfJKz5+k2+oV+zPsGRhJf93ho6HNmvttuDDjNSq3Q==
X-Received: by 2002:a17:902:db02:b0:205:7835:38dc with SMTP id
 d9443c01a7336-2074c73034emr45692865ad.60.1726036021143; 
 Tue, 10 Sep 2024 23:27:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:88b2:a50:8b0f:bbb5:4d76:e3a1?
 ([2600:1700:88b2:a50:8b0f:bbb5:4d76:e3a1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eeab68sm57062545ad.128.2024.09.10.23.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 23:27:00 -0700 (PDT)
Message-ID: <7ced0b1a-8548-44af-b108-23ef296e0b2b@gmail.com>
Date: Tue, 10 Sep 2024 23:26:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
 <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Abrams <satur9nine@gmail.com>
In-Reply-To: <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=satur9nine@gmail.com; helo=mail-pl1-x629.google.com
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



On 9/10/24 02:34, Peter Maydell wrote:
> On Mon, 9 Sept 2024 at 18:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> (Cc'ing Arnaud & Inès who are listed as maintainers)
>>
>> On 6/9/24 18:12, Peter Maydell wrote:
>>> On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>>>>
>>>> These changes allow the official STM32L4xx HAL UART driver to function
>>>> properly with the b-l475e-iot01a machine.
>>>>
>>>> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
>>>> likewise for RE and REACK bit.
>>>>
>>>> USART registers may be accessed via 16-bit instructions.
>>>>
>>>> Reseting USART_CR1 UE bit should restore ISR to default value.
>>>>
>>>> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>>>> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
>>>
>>> Thanks for this patch. I have one question below, and one
>>> minor nit.
>>>
>>>> ---
>>>>   hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>>>>   tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>>>>   2 files changed, 64 insertions(+), 4 deletions(-)
>>
>>
>>>>   static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>>>>   {
>>>>       if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
>>>> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>>>>       s->brr = 0x00000000;
>>>>       s->gtpr = 0x00000000;
>>>>       s->rtor = 0x00000000;
>>>> -    s->isr = 0x020000C0;
>>>> +    s->isr = ISR_RESET_VALUE;
>>>>       s->rdr = 0x00000000;
>>>>       s->tdr = 0x00000000;
>>>>
>>>> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>>>       case A_CR1:
>>>>           s->cr1 = value;
>>>>           stm32l4x5_update_params(s);
>>>> +        stm32l4x5_update_isr(s);
>>>>           stm32l4x5_update_irq(s);
>>>>           return;
>>>>       case A_CR2:
>>>> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>>>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>>>       .valid = {
>>>>           .max_access_size = 4,
>>>> -        .min_access_size = 4,
>>>> +        .min_access_size = 2,
>>>>           .unaligned = false
>>>>       },
>>>>       .impl = {
>>>>           .max_access_size = 4,
>>>> -        .min_access_size = 4,
>>>> +        .min_access_size = 2,
>>>>           .unaligned = false
>>>>       },
>>>
>>> The effect of these is that a 16-bit write not aligned
>>> to a (4-aligned) register offset will generate a GUEST_ERROR
>>> logged message, and a 16-bit write aligned to a 4-aligned
>>> register offset will write the value zero-extended to 32 bits.
>>> That seems reasonable to me.
>>
>> Peter, are you describing the .valid.min_access_size 4 -> 2 change
>> or the .impl.min_access_size one?
> 
> I was intending to summarise the effects of making the code
> changes above (both .impl and .valid), without any reference
> to what the real hardware behaviour might or might not be
> (as a starter for figuring out whether the change is reasonable).
> 
>> My understanding of the implementation is a 32-bit one:
>>
>>    REG32(CR1, 0x00)
>>
>>    struct Stm32l4x5UsartBaseState {
>>        ...
>>        uint32_t cr1;
>>
>>    static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>                                    uint64_t val64, unsigned int size)
>>    {
>>        ...
>>        switch (addr) {
>>        case A_CR1:
>>            s->cr1 = value;
>>
>> Am I missing something?
> 
> If we make the .impl and .valid changes, then the result is
> that we permit 16 bit writes to come through to the read
> and write functions. Since we don't make any changes to
> those functions to specially handle size == 2, you get the
> effects of the existing code. If the 16 bit write is aligned
> to a 4-aligned register offset it will match one of the A_*
> cases, and will write 16-bit-value-zero-extended to it.
> If the 16 bit write isn't to a 4-aligned offset it will fall
> into the "default" case and be logged as a GUEST_ERROR.
> 
> Did I miss some aspect of what the behaviour change is?
> -- PMM

Ah I see your point now regarding the zero extension writes. Basically you are saying this patch will have the effect that a 16-bit write to one of the USART registers such as USART_RTOR via an ARM instruction like STRH would not be handled correctly because value to be written will be zero extended to 32-bits before being written.

So for example if USART_RTOR currently has the value 0xAAAABBBB and STRH of value 0xCCCC is being applied to the lower 16 bits then one would expect the value to be 0xAAAACCCC in real HW but after my code change in Qemu then USART_RTOR would end up with 0x0000CCCC because the size parameter of stm32l4x5_usart_base_write is not being taken into account.

I do believe this is a valid problem. I will test the behavior on my STM32L476 and report back the real HW behavior and I suspect the result would be STRH write to such registers is allowed and unwritten bits are preserved and not overwritten with zeros.

I submitted a new patch for just TEACK fix already and will report back on the real HW test result later and adjust 16-bit read/write code as needed to behave properly.

I have also submitted a question to my STM contact regarding the reference manual and assuming the answer is yes it is in error I will add comments explaining that to my next patch for the 16-bit read/write handling.

-- Jacob

