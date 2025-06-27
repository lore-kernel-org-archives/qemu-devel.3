Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295EC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4Ke-0006nL-7s; Fri, 27 Jun 2025 04:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4Kb-0006jV-Vo
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:21:10 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4KX-0001CQ-UH
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751012466; x=1782548466;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CpxF4zTGQgoX3DS8eH2DE5rvizvGL3rcHU+vjne/WAs=;
 b=hJPkBZ1P0UILKiLFIOgd7ABtb/jzEo6EaJ84h9L7Bz0qNqG289zshArc
 Lon30CebhWRdMqvKOccqMJY+Hhn6MDSfRV4V3R+gx+wqSR43phB+ytjNc
 kELQacYRq9HK2/RzNNoBlQ9tTQKRnC7I/RgijjVpf8zvugUwUi7+TcIXr
 W9kUOqptqwYX0XtQwm/mn1+Ar6HMhzxsUbBiA3xvwtAWXoLmn+QFbC2mk
 UUWB73O2E9ggDbJbmvFVCeViY6Xr7mMemcN1swbMn54yI8u149wp6B5ou
 B44B39GMSt2OPeIkvxI5/06IeVLiEERCejj1GYYNYSUqUSTdjwxFQ9ekn Q==;
X-CSE-ConnectionGUID: 98laiWQsRWyAnZyUmIXREw==
X-CSE-MsgGUID: 1WahiXOmQQe5WZUnrWnScg==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="55944021"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="55944021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:21:04 -0700
X-CSE-ConnectionGUID: fQocwWKsS/+g4ogz77+YjA==
X-CSE-MsgGUID: jVRG3CtqSAqp1apA6I2fYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="152926186"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:21:01 -0700
Message-ID: <c8b0a815-c033-4ce7-8ae6-597b2a2c84d5@intel.com>
Date: Fri, 27 Jun 2025 16:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf
 as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-2-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250627035129.2755537-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
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

On 6/27/2025 11:51 AM, Zhao Liu wrote:
> Per SDM,
> 
> 80000000H EAX Maximum Input Value for Extended Function CPUID Information.
>            EBX Reserved.
>            ECX Reserved.
>            EDX Reserved.
> 
> EBX/ECX/EDX in CPUID 0x80000000 leaf are reserved. Intel is using 0x0
> leaf to encode vendor.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c7f157a0f71c..867e08236540 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8280,9 +8280,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x80000000:
>           *eax = env->cpuid_xlevel;
> -        *ebx = env->cpuid_vendor1;
> -        *edx = env->cpuid_vendor2;
> -        *ecx = env->cpuid_vendor3;
> +
> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
> +            *ebx = *ecx = *edx = 0;

"Reserved" is different to "Reserved to 0".

So you'd better provide justification like "set them to all zero as what 
real Intel processor returns"

> +        } else {
> +            *ebx = env->cpuid_vendor1;
> +            *edx = env->cpuid_vendor2;
> +            *ecx = env->cpuid_vendor3;
> +        }
>           break;
>       case 0x80000001:
>           *eax = env->cpuid_version;


