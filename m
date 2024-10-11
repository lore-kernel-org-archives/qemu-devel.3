Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC001D2447B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 06:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8m4-0006C0-3i; Fri, 11 Oct 2024 02:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8m2-0006Bn-Vx; Fri, 11 Oct 2024 02:05:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wcaR=RH=kaod.org=clg@ozlabs.org>)
 id 1sz8m1-0004za-2s; Fri, 11 Oct 2024 02:05:14 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XPx1K2J3Pz4xN6;
 Fri, 11 Oct 2024 17:05:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XPx1H2Y2Rz4xG8;
 Fri, 11 Oct 2024 17:05:07 +1100 (AEDT)
Message-ID: <d172fc78-8822-462c-9eca-48f64124feea@kaod.org>
Date: Fri, 11 Oct 2024 08:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] ppc/spapr: remove deprecated machine pseries-2.5
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-6-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241007153838.1085522-6-harshpb@linux.ibm.com>
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
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.5 specific code with this patch for now.
> 
> Also drop sPAPRMachineClass::use_ohci_by_default which is now useless.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/spapr.h |  1 -
>   hw/ppc/spapr.c         | 25 +------------------------
>   2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 1821ef96c7..6e9e62386c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -143,7 +143,6 @@ struct SpaprMachineClass {
>       /*< public >*/
>       bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
>       bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> -    bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>       bool pre_2_10_has_unused_icps;
>       bool legacy_irq_allocation;
>       uint32_t nr_xirqs;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4d7705c89f..f63843d107 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3070,11 +3070,7 @@ static void spapr_machine_init(MachineState *machine)
>       }
>   
>       if (machine->usb) {
> -        if (smc->use_ohci_by_default) {
> -            pci_create_simple(phb->bus, -1, "pci-ohci");
> -        } else {
> -            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> -        }
> +        pci_create_simple(phb->bus, -1, "nec-usb-xhci");
>   
>           if (has_vga) {
>               USBBus *usb_bus;
> @@ -5300,25 +5296,6 @@ static void spapr_machine_2_6_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 6);
>   
> -/*
> - * pseries-2.5
> - */
> -
> -static void spapr_machine_2_5_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { "spapr-vlan", "use-rx-buffer-pools", "off" },
> -    };
> -
> -    spapr_machine_2_6_class_options(mc);
> -    smc->use_ohci_by_default = true;
> -    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 5);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


