Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFCEE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO798-0004wW-0S; Wed, 18 Dec 2024 22:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tO796-0004w9-D1; Wed, 18 Dec 2024 22:24:16 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tO794-0008He-F0; Wed, 18 Dec 2024 22:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734578654; x=1766114654;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q37HglmJFbkIyET//zidT7en4ZdrnqcmKPRwLQlWZik=;
 b=PZgzNWhi4FaLE4aZHjz5wZR6BPkKMXgvJugRQuqkuFRZeA7JMmRo8Jcq
 SzC2nJ1x54mqBJ2JHrVnuclCWJeQvnX7cb+sYnMQJNgWSLsfvo8J3hh/P
 3FND5zRoZO5hLRUcetLNg6WkFldcThO7gMoVNJPX8xqUkqrEuJFz7MawE
 481CBuJ1r/fCHxYswGhOMb5QSOVSl8zcvySzac4cYEcUXi2unY7arBSYK
 Z0qzthIO3AGLyCOFtKIr4IubjySvkuIX/dd4ZgXGscoc4+5RE4UfL+bTC
 wKXkabTJQHCCeRpCExWrjWOT59Kup9fo7n/a/C2SQ36wcF/3DfD7QlufK g==;
X-CSE-ConnectionGUID: PQKSqktxQBGiNWhZ48pIiA==
X-CSE-MsgGUID: Erj5UCSDSsOQTGee/1JpuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35204726"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="35204726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 19:24:09 -0800
X-CSE-ConnectionGUID: KFAbH7pfQQGmecYSHdUhPA==
X-CSE-MsgGUID: Y1FfmOe+RNC5DJl6nAvTCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="97895816"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 18 Dec 2024 19:24:07 -0800
Date: Thu, 19 Dec 2024 11:42:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/7] rust: pl011: fix declaration of LineControl bits
Message-ID: <Z2OWNxw/kAh6PYqO@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:21:58PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:21:58 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/7] rust: pl011: fix declaration of LineControl bits
> X-Mailer: git-send-email 2.47.1
> 
> The bits in the LineControl struct were backwards. :(
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/lib.rs | 82 +++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


