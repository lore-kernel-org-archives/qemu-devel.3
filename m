Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC44CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4w5-0007H2-Oa; Wed, 12 Nov 2025 02:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJ4w4-0007GP-NI
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:06:32 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJ4w1-0004Og-Je
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:06:32 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.84])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d5vZn0Vpqz5yWd;
 Wed, 12 Nov 2025 07:06:25 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 12 Nov
 2025 08:06:24 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007503aa52d-e0d9-470b-9ead-5f5c79ce3d2c,
 9257335D443C2E6469A43BBCD845C62091C4C3D1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <188cb6be-97dc-4818-a035-2ef845c59807@kaod.org>
Date: Wed, 12 Nov 2025 08:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] hw/arm/aspeed: Model AST1700 SGPIOM block as
 unimplemented device
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Yubin Zou <yubinz@google.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-17-kane_chen@aspeedtech.com>
 <e5c2996f-610a-4c53-b086-d0c9306add00@kaod.org>
 <SI6PR06MB7631AD1B0C7457F8890AAA08F7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631AD1B0C7457F8890AAA08F7CFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: feed13ce-6533-4b96-a711-e8f363be20d5
X-Ovh-Tracer-Id: 3598376104153811957
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF40gITRMRQAT8kYufCFuksjqcDAhSJL2+JsSH+X61zXfHP7xdJUOcZIT+1F8z6NIx3K4AOKO9FdqD9MCVRzclimFH2t1Z+FHkNw/bCxhZvGrSym6gJ3GkaU7A3kcm3+zgv0qYapeaABQF6s1WZu0Si9PwYQ0vktSngJRQc7inHwuVVaphszjpgC9yVlmVX+QEVVjBL364ZHbHTuqfTLZqQR3ecUIHzDo6/bJbCzimeCmk92Pvn51mzGgqn7LLQczGB/9K5/YfRiJ2FIiE03lWq787EKXzrEi2M1C932xvaizcEvaX1l+xyxdSsdyX5JfRG44dZ2tNhuuymDjnbwXCJJb89/simh8rt0b3Q0OeLaglHOpJ8LIYCSMPqWRnS0rCFWn3AP2kTgV2dkHEFjsDRJsUoro3rzkBdohDpDbI9Hf7dHIZ4jBNh2ijrT9s+OWggivWJlpem11Fbhnl+xWURp9Xuaq7LcyzoJhZzitPfpqBgNfaxJm+TPgGB3otY13gTLlNbVTq2umTa6U7hsjMKaIZotJZqctjvbxxR2BbL+tueWj+4HdlhZtsDSLbxvQBLgy08ObAx8blrQW2qkqVWRJESaUKa9uMyagon4eZFhq+Z0xcs4LzYOGFyA/urld37bDkFEZOrGiGl8KXuzHsf0cPDu4jROro8NoKZs+A5dA
DKIM-Signature: a=rsa-sha256; bh=aYlCsGLgaem7QMAYCo7H8mUI60ZBUzwh1NXpaQpsWQw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762931186; v=1;
 b=fM3m8XNxBV/GRpHBA71Nr8M2iCmf65MrvgDVydhh4REanC1sAElHDTsW1cJnkvrBtoGdu2FK
 qGDhQydfbPcysm8kxEHhTB4sHIK8a12GSO5Y1m+177NjoI/LHxe5y9TRel15pfwTV6ABMFFa0ee
 O7Lpthx9RKEiUtj7f72ZWtZmmemqzQKcXZ+z2SFX/AAmFHkW3Zzli69C05ao86AOJAzY7bL3ljv
 +KcM62FZ1mXNhG3KdW9fAfJpFYA2TxNiA4T/tlXUCQ5pH4KQB3O3ZYy6Z2L6P1eg0awzsEhczH/
 JjCUZqz84iAdgiYZE2Bj0WcF31SGhqouMVnAB/jiQdCOA==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 11/11/25 02:33, Kane Chen wrote:
> Hi Cédric,
> 
> Thanks for the information. I'll investigate this model and integrate it.

Help with reviewing is welcome !

Thanks,

C.




> 
> Best Regards,
> Kane
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Tuesday, November 11, 2025 12:15 AM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
>> here <qemu-devel@nongnu.org>; Yubin Zou <yubinz@google.com>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v2 16/17] hw/arm/aspeed: Model AST1700 SGPIOM block
>> as unimplemented device
>>
>> Hello,
>>
>> On 11/5/25 04:58, Kane Chen wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>
>>> AST1700 includes an SGPIOM block, but QEMU has no functional model yet.
>>
>> Does the series  "hw/gpio: Add Aspeed Serial GPIO (SGPIO) controller" [1]
>> proposed by Yubin Zou fill this gap ?
>>
>> Thanks,
>>
>> C.
>>
>> [1]
>> https://lore.kernel.org//qemu-devel/20251106-aspeed-sgpio-v1-0-b0260937
>> 16fa@google.com
>>
>>
>>> Expose it as an unimplemented device so the address space is reserved
>>> and the missing functionality is explicit to users/guests.
>>>
>>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>> ---
>>>    include/hw/misc/aspeed_ast1700.h |  1 +
>>>    hw/misc/aspeed_ast1700.c         | 16 ++++++++++++++++
>>>    2 files changed, 17 insertions(+)
>>>
>>> diff --git a/include/hw/misc/aspeed_ast1700.h
>>> b/include/hw/misc/aspeed_ast1700.h
>>> index 4048d31154..8ada3a7775 100644
>>> --- a/include/hw/misc/aspeed_ast1700.h
>>> +++ b/include/hw/misc/aspeed_ast1700.h
>>> @@ -44,6 +44,7 @@ struct AspeedAST1700SoCState {
>>>        AspeedWDTState wdt[AST1700_WDT_NUM];
>>>
>>>        UnimplementedDeviceState i3c;
>>> +    UnimplementedDeviceState sgpiom;
>>>    };
>>>
>>>    #endif /* ASPEED_AST1700_H */
>>> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c index
>>> 37b2946fc0..66a5f21d27 100644
>>> --- a/hw/misc/aspeed_ast1700.c
>>> +++ b/hw/misc/aspeed_ast1700.c
>>> @@ -19,6 +19,7 @@
>>>    #define AST2700_SOC_LTPI_SIZE        0x01000000
>>>    #define AST1700_SOC_SRAM_SIZE        0x00040000
>>>    #define AST1700_SOC_I3C_SIZE         0x00010000
>>> +#define AST1700_SOC_SGPIOM_SIZE      0x00002000
>>>
>>>    enum {
>>>        ASPEED_AST1700_DEV_SPI0,
>>> @@ -26,6 +27,7 @@ enum {
>>>        ASPEED_AST1700_DEV_ADC,
>>>        ASPEED_AST1700_DEV_SCU,
>>>        ASPEED_AST1700_DEV_GPIO,
>>> +    ASPEED_AST1700_DEV_SGPIOM,
>>>        ASPEED_AST1700_DEV_I2C,
>>>        ASPEED_AST1700_DEV_I3C,
>>>        ASPEED_AST1700_DEV_UART12,
>>> @@ -40,6 +42,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =
>> {
>>>        [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
>>>        [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
>>>        [ASPEED_AST1700_DEV_GPIO]      =  0x00C0B000,
>>> +    [ASPEED_AST1700_DEV_SGPIOM]    =  0x00C0C000,
>>>        [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
>>>        [ASPEED_AST1700_DEV_I3C]       =  0x00C20000,
>>>        [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>>> @@ -162,6 +165,15 @@ static void aspeed_ast1700_realize(DeviceState
>> *dev, Error **errp)
>>>
>> aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
>>>
>>> sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
>>>
>>> +    /* SGPIOM */
>>> +    qdev_prop_set_string(DEVICE(&s->sgpiom), "name", "ioexp-sgpiom");
>>> +    qdev_prop_set_uint64(DEVICE(&s->sgpiom), "size",
>> AST1700_SOC_SGPIOM_SIZE);
>>> +    sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom), errp);
>>> +    memory_region_add_subregion_overlap(&s->iomem,
>>> +
>> aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SGPIOM],
>>> +
>> sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom), 0),
>>> +                        -1000);
>>> +
>>>        /* WDT */
>>>        for (i = 0; i < AST1700_WDT_NUM; i++) {
>>>            AspeedWDTClass *awc =
>> ASPEED_WDT_GET_CLASS(&s->wdt[i]); @@
>>> -225,6 +237,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>>>        object_initialize_child(obj, "ltpi-ctrl",
>>>                                &s->ltpi, TYPE_ASPEED_LTPI);
>>>
>>> +    /* SGPIOM */
>>> +    object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom,
>>> +                            TYPE_UNIMPLEMENTED_DEVICE);
>>> +
>>>        /* WDT */
>>>        for (i = 0; i < AST1700_WDT_NUM; i++) {
>>>            snprintf(typename, sizeof(typename), "aspeed.wdt-%s",
>>> socname);
> 


