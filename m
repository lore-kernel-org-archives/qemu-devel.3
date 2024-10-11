Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B08D2447F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 06:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8n4-0006z8-JT; Fri, 11 Oct 2024 02:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8n3-0006yc-Ee; Fri, 11 Oct 2024 02:06:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8n0-0005F9-FH; Fri, 11 Oct 2024 02:06:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XPx2S3WJnz4xN6;
 Fri, 11 Oct 2024 17:06:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XPx2Q3pPSz4wb7;
 Fri, 11 Oct 2024 17:06:06 +1100 (AEDT)
Message-ID: <cdeaf682-245a-4db8-9013-65519831f6e9@kaod.org>
Date: Fri, 11 Oct 2024 08:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] ppc/spapr: remove deprecated machine pseries-2.4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-5-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241007153838.1085522-5-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=wcaR=RH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 10/7/24 17:38, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.4 specific code with this patch for now.
> 
> While at it, also remove SpaprMachineClass::dr_lmb_enabled which is
> now turned useless.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/spapr.h |  1 -
>   hw/ppc/spapr.c         | 38 ++++----------------------------------
>   2 files changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f6de3e9972..1821ef96c7 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -141,7 +141,6 @@ struct SpaprMachineClass {
>       MachineClass parent_class;
>   
>       /*< public >*/
> -    bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
>       bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
>       bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>       bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 599a59910c..4d7705c89f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -682,7 +682,6 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
>   static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
>   {
>       MachineState *machine = MACHINE(spapr);
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>       hwaddr mem_start, node_size;
>       int i, nb_nodes = machine->numa_state->num_nodes;
>       NodeInfo *nodes = machine->numa_state->nodes;
> @@ -724,7 +723,6 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
>       if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
>           int ret;
>   
> -        g_assert(smc->dr_lmb_enabled);
>           ret = spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
>           if (ret) {
>               return ret;
> @@ -1307,9 +1305,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>       spapr_dt_cpus(fdt, spapr);
>   
>       /* ibm,drc-indexes and friends */
> -    if (smc->dr_lmb_enabled) {
> -        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
> -    }
> +    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
>       if (smc->dr_phb_enabled) {
>           root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
>       }
> @@ -2929,10 +2925,8 @@ static void spapr_machine_init(MachineState *machine)
>       spapr->ov5 = spapr_ovec_new();
>       spapr->ov5_cas = spapr_ovec_new();
>   
> -    if (smc->dr_lmb_enabled) {
> -        spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
> -        spapr_validate_node_memory(machine, &error_fatal);
> -    }
> +    spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
> +    spapr_validate_node_memory(machine, &error_fatal);
>   
>       spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
>   
> @@ -3016,9 +3010,7 @@ static void spapr_machine_init(MachineState *machine)
>           machine_memory_devices_init(machine, device_mem_base, device_mem_size);
>       }
>   
> -    if (smc->dr_lmb_enabled) {
> -        spapr_create_lmb_dr_connectors(spapr);
> -    }
> +    spapr_create_lmb_dr_connectors(spapr);
>   
>       if (mc->nvdimm_supported) {
>           spapr_create_nvdimm_dr_connectors(spapr);
> @@ -3662,7 +3654,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
>   static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                     Error **errp)
>   {
> -    const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
>       SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
>       bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>       PCDIMMDevice *dimm = PC_DIMM(dev);
> @@ -3671,11 +3662,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       Object *memdev;
>       hwaddr pagesize;
>   
> -    if (!smc->dr_lmb_enabled) {
> -        error_setg(errp, "Memory hotplug not supported for this machine");
> -        return;
> -    }
> -
>       size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> @@ -4713,7 +4699,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       hc->unplug_request = spapr_machine_device_unplug_request;
>       hc->unplug = spapr_machine_device_unplug;
>   
> -    smc->dr_lmb_enabled = true;
>       smc->update_dt_enabled = true;
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       mc->has_hotpluggable_cpus = true;
> @@ -5334,21 +5319,6 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 5);
>   
> -/*
> - * pseries-2.4
> - */
> -
> -static void spapr_machine_2_4_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -
> -    spapr_machine_2_5_class_options(mc);
> -    smc->dr_lmb_enabled = false;
> -    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 4);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


