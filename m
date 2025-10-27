Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E36DCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKhZ-0001vJ-GF; Mon, 27 Oct 2025 06:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKhV-0001pG-0R
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:43:45 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKhR-0001nu-6U
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761561821; x=1793097821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jsUXYGsPkXHYB7gSMqSqkQ15VcUFWDSt+Ems3L6pifQ=;
 b=k46Sg3++ZSnyrUQTHvPWlFxFydE5UOPxihb/5wBN1dsT3SvKJ+LxixHx
 fGDnbyfTQ+bYQ19DPwYqDtOAoogO1zw6Tey6YJLDAAFWsJGwAIm9fIavp
 as7NUXBTzCckFGWo9ubR3NfMtbvlY87vPx90SNI67siWmRE2VAZSroq4+
 vxSuzQ9WOjdON+KO9T+huafrochOtwiIidKmVcDAyj1A6UtbzQHceEfLF
 3E0F7KLMMXq466djZytR2p58fTaPQriyOtiMLln54k99T05lpgDUlNTzQ
 adtuBOlxfsY8CxBkzL/tiDNtmIDQOgmTEJ6jOjIg1BHCPgVoz9sw7+bJx w==;
X-CSE-ConnectionGUID: NkSC4Rp5SwSqZ5rDgshE9w==
X-CSE-MsgGUID: cwjTFyR6T2mYJVCs1pR0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67472116"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67472116"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 03:38:54 -0700
X-CSE-ConnectionGUID: kZJe5iBRR4CQJLPLtgorsg==
X-CSE-MsgGUID: tYhT4FeVSn2qST4hENL1Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184629188"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2025 03:38:51 -0700
Date: Mon, 27 Oct 2025 19:01:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 08/20] i386/cpu: Drop pmu check in CPUID 0x1C encoding
Message-ID: <aP9Q7RArsit6GoxM@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-9-zhao1.liu@intel.com>
 <ab59bf10-3d16-4c34-b87d-31002fe83142@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab59bf10-3d16-4c34-b87d-31002fe83142@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5b7a81fcdb1b..5cd335bb5574 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -8275,11 +8275,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           }
> >           break;
> >       }
> > -    case 0x1C:
> > -        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> > -            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> > -            *edx = 0;
> > +    case 0x1C: /* Last Branch Records Information Leaf */
> > +        *eax = 0;
> > +        *ebx = 0;
> > +        *ecx = 0;
> > +        *edx = 0;
> 
> Could you help write a patch to move the initialization-to-0 operation out
> to the switch() handling as the common first handling. So that each case
> doesn't need to set them to 0 individually.

Yes, this way could eliminate some redundant code, but explicitly
initializing each leaf currently helps prevent missing something.

Moreover, such cleanup would affect almost all CPUID leaves.
I'm afraid this would make it inconvenient for cherry-picking and
backporting. So the benefits are relatively limited. :-(

> > +        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> > +            break;
> >           }
> > +        x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> > +        *edx = 0; /* EDX is reserved. */
> 
> Not the fault of this series. I think just presenting what KVM returns to
> guest (i.e., directly passthrough) isn't correct. Once leaf 0x1c gets more
> bits defined and KVM starts to support and report them, then the bits
> presented to guest get changed automatically between different KVM.
> 
> the leaf 0x1c needs to be configurable and QEMU needs to ensure the same
> configuration outputs the constant result of leaf 0x1c, to ensure safe
> migration.
> 
> It's not urgent though. KVM doesn't even support ArchLBR yet.

I agree, the feature bits enumeration is necessary. Before KVM (or other
accelerators) supports the arch LBR, there's no need to make too many
logic changes - so in this series I try to not change functionality of
arch lbr as much as possible; Let's wait and see the new arch LBR series
from Zide in future.

Regards,
Zhao



