Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD83C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWq42-0007Z4-4R; Wed, 02 Jul 2025 01:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWq3z-0007Y4-Vu; Wed, 02 Jul 2025 01:31:20 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWq3v-0006Hs-Kq; Wed, 02 Jul 2025 01:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751434276; x=1782970276;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wmb7fyJuILH5pksG+hlA/BUwVrAifChyZtCLI4i1pLY=;
 b=XLU67H8AEHRzW43hJDo8lbxWjRTISg2Q/nBiFIBL60gVxpAL8Fn7LPWh
 C2/SqNpDpCHUtKLKR+fK6u6ADSz0/7flWb/4570Rqz3ErMGCDhvwslMxZ
 g2e1Xcnqt9WGsGQEv5Ajv2HHYWfwStqPtE8xzJllQ6Takd3L7ofaI+jc5
 prBqj/VflvajQHGXpmkoubfz15O9L0M2NN5AsZjTBK6V7TgNIfZGhDSOY
 zA+mrVQdukzrivxUScrM4BrIBdmndRh+fZBT07uI3wGKeJIsx1GjHvAI/
 dmWOg0GVEwcMvMN9t75cBAWc7MhqB4Hbb7R//iab6K5SDiXcLSH1sGLQt Q==;
X-CSE-ConnectionGUID: /m+g6MYvSyCHPg6VXvny2Q==
X-CSE-MsgGUID: AI7bi+fLTiuknAvsSX4rxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53827488"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53827488"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:31:12 -0700
X-CSE-ConnectionGUID: p0RHtcEzQZ6GGSNqEsQxlg==
X-CSE-MsgGUID: 2qgDZNU0QDmDzRf8UViSrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="154059786"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:31:02 -0700
Message-ID: <f1d53417-4dce-43e8-a647-74fbc5c378cb@intel.com>
Date: Wed, 2 Jul 2025 13:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com> <aGS9E6pT0I57gn+e@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGS9E6pT0I57gn+e@intel.com>
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

On 7/2/2025 1:01 PM, Zhao Liu wrote:
> Thanks Igor for looking here and thanks Konrad's explanation.
> 
>>>>> On 7/1/2025 6:26 PM, Zhao Liu wrote:
>>>>>>> unless it was explicitly requested by the user.
>>>>>> But this could still break Windows, just like issue #3001, which enables
>>>>>> arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
>>>>>> turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
>>>>>> value would even break something.
>>>>>>
>>>>>> So even for named CPUs, arch-capabilities=on doesn't reflect the fact
>>>>>> that it is purely emulated, and is (maybe?) harmful.
>>>>>
>>>>> It is because Windows adds wrong code. So it breaks itself and it's just the
>>>>> regression of Windows.
>>>>
>>>> Could you please tell me what the Windows's wrong code is? And what's
>>>> wrong when someone is following the hardware spec?
>>>
>>> the reason is that it's reserved on AMD hence software shouldn't even try
>>> to use it or make any decisions based on that.
>>>
>>>
>>> PS:
>>> on contrary, doing such ad-hoc 'cleanups' for the sake of misbehaving
>>> guest would actually complicate QEMU for no big reason.
>>
>> The guest is not misbehaving. It is following the spec.
> 
> (That's my thinking, and please feel free to correct me.)

I think we need firstly aligned on what the behavior of the Windows that 
hit "unsupported processor" is.

My understanding is, the Windows is doing something like

	if (is_AMD && CPUID(arch_capabilities))
		error(unsupported processor)

And I think this behavior is not correct.

However, it seems not the behavior of the Windows from your 
understanding. So what's the behavior in you mind?

> I had the same thought. Windows guys could also say they didn't access
> the reserved MSR unconditionally, and they followed the CPUID feature
> bit to access that MSR. When CPUID is set, it indicates that feature is
> implemented.
> 
> At least I think it makes sense to rely on the CPUID to access the MSR.
> Just as an example, it's unlikely that after the software finds a CPUID
> of 1, it still need to download the latest spec version to confirm
> whether the feature is actually implemented or reserved.
> 
> Based on the above point, this CPUID feature bit is set to 1 in KVM and
> KVM also adds emulation (as a fix) specifically for this MSR. This means
> that Guest is considered to have valid access to this feature MSR,
> except that if Guest doesn't get what it wants, then it is reasonable
> for Guest to assume that the current (v)CPU lacks hardware support and
> mark it as "unsupported processor".
> 
> As Konrad's mentioned, there's the previous explanation about why KVM
> sets this feature bit (it started with a little accident):
> 
> https://lore.kernel.org/kvm/CALMp9eRjDczhSirSismObZnzimxq4m+3s6Ka7OxwPj5Qj6X=BA@mail.gmail.com/#t
> 
> So I think the question is where this fix should be applied (KVM or
> QEMU) or if it should be applied at all, rather than whether Windows has
> the bug.

If we are agreed it's the bug of Windows, then no fix in QEMU/KVM at all.

> But I do agree, such "cleanups" would complicate QEMU, as I listed
> Eduardo as having done similar workaround six years ago:
> 
> https://lore.kernel.org/qemu-devel/20190125220606.4864-1-ehabkost@redhat.com/
> 
> Complexity and technical debt is an important consideration, and another
> consideration is the impact of this issue. Luckily, newer versions of
> Windows are actively compatible with KVM + QEMU:
> 
> https://blogs.windows.com/windows-insider/2025/06/23/announcing-windows-11-insider-preview-build-26120-4452-beta-channel/
> 
> But it's also hard to say if such a problem will happen again.
> Especially if the software works fine on real hardware but fails in
> "-host cpu" (which is supposed synchronized with host as much as
> possible).

work fine on real hardware but have issue with virtualization doesn't 
mean it is the problem of virtualization unless we figure out the 
root-cause and prove that software/OS's behavior is correct.

If the problem is due to the wrong behavior of guest OS, then it has 
nothing to do QEMU/KVM and QEMU/KVM cannot avoid such problem.


