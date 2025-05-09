Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3652C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDM3c-0003ci-0b; Fri, 09 May 2025 07:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDM3U-0003XL-HL
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:38:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDM3O-0004Yv-7E
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:38:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e661313a3so19725325ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746790686; x=1747395486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQneLAYoPqsh+WqN9+rKSdA74F7DAz7nPW0LDHeC2TM=;
 b=neuu3SJpTqtU5eRni9maNxomaNa24nl7eWl/YW7Q1jWJ3nWGdwVlAKNy+CnT0H2Nxn
 Z/JtyjW5Qw5lxX+zwkNCk9aGjikJ6ll4bhGNQT/aZkjYGf1E0AfY61jhBVut/PEu/oQz
 etf/rs5b0ehiKlbnlHO4NftjseFrpxTU7op04dGRzJE3wSqGlTIL9UMQOfiiRp6zBUvG
 GGFbmCf3enT7YLuBM/2rdOcQMMQmnI2h7EsuJdu+QPDilJ44kgGzV4/d9KYcqbfrJeKQ
 7eyP9HZ5eJq+rzs7yzQnox0A165ktr5QEgNcrPXAPMeGJYWEkuKUnfZ8QzYlD9G256Yw
 3bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746790686; x=1747395486;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tQneLAYoPqsh+WqN9+rKSdA74F7DAz7nPW0LDHeC2TM=;
 b=NWOwyoW2ECtOu9r7jcCqC0ISlLLnZo6UQNlgffwWz1dqnHY/Dazx/FjmaLuBEOVUka
 pmzQ/OF3SWT7gxXgufrCTPXLQSmRGKRA5EgHu2cIjFBuVCVCBYE5YXIs8aNOgdeHU+t1
 o5BmdJX/LP2HI56d3SwACKFcQBmtW3gZFnkE+hjQ585NmJZ7YXvkWhz9yncltCcUU2pV
 ILEMgbLrp+5yOrrfCqTxK6pbSD/vncsIdxJx/xT1Ln4jBRXamtE4hpaTJvW1YbTaeiIa
 q3KTlwMMDXTj7MmXsnigyOlSplraUGcZn8MK62pTI9hs8+HK1anee2iEJN8HwJ5GzlZh
 dfuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPaeamH8k/juKpCfequKNec/MMbJZr8925ouILXI/NJ6J0qm0bZu8vDkyZ3VutpNXBippt1xTHZGeT@nongnu.org
X-Gm-Message-State: AOJu0Ywt+TMkijr7u5HUwEnQhCTTRpvt4w4cIlEgQOTAn1ykHuITYJMT
 ruBhXSkBwXRAvCYS1iDTFoBX98Uc7ogwSIDa60O7e89kp5H+XmkQ
X-Gm-Gg: ASbGncuWx0Yjykcc3MN564noe/9UHGLg900rOemcNxeCYDdnTyhEVJa10ZXZ00q9NxG
 G1h3hXG4iixzbFI2bQAkpGjcVGEANbegE86/YCL3pivd81+WSSprlrNwjdY8JDvYlucPAQYyRcu
 ULr/lgCyWWmp996V1loeraClkJaskvuJQz33Gj5iXp3AtgjONSeYGgX+QZSqg803udaWx2q84w2
 7SRdPRDP+fh2IvQnBfQmUlzrXhblLZJQsGtvZprKdDy34OpQTZzmxpDnfcERYp/AOaztKMeyF5d
 Fd7TY372lUcWQQlYxCLL6gsn+a1qK1CR17zTnhR2OIbBSrcOsRJlJkD5p6obGQMXrQIF5bLGD8j
 nuHWFcT5uMYWv4dxk7A9JSZJz3PMsNqT1uIw7q+jQWrHPKLE=
X-Google-Smtp-Source: AGHT+IGeLvcoVQ8PR9MW4Z5QpnoL1FU0ZEnG2fc2ZBliWGn2SMDmHsUwMafEezr+FdLHeZbhAtm1GA==
X-Received: by 2002:a17:903:230e:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-22fc918e46dmr40360485ad.49.1746790685849; 
 Fri, 09 May 2025 04:38:05 -0700 (PDT)
Received: from ?IPV6:240e:404:1920:fd75:c5dc:7302:8c3:8925?
 ([240e:404:1920:fd75:c5dc:7302:8c3:8925])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc77413f6sm15366955ad.83.2025.05.09.04.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:38:05 -0700 (PDT)
Message-ID: <3a4366b3-7eaa-4578-b0f2-f68bd0f86cc4@gmail.com>
Date: Fri, 9 May 2025 19:37:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/cs4231a: fix assertion error in isa_bus_get_irq
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <b18184b6-aa78-4b81-b2af-96a5628f122b@gmail.com>
 <6222ad86-ef37-49f8-9e89-997208123c99@linaro.org>
From: Zheng Huang <hz1624917200@gmail.com>
In-Reply-To: <6222ad86-ef37-49f8-9e89-997208123c99@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Philippe,

On 2025/5/9 19:28, Philippe Mathieu-Daudé wrote:
> Hi Zheng,
> 
> On 9/5/25 13:15, Zheng Huang wrote:
>> This patch fixes an assertion error in isa_bus_get_irq() in
>> /hw/isa/isa-bus.c by adding a constraint to the irq property.
> 
> Can you provide a reproducer to trigger that?
> 

Sure, this bug occures when start qemu with:

```bash
qemu-system-x86_64 -display none -machine accel=qtest -m 64 -M pc  -nodefaults -audiodev none,id=snd0 -nodefaults -device cs4231a,audiodev=snd0,irq=17
```

and error message following:
qemu-system-x86_64: ../hw/isa/isa-bus.c:84: qemu_irq isa_bus_get_irq(ISABus *, unsigned int): Assertion `irqnum < ISA_NUM_IRQS' failed.

Besides, pls refer to patch v2, in which I updated the constraint.

>>
>> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
>> ---
>>   hw/audio/cs4231a.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
>> index 5a9be80ba3..d390da4c37 100644
>> --- a/hw/audio/cs4231a.c
>> +++ b/hw/audio/cs4231a.c
>> @@ -682,6 +682,10 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   +    if (s->irq >= ISA_NUM_IRQS) {
>> +        error_setg(errp, "Invalid IRQ %d (max %d)", s->irq, ISA_NUM_IRQS);
>> +        return;
>> +    }
>>       s->pic = isa_bus_get_irq(bus, s->irq);
>>       k = ISADMA_GET_CLASS(s->isa_dma);
>>       k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
> 


