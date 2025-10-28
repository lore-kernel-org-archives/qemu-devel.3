Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0AFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfCw-0000fD-MI; Tue, 28 Oct 2025 04:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfCu-0000eu-3t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:37:32 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfCq-0005U8-0e
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761640649; x=1793176649;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=co2V1dgs8SLXhRT4BPL7UibJYfxCY2w8waKe2/vtBNU=;
 b=JY3atuXjFTYMDbL3bn/9WvyjP6QFWMtVB26AMJ31oEeFlINKXrITUzP1
 dbu2/NUYd9DaSvuqYg6008SnYkRKV4FJ4AzaSZHT2UsWNDKj+3moTl8/V
 8bNvaYxc9Q1Tqhrw9uiM9Pl2cxIQytx0yiIHEQMDCrW9lbMXeF590Iyr7
 XzFaEbXq2B2bvwpBulbGu8VktjiIn1aqV8FXKAnWm6Ekgg3WUdZrxQEeM
 +h6Oze+/wuOxc55ALKRjZgWTOJ0+gjFaWdUvPY+deuPHDz8IjP9sFn3RX
 I1sD5lxD/P7ki7JW8xa4k2ei71UYgUDm4OoEmIabCLvEe3Gmf8LJaThXS w==;
X-CSE-ConnectionGUID: LBq5XsTtSbqw/29Wseg78A==
X-CSE-MsgGUID: sm3fPUcAR2KpBSe1nw/FLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63623467"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="63623467"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:37:25 -0700
X-CSE-ConnectionGUID: ZRU4m7bWRrCnsSAzmsIbNw==
X-CSE-MsgGUID: qqGz4TWDSjuh+2wDbjj3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189342494"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:37:21 -0700
Message-ID: <a9bfdd50-14c8-4bb6-8031-9293f8c9d69d@intel.com>
Date: Tue, 28 Oct 2025 16:37:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] i386/tdx: Fix missing spaces in tdx_xfam_deps[]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-20-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-20-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> The checkpatch.pl always complains: "ERROR: space required after that
> close brace '}'".
> 
> Fix this issue.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/kvm/tdx.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index dbf0fa2c9180..a3444623657f 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -520,15 +520,15 @@ typedef struct TdxXFAMDep {
>    * supported.
>    */
>   TdxXFAMDep tdx_xfam_deps[] = {
> -    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA }},
> -    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 }},
> -    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI}},
> -    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16}},
> -    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT}},
> -    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU}},
> -    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 }},
> -    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE }},
> -    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 }},
> +    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA } },
> +    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 } },
> +    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI } },
> +    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
> +    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
> +    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
> +    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
> +    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
> +    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
>   };
>   
>   static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,


