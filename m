Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FD6C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlgXO-0007nS-3G; Mon, 20 Jul 2026 01:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlgXG-0007n3-RK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:27:26 -0400
Received: from smtpout2.mo537.mail-out.ovh.net ([51.210.91.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlgXD-0007z4-Fm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:27:26 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4h3TY30fqWz405Z;
 Mon, 20 Jul 2026 05:27:19 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 20 Jul 2026 05:27:18 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.245])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h3TY25M86z6DgN; Mon, 20 Jul 2026 05:27:18 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 29803203DF1; 
 Mon, 20 Jul 2026 05:27:17 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007ca0eaccc-cb39-422d-bdb3-847e2e0c34bc,
 4C691EFFF00230C9D76A3F7E6338562E7D7850CB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bd86fbae-eb7e-4404-a48f-22972012497b@kaod.org>
Date: Mon, 20 Jul 2026 07:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 12805422594631969907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFtbC9n4aj/voKZjz0Z25TGSTSULmSCKO1OAnhQvdxPGtixyPpCUK8WYOrHlvQaVAgrRuu7FtiE83T/YwGmx8LhiE7EENQA2syQKjwel3PSxTT1SWVTQ7JnrBkg4BgjYJK5Uo+G/U+O45Lie/8xjTu4ZMKdHEnPnnf98Snf8BfJnFHUFaeoykBYnpNycsIkydytQmpmWb1d8WSUOTu2u3luMRsuBh7Wgsj3yGeioH4UA+fG4lo6iS4dLT/8rST3hBCCuTmBVzy07vDZMrmeelwg9TgHjfsufp5BwhPsGx39Uaka/GUkoVyRBh8E4pSNvCwtKQ1+Hx1/aIE+ssitMFaOe+kZsNLta9g6t+R+pNmMRV3y6yegeaf/SRfPR8ztyKGfEQKwLRRvwCKOYFUaemNOZH4vQMSuJDTziLlut3hgwytGetEBTK7PehUjdodp0kq63djnpRJW9tyb/uF0UOnxcGVs0+6UqraJ7CMZvrEftAwRqAVtsnCOIsgVYjf00Dkd6mms8WsNnToCaQJ6G5HzcytRooEfocyv9POr0ID7cB48RslAtKTLBzsVGaZ2/mObDdv95pJEmgECeYeaXeCjyiEIFFuwQDjzeKBpaRAAvcafmT/aC4STsGbupJMZcN85w2o1W6RlW/v/uX7L4gksiwCug+pOo+IuI+UdCv71VQ
DKIM-Signature: a=rsa-sha256; bh=zIgJ6wtkr7Exj6+UPEI8XbPYQsNMEeG0iJUQLIcJOuQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784525240; v=1;
 b=aqUe9UVE/71K+60zLDj8wbW7Pxgvw8i7Mo25vc6LrNdOPhTGMJ61kNRGAcVv/UTDjfist6NG
 G3BjW6ifKCXXruSLaatb113f+eKpKxh7GSlm2BkFTJ/uoiij8cAVsYQKMD4Al5rzZFCBPZrF4mN
 2UoRzLOPY67TMAww5EB/MjlYZYSgy8xTJiIM3rZqoC6Qy7RDa/YuZ19+NHrvMcT3jAk/tXYQrI2
 bRIc8PPjOCWHv/Wf5IsxHOmCfJs9Vh9MxT3g5mZNFpDOx5leCZONgCgXcJVr40T0P4S+WhiuDQW
 jPWI71R79jkmfn1NayXlPguQZlqgEBnovQ5tyGHOJlLoQ==
Received-SPF: pass client-ip=51.210.91.21; envelope-from=clg@kaod.org;
 helo=smtpout2.mo537.mail-out.ovh.net
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

Hello Jamin,

On 7/8/26 11:20, Jamin Lin wrote:
> This series improves AST2700 platform support by aligning SSP/TSP
> power and reset behavior with hardware, and enabling DRAM remapping
> required for proper firmware boot flow.
> 
> This series depends on:
> [v2,0/8] Refactor AST2700 SCU preparation for coprocessors
> https://patchwork.kernel.org/project/qemu-devel/cover/20260707060919.350637-1-jamin_lin@aspeedtech.com/
> 
> v1:
>    1. The changes move DRAM/SDMC initialization earlier to support memory
> aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement
> SSP/TSP reset, power-on, and remap controls via SCU registers.
>    2. With these updates, SSP and TSP can be booted via PSP and load their
> binaries from DRAM. Functional tests and documentation are updated
> accordingly.
> 
> v2:
>    Fix "make check" failure caused by both AST2700 and AST1700 realizing the same
>    TYPE_AST2700_SCU model.
>    
> v3:
>   1. Drop "Move DRAM and SDMC initialization earlier to support memory aliasing"
>   2. Support SPI/FMC FIFO Mode
>   3. Add unimplemented devices
> 
> v4:
>   1. Introduce Aspeed2700SCU subclass and separate from generic SCU.
>   2. Add separate reset handler for AST2700 SCUIO
>   3. Add AST2700 SCUIO RNG control and data registers
>   4. Share single SCUIO instance across PSP, SSP, and TSP
>   5. Fix AST2700 FC hardware strap settings
> 
> v5:
>   1. To speed up the review process, move the following patches into a separate
>      patch series, as they are not directly related to the main topic of this series:
>   
>      [v4,01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and separate from generic SCU
>      [v4,02/21] hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>      [v4,11/21] hw/arm/ast27x0: Share FMC controller with SSP and TSP
>      [v4,12/21] hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO regions for SSP/TSP (Merged)
>      [v4,13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions for SSP/TSP (Merged)
>      [v4,14/21] hw/block/m25p80: Implement volatile status register write enable for Winbond
>      [v4,15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700
>      [v4,16/21] hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700 SCU/SCUIO (Merged)
>      [v4,17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers (Merged)
>      [v4,18/21] hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>      [v4,19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings (Merged)
>      
>    2. Add memory_region_transaction_begin() and memory_region_transaction_commit()
>       to protect the transaction.
>      
> Jamin Lin (10):
>    hw/arm/ast27x0: Start SSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Start TSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
>    hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
>    hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap
>    hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap
>    tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP
>      and load binaries from DRAM
>    docs: Add support vbootrom and update Manual boot for ast2700fc
> 
>   docs/system/arm/aspeed.rst                    |  42 ++-
>   include/hw/misc/aspeed_scu.h                  |   5 +
>   hw/arm/aspeed_ast27x0-fc.c                    |   4 +
>   hw/arm/aspeed_ast27x0-ssp.c                   |  13 +
>   hw/arm/aspeed_ast27x0-tsp.c                   |  10 +
>   hw/arm/aspeed_ast27x0.c                       |   6 +
>   hw/misc/aspeed_scu.c                          | 285 ++++++++++++++++++
>   .../aarch64/test_aspeed_ast2700fc.py          |  29 +-
>   8 files changed, 374 insertions(+), 20 deletions(-)
> 

Here are some general comments on the design,


* Aspeed SCU Models

Aspeed2700SCUState is used by 3 instances:
- 1 PSP SCU, then linked in SSP and TSP
- 2 I/O expander SCUs (all aspeed.scu-ast2700)
   
AspeedSCUState (the parent) is used by SCUIO (aspeed.scuio-ast2700)

The I/O expander embeds Aspeed2700SCUState and gets the full
dram_remap_alias[3], ssp_cpuid, tsp_cpuid, and dram link.
none of which make sense for I/O.

Also, I doubt the whole register space is implemented for all SoCs.
This model seems overused to me and The I/O expander would need a
fix to separate the SCU type.

* remap Memory Regions

I think we need to reorganize the code.

The dram_remap Memory regions belong to the SSP and TSP coprocessor
SoC states. Makes more sense to me. The only reason they are under
SCU today is because it makes things easier for the memory region
controls.

So :

   include/hw/arm/aspeed_coprocessor.h:
   @@ -57,6 +57,8 @@ struct Aspeed27x0CoprocessorState {
        MemoryRegion scu_alias;
        MemoryRegion scuio_alias;
        MemoryRegion fmc_alias;
   +    MemoryRegion dram_remap[2];
   +    MemoryRegion *dram;
        Aspeed2700SCUState *scu;
        AspeedSCUState *scuio;
        AspeedSMCState *fmc;
        
   include/hw/misc/aspeed_scu.h:
   @@ -45,8 +45,8 @@ struct AspeedSCUState {
    struct Aspeed2700SCUState {
        AspeedSCUState parent_obj;
    
   +    MemoryRegion *ssp_remap[2];
   +    MemoryRegion *tsp_remap;

    static const Property aspeed_2700_scu_properties[] = {
   +    DEFINE_PROP_LINK("ssp-remap-0", Aspeed2700SCUState, ssp_remap[0],
   +                     TYPE_MEMORY_REGION, MemoryRegion *),
   +    DEFINE_PROP_LINK("ssp-remap-1", Aspeed2700SCUState, ssp_remap[1],
   +                     TYPE_MEMORY_REGION, MemoryRegion *),
   +    DEFINE_PROP_LINK("tsp-remap", Aspeed2700SCUState, tsp_remap,
   +                     TYPE_MEMORY_REGION, MemoryRegion *),
     };

The TSP and SSP models would initialize the alias(es) always :
   
   hw/arm/aspeed_ast27x0-ssp.c:
   +    /* DRAM remap aliases for PSP to access SSP SDRAM */
   +    memory_region_init_alias(&a->dram_remap[0], OBJECT(a),
   +                             "ssp.dram.remap1", a->dram, 0, 0x1a77e000);
   +    memory_region_init_alias(&a->dram_remap[1], OBJECT(a),
   +                             "ssp.dram.remap2", a->dram, 0x2c000000, 0x05880000);
   +    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[1]);
   +    memory_region_add_subregion(&s->sdram,
   +            memory_region_size(&a->dram_remap[1]), &a->dram_remap[0]);
   +    object_property_set_link(OBJECT(a->scu), "ssp-remap-0",
   +                             OBJECT(&a->dram_remap[0]), &error_abort);
   +    object_property_set_link(OBJECT(a->scu), "ssp-remap-1",
   +                             OBJECT(&a->dram_remap[1]), &error_abort);
    
        /* INTC */
        if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
   @@ -323,6 +330,8 @@ static const Property aspeed_27x0_coproc
                         TYPE_ASPEED_SCU, AspeedSCUState *),
        DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
                         AspeedSMCState *),
   +    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,
   +                     TYPE_MEMORY_REGION, MemoryRegion *),
    };
  
   hw/arm/aspeed_ast27x0-fc.c:
        object_property_set_link(OBJECT(&s->ssp), "sram",
                                 OBJECT(&psp->sram), &error_abort);
   +    object_property_set_link(OBJECT(&s->ssp), "dram",
   +                             OBJECT(psp->dram_mr), &error_abort);
        object_property_set_link(OBJECT(&s->ssp), "scu",
                                 OBJECT(&s->ca35.scu), &error_abort);
        object_property_set_link(OBJECT(&s->ssp), "scuio",


In SCU, we can drop the aspeed_2700_scu_realize() changes and the
control bits become :

   hw/misc/aspeed_scu.c:
        case AST2700_SCU_SSP_CTRL_1:
        case AST2700_SCU_SSP_CTRL_2:
   +        mr = (reg == AST2700_SCU_SSP_CTRL_1) ? a->ssp_remap[0] : a->ssp_remap[1];
            if (a->ssp_cpuid < 0 || mr == NULL) {
                return;
            }


* CPU index

As for the "tsp-cpuid" and "ssp-cpuid" properties, we have a
chicken&egg issue because the shared SCU model needs to be realized
and the SSP and TSP CPUs too.

I would be tempted to simply bypass QOM to avoid hardcoding cpu_index
values:

   hw/arm/aspeed_ast27x0-ssp.c:
         object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true,
                                  &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
    +    a->scu->ssp_cpuid = CPU(a->armv7m.cpu)->cpu_index;
   
         /* SDRAM */
         sdram_name = g_strdup_printf("aspeed.sdram.%d",
   
   hw/arm/aspeed_ast27x0-tsp.c:
         object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true,
                                  &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
    +    a->scu->tsp_cpuid = CPU(a->armv7m.cpu)->cpu_index;
   
         /* SDRAM */
         sdram_name = g_strdup_printf("aspeed.sdram.%d",

Or keep it that way for now.


Thanks,

C.

