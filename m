Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE8D0C612
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4KqY-0000Gt-Iv; Fri, 25 Oct 2024 09:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t4KqW-0000Fy-BI; Fri, 25 Oct 2024 09:59:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t4KqS-0005c4-3q; Fri, 25 Oct 2024 09:59:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e49ef3bb9so1363551b3a.1; 
 Fri, 25 Oct 2024 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729864753; x=1730469553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Omhfv7LDd1IgYpgOqBUvEuV/qy6izf8fyMsU+sk0uuw=;
 b=ZsbImJJQ+e6DXKe4R+QFk1sjSjuMWV44gw3TeBr8OYgaf39m1uwrHtpo8NH7wmaw2p
 kCH8raTje/m/7/9DGsJN5AsxNICqCPzWH3r/t1UTGOvI0uAJ/zvJeaO7vq7F4hGS5qGA
 YCQdKfWKONXGIG7HduZZxtdYxHEQvydMiwY6LJ0md8GIZKHfI2UD9AhoabieXVQMnS7e
 KjWdYwnrUWFvOybefjlVu4oAG1knew0Ht6LvEh+Ixkns18VORrNmJFyVHbwoaYKj/Q9Q
 GAIFW6Umo+fdu7G0jLnA2nWC1NZ7iTFN+gzRYO99wlhtnZPVkAsBFbTvJbQN7A5A3Hsd
 9+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729864753; x=1730469553;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Omhfv7LDd1IgYpgOqBUvEuV/qy6izf8fyMsU+sk0uuw=;
 b=RlkaMMn4xiYxwWO85mtE5Yv9Y09X0fhl0PRzWCv4dVfZzMyOyVMpnYrDnAy1QdnFbv
 mqlMMeW1kmPHbXoLsy+b1DTDPWE9fPLwjjnkMcSNupaBC58IQY8ZKNpJOL7BilntERf3
 M+1kH6sioeYVnJk3UDhxYfAkxBZyTXh0G66P3hbEw2olHyANuLrOkeULs3bzde8kW4pr
 oA3/EX1UMeNPWVHnGbcsScBDHh5y8yCe8BrnCgUM0Uwtr8szs6ErS1mczt0YaxwhukMg
 BSuK31eUQZ6V8x85EKsVnjYprnu/mL6Goucf4PW4CLRZIGHLM2oOTF5n6JdKrpiK8EBx
 1bZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXML6SlK3BoWsbkZk+7nLUX996csf5ujxahu+lAEtybDv7Vhwbbfo53tGhsFRMLiEd7BSJqC7qbE9fT@nongnu.org
X-Gm-Message-State: AOJu0Yx/NjvS5C50N3KkBoRgxHl0l8vcTlo/oeT8rXKgilQ4dNsQT6Aa
 rQmH49hHbwoCVDhUT3ObpMtLx6BEAw5LN2CfU0KAHILD4gR1U4b7eJSD1A==
X-Google-Smtp-Source: AGHT+IHJDKnzilVY5kMYoweteSTnrMyqMKJbnSYTdMsGfQfo8sc6JRBciKkyio+7paPn7VjUowCALg==
X-Received: by 2002:a05:6a00:898a:b0:71e:467e:a75d with SMTP id
 d2e1a72fcca58-7204545df78mr6465360b3a.12.1729864753498; 
 Fri, 25 Oct 2024 06:59:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a3c1f6sm1079869b3a.198.2024.10.25.06.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 06:59:12 -0700 (PDT)
Message-ID: <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
Date: Fri, 25 Oct 2024 06:59:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42a.google.com
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

On 10/25/24 02:57, Jan Lübbe wrote:
> Hi,
> 
> On Fri, 2024-10-25 at 08:55 +0200, Cédric Le Goater wrote:
>> On 10/24/24 19:59, Philippe Mathieu-Daudé wrote:
>>> Cc'ing Jan.
>>>
>>> On 22/10/24 12:04, Guenter Roeck wrote:
>>>> On 10/21/24 21:09, Philippe Mathieu-Daudé wrote:
>>>>> Hi Guenter,
>>>>>
>>>>> On 21/10/24 11:02, Guenter Roeck wrote:
>>>>>
>>>>>> Unrelated to this, but I found that the sd emulation in 9.1 is also broken
>>>>>> for loongarch and sifive_u, and partially for ast2600-evb (it has two
>>>>>> controllers, with one of them no longer working). That is too much for me
>>>>>> to track down quickly, so this is just a heads-up.
>>
>> It would greatly help if we could merge some of your testsuite under QEMU.
>>
>>>>> Please Cc me with reproducer or assign Gitlab issues to me,
>>>>> I'll have a look.
>>>>>
>>>>
>>>> If it wasn't funny, it would be sad.
>>>>
>>>> hw/sd/sd.c:sd_reset() calls sd_bootpart_offset() t determine the boot partition
>>>> offset. That function needs to have sd->ext_csd[EXT_CSD_PART_CONFIG] configured.
>>>> However, the value is only set later in sd_reset() with the call to sc->set_csd().
>>>> One of the parameters of that function is the previously calculated size.
>>>>
>>>> So in other words there is a circular dependency. The call to sd_bootpart_offset()
>>>> returns 0 because sd->ext_csd[EXT_CSD_PART_CONFIG] isn't set, then
>>>> the call to sc->set_csd() sets it ... too late. Subsequent calls to
>>>> sd_bootpart_offset() will then return the expected offset.
> 
>> oh. I didn't realize that :/ I guess we only tested our own scenario when
>> we were working on the ast2600 bringup.
> 
> Ah, I missed that early call to sd_bootpart_offset() as well.
> 
> As this function calculates the *runtime* offset which changes as the
> guest switches between accessing the main user data area and the boot
> partitions by writing to the EXT_CSD_PART_CONFIG_ACC_MASK bits, it
> shouldn't be involved in the calculations in sd_reset() at all.
> 
>> I think the change in the reset handler should be :
>>
>> -    size -= sd_bootpart_offset(sd);
>> +    if (sd_is_emmc(sd)) {
>> +        size -= sd->boot_part_size * 2;
>> +    }
> 
> Yes, that seems correct.
> 
>>>> I have no idea how this is supposed to work, and I don't think it works
>>>> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.
>>>> Jan, can you have a look at this bug report please? Otherwise I'll
>>>> have a look during soft freeze.
> 
> Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
> aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the

I tried both enabled and disabled.

> boot partition size would be 0, meaning that the eMMC has no boot
> partitions.

That is what I would have expected, but it does not reflect reality.

> 
> In that configuration, your backing file needs to have space for the
> boot partitions at the start (2*1MiB) and the rootfs starts at the 2
> MiB offset.
> 

boot-emmc doesn't make a difference, because

         if (emmc) {
             qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
             qdev_prop_set_uint8(card, "boot-config",
                                 boot_emmc ? 0x1 << 3 : 0x0);
         }

in hw/arm/aspeed.c sets the boot partition size independently of the
boot-emmc flag. I suspect that the expectation is that I always provide
an emmc image with a 2 MB gap at the beginning, but in my opinion that is
really hyper-clumsy, and I simply won't do it, sorry. I can work around
the problem by changing the above code to only set boot-partition-size if
boot_emmc is set, or I can revert commit e32ac563b83. For now I chose the
latter.

Thanks,
Guenter


