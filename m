Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ACBCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 08:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uynbs-0007C4-Uk; Wed, 17 Sep 2025 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uXDK=34=kaod.org=clg@ozlabs.org>)
 id 1uynbq-0007BA-EF; Wed, 17 Sep 2025 04:33:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uXDK=34=kaod.org=clg@ozlabs.org>)
 id 1uynbn-0005vQ-TM; Wed, 17 Sep 2025 04:33:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cRX9L3hcsz4wDK;
 Wed, 17 Sep 2025 18:33:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cRX9H1tsFz4wDN;
 Wed, 17 Sep 2025 18:33:38 +1000 (AEST)
Message-ID: <57d39eb5-10fb-408c-b557-fc60681ef1ed@kaod.org>
Date: Wed, 17 Sep 2025 10:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 3/6] hw/arm/aspeed: Add AST1700 IO expander
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
 <20250917013143.1600377-4-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250917013143.1600377-4-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uXDK=34=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 9/17/25 03:31, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> AST27x0 machines can carry up to two AST1700-based IO expander boards.
> This change introduces a lightweight AST1700 SoC container and maps two
> separate LTPI IO windows for those expanders.

We will need more details on the new SoC.

> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h | 20 ++++++++++++++++++--
>   hw/arm/aspeed_ast27x0.c     | 17 ++++++++++++-----
>   2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 72eefb0327..648c8d5c00 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -52,6 +52,21 @@
>   #define ASPEED_JTAG_NUM  2
>   #define ASPEED_IOEXP_NUM 2
>   
> +typedef struct {
> +    MemoryRegion *memory;
> +    MemoryRegion container;
> +    AddressSpace dram_as;
> +
> +    AspeedSMCState spi;
> +    AspeedADCState adc;
> +    AspeedSCUState scu;
> +    AspeedGPIOState gpio;
> +    AspeedI2CState i2c;
> +    AspeedI3CState i3c;
> +    SerialMM uart;
> +    AspeedWDTState wdt[ASPEED_WDTS_NUM];
> +} AspeedAST1700SoCState;
> +

This is introducing a new SoC, which is fine.


>   struct AspeedSoCState {
>       DeviceState parent;
>   
> @@ -102,10 +117,10 @@ struct AspeedSoCState {
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
>       UnimplementedDeviceState sgpiom;
> -    UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
>       AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
> +    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
>       uint8_t ioexp_num;
>   };
>   
> @@ -206,7 +221,8 @@ enum {
>       ASPEED_DEV_IOMEM,
>       ASPEED_DEV_IOMEM0,
>       ASPEED_DEV_IOMEM1,
> -    ASPEED_DEV_LTPI,
> +    ASPEED_DEV_LTPI_IO0,
> +    ASPEED_DEV_LTPI_IO1,
>       ASPEED_DEV_UART0,
>       ASPEED_DEV_UART1,
>       ASPEED_DEV_UART2,
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 3f93554027..2e180c8cc5 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -83,8 +83,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
>       [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
> +    [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
> +    [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
> -    [ASPEED_DEV_LTPI]      =  0x300000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
>   };
>   
> @@ -523,7 +524,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
>       object_initialize_child(obj, "hace", &s->hace, typename);
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "ltpi", &s->ltpi,
> +    object_initialize_child(obj, "ltpi0", &s->ioexp[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ltpi1", &s->ioexp[1],
>                               TYPE_UNIMPLEMENTED_DEVICE);



However, please reimplement all the class handlers for the new SoC.

Thanks,

C.





>       object_initialize_child(obj, "iomem", &s->iomem,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> @@ -968,9 +971,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],
>                                     AST2700_SOC_DPMCU_SIZE);
> -    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ltpi),
> -                                  "aspeed.ltpi",
> -                                  sc->memmap[ASPEED_DEV_LTPI],
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ioexp[0]),
> +                                  "aspeed.ltpi.0",
> +                                  sc->memmap[ASPEED_DEV_LTPI_IO0],
> +                                  AST2700_SOC_LTPI_SIZE);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ioexp[1]),
> +                                  "aspeed.ltpi.1",
> +                                  sc->memmap[ASPEED_DEV_LTPI_IO1],
>                                     AST2700_SOC_LTPI_SIZE);
>       aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem),
>                                     "aspeed.io",


