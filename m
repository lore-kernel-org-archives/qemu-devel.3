Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3057BC5B55C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKLZ-0004SF-5Z; Wed, 28 Aug 2024 11:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1sjKLW-0004NQ-NY; Wed, 28 Aug 2024 11:12:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1sjKLU-0003uO-Le; Wed, 28 Aug 2024 11:12:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-202146e93f6so70042975ad.3; 
 Wed, 28 Aug 2024 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724857946; x=1725462746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=gGgK9/Upc9LKO92n/PRGMPv4W5/Cmzi2o2u7R0RhS7g=;
 b=dvGcKcRkAqY/D0h7MgR1QpHlqznD45Ob2YMrLt7gYSghztyRgG9jyFUCvL0BIOFXCq
 Gtj2P0IvkdsWt3QpqMsh7851gWr7LmPkoT5OTG7UsKccZAl+V8rROfwbXCKE4TmRQXTk
 RYdITLtLgndW9zxkxqHJTqR3nEvsf2v11QmGP+G8oyV0euhddRZGflC8Qn+Aa+tVT2x2
 xfvaURrTSRIDneeWvcHtw2DQVKW6CQqYT31TxHn9gl3d6ULuuH5RtK1VmO79643eIovn
 qmu1RdM6XAArrvoAENqiZ3KucxdnFIgD0RXMaPUf0rrjDBkulXpqz5xHABW7abQzK2T/
 QYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724857946; x=1725462746;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGgK9/Upc9LKO92n/PRGMPv4W5/Cmzi2o2u7R0RhS7g=;
 b=I/ZXD6uDkIffmGL9i8t6ORmVX/Qq502VioISOrTorMuWNsbr2aPTrqY6TzSZR10zT5
 lr/jmqC5p+hir+Iw+0XFD1hlLElh0IKmagRvlNgCjVCiMcj/oxLjksBXbxw7ol9MJsyC
 SYfmWrwuS6WvMC89Xsbu7SVX1KVk/0SHVeAxnsltypZWHeVOzBQKJs066QOHQu5OSfU8
 llk5gK1x0AwZVkQXEqFuha6EMx6q7b0x8XasLLCowjBCwm89Uxks3paTZsK3yC/XWd31
 Nj07x3GbKlOs8dHKBy+ouu/OSoyXcfH0Co0Y9l3hxBdrPziuLuFTuv8r+F/EsiO9VMhU
 giPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw+T+oPc/CZkQyY0V2NqVloHz3QY/L3y16tQYqubh20eV+BSDitGqk/h7I8Q0GxF6VlfM1DGr1K95h@nongnu.org
X-Gm-Message-State: AOJu0YwHMP4o8bovFeJhGXa6lWILLz5ayJBiWoF+81ocr4MOltocxDpE
 9fvSQZslw1ttTy9vudSkb5k4Iu9ogp3gxL3LhQC7Qk84sx++5AIc7iDwKw==
X-Google-Smtp-Source: AGHT+IHKNw2JsXEcC++RkI43cSny4dPU4Dpph1CaIvpu+g13es8BoSJpqfSOvUX/iWPTnQXDNyoGsg==
X-Received: by 2002:a17:903:11c5:b0:1fd:a0b9:2be7 with SMTP id
 d9443c01a7336-2039e44f83dmr198858185ad.13.1724857946086; 
 Wed, 28 Aug 2024 08:12:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-204fb9c52f7sm12349515ad.188.2024.08.28.08.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 08:12:24 -0700 (PDT)
Message-ID: <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
Date: Wed, 28 Aug 2024 08:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
 <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 8/28/24 05:35, Cédric Le Goater wrote:
> On 8/26/24 20:50, Guenter Roeck wrote:
>> Hi,
>>
>> On 8/26/24 02:58, Cédric Le Goater wrote:
>>> Hello Guenter,
>>>
>>> On 8/9/24 00:05, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Tue, Jun 25, 2024 at 09:08:30AM +0200, Cédric Le Goater wrote:
>>>>> The tacoma-bmc machine was a board including an AST2600 SoC based BMC
>>>>> and a witherspoon like OpenPOWER system. It was used for bring up of
>>>>> the AST2600 SoC in labs. It can be easily replaced by the rainier-bmc
>>>>> machine which is part of a real product offering.
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>
>>>> I have been using tacoma-bmc to test tcg,tpm-tis-i2c functionality
>>>> on arm. rainier-bmc doesn't support that, and other IBM BMCs which
>>>> do support it (bonnell, everest, system1) are not supported in qemu.
>>>>
>>>> Do you have a suggested alternative ?
>>>
>>> Could you use the ast2600-evb machine instead ? as done in
>>> machine_aspeed.py, see routine test_arm_ast2600_evb_buildroot_tpm.
>>>
>>
>> Unfortunately, that does not work for me because that requires instantiating
>> the tpm chip from the CLI by writing into the new_device sysfs attribute,
>> and I can not do that in my test environment.
> 
> Ah. too bad.
> 
>>> We can't add a "tpm-tis-i2c" device to the tacoma-bmc machine init
>>> routine because a TPM backend is required.
>>>
>>
>> Not sure I understand; tacoma-bmc instantiates the TPM chip through its
>> devicetree file which is what I was looking for.
> 
> I meant at the "HW" board level in QEMU.
> 
> We can not instantiate the TPM I2C chip device model in the tacoma-bmc
> machine init routine and attach it to the I2C bus because of the required
> TPM backend. This means that the device is necessarily defined on the QEMU
> command line and this makes the ast2600-evb and tacoma-bmc machine very
> similar in terms of HW definitions.
> 

Yes, I found that as well.

>> I solved the problem by adding support for IBM Bonnell (which instantiates
>> the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
>> copy of qemu. 
> 
> Hmm, did you copy the rainier-bmc machine definition ?
> 
For aspeed_machine_bonnell_class_init(), pretty much yes, since I don't know
the actual hardware. For I2C initialization I used the devicetree file.
You can find the patch in the master-local or v9.1.0-local branches
of my qemu clone at https://github.com/groeck/qemu if you are interested.

>> It isn't perfect since I don't know the correct HW pin strapping
>> and reused the strapping from Rainier, but it works for me.
> 
> Keeping the tacoma-bmc machine is fine if there is a use for it. Testing
> the TPM I2C device driver is certainly a good use but we should reflect
> that in QEMU also (so that we don't forget). Could we change the test in
> machine_aspeed.py to use the tacoma-bmc machine instead ? and revert the
> deprecation patch of course.
> 

No need from my perspective. This isn't the only patch I carry on top of
upstream qemu, after all.

Thanks,
Guenter


