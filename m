Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DD0C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRISQ-0007dt-L3; Tue, 09 Jul 2024 17:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRISP-0007c5-23
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:33:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRISN-00036A-4n
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:33:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3813167f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720560781; x=1721165581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bbcpro0o+I3cTdZ1oGJyuIMJSzDBADoMwzQyQ181dsU=;
 b=JmtVfR2PpTTQ2VyfXf7+J5eHyu4A5ELE/BJvEDmiJVVgmemU7H56hKDkL3D8UQrf4u
 BpesS2ekW89xqD3OD2V3nl8LJU0pp0X9Wj6rZg4J9b/MoOt4CddoPdd21eBF5ZyRxapy
 Ci5tY/JoXPClwhj+9NAvbax2rgoxoGknvxC+VSXtViGsVbI+2UfFJDu9qT1xkG/uCrwO
 JNBH1+sFsQOVyIhX+BHYkIavqE+LncQKere3JZTH6Hre1HL1zWzYlrI/vEpCDK01Rvn9
 1CXnC3i2b9EB5Tr4miJZhhSSAgcjA1nNInBoLMGqb0viF97IHbFlGgq4k53KfqHKhnZG
 tKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720560781; x=1721165581;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbcpro0o+I3cTdZ1oGJyuIMJSzDBADoMwzQyQ181dsU=;
 b=ko9jIwilcaCxnyiRNn+YhHIjPIPljps1pUcME9kwbJlmngT3cIoNpwmOesbH1Us4u3
 tUJQf+hef73UVUs+FCkQcVVzhfoPyTk4ixT4/FX1qo9gDGSN3vaJDGWJwRsri4sL7ABw
 wuOD/0Nw1+ex0qW7mwENgF6aJSus5bIr2T6AOi42LD4REfwQ0pvWHmWz5tB90hZ4nPr7
 3XA2ilAgbs64Fmt8WjhaFV9OAS/dooYVAR1IsYShbufxmCAOh5t5UnGvADHBEL2PBJN7
 9ggku/EDtPtuI6Qcg6zT9U8gWW2HWGoWW0g1TX75W9GxvvKQTLqDIXQlzG+8Y/u0diE5
 DcLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYt5TeJF59gXYW+ryY3Zi0o6KMZCzQnhquK/UkWQNPtn98L/2I0l5LSVUYzX1nMeQpc+BPAQPqJJkHbW7NbcYgo2wkUPM=
X-Gm-Message-State: AOJu0YwjZ2kAz3NyJmi2G5kD3ixRw0NyRTAkAS+RjDA4oAt2px4f49Wd
 a2j5MXQD6C+/KrEqz/zBuMjF4JL9Ay6yohWEZ3kyZ1zaLd6oaPohHl1oLAr2Yek=
X-Google-Smtp-Source: AGHT+IFelwp22u6JwoJ+jy3eajt9ORCz7yMxCX1Lk9kcWuHFDSmEMOfVOiZpAcpN3gC5NdAo5C7+2Q==
X-Received: by 2002:a5d:6da9:0:b0:367:95e8:3af0 with SMTP id
 ffacd0b85a97d-367cea46c41mr3212617f8f.9.1720560781212; 
 Tue, 09 Jul 2024 14:33:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d16b0sm218993975e9.7.2024.07.09.14.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 14:33:00 -0700 (PDT)
Message-ID: <6099fc9c-c7ab-46c8-86e7-bf1e37c2cd83@linaro.org>
Date: Tue, 9 Jul 2024 23:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect HW
 strapping
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
 <8e770030-29ab-4e30-861f-3e735b25e37b@linaro.org>
 <b606cd09-3846-4c99-b902-b0b260d91788@linaro.org>
Content-Language: en-US
In-Reply-To: <b606cd09-3846-4c99-b902-b0b260d91788@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 5/7/24 17:52, Philippe Mathieu-Daudé wrote:
> On 5/7/24 15:28, Philippe Mathieu-Daudé wrote:
>> On 5/7/24 07:38, Cédric Le Goater wrote:
>>> On 7/5/24 5:41 AM, Andrew Jeffery wrote:
>>>> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>>>>> From: Cédric Le Goater <clg@kaod.org>
>>>>>
>>>>> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
>>>>> property to set the boot config register to boot from the first boot
>>>>> area partition of the eMMC device.
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>> ---
>>>>>   hw/arm/aspeed.c | 15 +++++++++++----
>>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>>>> index 756deb91efd1..135f4eb72215 100644
>>>>> --- a/hw/arm/aspeed.c
>>>>> +++ b/hw/arm/aspeed.c
>>>>> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState 
>>>>> *s, const char *flashtype,
>>>>>       }
>>>>>   }
>>>>> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo 
>>>>> *dinfo, bool emmc)
>>>>> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo 
>>>>> *dinfo, bool emmc,
>>>>> +                               bool boot_emmc)
>>>>>   {
>>>>>           DeviceState *card;
>>>>> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState 
>>>>> *sdhci, DriveInfo *dinfo, bool emmc)
>>>>>               return;
>>>>>           }
>>>>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>>>> +        if (emmc) {
>>>>> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 
>>>>> 0x48 : 0x0);
>>>>
>>>> 0x48 feels a little bit magic. I poked around a bit and there are some
>>>> boot-config macros, but not the ones you need and they're all in an
>>>> "internal" header anyway. I guess this is fine for now?
>>>
>>> You are right and we should be using these :
>>>
>>> hw/sd/sdmmc-internal.h:#define EXT_CSD_PART_CONFIG             179 /* 
>>> R/W */
>>
>> This field is R/W and expected to be configured by the guest.
>>
>> Why the guest (u-boot) doesn't detect partitioning support?
>>
>> See eMMC v4.5 section 7.4.60 PARTITIONING_SUPPORT [160] and earlier
>>
>>    For e•MMC 4.5 Devices, Bit 2-0 in PARTITIONING_SUPPORT
>>    shall be set to 1.
>>
>> We don't set it so far.
> 
> Sorry, I wasn't grepping in the correct branch, we do set it:
> 
>       sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
> 
> I'll investigate.

Correct behavior implemented (I hope) here:
https://lore.kernel.org/qemu-devel/20240709152556.52896-16-philmd@linaro.org/

Using it also simplifies this patch, we can squash:
-- >8 --
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5a22e66ff5..27fea3003a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -331,4 +331,3 @@ void aspeed_board_init_flashes(AspeedSMCState *s, 
const char *flashtype,

-static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, 
bool emmc,
-                               bool boot_emmc)
+static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, 
bool emmc)
  {
@@ -341,4 +340,3 @@ static void sdhci_attach_drive(SDHCIState *sdhci, 
DriveInfo *dinfo, bool emmc,
          if (emmc) {
-            qdev_prop_set_uint8(card, "boot-config",
-                                boot_emmc ? 
EXT_CSD_PART_CONFIG_EN_BOOT0 : 0x0);
+            qdev_prop_set_uint64(card, "boot-size", 1 * MiB);
          }
@@ -374,3 +372,2 @@ static void aspeed_machine_init(MachineState *machine)
      DriveInfo *emmc0 = NULL;
-    bool boot_emmc;

@@ -447,10 +444,8 @@ static void aspeed_machine_init(MachineState *machine)
          sdhci_attach_drive(&bmc->soc->sdhci.slots[i],
-                           drive_get(IF_SD, 0, i), false, false);
+                           drive_get(IF_SD, 0, i), false);
      }

-    boot_emmc = sc->boot_from_emmc(bmc->soc);
-
      if (bmc->soc->emmc.num_slots) {
          emmc0 = drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots);
-        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true, 
boot_emmc);
+        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true);
      }
@@ -461,3 +456,3 @@ static void aspeed_machine_init(MachineState *machine)

-        if (fmc0 && !boot_emmc) {
+        if (fmc0 && !sc->boot_from_emmc(bmc->soc)) {
              uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
---

IOW where we boot only affects the FMC, not (directly) the eMMC.

Regards,

Phil.

