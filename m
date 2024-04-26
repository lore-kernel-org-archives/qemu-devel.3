Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B41C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Md2-00085W-4C; Fri, 26 Apr 2024 10:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Mcp-00084O-E7; Fri, 26 Apr 2024 10:32:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Mcm-0003uh-93; Fri, 26 Apr 2024 10:32:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VQwD9248nz4x1x;
 Sat, 27 Apr 2024 00:32:25 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQwD51vs4z4wnv;
 Sat, 27 Apr 2024 00:32:20 +1000 (AEST)
Message-ID: <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
Date: Fri, 26 Apr 2024 16:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] ppc: Make Power11 as default cpu type for
 'pseries' and 'powernv'
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-10-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240426110023.733309-10-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
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

On 4/26/24 13:00, Aditya Gupta wrote:
> Make Power11 as default cpu type for 'pseries' and 'powernv' machine type,
> with Power11 being the newest supported Power processor in QEMU.

This is too early. We should merge Power11 support first, possibly in 9.1,
and then change default in a future release, 9.2, 10.0

Thanks,

C.



> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c   | 4 ++--
>   hw/ppc/spapr.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 06e272f3bdd3..0c5a6bc424af 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2531,8 +2531,6 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> -    mc->alias = "powernv";
> -
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
> @@ -2569,6 +2567,8 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
>       /* do power10_class_init as p11 core is same as p10 */
>       pnv_machine_p10_common_class_init(oc, data);
>   
> +    mc->alias = "powernv";
> +
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
>   
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d2d1e310a3be..1c3e2da8e9e4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4698,7 +4698,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>   
>       smc->dr_lmb_enabled = true;
>       smc->update_dt_enabled = true;
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
>       mc->has_hotpluggable_cpus = true;
>       mc->nvdimm_supported = true;
>       smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;


