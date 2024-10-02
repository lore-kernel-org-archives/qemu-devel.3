Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00138CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtFN-0007ra-Ro; Wed, 02 Oct 2024 02:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtFM-0007rO-VG; Wed, 02 Oct 2024 02:54:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtFK-0003AK-To; Wed, 02 Oct 2024 02:54:04 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XJQWq1kjLz4wcj;
 Wed,  2 Oct 2024 16:53:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XJQWn1vTxz4wc3;
 Wed,  2 Oct 2024 16:53:56 +1000 (AEST)
Message-ID: <e6b6aa19-4a99-4fd4-bfdc-8c2e05c9d28a@kaod.org>
Date: Wed, 2 Oct 2024 08:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] ppc/spapr: remove deprecated machine pseries-2.9
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
 <20241001092910.1030913-10-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241001092910.1030913-10-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/1/24 11:29, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.9 specific code with this patch for now.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/cpu.h      |  1 -
>   hw/ppc/spapr.c        | 20 --------------------
>   target/ppc/cpu_init.c |  2 --
>   target/ppc/machine.c  |  2 +-
>   4 files changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index cab4a46fc1..74a0ab768d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1456,7 +1456,6 @@ struct ArchCPU {
>       opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
>   
>       /* Fields related to migration compatibility hacks */
> -    bool pre_2_10_migration;
>       bool pre_3_0_migration;
>       int32_t mig_slb_nr;
>   };
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 97ab253fcc..84da4ece77 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5184,26 +5184,6 @@ static void spapr_machine_2_10_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 10);
>   
> -/*
> - * pseries-2.9
> - */
> -
> -static void spapr_machine_2_9_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
> -    };
> -
> -    spapr_machine_2_10_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    smc->pre_2_10_has_unused_icps = true;
> -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> -}> -
> -DEFINE_SPAPR_MACHINE(2, 9);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7768392986..39c19e6674 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7452,8 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>   }
>   
>   static Property ppc_cpu_properties[] = {
> -    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
> -                     false),
>       DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
>                        false),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 21bed7c7c8..47495b68b1 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -630,7 +630,7 @@ static bool compat_needed(void *opaque)
>       PowerPCCPU *cpu = opaque;
>   
>       assert(!(cpu->compat_pvr && !cpu->vhyp));
> -    return !cpu->pre_2_10_migration && cpu->compat_pvr != 0;
> +    return cpu->compat_pvr != 0;
>   }
>   
>   static const VMStateDescription vmstate_compat = {


