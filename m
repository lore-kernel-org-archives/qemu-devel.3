Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD4C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 06:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeIp-00014S-NC; Thu, 13 Jun 2024 02:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeIn-00014K-Rm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:51:17 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeIk-0003Fi-ST
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718261475; x=1749797475;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OqkYxmUOfBSzzH178ecuVkjIRH9iD616/PR4kw4x0iI=;
 b=ECOnRKW6iT2C93TngyKuR/hO2TBIopJ9dnEQHEBjpW6SAfwCtUYMz2sC
 mftfJx3co2P/EOPVwXb78aJnSsVhd2c+lYd3XBPnsd6dTIbHYD+5wewog
 E3oZFLYsWkfS/t10ep8b1eZVLKaSbYHNbd+Uk9BzKSOY4mJkzt4G4Ny5K
 g1mfZ0TuKi+KgtSSEb54y+YtcHX8xafo1Z+wDpUtfWpV/KSY+wp6roA9A
 kIY7t8lxdpUUUNtxvIRVHUKbmtWfMUxaAgAP7YlTkdIwfbYoC1tKZjDcv
 WFFCiiWIYHogOD9n09Ak9KinUrgi5wr/xrU/QFqcwXfkGymBmWWT4P0iR A==;
X-CSE-ConnectionGUID: 29H3EtBjTPeFBqd+M8oz6w==
X-CSE-MsgGUID: 2WdUA3xmTqSxnLNMgfQd8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15230005"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15230005"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 23:50:58 -0700
X-CSE-ConnectionGUID: u7wbnEIlSLav0AoIrtpXEw==
X-CSE-MsgGUID: GjJuT3mXT66W7daApdG84w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="40106244"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 12 Jun 2024 23:50:56 -0700
Date: Thu, 13 Jun 2024 15:06:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] i386/cpu: Add PerfMonV2 feature bit
Message-ID: <Zmqace8eCFHPq8ZK@intel.com>
References: <cover.1718218999.git.babu.moger@amd.com>
 <6f83528b78d31eb2543aa09966e1d9bcfd7ec8a2.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f83528b78d31eb2543aa09966e1d9bcfd7ec8a2.1718218999.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 12, 2024 at 02:12:18PM -0500, Babu Moger wrote:
> Date: Wed, 12 Jun 2024 14:12:18 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH 2/4] i386/cpu: Add PerfMonV2 feature bit
> X-Mailer: git-send-email 2.34.1
> 
> From: Sandipan Das <sandipan.das@amd.com>
> 
> CPUID leaf 0x80000022, i.e. ExtPerfMonAndDbg, advertises new performance
> monitoring features for AMD processors. Bit 0 of EAX indicates support
> for Performance Monitoring Version 2 (PerfMonV2) features. If found to
> be set during PMU initialization, the EBX bits can be used to determine
> the number of available counters for different PMUs. It also denotes the
> availability of global control and status registers.
> 
> Add the required CPUID feature word and feature bit to allow guests to
> make use of the PerfMonV2 features.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 26 ++++++++++++++++++++++++++
>  target/i386/cpu.h |  4 ++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 86a90b1405..7f1837cdc9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1228,6 +1228,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .tcg_features = 0,
>          .unmigratable_flags = 0,
>      },
> +    [FEAT_8000_0022_EAX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            "perfmon-v2", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
> +        .tcg_features = 0,
> +        .unmigratable_flags = 0,
> +    },
>      [FEAT_XSAVE] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> @@ -6998,6 +7014,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x80000022:
> +        *eax = *ebx = *ecx = *edx = 0;
> +        /* AMD Extended Performance Monitoring and Debug */
> +        if (kvm_enabled() && cpu->enable_pmu &&
> +            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
> +            *eax = CPUID_8000_0022_EAX_PERFMON_V2;
> +            *ebx = kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
> +                                                R_EBX) & 0xf;

Although only EAX[bit 0] and EBX[bits 0-3] are supported right now, I
think it's better to use ¡°|=¡± rather than just override the
original *eax and *ebx, which will prevent future mistakes or omissions.

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


