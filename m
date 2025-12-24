Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45493E7544E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 11:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMfu-0003Tf-Ky; Wed, 24 Dec 2025 06:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMfs-0003TD-F8
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:05:01 -0500
Received: from 4.mo552.mail-out.ovh.net ([178.33.43.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMfp-00054u-Ol
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:05:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.159])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dbptY6Yxbz6Nb7;
 Wed, 24 Dec 2025 11:04:53 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 12:04:53 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001713c906a-b92d-46d0-9114-3f76a80d70d5,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <4b68bc54-6968-4e95-a2ea-0d34b20e59f8@kaod.org>
Date: Wed, 24 Dec 2025 12:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251224014203.756264-15-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: e8092ca3-c195-42b8-8bb8-45d77bce000a
X-Ovh-Tracer-Id: 14471472978063625205
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGPC+Atz87I/uFW2hSawbgC4PBETeqbZ8POCVJngLm3VOOYJdeCPHCeuLc7qKszoTwrrUPqmPL5EKSMPKobzwMOEyu1aX0RnH/k8KXDHPQTYSabL/RmlIBO3oRE2UDPRbp7xLRlmm4GB+TB0Qv4GpdpUrD6kN1eodLEN89Q4Pw/wS1J6V2CJZx7q3AyTfDgF8XLHV0DsT3CZphTI214A16ndAh0PZkJsqU+YvMwxOgjhM6bA35I74lKxwd3ffbBgk+QoVETLTbUD7eJuroLS6NNL7TmOGQSqsk1ZEIqYsF8IGPuM1gJpNl8iEStyxeszeJ8CNoQYYRT4AHt+ifH0/BoBooGVEPj6C/c309cgshkkZ0CFDsKSmhIcKZmHh5zPG94fgus9aoqpsk0vphZQua0d7W9dEgFpP+RJb4yB8H/S+ehHbU80hfnhWLmdqO546fSxEmUreDTnFMcq7ZjtdZOffdFOiCtI87UzTIhDkhhGglhMmKns5T6uJ7K91BB8VKwD0huzuaARx4F6LDEJ5X8yPrYEFTfPshUQEVP+5Txb7QDZelIobnufCXY6B5neOkSWWtijTJrl425Obgrzjvr27eO/bbI3DHPruAhp7irxHmotNHwHUtpbXBQTYKuV9u3+hbLlfm9HvNC6uhvcL08KHq8yh5xd1NDJfb3sKamUw
DKIM-Signature: a=rsa-sha256; bh=1EWe7Mj9CQLewDT8vxvz7g/5Qokr4hh7Ko07XYkOJbg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766574294; v=1;
 b=NBlunWUlIBpTAezVXiVtbSn6x1Y8bDsutSsF7iuzNuGJ40lBmouoOMOj5v20nzzDk3EH8Yik
 id4Lb68CJAyPItXF6hqLr3nonri/rzaivNDRKdZsA6YIQ0hA8p4uausZs7mHPPAKavHjqE1TnaN
 QZWbOoxWHKatbZeCMjvP+j4gt+WtGVJ5JYS9kw6uOG7TaOJ85hwbBvy/jMzjV+buoEa6x5kzr6M
 qYMhHQib0mz4tgk84JruplsR+xGIie9s1Fg3Bcchhd686pyZx6zPZqxGCiS50sppJ0BFttpI9T7
 0gsuO828o5C7IjhRiu5PYGcT0EJ+YjaR8V69dzVDyjTSg==
Received-SPF: pass client-ip=178.33.43.201; envelope-from=clg@kaod.org;
 helo=4.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/24/25 02:41, Kane Chen via wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the I2C controller to the AST1700 model by mapping its MMIO
> region and wiring its interrupt line.
> 
> This patch also adds a bus_label property to distinguish I2C buses on
> the BMC from those on external boards. This prevents user-specified
> I2C devices from being attached to the wrong bus when provided via CLI.

This patch does 2 things. Please split the changes and provide an
example of the bus name in the commit log.

I think we should add documentation for the IO expander and mention
the I2C bus names too.

Thanks,

C.

> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  2 ++
>   include/hw/arm/aspeed_soc.h     |  2 ++
>   include/hw/i2c/aspeed_i2c.h     |  1 +
>   hw/arm/aspeed_ast1700.c         | 18 ++++++++++++
>   hw/arm/aspeed_ast27x0.c         | 51 +++++++++++++++++++++++++++++++--
>   hw/i2c/aspeed_i2c.c             | 19 ++++++++++--
>   6 files changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index 7ea6ff4c1a..d4b7abee7d 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -12,6 +12,7 @@
>   #include "hw/misc/aspeed_scu.h"
>   #include "hw/adc/aspeed_adc.h"
>   #include "hw/gpio/aspeed_gpio.h"
> +#include "hw/i2c/aspeed_i2c.h"
>   #include "hw/misc/aspeed_ltpi.h"
>   #include "hw/ssi/aspeed_smc.h"
>   #include "hw/char/serial-mm.h"
> @@ -34,6 +35,7 @@ struct AspeedAST1700SoCState {
>       AspeedADCState adc;
>       AspeedSCUState scu;
>       AspeedGPIOState gpio;
> +    AspeedI2CState i2c;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index b051d0eb3a..4ea2521041 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -290,6 +290,8 @@ enum {
>       ASPEED_DEV_LTPI_CTRL2,
>       ASPEED_DEV_LTPI_IO0,
>       ASPEED_DEV_LTPI_IO1,
> +    ASPEED_DEV_IOEXP0_I2C,
> +    ASPEED_DEV_IOEXP1_I2C,
>       ASPEED_DEV_IOEXP0_INTCIO,
>       ASPEED_DEV_IOEXP1_INTCIO,
>   };
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 2daacc10ce..babbad5ed9 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -269,6 +269,7 @@ struct AspeedI2CState {
>       uint32_t intr_status;
>       uint32_t ctrl_global;
>       uint32_t new_clk_divider;
> +    char *bus_label;
>       MemoryRegion pool_iomem;
>       uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
>   
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 9a6019908e..fad3b86e8d 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -22,6 +22,7 @@ enum {
>       ASPEED_AST1700_DEV_ADC,
>       ASPEED_AST1700_DEV_SCU,
>       ASPEED_AST1700_DEV_GPIO,
> +    ASPEED_AST1700_DEV_I2C,
>       ASPEED_AST1700_DEV_UART12,
>       ASPEED_AST1700_DEV_LTPI_CTRL,
>       ASPEED_AST1700_DEV_SPI0_MEM,
> @@ -33,6 +34,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
>       [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
>       [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
>       [ASPEED_AST1700_DEV_GPIO]      =  0x00C0B000,
> +    [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
>       [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>       [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
> @@ -108,6 +110,18 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
>   
> +    /* I2C */
> +    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);
> +    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);
> +    object_property_set_link(OBJECT(&s->i2c), "dram",
> +                             OBJECT(&s->iomem), errp);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0));
> +
>       /* LTPI controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>           return;
> @@ -141,6 +155,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       object_initialize_child(obj, "ioexp-gpio[*]", &s->gpio,
>                               "aspeed.gpio-ast2700");
>   
> +    /* I2C */
> +    object_initialize_child(obj, "ioexp-i2c[*]", &s->i2c,
> +                            "aspeed.i2c-ast2700");
> +
>       /* LTPI controller */
>       object_initialize_child(obj, "ltpi-ctrl",
>                               &s->ltpi, TYPE_ASPEED_LTPI);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index d998326536..ca3adf9a50 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -205,6 +205,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_ETH3]      = 196,
>       [ASPEED_DEV_PECI]      = 197,
>       [ASPEED_DEV_SDHCI]     = 197,
> +    [ASPEED_DEV_IOEXP0_I2C] = 198,
> +    [ASPEED_DEV_IOEXP1_I2C] = 200,
>   };
>   
>   /* GICINT 128 */
> @@ -267,6 +269,18 @@ static const int ast2700_gic133_gic197_intcmap[] = {
>       [ASPEED_DEV_PECI]      = 4,
>   };
>   
> +/* Primary AST1700 Interrupts */
> +/* A1: GICINT 198 */
> +static const int ast2700_gic198_intcmap[] = {
> +    [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
> +};
> +
> +/* Secondary AST1700 Interrupts */
> +/* A1: GINTC 200 */
> +static const int ast2700_gic200_intcmap[] = {
> +    [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
> +};
> +
>   /* GICINT 128 ~ 136 */
>   /* GICINT 192 ~ 201 */
>   struct gic_intc_irq_info {
> @@ -283,9 +297,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
>       {195, 1, 3, ast2700_gic131_gic195_intcmap},
>       {196, 1, 4, ast2700_gic132_gic196_intcmap},
>       {197, 1, 5, ast2700_gic133_gic197_intcmap},
> -    {198, 1, 6, NULL},
> +    {198, 2, 0, ast2700_gic198_intcmap},
>       {199, 1, 7, NULL},
> -    {200, 1, 8, NULL},
> +    {200, 3, 0, ast2700_gic200_intcmap},
>       {201, 1, 9, NULL},
>       {128, 0, 1, ast2700_gic128_gic192_intcmap},
>       {129, 0, 2, NULL},
> @@ -327,14 +341,23 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
>       int or_idx;
>       int idx;
>       int i;
> +    OrIRQState *porgates;
>   
>       for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
>           if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
>               assert(ast2700_gic_intcmap[i].ptr);
>               or_idx = ast2700_gic_intcmap[i].orgate_idx;
>               idx = ast2700_gic_intcmap[i].intc_idx;
> -            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
> +            if (idx < ASPEED_INTC_NUM) {
> +                porgates = &a->intc[idx].orgates[or_idx];
> +                return qdev_get_gpio_in(DEVICE(porgates),
> +                                    ast2700_gic_intcmap[i].ptr[dev] + index);
> +            } else {
> +                idx -= ASPEED_INTC_NUM;
> +                porgates = &a->intcioexp[idx].orgates[or_idx];
> +                return qdev_get_gpio_in(DEVICE(porgates),
>                                       ast2700_gic_intcmap[i].ptr[dev] + index);
> +            }
>           }
>       }
>   
> @@ -1098,6 +1121,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   
>       /* IO Expander */
>       for (i = 0; i < sc->ioexp_num; i++) {
> +        AspeedI2CClass *i2c_ctl;
> +
>           qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
>               return;
> @@ -1128,6 +1153,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,
>                              aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
>   
> +        /* I2C */
> +        i2c_ctl = ASPEED_I2C_GET_CLASS(&s->ioexp[i].i2c);
> +        for (int j = 0; j < i2c_ctl->num_busses; j++) {
> +            /*
> +             * For I2C on AST1700:
> +             * I2C bus interrupts are connected to the OR gate from bit 0 to bit
> +             * 15, and the OR gate output pin is connected to the input pin of
> +             * GICINT192 of IO expander Interrupt controller (INTC2/3). Then,
> +             * the output pin is connected to the INTC (CPU Die) input pin, and
> +             * its output pin is connected to the GIC.
> +             *
> +             * I2C bus 0 is connected to the OR gate at bit 0.
> +             * I2C bus 15 is connected to the OR gate at bit 15.
> +             */
> +            irq = aspeed_soc_ast2700_get_irq_index(s,
> +                                                   ASPEED_DEV_IOEXP0_I2C + i,
> +                                                   j);
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].i2c.busses[j]),
> +                               0, irq);
> +        }
>       }
>   
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 83fb906bdc..ca84068bb4 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1261,6 +1261,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>   static const Property aspeed_i2c_properties[] = {
>       DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
>   };
>   
>   static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
> @@ -1421,14 +1422,28 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
>       AspeedI2CClass *aic;
> -    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
> -    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
> +    g_autofree char *name = NULL;
> +    g_autofree char *pool_name = NULL;
>   
>       if (!s->controller) {
>           error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
>           return;
>       }
>   
> +    /*
> +     * I2C bus naming:
> +     *   - Empty bus_label -> BMC internal controller, use default name.
> +     *   - Non-empty bus_label -> external/addon controller, prefix with label
> +     *     to avoid conflicts and show bus origin.
> +     */
> +    if (!s->controller->bus_label || (strlen(s->controller->bus_label) == 0)) {
> +        name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
> +    } else {
> +        name = g_strdup_printf("aspeed.%s.i2c.bus.%d",
> +                               s->controller->bus_label, s->id);
> +    }
> +    pool_name = g_strdup_printf("%s.pool", name);
> +
>       aic = ASPEED_I2C_GET_CLASS(s->controller);
>   
>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);


