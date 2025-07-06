Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4786C83F03
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Jul 2025 13:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYPqR-0004pZ-En; Sun, 06 Jul 2025 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYPqP-0004pE-8b
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 09:55:49 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYPqN-0007OO-2P
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 09:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751810147; x=1783346147;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Niya/KWDVfc4AEzMAwO2ILfY9kbLtHMBXs6864wfYx8=;
 b=OBbbfcWBI9pPiEw/XDrs2JbGGi2jKAQ3PRwlIX+/ifs4l7/E63F5bQKJ
 s8lK2/qFsfrvGGCFoQP1t8lDMzSFLzJC6FLtwpWY7Q+0WfkOc3Nk/yt+4
 cNELgSE46GRHhmWI06x2yVcoE1Ihxh158kUDgJdmQnMnoCygHyQsbHJvQ
 px8OIsIYfmcRfQC1F8ddlNTMSzYBiYX36Qhm0b4rpIW9bETKYHL9vWAO2
 /YnWUGXDGZ4v+MWp5tBre4Irtyfivy5rQEpCPqsE2+B8ev4YkmQSk5JC3
 YoeJAIWJXMJgwNJRw1fA++sqy9lffmDEKltNyt2VlTqqg8Qlrw8KmtzV3 g==;
X-CSE-ConnectionGUID: PBHwLiLtT6a0B+3hHW3OMQ==
X-CSE-MsgGUID: b6bavukNS3+3M+pWoW3bvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="64644285"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="64644285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 06:55:43 -0700
X-CSE-ConnectionGUID: QoGLx97HTH6sai8M771alA==
X-CSE-MsgGUID: waQ+vI9ETsmNjHFdZ76bbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="159022573"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 06:55:41 -0700
Message-ID: <25632a7f-25a2-4edb-b3b4-272af905407f@intel.com>
Date: Sun, 6 Jul 2025 21:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tao1.su@intel.com, chenyi.qiang@intel.com
References: <20250704144504.4094810-1-xiaoyao.li@intel.com>
 <aGpKpvh+sEQb4LDM@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGpKpvh+sEQb4LDM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/6/2025 6:06 PM, Zhao Liu wrote:
> On Fri, Jul 04, 2025 at 10:45:04PM +0800, Xiaoyao Li wrote:
>> Date: Fri, 4 Jul 2025 22:45:04 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
>> X-Mailer: git-send-email 2.43.0
>>
>> Intel AVX10 spec has been updated to make the bit 16-18 of
>    ^^^^^^^^^^^^^^^^
> 
> This "AVX10 spec" is misleading, there are both AVX10.1 spec and AVX10.2
> spec, and QEMU currently supports AVX10.1 for the GNR, but your change
> is based on AVX10.2 spec.
> 
> It would be good to explain something like,
> 
> Although AVX10.1 has already marked AVX10/128 as always supported in
> revision 3.1 (QEMU did not synchronize this change), in the latest
> AVX10.2 spec (revison 5.0), AVX10 roadmap is updated, "AVX10/512 will be
> used in all Intel products, supporting vector lengths of 128, 256, and
> 512 in all product lines". This applies for all AVX10 versions.

AVX10.1 spec should be updates as well. I will follow it up to internal 
architects to update the avx10.1 spec.

>> CPUID.24_0.EBX as reserved at 1 because all the Intel processors with
>> AVX10 support will support all the vector lengths.
>>
>> The bits will be reserved at 1 to ensure the compatibility of the
>> existing software. For QEMU, it makes no sense to allow the
>> configurability of the bits anymore. So just remove the leaf
>> FEAT_24_0_EBX and related stuff and hardcore the bits to all 1 when
>> AVX10 is exposed to guest.
> 
> Add the doc link here if thers's next version.
> 
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c | 36 +-----------------------------------
>>   target/i386/cpu.h | 12 ------------
>>   2 files changed, 1 insertion(+), 47 deletions(-)
> 
> ...
> 
>> @@ -7720,7 +7686,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           *ecx = 0;
>>           *edx = 0;
>>           if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
>> -            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
>> +            *ebx = (0x7U << 16) | env->avx10_version;
> 
> Instead of hardcode, it's better to keep the macros and encoded this
> like:
> 
> *ebx = CPUID_24_0_EBX_AVX10_VL_MASK | env->avx10_version;
> 
> and leave a comment: all processors supporting Intel AVX10 will include
> support for all vector lengths.

The goal of Intel is trying to remove from the spec that there are 
enumeration bits for 128/256/512 bits. It wants to reassure people that 
all the processors support AVX10 support all the length.

Intel wants to disassociate the meaning of bits 16-18 from the 
enumeration of vector length as far as possible. But there might be SW 
already, who checks the bit 16-18 for checking the support of a 
specified version. So Intel has to add the footnote in the spec to 
explain that "Earlier versions of this specification documented this bit 
as enumerating VLxxx support"

We want QEMU to honor Intel's purpose and want QEMU to associate them 
with the enumeration of the vector length.

If you do want a comment, I think just add something like

	/* Bit 16-18 are reserved at 1 */

People interested in why they are reserved at 1 can go read the Intel 
sepc (SDM/ISE/AVX *) to get further information.

>>           }
>>           break;
>>       }


