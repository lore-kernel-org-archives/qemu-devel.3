Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B6ECD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slq60-00021m-KG; Wed, 04 Sep 2024 09:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1slq5v-000214-Rb
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:30:47 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1slq5s-0002aD-OQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725456645; x=1756992645;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=41TVB2Gs5jzmRJr75Hu5LbW3CVGlxCfcU+c4Ier+sKQ=;
 b=nPXusst2RrtwPNOqRBXHtMikF5ub8wu4UfSXVi2Z+tK+SGQJIeTCRvQh
 h9INfi2m052tkOBneAMacl0SjYrn/gQGV4gNW8MpbAqcNQmLsxGObYvKq
 1jDwfjKZ0sKznIGmljs9L6qf121lw9Cy5vuxzd1mVn8PFOtyqU47aP+t6
 7af51rFjpVTv2E91JkTXG18ZDRwCIMa3N+Vqkvvo/yRF9NYbGm0yhlAGn
 dFsmpGPxC5xSHmcgR21jJuVLLXFOcLYmCEgPTspus5np73PCYIhEZwP+R
 wfMT+1Mhk1a7txyWPCA8vFNr0ygvyT36v5xATwFa/9/npLQoMEn/DTcOQ g==;
X-CSE-ConnectionGUID: 5l1MYlwOSvyvRFwOo2vHjA==
X-CSE-MsgGUID: 1OF44ZprTfW40C86z5nj6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="46648537"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="46648537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 06:30:40 -0700
X-CSE-ConnectionGUID: CA9g3kPSQZ+7FOTst9bT6g==
X-CSE-MsgGUID: xqRfcvXbT3Wvg/0ZLZWq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="69898222"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 04 Sep 2024 06:30:38 -0700
Date: Wed, 4 Sep 2024 21:46:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 0/9] target/i386: Misc cleanup on KVM PV defs,
 outdated comments and error handling
Message-ID: <ZthkvhgLMfEfXCZ8@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Just a kindly ping.

Thanks,
Zhao

On Wed, Jul 17, 2024 at 12:10:06AM +0800, Zhao Liu wrote:
> Date: Wed, 17 Jul 2024 00:10:06 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v4 0/9] target/i386: Misc cleanup on KVM PV defs, outdated
>  comments and error handling
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This is my v4 cleanup series. Compared with v3 [1],
>  * Returned kvm_vm_ioctl() directly in kvm_install_msr_filters().
>  * Added a patch (patch 9) to clean up ARRAY_SIZE(msr_handlers).
> 
> 
> Background and Introduction
> ===========================
> 
> This series picks cleanup from my previous kvmclock [2] (as other
> renaming attempts were temporarily put on hold).
> 
> In addition, this series also include the cleanup on a historically
> workaround, recent comment of coco interface [3] and error handling
> corner cases in kvm_arch_init().
> 
> Avoiding the fragmentation of these misc cleanups, I consolidated them
> all in one series and was able to tackle them in one go!
> 
> [1]: https://lore.kernel.org/qemu-devel/20240715044955.3954304-1-zhao1.liu@intel.com/T/
> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (9):
>   target/i386/kvm: Add feature bit definitions for KVM CPUID
>   target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>     MSR_KVM_SYSTEM_TIME definitions
>   target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
>   target/i386/kvm: Save/load MSRs of kvmclock2
>     (KVM_FEATURE_CLOCKSOURCE2)
>   target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
>   target/i386/confidential-guest: Fix comment of
>     x86_confidential_guest_kvm_type()
>   target/i386/kvm: Clean up return values of MSR filter related
>     functions
>   target/i386/kvm: Clean up error handling in kvm_arch_init()
>   target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
>     KVM_MSR_FILTER_MAX_RANGES
> 
>  hw/i386/kvm/clock.c              |   5 +-
>  target/i386/confidential-guest.h |   2 +-
>  target/i386/cpu.h                |  25 +++++++
>  target/i386/kvm/kvm.c            | 113 +++++++++++++++++--------------
>  target/i386/kvm/kvm_i386.h       |   4 +-
>  5 files changed, 92 insertions(+), 57 deletions(-)
> 
> -- 
> 2.34.1
> 

