Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C61E83EF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYON-0007iN-OW; Wed, 04 Feb 2026 03:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYOG-0007Vo-7M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:37:37 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYOE-0006WD-3Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:37:35 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.248])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f5Yd76NxZz5vrd;
 Wed,  4 Feb 2026 08:37:31 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 4 Feb
 2026 09:37:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0020a4b3b63-77b3-4ef8-9f0e-df89df35e004,
 E481ED796CD1A7AD002472F698DA8951F44CEEA4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <04c83392-6dd9-4855-9ddd-e2afe5bf6871@kaod.org>
Date: Wed, 4 Feb 2026 09:37:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/22] hw/arm/aspeed: attach I2C device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
 <20260204082113.3955407-15-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260204082113.3955407-15-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: e5fa1796-e08e-4913-8bc4-c01ca9b4ced4
X-Ovh-Tracer-Id: 381398595244362741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEESgEOio85QnwyRBwra+GjqJhmQkLH8qBORIb0kl8hv7fW429pEir+qNnfZkFL9/IwqgETW+1ArqsZlNE18Usm6y5m+0GSZ7WQeKCD+0hadA8NFqxe6SqypdV3CVWNvoZxomfTTXZuu6q27BBGbYZqnLMpfcoglenrsYKNbZdL25D7sOZMoU1uh90jbzm2AM0rimOGlcZnkunIBkA3YX+vfH3RMdQL3zKit6RMxpvmTsUVy/yPvf55FdFPtIu2O1o6nhIlLH5OQDIq7fKyYjnsAXIw/wtRtegeZlZVj++sg0tUotSsq798fpMHoSz+gt+Z3kN/Vo55Yl+dBnxvWDIqGRrG91288PSmcd7pS2pSAtAhkKVw1WSxfAmrbCOOxEf8sVF0QDOZZKLODErRnxqPcbVkEMLTrvVaQo2g8nJ/IhWXBcvL5Z38dlwqAG0rpAkXmd2LuCyt9rQ8MAJ6DYqDhPcRHSFbf6M7jVr7gwzDfgyF3OCvTZfxVJ4o7+Q0QpvbQyflqKLIGKwSDnhl6yUjHJJyjMjay9vW4MkCfDfHn0qfDUgFgZIAf6aeCdMCtwgl+TTppW/CARoRWa0QB8iMjrGLU+MR8nWHrrVOZc7rBRbbo1mMvUs41iAWfUZ8xuyMiGXMGWjysLcgTZKoVh8zSzQiZu4mbMQ01htEzfsusg
DKIM-Signature: a=rsa-sha256; bh=/w9RO8xpQJVxgmUNSJWXpLsAgZZDNMktl1yggHlGrJM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770194252; v=1;
 b=lAbjavWDP/QH9Qh8RMwjVWmZHZM+R5Ae+xH/kAm3PnUxpNSEcjCjCdPCih+CkqX/724k+59w
 +O/2YvfUy3EdlyCIsgzr1B3ZRv1cqQGwZtGPZuHB5Q2J6369f25kgCi2Kt5Fo6yuNX8LhxZsJZB
 hjorkBpDJZVazbbKTg1+10U31t350ZsSsGK62fXE7VBohLjPj8qZtnsKqiKCDa1weC6p5t/V2S9
 Qwl4HKOKJKdXiUeTNFYjQRa0BrnsX+xLtm1Sg+U4UaC42kVlFLmWYcT/cr9OAtXG497VLbGlZ2/
 fRBvFB9kCRZX5ugdTDlLNiMDee8sJnIK92LcP6XU1pPOQ==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/4/26 09:21, Kane Chen wrote:
> Connect the I2C controller to the AST1700 model by mapping its MMIO
> region and wiring its interrupt line.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/hw/arm/aspeed_ast1700.h |  2 ++
>   include/hw/arm/aspeed_soc.h     |  2 ++
>   hw/arm/aspeed_ast1700.c         | 19 ++++++++++++
>   hw/arm/aspeed_ast27x0.c         | 51 +++++++++++++++++++++++++++++++--
>   4 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index 63cfcb4c24..1005ce6364 100644
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
> @@ -35,6 +36,7 @@ struct AspeedAST1700SoCState {
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
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 7efce450f6..e264b2200b 100644
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
> @@ -113,6 +115,19 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
>   
> +    /* I2C */
> +    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);
> +    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);
> +
> +    object_property_set_link(OBJECT(&s->i2c), "dram",
> +                             OBJECT(s->dram_mr), errp);
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
> @@ -146,6 +161,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       object_initialize_child(obj, "ioexp-gpio", &s->gpio,
>                               "aspeed.gpio-ast2700");
>   
> +    /* I2C */
> +    object_initialize_child(obj, "ioexp-i2c", &s->i2c,
> +                            "aspeed.i2c-ast2700");
> +
>       /* LTPI controller */
>       object_initialize_child(obj, "ltpi-ctrl",
>                               &s->ltpi, TYPE_ASPEED_LTPI);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index cd4028fcd4..8242258df4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -157,6 +157,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_EHCI4]     = 196,
>       [ASPEED_DEV_PECI]      = 197,
>       [ASPEED_DEV_SDHCI]     = 197,
> +    [ASPEED_DEV_IOEXP0_I2C] = 198,
> +    [ASPEED_DEV_IOEXP1_I2C] = 200,
>   };
>   
>   /* GICINT 192 */
> @@ -213,6 +215,18 @@ static const int ast2700_gic197_intcmap[] = {
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
>   /* GICINT 192 ~ 201 */
>   struct gic_intc_irq_info {
>       int irq;
> @@ -228,9 +242,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
>       {195, 1, 3, ast2700_gic195_intcmap},
>       {196, 1, 4, ast2700_gic196_intcmap},
>       {197, 1, 5, ast2700_gic197_intcmap},
> -    {198, 1, 6, NULL},
> +    {198, 2, 0, ast2700_gic198_intcmap},
>       {199, 1, 7, NULL},
> -    {200, 1, 8, NULL},
> +    {200, 3, 0, ast2700_gic200_intcmap},
>       {201, 1, 9, NULL},
>   };
>   
> @@ -263,14 +277,23 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
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
> @@ -1025,6 +1048,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   
>       /* IO Expander */
>       for (i = 0; i < sc->ioexp_num; i++) {
> +        AspeedI2CClass *i2c_ctl;
> +
>           qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
>           object_property_set_link(OBJECT(&s->ioexp[i]), "dram",
>                                    OBJECT(s->dram_mr), &error_abort);
> @@ -1057,6 +1082,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
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


