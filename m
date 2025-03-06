Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A8EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFt3-0006BN-Mm; Thu, 06 Mar 2025 13:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqFt1-0006Ac-SD; Thu, 06 Mar 2025 13:23:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqFsy-0003vQ-ER; Thu, 06 Mar 2025 13:23:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 128DD4E6001;
 Thu, 06 Mar 2025 19:23:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LIcx5ypPzU58; Thu,  6 Mar 2025 19:23:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 068BE4E6000; Thu, 06 Mar 2025 19:23:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 025E274577C;
 Thu, 06 Mar 2025 19:23:47 +0100 (CET)
Date: Thu, 6 Mar 2025 19:23:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
In-Reply-To: <ad0e4bde-40dd-db32-b8d9-46c27c257aa3@eik.bme.hu>
Message-ID: <0f3814d3-7c27-fd50-2ad3-b4d5344d9fc1@eik.bme.hu>
References: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
 <918e9ae0-fb22-43c7-a2cf-376aaee0e98b@linaro.org>
 <ad0e4bde-40dd-db32-b8d9-46c27c257aa3@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1210530465-1741284843=:15792"
Content-ID: <570c1695-1ec4-4413-2ad4-03d664ab6198@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1210530465-1741284843=:15792
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <c98dd5dd-0ec7-db10-6902-42204ceaf9a3@eik.bme.hu>

On Mon, 3 Mar 2025, BALATON Zoltan wrote:
> On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>> 
>> On 10/2/25 17:03, BALATON Zoltan wrote:
>>> The interrupt enable registers are not reset to 0 on Freescale eSDHC
>>> but some bits are enabled on reset. At least some U-Boot versions seem
>>> to expect this and not initialise these registers before expecting
>>> interrupts. Use existing vendor property for Freescale eSDHC and set
>>> the reset value of the interrupt registers to match Freescale
>>> documentation.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v2: Restrict to e500. Adding a reset method in a subclass does not
>>> work because the common reset function is called directly on register
>>> write from the guest but there's already provision for vendor specific
>>> behaviour which can be used to restrict this to Freescale SoCs.
>>>
>>>   hw/ppc/e500.c         | 1 +
>>>   hw/sd/sdhci.c         | 4 ++++
>>>   include/hw/sd/sdhci.h | 1 +
>>>   3 files changed, 6 insertions(+)
>>> 
>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>> index 26933e0457..560eb42a12 100644
>>> --- a/hw/ppc/e500.c
>>> +++ b/hw/ppc/e500.c
>>> @@ -1044,6 +1044,7 @@ void ppce500_init(MachineState *machine)
>>>           dev = qdev_new(TYPE_SYSBUS_SDHCI);
>>>           qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>>>           qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
>>> +        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
>>>           s = SYS_BUS_DEVICE(dev);
>>>           sysbus_realize_and_unref(s, &error_fatal);
>>>           sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 
>>> MPC85XX_ESDHC_IRQ));
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 99dd4a4e95..afa3c6d448 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
>>>       s->data_count = 0;
>>>       s->stopped_state = sdhc_not_stopped;
>>>       s->pending_insert_state = false;
>>> +    if (s->vendor == SDHCI_VENDOR_FSL) {
>>> +        s->norintstsen = 0x013f;
>>> +        s->errintstsen = 0x117f;
>> 
>> I'd rather do like capareg, and add:
>>
>>  DEFINE_PROP_UINT16("norintstsen", _state, norintstsen, 0),
>>  ...
>
> I don't see what you mean. capareg does not seem to be set via a property.
>
>> Then SoC code sets it:
>>
>>  qdev_prop_set_uint16(dev, "norintstsen", 0x013f);
>>  ...
>> 
>> WDYT?
>
> I think it may be overkill to add properties for this if there are no other 
> vendor or variant that needs this. Also properties are for something the user 
> may want to set as those can be changed with QEMU command line and these 
> reset values aren't something the user should change so I think this patch is 
> the simplest solution now.

This patch wasn't in the pull request but I haven't seen an answer to this 
message either so was it missed or do you have furhter comments? Bernhard 
has a comment about naming of SDHCI_VENDOR_FSL but I think the already 
existing IMX name is what's wrong not the one added in this patch but I 
don't think that's really that confusing to worth further effort. We still 
have time as this can be considered a fix but I'd like this to not get 
forgotten so I bring it up again.

Regards,
BALATON Zoltan
--3866299591-1210530465-1741284843=:15792--

