Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B25EC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 14:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trHKb-00083e-NU; Sun, 09 Mar 2025 10:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Uc6e=V4=kaod.org=clg@ozlabs.org>)
 id 1trHKa-00083L-8N; Sun, 09 Mar 2025 10:08:40 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Uc6e=V4=kaod.org=clg@ozlabs.org>)
 id 1trHKW-0006qb-SX; Sun, 09 Mar 2025 10:08:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z9hhB6HsJz4x3J;
 Mon, 10 Mar 2025 01:08:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z9hh73H36z4wby;
 Mon, 10 Mar 2025 01:08:22 +1100 (AEDT)
Message-ID: <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
Date: Sun, 9 Mar 2025 15:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-8-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250308205141.3219333-8-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Uc6e=V4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/8/25 21:51, Aditya Gupta wrote:
> Power11 core is same as Power10. Introduce a Power11 chip and machine,
> with Power10 chip as parent of Power11 chip.
> 
> Due to Power10 chip being declared as Power11 chip, all functions can
> cast 'Pnv11Chip' as 'Pnv10Chip' thus allowing it to reuse Power10's
> functionality, such as in PHB. Homer code
> 
> PowerNV11 declares a separate class_init and instance_init to be able to
> declare correct CFAM, and initialise Power11 specific child objects such
> as Homer, OCC etc. Other functionalities will use the Power10's codepath
> in Power11 for most cases.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/powernv.rst |   9 +-
>   hw/ppc/pnv.c                | 177 +++++++++++++++++++++++++++++++++++-
>   hw/ppc/pnv_core.c           |  11 +++

I would introduce the pnv_core changes in their own patch.

>   include/hw/ppc/pnv.h        |   5 +
>   include/hw/ppc/pnv_chip.h   |   7 ++
>   include/hw/ppc/pnv_core.h   |   1 +
>   6 files changed, 201 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
> index de7a807ac762..366da9bc371c 100644
> --- a/docs/system/ppc/powernv.rst
> +++ b/docs/system/ppc/powernv.rst
> @@ -1,5 +1,5 @@
> -PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
> -==================================================================
> +PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
> +================================================================================
>   
>   PowerNV (as Non-Virtualized) is the "bare metal" platform using the
>   OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
> @@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
>   Supported devices
>   -----------------
>   
> - * Multi processor support for POWER8, POWER8NVL and POWER9.
> + * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
>    * XSCOM, serial communication sideband bus to configure chiplets.
>    * Simple LPC Controller.
>    * Processor Service Interface (PSI) Controller.
> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
> +   Power11).
>    * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
>    * Simple OCC is an on-chip micro-controller used for power management tasks.
>    * iBT device to handle BMC communication, with the internal BMC simulator
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 87607508c768..1c4dc4ed1764 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -22,6 +22,7 @@
>   #include "qemu/units.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   #include "system/qtest.h"
>   #include "system/system.h"
>   #include "system/numa.h"
> @@ -486,6 +487,33 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>       pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
>   }
>   
> +static void pnv_chip_power11_dt_populate(PnvChip *chip, void *fdt)
> +{
> +    static const char compat[] = "ibm,power11-xscom\0ibm,xscom";
> +    int i;
> +
> +    pnv_dt_xscom(chip, fdt, 0,
> +                 cpu_to_be64(PNV10_XSCOM_BASE(chip)),
> +                 cpu_to_be64(PNV10_XSCOM_SIZE),
> +                 compat, sizeof(compat));
> +
> +    for (i = 0; i < chip->nr_cores; i++) {
> +        PnvCore *pnv_core = chip->cores[i];
> +        int offset;
> +
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
> +
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_31, sizeof(pa_features_31))));
> +    }
> +
> +    if (chip->ram_size) {
> +        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_size);
> +    }
> +
> +    pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
> +}
> +
>   static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
>   {
>       uint32_t io_base = d->ioport_id;
> @@ -1435,6 +1463,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>   
>   #define POWER10_CORE_MASK  (0xffffffffffffffull)
>   
> +#define POWER11_CORE_MASK  (0xffffffffffffffull)
> +
>   static void pnv_chip_power8_instance_init(Object *obj)
>   {
>       Pnv8Chip *chip8 = PNV8_CHIP(obj);
> @@ -1966,6 +1996,20 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>       int i;
>   
> +    /*
> +     * Power11 declares Power10 as it's parent class, to be able to reuse
> +     * most of the Power10 code.
> +     * But this causes Power10 and Power11's both instance init to be
> +     * called for PowerNV11 chip
> +     *
> +     * Skip initialising Power10 specific child objects, if the chip is
> +     * Power11 chip, in which case power11's instance init will initialise
> +     * the child objects
> +     */
> +    if (!strcmp(object_get_typename(obj), TYPE_PNV_CHIP_POWER11)) {
> +        return;
> +    }
> +

This is a hack !  Please duplicate the code like done for other chips.


>       object_initialize_child(obj, "adu",  &chip10->adu, TYPE_PNV_ADU);
>       object_initialize_child(obj, "xive", &chip10->xive, TYPE_PNV_XIVE2);
>       object_property_add_alias(obj, "xive-fabric", OBJECT(&chip10->xive),
> @@ -1997,7 +2041,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       }
>   }
>   
> -static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> +static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp,
> +        const char *cpu_model)


this belongs to another patch modifying P10 first.

>   {
>       PnvChip *chip = PNV_CHIP(chip10);
>       int i;
> @@ -2007,9 +2052,10 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>   
>       for (i = 0; i < chip10->nr_quads; i++) {
>           PnvQuad *eq = &chip10->quads[i];
> +        g_autofree char *type_name = PNV_QUAD_TYPE_NAME_DYN(cpu_model);
>   
>           pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> -                                  PNV_QUAD_TYPE_NAME("power10"));
> +                                  type_name);
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> @@ -2047,7 +2093,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> -static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
> +static void pnv_chip_power10_common_realize(DeviceState *dev, Error **errp,
> +        const char *cpu_model)

this belongs to another patch modifying P10 first.

>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
>       PnvChip *chip = PNV_CHIP(dev);
> @@ -2073,7 +2120,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       pnv_xscom_add_subregion(chip, PNV10_XSCOM_ADU_BASE,
>                               &chip10->adu.xscom_regs);
>   
> -    pnv_chip_power10_quad_realize(chip10, &local_err);
> +    pnv_chip_power10_quad_realize(chip10, &local_err, cpu_model);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> @@ -2235,6 +2282,54 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
> +{
> +    pnv_chip_power10_common_realize(dev, errp, "power10");
> +}
> +
> +static void pnv_chip_power11_instance_init(Object *obj)
> +{
> +    PnvChip *chip = PNV_CHIP(obj);
> +    Pnv11Chip *chip11 = PNV11_CHIP(obj);
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "adu",  &chip11->adu, TYPE_PNV_ADU);
> +    object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
> +    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
> +                              "xive-fabric");
> +    object_initialize_child(obj, "psi", &chip11->psi, TYPE_PNV11_PSI);
> +    object_initialize_child(obj, "lpc", &chip11->lpc, TYPE_PNV11_LPC);
> +    object_initialize_child(obj, "chiptod", &chip11->chiptod,
> +                            TYPE_PNV11_CHIPTOD);
> +    object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV11_OCC);
> +    object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV11_SBE);
> +    object_initialize_child(obj, "homer", &chip11->homer, TYPE_PNV11_HOMER);
> +    object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
> +                            TYPE_PNV_N1_CHIPLET);
> +
> +    chip->num_pecs = pcc->num_pecs;
> +
> +    for (i = 0; i < chip->num_pecs; i++) {
> +        object_initialize_child(obj, "pec[*]", &chip11->pecs[i],
> +                                TYPE_PNV_PHB5_PEC);
> +    }
> +
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        object_initialize_child(obj, "i2c[*]", &chip11->i2c[i], TYPE_PNV_I2C);
> +    }
> +
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
> +        object_initialize_child(obj, "pib_spic[*]", &chip11->pib_spic[i],
> +                                TYPE_PNV_SPI);
> +    }
> +}
> +
> +static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
> +{
> +    pnv_chip_power10_common_realize(dev, errp, "power11");
> +}
> +
>   static void pnv_rainier_i2c_init(PnvMachineState *pnv)
>   {
>       int i;
> @@ -2300,6 +2395,34 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>                                       &k->parent_realize);
>   }
>   
> +static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvChipClass *k = PNV_CHIP_CLASS(klass);
> +
> +    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
> +
> +    k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
> +    k->cores_mask = POWER11_CORE_MASK;
> +    k->get_pir_tir = pnv_get_pir_tir_p10;
> +    k->intc_create = pnv_chip_power10_intc_create;
> +    k->intc_reset = pnv_chip_power10_intc_reset;
> +    k->intc_destroy = pnv_chip_power10_intc_destroy;
> +    k->intc_print_info = pnv_chip_power10_intc_print_info;
> +    k->isa_create = pnv_chip_power10_isa_create;
> +    k->dt_populate = pnv_chip_power11_dt_populate;
> +    k->pic_print_info = pnv_chip_power10_pic_print_info;
> +    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
> +    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
> +    dc->desc = "PowerNV Chip POWER11";
> +    k->num_pecs = PNV10_CHIP_MAX_PEC;
> +    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> +    k->i2c_ports_per_engine = i2c_ports_per_engine;
> +
> +    device_class_set_parent_realize(dc, pnv_chip_power11_realize,
> +                                    &k->parent_realize);
> +}
> +
>   static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
>                                      Error **errp)
>   {
> @@ -2757,7 +2880,6 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>       };
>   
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");

This belongs to another patch.

>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
>       mc->alias = "powernv";
> @@ -2780,6 +2902,7 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>   
>       pnv_machine_p10_common_class_init(oc, data);
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");

ditto
>   
>       /*
>        * This is the parent of POWER10 Rainier class, so properies go here
> @@ -2806,9 +2929,26 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>   
>       pnv_machine_p10_common_class_init(oc, data);
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");

ditto

>       pmc->i2c_init = pnv_rainier_i2c_init;
>   }
>   
> +static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
> +
> +    /* do power10_class_init as p11 core is same as p10 */
> +    pnv_machine_p10_common_class_init(oc, data);
> +
> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
> +
> +    pmc->compat = compat;
> +    pmc->compat_size = sizeof(compat);
> +}
> +
>   static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>   {
>       CPUPPCState *env = cpu_env(cs);
> @@ -2914,7 +3054,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>           .parent        = TYPE_PNV10_CHIP,          \
>       }
>   
> +#define DEFINE_PNV11_CHIP_TYPE(type, class_initfn) \
> +    {                                              \
> +        .name          = type,                     \
> +        .class_init    = class_initfn,             \
> +        .parent        = TYPE_PNV11_CHIP,          \
> +    }
> +
>   static const TypeInfo types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("powernv11"),
> +        .parent        = TYPE_PNV_MACHINE,
> +        .class_init    = pnv_machine_power11_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { TYPE_XIVE_FABRIC },
> +            { },
> +        },
> +    },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
>           .parent        = MACHINE_TYPE_NAME("powernv10"),
> @@ -2969,6 +3125,17 @@ static const TypeInfo types[] = {
>           .abstract      = true,
>       },
>   
> +    /*
> +     * P11 chip and variants
> +     */
> +    {
> +        .name          = TYPE_PNV11_CHIP,
> +        .parent        = TYPE_PNV10_CHIP,

why is the parent not TYPE_PNV_CHIP like the other chips ?

This is a hack which can be easily avoided with more work :)

> +        .instance_init = pnv_chip_power11_instance_init,
> +        .instance_size = sizeof(Pnv11Chip),
> +    },
> +    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
> +
>       /*
>        * P10 chip and variants
>        */
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 99d9644ee38e..12916b15aa3b 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -469,6 +469,11 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
>       pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
>   }
>   
> +static void pnv_core_power11_class_init(ObjectClass *oc, void *data)
> +{
> +    pnv_core_power10_class_init(oc, data);
> +}
> +
>   static void pnv_core_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -500,6 +505,7 @@ static const TypeInfo pnv_core_infos[] = {
>       DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
>       DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
>       DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
> +    DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
>   };
>   
>   DEFINE_TYPES(pnv_core_infos)
> @@ -748,6 +754,11 @@ static const TypeInfo pnv_quad_infos[] = {
>           .name = PNV_QUAD_TYPE_NAME("power10"),
>           .class_init = pnv_quad_power10_class_init,
>       },
> +    {
> +        .parent = PNV_QUAD_TYPE_NAME("power10"),

why not TYPE_PNV_QUAD ?


Thanks,

C.



> +        .name = PNV_QUAD_TYPE_NAME("power11"),
> +        .class_init = pnv_quad_power10_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(pnv_quad_infos);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fcb6699150c8..ac960aa0fda9 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -33,6 +33,7 @@ typedef struct PnvChip PnvChip;
>   typedef struct Pnv8Chip Pnv8Chip;
>   typedef struct Pnv9Chip Pnv9Chip;
>   typedef struct Pnv10Chip Pnv10Chip;
> +typedef struct Pnv10Chip Pnv11Chip;
>   
>   #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
>   #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
> @@ -57,6 +58,10 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
>   DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
>                            TYPE_PNV_CHIP_POWER10)
>   
> +#define TYPE_PNV_CHIP_POWER11 PNV_CHIP_TYPE_NAME("power11_v2.0")
> +DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER11,
> +                         TYPE_PNV_CHIP_POWER11)
> +
>   PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id);
>   PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
>   
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 24ce37a9c8e4..6bd930f8b439 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -141,6 +141,13 @@ struct Pnv10Chip {
>   #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
>   #define PNV10_PIR2THREAD(pir)    (((pir) & 0x7f))
>   
> +#define TYPE_PNV11_CHIP "pnv11-chip"
> +DECLARE_INSTANCE_CHECKER(Pnv11Chip, PNV11_CHIP,
> +                         TYPE_PNV11_CHIP)
> +
> +/* Power11 core is same as Power10 */
> +typedef struct Pnv10Chip Pnv11Chip;
> +
>   struct PnvChipClass {
>       /*< private >*/
>       SysBusDeviceClass parent_class;
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index d8afb4f95f92..febe940a9af5 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -104,6 +104,7 @@ struct PnvQuadClass {
>   
>   #define PNV_QUAD_TYPE_SUFFIX "-" TYPE_PNV_QUAD
>   #define PNV_QUAD_TYPE_NAME(cpu_model) cpu_model PNV_QUAD_TYPE_SUFFIX
> +#define PNV_QUAD_TYPE_NAME_DYN(cpu) g_strconcat(cpu, PNV_QUAD_TYPE_SUFFIX, NULL)
>   
>   OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
>   


