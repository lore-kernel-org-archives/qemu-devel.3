Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3D2CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6MC-0006b0-RK; Mon, 01 Jun 2026 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6MA-0006aR-FE; Mon, 01 Jun 2026 13:23:18 -0400
Received: from smtpout8.mo539.mail-out.ovh.net ([51.210.91.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6M7-0003mN-NC; Mon, 01 Jun 2026 13:23:18 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4gTglh6BCbz4bjL;
 Mon,  1 Jun 2026 17:23:12 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:23:12 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.77])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTglh3XbRz7vRH; Mon,  1 Jun 2026 17:23:12 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 7B7DF1923050; Mon,  1 Jun 2026 17:23:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005898e618d-5629-4706-8ec7-a4f8969ee5f2,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9cbd85b4-cdee-490e-870f-bedb257c5354@kaod.org>
Date: Mon, 1 Jun 2026 19:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/21] hw/arm/ast27x0: Share single SCUIO instance
 across PSP, SSP, and TSP
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
 <20260417032837.2664122-19-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-19-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13835058056779508875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFg8alM4Ox6rj/RMH0gxvSygaqUTUgcm31fZOOQdarIl3Oe/xUcdAopqjL3+8ZBK1dkw33/hKpKQf1YaQ0GGEfdKDRg5t6/E4vQxxKyI5oynKFEOnUwHmyThtLhRwR/kqAsU69iwQCbSTROywejiLF/VwUHVF9EN5kweu747h8p2HOpj8CTG05EoBUWGGSbORZfvCbvsfO/WA6DRyecPDHmBzHrITGFoS8Hv6MMatzXeGS4iwuVJsRAKwMaRDKKk+TaPbhLylC/fzRzqgRf9DoJmgwPfb9lhqvlGQksEJcA75GiyObn4U4/svOiLq5WZV/fwlT0XLS7ObCwNLFvlAQZnIbGyipGVkpqdpBSbGNMdBqDL77dt9ZtS7Darvc21TgMDQVrpo/esml7Cec0P4c/qgExv/arRZNgOAl6lmv2SofcbPlUQPJ82X2wTPTME4t0UoZDGG7qgm2nZfowvOV0d9wyNVa3NYOifs5bzrR0M0BxaDIkE0ZbCe/45uOQ4uWFiHpxGTbyrsm+1DzDLe2IRwq5N05oe3M73BVb3IKJrFZTaickkG3Vw4cmXqQfSfN0Z7559BIabXiLNXsI2ksB+9/Fo6+TjFewJm1mt/IyvT71OCFCForyEvtFD50KK299slMq1DC4e72mGTIGiRdcLpnkrT6t2Nlr9knzTScwLg
DKIM-Signature: a=rsa-sha256; bh=IxzTI9OJOOEbMiHr0xpTFqB6Ky1MBk7yqr5OsUeB4vs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780334593; v=1;
 b=ugyNJiIwzkvGGW/9N+dPfoXP1Qutzcli+5lnoT0JOFNChEQyFNzjILg43Ys6vU7DDtT5YGS8
 pde1+VV1g2ipzENx+MJebW5CyKSR1aK4yaA5OTX1yaQI7Om/3TZ+hYnvli6dCaZu8bvTx7hwIa0
 cZJjuC+Fm365wP+58qGrtik70UCYzMavmBJPrIdsPHQIiQLSHbxIFaa0NBSZeLxlNN6GsnUkrj5
 +kl1xCUuoLz3Zv+Yp0nfycij28lXkN3Dx8XyQkNdiEgERi+iXgGAo2EdhpqlDjVxVTXLxZOryoA
 13Zt9OiyzJp4Ny/0M6lcXadz5UPBRkRn31Sx8KrS2wvWw==
Received-SPF: pass client-ip=51.210.91.47; envelope-from=clg@kaod.org;
 helo=smtpout8.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/17/26 05:29, Jamin Lin wrote:
> AST2700 has a single SCUIO hardware block, memory-mapped at
> 0x14C02000–0x14C03FFF from the perspective of the main CA35 processor (PSP).
> The SSP and TSP coprocessors access this same SCUIO block at different
> addresses: 0x74C02000–0x74C03FFF.
> 
> Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO
> device, resulting in three independent SCUIO instances in the QEMU model.
> In real hardware, however, only a single SCUIO exists and is shared among
> all processors.
> 
> This commit reworks the SCUIO model to correctly reflect the hardware
> behavior by allowing SSP and TSP to reference the PSP’s SCUIO instance.
> The following changes are introduced:
> 
> - Add a scuio property to Aspeed27x0CoprocessorState for linking the
>    coprocessor to the PSP’s SCUIO instance.
> - Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.
> - Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP.
> - Create SCUIO alias regions in both SSP and TSP coprocessors and map
>    them at 0x74C02000 to mirror the PSP’s SCUIO registers.
> - Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.
> 
> With this change, PSP, SSP, and TSP now share a consistent SCUIO state,
> matching the single-SCUIO hardware design of AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  4 ++--
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 14 +++++++++-----
>   hw/arm/aspeed_ast27x0-tsp.c         | 14 +++++++++-----
>   4 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index 7750569eed..23c3b97f06 100644
> --- a/include/hw/arm/aspeed_coprocessor.h
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -22,7 +22,6 @@ struct AspeedCoprocessorState {
>       MemoryRegion uart_alias;
>       Clock *sysclk;
>   
> -    AspeedSCUState scuio;
>       AspeedTimerCtrlState timerctrl;
>       SerialMM *uart;
>       int uart_dev;
> @@ -45,15 +44,16 @@ struct Aspeed27x0CoprocessorState {
>       AspeedCoprocessorState parent;
>       AspeedINTCState intc[2];
>       UnimplementedDeviceState ipc[2];
> -    UnimplementedDeviceState scuio;
>       UnimplementedDeviceState pric[2];
>       UnimplementedDeviceState otp;
>   
>       ARMv7MState armv7m;
>   
>       MemoryRegion scu_alias;
> +    MemoryRegion scuio_alias;
>       MemoryRegion fmc_alias;
>       Aspeed2700SCUState *scu;
> +    AspeedSCUState *scuio;
>       AspeedSMCState *fmc;
>   };
>   
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 56dd86e2c2..d1ff6fbd4d 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -161,6 +161,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "scu",
>                                OBJECT(&s->ca35.scu), &error_abort);
> +    object_property_set_link(OBJECT(&s->ssp), "scuio",
> +                             OBJECT(&psp->scuio), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "fmc",
>                                OBJECT(&psp->fmc), &error_abort);
>       if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
> @@ -195,6 +197,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->tsp), "scu",
>                                OBJECT(&s->ca35.scu), &error_abort);
> +    object_property_set_link(OBJECT(&s->tsp), "scuio",
> +                             OBJECT(&psp->scuio), &error_abort);
>       object_property_set_link(OBJECT(&s->tsp), "fmc",
>                                OBJECT(&psp->fmc), &error_abort);
>       if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 78bd6f342c..6c8945ce6c 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -143,8 +143,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "ipc1", &a->ipc[1],
>                               TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "scuio", &a->scuio,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "pric0", &a->pric[0],
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "pric1", &a->pric[1],
> @@ -215,6 +213,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>               memory_region_size(&a->scu->dram_remap_alias[1]),
>               &a->scu->dram_remap_alias[0]);
>   
> +    /* SCUIO */
> +    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",
> +                             &a->scuio->iomem, 0,
> +                             memory_region_size(&a->scuio->iomem));
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],
> +                                &a->scuio_alias);
> +
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
>           return;
> @@ -282,9 +287,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
>                                     "aspeed.ipc1",
>                                     sc->memmap[ASPEED_DEV_IPC1], 0x1000);
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
> -                                  "aspeed.scuio",
> -                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
>                                     "aspeed.pric0",
>                                     sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
> @@ -299,6 +301,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>   static const Property aspeed_27x0_coprocessor_properties[] = {
>       DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
>                        TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
> +                     TYPE_ASPEED_SCU, AspeedSCUState *),

Check that the link is set in the realize routines.

Thanks,

C.


>       DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
>                        AspeedSMCState *),
>   };
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index d6448d82f5..cab7f47ac8 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -143,8 +143,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "ipc1", &a->ipc[1],
>                               TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "scuio", &a->scuio,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "pric0", &a->pric[0],
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "pric1", &a->pric[1],
> @@ -212,6 +210,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>       /* SDRAM remap alias used by PSP to access TSP SDRAM */
>       memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[2]);
>   
> +    /* SCUIO */
> +    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",
> +                             &a->scuio->iomem, 0,
> +                             memory_region_size(&a->scuio->iomem));
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],
> +                                &a->scuio_alias);
> +
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
>           return;
> @@ -279,9 +284,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
>                                     "aspeed.ipc1",
>                                     sc->memmap[ASPEED_DEV_IPC1], 0x1000);
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
> -                                  "aspeed.scuio",
> -                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
>                                     "aspeed.pric0",
>                                     sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
> @@ -296,6 +298,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>   static const Property aspeed_27x0_coprocessor_properties[] = {
>       DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
>                        TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
> +                     TYPE_ASPEED_SCU, AspeedSCUState *),
>       DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
>                        AspeedSMCState *),
>   };


