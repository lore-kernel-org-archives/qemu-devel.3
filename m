Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748FCC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcbm-0001Tv-5Y; Fri, 04 Jul 2025 05:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcbk-0001R5-A1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:21:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcbi-0005VI-KZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620883; x=1783156883;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=inr+3FwlB9sc9YcOOYVxwbJmvIIoEDSr6BDierq+drE=;
 b=kQC1VO2xikFn0xe33JCRKx87YCsZcjWRRJ2IniAcVaQ/+y0w/4HmJuH5
 8pevu+JWAhKp4Lh2wJd5WD4y667dkqc3ByUD+Gn6p8TS0S5Xekr+sf2Wd
 sPH9B/bV//NTKBE3c2Uq24u3TmwCas4UUANgOBxgvddRgpbvHfJW0hRLM
 CV59TMGCVa5OYyPs2CMEiwOwyUpTO9Kf2MfZ/t4795xJn0rMk0LYYlWXC
 tEe+XY0+RvJFmLDX8dAU3XDkCPoIc5h/RCTotWZmC8b5QrLyJ7rnslwdc
 dnish42vgVfTkP6yfz6tmui02c8tc4FFCr4FhqgHfqqa9AXae6Z18B/Qc w==;
X-CSE-ConnectionGUID: a0lik0N8S9+DKadMT+FnIw==
X-CSE-MsgGUID: gTvJoLgJThmrLr+p0YQ8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54097940"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="54097940"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:21:21 -0700
X-CSE-ConnectionGUID: DxX1hGH6QsG+0u/Wg7IiCg==
X-CSE-MsgGUID: HbVV904qSka382ewDD1GgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154965016"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 04 Jul 2025 02:21:19 -0700
Date: Fri, 4 Jul 2025 17:42:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 12/39] accel: Move supports_guest_debug() declaration
 to AccelClass
Message-ID: <aGeiFZb4spI4uwqd@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-13-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:18PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:18 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 12/39] accel: Move supports_guest_debug() declaration to
>  AccelClass
> X-Mailer: git-send-email 2.49.0
> 
> AccelOpsClass is for methods dealing with vCPUs.
> When only dealing with AccelState, AccelClass is sufficient.
> 
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Restrict kvm_supports_guest_debug() scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/kvm/kvm-cpus.h       | 1 -
>  include/qemu/accel.h       | 1 +
>  include/system/accel-ops.h | 1 -
>  include/system/hvf.h       | 2 +-
>  accel/hvf/hvf-accel-ops.c  | 2 +-
>  accel/kvm/kvm-accel-ops.c  | 1 -
>  accel/kvm/kvm-all.c        | 5 ++++-
>  accel/tcg/tcg-accel-ops.c  | 6 ------
>  accel/tcg/tcg-all.c        | 6 ++++++
>  gdbstub/system.c           | 8 +++++---
>  target/arm/hvf/hvf.c       | 2 +-
>  target/i386/hvf/hvf.c      | 2 +-
>  12 files changed, 20 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


