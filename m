Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D13C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FCf-0006Ya-L6; Fri, 25 Apr 2025 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8FCa-0006U6-2z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:18:33 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8FCX-0006tT-Gm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745572709; x=1777108709;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=q8s+GZ7wJiAkeM4rMouGv5MqAa2zRRibXViU1Z94qMQ=;
 b=IBPKTZMWMmWxoDjT0hDzCG6midWTlt6UuxdAhMjWABWv/XAbcqj160pz
 rqUlc7BksNMbg5V3MwjoLNIJTrjR7dZl0RRPnBeIta3sGgD/NUeviqvMC
 YynKv+Ud/IeYJ0TJ/zWsYf6r02ddchRt0kVYx3S4SQfQjN88skxfQXnX6
 mj4rIyfDoazawyS7MjjuF3Hy1MQiSJuBJTZByc755tY8OtzTfVz+WrTUc
 lHU2TMF2wSq5KQnDHSIUYJYviBDQSNZ4tXkaksE6bGKyqW5oibiXX9owF
 uEfYia36GAVNO+YgSWzgFbeNky7fW0c3FlaRbjn11XpMc4eObweFp65oF g==;
X-CSE-ConnectionGUID: Q8Vc/4xAR96IF8tZZ/fBrA==
X-CSE-MsgGUID: ZVbv9w1hQxiveZ1TPjdqRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47401790"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47401790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2025 02:18:25 -0700
X-CSE-ConnectionGUID: lAFKN5hRQHWPCQL8vIwrpA==
X-CSE-MsgGUID: J/43f1rIQ6+gESFEmGkTow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="137693367"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 25 Apr 2025 02:18:22 -0700
Date: Fri, 25 Apr 2025 17:39:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Message-ID: <aAtYRhLiHoiJ4S1p@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <c522ebb5-04d5-49c6-9ad8-d755b8998988@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c522ebb5-04d5-49c6-9ad8-d755b8998988@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 4/23/25 7:46 PM, Zhao Liu wrote:
> > 
> > Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
> > "assert" check blocks adding new cache model for non-AMD CPUs.
> > 
> > Therefore, check the vendor and encode this leaf as all-0 for Intel
> > CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
> > check for Zhaoxin as well.
> 
> Thanks for taking Zhaoxin CPUs into account.
> 
> Zhaoxin follows AMD's definition for CPUID leaf 0x80000005, so this leaf is
> valid on our CPUs rather than reserved. We do, however, follow Intel's
> definition for leaf 0x80000006.

Thank you! I'll revert the change.

> > Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
> > information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
> > For this case, there is no need to tweak for non-AMD CPUs, because
> > vendor_cpuid_only has been turned on by default since PC machine v6.1.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   target/i386/cpu.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1b64ceaaba46..8fdafa8aedaf 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7248,11 +7248,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
> >           break;
> >       case 0x80000005:
> > -        /* cache info (L1 cache) */
> > -        if (cpu->cache_info_passthrough) {
> > +        /*
> > +         * cache info (L1 cache)
> > +         *
> > +         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
> > +         * information, i.e., get AMD's cache model. It doesn't matter,
> > +         * vendor_cpuid_only has been turned on by default since
> > +         * PC machine v6.1.
> > +         */
> > +        if (cpu->vendor_cpuid_only &&
> > +            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> 
> Given that, there is no need to add IS_ZHAOXIN_CPU(env) to the 0x80000005
> path. Note that the L1 TLB constants for the YongFeng core differ from the
> current values in target/i386/cpu.c(YongFeng defaults shown in brackets):
> 
> #define L1_DTLB_2M_ASSOC       1 (4)
> #define L1_DTLB_2M_ENTRIES   255 (32)
> #define L1_DTLB_4K_ASSOC       1 (6)
> #define L1_DTLB_4K_ENTRIES   255 (96)
> 
> #define L1_ITLB_2M_ASSOC       1 (4)
> #define L1_ITLB_2M_ENTRIES   255 (32)
> #define L1_ITLB_4K_ASSOC       1 (6)
> #define L1_ITLB_4K_ENTRIES   255 (96)
> 
> I am still reviewing how these constants flow through cpu_x86_cpuid() for
> leaf 0x80000005, so I'm not yet certain whether they are overridden.
> 
> For now, the patchset can ignore Zhaoxin in leaf 0x80000005. Once I have
> traced the code path, I will send an update if needed. Please include
> Zhaoxin in the handling for leaf 0x80000006.

Sure! And you can add more comment for the special cases.

If possible, could you please help check if there are any other cases :-)
without spec reference, it's easy to cause regression when refactor. As
per Xiaoyao's comment, we would like to further clean up the Intel/AMD
features by minimizing the ¡°incorrect¡± AMD features in Intel Guests
when vendor_cpuid_only (or another enhanced compat option) is turned on.

> I should have sent this after completing my review, but I did not want to
> delay your work. Sorry for the noise.

No problem. And your info really helps me. It will take me a little
while until the next version. It makes it easier to decouple our work
and review them separately in the community!

> Thanks again for your work.

You're welcome!


