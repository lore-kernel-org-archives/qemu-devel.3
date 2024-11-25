Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1020D3B7F0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUJC-0002zD-Fx; Mon, 25 Nov 2024 03:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2wM6=SU=kaod.org=clg@ozlabs.org>)
 id 1tFUIy-0002xg-Lt; Mon, 25 Nov 2024 03:18:49 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2wM6=SU=kaod.org=clg@ozlabs.org>)
 id 1tFUIv-0000Rq-UG; Mon, 25 Nov 2024 03:18:48 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XxdrQ49XNz4xcm;
 Mon, 25 Nov 2024 19:18:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XxdrM0781z4wc3;
 Mon, 25 Nov 2024 19:18:26 +1100 (AEDT)
Message-ID: <85b3fc32-130a-4a63-8e01-83c7336616ea@kaod.org>
Date: Mon, 25 Nov 2024 09:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/aspeed: Correct minimum access size for all models
To: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: BMC-SW@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241118021820.4928-1-joel@jms.id.au>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241118021820.4928-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=2wM6=SU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

Hello Joel,

On 11/18/24 03:18, Joel Stanley wrote:
> Guest code was performing a byte load to the SCU MMIO region, leading to
> the guest code crashing (it should be using proper accessors, but
> that is not Qemu's bug). Hardware and the documentation[1] both agree that
> byte loads are okay, so change all of the aspeed devices to accept a
> minimum access size of 1.

I think this is true for read ops but not for writes. You could model
the write limitation with a .accept() handler. See esp_mem_accepts()
or npcm7xx_mft_check_mem_op ().

Also, could we start by modifying first SCU since that is the IP
reported in 2636 ?


Thanks,

C.




> 
> [1] See the 'ARM Address Space Mapping' table in the ASPEED docs. This
> is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
> ast2600 datasheets.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/fsi/aspeed_apb2opb.c  | 2 +-
>   hw/gpio/aspeed_gpio.c    | 4 ++--
>   hw/intc/aspeed_vic.c     | 2 +-
>   hw/misc/aspeed_scu.c     | 4 ++--
>   hw/misc/aspeed_sdmc.c    | 2 +-
>   hw/misc/aspeed_xdma.c    | 2 +-
>   hw/net/ftgmac100.c       | 4 ++--
>   hw/sd/aspeed_sdhci.c     | 2 +-
>   hw/timer/aspeed_timer.c  | 2 +-
>   hw/watchdog/wdt_aspeed.c | 2 +-
>   10 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
> index 0e2cc143f105..855dccf6094c 100644
> --- a/hw/fsi/aspeed_apb2opb.c
> +++ b/hw/fsi/aspeed_apb2opb.c
> @@ -259,7 +259,7 @@ static const struct MemoryRegionOps aspeed_apb2opb_ops = {
>       .read = fsi_aspeed_apb2opb_read,
>       .write = fsi_aspeed_apb2opb_write,
>       .valid.max_access_size = 4,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .impl.max_access_size = 4,
>       .impl.min_access_size = 4,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index a5b3f454e800..c8bb7e590696 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -1372,7 +1372,7 @@ static const MemoryRegionOps aspeed_gpio_ops = {
>       .read       = aspeed_gpio_read,
>       .write      = aspeed_gpio_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>   };
>   
> @@ -1380,7 +1380,7 @@ static const MemoryRegionOps aspeed_gpio_2700_ops = {
>       .read       = aspeed_gpio_2700_read,
>       .write      = aspeed_gpio_2700_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>   };
>   
> diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
> index 55fe51a6675f..8ee662064469 100644
> --- a/hw/intc/aspeed_vic.c
> +++ b/hw/intc/aspeed_vic.c
> @@ -286,7 +286,7 @@ static const MemoryRegionOps aspeed_vic_ops = {
>       .read = aspeed_vic_read,
>       .write = aspeed_vic_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .valid.unaligned = false,
>   };
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 2c919349cfc0..b7a62da45907 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -436,7 +436,7 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
>       .read = aspeed_scu_read,
>       .write = aspeed_ast2500_scu_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .valid.unaligned = false,
>   };
> @@ -777,7 +777,7 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
>       .read = aspeed_ast2600_scu_read,
>       .write = aspeed_ast2600_scu_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .valid.unaligned = false,
>   };
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 4bc9faf691d6..ba700b008e5e 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -195,7 +195,7 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
>       .read = aspeed_sdmc_read,
>       .write = aspeed_sdmc_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>   };
>   
> diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
> index 1dd32f72f453..f222c632c099 100644
> --- a/hw/misc/aspeed_xdma.c
> +++ b/hw/misc/aspeed_xdma.c
> @@ -114,7 +114,7 @@ static const MemoryRegionOps aspeed_xdma_ops = {
>       .read = aspeed_xdma_read,
>       .write = aspeed_xdma_write,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>   };
>   
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 478356ee3e10..c8f6e1138ed0 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1150,7 +1150,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>   static const MemoryRegionOps ftgmac100_ops = {
>       .read = ftgmac100_read,
>       .write = ftgmac100_write,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
> @@ -1158,7 +1158,7 @@ static const MemoryRegionOps ftgmac100_ops = {
>   static const MemoryRegionOps ftgmac100_high_ops = {
>       .read = ftgmac100_high_read,
>       .write = ftgmac100_high_write,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index 98d5460905df..85e3f05e438f 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -123,7 +123,7 @@ static const MemoryRegionOps aspeed_sdhci_ops = {
>       .read = aspeed_sdhci_read,
>       .write = aspeed_sdhci_write,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>   };
>   
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 149f7cc5a6aa..a116488aa2dd 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -460,7 +460,7 @@ static const MemoryRegionOps aspeed_timer_ops = {
>       .read = aspeed_timer_read,
>       .write = aspeed_timer_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .valid.unaligned = false,
>   };
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 39c3f362a833..d9fd6fc9079f 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -229,7 +229,7 @@ static const MemoryRegionOps aspeed_wdt_ops = {
>       .read = aspeed_wdt_read,
>       .write = aspeed_wdt_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
>       .valid.unaligned = false,
>   };


