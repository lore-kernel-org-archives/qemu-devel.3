Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE2DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfG8p-0006ux-9J; Tue, 04 Feb 2025 05:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Xvsd=U3=kaod.org=clg@ozlabs.org>)
 id 1tfG8m-0006tz-Dz; Tue, 04 Feb 2025 05:26:48 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Xvsd=U3=kaod.org=clg@ozlabs.org>)
 id 1tfG8j-0007xl-MW; Tue, 04 Feb 2025 05:26:48 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YnKKH3WSwz4wy9;
 Tue,  4 Feb 2025 21:26:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YnKK91v7wz4wc2;
 Tue,  4 Feb 2025 21:26:20 +1100 (AEDT)
Message-ID: <e50b062a-2c93-483a-94d9-0b9fa152b09d@kaod.org>
Date: Tue, 4 Feb 2025 11:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
 <2d9247ab-34dd-4dde-a9c0-c04c2d8a1a18@kaod.org>
 <d9575d2cec122e41e11d84667f4d7cc63848b3ce.camel@codeconstruct.com.au>
 <SI2PR06MB504109C5631AD551E2542802FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <fd8bd633-947b-4bb6-be64-eb3bce60babb@kaod.org>
 <SI2PR06MB5041FC0F7F84B3D9031D0111FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB5041FC0F7F84B3D9031D0111FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Xvsd=U3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.068, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/4/25 09:22, Jamin Lin wrote:
> Hi Cedric,
> 
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Tuesday, February 4, 2025 3:35 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Peter Maydell <peter.maydell@linaro.org>;
>> Steven Lee <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>;
>> Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs
>> <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
>>
>> On 2/4/25 07:50, Jamin Lin wrote:
>>> Hi Cedric, Andrew
>>>
>>>> From: Andrew Jeffery <andrew@codeconstruct.com.au>
>>>> Sent: Thursday, January 30, 2025 11:22 AM
>>>> To: Cédric Le Goater <clg@kaod.org>; Jamin Lin
>>>> <jamin_lin@aspeedtech.com>; Peter Maydell <peter.maydell@linaro.org>;
>>>> Steven Lee <steven_lee@aspeedtech.com>; Troy Lee
>> <leetroy@gmail.com>;
>>>> Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs
>>>> <qemu-arm@nongnu.org>; open list:All patches CC here
>>>> <qemu-devel@nongnu.org>
>>>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>>>> <yunlin.tang@aspeedtech.com>
>>>> Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
>>>>
>>>> On Wed, 2025-01-29 at 18:03 +0100, Cédric Le Goater wrote:
>>>>> On 1/21/25 08:04, Jamin Lin wrote:
>>>>>> The design of the INTC has significant changes in the AST2700 A1.
>>>>>> In the
>>>>>> AST2700 A0, there was one INTC controller, whereas in the AST2700
>>>>>> A1, there were two INTC controllers: INTC0 (CPU DIE) and INTC1 (I/O
>>>>>> DIE).
>>>>>>
>>>>>> The previous INTC model only supported the AST2700 A0 and was
>>>>>> implemented for the INTC0 (CPU DIE). To support the future INTC1
>>>>>> (I/O DIE) model, rename INTC to INTC0.
>>>>>
>>>>>
>>>>> Why not introduce definitions with _INTC_IO_ and leave alone the
>>>>> current instead ? Do we expect to have more than 2 INTC controllers ?
>>>>>
>>>>
>>>> There was similar discussion on the devicetree bindings for the SCU a
>>>> while back:
>>>>
>>>> https://lore.kernel.org/all/94efc2d4ff280a112b869124fc9d7e35ac031596.
>>>> cam
>>>> el@codeconstruct.com.au/
>>>>
>>>> Ryan didn't like deviating from their internal documentation :(
>>>>
>>>> Andrew
>>>
>>>
>>> Thanks for your suggestion.
>>>
>>> Last year, Troy and I implemented the SCU(CPU Die) and SCU_IO(IO Die)
>> models to support the AST2700.
>>> https://github.com/qemu/qemu/blob/master/hw/misc/aspeed_scu.c#L1073
>>> https://github.com/qemu/qemu/blob/master/hw/misc/aspeed_scu.c#L1080
>>>> I am fine with keeping the INTC(CPU Die) naming and creating a new
>> INTC_IO(IO Die) model to support the AST2700 A1.
>>
>> Good. I think this will reduce the changes and clarify the models.
>>
>>> I have a question regarding the INTC_IO model implementation:
>>> Can I define separate "intc_io_class_init" and "intcio_class_realize" functions
>> for INTC_IO, similar to the SCU/SCU_IO models?
>>
>> Looks OK to me.
>>
>>> If yes, I think the patch “2 Support different memory region ops” can be
>> omitted.
>>> Additionally, I suggest that both INTC and INTC_IO have their own MMIO
>> callback functions, as their register addresses are different.
>>
>> Do you mean the register offset in the MMIO aperture ? We try to avoid
>> duplication unless the code becomes too complex.
> 
> 
> I means both INTC_IO and INTC_CPU use the same offset but different register definitions.
> 
> INTC0:
> INTC0_10
> INTC0_14
> 
> INTC1:
> INTC1_10
> INTC1_14

can you define them as

INTC_xxx

to avoid all the duplication below ?


Thanks,

C.



> I will implement as following
> 
> static void aspeed_intc_register_types(void)
> {
>      type_register_static(&aspeed_intc_info);
>      type_register_static(&aspeed_2700_intc_info);
>      type_register_static(&aspeed_intcio_info);
>      type_register_static(&aspeed_2700_intcio_info);
> }
> 
> static void aspeed_2700_intcio_class_init(ObjectClass *klass, void *data)
> {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> 
>      dc->desc = "ASPEED 2700 INTC IO Controller";
> }
> 
> static const TypeInfo aspeed_2700_intcio_info = {
>      .name = TYPE_ASPEED_2700_INTCIO,
>      .parent = TYPE_ASPEED_INTCIO,
>      .class_init = aspeed_2700_intcio_class_init,
> };
> 
> static void aspeed_intcio_class_init(ObjectClass *klass, void *data)
> {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> 
>      dc->desc = "ASPEED INTC IO Controller";
>      dc->realize = aspeed_intcio_realize;
>      device_class_set_legacy_reset(dc, aspeed_intcio_reset);
>      dc->vmsd = NULL;
> }
> 
> static const TypeInfo aspeed_intcio_info = {
>      .name = TYPE_ASPEED_INTCIO,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_init = aspeed_intcio_instance_init,
>      .instance_size = sizeof(AspeedINTCIOState),
>      .class_init = aspeed_intcio_class_init,
>      .class_size = sizeof(AspeedINTCIOClass),
>      .abstract = true,
> };
> 
> static void aspeed_intcio_realize(DeviceState *dev, Error **errp)
> {
>   memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intcio_ops, s,
>                            TYPE_ASPEED_INTCIO ".regs", ASPEED_INTC_NR_REGS << 2);
> }
> static void aspeed_intcio_reset(DeviceState *dev)
> {
> }
> static void aspeed_intcio_instance_init(Object *obj)
> {
> }
> 
> I want to create aspeed_intcio_read and aspeed_intcio_write call back functions.
> 
> static const MemoryRegionOps aspeed_intcio_ops = {
>      .read = aspeed_intcio_read,
>      .write = aspeed_intcio_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      }
> };
> 
> Thanks-Jamin
>>
>> Please send a v2, splitting your series in 3 as requested in the other email.
>>
> Will resend
>> Thanks,
>>
>> C.
> 


