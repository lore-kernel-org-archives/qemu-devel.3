Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64524C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 11:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzakn-0005Vd-ER; Wed, 24 Apr 2024 07:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzakm-0005VV-6d
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:25:32 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzakj-0000Y5-7B
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713957929; x=1745493929;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cz/dURFluKwGMZXjMxDdBntuez0U0bvZ+fpHCncB8GA=;
 b=AXRbzIYgvulkP+sqgEFtTJEhvE7kw6tLXgr6yAWrrhsQ/daohuhhbQKn
 9BHuxz12XEg1pwRKELK1r17Sztcue8y32L3rn0/7uaYyQNyR01Odfzs+t
 Xnm5zsCIQ9K6DI1Bpy/vZgvhf0DcNWnFAiqfqghpdiQHVCKUC3Pf5MFQ4
 MAKFzDB3Z+zHQ0Y1HqZoUrS3V87ttpNYmdGNfmeLkh6ca86YxvuNjx1n1
 0ly23prx6CNm0gtesceAHedusQHCpWahsoF5QQsJcyKx76uqRjci7JaoP
 Mv82AneF6Bco/D48C52WcGhcTIN3OAAW6MCk2ARqM8PxRD4qJWg355MxS g==;
X-CSE-ConnectionGUID: fRINEXPXRsqNuFAzdcGY/g==
X-CSE-MsgGUID: mlPNHHwjQK6R2AirxGdcGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20277908"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="20277908"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 04:25:26 -0700
X-CSE-ConnectionGUID: A1HlO/p5Rzy5isTOYGkguQ==
X-CSE-MsgGUID: 1CurQVV5QmO0dBuaqQk7ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="29501052"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 04:25:23 -0700
Message-ID: <1d81395a-93b4-4c63-b73d-7701f3e30666@intel.com>
Date: Wed, 24 Apr 2024 19:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 1/7] target/i386/kvm: Add feature bit definitions
 for KVM CPUID
To: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
 <20240329101954.3954987-2-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240329101954.3954987-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/29/2024 6:19 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Add feature definiations for KVM_CPUID_FEATURES in CPUID (
> CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
> offset calculations.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/i386/kvm/clock.c   |  5 ++---
>   target/i386/cpu.h     | 23 +++++++++++++++++++++++
>   target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
>   3 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 40aa9a32c32c..7c9752d5036f 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -27,7 +27,6 @@
>   #include "qapi/error.h"
>   
>   #include <linux/kvm.h>
> -#include "standard-headers/asm-x86/kvm_para.h"
>   #include "qom/object.h"
>   
>   #define TYPE_KVM_CLOCK "kvmclock"
> @@ -334,8 +333,8 @@ void kvmclock_create(bool create_always)
>   
>       assert(kvm_enabled());
>       if (create_always ||
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> +        cpu->env.features[FEAT_KVM] & (CPUID_FEAT_KVM_CLOCK |
> +                                       CPUID_FEAT_KVM_CLOCK2)) {
>           sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>       }
>   }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 83e473584517..b1b8d11cb0fe 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -27,6 +27,7 @@
>   #include "qapi/qapi-types-common.h"
>   #include "qemu/cpu-float.h"
>   #include "qemu/timer.h"
> +#include "standard-headers/asm-x86/kvm_para.h"
>   
>   #define XEN_NR_VIRQS 24
>   
> @@ -951,6 +952,28 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   /* Packets which contain IP payload have LIP values */
>   #define CPUID_14_0_ECX_LIP              (1U << 31)
>   
> +/* (Old) KVM paravirtualized clocksource */
> +#define CPUID_FEAT_KVM_CLOCK            (1U << KVM_FEATURE_CLOCKSOURCE)

we can drop the _FEAT_, just name it as

CPUID_KVM_CLOCK

> +/* (New) KVM specific paravirtualized clocksource */
> +#define CPUID_FEAT_KVM_CLOCK2           (1U << KVM_FEATURE_CLOCKSOURCE2)
> +/* KVM asynchronous page fault */
> +#define CPUID_FEAT_KVM_ASYNCPF          (1U << KVM_FEATURE_ASYNC_PF)
> +/* KVM stolen (when guest vCPU is not running) time accounting */
> +#define CPUID_FEAT_KVM_STEAL_TIME       (1U << KVM_FEATURE_STEAL_TIME)
> +/* KVM paravirtualized end-of-interrupt signaling */
> +#define CPUID_FEAT_KVM_PV_EOI           (1U << KVM_FEATURE_PV_EOI)
> +/* KVM paravirtualized spinlocks support */
> +#define CPUID_FEAT_KVM_PV_UNHALT        (1U << KVM_FEATURE_PV_UNHALT)
> +/* KVM host-side polling on HLT control from the guest */
> +#define CPUID_FEAT_KVM_POLL_CONTROL     (1U << KVM_FEATURE_POLL_CONTROL)
> +/* KVM interrupt based asynchronous page fault*/
> +#define CPUID_FEAT_KVM_ASYNCPF_INT      (1U << KVM_FEATURE_ASYNC_PF_INT)
> +/* KVM 'Extended Destination ID' support for external interrupts */
> +#define CPUID_FEAT_KVM_MSI_EXT_DEST_ID  (1U << KVM_FEATURE_MSI_EXT_DEST_ID)
> +
> +/* Hint to KVM that vCPUs expect never preempted for an unlimited time */
> +#define CPUID_FEAT_KVM_HINTS_REALTIME    (1U << KVM_HINTS_REALTIME)
> +
>   /* CLZERO instruction */
>   #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
>   /* Always save/restore FP error pointers */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe929302..2f3c8bc3a4ed 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -481,13 +481,13 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>            * be enabled without the in-kernel irqchip
>            */
>           if (!kvm_irqchip_in_kernel()) {
> -            ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
> +            ret &= ~CPUID_FEAT_KVM_PV_UNHALT;
>           }
>           if (kvm_irqchip_is_split()) {
> -            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
> +            ret |= CPUID_FEAT_KVM_MSI_EXT_DEST_ID;
>           }
>       } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> -        ret |= 1U << KVM_HINTS_REALTIME;
> +        ret |= CPUID_FEAT_KVM_HINTS_REALTIME;
>       }
>   
>       return ret;
> @@ -3324,20 +3324,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>           kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
>           kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
>           kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF_INT) {
>               kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
>           }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF) {
>               kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
>           }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_PV_EOI) {
>               kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
>           }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
> +        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_STEAL_TIME) {
>               kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
>           }
>   
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
> +        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_POLL_CONTROL) {
>               kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>           }
>   
> @@ -3789,19 +3789,19 @@ static int kvm_get_msrs(X86CPU *cpu)
>   #endif
>       kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
>       kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF_INT) {
>           kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
>       }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF) {
>           kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
>       }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_PV_EOI) {
>           kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
>       }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
> +    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_STEAL_TIME) {
>           kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
>       }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
> +    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_POLL_CONTROL) {
>           kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>       }
>       if (has_architectural_pmu_version > 0) {
> @@ -5434,7 +5434,7 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
>           return address;
>       }
>       env = &X86_CPU(first_cpu)->env;
> -    if (!(env->features[FEAT_KVM] & (1 << KVM_FEATURE_MSI_EXT_DEST_ID))) {
> +    if (!(env->features[FEAT_KVM] & CPUID_FEAT_KVM_MSI_EXT_DEST_ID)) {
>           return address;
>       }
>   


