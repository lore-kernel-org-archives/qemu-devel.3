Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A041F53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CVi-0000HA-75; Mon, 16 Mar 2026 14:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w2CVa-0000GZ-BQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:17:43 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w2CVY-0004O4-Iz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773685060; x=1805221060;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KyPEPqesLYTOsWwjXlMYthd6Gd2uEGN/gOmmt8vtMFA=;
 b=Sy07jS903Bc9uK1sOiAmirUO2wOussUeDlG2yF6iUkS89ekf0RT9mErf
 Dc94pblzZ9TRHAvQCXqYWy+fVtC0VjRtbPKfM8dKzhbyk8hrVVZ1X6M1Q
 veRv60k1EJXWO+WgEZDlAlN/m/M6Leo6Eqqd02BIzNF176QG2T4DDnk+i
 iLXqjP8G+qB2oDhgnKR2AolUEciIBIr4Nx3lwCtEaQ/QTqrv8/ZYGrmQb
 VGCxUtjmQKsZ7b4iVGYoRR6eBjovNZJL4xf7hRThX3gRBVpahaKdpQhVk
 aUnTZkpaOz1GeyZgPeJxhLPLCnEB9SwxzE3bI/9zHUsM/Z46CkYuL9tzP w==;
X-CSE-ConnectionGUID: N1/DW2h8SrCbulj2Mf126Q==
X-CSE-MsgGUID: mZjdfVoIRtiYHXPIcfx4Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85793273"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85793273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 11:17:40 -0700
X-CSE-ConnectionGUID: fDtS/vM9SE2zpGpgmBygew==
X-CSE-MsgGUID: xRLGUM+ISQ+wIh4TzWD+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="216482181"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.35])
 ([10.241.241.35])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 11:17:37 -0700
Message-ID: <0e81f486-6609-4181-9b85-161c69fbb704@intel.com>
Date: Mon, 16 Mar 2026 11:17:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Hector Cao <hector.cao@canonical.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
 <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/15/2026 8:21 PM, Chenyi Qiang wrote:
> 
> 
> On 3/5/2026 2:07 AM, Zide Chen wrote:
>> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
>> - When PMU is disabled, Debug Store must not be exposed to the guest,
>>   which implicitly disables legacy DS-based PEBS.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V3:
>> - Update title to be more accurate.
>> - Make DTES64 depend on DS.
>> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
>> - Clean up the commit message.
>>
>> V2: New patch.
>> ---
>>  target/i386/cpu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 2e1dea65d708..3ff9f76cf7da 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>>          .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>>          .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>>      },
>> +    {
>> +        .from = { FEAT_1_EDX,               CPUID_DTS},
>> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
>> +    },
>>      {
>>          .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>>          .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
>> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>          }
>>  
>> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>>          env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> 
> This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear, will also affect the configuration for TD VMs. 
> For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS is fixed to 1, and arch_lbr is controlled by XFAM[15].

Yes, I agree. In the TDX case, neither the DTS nor the arch_lbr bit
should be cleared.


> These features' configuration do not have dependencies on each other. So how about skipping the TD VM case like:
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 98e95d0842..458bfb07b9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>          }
> 
> -        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> -        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        if (!is_tdx_vm()) {
> +            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> +            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
> +        }
>      }
> 
>      for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> 
> 
> 
>>      }
>>  
> 


