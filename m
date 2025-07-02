Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE615C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWlvw-0003qO-2E; Tue, 01 Jul 2025 21:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWlvt-0003pT-Ul; Tue, 01 Jul 2025 21:06:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWlvr-00087i-10; Tue, 01 Jul 2025 21:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751418399; x=1782954399;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BRvXTnma/VCNa+QMctOvNLj1cGoxTriQJvp7SMtNDjQ=;
 b=U35/1QJmR06R4pX7S3mBspvwJDBI4ZXpxXg5fxTHD3AIZuGjIXWlb17E
 xjBQlzNc5fOTvD4iO17wVFo96jcxKLLuyniygKNdj0LbfaMUgci9QDjBz
 RAUXbrYeJ1bVJqILIwMDVH0F0q8iHC+XNGng8ZLdPdI4pd54GQO3iROxN
 Ni7j3MMnFj/M3wTvuD0YJHnbPofEejNG/uIAXThEPB9DlGbtmicuNbKRi
 VF3tDS5EOT1qedAdsJ5yfUF7zSKUpT8VojjCr2y+0Hcy/dXgwGwG0+0Bt
 mhkoBZCcQHq819D04Qt2QSlcP0Pcn9JGNfSyltN1Yr8LTGnBoDm6J5zRb Q==;
X-CSE-ConnectionGUID: KEsRK2DKT6CPtLUj2MNRVw==
X-CSE-MsgGUID: wasQe4WmRXmuSP7mVplSqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71126531"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="71126531"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 18:06:35 -0700
X-CSE-ConnectionGUID: 4tXMIMrdR7WAClkpR3P2aw==
X-CSE-MsgGUID: 71esOLeYSyC1RseItddZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="154020163"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 18:06:31 -0700
Message-ID: <2667f6af-0e75-4724-9371-0f4713bf6e75@intel.com>
Date: Wed, 2 Jul 2025 09:06:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org, zhao1.liu@intel.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
 <abdf31e3-2ada-47d8-9c9d-d875491537b2@oracle.com>
 <c8a0bd48-3f48-4f3b-b3ee-93a14e84a70a@intel.com>
 <aGQ7UrHYWkWE_k6Y@char.us.oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGQ7UrHYWkWE_k6Y@char.us.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
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

On 7/2/2025 3:47 AM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 01, 2025 at 05:47:06PM +0800, Xiaoyao Li wrote:
>> On 7/1/2025 5:22 PM, Alexandre Chartre wrote:
>>>
>>> On 7/1/25 10:23, Xiaoyao Li wrote:
>>>> On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
>>>>> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
>>>>> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
>>>>> MSR and it makes no sense to emulate it on AMD.
>>>>>
>>>>> As a consequence, VMs created on AMD with qemu -cpu host and using
>>>>> KVM will advertise the ARCH_CAPABILITIES feature and provide the
>>>>> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
>>>>> as the guest OS might not expect this MSR to exist on such cpus (the
>>>>> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
>>>>> are not defined on the AMD architecture).
>>>>>
>>>>> A fix was proposed in KVM code, however KVM maintainers don't want to
>>>>> change this behavior that exists for 6+ years and suggest changes to be
>>>>> done in qemu instead.
>>>>>
>>>>> So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
>>>>> is not provided by default on AMD cpus when the hypervisor emulates it,
>>>>> but it can still be provided by explicitly setting arch-capabilities=on.
>>>>>
>>>>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>>>> ---
>>>>>    target/i386/cpu.c | 14 ++++++++++++++
>>>>>    1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>>> index 0d35e95430..7e136c48df 100644
>>>>> --- a/target/i386/cpu.c
>>>>> +++ b/target/i386/cpu.c
>>>>> @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu,
>>>>> Error **errp)
>>>>>            }
>>>>>        }
>>>>> +    /*
>>>>> +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
>>>>> +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
>>>>> +     * continue doing so to not change its ABI for existing setups.
>>>>> +     *
>>>>> +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
>>>>> +     * to prevent providing a cpu with an MSR which is not supposed to
>>>>> +     * be there, unless it was explicitly requested by the user.
>>>>> +     */
>>>>> +    if (IS_AMD_CPU(env) &&
>>>>> +        !(env->user_features[FEAT_7_0_EDX] &
>>>>> CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
>>>>> +        env->features[FEAT_7_0_EDX] &=
>>>>> ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
>>>>> +    }
>>>>
>>>> This changes the result for the existing usage of "-cpu host" on
>>>> AMD. So it will need a compat_prop to keep the old behavior for old
>>>> machine.
>>>
>>> Right, I will look at that.
>>>
>>>>
>>>> But I would like discuss if we really want to do it in QEMU.
>>>> ARCH_CAPABILITIES is not the only one KVM emulates unconditionally.
>>>> We have TSC_DEADLINE_TIMER as well. So why to treat them
>>>> differently? just because some Windows cannot boot? To me, it looks
>>>> just the bug of Windows. So please fix Windows. And to run with the
>>>> buggy Windows, we have the workaround: "-cpu host,-arch-capabilities"
>>>
>>> Well, the Windows behavior is not that wrong as it conforms to the AMD
>>> Manual
>>> which specifies that ARCH_CAPABILITIES feature and MSR are not defined
>>> on AMD
>>> cpus; while QEMU/KVM are providing an hybrid kind of AMD cpu with Intel
>>> feature/MSR.
>>
>> It is currently reserved bit in AMD's manual. But it doesn't mean it will be
>> reserved forever. Nothing prevents AMD to implement it in the future.
> 
> And if it is implemented in the future (say in 100 years), then we
> would expose it then by the virtue of -cpu host picking it up
> automatically.

I wanted to talk about the impact on Windows implementation.

What if AMD implements 1 year later? Then at that time, the Windows will 
even fail booting on real AMD. Do you think is the correct 
implementation of Windows?

>>
>> Software shouldn't set any expectation on the reserved bit.
> 
> Exactly. Which is why there is this fix which does not set those bits.
> It should be done in KVM, but as you saw Sean agreed this is a bug, but
> he did not want it in the kernel.
> 
> What about the TSC deadline MSR? That should not be exposed either as it is
> not implemented on AMD.

Oh, no. It's not the rule of virtualization.

With virtualization, we don't need to present the vcpu 100% the same 
with real silicon. We can expose more (useful) features to vcpu as long 
as it's architecturally correct.

And with virtualization, people can tailor their own vcpu with different 
features/vendors/FMS as long as the configuration is architecturally 
correct.

>>
>>> Microsoft is fixing that behavior anyway and has provided a preview fix
>>> (OS Build
>>> 26100.4484), so that's good news. But the goal here is also to prevent
>>> such future
>>> misbehavior. So if other features (like TSC_DEADLINE_TIMER) are exposed
>>> while they
>>> shouldn't then they should probably be fixed as well.
>>>> "-cpu host,-arch-capabilities" is indeed a workaround, but it defeats
>>> the purpose
>>> of the "-cpu host" option which is to provide a guest with the same
>>> features as the
>>> host. And this workaround basically says: "provide a guest with the same
>>> cpu as
>>> the host but disable this feature that the host doesn't provide"; this
>>> doesn't make
>>> sense. Also this workaround doesn't integrate well in heterogeneous
>>> environments
>>> (with Intel,  AMD, ARM or other cpus) where you just want to use "-cpu
>>> host" whatever
>>> the platform is, and not have a special case for AMD cpus.
>>
>> As I said, it's just the workaround for users who want to run a specific
>> version of Windows with "-cpu host" on AMD. That's why it's called
>> workaround.
> 
> No? It is making the -cpu host expose the real bits.
> 
> Not add extra ones.
> 
>> The root-cause is the wrong behavior of the specific version of Windows. If
>> you don't use the buggy Windows, you don't need the workaround.
> 
> Windows probably does this.
> 
> if (cpuid(arch_capabilities)
> 	// do something sensible.

 From the description, doesn't Windows do something like

   if (IS_AMD && CPUID(arch_capabilities))
	ERROR(UNSUPPORTED PROCESSOR)

The problem is software cannot assume CPUID(arch_capabilities) is 0 on AMD.

> That is a correct behavior based on reading the Intel SDM.
> 
> The AMD SDM says that if you don't detect a CPUID being set, then don't mess
> with that MSR that is associated with that - otherwise you will get undefined
> behaviors.


> I am really missing what your agument here is? Is it that guest ABI got
> screwed up 7 years ago (and the author of the patch agreed it was a
> bug and so did the KVM maintainer) and we should just continue having this
> bug because ... what?

No, it's not a bug of KVM, nor QEMU.

