Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63923C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPbel-00089S-Mx; Fri, 05 Jul 2024 01:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPbek-00089B-6f
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPbea-0008D8-Uc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720157919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEksHmUWt00lTxG6oU7rGTdcMcd0W/EM5mkNsWPPkY0=;
 b=W7kU3qaAKExmKJ0O6VGf6NjEES14GHeZsSsn8U4wUgQntJeC5Y6S/ACDyO/3yTuzzfTcXN
 PptQ/BOSTrk6d1rvm0iP5xHlYQk1GsCV5E5TckchberT80Mgc5xrF9MkKf7BN4Hmr+kdYE
 VpuCBDu3jPRqVpHDjbyMGkxFUwS0bcQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-cAqXXrg-PSKxHRYJYlhxuQ-1; Fri, 05 Jul 2024 01:38:37 -0400
X-MC-Unique: cAqXXrg-PSKxHRYJYlhxuQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b5de421bc6so18356796d6.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 22:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720157917; x=1720762717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TEksHmUWt00lTxG6oU7rGTdcMcd0W/EM5mkNsWPPkY0=;
 b=cbZLu4H9XggU+NxrUr6QyQLf06yGYIyPC/FzTs3KzbBUMAFKiAAafxtsL0wntsLaSd
 vvMYMwNlmVJII9LKa9mGkuwJP6nqPyBYosBXxAaqNwyAprCDgeFNisAgNWdW+hPh2DnR
 JpJLLkiQFza2CAaWocPxqgVDVtnoYX+wHBzrrE9on2UvH0CcuKHG5m+QECpa78l/L9o2
 mfSNhAKu1o+g+PRNnYs0AX+XbuMQC1IxVhezWXcxrJ3N1rBA294O36DqK4nImnmTd3vH
 QUdM4n3ZbFqPl2RcWaSLRfetNT1IOJjdoh9gmpQ/RRCmecFIIU7/9tC0ClfyxEyC8Qj1
 +W7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUrqL7xwNj16SuyXpJI9/PoAXilnzoW0ZpFn1M2cSgRBkU4AiHEWvnkzVfnK/H2/Jw5THjvdzGHM6jIAVbFWCsA1Tz2xI=
X-Gm-Message-State: AOJu0YwqzC9bIFAfycE++mH4pM5LZAEI8aZHAABLgZrzlmF41xeEaTZ6
 k3WmxOJGzWBdq8BYYM/KBdisxnJv2v40QRXLog8eIAk3nPSjuCiU3NMNkMamtjEGjGViiHLhc/j
 qPkc8UzDCqq54N0raoV8hti1kCTeT0bRqITJrCICi+0Aho9fOTgjx
X-Received: by 2002:a05:6214:53c8:b0:6b5:42b7:122 with SMTP id
 6a1803df08f44-6b5ed196d97mr40578016d6.60.1720157917354; 
 Thu, 04 Jul 2024 22:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL/t49WO5/YqkMxoG2kWY7GS8ps14odKLGw2fahqLjoCy98AlYo72XJOZMANRYqK4i6nrBFA==
X-Received: by 2002:a05:6214:53c8:b0:6b5:42b7:122 with SMTP id
 6a1803df08f44-6b5ed196d97mr40577936d6.60.1720157917060; 
 Thu, 04 Jul 2024 22:38:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5eca5a923sm12310716d6.47.2024.07.04.22.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 22:38:36 -0700 (PDT)
Message-ID: <e6ca185f-3f9a-40e1-9ed2-eccfbbdf1444@redhat.com>
Date: Fri, 5 Jul 2024 07:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect HW
 strapping
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-6-clg@redhat.com>
 <f50579b99ef8883dac5fcfc1606a45abfb8bf85f.camel@codeconstruct.com.au>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f50579b99ef8883dac5fcfc1606a45abfb8bf85f.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/5/24 5:41 AM, Andrew Jeffery wrote:
> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
>> property to set the boot config register to boot from the first boot
>> area partition of the eMMC device.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/arm/aspeed.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 756deb91efd1..135f4eb72215 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>>       }
>>   }
>>   
>> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
>> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>> +                               bool boot_emmc)
>>   {
>>           DeviceState *card;
>>   
>> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
>>               return;
>>           }
>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>> +        if (emmc) {
>> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : 0x0);
> 
> 0x48 feels a little bit magic. I poked around a bit and there are some
> boot-config macros, but not the ones you need and they're all in an
> "internal" header anyway. I guess this is fine for now?

You are right and we should be using these :

hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG             179     /* R/W */

hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_ACC_MASK            (0x7)
hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_ACC_BOOT0           (0x1)
hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG_EN_USER             (0x7 << 3)

So I wonder where the 0x48 is coming from. Will change.

> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 


Thanks,

C.




