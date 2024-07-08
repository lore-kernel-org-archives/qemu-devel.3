Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE3C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 03:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQei1-00040d-5l; Sun, 07 Jul 2024 23:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sQehz-0003yt-EF
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:06:31 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sQehx-0002ci-ED
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720407989; x=1751943989;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HLlpZlQCuvieBDTYAh0yn3A2ZMIv7ImHFoPGoZG0XdA=;
 b=P9+nIqkQxWs6kfeL4uE2kSUK08x9VCmTedNoSfuWRncM3kbp7/ntRPHw
 uay/UHjQtXGQxldOx2KWEVtLLY4MrdY5CK73RIqJon2Tl5ARk/bd7mT1U
 wN3EFsYeY7eex23PRIo3H2InbU/WymvpeW8ccIL7P291E9uFXEiHmm7Jt
 rg9KR4uuqujqA226cyhMH1pdrtkTmXAxemI4e+sz7mQpea9QSq26fjmzb
 1A36XtyfFMpyNCu0IiOR8l6WacV8FBBzBtOOTCN78ts9Vk5HuFwoOi7Aq
 pUkqFuPBKcr9LaUu3trLcc+VoxQEj9LPXCov75oYp4LG0N8EnS0F9mVRJ A==;
X-CSE-ConnectionGUID: x23BwWYVQXG2SHbgEenFkQ==
X-CSE-MsgGUID: 3L1xfV68REm3qA/5C5i1CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="20495899"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="20495899"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2024 20:06:26 -0700
X-CSE-ConnectionGUID: x4TWM8dPR4Clj70+Pxqpjg==
X-CSE-MsgGUID: E3nijltTTLmaIkhw0abDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="84906879"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 07 Jul 2024 20:06:25 -0700
Date: Mon, 8 Jul 2024 11:22:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xin3.li@intel.com
Subject: Re: [PATCH v1 1/1] target/i386: Add VMX entry load FRED control name
 to VMX feature words
Message-ID: <ZotbW5wiO+ijQZCO@intel.com>
References: <20240707181057.2793329-1-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707181057.2793329-1-xin@zytor.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Sun, Jul 07, 2024 at 11:10:57AM -0700, Xin Li (Intel) wrote:
> Date: Sun,  7 Jul 2024 11:10:57 -0700
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: [PATCH v1 1/1] target/i386: Add VMX entry load FRED control name
>  to VMX feature words
> X-Mailer: git-send-email 2.45.2
> 
> As VMX entry load FRED control is required to enable FRED in nested VMX,
> add it to VMX feature words.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


