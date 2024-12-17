Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A50E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaA5-00048n-Iw; Tue, 17 Dec 2024 11:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa9z-000465-LL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:11:02 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa9x-0003jO-Ql
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734451858; x=1765987858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cm18FwdZ3kQgmti/Jxvk4pWT5jZnF2x7ce6Gw47H9Ew=;
 b=TbOS980kfsp+LpqJy2tpCVFzInwiGQq0x8ZHnZRmA/q+Zys3Sc6cdRF5
 LDXoa2B/S2PYnCu+RE/7LMNLoXyfXJTKMr42/fXK0mtNe0ZWyn02SaTmm
 kX9O9xLPrKYfMMIsw06gl3iG933RZUzlgUtPcVyOIKUgtIyPzEx4A/yfm
 0WYeTWu+k8w5nclyZqRHteUCNLFaaJlZCYU/UwK/p9buXdgn9frBYn1tB
 BuoJuqqaCjVXV8xgg3Yr/YwOmBZ0zOPaP9umPadlFifJw4TZXJ5hv+k7g
 mtcdc51PmS930jr9P8KcJp4Pc9lkay4bMxQJaWvtDbI46j5Hwd/NabpCI g==;
X-CSE-ConnectionGUID: 82+P/02jQeqazzGo2AWORA==
X-CSE-MsgGUID: b8NoMcoKQGWg+4Ur25NNiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45371634"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="45371634"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:10:54 -0800
X-CSE-ConnectionGUID: LxfpRyQmRYKpT7cLTu7iyA==
X-CSE-MsgGUID: UcpQ+NkHSCCQgNdhLxD23Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="98386534"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 17 Dec 2024 08:10:53 -0800
Date: Wed, 18 Dec 2024 00:29:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] i386: Remove unused parameter "uint32_t bit" in
 feature_word_description()
Message-ID: <Z2Gm7EFvxigbI9ze@intel.com>
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
 <20241217123932.948789-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217123932.948789-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Tue, Dec 17, 2024 at 07:39:31AM -0500, Xiaoyao Li wrote:
> Date: Tue, 17 Dec 2024 07:39:31 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 1/2] i386: Remove unused parameter "uint32_t bit" in
>  feature_word_description()
> X-Mailer: git-send-email 2.34.1
> 
> From: Lei Wang <lei4.wang@intel.com>
> 
> Parameter "uint32_t bit" is not used in function feature_word_description(),
> so remove it.
> 
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


