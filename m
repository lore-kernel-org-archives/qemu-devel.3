Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607DC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO8W-0003q2-En; Fri, 26 Jan 2024 10:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO8V-0003om-Mo; Fri, 26 Jan 2024 10:28:55 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO8U-00058n-13; Fri, 26 Jan 2024 10:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706282934; x=1737818934;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+ovD/oGfxB4K5wtszDrc6qT35DYU4vw2pL36d6+0Uyg=;
 b=O0czLiHPuNihgykh6OGxd6f5aSlGLdyRQRQu/QMDoHr8o0fkMjwSQQyd
 HCTi/wx7hnVciJUx3CgRgDnWH8N19Kz/Mq6FrPY2mR4ziFuqFtubgZdQ3
 5M6ieEK8xFYby1BIIS68vlYfjNOoAL+LE731PHHsiiJcoPBKY1lJ+1NKz
 CxKDxlgkgtGmFm5DWDq8a3xqDnCK7ZaIZ/vhuZc8v92u/RYdBlxvFfmtr
 aSa4ViflkWXzJhqyZoN8Sv8sdtL3re8Cy/SVtg32tqD191KIYLDETHvmU
 Z47Oyb2CFs79oU5fQT8ZWOnm0EqW2m96fegCt1xHOriJXsHhM3iowYI5H A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16024085"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="16024085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="28858589"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 26 Jan 2024 07:28:49 -0800
Date: Fri, 26 Jan 2024 23:41:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 08/10] cxl: Clean up includes
Message-ID: <ZbPSwMopXfEi0IX6@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-9-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-9-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 04:34:06PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:06 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 08/10] cxl: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes.
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>   it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>   Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/cxl/cxl-events.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index bee6dfaf148..affcf8a34dd 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -7,11 +7,9 @@
>   * COPYING file in the top-level directory.
>   */
>  
> -#include <stdint.h>
> -
>  #include "qemu/osdep.h"
> +
>  #include "qemu/bswap.h"
> -#include "qemu/typedefs.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
> -- 
> 2.34.1
> 
> 

