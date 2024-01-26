Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CCBC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOB8-0007rx-5s; Fri, 26 Jan 2024 10:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTOAg-0007OO-KC; Fri, 26 Jan 2024 10:31:15 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTOAd-0005gN-Dw; Fri, 26 Jan 2024 10:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706283067; x=1737819067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aKiL4StpDEzJ4gLiTB/uDaZOtIkGQVvH4PPWFRsb2PM=;
 b=hI+UMz012Mw6PtQvBdKtbqFrsJ/j6XVSuRDJzMQgefvhhfB2w1E4RI3/
 eO4OFVthUfws6wrm4j2Sv/pyQrT1+hhhanuHHFCbXnGf26Ord779AjiFg
 0SRujlLNoW/fEZdmYyfj474MkD9fps7QuGZF84+R1zsa+XKOfoyf5tsVo
 e3c0kJvPW6mUkXAYXq7R4uHbORyYV7DtEep++Sr1DIbkG/Nz0+cvoMeth
 cAR9yDgCzqRq5lwPV7tjyMnNdU/+cb9UTKPPJEBTqCznUD85mirPUs3dy
 0yt2wrjqwEgBtjBaddzcnwQrKR8mIjUewe4vc81kndn3WrSGLtq2eL1sW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16024520"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="16024520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:31:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="28859131"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 26 Jan 2024 07:31:04 -0800
Date: Fri, 26 Jan 2024 23:44:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 03/10] disas/riscv: Clean up includes
Message-ID: <ZbPTRxcookQdHSW0@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-4-peter.maydell@linaro.org>
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

On Thu, Jan 25, 2024 at 04:34:01PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:01 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 03/10] disas/riscv: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git disas/riscv disas/riscv*[ch]
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
>  disas/riscv.h          | 1 -
>  disas/riscv-xthead.c   | 1 +
>  disas/riscv-xventana.c | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 19e5ed2ce63..16a08e4895c 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -7,7 +7,6 @@
>  #ifndef DISAS_RISCV_H
>  #define DISAS_RISCV_H
>  
> -#include "qemu/osdep.h"
>  #include "target/riscv/cpu_cfg.h"
>  
>  /* types */
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index 99da679d16c..fcca326d1c3 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -4,6 +4,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include "qemu/osdep.h"
>  #include "disas/riscv.h"
>  #include "disas/riscv-xthead.h"
>  
> diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
> index a0224d1fb31..cd694f15f32 100644
> --- a/disas/riscv-xventana.c
> +++ b/disas/riscv-xventana.c
> @@ -4,6 +4,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include "qemu/osdep.h"
>  #include "disas/riscv.h"
>  #include "disas/riscv-xventana.h"
>  
> -- 
> 2.34.1
> 
> 

