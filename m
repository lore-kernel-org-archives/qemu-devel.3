Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F1C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNtP-0006d9-PM; Mon, 29 Jan 2024 04:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rUNtO-0006d1-BV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:25:26 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rUNtM-0006ty-KL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706520324; x=1738056324;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9WdcqUwjRi3wIoR35Zr6lodufDuKrUhN0sPD3ZVLcQM=;
 b=VF1BXYOYZPOMDYa4SU0YlFeQITwaWa0IEtz1BgRRooeXKK4NSBR9eACn
 2urIpbHYpgfxdlnKd94vhoePGD+gMqkR6H92+1sh1PFr6Of1rbpUSq2yh
 2/KLVtvrocKLi/yBLNSCfMQiQ/VK6oZAbfL4wIskZVQCaW1z1eUiIMu3r
 EUiiUaqMptc/H8Oc/55a1ULLeQZgyCi9q2CGN8OPjJNoxvwIbsySqwqLH
 Z0xWFBe/56SIhjCTE4WCpPO8QOzOMqBqLZZqDxt/3tpiL7ZWesZ/aq/hT
 dZHtfpwb89Wn9V5BDBsSDhrJ28gq3B3n9cO93Z5hesqBG8qxMkVQJyXFU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467164876"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="467164876"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1118881570"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="1118881570"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2024 01:25:20 -0800
Date: Mon, 29 Jan 2024 17:38:24 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology
 test cases
Message-ID: <ZbdyEDhz/pjuZNVE@intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Philippe,

A kindly ping.

Thanks,
Zhao

On Thu, Jan 18, 2024 at 10:48:49PM +0800, Zhao Liu wrote:
> Date: Thu, 18 Jan 2024 22:48:49 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology
>  test cases
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> Currently, test-smp-parse lacks the following cases:
> * The case to cover drawer and book parameters parsing in -smp.
> * The case to cover the full topology (with total 7 levels) to ensure
>   that the topology-related calculations are correct.
> * The case to check smp_props.has_clusters of MachineClass.
> 
> Thus, add the above cases to improve test coverage.
> 
> In addition, people is trying to bump max_cpus to 4096 for PC machine
> [1]. Without considering other changes, it's only a matter of time
> before the maximum CPUs is raised. Therefore, aslo bump max_cpus to 4096
> in -smp related test cases as a start.
> 
> [1]: https://lore.kernel.org/qemu-devel/20231208122611.32311-1-anisinha@redhat.com/
> 
> Regards,
> Zhao
> 
> ---
> Zhao Liu (8):
>   tests/unit/test-smp-parse.c: Use CPU number macros in invalid topology
>     case
>   tests/unit/test-smp-parse.c: Bump max_cpus to 4096
>   tests/unit/test-smp-parse.c: Make test cases aware of the book/drawer
>   tests/unit/test-smp-parse.c: Test "books" parameter in -smp
>   tests/unit/test-smp-parse.c: Test "drawers" parameter in -smp
>   tests/unit/test-smp-parse.c: Test "drawers" and "books" combination
>     case
>   tests/unit/test-smp-parse.c: Test the full 7-levels topology hierarchy
>   tests/unit/test-smp-parse.c: Test smp_props.has_clusters
> 
>  tests/unit/test-smp-parse.c | 515 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 494 insertions(+), 21 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

