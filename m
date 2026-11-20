Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDE606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OltcO9cG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULQn-00033H-CL; Fri, 20 Nov 2026 05:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xULQl-00032j-Cm
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:01:19 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xULQj-0008VV-MN
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795168879; x=1826704879;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xFjJrHG8loq+KTwHuECoxP4ZWZLEvCvDfnEwnsII7rM=;
 b=OltcO9cGCa1OwUCf59LWVqMj6XC6HJ9E3DhuFPOEgOhbHdJrU+5/+fCF
 dEHXRdhD0FHVxiSbKiYR68VBXxqbcz8l4WyUiMvYErwY+LAAePj534Kwq
 ixrdNQLDd3WNMSr2h3iGhC7e2CSC4AYzVTy3OM2wmchBY+omVI6JQBvtH
 2QDvcC8VOlr2EpTIWSH0DPHP19tmbcV1QxEm193Ty0qsWeeN0x17B8euD
 56rVMVAN8JsnUIP8jdBco3+XHH8pGnuyK44dDXYmW6J2HsTx1Q8M/cVZD
 MNxlg1w17/7QWKI7GA8bIqdM1MID3zpberwJHd0M2Yq3t4dRNo7UBNNJ+ g==;
X-CSE-ConnectionGUID: NRTXKkz+Q4WLZQ5WF3oqRA==
X-CSE-MsgGUID: 6d7QLthlR/6sWKIIJh25wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3928643"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3928643"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:01:17 -0800
X-CSE-ConnectionGUID: v/J9CCEjT5yTFVATrPph0w==
X-CSE-MsgGUID: SsLbqtAzSxCgq/mSTNbJug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10742489"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2026 02:01:14 -0800
Date: Fri, 20 Nov 2026 18:01:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] i386/cpu: miscellaneous fixes for DiamondRapids
Message-ID: <awAaafnPQCuwl3Fv@intel.com>
References: <20260930045237.784060-1-zhao1.liu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930045237.784060-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi maintainers,

Just a gentle ping.

Regards,
Zhao

On Wed, Sep 30, 2026 at 12:52:34PM +0800, Zhao Liu wrote:
> Date: Wed, 30 Sep 2026 12:52:34 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH 0/3] i386/cpu: miscellaneous fixes for DiamondRapids
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This series includes:
>  * AVX10.2 feature renaming to keep up with the latest spec changes.
>  * A fix for DMR cache topology emulation.
> 
> In addition, there is another TF32 fix remaining in the mail list,
> which is a change in hardware implementation:
> 
> https://lore.kernel.org/qemu-devel/20260720205227.519647-1-chang.seok.bae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (3):
>   i386/cpu: rename feature name avx10-vnni-int to avx10-v1-aux
>   i386/cpu: rename CPUID_24_1_ECX_AVX10_VNNI_INT macro to
>     CPUID_24_1_ECX_AVX10_V1_AUX
>   hw/core/machine-smp: allow thread level cache
> 
>  hw/core/machine-smp.c | 7 -------
>  target/i386/cpu.c     | 7 ++++---
>  target/i386/cpu.h     | 4 ++--
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1
> 

