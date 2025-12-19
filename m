Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFBDD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdva-0003Qi-G4; Fri, 19 Dec 2025 12:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWdvN-000397-TK; Fri, 19 Dec 2025 12:05:55 -0500
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWdvL-0008UQ-60; Fri, 19 Dec 2025 12:05:53 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.29])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dXv7H1w3Nz5xp3;
 Fri, 19 Dec 2025 17:05:47 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 18:05:46 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0039ac11577-add9-446f-b7d5-bc6432d9b339,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <53337586-5438-4d26-9957-8ea8b86b6d6d@kaod.org>
Date: Fri, 19 Dec 2025 18:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 12/18] hw/arm/aspeed: Attach SCU device to
 AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-13-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251208074436.1871180-13-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 7ee13072-1139-48e3-b0fa-57d2485113e1
X-Ovh-Tracer-Id: 9649806630857837490
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGCrikiogh66snvFaHp+jgzTdaAI9MoQtDJn13oZ6xMd4xRvPCngq5A8zlqSJ7ZAuorqJaRcM6h7SkX8T0OT5deyz/DTcAO5CoReH/EnPjgLD5gMPgvrVY4QWrY0TzdZ2xCDkI6EDTddnEGL+qBrBdTaOpz3l3MCgn4ShzIj5OKjnLGkQEWiHGAnqyyf9aR6gaK65ODCEFP9O+Iz1du/2J93rQsSJfeDi54Bj8ysMh6sAnXMu4HBtuoRnhQAs11dgRgUzcmNKRk7OdyUY2uycX4lV3OA8faRV3u+4qit4aPlwQ+1BkR0HChxjFKIn3DRvdudypfd+ZPRrR7dOs1P4gwFnB1hsWjHa+JmUzEczY8CR0XlEvRapiQ/R44xwR+1n4S+jdDojDmYNVaZ1EwjdTMoJlKDS6YjaH3Ebh63x7zL4B7dS6fYen9hY5b9So1XDmOmGtp5p5wt2KWt6o1/dH20IgNW881vPTZbzRp1nSAUZkUnMI/yaYrZXaiRSXTWolCOIH6cSIlcFcAWk6jPc1NT2hNqKNM/1Vgz5//MyiwW7HUoRuEC09aPP8AoMexcCbOuh6TxlpUvTjYRFN1vzVm4Rb7HRg7g1DtaZRsaGoAhYmBT1FLWaG59ks0kC6bicfMHh62NWHzLf3Ru0iMd0qVi40fOPy5gxABfEwnwCuxrw
DKIM-Signature: a=rsa-sha256; bh=5waYMpSZheJkkAbVCc/FQ990EkRWX/cMXlixaTjka7U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766163947; v=1;
 b=mOibjEYUcqjqRZO8cCK303moQKpuyhKZ+upJISbiXkQTvaYPmAIbITBOPXXbz0V/Em2W8Bn5
 w1pqygg2BG/k72n9UkG4DTc8YFbSrl3LFTM+vNVhTHbloijY4ptV0YYTroDmVhtISzpcu/9MC1S
 XIfu5B4LUvgwgXga/fwT9rwWVzDhg9/Ddqz3cMyOMQlOYzTCRAaz5Aw8n913jzG9to4pqM/Ov7E
 WjRfAquVRrK4EpfQvqqLfCCrvP5O0A/JmkuV/+5nGcuUE7glTuf2vjtne1i3s8KjruRwoob9UXF
 aIvIpkprhUdQ9a/HWw2/cj48/xo1vtl3azMbixjll1bJA==
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
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

On 12/8/25 08:44, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the SCU device to AST1700 model.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  3 +++
>   hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
>   hw/arm/aspeed_ast27x0.c         |  2 ++
>   3 files changed, 22 insertions(+)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index 0c1216c4ba..12c57145c6 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -9,6 +9,7 @@
>   #define ASPEED_AST1700_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/misc/aspeed_scu.h"
>   #include "hw/adc/aspeed_adc.h"
>   #include "hw/misc/aspeed_ltpi.h"
>   #include "hw/ssi/aspeed_smc.h"
> @@ -23,12 +24,14 @@ struct AspeedAST1700SoCState {
>   
>       MemoryRegion iomem;
>       uint8_t board_idx;
> +    uint32_t silicon_rev;
>   
>       AspeedLTPIState ltpi;
>       SerialMM uart;
>       MemoryRegion sram;
>       AspeedSMCState spi;
>       AspeedADCState adc;
> +    AspeedSCUState scu;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 967264aec9..b9a77765ce 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -20,6 +20,7 @@ enum {
>       ASPEED_AST1700_DEV_SPI0,
>       ASPEED_AST1700_DEV_SRAM,
>       ASPEED_AST1700_DEV_ADC,
> +    ASPEED_AST1700_DEV_SCU,
>       ASPEED_AST1700_DEV_UART12,
>       ASPEED_AST1700_DEV_LTPI_CTRL,
>       ASPEED_AST1700_DEV_SPI0_MEM,
> @@ -29,6 +30,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
>       [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
>       [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
>       [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
> +    [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
>       [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>       [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
> @@ -86,6 +88,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0));
>   
> +    /* SCU */
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
> +                         s->silicon_rev);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0));
> +
>       /* LTPI controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>           return;
> @@ -111,6 +123,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       object_initialize_child(obj, "ioexp-adc[*]", &s->adc,
>                               "aspeed.adc-ast2700");
>   
> +    /* SCU */
> +    object_initialize_child(obj, "ioexp-scu[*]", &s->scu,
> +                            TYPE_ASPEED_2700_SCU);
> +
>       /* LTPI controller */
>       object_initialize_child(obj, "ltpi-ctrl",
>                               &s->ltpi, TYPE_ASPEED_LTPI);
> @@ -119,6 +135,7 @@ static void aspeed_ast1700_instance_init(Object *obj)
>   
>   static const Property aspeed_ast1700_props[] = {
>       DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
> +    DEFINE_PROP_UINT32("silicon-rev", AspeedAST1700SoCState, silicon_rev, 0),
>   };
>   
>   static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 726b31031b..817c78209a 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -573,6 +573,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
>           /* AST1700 IOEXP */
>           object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
>                                   TYPE_ASPEED_AST1700);
> +        qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",
> +                             sc->silicon_rev);
>       }
>   
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,


