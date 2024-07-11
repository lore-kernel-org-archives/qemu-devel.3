Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwXv-0006lB-8n; Thu, 11 Jul 2024 12:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwXt-0006k2-R9; Thu, 11 Jul 2024 12:21:25 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwXr-0004gb-HK; Thu, 11 Jul 2024 12:21:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKg2j3lh7z4wnx;
 Fri, 12 Jul 2024 02:21:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKg2g3hRtz4wbr;
 Fri, 12 Jul 2024 02:21:15 +1000 (AEST)
Message-ID: <1d8a7c53-4876-4efe-afbb-7a4d0d37c6dc@kaod.org>
Date: Thu, 11 Jul 2024 18:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] ppc/pnv: specialise init for powernv8/9/10 machines
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-7-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SBUb=OL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/11/24 16:18, Nicholas Piggin wrote:
> This will allow different settings and checks for different
> machine types with later changes.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv.h |  1 +
>   hw/ppc/pnv.c         | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 476b136146..1993dededf 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -76,6 +76,7 @@ struct PnvMachineClass {
>       /*< public >*/
>       const char *compat;
>       int compat_size;
> +    int max_smt_threads;
>   
>       void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
>       void (*i2c_init)(PnvMachineState *pnv);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3bcf11984c..4252bcd28d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -899,6 +899,7 @@ static void pnv_init(MachineState *machine)
>       PnvMachineState *pnv = PNV_MACHINE(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
> +    int max_smt_threads = pmc->max_smt_threads;
>       char *fw_filename;
>       long fw_size;
>       uint64_t chip_ram_start = 0;
> @@ -997,17 +998,19 @@ static void pnv_init(MachineState *machine)
>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>   
> -    if (machine->smp.threads > 8) {
> -        error_report("Cannot support more than 8 threads/core "
> -                     "on a powernv machine");
> +    if (machine->smp.threads > max_smt_threads) {
> +        error_report("Cannot support more than %d threads/core "
> +                     "on %s machine", max_smt_threads, mc->desc);
>           exit(1);
>       }
> +
>       if (!is_power_of_2(machine->smp.threads)) {
>           error_report("Cannot support %d threads/core on a powernv"
>                        "machine because it must be a power of 2",
>                        machine->smp.threads);
>           exit(1);
>       }
> +
>       /*
>        * TODO: should we decide on how many chips we can create based
>        * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> @@ -2491,6 +2494,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>   
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
> +    pmc->max_smt_threads = 8;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>   }
> @@ -2515,6 +2519,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>   
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
> +    pmc->max_smt_threads = 4;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> @@ -2539,6 +2544,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>   
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
> +    pmc->max_smt_threads = 4;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
>       xfc->match_nvt = pnv10_xive_match_nvt;


