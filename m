Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D102AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Pln-0001jj-QK; Fri, 26 Apr 2024 13:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Pll-0001ig-S4; Fri, 26 Apr 2024 13:53:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Plj-0001r5-8H; Fri, 26 Apr 2024 13:53:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VR0hY2gr3z4wyp;
 Sat, 27 Apr 2024 03:53:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VR0hV4dNmz4wcR;
 Sat, 27 Apr 2024 03:53:46 +1000 (AEST)
Message-ID: <74a0e78c-0dd2-4f48-a2f3-c0c4460f28b6@kaod.org>
Date: Fri, 26 Apr 2024 19:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-4-adityag@linux.ibm.com>
 <7ac5fa18-70be-42d2-addb-b35c9355e984@kaod.org>
 <trxofbh7pgkmmfioku4kw7c7rl4bj3dawe4zakuqcx55tnhujo@fqxgd6s3odvr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <trxofbh7pgkmmfioku4kw7c7rl4bj3dawe4zakuqcx55tnhujo@fqxgd6s3odvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=oYEp=L7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/26/24 19:34, Aditya Gupta wrote:
> Hello Cédric,
> 
>>>
>>> <...snip...>
>>>
>>> - * Multi processor support for POWER8, POWER8NVL and POWER9.
>>> + * Multi processor support for POWER8, POWER8NVL, POWER9, POWER10 and Power11.
>>
>> POWER10 -> Power10. Don't ask me why.
> 
> Sure, got it !
> 
>>
>>>     * XSCOM, serial communication sideband bus to configure chiplets.
>>>     * Simple LPC Controller.
>>>     * Processor Service Interface (PSI) Controller.
>>> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
>>> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
>>> +   Power11).
>>>     * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
>>>     * Simple OCC is an on-chip micro-controller used for power management tasks.
>>>     * iBT device to handle BMC communication, with the internal BMC simulator
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 74e7908e5ffb..06e272f3bdd3 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -431,13 +431,27 @@ static const uint8_t pa_features_31[] = { 74, 0,
>>>    static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>>>    {
>>> -    static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
>>> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
>>> +    static const char compat_p10[] = "ibm,power10-xscom\0ibm,xscom";
>>> +    static const char compat_p11[] = "ibm,power11-xscom\0ibm,xscom";
>>> +
>>> +    PnvChipType chip_type = pcc->chip_type;
>>> +    const char *compat;
>>> +    int compat_len;
>>>        int i;
>>> +    if (chip_type == PNV_TYPE_POWER11) {
>>> +        compat = compat_p11;
>>> +        compat_len = sizeof(compat_p11);
>>> +    } else {
>>> +        compat = compat_p10;
>>> +        compat_len = sizeof(compat_p10);
>>> +    }
>>
>> please introduce a pnv_chip_power11_dt_populate() routine instead.
> 
> Okay.
> 
>>
>>>        pnv_dt_xscom(chip, fdt, 0,
>>>                     cpu_to_be64(PNV10_XSCOM_BASE(chip)),
>>>                     cpu_to_be64(PNV10_XSCOM_SIZE),
>>> -                 compat, sizeof(compat));
>>> +                 compat, compat_len);
>>>        for (i = 0; i < chip->nr_cores; i++) {
>>>            PnvCore *pnv_core = chip->cores[i];
>>> @@ -1288,6 +1302,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>>>    #define POWER10_CORE_MASK  (0xffffffffffffffull)
>>> +#define POWER11_CORE_MASK  (0xffffffffffffffull)
>>> +
>>>    static void pnv_chip_power8_instance_init(Object *obj)
>>>    {
>>>        Pnv8Chip *chip8 = PNV8_CHIP(obj);
>>> @@ -1838,6 +1854,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
>>>    static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>>>    {
>>>        PnvChip *chip = PNV_CHIP(chip10);
>>> +    PnvChipClass *chip_class = PNV_CHIP_GET_CLASS(chip);
>>>        int i;
>>>        chip10->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
>>> @@ -1846,7 +1863,11 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>>>        for (i = 0; i < chip10->nr_quads; i++) {
>>>            PnvQuad *eq = &chip10->quads[i];
>>> -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
>>> +        if (chip_class->chip_type == PNV_TYPE_POWER11)
>>> +            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
>>> +                                  PNV_QUAD_TYPE_NAME("power11"));
>>> +        else
>>> +            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
>>>                                      PNV_QUAD_TYPE_NAME("power10"));
>>
>>
>> Please change introduce a new pnv_chip_quad_realize() routine taking an
>> extra type_name argument.
> 
> Sure, can do it. But as it's called from 'pnv_chip_power10_realize',
> might require a 'pnv_chip_power11_realize' function also, so it can pass
> type_name as "power11" vs "power10".

Do the Power11 and Power10 processors have the same XSCOM and MMIO
address spaces ?

> Will do it.
> 
>>
>>
>>>            pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>>> @@ -2116,6 +2137,35 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>>>                                        &k->parent_realize);
>>>    }
>>> +static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    PnvChipClass *k = PNV_CHIP_CLASS(klass);
>>> +
>>> +    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
>>> +
>>> +    k->chip_cfam_id = 0x120da04900008000ull; /* P11 (with NX) */
>>> +    k->chip_type = PNV_TYPE_POWER11;
>>> +    k->cores_mask = POWER11_CORE_MASK;
>>> +    k->chip_pir = pnv_chip_pir_p10;
>>> +    k->intc_create = pnv_chip_power10_intc_create;
>>> +    k->intc_reset = pnv_chip_power10_intc_reset;
>>> +    k->intc_destroy = pnv_chip_power10_intc_destroy;
>>> +    k->intc_print_info = pnv_chip_power10_intc_print_info;
>>> +    k->isa_create = pnv_chip_power10_isa_create;
>>> +    k->dt_populate = pnv_chip_power10_dt_populate;
>>> +    k->pic_print_info = pnv_chip_power10_pic_print_info;
>>> +    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
>>> +    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
>>> +    dc->desc = "PowerNV Chip POWER11";
>>> +    k->num_pecs = PNV10_CHIP_MAX_PEC;
>>> +    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
>>> +    k->i2c_ports_per_engine = i2c_ports_per_engine;
>>> +
>>> +    device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>>> +                                    &k->parent_realize);
>>> +}
>>> +
>>>    static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
>>>    {
>>>        PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
>>> @@ -2510,6 +2560,22 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>>>        pmc->i2c_init = pnv_rainier_i2c_init;
>>>    }
>>> +static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    MachineClass *mc = MACHINE_CLASS(oc);
>>> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
>>> +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
>>> +
>>> +    /* do power10_class_init as p11 core is same as p10 */
>>> +    pnv_machine_p10_common_class_init(oc, data);
>>> +
>>> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
>>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
>>
>> This should be using a versionned CPU "power11_vx.y".
> 
> Okay.
> 
>>
>>> +
>>> +    pmc->compat = compat;
>>> +    pmc->compat_size = sizeof(compat);
>>> +}
>>> +
>>>    static bool pnv_machine_get_hb(Object *obj, Error **errp)
>>>    {
>>>        PnvMachineState *pnv = PNV_MACHINE(obj);
>>> @@ -2613,7 +2679,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>>>            .parent        = TYPE_PNV10_CHIP,          \
>>>        }
>>> +#define DEFINE_PNV11_CHIP_TYPE(type, class_initfn) \
>>> +    {                                              \
>>> +        .name          = type,                     \
>>> +        .class_init    = class_initfn,             \
>>> +        .parent        = TYPE_PNV11_CHIP,          \
>>> +    }
>>> +
>>>    static const TypeInfo types[] = {
>>> +    {
>>> +        .name          = MACHINE_TYPE_NAME("powernv11"),
>>> +        .parent        = TYPE_PNV_MACHINE,
>>> +        .class_init    = pnv_machine_power11_class_init,
>>> +        .interfaces = (InterfaceInfo[]) {
>>> +            { TYPE_XIVE_FABRIC },
>>> +            { },
>>> +        },
>>> +    },
>>>        {
>>>            .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
>>>            .parent        = MACHINE_TYPE_NAME("powernv10"),
>>> @@ -2668,6 +2750,16 @@ static const TypeInfo types[] = {
>>>            .abstract      = true,
>>>        },
>>> +    /*
>>> +     * P11 chip and variants
>>> +     */
>>> +    {
>>> +        .name          = TYPE_PNV11_CHIP,
>>> +        .parent        = TYPE_PNV10_CHIP,
>>> +        .instance_size = sizeof(Pnv11Chip),
>>> +    },
>>> +    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
>>> +
>>>        /*
>>>         * P10 chip and variants
>>>         */
>>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>>> index f40ab721d6fc..4522655793da 100644
>>> --- a/hw/ppc/pnv_core.c
>>> +++ b/hw/ppc/pnv_core.c
>>> @@ -402,7 +402,16 @@ static const TypeInfo pnv_core_infos[] = {
>>>        DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
>>>        DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
>>>        DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
>>> -    DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
>>> +    {
>>> +        .parent = TYPE_PNV_CORE,
>>> +        .name = PNV_CORE_TYPE_NAME("power10_v2.0"),
>>> +        .class_init = pnv_core_power10_class_init,
>>> +        .class_base_init = pnv_core_power10_class_init,
>>> +    },
>>
>> hmm, what is this change ?
> 
> I expanded the macro, to add '.class_base_init', as .class_base_init
> will be run by QEMU during initialisation of any child classes also. And
> I wanted to let QEMU call 'pnv_core_power10_class_init' when it
> initialises 'power11' type.
> 
>>
>>
>>> +    {
>>> +        .parent = PNV_CORE_TYPE_NAME("power10_v2.0"),
>>> +        .name = PNV_CORE_TYPE_NAME("power11"),
>>> +    }
>>
>> nope. please use DEFINE_PNV_CORE_TYPE()
> 
> Okay, then, should I have a 'pnv_core_power11_class_init' call
> 'pnv_core_power10_class_init' ?

yes.


> 
>>
>>>    };
>>>    DEFINE_TYPES(pnv_core_infos)
>>> @@ -633,6 +642,11 @@ static const TypeInfo pnv_quad_infos[] = {
>>>            .parent = TYPE_PNV_QUAD,
>>>            .name = PNV_QUAD_TYPE_NAME("power10"),
>>>            .class_init = pnv_quad_power10_class_init,
>>> +        .class_base_init = pnv_quad_power10_class_init,
>>> +    },
>>> +    {
>>> +        .parent = PNV_QUAD_TYPE_NAME("power10"),
>>> +        .name = PNV_QUAD_TYPE_NAME("power11"),
>>
>> hmm, I'd rather introduce pnv_quad_power11_class_init.
> 
> Same, in that case, I can have a 'pnv_quad_power11_class_init' which
> just calls 'pnv_quad_power10_class_init'.

yes.


Thanks,

C.


> 
> Any comments ?
> 
>>> <...snip...>
>>>
>>> +struct Pnv11Chip {
>>> +    /*< private >*/
>>> +    Pnv10Chip      parent_obj;
>>
>> Can't you use a typedef instead ?
> 
> Yes, makes sense. Thanks Cédric.
> 
> - Aditya Gupta
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>> +};
>>> +
>>>    struct PnvChipClass {
>>>        /*< private >*/
>>>        SysBusDeviceClass parent_class;
>>


