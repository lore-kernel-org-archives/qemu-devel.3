Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBC0C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUhrz-0005Q3-OU; Fri, 19 Jul 2024 03:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUhrx-0005I0-I0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:17:33 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUhru-0003vO-BU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721373450; x=1752909450;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/Ae4pVdiaD09KGVgieXvdPqUBGKYgjSMpkA2r7YyLfc=;
 b=nN3x/7Yj2oON1KwSfIccDJO6xpdE7pBe3vdJ0st5ZabeamrjUx2uS+Rn
 bEcudVLuwOzAa0GcSrs1jNDFrYVo6Ys/pr+25ein8xnyaXknUJn1J8QIW
 fJ5ypBFdI2QgLXYUEX9gnOv3q4H5/VTwYL3uHoBYGuJKWeNWuizfS9F47
 VKgYFREdyiMmfmI8P0oVbw8jZWBgKcnDJvRnvKbwdTxhtBMsP7oQekEOp
 uC9inD26qbSH40ratRZxcWSY9l3k3dsZq25JqcexiLSasiFX9EDotdkIK
 yKgW7Bjqj2NBOr0oQ698Es7UzOcUFYCYMzax5MXrCkgYzxg02Gx3Jou+Q w==;
X-CSE-ConnectionGUID: 0+OMJAtSTnGFcbfmsniI/w==
X-CSE-MsgGUID: hRIJE1RST9+NCkbGkMeC/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19117540"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="19117540"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 00:17:26 -0700
X-CSE-ConnectionGUID: NtdUO1JbQY2uoMG3BCuV5Q==
X-CSE-MsgGUID: GLBunO7fRq22CtIt7PUkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="51300064"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 19 Jul 2024 00:17:24 -0700
Date: Fri, 19 Jul 2024 15:33:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manish Mishra <manish.mishra@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Levon <john.levon@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>, Bob Ball <bob.ball@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: Windows 10 and 11 VMs fails to boot with SapphireRapids CPU
 definition
Message-ID: <ZpoWskY4XE/98jss@intel.com>
References: <PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Manish,

(+Paolo and Daniel)

On Thu, Jul 18, 2024 at 11:44:28AM +0000, Manish Mishra wrote:
> Date: Thu, 18 Jul 2024 11:44:28 +0000
> From: Manish Mishra <manish.mishra@nutanix.com>
> Subject: Windows 10 and 11 VMs fails to boot with SapphireRapids CPU
>  definition
> 
> Hi Everyone,
> 
> We are facing issues booting windows VMs with SapphireRapids CPU definition. This is happening in case we have multiple cores per vcpu set and the VM is a UEFI, secure boot and credential guard enabled. Till now we have observed this issue on windows 10 and 11.
> 
> 
> 
> We did some triaging around this. SapphireRapids CPU definition has raised cpuid_level to 0x20. This includes leaf V2 extended topology (0x1f). QEMU returns all zeros in case !x86_has_extended_topo()<https://github.com/qemu/qemu/blob/58ee924b97d1c0898555647a31820c5a20d55a73/target/i386/kvm/kvm.c#L1834>. As per expectation(also mentioned in https://cdrdv2-public.intel.com/775917/intel-64-architecture-processor-topology-enumeration.pdf) if guests see this it should fallback to 0x1b. Somehow windows 10 and windows 11 does not work well with this assumption and panics on boot.
> 
> 
> 
> We checked on one of the SapphireRapids node with no multi-die topology; this is how CPUID output looks like. 0x1f output is the same as 0xb.

[snip]

> We tried a workaround having 0x1f output same as 0xb in case !x86_has_extended_topo(), instead of setting all zeros. This seems to work fine. Our understanding is that current QEMU behaviour is not incorrect but still does the above mentioned workaround makes sense? 

The 0x1f was introduced from cascadelake-AP (2nd xeon) with multiple
dies, but cascadelake-SP doesn't has the 0x1f since it has only 1 die.

So from that time, QEMU's 0x1f checks for extended topology level to
determine whether to populate the 0x1f. HMM, currently, for this
all-zero 0x1f, it's valid because x86 (SDM) said "if a value entered
for CPUID.EAX is less than or equal to the maximum input value and the
leaf is not supported on that processor then 0 is returned in all the
registers."

So yes you're right, and it's actually a Windows issue, which should
check 0xb.

And you proposed to populate 0x1f by default even without die/module
should work:
 * older software still checks 0xb by default, then the newly added 0x1f
   doesn't break anything.
 * And software that follow the SDM recommendation to check 0x1f first
   by default will also benefit.

No one else has reported problems for old CPUs yet, but CPUs older than
cascadelake should disable configuration of extended topology levels to
avoid 0x1f creating compatibility issues. Of course, the current
workaround doesn't need to take that into account.

> And if we look it is the same as bare-metal so it should not be unreasonable. If so will be happy to send a patch for same.

I think it's worth doing, and I'll help you review.

You may refer to "cpuid-0xb" implementation and add the compat setting
pc_compat_9_0.

Thanks,
Zhao


