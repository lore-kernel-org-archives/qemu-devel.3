Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD23C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx699-0000Ks-Ta; Wed, 17 Apr 2024 10:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rx692-0000I8-0Z
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 10:20:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rx690-0006pJ-7s
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 10:20:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418d1edcd4cso1075995e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713363612; x=1713968412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g64g9Pt7qYCOpYOwvn3RujnDyp9ytH97gIhVySUkEbw=;
 b=AnM8JlPjLg/KW/dBfYha08dPX4cO/ulcd/BWZVs/3RS9htRbFLlhO/c5IT9abZ3gUT
 mekzUJUiRsZ7NZ20EIFCEgnagtuQ49xphdFeR2MOiTMyPG0Y/TDd2FPlmYpiMj6xXbqp
 L8c1vcJygjmjcT0U4+jwd+I5PiM4OT4qorrDy7K+8Zb0kQ6hDomHamFQpVlr6lEqqqfJ
 l0k6176jFSIteTyBx8oAftetorE8QAvPnKraq5c0nfEsKmopIdFeaIrSqzjIKRKHmEDC
 l8LETli50a8jOA3TxuM7cZ2VV7yd+5+mlrB3IQ9I0Gr3Hwa0qa1dJeYubjz6ioCak93w
 plsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713363612; x=1713968412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g64g9Pt7qYCOpYOwvn3RujnDyp9ytH97gIhVySUkEbw=;
 b=a+32Xzz9FIgNDDEiZrRI5TT0NCUu4DcVuB3NN1xIicb/uV1MGV1LrGdFB/XmX1tRro
 sBg3VXc6t0GYg/83Aph/2vaCMPOABGmN2n2HRLRDapmCmQ8ofY1ridhMIXF2OoM4uY8g
 nQFd5Wpqu88HTRFlfBxksg4qge9Wlj0rWdeRODrNVRVkMyAjIfDuX6x9Ji/riqYUKqcp
 ypT+hfa84XqHcD1BjWBFxAhj+WQ9nR7eLeDB8+MWseP8IFy2Kkl+zoLa4NPh3jKuLiSh
 VfGHePrUZr+jI55Ml7GyA05XeiX7+v8v2Ao+GAyOBF2vDpe2paW7YGTiJx2CzkTArST8
 GS+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWHWJtC8PilJct41H7CxGgR4hYfDM8Ftf+g5EAcnLczVzJCuKBtyZKhMZ/RdbD9FO0j4ivo0rFWE920AzcfSLG6AVs+4o=
X-Gm-Message-State: AOJu0YzMWggn4WuWYASaGlCKoT8U1dXmSilRHY03/vSFDQRIC7CAQvad
 6VOa1EQcVAEQDpExJouX3x+iakkAgHZOcNi2YVB1lkZdRT07bpas/mJ+eYurgQ4=
X-Google-Smtp-Source: AGHT+IF6Rss2bSmv3KpuS6EE5mk/PigbaBa3Ugivi4GOTh/NWSwnGsvpkq0mO65NDVuZZ6imPpaaSQ==
X-Received: by 2002:a05:600c:4e8e:b0:417:f7ad:7066 with SMTP id
 f14-20020a05600c4e8e00b00417f7ad7066mr12090784wmq.38.1713363612186; 
 Wed, 17 Apr 2024 07:20:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adfc805000000b00349bd105089sm1780408wrh.47.2024.04.17.07.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 07:20:11 -0700 (PDT)
Message-ID: <9722502e-ce18-49d4-932e-4ff777163763@linaro.org>
Date: Wed, 17 Apr 2024 16:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/i2c: Fix checkpatch line over 80 chars warnings
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
References: <20240416184722.28334-1-philmd@linaro.org>
 <20240416184722.28334-3-philmd@linaro.org>
 <4513c447-2ef3-4547-875b-5500067b44eb@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4513c447-2ef3-4547-875b-5500067b44eb@kaod.org>
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

On 17/4/24 08:24, Cédric Le Goater wrote:
> Hello,
> 
> On 4/16/24 20:47, Philippe Mathieu-Daudé wrote:
>> We are going to modify these lines, fix their style
>> in order to avoid checkpatch.pl warnings:
>>
>>    WARNING: line over 80 characters
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/i2c/i2c.h            |  11 ++-
>>   include/hw/nvram/eeprom_at24c.h |   6 +-
>>   hw/arm/aspeed.c                 | 140 +++++++++++++++++++-------------
>>   hw/nvram/eeprom_at24c.c         |   6 +-
>>   4 files changed, 98 insertions(+), 65 deletions(-)


>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), 
>> "dps310", 0x76);
>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), 
>> "max31785", 0x52);
>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), 
>> "tmp423", 0x4c);
>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), 
>> "tmp423", 0x4c);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>> +                            "dps310", 0x76);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>> +                            "max31785", 0x52);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>> +                            "tmp423", 0x4c);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>> +                            "tmp423", 0x4c);
>>       /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), 
>> TYPE_TMP105,
>> -                     0x4a);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>> +                            TYPE_TMP105, 0x4a);
>>       /* The witherspoon board expects Epson RX8900 I2C RTC but a 
>> ds1338 is
>>        * good enough */
>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), 
>> "ds1338", 0x32);
>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>> +                            "ds1338", 0x32);
> 
> If the definitions were on a single line, they would be more
> readable IMHO. So I would do the opposit change ...
> 
> An alternate solution could be to define an array of devices
> at the machine class level, something like
>    struct i2c_device [
>            const char *type;
>            uint8_t bus;
>            uint8_t addr;
>    } devices[] = { ... };

I agree this would be better, but this should be done separately
of this series. For now I propose not modifying hw/arm/aspeed.c
in this patch, and ignoring the checkpatch errors in the next
patch. What do you think?

