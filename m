Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D211CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 06:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utKOl-0005jX-2Q; Tue, 02 Sep 2025 02:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utKO2-0005Ei-3m; Tue, 02 Sep 2025 02:21:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utKNw-0005vK-DZ; Tue, 02 Sep 2025 02:20:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGFws5k26z4wB1;
 Tue,  2 Sep 2025 16:20:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGFwp3tzJz4w9s;
 Tue,  2 Sep 2025 16:20:42 +1000 (AEST)
Message-ID: <555f7a62-7332-41a2-a316-e0888fbc819d@kaod.org>
Date: Tue, 2 Sep 2025 08:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor
 initialization from machine to SoC leve
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/17/25 05:40, Jamin Lin wrote:
> In the previous design, the SSP coprocessor (aspeed27x0ssp-soc) was initialized
> and realized at the machine level (e.g., AST2700FC). However, to make sure the
> coprocessors can work together properly—such as using the same SRAM, sharing
> the SCU, and having consistent memory remapping—we need to change how these
> devices are set up.
> 
> This commit moves the SSP coprocessor initialization and realization into the
> AST2700 SoC (aspeed_soc_ast2700_init() and aspeed_soc_ast2700_realize()).
> By doing so, the SSP becomes a proper child of the SoC device, rather than
> the machine.
> 
> This is a preparation step for future commits that will support shared SCU,
> SRAM, and memory remap logic—specifically enabling PSP DRAM remap for SSP SDRAM
> access.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h | 27 +++++++++++++-----------
>   hw/arm/aspeed_ast27x0-fc.c  | 30 ++------------------------
>   hw/arm/aspeed_ast27x0.c     | 42 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+), 40 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 217ef0eafd..2831da91ab 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -128,6 +128,19 @@ struct Aspeed2600SoCState {
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
>   
> +struct Aspeed27x0SSPSoCState {
> +    AspeedSoCState parent;
> +    AspeedINTCState intc[2];
> +    UnimplementedDeviceState ipc[2];
> +    UnimplementedDeviceState scuio;
> +    MemoryRegion memory;
> +
> +    ARMv7MState armv7m;
> +};
> +
> +#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
> +
>   struct Aspeed27x0SoCState {
>       AspeedSoCState parent;
>   
> @@ -135,6 +148,8 @@ struct Aspeed27x0SoCState {
>       AspeedINTCState intc[2];
>       GICv3State gic;
>       MemoryRegion dram_empty;
> +
> +    Aspeed27x0SSPSoCState ssp;
>   };
>   
>   #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
> @@ -146,18 +161,6 @@ struct Aspeed10x0SoCState {
>       ARMv7MState armv7m;
>   };
>   
> -struct Aspeed27x0SSPSoCState {
> -    AspeedSoCState parent;
> -    AspeedINTCState intc[2];
> -    UnimplementedDeviceState ipc[2];
> -    UnimplementedDeviceState scuio;
> -
> -    ARMv7MState armv7m;
> -};
> -
> -#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
> -OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
> -
>   struct Aspeed27x0TSPSoCState {
>       AspeedSoCState parent;
>       AspeedINTCState intc[2];
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index e2eee6183f..c9b338fe78 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -37,14 +37,11 @@ struct Ast2700FCState {
>       MemoryRegion ca35_memory;
>       MemoryRegion ca35_dram;
>       MemoryRegion ca35_boot_rom;
> -    MemoryRegion ssp_memory;
>       MemoryRegion tsp_memory;
>   
> -    Clock *ssp_sysclk;
>       Clock *tsp_sysclk;
>   
>       Aspeed27x0SoCState ca35;
> -    Aspeed27x0SSPSoCState ssp;
>       Aspeed27x0TSPSoCState tsp;
>   
>       bool mmio_exec;
> @@ -158,6 +155,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
>           return;
>       }
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
> +    aspeed_soc_uart_set_chr(ASPEED_SOC(&s->ca35.ssp), ASPEED_DEV_UART4,
> +                            serial_hd(1));

hmm, I wonder if the second uart shouldn't be set from the init handler
of the Aspeed27x0SSPSoCState child object.


>       if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
>           return;
>       }
> @@ -196,30 +195,6 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
>   }
>   
> -static void ast2700fc_ssp_init(MachineState *machine)
> -{
> -    AspeedSoCState *soc;
> -    Ast2700FCState *s = AST2700A1FC(machine);
> -    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
> -    clock_set_hz(s->ssp_sysclk, 200000000ULL);
> -
> -    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
> -    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
> -                       UINT64_MAX);
> -
> -    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
> -    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
> -                                  OBJECT(&s->ssp_memory), &error_abort)) {
> -        return;
> -    }
> -
> -    soc = ASPEED_SOC(&s->ssp);
> -    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
> -    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
> -        return;
> -    }
> -}
> -
>   static void ast2700fc_tsp_init(MachineState *machine)
>   {
>       AspeedSoCState *soc;
> @@ -247,7 +222,6 @@ static void ast2700fc_tsp_init(MachineState *machine)
>   static void ast2700fc_init(MachineState *machine)
>   {
>       ast2700fc_ca35_init(machine);
> -    ast2700fc_ssp_init(machine);
>       ast2700fc_tsp_init(machine);
>   }
>   
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 6aa3841b69..ffbc32fef2 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -22,6 +22,8 @@
>   #include "hw/intc/arm_gicv3.h"
>   #include "qobject/qlist.h"
>   #include "qemu/log.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/boards.h"
>   
>   #define AST2700_SOC_IO_SIZE          0x00FE0000
>   #define AST2700_SOC_IOMEM_SIZE       0x01000000
> @@ -410,6 +412,8 @@ static bool aspeed_soc_ast2700_dram_init(DeviceState *dev, Error **errp)
>   
>   static void aspeed_soc_ast2700_init(Object *obj)
>   {
> +    MachineState *ms = MACHINE(qdev_get_machine());

Calling qdev_get_machine() in a device model is a no-no. Please don't.

> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>       Aspeed27x0SoCState *a = ASPEED27X0_SOC(obj);
>       AspeedSoCState *s = ASPEED_SOC(obj);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> @@ -426,6 +430,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                   aspeed_soc_cpu_type(sc));
>       }
>   
> +    /* Coprocessors */
> +    if (mc->default_cpus > sc->num_cpus) {

That's a hack.

We need to find another way to conditionally create the co-processors
if that's what you want to do. A SoC class attribute would be a better
way.

> +        object_initialize_child(obj, "ssp", &a->ssp, TYPE_ASPEED27X0SSP_SOC);
> +    }
> +
>       object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
>   
>       object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
> @@ -610,9 +619,35 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>       return true;
>   }
>   
> +static bool aspeed_soc_ast2700_ssp_realize(DeviceState *dev, Error **errp)

I would pass 'Aspeed27x0SoCState *' instead.

> +{
> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
> +    AspeedSoCState *s = ASPEED_SOC(dev);
> +    Clock *sysclk;
> +
> +    sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
> +    clock_set_hz(sysclk, 200000000ULL);
> +    qdev_connect_clock_in(DEVICE(&a->ssp), "sysclk", sysclk);
> +
> +    memory_region_init(&a->ssp.memory, OBJECT(&a->ssp), "ssp-memory",
> +                       UINT64_MAX);
> +    if (!object_property_set_link(OBJECT(&a->ssp), "memory",
> +                                  OBJECT(&a->ssp.memory), &error_abort)) {

please use errp instead.


> +        return false;
> +    }
> +
> +    if (!qdev_realize(DEVICE(&a->ssp), NULL, &error_abort)) {

same here.


Thanks,

C.


> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>       Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>       AspeedSoCState *s = ASPEED_SOC(dev);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> @@ -719,6 +754,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scuio), 0,
>                       sc->memmap[ASPEED_DEV_SCUIO]);
>   
> +    /* Coprocessors */
> +    if (mc->default_cpus > sc->num_cpus) {
> +        if (!aspeed_soc_ast2700_ssp_realize(dev, errp)) {
> +            return;
> +        }
> +    }
> +
>       /* UART */
>       if (!aspeed_soc_uart_realize(s, errp)) {
>           return;


