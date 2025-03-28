Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E34C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty4Q6-0006so-AP; Fri, 28 Mar 2025 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty4PU-0006oP-53; Fri, 28 Mar 2025 03:45:53 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty4PQ-0004et-56; Fri, 28 Mar 2025 03:45:46 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZPCHg5w2Bz4wxh;
 Fri, 28 Mar 2025 18:45:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZPCHd2SXMz4x8R;
 Fri, 28 Mar 2025 18:45:33 +1100 (AEDT)
Message-ID: <bfcf0ecb-667a-47f6-ada2-1942c1ecb28e@kaod.org>
Date: Fri, 28 Mar 2025 08:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] ppc/pnv: Add ChipTOD model for Power11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250327200738.1524401-1-adityag@linux.ibm.com>
 <20250327200738.1524401-6-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250327200738.1524401-6-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=v09i=WP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.083, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/27/25 21:07, Aditya Gupta wrote:
> Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
> code as the Power11 core is same as Power10 core.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c                 | 15 +++++++++
>   hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chiptod.h |  2 ++
>   3 files changed, 76 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 8b92ad11ae8e..d7da0e79063d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2395,6 +2395,8 @@ static void pnv_chip_power11_instance_init(Object *obj)
>       object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
>       object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
>                                 "xive-fabric");
> +    object_initialize_child(obj, "chiptod", &chip11->chiptod,
> +                            TYPE_PNV11_CHIPTOD);
>       object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
>                               TYPE_PNV_N1_CHIPLET);
>   
> @@ -2545,6 +2547,19 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>                                               (uint64_t) PNV11_LPCM_BASE(chip));
>   
> +    /* ChipTOD */
> +    object_property_set_bool(OBJECT(&chip11->chiptod), "primary",
> +                             chip->chip_id == 0, &error_abort);
> +    object_property_set_bool(OBJECT(&chip11->chiptod), "secondary",
> +                             chip->chip_id == 1, &error_abort);
> +    object_property_set_link(OBJECT(&chip11->chiptod), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip11->chiptod), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_CHIPTOD_BASE,
> +                            &chip11->chiptod.xscom_regs);
> +
>       /* HOMER (must be created before OCC) */
>       object_property_set_link(OBJECT(&chip11->homer), "chip", OBJECT(chip),
>                                &error_abort);
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index c8987ae67a2a..2e87ab62b2cf 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -210,6 +210,22 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
>       }
>   }
>   
> +static void chiptod_power11_broadcast_ttype(PnvChipTOD *sender,
> +                                            uint32_t trigger)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        PnvChipTOD *chiptod = &chip11->chiptod;
> +
> +        if (chiptod != sender) {
> +            chiptod_receive_ttype(chiptod, trigger);
> +        }
> +    }
> +}
> +
>   static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
>                                                   uint32_t xscom_base)
>   {
> @@ -283,6 +299,12 @@ static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
>       }
>   }
>   
> +static PnvCore *chiptod_power11_tx_ttype_target(PnvChipTOD *chiptod,
> +                                               uint64_t val)
> +{
> +    return chiptod_power10_tx_ttype_target(chiptod, val);
> +}
> +
>   static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                                       uint64_t val, unsigned size)
>   {
> @@ -520,6 +542,42 @@ static const TypeInfo pnv_chiptod_power10_type_info = {
>       }
>   };
>   
> +static int pnv_chiptod_power11_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int xscom_offset)
> +{
> +    const char compat[] = "ibm,power-chiptod\0ibm,power11-chiptod";
> +
> +    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
> +}
> +
> +static void pnv_chiptod_power11_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    dc->desc = "PowerNV ChipTOD Controller (Power11)";
> +    device_class_set_props(dc, pnv_chiptod_properties);
> +
> +    xdc->dt_xscom = pnv_chiptod_power11_dt_xscom;
> +
> +    pctc->broadcast_ttype = chiptod_power11_broadcast_ttype;
> +    pctc->tx_ttype_target = chiptod_power11_tx_ttype_target;
> +
> +    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
> +}
> +
> +static const TypeInfo pnv_chiptod_power11_type_info = {
> +    .name          = TYPE_PNV11_CHIPTOD,
> +    .parent        = TYPE_PNV_CHIPTOD,
> +    .instance_size = sizeof(PnvChipTOD),
> +    .class_init    = pnv_chiptod_power11_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
>   static void pnv_chiptod_reset(void *dev)
>   {
>       PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
> @@ -579,6 +637,7 @@ static void pnv_chiptod_register_types(void)
>       type_register_static(&pnv_chiptod_type_info);
>       type_register_static(&pnv_chiptod_power9_type_info);
>       type_register_static(&pnv_chiptod_power10_type_info);
> +    type_register_static(&pnv_chiptod_power11_type_info);
>   }
>   
>   type_init(pnv_chiptod_register_types);
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index fde569bcbfa9..466b06560a28 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -17,6 +17,8 @@ OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
>   DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
>   #define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
>   DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
> +#define TYPE_PNV11_CHIPTOD TYPE_PNV_CHIPTOD "-POWER11"
> +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV11_CHIPTOD, TYPE_PNV11_CHIPTOD)
>   
>   enum tod_state {
>       tod_error = 0,


Looks correct.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




