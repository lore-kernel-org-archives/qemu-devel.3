Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD3BCAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4Vk-0002ax-23; Mon, 15 Sep 2025 04:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uy4Vh-0002aZ-6v
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:24:29 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uy4VW-00007A-FW
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757924659; x=1789460659;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gRaS+5m9AQNg6Bt+v5f8CK7xCCdHBHUcwmOa5SYZVYI=;
 b=IEr/Mon/adWj8NQuS1mW4s4IyRU4fZ7rZo7xEbpeKZUdsLHeUFu5q4nt
 aVkOLSAS2TArtHYutvoEMGruXGyWLe5D3/QduEi4YvooQdalaH0x6nQ2P
 vA4BZf8zG926+1/4Esb7C2FrhaDS8BATbgN+5MZom+2vgTkHPXl7A55Yx
 oqk04nhEIgoa7f3m1o+yxkUxLpF3SipEtwPS5/P0vqqWW3yJk18jG9pRY
 Qk2Op4rxE545sD1MkN06cb01NlWZ3Rn5nULjIIjA2nI9rEdLWYUgb+S3J
 dwaRBGxGBPTNi0ShvL5+BEz6xBrdZeV3ErWWMqbiLbLCj9rKt4TySDNhI Q==;
X-CSE-ConnectionGUID: Y2CU8ZBoQ7G4Dojuj1+4/w==
X-CSE-MsgGUID: AB6drzrYQEOhK5kXfbxmtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60239635"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="60239635"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:24:10 -0700
X-CSE-ConnectionGUID: YH5KAeGzRB2EoTbYp7d39Q==
X-CSE-MsgGUID: kNcBdfrDQl+RpkhOtc3BWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="174377478"
Received: from junlongf-mobl.ccr.corp.intel.com (HELO [10.238.1.52])
 ([10.238.1.52])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:24:09 -0700
Message-ID: <76757b0c-475e-4911-a8b4-4a2444c6226e@intel.com>
Date: Mon, 15 Sep 2025 16:24:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tao1.su@intel.com, chenyi.qiang@intel.com
References: <20250707141151.4187798-1-xiaoyao.li@intel.com>
 <aMP6IQ4TR/MW6C6u@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aMP6IQ4TR/MW6C6u@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/12/2025 6:46 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> Rethinking this patch, I would not remove these feature bits with the
> comments inline:
> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 0d35e95430fe..1b50fd4e397d 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -912,7 +912,6 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>>   #define TCG_SGX_12_0_EAX_FEATURES 0
>>   #define TCG_SGX_12_0_EBX_FEATURES 0
>>   #define TCG_SGX_12_1_EAX_FEATURES 0
>> -#define TCG_24_0_EBX_FEATURES 0
>>   
>>   #if defined CONFIG_USER_ONLY
>>   #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
>> @@ -1208,20 +1207,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>           },
>>           .tcg_features = TCG_7_2_EDX_FEATURES,
>>       },
>> -    [FEAT_24_0_EBX] = {
>> -        .type = CPUID_FEATURE_WORD,
>> -        .feat_names = {
>> -            [16] = "avx10-128",
>> -            [17] = "avx10-256",
>> -            [18] = "avx10-512",
>> -        },
>> -        .cpuid = {
>> -            .eax = 0x24,
>> -            .needs_ecx = true, .ecx = 0,
>> -            .reg = R_EBX,
>> -        },
>> -        .tcg_features = TCG_24_0_EBX_FEATURES,
>> -    },
> 
> "Reserved at 1" means always enabling, not being deprecated.
> 
> So if someone has already cofigured "+avx10-128,+avx10-256,+avx10-512"
> for his cpu, this patch will break his use.
> 
> Although explicitly setting AVX10 vector length feature bits appears
> uncommon, but explicitly masking off these feature bits is even more
> unusual.
> 
> Removing these bits has little benefit but brings the risk of breaking
> the API.

I cannot argue against the risk of breaking the API.

Can we go the process to deprecate them?

> In the future, QEMU may need the AVX10 model to handle different
> versions. A complete feature list is necessary. This is another reason.

But whatever the avx10 version is/ will be, all the vector lengths will 
be supported. This is fundamental to AVX10.

Keeping the avx10-{128,256,512} feature bits in QEMU, misleads users to 
think they are configurable and they can do fancy thing to create a 
virtual hardware that only supports a subset of vector length for AVX10 
while the truth is they cannot.

> In addition, I also agree with KVM's point to keep these feature names:
> 
> https://lore.kernel.org/kvm/Zkz5Ak0PQlAN8DxK@google.com/

Could you elaborate what point from Sean from the link suggesting to 
keep these feature names?

> ...
> 
>> @@ -7720,7 +7686,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           *ecx = 0;
>>           *edx = 0;
>>           if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
>> -            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
>> +            /* bit 16-18 are reserved at 1 */
>> +            *ebx = (0x7U << 16) | env->avx10_version;
> 
> Hardcoding is not friendly for maintenance, and they are essentially
> feature bits.
> 
>>           }
>>           break;
>>       }
> 
> Thanks,
> Zhao
> 


