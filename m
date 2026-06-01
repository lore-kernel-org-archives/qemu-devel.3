Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4710CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2AY-00030Z-FS; Mon, 01 Jun 2026 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU2AU-0002zY-31
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:54:58 -0400
Received: from smtpout9.mo538.mail-out.ovh.net ([51.210.91.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU2AS-0008Mb-By
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:54:57 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYp40bsBz5vPK;
 Mon,  1 Jun 2026 12:54:52 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 12:54:51 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.251])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTYp35VfDz7vQQ; Mon,  1 Jun 2026 12:54:51 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 78AE712E3044;
 Mon,  1 Jun 2026 12:54:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003f3cbf691-17d6-43ae-a81c-4f3a64d21e2b,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <112ebc92-6cde-4df3-97ce-f6cb8ff421c3@kaod.org>
Date: Mon, 1 Jun 2026 14:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller
 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-7-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260529064243.2064188-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9303029458355923979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEZJNeMKoX16Q/XHRC+9YPS0qwErqrw1gv/ny+mKDcjwQIeeOBv54575JEs2Z/GpX/4ilG8j+IEe/5w4IEpNSkqX87VtdieIASIiVxGOVaBOJ2UxIijFCvdNousGNZUmRf1aKc6/lTJD5dkIXVCX7YeIUyTRl0nD4SLT22CunVO7kvf1gQdb4NxJzEYWJm3NSB17dVktWj5ZJ2j0D4CZEvAo+ip27ja3nQeABwoXHHiBSn/SNsWRYiUQaC6BUk5uivs3+ryxmnxR+puE+bhFJ6+l48BitEKht6WMrJztnGVlbJ1Pzi9pffR0Qiva+jOMnY4DmBUuX6LQI8fpRyW9xpHLOxNRU25oKVrFJ4h36FKo2A8yDR2sy8+lUBxzsz1pjFgjU9hvBBlbX0K4tjtyWnk3xfD5fZWF/7eZR7YU/azE9zrUwfngwVm12c0r92Mid4z+39C07rnhZoFMm3HV56eSGEs4qqP+zRiQJagNdCifEMJApbsfZLjYV2e02+B+l/xGyG3w9CRCfeDLdKZ1ZfX8rkCIZOk6VqN7XTvO+mqm/iXfvl+3n7YvNiC9GX1RhzAFTbEp3dSDLTtZx3/9c4QBw3iaSyaSN0DcOo840KLSWI9tu5gg56OAVX2Ibdd2A7xogdHyQq6mmjJxKy1JSsrKe5LmLI/vvhKTO9FHjd52g
DKIM-Signature: a=rsa-sha256; bh=zzf6/B7I+C3wDSOCb35wHXGxhsAMKJlSBVFk8J+cFqw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318493; v=1;
 b=s2tAUp2TZNYHFge4H9T7N6XDsLcsz87UR1RUtz/iqShUBeIbuwDFDWJzEOeVdji1eahtgsr4
 4oAUkzFKruAVND9FptIxwA97BVZKpBM1oKmBSd3O+mINX4l5kKyDQpMWFcuk+hxn92cqiEfeiRc
 EM8pjmkotR1DYHVLtHqsyK6/UH4tTyYwieGZ6AkJqEkdPAwD1IbGuZDytSS+U88kCBpZOsVvimQ
 Cw7S97QdCCAmL6GXV1KaAT9CK5jVnsMVtmwrPsgIBApIKoV8OZMUF8twZqdqUp0MO9EZk4AG5iX
 McBv9ZbfN3WBDPv9yCS708h1m/OSS3daq5lhaXlj0D8Bw==
Received-SPF: pass client-ip=51.210.91.38; envelope-from=clg@kaod.org;
 helo=smtpout9.mo538.mail-out.ovh.net
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
> The AST1040 SGPIO controller is compatible with the AST2700
> SGPIO controller implementation.
> 
> AST1040 contains two SGPIO controllers, so reuse the existing
> "aspeed.sgpio-ast2700" device model instead of keeping them as
> unimplemented devices.
> 
> MMIO mapping:
> - SGPIOM0 : 0x74C0C000
> - SGPIOM1 : 0x74C0D000
> 
> IRQ mapping:
> - SGPIOM0 : IRQ 85
> - SGPIOM1 : IRQ 88
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
> index c6b22186ce..77211ce1f3 100644
> --- a/hw/arm/aspeed_ast1040.c
> +++ b/hw/arm/aspeed_ast1040.c
> @@ -56,6 +56,7 @@ static const int aspeed_soc_ast1040_irqmap[] = {
>       [ASPEED_DEV_ADC]       = 80,
>       [ASPEED_DEV_GPIO]      = 82,
>       [ASPEED_DEV_SGPIOM0]   = 85,
> +    [ASPEED_DEV_SGPIOM1]   = 88,
>       [ASPEED_DEV_TIMER1]    = 92,
>       [ASPEED_DEV_I3C]       = 96, /* 96 ~ 103 */
>       [ASPEED_DEV_WDT]       = 112,
> @@ -112,14 +113,14 @@ static void aspeed_soc_ast1040_init(Object *obj)
>       object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>       object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],
> +                                "aspeed.sgpio-ast2700");
> +    }
>   
>       object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],
> -                            TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "jtag[0]", &s->jtag[0],
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "jtag[1]", &s->jtag[1],
> @@ -221,6 +222,17 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
>                          aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));
>   
> +    /* SGPIO */
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
> +    }
> +
>       /* Unimplemented peripherals */
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",
> @@ -234,14 +246,6 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
>                                     "aspeed.udc",
>                                     sc->memmap[ASPEED_DEV_UDC], 0x4000);
>   
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0]),
> -                                  "aspeed.sgpiom0",
> -                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);
> -
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1]),
> -                                  "aspeed.sgpiom1",
> -                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);
> -
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
>                                     "aspeed.jtag0",
>                                     sc->memmap[ASPEED_DEV_JTAG0], 0x100);
> @@ -269,6 +273,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
>       sc->sram_size[0]    = 128 * KiB;
>       sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
>       sc->uarts_num       = 13;
> +    sc->sgpio_num       = 2;
>       sc->uarts_base      = ASPEED_DEV_UART0;
>       sc->irqmap          = aspeed_soc_ast1040_irqmap;
>       sc->memmap          = aspeed_soc_ast1040_memmap;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


