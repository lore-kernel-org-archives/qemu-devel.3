Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1580CEE0202
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 03:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spJfs-0000k1-6b; Fri, 13 Sep 2024 23:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1spJfr-0000jX-F6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 23:42:15 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1spJfp-0004FH-Ic
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 23:42:15 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-70b2421471aso1046651a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726285331; x=1726890131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqb524JcDeADbDZoZRL0SH6PfN1TAbnxC4It9Bv+c6Q=;
 b=WPvHEPKtUaA7QDpmoqbB4h9NcZzcXpqeIzGVxQ0jrg8YwR6EWMF+dT3cDxlLUqRXRt
 3sY/Vs+VDoeRsPU4Hos+bzxwOtlRTKbQHCn56nRxa64egxOShyNsDKy4dZPIRAgH4gvV
 67LuZHsTlpCtiHnID1dQGaRBZhZEdjW0ah1Rf+CmJzCRi9jTc1PqP5O3zMiZgWJbKJJ7
 2kOgU5oxmEz0YqpS2zO3c6Apl/N5W+49tCnT4JRWTc+0/u4R0RzLtOnd1kMMjfkXM1rE
 E84KB9sQI2qugOu4tvb7ArUX1nGm3tsihormUDBtTUW2gxwM0qvTo6H7ouatClKR7FV6
 hTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726285331; x=1726890131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqb524JcDeADbDZoZRL0SH6PfN1TAbnxC4It9Bv+c6Q=;
 b=Ojuct9eydivLYDti/shjcUtdXfNNXKVMTJ+X3sjaJf1GGIvra3AhfMN/bJ8fPuYy2H
 x270wnpbn7p7sf3fmPRoo0MXq4ed2g5W30d/4L/irfu4dBb7uihGxLYr2Hb939/bqvyf
 7+ozNicSUMf0VfFhJgtpKcI4KPmHZ+P4oaU4cJkWmO32gIPbm3vRIzdUCis1lInWZkRe
 B0yYDDKu2QW84ADXi54VplFcM6tangaxYmyqI9jv+J/KfyLdsf97Bh0q0qs+KApyWv9N
 Y3vNQX/gunl4qj5S6pIxxNYebzYmbWuDmqMZ6Z/zRakU6v3+UEIzeJ7Dz7I220PZaKFO
 K7Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaN/kWuTi0Jcgm0C4YYGRvqEvqI2BDim5YYAVgJxp5jm+tUGXC4vM8dRkrG+XSQLV5hZvMEarl+jUe@nongnu.org
X-Gm-Message-State: AOJu0YxMco0Ze0no8mv7aVqhLhGVZ5+mEWxi26gstZaJYTe0GIUQcPuM
 WKo4Uyo823A3OPxUjl1zdkV1rq3n/9Dg92+HqhYukP4VO7OyxXKQ
X-Google-Smtp-Source: AGHT+IFmcUERN3HNDP+eRImqCTkGpwqq6YpbXSkL82NAn0QgTUDzf4G0YozC6UuMqSFFTyGmLTX/XQ==
X-Received: by 2002:a05:6a20:c99a:b0:1cf:2853:bc6c with SMTP id
 adf61e73a8af0-1d112e8bf46mr7154568637.33.1726285331285; 
 Fri, 13 Sep 2024 20:42:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:88b2:a50:6754:fe43:a60e:d076?
 ([2600:1700:88b2:a50:6754:fe43:a60e:d076])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944ab5115sm287778b3a.55.2024.09.13.20.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 20:42:10 -0700 (PDT)
Message-ID: <4aa1f089-6ae1-4a2d-9fdc-d62d26bd22ca@gmail.com>
Date: Fri, 13 Sep 2024 20:42:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
 <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
 <7ced0b1a-8548-44af-b108-23ef296e0b2b@gmail.com>
 <CAFEAcA-LoJUh4rXYtPnvQTwFhXhx8RHyzVh7sfMMvje98L2k+g@mail.gmail.com>
Content-Language: en-US
From: Jacob Abrams <satur9nine@gmail.com>
In-Reply-To: <CAFEAcA-LoJUh4rXYtPnvQTwFhXhx8RHyzVh7sfMMvje98L2k+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=satur9nine@gmail.com; helo=mail-pg1-x52b.google.com
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



On 9/11/24 03:28, Peter Maydell wrote:
> On Wed, 11 Sept 2024 at 07:27, Jacob Abrams <satur9nine@gmail.com> wrote:
>> On 9/10/24 02:34, Peter Maydell wrote:
>>> If we make the .impl and .valid changes, then the result is
>>> that we permit 16 bit writes to come through to the read
>>> and write functions. Since we don't make any changes to
>>> those functions to specially handle size == 2, you get the
>>> effects of the existing code. If the 16 bit write is aligned
>>> to a 4-aligned register offset it will match one of the A_*
>>> cases, and will write 16-bit-value-zero-extended to it.
>>> If the 16 bit write isn't to a 4-aligned offset it will fall
>>> into the "default" case and be logged as a GUEST_ERROR.
>>>
>>> Did I miss some aspect of what the behaviour change is?
> 
>> Ah I see your point now regarding the zero extension writes. Basically you are saying this patch will have the effect that a 16-bit write to one of the USART registers such as USART_RTOR via an ARM instruction like STRH would not be handled correctly because value to be written will be zero extended to 32-bits before being written.
> 
>> I do believe this is a valid problem. I will test the behavior on my STM32L476 and report back the real HW behavior and I suspect the result would be STRH write to such registers is allowed and unwritten bits are preserved and not overwritten with zeros.
> 
> Yeah, the datasheet doesn't say here and so checking the h/w
> behaviour would be helpful.
> 
>> I submitted a new patch for just TEACK fix already and will report back on the real HW test result later and adjust 16-bit read/write code as needed to behave properly.
>>
>> I have also submitted a question to my STM contact regarding the reference manual and assuming the answer is yes it is in error I will add comments explaining that to my next patch for the 16-bit read/write handling.
> 
> Would certainly be interesting to see what STM say.
> (If the answer is that some of these cases are invalid
> guest behaviour then we have the option of rather than
> following the in-practice h/w behaviour exactly instead
> doing something easy and logging it as a guest-error.)
> 
> thanks
> -- PMM

I have received a response from my contact Nicolas Fillon at STM, he wrote "I see we are making 16 bit access read and write to these 16 bit registers in our library for both HAL and LL so this should be a documentation issue."

I noticed in the Qemu source the RegisterAccessInfo struct and associated register_write_memory/register_write functions. These functions appear quite helpful to ensure that reserved bits are not written by using the ro field. I don't see very much usage of this paradigm in Qemu however, only Xilinx and USB DWC3 code appears to use it, but it seems a useful approach in many situations, especially for STM chips.

On the physical STM hardware, specifically the STM32L476, it allows writes smaller than 32-bit to 32-bit registers and does not fault or ignore them. In fact I noticed some very interesting byte duplication behavior, I tested the following code

  // USART_RTOR is a 32-bit register where every bit is r/w

  UartHandle.Instance->RTOR = 0xAAAABBBB;
  printf("USART1 RTOR 1: 0x%08"PRIx32"\n\r", UartHandle.Instance->RTOR);

  uint16_t *rtor_hw = (uint16_t *) &UartHandle.Instance->RTOR;
  rtor_hw[1] = (uint16_t) 0xCCCC;
  printf("USART1 RTOR 2: 0x%08"PRIx32"\n\r", UartHandle.Instance->RTOR);

  uint8_t *rtor_byte = (uint8_t *) &UartHandle.Instance->RTOR;
  rtor_byte[3] = (uint8_t) 0xDD;
  printf("USART1 RTOR 3: 0x%08"PRIx32"\n\r", UartHandle.Instance->RTOR);

  rtor_hw[0] = (uint16_t) 0xEEEE;
  printf("USART1 RTOR 4: 0x%08"PRIx32"\n\r", UartHandle.Instance->RTOR);

  // USART_BRR is a 32-bit register where only the lower 16-bit are r/w, the top 16-bits are reserved and read zero

  uint32_t *BRR32 = (uint32_t *) &USART2->BRR;

  *BRR32 = 0x11223344;
  printf("USART2 BRR 1: 0x%08"PRIx32"\n\r", *BRR32);

  uint16_t *brr_hw = (uint16_t *) BRR32;
  brr_hw[0] = (uint16_t) 0xCCCC;
  printf("USART2 BRR 2: 0x%08"PRIx32"\n\r", *BRR32);

  uint8_t *brr_byte = (uint8_t *) BRR32;
  brr_byte[1] = (uint8_t) 0xDD;
  printf("USART2 BRR 3: 0x%08"PRIx32"\n\r", *BRR32);

  /*
     OUTPUT:

     USART1 RTOR 1: 0xaaaabbbb
     USART1 RTOR 2: 0xcccccccc
     USART1 RTOR 3: 0xdddddddd
     USART1 RTOR 4: 0xeeeeeeee
     USART2 BRR 1: 0x00003344
     USART2 BRR 2: 0x0000cccc
     USART2 BRR 3: 0x0000dddd
   */

Notice how an 8-bit write of just 0xDD is duplicates to all words in the register, strange. I wonder if Qemu is interested in emulating this exact behavior, it doesn't seem particularly critical since the drivers provided by STM should never purposely write to fewer bits than are actually writable.

Jacob

