Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D436C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0eB-0002iK-J8; Wed, 03 Jul 2024 10:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0e8-0002ba-GU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:07:45 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0e6-0000EM-OU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:07:44 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so64466131fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720015660; x=1720620460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yvBwiUeG/2+fXst9/HnPC+pkcZFZvCOi3GuzDseKw8M=;
 b=eEpzsv7ABQk4PWSLB5dnMpYn/QZ4QGB9coh+SGuSobvo1MWkPbCW1I9rTg4YhMEvHE
 QaSiBkO1dhjtHay734JZah2yTt5G2KrfjWqoLcG78rzHbVc1dyZCobiWeLBNY2a5TEgj
 KuNukiJYaD79/IRzRtcPLHYxIuVsF+v2qYifB/XFCDOZ5fpaY4HVzJ9tMxdaF0HesEQ9
 pci26GTOw3l5SNZx6rHr/W3jqG5vLmJiy2BHxovV1xiQJno3aG7ADWahBb/0pQr0XYCJ
 xL51v2swwtfVdU9YRuA/NM2CF40g8HWuUc3JfY0Hg0HZnp0lEer+w3TstFBcaqy3VWOc
 cSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720015660; x=1720620460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yvBwiUeG/2+fXst9/HnPC+pkcZFZvCOi3GuzDseKw8M=;
 b=WcPJgh4J9Hbu1UPmJy0SUs6ESiYZc8xrAnnQUuvpkR1yY7xktiRAUNGHFygZ+Ec3aX
 oUEcdKtw5fn0GI1mMdSk3JDyk4UUnF0hmnQfw3NXY4FaveFGY4Ap5zvvogKmmvpVNT2X
 w3M6LSGKM6fyvlxJW4OiB7nD7zPQG8OXt6jyYWVdO8YGZbkhqYjAkRLulc/pjwHLtOzk
 YrN99YAgcEKez6qDdKCfmJKLbjVq48qLQPgGmzm4ULd9o9D9MIgWpwCTRDiknhKeIl2v
 23dyzL6t42uYQNY9VEYMPnSITqk2t9OxHEx8EEFrarCthe/Pemp5S68hegDbgXLArd4J
 Kxiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsj0zWLTIZKKrzvdRm75mmqan2YVtWxPl54jIh8FhyzeN8Hy8KMOjABNVxL5SiLuAQZh3Bo1gjxf4s8nNxriVKwjMpk/Y=
X-Gm-Message-State: AOJu0YwkpddEGhU2pIr0kqrXbq8jBLOAJKALfal1GZKaWJeM4LJA006o
 5Jx2rRdg699KiopVcqausdf07+AcqBJBkxgwHRSOks5grNbv1gwo6Gvom1fdS7YvSm6bsTjOFdB
 2
X-Google-Smtp-Source: AGHT+IE6TqbMBUbvnR5F3lfOX/CPgiQ7oQWeYDZXJ2UaZ1fKHyhMSqxrKeCOi9SxvAp7oM0leiWW0w==
X-Received: by 2002:a2e:be13:0:b0:2ec:5b8f:c791 with SMTP id
 38308e7fff4ca-2ee5e392632mr81221521fa.13.1720015659919; 
 Wed, 03 Jul 2024 07:07:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a112a54sm15983982f8f.115.2024.07.03.07.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 07:07:39 -0700 (PDT)
Message-ID: <6a12f867-08f0-4abc-b25a-6c8e4b05c89f@linaro.org>
Date: Wed, 3 Jul 2024 16:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 5/5] hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from
 TYPE_SD_CARD
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
 <20240703134356.85972-6-philmd@linaro.org>
 <ab8de479-fc85-4e00-8fac-c49dde0a03bc@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ab8de479-fc85-4e00-8fac-c49dde0a03bc@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 3/7/24 16:02, Cédric Le Goater wrote:
> On 7/3/24 3:43 PM, Philippe Mathieu-Daudé wrote:
>> In order to keep eMMC model simpler to maintain,
>> extract common properties and the common code from
>> class_init to the (internal) TYPE_SDMMC_COMMON.
>>
>> Update the corresponding QOM cast macros.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sd/sdmmc-internal.h |  3 +++
>>   hw/sd/core.c           | 29 ++++++++++++------------
>>   hw/sd/sd.c             | 50 ++++++++++++++++++++++++++++--------------
>>   3 files changed, 52 insertions(+), 30 deletions(-)


>> @@ -2508,14 +2521,19 @@ static void sd_spi_class_init(ObjectClass 
>> *klass, void *data)
>>   static const TypeInfo sd_types[] = {
>>       {
>> -        .name           = TYPE_SD_CARD,
>> +        .name           = TYPE_SDMMC_COMMON,
>>           .parent         = TYPE_DEVICE,
>>           .instance_size  = sizeof(SDState),
>>           .class_size     = sizeof(SDCardClass),
>> -        .class_init     = sd_class_init,
>> +        .class_init     = sdmmc_common_class_init,
>>           .instance_init  = sd_instance_init,
>>           .instance_finalize = sd_instance_finalize,
>>       },
> 
> Shouldn't it be an abstract class ?

Ah yes, safer. Squashing:

-- >8 --
@@ -2513,6 +2513,7 @@ static const TypeInfo sd_types[] = {
      {
          .name           = TYPE_SDMMC_COMMON,
          .parent         = TYPE_DEVICE,
+        .abstract       = true,
          .instance_size  = sizeof(SDState),
          .class_size     = sizeof(SDCardClass),
          .class_init     = sdmmc_common_class_init,
---

> 
> 
> Thanks,
> 
> C.
> 
> 
>> +    {
>> +        .name           = TYPE_SD_CARD,
>> +        .parent         = TYPE_SDMMC_COMMON,
>> +        .class_init     = sd_class_init,
>> +    },
>>       {
>>           .name           = TYPE_SD_CARD_SPI,
>>           .parent         = TYPE_SD_CARD,
> 


