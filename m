Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C3E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 13:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKdMc-0005P2-L7; Mon, 09 Dec 2024 07:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7enf=TC=kaod.org=clg@ozlabs.org>)
 id 1tKdMa-0005OX-Qq; Mon, 09 Dec 2024 07:59:48 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7enf=TC=kaod.org=clg@ozlabs.org>)
 id 1tKdMU-0001bp-4C; Mon, 09 Dec 2024 07:59:48 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y6MQD4tfFz4x4v;
 Mon,  9 Dec 2024 23:59:32 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y6MQ91cBxz4wbx;
 Mon,  9 Dec 2024 23:59:26 +1100 (AEDT)
Message-ID: <70f1ac2f-c9b5-46d0-bf0c-65ff7524ff3b@kaod.org>
Date: Mon, 9 Dec 2024 13:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241204084453.610660-1-jamin_lin@aspeedtech.com>
 <20241204084453.610660-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241204084453.610660-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7enf=TC=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/4/24 09:44, Jamin Lin wrote:
> Currently, it set the hardcode value of capability registers to all ASPEED SOCs
> However, the value of capability registers should be different for all ASPEED
> SOCs. For example: the bit 28 of the Capability Register 1 should be 1 for
> 64-bits System Bus support for AST2700.
> 
> Introduce a new "capareg" class member whose data type is uint_64 to set the
> different Capability Registers to all ASPEED SOCs.
> 
> The value of Capability Register is "0x0000000001e80080" for AST2400 and
> AST2500. The value of Capability Register is "0x0000000701f80080" for AST2600.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast2400.c      |  3 ++-
>   hw/arm/aspeed_ast2600.c      |  7 +++---
>   hw/sd/aspeed_sdhci.c         | 47 +++++++++++++++++++++++++++++++++++-
>   include/hw/sd/aspeed_sdhci.h | 12 +++++++--
>   4 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index ecc81ecc79..3c1b419945 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -224,7 +224,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
>       object_initialize_child(obj, "gpio", &s->gpio, typename);
>   
> -    object_initialize_child(obj, "sdc", &s->sdhci, TYPE_ASPEED_SDHCI);
> +    snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
> +    object_initialize_child(obj, "sdc", &s->sdhci, typename);
>   
>       object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_abort);
>   
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index c40d3d8443..b5703bd064 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -236,8 +236,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.gpio-%s-1_8v", socname);
>       object_initialize_child(obj, "gpio_1_8v", &s->gpio_1_8v, typename);
>   
> -    object_initialize_child(obj, "sd-controller", &s->sdhci,
> -                            TYPE_ASPEED_SDHCI);
> +    snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
> +    object_initialize_child(obj, "sd-controller", &s->sdhci, typename);
>   
>       object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_abort);
>   
> @@ -247,8 +247,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                   &s->sdhci.slots[i], TYPE_SYSBUS_SDHCI);
>       }
>   
> -    object_initialize_child(obj, "emmc-controller", &s->emmc,
> -                            TYPE_ASPEED_SDHCI);
> +    object_initialize_child(obj, "emmc-controller", &s->emmc, typename);
>   
>       object_property_set_int(OBJECT(&s->emmc), "num-slots", 1, &error_abort);
>   
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index acd6538261..ae2ec4a916 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -148,6 +148,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
>   {
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
> +    AspeedSDHCIClass *asc = ASPEED_SDHCI_GET_CLASS(sdhci);
>   
>       /* Create input irqs for the slots */
>       qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
> @@ -167,7 +168,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
>           }
>   
>           if (!object_property_set_uint(sdhci_slot, "capareg",
> -                                      ASPEED_SDHCI_CAPABILITIES, errp)) {
> +                                      asc->capareg, errp)) {
>               return;
>           }
>   
> @@ -218,12 +219,56 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>       device_class_set_props(dc, aspeed_sdhci_properties);
>   }
>   
> +static void aspeed_2400_sdhci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2400 SDHCI Controller";
> +    asc->capareg = 0x0000000001e80080;
> +}
> +
> +static void aspeed_2500_sdhci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2500 SDHCI Controller";
> +    asc->capareg = 0x0000000001e80080;
> +}
> +
> +static void aspeed_2600_sdhci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2600 SDHCI Controller";
> +    asc->capareg = 0x0000000701f80080;
> +}
> +
>   static const TypeInfo aspeed_sdhci_types[] = {
>       {
>           .name           = TYPE_ASPEED_SDHCI,
>           .parent         = TYPE_SYS_BUS_DEVICE,
>           .instance_size  = sizeof(AspeedSDHCIState),
>           .class_init     = aspeed_sdhci_class_init,
> +        .class_size = sizeof(AspeedSDHCIClass),
> +        .abstract = true,
> +    },
> +    {
> +        .name = TYPE_ASPEED_2400_SDHCI,
> +        .parent = TYPE_ASPEED_SDHCI,
> +        .class_init = aspeed_2400_sdhci_class_init,
> +    },
> +    {
> +        .name = TYPE_ASPEED_2500_SDHCI,
> +        .parent = TYPE_ASPEED_SDHCI,
> +        .class_init = aspeed_2500_sdhci_class_init,
> +    },
> +    {
> +        .name = TYPE_ASPEED_2600_SDHCI,
> +        .parent = TYPE_ASPEED_SDHCI,
> +        .class_init = aspeed_2600_sdhci_class_init,
>       },
>   };
>   
> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
> index 057bc5f3d1..8083797e25 100644
> --- a/include/hw/sd/aspeed_sdhci.h
> +++ b/include/hw/sd/aspeed_sdhci.h
> @@ -13,9 +13,11 @@
>   #include "qom/object.h"
>   
>   #define TYPE_ASPEED_SDHCI "aspeed.sdhci"
> -OBJECT_DECLARE_SIMPLE_TYPE(AspeedSDHCIState, ASPEED_SDHCI)
> +#define TYPE_ASPEED_2400_SDHCI TYPE_ASPEED_SDHCI "-ast2400"
> +#define TYPE_ASPEED_2500_SDHCI TYPE_ASPEED_SDHCI "-ast2500"
> +#define TYPE_ASPEED_2600_SDHCI TYPE_ASPEED_SDHCI "-ast2600"
> +OBJECT_DECLARE_TYPE(AspeedSDHCIState, AspeedSDHCIClass, ASPEED_SDHCI)
>   
> -#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
>   #define ASPEED_SDHCI_NUM_SLOTS    2
>   #define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32_t))
>   #define ASPEED_SDHCI_REG_SIZE     0x100
> @@ -32,4 +34,10 @@ struct AspeedSDHCIState {
>       uint32_t regs[ASPEED_SDHCI_NUM_REGS];
>   };
>   
> +struct AspeedSDHCIClass {
> +    SysBusDeviceClass parent_class;
> +
> +    uint64_t capareg;
> +};
> +
>   #endif /* ASPEED_SDHCI_H */


