Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E65F513F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyNpF-0001lo-OH; Fri, 06 Mar 2026 00:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNpE-0001lZ-3a
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:34:12 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNpC-0003Lo-JL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772775251; x=1804311251;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eddxyeWVkUyW0AcN7Wf7qdFoHBwu0Mn0ZNswE1Ip1Kc=;
 b=C/9W4cYnqrm0VAh5Oej8pwDtXEZx4HhaXKu9tzqN99e3M8MHBNUxuEjj
 iaNH5o9SGHrpiJzXA47VtMSkrXAK+aejM5JjyIC+KRtxvT0TIcbBIuDcV
 e4b+xismf4JgIYpB3PsPsM2FkJJ7/Vh3USIeGTqwb2IDMwBKr8heT1vzM
 6XFlF2pSDZB0WsxvP8hU0X+KA0fiVdM5sHPww44Ev+1s8HblEkk6j6Bzi
 K4YaZuQBgUGsYRqve0Qw8OCt2D+WIGjgfepgW86ii/ihqpmJCJHPMXk1h
 HSKEPiHozDfSgidlStYYAA9zooYYlxxGHeM7xuy2H59zfbVu+zP6h2fbN g==;
X-CSE-ConnectionGUID: gmxzu7LHR1eH/7aFZUVnCA==
X-CSE-MsgGUID: X2ztXDVOQWm8KI8ohxUjrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91269237"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91269237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:34:06 -0800
X-CSE-ConnectionGUID: tCSWuHajQISJOM7eQNBNqA==
X-CSE-MsgGUID: YcADNc1KT9GnB0ZdlfW55w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215630782"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:34:03 -0800
Message-ID: <9d74db3d-49d0-493f-9c68-da5d97f9c45e@linux.intel.com>
Date: Fri, 6 Mar 2026 13:34:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-13-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 3/5/2026 2:07 AM, Zide Chen wrote:
> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
> - When PMU is disabled, Debug Store must not be exposed to the guest,
>   which implicitly disables legacy DS-based PEBS.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3:
> - Update title to be more accurate.
> - Make DTES64 depend on DS.
> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
> - Clean up the commit message.
>
> V2: New patch.
> ---
>  target/i386/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2e1dea65d708..3ff9f76cf7da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>          .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>          .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>      },
> +    {
> +        .from = { FEAT_1_EDX,               CPUID_DTS},
> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
> +    },
>      {
>          .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>          .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>          }
>  
> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>          env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>      }
>  

