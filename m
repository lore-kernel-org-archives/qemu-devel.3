Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232A2C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK75p-0006aI-Rz; Tue, 27 May 2025 23:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK75b-0006YD-6l
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:04:24 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK75Z-0006jZ-BW
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748401461; x=1779937461;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1zUohZKnyQWPT/TPPGVsUpOiaEjBPiUPBWN317vof5c=;
 b=O4Of8r+UED9jko8cFLB/PQhfs8FUM+IiUk/MxUyGZmQwQ8kfmhcKHfsE
 QD/F9avgeCnkSYMhYb3NBGXX1V0rmQ+RAf/0N/u5RjzzLbQ1Ik/EXzHKp
 PMK7Mw94imjz+8caN3HEzK4PqK3StjLybRFsUnYKmC6HS7A+pqFhew1FI
 8i91wlKLRTpZzYwDp0K0jP17Zwy7DbZydBVLq45r4qICc0eroZgkaiC1c
 7bY/dTHk6QvFnxuN8wKPEzI13L3IVJSMvyHyMzjVEElevQg9qKVTp4tKN
 FCQzP0GrKj/WMcrOc1eo9eKby0GrueJD8HmXM63Vn/vsI0vwDqwGef07K A==;
X-CSE-ConnectionGUID: 1HF8ueGGRWWR5UvlYB3IRA==
X-CSE-MsgGUID: +hhgCC9mS1CvbZgpK6dR/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50570645"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="50570645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:04:19 -0700
X-CSE-ConnectionGUID: iOdUlqrwTj6uF26jbUKq6Q==
X-CSE-MsgGUID: YbYKdbb/S0upcHz2IOlr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="147848808"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 27 May 2025 20:04:17 -0700
Date: Wed, 28 May 2025 11:25:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: elisey.konstantinov@icloud.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
Message-ID: <aDaCJTkoDYsdJFmJ@intel.com>
References: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Elisey,

Thank you for your patch! I'm sorry I previously noticed #2894 [*] but
missed your report.

Recently there's a fix (commit 5979f50fa9fd ("i386/tcg: Make CPUID_HT
and CPUID_EXT3_CMP_LEG supported")). Does that fix address this bug?

[*]: https://lore.kernel.org/qemu-devel/aCWdhIqZiu4q+UJi@intel.com/

Regards,
Zhao

On Tue, May 27, 2025 at 07:10:27PM +0300, elisey.konstantinov@icloud.com wrote:
> Date: Tue, 27 May 2025 19:10:27 +0300
> From: elisey.konstantinov@icloud.com
> Subject: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
>  x86_cpu_expand_features() instead of cpu_x86_cpuid()"
> X-Mailer: Apple Mail (2.3826.600.51.1.1)
> 
> From e2f3eab60e9b9787c5c8f87bea5d1bd7079d982e Mon Sep 17 00:00:00 2001
> From: Elisey <elisey.konstantinov@icloud.com>
> Date: Tue, 27 May 2025 17:17:35 +0300
> Subject: [PATCH] Revert "i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()"
> 
> This reverts commit c6bd2dd634208ca717b6dc010064fe34d1359080.
> 
> The original change caused a regression where macOS guests (XNU kernel)
> would panic during boot with a divide error (type=0) when using SMP
> configuration. This affects multiple macOS versions from 10.6 to 10.14
> and possibly others.
> 
> The issue occurs during kernel TSC initialization and can be worked
> around by using single-core configuration (-smp 1), but reverting this
> change restores proper multi-core functionality.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2933
> Tested-by: Elisey Konstantinov <elisey.konstantinov@icloud.com>
> Signed-off-by: Elisey Konstantinov <elisey.konstantinov@icloud.com>
> ---
> target/i386/cpu.c | 15 +--------------
> 1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9689f6374e..c648a1cf04 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6859,6 +6859,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>         *edx = env->features[FEAT_1_EDX];
>         if (threads_per_pkg > 1) {
>             *ebx |= threads_per_pkg << 16;
> +            *edx |= CPUID_HT;
>         }
>         if (!cpu->enable_pmu) {
>             *ecx &= ~CPUID_EXT_PDCM;
> @@ -7838,20 +7839,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>         }
>     }
> 
> -    if (x86_threads_per_pkg(&env->topo_info) > 1) {
> -        env->features[FEAT_1_EDX] |= CPUID_HT;
> -
> -        /*
> -         * The Linux kernel checks for the CMPLegacy bit and
> -         * discards multiple thread information if it is set.
> -         * So don't set it here for Intel (and other processors
> -         * following Intel's behavior) to make Linux guests happy.
> -         */
> -        if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
> -            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
> -        }
> -    }
> -
>     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
>         FeatureDep *d = &feature_dependencies[i];
>         if (!(env->features[d->from.index] & d->from.mask)) {
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

