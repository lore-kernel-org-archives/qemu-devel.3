Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAFBC88E78
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 08:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkI9R-0005HD-5j; Mon, 26 Jan 2026 03:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkI9I-0005B0-UF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:40:42 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkI9G-00068q-JH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:40:40 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.71])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f026f3grFz5w7N;
 Mon, 26 Jan 2026 08:40:25 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 26 Jan
 2026 09:40:25 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002587b5450-1730-4a3d-9744-0eb3fa56dfef,
 329AED9B4B2025A2B6FD845E756CD38D93ED9099) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <45c2a602-15f4-4dfd-a228-490f8e1fe85b@kaod.org>
Date: Mon, 26 Jan 2026 09:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/22] hw/arm/aspeed: Attach UART device to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nabih Estefan <nabihestefan@google.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <20260120051859.1920565-9-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260120051859.1920565-9-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 6ab92ab9-7d09-4b1f-98a5-6debb81332b3
X-Ovh-Tracer-Id: 2916362234818104312
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGyCeJFec6/1iRVjWfkrHToij0A54MK7Edx2HBnsGuqmCGkifk82YB1V51dbVlqG0jshE3CDm+JEEWvqD0AdhotNfOu1a+oU33k5aTG7s8EZs5EOt73UXxVN3megX7maJOwb0n+ce+MCpoP/4QTq3+eNp5gdk3xdm740a5+TQ6vcmVh0ShZXL4k87pIQtrkLCIXuw9Ii5Q9mKTCCvlQxrMV8dt5jq/zeUZIWEesYlWn9oopsMqiqqOgHpt2rc3gB2yozjXmTBbeHNDeDFYNb/nyRo00NMnO3TMScv8uE84mByWHZOp97BtXA1OAgF2vnZ/W0cNEcVQox0XFx5v3OEBnhwSfUOzEqz6HBVpr7fllLdVX78EJx+LGmW4Qa7p/nLsgcKqRpsJSevYKPmQHOBLoglBGXHcsITt1nAp1QcndcBiHHgLUgpZT2yzoP0G8fLIQ2sKd0LFPzb+Iw/Jp9cPqdtvvKGrs5iuBouFLXy+JRlacuHZ9E6gInXklBBIrS8c3TVgMkQwSe7dABFwA3LoqhOvctHm/BXVXrFVPj2L2FZ2AVvyBwatVbqWFJDHTHWGZHlK1JXdWXvwDRUhMkk0A+L2YOdDDD3WSZok2+Pj6Q09jaOGnjajgfx3/z6/Ho1XdNT68Vhbmr9iXt/1iiBvKRRZ7kYaCEB/OOaSawgvCTA
DKIM-Signature: a=rsa-sha256; bh=Fl2M9KBhQlylwvolFSiEBHSrI+HpT9B8qRw+86N3OIU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769416827; v=1;
 b=LAU83VSHA2437IABZSD8blsseDetf5jCeqN+0XcFUMc1uycDHpL6jp0r00QFPAPdJV4gJVhy
 twoN2gCzLEeKjVbz3n1i98RUl4gIPMr3UkuJsNt/AineIgEhh13h3tNOYQQRwu75pmJOFemyKW/
 9jN7THI1jlFUSkKO245mnYVChDabihNyZNc+DX9j4p5LH1RcoMqfR+cViRQ/5+AnMC+M/b5Z0ex
 aqD8VYb+H88OA0jWaT0/rfkoyyxEJsAQX5sR6FQVvACz4cLLMhZdtJizSr48kBjOn5B0gwlJ/M5
 uIvwt5Bp+nGY73M60tgGdbSFaxqeOUd/sCSMr+5gQL+Tw==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/20/26 06:18, Kane Chen via qemu development wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the UART controller to the AST1700 model by mapping its MMIO
> region.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> Tested-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  2 ++
>   hw/arm/aspeed_ast1700.c         | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index addea3ab1f..b15b13aedd 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -10,6 +10,7 @@
>   
>   #include "hw/core/sysbus.h"
>   #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/char/serial-mm.h"
>   
>   #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
>   
> @@ -21,6 +22,7 @@ struct AspeedAST1700SoCState {
>       MemoryRegion iomem;
>   
>       AspeedLTPIState ltpi;
> +    SerialMM uart;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index e4c8565d3f..450ca6f5c7 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -9,15 +9,18 @@
>   #include "qemu/osdep.h"
>   #include "hw/core/boards.h"
>   #include "qom/object.h"
> +#include "hw/core/qdev-properties.h"
>   #include "hw/arm/aspeed_ast1700.h"
>   
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
>   
>   enum {
> +    ASPEED_AST1700_DEV_UART12,
>       ASPEED_AST1700_DEV_LTPI_CTRL,
>   };
>   
>   static const hwaddr aspeed_ast1700_io_memmap[] = {
> +    [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>   };
>   
> @@ -31,6 +34,17 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                          AST2700_SOC_LTPI_SIZE);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
> +    /* UART */
> +    qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
> +    qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
> +    qdev_prop_set_uint8(DEVICE(&s->uart), "endianness", DEVICE_LITTLE_ENDIAN);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0));
> +
>       /* LTPI controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>           return;
> @@ -44,6 +58,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>   {
>       AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
>   
> +    /* UART */
> +    object_initialize_child(obj, "uart[*]", &s->uart,
> +                            TYPE_SERIAL_MM);

There is only one uart device per AspeedAST1700SoCState; so you don't need
the "[*]" array suffix.

This is true for several other devices added to AspeedAST1700SoCState.
Please remove.

Thanks,

C.


> +
>       /* LTPI controller */
>       object_initialize_child(obj, "ltpi-ctrl",
>                               &s->ltpi, TYPE_ASPEED_LTPI);


