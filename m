Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1EAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKvG4-0003N0-BL; Tue, 10 Dec 2024 03:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvG2-0003Mc-7s; Tue, 10 Dec 2024 03:06:14 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvFw-0007jm-Tz; Tue, 10 Dec 2024 03:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733817969; x=1765353969;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XjCvPV9ltizMhPYnCb/qkFU0FwOYWNoTjbkNM4sIEFo=;
 b=E6HTcRahXvuCfD8xz9vm6ZQMtYFRjfDmHTPtxYbNQ2SN47W0QE5GN2Bj
 jboB6rqmGmTbWd1bKGYAUFRYIcznC2s7EjGVOgZl27BkD1Wnu8BJmuSZ0
 ht+SNqfnJMagdWf5yGa9U/IC63YSoe1JTuYuW1OKTnqqryO0VEGn+D2xi
 AwVeBrZ6UqGqspfBM+taXcPIYh2haPoP0EcivCn2Lgx4o05iGl9UWNtdY
 eE2NJsD1rfS9C802O+oNdOYYAQhvgqhr+YNTg7mm0OfqD3ZVN4cNKiv07
 QUprarYpHzyILjHlJ6+Yyrlcdd3OJzMCUVCwAQIxm6157dIAF+cxZ0S9Q A==;
X-CSE-ConnectionGUID: 7C/SQ9aGT/yrii343eM7hg==
X-CSE-MsgGUID: HSn3zaHlRm6Yybr68mGTBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37934107"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="37934107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 00:06:04 -0800
X-CSE-ConnectionGUID: jKAIkDnaTnundX9/2JJQeQ==
X-CSE-MsgGUID: DjsNfAH2TLigB51hCWhxVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="95162346"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2024 00:06:03 -0800
Date: Tue, 10 Dec 2024 16:24:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 08/26] rust: qom: rename Class trait to ClassInitImpl
Message-ID: <Z1f6sY8ZHlMIRN4b@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 09, 2024 at 01:36:59PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:36:59 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/26] rust: qom: rename Class trait to ClassInitImpl
> X-Mailer: git-send-email 2.47.1
> 
> While at it, document it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  4 ++--
>  rust/qemu-api/src/definitions.rs | 25 ++++++++++++++++++++++---
>  rust/qemu-api/tests/tests.rs     |  4 ++--
>  3 files changed, 26 insertions(+), 7 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


