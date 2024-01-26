Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27804C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO6W-0000Zj-6b; Fri, 26 Jan 2024 10:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO6T-0000XQ-O5; Fri, 26 Jan 2024 10:26:49 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO6R-0004ty-IV; Fri, 26 Jan 2024 10:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706282807; x=1737818807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ep4K5ToInF5CUDMsZrxUjxi6IBAbjApaSmNCYxPrLhs=;
 b=b0C2LuohOj0+SHnB81nqIWi2NHXACtwHhK9WK/as/y+2l4FnonKwPED+
 MJ0XZq9lGlp1nqDjm0msop6pbqTyVGmRUF701CYwJNjPx1+FR0nefysoE
 XRVVxp/QAVIVJTlL3ZYD/8+HJqcodleVbkejl8hxkKYrNvQFXizYn25eX
 gXVVxIXJUbtbjW+nm6e1l5gBC3+t2q5wjbohoTPThjVv/3tG5vUgW4HwU
 K0EdK8w7sNg/PUpXwQJX8vlDdHJefEkaqIB+2KKEjGMgocA0P76+cHDsh
 SWcBnkCM2KKcBTkkT/cId9ig3g1QhDvOkf4yJqw0QMV8HJ9/p1I+C5A/o Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402152702"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="402152702"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857423436"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="857423436"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 07:26:41 -0800
Date: Fri, 26 Jan 2024 23:39:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 04/10] aspeed: Clean up includes
Message-ID: <ZbPSQUQ2UXhLQbRN@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-5-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.55.52.115; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 04:34:02PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:02 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 04/10] aspeed: Clean up includes
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
>  hw/arm/aspeed_eeprom.h     | 1 -
>  tests/qtest/qtest_aspeed.h | 2 --
>  hw/arm/aspeed_eeprom.c     | 1 +
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> index bbf9e54365b..f08c16ef506 100644
> --- a/hw/arm/aspeed_eeprom.h
> +++ b/hw/arm/aspeed_eeprom.h
> @@ -7,7 +7,6 @@
>  #ifndef ASPEED_EEPROM_H
>  #define ASPEED_EEPROM_H
>  
> -#include "qemu/osdep.h"
>  
>  extern const uint8_t tiogapass_bmc_fruid[];
>  extern const size_t tiogapass_bmc_fruid_len;
> diff --git a/tests/qtest/qtest_aspeed.h b/tests/qtest/qtest_aspeed.h
> index 235dfaa186a..d35b0c7cba5 100644
> --- a/tests/qtest/qtest_aspeed.h
> +++ b/tests/qtest/qtest_aspeed.h
> @@ -12,8 +12,6 @@
>  #ifndef QTEST_ASPEED_H
>  #define QTEST_ASPEED_H
>  
> -#include <stdint.h>
> -
>  #include "libqtest.h"
>  
>  #define AST2600_ASPEED_I2C_BASE_ADDR 0x1e78a000
> diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> index ace5266cec9..daa3d329d10 100644
> --- a/hw/arm/aspeed_eeprom.c
> +++ b/hw/arm/aspeed_eeprom.c
> @@ -4,6 +4,7 @@
>   * SPDX-License-Identifier: GPL-2.0-only
>   */
>  
> +#include "qemu/osdep.h"

Just a question, as the code style, should we add a blank line after
this header?

>  #include "aspeed_eeprom.h"
>  
>  /* Tiogapass BMC FRU */
> -- 
> 2.34.1
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



