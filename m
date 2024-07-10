Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD1C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRQV-0003zk-Pl; Wed, 10 Jul 2024 03:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRRQU-0003ym-RK
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:07:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRRQS-0007Yl-P8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:07:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367ac08f80fso2674613f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720595258; x=1721200058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0VeHBxGBX1Ou6sORvrOTAZOGYXppRdh3caOVXyuKTo=;
 b=I+EIBL5gQS1vFxkjTS7SEOjHozHjxTG2fY6umxwFbstQRvZrh07l8rFUB9pH5ZfT6d
 KcQhogyALZVs8h3SxI3/pJ/ZgpniEWTk0gdRTz0TOC4bfVR880BAdh03VMvhKyrLyuOW
 lswJiO1WDg8YleeXbmRqWFRMF0qwbPtH0H2SW/NFCP9T1wBPZOWAqz+FN2DtKludSM1O
 L8Abqgj891QQIw6SmZZXCYdCV0LcHXE/0+R2WFpIvNGlJsREbo4eB+yWyMTriebAr4aJ
 RKR64NWRGT1raUR9Fwe+16l1QseghHuiFU+jxqepKVIGrfJCNZmqLGvar1EOgW2jgz1w
 fzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720595258; x=1721200058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0VeHBxGBX1Ou6sORvrOTAZOGYXppRdh3caOVXyuKTo=;
 b=CzqvdRJsNnrdji7VCYiXNyg/ctuheyv8EwNhEwR9mO0MNBT/Pbj5uj/fWgYXtE7mSW
 WysSfybRLzp69W+M2u/nkr5sggmNqr33sNaZcakhPyG2ol8cJzHicex1j3eUqoS8CGGo
 pdR1rqmBKl0mfhsVme/TjLL/6pU+iBZG4bc53nJnoZexhokrXp52eEhajG6gtzrbRtEA
 CFyHO+gm6QSEdO4E44JB5n8vuXgvZXJxb9zMvZ/J2dDDFVU/Nv1AfkIQi9gkP/qlFTn2
 5PZFV19ziDa+7mg3JGrJ8Nz9HVz0qKkd8QWZMhCHP8FP+xEfDoe/OeDOzSPnb0/1dDSz
 OxAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6OnGJ/aH+NODKlnTE4A3kBB6wzNzsVb9HXablEeKBzRa6ZdCIgyGEEV1cdgRsDnyrUggdCntoG0ZzVppopaVME0RkQ1w=
X-Gm-Message-State: AOJu0YxyZu4XDDwbj1uDPyjP0YQY13mN3NIaTADFb6h8lUeLSq0UGY4/
 XdfFM12qTTxq4D6YKdjgu9iJqkD1goK8c/YlAsVLnJbF7knnm21RQAF4K5xun1c=
X-Google-Smtp-Source: AGHT+IHowyeZE0/qKnz5z9Jj3TPboxyb1DdJz9jU3cS+HUiPCcj1VM3dbYN9TesVVxg+NvL9o/sxBQ==
X-Received: by 2002:a5d:6d0a:0:b0:367:8feb:8d8 with SMTP id
 ffacd0b85a97d-367cea462a5mr4789805f8f.11.1720595258259; 
 Wed, 10 Jul 2024 00:07:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab080sm4424609f8f.104.2024.07.10.00.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 00:07:37 -0700 (PDT)
Message-ID: <ade6cd7c-ccc9-4551-acd8-2a4c5c5e1af2@linaro.org>
Date: Wed, 10 Jul 2024 09:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect HW
 strapping
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-6-clg@redhat.com>
 <f50579b99ef8883dac5fcfc1606a45abfb8bf85f.camel@codeconstruct.com.au>
 <e6ca185f-3f9a-40e1-9ed2-eccfbbdf1444@redhat.com>
 <8e770030-29ab-4e30-861f-3e735b25e37b@linaro.org>
 <b606cd09-3846-4c99-b902-b0b260d91788@linaro.org>
 <6099fc9c-c7ab-46c8-86e7-bf1e37c2cd83@linaro.org>
 <ad8c95dd-f33c-4cff-a4d9-698b65c50028@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ad8c95dd-f33c-4cff-a4d9-698b65c50028@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 10/7/24 07:14, Cédric Le Goater wrote:
> On 7/9/24 11:32 PM, Philippe Mathieu-Daudé wrote:
>> On 5/7/24 17:52, Philippe Mathieu-Daudé wrote:
>>> On 5/7/24 15:28, Philippe Mathieu-Daudé wrote:
>>>> On 5/7/24 07:38, Cédric Le Goater wrote:
>>>>> On 7/5/24 5:41 AM, Andrew Jeffery wrote:
>>>>>> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>>>>>>> From: Cédric Le Goater <clg@kaod.org>
>>>>>>>
>>>>>>> When the boot-from-eMMC HW strapping bit is set, use the 
>>>>>>> 'boot-config'
>>>>>>> property to set the boot config register to boot from the first boot
>>>>>>> area partition of the eMMC device.
>>>>>>>
>>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>>> ---
>>>>>>>   hw/arm/aspeed.c | 15 +++++++++++----
>>>>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>>>>>> index 756deb91efd1..135f4eb72215 100644
>>>>>>> --- a/hw/arm/aspeed.c
>>>>>>> +++ b/hw/arm/aspeed.c
>>>>>>> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState 
>>>>>>> *s, const char *flashtype,
>>>>>>>       }
>>>>>>>   }
>>>>>>> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo 
>>>>>>> *dinfo, bool emmc)
>>>>>>> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo 
>>>>>>> *dinfo, bool emmc,
>>>>>>> +                               bool boot_emmc)
>>>>>>>   {
>>>>>>>           DeviceState *card;
>>>>>>> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState 
>>>>>>> *sdhci, DriveInfo *dinfo, bool emmc)
>>>>>>>               return;
>>>>>>>           }
>>>>>>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>>>>>> +        if (emmc) {
>>>>>>> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 
>>>>>>> 0x48 : 0x0);
>>>>>>
>>>>>> 0x48 feels a little bit magic. I poked around a bit and there are 
>>>>>> some
>>>>>> boot-config macros, but not the ones you need and they're all in an
>>>>>> "internal" header anyway. I guess this is fine for now?
>>>>>
>>>>> You are right and we should be using these :
>>>>>
>>>>> hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG             179 
>>>>> /* R/W */
>>>>
>>>> This field is R/W and expected to be configured by the guest.
>>>>
>>>> Why the guest (u-boot) doesn't detect partitioning support?
>>>>
>>>> See eMMC v4.5 section 7.4.60 PARTITIONING_SUPPORT [160] and earlier
>>>>
>>>>    For e•MMC 4.5 Devices, Bit 2-0 in PARTITIONING_SUPPORT
>>>>    shall be set to 1.
>>>>
>>>> We don't set it so far.
>>>
>>> Sorry, I wasn't grepping in the correct branch, we do set it:
>>>
>>>       sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
>>>
>>> I'll investigate.
>>
>> Correct behavior implemented (I hope) here:
>> https://lore.kernel.org/qemu-devel/20240709152556.52896-16-philmd@linaro.org/
>>
>> Using it also simplifies this patch, we can squash:
> 
> I think we need both "boot-size" and "boot-config" properties to set
> the associated registers, BOOT_CONFIG and BOOT_SIZE_MULT. BOOT_CONFIG
> defines which devices are enabled for boot (partition 1, 2 or user area)
> and BOOT_SIZE_MULT defines the size.

I disagree: it is the guest responsibility to set the BOOT_CONFIG
register (using the SWITCH command). Unlike the BOOT_CONFIG register
which is in the (read-only) Properties Segment, the BOOT_SIZE_MULT
is in the (read-write) Modes segment and its default value is 0x00.

See the Spec v4.3, chapter 8.4 "Extended CSD register":

       The Extended CSD register defines the card properties
       and selected modes. It is 512 bytes long. The most
       significant 320 bytes are the Properties segment, which
       defines the card capabilities and cannot be modified by
       the host. The lower 192 bytes are the Modes segment,
       which defines the configuration the card is working in.
       These modes can be changed by the host by means of the
       SWITCH command.

For example in u-boot BOOT_CONFIG is set by mmc_set_part_conf():

     /*
      * Modify EXT_CSD[179] which is PARTITION_CONFIG (formerly
      * BOOT_CONFIG) based on the passed in values for BOOT_ACK,
      * BOOT_PARTITION_ENABLE and PARTITION_ACCESS.
      *
      * Returns 0 on success.
      */
     int mmc_set_part_conf(struct mmc *mmc, u8 ack,
                           u8 part_num, u8 access)
     {
         int ret;
         u8 part_conf;

         part_conf = EXT_CSD_BOOT_ACK(ack) |
                     EXT_CSD_BOOT_PART_NUM(part_num) |
                     EXT_CSD_PARTITION_ACCESS(access);

         ret = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONF,
                          part_conf);
         if (!ret)
                 mmc->part_config = part_conf;

         return ret;
     }

> There is also a BOOT_INFO reg to define support for the alternate boot
> method but I don't think we care much today.

BOOT_INFO is in the RO Properties segment. We can add a QOM property
once we model the alternate boot mode (we don't so far).

> 
> Thanks,
> 
> C.
> 
> 


