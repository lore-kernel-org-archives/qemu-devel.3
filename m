Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0031CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 07:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAl3a-0001NE-GU; Fri, 02 May 2025 03:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAl3Y-0001Ms-Ia; Fri, 02 May 2025 03:43:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=zHgX=XS=kaod.org=clg@ozlabs.org>)
 id 1uAl3V-0001jK-Rq; Fri, 02 May 2025 03:43:36 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZpjZz07qDz4x5g;
 Fri,  2 May 2025 17:43:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZpjZv16Swz4x0s;
 Fri,  2 May 2025 17:43:18 +1000 (AEST)
Message-ID: <2d39d2e7-3540-467c-ae9d-184042f9215f@kaod.org>
Date: Fri, 2 May 2025 09:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1
 SSP SoC
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 "longzl2@lenovo.com" <longzl2@lenovo.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
 <20250429091855.1948374-6-steven_lee@aspeedtech.com>
 <11b5a654-00e9-447d-8827-83702ec30ab8@kaod.org>
 <KL1PR0601MB4180A5FEDCA81D3E2B25E7CF858D2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <KL1PR0601MB4180A5FEDCA81D3E2B25E7CF858D2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=zHgX=XS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/2/25 04:06, Steven Lee wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Wednesday, April 30, 2025 5:46 PM
>> To: Steven Lee <steven_lee@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; longzl2@lenovo.com; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v3 5/9] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0
>> A1 SSP SoC
>>
>> On 4/29/25 11:18, Steven Lee wrote:
>>> The AST2700 SSP (Secondary Service Processor) is a Cortex-M4 coprocessor.
>>> This patch adds support for A1 SSP with the following updates:
>>>
>>> - Introduce Aspeed27x0SSPSoCState structure in aspeed_soc.h
>>> - Define memory map and IRQ map for AST27x0 A1 SSP SoC
>>> - Implement initialization and realization functions
>>> - Add support for UART, INTC, and SCU devices
>>> - Map unimplemented devices for IPC and SCUIO
>>>
>>> The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
>>> interrupt controller.
>>>
>>> Difference from AST2700:
>>>
>>>       - AST2700
>>>         - Support GICINT128 to GICINT136 in INTC
>>>         - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
>>>             Bit 0 -> GIC 192
>>>             Bit 1 -> GIC 193
>>>             Bit 2 -> GIC 194
>>>             Bit 3 -> GIC 195
>>>             Bit 4 -> GIC 196
>>>
>>>       - AST2700-ssp
>>>         - Support SSPINT128 to SSPINT136 in INTC
>>>         - The INTCIO SSPINT_160_169 has 10 output pins, mapped as
>> follows:
>>>             Bit 0 -> SSPINT 160
>>>             Bit 1 -> SSPINT 161
>>>             Bit 2 -> SSPINT 162
>>>             Bit 3 -> SSPINT 163
>>>             Bit 4 -> SSPINT 164
>>>
>>> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
>>> Change-Id: I924bf1a657f1e83f9e16d6673713f4a06ecdb496
>>> ---
>>>    include/hw/arm/aspeed_soc.h |  14 ++
>>>    hw/arm/aspeed_ast27x0-ssp.c | 309
>> ++++++++++++++++++++++++++++++++++++
>>>    hw/arm/meson.build          |   1 +
>>>    3 files changed, 324 insertions(+)
>>>    create mode 100644 hw/arm/aspeed_ast27x0-ssp.c
>>>
>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>>> index dd5fb731e2..7c65324801 100644
>>> --- a/include/hw/arm/aspeed_soc.h
>>> +++ b/include/hw/arm/aspeed_soc.h
>>> @@ -145,6 +145,18 @@ struct Aspeed10x0SoCState {
>>>        ARMv7MState armv7m;
>>>    };
>>>
>>> +struct Aspeed27x0SSPSoCState {
>>> +    AspeedSoCState parent;
>>> +    AspeedINTCState intc[2];
>>> +    UnimplementedDeviceState ipc[2];
>>> +    UnimplementedDeviceState scuio;
>>> +
>>> +    ARMv7MState armv7m;
>>> +};
>>> +
>>> +
>>> +static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, void
>>> +*data) {
>>> +    static const char * const valid_cpu_types[] = {
>>> +        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
>>
>> So no FPU ?  I wonder what "cortex-m4" CPU model in QEMU implements.
>> Something to check.
>>
> 
> The SSP core on the AST2700 is based on a Cortex-M4 with FPU (M4F).
> However, QEMU only provides cortex-m4 at the moment, so I'm using that for now.

Yes. I checked and the cortex-m4 doesn't have FPU support.

> 
>>> +        NULL
>>> +    };
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
>>> +
>>> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
>>> +    dc->user_creatable = false;
>>> +    dc->realize = aspeed_soc_ast27x0ssp_realize;
>>> +
>>> +    sc->valid_cpu_types = valid_cpu_types;
>>> +    sc->silicon_rev = AST2700_A1_SILICON_REV;
>>> +    sc->sram_size = AST2700_SSP_RAM_SIZE;
>>> +    sc->spis_num = 0;
>>> +    sc->ehcis_num = 0;
>>> +    sc->wdts_num = 0;
>>> +    sc->macs_num = 0;
>>> +    sc->uarts_num = 13;
>>> +    sc->uarts_base = ASPEED_DEV_UART0;
>>> +    sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
>>> +    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
>>> +    sc->num_cpus = 1;
>>> +    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq; }
>>> +
>>> +static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
>>> +    {
>>> +        .name           = TYPE_ASPEED27X0SSP_SOC,
>>> +        .parent         = TYPE_ASPEED_SOC,
>>> +        .instance_size  = sizeof(Aspeed27x0SSPSoCState),
>>> +        .abstract       = true,
>>
>> The abstract class doesn't seem useful. why keep it ?
>>
>>
> 
> Thanks for pointing that out, it was originally introduced to support both A0 and A1 SoCs.
> After dropping A0 support, I forgot to remove the abstract class.
> I'll clean it up in the v4 patch series.
Thanks,

C.



