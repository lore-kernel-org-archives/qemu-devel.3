Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7707C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 05:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u21JF-0000sL-PM; Tue, 08 Apr 2025 01:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u21J7-0000rN-Sc
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:15:33 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u21J5-0002uS-Cs
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744089331; x=1775625331;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=awOzSp4eKVpKtblE1A0vBqJI2VCNcj0U9FQSX6+bKv4=;
 b=R6dx2NrDqrAKEH9abiqYSIKuuSL40aM/UrS/DsoVVnp51C49XQHSeD8n
 ERGIBkAHt1txR9h3K44MfJPcTHDyxn5wJjeIzPRw12G5oQZHZWmqDP/jK
 kKTz2/GkSb6r8HWVtUPcm8UVCfgpSG3imx0DoPmPkYoj2WYvAoVobfiNM
 snvCINvE+XkQTpcfhprPqNA0D7QL1qj4oSjdTiSqQp6jQdyQCYRjStvi6
 ttAUlYWgDVz44LMDM0jDKinAY7IpuJdX9+66wMkM0oVXZF30d3PSZlF4B
 gFohZTv5HzNbmYkz0OWUvEU/hDRfszK1Osqzp3gSoxxWc6XjY++0MYTbO Q==;
X-CSE-ConnectionGUID: H49Toxd6RGKcQZIiPBFVYw==
X-CSE-MsgGUID: OU3x4pXJQOum3jNdUbMNIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70879770"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="70879770"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 22:15:28 -0700
X-CSE-ConnectionGUID: zI5ahYPQQ4KNz9nFu5HJsw==
X-CSE-MsgGUID: yBhEgc4nQA684FI2/9Q2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="128680818"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 22:15:21 -0700
Message-ID: <b6ec7c47-4d4e-41fd-a170-0c5e5daea8e8@intel.com>
Date: Tue, 8 Apr 2025 13:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 55/55] docs: Add TDX documentation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, devel@lists.libvirt.org,
 Jiri Denemark <jdenemar@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-56-xiaoyao.li@intel.com>
 <Z-0WclTZ-e-sTjzO@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0WclTZ-e-sTjzO@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/2/2025 6:50 PM, Daniel P. Berrangé wrote:
> CC libvirt / Jiri, for confirmation about whether the CPUID restrictions
> listed below will have any possible impact on libvirt CPUID handling...
> 
> On Tue, Apr 01, 2025 at 09:02:05AM -0400, Xiaoyao Li wrote:
>> Add docs/system/i386/tdx.rst for TDX support, and add tdx in
>> confidential-guest-support.rst
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v6:
>>   - Add more information of "Feature configuration"
>>   - Mark TD Attestation as future work because KVM now drops the support
>>     of it.
>>
>> Changes in v5:
>>   - Add TD attestation section and update the QEMU parameter;
>>
>> Changes since v1:
>>   - Add prerequisite of private gmem;
>>   - update example command to launch TD;
>>
>> Changes since RFC v4:
>>   - add the restriction that kernel-irqchip must be split
>> ---
>>   docs/system/confidential-guest-support.rst |   1 +
>>   docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
>>   docs/system/target-i386.rst                |   1 +
>>   3 files changed, 158 insertions(+)
>>   create mode 100644 docs/system/i386/tdx.rst
> 
> 
>> +Feature Configuration
>> +---------------------
>> +
>> +Unlike non-TDX VM, the CPU features (enumerated by CPU or MSR) of a TD are not
>> +under full control of VMM. VMM can only configure part of features of a TD on
>> +``KVM_TDX_INIT_VM`` command of VM scope ``MEMORY_ENCRYPT_OP`` ioctl.
>> +
>> +The configurable features have three types:
>> +
>> +- Attributes:
>> +  - PKS (bit 30) controls whether Supervisor Protection Keys is exposed to TD,
>> +  which determines related CPUID bit and CR4 bit;
>> +  - PERFMON (bit 63) controls whether PMU is exposed to TD.
>> +
>> +- XSAVE related features (XFAM):
>> +  XFAM is a 64b mask, which has the same format as XCR0 or IA32_XSS MSR. It
>> +  determines the set of extended features available for use by the guest TD.
>> +
>> +- CPUID features:
>> +  Only some bits of some CPUID leaves are directly configurable by VMM.
>> +
>> +What features can be configured is reported via TDX capabilities.
>> +
>> +TDX capabilities
>> +~~~~~~~~~~~~~~~~
>> +
>> +The VM scope ``MEMORY_ENCRYPT_OP`` ioctl provides command ``KVM_TDX_CAPABILITIES``
>> +to get the TDX capabilities from KVM. It returns a data structure of
>> +``struct kvm_tdx_capabilities``, which tells the supported configuration of
>> +attributes, XFAM and CPUIDs.
>> +
>> +TD attributes
>> +~~~~~~~~~~~~~
>> +
>> +QEMU supports configuring raw 64-bit TD attributes directly via "attributes"
>> +property of "tdx-guest" object. Note, it's users' responsibility to provide a
>> +valid value because some bits may not supported by current QEMU or KVM yet.
>> +
>> +QEMU also supports the configuration of individual attribute bits that are
>> +supported by it, via properties of "tdx-guest" object.
>> +E.g., "sept-ve-disable" (bit 28).
>> +
>> +MSR based features
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +Current KVM doesn't support MSR based feature (e.g., MSR_IA32_ARCH_CAPABILITIES)
>> +configuration for TDX, and it's a future work to enable it in QEMU when KVM adds
>> +support of it.
>> +
>> +Feature check
>> +~~~~~~~~~~~~~
>> +
>> +QEMU checks if the final (CPU) features, determined by given cpu model and
>> +explicit feature adjustment of "+featureA/-featureB", can be supported or not.
>> +It can produce feature not supported warning like
>> +
>> +  "warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]"
>> +
>> +It can also produce warning like
>> +
>> +  "warning: TDX forcibly sets the feature: CPUID.80000007H:EDX.invtsc [bit 8]"
>> +
>> +if the fixed-1 feature is requested to be disabled explicitly. This is newly
>> +added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
>> +by TDX module and VMM cannot disable them.
> 
> This is where I'm wondering if libvirt has anything to be concerned
> about. Possibly when libvirt queries the actual CPUID after launching
> the guest it will just "do the right thing" ? Wondering if there's any
> need for libvirt to be aware of CPUID restrictions before that point
> though ?
> 
> 
>> +
>> +Launching a TD (TDX VM)
>> +-----------------------
>> +
>> +To launch a TD, the necessary command line options are tdx-guest object and
>> +split kernel-irqchip, as below:
>> +
>> +.. parsed-literal::
>> +
>> +    |qemu_system_x86| \\
>> +        -object tdx-guest,id=tdx0 \\
>> +        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
>> +        -bios OVMF.fd \\
> 
> I don't think we need to show 'kernel-irqchip=split' now that we "do the
> right thing" by default
> 
> 
> This surely also ought to include '-accel kvm', as IIUC there's no
> TCG support for TDX.
> 
> And presumably '-cpu host', since QEMU's default 'qemu64' CPU model
> is likely a terrible match for what TDX will force set.
> 
>> +
>> +Restrictions
>> +------------
>> +
>> + - kernel-irqchip must be split;
> 
> Can append
> 
>     "This is set by default for TDX guests if kernel-irqchip is left on
>      its default 'auto' setting."

This and above feedback are all good. Accept them all and will update in 
the next version.

Thanks!

>> +
>> + - No readonly support for private memory;
>> +
>> + - No SMM support: SMM support requires manipulating the guest register states
>> +   which is not allowed;
>> +
> 
> 
> With regards,
> Daniel


