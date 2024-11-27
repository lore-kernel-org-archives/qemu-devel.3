Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CFDD609A2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 06:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGBXA-0004OO-81; Wed, 27 Nov 2024 01:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tGBX8-0004Nx-EU; Wed, 27 Nov 2024 01:28:18 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tGBX6-0003Iq-9G; Wed, 27 Nov 2024 01:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732688896; x=1764224896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CSzBPJhSS9MzP+GlwEbLnRaydSVd8KPkg22TczdAkwI=;
 b=RQ4AmpjXclAOGezZiLx8pPUjG5RWJyItkw0D3ZvLQmzqMULkTZSMXcVy
 Ukn/t2oGjuurqvYa/ELDJxwLIGH52SUFNlNHl6teSLw6S7v6RpoKuqCMc
 b6dAV3qzw1a+9ub7+X0/pzvVSArkj+Src2Gtr2yjWjOFBrEbywtuoHPhu
 L6/QL2tGIMRHCjti77mwJb2HEOi1wfpC7Wxehr87yoU0XU97WU9KdzykP
 7bbKu5H1GmvxDGHnvNPkVy7+HUBAehqYjA/t/dchtnt4f8j/Bb5vTnkt9
 KCql2u/yhdGMzU+pf7YyQydU1einD4mL+ZOgl7gN8ii5mCeCWjHbPgO9s g==;
X-CSE-ConnectionGUID: qZz9sqrWQMC2jD775MrO7A==
X-CSE-MsgGUID: kD3w5FTyTpiD/Zd9BN63+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="33033078"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; d="scan'208";a="33033078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 22:28:13 -0800
X-CSE-ConnectionGUID: CrzDOZYmR26CQQ1wi7WNcg==
X-CSE-MsgGUID: fNWWfL/TQB+4K7wJK9xvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="96896359"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 26 Nov 2024 22:28:12 -0800
Date: Wed, 27 Nov 2024 14:46:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: Rust in QEMU roadmap
Message-ID: <Z0bAPQxjwyc15Hyv@intel.com>
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Tue, Nov 26, 2024 at 06:46:45PM +0100, Paolo Bonzini wrote:
> Date: Tue, 26 Nov 2024 18:46:45 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Rust in QEMU roadmap
> X-Mailer: git-send-email 2.47.0
> 
> [several people are in bcc.  You can follow the thread at
>  https://lore.kernel.org/r/cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local]
> 
> Based on the content presented in the community calls, here are some
> ideas for future Rust in QEMU subprojects.
> 
> This is by no means exhaustive, for example QAPI and async (block devices)
> are missing because I have not looked at them.
> 
> Table of contents
> '''''''''''''''''
> 
> * Status in QEMU 9.2
> * Build system
> * Feature parity for pl011 device
> * Avoiding undefined behavior
> * Safe QOM class definitions
> * QOM method calls
> * Callbacks
> * Tracing/logging
> * Data structure interoperability
> * Features expected from recent rust

Hi Paolo, thanks for your sharing and summary, do you have the plan
about custom allocator (QemuAllocator in rust/qemu-api/src/lib.rs)?

Regards,
Zhao


