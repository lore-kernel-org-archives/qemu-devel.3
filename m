Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE7CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slPJ6-0001K1-Fm; Tue, 03 Sep 2024 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org>)
 id 1slPJ4-0001EB-Un; Tue, 03 Sep 2024 04:54:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org>)
 id 1slPJ2-0001HS-Ut; Tue, 03 Sep 2024 04:54:34 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WyfZG4bm8z4x1V;
 Tue,  3 Sep 2024 18:54:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WyfZ9522Pz4wZx;
 Tue,  3 Sep 2024 18:54:25 +1000 (AEST)
Message-ID: <f12272cb-6a9b-4ae6-9a32-3cfe934b3e9c@kaod.org>
Date: Tue, 3 Sep 2024 10:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 09/11] aspeed/soc: Support I2C for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
 <20240903083528.2182190-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240903083528.2182190-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 10:35, Jamin Lin wrote:
> Add I2C model for AST2700 I2C support.
> The I2C controller registers base address is start at
> 0x14C0_F000 and its address space is 0x2000.
> 
> The AST2700 I2C controller has one source INTC per bus.
> I2C buses interrupt are connected to GICINT130_INTC
> from bit 0 to bit 15.
> I2C bus 0 is connected to GICINT130_INTC at bit 0.
> I2C bus 15 is connected to GICINT130_INTC at bit 15.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast27x0.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index a5eb78524f..761ee11657 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -61,6 +61,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_GIC_DIST]      =  0x12200000,
>       [ASPEED_GIC_REDIST]    =  0x12280000,
>       [ASPEED_DEV_ADC]       =  0x14C00000,
> +    [ASPEED_DEV_I2C]       =  0x14C0F000,
>   };
>   
>   #define AST2700_MAX_IRQ 288
> @@ -369,6 +370,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
>       object_initialize_child(obj, "adc", &s->adc, typename);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
> +    object_initialize_child(obj, "i2c", &s->i2c, typename);
>   }
>   
>   /*
> @@ -452,6 +456,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);
>       g_autofree char *sram_name = NULL;
> +    qemu_irq irq;
>   
>       /* Default boot region (SPI memory or ROMs) */
>       memory_region_init(&s->spi_boot_container, OBJECT(s),
> @@ -634,6 +639,25 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
>   
> +    /* I2C */
> +    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
> +    for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
> +        /*
> +         * The AST2700 I2C controller has one source INTC per bus.
> +         * I2C buses interrupt are connected to GICINT130_INTC
> +         * from bit 0 to bit 15.
> +         * I2C bus 0 is connected to GICINT130_INTC at bit 0.
> +         * I2C bus 15 is connected to GICINT130_INTC at bit 15.
> +         */
> +        irq = aspeed_soc_ast2700_get_irq_index(s, ASPEED_DEV_I2C, i);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
> +    }
> +
>       create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
>       create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
>       create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);


