Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949CCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU67E-0000kT-O8; Mon, 01 Jun 2026 13:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU677-0000jy-Lw
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:07:45 -0400
Received: from smtpout7.mo540.mail-out.ovh.net ([51.210.91.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU675-0008Mh-Lp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:07:45 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgPl4nqZz42F1;
 Mon,  1 Jun 2026 17:07:39 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:07:39 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.208])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTgPl3DFtz1yjQ; Mon,  1 Jun 2026 17:07:39 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8EFD1940D6B; 
 Mon,  1 Jun 2026 17:07:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0016c999f98-2139-4933-a1d1-ab781837502e,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <16c3c1f6-b9fe-419e-9c08-c6c35deab439@kaod.org>
Date: Mon, 1 Jun 2026 19:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13572441905034407051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFUmlOH3HMeLSIu1oYkIio0hWQJNZdcPPKwrZfU3XrWFW1uKonScSwkJlMO52x17mNFuRq8+0UcBOtaIZWVpxT5fB2mFMIdl/nEDnkdMox9C4M+9XUuVAFXcM0OuAs3Xlkd7qX6i5ugpodtUZoEoyL+0/X0CrOPyxl4olMqSAy2ZaB7t81jgY4RFc1ix0Za0SO8XDdAXi1xoutcG6796R3hMTzsVtcwQExMeMBWwK78z58o7/d9dW/S61++c+qwSEzJO2SpXxTyHBfwhfyX0VTzXM1y/rVjKfFPaGA+3lhjwRrNj91iVhQJzZSmSxbRmZZCyMF+ESRDXf/lqGJGy0WtPkdfiFx/oKTrsPCwAA8HA2dMAEjftPjm7n7WOD7j2uuIuYCGGqZyyI7hJq+m/KIg9d2zMDTQC1PMFHk+w21WIcPz4VL2Zm30/ab0JEz9kCIWKLJ7+pjqUCwUqsbUJHnlQfYl9uQwd0trQzMpZDmbGGMtGX4W/lSelOFklfA3cjCItviuGg1lZsx/e47JrZz7e8adWCEKxTffrv+UA2XkmL/39V/dcsAgcnjLbLHSSz3YUggwHF9CheCRY5FpJOBey1/Vkuy6iRkCgXHeBSycjB67cL3xjVpOgk7SN6qTeWtJM7Rz0m9EsyVXm6Hv3a+8+EUGBanILs5xKQA2It3tsQ
DKIM-Signature: a=rsa-sha256; bh=PLkLVnEZDk3rRI4FZ5PG2Tu/0jdVXTuFEVcdx5WwOwM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780333661; v=1;
 b=lGjTSORj6cct51RuDqB5kp5cSIx0e/oZOErtVzwV0d5R3uAcMM60MxUVORoJKLeKZmyNMnid
 oBlM3MTiwcee23YlEuUm8NjVOMb931lsYsqVMmSTmtHirDL3D5Akka56gT1kiNh068L8ujN8axJ
 U3sqvM+5pDAU+wY7gq/0dTKdDgQHsAY49N8IMnFK+KHCSdXkkidPKDCgEL0jMCnPu/ZwFLYXzsk
 1fs6w0SjG9CYjO31wZ30rYIdJmV3p2MkrFct7uj8u4YZRdh6oAIUutlJsh1xDYcq9HuEASf2IJb
 je0o0qer0U29WzDdPVBOi9ZZoa6vKqbkoNY/j2oFiYZsQ==
Received-SPF: pass client-ip=51.210.91.56; envelope-from=clg@kaod.org;
 helo=smtpout7.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/17/26 05:28, Jamin Lin wrote:
> This commit adds two MemoryRegion aliases to support PSP access to
> SSP SDRAM through shared memory remapping.
> 
> The SSP exposes two DRAM aliases:
>    - remap1 maps PSP DRAM at 0x400000000 to SSP SDRAM offset 0x5880000
>    - remap2 maps PSP DRAM at 0x42C000000 to SSP SDRAM offset 0x0
> 
> These mappings follow the default SCU register configuration used by
> the ASPEED SDK firmware, which defines the memory window mapping
> between PSP and the SSP.
> 
> Set SSP CPUID 4.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h |  4 ++++
>   hw/arm/aspeed_ast27x0-fc.c   |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++
>   hw/arm/aspeed_ast27x0.c      |  4 ++++
>   hw/misc/aspeed_scu.c         | 36 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 52 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index fd30313e69..106ab4b04a 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -44,6 +44,10 @@ struct AspeedSCUState {
>   
>   struct Aspeed2700SCUState {
>       AspeedSCUState parent_obj;
> +
> +    MemoryRegion dram_remap_alias[3];
> +    MemoryRegion *dram;
> +    int ssp_cpuid;
>   };
>   
>   #define AST2400_A1_SILICON_REV   0x02010303U
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 46f0c97329..0688750e78 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -100,6 +100,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
>                               sc->uarts_num, serial_hd(1));
>       aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
>                               sc->uarts_num, serial_hd(2));
> +    object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,
> +                            &error_abort);
>       if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
>           return false;
>       }
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index edfcf1badb..0500c02755 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -199,6 +199,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
>                                   &a->scu_alias);
>   
> +    /* SDRAM remap alias used by PSP to access SSP SDRAM */
> +    memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[1]);
> +    memory_region_add_subregion(&s->sdram,
> +            memory_region_size(&a->scu->dram_remap_alias[1]),
> +            &a->scu->dram_remap_alias[0]);
> +
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
>           return;
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index e84975a9c4..e38b829cc7 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -432,6 +432,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                 "hw-strap1");
>       object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),
>                                 "hw-prot-key");
> +    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&a->scu),
> +                              "ssp-cpuid");
>   
>       object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
>       qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
> @@ -794,6 +796,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                                   sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
>   
>       /* SCU */
> +    object_property_set_link(OBJECT(&a->scu), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {
>           return;
>       }
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 51696443bd..7080bd6241 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -20,6 +20,7 @@
>   #include "qemu/guest-random.h"
>   #include "qemu/module.h"
>   #include "trace.h"
> +#include "qemu/units.h"
>   
>   #define TO_REG(offset) ((offset) >> 2)
>   
> @@ -961,9 +962,42 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
>   
>   static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)
>   {
> +    Aspeed2700SCUState *a = ASPEED_2700_SCU(dev);
> +
>       aspeed_scu_realize(dev, errp);
> +
> +    if (a->ssp_cpuid > 0) {

hmm, this 'ssp_cpuid' atribute looks like an easy way to avoid a sub class.


> +        if (!a->dram) {
> +            error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set");
> +            return;
> +        }
> +    }
> +
> +    if (a->ssp_cpuid > 0) {

double if.

> +        /*
> +         * The SSP coprocessor uses two memory aliases (remap1 and remap2)
> +         * to access shared memory regions in the PSP DRAM:
> +         *
> +         * - remap1 maps PSP DRAM at 0x400000000 (size: 0x1A77E000) to
> +         *   SSP SDRAM offset 0x5880000
> +         * - remap2 maps PSP DRAM at 0x42C000000 (size: 0x05880000) to
> +         *   SSP SDRAM offset 0x0
> +         */
> +        memory_region_init_alias(&a->dram_remap_alias[0], OBJECT(a),
> +                                 "ssp.dram.remap1", a->dram,
> +                                 0, 0x1a77e000);
> +        memory_region_init_alias(&a->dram_remap_alias[1], OBJECT(a),
> +                                 "ssp.dram.remap2", a->dram,
> +                                 0x2c000000, 0x05880000);
> +    }
>   }
>   
> +static const Property aspeed_2700_scu_properties[] = {
> +    DEFINE_PROP_INT32("ssp-cpuid", Aspeed2700SCUState, ssp_cpuid, -1),
> +    DEFINE_PROP_LINK("dram", Aspeed2700SCUState, dram, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +};
> +
>   static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -972,6 +1006,8 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
>       dc->desc = "ASPEED 2700 System Control Unit";
>       device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
>       dc->realize = aspeed_2700_scu_realize;
> +    device_class_set_props(dc, aspeed_2700_scu_properties);
> +
>       asc->resets = ast2700_a0_resets;
>       asc->calc_hpll = aspeed_2600_scu_calc_hpll;
>       asc->get_apb = aspeed_2700_scu_get_apb_freq;


