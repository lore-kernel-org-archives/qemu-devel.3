Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC06606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=j/l2SFU2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTel4-0001u5-HG; Wed, 18 Nov 2026 07:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTekt-0001jg-NM
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:27:17 -0500
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTekp-0000lx-DG
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:27:15 -0500
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jV17R0tW0z666Q;
 Wed, 18 Nov 2026 12:26:58 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 18 Nov 2026 12:26:58 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.208])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jV17Q2yCqz1y06; Wed, 18 Nov 2026 12:26:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id B3B7094209F; 
 Wed, 18 Nov 2026 12:26:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008661dceb2-59c2-465f-bee7-83d6c67b4e85,
 240B2D80E6D5B5AB1626C6D871A46C45E5CC6673) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fe3a41ea-c366-44e6-857e-b12ee68300b7@kaod.org>
Date: Wed, 18 Nov 2026 13:26:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
 <20260723022300.4174471-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260723022300.4174471-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11065907235049942131
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGTxOCJnjaJJesbBBbox8dhe8CwImlSPj1KC82xYwawc+LLaQEnt4lbtr8Fl9Mqpf934hRXDfNfwl+Vx4wGSvhqh8cB2YkhCTxRp8QiRiDxiKqPpUsuHwZn7SkmUK6Vz2688qjigyD2Wz585qq4aEMtnidQzeUy3cEjxhQizoYbxLl/3o8mYAUJBaUsl7SrXZxCRcGwQgJUNQqzdgisxSUkl9nueoOf3Y/CjDhdqrrNSEg6CrWhjhAyavqq81+CzlEDXscP2SsAwYxF6KIZRTkD07EXR45L9pNjgXSm3x4uI4kMNZZ64hVEY+JT2RQrx2lcM1oGUGuoRPqmlLkz1BMkjh7GBzASabpfpmHG/FwZhXKvJl7Q2xuZP4VnnfHfVogBI2XqZauIgY4WA6srJOvX04/kkt0YKu6Kk5blmmOoc6i8hajQR4DxlHxV+vccJQFArexiEMleDkF+/1qFNDqkJ1YAbX2C9sm+OLblI5Og5mR4DCtbsWyjeimltz3T8nUW8bT7tfuZEHJliHpcl3y39PMW3drihCYl/NXMkF1bBppJIYPtQLM+Etoz+Zu7pz99+L7ksD406tnHqe2unZ3jvMcOghPL8s4Ock27u/A0pJWfKF802VD1jZ9eQUdJBABafrNVODRU7yVCk941/jtI0WCnA3l6xGJS92Oqh4tkpA
DKIM-Signature: a=rsa-sha256; bh=COJZfL/aaAM/gT4VBy+tzZ0MnEwM7GD7HuNYKMaLAvA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795004820; v=1;
 b=j/l2SFU2gD1P4I2HlyTLKMbbCsTaF2G0IKllVRzooT8+j14/9wxWQ2k7IjBIV+rrLVeL2/cj
 DSAQQ1j0Z21cOwgv/F7FQXGeqbRN3K5S+m6PsWZsoHAbxmXfWMIqEqY7YmBEn9WY+RXPO2aPtkt
 8TGiT3sbMslD9x0MTlkZnhz4b20rdWzyxU8Hvxh1j2pgEck0OvUjdhlD06telLpdXnF4kwYGon2
 ghXuG7+g0/L1LPBx5YreZacUIzOUGbN25J5XSJNv/nPbuPyWghOfHUh0fCDrzJ+I47hPQGIcJGU
 veK/7H/d8vI/NFS23ObNsYPL4ghSyH71g27L9C/Ep+x0A==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jamin,

On 7/23/26 04:23, Jamin Lin wrote:
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
> The alias MemoryRegions belong to the SSP coprocessor state itself
> (Aspeed27x0CoprocessorState), since that is what they represent; the
> SCU only holds pointers to them (ssp_remap[0]/ssp_remap[1]) so its
> control registers can reposition/resize the aliases at runtime. These
> can't be QOM link properties since the SCU is already realized by the
> time the SSP sets them, so the pointers are written in directly.
> 
> The SSP cpu_index is only known once the SSP's armv7m core is
> realized, so it is written directly into the shared SCU at that
> point. Its "not wired up" default of -1 is now set explicitly in the
> SCU's own realize(), since nothing else sets it via a QOM property
> anymore.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  2 ++
>   include/hw/misc/aspeed_scu.h        |  3 +++
>   hw/arm/aspeed_ast27x0-fc.c          |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c         | 38 +++++++++++++++++++++++++++++
>   hw/misc/aspeed_scu.c                |  3 +++
>   5 files changed, 48 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index 23c3b97f06..d9d0ae7b6d 100644
> --- a/include/hw/arm/aspeed_coprocessor.h
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -52,6 +52,8 @@ struct Aspeed27x0CoprocessorState {
>       MemoryRegion scu_alias;
>       MemoryRegion scuio_alias;
>       MemoryRegion fmc_alias;
> +    MemoryRegion dram_remap[2];
> +    MemoryRegion *dram;
>       Aspeed2700SCUState *scu;
>       AspeedSCUState *scuio;
>       AspeedSMCState *fmc;
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 904549465f..01e8854104 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -44,6 +44,9 @@ struct AspeedSCUState {
>   
>   struct Aspeed2700SCUState {
>       AspeedSCUState parent_obj;
> +
> +    MemoryRegion *ssp_remap[2];
> +    int ssp_cpuid;
>   };
>   
>   #define AST2400_A1_SILICON_REV   0x02010303U
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 058cea42ed..af700e748f 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -155,6 +155,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,
>                               &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "sram",
>                                OBJECT(&psp->sram), &error_abort);
> +    object_property_set_link(OBJECT(&s->ssp), "dram",
> +                             OBJECT(psp->dram_mr), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "scu",
>                                OBJECT(&s->ca35.scu), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "scuio",

Keeping the wiring at machine level seems cleaner for shared resources.
So I think the DRAM remap regions and cpuid should be wired here too.

Something like :

     /* Wire SSP DRAM remap regions and cpuid into the shared SCU */
     object_property_set_link(OBJECT(&s->ca35.scu), "ssp-remap0",
                              OBJECT(&s->ssp.dram_remap[0]), &error_abort);
     object_property_set_link(OBJECT(&s->ca35.scu), "ssp-remap1",
                              OBJECT(&s->ssp.dram_remap[1]), &error_abort);
     s->ca35.scu.ssp_cpuid = CPU(s->ssp.armv7m.cpu)->cpu_index;

See below.

> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 9c984d23cd..2b0cf5041f 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -184,6 +184,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    if (!a->dram) {
> +        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR
> +                   ": 'dram' link is not set");
> +        return;
> +    }
> +
>       /* AST27X0 SSP Core */
>       armv7m = DEVICE(&a->armv7m);
>       qdev_prop_set_uint32(armv7m, "num-irq", 256);
> @@ -201,6 +207,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>                                &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
>   
> +    /*
> +     * cpu_index is only known once the armv7m core above is realized;
> +     * write it directly into the shared SCU.
> +     */
> +    a->scu->ssp_cpuid = CPU(a->armv7m.cpu)->cpu_index;
> +

Having the SSP and TSP SoC models reach into the shared SCU during
their own realize is a "device-modifying-another-device" pattern
that's hard to audit.


>       /* SDRAM */
>       sdram_name = g_strdup_printf("aspeed.sdram.%d",
>                                    CPU(a->armv7m.cpu)->cpu_index);
> @@ -232,6 +244,30 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],
>                                   &a->scuio_alias);
>   
> +    /*
> +     * DRAM remap aliases used by PSP to access SSP SDRAM:
> +     * - remap[0] maps PSP DRAM at 0x400000000 (size: 0x1A77E000) to
> +     *   SSP SDRAM offset 0x5880000
> +     * - remap[1] maps PSP DRAM at 0x42C000000 (size: 0x05880000) to
> +     *   SSP SDRAM offset 0x0
> +     */
> +    memory_region_init_alias(&a->dram_remap[0], OBJECT(a), "ssp.dram.remap1",
> +                             a->dram, 0, 0x1a77e000);
> +    memory_region_init_alias(&a->dram_remap[1], OBJECT(a), "ssp.dram.remap2",
> +                             a->dram, 0x2c000000, 0x05880000);
> +    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[1]);
> +    memory_region_add_subregion(&s->sdram,
> +                                memory_region_size(&a->dram_remap[1]),
> +                                &a->dram_remap[0]);
> +
> +    /*
> +     * The SCU is already realized at this point (it belongs to the PSP,
> +     * which is realized before the SSP), so the remaps are linked in
> +     * directly instead of via QOM properties.
> +     */
> +    a->scu->ssp_remap[0] = &a->dram_remap[0];
> +    a->scu->ssp_remap[1] = &a->dram_remap[1];
> +

same "device-modifying-another-device" pattern. This is true for all the
  a->scu-> assignments.

>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
>           return;
> @@ -317,6 +353,8 @@ static const Property aspeed_27x0_coprocessor_properties[] = {
>                        TYPE_ASPEED_SCU, AspeedSCUState *),
>       DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
>                        AspeedSMCState *),
> +    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index ca93c3699d..4025ea3205 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -932,6 +932,9 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)
>   
>   static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)
>   {
> +    Aspeed2700SCUState *a = ASPEED_2700_SCU(dev);
> +
> +    a->ssp_cpuid = -1;

hmm, these should be in an instance_init handler.

>       aspeed_scu_realize(dev, errp);
>   }
>   

Please try with :

static void aspeed_2700_scu_instance_init(Object *obj)
{
     Aspeed2700SCUState *a = ASPEED_2700_SCU(obj);

     a->ssp_cpuid = -1;
     a->tsp_cpuid = -1;

     object_property_add_link(obj, "ssp-remap0", TYPE_MEMORY_REGION,
                              (Object **)&a->ssp_remap[0],
                              object_property_allow_set_link, 0);
     object_property_add_link(obj, "ssp-remap1", TYPE_MEMORY_REGION,
                              (Object **)&a->ssp_remap[1],
                              object_property_allow_set_link, 0);
     object_property_add_link(obj, "tsp-remap", TYPE_MEMORY_REGION,
                              (Object **)&a->tsp_remap,
                              object_property_allow_set_link, 0);
}


and


