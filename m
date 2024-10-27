Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44115D1356A
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 21:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Aa5-0005LF-5b; Sun, 27 Oct 2024 17:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DUM3=RX=kaod.org=clg@ozlabs.org>)
 id 1t5Aa3-0005Ke-9k; Sun, 27 Oct 2024 17:13:47 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DUM3=RX=kaod.org=clg@ozlabs.org>)
 id 1t5Aa1-0007U6-99; Sun, 27 Oct 2024 17:13:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Xc8Q63J6Bz4x4c;
 Mon, 28 Oct 2024 08:13:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xc8Q257Hkz4x33;
 Mon, 28 Oct 2024 08:13:30 +1100 (AEDT)
Message-ID: <86fa6e68-5861-4d4d-941f-95b278074eb6@kaod.org>
Date: Sun, 27 Oct 2024 22:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
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
 <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
 <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
 <c27fbed6-596e-4ce7-a6ca-6d12d7205e99@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <c27fbed6-596e-4ce7-a6ca-6d12d7205e99@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=DUM3=RX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/24 17:32, Guenter Roeck wrote:
> On 10/26/24 03:02, Cédric Le Goater wrote:
> [ ... ]
> 
>>> I don't mind a single file. What bothers me is that the partitioning is made
>>> mandatory for ast2600 even if not used.
>>
>> Our only use case, in 2019, was to boot QEMU ast2600 machines from an
>> eMMC device using an OpenBMC FW image like the ones we find on IBM
>> Power10 Rainier systems. I agree we only focused on this scenario.
>> Most of the support should be there for other use cases, and it's now
>> a question of finding the right tunables for the user.
>>
>> I did a quick experiment using 2 patches,
>>
>> one on hw/sd/sd.c to fix c8cb19876d3e ("hw/sd/sdcard: Support boot
>> area in emmc image")
>>
>>      @@ -826,7 +826,9 @@ static void sd_reset(DeviceState *dev)
>>               sect = 0;
>>           }
>>           size = sect << HWBLOCK_SHIFT;
>>      -    size -= sd_bootpart_offset(sd);
>>      +    if (sd_is_emmc(sd)) {
>>      +        size -= sd->boot_part_size * 2;
>>      +    }
>>           sect = sd_addr_to_wpnum(size) + 1;
>>
>> and another on hw/arm/aspeed.c to remove the setting of the eMMC
>> device properties when it is not bootable :
>>      @@ -338,7 +338,7 @@ static void sdhci_attach_drive(SDHCIStat
>>                   return;
>>               }
>>               card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>>      -        if (emmc) {
>>      +        if (emmc && boot_emmc) {
>>                   qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>                   qdev_prop_set_uint8(card, "boot-config",
>>                                       boot_emmc ? 0x1 << 3 : 0x0);
>> (I am not saying this is correct)
>>
> 
> Works for me, though, and it is much better than mandating the existence
> of boot partitions.

Yes. However, if the emmc device was user creatable, we could use :

   -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb-noboot.raw \
   -device emmc,bus=sdhci-bus.2,drive=emmc0

and with boot partitions:

   -M boot-emmc=true \
   -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
   -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8

The above would be my preferred approach if acceptable. The "sd-bus"
bus identifier should be changed in other machines tough.

> If you end up submitting those patches, please feel free to add
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

I should send these fixes for QEMU 9.2.

Thanks,

C.


