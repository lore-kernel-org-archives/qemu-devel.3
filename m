Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18389E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLp-0007cC-7h; Wed, 18 Dec 2024 10:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwLm-0007bJ-HL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:38 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwLd-0006SJ-G4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734537149; x=1766073149;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xYWUY6FUMgKVBTt036jB/3WZ6VA/zqwqAeU/dvEoRC4=;
 b=LDKstJp9JaQOm3hPUtFdwkXuLD7qzhGdqunfUBz89AfpWdhZMkBANpRW
 c9esEC3nEdNGoy+eAPqSoljX/75myPFac26DxSjNY9afAPtOktIQsY0nF
 P5zxcJnbgqv9jRqXYa5KFL1mML32xzNM3p+JB8IeGmqPFWDDdJeKtqnja
 tC/AxjRmkDTVtv1FmYQUSnihQwH8gjp6cgE4O7tbc71mdT76Z+1jsz6dM
 +ictaUZy1rJEklKEUf9ucl8i8lUZn2wDVg1g2z2StnBI7xTPU4KgUSxSs
 x6d5IIu7EjsE/016Mzf861VBG/WjVJsVg7Bn/QjXly32HG2R3ohDG+5zP g==;
X-CSE-ConnectionGUID: XEdHfkbFRDCdw+JnL50thg==
X-CSE-MsgGUID: 3xCcR9LcS3+eKpHwZrE7IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52545640"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; d="scan'208";a="52545640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 07:52:20 -0800
X-CSE-ConnectionGUID: 0ly9LiB0QR6pyWIDjIZd9Q==
X-CSE-MsgGUID: NkUpujlVQWSjE1Jjly+1zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; d="scan'208";a="98459076"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 18 Dec 2024 07:52:19 -0800
Date: Thu, 19 Dec 2024 00:10:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/11] i386: miscellaneous cleanup
Message-ID: <Z2L0E1tTCRdv9z6G@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A kindly ping.

Thanks,
Zhao

On Wed, Nov 06, 2024 at 11:07:17AM +0800, Zhao Liu wrote:
> Date: Wed, 6 Nov 2024 11:07:17 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v5 00/11] i386: miscellaneous cleanup
> X-Mailer: git-send-email 2.34.1
> 
> Hi Paolo and all,
> 
> Is it necessary to include the first patch (AVX10 cleanup/fix) in v9.2?
> 
> Others are for v10.0.
> 
> Compared with v4 [1],
>  * patch 1 (AVX10 fix) and patch 9 (RAPL cleanup) are newly added.
>  * rebased on commit 9a7b0a8618b1 ("Merge tag 'pull-aspeed-20241104' of
>    https://github.com/legoater/qemu into staging").
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
> [1]: https://lore.kernel.org/qemu-devel/20240716161015.263031-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (11):
>   i386/cpu: Mark avx10_version filtered when prefix is NULL
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
>   target/i386/kvm: Return -1 when kvm_msr_energy_thread_init() fails
>   target/i386/kvm: Clean up error handling in kvm_arch_init()
>   target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
>     KVM_MSR_FILTER_MAX_RANGES
> 
>  hw/i386/kvm/clock.c              |   5 +-
>  target/i386/confidential-guest.h |   2 +-
>  target/i386/cpu.c                |   6 +-
>  target/i386/cpu.h                |  25 ++++
>  target/i386/kvm/kvm.c            | 211 +++++++++++++++++--------------
>  5 files changed, 145 insertions(+), 104 deletions(-)
> 
> -- 
> 2.34.1
> 

