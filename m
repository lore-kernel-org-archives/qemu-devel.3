Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E299CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6oqD-0001Rw-DR; Thu, 09 Oct 2025 07:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v6oq9-0001Rh-R9; Thu, 09 Oct 2025 07:29:45 -0400
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v6oq3-0003gn-9L; Thu, 09 Oct 2025 07:29:45 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.98])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cj72247DTz5w0l;
 Thu,  9 Oct 2025 11:29:30 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 9 Oct
 2025 13:29:29 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0043144a28e-7e7c-4a47-906f-5738171193c0,
 0ABBE769FBEA5341A3875E1E3E57BEA7B23E4658) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b6695612-cc9d-4f33-b7e8-b82870eab973@kaod.org>
Date: Thu, 9 Oct 2025 13:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 07/16] hw/arm/aspeed: Remove AspeedSoCState
 dependency from aspeed_soc_get_irq() API
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251009023301.4085829-1-jamin_lin@aspeedtech.com>
 <20251009023301.4085829-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251009023301.4085829-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: d4618ece-badd-47fe-88b6-2cb858a6bc18
X-Ovh-Tracer-Id: 11284331820077910962
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFiR9vaC7YXX12caLseZjm+nAcgZnAEDele9w3Yx2a4sJLtJIXY+L2PJf4mJQTsL3+52OM1l6ue5S2DHN+mtYrNqfN6lPbqbEVYbL7GbAc1Oxbg+YlOQtO6ZvxTll4PUocNbfhx+OUP456d8u3tAq/EQh/7D7E1sq4RwyvnfxUfaP7DSw6gPuV2e7BBTLRzY0F5dH0dRCFAe+ohLyU0MIg3dwNHc0cfWTJ5H21yM4sYGNVMth1LD+V67bcWWCTAyAA/VIg7x0yCxUFS3Xwx0PrXK2pPOY8Mo3uTfFoQKtcdJkQrlJGabZznW0W96Sxc53lewtyYcg0/jTzVFF9JsmFIscPzzWSayXJWxPxL3qIhuUO1vRnpJDp4y72cNVj/1lpEqHbbCrWGa21zi1gGdnGHvMxHyDmivyQDJMWSt9O+TbbT8yDwXM6u0yFBlm9ZBeJ2SSwkd2qWzZwhOZSMK+PDpt7JyfGQHNbtDdjm7Yyp0aj/L156ON6qmDZGzCDbfT6IQsTJYUPrdqSe/gMZyqUuz+wTxwJcYMkner9HSvZ+INsrnE9HkXPytuvox1LUeu/5NUtWvCcC4kTLES/1k5w1+dYDVXef1BnATupsY7SBNIXn0qbh3FSpUsQY/8gxROXyLwV1aEd3rYnx1CYWL3go8Fi39j4oKYUzA5yCsb4a7w
DKIM-Signature: a=rsa-sha256; bh=Zb983iZcpcciDIYkAp15DVb9p819Y45JLpEr7y8SQQo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760009371; v=1;
 b=KUQ+h/Afy36/ZRoKCfudWjza4FgPDZcY04lyR84qh0ckI1+PZF1/hNREHD7Z9xCurcTnW7DQ
 otMDktsmF2kPmG4eJqWugtOf1BRasldC3xVn8RPZ5HsULodJJzpwx8iM/Tubexzc6ETLm91FwIC
 9YWE5z4Ck6vxD/83JYTaNQeUe/oDflu0Dd4ul74HjoYslT1Y0axh3FKva0UX5uOrBiNNBCd43AO
 PP+bR1uI7H8/4wvB3ykVD7km5KGjIhHpS8lFX2cCKHxcXUvGqGoA45C+vRJ6mf31YYFb4XYksUL
 ViR+0zRtRb6WdA/QWYWsazpWfhZfoRcjG0LT9LU5W3dFA==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/25 04:32, Jamin Lin wrote:
> Refactor IRQ helper to decouple from SoC state. The public
> aspeed_soc_get_irq() now takes a function pointer and opaque context
> (qemu_irq (*fn)(void *ctx, int dev), void *ctx, int dev) instead of an
> AspeedSoCState *.
> 
> Update AspeedSoCClass::get_irq signature to (void *ctx, int dev) and
> convert all SoC-specific implementations (AST1030/2400/2600/27x0 SSP/TSP
> and AST2700) to accept void *ctx.
> 
> Adjust all call sites to pass sc->get_irq and s explicitly, and wire
> through in aspeed_soc_uart_realize() and relevant realize paths.
> 
> This change removes a hard dependency on AspeedSoCState, enabling reuse
> from other classes and simplifying future refactors.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  5 +++--
>   hw/arm/aspeed_ast10x0.c     | 18 ++++++++++--------
>   hw/arm/aspeed_ast2400.c     | 32 ++++++++++++++++++--------------
>   hw/arm/aspeed_ast2600.c     | 37 +++++++++++++++++++++----------------
>   hw/arm/aspeed_ast27x0-ssp.c |  3 ++-
>   hw/arm/aspeed_ast27x0-tsp.c |  3 ++-
>   hw/arm/aspeed_ast27x0.c     | 27 +++++++++++++++------------
>   hw/arm/aspeed_soc_common.c  |  8 +++++---
>   8 files changed, 76 insertions(+), 57 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 957362b88d..427708c087 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -198,7 +198,7 @@ struct AspeedSoCClass {
>       const int *irqmap;
>       const hwaddr *memmap;
>       uint32_t num_cpus;
> -    qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
> +    qemu_irq (*get_irq)(void *ctx, int dev);
>       bool (*boot_from_emmc)(AspeedSoCState *s);
>   };
>   
> @@ -303,7 +303,8 @@ enum {
>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> -qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
> +qemu_irq aspeed_soc_get_irq(qemu_irq (*fn)(void *ctx, int dev),
> +                            void *ctx, int dev);
>   bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
>   void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
>                                int uarts_num, Chardev *chr);
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index e861b6dad6..3ce866c66a 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -99,8 +99,9 @@ static const int aspeed_soc_ast1030_irqmap[] = {
>       [ASPEED_DEV_JTAG1]     = 53,
>   };
>   
> -static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast1030_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed10x0SoCState *a = ASPEED10X0_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> @@ -283,7 +284,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
>                       sc->memmap[ASPEED_DEV_PECI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));

Could we call directly aspeed_soc_ast1030_get_irq() instead ? same
for all other SoC and remove aspeed_soc_get_irq().


Thanks,

C.



>   
>       /* LPC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
> @@ -294,7 +295,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>   
>       /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
>   
>       /*
>        * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
> @@ -329,7 +330,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
>                       sc->memmap[ASPEED_DEV_TIMER1]);
>       for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> -        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
> +        qemu_irq irq = aspeed_soc_get_irq(sc->get_irq, s,
> +                                          ASPEED_DEV_TIMER1 + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>       }
>   
> @@ -340,7 +342,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
>                       sc->memmap[ASPEED_DEV_ADC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
>   
>       /* FMC, The number of CS is set at the board level */
>       object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram),
> @@ -353,7 +355,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
>                       ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
>   
>       /* SPI */
>       for (i = 0; i < sc->spis_num; i++) {
> @@ -384,7 +386,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
>                       sc->memmap[ASPEED_DEV_HACE]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
>   
>       /* Watch dog */
>       for (i = 0; i < sc->wdts_num; i++) {
> @@ -406,7 +408,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
>                       sc->memmap[ASPEED_DEV_GPIO]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
>   
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index e0604851a5..2910c40807 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -134,8 +134,9 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>   
>   #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
>   
> -static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast2400_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed2400SoCState *a = ASPEED2400_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> @@ -312,7 +313,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
>                       sc->memmap[ASPEED_DEV_RTC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
>   
>       /* Timer */
>       object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
> @@ -323,7 +324,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
>                       sc->memmap[ASPEED_DEV_TIMER1]);
>       for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> -        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
> +        qemu_irq irq = aspeed_soc_get_irq(sc->get_irq, s,
> +                                          ASPEED_DEV_TIMER1 + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>       }
>   
> @@ -334,7 +336,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
>                       sc->memmap[ASPEED_DEV_ADC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
>   
>       /* UART */
>       if (!aspeed_soc_uart_realize(s, errp)) {
> @@ -350,7 +352,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
>                       sc->memmap[ASPEED_DEV_I2C]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_I2C));
>   
>       /* PECI */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
> @@ -359,7 +361,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
>                       sc->memmap[ASPEED_DEV_PECI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));
>   
>       /* FMC, The number of CS is set at the board level */
>       object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
> @@ -372,7 +374,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
>                       ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
>   
>       /* Set up an alias on the FMC CE0 region (boot default) */
>       MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
> @@ -399,7 +401,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
>                           sc->memmap[ASPEED_DEV_EHCI1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_EHCI1 + i));
>       }
>   
>       /* SDMC - SDRAM Memory Controller */
> @@ -437,7 +440,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                           sc->memmap[ASPEED_DEV_ETH1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_ETH1 + i));
>       }
>   
>       /* XDMA */
> @@ -447,7 +451,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
>                       sc->memmap[ASPEED_DEV_XDMA]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_XDMA));
>   
>       /* GPIO */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
> @@ -456,7 +460,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
>                       sc->memmap[ASPEED_DEV_GPIO]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
>   
>       /* SDHCI */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
> @@ -465,7 +469,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
>                       sc->memmap[ASPEED_DEV_SDHCI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
>   
>       /* LPC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
> @@ -476,7 +480,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>   
>       /* Connect the LPC IRQ to the VIC */
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
>   
>       /*
>        * On the AST2400 and AST2500 the one LPC IRQ is shared between all of the
> @@ -508,7 +512,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
>                       sc->memmap[ASPEED_DEV_HACE]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
>   }
>   
>   static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index ed0985a16e..cd14dc95bb 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -144,8 +144,9 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_I3C]       = 102,   /* 102 -> 107 */
>   };
>   
> -static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast2600_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed2600SoCState *a = ASPEED2600_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> @@ -463,7 +464,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
>                       sc->memmap[ASPEED_DEV_RTC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
>   
>       /* Timer */
>       object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
> @@ -474,7 +475,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
>                       sc->memmap[ASPEED_DEV_TIMER1]);
>       for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> -        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
> +        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_TIMER1 + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>       }
>   
> @@ -485,7 +486,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
>                       sc->memmap[ASPEED_DEV_ADC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
>   
>       /* UART */
>       if (!aspeed_soc_uart_realize(s, errp)) {
> @@ -514,7 +515,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
>                       sc->memmap[ASPEED_DEV_PECI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));
>   
>       /* PCIe Root Complex (RC) */
>       if (!aspeed_soc_ast2600_pcie_realize(dev, errp)) {
> @@ -532,7 +533,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
>                       ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
>   
>       /* Set up an alias on the FMC CE0 region (boot default) */
>       MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
> @@ -561,7 +562,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
>                           sc->memmap[ASPEED_DEV_EHCI1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_EHCI1 + i));
>       }
>   
>       /* SDMC - SDRAM Memory Controller */
> @@ -599,7 +601,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                           sc->memmap[ASPEED_DEV_ETH1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_ETH1 + i));
>   
>           object_property_set_link(OBJECT(&s->mii[i]), "nic",
>                                    OBJECT(&s->ftgmac100[i]), &error_abort);
> @@ -618,7 +621,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
>                       sc->memmap[ASPEED_DEV_XDMA]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_XDMA));
>   
>       /* GPIO */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
> @@ -627,7 +630,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
>                       sc->memmap[ASPEED_DEV_GPIO]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
>   
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
>           return;
> @@ -635,7 +638,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
>                       sc->memmap[ASPEED_DEV_GPIO_1_8V]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
> +                       aspeed_soc_get_irq(sc->get_irq, s,
> +                                          ASPEED_DEV_GPIO_1_8V));
>   
>       /* SDHCI */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
> @@ -644,7 +648,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
>                       sc->memmap[ASPEED_DEV_SDHCI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
>   
>       /* eMMC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
> @@ -653,7 +657,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
>                       sc->memmap[ASPEED_DEV_EMMC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_EMMC));
>   
>       /* LPC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
> @@ -664,7 +668,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>   
>       /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
>   
>       /*
>        * On the AST2600 LPC subdevice IRQs are connected straight to the GIC.
> @@ -699,7 +703,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
>                       sc->memmap[ASPEED_DEV_HACE]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
>   
>       /* I3C */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
> @@ -729,7 +733,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
>                           sc->memmap[ASPEED_DEV_FSI1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_FSI1 + i));
>       }
>   }
>   
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 99a3de15b5..e63a4b3ad3 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -104,8 +104,9 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
>       {136, 0, 9, NULL},
>   };
>   
> -static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast27x0ssp_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 568d7555e2..9537ce121c 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -104,8 +104,9 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
>       {136, 0, 9, NULL},
>   };
>   
> -static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 9b645c6c55..9a53f51ec5 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -286,8 +286,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
>       {136, 0, 9, NULL},
>   };
>   
> -static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
> +static qemu_irq aspeed_soc_ast2700_get_irq(void *ctx, int dev)
>   {
> +    AspeedSoCState *s = (AspeedSoCState *)ctx;
>       Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       int or_idx;
> @@ -660,7 +661,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
>           }
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[i]), 0,
>                           sc->memmap[ASPEED_DEV_PCIE0 + i]);
> -        irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
> +        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PCIE0 + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
>   
>           mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[i].rc), 1);
> @@ -806,7 +807,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
>                       ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
>   
>       /* Set up an alias on the FMC CE0 region (boot default) */
>       MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
> @@ -835,7 +836,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
>                           sc->memmap[ASPEED_DEV_EHCI1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_EHCI1 + i));
>       }
>   
>       /*
> @@ -870,7 +872,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                           sc->memmap[ASPEED_DEV_ETH1 + i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
> -                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
> +                           aspeed_soc_get_irq(sc->get_irq, s,
> +                                              ASPEED_DEV_ETH1 + i));
>   
>           object_property_set_link(OBJECT(&s->mii[i]), "nic",
>                                    OBJECT(&s->ftgmac100[i]), &error_abort);
> @@ -915,7 +918,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
>                       sc->memmap[ASPEED_DEV_ADC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
>   
>       /* I2C */
>       object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
> @@ -956,7 +959,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
>                       sc->memmap[ASPEED_DEV_GPIO]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
>   
>       /* RTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
> @@ -965,7 +968,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
>                       sc->memmap[ASPEED_DEV_RTC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
>   
>       /* SDHCI */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
> @@ -974,7 +977,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
>                       sc->memmap[ASPEED_DEV_SDHCI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
>   
>       /* eMMC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
> @@ -983,7 +986,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
>                       sc->memmap[ASPEED_DEV_EMMC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_EMMC));
>   
>       /* Timer */
>       object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
> @@ -994,7 +997,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
>                       sc->memmap[ASPEED_DEV_TIMER1]);
>       for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> -        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
> +        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_TIMER1 + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>       }
>   
> @@ -1007,7 +1010,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
>                       sc->memmap[ASPEED_DEV_HACE]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
> +                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
>   
>       /* PCIe Root Complex (RC) */
>       if (!aspeed_soc_ast2700_pcie_realize(dev, errp)) {
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index e7d0a9c290..2bd872d9a6 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -30,9 +30,10 @@ const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types)
>       return valid_cpu_types[0];
>   }
>   
> -qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
> +qemu_irq aspeed_soc_get_irq(qemu_irq (*fn)(void *ctx, int dev),
> +                            void *ctx, int dev)
>   {
> -    return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
> +    return fn(ctx, dev);
>   }
>   
>   bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
> @@ -52,7 +53,8 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>               return false;
>           }
>   
> -        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0,
> +                           aspeed_soc_get_irq(sc->get_irq, s, uart));
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
>       }
>   


