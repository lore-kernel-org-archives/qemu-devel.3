Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65546C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7kU-0004E9-Nc; Tue, 25 Mar 2025 13:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7kS-00049O-PM; Tue, 25 Mar 2025 13:07:32 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx7kQ-0006gy-8t; Tue, 25 Mar 2025 13:07:32 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZMbvK5Kv2z4wcr;
 Wed, 26 Mar 2025 04:07:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMbvH1mB9z4xNG;
 Wed, 26 Mar 2025 04:07:22 +1100 (AEDT)
Message-ID: <892091a9-473f-4dcf-96ce-4c0a1738b4ff@kaod.org>
Date: Tue, 25 Mar 2025 18:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] ppc/pnv: Add PHB5 PCIe Host bridge to Power11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-10-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250325112319.927190-10-adityag@linux.ibm.com>
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
> Power11 also uses PHB5, same as Power10.
> 
> Add Power11 PHBs with similar code as the corresponding Power10 implementation.
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
>   hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ae2c1dcd4684..0b741fd4076f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -973,6 +973,8 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
>   
>       pnv_psi_pic_print_info(&chip11->psi, buf);
>       pnv_xive2_pic_print_info(&chip11->xive, buf);
> +    object_child_foreach_recursive(OBJECT(chip),
> +                         pnv_chip_power9_pic_print_info_child, buf);
>   }
>   
>   /* Always give the first 1GB to chip 0 else we won't boot */
> @@ -2373,6 +2375,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>   
>   static void pnv_chip_power11_instance_init(Object *obj)
>   {
> +    PnvChip *chip = PNV_CHIP(obj);
>       Pnv11Chip *chip11 = PNV11_CHIP(obj);
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>       int i;
> @@ -2389,6 +2392,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
>       object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
>                               TYPE_PNV_N1_CHIPLET);
>   
> +    chip->num_pecs = pcc->num_pecs;
> +
> +    for (i = 0; i < chip->num_pecs; i++) {
> +        object_initialize_child(obj, "pec[*]", &chip11->pecs[i],
> +                                TYPE_PNV_PHB5_PEC);
> +    }
> +
>       for (i = 0; i < pcc->i2c_num_engines; i++) {
>           object_initialize_child(obj, "i2c[*]", &chip11->i2c[i], TYPE_PNV_I2C);
>       }
> @@ -2421,6 +2431,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
>       }
>   }
>   
> +static void pnv_chip_power11_phb_realize(PnvChip *chip, Error **errp)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +    int i;
> +
> +    for (i = 0; i < chip->num_pecs; i++) {
> +        PnvPhb4PecState *pec = &chip11->pecs[i];
> +        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
> +        uint32_t pec_cplt_base;
> +        uint32_t pec_nest_base;
> +        uint32_t pec_pci_base;
> +
> +        object_property_set_int(OBJECT(pec), "index", i, &error_fatal);
> +        object_property_set_int(OBJECT(pec), "chip-id", chip->chip_id,
> +                                &error_fatal);
> +        object_property_set_link(OBJECT(pec), "chip", OBJECT(chip),
> +                                 &error_fatal);
> +        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
> +            return;
> +        }
> +
> +        pec_cplt_base = pecc->xscom_cplt_base(pec);
> +        pec_nest_base = pecc->xscom_nest_base(pec);
> +        pec_pci_base = pecc->xscom_pci_base(pec);
> +
> +        pnv_xscom_add_subregion(chip, pec_cplt_base,
> +                 &pec->nest_pervasive.xscom_ctrl_regs_mr);
> +        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
> +        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
> +    }
> +}
> +
>   static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> @@ -2550,7 +2592,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>       pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_ES_BASE,
>                              &chip11->n1_chiplet.xscom_pb_es_mr);
>   
> -    /* WIP: PHB added in future patch */
> +    /* PHBs */
> +    pnv_chip_power11_phb_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>   
>       /*
>        * I2C
> @@ -2684,6 +2731,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
>       k->xscom_core_base = pnv_chip_power11_xscom_core_base;
>       k->xscom_pcba = pnv_chip_power11_xscom_pcba;
>       dc->desc = "PowerNV Chip Power11";
> +    k->num_pecs = PNV10_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
>       k->i2c_ports_per_engine = i2c_ports_per_engine;
>   
> @@ -3274,6 +3322,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
>       XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
>       static const char compat[] = "qemu,powernv11\0ibm,powernv";
>   
> +    static GlobalProperty phb_compat[] = {
> +        { TYPE_PNV_PHB, "version", "5" },
> +        { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
> +    };
> +
> +    compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
> +
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 4;


