Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF69CD3E1AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mmE-0001Td-2v; Mon, 21 Oct 2024 03:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2mmC-0001TV-8Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:28 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2mm7-0005bA-KT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729495464; x=1761031464;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NGl3r5fmOudRc/L4pqhjtSh24bKpx54A9FpiC7dQjgc=;
 b=BZuFbYfXbKdeZ2Cnie4eFmga80xrIK17ezraOl5ShodGQxiUXWFddXWN
 VJLU+LeBrtg8n1w0OFESfiJA8AMA9SRRHL8IEe+Y427/GBmwfKBG3nJ0q
 ijj+9JUZuK0xd4T9pL09hqSYTgJJsKKP9FjTwPm3W8fz50Tl6+rKhPcLM
 oLRH6isHE1n37x0DjesCE727TyRIg12wH+1AekGzUWYvcj+jveb9l+M4s
 VaGoF7GrG8nqa8jkiIDyewta9vkq9gys85pdVW58D4vbN10/bWvJVkLmd
 4/AHM5hnXIauKJEOIyeAhj4XKFIXah1kluizwW05s7fEWKG8oTW3fChA9 g==;
X-CSE-ConnectionGUID: kG617X0ESAea/Jo8n0ZABg==
X-CSE-MsgGUID: iWcOiz75Q2WnAj27o4gwNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46431833"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46431833"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 00:24:21 -0700
X-CSE-ConnectionGUID: mnxqQK3ySHC4CsL5jLiUHg==
X-CSE-MsgGUID: 1oqouM4pR7Gt0SUqVNjiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; d="scan'208";a="79402130"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 21 Oct 2024 00:24:19 -0700
Date: Mon, 21 Oct 2024 15:40:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/16] rust: fix cfgs of proc-macro2 for 1.63.0
Message-ID: <ZxYFc+jm/oOzWa6F@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
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

On Tue, Oct 15, 2024 at 03:17:23PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:23 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/16] rust: fix cfgs of proc-macro2 for 1.63.0
> X-Mailer: git-send-email 2.46.2
> 
> Replay the configuration that would be computed by build.rs when compiling
> on a 1.63.0 compiler.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


