Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF63C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPizj-0007Ul-JU; Fri, 05 Jul 2024 09:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPizh-0007UU-4A
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:28:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPizf-0004uT-Ci
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:28:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso11267655e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720186134; x=1720790934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KTIaIwuF1Hd7WTvGDN/mPtt/G1KpBjOFvNeXbcF3s3A=;
 b=xAfiFf/qklawdAto6Tueg/AQOXdAfY5stXq1jpIdcijazuM5r8KGT0ygckTmGeNAFU
 t99TWlrCevyUUGKyUxkrZdppY/Usor0eetmDunxtnJ61VKcKXmoHRJ1zqa9weOpvnIL7
 AbSQuRhptuA2tHDvxh8uXorHYSw4kZXF4oxiCOKkCTKBZA+JOytVNXKlrEmIw+MJmfKo
 vXNWHepNMKYnm2Sp+AEZh7/QHxdNdkTsvt5zOgDtGUhiI0vTdX37cYFPAGJfkF7XYqrp
 /Pi7jo7oajuqWS8WIduPhzHudqfAY8fckayKGFNl6IjcSqA8uc2EWQUCsuIQf/E+iyX9
 qoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720186134; x=1720790934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KTIaIwuF1Hd7WTvGDN/mPtt/G1KpBjOFvNeXbcF3s3A=;
 b=TSgTkH/kq0vwQHS5vk8yhvU+5++yN6/wtdFLdoH+X4O2TKiAO1mL2LnCRDzFQWHe+4
 BaFdOKO7G6wpYhlhy2leTT/wGTeU/eNCFefIW/XmEpK9saKWmjgIdn3shAsHyB36cMjY
 mj4UFmRiRYWeJ7uFfRL/F3+4uLfosOm3SpINv8Q6CzeSw1ty5BR39uPU++L4K4W4uBfT
 L+DeCbwrnrVBZt9DKpjSg0Vgeeea5Gpx2mflzO6AlKxT8T5FeroqYBR85tR0ffZA5xTA
 HDPDcMhu48cwQGxooZF/0zqyGdwIKydai5HcEbicEF2TenevLIL4eP2cE8m0FfVHhOrT
 GfCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX5Vs4QXv9loo8I95FIHPQv0cav1QtztjPrszE6IBIuut/xEQQzorZ+8HwB19l0eXjTpbkAULAlH18zWbESSyxwIuTS6s=
X-Gm-Message-State: AOJu0Yz5XCWESUQTlv7uapCGLmSYMPVsS8Ysv/OHQC2mNs6mI7wE0XjS
 Qdl9nKEOQbqVFvBOIVV2iviF+rMbumD8sDpBdScy07eN1BhM4VJNgIvEXA1V3yM=
X-Google-Smtp-Source: AGHT+IED7PnRea+05LwXZdTqmm0wx0udexBOYK9geXA/gppCqY5M/BOcOGTad2T+Slt4n4qtKiKQEA==
X-Received: by 2002:a05:600c:63c4:b0:425:6207:12b4 with SMTP id
 5b1f17b1804b1-4264a3e79cbmr36017085e9.24.1720186133783; 
 Fri, 05 Jul 2024 06:28:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca60bsm62922245e9.31.2024.07.05.06.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 06:28:53 -0700 (PDT)
Message-ID: <8e770030-29ab-4e30-861f-3e735b25e37b@linaro.org>
Date: Fri, 5 Jul 2024 15:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect HW
 strapping
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-6-clg@redhat.com>
 <f50579b99ef8883dac5fcfc1606a45abfb8bf85f.camel@codeconstruct.com.au>
 <e6ca185f-3f9a-40e1-9ed2-eccfbbdf1444@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e6ca185f-3f9a-40e1-9ed2-eccfbbdf1444@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/7/24 07:38, Cédric Le Goater wrote:
> On 7/5/24 5:41 AM, Andrew Jeffery wrote:
>> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>>> From: Cédric Le Goater <clg@kaod.org>
>>>
>>> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
>>> property to set the boot config register to boot from the first boot
>>> area partition of the eMMC device.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/arm/aspeed.c | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index 756deb91efd1..135f4eb72215 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, 
>>> const char *flashtype,
>>>       }
>>>   }
>>> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, 
>>> bool emmc)
>>> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, 
>>> bool emmc,
>>> +                               bool boot_emmc)
>>>   {
>>>           DeviceState *card;
>>> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState *sdhci, 
>>> DriveInfo *dinfo, bool emmc)
>>>               return;
>>>           }
>>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>> +        if (emmc) {
>>> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 
>>> 0x48 : 0x0);
>>
>> 0x48 feels a little bit magic. I poked around a bit and there are some
>> boot-config macros, but not the ones you need and they're all in an
>> "internal" header anyway. I guess this is fine for now?
> 
> You are right and we should be using these :
> 
> hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG             179     
> /* R/W */

This field is R/W and expected to be configured by the guest.

Why the guest (u-boot) doesn't detect partitioning support?

See eMMC v4.5 section 7.4.60 PARTITIONING_SUPPORT [160] and earlier

   For e•MMC 4.5 Devices, Bit 2-0 in PARTITIONING_SUPPORT
   shall be set to 1.

We don't set it so far.

I see in u-boot mmc_startup_v4():

     /* store the partition info of emmc */
     mmc->part_support = ext_csd[EXT_CSD_PARTITIONING_SUPPORT];
     if ((ext_csd[EXT_CSD_PARTITIONING_SUPPORT] & PART_SUPPORT) ||
         ext_csd[EXT_CSD_BOOT_MULT])
             mmc->part_config = ext_csd[EXT_CSD_PART_CONF];
     if (part_completed &&
         (ext_csd[EXT_CSD_PARTITIONING_SUPPORT] & ENHNCD_SUPPORT))
             mmc->part_attr = ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE];

I'm still waiting for the eMMC prerequisite to be reviewed
before looking at the eMMC patches in detail :/

Regards,

Phil.

