Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD1AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEvz-0006Hn-4G; Mon, 14 Jul 2025 04:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubEX2-0004Ms-Ea
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:27:29 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubEX0-0007YO-7W
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752481646; x=1784017646;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ulxwXnCarJ/lEri4I9QD+wDA4PxCaZqW3dZhn2Jg+Qw=;
 b=FmAVkrHHMBueIuwjZKwHsda3ODvtxJmlzMPY2Zz7c0W3C5FBrrTfNMVQ
 CMpm6+is6mxFmFMKRHglAdcpA0rTFXD3lCWp9n/m94P0fT3hLlczur4L8
 nFSBZc4nIwTDLmuPimYmf3lctUcj8hUI+gq6r5/4aAPkykeIV4qectjCQ
 B8R7YRPzgZUGuSroao5wFQbB0Bd/ydNp10zze9ZJKscCjKTY3tEp3FXpz
 EWlP5EZl6qqeZV9lgQMpMQAFSw3rDG0gIb3v/YQ55V8G4gJorVEeEf4Lr
 k+XdySu60b+PQPDCnJaUlPSbdv52dRqnRC+NdPsuj3cPG+vG0MKYfvjVq A==;
X-CSE-ConnectionGUID: BBFQsTz8SLy2IkswBoEPeg==
X-CSE-MsgGUID: BVBXZULSQImIpRH9NQdj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54525289"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="54525289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:27:24 -0700
X-CSE-ConnectionGUID: Q6VCSHHtTjuZLjh9OyYkqg==
X-CSE-MsgGUID: V/MSKFOGSlSS31jYDDA7Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="157431131"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:27:20 -0700
Message-ID: <42817b7d-445f-4940-9070-e3c939a6e90f@intel.com>
Date: Mon, 14 Jul 2025 16:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] &
 [12:15] as reserved for Intel/Zhaoxin
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Tao Su <tao1.su@linux.intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-3-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250714080859.1960104-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
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

On 7/14/2025 4:08 PM, Zhao Liu wrote:
> Per SDM,
> 
> 80000008H EAX Linear/Physical Address size.
>                Bits 07-00: #Physical Address Bits*.
>                Bits 15-08: #Linear Address Bits.
>                Bits 31-16: Reserved = 0.
>            EBX Bits 08-00: Reserved = 0.
>                Bit 09: WBNOINVD is available if 1.
>                Bits 31-10: Reserved = 0.
>            ECX Reserved = 0.
>            EDX Reserved = 0.
> 
> ECX/EDX in CPUID 0x80000008 leaf are reserved.
> 
> Currently, in QEMU, only ECX bits[0:7] and ECX bits[12:15] are encoded,
> and both are emulated in QEMU.
> 
> Considering that Intel and Zhaoxin are already using the 0x1f leaf to
> describe CPU topology, which includes similar information, Intel and
> Zhaoxin will not implement ECX bits[0:7] and bits[12:15] of 0x80000008.
> 
> Therefore, mark these two fields as reserved and clear them for Intel
> and Zhaoxin guests.
> 
> Reviewed-by: Tao Su <tao1.su@linux.intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes Since v1:
>   * Consider Zhaoxin (Ewan).
>   * Only clear ECX bits[0:7] and bits[12:15] for Intel/Zhaoxin, and do
>     not cover other bits.
> ---
>   target/i386/cpu.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 37e4bf51d890..abd529d587ba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8387,15 +8387,25 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
> +
>           if (threads_per_pkg > 1) {
>               /*
> -             * Bits 15:12 is "The number of bits in the initial
> -             * Core::X86::Apic::ApicId[ApicId] value that indicate
> -             * thread ID within a package".
> -             * Bits 7:0 is "The number of threads in the package is NC+1"
> +             * Don't emulate Bits [7:0] & Bits [15:12] for Intel/Zhaoxin, since
> +             * they're using 0x1f leaf.
>                */
> -            *ecx = (apicid_pkg_offset(topo_info) << 12) |
> -                   (threads_per_pkg - 1);
> +            if (cpu->vendor_cpuid_only_v2 &&
> +                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> +                    *ecx = 0;
> +            } else {
> +                /*
> +                 * Bits 15:12 is "The number of bits in the initial
> +                 * Core::X86::Apic::ApicId[ApicId] value that indicate
> +                 * thread ID within a package".
> +                 * Bits 7:0 is "The number of threads in the package is NC+1"
> +                 */
> +                *ecx = (apicid_pkg_offset(topo_info) << 12) |
> +                       (threads_per_pkg - 1);
> +            }
>           } else {
>               *ecx = 0;
>           }

I prefer below:

	if ((cpu->vendor_cpuid_only_v2 &&
	    (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) ||
	    threads_per_pkg < 2) {
		*ecx = 0;
	} else {
		...
	}


