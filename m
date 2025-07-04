Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F65AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXd9b-0007G4-4H; Fri, 04 Jul 2025 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd9W-0007FZ-Jn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:56:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd9U-0000Zz-54
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622976; x=1783158976;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uW1nv3mKz5l0yYBOrOUKSnM1vhjZclQooiyT8V3CS5Y=;
 b=ZW5DqxzBC/5FOyv4Da6hGJidVPCNRtuS/iZ3hjXLQ2sRnM/wXtrbYyyG
 Y1YfRXeYTnat00FryjY/xOaZBIKiivQv0s/iYpIdS/N4NBr98HFn7JiSL
 P1nXWoU+CAIvAgLDTHLE9RwY4WRLEbdAbVj879Q5wgKhLfsOCfolDb5Dl
 YvNHc2Lds7G0SB01bg5cFghJlTu9qgllqtFv5Ew8L8YX0nQwF9SpxHVL6
 mMHDCVA7dICAx0DLe6emUluZf5RJL/yBICOfL7VCrV0yX3PRNoubOd6I0
 +35HrpsYcLld5LRSZdQizlP6EDdFiV/MZo0Nj1JYiRJbCt5kINWNR9CMS w==;
X-CSE-ConnectionGUID: ejpZmu6JSc+nDDmXS5hOQg==
X-CSE-MsgGUID: m4J61CNsQgaOXDleaTWNOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65306650"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="65306650"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:56:14 -0700
X-CSE-ConnectionGUID: SBAuCUhhRYmUzWsTflubQQ==
X-CSE-MsgGUID: BaFtMaN9SIeQKEYYcbwOIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154357358"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 04 Jul 2025 02:56:13 -0700
Date: Fri, 4 Jul 2025 18:17:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 22/39] accel/system: Document cpu_synchronize_state()
Message-ID: <aGeqQnAufjC9tQRC@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-23-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-23-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 03, 2025 at 07:32:28PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:28 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 22/39] accel/system: Document cpu_synchronize_state()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/system/accel-ops.h |  8 ++++++++
>  include/system/hw_accel.h  | 13 +++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


