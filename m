Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3FC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 06:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgB4-00052i-An; Wed, 21 Feb 2024 01:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcgB1-00050l-QF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:33:55 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcgAz-000073-4b
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708497233; x=1740033233;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JIJqq8etKgBFDk+nUooig/25yql7LCBCLbbx9r1h6+k=;
 b=BKzxMxsp7TAhx9Z5PgFMbJBFv/k2DWpA9GRA0d9oRdzL5vJ2hGbLpDYW
 dKN/qHFDpSn3BrAgwz/yVSiqMdaqWxbc4wJ9vtSr8885HxKq2C8T6ghAD
 TIaUCCrFuji5Ocsa2qcSlMPFS4r/aLS1rAiBGnoAseKNc05VvocfgeoyM
 tV96E+MCDfPwA0ifo1KpG9uYvlbIDGSq/S5M4n90/2CeaTsSzHkkWvDDd
 +Kk+8m2d2DHO25+1tEghe1pW/RxdligVwoYfMUocIqZoSxWZ/eZCxEY1w
 Ov/k0Axv4N9B/c3fCPVTyYs8EMlv75XDT8uQ8YGK2PYkN5HMnUzwIGORI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2778524"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2778524"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 22:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5341712"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 22:33:48 -0800
Date: Wed, 21 Feb 2024 14:47:27 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology
 test cases
Message-ID: <ZdWcf0pC6S9P/9FY@intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
 <ZbdyEDhz/pjuZNVE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbdyEDhz/pjuZNVE@intel.com>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

Could you pls help me review this series?

...Except you, I'm not sure the other machine core maintainers will
review this.

If this series is acceptable, next I can add module level test case,
cache topology test case and more clean up based on this.

Thanks,
Zhao

On Mon, Jan 29, 2024 at 05:38:24PM +0800, Zhao Liu wrote:
> Date: Mon, 29 Jan 2024 17:38:24 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: Re: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology
>  test cases
> 
> Hi Philippe,
> 
> A kindly ping.
> 
> Thanks,
> Zhao
> 
> On Thu, Jan 18, 2024 at 10:48:49PM +0800, Zhao Liu wrote:
> > Date: Thu, 18 Jan 2024 22:48:49 +0800
> > From: Zhao Liu <zhao1.liu@linux.intel.com>
> > Subject: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology
> >  test cases
> > X-Mailer: git-send-email 2.34.1
> > 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > Currently, test-smp-parse lacks the following cases:
> > * The case to cover drawer and book parameters parsing in -smp.
> > * The case to cover the full topology (with total 7 levels) to ensure
> >   that the topology-related calculations are correct.
> > * The case to check smp_props.has_clusters of MachineClass.
> > 
> > Thus, add the above cases to improve test coverage.
> > 
> > In addition, people is trying to bump max_cpus to 4096 for PC machine
> > [1]. Without considering other changes, it's only a matter of time
> > before the maximum CPUs is raised. Therefore, aslo bump max_cpus to 4096
> > in -smp related test cases as a start.
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20231208122611.32311-1-anisinha@redhat.com/
> > 
> > Regards,
> > Zhao
> > 
> > ---
> > Zhao Liu (8):
> >   tests/unit/test-smp-parse.c: Use CPU number macros in invalid topology
> >     case
> >   tests/unit/test-smp-parse.c: Bump max_cpus to 4096
> >   tests/unit/test-smp-parse.c: Make test cases aware of the book/drawer
> >   tests/unit/test-smp-parse.c: Test "books" parameter in -smp
> >   tests/unit/test-smp-parse.c: Test "drawers" parameter in -smp
> >   tests/unit/test-smp-parse.c: Test "drawers" and "books" combination
> >     case
> >   tests/unit/test-smp-parse.c: Test the full 7-levels topology hierarchy
> >   tests/unit/test-smp-parse.c: Test smp_props.has_clusters
> > 
> >  tests/unit/test-smp-parse.c | 515 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 494 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 

