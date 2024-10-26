Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F5D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 05:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ZlC-0007Z6-Hb; Sat, 26 Oct 2024 01:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t4Zl4-0007YM-R9; Sat, 26 Oct 2024 01:54:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t4Zl1-0001KO-Oy; Sat, 26 Oct 2024 01:54:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so2143938a91.1; 
 Fri, 25 Oct 2024 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729922077; x=1730526877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=NOMGy2FEk66qzMckv6NEqNCB3zgERDeVlupgMzTkWMg=;
 b=kI5y4OkmY8sO3OdztOvoq/rwfxG41DszzpxMVgBJf6RVi0kGcCtYmdGXgy06aGLaui
 cp5NGPTvQyzeJIIW7FWQjacThAR029jft5vhRwWvz27WIYVvhcSwbLbBt3OJelADaUnj
 g3ukF0JwLG9eOOKV9S3HYjJ5UYVksN/8jRq5okrsA6rq7iJv1V+7N1JwsvSCgXPLQBIA
 5y/kbWTZO62H31mw9PheM/2D12zUnipzpQDZ/GxO+rPNKqOpwvJ1a7XYEmtDPNgmpmGt
 wRhfJ9svctc+KlVobM6EaeD/shuUrwxNhmUtJ25l8mdSFxfV6kUkByvM2dvgrAHJe+Qz
 fULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729922077; x=1730526877;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOMGy2FEk66qzMckv6NEqNCB3zgERDeVlupgMzTkWMg=;
 b=EVMOLfheDrIiVr1fod9znbFuYtQbJhV3vWlXpSQJl0uaUHwdVX3qsWjAqncgppjtw8
 6zvjsl53bS9ijc6Mve+oPYMDJZllqW/FHKtII/lNZrFdmW2OYZxZATijaPUx5R1yONfT
 sFTrMo2nwkhJ4tIK469oA9m0Cm8FPTUYALDbpUMgdJ6U1ryHVlRxMPKDfQWwpJP7RBHE
 JuCKAErdIcolNGVbRj9XjqWlXFqGweJ10rDpTfWE+NHAdbpJUGhXoZdgSqh7GH3kSTQY
 btqcBae3C2ArHXTBtxU7Aun7xgylOMmc27FprfZlbIDWKwp5XAp0NqwCvfKRbkJC58x8
 bipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21pWiAz78e25rjzc6NmONv2Hf79EJNRuJnplWSBY0GeZndNfTVdlzYFoi/dzZ8WidckX+aY0j4XYo@nongnu.org,
 AJvYcCW9PW9nnvVorfLIqha1KuYZcKWgiUfDGjn5/qb6zVts41/6QQk7y1UOmaOcPzKRuazJlVjTx+8yBx6NuQ==@nongnu.org
X-Gm-Message-State: AOJu0YzCt356Xx+67hfQu5rPAy7KT2XG9D19Uq5K5YV9tZP0DpOJMVJ0
 vJB4fTTlHLPzGTtqQ7zP3/4l3EoXZs41kitxW9fC/Ts4tzMxtgD5
X-Google-Smtp-Source: AGHT+IFJG4Cj/fqsoZNGSucSYoUv9Fl2K2E7HwCFBwMlahm5V4eoqQix85zJpo05dvtFAoMiTAOhbQ==
X-Received: by 2002:a17:90a:b305:b0:2e2:9038:4a48 with SMTP id
 98e67ed59e1d1-2e8f10a6e39mr2108770a91.32.1729922077318; 
 Fri, 25 Oct 2024 22:54:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e3555b67sm2627131a91.9.2024.10.25.22.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 22:54:36 -0700 (PDT)
Message-ID: <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
Date: Fri, 25 Oct 2024 22:54:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-block <qemu-block@nongnu.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
 <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
 <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 21:47, Philippe Mathieu-Daudé wrote:
> On 25/10/24 12:25, Jan Lübbe wrote:
>> On Fri, 2024-10-25 at 06:59 -0700, Guenter Roeck wrote:
>>> On 10/25/24 02:57, Jan Lübbe wrote:
>>>> On Fri, 2024-10-25 at 08:55 +0200, Cédric Le Goater wrote:
>>>>> On 10/24/24 19:59, Philippe Mathieu-Daudé wrote:
>>>>>> Cc'ing Jan.
>>>>>>
>>>>>> On 22/10/24 12:04, Guenter Roeck wrote:
>>>>>>
>>>>>>> I have no idea how this is supposed to work, and I don't think it works
>>>>>>> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.
>>>>>>> Jan, can you have a look at this bug report please? Otherwise I'll
>>>>>>> have a look during soft freeze.
>>>>
>>>> Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
>>>> aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the
>>>
>>> I tried both enabled and disabled.
>>>
>>>> boot partition size would be 0, meaning that the eMMC has no boot
>>>> partitions.
>>>
>>> That is what I would have expected, but it does not reflect reality.
>>>
>>>> In that configuration, your backing file needs to have space for the
>>>> boot partitions at the start (2*1MiB) and the rootfs starts at the 2
>>>> MiB offset.
>>>>
>>>
>>> boot-emmc doesn't make a difference, because
>>>
>>>           if (emmc) {
>>>               qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>>               qdev_prop_set_uint8(card, "boot-config",
>>>                                   boot_emmc ? 0x1 << 3 : 0x0);
>>>           }
>>>
>>> in hw/arm/aspeed.c sets the boot partition size independently of the
>>> boot-emmc flag.
>>
>> Ah, yes. :/
>>
>> So you can have SD, eMMC with boot from boot partition *disabled* or
>> eMMC with boot from boot partition *enabled*.
>>
>>> I suspect that the expectation is that I always provide
>>> an emmc image with a 2 MB gap at the beginning, but in my opinion that is
>>> really hyper-clumsy, and I simply won't do it, sorry.
>>
>> I was surprised that the boot partitions' contents are stored in the
>> same backing file as the main area (instead of being separate files).
>> But I've not researched why it was designed this way.
> 
> Yeah I'd have preferred separate files too, but when it seemed
> to be simpler for the single user case:
> https://lore.kernel.org/qemu-devel/d48b6357-c839-4971-aa28-bdbd5b1bab53@kaod.org/
> 

I don't mind a single file. What bothers me is that the partitioning is made
mandatory for ast2600 even if not used.

Guenter

>>
>>> I can work around
>>> the problem by changing the above code to only set boot-partition-size if
>>> boot_emmc is set, or I can revert commit e32ac563b83. For now I chose the
>>> latter.
>>
>> With e32ac563b83 reverted, your backing file layout will change *at
>> runtime* depending on whether booting from the boot partition is
>> enabled via EXT CSD registers. You should be able to try that using
>> 'mmc bootpart enable <boot_part> 0 /dev/mmcblk0' (with boot_part=0 for
>> disabled and boot_part=1/2 for enabled).
>>
>>
>> I'm not sure what the best way forward is... perhaps make the boot-
>> partition-size zero if boot_emmc is false? e.g.
>>
>> @@ -339,7 +339,12 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>>           }
>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>           if (emmc) {
>> -            qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>> +            /*
>> +             * Avoid the requirement for a padded disk image if booting from
>> +             * eMMC boot partitions is not needed.
>> +             */
>> +            qdev_prop_set_uint64(card, "boot-partition-size",
>> +                                boot_emmc ? 1 * MiB : 0);
>>               qdev_prop_set_uint8(card, "boot-config",
>>                                   boot_emmc ? 0x1 << 3 : 0x0);
>>           }
>>
>>
>> Then you'd have the choice between:
>> - an eMMC, but without boot partitions (and simple backing file layout)
>> - an eMMC with boot partitions and need a backing file with
>>    the boot partitions at the beginning
>>
>> That might be the lesser evil. :)
>>
>> Jan
>>
> 


