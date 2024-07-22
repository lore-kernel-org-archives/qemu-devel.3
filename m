Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD439C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqi7-0001ow-Rf; Mon, 22 Jul 2024 06:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVqi5-0001io-Gp
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:56:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVqhw-0000lU-2x
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:56:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so29468935e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721645754; x=1722250554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSqRJsuOgPkQp+molU80IEyHUVgCBYRr0K3MQ8/UCKY=;
 b=GRnpqZjdZ3qF3xPhODFKY8143OTTNzwlAJD3dHi02dk4VbqDDrqGGN/ScZRurd4GIr
 Fq0AB4Q1UGoHsMrD7YNum8GYCGbMRHljL20KBHxFtXjO0v56LvPk+CLYLPYFgp92wK9O
 nrR+jonvP2TsCgFG/g+KoUDp7MCQGQ9WLNeF6+FuiBDq2sqg4NIqoY551kN5C1ZkbRIU
 wtvMrw8DVC17FLh5dAOwbPKnRZy52SHUVhY2IOzXbsmZtJsCWo2sR9FlLg6xsLYZKvo1
 aH+gImv4Ayszv4yx8CHUTBCCTcTBV1KUgVTQFJiScurzALlNyqzVC9F00uWEx5ambjgw
 E1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721645754; x=1722250554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSqRJsuOgPkQp+molU80IEyHUVgCBYRr0K3MQ8/UCKY=;
 b=eMP9mbrUFMdviUEVtJMTO+srAuOx3Oxq66F3LlWq0vEpxlw84vHvKVWwJKRsWWuD29
 n5We5rDJ44MMa8fvcASTit86Yd68Qh3v0KNAO/AXrxFAepB+Dw3Acyka823yxxdBc58h
 XQ3DjptYfm7mHMeEw9FAzXrEY4GzMS3Ur8wDbsgMz2qdHs/b+ZiidlR0oS+iNo9Tlhcx
 NLVip/E7Bn3LHCnsXxq9PiTnI8XzJ0zgjwPVOU2Ap3oCNwpCigxhVtxRVYss2MxvH3mL
 ixI663J4BS5QCz8Pgvhhozf5sDpqSsI1RV6+KEymzcSM0nghjuPV5e9W9DmQ+bjsiqe3
 s7NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXLA8fEg+wmnryFiSbPHKNR/QUH++sK5mYa61FM/3EN80FP1iVRhlM6qdb9v6R7QrvLERuujNku2aGtM5BAqJYX8cmjc=
X-Gm-Message-State: AOJu0YyZpvbQN9xZKf2Mg1zeuYadwO4yKqyS1AgyhtbQ8knom+EkRvnE
 DdqQlB7N0KLDzwMzu/jJz/bAwbSIDYSSP+eOc2tASxdIwudmHTrQWf+pjvcsYLnBDbMFSSItXOt
 v
X-Google-Smtp-Source: AGHT+IEPlfCS+7hbnElK16ovnhrYILyiKEaLq6tQ1oWgXZZQI5wGJWh0XxtdQkdXQ1jzppImGSaXww==
X-Received: by 2002:a05:600c:1c8b:b0:426:54c9:dfed with SMTP id
 5b1f17b1804b1-427dc57654bmr38882185e9.28.1721645753479; 
 Mon, 22 Jul 2024 03:55:53 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8e68ba0sm114323815e9.21.2024.07.22.03.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:55:53 -0700 (PDT)
Message-ID: <69df9510-1b1a-434e-bbbe-1df7acf49f58@linaro.org>
Date: Mon, 22 Jul 2024 12:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] util/fifo8: Introduce fifo8_change_capacity()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240719151628.46253-1-philmd@linaro.org>
 <20240719151628.46253-4-philmd@linaro.org>
 <e49735e8-1c33-42cb-9181-662a0c010b97@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e49735e8-1c33-42cb-9181-662a0c010b97@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 19/7/24 22:21, Mark Cave-Ayland wrote:
> On 19/07/2024 16:16, Philippe Mathieu-Daudé wrote:
> 
>> FIFOs can be resized at runtime. Introduce the
>> fifo8_change_capacity() method to do that.
>> When capacity is changed, the FIFO must be reset.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/fifo8.h | 10 ++++++++++
>>   util/fifo8.c         |  7 +++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
>> index c6295c6ff0..9fe0555a24 100644
>> --- a/include/qemu/fifo8.h
>> +++ b/include/qemu/fifo8.h
>> @@ -31,6 +31,16 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
>>   void fifo8_destroy(Fifo8 *fifo);
>> +/**
>> + * fifo8_change_capacity:
>> + * @fifo: struct Fifo8 to change the capacity
>> + * @capacity: new capacity of the FIFO
>> + *
>> + * Change a FIFO capacity to the specified size. The FIFO is reset.
>> + */
>> +
>> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity);
>> +
>>   /**
>>    * fifo8_push:
>>    * @fifo: FIFO to push to
>> diff --git a/util/fifo8.c b/util/fifo8.c
>> index 2925fe5611..c453afd774 100644
>> --- a/util/fifo8.c
>> +++ b/util/fifo8.c
>> @@ -34,6 +34,13 @@ void fifo8_destroy(Fifo8 *fifo)
>>       g_free(fifo->data);
>>   }
>> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity)
>> +{
>> +    fifo->data = g_renew(uint8_t, fifo->data, capacity);
>> +    fifo->capacity = capacity;
>> +    fifo8_reset(fifo);
>> +}
>> +
>>   void fifo8_push(Fifo8 *fifo, uint8_t data)
>>   {
>>       assert(fifo->num < fifo->capacity);
> 
> The changes look okay, however I'm a little confused as to why this is 
> needed as generally hardware FIFOs are a fixed size? Presumably this is 
> related to the PL011 series?

Indeed, this is to model trying to stay as close as possible to
the datasheet, which states:

   2.4.3 UART operation

     Disabling the FIFOs

       Additionally, you can disable the FIFOs. In this case,
       the transmit and receive sides of the UART have 1-byte
       holding registers (the bottom entry of the FIFOs). The
       overrun bit is set when a word has been received, and
       the previous one was not yet read. In this implementation,
       the FIFOs are not physically disabled, but the flags are
       manipulated to give the illusion of a 1-byte register.


