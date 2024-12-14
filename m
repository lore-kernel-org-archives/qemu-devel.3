Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E159E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 10:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMP1o-00035k-8J; Sat, 14 Dec 2024 05:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1k-0002zG-Aw; Sat, 14 Dec 2024 05:05:37 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1i-0001Rq-2a; Sat, 14 Dec 2024 05:05:35 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y9MK13s2jz4x07;
 Sat, 14 Dec 2024 21:05:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y9MJq0hprz4w2R;
 Sat, 14 Dec 2024 21:05:14 +1100 (AEDT)
Message-ID: <0171e7d1-ef32-4d14-b301-fefd45e2c0d8@kaod.org>
Date: Sat, 14 Dec 2024 11:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 59/71] hw/ssi: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:OpenTitan" <qemu-riscv@nongnu.org>,
 "open list:PowerNV Non-Virt..." <qemu-ppc@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-64-richard.henderson@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241213190750.2513964-64-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=YvF0=TH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

On 12/13/24 20:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/ssi/aspeed_smc.c       | 4 ++--
>   hw/ssi/ibex_spi_host.c    | 2 +-
>   hw/ssi/npcm7xx_fiu.c      | 2 +-
>   hw/ssi/pnv_spi.c          | 2 +-
>   hw/ssi/sifive_spi.c       | 2 +-
>   hw/ssi/ssi.c              | 2 +-
>   hw/ssi/xilinx_spi.c       | 2 +-
>   hw/ssi/xilinx_spips.c     | 4 ++--
>   hw/ssi/xlnx-versal-ospi.c | 2 +-
>   9 files changed, 11 insertions(+), 11 deletions(-)


For the aspeed part,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 033cbbb59b..bbdd4e4786 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -1287,7 +1287,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
>       }
>   };
>   
> -static Property aspeed_smc_properties[] = {
> +static const Property aspeed_smc_properties[] = {
>       DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, false),
>       DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
>       DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
> @@ -1336,7 +1336,7 @@ static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
>   }
>   
> -static Property aspeed_smc_flash_properties[] = {
> +static const Property aspeed_smc_flash_properties[] = {
>       DEFINE_PROP_UINT8("cs", AspeedSMCFlash, cs, 0),
>       DEFINE_PROP_LINK("controller", AspeedSMCFlash, controller, TYPE_ASPEED_SMC,
>                        AspeedSMCState *),
> diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
> index 9e07432f7c..60a0b17b62 100644
> --- a/hw/ssi/ibex_spi_host.c
> +++ b/hw/ssi/ibex_spi_host.c
> @@ -561,7 +561,7 @@ static const MemoryRegionOps ibex_spi_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -static Property ibex_spi_properties[] = {
> +static const Property ibex_spi_properties[] = {
>       DEFINE_PROP_UINT32("num_cs", IbexSPIHostState, num_cs, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> index 119c38c415..fdd3ad2fdc 100644
> --- a/hw/ssi/npcm7xx_fiu.c
> +++ b/hw/ssi/npcm7xx_fiu.c
> @@ -541,7 +541,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
>       },
>   };
>   
> -static Property npcm7xx_fiu_properties[] = {
> +static const Property npcm7xx_fiu_properties[] = {
>       DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index c21b2ebb3c..4ca9c469a4 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -1195,7 +1195,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static Property pnv_spi_properties[] = {
> +static const Property pnv_spi_properties[] = {
>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
>       DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
> index 08a107792b..7458747779 100644
> --- a/hw/ssi/sifive_spi.c
> +++ b/hw/ssi/sifive_spi.c
> @@ -328,7 +328,7 @@ static void sifive_spi_realize(DeviceState *dev, Error **errp)
>       fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
>   }
>   
> -static Property sifive_spi_properties[] = {
> +static const Property sifive_spi_properties[] = {
>       DEFINE_PROP_UINT32("num-cs", SiFiveSPIState, num_cs, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 3f357e8f16..cab0014c3f 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -108,7 +108,7 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
>       ssc->realize(s, errp);
>   }
>   
> -static Property ssi_peripheral_properties[] = {
> +static const Property ssi_peripheral_properties[] = {
>       DEFINE_PROP_UINT8("cs", SSIPeripheral, cs_index, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index 7f1e1808c5..588c1ec071 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -361,7 +361,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
>       }
>   };
>   
> -static Property xilinx_spi_properties[] = {
> +static const Property xilinx_spi_properties[] = {
>       DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index aeb462c3ce..f72cb3cbc8 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1420,12 +1420,12 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
>       }
>   };
>   
> -static Property xilinx_zynqmp_qspips_properties[] = {
> +static const Property xilinx_zynqmp_qspips_properties[] = {
>       DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS, dma_burst_size, 64),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> -static Property xilinx_spips_properties[] = {
> +static const Property xilinx_spips_properties[] = {
>       DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
>       DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
>       DEFINE_PROP_UINT8("num-txrx-bytes", XilinxSPIPS, num_txrx_bytes, 1),
> diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
> index ecc1903b8e..e51abe9de2 100644
> --- a/hw/ssi/xlnx-versal-ospi.c
> +++ b/hw/ssi/xlnx-versal-ospi.c
> @@ -1825,7 +1825,7 @@ static const VMStateDescription vmstate_xlnx_versal_ospi = {
>       }
>   };
>   
> -static Property xlnx_versal_ospi_properties[] = {
> +static const Property xlnx_versal_ospi_properties[] = {
>       DEFINE_PROP_BOOL("dac-with-indac", XlnxVersalOspi, dac_with_indac, false),
>       DEFINE_PROP_BOOL("indac-write-disabled", XlnxVersalOspi,
>                        ind_write_disabled, false),


