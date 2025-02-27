Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE7FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaeW-0005Kr-FJ; Thu, 27 Feb 2025 04:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gGIw=VS=kaod.org=clg@ozlabs.org>)
 id 1tnaeT-0005K6-6X; Thu, 27 Feb 2025 04:57:57 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gGIw=VS=kaod.org=clg@ozlabs.org>)
 id 1tnaeQ-0004RH-6t; Thu, 27 Feb 2025 04:57:56 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z3Rbc5K7Dz4x3d;
 Thu, 27 Feb 2025 20:57:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z3RbY1jsgz4x04;
 Thu, 27 Feb 2025 20:57:44 +1100 (AEDT)
Message-ID: <73c6c7c5-80f6-403b-b4de-3a55ce8735a3@kaod.org>
Date: Thu, 27 Feb 2025 10:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] hw/intc/aspeed: Support setting different memory
 and register size
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-2-jamin_lin@aspeedtech.com>
 <d770b173-c9e8-46b0-9c36-4f3fd3005d92@kaod.org>
 <SI2PR06MB5041068E28CC4DD8CFA24854FCC42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <642b1b3d-c73d-450b-b45e-21bc7bb51d31@kaod.org>
 <SI2PR06MB50412C87DC117A6183B27EDCFCC22@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB50412C87DC117A6183B27EDCFCC22@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=gGIw=VS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/26/25 04:40, Jamin Lin wrote:
> Hi Cedric,
> 
>>>> and the register array as:
>>>>
>>>>      uint32_t regs[ASPEED_INTC_NR_REGS];
>>>>
>>>> The number of regs looks pretty big for me. Are the registers
>>>> covering the whole MMIO aperture ?
>>>>
>>> According to the datasheet, the entire register address space size of
>>> INTC (CPU DIE) is 16KB (0x12100000-0x12103FFF). Therefore, I set the
>> memory size to 0x4000.
>>> Currently, we need to use the "GICINT192-201 raw status and clear" register
>> INTC1B04.
>>> Thus, an array size of 0x2000 is sufficient.
>>
>> yes but we are only using these regs :
>>
>> REG32(GICINT128_EN,         0x1000)
>> REG32(GICINT128_STATUS,     0x1004)
>> REG32(GICINT129_EN,         0x1100)
>> REG32(GICINT129_STATUS,     0x1104)
>> REG32(GICINT130_EN,         0x1200)
>> REG32(GICINT130_STATUS,     0x1204)
>> REG32(GICINT131_EN,         0x1300)
>> REG32(GICINT131_STATUS,     0x1304)
>> REG32(GICINT132_EN,         0x1400)
>> REG32(GICINT132_STATUS,     0x1404)
>> REG32(GICINT133_EN,         0x1500)
>> REG32(GICINT133_STATUS,     0x1504)
>> REG32(GICINT134_EN,         0x1600)
>> REG32(GICINT134_STATUS,     0x1604)
>> REG32(GICINT135_EN,         0x1700)
>> REG32(GICINT135_STATUS,     0x1704)
>> REG32(GICINT136_EN,         0x1800)
>> REG32(GICINT136_STATUS,     0x1804)
>> REG32(GICINT192_201_EN,         0x1B00)
>> REG32(GICINT192_201_STATUS,     0x1B04)
>>
>> so the first 0x1000 are unused.
>>
>>
>>>
>>> However, we are going to increase the size to 0x3000 to support the
>>> co-processors SSP and TSP In the another patch series.
>>> We also need to include the following register definitions:
>>>
>>> /* SSP INTC Registers */
>>> REG32(SSPINT128_EN,             0x2000)
>>> REG32(SSPINT128_STATUS,         0x2004)
>>> REG32(SSPINT129_EN,             0x2100)
>>> REG32(SSPINT129_STATUS,         0x2104)
>>> REG32(SSPINT130_EN,             0x2200)
>>> REG32(SSPINT130_STATUS,         0x2204)
>>> REG32(SSPINT131_EN,             0x2300)
>>> REG32(SSPINT131_STATUS,         0x2304)
>>> REG32(SSPINT132_EN,             0x2400)
>>> REG32(SSPINT132_STATUS,         0x2404)
>>> REG32(SSPINT133_EN,             0x2500)
>>> REG32(SSPINT133_STATUS,         0x2504)
>>> REG32(SSPINT134_EN,             0x2600)
>>> REG32(SSPINT134_STATUS,         0x2604)
>>> REG32(SSPINT135_EN,             0x2700)
>>> REG32(SSPINT135_STATUS,         0x2704)
>>> REG32(SSPINT136_EN,             0x2800)
>>> REG32(SSPINT136_STATUS,         0x2804)
>>> REG32(SSPINT137_EN,             0x2900)
>>> REG32(SSPINT137_STATUS,         0x2904)
>>> REG32(SSPINT138_EN,             0x2A00)
>>> REG32(SSPINT138_STATUS,         0x2A04)
>>> REG32(SSPINT160_169_EN,         0x2B00)
>>> REG32(SSPINT160_169_STATUS,     0x2B04)
>>>
>>>>
>>>>> +    if (offset >= aic->reg_size) {
>>>>
>>>> This is dead code since the MMIO aperture has the same size. You
>>>> could remove the check.
>>>
>>> Will remove.
>>>>
>>>>>             qemu_log_mask(LOG_GUEST_ERROR,
>>>>>                           "%s: Out-of-bounds read at offset 0x%"
>>>> HWADDR_PRIx "\n",
>>>>>                           __func__, offset); @@ -143,7 +144,7 @@
>>>> static
>>>>> void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>>>>>         uint32_t change;
>>>>>         uint32_t irq;
>>>>>
>>>>> -    if (addr >= ASPEED_INTC_NR_REGS) {
>>>>> +    if (offset >= aic->reg_size) {
>>>>>             qemu_log_mask(LOG_GUEST_ERROR,
>>>>>                           "%s: Out-of-bounds write at offset 0x%"
>>>> HWADDR_PRIx "\n",
>>>>>                           __func__, offset); @@ -302,10 +303,16
>> @@
>>>>> static void aspeed_intc_realize(DeviceState *dev, Error **errp)
>>>>>         AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
>>>>>         int i;
>>>>>
>>>>> +    memory_region_init(&s->iomem_container, OBJECT(s),
>>>>> +            TYPE_ASPEED_INTC ".container", aic->mem_size);
>>>>> +
>>>>> +    sysbus_init_mmio(sbd, &s->iomem_container);
>>>>
>>>> Why introduce a container ? Do you plan to have multiple sub-regions ?
>>>>
>>> I created a container to save the entire register address space of
>>> INTC and its sub-region to place the actual used register address space.
>>> 0000000012100000-0000000012103fff (prio 0, i/o): aspeed.intc.container
>>>         0000000012100000-0000000012101fff (prio 0, i/o):
>>> aspeed.intc.regs 0000000014c18000-0000000014c183ff (prio 0, i/o):
>> aspeed.intc.container
>>>         0000000014c18000-0000000014c183d7 (prio 0, i/o):
>>> aspeed.intc.regs
>>>
>>> If I misunderstood this design, I will change it to have two memory regions
>> for INTC and INTCIO, respectively.
>>> If need, I will change to the following memory regions.  --> it removes
>> containers.
>>>         0000000012100000-0000000012101fff (prio 0, i/o):
>> aspeed.intc.regs
>>>         0000000014c18000-0000000014c183d7 (prio 0, i/o):
>>> aspeed.intc.regs
>>
>> I don't think the region container is useful in that case since there is only a
>> single region per model.
>>
>> However, we could "optimize" a bit the MMIO apertures to avoid mapping
>> huge unused gaps and only map the useful set of registers :
>>
>>     INTC Registers      [ 0x1000 - 0x1B04 ]
>>     SSP INTC Registers  [ 0x2000 - 0x2B04 ]
>>     INTCIO Registers    [ 0x0100 - 0x0154 ]
>>
>> Each set would be associated with a subregion which would be mapped at the
>> right offset in the region container.
>>
>> This is just a suggestion.
>>
> 
> I followed your suggestion to reduce the size of the register array. Here's what I've done:
> 
> 0000000012100000-0000000012103fff (prio 0, i/o): aspeed.intc.container
>        0000000012101000-0000000012101b07 (prio 0, i/o): aspeed.intc.regs
> 
> A solution:
> 1.	I created an INTC Register sub-region mapped at offset 0x1000 with a size of 0xb08.
> This change adjusted the following register offsets to their original values minus 0x1000:
> 
> REG32(GICINT128_EN,         0x000)
> REG32(GICINT128_STATUS,     0x004)
> REG32(GICINT129_EN,         0x100)
> REG32(GICINT129_STATUS,     0x104)
> REG32(GICINT130_EN,         0x200)
> REG32(GICINT130_STATUS,     0x204)
> REG32(GICINT131_EN,         0x300)
> REG32(GICINT131_STATUS,     0x304)
> REG32(GICINT132_EN,         0x400)
> REG32(GICINT132_STATUS,     0x404)
> REG32(GICINT133_EN,         0x500)
> REG32(GICINT133_STATUS,     0x504)
> REG32(GICINT134_EN,         0x600)
> REG32(GICINT134_STATUS,     0x604)
> REG32(GICINT135_EN,         0x700)
> REG32(GICINT135_STATUS,     0x704)
> REG32(GICINT136_EN,         0x800)
> REG32(GICINT136_STATUS,     0x804)
> REG32(GICINT192_201_EN,         0xB00)
> REG32(GICINT192_201_STATUS,     0xB04)
> 
> 2.	To support multiple sub-regions, such as for SSP, I created a new sub-region mapped at offset 0x2000.
> This adjustment changed the register offsets to their original values minus 0x2000:
> 
> /* SSP INTC Registers */
>> REG32(SSPINT128_EN,             0x000)
>> REG32(SSPINT128_STATUS,         0x004)
>> REG32(SSPINT129_EN,             0x100)
>> REG32(SSPINT129_STATUS,         0x104)
>> REG32(SSPINT130_EN,             0x200)
>> REG32(SSPINT130_STATUS,         0x204)
>> REG32(SSPINT131_EN,             0x300)
>> REG32(SSPINT131_STATUS,         0x304)
>> REG32(SSPINT132_EN,             0x400)
>> REG32(SSPINT132_STATUS,         0x404)
>> REG32(SSPINT133_EN,             0x500)
>> REG32(SSPINT133_STATUS,         0x504)
>> REG32(SSPINT134_EN,             0x600)
>> REG32(SSPINT134_STATUS,         0x604)
>> REG32(SSPINT135_EN,             0x700)
>> REG32(SSPINT135_STATUS,         0x704)
>> REG32(SSPINT136_EN,             0x800)
>> REG32(SSPINT136_STATUS,         0x804)
>> REG32(SSPINT137_EN,             0x900)
>> REG32(SSPINT137_STATUS,         0x904)
>> REG32(SSPINT138_EN,             0xA00)
>> REG32(SSPINT138_STATUS,         0xA04)
>> REG32(SSPINT160_169_EN,         0xB00)
>> REG32(SSPINT160_169_STATUS,     0xB04)
> 
> Regarding handling identical offsets like SSPINT128_EN and GICINT128_EN, which both use offset 0x00,
> they currently share the same aspeed_intc_ops and IRQ handler functions like aspeed_intc_status_handler.

You need a MemoryRegionOps per region.

> How can I check whether the offset belongs to the SSP or INTC region?
> Can I create new aspeed_intc_ssp_write and aspeed_intc_ssp_read callback functions specifically for
> reading and writing to the SSP region, and then add new parameters to the IRQ handler to distinguish
> between the SSP and INTC regions?

I haven't looked at that part yet.

> 
> B solution:
> 
> There is another solution where we don't consider multiple sub-regions and only support a single sub-region.
> Since the SSP runs on a co-processor, we've created a new SSP class:
> static void aspeed_intc_register_types(void)
> {
>      type_register_static(&aspeed_intc_info);
>      type_register_static(&aspeed_2700_intc_info);
>      type_register_static(&aspeed_2700_intcio_info);
> +    type_register_static(&aspeed_2700_ssp_intc_info);
> +    type_register_static(&aspeed_2700_ssp_intcio_info);
> }
> 
> In this solution, we don’t need to make many changes because the SSP has its own AspeedINTCState register array.
> As a result, most functions can be reused to support SSP.
> The SSP uses the same callback function as the INTC:
> 
> static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>                                          unsigned size)
> {
>      switch (addr) {
>      case R_GICINT128_EN:
>      case R_GICINT129_EN:
>      case R_GICINT130_EN:
>      case R_GICINT131_EN:
>      case R_GICINT132_EN:
>      case R_GICINT133_EN:
>      case R_GICINT134_EN:
>      case R_GICINT135_EN:
>      case R_GICINT136_EN:
>      case R_GICINT192_201_EN:
> +    case R_SSPINT128_STATUS:
> +    case R_SSPINT129_STATUS:
> +    case R_SSPINT130_STATUS:
> 
> Since both GICINT128_EN and SSPINT128_EN share the same offset of 0, I will modify the code to handle INT128 for both.
> 
> Could you please give me any suggestion?

Please send a series.

As a reminder, soft-freeze is in less than 2 weeks. Please try to organize
the current series so that the more obvious ones can be merged easily.


Thanks,

C.


> 
> Thanks-Jamin
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> Do you expect the above memory regions for INTC?
>>>
>>> Thanks for your review and suggestion.
>>> Jamin
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>
>>>>> +
>>>>>         memory_region_init_io(&s->iomem, OBJECT(s),
>> &aspeed_intc_ops,
>>>> s,
>>>>> -                          TYPE_ASPEED_INTC ".regs",
>>>> ASPEED_INTC_NR_REGS << 2);
>>>>> +                          TYPE_ASPEED_INTC ".regs",
>> aic->reg_size);
>>>>> +
>>>>> +    memory_region_add_subregion(&s->iomem_container, 0x0,
>>>> &s->iomem);
>>>>>
>>>>> -    sysbus_init_mmio(sbd, &s->iomem);
>>>>>         qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
>>>>>
>>>>>         for (i = 0; i < aic->num_ints; i++) { @@ -344,6 +351,8 @@
>>>>> static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
>>>>>         dc->desc = "ASPEED 2700 INTC Controller";
>>>>>         aic->num_lines = 32;
>>>>>         aic->num_ints = 9;
>>>>> +    aic->mem_size = 0x4000;
>>>>> +    aic->reg_size = 0x2000;
>>>>>     }
>>>>>
>>>>>     static const TypeInfo aspeed_2700_intc_info = { diff --git
>>>>> a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
>>>>> index 18cb43476c..ecaeb15aea 100644
>>>>> --- a/include/hw/intc/aspeed_intc.h
>>>>> +++ b/include/hw/intc/aspeed_intc.h
>>>>> @@ -25,6 +25,8 @@ struct AspeedINTCState {
>>>>>
>>>>>         /*< public >*/
>>>>>         MemoryRegion iomem;
>>>>> +    MemoryRegion iomem_container;
>>>>> +
>>>>>         uint32_t regs[ASPEED_INTC_NR_REGS];
>>>>>         OrIRQState orgates[ASPEED_INTC_NR_INTS];
>>>>>         qemu_irq output_pins[ASPEED_INTC_NR_INTS]; @@ -39,6 +41,8
>> @@
>>>>> struct AspeedINTCClass {
>>>>>
>>>>>         uint32_t num_lines;
>>>>>         uint32_t num_ints;
>>>>> +    uint64_t mem_size;
>>>>> +    uint64_t reg_size;
>>>>>     };
>>>>>
>>>>>     #endif /* ASPEED_INTC_H */
>>>
> 


