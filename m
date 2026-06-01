Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C668DCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2J2-0006U8-Ey; Mon, 01 Jun 2026 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU2J1-0006Tg-Gv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:03:47 -0400
Received: from smtpout1.mo540.mail-out.ovh.net ([51.210.91.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU2Iz-0004BL-OU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:03:47 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gTZ0G0Xqzz3wYt;
 Mon,  1 Jun 2026 13:03:42 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 13:03:41 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.103])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gTZ0F4VGPz7tjH;
 Mon,  1 Jun 2026 13:03:41 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 F09D62403043; Mon,  1 Jun 2026 13:03:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0011691990a-7c96-4bf8-8595-021fef9f0a81,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8c183f34-271c-4af2-90ea-31700b719c97@kaod.org>
Date: Mon, 1 Jun 2026 15:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog
 models
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-11-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260529064243.2064188-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9452211192925760523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGl/dIjqdgJM/NpUD3pnXqNgQDT0uUxyBa1sLRmJG4N/NPq4M9uP7IlhZuCWrfyTNZw2bnNB0znsqqLqWTFbFat/sg9uwQQFY9k7W9pB1wUVAnMT4gX1QYD6HJk5QRlMZUTw+U1qV5Fxwtt0c242wblcRAXQSJ0C3JKg9x3i6fbatScxN/+Y4f0YAiyBz3iEs7saMhv1MmeoAbmYdyRI/k3JAshjSOdNV69So+0srUL+HmXds94z7gYEgLdalZjp89MlV9rBx5L4bEJbu6ITexMbQBjQE3Iqv7exRuYMmb5o2b2p664rCK4JMrhYiC+GFkGKtCQmQXDQMJgS1RM8J+TbmiDFQ1Ej8Rh/wFRiSk2jwnnJ5OV4cBkcnFWWW037V7TNpkqrVN45nNuDv1wJ/o7mcO5rfm7yDLaqMuoE4Rzd+yP6pe/boF+UYpEZN8t5pkBqpUKmPQueGJfre4VUn7FXlJDAw6S1bj8EfWO/voQFmyLexLOTeqWSAw/IcZhZRIk5LKixK2CkhemGQ7H52woxR8kdiaT/9h0hyDYehOTm6LNNgAmj0uQK1dSINzhH72MWWXsajw7Mi6SX0EPxwDr2vzJn7p7szDIffh1f3KEQcMQp5Vj85d8BE/9KlLQ1gcl2uhYrMVaqPxDs5tKdDm2hJCzzaD2Atxu6GftFb1gvA
DKIM-Signature: a=rsa-sha256; bh=OSG+SSYFrWmlAREMXWfE/vKOJENDVYBqcKnGKj/PaYM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780319023; v=1;
 b=W/Joz1SFwX7P3IHGAH6ktcRUtOwEga3T1KLTqTwpqbKO4iVpFm2tTodFDllJZxZYGf0U2oSG
 xY1Y9JUCAzuWpG0tCMQHUvbVvSVhTvJ8FHrKb+yKw46qIAf0yeBmCufiDdR81KQG5KuKRbbPLda
 rmDT619MMo7oLKuokz+S3JlijsfwRIAtNe75rH+CuvjY9ks1fOOWjZTVMGNOthk6dqAEkzgGagf
 NSRodaX/I8TWZ/7yQk7POxbNMVyNsOWKNlj95KbSaHHQZskY5TBLXD5TV8JZW1NdX5Y9Jyttz7K
 +NxPFizH3uZXt24VF1ry1P4wsC5ccC1FQ628effr35hqQ==
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

On 5/29/26 08:42, Jamin Lin wrote:
> Instantiate and realize the watchdog models for the AST1040 SoC.
> 
> The AST1040 watchdog controller is compatible with the AST2700 watchdog
> controller, so reuse the existing AST2700 watchdog model.
> 
> Configure the AST1040 SoC with 8 watchdog instances and map them to
> their corresponding MMIO regions. The first watchdog controller (WDT0) is
> located at 0x74c37000, with subsequent watchdogs placed according to the
> controller register space size.
> 
> Each watchdog is linked to the SCU device before realization to provide the
> required reset and system control interactions.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
> index a4fe0658d5..edf28c62f9 100644
> --- a/hw/arm/aspeed_ast1040.c
> +++ b/hw/arm/aspeed_ast1040.c
> @@ -127,6 +127,11 @@ static void aspeed_soc_ast1040_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>       object_initialize_child(obj, "i2c", &s->i2c, typename);
>   
> +    for (i = 0; i < sc->wdts_num; i++) {
> +        object_initialize_child(obj, "wdt[*]", &s->wdt[i],
> +                                "aspeed.wdt-ast2700");
> +    }
> +
>       object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
> @@ -257,6 +262,19 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
>       }
>   
> +    /* Watch dog */
> +    for (i = 0; i < sc->wdts_num; i++) {
> +        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> +        hwaddr wdt_offset = sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize;
> +
> +        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
> +                                 &error_abort);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
> +    }
> +
>       /* Unimplemented peripherals */
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",
> @@ -298,6 +316,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
>       sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
>       sc->uarts_num       = 13;
>       sc->sgpio_num       = 2;
> +    sc->wdts_num        = 8;
>       sc->uarts_base      = ASPEED_DEV_UART0;
>       sc->irqmap          = aspeed_soc_ast1040_irqmap;
>       sc->memmap          = aspeed_soc_ast1040_memmap;



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


