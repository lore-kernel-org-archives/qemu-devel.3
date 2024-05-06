Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF5CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oHZ-0007so-R7; Sun, 05 May 2024 22:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3oHW-0007rp-EH
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:40:47 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3oHT-0007Dk-EY
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714963244; x=1746499244;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8NCHiPb7AIUJPCLV8GfvbkSeFl/6CephUsTfkltLJuU=;
 b=F8kOaYMl931/hFTQ7/pp+3ZA0oTmI7FehjEas4dLBZn9wvM6fSmZLvN/
 A1W7vmIJQihjk+/WxkDhCiIEzOamlvGccSN6KWS+V3v+4bjUSJjyGdZAD
 bPYpXxTsMmMjAI1FQqW3Prte9gvc6xvM/6OMQyxXDB6QHB1jQ/u+e4Ag0
 8TxNQbTpHWbCPpeLzgOnQbAmlxsfwLGn5NYJmVVY2U93TFHq8qRv7obDA
 og6nIWiD9XIayCRbsGI1kK4pstJVYZyymFvt9iaNlhSNMoQKAdOjVeocv
 M1wXhIQ2kMLptYoT9Tx4x1UkTgN3HwOJu/7gdesOHW2rI95Xh66Vubeu4 g==;
X-CSE-ConnectionGUID: RyKqi4QFQrKSO457NGQzsw==
X-CSE-MsgGUID: QMNTDxMRToSKOzy5uPyf2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="36080381"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="36080381"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 19:40:33 -0700
X-CSE-ConnectionGUID: ool1PNuwS6WykBKUBLBn2g==
X-CSE-MsgGUID: Os5rVDVeQ9yhjdj2IAtbiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="32494811"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 05 May 2024 19:40:30 -0700
Date: Mon, 6 May 2024 10:54:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 1/6] target/i386/kvm: Add feature bit definitions for KVM
 CPUID
Message-ID: <ZjhGchDOqGB1taVz@intel.com>
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
 <20240426100716.2111688-2-zhao1.liu@intel.com>
 <04d827f7-fb18-4c93-b223-91dd5e190421@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d827f7-fb18-4c93-b223-91dd5e190421@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Zide,

On Fri, Apr 26, 2024 at 10:23:27AM -0700, Chen, Zide wrote:
> Date: Fri, 26 Apr 2024 10:23:27 -0700
> From: "Chen, Zide" <zide.chen@intel.com>
> Subject: Re: [PATCH 1/6] target/i386/kvm: Add feature bit definitions for
>  KVM CPUID
> 
> On 4/26/2024 3:07 AM, Zhao Liu wrote:
> > Add feature definiations for KVM_CPUID_FEATURES in CPUID (
> > CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
> > offset calculations.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > v2: Changed the prefix from CPUID_FEAT_KVM_* to CPUID_KVM_*. (Xiaoyao)
> > ---
> >  hw/i386/kvm/clock.c   |  5 ++---
> >  target/i386/cpu.h     | 23 +++++++++++++++++++++++
> >  target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
> >  3 files changed, 39 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> > index 40aa9a32c32c..ce416c05a3d0 100644
> > --- a/hw/i386/kvm/clock.c
> > +++ b/hw/i386/kvm/clock.c
> > @@ -27,7 +27,6 @@
> >  #include "qapi/error.h"
> >  
> >  #include <linux/kvm.h>
> > -#include "standard-headers/asm-x86/kvm_para.h"
> >  #include "qom/object.h"
> >  
> >  #define TYPE_KVM_CLOCK "kvmclock"
> > @@ -334,8 +333,8 @@ void kvmclock_create(bool create_always)
> >  
> >      assert(kvm_enabled());
> >      if (create_always ||
> > -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> > -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> > +        cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
> > +                                       CPUID_KVM_CLOCK2)) {
> 
> To achieve this purpose, how about doing the alternative to define an
> API similar to KVM's guest_pv_has()?
>
> xxxx_has() is simpler and clearer than "features[] & CPUID_xxxxx",
> additionally, this helps to keep the definitions identical to KVM, more
> readable and easier for future maintenance.

Yes, it's a clearer way! I can explore the xxxx_has() pattern in another
series and try to expand it to more CPUID leaves.

Thanks,
Zhao



