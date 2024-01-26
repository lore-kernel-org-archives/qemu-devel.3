Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD7EC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO7w-0002mw-Lz; Fri, 26 Jan 2024 10:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO7q-0002gm-Ai; Fri, 26 Jan 2024 10:28:15 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO7n-00055q-Hg; Fri, 26 Jan 2024 10:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706282891; x=1737818891;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=X6kt4bSgL+TknRdagc/Pc71ISYBv8zPogojDwB9dlQA=;
 b=IxdDhFN9Ch4I+89vGQKBAhYXOTXz6oAbGTMRlramV5HOntOXc0gA/flD
 XubTDJUsqxzEaQbAiZmq5K+pDA7EQTIj/rSef9MT2obHNRFXD28sanj+F
 V5KDogLA1Ila1KQ5P+x1/vItBKvwy3oDkCYNmZ1UbV41FVvioshLVk+fs
 /N0f91YAtEPLuT+cfkbp02lycD35AtxoH0ef4nR/b3eiI8ibLTkTlfW21
 Ze0vb+HsFQSoxeqCN4VxB5OIb/9Bqvc1NFuUrxgeT4AG75dkFn/TZ7vtm
 oHJLnsyXMe4BEVSiN2qfZttglHc9b8DkfD083it3jY5IDreIIN4G42YS6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9878839"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9878839"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118284121"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="1118284121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2024 07:28:06 -0800
Date: Fri, 26 Jan 2024 23:41:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 09/10] riscv: Clean up includes
Message-ID: <ZbPSlkzTr+VQTxqs@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-10-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-10-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jan 25, 2024 at 04:34:07PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:07 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 09/10] riscv: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git riscv target/riscv/*.[ch]
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
>  target/riscv/vector_internals.h | 1 -
>  target/riscv/vector_internals.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
> index 8133111e5f6..842765f6c16 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -19,7 +19,6 @@
>  #ifndef TARGET_RISCV_VECTOR_INTERNALS_H
>  #define TARGET_RISCV_VECTOR_INTERNALS_H
>  
> -#include "qemu/osdep.h"
>  #include "qemu/bitops.h"
>  #include "cpu.h"
>  #include "tcg/tcg-gvec-desc.h"
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 9cf5c17cdea..12f5964fbbe 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -16,6 +16,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "vector_internals.h"
>  
>  /* set agnostic elements to 1s */
> -- 
> 2.34.1
> 
> 

