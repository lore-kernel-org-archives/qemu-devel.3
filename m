Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52411C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOE2-0003CI-SI; Fri, 26 Jan 2024 10:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTODp-00037Y-A0; Fri, 26 Jan 2024 10:34:25 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTODn-0006HL-Hn; Fri, 26 Jan 2024 10:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706283263; x=1737819263;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BstrZwgM1Y+iwNJmCRHendx4Fgmy6QSeO0xSowhKAxM=;
 b=nXXtY2iz23DsWonzzj3Tni56f82Tgyb/MdQKOQd5xSK86UJGlhsN3Fmk
 YDbuRf2yCPhYuhmXhA3mqXEItTekWdY5kc+0e9w1+I4Wu2hz9jWvXXCf3
 9yUsEKUxY22Ce0g9tbDjN4QaaA3G6sI+QxA8ALjdk23zd3ch3Y07q/U2W
 766R3rws3rIyyaBo0WTRcMNQqO5cXCPRFQPKrVwADQahFOJ85YDK0Z1Vz
 GPKEG4yUjY7n0r7BNE8nRlX/ACVioLuYf35fOgTUGVJrLrieS8qIYp9Um
 BUhlTD1dlrsBlYtHw6iu4hixCFOGcbGtIZCGKkIpfPwrFePQNUce+S8WZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="23959842"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="23959842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736714844"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="736714844"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 26 Jan 2024 07:34:19 -0800
Date: Fri, 26 Jan 2024 23:47:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 10/10] misc: Clean up includes
Message-ID: <ZbPUC3KoK30WANMX@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-11-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-11-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jan 25, 2024 at 04:34:08PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:08 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 10/10] misc: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git misc net/af-xdp.c plugins/*.c audio/pwaudio.c util/userfaultfd.c
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
> These are all cases where files include things osdep already gives them.
> ---
>  audio/pwaudio.c    | 1 -
>  net/af-xdp.c       | 1 -
>  plugins/core.c     | 1 -
>  plugins/loader.c   | 1 -
>  util/userfaultfd.c | 1 -
>  5 files changed, 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3ce5f6507b4..3b14e04fbb0 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -11,7 +11,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "audio.h"
> -#include <errno.h>
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include <spa/param/audio/format-utils.h>
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 6c65028fb00..38e600703a3 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -13,7 +13,6 @@
>  
>  #include "qemu/osdep.h"
>  #include <bpf/bpf.h>
> -#include <inttypes.h>
>  #include <linux/if_link.h>
>  #include <linux/if_xdp.h>
>  #include <net/if.h>
> diff --git a/plugins/core.c b/plugins/core.c
> index 49588285dd0..ee2fa41af9e 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -27,7 +27,6 @@
>  #include "tcg/tcg.h"
>  #include "tcg/tcg-op.h"
>  #include "plugin.h"
> -#include "qemu/compiler.h"
>  
>  struct qemu_plugin_cb {
>      struct qemu_plugin_ctx *ctx;
> diff --git a/plugins/loader.c b/plugins/loader.c
> index 734c11cae04..9768b78eb6b 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -33,7 +33,6 @@
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/boards.h"
>  #endif
> -#include "qemu/compiler.h"
>  
>  #include "plugin.h"
>  
> diff --git a/util/userfaultfd.c b/util/userfaultfd.c
> index fdff4867e8b..1b2fa949d4d 100644
> --- a/util/userfaultfd.c
> +++ b/util/userfaultfd.c
> @@ -18,7 +18,6 @@
>  #include <poll.h>
>  #include <sys/syscall.h>
>  #include <sys/ioctl.h>
> -#include <fcntl.h>
>  
>  typedef enum {
>      UFFD_UNINITIALIZED = 0,
> -- 
> 2.34.1
> 
> 

