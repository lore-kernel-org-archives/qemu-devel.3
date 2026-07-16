Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E0BC44513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFlS-0000OH-7K; Thu, 16 Jul 2026 02:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkFlR-0000NW-07
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:40:09 -0400
Received: from smtpout1.mo540.mail-out.ovh.net ([51.210.91.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkFlO-0003CL-F6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:40:08 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h13Ln2rjhz44mw;
 Thu, 16 Jul 2026 06:40:01 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Thu, 16 Jul 2026 06:40:01 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.170])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h13Ln1l6Lz1xp3; Thu, 16 Jul 2026 06:40:01 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 CF58C2403DD0; Thu, 16 Jul 2026 06:39:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00413c65542-3251-4875-bc84-01c60f54181a,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <85f1e1b7-f215-4928-915c-c1338a327f02@kaod.org>
Date: Thu, 16 Jul 2026 08:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260707060919.350637-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 8989466335050116107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTElb8lpc6u0QNAa8DtaVx8g2XMQqfKZBQgB+TBS85IbYyK96IB4aZFuqdgVQHBfgWw3rBvd00E3iRjFSK87YG8vNoZeTiyooYH87nn2FrJs3iUa2tvwMmsI3QkWlzn46FTzQK0+tvVphyQHpcABKEFqvt2TvNONkkya304/lzEgevvkB3LWd/83Kp8JqCHgCLizq2YZ9TNCHCvUAZIbC3uOGCW20ewXH1pE54WlMEDnIBB+W/nk6o3BCYcS11XXr283SqWdfNGIxqeEwrvsZHh4Xy6quUlkqdsao9lj4xBIuzZhhLnNJN49KppvASnIViL6Tc8j4pO0zqODLAAFr8nzFPsxVFn4uUPf617DvsHeZo3LngPG74AxibdPMQSJjAv4CXwOxlS1cniSJLAPW3QXrPb6dtQD0M0CJIGr3jnTAVgUh3aHGxvxOSq5O3z6iSaOODIwJBKN0qEnG0QrfbxmYtthPEo20KSr8Xq1XKDjWiLSZrFmzb4nH5QyFGZzMvG5ZIh1DGHw+pNb8YuoaB6YaOOVqro7QECe1SR4akZ1VSyIORvCW40K9S/wiHT1IlON4DxZ5VIc+ANOg4lj4QvCjni1tGrMA01yTD4321Rxkyg8eA2NP0GcE6ge2IadujEKriPLbothQwZRCq6wpuK+qrA3ornN1SXQkf+D2+xUZw
DKIM-Signature: a=rsa-sha256; bh=ZcpxlsHD40347bHDBOOQdaeAqrW5wIJisWGQ4r8/2iQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784184003; v=1;
 b=Lu6W/pxzLKjK4PobECFbGG1J1FxQut8NS50DTlIDejikgACeu63iqr4K++07QIurKn6BIYwU
 gdKsrbstjly+zTNEhIEJQ9jcO+OTvF7SyLnYPKvxUa1wGP1LZazUxamZtptsWmMP9nAq8kDg9Gr
 8lR6+AoIH3D3IUjDPRZCtm+Oct4uC0DxR4F+8r2+ug3BhAskCUhxHg1CyKeO3D5VcxWgH2bhWgc
 QO8yYAzi4Jw3VErSOxOaYyIvDFBaG+I/Pe+uhCuy2vVR5KRpoEUYOc4cN/kASPWJ0v9EJIIYOpF
 xv5ga6tlmnmNm+RYXUvHzZSEmlGgIpQ+nBvuA8qkr3n2A==
Received-SPF: pass client-ip=51.210.91.50; envelope-from=clg@kaod.org;
 helo=smtpout1.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/7/26 08:09, Jamin Lin wrote:
> AST2700 supports a Data FIFO mode where flash accesses can be performed
> directly through Data FIFO MMIO offsets. The Data FIFO start offset
> increments by one for every 16MB of flash address space, allowing the
> chip select (CS) to be decoded from the Data FIFO offset.
> 
> This change adds Data FIFO support to the Aspeed SMC model and introduces
> a class callback to translate Data FIFO offsets into CS indices. For
> AST2700, the Data FIFO offset is matched against the segment start address
> of each CS to determine the target flash device.
> 
> The SMC register region size (nregs) is also extended dynamically
> based on the number of supported chip selects to cover all possible
> Data FIFO regions.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/ssi/aspeed_smc.h |   3 +-
>   hw/ssi/aspeed_smc.c         | 113 +++++++++++++++++++++++++++++++++---
>   2 files changed, 107 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 76831422c6..640efade94 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -47,7 +47,7 @@ struct AspeedSMCFlash {
>   #define TYPE_ASPEED_SMC "aspeed.smc"
>   OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)
>   
> -#define ASPEED_SMC_R_MAX        (0x100 / 4)
> +#define ASPEED_SMC_R_MAX        (0x300 / 4)

This array increase always requires a commit log comment saying that
migration compatibility is broken, may be a version bump too, even
if we know that migration is *not* officially supported. Minor.

Thanks,

C.

>   #define ASPEED_SMC_CS_MAX       5
>   
>   struct AspeedSMCState {
> @@ -116,6 +116,7 @@ struct AspeedSMCClass {
>                              AspeedSegments *seg);
>       void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);
>       int (*addr_width)(const AspeedSMCState *s);
> +    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset);
>       const MemoryRegionOps *reg_ops;
>   };
>   
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index d87fbd798c..c399503294 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -163,6 +163,9 @@
>   /* Read Timing Compensation Register */
>   #define R_TIMINGS         (0x94 / 4)
>   
> +/* Data fifo */
> +#define R_DATA_FIFO       (0x200 / 4)
> +
>   /* SPI controller registers and bits (AST2400) */
>   #define R_SPI_CONF        (0x00 / 4)
>   #define   SPI_CONF_ENABLE_W0   0
> @@ -212,6 +215,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[];
>   #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2
>   #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4
>   #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08
> +#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10
>   
>   static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)
>   {
> @@ -228,6 +232,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSMCClass *asc)
>       return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
>   }
>   
> +static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)
> +{
> +    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);
> +}
> +
>   #define aspeed_smc_error(fmt, ...)                                      \
>       qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS__)
>   
> @@ -764,6 +773,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
>   {
>       AspeedSMCState *s = ASPEED_SMC(opaque);
>       AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(opaque);
> +    int cs;
>   
>       addr >>= 2;
>   
> @@ -789,6 +799,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
>           trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);
>   
>           *data = s->regs[addr];
> +    } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
> +        cs = asc->data_fifo_offset_to_cs(s, addr << 2);
> +        if (cs >= 0) {
> +            /*
> +             * Data fifo mode only supports SPI user mode.
> +             * The flash address is provided by the SPI command/address cycles,
> +             * the MMIO addr parameter is ignored.
> +             */
> +            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, attrs);
> +        }
> +        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
> +        return MEMTX_ERROR;
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                         __func__, addr);
> @@ -1163,6 +1185,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>       } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&
>                  addr == R_DMA_DRAM_ADDR_HIGH) {
>           s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
> +    } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
> +        int cs = asc->data_fifo_offset_to_cs(s, addr << 2);
> +        if (cs >= 0) {
> +            /*
> +             * Data fifo mode only supports SPI user mode.
> +             * The flash address is provided by the SPI command/address cycles,
> +             * the MMIO addr parameter is ignored.
> +             */
> +            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,
> +                                          attrs);
> +        }
> +        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
> +        return MEMTX_ERROR;
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                         __func__, addr);
> @@ -1909,6 +1944,39 @@ static void aspeed_2700_smc_reg_to_segment(const AspeedSMCState *s,
>       }
>   }
>   
> +/*
> + * Convert a data fifo offset to a chip select (CS).
> + *
> + * Data fifo access starts at 0x200. The data fifo offset index is
> + * calculated by subtracting the data fifo base offset from the MMIO address.
> + *
> + * The data fifo offset index increments by 1 for every 16MB of flash address
> + * space. Each offset step therefore represents a 16MB address decode range.
> + *
> + * The CS is determined by matching the data fifo offset index against the
> + * segment start address of each CS.
> + *
> + * Returns the CS index on success, or -1 if the offset is invalid.
> + */
> +static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,
> +                                                  uint32_t offset)
> +{
> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> +    uint32_t start_offset;
> +    uint32_t fifo_offset;
> +    int i;
> +
> +    for (i = 0; i < asc->cs_num_max; i++) {
> +        start_offset = (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;
> +        fifo_offset = start_offset / 0x1000000;
> +        if (fifo_offset == offset - (R_DATA_FIFO << 2)) {
> +            return i;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
>   static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
>       [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
>               CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),
> @@ -1943,6 +2011,27 @@ static const AspeedSegments aspeed_2700_fmc_segments[] = {
>       { 0x0, 0 }, /* disabled */
>   };
>   
> +/*
> + * AST2700 supports data fifo mode with a base data fifo start offset of 0x200.
> + *
> + * The data fifo start offset increments by 1 for every 16MB of flash address
> + * space. Each offset step therefore represents a 16MB address decode range.
> + *
> + * Assuming each chip select (CS) can use the maximum flash size of 256MB:
> + *   256MB / 16MB = 0x10 offset steps per CS.
> + *
> + * Data fifo start offset for CSn:
> + *   0x200 + (n * 0x10)
> + *
> + * Examples:
> + *   CS0: 0x200
> + *   CS1: 0x210
> + *   CS2: 0x220
> + *   CS3: 0x230
> + *
> + * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)
> + * to cover all possible data fifo regions.
> + */
>   static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1962,14 +2051,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
>       asc->flash_window_base = 0x100000000;
>       asc->flash_window_size = 1 * GiB;
>       asc->features          = ASPEED_SMC_FEATURE_DMA |
> -                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
> +                             ASPEED_SMC_FEATURE_DATA_FIFO;
>       asc->dma_flash_mask    = 0x2FFFFFFC;
>       asc->dma_dram_mask     = 0xFFFFFFFC;
>       asc->dma_start_length  = 1;
> -    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
>       asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
>       asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
>       asc->reg_ops           = &aspeed_2700_smc_flash_ops;
>   }
>   
> @@ -1997,14 +2088,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass *klass, const void *data)
>       asc->flash_window_base = 0x180000000;
>       asc->flash_window_size = 1 * GiB;
>       asc->features          = ASPEED_SMC_FEATURE_DMA |
> -                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
> +                             ASPEED_SMC_FEATURE_DATA_FIFO;
>       asc->dma_flash_mask    = 0x2FFFFFFC;
>       asc->dma_dram_mask     = 0xFFFFFFFC;
>       asc->dma_start_length  = 1;
> -    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
>       asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
>       asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
>       asc->reg_ops           = &aspeed_2700_smc_flash_ops;
>   }
>   
> @@ -2031,14 +2124,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass *klass, const void *data)
>       asc->flash_window_base = 0x200000000;
>       asc->flash_window_size = 1 * GiB;
>       asc->features          = ASPEED_SMC_FEATURE_DMA |
> -                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
> +                             ASPEED_SMC_FEATURE_DATA_FIFO;
>       asc->dma_flash_mask    = 0x2FFFFFFC;
>       asc->dma_dram_mask     = 0xFFFFFFFC;
>       asc->dma_start_length  = 1;
> -    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
>       asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
>       asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
>       asc->reg_ops           = &aspeed_2700_smc_flash_ops;
>   }
>   
> @@ -2065,14 +2160,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
>       asc->flash_window_base = 0x280000000;
>       asc->flash_window_size = 1 * GiB;
>       asc->features          = ASPEED_SMC_FEATURE_DMA |
> -                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
> +                             ASPEED_SMC_FEATURE_DATA_FIFO;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0xFFFFFFFC;
>       asc->dma_start_length  = 1;
> -    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
>       asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
>       asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
>       asc->reg_ops           = &aspeed_2700_smc_flash_ops;
>   }
>   


