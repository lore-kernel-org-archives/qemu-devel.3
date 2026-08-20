Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92CDC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwjr-0005a9-63; Thu, 20 Aug 2026 02:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwwjl-0005Xp-7b
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:58:53 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwwjh-0002GR-Sv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:58:51 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hQZ6G40FBz88w1;
 Thu, 20 Aug 2026 06:58:46 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 06:58:46 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.61])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQZ6G2tY6z1xsb; Thu, 20 Aug 2026 06:58:46 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 AC8C01923F11; Thu, 20 Aug 2026 06:58:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001b4cdd1de-1170-4ac2-94d7-7c0d50473981,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <f30198b4-89ed-4db5-8c35-81bacdc1a25a@kaod.org>
Date: Thu, 20 Aug 2026 08:58:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11936227866425928943
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEsc1vSykbRm35jTj4EXwMB1/5uGvz6IzdXE9nmneM8vn3LuJmMXPSzc+XyaYpaR47S+EKsMtc14tIGKqyzPd/+o2NBA3Kx+P3CBKNzWQlqFH/EvlHnFGAEf6IaoFsCTTV4uz9oic67Ek3oHg601vcsk22yltT61Q7dazduRII5sDgM48WQvU3XCeQqKLkWAqdqG064wOYHWmD2hIBtbxdVM4pgp0KGPlTLlM0cvz0dolAogiV2nebw9uF3uXaQUmyb4dZ2SY8j3tbsnBmGBwwJCVSDCFPKQSQUZ7k80Z0zGPgnvAY8jn/wIHQOVtk2vXzDhKb4fkbJyBADLuMwg/r7Rk+59+xK7wlHCton5CyMbLtwuNhaa5ts0/QDYDgMws9NCb/qNz1C/BiynwwgMMPkyX6mvG3ZeS4PAPySDdprNEwO/Uua2YiIbOIIYCRRTAiAsdmHTV5dQzx1k6xsp4+8yX/ZLmb6MOWQVUuRmcdmYUij7xy4yxUvxM0TSFfv/Qp8HLQQkPQ1AfymhvG2k++AvC+MkNRJlGSGiDkdw3xy637WRk5GwT9XVh/HtK/M/CEXpnnxSGPcNK6u6e6sNUB1gTdp1YpdPKiN0t1kcA11N4/BoauWBaUjbKCiWJbsMYfGDQpZkR6+KYz8FgmSiOAs12uXjH8mdSmR8OUTt9nSUw
DKIM-Signature: a=rsa-sha256; bh=dBYqgTFRMI6gTu9MRy/B+j0bBQ/CO3c/8xoLgkAlSlo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787209127; v=1;
 b=WX4CULo8kpmflErFLxO0KZEIZvHx5KGUvf5XFACPgP7BFZk7Auz8WVweXaQiYUmtH2osWN3F
 htPKjpWoD/BJuZLNn3pr3JFdZoGDokGUX772YukXZ+jSXRt/4PlkQyHz/gHA19BPPIEoR2Xdzm5
 qiP9DPYPTzEMni2LXtPz4X+dGoQtiJ7uY2ChpeITNKlnJURp/SWndZ0aNyobYFEGymK2nupTCXc
 ZrzhZW6lRRqU65+ztXft4r7RPS6GhHN8eOJsx8ltsMCrxuh7QoMLHeSt86WL4u2gWEvPTvMIrBS
 gbjFxXQBWNGi8QJsEmBTD/+WVKMFVcYScjTaGVwE8R4Xg==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/3/26 09:43, Jamin Lin wrote:
> Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC:
> map its registers and connect its interrupt.
> 
> The gadget USB device is not created by the SoC. It is a separate,
> user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a
> USB host controller's bus; it finds its controller through the "udc"
> link property, e.g.
> 
>    -device aspeed.udc-gadget,udc=/machine/soc/udc
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast2600.c     | 13 +++++++++++++
>   include/hw/arm/aspeed_soc.h |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d1f18e471a..7d97f10448 100644
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
> @@ -113,6 +114,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_SDHCI]     = 43,
>       [ASPEED_DEV_EHCI1]     = 5,
>       [ASPEED_DEV_EHCI2]     = 9,
> +    [ASPEED_DEV_UDC]       = 9,
>       [ASPEED_DEV_EMMC]      = 15,
>       [ASPEED_DEV_GPIO]      = 40,
>       [ASPEED_DEV_GPIO_1_8V] = 11,
> @@ -214,6 +216,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                   TYPE_PLATFORM_EHCI);
>       }
>   
> +    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -573,6 +577,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                                                         ASPEED_DEV_EHCI1 + i));
>       }
>   
> +    /* UDC - USB 2.0 Device Controller */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,
> +                    sc->memmap[ASPEED_DEV_UDC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,
> +                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_UDC));
> +
>       /* SDMC - SDRAM Memory Controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
>           return;
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 3aac144cd4..74fd83e957 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -36,6 +36,7 @@
>   #include "hw/gpio/aspeed_sgpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/usb/aspeed-udc.h"
>   #include "qom/object.h"
>   #include "hw/misc/aspeed_lpc.h"
>   #include "hw/misc/unimp.h"
> @@ -138,6 +139,7 @@ struct Aspeed2600SoCState {
>   
>       A15MPPrivState a7mpcore;
>       ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
> +    AspeedUDCState udc;
>   };
>   
>   #define TYPE_ASPEED2600_SOC "aspeed2600-soc"

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


