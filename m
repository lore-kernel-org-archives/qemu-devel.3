Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F312C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzt8m-0006sO-0D; Thu, 25 Apr 2024 03:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzt8g-0006s6-RR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:03:26 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzt8e-0004QO-2y
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714028604; x=1745564604;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qO4v/myxkSZo6pTKczEfEvF9d1EDa0KePzRo82nRE0k=;
 b=gP+vNWx7eB4CxlWogBrILeG2e6vA9k8jC7MLrzMPdFa3A9aiRpBmW+Sg
 k/2YWOhyg+huKEGw04LqRT+kqe8CUTfHtI9xYfUXudayOeWBrIEqLkGLA
 6TIMa9PC3+QU6TdwgzdhMNwzH9bGqo6bBbSTHKYdGr/iVzFk2y7yRaQWl
 h6I/C4zV99Uaw0815KloR/XKxACDL52fSmSEwmVqocVeVsvk87S+ij4WY
 DKbZQe0+tvb1H+jRDJWbhDSNpHuWLQZLsy4B3Bh+lMvKTzv57Kxjp6IHq
 oBYjheHqbEmzKv86m1X5+dfQWg2TYT1nXgkK1Zc5RHMS89X0u45JFDCTL g==;
X-CSE-ConnectionGUID: 5f0hTNYmTRqGET2V8L/tMw==
X-CSE-MsgGUID: 0qOWtXb8R6W9ZYtNIq4t+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13479826"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="13479826"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 00:03:21 -0700
X-CSE-ConnectionGUID: EGiMHNZBS0ebDAMq4EDJew==
X-CSE-MsgGUID: LhCxX+3GQBKq46HlzN5VnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="25590748"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 25 Apr 2024 00:03:19 -0700
Date: Thu, 25 Apr 2024 15:17:26 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
 feature name
Message-ID: <ZioDhpYUOEdGbWgE@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
 <fb252e78-2e71-4422-9499-9eac69102eec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb252e78-2e71-4422-9499-9eac69102eec@intel.com>
Received-SPF: none client-ip=198.175.65.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

Hi Xiaoyao,

On Wed, Apr 24, 2024 at 11:57:11PM +0800, Xiaoyao Li wrote:
> Date: Wed, 24 Apr 2024 23:57:11 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
>  feature name
> 
> On 3/29/2024 6:19 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > This series is based on Paolo's guest_phys_bits patchset [1].
> > 
> > Currently, the old and new kvmclocks have the same feature name
> > "kvmclock" in FeatureWordInfo[FEAT_KVM].
> > 
> > When I tried to dig into the history of this unusual naming and fix it,
> > I realized that Tim was already trying to rename it, so I picked up his
> > renaming patch [2] (with a new commit message and other minor changes).
> > 
> > 13 years age, the same name was introduced in [3], and its main purpose
> > is to make it easy for users to enable/disable 2 kvmclocks. Then, in
> > 2012, Don tried to rename the new kvmclock, but the follow-up did not
> > address Igor and Eduardo's comments about compatibility.
> > 
> > Tim [2], not long ago, and I just now, were both puzzled by the naming
> > one after the other.
> 
> The commit message of [3] said the reason clearly:
> 
>   When we tweak flags involving this value - specially when we use "-",
>   we have to act on both.
> 
> So you are trying to change it to "when people want to disable kvmclock,
> they need to use '-kvmclock,-kvmclock2' instead of '-kvmclock'"
>
> IMHO, I prefer existing code and I don't see much value of differentiating
> them. If the current code puzzles you, then we can add comment to explain.

It's enough to just enable kvmclock2 for Guest; kvmclock (old) is
redundant in the presence of kvmclock2.

So operating both feature bits at the same time is not a reasonable
choice, we should only keep kvmclock2 for Guest. It's possible because
the oldest linux (v4.5) which QEMU i386 supports has kvmclock2.

Pls see:
https://elixir.bootlin.com/linux/v4.5/source/arch/x86/include/uapi/asm/kvm_para.h#L22

With this in mind, I'm trying to implement a silky smooth transition to
"only kcmclock2 support".

This series is now separating kvmclock and kvmclock2, and then I plan to
go to the KVM side and deprecate kvmclock2, and then finally remove
kvmclock (old) in QEMU. Separating the two features makes the process
clearer.

Continuing to use the same name equally would have silently caused the
CPUID to change on the Guest side, which would have hurt compatibility
as well.

> > So, this series is to push for renaming the new kvmclock feature to
> > "kvmclock2" and adding compatibility support for older machines (PC 9.0
> > and older).
> > 
> > Finally, let's put an end to decades of doubt about this name.
> > 
> > 
> > Next Step
> > =========
> > 
> > This series just separates the two kvmclocks from the naming, and in
> > subsequent patches I plan to stop setting kvmclock(old kcmclock) by
> > default as long as KVM supports kvmclock2 (new kvmclock).
> 
> No. It will break existing guests that use KVM_FEATURE_CLOCKSOURCE.

Please refer to my elaboration on v4.5 above, where kvmclock2 is
available, it should be used in priority.

> > Also, try to deprecate the old kvmclock in KVM side.
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20240325141422.1380087-1-pbonzini@redhat.com/
> > [2]: https://lore.kernel.org/qemu-devel/20230908124534.25027-4-twiederh@redhat.com/
> > [3]: https://lore.kernel.org/qemu-devel/1300401727-5235-3-git-send-email-glommer@redhat.com/
> > [4]: https://lore.kernel.org/qemu-devel/1348171412-23669-3-git-send-email-Don@CloudSwitch.com/

Thanks,
Zhao



