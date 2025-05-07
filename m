Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118D5C3ABBE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 03:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCVSi-0002ol-IV; Tue, 06 May 2025 23:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVSf-0002o8-TB; Tue, 06 May 2025 23:28:45 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVSd-0006I6-VY; Tue, 06 May 2025 23:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746588524; x=1778124524;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mezvLOkTGgAQ93LPJlH8izzEzWaZFRk1p+2yHiDwFJo=;
 b=YYTxfW14wlJ7T8s4fu7MBUfnDChhDRTIXz+HoK7BXfLgVA88+wvzNGl0
 X+y2JtC1p9ZC6C1izCRuI7YdQfgR2DarTnFFeSYq6AzicOgtIdVgcEKrh
 ZmR7RJkBlBgqcsGkgk+lU4YaDwXV9h6QfmSXGTniizG4BCOveCnyAYd8m
 1kVoSchNy5uFeeRg2naxLOUYRq5HQyF0Gdq/N5EF63WFB/DArVK/qI1kk
 ckJk5ItkEBBe4hfzdVUhxVc6vYg5mOFyU/1w5cpfzEKZtiX9Uzkf+Rebi
 CJQ1fIF8c+5fqpLSmchYh7qBozFuHI2FXDJd6OZ3rYXMVzpaInvb8x33a g==;
X-CSE-ConnectionGUID: rp2Sngp5QxOeiwnEQAdKug==
X-CSE-MsgGUID: X5xY1SBUQim9x2QPDwGqog==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50941998"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="50941998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 20:28:41 -0700
X-CSE-ConnectionGUID: OARX8iJES5qqgvq3pvmWmA==
X-CSE-MsgGUID: +Z02oildSlSNARXN0BJOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="173011479"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 06 May 2025 20:28:36 -0700
Date: Wed, 7 May 2025 11:49:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 11/19] hw/nvram/fw_cfg: Remove legacy
 FW_CFG_ORDER_OVERRIDE
Message-ID: <aBrYUUywuF4Ttbd/@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-12-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:38:57PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:57 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 11/19] hw/nvram/fw_cfg: Remove legacy
>  FW_CFG_ORDER_OVERRIDE
> X-Mailer: git-send-email 2.47.1
> 
> The MachineClass::legacy_fw_cfg_order boolean was only used
> by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
> removed. Remove it along with:
> 
> - FW_CFG_ORDER_OVERRIDE_* definitions
> - fw_cfg_set_order_override()
> - fw_cfg_reset_order_override()
> - fw_cfg_order[]
> - rom_set_order_override()
> - rom_reset_order_override()
> 
> Simplify CLI and pc_vga_init() / pc_nic_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/hw/boards.h       |   3 +-
>  include/hw/loader.h       |   2 -
>  include/hw/nvram/fw_cfg.h |  10 ----
>  hw/core/loader.c          |  14 -----
>  hw/i386/pc.c              |   7 +--
>  hw/nvram/fw_cfg.c         | 109 +++-----------------------------------
>  system/vl.c               |   5 --
>  7 files changed, 9 insertions(+), 141 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


