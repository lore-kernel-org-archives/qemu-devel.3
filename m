Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDG5Q-0005RI-Un; Mon, 27 Oct 2025 01:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDG5O-0005R7-OJ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:48:06 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDG5M-0001VD-Eq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544085; x=1793080085;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=24zEWJ2BhHyTK1Z3gf/A4Z3jWdwL2s4O/5Gno5jTRLU=;
 b=Uq+dakpVFUihp9eQvmeij3dmTbzHdlDQsg1oIGn/h0TivdIMU3aX5kjL
 VuFF9edY1GTgKQ0D6jMO/0m8/GPg1SyfKRvybJnndx5YO8R8KmmW7c6Q4
 eqsiGFud9j/w2e6fJyqsx3q9fuunxYs5C6yTsqDv5Uz9VEN9IX+mPqcIf
 63k4Vz096k8oSygw5wQj3o0gkygq6g8B9b5e/kKXu+JU3qoWnWAAha91J
 Iuld6BtMcb5TpH9053nYxrazW6230ZWhJ7uUM4L4ZQ2orRajVjvTonwMR
 dIwrwzUT/+SbgK62U0FQlyRfpUg7evKCYd82sTZqjOnv0pOIAeVrAQjVu A==;
X-CSE-ConnectionGUID: luLJ0jSGQlyfSEfmqs1VVA==
X-CSE-MsgGUID: YJZYagGUR9u8jFwcKwC2Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63541804"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63541804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:48:01 -0700
X-CSE-ConnectionGUID: /SnmDoMzTvOFq7mwUpzN/Q==
X-CSE-MsgGUID: b6cy4JhCSIe4bWzQbH9gHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184566973"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:47:57 -0700
Message-ID: <94d254b3-3d0f-4fe8-b6aa-da5df2b9c0e6@intel.com>
Date: Mon, 27 Oct 2025 13:47:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] i386/cpu: Clean up indent style of
 x86_ext_save_areas[]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-3-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.57, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:

<empty commit message> isn't good.

> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 58 +++++++++++++++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0a66e1fec939..f0e179c2d235 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2028,38 +2028,46 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
>           .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
>           .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
>       },
> -    [XSTATE_YMM_BIT] =
> -          { .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
> -            .size = sizeof(XSaveAVX) },
> -    [XSTATE_BNDREGS_BIT] =
> -          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
> -            .size = sizeof(XSaveBNDREG)  },
> -    [XSTATE_BNDCSR_BIT] =
> -          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
> -            .size = sizeof(XSaveBNDCSR)  },
> -    [XSTATE_OPMASK_BIT] =
> -          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> -            .size = sizeof(XSaveOpmask) },
> -    [XSTATE_ZMM_Hi256_BIT] =
> -          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> -            .size = sizeof(XSaveZMM_Hi256) },
> -    [XSTATE_Hi16_ZMM_BIT] =
> -          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> -            .size = sizeof(XSaveHi16_ZMM) },
> -    [XSTATE_PKRU_BIT] =
> -          { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
> -            .size = sizeof(XSavePKRU) },
> +    [XSTATE_YMM_BIT] = {
> +        .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
> +        .size = sizeof(XSaveAVX),
> +    },
> +    [XSTATE_BNDREGS_BIT] = {
> +        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
> +        .size = sizeof(XSaveBNDREG),
> +    },
> +    [XSTATE_BNDCSR_BIT] = {
> +        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
> +        .size = sizeof(XSaveBNDCSR),
> +    },
> +    [XSTATE_OPMASK_BIT] = {
> +        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> +        .size = sizeof(XSaveOpmask),
> +    },
> +    [XSTATE_ZMM_Hi256_BIT] = {
> +        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> +        .size = sizeof(XSaveZMM_Hi256),
> +    },
> +    [XSTATE_Hi16_ZMM_BIT] = {
> +        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
> +        .size = sizeof(XSaveHi16_ZMM),
> +    },
> +    [XSTATE_PKRU_BIT] = {
> +        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
> +        .size = sizeof(XSavePKRU),
> +    },
>       [XSTATE_ARCH_LBR_BIT] = {
> -            .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
> -            .offset = 0 /*supervisor mode component, offset = 0 */,
> -            .size = sizeof(XSavesArchLBR) },
> +        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
> +        .offset = 0 /*supervisor mode component, offset = 0 */,
> +        .size = sizeof(XSavesArchLBR),
> +    },
>       [XSTATE_XTILE_CFG_BIT] = {
>           .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
>           .size = sizeof(XSaveXTILECFG),
>       },
>       [XSTATE_XTILE_DATA_BIT] = {
>           .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
> -        .size = sizeof(XSaveXTILEDATA)
> +        .size = sizeof(XSaveXTILEDATA),
>       },
>   };
>   


