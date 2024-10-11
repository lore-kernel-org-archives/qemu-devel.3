Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA708D2447B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 06:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8oE-0007l6-0e; Fri, 11 Oct 2024 02:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8o8-0007kl-Gh; Fri, 11 Oct 2024 02:07:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8o4-0005Nb-Vg; Fri, 11 Oct 2024 02:07:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XPx3n3cqWz4xN6;
 Fri, 11 Oct 2024 17:07:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XPx3l3mq2z4wb7;
 Fri, 11 Oct 2024 17:07:15 +1100 (AEDT)
Message-ID: <f73939b8-999a-42ad-ada0-2f8045752ff5@kaod.org>
Date: Fri, 11 Oct 2024 08:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] ppc/spapr: remove deprecated machine pseries-2.3
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-4-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241007153838.1085522-4-harshpb@linux.ibm.com>
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
> Removing pseries-2.3 specific code with this patch for now.
> 
> While at it, also remove the dynamic-reconfiguration option which was
> introduced to disable it by default for legacy machines until pseries-2.3.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/spapr.h |  1 -
>   hw/ppc/spapr.c              | 15 ---------------
>   hw/ppc/spapr_pci.c          | 35 -----------------------------------
>   3 files changed, 51 deletions(-)
> 
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 3778aac27b..79187e80fd 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -53,7 +53,6 @@ struct SpaprPhbState {
>       uint32_t index;
>       uint64_t buid;
>       char *dtbusname;
> -    bool dr_enabled;
>   
>       MemoryRegion memspace, iospace;
>       hwaddr mem_win_addr, mem_win_size, mem64_win_addr, mem64_win_size;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 34d655d0b3..599a59910c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5349,21 +5349,6 @@ static void spapr_machine_2_4_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 4);
>   
> -/*
> - * pseries-2.3
> - */
> -
> -static void spapr_machine_2_3_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
> -    };
> -    spapr_machine_2_4_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -DEFINE_SPAPR_MACHINE(2, 3);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5c0024bef9..8f1964ce52 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1237,10 +1237,6 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
>       int i;
>       uint8_t chassis;
>   
> -    if (!phb->dr_enabled) {
> -        return;
> -    }
> -
>       chassis = chassis_from_bus(bus);
>   
>       if (pci_bus_is_root(bus)) {
> @@ -1260,10 +1256,6 @@ static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
>       int i;
>       uint8_t chassis;
>   
> -    if (!phb->dr_enabled) {
> -        return;
> -    }
> -
>       chassis = chassis_from_bus(bus);
>   
>       for (i = PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >= 0; i--) {
> @@ -1548,17 +1540,6 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
>       PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
>       uint32_t slotnr = PCI_SLOT(pdev->devfn);
>   
> -    if (!phb->dr_enabled) {
> -        /* if this is a hotplug operation initiated by the user
> -         * we need to let them know it's not enabled
> -         */
> -        if (plugged_dev->hotplugged) {
> -            error_setg(errp, "Bus '%s' does not support hotplugging",
> -                       phb->parent_obj.bus->qbus.name);
> -            return;
> -        }
> -    }
> -
>       if (IS_PCI_BRIDGE(plugged_dev)) {
>           if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
>               return;
> @@ -1591,14 +1572,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>       SpaprDrc *drc = drc_from_dev(phb, pdev);
>       uint32_t slotnr = PCI_SLOT(pdev->devfn);
>   
> -    /*
> -     * If DR is disabled we don't need to do anything in the case of
> -     * hotplug or coldplug callbacks.
> -     */
> -    if (!phb->dr_enabled) {
> -        return;
> -    }
> -
>       g_assert(drc);
>   
>       if (IS_PCI_BRIDGE(plugged_dev)) {
> @@ -1673,12 +1646,6 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>       PCIDevice *pdev = PCI_DEVICE(plugged_dev);
>       SpaprDrc *drc = drc_from_dev(phb, pdev);
>   
> -    if (!phb->dr_enabled) {
> -        error_setg(errp, "Bus '%s' does not support hotplugging",
> -                   phb->parent_obj.bus->qbus.name);
> -        return;
> -    }
> -
>       g_assert(drc);
>       g_assert(drc->dev == plugged_dev);
>   
> @@ -2089,8 +2056,6 @@ static Property spapr_phb_properties[] = {
>                          SPAPR_PCI_MEM64_WIN_SIZE),
>       DEFINE_PROP_UINT64("io_win_size", SpaprPhbState, io_win_size,
>                          SPAPR_PCI_IO_WIN_SIZE),
> -    DEFINE_PROP_BOOL("dynamic-reconfiguration", SpaprPhbState, dr_enabled,
> -                     true),
>       /* Default DMA window is 0..1GB */
>       DEFINE_PROP_UINT64("dma_win_addr", SpaprPhbState, dma_win_addr, 0),
>       DEFINE_PROP_UINT64("dma_win_size", SpaprPhbState, dma_win_size, 0x40000000),


