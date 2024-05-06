Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38939C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ut3-0005S1-Tn; Mon, 06 May 2024 05:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3ut1-0005R2-7t
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:43:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3usw-0000pc-A9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:43:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41c7ac71996so14213815e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714988628; x=1715593428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X+4F1yoD9pWlkg7x/lCbVPD9tv9Quejjrv1H3pO9uw8=;
 b=oHYsgsk5KaMBDwMLWVIwNrorBxVdlHiCoS1gPWYVlTMkVyS0HUQyYMqJ8CC6bjC7p6
 P0K6Nh5Itx3h2s8DUBXSBsec+wlINDTlzM+roraqHUd4hu1Z+9qwjnzo+vdnDFbYYfbG
 s7aLPEPkJinfgCeRXg2mv++Z+jLlxBvM+Bj/5PYnYijzWVpcLa28+IHJBJtuSlAL9zBd
 wjtktNmPuaZizBmdksCcTLqTM6vhg1nRDK29+yli60vUdN7AZ/+MvRrTJoh6zXLPJ+R+
 wTiKmqUXEetYR0Swg/WnkXrF69gwkV/TFd1VEjcUI9LKSTNN7dkSUImh+oCde0ZDFeev
 SlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714988628; x=1715593428;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+4F1yoD9pWlkg7x/lCbVPD9tv9Quejjrv1H3pO9uw8=;
 b=DkfOtXgrwSadT/iq3KEeU4Q59RuOmp4yvxOYhG0aP37M47r6MP/xW0KivQuon7NBjI
 0vsIJAugJvBO3Z3/31KNpZxg5yzgViM+kg2DdFeBxowR9xuH0KW3bEgDQRbbQ0PnV9S3
 BxfB1QXLwARlPfD7/cSD4mEoBeYTTQTTIsdzWD3akIGX2O0RY9xbI8AJQfGuk7t6TL0z
 brB2SgpBpVPj3HT5J6GKWszkZ4dixB/fP777mgN72TnavUO1A/SrZs1eKaol+UykjsPh
 V+U4FGDAgoLYbTymIj432UC1cl778o9tXohrDJgqwu+DXJ63kqg45l82Egfu+rMwYCIu
 VI5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbzNDGQ3jBUd6mheXbwyQwEBxOyqVN4ChF+M+GVwBQfRW9vq7rOCXbRBvF4u0stV1GiCy8pG/ffQT+DvdzsLF0zHDMSD8=
X-Gm-Message-State: AOJu0Yx7fvHYNJlEpAuOxzbuqrcxBpvZkfh2PyUEQa2c11n09Cl2aiMI
 WO7+amWqsMy0VA1o4xHl363fHzqdR+Bss5SaAqcc5VDybxTp6TIxNOPlgTxPit8=
X-Google-Smtp-Source: AGHT+IGvgG94s+1rG7fvQnwNPutZt9HPbfKbFldFnklMoUVMq86LonPv8XxEj9UYPfViYf51wuXcQw==
X-Received: by 2002:a05:600c:3ac9:b0:418:df23:ae0e with SMTP id
 d9-20020a05600c3ac900b00418df23ae0emr6616904wms.40.1714988628612; 
 Mon, 06 May 2024 02:43:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05600c34c100b0041c130520f3sm19149658wmq.6.2024.05.06.02.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:43:48 -0700 (PDT)
Message-ID: <4717eddc-7564-4bb9-8abf-f42c2253e98e@linaro.org>
Date: Mon, 6 May 2024 11:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/char: Add QOM property for STM32L4x5 USART clock
 frequency
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>,
 Damien Hedde <damien.hedde@dahe.fr>
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-4-ines.varhol@telecom-paris.fr>
 <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
Content-Language: en-US
In-Reply-To: <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

(+Luc & Damien for Clock API)

On 6/5/24 11:34, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 5/5/24 16:05, Inès Varhol wrote:
>> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
>> ---
>>   hw/char/stm32l4x5_usart.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
>> index fc5dcac0c4..ee7727481c 100644
>> --- a/hw/char/stm32l4x5_usart.c
>> +++ b/hw/char/stm32l4x5_usart.c
>> @@ -26,6 +26,7 @@
>>   #include "hw/clock.h"
>>   #include "hw/irq.h"
>>   #include "hw/qdev-clock.h"
>> +#include "qapi/visitor.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>>   #include "hw/registerfields.h"
>> @@ -523,6 +524,14 @@ static Property stm32l4x5_usart_base_properties[] 
>> = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> +static void clock_freq_get(Object *obj, Visitor *v,
>> +    const char *name, void *opaque, Error **errp)
>> +{
>> +    Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
>> +    uint32_t clock_freq_hz = clock_get_hz(s->clk);
>> +    visit_type_uint32(v, name, &clock_freq_hz, errp);
>> +}
>> +
>>   static void stm32l4x5_usart_base_init(Object *obj)
>>   {
>>       Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
>> @@ -534,6 +543,9 @@ static void stm32l4x5_usart_base_init(Object *obj)
>>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>>       s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
>> +
>> +    object_property_add(obj, "clock-freq-hz", "uint32",
>> +                        clock_freq_get, NULL, NULL, NULL);
> 
> Patch LGTM, but I wonder if registering QOM getter without setter
> is recommended. Perhaps we should encourage parity? In normal HW
> emulation we shouldn't update this clock externally, but thinking
> about testing, this could be interesting to introduce jitter.

Orthogonal to this doubt, we could add the clock properties
directly in qdev_init_clock_in(). Seems useful for the QTest
framework.

> Any opinion on this?
> 
>>   }
>>   static int stm32l4x5_usart_base_post_load(void *opaque, int version_id)
> 


