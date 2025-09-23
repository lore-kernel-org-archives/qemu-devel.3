Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E510CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13tQ-0004V3-U2; Tue, 23 Sep 2025 10:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13tK-0004Qe-6t; Tue, 23 Sep 2025 10:21:16 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13tG-0000Hc-2e; Tue, 23 Sep 2025 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758637270; x=1790173270;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5zdqBubNKRDvGVUN+FwA3+JH/9UahAt+wKm6VCM5hHo=;
 b=N4SvzoMA62Xt5r3WyOzSyErgiEddgFJ0OQGt3cxfIF1zWPIjddSXIm1+
 qcY2Sxnz/76OK5WY8jmNfYj1T7teP5hYe2TBQHxUxbaHw9N+7ANVQqqqx
 plcEWf12M4l7+xplPDrllzbrgFWZuIZ65DkvofVoJuV/FAd2YQGagxkey
 utiIr1JxYqC5CN6fcsGPl7dP+71pZvSY4+cuJtC8rpD0nlqHsPGuFZtKW
 B8G2FWcMzTQEnGHqak6dKHFIUzaI0NrpiAIxmCWNj7luqn2eWRQBwundS
 uutGhHwN4clo1tXv9lXHxW75OqVvmanObMWxLgNKZmuqqMHNL1z9mYU7+ g==;
X-CSE-ConnectionGUID: LpYDuaFOQEmqScgkcDSrEQ==
X-CSE-MsgGUID: OQPH3VFtSiqdfBQwxxlvMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61032877"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="61032877"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:21:06 -0700
X-CSE-ConnectionGUID: 9gfSgjKJQNinyWxn2p2p3g==
X-CSE-MsgGUID: Vb3QVG9tSHaGh05bxpD9Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="176614216"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 23 Sep 2025 07:21:05 -0700
Date: Tue, 23 Sep 2025 22:43:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: vmstate: use "cast()" instead of "as"
Message-ID: <aNKx9mz+YaUzhH7c@intel.com>
References: <20250919083625.86678-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919083625.86678-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Fri, Sep 19, 2025 at 10:36:25AM +0200, Paolo Bonzini wrote:
> Date: Fri, 19 Sep 2025 10:36:25 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: vmstate: use "cast()" instead of "as"
> 
> Reported by clippy, fix it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


