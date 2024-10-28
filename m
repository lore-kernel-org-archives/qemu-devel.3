Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4480D1356B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 03:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5GNJ-0006in-No; Sun, 27 Oct 2024 23:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5GNH-0006ib-R8
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:24:59 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5GNF-0006Dz-Pz
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730085897; x=1761621897;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+DoVMk67zblu+b37B6E5uAiS+mO4TLNtp2kdYeUmHEQ=;
 b=kYQMpwzSzJ8gSPGXo10XLYhUXUM466QtxRJMpLRbpcQ1Uq1mMl+PxBXw
 0VS2DEnOoB0j8ttOoO8zOpAIdclVjNqGINx6rn62FIWcICH2TjIi6cDd4
 0BKx/70TaXs0ar41XDJBDLIM3A6kzImP/96j4aa1+CiEh+0y9/QWsbrmu
 jj8GMPB149V1xeA6nJ5XF1RKtB3c4c5ONb03mpPqK6D1OD/jBdGuobG0k
 2zQcIB3CLrU/+cZEDcoW8U+/nopwiMmAyUZkuFHmKRDZxAb4Pk5cCdPTp
 XnYNVygzetvFjmChfPGVt2Pmr4Fhb/wOQjprDbd64DgTTOYihte0EXKIf Q==;
X-CSE-ConnectionGUID: TRY1IchSRtWK8LKKlxM50g==
X-CSE-MsgGUID: o3oARS6KRwqoPhmaQC9buA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52229193"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="52229193"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 20:24:52 -0700
X-CSE-ConnectionGUID: 07U5wF8zTbGGMUom7qVg0w==
X-CSE-MsgGUID: oxB4oV3tRLC9uuUPLPfUag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="112315117"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 27 Oct 2024 20:24:50 -0700
Date: Mon, 28 Oct 2024 11:41:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] target/i386: Fix minor typo in NO_NESTED_DATA_BP
 feature bit
Message-ID: <Zx8H1RJTniBeDNvV@intel.com>
References: <cover.1729807947.git.babu.moger@amd.com>
 <a6749acd125670d3930f4ca31736a91b1d965f2f.1729807947.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6749acd125670d3930f4ca31736a91b1d965f2f.1729807947.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Thu, Oct 24, 2024 at 05:18:19PM -0500, Babu Moger wrote:
> Date: Thu, 24 Oct 2024 17:18:19 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v3 1/7] target/i386: Fix minor typo in NO_NESTED_DATA_BP
>  feature bit
> X-Mailer: git-send-email 2.34.1
> 
> Rename CPUID_8000_0021_EAX_No_NESTED_DATA_BP to
>        CPUID_8000_0021_EAX_NO_NESTED_DATA_BP.
> 
> No functional change intended.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: New patch.
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


