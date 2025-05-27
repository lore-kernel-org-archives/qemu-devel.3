Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CA6C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq5I-0005mE-8Y; Tue, 27 May 2025 04:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJq5F-0005j0-Nc
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:54:53 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJq5D-0002GZ-0L
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748336091; x=1779872091;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q/LWDDFdpB2ms1x4mCQbLyzn31BMzfii1VHC4mEjqMw=;
 b=SUjGdP6x5RULtYlapGGD+czzV63WMSyq4yVKfY8CvaYzRDlN+uDb0IKJ
 pSewMq2+kPY+T+rZ/vG07H2uHyEuVXYco+8x6Pu4lA7zwyL9GoK/kYCS7
 nJKiXyZZkd5thrIIPciuuXsMQEFJs5BKMlvkQ1/pcK3s1N7ZIQ3pHpN3X
 YppZSFGpLWgArNXhHlNHE85S0Xb3/zjd8bYqfReap4oT9YOvcoBB6Fvs/
 R1n7dpXzp//3hqr4mUbpCrAratN94lV7EtBQZo6TUcjL/fime/flLmQoe
 kt1lrbXwXO0dFCMpYkMwjqQlKvnylNjKnmDpUSfCBim1kVCjLY/XaRz2e A==;
X-CSE-ConnectionGUID: Oj/Y4ITOQea9Oun3ZWVs/A==
X-CSE-MsgGUID: eGOf7q/lQi6HPJEUcK1Egw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50474021"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="50474021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 01:54:45 -0700
X-CSE-ConnectionGUID: ZbCSfBkcTXGZmASiSGn+zg==
X-CSE-MsgGUID: OuHNMLqDQZWQqyO7mBKquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="142717217"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 27 May 2025 01:54:42 -0700
Date: Tue, 27 May 2025 17:15:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Message-ID: <aDWCxhsCMavTTzkE@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On 4/23/25 7:46 PM, Zhao Liu wrote:
> > 
> > Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
> > "assert" check blocks adding new cache model for non-AMD CPUs.
> > 
> > Therefore, check the vendor and encode this leaf as all-0 for Intel
> > CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
> > check for Zhaoxin as well.
> > 
> > Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
> > information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
> > For this case, there is no need to tweak for non-AMD CPUs, because
> > vendor_cpuid_only has been turned on by default since PC machine v6.1.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   target/i386/cpu.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1b64ceaaba46..8fdafa8aedaf 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7248,11 +7248,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
> >           break;
> >       case 0x80000005:
> > -        /* cache info (L1 cache) */
> > -        if (cpu->cache_info_passthrough) {
> > +        /*
> > +         * cache info (L1 cache)
> > +         *
> > +         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
> > +         * information, i.e., get AMD's cache model. It doesn't matter,
> > +         * vendor_cpuid_only has been turned on by default since
> > +         * PC machine v6.1.
> > +         */
> > +        if (cpu->vendor_cpuid_only &&
> > +            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> > +            *eax = *ebx = *ecx = *edx = 0;
> > +            break;
> > +        } else if (cpu->cache_info_passthrough) {
> >               x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
> >               break;
> >           }
> > +
> >           *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
> >                  (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
> >           *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
> 
> I've reviewed the cache-related CPUID path and noticed an oddity: every AMD
> vCPU model still reports identical hard-coded values for the L1 ITLB and L1
> DTLB fields in leaf 0x8000_0005. Your patch fixes this for Intel(and
> Zhaoxin), but all AMD models continue to receive the same constants in
> EAX/EBX.

Yes, TLB info is hardcoded here. Previously, Babu and Eduardo cleaned up
the cache info but didn't cover TLB [*]. I guess one reason would there
are very few use cases related to TLB's info, and people are more
concerned about the cache itself.

[*]: https://lore.kernel.org/qemu-devel/20180510204148.11687-2-babu.moger@amd.com/

> Do you know the reason for this choice? Is the guest expected to ignore
> those L1 TLB numbers? If so, I'll prepare a patch that adjusts only the
> Zhaoxin defaults in leaf 0x8000_0005 like below, matching real YongFeng
> behaviour in ecx and edx, but keep eax and ebx following AMD's behaviour.

This way is fine for me.

> ## Notes
> 1. Changes tied to "-machine smp-cache xxx" (mainly
> x86_cpu_update_smp_cache_topo()) are not included here.
> 2. Do you think I need Zhaoxin-specific legacy_l1d/l1i/l2/l3_cache helpers?
> If yes, I'll add them with YongFeng sillicon topology data.

Legacy cache info stands for information on very old machines. So I
think your yongfeng_cache_info is enough for Yongfeng CPU.

> --- patch prototype start ---

Thank you for your patch!

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7b223642ba..8a17e5ffe9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2726,6 +2726,66 @@ static const CPUCaches xeon_srf_cache_info = {
>      },
>  };
> 
> +static const CPUCaches yongfeng_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .inclusive = false,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 64 * KiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .inclusive = false,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .size = 256 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 512,
> +        .lines_per_tag = 1,
> +        .inclusive = true,
> +        .self_init = true,
> +        .no_invd_sharing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .size = 8 * MiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .partitions = 1,
> +        .sets = 8192,
> +        .lines_per_tag = 1,
> +        .self_init = true,
> +        .inclusive = true,
> +        .no_invd_sharing = true,
> +        .complex_indexing = false,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,

Just to confirm:

Is the topology of cache on your physical machines per-die instead of
per-socket?

> +    },
> +};
> +
>  /* The following VMX features are not supported by KVM and are left out in the
>   * CPU definitions:
>   *
> @@ -5928,6 +5988,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version = 3,
> +                .note = "wiith the correct model number and cache info",
> +                .props = (PropValue[]) {
> +                    { "model", "0x5b" },
> +                    { /* end of list */ }
> +                },
> +                .cache_info = &yongfeng_cache_info
> +            },
>              { /* end of list */ }
>          }
>      },

Adding a cache model can be done as a separate patch. :-)

> @@ -7565,8 +7634,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,
> uint32_t count,
>           * vendor_cpuid_only has been turned on by default since
>           * PC machine v6.1.
>           */
> -        if (cpu->vendor_cpuid_only &&
> -            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> +        if (cpu->vendor_cpuid_only && IS_INTEL_CPU(env)) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          } else if (cpu->cache_info_passthrough) {
> @@ -7578,8 +7646,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,
> uint32_t count,
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>          *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
> -        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
> -        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
> +
> +        if (IS_AMD_CPU(env)) {
> +            *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
> +            *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
> +            break;
> +        }

AMD uses 0x80000005 and doesn't use 0x4 leaf. Does Zhaoxin use 0x4?
If not, you can fix 0x4 for Zhaoxin, too.

> +        /* Zhaoxin follows AMD behaviour on leaf 0x8000_0005 */
> +        if (IS_ZHAOXIN_CPU(env)) {
> +            *ecx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1d_cache);
> +            *edx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1i_cache);

Maybe it's not necessary to add cache_info_zhaoxin? Zhaoxin could use
legacy cache_info_cpuid4 with Intel, because it seems cache_info_zhaoxin
is same as cache_info_cpuid4.

For this case, you can add a comment like "This is a special case where
Zhaoxin follows AMD. Elsewhere, Zhaoxin follows Intel's behavior."

> +            break;
> +        }
> +
> +        /* Other vendors */
> +        *eax = *ebx = *ecx = *edx = 0;
>          break;
>      case 0x80000006:
>          /* cache info (L2 cache) */
> @@ -8638,7 +8719,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              return;
>          }
>          env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
> -            *cache_info;
> +            env->cache_info_zhaoxin = *cache_info;
>      } else {
>          /* Build legacy cache information */
>          env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
> @@ -8655,6 +8736,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
>          env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
>          env->cache_info_amd.l3_cache = &legacy_l3_cache;
> +
> +        env->cache_info_zhaoxin.l1d_cache = &legacy_l1d_cache;
> +        env->cache_info_zhaoxin.l1i_cache = &legacy_l1i_cache;
> +        env->cache_info_zhaoxin.l2_cache = &legacy_l2_cache;
> +        env->cache_info_zhaoxin.l3_cache = &legacy_l3_cache;

As I said above, we can apply cache_info_cpuid4 for Zhaoxin too.

>      }
> 
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d98c9ba282..46bfd6f6b0 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2062,6 +2062,7 @@ typedef struct CPUArchState {
>       * with old QEMU versions.
>       */
>      CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
> +    CPUCaches cache_info_zhaoxin;
> 
>      /* MTRRs */
>      uint64_t mtrr_fixed[11];
> 
> 
> 
> 

