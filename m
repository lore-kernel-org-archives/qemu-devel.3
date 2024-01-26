Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49161C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOCT-00015P-RH; Fri, 26 Jan 2024 10:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTOCO-0000p7-PU; Fri, 26 Jan 2024 10:32:58 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTOCM-00062j-55; Fri, 26 Jan 2024 10:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706283174; x=1737819174;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xdnt7TugAddM5NzoPI2fVh+GAXklW+s16lNhdZleJU8=;
 b=SShdiS+Ir0pcJDnGi5+GWWQlWAXiAxlxQlVM4ydA8J98ho4pMCvc1ing
 ohMhW0Ik2ZxCQv0piTK9+bq4KsdkuubQ8ZVJANGjoHkpkPKl9lo5/Ceoo
 JA+7a25ndqO3C6ZUIdKLRkrF6A0skx1Xemceg2i15ZTTiF/uIHppeiqUh
 AFM4OP6/dapmwJJzEv2i8z/qzzDDz+QobxbIooDdKgiupJOXJktMol6nE
 MEel7KxqCqx/wFBQFKSc44oZaa6jYHVBQkYDHjrwM0CxRl0VzhpqLGN24
 eh+EGV6XwlDwgRpWos9SADjg5vwLsKxQeatlTUsywk4w2HfMRMQ5hqITe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15854939"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="15854939"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2643268"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 26 Jan 2024 07:32:23 -0800
Date: Fri, 26 Jan 2024 23:45:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 02/10] hyperv: Clean up includes
Message-ID: <ZbPTlRJtPRlnDL3C@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jan 25, 2024 at 04:34:00PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:00 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 02/10] hyperv: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git hyperv hw/hyperv/*.[ch]
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
>  hw/hyperv/hv-balloon-internal.h           | 1 -
>  hw/hyperv/hv-balloon-our_range_memslots.h | 1 -
>  hw/hyperv/hv-balloon-page_range_tree.h    | 1 -
>  hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
>  hw/hyperv/hv-balloon-page_range_tree.c    | 1 +
>  hw/hyperv/hv-balloon.c                    | 1 +
>  6 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/hyperv/hv-balloon-internal.h b/hw/hyperv/hv-balloon-internal.h
> index 164c2e58253..ee53a28a266 100644
> --- a/hw/hyperv/hv-balloon-internal.h
> +++ b/hw/hyperv/hv-balloon-internal.h
> @@ -10,7 +10,6 @@
>  #ifndef HW_HYPERV_HV_BALLOON_INTERNAL_H
>  #define HW_HYPERV_HV_BALLOON_INTERNAL_H
>  
> -#include "qemu/osdep.h"
>  
>  #define HV_BALLOON_PFN_SHIFT 12
>  #define HV_BALLOON_PAGE_SIZE (1 << HV_BALLOON_PFN_SHIFT)
> diff --git a/hw/hyperv/hv-balloon-our_range_memslots.h b/hw/hyperv/hv-balloon-our_range_memslots.h
> index b6f592d34b0..df3b686bc7c 100644
> --- a/hw/hyperv/hv-balloon-our_range_memslots.h
> +++ b/hw/hyperv/hv-balloon-our_range_memslots.h
> @@ -10,7 +10,6 @@
>  #ifndef HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
>  #define HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
>  
> -#include "qemu/osdep.h"
>  
>  #include "exec/memory.h"
>  #include "qom/object.h"
> diff --git a/hw/hyperv/hv-balloon-page_range_tree.h b/hw/hyperv/hv-balloon-page_range_tree.h
> index 07a9ae0da61..333772b86d2 100644
> --- a/hw/hyperv/hv-balloon-page_range_tree.h
> +++ b/hw/hyperv/hv-balloon-page_range_tree.h
> @@ -10,7 +10,6 @@
>  #ifndef HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
>  #define HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
>  
> -#include "qemu/osdep.h"
>  
>  /* PageRange */
>  typedef struct PageRange {
> diff --git a/hw/hyperv/hv-balloon-our_range_memslots.c b/hw/hyperv/hv-balloon-our_range_memslots.c
> index 99bae870f37..1505a395cf7 100644
> --- a/hw/hyperv/hv-balloon-our_range_memslots.c
> +++ b/hw/hyperv/hv-balloon-our_range_memslots.c
> @@ -7,6 +7,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "hv-balloon-internal.h"
>  #include "hv-balloon-our_range_memslots.h"
>  #include "trace.h"
> diff --git a/hw/hyperv/hv-balloon-page_range_tree.c b/hw/hyperv/hv-balloon-page_range_tree.c
> index e178d8b413c..dfb14852f42 100644
> --- a/hw/hyperv/hv-balloon-page_range_tree.c
> +++ b/hw/hyperv/hv-balloon-page_range_tree.c
> @@ -7,6 +7,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "hv-balloon-internal.h"
>  #include "hv-balloon-page_range_tree.h"
>  
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> index 66f297c1d7e..02383657124 100644
> --- a/hw/hyperv/hv-balloon.c
> +++ b/hw/hyperv/hv-balloon.c
> @@ -7,6 +7,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "hv-balloon-internal.h"
>  
>  #include "exec/address-spaces.h"
> -- 
> 2.34.1
> 
> 

