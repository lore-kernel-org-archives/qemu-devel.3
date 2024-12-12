Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D466E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfdL-0005sP-TA; Thu, 12 Dec 2024 04:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfdJ-0005rS-Hs; Thu, 12 Dec 2024 04:37:21 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfdH-0007Vu-GL; Thu, 12 Dec 2024 04:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733996240; x=1765532240;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mlYoJrzGX5NuPJYlKB4uXOWtJvTEY8ZIW1Kq3WDJKxI=;
 b=nRrGT1G43Pa39PPfTA+AD9deFE/LrpnaPFFJ9jICeqlDfDe5esCwyEHU
 u+xc8gz50NDFAcksBCGtEZ3UIwsvo4tKLlzCow5/s0mbBHfxTlW4cpTzr
 W28NVmrZSAQ1nBh9Vx93D8Xw+0WVAmDLN+dvxgC+zm/LUYUl2O27eDnh8
 DFOthAL+sSS5EPLtjFlhdOOBG26M7HlVIh66uriGO4G7BUnWKAOnLqduh
 7SR3zcywP7k+0TQTK2oBjA3CYCo786BTwd8iTWLJPYXdoFgXjyyE9gkmy
 aL31m+eJrYeKcdqRFfUmGTpMR+KqyV4qtzvEt0Lp4HXBNbY27bLveZLYN w==;
X-CSE-ConnectionGUID: Jx1duiFoQD2HXB2LHgcBuQ==
X-CSE-MsgGUID: NgGqCYU7TyiTk9aPuNv44g==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45790707"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; d="scan'208";a="45790707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 01:37:17 -0800
X-CSE-ConnectionGUID: DpKcTb3TQEWjI8OndLiLMg==
X-CSE-MsgGUID: lGRW47QqTM+0SrD5YDUSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="95932009"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 12 Dec 2024 01:37:15 -0800
Date: Thu, 12 Dec 2024 17:55:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 20/26] rust: re-export C types from qemu-api submodules
Message-ID: <Z1qzEudUZP4OY5gh@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-21-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-21-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Mon, Dec 09, 2024 at 01:37:11PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:11 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 20/26] rust: re-export C types from qemu-api submodules
> X-Mailer: git-send-email 2.47.1
> 
> Long term we do not want device code to use "bindings" at all, so make it
> possible to get the relevant types from the other modules of qemu-api.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs    |  7 +++++--
>  rust/qemu-api/src/qom.rs     | 10 ++++++----
>  rust/qemu-api/src/sysbus.rs  |  3 ++-
>  rust/qemu-api/src/vmstate.rs |  9 +++++----
>  rust/qemu-api/tests/tests.rs |  3 ++-
>  5 files changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


