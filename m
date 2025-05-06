Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5CBC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCbH-0007Aw-6Y; Tue, 06 May 2025 03:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCbE-00077w-6t; Tue, 06 May 2025 03:20:20 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCbC-0004Yw-76; Tue, 06 May 2025 03:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746516018; x=1778052018;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zZLTHjqWA3crtEEjdzLNusApWQ8qFX6fx/D1bPjaYq8=;
 b=GVFnRKNQXMdB/bBC5v96tA7QcCtWc631jXiGLSB7e6x6ur1Cvpy2Sybq
 y1sZq2fMuxwmWq8yx1HJYvQe9ojfl2h+Oavnxb26O7u5OZ9Zwn/l2zj7C
 k1jBtvqEsOx2khbea1aR4vLU/ttQ5NsFW3/imUcDBSGLBZ76wXmSlnmgG
 jBR9hVpMe0GuBOFjFVOJkNvqUWDklvHoUPU9Wc8Kah2HBh53PRI0RtxPq
 S/1VdMk/RjkZegNQLuav2sWNsOvZylWdN5L/gQ/yqrWLRwjUfKFt+y/2g
 RYdLnYXj7dIeTfZBULBIJFip465Aq9Xtp1cdkkauqoR1uLZ/CPNok6C0W g==;
X-CSE-ConnectionGUID: 3BxYlCyATgmGYg+GTtdOXg==
X-CSE-MsgGUID: wsNe7DmiQ0+86DehErgyvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73564791"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="73564791"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:20:14 -0700
X-CSE-ConnectionGUID: hze0HaQuR5KQXY0Zgax+3w==
X-CSE-MsgGUID: rGxMi7R+RC+imZuApjCgVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="158771341"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2025 00:20:13 -0700
Date: Tue, 6 May 2025 15:41:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/11] rust: let bilge use "let ... else"
Message-ID: <aBm9GYrDJDl2R9rx@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:29AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:29 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/11] rust: let bilge use "let ... else"
> X-Mailer: git-send-email 2.49.0
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                           |  3 --
>  subprojects/bilge-impl-0.2-rs.wrap            |  1 -
>  .../packagefiles/bilge-impl-1.63.0.patch      | 45 -------------------
>  3 files changed, 49 deletions(-)
>  delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


