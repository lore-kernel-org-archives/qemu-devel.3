Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383F1D1AD36
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LiH-0002Mb-Qe; Thu, 17 Oct 2024 04:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t1Li7-0002LX-Rz; Thu, 17 Oct 2024 04:18:21 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t1Li5-0007gT-Ip; Thu, 17 Oct 2024 04:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729153097; x=1760689097;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=jwUcg/w2I2IwDZp85rkfOYl+VTxWX6Z3JaM75ADodRs=;
 b=f+UwIHoG08KcmeeGBDjC8u2Y+g5xZrhkrGEprHtUWQ6LMyyhbz1QrwrS
 CXZD+Bp8MN4UwbBa22exIFL9blAyTKmW8vaSLcAYk44nCP/+35vSgarO+
 hvB5VF5iHGuvRN9yE3CTeQn6d/MizxZxzOZTDlPbomJYA59Xfg8kwAjNM
 HEUGBbKafmagfEfiBsKHftpFbO69lpvxU8XsOe8OCOQMZouloTPYvOwK9
 HGbucYh1Uo/8pwsTr6fjOSNw5TXtJ2o7utrCRJy7TVGouH0rLFTAtCjtk
 QUgdgd7hTC438ViSYnM44+wlMLFb2K1dKn4xowYfRfxm4ONy/OPLWX3Jx w==;
X-CSE-ConnectionGUID: mHbD0kJ6SBqx5nguXgG0MA==
X-CSE-MsgGUID: YtLwPalBQX2JpPyIoE77IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28724515"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28724515"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 01:18:11 -0700
X-CSE-ConnectionGUID: 0UeNAiZoSWC3bCHTka1xtA==
X-CSE-MsgGUID: VMDGMppOSnuBbD5wGVU/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="78821110"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.38])
 ([10.124.224.38])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 01:18:08 -0700
Message-ID: <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com>
Date: Thu, 17 Oct 2024 16:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
 <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com> <ZwyRsq4EIooifRvb@intel.com>
Content-Language: en-US
In-Reply-To: <ZwyRsq4EIooifRvb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/14/2024 11:36 AM, Zhao Liu wrote:
>>>> On 10/9/2024 11:56 AM, Chuang Xu wrote:
>>>>> When QEMU is started with:
>>>>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>>>>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>>>>
>>>>> On Intel platform:
>>>>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>>>>> logical processors in the physical package".
>>>>>
>>>>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a
>>>>> value of 90 for
>>>>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>>>>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>>>>> CPUID.04H.EAX[31:26], which matches the expected result.
>>>>>
>>>>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>>>>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>>>>> integer too. Otherwise we may encounter unexpected results in guest.
>>>>>
>>>>> For example, when QEMU is started with CLI above and xtopology
>>>>> is disabled,
>>>>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/
>>>>> (1+CPUID.04H.EAX[31:26]) to
>>>>> calculate threads-per-core in detect_ht(). Then guest will get
>>>>> "90/ (1+63)=1"
>>>>> as the result, even though threads-per-core should actually be 2.
>>>>
>>>> It's kernel's bug instead.
>>>>
>>>> In 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of
>>>> "Intel 64 Architecture Processor Topology Enumeration" [1], it is
>>>>
>>>>    - SMT_Mask_Width = Log2(RoundToNearestPof2(CPUID.1:EBX[23:16])/
>>>> (CPUID.(EAX=4,ECX=0):EAX[31:26]) + 1))
>>>>
>>>> The value of CPUID.1:EBX[23:16] needs to be *rounded* to the
>>>> neartest power-of-two integer instead of itself being the
>>>> power-of-two.
>>>>
>>>> This also is consistency with the SDM, where the comment for bit
>>>> 23-16 of CPUID.1:EBX is:
>>>>
>>>>    The nearest power-of-2 integer that is not smaller than EBX[23:16] is
>>>>    the number of unique initial APIC IDs reserved for addressing
>>>>    different logical processors in a physical package.
>>>>
>>>> What I read from this is, the nearest power-of-2 integer that is not
>>>> smaller than EBX[23:16] is a different thing than EBX[23:16]. i.e.,
>>>
>>> Yes, when I read sdm, I also thought it was a kernel bug. But on my
>>> 192ht spr host, the value of CPUID.1:EBX[23:16] was indeed rounded up
>>>
>>> to the nearest power of 2 by the hardware. After communicating with
>>> Intel technical support staff, we thought that perhaps the description
>>> in sdm
>>>
>>> is not so accurate, and rounding up CPUID.1:EBX[23:16] to the power of 2
>>> in qemu may be more in line with the hardware behavior.
>>
>> I think above justification is important. We need to justify our changes
>> with the fact and correct reason.
>>
>> I somehow agree to set EBX[23:16] to a value of power-of-2, because the
>> 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of "Intel 64
>> Architecture Processor Topology Enumeration" spec says
>>
>>      CPUID.1:EBX[23:16] represents the maximum number of addressable IDs
>>      (initial APIC ID) that can be assigned to logical processors in a
>>      physical package. The value may not be the same as the number of
>>      logical processors that are present in the hardware of a physical
>>      package.
>>
>> It uses the word "may not".
> 
> IMO, I don't quite understand your confusion regarding this. I've already
> explained the meaning of addressable ID, and the spec you referenced also
> clarifies its significance. The reason for this modification is not
> because of the two words "may not".
> 
> Whether it is "be" or "not be" the same as the number of logical
> processors, the essence is that due to topology, the actual number of
> initial IDs that can be accommodated in the APIC ID may exceed the number
> of logical processors.

I have the confusion because no matter from SDM:

   Bit 23-16: Maximum number of addressable IDs for logical processors in
              this physical package*

   * The nearest power-of-2 integer that is not smaller than EBX[23:16]
     is the number of unique initial APIC IDs reserved for addressing
     different logical processors in a physical package.

or from "Intel 64 Architecture Processor Topology Enumeration" spec，(Jan 
2018, revision 1.1), 1.5.3 "sub ID Extraction Parameters for Inital APIC ID"

   RoundToNearestPof2(CPUID.1:EBX[23:16])

or from "Intel 64 Architecture Processor Topology Enumeration" 
spec，(April 2023, revision 2.0), 1.6.1 Legacy Extraction Algorithm

https://cdrdv2-public.intel.com/775917/intel-64-architecture-processor-topology-enumeration.pdf

   "MaximumLogicalProcessorIDsPerPackage" is calculated by rounding
    CPUID.01H.EBX[23:16] to nearest power of 2.

what I read from them is that EBX[23:16] is a different thing than 
pow2ceil(EBX[23:16]) and EBX[23:16] doesn't need to be power-of-2, but 
the patch are trying to make it power-of-2.

Then I consult it with Intel internal architect. I was told that 
EBX[23:16] used to be that software was to round to the next power of 2. 
However, software had issues a long time ago because applications could 
then compute the wrong power of 2 based on APIC ID holes or some 
applications would use it directly (without round it up to power-of-2).
So intel became to report exact power-of-2 and this behavior is not 
documented.

