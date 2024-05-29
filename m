Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BBCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJaA-0001gg-AQ; Wed, 29 May 2024 09:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJa8-0001gD-Tv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:43:08 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCJa6-0001Rd-Ux
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716990187; x=1748526187;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SCQ9nkm1ztsqBMCoum5K+Ptt4+PY7yogbkbMLMLLhxI=;
 b=iCk96TCEf4dKaJD21rpT8voxLXo48t61f9mQy7wiNwHOuPeT7nxnT+IK
 sh/s4UF06FYqNejtopNhVxjJl0XJZhaMIp/Lxfc9mzgUR8QKwyDHpXfYw
 zYDbjPgqRsTQZ5oECV4oG/k5UTEmYCsfqQs04ZNLhUcg8AyWLUJTgsYtC
 sUbMaduXMYxwae+5Gp29kZKcz+P9D4qeEi3RddFG0+uAm5quTqEsXU+kN
 cF3XAnqjg5S8+jFdRqTXBbPOt+bFP1fd3LePgyV18x4V/qMzcMmK4jF2k
 NWXh09BKo2lnVFuy3BO0sZyO8eEVXixcq6pXyKOqH8Ae/B3H5WCRl1HgC Q==;
X-CSE-ConnectionGUID: hWg0zTM3Txyl+hPyR66o4A==
X-CSE-MsgGUID: dVagklnGTp+FhDfVwR2wgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="23946917"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="23946917"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 06:43:04 -0700
X-CSE-ConnectionGUID: QTEDW32xRxe4A/GVgvYEzw==
X-CSE-MsgGUID: afC3wSa8TiaLzb+l86Vs6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="35469404"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 29 May 2024 06:43:03 -0700
Date: Wed, 29 May 2024 21:58:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
 feature name
Message-ID: <Zlc0gX0ouWmyUab9@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

Sorry to re-pick this series, is it an acceptable cleanup to separate the
current kvmclock/kvmclock2 if the old kvmclock can't be dropped?

Thanks,
Zhao

On Fri, Mar 29, 2024 at 06:19:47PM +0800, Zhao Liu wrote:
> Date: Fri, 29 Mar 2024 18:19:47 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock feature
>  name
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This series is based on Paolo's guest_phys_bits patchset [1].
> 
> Currently, the old and new kvmclocks have the same feature name
> "kvmclock" in FeatureWordInfo[FEAT_KVM].
> 
> When I tried to dig into the history of this unusual naming and fix it,
> I realized that Tim was already trying to rename it, so I picked up his
> renaming patch [2] (with a new commit message and other minor changes).
> 
> 13 years age, the same name was introduced in [3], and its main purpose
> is to make it easy for users to enable/disable 2 kvmclocks. Then, in
> 2012, Don tried to rename the new kvmclock, but the follow-up did not
> address Igor and Eduardo's comments about compatibility.
> 
> Tim [2], not long ago, and I just now, were both puzzled by the naming
> one after the other.
> 
> So, this series is to push for renaming the new kvmclock feature to
> "kvmclock2" and adding compatibility support for older machines (PC 9.0
> and older).
> 
> Finally, let's put an end to decades of doubt about this name.
> 
> 
> Next Step
> =========
> 
> This series just separates the two kvmclocks from the naming, and in
> subsequent patches I plan to stop setting kvmclock(old kcmclock) by
> default as long as KVM supports kvmclock2 (new kvmclock).
> 
> Also, try to deprecate the old kvmclock in KVM side.
> 
> [1]: https://lore.kernel.org/qemu-devel/20240325141422.1380087-1-pbonzini@redhat.com/
> [2]: https://lore.kernel.org/qemu-devel/20230908124534.25027-4-twiederh@redhat.com/
> [3]: https://lore.kernel.org/qemu-devel/1300401727-5235-3-git-send-email-glommer@redhat.com/
> [4]: https://lore.kernel.org/qemu-devel/1348171412-23669-3-git-send-email-Don@CloudSwitch.com/
> 
> Thanks and Best Regards,
> Zhao
> 
> ---
> Tim Wiederhake (1):
>   target/i386: Fix duplicated kvmclock name in FEAT_KVM
> 
> Zhao Liu (6):
>   target/i386/kvm: Add feature bit definitions for KVM CPUID
>   target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>     MSR_KVM_SYSTEM_TIME definitions
>   target/i386/kvm: Only Save/load kvmclock MSRs when kvmclock enabled
>   target/i386/kvm: Save/load MSRs of new kvmclock
>     (KVM_FEATURE_CLOCKSOURCE2)
>   target/i386/kvm: Add legacy_kvmclock cpu property
>   target/i386/kvm: Update comment in kvm_cpu_realizefn()
> 
>  hw/i386/kvm/clock.c       |  5 ++--
>  hw/i386/pc.c              |  1 +
>  target/i386/cpu.c         |  3 +-
>  target/i386/cpu.h         | 32 +++++++++++++++++++++
>  target/i386/kvm/kvm-cpu.c | 25 ++++++++++++++++-
>  target/i386/kvm/kvm.c     | 59 +++++++++++++++++++++++++--------------
>  6 files changed, 99 insertions(+), 26 deletions(-)
> 
> -- 
> 2.34.1
> 

