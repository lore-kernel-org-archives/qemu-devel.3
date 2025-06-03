Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF794C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 02:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHht-0007a4-7Q; Mon, 02 Jun 2025 22:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHhl-0007Za-LG; Mon, 02 Jun 2025 22:48:46 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHhj-0005Zh-70; Mon, 02 Jun 2025 22:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748918923; x=1780454923;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vvZoXYxJ3Fo7E9JzOl1l2/TaAPNfkQhCQfcUAUk/JdM=;
 b=WMLlSJDybB60q+yMwgQp96egrxltNuAr76yNdGU8ncsXY4kTazbLxS/F
 hhPuEIKtx3Z+d/V/Auy1AVuiA/0l/aFjIUpBQkUntOgY2r0I8dHls8YQK
 TBFkikNea7xXNL8KamFERVRZ1x5nUakiKq9SUgJJp62CZmUCoJK0uxBp4
 srhSuVO61TppL5BUhIrPlcy3MipdC6zsl6qIeqKuFPJiUwyn6s39e4REa
 2IdvsQuGSnRAAUVMzv9MhLM3/cydyPZ4YVkzOi+lazAAeUE1qN3NKxo2F
 1SPVa8swIKtYRpy/QeoihRu4bevyS1axiPeqqfMD9tW2+lR1pA+VtcnGb w==;
X-CSE-ConnectionGUID: lIbzJJ18ScWE0Qyg9H9F3g==
X-CSE-MsgGUID: RXY3B4oiQpO0lOAKB1qh+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53571796"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="53571796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 19:48:41 -0700
X-CSE-ConnectionGUID: D2sxExXnS5S+fJnR2uNr3Q==
X-CSE-MsgGUID: /kc0lm9CQNmHV8KK8sn+fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="149599447"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2025 19:48:40 -0700
Date: Tue, 3 Jun 2025 11:09:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 14/14] docs: update Rust module status
Message-ID: <aD5ngENfwC/e2Zog@intel.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530080307.2055502-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Fri, May 30, 2025 at 10:03:06AM +0200, Paolo Bonzini wrote:
> Date: Fri, 30 May 2025 10:03:06 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 14/14] docs: update Rust module status
> X-Mailer: git-send-email 2.49.0
> 
> error is new; offset_of is gone.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


