Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CCCC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hyY-0007tI-V6; Wed, 08 May 2024 10:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4hyX-0007sy-Gy
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:08:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4hyU-0002gQ-RL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:08:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-573137ba8d7so1644830a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715177328; x=1715782128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RHqHsuiLiPA/oyCgbngDHmPlwOj1ZNaC9uXrn1XVW8=;
 b=F/bBcKI8/qGW+48XCB/jsKwBcfJfFVWISIix9o3CyecMf3phcR4IirdC74Hq6Bv2Uq
 SPrCrPz0RJ0xVFr7yvq/VDHepstkHMDmh5vDCSpbn3e0YzHv3nicsII0P15VX6/EcErw
 TVnfIUekt52SgID592ZqsJ8v1LGkdZz80QLKNz19UVYoSDqFHYDYCXExKuQy1YEN2KnO
 jwOyhNJ+M/0D2IXUEetAl4kruhOLGQYz02ZnE5Xi5JHyA7MkI5OXO2iadaQjBFTV0UZh
 ewx3NFCZUpcDivtm9IeJ8KMHJflnHnxTUp9+2a1eqUikF01tFR5ovNsitEWBcrlM5x+5
 U55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715177328; x=1715782128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RHqHsuiLiPA/oyCgbngDHmPlwOj1ZNaC9uXrn1XVW8=;
 b=fIaVmIqeON3to6F/utL8oGPZ2fsnMieEJBUZbLShJNuo1wj5gEKk59rvN+CL0dPC0o
 DsyXNv45SWBJijWcvrAyCFkhpJRvfqwGjXyQ2AJGkdGhZ2vITUawhGtCWirXqjhAZetc
 E/1rZ0FesUzje59Omhk73Ns2F4yiU8bjraUnl+6rlyoaCAh369Q43hQGbf9IIRYMiku1
 MrycZwtPQ1UF4a8xCebOr8lLfD4H5LaLUwBPjmmx6VlMKcCGNFTae/3Favot/s8RsgN/
 MX87/ck5oyK8VkNLBnKkZWN+oT55DfY/wourPnv14jqKPyDSF8E507IuCOCZsS/MeBAB
 Zo+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO0z8DmL3k/ovbqLK4SMAyTa6os6nAu8mPcG2QzLW5arvgxqp5W2PJ17/Hh5sDyiMiXYIsrMT4bvtIjQpPf8zVxD68t8Y=
X-Gm-Message-State: AOJu0YzOctIM/+06rGzZyrFMLdBmnubFCrlw3B+eIXs0QH81kdqhWN1w
 1/qIrx4po2Ixsb6bwBkSQvPyT0vWCD8eJfoRh+Oj6BHslMni6Qw8hb38StWhWMI=
X-Google-Smtp-Source: AGHT+IEz6WoH9ZFnMhGm0j3XtBpTHyKelK1c97hkp18IeSug2XbkTiADxPRiw2rUjY1NdR1RviumLw==
X-Received: by 2002:a17:907:9490:b0:a59:fb06:5d35 with SMTP id
 a640c23a62f3a-a59fb065e31mr295445866b.8.1715177328136; 
 Wed, 08 May 2024 07:08:48 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 jt26-20020a170906ca1a00b00a558206b2c5sm7748013ejb.99.2024.05.08.07.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:08:47 -0700 (PDT)
Message-ID: <d03ca96e-53e9-43ed-886e-0cffd15994fb@linaro.org>
Date: Wed, 8 May 2024 16:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/char: Add QOM property for STM32L4x5 USART clock
 frequency
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-4-ines.varhol@telecom-paris.fr>
 <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
 <CAFEAcA83cgqq3yh3=d=gHd-LK3qh2g-pE2v734apKmcNTJTvww@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA83cgqq3yh3=d=gHd-LK3qh2g-pE2v734apKmcNTJTvww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 7/5/24 11:54, Peter Maydell wrote:
> On Mon, 6 May 2024 at 10:34, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 5/5/24 16:05, Inès Varhol wrote:
>>> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
>>> ---
>>>    hw/char/stm32l4x5_usart.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
>>> index fc5dcac0c4..ee7727481c 100644
>>> --- a/hw/char/stm32l4x5_usart.c
>>> +++ b/hw/char/stm32l4x5_usart.c
>>> @@ -26,6 +26,7 @@
>>>    #include "hw/clock.h"
>>>    #include "hw/irq.h"
>>>    #include "hw/qdev-clock.h"
>>> +#include "qapi/visitor.h"
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/qdev-properties-system.h"
>>>    #include "hw/registerfields.h"
>>> @@ -523,6 +524,14 @@ static Property stm32l4x5_usart_base_properties[] = {
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>
>>> +static void clock_freq_get(Object *obj, Visitor *v,
>>> +    const char *name, void *opaque, Error **errp)
>>> +{
>>> +    Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
>>> +    uint32_t clock_freq_hz = clock_get_hz(s->clk);
>>> +    visit_type_uint32(v, name, &clock_freq_hz, errp);
>>> +}
>>> +
>>>    static void stm32l4x5_usart_base_init(Object *obj)
>>>    {
>>>        Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
>>> @@ -534,6 +543,9 @@ static void stm32l4x5_usart_base_init(Object *obj)
>>>        sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>>>
>>>        s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
>>> +
>>> +    object_property_add(obj, "clock-freq-hz", "uint32",
>>> +                        clock_freq_get, NULL, NULL, NULL);
>>
>> Patch LGTM, but I wonder if registering QOM getter without setter
>> is recommended. Perhaps we should encourage parity? In normal HW
>> emulation we shouldn't update this clock externally, but thinking
>> about testing, this could be interesting to introduce jitter.
> 
> object_property_add() with the set function NULL is fine,
> and is documented to mean "property cannot be set". Attempts
> to set it will be failed (in object_property_set()) with a
> reasonable error.
> 
> But it's not clear to me why we want the property in the first
> place -- we don't generally have devices which take a Clock
> input have properties exposing its frequency. If we did want
> that it would probably be better if we could do it generically
> rather than by adding more boilerplate code to each device.

Inès qtest checking (via HMP) the configured clock has a
correct scaled frequency seems a good use case.

> Mostly "frequency" properties on devices are for the case
> where  they *don't* have a Clock input and instead have
> ad-hoc legacy handling where the board/SoC that creates the
> device sets an integer property to define the input frequency
> because it doesn't model the clock tree with Clock objects.
> 
> thanks
> -- PMM


