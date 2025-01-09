Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3950DE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVmYX-0008QG-8g; Thu, 09 Jan 2025 02:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H8xH=UB=kaod.org=clg@ozlabs.org>)
 id 1tVmYU-0008Pa-UP; Thu, 09 Jan 2025 02:02:11 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H8xH=UB=kaod.org=clg@ozlabs.org>)
 id 1tVmYS-00015q-9P; Thu, 09 Jan 2025 02:02:10 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YTG1D3n3Sz4wvc;
 Thu,  9 Jan 2025 18:01:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YTG190VWVz4wcy;
 Thu,  9 Jan 2025 18:01:48 +1100 (AEDT)
Message-ID: <f051128e-94b1-463d-845a-345ec2190d3d@kaod.org>
Date: Thu, 9 Jan 2025 08:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
 ops
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
 <20241216075353.1308043-2-jamin_lin@aspeedtech.com>
 <c3b0139f9995427dd83e6172aa17b799361926b6.camel@codeconstruct.com.au>
 <SI2PR06MB504166A128450060C560D908FC132@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB504166A128450060C560D908FC132@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=H8xH=UB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/9/25 03:26, Jamin Lin wrote:
> Hi Andrew,
> 
>> From: Andrew Jeffery <andrew@codeconstruct.com.au>
>> Sent: Thursday, January 9, 2025 9:59 AM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Cédric Le Goater <clg@kaod.org>;
>> Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Joel Stanley
>> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
>> list:All patches CC here <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
>> ops
>>
>> On Mon, 2024-12-16 at 15:53 +0800, Jamin Lin wrote:
>>> It set "aspeed_timer_ops" struct which containing read and write
>>> callbacks to be used when I/O is performed on the TIMER region.
>>>
>>> Besides, in the previous design of ASPEED SOCs, the timer registers
>>> address space are contiguous.
>>>
>>> ex: TMC00-TMC0C are used for TIMER0.
>>> ex: TMC10-TMC1C are used for TIMER1.
>>> ex: TMC80-TMC8C are used for TIMER7.
>>>
>>> The TMC30 is a control register and TMC34 is an interrupt status
>>> register for TIMER0-TIMER7.
>>>
>>> However, the register set have a significant change in AST2700. The
>>> TMC00-TMC3C are used for TIMER0 and TMC40-TMC7C are used for
>> TIMER1.
>>> In additional, TMC20-TMC3C and TMC60-TMC7C are reserved registers for
>>> TIMER0 and TIMER1, respectively.
>>>
>>> Besides, each TIMER has their own control and interrupt status
>>> register.
>>> In other words, users are able to set control and interrupt status for
>>> TIMER0 in one register. Both aspeed_timer_read and aspeed_timer_write
>>> callback functions are not compatible AST2700.
>>>
>>> Introduce a new "const MemoryRegionOps *" attribute in
>>> AspeedTIMERClass and use it in aspeed_timer_realize function.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>   hw/timer/aspeed_timer.c         | 7 ++++++-
>>>   include/hw/timer/aspeed_timer.h | 1 +
>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c index
>>> 149f7cc5a6..970bf1d79d 100644
>>> --- a/hw/timer/aspeed_timer.c
>>> +++ b/hw/timer/aspeed_timer.c
>>> @@ -606,6 +606,7 @@ static void aspeed_timer_realize(DeviceState *dev,
>>> Error **errp)
>>>       int i;
>>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>       AspeedTimerCtrlState *s = ASPEED_TIMER(dev);
>>> +    AspeedTimerClass *atc = ASPEED_TIMER_GET_CLASS(s);
>>>
>>>       assert(s->scu);
>>>
>>> @@ -613,7 +614,7 @@ static void aspeed_timer_realize(DeviceState *dev,
>>> Error **errp)
>>>           aspeed_init_one_timer(s, i);
>>>           sysbus_init_irq(sbd, &s->timers[i].irq);
>>>       }
>>> -    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_timer_ops,
>> s,
>>> +    memory_region_init_io(&s->iomem, OBJECT(s), atc->reg_ops, s,
>>>                             TYPE_ASPEED_TIMER, 0x1000);
>>
>>
>>>       sysbus_init_mmio(sbd, &s->iomem);
>>>   }
>>> @@ -708,6 +709,7 @@ static void
>>> aspeed_2400_timer_class_init(ObjectClass *klass, void *data)
>>>       dc->desc = "ASPEED 2400 Timer";
>>>       awc->read = aspeed_2400_timer_read;
>>>       awc->write = aspeed_2400_timer_write;
>>> +    awc->reg_ops = &aspeed_timer_ops;
>>>   }
>>>
>>>   static const TypeInfo aspeed_2400_timer_info = { @@ -724,6 +726,7 @@
>>> static void aspeed_2500_timer_class_init(ObjectClass *klass, void
>>> *data)
>>>       dc->desc = "ASPEED 2500 Timer";
>>>       awc->read = aspeed_2500_timer_read;
>>>       awc->write = aspeed_2500_timer_write;
>>> +    awc->reg_ops = &aspeed_timer_ops;
>>>   }
>>>
>>>   static const TypeInfo aspeed_2500_timer_info = { @@ -740,6 +743,7 @@
>>> static void aspeed_2600_timer_class_init(ObjectClass *klass, void
>>> *data)
>>>       dc->desc = "ASPEED 2600 Timer";
>>>       awc->read = aspeed_2600_timer_read;
>>>       awc->write = aspeed_2600_timer_write;
>>> +    awc->reg_ops = &aspeed_timer_ops;
>>>   }
>>>
>>>   static const TypeInfo aspeed_2600_timer_info = { @@ -756,6 +760,7 @@
>>> static void aspeed_1030_timer_class_init(ObjectClass *klass, void
>>> *data)
>>>       dc->desc = "ASPEED 1030 Timer";
>>>       awc->read = aspeed_2600_timer_read;
>>>       awc->write = aspeed_2600_timer_write;
>>> +    awc->reg_ops = &aspeed_timer_ops;
>>>   }
>>>
>>>   static const TypeInfo aspeed_1030_timer_info = { diff --git
>>> a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
>>> index 07dc6b6f2c..8d0b15f055 100644
>>> --- a/include/hw/timer/aspeed_timer.h
>>> +++ b/include/hw/timer/aspeed_timer.h
>>> @@ -73,6 +73,7 @@ struct AspeedTimerClass {
>>>
>>>       uint64_t (*read)(AspeedTimerCtrlState *s, hwaddr offset);
>>>       void (*write)(AspeedTimerCtrlState *s, hwaddr offset, uint64_t
>>> value);
>>> +    const MemoryRegionOps *reg_ops;
>>
>> So given the layout changes for the AST2700, perhaps we can improve the way
>> we've organised the call delegation?
>>
>> Currently the callbacks in `aspeed_timer_ops` are generic
>> (aspeed_timer_read(), aspeed_timer_write()), and then we specialise some
>> bits in the default label of the switch statement by delegating to the
>> SoC-specific callbacks.
>>
>> Perhaps we should instead call through the SoC-specific callbacks first, and
>> then have those call the generic op implementation for accesses to registers
>> have common behaviours across the AST2[456]00 SoCs.
>>
>> With that perspective, the change in layout for the AST2700 is effectively a
>> specialisation for all the registers. Later, if there's some tinkering with the
>> timer registers for a hypothetical AST2800, we can follow the same strategy by
>> extracting out the common behaviours for the AST2700 and AST2800, and
>> invoke them through the default label.
>>
>> As a quick PoC to demonstrate my line of thinking (not compiled, not tested,
>> only converts AST2400):
>>
> Thank you for your review and suggestion.
> Currently, I am working on QEMU to support the "AST2700 A1" boot(I should refactor INTC model).

Is that the reason why the QEMU ast2700-evb machine doesn't boot
with the v09.04 SDK images ?

> Once I have completed that task, I will revise the timer model with your suggestion.

Please replace suffix '_generic' by '_common' when you do.



Thanks,

C.



