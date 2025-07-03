Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC3C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEAT-0006Cj-Hy; Thu, 03 Jul 2025 03:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXEAQ-0006Bp-5r
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:15:35 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXEAN-0006J7-Ab
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526932; x=1783062932;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sEhMyh7ACkcJdENP3Uqt+6GOmATUkVCYwXQABZ6A4kQ=;
 b=cTbTzD4Jxfr5kmCzkj8ipkwAupfvcuvQEKUTIEMKV4ffanFxXHAviSWC
 6i6Gt93jEkHS2PJfytToJTsmQ+PV8qeRi0zMaR2o1puTxf2m1IYD57r9t
 BcLJH/Knu47QkVNPQgKZ3llhTD6CsCDtyCnFPhz7tqznIf3kQBaqKPCXi
 JbKU1o/qiTsWKFSiSJuuR70NWs+p5tv/4HK6IeZL9IgkxjOXBW37eewiP
 8ErVLrQFyWcQ6Iun7yX3lrDlu0aXRGYzA7Na2FJvGzKA8nm1OaDo5KFFs
 yeb+9Uflm1D66Rn0MAp1/PiCgXPBpfjY1DkDo0UjV4WD5MjxyszgYmXll w==;
X-CSE-ConnectionGUID: bp6tK/PBTaGJoB5Opn3JkA==
X-CSE-MsgGUID: d9MwCHftTlOvdoegjPAAlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64437342"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64437342"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:15:29 -0700
X-CSE-ConnectionGUID: d/2L23pDTSeJZL/b6YqqaA==
X-CSE-MsgGUID: nJ3OZbkPRTSFV7vWdwVhuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="185315215"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:15:24 -0700
Message-ID: <42641bcb-67b8-4c06-900c-378593e74d6b@linux.intel.com>
Date: Thu, 3 Jul 2025 15:15:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] i386/cpu: Add legacy_intel_cache_info cache model
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
 <20250620092734.1576677-10-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.11;
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
> Based on legacy_l1d_cache, legacy_l1i_cache, legacy_l2_cache and
> legacy_l3_cache, build a complete legacy intel cache model, which can
> clarify the purpose of these trivial legacy cache models, simplify the
> initialization of cache info in X86CPUState, and make it easier to
> handle compatibility later.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 101 +++++++++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 47 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0b292aa2e07b..ec229830c532 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -643,21 +643,6 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
>   * These are legacy cache values. If there is a need to change any
>   * of these values please use builtin_x86_defs
>   */
> -
> -/* L1 data cache: */
> -static CPUCacheInfo legacy_l1d_cache = {
> -    .type = DATA_CACHE,
> -    .level = 1,
> -    .size = 32 * KiB,
> -    .self_init = 1,
> -    .line_size = 64,
> -    .associativity = 8,
> -    .sets = 64,
> -    .partitions = 1,
> -    .no_invd_sharing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
>  static CPUCacheInfo legacy_l1d_cache_amd = {
>      .type = DATA_CACHE,
>      .level = 1,
> @@ -672,20 +657,6 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
>      .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>  };
>  
> -/* L1 instruction cache: */
> -static CPUCacheInfo legacy_l1i_cache = {
> -    .type = INSTRUCTION_CACHE,
> -    .level = 1,
> -    .size = 32 * KiB,
> -    .self_init = 1,
> -    .line_size = 64,
> -    .associativity = 8,
> -    .sets = 64,
> -    .partitions = 1,
> -    .no_invd_sharing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
>  static CPUCacheInfo legacy_l1i_cache_amd = {
>      .type = INSTRUCTION_CACHE,
>      .level = 1,
> @@ -700,20 +671,6 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
>      .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>  };
>  
> -/* Level 2 unified cache: */
> -static CPUCacheInfo legacy_l2_cache = {
> -    .type = UNIFIED_CACHE,
> -    .level = 2,
> -    .size = 4 * MiB,
> -    .self_init = 1,
> -    .line_size = 64,
> -    .associativity = 16,
> -    .sets = 4096,
> -    .partitions = 1,
> -    .no_invd_sharing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
>  static CPUCacheInfo legacy_l2_cache_amd = {
>      .type = UNIFIED_CACHE,
>      .level = 2,
> @@ -803,6 +760,59 @@ static const CPUCaches legacy_intel_cpuid2_cache_info = {
>      },
>  };
>  
> +static const CPUCaches legacy_intel_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .sets = 64,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .sets = 64,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .size = 4 * MiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .sets = 4096,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .size = 16 * MiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .sets = 16384,
> +        .partitions = 1,
> +        .lines_per_tag = 1,
> +        .self_init = true,
> +        .inclusive = true,
> +        .complex_indexing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    },
> +};
> +
>  /* TLB definitions: */
>  
>  #define L1_DTLB_2M_ASSOC       1
> @@ -8971,10 +8981,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              env->enable_legacy_cpuid2_cache = true;
>          }
>  
> -        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
> -        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
> -        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
> -        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
> +        env->cache_info_cpuid4 = legacy_intel_cache_info;
>  
>          env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
>          env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



