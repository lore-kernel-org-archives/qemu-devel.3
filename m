Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9007C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDyo-0008Ga-KL; Thu, 03 Jul 2025 03:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXDyk-0008E5-7I
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:03:30 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXDya-0002GN-FN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526201; x=1783062201;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BzXwtEIeavtTZYYUVx+lfAQIPYpgvTwFbxREu6EtwrI=;
 b=LbyEffUYN3xI64jma5t6MA5JvWdrfFszGJnMBZ4sN4d20qhssvgisNCx
 69/1eeMcTLF99AkMLC/RqXcCxXCbtbQ51AgnQWG4Ka3mWYdKemdC077Z/
 1Sgo+qm9VaExwhkPKt5bFf0Wu9XhX1Im0IbZX66DjOxGxMGlCv9L8cknu
 qAA9hVE2CnXNQPN9zWZi2wM0q6LrVuxXH7HqkPQulKM9f8fySQmTiurQu
 9jLeDWPvaEtvtLHg/ne8LoTXdLi+sjB3Hg6ixLAjZ6IkO0vgV+I/rSJdT
 ahh0BDBMqk0NfEcZ/vMgGcuy6YKdzUK4h3sCJKNhcVzKtCGLnCqXK1M+M g==;
X-CSE-ConnectionGUID: uO8bO1x+T6SPoGGdx3i18Q==
X-CSE-MsgGUID: qwTzV9i9RISbdjhprZYinQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64535946"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64535946"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:03:17 -0700
X-CSE-ConnectionGUID: ktBMxDa0SVq6uwU+UbRsHA==
X-CSE-MsgGUID: lvFHRDRCQuecOiGfPhCX8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153924989"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:03:12 -0700
Message-ID: <705f8d41-3577-453a-8464-5cb383708c25@linux.intel.com>
Date: Thu, 3 Jul 2025 15:03:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] i386/cpu: Drop CPUID 0x2 specific cache info in
 X86CPUState
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
 <20250620092734.1576677-7-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.9;
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
> With the pre-defined cache model legacy_intel_cpuid2_cache_info,
> for X86CPUState there's no need to cache special cache information
> for CPUID 0x2 leaf.
>
> Drop the cache_info_cpuid2 field of X86CPUState and use the
> legacy_intel_cpuid2_cache_info directly.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 31 +++++++++++--------------------
>  target/i386/cpu.h |  3 ++-
>  2 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a06aa1d629dc..8f174fb971b6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -244,19 +244,27 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
>      return CACHE_DESCRIPTOR_UNAVAILABLE;
>  }
>  
> +static const CPUCaches legacy_intel_cpuid2_cache_info;
> +
>  /* Encode cache info for CPUID[4] */
>  static void encode_cache_cpuid2(X86CPU *cpu,
>                                  uint32_t *eax, uint32_t *ebx,
>                                  uint32_t *ecx, uint32_t *edx)
>  {
>      CPUX86State *env = &cpu->env;
> -    CPUCaches *caches = &env->cache_info_cpuid2;
> +    const CPUCaches *caches;
>      int l1d, l1i, l2, l3;
>      bool unmatched = false;
>  
>      *eax = 1; /* Number of CPUID[EAX=2] calls required */
>      *ebx = *ecx = *edx = 0;
>  
> +    if (env->enable_legacy_cpuid2_cache) {
> +        caches = &legacy_intel_cpuid2_cache_info;
> +    } else {
> +        caches = &env->cache_info_cpuid4;
> +    }
> +
>      l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
>      l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
>      l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
> @@ -705,17 +713,6 @@ static CPUCacheInfo legacy_l2_cache = {
>      .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>  };
>  
> -/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
> -static CPUCacheInfo legacy_l2_cache_cpuid2 = {
> -    .type = UNIFIED_CACHE,
> -    .level = 2,
> -    .size = 2 * MiB,
> -    .line_size = 64,
> -    .associativity = 8,
> -    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
> -};
> -
> -
>  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
>  static CPUCacheInfo legacy_l2_cache_amd = {
>      .type = UNIFIED_CACHE,
> @@ -8951,18 +8948,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>                         "CPU model '%s' doesn't support legacy-cache=off", name);
>              return;
>          }
> -        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
> -            *cache_info;
> +        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
>      } else {
>          /* Build legacy cache information */
> -        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
> -        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
>          if (!cpu->consistent_cache) {
> -            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
> -        } else {
> -            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
> +            env->enable_legacy_cpuid2_cache = true;
>          }
> -        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
>  
>          env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
>          env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 3c7e59ffb12a..8d3ce8a2b678 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2076,7 +2076,8 @@ typedef struct CPUArchState {
>       * on each CPUID leaf will be different, because we keep compatibility
>       * with old QEMU versions.
>       */
> -    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
> +    CPUCaches cache_info_cpuid4, cache_info_amd;
> +    bool enable_legacy_cpuid2_cache;
>  
>      /* MTRRs */
>      uint64_t mtrr_fixed[11];

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


