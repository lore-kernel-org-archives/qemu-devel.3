Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62528C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 10:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZjA-0003QU-Jy; Wed, 24 Apr 2024 06:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzZj7-0003Pj-Mc
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:19:45 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzZj4-0003fs-Us
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713953983; x=1745489983;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ro8LJdgZqyCdBFIoBx/EtjaSCPEmCl/nrm9NUdz+RfE=;
 b=FDvfDHhhNcsSVRiT47Ca/9+hoJwo/Zm7uXF1tOTvzvk5lruLbwMW++h5
 zcOKrS3UdfXpK1thx5LJWZQSnwb90skSnnU+t5Qr4zgmfp+lq4GoyoV39
 Zo8B1gFdZNnw//YeGBqU1L+LFnw8r/BUJlWiGDhr0XZMHHTP/UNYrS/qi
 0CSL9HP2ayDzV/TxHTKP5XA8m83bZ1SQN6ixkz8JQYL7H+/YZEZRpMXeQ
 lNrXUGNFQsJAUsa50ptXbLgVGYAtaZyN34qu+Up+sR6gieqjZ9a6sZ5h4
 M0+sMG8nX5f+pakiQYj8v7gsGLVxTGxntAsUCF63sN+CQPVnzdBAJmQeN A==;
X-CSE-ConnectionGUID: 33GR64v8TZSLhfdmmcDZzg==
X-CSE-MsgGUID: 5yjhA3NITTiJvfyMWdsXFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27032264"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="27032264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 03:19:40 -0700
X-CSE-ConnectionGUID: cNB1Y3tgQZC1OhIlSs1w6A==
X-CSE-MsgGUID: 7qPVLuibTjOUwVDbsuRCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="29305819"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 24 Apr 2024 03:19:37 -0700
Date: Wed, 24 Apr 2024 18:33:43 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
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
Message-ID: <ZijgB1Aocksr+ec9@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi maintainers,

Ping. Do you like this diea?

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

