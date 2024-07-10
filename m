Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87402C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRSA8-0003mn-Q8; Wed, 10 Jul 2024 03:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRSA7-0003ld-LS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRS9t-0007sb-0U
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720598075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jubHSxmXlMwiWurd5xV/Oce8xrO/EEgbqgeIybX2ld0=;
 b=MRLXr3IFmcf1WEnLKlrtPKW0WU2zuLhkEgQ/eZENkvJZ9xcff7wZA4Js1WIoOsH80KlHum
 ZZ/ZO/4gE/4j6h9VIsSZ/0rDw1Ta7dTYSN4BA1kq2mHtevBHAda2X+5zVizYcEQdACQBhC
 WLe1ImBtkVTMv/iY8Vul1iBKkTG0riE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-oqAJ9zuoNN2FLsr2GWfgfA-1; Wed, 10 Jul 2024 03:54:30 -0400
X-MC-Unique: oqAJ9zuoNN2FLsr2GWfgfA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44668469cefso76480071cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720598070; x=1721202870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jubHSxmXlMwiWurd5xV/Oce8xrO/EEgbqgeIybX2ld0=;
 b=ZuqUqDQIuZeESXsg0pC56E8WnwujzrBWPOlE1/9f7djI8wbz9kZPpucBZL/gz6jHLW
 kYQuwcZRnMxEODixWGinli9cQMgVqWIRIm9FlBRFqhsFYlKV2h+LXZOpukAmdlFcTnLj
 RbvPhm8Ff3mHAJ/HS/BNG9ORPdjzAqF37dC8/p9fRM4Cd51vj9SppbbCESD+H73OWwJr
 3CWK4OhWGx0myTks+o3GoQHqXVs5hZTvasxeFbRSPW40Uwud7BYkn3FC9prm1iP4bV7J
 MuyKulEVuQ3qAmUp7nSM2Q1cVxB0Q3PlzdrqoxdS7BJEZmWeIwiuRG5zLLN5Mwe9MQ7+
 G6hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbrWO2si5RVlHO4171jQkIk0gHi9d+kUih6Lo0dZnTE6hhlziBjVLqK7e0/O+dqnU8hTWRGP5EdQ/PcazxnCLTrX+VaDs=
X-Gm-Message-State: AOJu0YzUKRoQiUm0SJ+J42e67BKGNFKMTNqbKVrQsaFxtBPAv9Pzb/DR
 ZGDzyGCcI0OlVFRCmRal6CwkFS4eNWbsIqmrj9iKEOVVPi42mOknnlxGYFjDODqHLSs/gxIBr/1
 GLgaegcG70aNVSeNE8vs+sNBavpxrQtBidXjZPrNLK4kx1EG5Ts57
X-Received: by 2002:ac8:5e4c:0:b0:447:e9ef:b4fd with SMTP id
 d75a77b69052e-447fa935f6amr56572821cf.51.1720598070148; 
 Wed, 10 Jul 2024 00:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw5TQ/3zoRoaUrHiarL93Z2FQPPxjbHC/p840adld54iLx3l1cW4EDG5ol5AOBrZVoUNI7cA==
X-Received: by 2002:ac8:5e4c:0:b0:447:e9ef:b4fd with SMTP id
 d75a77b69052e-447fa935f6amr56572621cf.51.1720598069684; 
 Wed, 10 Jul 2024 00:54:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9b3e8e5sm18299191cf.35.2024.07.10.00.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 00:54:29 -0700 (PDT)
Message-ID: <9008df21-9ce4-442e-b2b5-4e286606e50d@redhat.com>
Date: Wed, 10 Jul 2024 09:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect HW
 strapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
 <ade6cd7c-ccc9-4551-acd8-2a4c5c5e1af2@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ade6cd7c-ccc9-4551-acd8-2a4c5c5e1af2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/24 9:07 AM, Philippe Mathieu-Daudé wrote:
> On 10/7/24 07:14, Cédric Le Goater wrote:
>> On 7/9/24 11:32 PM, Philippe Mathieu-Daudé wrote:
>>> On 5/7/24 17:52, Philippe Mathieu-Daudé wrote:
>>>> On 5/7/24 15:28, Philippe Mathieu-Daudé wrote:
>>>>> On 5/7/24 07:38, Cédric Le Goater wrote:
>>>>>> On 7/5/24 5:41 AM, Andrew Jeffery wrote:
>>>>>>> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>>>>>>>> From: Cédric Le Goater <clg@kaod.org>
>>>>>>>>
>>>>>>>> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
>>>>>>>> property to set the boot config register to boot from the first boot
>>>>>>>> area partition of the eMMC device.
>>>>>>>>
>>>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>> ---
>>>>>>>>   hw/arm/aspeed.c | 15 +++++++++++----
>>>>>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>>>>>>> index 756deb91efd1..135f4eb72215 100644
>>>>>>>> --- a/hw/arm/aspeed.c
>>>>>>>> +++ b/hw/arm/aspeed.c
>>>>>>>> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>>>>>>>>       }
>>>>>>>>   }
>>>>>>>> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
>>>>>>>> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>>>>>>>> +                               bool boot_emmc)
>>>>>>>>   {
>>>>>>>>           DeviceState *card;
>>>>>>>> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
>>>>>>>>               return;
>>>>>>>>           }
>>>>>>>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>>>>>>> +        if (emmc) {
>>>>>>>> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : 0x0);
>>>>>>>
>>>>>>> 0x48 feels a little bit magic. I poked around a bit and there are some
>>>>>>> boot-config macros, but not the ones you need and they're all in an
>>>>>>> "internal" header anyway. I guess this is fine for now?
>>>>>>
>>>>>> You are right and we should be using these :
>>>>>>
>>>>>> hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG             179 /* R/W */
>>>>>
>>>>> This field is R/W and expected to be configured by the guest.
>>>>>
>>>>> Why the guest (u-boot) doesn't detect partitioning support?
>>>>>
>>>>> See eMMC v4.5 section 7.4.60 PARTITIONING_SUPPORT [160] and earlier
>>>>>
>>>>>    For e•MMC 4.5 Devices, Bit 2-0 in PARTITIONING_SUPPORT
>>>>>    shall be set to 1.
>>>>>
>>>>> We don't set it so far.
>>>>
>>>> Sorry, I wasn't grepping in the correct branch, we do set it:
>>>>
>>>>       sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
>>>>
>>>> I'll investigate.
>>>
>>> Correct behavior implemented (I hope) here:
>>> https://lore.kernel.org/qemu-devel/20240709152556.52896-16-philmd@linaro.org/
>>>
>>> Using it also simplifies this patch, we can squash:
>>
>> I think we need both "boot-size" and "boot-config" properties to set
>> the associated registers, BOOT_CONFIG and BOOT_SIZE_MULT. BOOT_CONFIG
>> defines which devices are enabled for boot (partition 1, 2 or user area)
>> and BOOT_SIZE_MULT defines the size.
> 
> I disagree: it is the guest responsibility to set the BOOT_CONFIG
> register (using the SWITCH command). Unlike the BOOT_CONFIG register
> which is in the (read-only) Properties Segment,

hmm, in section 8.4 Extended CSD register, table 49 says
BOOT_CONFIG is R/W.

> the BOOT_SIZE_MULT
> is in the (read-write) Modes segment and its default value is 0x00.

and BOOT_SIZE_MULTI is RO

> See the Spec v4.3, chapter 8.4 "Extended CSD register":
> 
>        The Extended CSD register defines the card properties
>        and selected modes. It is 512 bytes long. The most
>        significant 320 bytes are the Properties segment, which
>        defines the card capabilities and cannot be modified by
>        the host. The lower 192 bytes are the Modes segment,
>        which defines the configuration the card is working in.
>        These modes can be changed by the host by means of the
>        SWITCH command.

yes and how is initial boot done ? You have start from eMMC at some
point.

> 
> For example in u-boot BOOT_CONFIG is set by mmc_set_part_conf():
> 
>      /*
>       * Modify EXT_CSD[179] which is PARTITION_CONFIG (formerly
>       * BOOT_CONFIG) based on the passed in values for BOOT_ACK,
>       * BOOT_PARTITION_ENABLE and PARTITION_ACCESS.
>       *
>       * Returns 0 on success.
>       */
>      int mmc_set_part_conf(struct mmc *mmc, u8 ack,
>                            u8 part_num, u8 access)
>      {
>          int ret;
>          u8 part_conf;
> 
>          part_conf = EXT_CSD_BOOT_ACK(ack) |
>                      EXT_CSD_BOOT_PART_NUM(part_num) |
>                      EXT_CSD_PARTITION_ACCESS(access);
> 
>          ret = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONF,
>                           part_conf);
>          if (!ret)
>                  mmc->part_config = part_conf;
> 
>          return ret;
>      }

OK. It has been 5y since I last looked ! The part above is a u-boot
command which means the board has already booted on some device (flash)
and this command lets you boot from another device (eMMC)

I don't remember how exactly how this works on AST2600. I think the
SoC secure boot controller sets the EXT_CSD config on the eMMC device
and loads boot data in RAM. This is what the model is doing today when
setting the boot config property and loading a ROM.

Anyhow, having two properties is not a big issue. It gives more
flexibility to model the HW implementation of the boot part.


Thanks,

C.



