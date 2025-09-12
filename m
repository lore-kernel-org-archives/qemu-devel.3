Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA9CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwax-0002TD-HF; Fri, 12 Sep 2025 01:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwat-0002St-Ll
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:45:12 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwaq-0001dq-LD
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757655908; x=1789191908;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=C2b02f5W/yfeW3l+NMzSxX0QrkOtgZDLOt9gXLEO4JE=;
 b=MtMTkSytGD/WNKO6YuyVzoe9x3C8wOSOFCE8QhCR+/R2F6pDXd6mcBxP
 ksY6UKQc6Ft5TiXk4EfNXO+WJqW+l9Li4+bSO6GrQWfbXZKRvukZileBl
 EC9nWo43wGn128Ml1S2n76lMiip+eekhrBsLplopfBbrWmRDOY4CkETtz
 A1AEafmJv7AWDquRILzW4ZO4UndI6KdeW6+Euk420FFlgbUfBzyZiXn15
 wLg9aoUMVz1/+H8iMkvxw750xaAuQNIvTiU1eVOpm2ffr9EIA7b7B4Urj
 PUGi8lPJd97NImPglweZPf59ufz22ktRVd/NieQbA0D5ntI4U2wzlhKvA A==;
X-CSE-ConnectionGUID: v1K4UYGTTiKq2AODPCZuzQ==
X-CSE-MsgGUID: aBS8H0pBQx+eUoLkLClTGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60144382"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="60144382"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:45:03 -0700
X-CSE-ConnectionGUID: 2h9KKb9ORBCw0GWUSszqaw==
X-CSE-MsgGUID: 8NNcPvDhTECAI43yW2Fo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173055439"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:45:02 -0700
Message-ID: <c878ee60-9e7e-4a14-9bf6-e7331196af82@intel.com>
Date: Fri, 12 Sep 2025 13:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, tao1.su@intel.com, 
 chenyi.qiang@intel.com
References: <20250707141151.4187798-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250707141151.4187798-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Gentle Ping.

On 7/7/2025 10:11 PM, Xiaoyao Li wrote:
> It turns out that all the Intel processors enumerating the support of
> Intel AVX10 support all vector widths. It's documented in the latest
> SDM, vol 1, Chapter 16 "programming with Intel AVX10".
> 
> (Note that AVX10.1 spec stops update since AVX10 is subsumed into SDM
>   while AVX10.2 spec stays update for the future extension of AVX10)
> 
> Now SDM [1] marks the bit 16-18 of CPUID.0x24_0.EBX as reserved and they
> are reserved at 1. The purpose of Intel is to remove the semantic of
> vector length enumeration from these bits since all the 128/256/512 bit
> length are supported and no need for enumeration. But Intel has to keep
> them reserved at 1 to make it compatible with the software written based
> on earlier avx10 spec that checks the bits to query of the support of each
> vector length.
> 
> For QEMU, it makes no sense to allow the configurability of the bits
> anymore. Remove the leaf FEAT_24_0_EBX and related stuff. Just hardcore
> the bits to all 1 when AVX10 is exposed to guest, to comply with the SDM
> and stop trying to associate them with the enumeration of vector length.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671200 (rev 088)
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v2:
>   - refine the commit message to reference update from SDM instead of
>     AVX10 spec;
>   - call out explicitly the purpose of disassociating the enumeration of
>     vector length from the CPUID bits.
> ---
>   target/i386/cpu.c | 37 ++-----------------------------------
>   target/i386/cpu.h | 12 ------------
>   2 files changed, 2 insertions(+), 47 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430fe..1b50fd4e397d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -912,7 +912,6 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>   #define TCG_SGX_12_0_EAX_FEATURES 0
>   #define TCG_SGX_12_0_EBX_FEATURES 0
>   #define TCG_SGX_12_1_EAX_FEATURES 0
> -#define TCG_24_0_EBX_FEATURES 0
>   
>   #if defined CONFIG_USER_ONLY
>   #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
> @@ -1208,20 +1207,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           },
>           .tcg_features = TCG_7_2_EDX_FEATURES,
>       },
> -    [FEAT_24_0_EBX] = {
> -        .type = CPUID_FEATURE_WORD,
> -        .feat_names = {
> -            [16] = "avx10-128",
> -            [17] = "avx10-256",
> -            [18] = "avx10-512",
> -        },
> -        .cpuid = {
> -            .eax = 0x24,
> -            .needs_ecx = true, .ecx = 0,
> -            .reg = R_EBX,
> -        },
> -        .tcg_features = TCG_24_0_EBX_FEATURES,
> -    },
>       [FEAT_8000_0007_EDX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> @@ -1839,22 +1824,6 @@ static FeatureDep feature_dependencies[] = {
>           .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
>           .to = { FEAT_SGX_12_1_EAX,          ~0ull },
>       },
> -    {
> -        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
> -        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
> -    },
> -    {
> -        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
> -        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
> -    },
> -    {
> -        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
> -        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
> -    },
> -    {
> -        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
> -        .to = { FEAT_24_0_EBX,              ~0ull },
> -    },
>   };
>   
>   typedef struct X86RegisterInfo32 {
> @@ -4732,9 +4701,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                       { "movdiri", "on" },
>                       { "movdir64b", "on" },
>                       { "avx10", "on" },
> -                    { "avx10-128", "on" },
> -                    { "avx10-256", "on" },
> -                    { "avx10-512", "on" },
>                       { "avx10-version", "1" },
>                       { "stepping", "1" },
>                       { /* end of list */ }
> @@ -7720,7 +7686,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *ecx = 0;
>           *edx = 0;
>           if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
> -            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
> +            /* bit 16-18 are reserved at 1 */
> +            *ebx = (0x7U << 16) | env->avx10_version;
>           }
>           break;
>       }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 51e10139dfdf..7856a882f014 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -671,7 +671,6 @@ typedef enum FeatureWord {
>       FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
> -    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
>       FEATURE_WORDS,
>   } FeatureWord;
>   
> @@ -1037,17 +1036,6 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   /* Packets which contain IP payload have LIP values */
>   #define CPUID_14_0_ECX_LIP              (1U << 31)
>   
> -/* AVX10 128-bit vector support is present */
> -#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
> -/* AVX10 256-bit vector support is present */
> -#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
> -/* AVX10 512-bit vector support is present */
> -#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
> -/* AVX10 vector length support mask */
> -#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
> -                                         CPUID_24_0_EBX_AVX10_256 | \
> -                                         CPUID_24_0_EBX_AVX10_512)
> -
>   /* RAS Features */
>   #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
>   #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)


