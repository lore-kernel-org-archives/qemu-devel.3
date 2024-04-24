Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8AC07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzf01-00056b-3O; Wed, 24 Apr 2024 11:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzezs-00056L-5r
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:57:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzezp-0000ZR-Ho
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713974241; x=1745510241;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=szSvnPPOZogSbQg2l5FImdE9D+W2Mso6/U/ehpDLjtg=;
 b=izKOh63oGCKbT7myKf6mLyKKvl/DJlZfs0ngNNAZkLDeDNCuHwGD9rjw
 V1ctaV5rWyGx412KGOaJxQuoR+yKWi2R8/ObTpe6kiP5ZPmjUmr8Dk+ZB
 sXgMT28pXC1iMje7O8sr1Dn4rjsutDAM4P4i8jIDQoMb4cDFtJlo9rBQK
 GVm0OGNhmkv/xFwEYI96GZ+9xTd77RoSzrc7U5ERaelj1kxyTEe+xGoXu
 MncKuTqP2XXFrx2PpKjcBHtwEAFjxumxvOT4d7x95gwXvs6D9rCkWpGCL
 tLMR3D0fp31GUaptavTZl82e+FULR18ij6IjTDbkWBfk1u1oLe/ymN8V3 w==;
X-CSE-ConnectionGUID: 5Pbnf+5MR+mygMl4WRVKEA==
X-CSE-MsgGUID: 8RIzLh9RS+i2FpPXu/+Gcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9776172"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9776172"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:57:17 -0700
X-CSE-ConnectionGUID: sPs8qcndRmmnxNGDQsUxSw==
X-CSE-MsgGUID: DrAM4+fPRKKgQpa+TloHrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="24770849"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:57:14 -0700
Message-ID: <fb252e78-2e71-4422-9499-9eac69102eec@intel.com>
Date: Wed, 24 Apr 2024 23:57:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock feature
 name
To: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/29/2024 6:19 PM, Zhao Liu wrote:
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

The commit message of [3] said the reason clearly:

   When we tweak flags involving this value - specially when we use "-",
   we have to act on both.

So you are trying to change it to "when people want to disable kvmclock, 
they need to use '-kvmclock,-kvmclock2' instead of '-kvmclock'"

IMHO, I prefer existing code and I don't see much value of 
differentiating them. If the current code puzzles you, then we can add 
comment to explain.

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

No. It will break existing guests that use KVM_FEATURE_CLOCKSOURCE.

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
>    target/i386: Fix duplicated kvmclock name in FEAT_KVM
> 
> Zhao Liu (6):
>    target/i386/kvm: Add feature bit definitions for KVM CPUID
>    target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>      MSR_KVM_SYSTEM_TIME definitions
>    target/i386/kvm: Only Save/load kvmclock MSRs when kvmclock enabled
>    target/i386/kvm: Save/load MSRs of new kvmclock
>      (KVM_FEATURE_CLOCKSOURCE2)
>    target/i386/kvm: Add legacy_kvmclock cpu property
>    target/i386/kvm: Update comment in kvm_cpu_realizefn()
> 
>   hw/i386/kvm/clock.c       |  5 ++--
>   hw/i386/pc.c              |  1 +
>   target/i386/cpu.c         |  3 +-
>   target/i386/cpu.h         | 32 +++++++++++++++++++++
>   target/i386/kvm/kvm-cpu.c | 25 ++++++++++++++++-
>   target/i386/kvm/kvm.c     | 59 +++++++++++++++++++++++++--------------
>   6 files changed, 99 insertions(+), 26 deletions(-)
> 


