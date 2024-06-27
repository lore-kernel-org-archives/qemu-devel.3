Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A31AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnR5-0003pj-8h; Thu, 27 Jun 2024 07:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sMnR3-0003oJ-7b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:37:05 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sMnR1-0006xn-9X
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719488223; x=1751024223;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EsHyF8FI9Ep/AX9p5cB8YmwhhJICxdbmONHp5r/od0M=;
 b=WoWKGQXHLm2O7786HAzWpcZpsvc3/JKsDTSAiEAmKlUN93zhEB98ovVZ
 m7/l4csqtx5tohmYE5NZftfLZrlAbDQ12e9rbWMF5/32/5Y0U8DK4FXAi
 YHJ9R+vjjZ7FjGPrk0RAUZo2Kpntx54H9vq4bBkXPWI/m14mU2WYsD5PD
 o+86wiVfpI/CK3iGjw+3J/2M/0Y0nJG0nXgsODjmzh0LGx6MM9Kc1cYb3
 kRtnzjZPFM9iqb1/uB6xy+ZWDwKELWexWhbyt2bbv/88bLiLPchAS4UiJ
 hLC2vRvzjPVaYrqPrhroVF5hocD7W50Ugx1WUHbi37RbBsklMSR9fdtOy g==;
X-CSE-ConnectionGUID: PfcKF4NlRi+49R3dZp9otA==
X-CSE-MsgGUID: wJN2a6xtR/SaPuCaEhT59w==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16746361"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="16746361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 04:37:02 -0700
X-CSE-ConnectionGUID: n4BhW3wDSUSLn+FZCgQ65w==
X-CSE-MsgGUID: fjG01yxjRwiAHNMsz+O03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="49281031"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 04:37:00 -0700
Date: Thu, 27 Jun 2024 19:52:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
 outdated comments
Message-ID: <Zn1SgwRCnbbwyWzb@intel.com>
References: <20240506085153.2834841-1-zhao1.liu@intel.com>
 <ZmGAi4j+IxZgNShC@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmGAi4j+IxZgNShC@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Hi Paolo,

A gentle poke for this series.

Thanks,
Zhao

On Thu, Jun 06, 2024 at 05:25:31PM +0800, Zhao Liu wrote:
> Date: Thu, 6 Jun 2024 17:25:31 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
>  outdated comments
> 
> Hi Paolo,
> 
> Just a ping for this cleanup series.
> 
> Thanks,
> Zhao
> 
> On Mon, May 06, 2024 at 04:51:47PM +0800, Zhao Liu wrote:
> > Date: Mon, 6 May 2024 16:51:47 +0800
> > From: Zhao Liu <zhao1.liu@intel.com>
> > Subject: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
> >  outdated comments
> > X-Mailer: git-send-email 2.34.1
> > 
> > Hi,
> > 
> > This is my v2 cleanup series. Compared with v1 [1], only tags (R/b, S/b)
> > updates, and a typo fix, no code change.
> > 
> > This series picks cleanup from my previous kvmclock [2] (as other
> > renaming attempts were temporarily put on hold).
> > 
> > In addition, this series also include the cleanup on a historically
> > workaround and recent comment of coco interface [3].
> > 
> > Avoiding the fragmentation of these misc cleanups, I consolidated them
> > all in one series and was able to tackle them in one go!
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20240426100716.2111688-1-zhao1.liu@intel.com/
> > [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> > [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> > 
> > Thanks and Best Regards,
> > Zhao
> > ---
> > Zhao Liu (6):
> >   target/i386/kvm: Add feature bit definitions for KVM CPUID
> >   target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
> >     MSR_KVM_SYSTEM_TIME definitions
> >   target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
> >   target/i386/kvm: Save/load MSRs of kvmclock2
> >     (KVM_FEATURE_CLOCKSOURCE2)
> >   target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
> >   target/i386/confidential-guest: Fix comment of
> >     x86_confidential_guest_kvm_type()
> > 
> >  hw/i386/kvm/clock.c              |  5 +--
> >  target/i386/confidential-guest.h |  2 +-
> >  target/i386/cpu.h                | 25 +++++++++++++
> >  target/i386/kvm/kvm.c            | 63 +++++++++++++++++++-------------
> >  4 files changed, 66 insertions(+), 29 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 

