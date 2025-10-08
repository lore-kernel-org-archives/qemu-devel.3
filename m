Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63697CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WY8-0007zF-5J; Wed, 08 Oct 2025 11:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WY5-0007yX-5E; Wed, 08 Oct 2025 11:57:53 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WXx-0001Jk-Qx; Wed, 08 Oct 2025 11:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759939066; x=1791475066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SL9ZIanH4daLtDHkAxvTE4hpVJPEL03brhWGLFT3rRs=;
 b=H7OPV8almis3SPAHP9jkcqLLNV+SY3XAC6sfabmW2l++od/t7K1JOw0V
 ErN8peAPDYkz0OofFYj5uKeBkYw4aR/dLZUiOctKvjcwKZTuMTsTiD1Ma
 2apiGB1lYTiOk9DurN1RS69SeqkuPd6cXj67P/8IRPyWhcAIYbApayusH
 y0YhNuQEx1309KnAvqtAKfOviOBxTRu71Pww7KX0P3njQ/YT3MvkY6zCw
 QGiV2jskokBmilVb497MBELIxvHzv18YXxi4lkFOpFOTDnlojCFJvYly9
 /9ZtjqJguaqXhCNwZWgH4ALReA1Fj70lVGZM3uTYCkbD94uzDtOqJaMkx g==;
X-CSE-ConnectionGUID: OyaJvq8pTDu0lR5T+Alkxg==
X-CSE-MsgGUID: 6RYvDiAeTNG2SpfK/DW/Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73240728"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="73240728"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 08:57:37 -0700
X-CSE-ConnectionGUID: HdrRK16eRtWnOkROb0v1og==
X-CSE-MsgGUID: IAv3gJJYQICMGPKD8mFH4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="211128389"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 08 Oct 2025 08:57:36 -0700
Date: Thu, 9 Oct 2025 00:19:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-10.0.x] Revert "i386/cpu: Move adjustment of
 CPUID_EXT_PDCM before feature_dependencies[] check"
Message-ID: <aOaPGqqCsrSP1GAA@intel.com>
References: <20251008134716.528025-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008134716.528025-1-mjt@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Oct 08, 2025 at 04:47:14PM +0300, Michael Tokarev wrote:
> Date: Wed, 8 Oct 2025 16:47:14 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: [PATCH for-10.0.x] Revert "i386/cpu: Move adjustment of
>  CPUID_EXT_PDCM before feature_dependencies[] check"
> X-Mailer: git-send-email 2.47.3
> 
> This reverts commit 3d26cb65c27190e57637644ecf6c96b8c3d246a3
> (v10.0.3-34-g3d26cb65c271) from 10.0.x branch.
> 
> The problem is that the change makes qemu 10.0.x non-migratable
> to subsequent qemu versions, since it requires introducing a new
> machine type.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  target/i386/cpu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


