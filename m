Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5FD33994
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RLw-00052E-6P; Mon, 28 Oct 2024 11:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RLu-00051b-2D
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:08:18 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RLs-000857-E6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730128096; x=1761664096;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XJBqrkdQ4Cnj8XdNXfjcI3vVYlr3t+IAnfewCkj4VlQ=;
 b=PJ+aX48jEJ6m8MtVqtDIemqRk5vILSqo78/wFZY3l2KR8WT3ZUwPedue
 TyQ8QOSuq8nC05lps3TY9utTx4qBlNMSwv5+YMQWgQaL0Nv0dwtwV9JFP
 z/geOQdNTim5zIxOcMaRfC0BVtnWrVBgAZJnueHkCKmf664Js5qzPCnJG
 8XNFJjlZycSBqno+ezFi10JDssqt/A6nHig6X7MNUgKEcMS//K2dYtR0P
 sCX+E5CUa52sESTRj5o/etDQpf+5rcLDxHuHFQl8vokfkVZsvApRbaThH
 7olXxgwmt3iTQyyfxium4I8VPpj+iB0ap4zSV+R9J5drKx3iOConpXUBj A==;
X-CSE-ConnectionGUID: hAkKWxr5SQi9xmkMybPHgg==
X-CSE-MsgGUID: EqqFlqm9TKigwSqYBrhMNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40266160"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40266160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:08:14 -0700
X-CSE-ConnectionGUID: wNsZuVB9Qpa+JQ5Bepw/mw==
X-CSE-MsgGUID: eeLhvuY7RVWVaHiUbbkzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="104964228"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:08:12 -0700
Message-ID: <1103ceda-8b29-4f05-bfe1-5fba66070582@intel.com>
Date: Mon, 28 Oct 2024 23:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 mtosatti@redhat.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
 <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
 <340b5b33-8b77-43ab-b0dc-c6e9f610b4a2@redhat.com>
 <14c432e8-5049-4051-ba1f-303f76bfbe19@intel.com>
 <CABgObfYq4itG4ivTqh5nc74dfc11_FG7NA1UQi5Yx7z+1FNG3w@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfYq4itG4ivTqh5nc74dfc11_FG7NA1UQi5Yx7z+1FNG3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.782, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/28/2024 10:50 PM, Paolo Bonzini wrote:
> On Mon, Oct 28, 2024 at 3:48 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> On 10/28/2024 6:45 PM, Paolo Bonzini wrote:
>>> On 10/28/24 11:02, Tao Su wrote:
>>>> On Mon, Oct 28, 2024 at 09:45:39AM +0100, Paolo Bonzini wrote:
>>>>> On 10/28/24 03:45, Tao Su wrote:
>>>>>> Since the highest supported vector length for a processor implies that
>>>>>> all lesser vector lengths are also supported, add the dependencies of
>>>>>> the supported vector lengths. If all vector lengths aren't supported,
>>>>>> clear AVX10 enable bit as well.
>>>>>>
>>>>>> Note that the order of AVX10 related dependencies should be kept as:
>>>>>>            CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
>>>>>>            CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
>>>>>>            CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
>>>>>
>>>>> I think you need to add a set of dependencies so that avx10 cannot be
>>>>> set,
>>>>> unless all the older AVX features that it's composed of are
>>>>> available.  From
>>>>> the manual these are
>>>>>
>>>>> AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA,
>>>>> AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
>>>>> VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.
>>>>
>>>> Thanks for such a quick review!!
>>>>
>>>> AVX10.1 spec said:
>>>> Intel AVX-512 will continue to be supported on P-core-only processors for
>>>> the foreseeable future to support legacy applications. However, new
>>>> vector
>>>> ISA features will only be added to the Intel AVX10 ISA moving forward.
>>>> While Intel AVX10/512 includes all Intel AVX-512 instructions, it
>>>> important to note that applications compiled to Intel AVX-512 with vector
>>>> length limited to 256 bits are not guaranteed to be compatible on an
>>>> Intel
>>>> AVX10/256 processor.
>>>>
>>>> I.e. AVX10/256 processors will support old AVX-512 instructions
>>>> (limited to 256 bits and enumerated by AVX10) but not set AVX-512 related
>>>> CPUIDs. So, I think we can't add these dependencies…
>>>
>>> Of course you're right about AVX10 in general, you still need to add the
>>> dependency but only for CPUID_24_0_EBX_AVX10_512.
>>
>> What if future E-core processor starts to support AVX10/512 but not
>> enumerating any individual AVX512 bit? (AVX10.1 spec only states the
>> compatibility behavior for P-core-only processors)
> 
> KVM and QEMU could always specify the bits. 

That will need KVM to report individual AVX512 bits in 
KVM_GET_SUPPORTED_CPUID to not break QEMU.

> If you want to ask around
> if this is possible then go ahead.

We will ask internal architects and get back with the answer.

> In the meanwhile I actually can apply Tao Su's patches, since the
> dependencies are merely a safety feature.

Sound reasonable.

> Paolo
> 


