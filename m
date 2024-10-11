Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41970D2447C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 05:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8eW-0003LI-0J; Fri, 11 Oct 2024 01:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8eV-0003L5-1Y; Fri, 11 Oct 2024 01:57:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8eR-0003eI-N8; Fri, 11 Oct 2024 01:57:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XPwr565MHz4xQ0;
 Fri, 11 Oct 2024 16:57:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XPwr364G4z4xKl;
 Fri, 11 Oct 2024 16:57:07 +1100 (AEDT)
Message-ID: <68da6aab-eb1e-4c26-888f-54a1c8cad987@kaod.org>
Date: Fri, 11 Oct 2024 07:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] ppc/spapr: remove deprecated machine pseries-3.0
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-15-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241007153838.1085522-15-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=wcaR=RH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/7/24 17:38, Harsh Prateek Bora wrote:
> As per Qemu's deprecation policy [1], and the mailing list discussion
> that happened on [2], pseries-3.0 is more than 6 years old since release
> and therefore due for deletion as already deprecated for >3 years.
> 
> [1] https://www.qemu.org/docs/master/about/deprecated.html
> [2] https://lore.kernel.org/qemu-devel/1d7c210e-d7a6-4233-b555-c99a41f3c4e2@kaod.org/
> 
> While at it, also remove related legacy irq hacks which are now obsolete.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

I induced you in error. This version has not been deprecated yet.

We will have to wait a little longer (2 cycles) to remove it when
the automatic deprecation process starts. See c9fd2d9a48ee. You
can resend when the 10.1 cycle starts, around april 2025.

Thanks,

C.


> ---
>   include/hw/ppc/spapr.h     |  1 -
>   include/hw/ppc/spapr_irq.h |  1 -
>   hw/ppc/spapr.c             | 27 +--------------------------
>   hw/ppc/spapr_events.c      |  8 --------
>   hw/ppc/spapr_irq.c         | 16 +---------------
>   hw/ppc/spapr_pci.c         | 32 ++++----------------------------
>   hw/ppc/spapr_vio.c         |  9 ---------
>   7 files changed, 6 insertions(+), 88 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index af4aa1cb0f..bac3f8561b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -143,7 +143,6 @@ struct SpaprMachineClass {
>       /*< public >*/
>       bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
>       bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> -    bool legacy_irq_allocation;
>       uint32_t nr_xirqs;
>       bool broken_host_serial_model; /* present real host info to the guest */
>       bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index cb9a85f657..5ddd1107c3 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -100,7 +100,6 @@ typedef struct SpaprIrq {
>   } SpaprIrq;
>   
>   extern SpaprIrq spapr_irq_xics;
> -extern SpaprIrq spapr_irq_xics_legacy;
>   extern SpaprIrq spapr_irq_xive;
>   extern SpaprIrq spapr_irq_dual;
>   
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f15467049a..8fa75ec541 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3312,9 +3312,7 @@ static char *spapr_get_ic_mode(Object *obj, Error **errp)
>   {
>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>   
> -    if (spapr->irq == &spapr_irq_xics_legacy) {
> -        return g_strdup("legacy");
> -    } else if (spapr->irq == &spapr_irq_xics) {
> +    if (spapr->irq == &spapr_irq_xics) {
>           return g_strdup("xics");
>       } else if (spapr->irq == &spapr_irq_xive) {
>           return g_strdup("xive");
> @@ -3328,11 +3326,6 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
>   {
>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>   
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        error_setg(errp, "This machine only uses the legacy XICS backend, don't pass ic-mode");
> -        return;
> -    }
> -
>       /* The legacy IRQ backend can not be set */
>       if (strcmp(value, "xics") == 0) {
>           spapr->irq = &spapr_irq_xics;
> @@ -4999,24 +4992,6 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(3, 1);
>   
> -/*
> - * pseries-3.0
> - */
> -
> -static void spapr_machine_3_0_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -
> -    spapr_machine_3_1_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
> -
> -    smc->legacy_irq_allocation = true;
> -    smc->nr_xirqs = 0x400;
> -    smc->irq = &spapr_irq_xics_legacy;
> -}
> -
> -DEFINE_SPAPR_MACHINE(3, 0);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4dbf8e2e2e..12ae5bf57c 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -1043,10 +1043,6 @@ void spapr_events_init(SpaprMachineState *spapr)
>   {
>       int epow_irq = SPAPR_IRQ_EPOW;
>   
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        epow_irq = spapr_irq_findone(spapr, &error_fatal);
> -    }
> -
>       spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
>   
>       QTAILQ_INIT(&spapr->pending_events);
> @@ -1067,10 +1063,6 @@ void spapr_events_init(SpaprMachineState *spapr)
>       if (spapr->use_hotplug_event_source) {
>           int hp_irq = SPAPR_IRQ_HOTPLUG;
>   
> -        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -            hp_irq = spapr_irq_findone(spapr, &error_fatal);
> -        }
> -
>           spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
>   
>           spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index aebd7eaabb..cb153651c3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -33,11 +33,6 @@ static const TypeInfo spapr_intc_info = {
>   
>   static void spapr_irq_msi_init(SpaprMachineState *spapr)
>   {
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        /* Legacy mode doesn't use this allocator */
> -        return;
> -    }
> -
>       spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
>       spapr->irq_map = bitmap_new(spapr->irq_map_nr);
>   }
> @@ -286,11 +281,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>   {
>       SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>   
> -    if (smc->legacy_irq_allocation) {
> -        return smc->nr_xirqs;
> -    } else {
> -        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
> -    }
> +    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
>   }
>   
>   void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
> @@ -588,11 +579,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>       return first + ics->offset;
>   }
>   
> -SpaprIrq spapr_irq_xics_legacy = {
> -    .xics        = true,
> -    .xive        = false,
> -};
> -
>   static void spapr_irq_register_types(void)
>   {
>       type_register_static(&spapr_intc_info);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7e24084673..c2bf89b2fd 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -269,7 +269,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                   target_ulong args, uint32_t nret,
>                                   target_ulong rets)
>   {
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>       uint32_t config_addr = rtas_ld(args, 0);
>       uint64_t buid = rtas_ldq(args, 1);
>       unsigned int func = rtas_ld(args, 3);
> @@ -374,13 +373,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       }
>   
>       /* Allocate MSIs */
> -    if (smc->legacy_irq_allocation) {
> -        irq = spapr_irq_find(spapr, req_num, ret_intr_type == RTAS_TYPE_MSI,
> -                             &err);
> -    } else {
> -        irq = spapr_irq_msi_alloc(spapr, req_num,
> -                                  ret_intr_type == RTAS_TYPE_MSI, &err);
> -    }
> +    irq = spapr_irq_msi_alloc(spapr, req_num,
> +                              ret_intr_type == RTAS_TYPE_MSI, &err);
>       if (err) {
>           error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>                             config_addr);
> @@ -394,9 +388,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
>               if (i) {
>                   spapr_irq_free(spapr, irq, i);
>               }
> -            if (!smc->legacy_irq_allocation) {
> -                spapr_irq_msi_free(spapr, irq, req_num);
> -            }
> +            spapr_irq_msi_free(spapr, irq, req_num);
>               error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>                                 config_addr);
>               rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -1776,12 +1768,9 @@ static void spapr_phb_unrealize(DeviceState *dev)
>   static void spapr_phb_destroy_msi(gpointer opaque)
>   {
>       SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>       SpaprPciMsi *msi = opaque;
>   
> -    if (!smc->legacy_irq_allocation) {
> -        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> -    }
> +    spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>       spapr_irq_free(spapr, msi->first_irq, msi->num);
>       g_free(msi);
>   }
> @@ -1795,7 +1784,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>       SpaprMachineState *spapr =
>           (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                     TYPE_SPAPR_MACHINE);
> -    SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
>       PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
> @@ -1943,18 +1931,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < PCI_NUM_PINS; i++) {
>           int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
>   
> -        if (smc->legacy_irq_allocation) {
> -            irq = spapr_irq_findone(spapr, errp);
> -            if (irq < 0) {
> -                error_prepend(errp, "can't allocate LSIs: ");
> -                /*
> -                 * Older machines will never support PHB hotplug, ie, this is an
> -                 * init only path and QEMU will terminate. No need to rollback.
> -                 */
> -                return;
> -            }
> -        }
> -
>           if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
>               error_prepend(errp, "can't allocate LSIs: ");
>               goto unrealize;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 6a5a7f57c7..c9ce796f63 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -507,15 +507,6 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>   
>       dev->irq = spapr_vio_reg_to_irq(dev->reg);
>   
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        int irq = spapr_irq_findone(spapr, errp);
> -
> -        if (irq < 0) {
> -            return;
> -        }
> -        dev->irq = irq;
> -    }
> -
>       if (spapr_irq_claim(spapr, dev->irq, false, errp) < 0) {
>           return;
>       }


