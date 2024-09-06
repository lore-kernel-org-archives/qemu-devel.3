Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53283CE7B1E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaOk-0003MX-GE; Fri, 06 Sep 2024 10:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smaOg-00038R-8G; Fri, 06 Sep 2024 10:57:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smaOd-0001qi-Ig; Fri, 06 Sep 2024 10:57:14 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d87176316eso2360707a91.0; 
 Fri, 06 Sep 2024 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725634630; x=1726239430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=UvJEQ9nPdvC5fFloOwpDx13cjwQwv5NfMt0nH1un7rY=;
 b=K6DccI0RtvGtEjXAVfbEJvtCgzkRO+R88gCLkzqxkTb2j5EpEQlfHIYrN2rylUshun
 0T5eneliod+ZB7KTCdtk77SD2L8hd1MT+ZC5Rq57zX2oAQRW2AzFVJopf/MCxLPovtJ2
 pRT911g8wSlBhqn7yR5euMVGGm2RJN/ODSZsy0pAsg3K94hl9UVD/9tQllsOWU6w6A1S
 FxhB/pUXsHB/60EDVSiqD2vWyvaly1p3CDmbD2o2pYlReS/i/fUJq6pyHbwyDTIkfPCy
 bOr6/dApy7Apk3WqVOTQ3qjomM+oGj1FfBsF36GKgq8Qtc1D0lgYwaFqOEdkWKAcGGrP
 NDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634630; x=1726239430;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvJEQ9nPdvC5fFloOwpDx13cjwQwv5NfMt0nH1un7rY=;
 b=MLLRrYDZP0er78FxbCBy8KdGY5STRcs94HmwQK5kWWMveaPev44Bws5bRCy15lnalp
 YX7zLglypHIHLGgJjbSD9xFTFTHAmRmatEuZtPodES75zKv0GX7bRZxm+ln3A9yRbC+z
 FUdwTLG3oZI/hF/UB3J6q4okqDbxCEAy8glNuvRl0AI4RyL6LZ/DKdsZUpftDZtLztEI
 cDEUwyJA0RnCb0Eb4I+lP84TMzcBmaYCvL0D7TRaJ+AhQGGFx21HA2hs7ZUIx0ClfT9d
 aY2cr+q2vFg9DCIMA8HkTo2kN8ey2QwYxnLXgHlzokxjlp8Uo+BMzUXH/dKMwU3RZp1/
 FPDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKk+wX7QKKL0Az0XHunER+49/Z8ZNEIEW+TpYbBF8y/cnwjEbhOIhutpUaHayGyQO1OmrX4tH5aDc/@nongnu.org
X-Gm-Message-State: AOJu0YxQwbcWRTZHHe/ZpmIBiMsgCRZxdVZrYa8zNuFgIf1g10fFgPRh
 7+vMbKnR8MhcnzbYb2RogTene3M2BiZSAAelgvr8jBUzbbeQao0h
X-Google-Smtp-Source: AGHT+IF6WPwIKpYg3HEwbeGgtWi9QmIi5iqmzcdMXC/DsmiF6Y2aHmAaNrOR2YYJTEkZ7P2KnMqn8g==
X-Received: by 2002:a17:90b:390c:b0:2d8:ea11:b2db with SMTP id
 98e67ed59e1d1-2dad5122cc1mr5084602a91.16.1725634629542; 
 Fri, 06 Sep 2024 07:57:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc0c6d0csm1674459a91.52.2024.09.06.07.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 07:57:08 -0700 (PDT)
Message-ID: <97911998-4d74-4adf-8c43-6e81029842cf@roeck-us.net>
Date: Fri, 6 Sep 2024 07:57:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add support for IBM Bonnell
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20240906123505.3818154-1-linux@roeck-us.net>
 <36c9b2b5-5a19-4713-8e27-112ae4b83bc4@kaod.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <36c9b2b5-5a19-4713-8e27-112ae4b83bc4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 9/6/24 07:49, Cédric Le Goater wrote:
> Joel,
> 
> Would have access to a Bonnell BMC ? To get the HW strapping
> register values.
> 
> On 9/6/24 14:35, Guenter Roeck wrote:
>> Introduce support for the IBM Bonnell BMC.
>>
>> Use Rainier machine information for HW strapping and other machine details
>> since the actual hardware configuration is unknown. I2C device
>> instantiation is based on the devicetree file in the upstream Linux kernel.
>>
>> Major difference to Rainier is that the Bonnell devicetree file
>> instantiates a TPM. It is therefore possible to test TPM functionality
>> without having to instantiate the TPM manually from the Linux command
>> line.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/arm/aspeed.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index fd5603f7aa..4f833c5708 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -865,6 +865,70 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>>       create_pca9552(soc, 15, 0x60);
>>   }
>> +static void bonnell_bmc_i2c_init(AspeedMachineState *bmc)
>> +{
>> +    AspeedSoCState *soc = bmc->soc;
>> +    I2CBus *bus;
>> +
>> +    bus = aspeed_i2c_get_bus(&soc->i2c, 0);
>> +
>> +    at24c_eeprom_init(bus, 0x51, 8 * KiB);      /* atmel,24c64 */
>> +    /* tca9554@11:20 */
>> +    i2c_slave_create_simple(bus, "pca9554", 0x20);
> 
> 
> The other machine tend to simply do :
> 
>    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "pca9554", 0x20);
> 
> But that's fine.
> 

I know, I tried to avoid multiple calls to aspeed_i2c_get_bus() if the bus
is needed multiple times.

Thanks,
Guenter


