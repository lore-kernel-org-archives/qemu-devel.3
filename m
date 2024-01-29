Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65676C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNrE-0005xz-AR; Mon, 29 Jan 2024 04:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rUNrB-0005xf-0U
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:23:09 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rUNr8-0006RT-7d
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706520186; x=1738056186;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kTLO3Eni/9TEzZcTjfgf+2qoJEzSnC+sGPOsJt/kFbA=;
 b=LIqtXv6DcRIQeuWOtoUM0+0kbTkRseFnxhoihcePMrIU21XEGd/nXzoV
 PH3ZSxaKBYp+s3eHpk/u9GpHN3hHzH1STu5TWdsByPpsmqQ6pxnSK1Sfx
 0EOZ6FelAViJnNsdG9fJ/21MZMquqkTJ9JJUwAw+lD/zJg8dtbUH7rkjf
 MBP2bQFivGVzQq1maZKNFtXaeBDXeKGRbHWhzEVXR3GiBHr1c4I63/Vch
 RZ3/U8uXuKsaPMtwFIF+hbdQTDf5y7n4HtZBfTbKSkQRkKeM3I5wbg01w
 qw0DjQ3OqoCfgZcJob3qmit6cF057M2gRnx2uUoSTRiYWjLLaD5Asmc/n A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10287596"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="10287596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3410654"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 29 Jan 2024 01:22:54 -0800
Date: Mon, 29 Jan 2024 17:35:58 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 0/9] hw/core: Cleanup and reorder headers
Message-ID: <ZbdxfiOaVu3U+sec@intel.com>
References: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
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

Thanks for picking the 1st patch. Could you take time for further review
on other patches?

Thanks,
Zhao

On Tue, Jan 16, 2024 at 03:46:38PM +0800, Zhao Liu wrote:
> Date: Tue, 16 Jan 2024 15:46:38 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH v2 0/9] hw/core: Cleanup and reorder headers
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Identify unused headers by full compilation (tested by "./configure" and
> then "make") and manually checking if it is a direct inclusion.
> 
> Then reorder headers in alphabetical order.
> 
> In addition, update a file entry in MAINTAINERS file.
> 
> ---
> Changelog:
> 
> v1: Per Peter and Philippe's comments in v1, keep directly included
>     headers to avoid implicit header inclusions [1].
> 
> [1]: https://lore.kernel.org/qemu-devel/06d4179f-76b8-42f0-b147-f4bc2d1f06bd@linaro.org/#t
> 
> ---
> Zhao Liu (9):
>   MAINTAINERS: Update hw/core/cpu.c entry
>   hw/core: Cleanup unused included headers in cpu-common.c
>   hw/core: Reorder included headers in cpu-common.c
>   hw/core: Reorder included headers in cpu-sysemu.c
>   hw/core: Cleanup unused included header in machine-qmp-cmds.c
>   hw/core: Reorder included header in machine.c
>   hw/core: Reorder included headers in null-machine.c
>   hw/core: Cleanup unused included headers in numa.c
>   hw/core: Reorder included headers in numa.c
> 
>  MAINTAINERS                |  3 ++-
>  hw/core/cpu-common.c       | 17 +++++++----------
>  hw/core/cpu-sysemu.c       |  3 ++-
>  hw/core/machine-qmp-cmds.c |  2 +-
>  hw/core/machine.c          | 21 +++++++++++----------
>  hw/core/null-machine.c     |  5 +++--
>  hw/core/numa.c             | 22 ++++++++++------------
>  7 files changed, 36 insertions(+), 37 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

