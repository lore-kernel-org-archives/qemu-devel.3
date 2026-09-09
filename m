Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C2DC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GHZ-00077r-92; Wed, 09 Sep 2026 07:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x4GHX-00077a-Bd
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:15:59 -0400
Received: from smtpout8.mo539.mail-out.ovh.net ([51.210.91.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x4GHS-0007sV-Pa
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:15:58 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hfysS3FrJz4GMN;
 Wed,  9 Sep 2026 11:15:39 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  9 Sep 2026 11:15:39 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.135])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hfysR5QwFz6Mbb;
 Wed,  9 Sep 2026 11:15:39 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 231E61923FFD; Wed,  9 Sep 2026 11:15:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004db339e69-487d-4118-8126-87b886c6d403,
 E4FF89F5E029BDF2B6C047D55A1BD61D763A9D7C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <50c3fb43-8965-4cde-a3b8-a01d067991db@kaod.org>
Date: Wed, 9 Sep 2026 13:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm: Add /machine/labels container for Aspeed
 machines
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260904050424.4049984-1-clg@redhat.com>
 <20260904050424.4049984-2-clg@redhat.com>
 <2f7465ed-9945-48e6-81dd-d7aaafd249ed@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <2f7465ed-9945-48e6-81dd-d7aaafd249ed@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4601271445395385368
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFXImvsUkicB27UP8CNL1C1gZfUtawuCBceaJLpiMJh0kzlnKjqsWqc26AxaN3zrBrgXZsHOdb9TqdMDAbne4apTGNPF6b7tRQDh5KbR2oFC9y8naWfXg7yFLRCBS5EPhxMrgx5/+sA7sBySuPflf/6nYC9ygFTNM5FZkJ+E2GPpYCEXxX4GLKDbrdv/Mu74cbb6FvT0BWVGUShRcpm/+GM957fbzPWuptPDU0OqiLb+pNLnlLUA1jkl07PcGVe+O+qIosiOC+D/Djy6NewC4JatZXBUhPS7QxWodRtv5QpOycD9u6cXCd0baBcSpMstxYP0xkW13DKL5RB7BgBDaogULUB9bXAnsL7mxVT5XtkUlBp1fIiT5tIsA73b1BgbLZoGDlLf0AEIY9N/ZblGwWJOezW9+hQD3yiQjv7Pb9ynqktVExY4j6SXtRZ74r9WJrO9kV1Un45b/83ve7MhKZcttd7osGJq4DkIPI0pMjXTJZ71vwdLxCt933CJ2ycFu8FQu38J0qWxYZPHfGIfvvD7OfO52yDG4AsN9qsngwpg9qOhJEvuc2EbLcnyZF3CyCdzCgcHZ0Zg40mxKcZc5qOzFWE9fszF3m5EYnC8/OPKrM+CE2RyMMeAXhQo159ry0MISW/V/wam+l81UbSU3NPR03RLPPsnIiZsgB27xHqog
DKIM-Signature: a=rsa-sha256; bh=yFKtaa1ZMVl1jjKhMZHKm52K1l98fhoYys3D5WxJwYo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788952541; v=1;
 b=tq29qQncFOMBwoGyKWicJ9t4CSFDGWzqXWenkGc0Nyn/w8kj+Vu1tYTK0IBhGYk4lW2Bi7Tg
 qkqfFZuxkm/OK+aP5Iy2KbV9cheT1g3oXcejN8gk/5rwkiTBSDASVgQFHHwx2AVcI5/t4Zw9ZWL
 56a+Uuy6b225kulZowyHmLoFcNdkbNDIc6dNKY0+SMNd6HiIRmQA2NHfBPIdGlfLYzFLBWDH6bD
 DrAPvG8yD9HwyMdlp7O2KbX4a88s78EaOL+9DVeg0pTpaihT6GBcy4y6Y/ULaucMLxWVAY9qFcy
 NqFUR6zDmKPgYBomuZOBUO2vJO9CipEOY97nyk0ZgvOjg==
Received-SPF: pass client-ip=51.210.91.47; envelope-from=clg@kaod.org;
 helo=smtpout8.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On 9/9/26 12:35, Mark Cave-Ayland wrote:
> On 04/09/2026 06:04, Cédric Le Goater wrote:
> 
>> Add a DT-style alias container /machine/labels where board code registers
>> link<> properties pointing to well-known devices. Tests can then resolve
>> a device with a single QMP call (qom-get /machine/labels/<name>) instead
>> of walking the bus hierarchy.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/arm/aspeed.h | 12 ++++++++++++
>>   hw/arm/aspeed.c         | 10 ++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>> index 245d02e5f757..0b8b40262767 100644
>> --- a/include/hw/arm/aspeed.h
>> +++ b/include/hw/arm/aspeed.h
>> @@ -128,4 +128,16 @@ void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
>>    */
>>   void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc);
>> +/*
>> + * aspeed_machine_add_label:
>> + * @bmc: pointer to the #AspeedMachineState.
>> + * @label: the label name for the device.
>> + * @target: the device object to register.
>> + *
>> + * Register a well-known device under /machine/labels/<label> as a
>> + * read-only link.  Aborts on duplicate label names.
>> + */
>> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
>> +                              Object *target);
>> +
>>   #endif
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 1f8d5d3e132d..79b8d55d66da 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -127,6 +127,14 @@ void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>>       }
>>   }
>> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
>> +                              Object *target)
>> +{
>> +    Object *labels = object_resolve_path_component(OBJECT(bmc), "labels");
>> +
>> +    object_property_add_const_link(labels, label, target);
>> +}
>> +
>>   static void aspeed_machine_init(MachineState *machine)
>>   {
>>       AspeedMachineState *bmc = ASPEED_MACHINE(machine);
>> @@ -137,6 +145,8 @@ static void aspeed_machine_init(MachineState *machine)
>>       DriveInfo *emmc0 = NULL;
>>       bool boot_emmc;
>> +    object_property_add_new_container(OBJECT(machine), "labels");
>> +
>>       bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
>>       object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
>>       object_unref(OBJECT(bmc->soc));
> 
> Thanks for the proposal, Cédric! A few comments from me below:
> 
> 1) Is there any reason it should be called labels as opposed to aliases? 

none

> The aliases name as used in Open Firmware feels more intuitive to me.

yes. It it just a name. aliases is fine for me unless it introduces
some confusion with object_property_add_alias().

> 
> 2) If there is agreement in this approach, is there any reason why we shouldn't create /machine/labels (or equivalent) for all QOM trees? I certainly think it would be a useful addition going forward.

It is a trivial addition. We would need more maintainers to Ack
the concept though.

> 
> 3) Is there any reason why we need to provide the machine object directly to the aspeed_machine_add_label() function?

Only because it was selfishly introduced as a Aspeed machine helper !

>  If possible I think it makes sense to avoid the direct machine reference, in case the underlying implementation changes i.e.
> 
> 
>    void machine_add_alias(const char *alias, Object *target)
>    {
>       Object *aliases = object_resolve_path("/machine/aliases",  NULL);
> 
>       object_property_add_const_link(aliases, alias, target);
>    }

ok.
> Even better perhaps we should also generate an error if the alias already exists to ensure they are always unique i.e.
> 
> 
>    bool machine_add_alias(const char *alias, Object *target,
>                           Error **errp)
>    {
>       Object *aliases = object_resolve_path("/machine/aliases",  NULL);
> 
>       if (object_resolve_path_component(aliases, alias)) {
>           error_setg(errp, "machine alias '%s' already exists");
>           return false;
>       }

I don't think this is useful since object_property_add_const_link()
should abort in case of duplicate, which would be a modeling error
anyhow.

> 
>       return (object_property_add_const_link(aliases, alias, target) !=
>               NULL);
>    }
> 
> 
> 4) Should we create a page in the documentation explaining which devices/objects should be included in the alias list,

Any device in the QOM tree could have an alias. Why would you want
to limit the possible aliases? a part from dynamic ones.

> which ones are added automatically, 

That's dangerous. I would say none.

> and what naming conventions should be used for devices e.g. serial0, net0 for a network device etc.?

I would leave the choice to the person in charge of the SoC or the
machine.
  
> 5) What should happen to aliases for devices that are hot-plugged/hot-unplugged?
IMO, aliases are intended for devices "soldered" on the board,
created by the machine. Devices created via the command line or
QMP/HMP are excluded.


Thanks,

C.


