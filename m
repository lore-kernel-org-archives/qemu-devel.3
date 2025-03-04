Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2BEC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpVQH-0003nq-W8; Tue, 04 Mar 2025 11:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpVQ8-0003jP-CE; Tue, 04 Mar 2025 11:47:08 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpVQ4-0002zR-QJ; Tue, 04 Mar 2025 11:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741106821; x=1772642821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jmaem5cQC4XHhY3/BP0OvobTtroTuo7hud9bFRaDzYo=;
 b=S47mZCFRjxUtqIVkLcwnskti0MDZUDWm+ux40EpMQ5DSy97Lu4HPCEFk
 SNtvFaNe5WQ2x/jBMsJcKIUL+0uhv4l9pwaqOG1J1ff9TXo7EAjxg37Fh
 VCTjGPfbmDSCr/NRNjQVZhBI+Svs3+NhpZG0I9w0ZXTlREnqtoJDjoYDi
 kWVn6hdPcl8dC5qMDGTr7BW+F9y6SbdpEdFt7RcdDdCxugTEJ0yka1+YH
 5bZmg/J9kQsZsI9L+eAAlO4BJWijeT3HkEFs/nJz8kN5tLJ9queiTsXRq
 SLkX04IyokGMu0+WciKx7aB+KjsgXM5oOC895v29jRg5FSZVC9vkGU4cM A==;
X-CSE-ConnectionGUID: rw/dCJgNQHSUvdURqnp3Uw==
X-CSE-MsgGUID: Jj2RGTX2RpGcKwEUtkqVeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45685625"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; d="scan'208";a="45685625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 08:46:58 -0800
X-CSE-ConnectionGUID: fbJBhUCkQuO5m29jKgZUEA==
X-CSE-MsgGUID: nJDXc8RgTE6afNAlKDx93A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118314908"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 04 Mar 2025 08:46:57 -0800
Date: Wed, 5 Mar 2025 01:07:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: qom: remove operations on &mut
Message-ID: <Z8czOELqP69Yk/qG@intel.com>
References: <20250228085831.847265-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228085831.847265-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Feb 28, 2025 at 09:58:31AM +0100, Paolo Bonzini wrote:
> Date: Fri, 28 Feb 2025 09:58:31 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: qom: remove operations on &mut
> X-Mailer: git-send-email 2.48.1
> 
> The dubious casts of mutable references to objects are not used
> anymore: the wrappers for qdev_init_clock_in and for IRQ and MMIO
> initialization can be called directly on the subclasses, without
> casts, plus they take a shared reference so they can just use
> "upcast()" instead of "upcast_mut()".  Remove them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/prelude.rs |  1 -
>  rust/qemu-api/src/qom.rs     | 83 ------------------------------------
>  rust/qemu-api/tests/tests.rs | 34 +--------------
>  3 files changed, 2 insertions(+), 116 deletions(-)

Simplification is always a good thing,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


