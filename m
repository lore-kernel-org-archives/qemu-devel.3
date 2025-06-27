Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2132C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4NZ-0000HM-Ts; Fri, 27 Jun 2025 04:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4NW-0000Gc-Ve
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:24:11 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4NU-0001ct-Uw
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751012649; x=1782548649;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XrI4vpS4ZE9ZvR/h6/QehLdrMplYTo9Ns/njSi80pdM=;
 b=Fs81NhfC9PD9IxHavEZ9bfW7GKiBSI+GHWJtJLY8BYz8WI2EedXYH+J9
 qTlhhwW2lpUyGcknXkxtgGtir72dKLGKj40YugFmY4rcVt5rN2n0JtUGx
 1BSUuZxVDch1zBwUuiHTFSYGbLxML1YciYPRbBWe69uOCaOKHLsqmkhi7
 627ojEon8s14K+rw6xXDvZeiJfD79vf7Hf1cDqMIZgmTozGRdtbc7E41v
 UImsvDMkhRZqng03H9StkO4JGuP+l8zinHLZX9s01DjgkZCWgIji1ZRmy
 emI3jQHZ59OcL7JLBEVI2iaD4YdYl4+poe+zCvNK2inETpgVxxERIrJZy g==;
X-CSE-ConnectionGUID: j8DPGkqWRNiOn9sPvmhGKw==
X-CSE-MsgGUID: 6NEQVuXiQQyNj7xdXg8cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64011843"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="64011843"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:24:06 -0700
X-CSE-ConnectionGUID: FpkZuIZMSe6g647B6KdMxA==
X-CSE-MsgGUID: PtOYRRPJSpawGQqPHyEpVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="157296823"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:24:04 -0700
Message-ID: <dedb9a90-a516-430e-8748-f776392f508d@intel.com>
Date: Fri, 27 Jun 2025 16:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as
 reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-4-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250627035129.2755537-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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
> ECX/EDX in CPUID 0x80000008 leaf are reserved. Encode these 2 registers
> as 0 for Intel.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6d590a9af389..5d5a227d4c8a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8391,6 +8391,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
> +
> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
> +            *ecx = *edx = 0;
> +            break;
> +        }

current code guarantees ecx and edx to be 0 for !IS_AMD_CPU(). I think 
the patch is unnecessary.

>           if (threads_per_pkg > 1) {
>               /*
>                * Bits 15:12 is "The number of bits in the initial


