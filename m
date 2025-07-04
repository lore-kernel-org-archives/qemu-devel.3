Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA30C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcWK-0006UO-9R; Fri, 04 Jul 2025 05:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcWJ-0006T7-5e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:15:47 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcWH-0001oc-9s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620545; x=1783156545;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=aial7JJv8nX1bRITUsijee950EYSkwRQ1GY89vTuk3U=;
 b=njHqUFK3oqP5ph1XR2/SI1e+/MayWeuwnoJAKLGSYwxeJL7M8USmJGOC
 G1tL4KqzVsgDNJ97o1nT+nQs0lCx0GHyLaf1Fdm0nTK7qRd9yzZVnSqHq
 ySWO46/csmAWoBTxLHwtc2N+q62J5j3WSd0cI+7r+v+P/5S5HjqVT/sSL
 G9ib0XfFMh0rGLNEg/TztjkUV8hNyRVot8c6JUnsE13wdqSyIBma8SuUl
 Obw/ci1S4IGhOmBxOS8Nb2v5j3EUhitzUjP4V+/F6x+s8oz7Nf8WHIG3m
 2bfCct7iLhlKk/N3xxDmvzTuUs70RbCCdtVNE5llwjG6GN8UlknetA7q8 w==;
X-CSE-ConnectionGUID: NIhhETDVQKOgUr/obFNcnQ==
X-CSE-MsgGUID: kvJboX40Rmi4nhFehLsKxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="41581992"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="41581992"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:15:42 -0700
X-CSE-ConnectionGUID: ouFteSMUS0S4U9hkUsQBwQ==
X-CSE-MsgGUID: 7xQMCcpqS+WteSWpSR07+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154017677"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 04 Jul 2025 02:15:41 -0700
Date: Fri, 4 Jul 2025 17:37:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 08/39] accel/tcg: Remove profiler leftover
Message-ID: <aGegwk0QFBerPmAp@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-9-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:14PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:14 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 08/39] accel/tcg: Remove profiler leftover
> X-Mailer: git-send-email 2.49.0
> 
> TCG profiler was removed in commit 1b65b4f54c7.
> 
> Fixes: 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/monitor.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


