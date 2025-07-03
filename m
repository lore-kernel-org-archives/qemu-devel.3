Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF93C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXE2w-0002XE-1t; Thu, 03 Jul 2025 03:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXE2u-0002Tz-3p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:07:48 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXE2p-0003XN-TX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526464; x=1783062464;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yhwYOjrKq9ebGmZR+FPGnDwzlieY5n9LStWiPQOmj6U=;
 b=TPQJ7jdmf1yeHrB0pstmGfn/R10XYxmVhbBDBKa3D/h/eO4LPqG0LhTB
 FqN6INwwtzv/gxepF3EngnRHo9lhXf9vfDmeDEOFhQzjUJsb8yiTIEEMa
 HjqgwEs3mZlZXsZ+Fug/pdgzRE/Xa8TILmh3U2JzOW87nLCt/lHNu+jyA
 YKhqJgPdtE4D7Tngir3bu08PW/ekQvteFMm1+oWpEiEd3cgmVRZzzrRwK
 EXuQYb8KKlRoCNjgqlRFd4brbDITekxRWCrG88187VISPCFjQmN5STGFn
 TZiMNklE9SjSPD+N522fUWS2tyduPZLxGd8BwJBnLrGvW7bLzU/g9k2Uu w==;
X-CSE-ConnectionGUID: lM/Qzc2ySliZ/QcU02vPbQ==
X-CSE-MsgGUID: cZ9svscqSSa32JkTjayMDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53560557"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53560557"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:07:41 -0700
X-CSE-ConnectionGUID: P2P8NYlaQfCrKV2v+DWr9g==
X-CSE-MsgGUID: UwQDhg03RpGOCpROJUYAXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154778852"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:07:37 -0700
Message-ID: <44cdc08c-21e9-422c-b55a-17e53d34ef90@linux.intel.com>
Date: Thu, 3 Jul 2025 15:07:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] i386/cpu: Mark CPUID[0x80000005] as reserved for
 Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-8-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/20/2025 5:27 PM, Zhao Liu wrote:
> Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
> "assert" check blocks adding new cache model for non-AMD CPUs.
>
> And please note, although Zhaoxin mostly follows Intel behavior,
> this leaf is an exception [1].
>
> So, add a compat property "x-vendor-cpuid-only-v2" (for PC machine v10.0
> and older) to keep the original behavior. For the machine since v10.1,
> check the vendor and encode this leaf as all-0 only for Intel CPU.
>
> This fix also resolves 2 FIXMEs of legacy_l1d_cache_amd and
> legacy_l1i_cache_amd:
>
> /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>
> In addition, per AMD's APM, update the comment of CPUID[0x80000005].
>
> [1]: https://lore.kernel.org/qemu-devel/fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com/
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since RFC:
>  * Only set all-0 for Intel CPU.
>  * Add x-vendor-cpuid-only-v2.
> ---
>  hw/i386/pc.c      |  1 +
>  target/i386/cpu.c | 11 ++++++++---
>  target/i386/cpu.h | 11 ++++++++++-
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ad2d6495ebde..9ec3f4db31f3 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -83,6 +83,7 @@
>  
>  GlobalProperty pc_compat_10_0[] = {
>      { TYPE_X86_CPU, "x-consistent-cache", "false" },
> +    { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
>  };
>  const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8f174fb971b6..df40d1362566 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -655,7 +655,6 @@ static CPUCacheInfo legacy_l1d_cache = {
>      .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>  };
>  
> -/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>  static CPUCacheInfo legacy_l1d_cache_amd = {
>      .type = DATA_CACHE,
>      .level = 1,
> @@ -684,7 +683,6 @@ static CPUCacheInfo legacy_l1i_cache = {
>      .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>  };
>  
> -/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>  static CPUCacheInfo legacy_l1i_cache_amd = {
>      .type = INSTRUCTION_CACHE,
>      .level = 1,
> @@ -7889,11 +7887,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
>          break;
>      case 0x80000005:
> -        /* cache info (L1 cache) */
> +        /* cache info (L1 cache/TLB Associativity Field) */
>          if (cpu->cache_info_passthrough) {
>              x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
>              break;
>          }
> +
> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
> +            *eax = *ebx = *ecx = *edx = 0;
> +            break;
> +        }
> +
>          *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>          *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
> @@ -9464,6 +9468,7 @@ static const Property x86_cpu_properties[] = {
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
> +    DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8d3ce8a2b678..02cda176798f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2282,9 +2282,18 @@ struct ArchCPU {
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> -    /* Only advertise CPUID leaves defined by the vendor */
> +    /*
> +     * Compatibility bits for old machine types (PC machine v6.0 and older).
> +     * Only advertise CPUID leaves defined by the vendor.
> +     */
>      bool vendor_cpuid_only;
>  
> +    /*
> +     * Compatibility bits for old machine types (PC machine v10.0 and older).
> +     * Only advertise CPUID leaves defined by the vendor.
> +     */
> +    bool vendor_cpuid_only_v2;
> +
>      /* Only advertise TOPOEXT features that AMD defines */
>      bool amd_topoext_features_only;
>  

The Intel related part looks good to me. (Not quite familiar with AMD's
Spec, so no reviewed-by tag)



