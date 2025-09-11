Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0634FCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 02:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwXUy-0004TL-Su; Wed, 10 Sep 2025 22:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXUw-0004Sy-Jv
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:57:22 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXUv-0001Ax-4v
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757559441; x=1789095441;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jZwRKGuuS8FTHuvDXccERuvIG6aCrnq7mvDN1ej6no0=;
 b=P7Hvf1nbjNs8vvZlcW8LL/He2Mv/l0yRiaLKUn4Yl1lYMvjXx80TosZ5
 rGNCN/NWzdG/8JZmYfbJsBoGYQczKgETU55dDkmC0y5D7dvY2WHdpux1w
 6pDldDlfBoEKmQ5DyJE86WH813WuXnYm718QfFeYFS1cllkp0ugsxFztA
 6f14rjWEHP3z9wlrn/EnXwIb5m3obtPilfsWbbJ4tmJfEnxdo8EiAZxk+
 UkBzXDk6wmDHtvLGCMxKQOh/cPcDb5060z09/AfdGAIqpLlcbXyef/lYD
 HCGPBPmGD0gLwVqXENS5Pjf7Od+OPGG1ETA70tO6Vs4OL7TdYZVH9rdTA g==;
X-CSE-ConnectionGUID: S3Hr4y42SQa56OBsAh4NEQ==
X-CSE-MsgGUID: Eb2zGSI1R9SP1ROaTP8Rdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59829814"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59829814"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 19:57:19 -0700
X-CSE-ConnectionGUID: C4PFMN7AQUGjPGJXA63PlQ==
X-CSE-MsgGUID: Xt5YA0cZQt6WFkfTT0tPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173400170"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 10 Sep 2025 19:57:18 -0700
Date: Thu, 11 Sep 2025 11:19:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/33] meson, cargo: require Rust 1.83.0
Message-ID: <aMI/rq6519VDjgQC@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:35PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:35 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/33] meson, cargo: require Rust 1.83.0
> X-Mailer: git-send-email 2.51.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 14 +++++---------
>  meson.build         |  6 +++---
>  clippy.toml         |  2 +-
>  rust/Cargo.toml     |  2 +-
>  4 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


