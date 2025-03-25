Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BEDC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7wp-0002Tp-DT; Tue, 25 Mar 2025 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7wm-0002Tb-Dp; Tue, 25 Mar 2025 13:20:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7wi-00084r-Ow; Tue, 25 Mar 2025 13:20:16 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZMcB0631Lz4x3S;
 Wed, 26 Mar 2025 04:20:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMc9y0cRgz4xNC;
 Wed, 26 Mar 2025 04:20:05 +1100 (AEDT)
Message-ID: <e81f326c-23ea-4608-aa7b-7d49d5362ddb@kaod.org>
Date: Tue, 25 Mar 2025 18:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] ppc/pnv: Introduce Pnv11Chip
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-7-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250325112319.927190-7-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=TX69=WM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Implement Pnv11Chip, currently without chiptod, xive and phb.
> 
> Chiptod, XIVE, PHB are implemented in later patches.
> 
> Since Power11 core is same as Power10, the implementation of Pnv11Chip
> is a duplicate of corresponding Pnv10Chip.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


Looks correct, one comment below.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>


> ---
>   hw/ppc/pnv.c               | 306 +++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c          |  17 +++
>   include/hw/ppc/pnv.h       |  20 +++
>   include/hw/ppc/pnv_chip.h  |   7 +
>   include/hw/ppc/pnv_xscom.h |  49 ++++++
>   5 files changed, 399 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 63f2232f32fd..006ff62efd79 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -490,6 +490,33 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>       pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
>   }
>   
> +static void pnv_chip_power11_dt_populate(PnvChip *chip, void *fdt)
> +{
> +    static const char compat[] = "ibm,power11-xscom\0ibm,xscom";
> +    int i;
> +
> +    pnv_dt_xscom(chip, fdt, 0,
> +                 cpu_to_be64(PNV11_XSCOM_BASE(chip)),
> +                 cpu_to_be64(PNV11_XSCOM_SIZE),
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
> +    pnv_dt_lpc(chip, fdt, 0, PNV11_LPCM_BASE(chip), PNV11_LPCM_SIZE);
> +}
> +
>   static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
>   {
>       uint32_t io_base = d->ioport_id;
> @@ -822,6 +849,26 @@ static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
>       return pnv_lpc_isa_create(&chip10->lpc, false, errp);
>   }
>   
> +static ISABus *pnv_chip_power11_isa_create(PnvChip *chip, Error **errp)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +    qemu_irq irq;
> +
> +    irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPCHC);
> +    qdev_connect_gpio_out_named(DEVICE(&chip11->lpc), "LPCHC", 0, irq);
> +
> +    irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPC_SIRQ0);
> +    qdev_connect_gpio_out_named(DEVICE(&chip11->lpc), "SERIRQ", 0, irq);
> +    irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPC_SIRQ1);
> +    qdev_connect_gpio_out_named(DEVICE(&chip11->lpc), "SERIRQ", 1, irq);
> +    irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPC_SIRQ2);
> +    qdev_connect_gpio_out_named(DEVICE(&chip11->lpc), "SERIRQ", 2, irq);
> +    irq = qdev_get_gpio_in(DEVICE(&chip11->psi), PSIHB9_IRQ_LPC_SIRQ3);
> +    qdev_connect_gpio_out_named(DEVICE(&chip11->lpc), "SERIRQ", 3, irq);
> +
> +    return pnv_lpc_isa_create(&chip11->lpc, false, errp);
> +}
> +
>   static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
>   {
>       return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
> @@ -885,6 +932,12 @@ static uint64_t pnv_chip_power10_xscom_core_base(PnvChip *chip,
>       return PNV10_XSCOM_EC_BASE(core_id);
>   }
>   
> +static uint64_t pnv_chip_power11_xscom_core_base(PnvChip *chip,
> +                                                 uint32_t core_id)
> +{
> +    return PNV11_XSCOM_EC_BASE(core_id);
> +}
> +
>   static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
>   {
>       PowerPCCPUClass *ppc_default =
> @@ -914,6 +967,13 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, GString *buf)
>                            pnv_chip_power9_pic_print_info_child, buf);
>   }
>   
> +static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +
> +    pnv_psi_pic_print_info(&chip11->psi, buf);
> +}
> +
>   /* Always give the first 1GB to chip 0 else we won't boot */
>   static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
>   {
> @@ -1451,6 +1511,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>   
>   #define POWER10_CORE_MASK  (0xffffffffffffffull)
>   
> +#define POWER11_CORE_MASK  (0xffffffffffffffull)
> +
>   static void pnv_chip_power8_instance_init(Object *obj)
>   {
>       Pnv8Chip *chip8 = PNV8_CHIP(obj);
> @@ -2264,6 +2326,203 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void pnv_chip_power11_instance_init(Object *obj)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(obj);
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "adu",  &chip11->adu, TYPE_PNV_ADU);
> +    object_initialize_child(obj, "psi", &chip11->psi, TYPE_PNV11_PSI);
> +    object_initialize_child(obj, "lpc", &chip11->lpc, TYPE_PNV11_LPC);
> +    object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV11_OCC);
> +    object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV11_SBE);
> +    object_initialize_child(obj, "homer", &chip11->homer, TYPE_PNV11_HOMER);


As said earlier, if the models of the HW units above are the same
on P10 an P11, you could simply use the P10 types. That's fine.
Just add a little comment.


Thanks,

C.



> +    object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
> +                            TYPE_PNV_N1_CHIPLET);
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
> +static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
> +{
> +    PnvChip *chip = PNV_CHIP(chip11);
> +    int i;
> +
> +    chip11->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
> +    chip11->quads = g_new0(PnvQuad, chip11->nr_quads);
> +
> +    for (i = 0; i < chip11->nr_quads; i++) {
> +        PnvQuad *eq = &chip11->quads[i];
> +
> +        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> +                                  PNV_QUAD_TYPE_NAME("power11"));
> +
> +        pnv_xscom_add_subregion(chip, PNV11_XSCOM_EQ_BASE(eq->quad_id),
> +                                &eq->xscom_regs);
> +
> +        pnv_xscom_add_subregion(chip, PNV11_XSCOM_QME_BASE(eq->quad_id),
> +                                &eq->xscom_qme_regs);
> +    }
> +}
> +
> +static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> +    PnvChip *chip = PNV_CHIP(dev);
> +    Pnv11Chip *chip11 = PNV11_CHIP(dev);
> +    Error *local_err = NULL;
> +    int i;
> +
> +    /* XSCOM bridge is first */
> +    pnv_xscom_init(chip, PNV11_XSCOM_SIZE, PNV11_XSCOM_BASE(chip));
> +
> +    pcc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* ADU */
> +    object_property_set_link(OBJECT(&chip11->adu), "lpc", OBJECT(&chip11->lpc),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip11->adu), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_ADU_BASE,
> +                            &chip11->adu.xscom_regs);
> +
> +    pnv_chip_power11_quad_realize(chip11, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* WIP: XIVE added in future patch */
> +
> +    /* Processor Service Interface (PSI) Host Bridge */
> +    object_property_set_int(OBJECT(&chip11->psi), "bar",
> +                            PNV11_PSIHB_BASE(chip), &error_fatal);
> +    if (!qdev_realize(DEVICE(&chip11->psi), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_PSIHB_BASE,
> +                            &PNV_PSI(&chip11->psi)->xscom_regs);
> +
> +    /* LPC */
> +    if (!qdev_realize(DEVICE(&chip11->lpc), NULL, errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), PNV11_LPCM_BASE(chip),
> +                                &chip11->lpc.xscom_regs);
> +
> +    chip->fw_mr = &chip11->lpc.isa_fw;
> +    chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
> +                                            (uint64_t) PNV11_LPCM_BASE(chip));
> +
> +    /* HOMER (must be created before OCC) */
> +    object_property_set_link(OBJECT(&chip11->homer), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip11->homer), NULL, errp)) {
> +        return;
> +    }
> +    /* Homer Xscom region */
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_PBA_BASE,
> +                            &chip11->homer.pba_regs);
> +    /* Homer RAM region */
> +    memory_region_add_subregion(get_system_memory(), chip11->homer.base,
> +                                &chip11->homer.mem);
> +
> +    /* Create the simplified OCC model */
> +    object_property_set_link(OBJECT(&chip11->occ), "homer",
> +                             OBJECT(&chip11->homer), &error_abort);
> +    if (!qdev_realize(DEVICE(&chip11->occ), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_OCC_BASE,
> +                            &chip11->occ.xscom_regs);
> +    qdev_connect_gpio_out(DEVICE(&chip11->occ), 0, qdev_get_gpio_in(
> +                              DEVICE(&chip11->psi), PSIHB9_IRQ_OCC));
> +
> +    /* OCC SRAM model */
> +    memory_region_add_subregion(get_system_memory(),
> +                                PNV11_OCC_SENSOR_BASE(chip),
> +                                &chip11->occ.sram_regs);
> +
> +    /* SBE */
> +    if (!qdev_realize(DEVICE(&chip11->sbe), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_SBE_CTRL_BASE,
> +                            &chip11->sbe.xscom_ctrl_regs);
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_SBE_MBOX_BASE,
> +                            &chip11->sbe.xscom_mbox_regs);
> +    qdev_connect_gpio_out(DEVICE(&chip11->sbe), 0, qdev_get_gpio_in(
> +                              DEVICE(&chip11->psi), PSIHB9_IRQ_PSU));
> +
> +    /* N1 chiplet */
> +    if (!qdev_realize(DEVICE(&chip11->n1_chiplet), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_CHIPLET_CTRL_REGS_BASE,
> +             &chip11->n1_chiplet.nest_pervasive.xscom_ctrl_regs_mr);
> +
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_EQ_BASE,
> +                           &chip11->n1_chiplet.xscom_pb_eq_mr);
> +
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_ES_BASE,
> +                           &chip11->n1_chiplet.xscom_pb_es_mr);
> +
> +    /* WIP: PHB added in future patch */
> +
> +    /*
> +     * I2C
> +     */
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        Object *obj =  OBJECT(&chip11->i2c[i]);
> +
> +        object_property_set_int(obj, "engine", i + 1, &error_fatal);
> +        object_property_set_int(obj, "num-busses",
> +                                pcc->i2c_ports_per_engine[i],
> +                                &error_fatal);
> +        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV11_XSCOM_I2CM_BASE +
> +                                (chip11->i2c[i].engine - 1) *
> +                                        PNV11_XSCOM_I2CM_SIZE,
> +                                &chip11->i2c[i].xscom_regs);
> +        qdev_connect_gpio_out(DEVICE(&chip11->i2c[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&chip11->psi),
> +                                               PSIHB9_IRQ_SBE_I2C));
> +    }
> +    /* PIB SPI Controller */
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
> +        object_property_set_int(OBJECT(&chip11->pib_spic[i]), "spic_num",
> +                                i, &error_fatal);
> +        /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
> +        object_property_set_int(OBJECT(&chip11->pib_spic[i]), "transfer_len",
> +                                (i == 2) ? 1 : 4, &error_fatal);
> +        object_property_set_int(OBJECT(&chip11->pib_spic[i]), "chip-id",
> +                                chip->chip_id, &error_fatal);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
> +                                        (&chip11->pib_spic[i])), errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV11_XSCOM_PIB_SPIC_BASE +
> +                                i * PNV11_XSCOM_PIB_SPIC_SIZE,
> +                                &chip11->pib_spic[i].xscom_spic_regs);
> +    }
> +}
> +
>   static void pnv_rainier_i2c_init(PnvMachineState *pnv)
>   {
>       int i;
> @@ -2302,6 +2561,12 @@ static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
>       return addr >> 3;
>   }
>   
> +static uint32_t pnv_chip_power11_xscom_pcba(PnvChip *chip, uint64_t addr)
> +{
> +    addr &= (PNV11_XSCOM_SIZE - 1);
> +    return addr >> 3;
> +}
> +
>   static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -2329,6 +2594,29 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
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
> +    k->isa_create = pnv_chip_power11_isa_create;
> +    k->dt_populate = pnv_chip_power11_dt_populate;
> +    k->pic_print_info = pnv_chip_power11_pic_print_info;
> +    k->xscom_core_base = pnv_chip_power11_xscom_core_base;
> +    k->xscom_pcba = pnv_chip_power11_xscom_pcba;
> +    dc->desc = "PowerNV Chip Power11";
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
> @@ -2962,6 +3250,13 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
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
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> @@ -3017,6 +3312,17 @@ static const TypeInfo types[] = {
>           .abstract      = true,
>       },
>   
> +    /*
> +     * P11 chip and variants
> +     */
> +    {
> +        .name          = TYPE_PNV11_CHIP,
> +        .parent        = TYPE_PNV_CHIP,
> +        .instance_init = pnv_chip_power11_instance_init,
> +        .instance_size = sizeof(Pnv11Chip),
> +    },
> +    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
> +
>       /*
>        * P10 chip and variants
>        */
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a33977da1882..ea58d49bdd93 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -473,6 +473,11 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
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
> @@ -504,6 +509,7 @@ static const TypeInfo pnv_core_infos[] = {
>       DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
>       DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
>       DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
> +    DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
>   };
>   
>   DEFINE_TYPES(pnv_core_infos)
> @@ -725,6 +731,12 @@ static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
>       pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
>   }
>   
> +static void pnv_quad_power11_class_init(ObjectClass *oc, void *data)
> +{
> +    /* Power11 quad is similar to Power10 quad */
> +    pnv_quad_power10_class_init(oc, data);
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -752,6 +764,11 @@ static const TypeInfo pnv_quad_infos[] = {
>           .name = PNV_QUAD_TYPE_NAME("power10"),
>           .class_init = pnv_quad_power10_class_init,
>       },
> +    {
> +        .parent = TYPE_PNV_QUAD,
> +        .name = PNV_QUAD_TYPE_NAME("power11"),
> +        .class_init = pnv_quad_power11_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(pnv_quad_infos);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index d8fca079f2fe..f0002627bcab 100644
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
> @@ -252,4 +257,19 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>   #define PNV10_HOMER_BASE(chip)                                           \
>       (0x300ffd800000ll + ((uint64_t)(chip)->chip_id) * PNV_HOMER_SIZE)
>   
> +/* Power11 */
> +#define PNV11_XSCOM_SIZE            PNV10_XSCOM_SIZE
> +#define PNV11_XSCOM_BASE(chip)      PNV10_XSCOM_BASE(chip)
> +
> +#define PNV11_LPCM_SIZE             PNV10_LPCM_SIZE
> +#define PNV11_LPCM_BASE(chip)       PNV10_LPCM_BASE(chip)
> +
> +#define PNV11_PSIHB_ESB_SIZE        PNV10_PSIHB_ESB_SIZE
> +#define PNV11_PSIHB_ESB_BASE(chip)  PNV10_PSIHB_ESB_BASE(chip)
> +
> +#define PNV11_PSIHB_SIZE            PNV10_PSIHB_SIZE
> +#define PNV11_PSIHB_BASE(chip)      PNV10_PSIHB_BASE(chip)
> +
> +#define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
> +
>   #endif /* PPC_PNV_H */
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
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index a927aea1c09c..09e70ed23211 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -207,6 +207,55 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
>   #define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
>   
> +/*
> + * Power11 core is same as Power10
> + */
> +#define PNV11_XSCOM_EC_BASE(core)  PNV10_XSCOM_EC_BASE(core)
> +
> +#define PNV11_XSCOM_ADU_BASE       PNV10_XSCOM_ADU_BASE
> +#define PNV11_XSCOM_ADU_SIZE       PNV10_XSCOM_ADU_SIZE
> +
> +#define PNV11_XSCOM_QME_BASE(core) PNV10_XSCOM_QME_BASE(core)
> +
> +#define PNV11_XSCOM_EQ_BASE(core)  PNV10_XSCOM_EQ_BASE(core)
> +
> +#define PNV11_XSCOM_PSIHB_BASE     PNV10_XSCOM_PSIHB_BASE
> +#define PNV11_XSCOM_PSIHB_SIZE     PNV10_XSCOM_PSIHB_SIZE
> +
> +#define PNV11_XSCOM_I2CM_BASE      PNV10_XSCOM_I2CM_BASE
> +#define PNV11_XSCOM_I2CM_SIZE      PNV10_XSCOM_I2CM_SIZE
> +
> +#define PNV11_XSCOM_CHIPTOD_BASE   PNV10_XSCOM_CHIPTOD_BASE
> +#define PNV11_XSCOM_CHIPTOD_SIZE   PNV10_XSCOM_CHIPTOD_SIZE
> +
> +#define PNV11_XSCOM_OCC_BASE       PNV10_XSCOM_OCC_BASE
> +#define PNV11_XSCOM_OCC_SIZE       PNV10_XSCOM_OCC_SIZE
> +
> +#define PNV11_XSCOM_SBE_CTRL_BASE  PNV10_XSCOM_SBE_CTRL_BASE
> +#define PNV11_XSCOM_SBE_CTRL_SIZE  PNV10_XSCOM_SBE_CTRL_SIZE
> +
> +#define PNV11_XSCOM_SBE_MBOX_BASE  PNV10_XSCOM_SBE_MBOX_BASE
> +#define PNV11_XSCOM_SBE_MBOX_SIZE  PNV10_XSCOM_SBE_MBOX_SIZE
> +
> +#define PNV11_XSCOM_PBA_BASE       PNV10_XSCOM_PBA_BASE
> +#define PNV11_XSCOM_PBA_SIZE       PNV10_XSCOM_PBA_SIZE
> +
> +#define PNV11_XSCOM_XIVE2_BASE     PNV10_XSCOM_XIVE2_BASE
> +#define PNV11_XSCOM_XIVE2_SIZE     PNV10_XSCOM_XIVE2_SIZE
> +
> +#define PNV11_XSCOM_N1_CHIPLET_CTRL_REGS_BASE  \
> +    PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE
> +#define PNV11_XSCOM_CHIPLET_CTRL_REGS_SIZE   PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE
> +
> +#define PNV11_XSCOM_N1_PB_SCOM_EQ_BASE  PNV10_XSCOM_N1_PB_SCOM_EQ_BASE
> +#define PNV11_XSCOM_N1_PB_SCOM_EQ_SIZE  PNV10_XSCOM_N1_PB_SCOM_EQ_SIZE
> +
> +#define PNV11_XSCOM_N1_PB_SCOM_ES_BASE  PNV10_XSCOM_N1_PB_SCOM_ES_BASE
> +#define PNV11_XSCOM_N1_PB_SCOM_ES_SIZE  PNV10_XSCOM_N1_PB_SCOM_ES_SIZE
> +
> +#define PNV11_XSCOM_PIB_SPIC_BASE  PNV10_XSCOM_PIB_SPIC_BASE
> +#define PNV11_XSCOM_PIB_SPIC_SIZE  PNV10_XSCOM_PIB_SPIC_SIZE
> +
>   void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
>   int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>                    uint64_t xscom_base, uint64_t xscom_size,


