Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C074CDE020
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1str2p-0006r3-Ez; Thu, 26 Sep 2024 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2n-0006oH-Dq; Thu, 26 Sep 2024 12:08:41 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2l-00043c-8p; Thu, 26 Sep 2024 12:08:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XDz6P2kMgz4xQS;
 Fri, 27 Sep 2024 02:08:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XDz6K37lNz4xGl;
 Fri, 27 Sep 2024 02:08:05 +1000 (AEST)
Message-ID: <97b239a9-39df-4c5e-83f3-4bee66e570e5@kaod.org>
Date: Thu, 26 Sep 2024 18:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/gpio/aspeed: Fix coding style
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240926074535.1286209-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.246, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/26/24 09:45, Jamin Lin wrote:
> Fix coding style issues from checkpatch.pl
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/gpio/aspeed_gpio.c         | 6 +++---
>   include/hw/gpio/aspeed_gpio.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 71756664dd..00fb72a509 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -340,7 +340,8 @@ static void aspeed_gpio_set_pin_level(AspeedGPIOState *s, uint32_t set_idx,
>           value &= ~pin_mask;
>       }
>   
> -    aspeed_gpio_update(s, &s->sets[set_idx], value, ~s->sets[set_idx].direction);
> +    aspeed_gpio_update(s, &s->sets[set_idx], value,
> +                       ~s->sets[set_idx].direction);
>   }
>   
>   /*
> @@ -629,7 +630,6 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
>   static void aspeed_gpio_write_index_mode(void *opaque, hwaddr offset,
>                                                   uint64_t data, uint32_t size)
>   {
> -
>       AspeedGPIOState *s = ASPEED_GPIO(opaque);
>       AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s);
>       const GPIOSetProperties *props;
> @@ -963,7 +963,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
>       aspeed_gpio_set_pin_level(s, set_idx, pin, level);
>   }
>   
> -/****************** Setup functions ******************/
> +/* Setup functions */
>   static const GPIOSetProperties ast2400_set_props[ASPEED_GPIO_MAX_NR_SETS] = {
>       [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
>       [1] = {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
> diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
> index 90a12ae318..39febda9ea 100644
> --- a/include/hw/gpio/aspeed_gpio.h
> +++ b/include/hw/gpio/aspeed_gpio.h
> @@ -88,7 +88,7 @@ struct AspeedGPIOState {
>       qemu_irq irq;
>       qemu_irq gpios[ASPEED_GPIO_MAX_NR_SETS][ASPEED_GPIOS_PER_SET];
>   
> -/* Parallel GPIO Registers */
> +    /* Parallel GPIO Registers */
>       uint32_t debounce_regs[ASPEED_GPIO_NR_DEBOUNCE_REGS];
>       struct GPIOSets {
>           uint32_t data_value; /* Reflects pin values */


