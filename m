Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0DFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKvDE-0001VD-5D; Tue, 10 Dec 2024 03:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvD4-0001SX-H0; Tue, 10 Dec 2024 03:03:10 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvD0-0007Fc-Gi; Tue, 10 Dec 2024 03:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733817787; x=1765353787;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WD3n/k1x14oQLUe2LOCr6mf5vrLQ41VoVFtP9E50n6Q=;
 b=ZSzev2z2ZUZBM7ATuwsi6i9DNfQT/GusTdJH7Wm1N4WT0tliIqepBfX3
 /HswxU16WQ8seFHB6Z/Rj6J9P9BzCNLbAfvClT8H7v3REpIr0uomrkW4V
 2fRUlg/1ubd7E1xCEWquK3i92I+jasDH7/9im3qn6ECyp7JMUlTyMo3by
 l2K9xwIoAK51QHpU6EUVrgvfVdqQTxbPMUjasDrrYQGeBgzRHXI8E1tD+
 yx0zHPLuC3/dUriU9hDmDHs/bAcIW0+71o+j5lX8IuPOnLnlhrwfilW7Q
 hnanp+YpgGuNug/8b/mM3jc0WMZgeVDrDZsopCYDGN2h1hTVmap28AH5+ g==;
X-CSE-ConnectionGUID: chDxBZDcQa+udNySyVqH5A==
X-CSE-MsgGUID: lXemqAAoTc6jjLHCOtxMBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34201711"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="34201711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 00:03:03 -0800
X-CSE-ConnectionGUID: NeQ7eTsxTrGVsAaeBjeZ7Q==
X-CSE-MsgGUID: GHzqmXKKRQ6lJ0HKb1DvPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="95526036"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 10 Dec 2024 00:03:00 -0800
Date: Tue, 10 Dec 2024 16:21:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 07/26] rust: qom: add default definitions for ObjectImpl
Message-ID: <Z1f5+23Ojp0tfonB@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 09, 2024 at 01:36:58PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:36:58 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/26] rust: qom: add default definitions for ObjectImpl
> X-Mailer: git-send-email 2.47.1
> 
> Remove a bunch of duplicate const definitions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 6 ------
>  rust/qemu-api/src/definitions.rs | 8 ++++----
>  rust/qemu-api/tests/tests.rs     | 4 ----
>  3 files changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


