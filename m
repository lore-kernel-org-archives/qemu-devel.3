Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9393CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8a7C-00005u-TI; Tue, 14 Oct 2025 04:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8a7A-000057-2E; Tue, 14 Oct 2025 04:10:36 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8a76-00027h-BC; Tue, 14 Oct 2025 04:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760429432; x=1791965432;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+rb9fd7gk+4x28bbRTA4dNcOeJ35a1K7hPzPcL6gDAw=;
 b=eG9DYXRTk1hHUNtByUG0j7PqD6jjh/eYkTvqEk5ys9KgbqpCmyinP3ag
 Dct/OUP6ytnRdmN7TNFLige+sydX1eFG8YducIjTcI8CZBZtpFeIl3I8v
 eRrLwb96vAd2t8ICSGaDTFJBfKYm961QmEazqL2pxsCj3J/c+L0itG0G3
 UJKhOFcZlQb3tcVQFmjJvFkG8sl31emjAQw4cl5XFobi9BfueH9pscLB2
 bcR80sRrlJn8lmOW3GcmRbOm0/ZAWf4saDlpjHCfv7WgtKDcaz6DVInse
 9y+EAPsz2fe3K6sNnKmwljHsEJy2+AcjhP6dezO1ABXpwBlMeIa9Lq4ck g==;
X-CSE-ConnectionGUID: zK1RHPySRSWYUu/4I4svQg==
X-CSE-MsgGUID: BBqmGwzqRyqsQCC1tgoWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61793295"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61793295"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:10:28 -0700
X-CSE-ConnectionGUID: hxTqizD9TUK8trm29fJs2g==
X-CSE-MsgGUID: F/s274voTFmQeW7xGWCKZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181772916"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 01:10:25 -0700
Date: Tue, 14 Oct 2025 16:32:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, hector.cao@canonical.com, lk@c--e.de,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] target/i386: move arch_capabilities & pdcm compatibility
 properties from 10.0 to 9.2 machine type
Message-ID: <aO4KnvVkANLF/3QF@intel.com>
References: <20251014063650.25057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014063650.25057-1-mjt@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

+Christian (who reported the migration bug) and Perter Xu

On Tue, Oct 14, 2025 at 09:36:47AM +0300, Michael Tokarev wrote:
> Date: Tue, 14 Oct 2025 09:36:47 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: [PATCH] target/i386: move arch_capabilities & pdcm compatibility
>  properties from 10.0 to 9.2 machine type
> X-Mailer: git-send-email 2.47.3
> 
> The two compat properties, introduced by the following commits (f):
> 
>  e9efa4a771 target/i386: add compatibility property for arch_capabilities
>  6529f31e0d target/i386: add compatibility property for pdcm feature
> 
> were added to address migration issues after the following commits (c10.1):
> 
>  d3a24134e3 target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
>  e68ec29809 i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check
> 
> which were added in 10.1 and broke migration from 10.0 to 10.1.
> 
> However, the 2 changes which required the compat properties, were
> mistakenly cherry-picked to 10.0.x stable branch (c10.0):
> 
>  24778b1c7e target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
>  3d26cb65c2 i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check
> 
> and were released as v10.0.4 (and v10.0.5).  This breaks migration
> from earlier versions to 10.0.4 the same way as it's broken for 10.1
> where the two fixes (f) are needed.
> 
> However, reverting c10.0 commits from the 10.0.x stable branch will
> make that branch further incompatible with itself again, in an opposite
> way.
> 
> It might be better to accept the current situation and "pretend" that
> the c10.0 commits has "always" been in 10.0 branch.  So the fixups (f)
> are needed for both 10.0 and 10.1 branches to preserve migration
> compatibility from the earlier versions and between 10.0 & 10.1 & next.
> So the fixup commits (f) can be applied to both branches, and on top
> of that, adjust the machine version for the compat properties from 10.0
> to the previous, 9.2, machine type.
> 
> This is what this change does.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> Note1: this is an alternative to reverting the two changes (c10.0)
> from the 10.0.x branch.  If accepted, this will be the first time
> in history when we modify machine properties retrospectively (or
> I think so, maybe there were other case like this already).
> 
> Note2: I still don't understand the implications of this migration
> stuff, - what exactly is broken now and what will be broken if this
> change is accepted, or if (c10.0) are reverted.  We've quite a matrix
> here:
> 
>   10.0.3 and before
>   10.0.4, 10.0.5 (with c10.0 applied)
>   10.0.6 and up (with the fix, either revert of (c10.0) or with 2 fixups on top)
>   10.1.1 and before (before (f) is applied)
>   10.1.2 and up (with (f) applied and maybe with this fixup applied too)
> 
> This set is multiplied further by the number of possible machine versions
> used in particular setup - if it was -m pc-10.0 or -m pc-10.1.
> 
> We also have backwards migration but I don't care about it at this time.

Canonical initially reported migration failures between QEMU 10.0 and
10.1, so their 10.0 build lacked the original two fixups.

Adding the compat option to pc_compat_9_2 can help stable v10.0.[4,5],
but Canonical's case will still fail.

I think that if Canonical officially adopts v10.0.[0-3] and hasn't used
v10.0.[4,5], reverting might be a more viable option. If they plan to
use v10.0.[4,5], then the current solution is preferable. Understanding
Canonical's v10.0 status can help evaluate the impact of different
options.

Regards,
Zhao

> Note3: It'd be best if we can release a fixed set of versions sooner,
> so it's finally known which combination is broken for migration and
> in which way.
> 
> Note4: due to my lack of understanding of the brokeness and its severity,
> I can't decide which way to go from here.  It'd be really nice if I knew
> at least, like, 'a->b: dies at migration; c->d: migration succeeds, but
> some OSes might start misbehaving due to changed CPU properties' stuff about
> the above matrix, - this way, it will be possible to make a better decision.
> 
> Thanks, and sorry for the breakage and the long post.
> 
>  hw/i386/pc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4d6bcbb846..40fb12a3d2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -87,12 +87,13 @@ const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
>  GlobalProperty pc_compat_10_0[] = {
>      { TYPE_X86_CPU, "x-consistent-cache", "false" },
>      { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
> -    { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
> -    { TYPE_X86_CPU, "x-pdcm-on-even-without-pmu", "true" },
>  };
>  const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
>  
> -GlobalProperty pc_compat_9_2[] = {};
> +GlobalProperty pc_compat_9_2[] = {
> +    { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
> +    { TYPE_X86_CPU, "x-pdcm-on-even-without-pmu", "true" },
> +};
>  const size_t pc_compat_9_2_len = G_N_ELEMENTS(pc_compat_9_2);
>  
>  GlobalProperty pc_compat_9_1[] = {
> -- 
> 2.47.3
> 

