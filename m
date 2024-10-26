Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B5D10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Yhr-00048u-QQ; Sat, 26 Oct 2024 00:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yhn-00047z-2w
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:47:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yhk-0001zA-0R
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:47:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c7edf2872so27599475ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729918030; x=1730522830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJ8dGdbJeWFvl4ollPhSLJU33Y4fP/CM8oXsOmLAysE=;
 b=IDXjLRVC2I2ghy3+DYoY/1WI5SqeOMP/VPtf3cQrEVT9N/hVgS73rVXc7pos9+atrw
 0ZhbC4Q1sZcFWfo+3ekRyjuxmIuZQKqggZBqCbSo7qOpf/NJ6D3eb4Vyg0VFwPytszk/
 QGE4rMaAG2PjYhcIoAH5aBDQ1yzzvg1VP7ausAwGUC0QL2pDzEcOhzB3/4adByelICqU
 pN7JZsgc+sKuHR3soEyfS/aml8y3Wv3WPfJyTEVEPI23PAs8gykpaupjZGDKE/icCrnF
 N2c7eFUtPqmaxqJCq104lioY39jveOaE15dZR4rfBha//c9cSBjUV5hqKNrkA2RyZIiM
 63Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729918030; x=1730522830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yJ8dGdbJeWFvl4ollPhSLJU33Y4fP/CM8oXsOmLAysE=;
 b=s73Lui7LHfR6jyJccfaLT+B6+zNqzVv7ac6M0mJstpJwkMmsCLcSyKuc3I80EXQcxr
 E3qDlMTqSDJECZ1YsyvEDlnlFKoX726mQWKFFV/n7JkEvA+5r7wzmpIwMxcKvCFJCsTO
 rTGVJdGUaCoPcqUA+aVqTdOolH3crlVYRgU4t83ccBZ2fNTObZt28lVIHiyUAthFuUjE
 9WNM60ZECjwNBNYPCKykc+SmN8U3FO5rJnIW360yo1ss3l1Bi1p+C6ynkN0VxXQY3+Ip
 9MsEcTA3Ed4KWdovqMsWP3cA+90wtOoqUFhOy9uroJwdHyYv3ZKs6GJUYSdh9+fh54s1
 SezA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0hVGggF9mrbIaYJ/K6emTwmh4VKakjLtnOvbIskWwz3wVHZG40PqB5ojTWXBF1rQranwxClNQmUCh@nongnu.org
X-Gm-Message-State: AOJu0YzJ6vVyzc3tDfxGFxlFbABuIIzX3O8uyOhJi5xl4f0Hqlt4Tj0t
 /UgqxzD4HpbFNDrSdLSvhwbiJWLTEblWBLt0RSMXsR1re+RX2BKYACAiV8QuJkusZPRWGxLcwNG
 x
X-Google-Smtp-Source: AGHT+IF+wwvDyY7vdllMZgo7yciTs2+xBuNFGf/BBmG+PsfO40xE9zG3M5xxT2zCqtExzIR1MmK4aw==
X-Received: by 2002:a17:903:32ce:b0:20c:5990:897c with SMTP id
 d9443c01a7336-20fb8a5b3c2mr111413415ad.27.1729918030152; 
 Fri, 25 Oct 2024 21:47:10 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc0303dbsm17280395ad.217.2024.10.25.21.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:47:09 -0700 (PDT)
Message-ID: <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
Date: Sat, 26 Oct 2024 01:47:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 12:25, Jan Lübbe wrote:
> On Fri, 2024-10-25 at 06:59 -0700, Guenter Roeck wrote:
>> On 10/25/24 02:57, Jan Lübbe wrote:
>>> On Fri, 2024-10-25 at 08:55 +0200, Cédric Le Goater wrote:
>>>> On 10/24/24 19:59, Philippe Mathieu-Daudé wrote:
>>>>> Cc'ing Jan.
>>>>>
>>>>> On 22/10/24 12:04, Guenter Roeck wrote:
>>>>>
>>>>>> I have no idea how this is supposed to work, and I don't think it works
>>>>>> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.
>>>>>> Jan, can you have a look at this bug report please? Otherwise I'll
>>>>>> have a look during soft freeze.
>>>
>>> Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
>>> aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the
>>
>> I tried both enabled and disabled.
>>
>>> boot partition size would be 0, meaning that the eMMC has no boot
>>> partitions.
>>
>> That is what I would have expected, but it does not reflect reality.
>>
>>> In that configuration, your backing file needs to have space for the
>>> boot partitions at the start (2*1MiB) and the rootfs starts at the 2
>>> MiB offset.
>>>
>>
>> boot-emmc doesn't make a difference, because
>>
>>           if (emmc) {
>>               qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>               qdev_prop_set_uint8(card, "boot-config",
>>                                   boot_emmc ? 0x1 << 3 : 0x0);
>>           }
>>
>> in hw/arm/aspeed.c sets the boot partition size independently of the
>> boot-emmc flag.
> 
> Ah, yes. :/
> 
> So you can have SD, eMMC with boot from boot partition *disabled* or
> eMMC with boot from boot partition *enabled*.
> 
>> I suspect that the expectation is that I always provide
>> an emmc image with a 2 MB gap at the beginning, but in my opinion that is
>> really hyper-clumsy, and I simply won't do it, sorry.
> 
> I was surprised that the boot partitions' contents are stored in the
> same backing file as the main area (instead of being separate files).
> But I've not researched why it was designed this way.

Yeah I'd have preferred separate files too, but when it seemed
to be simpler for the single user case:
https://lore.kernel.org/qemu-devel/d48b6357-c839-4971-aa28-bdbd5b1bab53@kaod.org/

> 
>> I can work around
>> the problem by changing the above code to only set boot-partition-size if
>> boot_emmc is set, or I can revert commit e32ac563b83. For now I chose the
>> latter.
> 
> With e32ac563b83 reverted, your backing file layout will change *at
> runtime* depending on whether booting from the boot partition is
> enabled via EXT CSD registers. You should be able to try that using
> 'mmc bootpart enable <boot_part> 0 /dev/mmcblk0' (with boot_part=0 for
> disabled and boot_part=1/2 for enabled).
> 
> 
> I'm not sure what the best way forward is... perhaps make the boot-
> partition-size zero if boot_emmc is false? e.g.
> 
> @@ -339,7 +339,12 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>           }
>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>           if (emmc) {
> -            qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
> +            /*
> +             * Avoid the requirement for a padded disk image if booting from
> +             * eMMC boot partitions is not needed.
> +             */
> +            qdev_prop_set_uint64(card, "boot-partition-size",
> +                                boot_emmc ? 1 * MiB : 0);
>               qdev_prop_set_uint8(card, "boot-config",
>                                   boot_emmc ? 0x1 << 3 : 0x0);
>           }
> 
> 
> Then you'd have the choice between:
> - an eMMC, but without boot partitions (and simple backing file layout)
> - an eMMC with boot partitions and need a backing file with
>    the boot partitions at the beginning
> 
> That might be the lesser evil. :)
> 
> Jan
> 


