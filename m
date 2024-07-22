Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6EBC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVs25-00034C-CP; Mon, 22 Jul 2024 08:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVs23-0002yc-Nm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:20:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVs20-0002Pb-87
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:20:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so36016835e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721650842; x=1722255642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o3MTmTnf/xuhISk/ITg0IeItLg375WvqZFO4Tlc7y7w=;
 b=vbFP4J0HOKWmqyp9E4KZOeLK0h1x8xUf8llTInz73gAHWB2VTIghe8TeIds7dtE1zh
 dsv5lzT8ItwPdqLtplp2oxp5X8sWFAPJhjvCTfYzdBGHZiacPkcJkkOPi4ci3Or74xx6
 RX7hkXoyY2faNk1g1ecqTXvgqubtX7tCcdAAoQFqcyevSm/lrjyh+TfHUhFzrhnSNySJ
 OSC4oTG0fmNIt+NZAwBayO1Rx8NqynKA7iKp0N4neMgL082xKQckIL8r6iHsk3aLlRBv
 SWr9e7Q6uFH69qYxHCf9TyeQy8khiJmRzqU4zvqVp5XddrxociFbrvhYeGkV7qwLVWn0
 NiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721650842; x=1722255642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3MTmTnf/xuhISk/ITg0IeItLg375WvqZFO4Tlc7y7w=;
 b=mpICBcjC67ikCSUdnGwNfXvvGVkh3DhzZoOPSHG4JSZxlNJ97mv43Kc6qS/gcI5k4H
 Lh8X48X0FDUfTqufhChZu4ot2FB/dj6URJ0d6P+tJDsXcfYxRDDW9m1iOE3x/fo+YYES
 HvHLykx4VLkeTsge5p743lZrlPTBZATK87eTLzOET+r4ut9MVPO75UbnFhGYni/TjN4u
 +BVCSnbR1V1yeTgidHSk1C+jgWeiFHIynSx0N1HvzReNh3mXzvLqyrQM++XTEYb/nEo3
 ms5MYheut7Xs0lhvVCa6yIa9OSFIZs309pqxMWAmpGXO3sSeizghaMC8/e3BeXni0Ml5
 /lOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw+wPqKoncIrYS+Ut6LNDap+h2jys4E8S5jEPcFV1HZhwrSDyKvw9b3COw222JfetjiWml1v3RZ4ApZH/NpRv2GXARaUo=
X-Gm-Message-State: AOJu0YzY7GodjVDxh8bj3Awusv804sk1CdgPaER4tAMoWSDWOZCpkcOb
 w9L/xoF42FTJDyiyx+kug+T3EHupj4vJGIoB6rbQQcgzg4t7xzmI3LK2sTaXI0w=
X-Google-Smtp-Source: AGHT+IG2IBtz3m+6rkjg28AXNuSrTz5fQoySjI68bBJvVyTYflLZ8M0YpzNJ3volLnKBWSYaqgVgYg==
X-Received: by 2002:a05:600c:4f47:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-427dc515d17mr51610075e9.3.1721650842324; 
 Mon, 22 Jul 2024 05:20:42 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2920313sm112804515e9.0.2024.07.22.05.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 05:20:41 -0700 (PDT)
Message-ID: <778e6f3e-c4ec-4bef-a936-7dc9d8d5316c@linaro.org>
Date: Mon, 22 Jul 2024 14:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] util/fifo8: Introduce fifo8_change_capacity()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240719151628.46253-1-philmd@linaro.org>
 <20240719151628.46253-4-philmd@linaro.org>
 <e49735e8-1c33-42cb-9181-662a0c010b97@ilande.co.uk>
 <69df9510-1b1a-434e-bbbe-1df7acf49f58@linaro.org>
 <CAFEAcA_Ec_P1fNqs6aDK_QnGFDhSapf4btYoM5YjRf_3a4nRPQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_Ec_P1fNqs6aDK_QnGFDhSapf4btYoM5YjRf_3a4nRPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/7/24 13:52, Peter Maydell wrote:
> On Mon, 22 Jul 2024 at 11:56, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 19/7/24 22:21, Mark Cave-Ayland wrote:
>>> On 19/07/2024 16:16, Philippe Mathieu-Daudé wrote:
>>>
>>>> FIFOs can be resized at runtime. Introduce the
>>>> fifo8_change_capacity() method to do that.
>>>> When capacity is changed, the FIFO must be reset.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/qemu/fifo8.h | 10 ++++++++++
>>>>    util/fifo8.c         |  7 +++++++
>>>>    2 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
>>>> index c6295c6ff0..9fe0555a24 100644
>>>> --- a/include/qemu/fifo8.h
>>>> +++ b/include/qemu/fifo8.h
>>>> @@ -31,6 +31,16 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
>>>>    void fifo8_destroy(Fifo8 *fifo);
>>>> +/**
>>>> + * fifo8_change_capacity:
>>>> + * @fifo: struct Fifo8 to change the capacity
>>>> + * @capacity: new capacity of the FIFO
>>>> + *
>>>> + * Change a FIFO capacity to the specified size. The FIFO is reset.
>>>> + */
>>>> +
>>>> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity);
>>>> +
>>>>    /**
>>>>     * fifo8_push:
>>>>     * @fifo: FIFO to push to
>>>> diff --git a/util/fifo8.c b/util/fifo8.c
>>>> index 2925fe5611..c453afd774 100644
>>>> --- a/util/fifo8.c
>>>> +++ b/util/fifo8.c
>>>> @@ -34,6 +34,13 @@ void fifo8_destroy(Fifo8 *fifo)
>>>>        g_free(fifo->data);
>>>>    }
>>>> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity)
>>>> +{
>>>> +    fifo->data = g_renew(uint8_t, fifo->data, capacity);
>>>> +    fifo->capacity = capacity;
>>>> +    fifo8_reset(fifo);
>>>> +}
>>>> +
>>>>    void fifo8_push(Fifo8 *fifo, uint8_t data)
>>>>    {
>>>>        assert(fifo->num < fifo->capacity);
>>>
>>> The changes look okay, however I'm a little confused as to why this is
>>> needed as generally hardware FIFOs are a fixed size? Presumably this is
>>> related to the PL011 series?
>>
>> Indeed, this is to model trying to stay as close as possible to
>> the datasheet, which states:
>>
>>     2.4.3 UART operation
>>
>>       Disabling the FIFOs
>>
>>         Additionally, you can disable the FIFOs. In this case,
>>         the transmit and receive sides of the UART have 1-byte
>>         holding registers (the bottom entry of the FIFOs). The
>>         overrun bit is set when a word has been received, and
>>         the previous one was not yet read. In this implementation,
>>         the FIFOs are not physically disabled, but the flags are
>>         manipulated to give the illusion of a 1-byte register.
> 
> Notice that in the hardware we don't actually resize the FIFO,
> though -- we just only ever keep one element in it...

Yes. IIUC Mark's comment in the PL011 series, we don't need
this (confusing) method at all:
https://lore.kernel.org/qemu-devel/4e6b616f-3acc-4130-9b92-1af7fed540da@ilande.co.uk/

