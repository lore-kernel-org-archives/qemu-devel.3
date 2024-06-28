Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DC0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN71c-0007lN-1L; Fri, 28 Jun 2024 04:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sN71Z-0007jZ-Ad
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:32:05 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sN71X-0000qm-Ey
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719563523; x=1751099523;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xQbgmLOiUzMotqn7K6RalAxrTaCb1Ai/St6yAhJtgJ0=;
 b=n4OGcd6mFeqbr8IilPBGsF9s1yeZB+kxOLvavgWQPZJAjFwvE92JjDmW
 QD1SKoFdfQeHjI8UBnVCbhiN0l9cf4nbxejxV+ktTrPh6nNUpEN6vq2ui
 560+TPgwyXETrD7aekM4NAkrLpzrURmka6AXFFFOdevZDr9eGuxr2/d6g
 iOGdV+eAceNCDcy1dlBGg87XGwXgPg1dm9mdKuM4L/CKF0rhP44U1fhtL
 Pp6ibh8+TxWOQsKyFqwxPkLAf9yEmyoPMTBpFbsd3cM2kDHOnWgcewGre
 Xxzd+tAn/48uGUtH4zsMXPBBm+uYRxt3/d5Nk8wjIcfXNKVLnJr0BDs1y Q==;
X-CSE-ConnectionGUID: U6PRp7T0TsKzlIK8yhqy5A==
X-CSE-MsgGUID: ePi3tcZfQZ+WZRu9ao/GgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16692995"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="16692995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 01:32:00 -0700
X-CSE-ConnectionGUID: X7IopqwjQiqSx3gRJlTy+A==
X-CSE-MsgGUID: TWXryn/CSxSdfOXYVOEklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="75406415"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 01:31:59 -0700
Message-ID: <a8f5d517-7037-4146-824e-3f985774c780@intel.com>
Date: Fri, 28 Jun 2024 16:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386: drop AMD machine check bits from Intel
 CPUID
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>
References: <20240627140628.1025317-1-pbonzini@redhat.com>
 <20240627140628.1025317-3-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240627140628.1025317-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.505, HK_RANDOM_FROM=0.457, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/27/2024 10:06 PM, Paolo Bonzini wrote:
> The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
> causes the bit to be visible when "-cpu host" VMs are started on Intel
> processors.
> 
> While this should in principle be harmless, it's not tidy and we don't
> even know for sure that it doesn't cause any guest OS to take unexpected
> paths.  Since x86_cpu_get_supported_feature_word() can return different
> different values depending on the guest, adjust it to hide the SUCCOR

superfluous different

> bit if the guest has non-AMD vendor.

It seems to adjust it based on vendor in kvm_arch_get_supported_cpuid() 
is better than in x86_cpu_get_supported_feature_word(). Otherwise 
kvm_arch_get_supported_cpuid() still returns "risky" value for Intel VMs.

> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: John Allen <john.allen@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index deb58670651..f3e9b543682 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6064,8 +6064,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
>       } else {
>           return ~0;
>       }
> +
> +    switch (w) {
>   #ifndef TARGET_X86_64
> -    if (w == FEAT_8000_0001_EDX) {
> +    case FEAT_8000_0001_EDX:
>           /*
>            * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
>            * way for userspace to get out of its 32-bit jail, we can leave
> @@ -6077,6 +6079,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
>           r &= ~unavail;
>           break;
>   #endif
> +
> +    case FEAT_8000_0007_EBX:
> +        if (cpu && !IS_AMD_CPU(&cpu->env)) {
> +            /* Disable AMD machine check architecture for Intel CPU.  */
> +            r = 0;
> +        }
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
>       if (cpu && cpu->migratable) {
>           r &= x86_cpu_get_migratable_flags(w);
>       }


