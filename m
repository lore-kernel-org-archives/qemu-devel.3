Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E6D33987
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYBR-0006K2-Bd; Fri, 05 Dec 2025 10:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRYBP-0006Jl-BO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:57:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRYBN-0003c3-JV
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:57:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so27252525e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764950237; x=1765555037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k1iI5+11v7PhEDhAuHyFXuNiy+jpDj0wIcIAyZ0T0hQ=;
 b=xJ+sL1/T1p1YHXMdunVSU1h0H/Rt8Cgv+Wxp91bY/hIJZ501fvGYnu2qubZhxP0C/T
 sE900q3WML279NamVn9o9yH1ZkfYYBCIZ2fkcj8S/Zh8ePhLAx5yAbhfYx2MXgRIBbvP
 /0CrqdcZzLAxYGRa8BbRv21tj+0T+ntBPs9a5XRiruWqGU2lDHV3GPLw8M9s7XrBG4T+
 Uu62oq/0WKBA82J/vpz8BvN4ZWtoORRJgd0OjylbZKodvnkxgsYIb00s3bmcEMtzI/7T
 6SkTGfUwiYzkwdrnNuJoA6YppbzRcvyVuNZbqbXSoQPq6BLZEixmrQoHwJU94OERBOQg
 4IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764950237; x=1765555037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1iI5+11v7PhEDhAuHyFXuNiy+jpDj0wIcIAyZ0T0hQ=;
 b=WND/HJeFt/hGQ8WtMNv1OZo949On8V+S/VlfK9k5L4HRMKXygl3X7c7ZMJbs6AhGUF
 XXxZSghOiVxlkU94Xeqv/UB68yDG4GZcL18O/i/A2Gp3TX1+QNC4mrQ6rKN+z7BLyr26
 xFJemYXxRgChEl+zV5dIXIYpWg8pIkxMogzXAD4nQGLOk1zHqdWjH4uHRQsEl4mU9ahz
 gHxReoBGkg2/lYa8BF2Th14b4BNpm11PruAh4QqTpTo7PCGmLUi0H+EhQDyx/zdmdzFa
 xVPj5Nz8dDvfIVsERW4aIY6b/EhnNUemYanA5u2fcwt1y6rcud7BuNM4nPu2yveaJMdh
 o1cQ==
X-Gm-Message-State: AOJu0YwqZrYAneexe4SaZ9ehETEGrGnDVfGqDoHE4N2pYpsZ4Ay6XMXG
 xfLKvy2LopsU2GuOOPdX4vM4oUzyuFifFcNpcYbAzTT98Sa+eE+rDdu5kEalrgMJ3cs=
X-Gm-Gg: ASbGnctouVJ6HZEW+idtU3r3wwgMCCBT6SYz6Tx/RyGjFowPRPi1Hzz0eqwo9wniUOQ
 oXYSj9CnekkYBn7Ool/2IUiXrNV9pk2jI0w+b5EzFm42qDlfM2Um0KCt4QHOAbAX+8nYR6B7O4J
 wUbuVOMitSjpyKsJIA8xSSrxEQitrVmjV+XqZM24icB49SALCEyBfzx5dRxlJ2byI3r0XuE6vNb
 ajzDNd9QyHWjqjpYTszZqGlFUEY7J9piTNU7pLDbxA/W4lfkdASLmXEurfbx1EKE85frC0N7VOY
 AwkybeDcTJdoSAdePzX06jYr7yQlRhEYlnY84mZ/u8NZTlsUzdzCtBIu5x8akGJAAsN5nk9x0WN
 x3JXsKRgN209IeuL2QBmsXWJbBv1QIxgaSD/5e8TrQ1qTk/8Hvn8Ishac3hUkv4ce140uac2aGG
 7wuHDv9qutDpD3KakRgt4OievitblgrEUKlsAxnzrvzmWCvlwRgBqrNUapo39WH6Q=
X-Google-Smtp-Source: AGHT+IHh2Y/yx0eTpxhqLxdbtr9B4NrwocZ8oBKcuKU3JNk+45mLi2KGZX0Px4svZNNcj0lg5ebOyg==
X-Received: by 2002:a05:600c:45d5:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-4792aee03aamr107531815e9.7.1764950237427; 
 Fri, 05 Dec 2025 07:57:17 -0800 (PST)
Received: from [10.143.236.213] (14.red-88-28-21.dynamicip.rima-tde.net.
 [88.28.21.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311e707asm86467345e9.10.2025.12.05.07.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 07:57:16 -0800 (PST)
Message-ID: <a605c0b2-8122-424c-a917-7d6ad8371c34@linaro.org>
Date: Fri, 5 Dec 2025 16:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
 <87qztarkyf.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87qztarkyf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 4/12/25 22:33, Alex Bennée wrote:
> Jim MacArthur <jim.macarthur@linaro.org> writes:
> 
>> If both frame and element count are 65535, which appears valid from my
>> reading of the OMAP5912 documentation, then some of the calculations
>> will overflow the 32-bit signed integer range and produce a negative
>> min_elems value.
>>
>> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
>>
> 
> nit:
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3204

Format is:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3204
Fixes: afbb5194d43 ("Handle on-chip DMA controllers in one place")

> 
>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>> ---
>>   hw/dma/omap_dma.c | 32 +++++++++++++++++++++-----------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
>> index 101f91f4a3..93e6503ff9 100644
>> --- a/hw/dma/omap_dma.c
>> +++ b/hw/dma/omap_dma.c
>> @@ -504,9 +504,19 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
>>       struct omap_dma_channel_s *ch = dma->opaque;
>>       struct omap_dma_s *s = dma->dma->opaque;
>>       int frames, min_elems, elements[__omap_dma_intr_last];
>> +    uint64_t frames64, frame64, elements64, element64;
>>   
>>       a = &ch->active_set;
>>   
>> +    /*
>> +     * We do maths with the frame and element fields which exceeds
>> +     * a signed 32-bit integer, so convert all these to 64 bit for future use.
>> +     */
>> +    frames64 = a->frames;
>> +    frame64 = a->frame;
>> +    elements64 = a->elements;
>> +    element64 = a->element;
>> +
>>       src_p = &s->mpu->port[ch->port[0]];
>>       dest_p = &s->mpu->port[ch->port[1]];
>>       if ((!ch->constant_fill && !src_p->addr_valid(s->mpu, a->src)) ||
>> @@ -527,7 +537,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
>>       /* Check all the conditions that terminate the transfer starting
>>        * with those that can occur the soonest.  */
>>   #define INTR_CHECK(cond, id, nelements) \
>> -    if (cond) {         \
>> +    if (cond && nelements <= INT_MAX) {         \
>>           elements[id] = nelements;   \
>>           if (elements[id] < min_elems)   \
>>               min_elems = elements[id];   \
>> @@ -547,24 +557,24 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
>>        * See also the TODO in omap_dma_channel_load.  */
>>       INTR_CHECK(
>>                       (ch->interrupts & LAST_FRAME_INTR) &&
>> -                    ((a->frame < a->frames - 1) || !a->element),
>> +                    ((frame64 < frames64 - 1) || !element64),
>>                       omap_dma_intr_last_frame,
>> -                    (a->frames - a->frame - 2) * a->elements +
>> -                    (a->elements - a->element + 1))
>> +                    (frames64 - frame64 - 2) * elements64 +
>> +                    (elements64 - element64 + 1))
>>       INTR_CHECK(
>>                       ch->interrupts & HALF_FRAME_INTR,
>>                       omap_dma_intr_half_frame,
>> -                    (a->elements >> 1) +
>> -                    (a->element >= (a->elements >> 1) ? a->elements : 0) -
>> -                    a->element)
>> +                    (elements64 >> 1) +
>> +                    (element64 >= (elements64 >> 1) ? elements64 : 0) -
>> +                    element64)
>>       INTR_CHECK(
>>                       ch->sync && ch->fs && (ch->interrupts & END_FRAME_INTR),
>>                       omap_dma_intr_frame,
>> -                    a->elements - a->element)
>> +                    elements64 - element64)
>>       INTR_CHECK(
>>                       ch->sync && ch->fs && !ch->bs,
>>                       omap_dma_intr_frame_sync,
>> -                    a->elements - a->element)
>> +                    elements64 - element64)
>>   
>>       /* Packets */
>>       INTR_CHECK(
>> @@ -581,8 +591,8 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
>>       INTR_CHECK(
>>                       1,
>>                       omap_dma_intr_block,
>> -                    (a->frames - a->frame - 1) * a->elements +
>> -                    (a->elements - a->element))
>> +                    (frames64 - frame64 - 1) * elements64 +
>> +                    (elements64 - element64))
>>   
>>       dma->bytes = min_elems * ch->data_type;
> 
> Can we also add a qtest for the device that checks for this (and can be
> expanded for other unit tests later)?
> 


