Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD49CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU28O-0001PG-Td; Mon, 01 Jun 2026 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU28F-0001Be-WC; Mon, 01 Jun 2026 08:52:41 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU28D-0007cg-FX; Mon, 01 Jun 2026 08:52:39 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYlN3Sx2z4CfM;
 Mon,  1 Jun 2026 12:52:31 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 12:52:31 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.134])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYlM4jMRz5vM9;
 Mon,  1 Jun 2026 12:52:31 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 39AB91923050; Mon,  1 Jun 2026 12:52:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S00233f0b467-d3a5-478e-a452-6281797a8e93,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <785dc8f5-67b1-4e62-b3e5-e3b54c961005@kaod.org>
Date: Mon, 1 Jun 2026 14:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260529064243.2064188-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9263622960828754955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTExWjqg+pYeyCCwiJ8Owucakq1Pobk3bLs1PkGxhZVYALkPnzcoRFCUkIY0VrxjwsFNtH1lmPscdKRESqPvPbpmabnKdRVJDUvfUWcpTGrszPsTXlDHC2dO6yFIq77r6hPal+dOIGEi988Epd0NOzAmF/5KIuk3YSVO0wb3MsT81DTiBU6F9W/RHDzxKv1Tk/mdxU3vXZ7kr1T3svFHNAZHDGRE8dkSlnddNwUcIFbdK+9U54ivmDwSkSO0tsVtf/CdZ7ZxVOkBXSxKSJeQLJZaPxaemwGHuOsEl34u0vnSrkF/TUp9WhDaLIJ8tWQW2JUrVvtIpWaJjkSw3s4xOar5HSto1yvlanyRYi2JK1W4+pne6xTLfX8idkr4Xdylsk9OL4davHF480knNSnxxnIGvEn1pu3cMKHUFkb/mj+suJJhWbiIfzpyfmO6yBDCAFYXQBgq9MZMFRULWcKUHeG4wFzQyQ8usjC2OJScxxNCCgpzWeT6gGHf8koEym0Ytil5ksDlu/U52WUrlGGwWJ+0Ox5pTEGfzabIldMFZC1yLtWFtePNWQGnfK2PI2aMrKVfrP+RUNRjJPUw4i/GXsPWMZoS/EG6wYUVGfIDrBrZnrw+mz4e91u6qUBghc/xF0772DxlW5Vs1ugCBi1L1L/8sR6IOstvcamJh9Z3nrPTMw
DKIM-Signature: a=rsa-sha256; bh=LKmQxycYhZOYigFdPdkS8qPhGhrpm7l1QKQ0p4UNp84=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318354; v=1;
 b=QhANSmTuexTemQe/f0R3Lxwtq57iWrrNraEJr4hgW9CRM8VMwCe1Sx0MnTG//GSWW4MACAub
 AdCYhOCIsH1U/6oXw3kEnpkIz9Yk0VIRPOXxx8PMO66ypDfVGVsaKtxTuC3ow9k46pHefcMPJ3z
 xblnMyj4sMPkBFlv+FSGSrZYelfYYhZQrYx3eRcJ02ZophB7oLtAyWLQf7mElVGQF82IOz+/aH2
 mUZBKinfNCs73hv15wn6S0k8PtsLH0wwuaPNU9BeUBlYyN7Bz4PhGZLuMqCaqQGwpTanNN6LOt6
 0R1fKVCaIS/ST8K4X+MOV3IkTeaoSboYDVyiq6LAPrjrQ==
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

On 5/29/26 08:42, Jamin Lin wrote:
> Introduce PECI support for the AST1040 SoC model.
> 
> This change adds the PECI MMIO region and IRQ mapping,
> initializes the PECI device instance, and realizes the
> controller during SoC initialization.
> 
> The PECI controller is mapped at 0x74C1F000 and connected
> to IRQ 164.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
> index b736e690e5..9ae0a0e7a4 100644
> --- a/hw/arm/aspeed_ast1040.c
> +++ b/hw/arm/aspeed_ast1040.c
> @@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast1040_memmap[] = {
>       [ASPEED_DEV_SGPIOM0]   = 0x74C0C000,
>       [ASPEED_DEV_SGPIOM1]   = 0x74C0D000,
>       [ASPEED_DEV_I2C]       = 0x74C0F000,
> +    [ASPEED_DEV_PECI]      = 0x74C1F000,
>       [ASPEED_DEV_I3C]       = 0x74C20000,
>       [ASPEED_DEV_UART0]     = 0x74C33000,
>       [ASPEED_DEV_UART1]     = 0x74C33100,
> @@ -76,6 +77,7 @@ static const int aspeed_soc_ast1040_irqmap[] = {
>       [ASPEED_DEV_UART11]    = 146,
>       [ASPEED_DEV_UART12]    = 147,
>       [ASPEED_DEV_JTAG0]     = 162,
> +    [ASPEED_DEV_PECI]      = 164,
>   };
>   
>   static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
> @@ -108,6 +110,7 @@ static void aspeed_soc_ast1040_init(Object *obj)
>       }
>   
>       object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
> +    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   
>       object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
> @@ -199,6 +202,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
>                          aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));
>   
> +    /* PECI */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
> +                    sc->memmap[ASPEED_DEV_PECI]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
> +                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));
> +
>       /* Unimplemented peripherals */
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


