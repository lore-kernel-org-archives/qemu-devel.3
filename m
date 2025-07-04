Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1549FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdZq-0000OT-Ox; Fri, 04 Jul 2025 06:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdZl-0000O8-Nk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:23:25 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdZg-0002RH-8y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751624601; x=1783160601;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fkQyWEzNVDp1mIlK5qCKfe4R0qOhdAASngJuemDaDmw=;
 b=TyhH40dIkh3RRRhgiOIlfMwYSF3BV/tNaifkhhyevsx/mxHmZL4XyhHk
 aUarIZMPX5+xdrW26xFf1ThW4OhHOZ3jlwTKnxAVf0Y1sNU7FmHuvh+Eu
 MS4Bq1Vq4axpb6Q+rv7cCPTRa6F1+WoWycJy/yIodw3PQta+9oXO/EZDn
 rP6NKflUXXdonv6nI0uJcnRFGkEH8RMJx20G/Kjy0g9EohXyQ7dx6l1/Q
 MMlVHaJVW+lOWs6BSoAW6UdaEahEt9aNhMbhELFL7yMwqRq30qSW9irMb
 P80KD1UhbjYuWZ68TUEP+VbJnejCVSw/x9IDe+XokAONNy5g2/Uq4yWZJ w==;
X-CSE-ConnectionGUID: OCiHmauhQW2GbioymgtRjA==
X-CSE-MsgGUID: 6wx/kclNTVicZV4AvZwS2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65013798"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="65013798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 03:23:16 -0700
X-CSE-ConnectionGUID: YSK9P3LbQX6KthdIqnuodw==
X-CSE-MsgGUID: I/OSUW5/SDSw+mLVOAoeKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="178278997"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 04 Jul 2025 03:23:14 -0700
Date: Fri, 4 Jul 2025 18:44:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 26/39] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Message-ID: <aGewmEL4KkPitAA8@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-27-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-27-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:32PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:32 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 26/39] accel/dummy: Extract 'dummy-cpus.h' header from
>  'system/cpus.h'
> X-Mailer: git-send-email 2.49.0
> 
> 'dummy' helpers are specific to accelerator implementations,
> no need to expose them via "system/cpus.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  MAINTAINERS           |  1 +
>  accel/dummy-cpus.h    | 14 ++++++++++++++
>  include/system/cpus.h |  5 -----
>  accel/dummy-cpus.c    |  1 +
>  accel/qtest/qtest.c   |  1 +
>  accel/xen/xen-all.c   |  1 +
>  6 files changed, 18 insertions(+), 5 deletions(-)
>  create mode 100644 accel/dummy-cpus.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


