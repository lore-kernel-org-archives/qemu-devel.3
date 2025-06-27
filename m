Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E25C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4HZ-0005wY-DN; Fri, 27 Jun 2025 04:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4HX-0005wJ-KM
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:17:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uV4HV-0006zS-Dt
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751012278; x=1782548278;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8V/K4usUwieMu46RJaL0JU5FflRxXMlRqbZCzyci71w=;
 b=kAiNQF83Bg5jgzS2YnWJtq5penVrM1ji/5bgpztBvNy5n4Bv7rQppL9V
 X1cNXZS4iEnQ4ktbKtHmtPuHR4+NvJqcljJ33vX7vKYrKeHW9Lcqmst8e
 iROVYguVS9U0G6mDpPs9WevgukQscG8oNWq801h3iGP0deQpswRQrCBd5
 zmb+993kisCbGQp6nF/WcE0R0AC/Zv/5y27wZG7Kn/r1ZRXWBjcyy0l+S
 a9MHl1CYw1cdyM1O/ETWyj8jUlLwxmwohFJftLTPMJs+kpvt3HtuFpV9+
 BkETgwDkmIMXMHkCiWp7mPM4dsITeYoJQmFWHeFrGMCeQPQrBufYmTgQO w==;
X-CSE-ConnectionGUID: +a4MFTF/R+uE4oGRF+9iUg==
X-CSE-MsgGUID: 1UugWEKZSAGNGb+WCBa7GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="78761678"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="78761678"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:17:52 -0700
X-CSE-ConnectionGUID: eaMgwebpT5yxVRKhtLp2NA==
X-CSE-MsgGUID: aqr7yh1WS6StfW/b+T8FGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="152925371"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:17:50 -0700
Message-ID: <fffd0d18-5272-4250-a3a5-c450286f5449@intel.com>
Date: Fri, 27 Jun 2025 16:17:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] i386/cpu: Clean Up Reserved CPUID Leaves for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
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
> Hi,
> 
> Since the previsor unified cache model series has already introduced a
> new compat property "x-vendor-cpuid-only-v2", it's a chance to once
> again consolidate more vendor-specific CPUIDs.

Please provide the link to the patch that introduced 
"x-vendor-cpuid-only-v2"

When talking about vendor-specific CPUIDs, there are multiple vendors 
for x86, including Intel, AMD, Hygon and Zhaoxin. From the patches, you 
are only dealing with Intel specifically. So a basic question is, why 
not rename "x-vendor-cpuid-only-v2" to "x-intel-cpuid-only"?


> I also checked the CPUID leaves currently supported by Intel & AMD and
> found that since the previous "x-vendor-cpuid-only," AMD has already
> cleaned up the Intel-specific CPUIDs quite well.
> 
> As for Intel, the only cleanup needed is for the "extended function
> CPUID" leaves (0x80000000~0x80000008). That's what this series does.
> 
> This series is based on:
> 
> <20250626083105.2581859-1-zhao1.liu@intel.com>
> 
> Or you can find the code at:
> 
> https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (4):
>    i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for
>      Intel
>    i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for Intel
>    i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as reserved for Intel
>    i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
> 
>   target/i386/cpu.c | 83 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 49 insertions(+), 34 deletions(-)
> 


