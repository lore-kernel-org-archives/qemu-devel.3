Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6D8C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeU7-0004U3-BZ; Fri, 04 Jul 2025 07:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeU0-0004G4-GB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:21:33 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeTx-00080F-UD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628090; x=1783164090;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yqLsMXvXsECTq5ameAvnd7rKTpfYOMo5B5yoxtZ5sgI=;
 b=NxZ6p1krs9YFgGyf59AkpJXLnTmt79bvUdIlkKWRPVQ0Azl7uih6BZg5
 Zm2mDxUHZVW4qx8yblHwT6eH+p1utBzUrVEuQZTjxQC5U9gk58f4vrLQm
 dsaIQ+FcVXosIw/yH/fnzoEOnUa5JpS9jlccjvikb0p1+PwxC99BZeY1g
 I35iz4YCMYjslXzoRBmr1WKP1tj+G0/dknIt8OObiKDy/9nM/9TjXL2OQ
 hYJdc60LMRo8M7ovciDEMOULm/n51TbdfeUe0ROfVYD0S9bkE32gVy5FW
 3lDCdmA1/kcGcUUxN1VSbCnxRybHg9XZd5u5//Tuv+oUGTSKTlLR8Hj9i w==;
X-CSE-ConnectionGUID: 9UDFSZ2ySimFmyeci3mejQ==
X-CSE-MsgGUID: 50roPLmVROqsFF5UhUpQLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65017466"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="65017466"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:21:28 -0700
X-CSE-ConnectionGUID: ereO5IYETiSC4+D4vUjaGg==
X-CSE-MsgGUID: vv3Xhsm+Q2CkZwDzzVmUPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="158653810"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2025 04:21:27 -0700
Date: Fri, 4 Jul 2025 19:42:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 36/39] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Message-ID: <aGe+PNvT1W9hdlPY@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-37-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-37-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On Thu, Jul 03, 2025 at 07:32:42PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:42 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 36/39] accel: Pass AccelState argument to
>  gdbstub_supported_sstep_flags()
> X-Mailer: git-send-email 2.49.0
> 
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/accel.h | 2 +-
>  accel/accel-common.c | 2 +-
>  accel/hvf/hvf-all.c  | 2 +-
>  accel/kvm/kvm-all.c  | 2 +-
>  accel/tcg/tcg-all.c  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Make sense. I think then MachineClass can also be similarly cleaned up.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


