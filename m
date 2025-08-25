Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A84CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqREH-0004Cr-F9; Mon, 25 Aug 2025 03:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqREF-0004Cj-U0
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:02:56 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqREC-0007pI-Kc
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756105373; x=1787641373;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8VCksnUANnZpWCksBnUQSvpA2J6PwDmkE0ptSQKnaCE=;
 b=BpwsJOiHlqVFAzhXr8Iy2nRjZuLNXjEmhzjKw9VTEIDWzgXL4oJv3ZTM
 nQXDhnCMLr3HEJRfahBl+1or8vVnqJYUbGPwq/N8L2NyIe1I8/sN0Xb6l
 8tHQG+pwFqp1/MZrd8nFoumtR/x3OLm5MadR/FdRtQ0uuGe5T7B2BxAsS
 rSqI13df2iHpbH/3M44/BFg9CNL9Woe61dhBCIo9ZG5c8wBUkBhVFG0Ce
 uZLGtPCZTBS/669421yUo2j53XaguvHU1NGFTsFtOCG+nOc4mesc69bEi
 4McaV68YG/EVulqh9/bXmnKijlLnE29i/oZpgUuVWrWEDRBpPikmDwItK w==;
X-CSE-ConnectionGUID: O8adKopoQPmZV5G+0IRzJA==
X-CSE-MsgGUID: +OEo+d1cRYa6h6UNb89RaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69414427"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69414427"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 00:02:50 -0700
X-CSE-ConnectionGUID: aQc6LoVCRlWXwfjH2nYzBQ==
X-CSE-MsgGUID: Y3jAWNLuScas4KZx7wHMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="173622457"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 25 Aug 2025 00:02:47 -0700
Date: Mon, 25 Aug 2025 15:24:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 02/14] rust: move dependencies to rust/Cargo.toml
Message-ID: <aKwPsY7sg0YAOMbE@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Aug 22, 2025 at 02:26:43PM +0200, Paolo Bonzini wrote:
> Date: Fri, 22 Aug 2025 14:26:43 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/14] rust: move dependencies to rust/Cargo.toml
> X-Mailer: git-send-email 2.50.1
> 
> As more crates start using the same dependencies, it's better to not
> repeat the versions and move the dependency declarations to the workspace.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml          | 5 +++++
>  rust/qemu-api/Cargo.toml | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


