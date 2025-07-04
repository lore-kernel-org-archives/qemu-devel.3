Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21BEC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 05:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXZ6X-0003AE-FI; Fri, 04 Jul 2025 01:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZ6W-0003A4-8h
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:36:56 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZ6U-00036B-0E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751607414; x=1783143414;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=V5oT/y4rYK+ANN955owVAWn1DJwS6HxdCrK+3DgxSHQ=;
 b=XgBrt+utw/y2zrHxSEI1AIaYJV77ZkVO1VixfCM2y7Vnt2sEzieNNb+h
 KkfCe8AFi8k8gBiPYfPkoPdpYQa9tsA6K05QbBdomKqTDU4yZyBzZ+6oU
 uokibBukNUP7ONxA+LVZBueBqQAjo3PLwzSRlARtaguwj1OPKD8mO2ZT4
 OAWvb5PvkNKTvm294lvnVZ+NxsZvlUqcrHF0/4qniKfzwd7r8DcEu1Qhc
 D9xOQzImaG4UKs7M7obvEYI0G+Qdh5x0EITnqtsr1S/etVaqs8TctbCcb
 OMSUYfeD1/i0/W8k2rOGstXPP5bn53DgX7KhIoDfCHcIkQgpgNq77b/Ie w==;
X-CSE-ConnectionGUID: TcdEvksdT3SfTfMOHG1mZQ==
X-CSE-MsgGUID: BXQXirAQQGiBs9H+o+HdvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64539223"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="64539223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 22:36:50 -0700
X-CSE-ConnectionGUID: 7pbGoi9nQWaT/1jvAmDUmg==
X-CSE-MsgGUID: YlBwX3aESUabJ7EJb4SUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="185580935"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 22:36:47 -0700
Message-ID: <78f4e026-9abd-47eb-9540-656094b19762@intel.com>
Date: Fri, 4 Jul 2025 13:36:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/39] accel: Move cpus_are_resettable() declaration to
 AccelClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-14-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> AccelOpsClass is for methods dealing with vCPUs.
> When only dealing with AccelState, AccelClass is sufficient.
> 
> Move cpus_are_resettable() declaration to accel/accel-system.c.

I don't think this is necessary unless a solid justfication provided.

One straightfroward question against it, is why don't move 
gdb_supports_guest_debug() to accel/accel-system.c as well in the patch 12.

> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.

Is this the essential preparation for split-accel work?

> Adapt KVM handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/accel.h       |  1 +
>   include/system/accel-ops.h |  1 -
>   accel/accel-system.c       | 10 ++++++++++
>   accel/kvm/kvm-accel-ops.c  |  6 ------
>   accel/kvm/kvm-all.c        |  6 ++++++
>   system/cpus.c              |  8 --------
>   6 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index fb176e89bad..f987d16baaa 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -45,6 +45,7 @@ typedef struct AccelClass {
>       void (*setup_post)(MachineState *ms, AccelState *accel);
>       bool (*has_memory)(MachineState *ms, AddressSpace *as,
>                          hwaddr start_addr, hwaddr size);
> +    bool (*cpus_are_resettable)(AccelState *as);
>   
>       /* gdbstub related hooks */
>       bool (*supports_guest_debug)(AccelState *as);
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index 700df92ac6d..f19245d0a0e 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -33,7 +33,6 @@ struct AccelOpsClass {
>       /* initialization function called when accel is chosen */
>       void (*ops_init)(AccelOpsClass *ops);
>   
> -    bool (*cpus_are_resettable)(void);
>       void (*cpu_reset_hold)(CPUState *cpu);
>   
>       void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index a0f562ae9ff..07b75dae797 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -62,6 +62,16 @@ void accel_setup_post(MachineState *ms)
>       }
>   }
>   
> +bool cpus_are_resettable(void)
> +{
> +    AccelState *accel = current_accel();
> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
> +    if (acc->cpus_are_resettable) {
> +        return acc->cpus_are_resettable(accel);
> +    }
> +    return true;
> +}
> +
>   /* initialize the arch-independent accel operation interfaces */
>   void accel_init_ops_interfaces(AccelClass *ac)
>   {
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 96606090889..99f61044da5 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -78,11 +78,6 @@ static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
>       return !kvm_halt_in_kernel();
>   }
>   
> -static bool kvm_cpus_are_resettable(void)
> -{
> -    return !kvm_enabled() || !kvm_state->guest_state_protected;
> -}
> -
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>   static int kvm_update_guest_debug_ops(CPUState *cpu)
>   {
> @@ -96,7 +91,6 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>   
>       ops->create_vcpu_thread = kvm_start_vcpu_thread;
>       ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
> -    ops->cpus_are_resettable = kvm_cpus_are_resettable;
>       ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
>       ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
>       ops->synchronize_state = kvm_cpu_synchronize_state;
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c8611552d19..88fb6d36941 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3979,6 +3979,11 @@ static void kvm_accel_instance_init(Object *obj)
>       s->msr_energy.enable = false;
>   }
>   
> +static bool kvm_cpus_are_resettable(AccelState *as)
> +{
> +    return !kvm_enabled() || !kvm_state->guest_state_protected;
> +}
> +
>   /**
>    * kvm_gdbstub_sstep_flags():
>    *
> @@ -3997,6 +4002,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
>       ac->init_machine = kvm_init;
>       ac->has_memory = kvm_accel_has_memory;
>       ac->allowed = &kvm_allowed;
> +    ac->cpus_are_resettable = kvm_cpus_are_resettable;
>       ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       ac->supports_guest_debug = kvm_supports_guest_debug;
> diff --git a/system/cpus.c b/system/cpus.c
> index a43e0e4e796..4fb764ac880 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -195,14 +195,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
>       }
>   }
>   
> -bool cpus_are_resettable(void)
> -{
> -    if (cpus_accel->cpus_are_resettable) {
> -        return cpus_accel->cpus_are_resettable();
> -    }
> -    return true;
> -}
> -
>   void cpu_exec_reset_hold(CPUState *cpu)
>   {
>       if (cpus_accel->cpu_reset_hold) {


