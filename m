Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CDCC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Hoa-0004fY-Kh; Tue, 01 Sep 2026 02:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1HoX-0004e3-Rp; Tue, 01 Sep 2026 02:17:45 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1HoV-0005Wx-Cg; Tue, 01 Sep 2026 02:17:45 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hYwdG5Kryz42WZ;
 Tue,  1 Sep 2026 06:17:38 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:17:37 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.233])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hYwdF6wytz422n;
 Tue,  1 Sep 2026 06:17:37 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 730332403FDA; Tue,  1 Sep 2026 06:17:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0016af20001-b4c2-427b-b490-f30cb50301f4,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c215ba70-a89d-4dd3-8609-283241de1f74@kaod.org>
Date: Tue, 1 Sep 2026 08:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
 <20260901024400.3488429-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901024400.3488429-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7926616820295183599
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFMixdheX3ng1ZtpoelvsaOHegl7dCwm0RO/wzH6EKbYYaUF9xh9LDET/hCIK2JYuoJ8AftbhG6/ylKrWjZoAqgt8YeYLUbMP2z3j8RL5UAwe1NkhslebEs8dLIiv3v9Dvyf2iQfQ8rNFcmjsX6QIYerpmEtP+hQmdkM2M7eAhA+Qbf+058PTooW7drNVKSMf20BimkSnEzxRyipL4NOvy9anOdNpbo2dK0QCPsxrf+5ToHtXuKj0QZKjS/Regh0+tclphRbd3Bno/9uF5Q8ucfcW+nMxwabXDiMh1JE5Pe+dNRyLvFXdXvWShBRYiN68Ll2uxK2klNUIVBacu8kN6nCdosJWHXty2P4BzEHwqlurkTPnN4kfGPXlX8QeFBFBn2TYzCun+M4A0gCrjE/eTF35iCSTiffFURprthM5chic7KbYJjG9OJCAYOW4Lxq5JtIVByxiY4YusHHAifQqtWEZId755U5cOw+/UWrdDGr04sK9TkAF0H48YgBRoG29zgzbDhM/FKgobr08thckebJtD8/b274+9G59De0DWXEjUnsRV6/Obz2i95ikyOmOeFCp8+kYtQ7ZDqo2Gc1Qs82eF2ygTochnCcHtc176hyErVtUH/xplqAa6w7VwKFDH9U0S2I0DEMl/Fqb6I8HBiQe/ZcaCpStx2mHYgTe+E4w
DKIM-Signature: a=rsa-sha256; bh=et8Mh8o01/C/p8upBH4AGQWVRwSz9WwHh+5AtGhfZiw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788243460; v=1;
 b=VEdB8/kvBn6mnLcg4dYzG3VJUveC8ukNlvB5yA6OnbbDj3h4dM41+OE99jVXT+o7QqdwbCM3
 JBWP22IxGt4aTqm7q8vVG3Fda5jR3MtpAD7kzOMePlF/4l8Qy3jHJVibsQ3a9tqDpnm1OmYx6GK
 CC97KpSiO8q6Z9gT+xZbqs56pxr5JSd/QC0lrh+lfC5niqmwjBhPvBKRVpMIByHmJgwEq6Dl82M
 oyP8JWXF2qRqNRldpLJuJD2USJDfM5KHmWusnQsifREd1T7yDW093utUQ/Okk2IJPKG+dVgxOgS
 w4nics9SSP0EbLeQHHiiQtBth5eK8sqN+rlRrcwYWEdEg==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/26 04:44, Jamin Lin wrote:
> Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC
> and map its registers.
> 
> The UDC and the second EHCI host controller (EHCI2) share one SoC
> interrupt line. Route both through an OR gate whose output drives that
> GIC input, so either device can raise the interrupt without the other
> clobbering the line.
> 
> The gadget USB device is not created by the SoC. It is a separate,
> user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a
> USB host controller's bus; it finds its controller through the "udc"
> link property, e.g.
> 
>    -device aspeed.udc-gadget,udc=/machine/soc/udc
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/arm/aspeed_soc.h |  4 ++++
>   hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cd68c7f1ca..fe7b31e42c 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -36,6 +36,8 @@
>   #include "hw/gpio/aspeed_sgpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/usb/aspeed-udc.h"
> +#include "hw/core/or-irq.h"
>   #include "qom/object.h"
>   #include "hw/misc/aspeed_lpc.h"
>   #include "hw/misc/unimp.h"
> @@ -138,6 +140,8 @@ struct Aspeed2600SoCState {
>   
>       A15MPPrivState a7mpcore;
>       ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
> +    AspeedUDCState udc;
> +    OrIRQState ehci2_udc_orgate;
>   };
>   
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d1f18e471a..21db95f5ae 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_SPI1]      = 0x1E630000,
>       [ASPEED_DEV_SPI2]      = 0x1E631000,
>       [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
> +    [ASPEED_DEV_UDC]       = 0x1E6A2000,
>       [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
>       [ASPEED_DEV_MII1]      = 0x1E650000,
>       [ASPEED_DEV_MII2]      = 0x1E650008,
> @@ -214,6 +215,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                   TYPE_PLATFORM_EHCI);
>       }
>   
> +    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);
> +    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,
> +                            TYPE_OR_IRQ);
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -561,6 +566,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                              aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 + i));
>       }
>   
> +    /*
> +     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs
> +     * together and drive that GIC input from the OR gate.
> +     */
> +    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,
> +                            &error_abort);
> +    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);
> +    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,
> +                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2));
> +
>       /* EHCI */
>       for (i = 0; i < sc->ehcis_num; i++) {
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
> @@ -568,10 +583,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>           }
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
>                           sc->memmap[ASPEED_DEV_EHCI1 + i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> -                           aspeed_soc_ast2600_get_irq(s,
> -                                                      ASPEED_DEV_EHCI1 + i));
>       }
> +    /*
> +     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it through
> +     * the OR gate.
> +     */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,
> +                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,
> +                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));
> +
> +    /* UDC - USB 2.0 Device Controller */
> +    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,
> +                    sc->memmap[ASPEED_DEV_UDC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,
> +                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));
>   
>       /* SDMC - SDRAM Memory Controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



