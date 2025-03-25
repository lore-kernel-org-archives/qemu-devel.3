Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC75C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5Zh-0003ml-NS; Tue, 25 Mar 2025 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx5Zc-0003lz-3G; Tue, 25 Mar 2025 10:48:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TX69=WM=kaod.org=clg@ozlabs.org>)
 id 1tx5ZZ-0004Hl-GA; Tue, 25 Mar 2025 10:48:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZMXpT41srz4xM5;
 Wed, 26 Mar 2025 01:48:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMXpR0lB4z4xM3;
 Wed, 26 Mar 2025 01:47:58 +1100 (AEDT)
Message-ID: <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
Date: Tue, 25 Mar 2025 15:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250325112319.927190-8-adityag@linux.ibm.com>
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
> The Powernv11 machine doesn't have XIVE & PHBs as of now
> 
> XIVE2 interface and PHB5 added in later patches to Powernv11 machine
> 
> Also add mention of Power11 to powernv documentation
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/powernv.rst |  9 +++++----
>   hw/ppc/pnv.c                | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
> index f3ec2cc69c0d..5154794cc8cd 100644
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
> index 006ff62efd79..3e63b2891279 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -3145,6 +3145,37 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>       pmc->i2c_init = pnv_rainier_i2c_init;
>   }
>   
> +static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
> +
> +    pmc->compat = compat;
> +    pmc->compat_size = sizeof(compat);
> +    pmc->max_smt_threads = 4;
> +    pmc->has_lpar_per_thread = true;
> +    pmc->quirk_tb_big_core = true;
> +    pmc->dt_power_mgt = pnv_dt_power_mgt;
> +
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);

There was a lot of work done to have dynamic PHBs in the PowerNV
machines. This was to add support in libvirt and this goal was
abandoned when people left. I think we should consider removing
it as it adds unnecessary complexity.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

+
> +    mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
> +
> +    object_class_property_add_bool(oc, "big-core",
> +                                   pnv_machine_get_big_core,
> +                                   pnv_machine_set_big_core);
> +    object_class_property_set_description(oc, "big-core",
> +                              "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_lpar_per_core,
> +                                   pnv_machine_set_lpar_per_core);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
> +}
> +
>   static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>   {
>       CPUPPCState *env = cpu_env(cs);
> @@ -3258,6 +3289,11 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>       }
>   
>   static const TypeInfo types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("powernv11"),
> +        .parent        = TYPE_PNV_MACHINE,
> +        .class_init    = pnv_machine_power11_class_init,
> +    },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
>           .parent        = MACHINE_TYPE_NAME("powernv10"),


