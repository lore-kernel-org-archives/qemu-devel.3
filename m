Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FF2C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCui-0004UJ-Sb; Thu, 06 Mar 2025 10:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org>)
 id 1tqCuC-0003NT-WF; Thu, 06 Mar 2025 10:13:05 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org>)
 id 1tqCu9-0001aC-9W; Thu, 06 Mar 2025 10:12:59 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z7tFy0JLMz4x3d;
 Fri,  7 Mar 2025 02:12:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z7tFt50Twz4wcT;
 Fri,  7 Mar 2025 02:12:50 +1100 (AEDT)
Message-ID: <37d1b1c1-f9ae-4792-abc6-bd92d760e8ac@kaod.org>
Date: Thu, 6 Mar 2025 16:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/29] hw/arm/aspeed_ast27x0: Sort the memmap table by
 mapping address
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
 <20250306103846.429221-25-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250306103846.429221-25-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/6/25 11:38, Jamin Lin wrote:
> To improve readability, sort the memmap table by mapping address
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast27x0.c | 54 ++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 7439512b83..3330484bf5 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -24,16 +24,40 @@
>   #include "qemu/log.h"
>   
>   static const hwaddr aspeed_soc_ast2700_memmap[] = {
> -    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_SRAM]      =  0x10000000,
> +    [ASPEED_DEV_HACE]      =  0x12070000,
> +    [ASPEED_DEV_EMMC]      =  0x12090000,
> +    [ASPEED_DEV_INTC]      =  0x12100000,
> +    [ASPEED_GIC_DIST]      =  0x12200000,
> +    [ASPEED_GIC_REDIST]    =  0x12280000,
>       [ASPEED_DEV_SDMC]      =  0x12C00000,
>       [ASPEED_DEV_SCU]       =  0x12C02000,
> +    [ASPEED_DEV_RTC]       =  0x12C0F000,
> +    [ASPEED_DEV_TIMER1]    =  0x12C10000,
> +    [ASPEED_DEV_SLI]       =  0x12C17000,
> +    [ASPEED_DEV_UART4]     =  0X12C1A000,
> +    [ASPEED_DEV_FMC]       =  0x14000000,
> +    [ASPEED_DEV_SPI0]      =  0x14010000,
> +    [ASPEED_DEV_SPI1]      =  0x14020000,
> +    [ASPEED_DEV_SPI2]      =  0x14030000,
> +    [ASPEED_DEV_MII1]      =  0x14040000,
> +    [ASPEED_DEV_MII2]      =  0x14040008,
> +    [ASPEED_DEV_MII3]      =  0x14040010,
> +    [ASPEED_DEV_ETH1]      =  0x14050000,
> +    [ASPEED_DEV_ETH2]      =  0x14060000,
> +    [ASPEED_DEV_ETH3]      =  0x14070000,
> +    [ASPEED_DEV_SDHCI]     =  0x14080000,
> +    [ASPEED_DEV_ADC]       =  0x14C00000,
>       [ASPEED_DEV_SCUIO]     =  0x14C02000,
> +    [ASPEED_DEV_GPIO]      =  0x14C0B000,
> +    [ASPEED_DEV_I2C]       =  0x14C0F000,
> +    [ASPEED_DEV_INTCIO]    =  0x14C18000,
> +    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
> +    [ASPEED_DEV_VUART]     =  0X14C30000,
>       [ASPEED_DEV_UART0]     =  0X14C33000,
>       [ASPEED_DEV_UART1]     =  0X14C33100,
>       [ASPEED_DEV_UART2]     =  0X14C33200,
>       [ASPEED_DEV_UART3]     =  0X14C33300,
> -    [ASPEED_DEV_UART4]     =  0X12C1A000,
>       [ASPEED_DEV_UART5]     =  0X14C33400,
>       [ASPEED_DEV_UART6]     =  0X14C33500,
>       [ASPEED_DEV_UART7]     =  0X14C33600,
> @@ -43,32 +67,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_UART11]    =  0X14C33A00,
>       [ASPEED_DEV_UART12]    =  0X14C33B00,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
> -    [ASPEED_DEV_VUART]     =  0X14C30000,
> -    [ASPEED_DEV_FMC]       =  0x14000000,
> -    [ASPEED_DEV_SPI0]      =  0x14010000,
> -    [ASPEED_DEV_SPI1]      =  0x14020000,
> -    [ASPEED_DEV_SPI2]      =  0x14030000,
> +    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
> -    [ASPEED_DEV_MII1]      =  0x14040000,
> -    [ASPEED_DEV_MII2]      =  0x14040008,
> -    [ASPEED_DEV_MII3]      =  0x14040010,
> -    [ASPEED_DEV_ETH1]      =  0x14050000,
> -    [ASPEED_DEV_ETH2]      =  0x14060000,
> -    [ASPEED_DEV_ETH3]      =  0x14070000,
> -    [ASPEED_DEV_EMMC]      =  0x12090000,
> -    [ASPEED_DEV_INTC]      =  0x12100000,
> -    [ASPEED_DEV_INTCIO]    =  0x14C18000,
> -    [ASPEED_DEV_SLI]       =  0x12C17000,
> -    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
> -    [ASPEED_GIC_DIST]      =  0x12200000,
> -    [ASPEED_GIC_REDIST]    =  0x12280000,
> -    [ASPEED_DEV_ADC]       =  0x14C00000,
> -    [ASPEED_DEV_I2C]       =  0x14C0F000,
> -    [ASPEED_DEV_GPIO]      =  0x14C0B000,
> -    [ASPEED_DEV_RTC]       =  0x12C0F000,
> -    [ASPEED_DEV_SDHCI]     =  0x14080000,
> -    [ASPEED_DEV_TIMER1]    =  0x12C10000,
> -    [ASPEED_DEV_HACE]      =  0x12070000,
>   };
>   
>   #define AST2700_MAX_IRQ 256


