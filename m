Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40989CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9X9-0006bA-8k; Mon, 12 Oct 2026 02:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9X5-0006Sp-Ng
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:11 -0400
Received: from smtpout2.mo536.mail-out.ovh.net ([51.210.91.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9X3-0005FU-Lq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:11 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j36xb1ykQz88WS;
 Mon, 12 Oct 2026 06:29:07 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:29:07 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.8])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j36xb1C9Xz6LhR; Mon, 12 Oct 2026 06:29:07 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 B74BF1922C92; Mon, 12 Oct 2026 06:29:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001b7d52a51-917f-454f-a655-f8f57132bebc,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4e1be977-ecf6-403f-b206-380cae3acf7f@kaod.org>
Date: Mon, 12 Oct 2026 08:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/arm/aspeed_ast10x0: Add the USB device
 controller
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005064418.3060881-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9093612074194086923
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGKPEnPHmvyu3W1ULBW3Ua89lvNq9BGU+KEQnO30evsbrht7aRU9NPUW2Uei0nLNILn9GglPZIHLBdp3URCzyzKCLvGdGTPjsReLVmsqATWope8ujCB0btegPGW0ozwpn7Pj5p5bT77VfoqVMbeBaUFH+nZ89q7ebc0Gi9xb59p2/dS5okl17o7PUab1oFlp3f87wtSV3BYDpIcxUpFHAaMbbokTwe2oJuO+0FVGyt6WNdRRXBcwdst4j9690DoYZoGsTSG7SmqJ4EKVi0AdEb1Qv3vn50AiYNvPPFjOKYvs1NkqQ1s6VRVgxyOvfd4lPmSu2vdDXFlndhVSWMeHpLiJod2cjzVjJvfuNSm6nDtZ87c/Gxh5q40iw8xAssXz1ozTi89tfyJdy8dkGO35QAppw1sca6yFnLym/9OYX6rsICXgfKxomaMflb8xoOvgrIMu62/VntqF5tMUxhjyqVucaFQWXXZtZvPEmRQm87wRDfu5cJ6K2/gkDOy0UiUQLi12NID/BAr/rABgG3nxYm5Wm83n1RUrV4xysSs/S0Hp0Mr/FMjoHct58Avv8J57QGjftcJy5wQYIJQAWU3e0LptpeSIygEt6+NrAv2GFR9MS6Tf030xiXMOiOYbqkFGaXbnp4zAJM0Gegg59oCRxq90//rLekhqMfL7Fg3LiBr+w
DKIM-Signature: a=rsa-sha256; bh=YlunV2W0MPR7Tr2h8q42m4XfEnno06Sif5a9AvRxmEg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786547; v=1;
 b=RgQHvZaxyNQcI2uCUsKXovoX/3XSVG5i4C8UNo30CX9zvsQ+TVlyB+Xv4SbwUu0wY3zBccKS
 QSh6Y7qLA2mpWQKpRc8QoWF617MzzOfnCzchWFPErID6a4R5ENY/DsSdrcLmHXmjyU4imhNunUh
 NBws+TVR2B7sYG7J3DGrL0gm88KYv/Oi+1VurA+TVgvNSX4bN51uQiWXPW5E3XxqIcdgeq4Yiau
 fD3qPJQAeWlsl1YOgIt3+TMpca1pyJ/SEsr0EwplgmrYDSgaUtJYiGP7xSkUaHCcNzeKh12mn4x
 /i+6oBn6I+X/4LvJVYl1f4nRlnm5x9CJ2W079vDLr+hog==
Received-SPF: pass client-ip=51.210.91.11; envelope-from=clg@kaod.org;
 helo=smtpout2.mo536.mail-out.ovh.net
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

On 10/5/26 08:44, Jamin Lin wrote:
> Add the USB UDC device at 0x7E6A2000 with IRQ 9. The AST10x0 UDC
> controller is compatible with the AST2600 one, so reuse TYPE_ASPEED_UDC.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  1 +
>   hw/arm/aspeed_ast10x0.c     | 17 +++++++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 38226d9b80..4459188c57 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -167,6 +167,7 @@ struct Aspeed10x0SoCState {
>       AspeedSoCState parent;
>   
>       ARMv7MState armv7m;
> +    AspeedUDCState udc;
>   };
>   
>   #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index aeb5a4423d..81f2d78a45 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -162,10 +162,11 @@ static void aspeed_soc_ast10x0_init(Object *obj, const char *socname)
>       snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
>       object_initialize_child(obj, "hace", &s->hace, typename);
>   
> +    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);
> +
>       object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "sgpiom", &s->sgpiom,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "jtag[0]", &s->jtag[0],
> @@ -394,6 +395,17 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
>                          aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));
>   
> +    /* UDC - USB 2.0 Device Controller */
> +    object_property_set_link(OBJECT(&a->udc), "dram",
> +                             OBJECT(&s->sram[0]), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {
> +        return false;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,
> +                    sc->memmap[ASPEED_DEV_UDC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,
> +                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_UDC));
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",
>                                     sc->memmap[ASPEED_DEV_PWM], 0x100);
> @@ -402,9 +414,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
>                                     "aspeed.espi",
>                                     sc->memmap[ASPEED_DEV_ESPI], 0x800);
>   
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
> -                                  "aspeed.udc",
> -                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
>                                     "aspeed.sgpiom",
>                                     sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



