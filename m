Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A700CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRjN-0000qY-Vt; Mon, 25 Aug 2025 03:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRjK-0000oR-Vr
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:35:03 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRjF-0002sS-Nf
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756107298; x=1787643298;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=039Im5f9sBccczcDnmgMWyjSRsRL61+VEvDO+0R0nhQ=;
 b=kEVBsi+zuXSxRAtDClhTy00VzQaeURC7fxpe7WRMad4Xlpx3LxePp4zL
 RFlOxft9ZfGEKk++6tbsYwc9zLNmDyav8iYat7RTBZV25j1QyzndScWG3
 gCoIssmjQ1r3j8oMUtrPTLXrxSskhaioxCnvf3p6zh0tdx+6zeJGr9g3V
 FVYwlzz3qz+P6UPFNMokKLVDgUD69YohLTGcu4yFq8DUjccab+rIgweVf
 PhzwcNxFzfDCMWNW8eh9GTHgNBOZemUCyDRIgJFzWJs48XqDESuEf9pKZ
 M/FoAcGTrUZU7yPPW79jbJUNFEGkto/YChGVLg7JoNkyapvjHSLE3j4at Q==;
X-CSE-ConnectionGUID: yMlzD5wOQ4GrO7OxSeDoRA==
X-CSE-MsgGUID: bnEj1Z1ATpqbwvcJMkO3bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="57334841"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="57334841"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 00:34:52 -0700
X-CSE-ConnectionGUID: ++fF9rQbRWO7moWdy5EvKw==
X-CSE-MsgGUID: Oyov6XcxSVGch3WDF+6q+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="168430058"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 25 Aug 2025 00:34:50 -0700
Date: Mon, 25 Aug 2025 15:56:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 11/14] log: change qemu_loglevel to unsigned
Message-ID: <aKwXM0P+5Pea5zWv@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 22, 2025 at 02:26:52PM +0200, Paolo Bonzini wrote:
> Date: Fri, 22 Aug 2025 14:26:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/14] log: change qemu_loglevel to unsigned
> X-Mailer: git-send-email 2.50.1
> 
> Bindgen makes the LOG_* constants unsigned, even if they are defined as
> (1 << 15):
> 
>    pub const LOG_TRACE: u32 = 32768;
> 
> Make them unsigned in C as well, and also change the type of the variable
> that they are used with.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/log-for-trace.h |  4 ++--
>  include/qemu/log.h           | 44 ++++++++++++++++++------------------
>  util/log.c                   |  2 +-
>  rust/qemu-api/src/log.rs     |  2 +-
>  4 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


