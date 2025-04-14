Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EA0C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 06:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4DYw-0000vZ-V1; Mon, 14 Apr 2025 02:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u4DYp-0000v9-Qb
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:44:52 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u4DYn-00024Z-48
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744613089; x=1776149089;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PrcMhElfFIkbdr9RgyGglyefVASNpMvFS8jJLu8xvzY=;
 b=gvzxllFV1tXIZWO6X0NBOJXMoWHbAaSLpPC8Tq+7UkJW2FBX3v1X/pKO
 JZE2Hkw9QpGf/4s9eshoV64JTp+gRcGHHV6/ZeD1Eb+ZezhQyxU714VBR
 FOfkRAGmWyUzUCIWyZR3vUxpLRdCKQAZzLvr9lHo6v++uA+Qf82TDfWCg
 0xGDBs82sxu4ohx25YkAcn9FsmePz1dpm+4G8j6EIyA6nA7zZnw0H10VX
 8dzWx7ToFqmeo2myIiU4NBAU/PIKc4BMnsrWHyN88n0PaztrOS9E2u1AE
 6fJpqdSczTFUkLPnI3ssgiLGLaOsJYMgnxePkawF0rRpw4zRthp7j7OnZ Q==;
X-CSE-ConnectionGUID: p+t1lX7jTDusqdeYmvgJmA==
X-CSE-MsgGUID: 7W3Wtf9IQJqV8Uc55AysjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46157527"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="46157527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2025 23:44:44 -0700
X-CSE-ConnectionGUID: r8CDznhQSsKN6Y+vTIe5pg==
X-CSE-MsgGUID: 6RpnlHC7TWSpDqW4rX0Bkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="134881328"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2025 23:44:43 -0700
Message-ID: <c8a0db98-893a-4fb2-836e-becd49375c89@intel.com>
Date: Mon, 14 Apr 2025 14:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com
References: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
 <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
 <a8750eb8-63ad-4ed8-a80d-f4568c4bc778@zhaoxin.com>
 <Z/iK4wVFWTjhEa32@intel.com>
 <d69d169a-9401-4a19-a942-44d540f050d2@zhaoxin.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d69d169a-9401-4a19-a942-44d540f050d2@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/11/2025 3:42 PM, Ewan Hai wrote:
> 
> 
> On 4/11/25 11:22 AM, Zhao Liu wrote:
>>
>> On Thu, Apr 10, 2025 at 10:07:15PM +0800, Ewan Hai wrote:
>>> Date: Thu, 10 Apr 2025 22:07:15 +0800
>>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>>> Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin 
>>> YongFeng
>>>   vCPU template
>>>
>>> On 4/10/25 8:22 PM, Paolo Bonzini wrote:
>>>>
>>>> On 4/7/25 04:07, Ewan Hai wrote:
>>>>> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
>>>>> The correct value is 0x5b. This mistake occurred because the extended
>>>>> model bits in cpuid[eax=0x1].eax were overlooked, and only the base
>>>>> model was used.
>>>>>
>>>>> This patch corrects the model field.
>>>>
>>>> Hi, please follow commit e0013791b9326945ccd09b5b602437beb322cab8 to
>>>> define a new version of the CPU.
>>>
>>> I’ve noticed that in the QEMU repository at commit
>>> e0013791b9326945ccd09b5b602437beb322cab8 (as HEAD), the following 
>>> patches I
>>> previously submitted (which the Zhaoxin YongFeng vCPU model depends 
>>> on) are
>>> not included:
>>
>> :-) e0013791b9326945ccd09b5b602437beb322cab8 is an example case to show
>> how to fix model id.
>>
>>> - 5d20aa540b6991c0dbeef933d2055e5372f52e0e: "target/i386: Add support 
>>> for
>>> Zhaoxin CPU vendor identification"
>>> - c0799e8b003713e07b546faba600363eccd179ee: "target/i386: Add CPUID leaf
>>> 0xC000_0001 EDX definitions"
>>> - ff04bc1ac478656e5d6a255bf4069edb3f55bc58: "target/i386: Introduce 
>>> Zhaoxin
>>> Yongfeng CPU model" (this is the main patch that needs to be fixed)
>>> - a4e749780bd20593c0c386612a51bf4d64a80132: "target/i386: Mask 
>>> CMPLegacy bit
>>> in CPUID[0x80000001].ECX for Zhaoxin CPUs"
>>>
>>> Should I resend the entire patchset, or would it be sufficient to 
>>> just send
>>> a revised version of the “target/i386: Introduce Zhaoxin Yongfeng CPU 
>>> model”
>>> patch?
>>
>> IIUC, because this fix is planning to land in v10.1 (next release
>> cycle), current CPU model (will be released in v10.0) can't be modified
>> directly. It is only possible to directly modify an unreleased CPU model
>> during the same release cycle.
>>
>> Thus it's enough to just introduce a v2 and correct your model id like
>> this:
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 1b64ceaaba46..1ca1c3a729e8 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5621,6 +5621,17 @@ static const X86CPUDefinition 
>> builtin_x86_defs[] = {
>>           .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>>           .xlevel = 0x80000008,
>>           .model_id = "Zhaoxin YongFeng Processor",
>> +        .versions = (X86CPUVersionDefinition[]) {
>> +            { .version = 1 },
>> +            {
>> +                .version = 2,
>> +                .props = (PropValue[]) {
>> +                    { "model", "0x5b" },
>> +                    { /* end of list */ }
>> +                }
>> +            },
>> +            { /* end of list */ }
>> +        }
>>       },
>>   };
>>
> 
> Thanks again for your patience and explanation.
> 
> I'm not entirely sure if this is the best approach. I have one thought, 
> and I'd like your help to confirm whether I'm on the right track or not. 
> From what I can tell, most other vCPU definitions that use the .versions 
> mechanism do so incrementally: for instance, they add new features in 
> v2, v3, etc., but each of those versions (v1, v2, v3) remains valid for 
> practical use.
> 
> However, in our specific case, the v1 version of the Zhaoxin vCPU 
> definition has an incorrect .model value, which breaks the Linux guest's 
> vPMU functionality. That makes me uncertain whether using new version 
> definitions to fix this issue is really the best solution. After all, v1 
> itself would remain problematic.
> 
> Do you have any thoughts on whether it might be better to correct the 
> existing definition, or do you think the versioned approach is still the 
> recommended path? I appreciate any input or guidance you can provide.
> 

If changing the @model value directly, it will introduce user visible 
change. E.g., live migrating from old QEMU to new QEMU, the guest will 
find the model number changes.

That's why versioned CPU model was introduced. It becomes the fact 
already that YongFeng-v1 has model id 11 and broken vpmu. If user create 
vcpu with YongFeng-v1, user has to accept it. If user wants a working 
vpmu, go and use YongFeng-v2


