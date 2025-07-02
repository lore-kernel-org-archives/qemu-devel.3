Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3191C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtF9-0000tc-HP; Wed, 02 Jul 2025 04:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWtF8-0000tN-6P; Wed, 02 Jul 2025 04:55:02 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWtF6-0003KP-D3; Wed, 02 Jul 2025 04:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751446501; x=1782982501;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MY9aVmShvK7y3KFSV6s4iDmTnB1j5xEapHFKBdIkaFo=;
 b=k2HzA2OorAWkPUzAlNOKO6FlTeVOpnYQ8wQUBUWsOwWhY2E2qE47nXPa
 RU973iJoaRUkGJO74vdfPoHz9DDNemxcs9UkhFCu5ZRWIXOzfzUdUI3IJ
 lm+IyrQU6jA/qvnX/PAiDWLYpOiYNxREOXuWF3NkZC5Q0Qs+85CkKSOSH
 xO0oLIMbbrOVSQ7m2pBus1atje0m1DUC6gH41l236JUbiAhKlnd7F06jZ
 qyqt+/wF8a8fTx1ew7ZNMdeQuzPmXj9O9CgdmpSPRdo21eyfC8zMn70Rh
 z5/2eqjAxLbLdsxEblVnAoQ/OLelIyPkriDWz7zSd34wAnUWH4wW4S9SQ w==;
X-CSE-ConnectionGUID: ICxCG5bTTBmABvAt9Kdq1g==
X-CSE-MsgGUID: nHHyzTIARfmFp/xZNbxWLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65188340"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="65188340"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 01:54:57 -0700
X-CSE-ConnectionGUID: 3pZVwCG8TFSBFgPngHDYiw==
X-CSE-MsgGUID: wWBXtC0mQKeIF16vm+Vc8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153477238"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 02 Jul 2025 01:54:56 -0700
Date: Wed, 2 Jul 2025 17:16:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/system/target-i386: Remove the sentence about RHEL
 7 being supported
Message-ID: <aGT45EFFk4ZCDdAe@intel.com>
References: <20250702082138.23109-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082138.23109-1-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 10:21:38AM +0200, Thomas Huth wrote:
> Date: Wed,  2 Jul 2025 10:21:38 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] docs/system/target-i386: Remove the sentence about RHEL 7
>  being supported
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> According to our "Supported build platforms" policy, RHEL 7 is not
> supported anymore, so let's remove the related sentence from the x86
> documentation.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/target-i386.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


