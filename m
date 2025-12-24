Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98050E7544E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMHY-0004W2-GC; Wed, 24 Dec 2025 05:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMHW-0004VD-UO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:39:50 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMHV-0005hr-0s
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:39:50 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.178])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dbpKY33lFz5xV2;
 Wed, 24 Dec 2025 10:39:45 +0000 (UTC)
Received: from DAG3EX1.mxp5.local (172.16.2.21) by DAG2EX2.mxp5.local
 (172.16.2.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:39:44 +0100
Received: from kaod.org (37.59.142.97) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:39:43 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002e6fa7f97-72f8-418a-9c98-6a507f8cb611,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <8d290ffe-351f-4dee-90f0-05dc1d299872@kaod.org>
Date: Wed, 24 Dec 2025 11:39:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251224014203.756264-7-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 2a637a7a-03a1-42b4-9558-05ba4326225d
X-Ovh-Tracer-Id: 14046727238989548533
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEHBSFiLa0QiXP/FAyw3+JjjrHrLKN9919eguqN3Z46cpkiVToLrPUfCwiPVYz7cpT/opUR5x4SGg5yXvx5gLu+nKcFJvQ3TjxDfwvSa+3LPbv+vKUvpgRhNRlxwlq/rHKr1BdmViL05x8bsVoiwBozCB7wmTDS/9wyXmfm0PDaQKcrafRoOHtBpeId2P+vuGNE9hTeZANbzWTKev53y6LNxKc29pNuzzxMmcMOWA20QybrZli0GEfB7nyl8DVs+NWs8AEsvj1R+qVg72PhejlLBUNnauVkH+akj7ePiwMOSTBJIDcZc0vWQRu7ic6+CRaGyC16USxNm8PA5lRMkXvpZgwYo7mmuuidNU6nB2k/xUYkECLTtv7Kb/Bco6zpLnRC7DCxNajkuNioWlU3Eq+fRrfOwSSuD6BV+chlklkWboHfvYodh2ksq5X48Nq3jX1mA4E8VQusL+748AfosRluBFyn5QGV1yKZXLGOgb47r8SA8xfh+3PdiR/L2NeoPnMZ9GzsJZr7DJy46RfiOrVhndFKYOo95jGMSOwJ+B58KBYzvkA/y5dF2ggIPOFaC977uV4sJLZypVoghK/qobgKt6c2pygK0o4E40THKhdoUsZnB8PxKTEQGCQL3lE8pGKiMyOaQXH+nQan+6rbl4U632q4rJ+TG2D3Sl6mAareFw
DKIM-Signature: a=rsa-sha256; bh=j4p9bQzrSVbrWc3+eC9RwK/stEZ/HDXZk2QanPUF8uo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766572786; v=1;
 b=p920XWBLV5jlBVeWYz7jskVNrxAxTrf6ttpjL6QnWdW6mzc8N1WJrO5NbywDdYtU32VaSfS8
 MhNdvBS7/q4P9doCwe2c7KAC5ZenNYzCDYUJJD1yxSdqr3D8CCE99PnZY6jWwlw4v1WYuW1oTsJ
 gNjZf39kRgMuOOrtD04XFyz+4q1cW2XNG1ZHPvT89XLeqMn+Y156yzTW8miQjElTw5hQInwg0Z9
 VNK349SE1cQcFQQQtIQrGgsaYX3dyRvVTTQFxNMLu8/rqIktN8hj2E67rWauB9meEjy9YPvKv3J
 OoJXJ1dx9lUvA/GjxteKAshu4qKQTZ0ZDBeKARvKcpW5A==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling
> the propagation of AST1700-originated interrupts to the host SoC.
> 
> This patch does not implement interrupt sources in AST1700 itself,
> only the wiring into AST27X0.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h   |  6 +++-
>   include/hw/intc/aspeed_intc.h |  2 ++
>   hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++
>   hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++
>   4 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index f19bab3457..b051d0eb3a 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -58,6 +58,7 @@
>   #define ASPEED_UARTS_NUM 13
>   #define ASPEED_JTAG_NUM  2
>   #define ASPEED_PCIE_NUM  3
> +#define ASPEED_INTC_NUM  2
>   #define ASPEED_IOEXP_NUM 2
>   
>   struct AspeedSoCState {
> @@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {
>       AspeedSoCState parent;
>   
>       ARMCPU cpu[ASPEED_CPUS_NUM];
> -    AspeedINTCState intc[2];
> +    AspeedINTCState intc[ASPEED_INTC_NUM];
> +    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
>       GICv3State gic;
>       MemoryRegion dram_empty;
>   };
> @@ -288,6 +290,8 @@ enum {
>       ASPEED_DEV_LTPI_CTRL2,
>       ASPEED_DEV_LTPI_IO0,
>       ASPEED_DEV_LTPI_IO1,
> +    ASPEED_DEV_IOEXP0_INTCIO,
> +    ASPEED_DEV_IOEXP1_INTCIO,
>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index 51288384a5..4565bbab84 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -15,6 +15,8 @@
>   #define TYPE_ASPEED_INTC "aspeed.intc"
>   #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
>   #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
> +#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "ast2700-ioexp1"
> +#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "ast2700-ioexp2"
>   #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
>   #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
>   #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index de39a3e7eb..678d4eb6d9 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
>       [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
> +    [ASPEED_DEV_IOEXP0_INTCIO] = 0x30C18000,
>       [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
> +    [ASPEED_DEV_IOEXP1_INTCIO] = 0x50C18000,
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
>       [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
> @@ -511,6 +513,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
>       object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
>       object_initialize_child(obj, "intcio", &a->intc[1],
>                               TYPE_ASPEED_2700_INTCIO);
> +    object_initialize_child(obj, "intcioexp0", &a->intcioexp[0],
> +                            TYPE_ASPEED_2700_INTCIOEXP1);
> +    object_initialize_child(obj, "intcioexp1", &a->intcioexp[1],
> +                            TYPE_ASPEED_2700_INTCIOEXP2);
>   
>       snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
>       object_initialize_child(obj, "adc", &s->adc, typename);
> @@ -755,6 +761,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
>                       sc->memmap[ASPEED_DEV_INTCIO]);
>   
> +    /* INTCIOEXP0 */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,
> +                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
> +
> +    /* INTCIOEXP1 */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,
> +                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
> +
>       /* irq sources -> orgates -> INTC */
>       for (i = 0; i < ic->num_inpins; i++) {
>           qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
> @@ -1079,6 +1101,21 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           }
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
>                           sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
> +
> +        icio = ASPEED_INTC_GET_CLASS(&a->intcioexp[i]);
> +        /* INTC_IOEXP internal: orgate[i] -> input[i] */
> +        for (int j = 0; j < icio->num_inpins; j++) {
> +            irq = qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);
> +            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]), 0,
> +                                  irq);
> +        }
> +
> +        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */
> +        for (int j = 0; j < icio->num_outpins; j++) {
> +            irq = qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,
> +                               irq);
> +        }
>       }
>   
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 5cd786dee6..a04005ee7c 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -924,6 +924,64 @@ static const TypeInfo aspeed_2700_intc_info = {
>       .class_init = aspeed_2700_intc_class_init,
>   };
>   
> +static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> +    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> +};
> +
> +static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 IOEXP2 INTC Controller";
> +    aic->num_lines = 32;
> +    aic->num_inpins = 2;
> +    aic->num_outpins = 10;
> +    aic->mem_size = 0x400;
> +    aic->nr_regs = 0x58 >> 2;
> +    aic->reg_offset = 0x100;
> +    aic->reg_ops = &aspeed_intcio_ops;
> +    aic->irq_table = aspeed_2700_intcioexp2_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700_intcioexp2_info = {
> +    .name = TYPE_ASPEED_2700_INTCIOEXP2,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700_intcioexp2_class_init,
> +};
> +
> +static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> +    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> +};
> +
> +static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 IOEXP1 INTC Controller";
> +    aic->num_lines = 32;
> +    aic->num_inpins = 2;
> +    aic->num_outpins = 10;
> +    aic->mem_size = 0x400;
> +    aic->nr_regs = 0x58 >> 2;
> +    aic->reg_offset = 0x100;
> +    aic->reg_ops = &aspeed_intcio_ops;
> +    aic->irq_table = aspeed_2700_intcioexp1_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700_intcioexp1_info = {
> +    .name = TYPE_ASPEED_2700_INTCIOEXP1,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700_intcioexp1_class_init,
> +};
> +
>   static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
>       {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
>       {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> @@ -1099,6 +1157,8 @@ static void aspeed_intc_register_types(void)
>       type_register_static(&aspeed_intc_info);
>       type_register_static(&aspeed_2700_intc_info);
>       type_register_static(&aspeed_2700_intcio_info);
> +    type_register_static(&aspeed_2700_intcioexp1_info);
> +    type_register_static(&aspeed_2700_intcioexp2_info);
>       type_register_static(&aspeed_2700ssp_intc_info);
>       type_register_static(&aspeed_2700ssp_intcio_info);
>       type_register_static(&aspeed_2700tsp_intc_info);


