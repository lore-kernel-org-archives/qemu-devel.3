Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A651BE75448
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYML2-0006Vt-Va; Wed, 24 Dec 2025 05:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYML0-0006VQ-IY
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:43:26 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMKy-0006Qi-KN
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:43:26 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.107])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dbpPk1HZrz5xdL;
 Wed, 24 Dec 2025 10:43:22 +0000 (UTC)
Received: from DAG3EX1.mxp5.local (172.16.2.21) by DAG5EX2.mxp5.local
 (172.16.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:43:21 +0100
Received: from kaod.org (37.59.142.105) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:43:21 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006e2d09ea9-d9db-4649-baee-44388beffc1a,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <473d4888-83fb-4eb8-8487-14c2521fc331@kaod.org>
Date: Wed, 24 Dec 2025 11:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-19-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251224014203.756264-19-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 64ec9a08-e402-466a-9c48-9d19512b1a9f
X-Ovh-Tracer-Id: 14107807309145082869
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEMC2SQto1uGx8hmbF0Hh8A3zBTH6ZJLojUZXyswecNuQxMarCK/kN0euvZw4RwkiIdIhgW1qDaRwscfqly4hqDn/YtHUSY/eKIX3denPLWnogsA5gzHbtzyl00WssrNuzvVg/6DXCSmFaS24IQ36G3clF4SPbHLSqKv15ZcdCM3cBIxWG585Em6smijhIAkUat6zR4XuouJOlonIdQlQyKSWsrwFiGHNsWhfqo4LmRUlKiL6bEY0KAqJbMtfose3HvSi85JCcdMp0gE4pbBpU0jyBTLbMQNNQ2Ocb1b5JOAqGCLlqsdJe+l9mPjDA+tVwyQlZ2xKVcKBfjE32UAbhvs7P1UOd6eAVXVoXMTojCZoUwEXNLws+gvF1Y4Bzm8Ha/xQDsCNGTy7cVzuL6Iv7qlqnu2mqowEz64YfQPSiYdxuE/fU4cuUSjP39bXAtLN8dR2BCrilPhVI8g/6qgRJJ9fE9nvxWAWr0D9u3IBh7gfG54O5Rr/01x7lwaOn6iDpJlopnpJJxwv9kOj0d/JGzETZqb1yGVohCKm8jiaSB++GdbTUTSwEseGT//qMwB7BG/wlcqMSwxEPN2nKUQ40ZrghrpvYfk1iW4fjvWK+0x4EkBb82b4ZqlMW5RQqnhZ8KpBU3CopxzzT+sRbqGZ2uRRu9hhZesvBiZ0msx1lJkw
DKIM-Signature: a=rsa-sha256; bh=nEqr/UaAJN/ek4VAVvKAc8HmkpaBTyGEbOHXMn17a8U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766573002; v=1;
 b=HJXsM7rr3O4ox5qzvjddkGFr4dr6R+LwgpXSMgB68nGsPX7dV978gWbIimce7i8rRrNo2WJO
 rHg7Is+6oB5qJYnQQ23yZj0XfhusxsEhQRE/ODeycPNaTDhnCuaEXvsVn+bdhsgoROG3JCWJiGN
 +VTL9xSpHcEVac33gs68kc2NjwvIqeLXma/RiGNeX5ZSO+T/ooYVJSjmH/zI79oVglB4ybhw8FL
 T6HA0PXO+n9esQ5/3v4Sxa/ZkOtLWo/trTQrzKSyp/qt17N3W8mi4Mn9hyb7K4+eZ+8O4aPOeH8
 s4l/vfTNE/4UlOjj7o7T5C7iQaesaT2DMefoL84k7iK/g==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=clg@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> AST1700 exposes more I3C buses than the current dummy I3C model
> provides. When Linux probes the I3C devices on AST1700 this mismatch
> can trigger a kernel panic. Model the I3C block as an unimplemented
> device to make the missing functionality explicit and avoid unexpected
> side effects.
> 
> This wires up the I3C interrupt lines for the IO expanders and adds the
> corresponding device entries for the AST1700 model.
> 
> No functional I3C emulation is provided yet; this only prevents crashes and
> documents the missing piece.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   include/hw/arm/aspeed_ast1700.h |  3 +++
>   include/hw/arm/aspeed_soc.h     |  2 ++
>   hw/arm/aspeed_ast1700.c         | 15 +++++++++++++++
>   hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
>   4 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index 490f2a3b05..874b4d63fe 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -19,6 +19,7 @@
>   #include "hw/ssi/aspeed_smc.h"
>   #include "hw/watchdog/wdt_aspeed.h"
>   #include "hw/char/serial-mm.h"
> +#include "hw/misc/unimp.h"
>   
>   #define AST1700_SGPIO_NUM            2
>   #define AST1700_WDT_NUM              9
> @@ -45,6 +46,8 @@ struct AspeedAST1700SoCState {
>       AspeedI2CState i2c;
>       AspeedPWMState pwm;
>       AspeedWDTState wdt[AST1700_WDT_NUM];
> +
> +    UnimplementedDeviceState i3c;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 4ea2521041..b185b04186 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -294,6 +294,8 @@ enum {
>       ASPEED_DEV_IOEXP1_I2C,
>       ASPEED_DEV_IOEXP0_INTCIO,
>       ASPEED_DEV_IOEXP1_INTCIO,
> +    ASPEED_DEV_IOEXP0_I3C,
> +    ASPEED_DEV_IOEXP1_I3C,
>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index ca0ce4e2c2..5f3c56e6cc 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -15,6 +15,7 @@
>   
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
>   #define AST1700_SOC_SRAM_SIZE        0x00040000
> +#define AST1700_SOC_I3C_SIZE         0x00010000
>   
>   enum {
>       ASPEED_AST1700_DEV_SPI0,
> @@ -26,6 +27,7 @@ enum {
>       ASPEED_AST1700_DEV_SGPIOM0,
>       ASPEED_AST1700_DEV_SGPIOM1,
>       ASPEED_AST1700_DEV_I2C,
> +    ASPEED_AST1700_DEV_I3C,
>       ASPEED_AST1700_DEV_UART12,
>       ASPEED_AST1700_DEV_LTPI_CTRL,
>       ASPEED_AST1700_DEV_WDT,
> @@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
>       [ASPEED_AST1700_DEV_SGPIOM0]   =  0x00C0C000,
>       [ASPEED_AST1700_DEV_SGPIOM1]   =  0x00C0D000,
>       [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
> +    [ASPEED_AST1700_DEV_I3C]       =  0x00C20000,
>       [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>       [ASPEED_AST1700_DEV_WDT]       =  0x00C37000,
> @@ -172,6 +175,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
>       }
>   
> +    /* I3C */
> +    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
> +    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
> +    memory_region_add_subregion_overlap(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0),
> +                        -1000);
>   }
>   
>   static void aspeed_ast1700_instance_init(Object *obj)
> @@ -221,6 +232,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>                                   &s->wdt[i], "aspeed.wdt-ast2700");
>       }
>   
> +    /* I3C */
> +    object_initialize_child(obj, "ioexp-i3c[*]", &s->i3c,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +
>       return;
>   }
>   
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index ca3adf9a50..0807481162 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -206,7 +206,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_PECI]      = 197,
>       [ASPEED_DEV_SDHCI]     = 197,
>       [ASPEED_DEV_IOEXP0_I2C] = 198,
> +    [ASPEED_DEV_IOEXP0_I3C] = 199,
>       [ASPEED_DEV_IOEXP1_I2C] = 200,
> +    [ASPEED_DEV_IOEXP1_I3C] = 201,
>   };
>   
>   /* GICINT 128 */
> @@ -275,12 +277,24 @@ static const int ast2700_gic198_intcmap[] = {
>       [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
>   };
>   
> +/* Primary AST1700 Interrupts */
> +/* A1: GINTC 199 */
> +static const int ast2700_gic199_intcmap[] = {
> +    [ASPEED_DEV_IOEXP0_I3C]       = 0, /* 0 - 15 */
> +};
> +
>   /* Secondary AST1700 Interrupts */
>   /* A1: GINTC 200 */
>   static const int ast2700_gic200_intcmap[] = {
>       [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
>   };
>   
> +/* Secondary AST1700 Interrupts */
> +/* A1: GINTC 201 */
> +static const int ast2700_gic201_intcmap[] = {
> +    [ASPEED_DEV_IOEXP1_I3C]       = 0, /* 0 - 15 */
> +};
> +
>   /* GICINT 128 ~ 136 */
>   /* GICINT 192 ~ 201 */
>   struct gic_intc_irq_info {
> @@ -298,9 +312,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
>       {196, 1, 4, ast2700_gic132_gic196_intcmap},
>       {197, 1, 5, ast2700_gic133_gic197_intcmap},
>       {198, 2, 0, ast2700_gic198_intcmap},
> -    {199, 1, 7, NULL},
> +    {199, 2, 1, ast2700_gic199_intcmap},
>       {200, 3, 0, ast2700_gic200_intcmap},
> -    {201, 1, 9, NULL},
> +    {201, 3, 1, ast2700_gic201_intcmap},
>       {128, 0, 1, ast2700_gic128_gic192_intcmap},
>       {129, 0, 2, NULL},
>       {130, 0, 3, ast2700_gic130_gic194_intcmap},


