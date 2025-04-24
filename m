Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D6C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 02:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7mNG-0003Uk-Pm; Wed, 23 Apr 2025 22:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7mNF-0003U7-Ao
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:31:37 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7mND-00061A-5t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745461895; x=1776997895;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Ekg2qfsM9bPBGyQiZZJL+MMvwd2ayI0bu7Qyc0F1u/8=;
 b=meVAD5Y+6O3fjcueaDJUPHyA4zeJjT0ONgDewobpNV7XrFAj+woakQu0
 RVX86k0Ji3BU7EhzKOo/DGl9sRC4vYY8TxbCcVCdNwKTRF34PzlW2k54u
 0kMiICmiB5v3tpGyhS1Ogm8CAQ/Vj9U4yFe6/lK2i+oH7udgKUx6ENKC5
 R6bHGWg5TuesX3Zj+haXtfeqatYuCX87d5NVkRAdYu1kzBPOf33v4AJjM
 bTSywA5zJgDyKyxroQ8O1xSxh7ZFWICVBl2SkCvP0eb4bgjr+FzqsbMUh
 XiJfSnBrjLbgPnXH/BLpOGmbZo1MPzqLbFH3Tg0+drKfnyRcixEn0ilYg A==;
X-CSE-ConnectionGUID: YdEicEHtQwWKBhtSVdfudw==
X-CSE-MsgGUID: Vws1opZeRt2q3F8L2Ela0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57724973"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57724973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 19:31:31 -0700
X-CSE-ConnectionGUID: 3zhve+q3R8inQ1NaKVLnag==
X-CSE-MsgGUID: UH0bjNOcTgOH3Yrd3jjvvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="132788659"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2025 19:31:28 -0700
Date: Thu, 24 Apr 2025 10:52:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Message-ID: <aAmnaAbrELVl3UiT@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <596c7a44-797b-4a16-bd7e-0f0dc5c2e593@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <596c7a44-797b-4a16-bd7e-0f0dc5c2e593@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

> > +        /*
> > +         * cache info (L1 cache)
> > +         *
> > +         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
> > +         * information, i.e., get AMD's cache model. It doesn't matter,
> > +         * vendor_cpuid_only has been turned on by default since
> > +         * PC machine v6.1.
> > +         */
> 
> We need to define a new compat property for it other than vendor_cpuid_only,
> for 10.1.
> 
> I proposed some change to leaf FEAT_8000_0001_EDX[1], and I was told by
> Paolo (privately) that vendor_cpuid_only doesn't suffice.
> 
>  On Fri, Oct 11, 2024 at 6:22 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>  >
>  > On 10/11/2024 11:30 PM, Paolo Bonzini wrote:
>  > > On Fri, Oct 11, 2024 at 4:55 PM Xiaoyao Li <xiaoyao.li@intel.com>
> wrote:
>  > >>
>  > >> I think patch 8 is also a general issue> Without it, the
>  > >> CPUID_EXT2_AMD_ALIASES bits are exposed to Intel VMs which are
>  > >> reserved bits for Intel.
>  > >
>  > > Yes but you'd have to add compat properties for these. If you can do
>  > > it for TDX only, that's easier.
>  >
>  > Does vendor_cpuid_only suffice?
> 
>  Unfortunately not, because it is turned off only for <=6.0 machine
>  types. Here you'd have to turn it off for <=9.1 machine types.
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20240814075431.339209-9-xiaoyao.li@intel.com/

For the patch link, you wanted to mark it as unavailiable but it would
break the machine <= 6.0 (with vendor_cpuid_only turned off), correct?

For this patch:
 * vendor_cpuid_only turns off for <= 6.0 machine, no change.
 * vendor_cpuid_only turns on for > 6.0 machine, I treated it as a
   "direct" fix because original codes encode the AMD cache model info
   on non-AMD platform (in ecx & edx). This doesn't make sense. Non-AMD
   platform should use cache_info_cpuid4 or 0 here. If it is considered
   a fix, it may be more appropriate to use cache_info_cpuid4.

I think it's somehow similar to the “trade-offs” Daniel indicated [2].

This case can also be fixed by compat option. Then we don't  need to
encode cache_info_cpuid4 info for non-AMD platforms in this leaf.

Do you still need the patches in your links? (I didn't find the related
patch merged.) If so, I can add the compat option in the next version
which could also help you land your previous patches v10.1 as well.

[2]: https://lore.kernel.org/qemu-devel/Z08j2Ii-QuZk3lTY@redhat.com/

> > +        if (cpu->vendor_cpuid_only &&
> > +            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> > +            *eax = *ebx = *ecx = *edx = 0;
> > +            break;
> > +        } else if (cpu->cache_info_passthrough) {
> >               x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
> >               break;
> >           }
> > +
> >           *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
> >                  (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
> >           *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
> 

