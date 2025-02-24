Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B296C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZa5-0005Xg-VO; Mon, 24 Feb 2025 09:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZa3-0005XJ-Dp; Mon, 24 Feb 2025 09:37:11 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZa1-0006Km-Ag; Mon, 24 Feb 2025 09:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740407829; x=1771943829;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=un8HXcxNZE3oFALFsJNKuLE61w4QGf33WYRzArq2yu0=;
 b=brytg2KFx4awoV+xcFbn4J6i1V4MwL8LmQtLsC94HwWzjJ2MSjNtfizl
 b3YIRHICVrRGynv86pSk6FKGtYi0lgDyC/3/xooHdcLv3m2ntaEVSAmuN
 jRsfwFP7emzxyR9bSp3LfSowGZTfDXviTZjG/zgJTSrclncNjw12oYe4E
 tBAwAW2csVALIInP1zMF7ajcV2AihbIDmyZLGJIyHAXREGA0GFoJXW2Vb
 W/uctfZEqAqWbF49mBsaNYyCjAMrqD2/WdnzxZm+E3fPzFpKjkI8808yp
 FHdw+yHxIjKbninewdYt2BWGJVw3V9dgaskuCDH+tQ8XswgsCTlULqGGa A==;
X-CSE-ConnectionGUID: IyS6v4zxRKyyRQdjGl0JIQ==
X-CSE-MsgGUID: E15o6cj2TT2CLpLE6+DQMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58710962"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="58710962"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 06:37:06 -0800
X-CSE-ConnectionGUID: jgHqyOPZQE6IHwmrZ3ZTpg==
X-CSE-MsgGUID: Cxa1PgNlToGKRclv3D1gyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116056262"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 24 Feb 2025 06:37:04 -0800
Date: Mon, 24 Feb 2025 22:56:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/15] rust: qom: add ObjectImpl::CLASS_INIT
Message-ID: <Z7yIqbXZ+D5qufkn@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 21, 2025 at 06:03:30PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:30 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/15] rust: qom: add ObjectImpl::CLASS_INIT
> X-Mailer: git-send-email 2.48.1
> 
> As shown in the PL011 device, the orphan rules required a manual
> implementation of ClassInitImpl for anything not in the qemu_api crate;
> this gets in the way of moving system emulation-specific code (including
> DeviceClass, which as a blanket ClassInitImpl<DeviceClass> implementation)
> into its own crate.
> 
> Make ClassInitImpl optional, at the cost of having to specify the CLASS_INIT
> member by hand in every implementation of ObjectImpl.  The next commits will
> get rid of it, replacing all the "impl<T> ClassInitImpl<Class> for T" blocks
> with a generic class_init<T> method on Class.
> 
> Right now the definition is always the same, but do not provide a default
> as that will not be true once ClassInitImpl goes away.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  3 +++
>  rust/hw/timer/hpet/src/hpet.rs   |  3 ++-
>  rust/qemu-api/src/qom.rs         | 14 +++++++++++---
>  rust/qemu-api/tests/tests.rs     |  3 +++
>  4 files changed, 19 insertions(+), 4 deletions(-)> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


