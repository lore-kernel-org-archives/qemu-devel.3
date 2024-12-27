Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A16E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 09:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR72M-0000Q3-L6; Fri, 27 Dec 2024 04:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TB6Z=TU=kaod.org=clg@ozlabs.org>)
 id 1tR72K-0000M0-Ai; Fri, 27 Dec 2024 04:53:40 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TB6Z=TU=kaod.org=clg@ozlabs.org>)
 id 1tR72H-0005pb-Lc; Fri, 27 Dec 2024 04:53:40 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YKLR94Xv2z4x5h;
 Fri, 27 Dec 2024 20:53:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YKLR60w1Tz4wnx;
 Fri, 27 Dec 2024 20:53:21 +1100 (AEDT)
Message-ID: <94c71f3b-4c3a-4989-af08-2cf07c8aca2c@kaod.org>
Date: Fri, 27 Dec 2024 10:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] aspeed: ast27x0: Map unimplemented devices in SoC
 memory
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-3-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241225020311.3718080-3-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=TB6Z=TU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.169, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

On 12/25/24 03:03, Steven Lee wrote:
> Maps following unimplemented devices in SoC memory
> - dpmcu
> - iomem0
> - iomem1
> - ltpi
> - io

Could you please add a sentence about what these devices are ?

Thanks,

C.


> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c     | 45 +++++++++++++++++++++++++++++++------
>   include/hw/arm/aspeed_soc.h |  6 +++++
>   2 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index fee3755837..fd09872403 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -23,11 +23,19 @@
>   #include "qapi/qmp/qlist.h"
>   #include "qemu/log.h"
>   
> +#define AST2700_SOC_IO_SIZE          0x04000000
> +#define AST2700_SOC_IOMEM_SIZE       0x01000000
> +#define AST2700_SOC_DPMCU_SIZE       0x00040000
> +#define AST2700_SOC_LTPI_SIZE        0x01000000
> +
>   static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_SPI_BOOT]  =  0x400000000,
> +    [ASPEED_DEV_IOMEM]     =  0x00000000,
>       [ASPEED_DEV_SRAM]      =  0x10000000,
> +    [ASPEED_DEV_IOMEM0]    =  0x12000000,
>       [ASPEED_DEV_SDMC]      =  0x12C00000,
>       [ASPEED_DEV_SCU]       =  0x12C02000,
> +    [ASPEED_DEV_IOMEM1]    =  0x14000000,
>       [ASPEED_DEV_SCUIO]     =  0x14C02000,
>       [ASPEED_DEV_UART0]     =  0X14C33000,
>       [ASPEED_DEV_UART1]     =  0X14C33100,
> @@ -66,6 +74,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_GPIO]      =  0x14C0B000,
>       [ASPEED_DEV_RTC]       =  0x12C0F000,
>       [ASPEED_DEV_SDHCI]     =  0x14080000,
> +    [ASPEED_DEV_LTPI]      =  0x30000000,
>   };
>   
>   #define AST2700_MAX_IRQ 256
> @@ -397,6 +406,14 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
>                               TYPE_SYSBUS_SDHCI);
> +
> +    object_initialize_child(obj, "dpmcu", &s->dpmcu, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ltpi", &s->ltpi, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "io", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "iomem0", &s->iomem0,
> +            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "iomem1", &s->iomem1,
> +            TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
>   /*
> @@ -432,8 +449,10 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>       if (!sysbus_realize(gicbusdev, errp)) {
>           return false;
>       }
> -    sysbus_mmio_map(gicbusdev, 0, sc->memmap[ASPEED_GIC_DIST]);
> -    sysbus_mmio_map(gicbusdev, 1, sc->memmap[ASPEED_GIC_REDIST]);
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 0,
> +                    sc->memmap[ASPEED_GIC_DIST]);
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 1,
> +                    sc->memmap[ASPEED_GIC_REDIST]);
>   
>       for (i = 0; i < sc->num_cpus; i++) {
>           DeviceState *cpudev = DEVICE(&a->cpu[i]);
> @@ -716,11 +735,23 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
>   
> -    create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
> -    create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
> -    create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);
> -    create_unimplemented_device("ast2700.ltpi", 0x30000000, 0x1000000);
> -    create_unimplemented_device("ast2700.io", 0x0, 0x4000000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu), "aspeed.dpmcu",
> +                                  sc->memmap[ASPEED_DEV_DPMCU],
> +                                  AST2700_SOC_DPMCU_SIZE);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ltpi), "aspeed.ltpi",
> +                                  sc->memmap[ASPEED_DEV_LTPI],
> +                                  AST2700_SOC_LTPI_SIZE);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
> +                                  sc->memmap[ASPEED_DEV_IOMEM],
> +                                  AST2700_SOC_IO_SIZE);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem0),
> +                                  "aspeed.iomem0",
> +                                  sc->memmap[ASPEED_DEV_IOMEM0],
> +                                  AST2700_SOC_IOMEM_SIZE);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem1),
> +                                  "aspeed.iomem1",
> +                                  sc->memmap[ASPEED_DEV_IOMEM1],
> +                                  AST2700_SOC_IOMEM_SIZE);
>   }
>   
>   static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 689f52dae8..bf885da3fc 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -90,6 +90,8 @@ struct AspeedSoCState {
>       SerialMM uart[ASPEED_UARTS_NUM];
>       Clock *sysclk;
>       UnimplementedDeviceState iomem;
> +    UnimplementedDeviceState iomem0;
> +    UnimplementedDeviceState iomem1;
>       UnimplementedDeviceState video;
>       UnimplementedDeviceState emmc_boot_controller;
>       UnimplementedDeviceState dpmcu;
> @@ -97,6 +99,7 @@ struct AspeedSoCState {
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
>       UnimplementedDeviceState sgpiom;
> +    UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
>   };
> @@ -172,6 +175,9 @@ const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
>   enum {
>       ASPEED_DEV_SPI_BOOT,
>       ASPEED_DEV_IOMEM,
> +    ASPEED_DEV_IOMEM0,
> +    ASPEED_DEV_IOMEM1,
> +    ASPEED_DEV_LTPI,
>       ASPEED_DEV_UART0,
>       ASPEED_DEV_UART1,
>       ASPEED_DEV_UART2,


