Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57231CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6Hl-0002nw-Mw; Mon, 01 Jun 2026 13:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6Ha-0002eE-Ve; Mon, 01 Jun 2026 13:18:40 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6HY-0002YZ-Ew; Mon, 01 Jun 2026 13:18:34 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgfB3d67z5wb6;
 Mon,  1 Jun 2026 17:18:26 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:18:26 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.250])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgfB0lvWz7vR4;
 Mon,  1 Jun 2026 17:18:26 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 5C2D91923041; Mon,  1 Jun 2026 17:18:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0017c7da7c9-6dda-4fe0-afa4-0f69e01a1626,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <87eed226-a92f-41c2-8e23-4e74ffa09466@kaod.org>
Date: Mon, 1 Jun 2026 19:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/21] hw/arm/ast27x0: Share FMC controller with SSP
 and TSP
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13754556213091806347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEkUb3OGfqke6ZcvyqwQoZdOTmnDvCWUUQFI5LDFyv7LopAkx1s5yNwlTZyPw6QdGKb0IjZXeMMzOZ8y4YhT8KPe0suolKAbId/bquqxGUGK76qW9tk/n7+b1zK9O39hsRBKzIA0cRFVzF655R2dypiaQTvqtMLqeC5amJ90+84VgRI5o/tpXG0M7SDtd5zgXZexl2f7hJnbu7mE9n7eNreH9ITYMmiSkd5dZwwQ719PrDwwrGKrMUWJ1BW+7Gm3gD0ctd6AoCGO4QIKlQOIKoWsH0AMSDhBa45ifnsPyWcs09g91JjH3eODe6GZg1P3TCx8kD/tZUi8kihffO3LQhhlwoS8R1iGMMG5VqIHLrbXxdGD0u2W0tsURDewULZ/zbnLsAtxmnbKvbw39UuInzRWBXCZrzHO5gZ4s4zohqIpp+dBoI/Vj9sa1+vCNgFSIQ0Zmoh+yIx427OJZWw4xLZ+Zg6FrNr8qo30Z58V+g+qpUkQhuEZAMwt7LE53z0XSdxqrthvBpW7AfdkT/9n8D4sddAJACeQ57VYuLLUOBe/TBCFOPni0u+tefZBK6ENh58Tu1FygKtUYUGTXLs2g8X88vJPRVwUGQAEqlNT433/7DcmrYGuzUkJZgamv5hjMIgp6ODJiy5gz/OwqkjWZHkAsjkQCFGYdiEaeL+SYyXBg
DKIM-Signature: a=rsa-sha256; bh=bB6oamHjqVimcyH0YhJe7s++Tqfu5xSrWFchLyvst4c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780334307; v=1;
 b=dw+2lyoLIET4r7Fo63QaMWhTmOM/3bQuoVK3MsjLS19wNN7rGCJ09Mc+JwmPUK5qi+OaXU9D
 VNb9vcJDmRDLbY4YxN8pOqSZ/o+fFKFBaie7VCD6pr3WDp9Z/XadMHEdLEy6tTgVvkb0GKXdgUP
 +K0tU/ylRpJc6lZ7g+7hjl0W0k0qBZGFDMHocbtNWeCi+zkzpmDgZwpaIRDDpXeUEUfJvUzoAbk
 J9IQxklGLcRkZ48oOMAjomeAVrtgTKeqo3A5yj+ZNjneFXPk0Gx4RzE0bCfaVh13WWVcwcXLhli
 cbbQN05xHwFJRFyjnsHdB7v6ex+j/wl6qxfRjq6dA98bw==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/17/26 05:28, Jamin Lin wrote:
> AST2700 provides a single FMC controller shared by the main CA35 processor
> (PSP) and the SSP/TSP coprocessors.
> 
>  From the PSP perspective, the FMC controller is memory-mapped at
> 0x14000000–0x140000FF. The SSP and TSP access the same controller through
> a different address window at 0x74000000–0x740000FF.
> 
> This change allows the SSP and TSP SoC models to reference the existing
> PSP FMC instance instead of creating independent controllers. An MMIO
> alias is added in the SSP and TSP address spaces to map their FMC access
> window to the shared FMC device.
> 
> This ensures consistent FMC state across PSP, SSP, and TSP and matches
> the AST2700 hardware design.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  2 ++
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 10 ++++++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 10 ++++++++++
>   4 files changed, 26 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index 4db995d251..2460a11401 100644
> --- a/include/hw/arm/aspeed_coprocessor.h
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -50,7 +50,9 @@ struct Aspeed27x0CoprocessorState {
>       ARMv7MState armv7m;
>   
>       MemoryRegion scu_alias;
> +    MemoryRegion fmc_alias;
>       Aspeed2700SCUState *scu;
> +    AspeedSMCState *fmc;
>   };
>   
>   #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 62bd6a0568..56dd86e2c2 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -161,6 +161,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "scu",
>                                OBJECT(&s->ca35.scu), &error_abort);

I would change ast2700fc_ssp_init() and ast2700fc_tsp_init() to use
a AspeedSoCState argument and not a MachineState. This to reflect
that the AspeedSoCState *needs* to be realized before the coprocessors.
A comment is worth adding.


> +    object_property_set_link(OBJECT(&s->ssp), "fmc",
> +                             OBJECT(&psp->fmc), &error_abort);
>       if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
>           return false;
>       }
> @@ -193,6 +195,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->tsp), "scu",
>                                OBJECT(&s->ca35.scu), &error_abort);
> +    object_property_set_link(OBJECT(&s->tsp), "fmc",
> +                             OBJECT(&psp->fmc), &error_abort);
>       if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
>           return false;
>       }
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 0500c02755..bfd6fe4485 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_FMC]       =  0x74000000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,
> @@ -256,6 +257,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
>                          aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));

Please check that a->fmc is set :


   if (!a->fmc) {
       error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR ": 'fmc' link not set");
       return;
   }



>   
> +    /* FMC */
> +    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",
> +                             &a->fmc->mmio, 0,
> +                             memory_region_size(&a->fmc->mmio));

Isn't that too big for 0x14000000–0x140000FF ?

What about the flash contents window ? Is there one in the coprocessor
socs ? Is is unimplemented ?


> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
> +                                &a->fmc_alias);
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
>                                     "aspeed.timerctrl",
>                                     sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> @@ -273,6 +281,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>   static const Property aspeed_27x0_coprocessor_properties[] = {
>       DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
>                        TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
> +                     AspeedSMCState *),
>   };
>   
>   static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 4da4741d8a..166dcb14ed 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_FMC]       =  0x74000000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,
> @@ -253,6 +254,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
>                          aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));
>   
> +    /* FMC */
> +    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",
> +                             &a->fmc->mmio, 0,
> +                             memory_region_size(&a->fmc->mmio));
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
> +                                &a->fmc_alias);
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
>                                     "aspeed.timerctrl",
>                                     sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> @@ -270,6 +278,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>   static const Property aspeed_27x0_coprocessor_properties[] = {
>       DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
>                        TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
> +                     AspeedSMCState *),
>   };
>   
>   static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,


