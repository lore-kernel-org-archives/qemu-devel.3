Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WYy-00089x-65; Wed, 08 Oct 2025 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WYo-00086i-QA; Wed, 08 Oct 2025 11:58:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WYh-0001V7-Oq; Wed, 08 Oct 2025 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759939111; x=1791475111;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1BouwLaDdnUKXtsovcRtz7AKvj03mAL2ND+hoCcpCdw=;
 b=HAgmNnJ8sG389o1dnGqZqCkOcCLTacUrTThCBJ7OMoNbD3vmVlZtQUxD
 qD49EDVudJxEcPOyUgfBs5y1OM3yDvlP0ikTo6YyqgfCtnB6lqUKDbfRT
 K07l/jlp31JzoXjMFoJfw9DFl/QUfoFLSCz3eE78bsr8R7jCYcu555y/q
 yFGKGp7tXD0Omn10B/MdrGQ8SHuwH7Bvu7RUGu9XBwqImVDpClVjU1Jvh
 yRB5mrauGw6xFxHTtejHI1p7O8N/bNYFCMG5VDrt4weykph52gkUQui7u
 YUWW1rCq5PG7rlv84KINuEwzrkFoPMotc/MSRZY1aKpeKl5DImPX0f2kh Q==;
X-CSE-ConnectionGUID: kQMDFUcmQ4y3vQgIUcxMhg==
X-CSE-MsgGUID: hMHhScHFTSGjEgL05uk/AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79574800"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="79574800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 08:58:24 -0700
X-CSE-ConnectionGUID: kj/JBHdVTO60oM9Exep1+A==
X-CSE-MsgGUID: xs+Ut2d8RqihU9+DtpGDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="180886281"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 08 Oct 2025 08:58:23 -0700
Date: Thu, 9 Oct 2025 00:20:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH for-10.0.x] Revert "target/i386: do not expose
 ARCH_CAPABILITIES on AMD CPU"
Message-ID: <aOaPSlnBg3rCMLbW@intel.com>
References: <20251008134112.527650-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008134112.527650-1-mjt@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 08, 2025 at 04:41:10PM +0300, Michael Tokarev wrote:
> Date: Wed, 8 Oct 2025 16:41:10 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: [PATCH for-10.0.x] Revert "target/i386: do not expose
>  ARCH_CAPABILITIES on AMD CPU"
> X-Mailer: git-send-email 2.47.3
> 
> This reverts commit 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
> (v10.0.2-66-g24778b1c7ee7) from the 10.0.x branch.
> 
> The problem is that the change makes qemu 10.0.x non-migratable
> to subsequent qemu versions, since it requires introducing a new
> machine type.
> 
> This revert re-introduces the problem with windows guests (which
> is already fixed in windows but not in prior versions).
> Details: https://gitlab.com/qemu-project/qemu/-/issues/3001
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  target/i386/kvm/kvm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


