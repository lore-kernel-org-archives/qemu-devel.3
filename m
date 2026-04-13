Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B516EBFD27
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDfo-0007CC-4H; Mon, 13 Apr 2026 05:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wCDfk-0007BX-Al
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:33:36 -0400
Received: from 10.mo533.mail-out.ovh.net ([46.105.72.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wCDfc-0005U9-Kz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:33:31 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4fvMfC2wc9z5wm4;
 Mon, 13 Apr 2026 09:33:23 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon, 13 Apr 2026 09:33:23 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.103])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4fvMfC04lkz7v45;
 Mon, 13 Apr 2026 09:33:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 36EEA2403A4B; Mon, 13 Apr 2026 09:33:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00239af5ffc-7425-4ff7-a01f-aec15dcb7842,
 F7713FC095E1F08B8E0558270325563210D84F3E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d171fb32-5a43-4855-83ca-6858ccfdec2c@kaod.org>
Date: Mon, 13 Apr 2026 11:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
 <20260224065556.3847942-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260224065556.3847942-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13286463329606151307
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF/gh+F6g+bX3gy/LsQXvLELX3I/IFlLipXbRDXdOMMZ5Saq7h8hwVchmpAyXPXDBlVfEGhOvpifKE3+E5LA69O0/TMjOjfowM1uETeUdTJFqvVamDvpU0MNG3ty3W2IzjXz7E/apYAhYsbkwSl16LdyhuSqS0n9YJSGfA6af3pTaVfFq26t2SWFqOGp4WALQEyQRvmDop10D0yiwVhQ0KdTfuGfR4IlYJdRUnXADv5g+LwnS5YStS0bZXQT9RDS5fhV3CppOk8iLziWSvJIiDVkHJeNp1mcCNwlZ0VY3oQ+ACrgpFZq78ZV3CRyqwRLmb/y+WvTv/bUhKAjOzyNd9aD292bleJ1xjapZ/9wTYsg5YDRYOGNqb4bYdvCOXxR7DtC0V4Y2LVYiIgH4RVsg8CGU0El3cyoyStvfR2XRfzx1tRbJwY4NOO4LaIGf6kUIIQjxJHyU7FY+em6DX8Z1woqN64qnPkKHKNMN2pEmafVPyiaZme8FjlnWDjlQ+a4sCJCS1gYEaYK11VIxkKmPM4TPm5jQBndfuwZX9KHBjEpj+Un5Negid2HUQTAf/n89z9xzr2mJhnIRMI8EV220eYEk8VwvZTnDse8+8kkzUxRb2Ww1tenbZgTg0zkk/4VUAYzIFq6q/H5zB2LsXF/9+Xvq2qbE1CKZ2rZVIO6DPaLA
DKIM-Signature: a=rsa-sha256; bh=XRVoK4RkaeUf/znT0NF3v86chqU2JVNDnGRFyxVNDx0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776072805; v=1;
 b=QTA+8POMELZc87xgY+10Uw3CMVHpsoHzDTQaTuCanvvvosiOJgcTjEog8JYDPp/lvQyJsWoh
 MxfH00YrlSwH3XGb6jzOX/zO2KDUF/ATZnso+EqOlmVAZWisfSg293lvEFmv8ybLj8UJddN+jEZ
 udPj8Dmf7moAdbwenv3BzCV/efHgwDQNnBwrYwkPK0JIjUTkm2IdbZ/zVgt+TDQGDcQnPSV7s1u
 Ob7cr35+VcSUKygc1ubllV76fV3wBaoMl5MK6c+8Uzv6tSFeiefsLByoDazNHbkkX+xV/BrBODO
 uftcSv7atOh90i2QveHMXFd4uRkTr/u+uFTEm3o2bhtPQ==
Received-SPF: pass client-ip=46.105.72.194; envelope-from=clg@kaod.org;
 helo=10.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/24/26 07:56, Jamin Lin wrote:
> This commit adds two MemoryRegion aliases to support PSP access to
> SSP SDRAM through shared memory remapping, as defined by the default SCU
> configuration.
> 
> The SSP exposes two DRAM aliases:
>    - remap1 maps PSP DRAM at 0x400000000 (32MB) to SSP SDRAM offset 0x2000000
>    - remap2 maps PSP DRAM at 0x42c000000 (32MB) to SSP SDRAM offset 0x0
> 
> These regions correspond to the default SCU register values, which control
> the mapping between PSP and coprocessor memory windows.
> 
> Set SSP CPUID 4 and bumps the SCU VMState version to 3.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h |  5 +++++
>   hw/arm/aspeed_ast27x0-fc.c   |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++
>   hw/arm/aspeed_ast27x0.c      |  4 ++++
>   hw/misc/aspeed_scu.c         | 42 ++++++++++++++++++++++++++++++++++--
>   5 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index d003955428..9c29ca217d 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -39,6 +39,10 @@ struct AspeedSCUState {
>       uint32_t hw_strap1;
>       uint32_t hw_strap2;
>       uint32_t hw_prot_key;
> +
> +    MemoryRegion dram_remap_alias[3];
> +    MemoryRegion *dram;
> +    int ssp_cpuid;
>   };
>   
>   #define AST2400_A1_SILICON_REV   0x02010303U
> @@ -64,6 +68,7 @@ struct AspeedSCUClass {
>       uint32_t nr_regs;
>       bool clkin_25Mhz;
>       const MemoryRegionOps *ops;
> +    void (*dram_remap)(AspeedSCUState *s, Error **errp);
>   };
>   
>   #define ASPEED_SCU_PROT_KEY      0x1688A8A8
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 5eb6680da9..77ce312591 100644
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
> index 437fff3311..4a9c8c1406 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -198,6 +198,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
>                                   &s->scu_alias);
>   
> +    /* SDRAM remap alias used by PSP to access SSP SDRAM */
> +    memory_region_add_subregion(&s->sdram, 0, &s->scu->dram_remap_alias[1]);
> +    memory_region_add_subregion(&s->sdram,
> +            memory_region_size(&s->scu->dram_remap_alias[1]),
> +            &s->scu->dram_remap_alias[0]);
> +
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
>           return;
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 87dcb82e1b..b914c01825 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -432,6 +432,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                 "hw-strap1");
>       object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                 "hw-prot-key");
> +    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&s->scu),
> +                              "ssp-cpuid");
>   
>       object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
>       qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
> @@ -794,6 +796,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                                   sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
>   
>       /* SCU */
> +    object_property_set_link(OBJECT(&s->scu), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
>           return;
>       }
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index e4160356e4..84fe88e58b 100644
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
> @@ -593,12 +594,16 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
>                             TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
>   
>       sysbus_init_mmio(sbd, &s->iomem);
> +
> +    if (asc->dram_remap) {
> +        asc->dram_remap(s, errp);
> +    }
>   }
>   
>   static const VMStateDescription vmstate_aspeed_scu = {
>       .name = "aspeed.scu",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_REGS),
>           VMSTATE_END_OF_LIST()
> @@ -610,6 +615,9 @@ static const Property aspeed_scu_properties[] = {
>       DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
>       DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
>       DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
> +    DEFINE_PROP_INT32("ssp-cpuid", AspeedSCUState, ssp_cpuid, -1),
> +    DEFINE_PROP_LINK("dram", AspeedSCUState, dram, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
>   };
>   
>   static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
> @@ -863,6 +871,35 @@ static const TypeInfo aspeed_2600_scu_info = {
>       .class_init = aspeed_2600_scu_class_init,
>   };
>   
> +static void aspeed_2700_scu_dram_remap_alias_init(AspeedSCUState *s,
> +                                                  Error **errp)
> +{
> +    if (s->ssp_cpuid > 0) {


why not introduce new Aspeed SCU subclasses with custom realize and reset
handlers instead ?

> +        if (!s->dram) {
> +            error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set");
> +            return;
> +        }
> +    }
> +
> +    if (s->ssp_cpuid > 0) {
> +        /*
> +         * The SSP coprocessor uses two memory aliases (remap1 and remap2)
> +         * to access shared memory regions in the PSP DRAM:
> +         *
> +         * - remap1 maps PSP DRAM at 0x400000000 (size: 32MB) to SSP SDRAM
> +         *   offset 0x2000000
> +         * - remap2 maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM
> +         *   offset 0x0
> +         */
> +        memory_region_init_alias(&s->dram_remap_alias[0], OBJECT(s),
> +                                 "ssp.dram.remap1", s->dram,
> +                                 0, 32 * MiB);
> +        memory_region_init_alias(&s->dram_remap_alias[1], OBJECT(s),
> +                                 "ssp.dram.remap2", s->dram,
> +                                 0x2c000000, 32 * MiB);
> +    }
> +}
> +
>   static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
>                                           unsigned size)
>   {
> @@ -973,6 +1010,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
>       asc->nr_regs = ASPEED_AST2700_SCU_NR_REGS;
>       asc->clkin_25Mhz = true;
>       asc->ops = &aspeed_ast2700_scu_ops;
> +    asc->dram_remap = aspeed_2700_scu_dram_remap_alias_init;
>   }
>   
>   static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,


