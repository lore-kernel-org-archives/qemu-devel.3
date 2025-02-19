Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6481CC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfcL-0003Rq-Ma; Wed, 19 Feb 2025 03:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkfcJ-0003RL-1g
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:39:39 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkfcG-0005rq-6I
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739954376; x=1771490376;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0YMoMndJuWKKyb7v6FgnrYSG+SGFwDrJuHUS/mMRlTg=;
 b=BAreybdeqbFSRMFUlv5d5FfaiXufKuFcPNZiG8/gvjTjN2hb+qjEe51W
 TJYyF/1cngYZYxEL57bC89N3AEOtmXCacTVDhFQa76lMLxwMtORDLxc3U
 caB11AZAltDytIRXfnrwukm7+AnMCTYV9+OTY9Ve19iFSDlXSsNvImrWG
 bNNv6woEwmKc21DybRuSJCT8py3pAtq1j1v/60V/8g7zHO4WB8f6eRPdG
 cBD7Ow1RPCih4a4itz5Trhnv9e91/s6Q5wk/XlMwEM6JXQb164TBxWV2R
 vCg9SLDaMHzjjlMOfguI5nSwmRA10VJ5tNPghVd+uLTRAgQKrmbA1CZFN Q==;
X-CSE-ConnectionGUID: BiYHYWJKQUqnXL1stFD/+g==
X-CSE-MsgGUID: zKG8ybklRQOwQNZFLhnpXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51299259"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="51299259"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:39:33 -0800
X-CSE-ConnectionGUID: adEyG1G2RVmLADIDWYWipQ==
X-CSE-MsgGUID: IfAHvtMlRIm7RQS8p4Cruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115552413"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 19 Feb 2025 00:39:32 -0800
Date: Wed, 19 Feb 2025 16:59:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
Message-ID: <Z7WdWiSEiVTyyAhF@intel.com>
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
 <Z6R+/R66Gs2uNBez@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6R+/R66Gs2uNBez@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

Hi Paolo,

A gentle poke. I plan to add cache models for Intel CPUs and extend
this smp_cache interface after this series. :-)

(The 1st patch of general machine has been picked by Phili.)

Thanks,
Zhao

> > Alireza Sanaee (1):
> >   i386/cpu: add has_caches flag to check smp_cache configuration
> > 
> > Zhao Liu (4):
> >   hw/core/machine: Reject thread level cache
> >   i386/cpu: Support module level cache topology
> >   i386/cpu: Update cache topology with machine's configuration
> >   i386/pc: Support cache topology in -machine for PC machine
> > 
> >  hw/core/machine-smp.c |  9 ++++++
> >  hw/i386/pc.c          |  4 +++
> >  include/hw/boards.h   |  3 ++
> >  qemu-options.hx       | 30 +++++++++++++++++-
> >  target/i386/cpu.c     | 71 ++++++++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 115 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 

