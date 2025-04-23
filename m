Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EECC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zo1-0004W1-3m; Wed, 23 Apr 2025 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Znf-0004Kw-H1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:06:03 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Znc-0007sb-F5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745413561; x=1776949561;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Tl+0+y185DgIHpX7ae3+z9ruYdWnjo2wg62la9Udigo=;
 b=Wmss7KISVwGiRBOBpqKYC4//suxPxLfdmg649St5H9EUK3j3IX1sNSXP
 NK+xIFsDrvidtUX6WmZBOJx7K7yAqhijFqJ8YWx4ujwhyaqMQEX+6nKvE
 LXPopA5XyUFGj/fZch1xJAOmlkDMBSE6abVk+gLQhQInMesIiB3WLiTGQ
 e9tzBukN6ePFVQSUvSU4vg2YgyRVNXCpCS5nXGk1aH3JDBshH0yJnlpcT
 3IxrCS0oDLUewsqs6Wmtl7tu42QoSKo/Dgb3fJA1RG1+NKgwj0EicUvAo
 An50CpXNlhFYTdoA/LMecax5g8YRRAv2fjdQXBGuW/gz84dZo8XPjjMIA Q==;
X-CSE-ConnectionGUID: WC9ofMfYTs2629F8KLjxXA==
X-CSE-MsgGUID: n8TWVb+GT5yqTfq/+cPLNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46914905"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="46914905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 06:05:51 -0700
X-CSE-ConnectionGUID: uXSIB91ITSG/dEQvO9r4RQ==
X-CSE-MsgGUID: HzAHN9adTmaDywAH/ernmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="132061302"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 06:05:46 -0700
Message-ID: <596c7a44-797b-4a16-bd7e-0f0dc5c2e593@intel.com>
Date: Wed, 23 Apr 2025 21:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250423114702.1529340-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/23/2025 7:46 PM, Zhao Liu wrote:
> Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
> "assert" check blocks adding new cache model for non-AMD CPUs.
> 
> Therefore, check the vendor and encode this leaf as all-0 for Intel
> CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
> check for Zhaoxin as well.
> 
> Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
> information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
> For this case, there is no need to tweak for non-AMD CPUs, because
> vendor_cpuid_only has been turned on by default since PC machine v6.1.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b64ceaaba46..8fdafa8aedaf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7248,11 +7248,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
>           break;
>       case 0x80000005:
> -        /* cache info (L1 cache) */
> -        if (cpu->cache_info_passthrough) {
> +        /*
> +         * cache info (L1 cache)
> +         *
> +         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
> +         * information, i.e., get AMD's cache model. It doesn't matter,
> +         * vendor_cpuid_only has been turned on by default since
> +         * PC machine v6.1.
> +         */

We need to define a new compat property for it other than 
vendor_cpuid_only, for 10.1.

I proposed some change to leaf FEAT_8000_0001_EDX[1], and I was told by 
Paolo (privately) that vendor_cpuid_only doesn't suffice.

  On Fri, Oct 11, 2024 at 6:22 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
  >
  > On 10/11/2024 11:30 PM, Paolo Bonzini wrote:
  > > On Fri, Oct 11, 2024 at 4:55 PM Xiaoyao Li <xiaoyao.li@intel.com> 
wrote:
  > >>
  > >> I think patch 8 is also a general issue> Without it, the
  > >> CPUID_EXT2_AMD_ALIASES bits are exposed to Intel VMs which are
  > >> reserved bits for Intel.
  > >
  > > Yes but you'd have to add compat properties for these. If you can do
  > > it for TDX only, that's easier.
  >
  > Does vendor_cpuid_only suffice?

  Unfortunately not, because it is turned off only for <=6.0 machine
  types. Here you'd have to turn it off for <=9.1 machine types.


[1] 
https://lore.kernel.org/qemu-devel/20240814075431.339209-9-xiaoyao.li@intel.com/


> +        if (cpu->vendor_cpuid_only &&
> +            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> +            *eax = *ebx = *ecx = *edx = 0;
> +            break;
> +        } else if (cpu->cache_info_passthrough) {
>               x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
>               break;
>           }
> +
>           *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>                  (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>           *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |


