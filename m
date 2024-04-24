Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5000C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzeHw-0006Gc-QA; Wed, 24 Apr 2024 11:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzeHv-0006Er-1W
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:11:59 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzeHs-0001cc-CE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713971517; x=1745507517;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=z+yYUortuN9MLve/Ru6n/slcgqQeEK0ycWBgsD8ltgU=;
 b=gOwzjjk+E4ydYZOFcDqnVOkeFo8CItM1V1uZdtjtzw1UfkxQ7H3O7NWV
 Fbjh8/mQWcj0evuynhKjskjMHuOreTvGV5I1I5ReOGJDtaypuRPgWgI3C
 izR0auBm31xbOCppSNJpGug1hBaI/clm6sCfdEImBaXDG8Eid6L2kwSp2
 RnhGEC6vmW9EZQGtj2LSWIr8Cp3RaQFMaT3Wjzge8zDbMLBsnXYhVEuEZ
 1lC21ZDte6hP/bJsJcp65hdSI2lgE7gQQ5epui/NF2v8EzPqOt6CM05i6
 lX8FfiJZfP2GaYt4+XCZderHQ54gAKIemOES2GF+yGOZNX7lqsap+8Vsu w==;
X-CSE-ConnectionGUID: 6DWzN4unTRS2WTtluSEMtQ==
X-CSE-MsgGUID: U3JmY8kVSPWKVjMVSxPY/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9772666"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9772666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:11:52 -0700
X-CSE-ConnectionGUID: c9IMInXcT4OiWPCx3Bo/vA==
X-CSE-MsgGUID: SmpQ8IYDRKuV4ZwLsss+Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="48005578"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:11:47 -0700
Message-ID: <5e7cbb8b-51e6-4be9-868b-601a0418374e@intel.com>
Date: Wed, 24 Apr 2024 23:11:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 2/7] target/i386/kvm: Remove local
 MSR_KVM_WALL_CLOCK and MSR_KVM_SYSTEM_TIME definitions
To: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
 <20240329101954.3954987-3-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240329101954.3954987-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/29/2024 6:19 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> These 2 MSRs have been already defined in the kvm_para header
> (standard-headers/asm-x86/kvm_para.h).
> 
> Remove QEMU local definitions to avoid duplication.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/kvm/kvm.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2f3c8bc3a4ed..be88339fb8bd 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -78,9 +78,6 @@
>   #define KVM_APIC_BUS_CYCLE_NS       1
>   #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
>   
> -#define MSR_KVM_WALL_CLOCK  0x11
> -#define MSR_KVM_SYSTEM_TIME 0x12
> -
>   /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
>    * 255 kvm_msr_entry structs */
>   #define MSR_BUF_SIZE 4096


