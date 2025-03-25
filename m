Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E67C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7jy-0003gX-Bc; Tue, 25 Mar 2025 13:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7jv-0003g1-5x; Tue, 25 Mar 2025 13:06:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7js-0006dY-Di; Tue, 25 Mar 2025 13:06:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZMbtg1vq4z4xN8;
 Wed, 26 Mar 2025 04:06:51 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMbtc32xBz4xN4;
 Wed, 26 Mar 2025 04:06:48 +1100 (AEDT)
Message-ID: <92cef1ae-a2de-48cf-ac64-26f1dd1a8e83@kaod.org>
Date: Tue, 25 Mar 2025 18:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] ppc/pnv: Add XIVE2 controller to Power11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-9-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250325112319.927190-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=TX69=WM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/25/25 12:23, Aditya Gupta wrote:
> Add a XIVE2 controller to Power11 chip and machine.
> The controller has the same logic as Power10.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


LGTM,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv.c         | 132 ++++++++++++++++++++++++++++++++++++++++++-
>   include/hw/ppc/pnv.h |  18 ++++++
>   2 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3e63b2891279..ae2c1dcd4684 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -972,6 +972,7 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
>       Pnv11Chip *chip11 = PNV11_CHIP(chip);
>   
>       pnv_psi_pic_print_info(&chip11->psi, buf);
> +    pnv_xive2_pic_print_info(&chip11->xive, buf);
>   }
>   
>   /* Always give the first 1GB to chip 0 else we won't boot */
> @@ -1481,6 +1482,50 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>       xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
>   }
>   
> +static void pnv_chip_power11_intc_create(PnvChip *chip, PowerPCCPU *cpu,
> +                                        Error **errp)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +    Error *local_err = NULL;
> +    Object *obj;
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    /*
> +     * The core creates its interrupt presenter but the XIVE2 interrupt
> +     * controller object is initialized afterwards. Hopefully, it's
> +     * only used at runtime.
> +     */
> +    obj = xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip11->xive),
> +                           &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    pnv_cpu->intc = obj;
> +}
> +
> +static void pnv_chip_power11_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
> +}
> +
> +static void pnv_chip_power11_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
> +    pnv_cpu->intc = NULL;
> +}
> +
> +static void pnv_chip_power11_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
> +                                             GString *buf)
> +{
> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
> +}
> +
>   /*
>    * Allowed core identifiers on a POWER8 Processor Chip :
>    *
> @@ -2334,6 +2379,9 @@ static void pnv_chip_power11_instance_init(Object *obj)
>   
>       object_initialize_child(obj, "adu",  &chip11->adu, TYPE_PNV_ADU);
>       object_initialize_child(obj, "psi", &chip11->psi, TYPE_PNV11_PSI);
> +    object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
> +    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
> +                              "xive-fabric");
>       object_initialize_child(obj, "lpc", &chip11->lpc, TYPE_PNV11_LPC);
>       object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV11_OCC);
>       object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV11_SBE);
> @@ -2405,11 +2453,33 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    /* WIP: XIVE added in future patch */
> +    /* XIVE2 interrupt controller */
> +    object_property_set_int(OBJECT(&chip11->xive), "ic-bar",
> +                            PNV11_XIVE2_IC_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "esb-bar",
> +                            PNV11_XIVE2_ESB_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "end-bar",
> +                            PNV11_XIVE2_END_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "nvpg-bar",
> +                            PNV11_XIVE2_NVPG_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "nvc-bar",
> +                            PNV11_XIVE2_NVC_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "tm-bar",
> +                            PNV11_XIVE2_TM_BASE(chip), &error_fatal);
> +    object_property_set_link(OBJECT(&chip11->xive), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&chip11->xive), errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_XIVE2_BASE,
> +                            &chip11->xive.xscom_regs);
>   
>       /* Processor Service Interface (PSI) Host Bridge */
>       object_property_set_int(OBJECT(&chip11->psi), "bar",
>                               PNV11_PSIHB_BASE(chip), &error_fatal);
> +    /* PSI can be configured to use 64k ESB pages on POWER11 */
> +    object_property_set_int(OBJECT(&chip11->psi), "shift", XIVE_ESB_64K,
> +                            &error_fatal);
>       if (!qdev_realize(DEVICE(&chip11->psi), NULL, errp)) {
>           return;
>       }
> @@ -2604,6 +2674,10 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
>       k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
>       k->cores_mask = POWER11_CORE_MASK;
>       k->get_pir_tir = pnv_get_pir_tir_p10;
> +    k->intc_create = pnv_chip_power11_intc_create;
> +    k->intc_reset = pnv_chip_power11_intc_reset;
> +    k->intc_destroy = pnv_chip_power11_intc_destroy;
> +    k->intc_print_info = pnv_chip_power11_intc_print_info;
>       k->isa_create = pnv_chip_power11_isa_create;
>       k->dt_populate = pnv_chip_power11_dt_populate;
>       k->pic_print_info = pnv_chip_power11_pic_print_info;
> @@ -2972,6 +3046,54 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
>       return 0;
>   }
>   
> +static int pnv11_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool crowd, bool cam_ignore, uint8_t priority,
> +                                uint32_t logic_serv,
> +                                XiveTCTXMatch *match)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(xfb);
> +    int total_count = 0;
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
> +        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> +        int count;
> +
> +        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> +                               cam_ignore, priority, logic_serv, match);
> +
> +        if (count < 0) {
> +            return count;
> +        }
> +
> +        total_count += count;
> +    }
> +
> +    return total_count;
> +}
> +
> +static int pnv11_xive_broadcast(XiveFabric *xfb,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool crowd, bool cam_ignore,
> +                                uint8_t priority)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(xfb);
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
> +        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
> +    }
> +    return 0;
> +}
> +
> +
>   static bool pnv_machine_get_big_core(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -3149,6 +3271,7 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> +    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
>       static const char compat[] = "qemu,powernv11\0ibm,powernv";
>   
>       pmc->compat = compat;
> @@ -3158,6 +3281,9 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
>       pmc->quirk_tb_big_core = true;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
> +    xfc->match_nvt = pnv11_xive_match_nvt;
> +    xfc->broadcast = pnv11_xive_broadcast;
> +
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>   
>       mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
> @@ -3293,6 +3419,10 @@ static const TypeInfo types[] = {
>           .name          = MACHINE_TYPE_NAME("powernv11"),
>           .parent        = TYPE_PNV_MACHINE,
>           .class_init    = pnv_machine_power11_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { TYPE_XIVE_FABRIC },
> +            { },
> +        },
>       },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index f0002627bcab..cbdddfc73cd4 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -270,6 +270,24 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>   #define PNV11_PSIHB_SIZE            PNV10_PSIHB_SIZE
>   #define PNV11_PSIHB_BASE(chip)      PNV10_PSIHB_BASE(chip)
>   
> +#define PNV11_XIVE2_IC_SIZE         PNV10_XIVE2_IC_SIZE
> +#define PNV11_XIVE2_IC_BASE(chip)   PNV10_XIVE2_IC_BASE(chip)
> +
> +#define PNV11_XIVE2_TM_SIZE         PNV10_XIVE2_TM_SIZE
> +#define PNV11_XIVE2_TM_BASE(chip)   PNV10_XIVE2_TM_BASE(chip)
> +
> +#define PNV11_XIVE2_NVC_SIZE        PNV10_XIVE2_NVC_SIZE
> +#define PNV11_XIVE2_NVC_BASE(chip)  PNV10_XIVE2_NVC_BASE(chip)
> +
> +#define PNV11_XIVE2_NVPG_SIZE       PNV10_XIVE2_NVPG_SIZE
> +#define PNV11_XIVE2_NVPG_BASE(chip) PNV10_XIVE2_NVPG_BASE(chip)
> +
> +#define PNV11_XIVE2_ESB_SIZE        PNV10_XIVE2_ESB_SIZE
> +#define PNV11_XIVE2_ESB_BASE(chip)  PNV10_XIVE2_ESB_BASE(chip)
> +
> +#define PNV11_XIVE2_END_SIZE        PNV10_XIVE2_END_SIZE
> +#define PNV11_XIVE2_END_BASE(chip)  PNV10_XIVE2_END_BASE(chip)
> +
>   #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
>   
>   #endif /* PPC_PNV_H */


