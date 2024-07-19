Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E55C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 06:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUh07-000550-2p; Fri, 19 Jul 2024 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUh04-00051W-SA; Fri, 19 Jul 2024 02:21:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUh02-00081m-6V; Fri, 19 Jul 2024 02:21:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WQKM24FN6z4wym;
 Fri, 19 Jul 2024 16:21:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQKLy43Tjz4w2K;
 Fri, 19 Jul 2024 16:21:27 +1000 (AEST)
Message-ID: <0d155585-46d0-4a72-9004-7990b54bd096@kaod.org>
Date: Fri, 19 Jul 2024 08:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-4-jamin_lin@aspeedtech.com>
 <311c3893-4e27-4472-8356-889fdaaade6f@kaod.org>
 <SI2PR06MB5041287D9E64F7D0E25968EEFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5f6efa7b-0ed9-4cf3-b8e5-b6b0656394fd@kaod.org>
 <SI2PR06MB50412C180B0C364D1865BE0AFCAD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB50412C180B0C364D1865BE0AFCAD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vGMz=OT=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/19/24 03:11, Jamin Lin wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
>> memory size
>>
>> On 7/18/24 11:42, Jamin Lin wrote:
>>> Hi Cedric,
>>>
>>>> Subject: Re: [PATCH v1 03/15] hw/i2c/aspeed: support to set the
>>>> different memory size
>>>>
>>>> On 7/18/24 08:49, Jamin Lin wrote:
>>>>> According to the datasheet of ASPEED SOCs, an I2C controller owns
>>>>> 8KB of register space for AST2700, owns 4KB of register space for
>>>>> AST2600,
>>>>> AST2500 and AST2400, and owns 64KB of register space for AST1030.
>>>>>
>>>>> It set the memory region size 4KB by default and it does not
>>>>> compatible register space for AST2700.
>>>>>
>>>>> Introduce a new class attribute to set the I2C controller memory
>>>>> size for different ASPEED SOCs.
>>>>>
>>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>>> ---
>>>>>     hw/i2c/aspeed_i2c.c         | 6 +++++-
>>>>>     include/hw/i2c/aspeed_i2c.h | 2 +-
>>>>>     2 files changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
>>>>> b43afd250d..7d5a53c4c0 100644
>>>>> --- a/hw/i2c/aspeed_i2c.c
>>>>> +++ b/hw/i2c/aspeed_i2c.c
>>>>> @@ -1014,7 +1014,7 @@ static void aspeed_i2c_realize(DeviceState
>>>>> *dev, Error **errp)
>>>>>
>>>>>         sysbus_init_irq(sbd, &s->irq);
>>>>>         memory_region_init_io(&s->iomem, OBJECT(s),
>>>> &aspeed_i2c_ctrl_ops, s,
>>>>> -                          "aspeed.i2c", 0x1000);
>>>>> +                          "aspeed.i2c", aic->mem_size);
>>>>>         sysbus_init_mmio(sbd, &s->iomem);
>>>>>
>>>>>         for (i = 0; i < aic->num_busses; i++) { @@ -1286,6 +1286,7 @@
>>>>> static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
>>>>>         aic->pool_size = 0x800;
>>>>>         aic->pool_base = 0x800;
>>>>>         aic->bus_pool_base = aspeed_2400_i2c_bus_pool_base;
>>>>> +    aic->mem_size = 0x1000;
>>>>>     }
>>>>>
>>>>>     static const TypeInfo aspeed_2400_i2c_info = { @@ -1320,6 +1321,7
>>>>> @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void
>> *data)
>>>>>         aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
>>>>>         aic->check_sram = true;
>>>>>         aic->has_dma = true;
>>>>> +    aic->mem_size = 0x1000;
>>>>>     }
>>>>>
>>>>>     static const TypeInfo aspeed_2500_i2c_info = { @@ -1353,6 +1355,7
>>>>> @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void
>> *data)
>>>>>         aic->pool_base = 0xC00;
>>>>>         aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
>>>>>         aic->has_dma = true;
>>>>> +    aic->mem_size = 0x1000;
>>>>>     }
>>>>>
>>>>>     static const TypeInfo aspeed_2600_i2c_info = { @@ -1376,6 +1379,7
>>>>> @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, void
>> *data)
>>>>>         aic->pool_base = 0xC00;
>>>>>         aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
>>>>>         aic->has_dma = true;
>>>>> +    aic->mem_size = 0x10000;
>>>>
>>> Thanks for review.
>>>
>>> According to the datasheet of AST1030 in chapter 7 (Memory Space
>>> Allocation Table) , the register address space of I2C Controller range
>>> is start from 7E7B0000 to 7E7BFFFF and its register address space is
>> 64KB(0x10000).
>>
>> OK.
>>
>>> The firmware only use 4KB address space. We can change mem_size either
>> 4KB or 64KB.
>>> Could you tell me which size you prefer?
>>
>> I would keep the larger value for the model and let FW decide to resize or not.
>>
> Thanks for suggestion.
> Got it.

and so,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>
> 
> ************* Email Confidentiality Notice ********************
> 免責聲明:
> 本信件(或其附件)可能包含機密資訊，並受法律保護。如 台端非指定之收件者，請以電子郵件通知本電子郵件之發送者, 並請立即刪除本電子郵件及其附件和銷毀所有複印件。謝謝您的合作!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.


