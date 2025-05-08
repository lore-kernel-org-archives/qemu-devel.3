Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D4C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCunk-00059c-CP; Thu, 08 May 2025 02:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCune-000593-Q5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:32:08 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCunb-0001EU-9G
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746685923; x=1778221923;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EhUxPhN89QWRiBJnOQ92HMc/WEiQXaIrQeVMQashhcY=;
 b=hEUY2+bUv+zaDhWToVRQCMVbdAjVI8TqOgRBTBqHCmEhU3pzxQ+wr4cH
 oY8F+KUDV9ucgVk7XUkocZC21YARc/MVGXu633DrSGIJ8F3WvDIlyNofv
 i3FP97H/ziAGEg8zhDJFr+yYRfxgIPxvi1PENjv4dsOzZs86ok4LRs3hC
 JdnWXuuDG/9TB9ti/W2RnehOPvoYUAvDhM58FOMkZ12sf4Zz43AEu7fFv
 oXG0AdmWZ36Awrp1HcyYOjIaiwehd10jePPjMy2B0l2/Bs64623LFk86R
 4zs5AXR94fHxfIBCfltsUU+N61fN3qjvyUkBLpHMvX9CrMh5gJUgkLiiX g==;
X-CSE-ConnectionGUID: Kyj6St0jSHOvrxQW33j1YA==
X-CSE-MsgGUID: le13pVUpTOejgd04m3r/Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52264134"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="52264134"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:31:59 -0700
X-CSE-ConnectionGUID: vWXw4NFPTtGtKc6yf00USA==
X-CSE-MsgGUID: PW9Fz6dnQZ2kdaR4tXRmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="136078994"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:31:57 -0700
Message-ID: <d1c29947-2ffc-427d-8bc5-fb6ceb49b0fe@intel.com>
Date: Thu, 8 May 2025 14:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 46/55] i386/tdx: Add supported CPUID bits related to TD
 Attributes
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-47-xiaoyao.li@intel.com> <aBnzG0e+Dea5S3sR@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aBnzG0e+Dea5S3sR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/6/2025 7:31 PM, Zhao Liu wrote:
> On Tue, Apr 01, 2025 at 09:01:56AM -0400, Xiaoyao Li wrote:
>> Date: Tue,  1 Apr 2025 09:01:56 -0400
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH v8 46/55] i386/tdx: Add supported CPUID bits related to TD
>>   Attributes
>> X-Mailer: git-send-email 2.34.1
>>
>> For TDX, some CPUID feature bit is configured via TD attributes. They
>> are not covered by tdx_caps.cpuid (which only contians the configurable
>> bits), but they are actually supported when the related attributre bit
>> is supported.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.h     |  4 +++
>>   target/i386/kvm/tdx.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 115137279a1a..0e984ec42bb6 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -903,6 +903,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>>   #define CPUID_7_0_ECX_LA57              (1U << 16)
>>   /* Read Processor ID */
>>   #define CPUID_7_0_ECX_RDPID             (1U << 22)
>> +/* KeyLocker */
>> +#define CPUID_7_0_ECX_KeyLocker         (1U << 23)
>>   /* Bus Lock Debug Exception */
>>   #define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
>>   /* Cache Line Demote Instruction */
>> @@ -963,6 +965,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>>   #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
>>   /* AVX512 BFloat16 Instruction */
>>   #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
>> +/* Linear address space separation */
>> +#define CPUID_7_1_EAX_LASS              (1U << 6)
>>   /* CMPCCXADD Instructions */
>>   #define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
>>   /* Fast Zero REP MOVS */
> 
> The whole framework is very good for me.
> 
> Since LASS/key locker are not yet supported, I think it's better to add
> the note (in the commit message or code) that they are helpful for
> future enabling. Of course, removing these two features would be best,
> as they cannot be covered by current testing.

I will add note in the commit message and don't change the code.

Keep them in tdx_attrs_maps[] is helpful for the completeness of the 
existing attribute bits that are related to a CPUID feature.

> Regards,
> Zhao
> 
> 


