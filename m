Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FC8C369D3
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8yX3-0000aD-Vb; Sun, 27 Apr 2025 05:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1u8yWz-0000ZA-NN
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 05:42:38 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1u8yWx-0006aj-0y
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 05:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745746955; x=1777282955;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=20rtXIKpVHePMp/s5NOBXpbrgNMBI6Ac2g1H+IRiiLA=;
 b=KUXBtfwtGT6OaZiNdV6TWdoDpYT0K2gd4maxpc7a8240ehL95Yd7jziE
 pdwooJiWXE0BOJnFDcGSblsZA39IxxQsAMCojmvYRzKNnyOa5pnFaDjBD
 DgXm10Wx+f0+M66ywnn9W3Dk951EXQbw6l0wKv8SP2lPcH/dEMcyo1EUO
 6O5klSRXn9V3IkMCp2dYYsP+cnC6p0l/hA6FTsTwk/27THshWDL3W7mNI
 y0cY4dIBf8uFsk4L2Ld85Wz36zMdmjczAQzjU6i7oAk9BelhwT8WIYEJQ
 IVF2Z1V9bBE+1XQe4POvlxaXyCxjEqW6cVHd7dS442bdF+ztEPjT4gvSy A==;
X-CSE-ConnectionGUID: 2VgDxz7+QqO9nHBm7/nbRw==
X-CSE-MsgGUID: SP2d+HQ9Q7C9EfHABZzoTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47438869"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="47438869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 02:42:30 -0700
X-CSE-ConnectionGUID: zj6lZ3H8QjOQTMsxinQBnw==
X-CSE-MsgGUID: tMiRphQHRkWlAdVlJsZJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="133759400"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128])
 ([10.124.245.128])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 02:42:27 -0700
Message-ID: <4ee686a3-6970-4560-b0ad-00329d773148@linux.intel.com>
Date: Sun, 27 Apr 2025 17:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/i386: Support
 VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
 <20250324123712.34096-4-dapeng1.mi@linux.intel.com>
 <aA3w2PiRuNOMKwdM@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aA3w2PiRuNOMKwdM@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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


On 4/27/2025 4:54 PM, Zhao Liu wrote:
>> @@ -4212,7 +4213,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
>> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
>> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
>> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>>          .features[FEAT_VMX_MISC] =
>>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>>              MSR_VMX_MISC_VMWRITE_VMEXIT,
>> @@ -4368,7 +4370,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
>> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
>> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
>> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>>          .features[FEAT_VMX_MISC] =
>>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>>              MSR_VMX_MISC_VMWRITE_VMEXIT,
>> @@ -4511,7 +4514,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
>> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
>> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
>> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>>          .features[FEAT_VMX_MISC] =
>>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>>              MSR_VMX_MISC_VMWRITE_VMEXIT,
> Instead of modifying SPR's CPU model directly, we should introduce a new
> version (SapphireRapids-v4), like Skylake-Server-v4 enables
> "vmx-eptp-switching".

Sure. Let me have a look this.


>

