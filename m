Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEB7E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3wD-0001DR-U1; Tue, 07 Jan 2025 02:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3wC-0001D1-1q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:23:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3w9-0007dP-6H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736234617; x=1767770617;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VCmXgbYQ/ZSnluxbOEjbx9Minq4xrR4y0fz/Vjo4cuk=;
 b=EjNw1ZMongcwSRutfiGWsCFshPLUYCJinq4/77wwB0kWDMzfUZWha2xu
 GevxCXbcSPjwZv/j1tlYE6clahN3qaC6AOE6hILb3rgsGjWfMf0PBxdxo
 9w3kq6VI6KE2EBzeu4748i7M63Bh2zOLplIG56ujsqwF/JbKNq3w1uzwt
 U/OHjLlI6/+YBZviNM1wqZi4TpxIA5cWrF+8sXdnH/W8wHUuhmBUV9t0A
 x8k/gfj+b+6LMekzKh18mnC3l3UXKiZ83Hj1+aURWljJFTPDpTXd9dfLT
 fkHGKQ6BUQZ2n0LOdopctvpLFRr6BhRowAY9SF3v2AEiDCMTHYCVmYrhK g==;
X-CSE-ConnectionGUID: knYsFdHgSuO50k7lBnC0LQ==
X-CSE-MsgGUID: R+8vdEWMQVeC3uH6B7wpZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="39224762"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="39224762"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:23:33 -0800
X-CSE-ConnectionGUID: uAnHJf0hSJ+tdqKYqvemNA==
X-CSE-MsgGUID: n+CvdcgRRw+5MF8KybiI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107304152"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:23:30 -0800
Message-ID: <ae5dc8f4-6967-4ec9-8176-ea8a5b6c2f63@intel.com>
Date: Tue, 7 Jan 2025 15:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] cpu: Drop CPUState::nr_cores
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241230171150.5ef181e0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241230171150.5ef181e0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On 12/31/2024 12:11 AM, Igor Mammedov wrote:
> On Thu,  5 Dec 2024 09:57:12 -0500
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> The series is motivated by auditing the usage of CPUState::nr_cores and
>> CPUState::nr_threads, which is motivated by [1].
>>
>> The initial goal is to initialize nr_threads and nr_cores earlier for
>> x86, which leads to patches [2] and [3]. Patch [2] touches all the ARCHes
>> and patch [3] looks hacky. At last Igor suggested to audit nr_threads and
>> nr_cores, and only set them in the pre_plug() callback for the ARCHes that
>> really need them[1].
>>
>> By audting nr_threads and nr_cores, I found nr_cores is only used by
>> x86. So we can introduce a x86 specific one and initialize in
>> x86_cpu_pre_plug(), then drop nr_cores totally.
>>
>> However for nr_threads, it's used by MIPS and PPC as well[4]. There are
>> two options:
>> 1. maintain separate substitute in X86/MIPS/PPS, so we can drop
>> CPUState::nr_threads like for CPUState::nr_cores.
>>
>> 2. keep CPUState::nr_threads and find place (or introduce pre_plug()) to
>> initialize them earlier for MIPS/PPC.
>>
>> I would like to seek for opinions for which one is prefered.
>>
>> This series implments the drop for CPUState::nr_cores. Though it doesn't
>> help on the initial goal without the solution for nr_threads, I think it
>> is still a good cleanup?
>>
>> BTW, by initializing nr_threads and nr_cores earlier than
>> qemu_init_vcpu(), it also unblocks [5].
> 
> With minor fixes included mentioned during review
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Appreciated for your Ack, Igor!

There is a v2[*], could you take a look at that?

[*] 
https://lore.kernel.org/qemu-devel/20241219110125.1266461-1-xiaoyao.li@intel.com/

>>
>>
>> [1] https://lore.kernel.org/qemu-devel/20241125103857.78a23715@imammedo.users.ipa.redhat.com/
>> [2] https://lore.kernel.org/qemu-devel/5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com/
>> [3] https://lore.kernel.org/qemu-devel/20241122160317.4070177-1-xiaoyao.li@intel.com/
>> [4] https://lore.kernel.org/qemu-devel/045f9cb1-2b17-4b2c-985f-3c34e3626b36@intel.com/
>> [5] https://lore.kernel.org/qemu-devel/20231128171239.69b6d7b1@imammedo.users.ipa.redhat.com/
>>
>> Xiaoyao Li (4):
>>    i386/topology: Update the comment of x86_apicid_from_topo_ids()
>>    i386: Extract a common fucntion to setup value of
>>      MSR_CORE_THREAD_COUNT
>>    i386: Track cores_per_module in CPUX86State
>>    cpu: Remove nr_cores from struct CPUState
>>
>>   hw/core/cpu-common.c                 |  1 -
>>   hw/i386/x86-common.c                 |  4 +++-
>>   include/hw/core/cpu.h                |  2 --
>>   include/hw/i386/topology.h           |  5 +++--
>>   system/cpus.c                        |  1 -
>>   target/i386/cpu.c                    |  2 +-
>>   target/i386/cpu.h                    | 16 ++++++++++++++++
>>   target/i386/hvf/x86_emu.c            |  3 +--
>>   target/i386/kvm/kvm.c                |  5 +----
>>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>>   10 files changed, 26 insertions(+), 16 deletions(-)
>>
> 


