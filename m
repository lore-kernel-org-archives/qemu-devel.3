Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E899CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZAJ-0001Gq-U3; Mon, 09 Sep 2024 03:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ9s-0008GF-UT; Mon, 09 Sep 2024 03:50:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ9q-0004CX-Q5; Mon, 09 Sep 2024 03:50:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X2Js03lmdz4x21;
 Mon,  9 Sep 2024 17:49:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2Jrt70z4z4w2L;
 Mon,  9 Sep 2024 17:49:50 +1000 (AEST)
Message-ID: <58d936b4-8e3e-4867-b478-8341987c400e@kaod.org>
Date: Mon, 9 Sep 2024 09:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] aspeed: Add uhci support for ast2600
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-8-linux@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240906122542.3808997-8-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Li2i=QH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 9/6/24 14:25, Guenter Roeck wrote:
> Enable UHCO support for the ast2600 SoC. With this patch, the UHCI port
> is successfully instantiated on the rainier-bmc and ast2600-evb machines.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast2600.c     | 13 +++++++++++++
>   include/hw/arm/aspeed_soc.h |  3 +++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index be3eb70cdd..cd7e4ae6c9 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -33,6 +33,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_SPI2]      = 0x1E631000,
>       [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
>       [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
> +    [ASPEED_DEV_UHCI]      = 0x1E6B0000,
>       [ASPEED_DEV_MII1]      = 0x1E650000,
>       [ASPEED_DEV_MII2]      = 0x1E650008,
>       [ASPEED_DEV_MII3]      = 0x1E650010,
> @@ -110,6 +111,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_SDHCI]     = 43,
>       [ASPEED_DEV_EHCI1]     = 5,
>       [ASPEED_DEV_EHCI2]     = 9,
> +    [ASPEED_DEV_UHCI]      = 10,
>       [ASPEED_DEV_EMMC]      = 15,
>       [ASPEED_DEV_GPIO]      = 40,
>       [ASPEED_DEV_GPIO_1_8V] = 11,
> @@ -206,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                   TYPE_PLATFORM_EHCI);
>       }
>   
> +    object_initialize_child(obj, "uhci", &s->uhci, TYPE_ASPEED_UHCI);
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -481,6 +485,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                              aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
>       }
>   
> +    /* UHCI */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uhci), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->uhci), 0,
> +                    sc->memmap[ASPEED_DEV_UHCI]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uhci), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_DEV_UHCI));
> +
>       /* SDMC - SDRAM Memory Controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
>           return;
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 624d489e0d..b54849db72 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -34,6 +34,7 @@
>   #include "hw/gpio/aspeed_gpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/usb/hcd-uhci-sysbus.h"
>   #include "qom/object.h"
>   #include "hw/misc/aspeed_lpc.h"
>   #include "hw/misc/unimp.h"
> @@ -72,6 +73,7 @@ struct AspeedSoCState {
>       AspeedSMCState fmc;
>       AspeedSMCState spi[ASPEED_SPIS_NUM];
>       EHCISysBusState ehci[ASPEED_EHCIS_NUM];
> +    ASPEEDUHCIState uhci;
>       AspeedSBCState sbc;
>       AspeedSLIState sli;
>       AspeedSLIState sliio;
> @@ -193,6 +195,7 @@ enum {
>       ASPEED_DEV_SPI2,
>       ASPEED_DEV_EHCI1,
>       ASPEED_DEV_EHCI2,
> +    ASPEED_DEV_UHCI,
>       ASPEED_DEV_VIC,
>       ASPEED_DEV_INTC,
>       ASPEED_DEV_SDMC,


