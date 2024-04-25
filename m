Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 13:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzz3X-0004Mj-St; Thu, 25 Apr 2024 09:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzz3V-0004MV-Vf
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:22:30 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rzz3S-0001gT-FQ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714051346; x=1745587346;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1yI1AmeOggJ3cHhFUvziR4XRUExHRkUgkfAFK+a/8B8=;
 b=IObXmK1ptl6OsVSZ2fL85hCbQFr37fPkvAbtaQ4XLi5cVwSf2D2JMZW0
 Pkv+DpE2RJ0Oq6aCjMW7wlp45o0bsy7nM/2U3zHItLbtya3necnDt+oOL
 ztaoBwZA6jbR9Yi8YXwOR2o3oB0NZa1BSwh4kJKfXXpZukerrRTy9PlaN
 86pbsyAsjPBG/cl/XoSiULIh4zD8QoZs4uN0ch+9JdXWnfFHQHnXL2Bt8
 2uswNrzZ5k3atBkCINoU3oMb9IXS/6OkT0VeYsOa6qWBzvZlvKgfNO/bW
 Ip/uOPsv5ZLyT+LLbYjU+VdcvgWv0bxWhOgH8Z5VPA+CfV4RclVUzDVEk A==;
X-CSE-ConnectionGUID: T4h+2SguTw+jKhXiEgqXzg==
X-CSE-MsgGUID: 7nQJGPqZSLeMkZW8AfL0ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10272208"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="10272208"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 06:22:20 -0700
X-CSE-ConnectionGUID: Jrjz/c8KR+O0UnUDjsYFag==
X-CSE-MsgGUID: pUqp5B0GQniwGLarYNEKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="24942598"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 25 Apr 2024 06:22:17 -0700
Date: Thu, 25 Apr 2024 21:36:24 +0800
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
Message-ID: <ZipcWGbYR2KCfmxp@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
 <fb252e78-2e71-4422-9499-9eac69102eec@intel.com>
 <ZioDhpYUOEdGbWgE@intel.com>
 <eb5cfa25-6490-4b8d-8552-4be2662d15d2@intel.com>
 <ZiowbFCZ75LOgBMC@intel.com>
 <6ee5cb90-d299-4977-8a2f-529f78dc3913@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee5cb90-d299-4977-8a2f-529f78dc3913@intel.com>
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

On Thu, Apr 25, 2024 at 08:04:46PM +0800, Xiaoyao Li wrote:
> Date: Thu, 25 Apr 2024 20:04:46 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
>  feature name
> 
> On 4/25/2024 6:29 PM, Zhao Liu wrote:
> > On Thu, Apr 25, 2024 at 04:40:10PM +0800, Xiaoyao Li wrote:
> > > Date: Thu, 25 Apr 2024 16:40:10 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
> > >   feature name
> > > 
> > > On 4/25/2024 3:17 PM, Zhao Liu wrote:
> > > > Hi Xiaoyao,
> > > > 
> > > > On Wed, Apr 24, 2024 at 11:57:11PM +0800, Xiaoyao Li wrote:
> > > > > Date: Wed, 24 Apr 2024 23:57:11 +0800
> > > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
> > > > >    feature name
> > > > > 
> > > > > On 3/29/2024 6:19 PM, Zhao Liu wrote:
> > > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > > 
> > > > > > Hi list,
> > > > > > 
> > > > > > This series is based on Paolo's guest_phys_bits patchset [1].
> > > > > > 
> > > > > > Currently, the old and new kvmclocks have the same feature name
> > > > > > "kvmclock" in FeatureWordInfo[FEAT_KVM].
> > > > > > 
> > > > > > When I tried to dig into the history of this unusual naming and fix it,
> > > > > > I realized that Tim was already trying to rename it, so I picked up his
> > > > > > renaming patch [2] (with a new commit message and other minor changes).
> > > > > > 
> > > > > > 13 years age, the same name was introduced in [3], and its main purpose
> > > > > > is to make it easy for users to enable/disable 2 kvmclocks. Then, in
> > > > > > 2012, Don tried to rename the new kvmclock, but the follow-up did not
> > > > > > address Igor and Eduardo's comments about compatibility.
> > > > > > 
> > > > > > Tim [2], not long ago, and I just now, were both puzzled by the naming
> > > > > > one after the other.
> > > > > 
> > > > > The commit message of [3] said the reason clearly:
> > > > > 
> > > > >     When we tweak flags involving this value - specially when we use "-",
> > > > >     we have to act on both.
> > > > > 
> > > > > So you are trying to change it to "when people want to disable kvmclock,
> > > > > they need to use '-kvmclock,-kvmclock2' instead of '-kvmclock'"
> > > > > 
> > > > > IMHO, I prefer existing code and I don't see much value of differentiating
> > > > > them. If the current code puzzles you, then we can add comment to explain.
> > > > 
> > > > It's enough to just enable kvmclock2 for Guest; kvmclock (old) is
> > > > redundant in the presence of kvmclock2.
> > > > 
> > > > So operating both feature bits at the same time is not a reasonable
> > > > choice, we should only keep kvmclock2 for Guest. It's possible because
> > > > the oldest linux (v4.5) which QEMU i386 supports has kvmclock2.
> > > 
> > > who said the oldest Linux QEMU supports is from 4.5? what about 2.x kernel?
> > 
> > For Host (docs/system/target-i386.rst).
> > 
> > > Besides, not only the Linux guest, whatever guest OS is, it will be broken
> > > if the guest is using kvmclock and QEMU starts to drop support of kvmclock.
> > 
> > I'm not aware of any minimum version requirements for Guest supported
> > by KVM, but there are no commitment.
> 
> the common commitment is at least keeping backwards compatibility.
> 
> > > So, again, hard NAK to drop the support of kvmclock. It breaks existing
> > > guests that use kvmclock. You cannot force people to upgrade their existing
> > > VMs to use kvmclock2 instead of kvmclock.
> > 
> > I agree, legacy kvmclock can be left out, if the old kernel does not
> > support kvmclock2 and strongly requires kvmclock, it can be enabled
> > using 9.1 and earlier machines or legacy-kvmclock, as long as Host still
> > supports it.
> > 
> > What's the gap in handling it this way? especially considering that
> > kvmclock2 was introduced in v2.6.35, and earlier kernels are no longer
> > maintained. The availability of the PV feature requires compatibility
> > for both Host and Guest.
> > 
> > Anyway, the above discussion here is about future plans, and this series
> > does not prevent any Guest from ignoring kvmclock2 in favor of kvmclock.
> > 
> > What this series is doing, i.e. separating the current two kvmclock and
> > ensuring CPUID compatibility via legacy-kvmclock, could balance the
> > compatibility requirements of the ancient (unmaintained kernel) with
> > the need for future feature changes.
> 
> You introduce a user-visible change that people need to use
> "-kvmclock,-kvmclock2" to totally disable kvmclock.
> 
> The only difference between kvmclock and kvmclock2 is the MSR index. And
> from users' perspective, they don't care this difference. The existing usage
> is simple. When I want kvmclock, use "+kvmclock". When I don't want it, use
> "-kvmclock".
> 
> You are complicating things and I don't see a strong reason that we have to
> do it.
>

Okay, only when old kvmclock deprecation occurs can the values (of
renaming) be recognized, then I'll hold the renamed patches for now and
only keep some of the other cleanups.

Thanks for your review,

-Zhao


