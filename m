Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FEBC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWQd-0005V2-CU; Mon, 26 Feb 2024 03:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWPR-0004XJ-Vu
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:32:31 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWPP-0005zE-0V
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708936343; x=1740472343;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WsTR/gAkAzlIQ57Tf6rwYKhkUCHa2v9haeK6E/saU2c=;
 b=nXtADgs2ct/qt+Arb8v7KY1h0AixT9Bjk0Z+WQj1pCtx4lyTtcdDvO9E
 fQMqv8aSRk2VL/GduMJtt6cHW5BdaPLtSSJcfFGPKl8Gn2c3Zyz4CpS+i
 6uulTSISJHP2xQludEo1Jzj+rnMRyxmZI9pD7hhHDozJEFitFUDCRBJjZ
 4xc2siue6llnlXzPsiXjXX5f7oQ5hJVzS7TEZbcFWOJVhKpjm+2AjY2i9
 k8hoUlLVaUVJ2iA8Ri0j2+Y2dAFQ1DNFVCGHu4wPJldOioQ3TqzeMwIE4
 rGEH54D5eLsPIAV8txH+YXIH7e97n1BjPNyzxNYs2OVzYQu2Yxg6uX5gg A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13849589"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13849589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11181198"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2024 00:32:19 -0800
Date: Mon, 26 Feb 2024 16:46:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] atomic.h: Reword confusing comment for qatomic_cmpxchg
Message-ID: <ZdxPyeqBPAP5hWZD@intel.com>
References: <20240223182035.1048541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223182035.1048541-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Fri, Feb 23, 2024 at 06:20:35PM +0000, Peter Maydell wrote:
> Date: Fri, 23 Feb 2024 18:20:35 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH] atomic.h: Reword confusing comment for qatomic_cmpxchg
> X-Mailer: git-send-email 2.34.1
> 
> The qatomic_cmpxchg() and qatomic_cmpxchg__nocheck() macros have
> a comment that reads:
>  Returns the eventual value, failed or not
> 
> This is somewhere between cryptic and wrong, since the value actually
> returned is the value that was in memory before the cmpxchg.  Reword
> to match how we describe these macros in atomics.rst.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index f1d3d1702a9..99110abefb3 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -202,7 +202,7 @@
>      qatomic_xchg__nocheck(ptr, i);                          \
>  })
>  
> -/* Returns the eventual value, failed or not */
> +/* Returns the old value of '*ptr' (whether the cmpxchg failed or not) */
>  #define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
>      typeof_strip_qual(*ptr) _old = (old);                               \
>      (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
> -- 
> 2.34.1
> 
> 

