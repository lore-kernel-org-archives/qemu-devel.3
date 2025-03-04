Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5773C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMSH-0006mh-C2; Tue, 04 Mar 2025 02:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMRx-0006fH-NJ; Tue, 04 Mar 2025 02:12:27 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMRs-0002k8-1E; Tue, 04 Mar 2025 02:12:19 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z6Rh814jmz4x8W;
 Tue,  4 Mar 2025 18:12:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6Rh42z9Zz4x0t;
 Tue,  4 Mar 2025 18:12:04 +1100 (AEDT)
Message-ID: <93676cc7-8801-42a5-9b53-a8006bcb1eb7@kaod.org>
Date: Tue, 4 Mar 2025 08:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/23] hw/arm/aspeed_ast27x0.c Support AST2700 A1 GIC
 Interrupt Mapping
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-18-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250303095457.2337631-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=B2sr=VX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/3/25 10:54, Jamin Lin wrote:
> Currently, these IRQ tables support from GIC 128 - 136 for AST2700 A0.
> These IRQ tables can be reused for AST2700 A1 from GIC 192 - 197.
> Updates the interrupt mapping to include support for AST2700 A1 by extending
> the existing mappings to the new GIC range.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 82 ++++++++++++++++++++++++++---------------
>   1 file changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 09aad69e3c..eab9674b6c 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -120,21 +120,27 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
>   };
>   
>   /* GICINT 128 */
> -static const int aspeed_soc_ast2700_gic128_intcmap[] = {
> +/* GICINT 192 */
> +static const int ast2700_gic128_gic192_intcmap[] = {
>       [ASPEED_DEV_LPC]       = 0,
>       [ASPEED_DEV_IBT]       = 2,
>       [ASPEED_DEV_KCS]       = 4,
>   };
>   
> +/* GICINT 129 */
> +/* GICINT 193 */
> +
>   /* GICINT 130 */
> -static const int aspeed_soc_ast2700_gic130_intcmap[] = {
> +/* GICINT 194 */
> +static const int ast2700_gic130_gic194_intcmap[] = {
>       [ASPEED_DEV_I2C]        = 0,
>       [ASPEED_DEV_ADC]        = 16,
>       [ASPEED_DEV_GPIO]       = 18,
>   };
>   
>   /* GICINT 131 */
> -static const int aspeed_soc_ast2700_gic131_intcmap[] = {
> +/* GICINT 195 */
> +static const int ast2700_gic131_gic195_intcmap[] = {
>       [ASPEED_DEV_I3C]       = 0,
>       [ASPEED_DEV_WDT]       = 16,
>       [ASPEED_DEV_FMC]       = 25,
> @@ -142,7 +148,8 @@ static const int aspeed_soc_ast2700_gic131_intcmap[] = {
>   };
>   
>   /* GICINT 132 */
> -static const int aspeed_soc_ast2700_gic132_intcmap[] = {
> +/* GICINT 196 */
> +static const int ast2700_gic132_gic196_intcmap[] = {
>       [ASPEED_DEV_ETH1]      = 0,
>       [ASPEED_DEV_ETH2]      = 1,
>       [ASPEED_DEV_ETH3]      = 2,
> @@ -161,24 +168,26 @@ static const int aspeed_soc_ast2700_gic132_intcmap[] = {
>   };
>   
>   /* GICINT 133 */
> -static const int aspeed_soc_ast2700_gic133_intcmap[] = {
> +/* GICINT 197 */
> +static const int ast2700_gic133_gic197_intcmap[] = {
>       [ASPEED_DEV_SDHCI]     = 1,
>       [ASPEED_DEV_PECI]      = 4,
>   };
>   
>   /* GICINT 128 ~ 136 */
> +/* GICINT 192 ~ 201 */
>   struct gic_intc_irq_info {
>       int irq;
>       const int *ptr;
>   };
>   
> -static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
> -    {128,  aspeed_soc_ast2700_gic128_intcmap},
> +static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
> +    {128,  ast2700_gic128_gic192_intcmap},
>       {129,  NULL},
> -    {130,  aspeed_soc_ast2700_gic130_intcmap},
> -    {131,  aspeed_soc_ast2700_gic131_intcmap},
> -    {132,  aspeed_soc_ast2700_gic132_intcmap},
> -    {133,  aspeed_soc_ast2700_gic133_intcmap},
> +    {130,  ast2700_gic130_gic194_intcmap},
> +    {131,  ast2700_gic131_gic195_intcmap},
> +    {132,  ast2700_gic132_gic196_intcmap},
> +    {133,  ast2700_gic133_gic197_intcmap},
>       {134,  NULL},
>       {135,  NULL},
>       {136,  NULL},
> @@ -190,11 +199,11 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       int i;
>   
> -    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
> -        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
> -            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
> +    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
> +        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
> +            assert(ast2700_gic_intcmap[i].ptr);
>               return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
> -                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev]);
> +                ast2700_gic_intcmap[i].ptr[dev]);
>           }
>       }
>   
> @@ -208,16 +217,17 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       int i;
>   
> -    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
> -        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
> -            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
> +    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
> +        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
> +            assert(ast2700_gic_intcmap[i].ptr);
>               return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
> -                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev] + index);
> +                                    ast2700_gic_intcmap[i].ptr[dev] + index);
>           }
>       }
>   
>       /*
> -     * Invalid orgate index, device irq should be 128 to 136.
> +     * Invalid OR gate index, device IRQ should be between 128 to 136
> +     * and 192 to 201.
>        */
>       g_assert_not_reached();
>   }
> @@ -492,7 +502,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>       AspeedSoCState *s = ASPEED_SOC(dev);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);

I would keep this intermediate variable. Minor.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>       g_autofree char *sram_name = NULL;
>       qemu_irq irq;
>   
> @@ -530,17 +539,18 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
>                       sc->memmap[ASPEED_DEV_INTC]);
>   
> -    /* source orgates -> INTC */
> -    for (i = 0; i < ic->num_inpins; i++) {
> +    /* irq sources -> orgates -> INTC */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc)->num_inpins; i++) {
>           qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
> -                                qdev_get_gpio_in(DEVICE(&a->intc), i));
> +                              qdev_get_gpio_in(DEVICE(&a->intc), i));
>       }
>   
> +    /* INTC -> GIC192 - GIC201 */
>       /* INTC -> GIC128 - GIC136 */
> -    for (i = 0; i < ic->num_outpins; i++) {
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc)->num_outpins; i++) {
>           sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
>                              qdev_get_gpio_in(DEVICE(&a->gic),
> -                                aspeed_soc_ast2700_gic_intcmap[i].irq));
> +                                            ast2700_gic_intcmap[i].irq));
>       }
>   
>       /* SRAM */
> @@ -691,10 +701,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
>           /*
>            * The AST2700 I2C controller has one source INTC per bus.
> -         * I2C buses interrupt are connected to GICINT130_INTC
> -         * from bit 0 to bit 15.
> -         * I2C bus 0 is connected to GICINT130_INTC at bit 0.
> -         * I2C bus 15 is connected to GICINT130_INTC at bit 15.
> +         *
> +         * For AST2700 A0:
> +         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
> +         * 15, and the OR gate output pin is connected to the input pin of
> +         * GICINT130 of INTC (CPU Die). Then, the output pin is connected to
> +         * the GIC.
> +         *
> +         * For AST2700 A1:
> +         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
> +         * 15, and the OR gate output pin is connected to the input pin of
> +         * GICINT194 of INTCIO (IO Die). Then, the output pin is connected
> +         * to the INTC (CPU Die) input pin, and its output pin is connected
> +         * to the GIC.
> +         *
> +         * I2C bus 0 is connected to the OR gate at bit 0.
> +         * I2C bus 15 is connected to the OR gate at bit 15.
>            */
>           irq = aspeed_soc_ast2700_get_irq_index(s, ASPEED_DEV_I2C, i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);


