Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966ADCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 17:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCrU-0007Im-Bv; Mon, 15 Sep 2025 13:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCrR-0007Ht-0x; Mon, 15 Sep 2025 13:19:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCrH-00061v-Kt; Mon, 15 Sep 2025 13:19:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cQWwc0rlcz4wBB;
 Tue, 16 Sep 2025 03:19:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cQWwW2dbkz4wB7;
 Tue, 16 Sep 2025 03:19:07 +1000 (AEST)
Message-ID: <dfe622ba-5202-4102-b4e7-c4df57d1d6b9@kaod.org>
Date: Mon, 15 Sep 2025 19:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 08/14] hw/arm/aspeed_ast2600: Add PCIe RC
 support (RC_H only)
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250911072452.314553-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=keIv=32=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/11/25 09:24, Jamin Lin wrote:
> Wire up the PCIe Root Complex in the AST2600 SoC model.
> 
> According to the AST2600 firmware driver, only the RC_H controller is
> supported. RC_H uses PCIe PHY1 at 0x1e6ed200 and the PCIe config (H2X)
> register block at 0x1e770000. The RC_H MMIO window is mapped at
> 0x70000000–0x80000000. RC_L is not modeled. The RC_H interrupt is
> wired to IRQ 168. Only RC_H is realized and connected to the SoC
> interrupt controller.
> 
> The SoC integration initializes PCIe PHY1, instantiates a single RC
> instance, wires its MMIO regions, and connects its interrupt. An alias
> region is added to map the RC MMIO space into the guest physical address
> space.
> 
> This provides enough functionality for firmware and guest drivers to
> discover and use the AST2600 RC_H Root Complex while leaving RC_L
> unimplemented.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast2600.c | 69 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 66 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d12707f0ab..d521a1b4f0 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -48,11 +48,13 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_XDMA]      = 0x1E6E7000,
>       [ASPEED_DEV_ADC]       = 0x1E6E9000,
>       [ASPEED_DEV_DP]        = 0x1E6EB000,
> +    [ASPEED_DEV_PCIE_PHY1] = 0x1E6ED200,
>       [ASPEED_DEV_SBC]       = 0x1E6F2000,
>       [ASPEED_DEV_EMMC_BC]   = 0x1E6f5000,
>       [ASPEED_DEV_VIDEO]     = 0x1E700000,
>       [ASPEED_DEV_SDHCI]     = 0x1E740000,
>       [ASPEED_DEV_EMMC]      = 0x1E750000,
> +    [ASPEED_DEV_PCIE0]     = 0x1E770000,
>       [ASPEED_DEV_GPIO]      = 0x1E780000,
>       [ASPEED_DEV_GPIO_1_8V] = 0x1E780800,
>       [ASPEED_DEV_RTC]       = 0x1E781000,
> @@ -79,6 +81,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_FSI1]      = 0x1E79B000,
>       [ASPEED_DEV_FSI2]      = 0x1E79B100,
>       [ASPEED_DEV_I3C]       = 0x1E7A0000,
> +    [ASPEED_DEV_PCIE_MMIO1] = 0x70000000,
>       [ASPEED_DEV_SDRAM]     = 0x80000000,
>   };
>   
> @@ -127,6 +130,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_LPC]       = 35,
>       [ASPEED_DEV_IBT]       = 143,
>       [ASPEED_DEV_I2C]       = 110,   /* 110 -> 125 */
> +    [ASPEED_DEV_PCIE0]     = 168,
>       [ASPEED_DEV_PECI]      = 38,
>       [ASPEED_DEV_ETH1]      = 2,
>       [ASPEED_DEV_ETH2]      = 3,
> @@ -191,6 +195,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>       object_initialize_child(obj, "i2c", &s->i2c, typename);
>   
> +    object_initialize_child(obj, "pcie-cfg", &s->pcie[0], TYPE_ASPEED_PCIE_CFG);
> +    object_initialize_child(obj, "pcie-phy[*]", &s->pcie_phy[0],
> +                            TYPE_ASPEED_PCIE_PHY);
> +
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   
>       snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
> @@ -292,7 +300,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       AspeedSoCState *s = ASPEED_SOC(dev);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       qemu_irq irq;
> -    g_autofree char *sram_name = NULL;
> +    g_autofree char *name = NULL;
> +    MemoryRegion *mmio_alias;
> +    MemoryRegion *mmio_mr;
>   
>       /* Default boot region (SPI memory or ROMs) */
>       memory_region_init(&s->spi_boot_container, OBJECT(s),
> @@ -362,8 +372,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* SRAM */
> -    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
> -    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
> +    name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
> +    if (!memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size,
>                                   errp)) {
>           return;
>       }
> @@ -438,6 +448,59 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
>   
> +    /*
> +     * PCIe Root Complex (RC)
> +     *
> +     * H2X register space (single block 0x00-0xFF):
> +     *   0x00-0x7F : shared by RC_L (PCIe0) and RC_H (PCIe1)
> +     *   0x80-0xBF : RC_L only
> +     *   0xC0-0xFF : RC_H only
> +     *
> +     * Model scope / limitations:
> +     *   - Firmware supports RC_H only; this QEMU model does not support RC_L.
> +     *   - RC_H uses PHY1 and the MMIO window [0x70000000, 0x80000000]
> +     *     (aka MMIO1).
> +     *
> +     * Indexing convention (this model):
> +     *   - Expose a single logical instance at index 0.
> +     *   - pcie[0] -> hardware RC_H (PCIe1)
> +     *   - phy[0]  -> hardware PHY1
> +     *   - mmio.0 -> guest address range MMIO1: 0x70000000-0x80000000
> +     *   - RC_L / PCIe0 is not created and mapped.
> +     */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[0]), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
> +                    sc->memmap[ASPEED_DEV_PCIE_PHY1]);
> +
> +    object_property_set_int(OBJECT(&s->pcie[0]), "dram-base",
> +                            sc->memmap[ASPEED_DEV_SDRAM],
> +                            &error_abort);
> +    object_property_set_link(OBJECT(&s->pcie[0]), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[0]), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[0]), 0,
> +                    sc->memmap[ASPEED_DEV_PCIE0]);
> +
> +    irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
> +                           sc->irqmap[ASPEED_DEV_PCIE0]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[0].rc), 0, irq);
> +
> +    name = g_strdup_printf("aspeed.pcie-mmio.0");
> +
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[0].rc), 1);
> +
> +    memory_region_init_alias(mmio_alias, OBJECT(&s->pcie[0].rc), name,
> +                             mmio_mr, sc->memmap[ASPEED_DEV_PCIE_MMIO1],
> +                             0x10000000);
> +    memory_region_add_subregion(s->memory,
> +                                sc->memmap[ASPEED_DEV_PCIE_MMIO1],
> +                                mmio_alias);
> +

Could you please introduce a sub routine to realize the PCIe RC model ?
name it aspeed_soc_ast2600_pcie_realize() maybe.


Thanks,

C.




>       /* FMC, The number of CS is set at the board level */
>       object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
>                                &error_abort);


