Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66311C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDKs-0006HP-6Y; Wed, 29 May 2024 03:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCDKj-0006Gj-N5; Wed, 29 May 2024 03:02:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCDKg-00036p-4L; Wed, 29 May 2024 03:02:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vq0h34nw6z4x1s;
 Wed, 29 May 2024 17:02:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vq0gz5qzkz4x21;
 Wed, 29 May 2024 17:02:39 +1000 (AEST)
Message-ID: <17aff806-7f15-4780-bfe2-068495ffd22f@kaod.org>
Date: Wed, 29 May 2024 09:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/10] ppc/pnv: Add an LPAR per core machine option
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-11-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240526122612.473476-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/26/24 14:26, Nicholas Piggin wrote:
> Recent POWER CPUs can operate in "LPAR per core" or "LPAR per thread"
> modes. In per-core mode, some SPRs and IPI doorbells are shared between
> threads in a core. In per-thread mode, supervisor and user state is
> not shared between threads.
> 
> OpenPOWER systems use LPAR per thread mode as it is required for KVM.
> Enterprise systems use LPAR per core mode, as they partition the
> machine by core.
> 
> Implement a lpar-per-core machine option for powernv machines. This
> is supported on POWER9 and POWER10.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

LGTM,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv.h      |  1 +
>   include/hw/ppc/pnv_core.h |  1 +
>   hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c         |  8 ++++++++
>   target/ppc/cpu_init.c     |  3 ++-
>   5 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index bec603f1a8..8f75c715d8 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -103,6 +103,7 @@ struct PnvMachineState {
>   
>       bool         big_core;
>       bool         big_core_tbst_quirk;
> +    bool         lpar_per_core;
>   };
>   
>   PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 9599da15ea..e41b6347ea 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -57,6 +57,7 @@ struct PnvCore {
>       /*< public >*/
>       PowerPCCPU **threads;
>       bool big_core;
> +    bool lpar_per_core;
>       uint32_t pir;
>       uint32_t hwid;
>       uint64_t hrmor;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 765142965f..0d830ad731 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1108,12 +1108,17 @@ static void pnv_init(MachineState *machine)
>   
>   static void pnv_power8_init(MachineState *machine)
>   {
> +    PnvMachineState *pnv = PNV_MACHINE(machine);
> +
>       if (machine->smp.threads > 8) {
>           error_report("Cannot support more than 8 threads/core "
>                        "on a powernv POWER8 machine");
>           exit(1);
>       }
>   
> +    /* POWER8 is always lpar-per-core. */
> +    pnv->lpar_per_core = true;
> +
>       pnv_init(machine);
>   }
>   
> @@ -2541,6 +2546,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
>       pnv->big_core = value;
>   }
>   
> +static bool pnv_machine_get_1lpar(Object *obj, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    return pnv->lpar_per_core;
> +}
> +
> +static void pnv_machine_set_1lpar(Object *obj, bool value, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    pnv->lpar_per_core = value;
> +}
> +
>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -2614,6 +2631,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_1lpar,
> +                                   pnv_machine_set_1lpar);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
> @@ -2660,6 +2683,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_1lpar,
> +                                   pnv_machine_set_1lpar);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 835c35d90b..e510909db1 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -207,6 +207,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                   val |= PPC_BIT(56 + i);
>               }
>           }
> +        if (pc->lpar_per_core) {
> +            val |= PPC_BIT(62);
> +        }
>           break;
>       case PNV10_XSCOM_EC_CORE_THREAD_INFO:
>           break;
> @@ -322,6 +325,11 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>           env->core_index = core_hwid;
>       }
>   
> +    if (pnv->lpar_per_core) {
> +        pc->lpar_per_core = true;
> +        cpu_ppc_set_1lpar(cpu);
> +    }
> +
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>   }
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index e71ee008ed..f0065c2e37 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6785,7 +6785,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
>   
>       /*
>        * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
> -     * between threads.
> +     * between threads. powernv be in either mode, and it mostly affects
> +     * supervisor visible registers and instructions.
>        */
>       if (env->flags & POWERPC_FLAG_SMT) {
>           env->flags |= POWERPC_FLAG_SMT_1LPAR;


