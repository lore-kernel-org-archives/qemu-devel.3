Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E5C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCuS-0007uT-2M; Tue, 06 May 2025 03:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCuQ-0007u3-Tw; Tue, 06 May 2025 03:40:10 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCuP-00075t-9x; Tue, 06 May 2025 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746517209; x=1778053209;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vbNRdNbsW9eQb9iQ2i4LzRidWxmWG7Nk5N+yFxfO8p0=;
 b=MKLJEKC9EDeos51SbmqVRKQpL6rGa1F3OQ2O9yA1Jn7g63Ua6vKisdL1
 4oabxMImd8+Q3kCYnJ+NCSbOfm8th8ZnBb1XHj8nQg4Lo+IrkrNKucAdF
 Dzxyinj0EnVAfiVXGPmyEY+Avjx7Ea977PzXYSqtHSds0XcGK4bhTuSWO
 WbuYKZBSGFeLF0SMl0GW56yX8K5leJt3uKlfnvVuXT2nCdNy6yHZcUXJ2
 bzYsx/yi6t8Fs/yCJbVKk2fmHIZZZdR9w689wwart0QQ/PI5WdYO/x4yi
 Dhag3RVxgV41HURbtiJM1iTvBlHpiKTQjD93X4pxEJCn5wNGyHNHqI/hU g==;
X-CSE-ConnectionGUID: jp9Oyop2QredhEE7ZVm68w==
X-CSE-MsgGUID: xWSQ9A77Te+RQtv24+aRig==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47426091"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="47426091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:40:07 -0700
X-CSE-ConnectionGUID: xM7pLFxZQoOwohRL3ovlKA==
X-CSE-MsgGUID: Nsg0nZRmQbOCaU0QfDhOuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="166589446"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 06 May 2025 00:40:05 -0700
Date: Tue, 6 May 2025 16:01:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/11] rust: qom: fix TODO about zeroability of classes
Message-ID: <aBnBwlhkS23VwULI@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:32AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:32 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/11] rust: qom: fix TODO about zeroability of classes
> X-Mailer: git-send-email 2.49.0
> 
> The proposed suggestion is not correct.  First it is not necessary for
> *all* classes to be Zeroable, only for Rust-defined ones; classes
> defined in C never implement ObjectImpl.
> 
> Second, the parent class field need not be Zeroable.  For example,
> ChardevClass's chr_write and chr_be_event fields cannot be NULL,
> therefore ChardevClass cannot be Zeroable.  However, char_class_init()
> initializes them, therefore ChardevClass could be subclassed by Rust code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Yes, it's clearly explained.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


