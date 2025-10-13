Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0110CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8DrO-0005Ff-AL; Mon, 13 Oct 2025 04:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8DrN-0005FQ-18
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:24:49 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8DrK-0005pD-DJ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760343886; x=1791879886;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yfI5dV/UzU5knZNHzJbCKeiwxQrhR/WdjS1NnmZRnMo=;
 b=nTnZxusP85se4VwzY6jFoUnxsqtOdppeKtiNPzCZ6hvQ9DIcc8FZpQGK
 KOJ2/GJODy6hA/N3g1I7AvVLkgX3OkFeaP591/Fteecett2KsUzMNleQX
 Gc5R49h32L1SGtzPMTHq2mdhWxOJ21AJaffUJCSErU4p185Y3kttFGGne
 EUEO7wn9v8yfFUW1qFi392CD5e+Xv4awzB9VRwn5o2wCsIbnLrYbOenkW
 RuOf0HCMx76UOpFUKJjLB8rQaV6DK+uL2ljgeMD8z63VEJlSY6oy4iiFU
 FcPfXtD0SZWCq/FBAe3kRqVFPZzhgSXYuJiHxHwVpIQkD7VpTFMOJPNM2 Q==;
X-CSE-ConnectionGUID: il96r66KRfi2KndOXTPAPw==
X-CSE-MsgGUID: 1ekbOir9S524xHGVGwdzgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="65099221"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="65099221"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 01:24:43 -0700
X-CSE-ConnectionGUID: DuFA93zrRlG6CeWz5dYraA==
X-CSE-MsgGUID: J00H97rVQzukzqruHk08ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="181108829"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 13 Oct 2025 01:24:42 -0700
Date: Mon, 13 Oct 2025 16:46:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/11] rust: migration: validate termination of
 subsection arrays
Message-ID: <aOy8d2DX5MnnkS8P@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 09:52:03AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:03 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/11] rust: migration: validate termination of subsection
>  arrays
> X-Mailer: git-send-email 2.51.0
> 
> For consistency with fields(), validate the value (at least to some extent)
> before passing it to C.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


