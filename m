Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CCBC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7sUm-00017w-3A; Fri, 17 May 2024 03:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mZ+H=MU=kaod.org=clg@ozlabs.org>)
 id 1s7sUj-000108-Tu; Fri, 17 May 2024 03:59:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mZ+H=MU=kaod.org=clg@ozlabs.org>)
 id 1s7sUf-0006SD-Ml; Fri, 17 May 2024 03:59:13 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VgfVb3VtMz4x0y;
 Fri, 17 May 2024 17:59:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VgfVV3HySz4wx6;
 Fri, 17 May 2024 17:58:58 +1000 (AEST)
Message-ID: <1418ca7a-dc4c-46bb-b765-273686b1f05b@kaod.org>
Date: Fri, 17 May 2024 09:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/16] aspeed/soc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-13-jamin_lin@aspeedtech.com>
 <36db3ce7-633b-44d0-9f19-30cf0ffe9e71@kaod.org>
 <SEYPR06MB5037AF0FAEC7DBC2A6D88879FC0D2@SEYPR06MB5037.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SEYPR06MB5037AF0FAEC7DBC2A6D88879FC0D2@SEYPR06MB5037.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mZ+H=MU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/19/24 09:58, Jamin Lin wrote:
> Hi Cedric,
>> On 4/16/24 11:18, Jamin Lin wrote:
>>> Initial definitions for a simple machine using an AST2700 SOC (Cortex-a35
>> CPU).
>>>
>>> AST2700 SOC and its interrupt controller are too complex to handle in
>>> the common Aspeed SoC framework. We introduce a new ast2700 class with
>>> instance_init and realize handlers.
>>>
>>> AST2700 is a 64 bits quad core cpus and support 8 watchdog.
>>> Update maximum ASPEED_CPUS_NUM to 4 and ASPEED_WDTS_NUM to 8.
>>> In addition, update AspeedSocState to support scuio, sli, sliio and intc.
>>>
>>> Add TYPE_ASPEED27X0_SOC machine type.
>>>
>>> The SDMC controller is unlocked at SPL stage.
>>> At present, only supports to emulate booting start from u-boot stage.
>>> Set SDMC controller unlocked by default.
>>>
>>> In INTC, each interrupt of INT 128 to INT 136 combines 32 interrupts.
>>> It connect GICINT IRQ GPIO-OUTPUT pins to GIC device with irq 128 to 136.
>>> And, if a device irq is 128 to 136, its irq GPIO-OUTPUT pin is
>>> connected to GICINT or-gates instead of GIC device.
>>>
>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>
>> Before I forget, please see a little comment below regarding user creatable
>> devices.
>>
>> The model looks fine. The interrupt controller part is more complex than the
>> previous SoCs so I will come back to it later when I have more time.
> Thanks for your kindly support.
>>> ---
>>>    hw/arm/aspeed_ast27x0.c     | 554
>> ++++++++++++++++++++++++++++++++++++
>>>    hw/arm/meson.build          |   1 +
>>>    include/hw/arm/aspeed_soc.h |  26 +-
>>>    3 files changed, 579 insertions(+), 2 deletions(-)
>>>    create mode 100644 hw/arm/aspeed_ast27x0.c
>>>
>>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c new
>>> file mode 100644 index 0000000000..754c963230
>>> --- /dev/null
>>> +++ b/hw/arm/aspeed_ast27x0.c
>>> @@ -0,0 +1,554 @@
>>> +/*
>>> + * ASPEED SoC 27x0 family
>>> + *
>>> + * Copyright (C) 2024 ASPEED Technology Inc.
>>> + *
>>> + * This code is licensed under the GPL version 2 or later.  See
>>> + * the COPYING file in the top-level directory.
>>> + *
>>> + * Implementation extracted from the AST2600 and adapted for AST27x0.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/misc/unimp.h"
>>> +#include "hw/arm/aspeed_soc.h"
>>> +#include "qemu/module.h"
>>> +#include "qemu/error-report.h"
>>> +#include "hw/i2c/aspeed_i2c.h"
>>> +#include "net/net.h"
>>> +#include "sysemu/sysemu.h"
>>> +#include "hw/intc/arm_gicv3.h"
>>> +#include "qapi/qmp/qlist.h"
>>> +
>>> +static const hwaddr aspeed_soc_ast2700_memmap[] = {
>>> +    [ASPEED_DEV_SPI_BOOT]  =  0x400000000,
>>> +    [ASPEED_DEV_SRAM]      =  0x10000000,
>>> +    [ASPEED_DEV_SDMC]      =  0x12C00000,
>>> +    [ASPEED_DEV_SCU]       =  0x12C02000,
>>> +    [ASPEED_DEV_SCUIO]     =  0x14C02000,
>>> +    [ASPEED_DEV_UART0]     =  0X14C33000,
>>> +    [ASPEED_DEV_UART1]     =  0X14C33100,
>>> +    [ASPEED_DEV_UART2]     =  0X14C33200,
>>> +    [ASPEED_DEV_UART3]     =  0X14C33300,
>>> +    [ASPEED_DEV_UART4]     =  0X12C1A000,
>>> +    [ASPEED_DEV_UART5]     =  0X14C33400,
>>> +    [ASPEED_DEV_UART6]     =  0X14C33500,
>>> +    [ASPEED_DEV_UART7]     =  0X14C33600,
>>> +    [ASPEED_DEV_UART8]     =  0X14C33700,
>>> +    [ASPEED_DEV_UART9]     =  0X14C33800,
>>> +    [ASPEED_DEV_UART10]    =  0X14C33900,
>>> +    [ASPEED_DEV_UART11]    =  0X14C33A00,
>>> +    [ASPEED_DEV_UART12]    =  0X14C33B00,
>>> +    [ASPEED_DEV_WDT]       =  0x14C37000,
>>> +    [ASPEED_DEV_VUART]     =  0X14C30000,
>>> +    [ASPEED_DEV_FMC]       =  0x14000000,
>>> +    [ASPEED_DEV_SPI0]      =  0x14010000,
>>> +    [ASPEED_DEV_SPI1]      =  0x14020000,
>>> +    [ASPEED_DEV_SPI2]      =  0x14030000,
>>> +    [ASPEED_DEV_SDRAM]     =  0x400000000,
>>> +    [ASPEED_DEV_MII1]      =  0x14040000,
>>> +    [ASPEED_DEV_MII2]      =  0x14040008,
>>> +    [ASPEED_DEV_MII3]      =  0x14040010,
>>> +    [ASPEED_DEV_ETH1]      =  0x14050000,
>>> +    [ASPEED_DEV_ETH2]      =  0x14060000,
>>> +    [ASPEED_DEV_ETH3]      =  0x14070000,
>>> +    [ASPEED_DEV_EMMC]      =  0x12090000,
>>> +    [ASPEED_DEV_INTC]      =  0x12100000,
>>> +    [ASPEED_DEV_SLI]       =  0x12C17000,
>>> +    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
>>> +    [ASPEED_GIC_DIST]      =  0x12200000,
>>> +    [ASPEED_GIC_REDIST]    =  0x12280000,
>>> +};
>>> +
>>> +#define AST2700_MAX_IRQ 288
>>> +
>>> +/* Shared Peripheral Interrupt values below are offset by -32 from
>>> +datasheet */ static const int aspeed_soc_ast2700_irqmap[] = {
>>> +    [ASPEED_DEV_UART0]     = 132,
>>> +    [ASPEED_DEV_UART1]     = 132,
>>> +    [ASPEED_DEV_UART2]     = 132,
>>> +    [ASPEED_DEV_UART3]     = 132,
>>> +    [ASPEED_DEV_UART4]     = 8,
>>> +    [ASPEED_DEV_UART5]     = 132,
>>> +    [ASPEED_DEV_UART6]     = 132,
>>> +    [ASPEED_DEV_UART7]     = 132,
>>> +    [ASPEED_DEV_UART8]     = 132,
>>> +    [ASPEED_DEV_UART9]     = 132,
>>> +    [ASPEED_DEV_UART10]    = 132,
>>> +    [ASPEED_DEV_UART11]    = 132,
>>> +    [ASPEED_DEV_UART12]    = 132,
>>> +    [ASPEED_DEV_FMC]       = 131,
>>> +    [ASPEED_DEV_SDMC]      = 0,
>>> +    [ASPEED_DEV_SCU]       = 12,
>>> +    [ASPEED_DEV_ADC]       = 130,
>>> +    [ASPEED_DEV_XDMA]      = 5,
>>> +    [ASPEED_DEV_EMMC]      = 15,
>>> +    [ASPEED_DEV_GPIO]      = 11,
>>> +    [ASPEED_DEV_GPIO_1_8V] = 130,
>>> +    [ASPEED_DEV_RTC]       = 13,
>>> +    [ASPEED_DEV_TIMER1]    = 16,
>>> +    [ASPEED_DEV_TIMER2]    = 17,
>>> +    [ASPEED_DEV_TIMER3]    = 18,
>>> +    [ASPEED_DEV_TIMER4]    = 19,
>>> +    [ASPEED_DEV_TIMER5]    = 20,
>>> +    [ASPEED_DEV_TIMER6]    = 21,
>>> +    [ASPEED_DEV_TIMER7]    = 22,
>>> +    [ASPEED_DEV_TIMER8]    = 23,
>>> +    [ASPEED_DEV_WDT]       = 131,
>>> +    [ASPEED_DEV_PWM]       = 131,
>>> +    [ASPEED_DEV_LPC]       = 128,
>>> +    [ASPEED_DEV_IBT]       = 128,
>>> +    [ASPEED_DEV_I2C]       = 130,
>>> +    [ASPEED_DEV_PECI]      = 133,
>>> +    [ASPEED_DEV_ETH1]      = 132,
>>> +    [ASPEED_DEV_ETH2]      = 132,
>>> +    [ASPEED_DEV_ETH3]      = 132,
>>> +    [ASPEED_DEV_HACE]      = 4,
>>> +    [ASPEED_DEV_KCS]       = 128,
>>> +    [ASPEED_DEV_DP]        = 28,
>>> +    [ASPEED_DEV_I3C]       = 131,
>>> +};
>>> +
>>> +/* GICINT 128 */
>>> +static const int aspeed_soc_ast2700_gic128_intcmap[] = {
>>> +    [ASPEED_DEV_LPC]       = 0,
>>> +    [ASPEED_DEV_IBT]       = 2,
>>> +    [ASPEED_DEV_KCS]       = 4,
>>> +};
>>> +
>>> +/* GICINT 130 */
>>> +static const int aspeed_soc_ast2700_gic130_intcmap[] = {
>>> +    [ASPEED_DEV_I2C]        = 0,
>>> +    [ASPEED_DEV_ADC]        = 16,
>>> +    [ASPEED_DEV_GPIO_1_8V]  = 18,
>>> +};
>>> +
>>> +/* GICINT 131 */
>>> +static const int aspeed_soc_ast2700_gic131_intcmap[] = {
>>> +    [ASPEED_DEV_I3C]       = 0,
>>> +    [ASPEED_DEV_WDT]       = 16,
>>> +    [ASPEED_DEV_FMC]       = 25,
>>> +    [ASPEED_DEV_PWM]       = 29,
>>> +};
>>> +
>>> +/* GICINT 132 */
>>> +static const int aspeed_soc_ast2700_gic132_intcmap[] = {
>>> +    [ASPEED_DEV_ETH1]      = 0,
>>> +    [ASPEED_DEV_ETH2]      = 1,
>>> +    [ASPEED_DEV_ETH3]      = 2,
>>> +    [ASPEED_DEV_UART0]     = 7,
>>> +    [ASPEED_DEV_UART1]     = 8,
>>> +    [ASPEED_DEV_UART2]     = 9,
>>> +    [ASPEED_DEV_UART3]     = 10,
>>> +    [ASPEED_DEV_UART5]     = 11,
>>> +    [ASPEED_DEV_UART6]     = 12,
>>> +    [ASPEED_DEV_UART7]     = 13,
>>> +    [ASPEED_DEV_UART8]     = 14,
>>> +    [ASPEED_DEV_UART9]     = 15,
>>> +    [ASPEED_DEV_UART10]    = 16,
>>> +    [ASPEED_DEV_UART11]    = 17,
>>> +    [ASPEED_DEV_UART12]    = 18,
>>> +};
>>> +
>>> +/* GICINT 133 */
>>> +static const int aspeed_soc_ast2700_gic133_intcmap[] = {
>>> +    [ASPEED_DEV_PECI]      = 4,
>>> +};
>>> +
>>> +/* GICINT 128 ~ 136 */
>>> +struct gic_intc_irq_info {
>>> +    int irq;
>>> +    const int *ptr;
>>> +};
>>> +
>>> +static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
>>> +    {128,  aspeed_soc_ast2700_gic128_intcmap},
>>> +    {129,  NULL},
>>> +    {130,  aspeed_soc_ast2700_gic130_intcmap},
>>> +    {131,  aspeed_soc_ast2700_gic131_intcmap},
>>> +    {132,  aspeed_soc_ast2700_gic132_intcmap},
>>> +    {133,  aspeed_soc_ast2700_gic133_intcmap},
>>> +    {134,  NULL},
>>> +    {135,  NULL},
>>> +    {136,  NULL},
>>> +};
>>> +
>>> +static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int
>>> +dev) {
>>> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
>>> +        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
>>> +            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
>>> +            return qdev_get_gpio_in(DEVICE(&a->intc.gicint_orgate[i]),
>>> +                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev]);
>>> +        }
>>> +    }
>>> +
>>> +    return qdev_get_gpio_in(a->intc.gic, sc->irqmap[dev]); }
>>> +
>>> +static void aspeed_soc_ast2700_init(Object *obj) {
>>> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(obj);
>>> +    AspeedSoCState *s = ASPEED_SOC(obj);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>> +    int i;
>>> +    char socname[8];
>>> +    char typename[64];
>>> +
>>> +    if (sscanf(sc->name, "%7s", socname) != 1) {
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    for (i = 0; i < sc->num_cpus; i++) {
>>> +        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
>>> +                                aspeed_soc_cpu_type(sc));
>>> +    }
>>> +
>>> +    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
>>> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
>>> +                         sc->silicon_rev);
>>> +    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
>>> +                              "hw-strap1");
>>> +    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
>>> +                              "hw-strap2");
>>> +    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>>> +                              "hw-prot-key");
>>> +
>>> +    object_initialize_child(obj, "scuio", &s->scuio,
>> TYPE_ASPEED_2700_SCUIO);
>>> +    qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
>>> +                         sc->silicon_rev);
>>> +
>>> +    snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
>>> +    object_initialize_child(obj, "fmc", &s->fmc, typename);
>>> +
>>> +    for (i = 0; i < sc->spis_num; i++) {
>>> +        snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i,
>> socname);
>>> +        object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
>>> +    }
>>> +
>>> +    snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>>> +    object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>>> +    object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
>>> +                              "ram-size");
>>> +
>>> +    for (i = 0; i < sc->wdts_num; i++) {
>>> +        snprintf(typename, sizeof(typename), "aspeed.wdt-%s",
>> socname);
>>> +        object_initialize_child(obj, "wdt[*]", &s->wdt[i], typename);
>>> +    }
>>> +
>>> +    for (i = 0; i < sc->macs_num; i++) {
>>> +        object_initialize_child(obj, "ftgmac100[*]", &s->ftgmac100[i],
>>> +                                TYPE_FTGMAC100);
>>> +
>>> +        object_initialize_child(obj, "mii[*]", &s->mii[i],
>> TYPE_ASPEED_MII);
>>> +    }
>>> +
>>> +    for (i = 0; i < sc->uarts_num; i++) {
>>> +        object_initialize_child(obj, "uart[*]", &s->uart[i],
>> TYPE_SERIAL_MM);
>>> +    }
>>> +
>>> +    object_initialize_child(obj, "sli", &s->sli, TYPE_ASPEED_2700_SLI);
>>> +    object_initialize_child(obj, "sliio", &s->sliio,
>> TYPE_ASPEED_2700_SLIIO);
>>> +    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_INTC);
>>> +}
>>> +
>>> +/*
>>> + * ASPEED ast2700 has 0x0 as cluster ID
>>> + *
>>> + *
>>> +https://developer.arm.com/documentation/100236/0100/register-descript
>>> +ions/aarch64-system-registers/multiprocessor-affinity-register--el1
>>> + */
>>> +static uint64_t aspeed_calc_affinity(int cpu) {
>>> +    return (0x0 << ARM_AFF1_SHIFT) | cpu; }
>>> +
>>> +static void aspeed_soc_ast2700_gic(DeviceState *dev, Error **errp) {
>>> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>>> +    AspeedSoCState *s = ASPEED_SOC(dev);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>> +    SysBusDevice *gicbusdev;
>>> +    QList *redist_region_count;
>>> +    int i;
>>> +
>>> +    a->intc.gic = qdev_new(gicv3_class_name());
>>> +    qdev_prop_set_uint32(a->intc.gic, "revision", 3);
>>> +    qdev_prop_set_uint32(a->intc.gic, "num-cpu", sc->num_cpus);
>>> +    qdev_prop_set_uint32(a->intc.gic, "num-irq", AST2700_MAX_IRQ);
>>> +
>>> +    redist_region_count = qlist_new();
>>> +    qlist_append_int(redist_region_count, sc->num_cpus);
>>> +    qdev_prop_set_array(a->intc.gic, "redist-region-count",
>>> +                            redist_region_count);
>>> +
>>> +    gicbusdev = SYS_BUS_DEVICE(a->intc.gic);
>>> +    sysbus_realize_and_unref(gicbusdev, errp);
>>> +    sysbus_mmio_map(gicbusdev, 0, sc->memmap[ASPEED_GIC_DIST]);
>>> +    sysbus_mmio_map(gicbusdev, 1, sc->memmap[ASPEED_GIC_REDIST]);
>>> +
>>> +    for (i = 0; i < sc->num_cpus; i++) {
>>> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
>>> +        int NUM_IRQS = 256, ARCH_GIC_MAINT_IRQ = 9,
>> VIRTUAL_PMU_IRQ = 7;
>>> +        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
>>> +
>>> +        const int timer_irq[] = {
>>> +            [GTIMER_PHYS] = 14,
>>> +            [GTIMER_VIRT] = 11,
>>> +            [GTIMER_HYP]  = 10,
>>> +            [GTIMER_SEC]  = 13,
>>> +        };
>>> +        int j;
>>> +
>>> +        for (j = 0; j < ARRAY_SIZE(timer_irq); j++) {
>>> +            qdev_connect_gpio_out(cpudev, j,
>>> +                    qdev_get_gpio_in(a->intc.gic, ppibase +
>> timer_irq[j]));
>>> +        }
>>> +
>>> +        qemu_irq irq = qdev_get_gpio_in(a->intc.gic,
>>> +                                        ppibase +
>> ARCH_GIC_MAINT_IRQ);
>>> +        qdev_connect_gpio_out_named(cpudev,
>> "gicv3-maintenance-interrupt",
>>> +                                    0, irq);
>>> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
>>> +                qdev_get_gpio_in(a->intc.gic, ppibase +
>>> + VIRTUAL_PMU_IRQ));
>>> +
>>> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev,
>> ARM_CPU_IRQ));
>>> +        sysbus_connect_irq(gicbusdev, i + sc->num_cpus,
>>> +                           qdev_get_gpio_in(cpudev,
>> ARM_CPU_FIQ));
>>> +        sysbus_connect_irq(gicbusdev, i + 2 * sc->num_cpus,
>>> +                           qdev_get_gpio_in(cpudev,
>> ARM_CPU_VIRQ));
>>> +        sysbus_connect_irq(gicbusdev, i + 3 * sc->num_cpus,
>>> +                           qdev_get_gpio_in(cpudev,
>> ARM_CPU_VFIQ));
>>> +    }
>>> +}
>>> +
>>> +static void aspeed_soc_ast2700_realize(DeviceState *dev, Error
>>> +**errp) {
>>> +    int i;
>>> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>>> +    AspeedSoCState *s = ASPEED_SOC(dev);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>> +    g_autofree char *sram_name = NULL;
>>> +
>>> +    /* Default boot region (SPI memory or ROMs) */
>>> +    memory_region_init(&s->spi_boot_container, OBJECT(s),
>>> +                       "aspeed.spi_boot_container", 0x400000000);
>>> +    memory_region_add_subregion(s->memory,
>> sc->memmap[ASPEED_DEV_SPI_BOOT],
>>> +                                &s->spi_boot_container);
>>> +
>>> +    /* CPU */
>>> +    for (i = 0; i < sc->num_cpus; i++) {
>>> +        object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
>>> +                                aspeed_calc_affinity(i),
>>> + &error_abort);
>>> +
>>> +        object_property_set_int(OBJECT(&a->cpu[i]), "cntfrq",
>> 1125000000,
>>> +                                &error_abort);
>>> +        object_property_set_link(OBJECT(&a->cpu[i]), "memory",
>>> +                                 OBJECT(s->memory),
>> &error_abort);
>>> +
>>> +        if (!qdev_realize(DEVICE(&a->cpu[i]), NULL, errp)) {
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    /* GIC */
>>> +    aspeed_soc_ast2700_gic(dev, errp);
>>
>> Hmm, we should return.
> This function return type is void.
> If I understand your request, do you mean do the following changes?
> 
> static bool aspeed_soc_ast2700_gic(DeviceState *dev, Error **errp) --> change return type bool
> {
>      ---
>      gicbusdev = SYS_BUS_DEVICE(a->intc.gic);
>      if(!sysbus_realize(gicbusdev, errp)) {
>          return false;
>      }
>      ---
>      return true;
> }
> 
> Then,
> /* GIC */
> if(!aspeed_soc_ast2700_gic(dev, errp)) {
>      return;
>      }


yes.


Thanks,

C.


> Thanks-Jamin
>>
>>> +
>>> +    /* INTC */
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc), errp)) {
>>> +        return;
>>> +    }
>>> +
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
>>> +                    sc->memmap[ASPEED_DEV_INTC]);
>>> +
>>> +    /* GICINT orgate -> INTC -> GIC */
>>> +    for (i = 0; i < ASPEED_INTC_NR_GICS; i++) {
>>> +        if (!qdev_realize(DEVICE(&a->intc.gicint_orgate[i]), NULL, errp)) {
>>> +            return;
>>> +        }
>>> +
>>> +        qdev_connect_gpio_out(DEVICE(&a->intc.gicint_orgate[i]), 0,
>>> +                              qdev_get_gpio_in(DEVICE(&a->intc),
>> i));
>>> +
>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
>>> +                           qdev_get_gpio_in(a->intc.gic,
>>> +
>> aspeed_soc_ast2700_gic_intcmap[i].irq));
>>> +    }
>>> +
>>> +    /* SRAM */
>>> +    sram_name = g_strdup_printf("aspeed.sram.%d",
>> CPU(&a->cpu[0])->cpu_index);
>>> +    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
>> sc->sram_size,
>>> +                                 errp)) {
>>> +        return;
>>> +    }
>>> +    memory_region_add_subregion(s->memory,
>>> +                                sc->memmap[ASPEED_DEV_SRAM],
>>> + &s->sram);
>>> +
>>> +    /* SCU */
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0,
>>> + sc->memmap[ASPEED_DEV_SCU]);
>>> +
>>> +    /* SCU1 */
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scuio), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scuio), 0,
>>> +                    sc->memmap[ASPEED_DEV_SCUIO]);
>>> +
>>> +    /* UART */
>>> +    if (!aspeed_soc_uart_realize(s, errp)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* FMC, The number of CS is set at the board level */
>>> +    object_property_set_link(OBJECT(&s->fmc), "dram",
>> OBJECT(s->dram_mr),
>>> +                             &error_abort);
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0,
>> sc->memmap[ASPEED_DEV_FMC]);
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
>>> +
>> ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
>>> +                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
>>> +
>>> +    /* Set up an alias on the FMC CE0 region (boot default) */
>>> +    MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
>>> +    memory_region_init_alias(&s->spi_boot, OBJECT(s),
>> "aspeed.spi_boot",
>>> +                             fmc0_mmio, 0,
>> memory_region_size(fmc0_mmio));
>>> +    memory_region_add_subregion(&s->spi_boot_container, 0x0,
>>> + &s->spi_boot);
>>> +
>>> +    /* SPI */
>>> +    for (i = 0; i < sc->spis_num; i++) {
>>> +        object_property_set_link(OBJECT(&s->spi[i]), "dram",
>>> +                                 OBJECT(s->dram_mr),
>> &error_abort);
>>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
>>> +            return;
>>> +        }
>>> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
>>> +                        sc->memmap[ASPEED_DEV_SPI0 + i]);
>>> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
>>> +
>> ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
>>> +    }
>>> +
>>> +    /*
>>> +     * SDMC - SDRAM Memory Controller
>>> +     * The SDMC controller is unlocked at SPL stage.
>>> +     * At present, only supports to emulate booting
>>> +     * start from u-boot stage. Set SDMC controller
>>> +     * unlocked by default. It is a temporarily solution.
>>> +     */
>>> +    object_property_set_bool(OBJECT(&s->sdmc), "unlocked", true,
>>> +                                 &error_abort);
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
>>> +                    sc->memmap[ASPEED_DEV_SDMC]);
>>> +
>>> +    /* RAM */
>>> +    if (!aspeed_soc_dram_init(s, errp)) {
>>> +        return;
>>> +    }
>>> +
>>> +    for (i = 0; i < sc->macs_num; i++) {
>>> +        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed",
>> true,
>>> +                                 &error_abort);
>>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
>>> +            return;
>>> +        }
>>> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>>> +                        sc->memmap[ASPEED_DEV_ETH1 + i]);
>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>>> +                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1
>> +
>>> + i));
>>> +
>>> +        object_property_set_link(OBJECT(&s->mii[i]), "nic",
>>> +                                 OBJECT(&s->ftgmac100[i]),
>> &error_abort);
>>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), errp)) {
>>> +            return;
>>> +        }
>>> +
>>> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->mii[i]), 0,
>>> +                        sc->memmap[ASPEED_DEV_MII1 + i]);
>>> +    }
>>> +
>>> +    /* Watch dog */
>>> +    for (i = 0; i < sc->wdts_num; i++) {
>>> +        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
>>> +        hwaddr wdt_offset = sc->memmap[ASPEED_DEV_WDT] + i *
>>> + awc->iosize;
>>> +
>>> +        object_property_set_link(OBJECT(&s->wdt[i]), "scu",
>> OBJECT(&s->scu),
>>> +                                 &error_abort);
>>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
>>> +            return;
>>> +        }
>>> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0,
>> wdt_offset);
>>> +    }
>>> +
>>> +    /* SLI */
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sli), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sli), 0,
>>> + sc->memmap[ASPEED_DEV_SLI]);
>>> +
>>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sliio), errp)) {
>>> +        return;
>>> +    }
>>> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sliio), 0,
>>> +                    sc->memmap[ASPEED_DEV_SLIIO]);
>>> +
>>> +    create_unimplemented_device("ast2700.dpmcu", 0x11000000,
>> 0x40000);
>>> +    create_unimplemented_device("ast2700.iomem0", 0x12000000,
>> 0x01000000);
>>> +    create_unimplemented_device("ast2700.iomem1", 0x14000000,
>> 0x01000000);
>>> +    create_unimplemented_device("ast2700.ltpi", 0x30000000,
>> 0x1000000);
>>> +    create_unimplemented_device("ast2700.io", 0x0, 0x4000000); }
>>> +
>>> +static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void
>>> +*data) {
>>> +    static const char * const valid_cpu_types[] = {
>>> +        ARM_CPU_TYPE_NAME("cortex-a35"),
>>> +        NULL
>>> +    };
>>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>>> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
>>> +
>>> +    dc->realize      = aspeed_soc_ast2700_realize;
>>
>>
>> Please add :
>>
>>       /* Reason: The Aspeed SoC can only be instantiated from a board */
>>       dc->user_creatable = false;
>>
>>
> Will add.
>> Thanks,
>>
>> C.
>>
>>
>>> +
>>> +    sc->name         = "ast2700-a0";
>>> +    sc->valid_cpu_types = valid_cpu_types;
>>> +    sc->silicon_rev  = AST2700_A0_SILICON_REV;
>>> +    sc->sram_size    = 0x20000;
>>> +    sc->spis_num     = 3;
>>> +    sc->wdts_num     = 8;
>>> +    sc->macs_num     = 1;
>>> +    sc->uarts_num    = 13;
>>> +    sc->num_cpus     = 4;
>>> +    sc->uarts_base   = ASPEED_DEV_UART0;
>>> +    sc->irqmap       = aspeed_soc_ast2700_irqmap;
>>> +    sc->memmap       = aspeed_soc_ast2700_memmap;
>>> +    sc->get_irq      = aspeed_soc_ast2700_get_irq;
>>> +}
>>> +
>>> +static const TypeInfo aspeed_soc_ast27x0_types[] = {
>>> +    {
>>> +        .name           = TYPE_ASPEED27X0_SOC,
>>> +        .parent         = TYPE_ASPEED_SOC,
>>> +        .instance_size  = sizeof(Aspeed27x0SoCState),
>>> +        .abstract       = true,
>>> +    }, {
>>> +        .name           = "ast2700-a0",
>>> +        .parent         = TYPE_ASPEED27X0_SOC,
>>> +        .instance_init  = aspeed_soc_ast2700_init,
>>> +        .class_init     = aspeed_soc_ast2700_class_init,
>>> +    },
>>> +};
>>> +
>>> +DEFINE_TYPES(aspeed_soc_ast27x0_types)
>>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
>>> 6808135c1f..1e3295a423 100644
>>> --- a/hw/arm/meson.build
>>> +++ b/hw/arm/meson.build
>>> @@ -46,6 +46,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
>> files(
>>>      'aspeed_soc_common.c',
>>>      'aspeed_ast2400.c',
>>>      'aspeed_ast2600.c',
>>> +  'aspeed_ast27x0.c',
>>>      'aspeed_ast10x0.c',
>>>      'aspeed_eeprom.c',
>>>      'fby35.c'))
>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>>> index c60fac900a..9f177b6037 100644
>>> --- a/include/hw/arm/aspeed_soc.h
>>> +++ b/include/hw/arm/aspeed_soc.h
>>> @@ -15,6 +15,7 @@
>>>    #include "hw/cpu/a15mpcore.h"
>>>    #include "hw/arm/armv7m.h"
>>>    #include "hw/intc/aspeed_vic.h"
>>> +#include "hw/intc/aspeed_intc.h"
>>>    #include "hw/misc/aspeed_scu.h"
>>>    #include "hw/adc/aspeed_adc.h"
>>>    #include "hw/misc/aspeed_sdmc.h"
>>> @@ -26,6 +27,7 @@
>>>    #include "hw/ssi/aspeed_smc.h"
>>>    #include "hw/misc/aspeed_hace.h"
>>>    #include "hw/misc/aspeed_sbc.h"
>>> +#include "hw/misc/aspeed_sli.h"
>>>    #include "hw/watchdog/wdt_aspeed.h"
>>>    #include "hw/net/ftgmac100.h"
>>>    #include "target/arm/cpu.h"
>>> @@ -41,8 +43,8 @@
>>>
>>>    #define ASPEED_SPIS_NUM  2
>>>    #define ASPEED_EHCIS_NUM 2
>>> -#define ASPEED_WDTS_NUM  4
>>> -#define ASPEED_CPUS_NUM  2
>>> +#define ASPEED_WDTS_NUM  8
>>> +#define ASPEED_CPUS_NUM  4
>>>    #define ASPEED_MACS_NUM  4
>>>    #define ASPEED_UARTS_NUM 13
>>>    #define ASPEED_JTAG_NUM  2
>>> @@ -61,6 +63,7 @@ struct AspeedSoCState {
>>>        AspeedI2CState i2c;
>>>        AspeedI3CState i3c;
>>>        AspeedSCUState scu;
>>> +    AspeedSCUState scuio;
>>>        AspeedHACEState hace;
>>>        AspeedXDMAState xdma;
>>>        AspeedADCState adc;
>>> @@ -68,6 +71,8 @@ struct AspeedSoCState {
>>>        AspeedSMCState spi[ASPEED_SPIS_NUM];
>>>        EHCISysBusState ehci[ASPEED_EHCIS_NUM];
>>>        AspeedSBCState sbc;
>>> +    AspeedSLIState sli;
>>> +    AspeedSLIState sliio;
>>>        MemoryRegion secsram;
>>>        UnimplementedDeviceState sbc_unimplemented;
>>>        AspeedSDMCState sdmc;
>>> @@ -117,6 +122,16 @@ struct Aspeed2600SoCState {
>>>    #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
>>>    OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState,
>> ASPEED2600_SOC)
>>>
>>> +struct Aspeed27x0SoCState {
>>> +    AspeedSoCState parent;
>>> +
>>> +    ARMCPU cpu[ASPEED_CPUS_NUM];
>>> +    AspeedINTCState intc;
>>> +};
>>> +
>>> +#define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SoCState, ASPEED27X0_SOC)
>>> +
>>>    struct Aspeed10x0SoCState {
>>>        AspeedSoCState parent;
>>>
>>> @@ -168,11 +183,13 @@ enum {
>>>        ASPEED_DEV_UART13,
>>>        ASPEED_DEV_VUART,
>>>        ASPEED_DEV_FMC,
>>> +    ASPEED_DEV_SPI0,
>>>        ASPEED_DEV_SPI1,
>>>        ASPEED_DEV_SPI2,
>>>        ASPEED_DEV_EHCI1,
>>>        ASPEED_DEV_EHCI2,
>>>        ASPEED_DEV_VIC,
>>> +    ASPEED_DEV_INTC,
>>>        ASPEED_DEV_SDMC,
>>>        ASPEED_DEV_SCU,
>>>        ASPEED_DEV_ADC,
>>> @@ -222,6 +239,11 @@ enum {
>>>        ASPEED_DEV_JTAG1,
>>>        ASPEED_DEV_FSI1,
>>>        ASPEED_DEV_FSI2,
>>> +    ASPEED_DEV_SCUIO,
>>> +    ASPEED_DEV_SLI,
>>> +    ASPEED_DEV_SLIIO,
>>> +    ASPEED_GIC_DIST,
>>> +    ASPEED_GIC_REDIST,
>>>    };
>>>
>>>    qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
> 


