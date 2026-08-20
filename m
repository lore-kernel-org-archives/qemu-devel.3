Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FCBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2Q3-0006x7-45; Thu, 20 Aug 2026 09:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wx2Q1-0006wb-2V; Thu, 20 Aug 2026 09:02:53 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wx2Py-0006Ol-Pj; Thu, 20 Aug 2026 09:02:52 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hQkBF3Q0Zz67Lg;
 Thu, 20 Aug 2026 13:02:45 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 13:02:45 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.62])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQkBF2Hqpz48x8; Thu, 20 Aug 2026 13:02:45 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 54BBF1B43F57;
 Thu, 20 Aug 2026 13:02:43 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00567fe1204-6266-4134-8c92-4dbc6d8bdd24,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <3d481220-9126-47fe-bfda-7954b7cda0e1@kaod.org>
Date: Thu, 20 Aug 2026 15:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
 <20260820081206.3353463-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260820081206.3353463-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18083359879728573485
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGl6iZAQbWNtbkebDSGUaHKrg0LQ3eV6dJYf2jlkNbLtU2r6OOPBXjDBXvyUIe+M65GGTk0iwS74/k8WdfXNlJfOJr/XXqznXmM93DmF1jhwHytjjB5+ZAlc3TFoU3oKMAUUEHR6hVPNC4Z9iFtbq0fs6GhNvtpGLVaY600pwveIeKJ6a/YHDSsDblnI3WvHHRnNiGnY/xrgayH0oujAXBqoJSUm/uwe7nf16gH/gQfzqyk9EBzq87cEY8wr/3zw5mEU4gInkQLZePlQdR3UX0oFMBfD+Z9buZOp0E25dIoX5BVxpsfad2WmBQ+39O5YIWMJPuXfw4Sgk5N+DKKJCCuTrXco93dwQzDmzmOtm7WqR76l5xb902WEzjH1YNFfX1foAjcuZsVHWXYO4ZFbUtcnVpRwJcUVtXE045E4Srhm+eCACRDRinhlDqAhFNGtsK9Vz9hnrvGp+NYCB/m2YaHKcKhk/BYFADMEe8jM0VO6MVqHe2PB8BEFF7PPUs7dcm/lkPHZjM5cOY6hFFS+dUsHVVY4esepNcDVojURZqbJefD8f6pXegkryKiF3mKYlJrskvRHDIUIYV4oMLEOCs90TX0uhl/kU5NW+miPsKfEvpl9iTE5f6FsNNaKO6hrgTFir7Y+Xa+KcsbpzUuow7LK9XoyIdKvf45LnkHKUZKcA
DKIM-Signature: a=rsa-sha256; bh=7f/rDBrsbMOoF/8E8X97b2RT9obQm/fcyu6oXMfXPI4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787230966; v=1;
 b=S/Ns1QgtaNFbSSWkWRclQH1Czd0gxYU82hC1cQ5cQX0Ro+Lw6a/QaN3zmjqgeyzxnwUy6EuY
 dKC0EEiP1Q0s6FijwAfrp1MQgpRioSqRU0Wirx+9d4rsOX8sFz0Ak7V9shp+X1jHdpOKJtulTDZ
 ZdwGJ9C4nzHDI8zYNwhk/w7hCZJ3iWlNH+PF8lSeQyev+XdDUf/sgM7m0QR7cckg6INojq+1EIm
 jUh0EAsbaf+BMi3lvLNqdnftLhFYxPngV6kMbDvjOJM8Yw6eL6ia0c8lF3D24ThV+/7djjcRB7q
 bdis+Ca8+78sCgv1tUpNcebTDqiZOD7jI+i7uJUlgVIPA==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
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

On 8/20/26 10:12, Jamin Lin wrote:
> Reuse the existing SRAM array convention on AspeedSoCState to add the
> 64 KiB ACRY SRAM region to the AST2600 at its real-silicon address
> (0x1e710000-0x1e71ffff).
> 
> Wrap the RAM in a container mapped at offset 0 so the ACRY engine wired
> up in a later patch can address the SRAM by relative offset without the
> device model knowing its mapping address.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  1 +
>   hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cd68c7f1ca..46e7854727 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -69,6 +69,7 @@ struct AspeedSoCState {
>       MemoryRegion *dram_mr;
>       MemoryRegion dram_container;
>       MemoryRegion sram[ASPEED_SRAM_NUM];
> +    MemoryRegion sram_container[ASPEED_SRAM_NUM];
>       MemoryRegion spi_boot_container;
>       MemoryRegion spi_boot;
>       MemoryRegion vbootrom;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d1f18e471a..f23a51c8a4 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/arm/aspeed_soc.h"
> @@ -24,6 +25,7 @@
>   static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
>       [ASPEED_DEV_SRAM0]     = 0x10000000,
> +    [ASPEED_DEV_SRAM1]     = 0x1E710000, /* ACRY SRAM */
>       [ASPEED_DEV_DPMCU]     = 0x18000000,
>       /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
>       [ASPEED_DEV_IOMEM]     = 0x1E600000,
> @@ -361,6 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       AspeedSoCState *s = ASPEED_SOC(dev);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       qemu_irq irq;
> +    g_autofree char *sram1_name = NULL;
>       g_autofree char *sram_name = NULL;
>       int uart;
>   
> @@ -444,6 +447,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(s->memory,
>                                   sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0]);
>   
> +    /* ACRY SRAM */
> +    sram1_name = g_strdup_printf("aspeed.acry.sram.%d",
> +                                 CPU(&a->cpu[0])->cpu_index);
> +    if (!memory_region_init_ram(&s->sram[1], OBJECT(s), sram1_name,
> +                                sc->sram_size[1], errp)) {
> +        return;
> +    }
> +    memory_region_init(&s->sram_container[1], OBJECT(s),
> +                       "aspeed.acry.sram-container", sc->sram_size[1]);
> +    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);
> +    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
> +                                &s->sram_container[1]);
> +
>       /* DPMCU */
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
> @@ -765,6 +781,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->silicon_rev  = AST2600_A3_SILICON_REV;
>       sc->sram_size[0] = 0x16400;
> +    sc->sram_size[1] = 64 * KiB; /* ACRY SRAM */
>       sc->spis_num     = 2;
>       sc->ehcis_num    = 2;
>       sc->wdts_num     = 4;

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

