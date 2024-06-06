Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D6EC27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF98Q-0006aO-DZ; Thu, 06 Jun 2024 05:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF98N-0006YB-Rn
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:10:12 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF98L-0002Be-Om
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717665010; x=1749201010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eGjSDJFtFiOdUgyuzxIYjRn+S7wXr14xrMosiBvN5vM=;
 b=J2Hn1SjbQ/1d9LUFUOpVM2AjSGna5LbeP75YHj1U6wFmkzS1gAbyAJzL
 ffd1uKtc5F4pK/ugNx9HDRAzKhSFnXLvvUx7blfV7qYEZGZHnRIXrBTIr
 669eOSC3lynzIz7Yxw1tlNFEUb5pxR8m9eaXTEuY8VC/R9e3FTOLQB63R
 9A2u3UY4vCItMKsCKFsT4xvK4G2TQQ5GA3zpGqqS5XtIFMCO29wVgnzOI
 3W+uOGnJIPRkjJjyDMYnmf0JsXJPt3sHf6DlyHjLAfPhePaYkv4MvEEVG
 +qBbrE0eEAPRSue/wVHsHk51TCV+d5gZ4RxvZFU/zmN7lBo4nrjdL6W5i g==;
X-CSE-ConnectionGUID: map/oZaWSGedczyh27WebQ==
X-CSE-MsgGUID: 0OvnZu6yQNCKA/gLSEQ/kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24890291"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="24890291"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 02:10:06 -0700
X-CSE-ConnectionGUID: U1p9oq3aSt2+r+EWMjdTWQ==
X-CSE-MsgGUID: G5wjL19rTEWp1zdCCs+q6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="42839079"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 06 Jun 2024 02:10:05 -0700
Date: Thu, 6 Jun 2024 17:25:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
 outdated comments
Message-ID: <ZmGAi4j+IxZgNShC@intel.com>
References: <20240506085153.2834841-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506085153.2834841-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Just a ping for this cleanup series.

Thanks,
Zhao

On Mon, May 06, 2024 at 04:51:47PM +0800, Zhao Liu wrote:
> Date: Mon, 6 May 2024 16:51:47 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and
>  outdated comments
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This is my v2 cleanup series. Compared with v1 [1], only tags (R/b, S/b)
> updates, and a typo fix, no code change.
> 
> This series picks cleanup from my previous kvmclock [2] (as other
> renaming attempts were temporarily put on hold).
> 
> In addition, this series also include the cleanup on a historically
> workaround and recent comment of coco interface [3].
> 
> Avoiding the fragmentation of these misc cleanups, I consolidated them
> all in one series and was able to tackle them in one go!
> 
> [1]: https://lore.kernel.org/qemu-devel/20240426100716.2111688-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (6):
>   target/i386/kvm: Add feature bit definitions for KVM CPUID
>   target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>     MSR_KVM_SYSTEM_TIME definitions
>   target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
>   target/i386/kvm: Save/load MSRs of kvmclock2
>     (KVM_FEATURE_CLOCKSOURCE2)
>   target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
>   target/i386/confidential-guest: Fix comment of
>     x86_confidential_guest_kvm_type()
> 
>  hw/i386/kvm/clock.c              |  5 +--
>  target/i386/confidential-guest.h |  2 +-
>  target/i386/cpu.h                | 25 +++++++++++++
>  target/i386/kvm/kvm.c            | 63 +++++++++++++++++++-------------
>  4 files changed, 66 insertions(+), 29 deletions(-)
> 
> -- 
> 2.34.1
> 

