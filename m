Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833E7E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 07:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQhts-0005TR-A7; Thu, 26 Dec 2024 02:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQhto-0005T3-Qx
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 02:03:13 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQhtm-0000gV-Sk
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 02:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735196591; x=1766732591;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Diqc1mJaCB7NLlrqiy784OP1AtghcIlJ9QFIfSpqUx8=;
 b=WnaccxHsOld8DjjduvDva/jv8tQ3+IudVd1bpo79Y/jo6UshkQ2GMR13
 ORbMXcKu+boFd30jDAybIcaxirMkKnpEbLmOyCDOuYSPkiTbW/heF+Y9D
 T/F9fJo2O4ZA4WT/PZl7rEfA59VsSl3A+xi7As9ocq6gkcYAjrEwoysH3
 CS6s5iULxorG5cR40hWcVAwPN1COJe+fIxRuK2U9ArhxKlwvaaoHdBcdC
 zOzWgMcBR9UwflszaiG372Ay1BxocpOQco6Y2pUpbkMIbyCWxUqo+YJ+D
 VMMRLNTbpPSontPcx3iU9BUp9d1yhEHEzABM/hlf0fnGR+3X7tzXiPNbt g==;
X-CSE-ConnectionGUID: +yHP3KVhQXas9f+Cxmmplg==
X-CSE-MsgGUID: F2+RkX7wQsia4kwT7aPrdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35775768"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="35775768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 23:03:09 -0800
X-CSE-ConnectionGUID: nThqAotoRsam4q2pt38SAA==
X-CSE-MsgGUID: 0fSL86GmTRaUJuz2VNGf0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="100334750"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 25 Dec 2024 23:03:08 -0800
Date: Thu, 26 Dec 2024 15:21:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 12/12] rust: hide warnings for subprojects
Message-ID: <Z20ED5iHoStmnOQe@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:54PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:54 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/12] rust: hide warnings for subprojects
> X-Mailer: git-send-email 2.47.1
> 
> This matches cargo's own usage of "--cap-lints allow" when building dependencies.

+Add remove the unnecessary meson.build file.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  subprojects/arbitrary-int-1-rs.wrap           |  3 +++
>  subprojects/bilge-0.2-rs.wrap                 |  3 +++
>  subprojects/bilge-impl-0.2-rs.wrap            |  3 +++
>  subprojects/either-1-rs.wrap                  |  3 +++
>  subprojects/itertools-0.11-rs.wrap            |  3 +++
>  .../arbitrary-int-1-rs/meson.build            |  1 +
>  .../packagefiles/bilge-0.2-rs/meson.build     |  1 +
>  .../bilge-impl-0.2-rs/meson.build             |  1 +
>  .../packagefiles/either-1-rs/meson.build      |  1 +
>  .../itertools-0.11-rs/meson.build             |  1 +
>  .../proc-macro-error-1-rs/meson.build         |  1 +
>  .../proc-macro-error-attr-1-rs/meson.build    |  1 +
>  .../packagefiles/proc-macro2-1-rs/meson.build |  1 +
>  .../packagefiles/quote-1-rs/meson.build       |  1 +
>  subprojects/packagefiles/syn-2-rs/meson.build |  1 +
>  .../unicode-ident-1-rs/meson.build            |  1 +
>  subprojects/proc-macro-error-1-rs.wrap        |  3 +++
>  subprojects/proc-macro-error-attr-1-rs.wrap   |  3 +++
>  subprojects/proc-macro2-1-rs.wrap             |  3 +++
>  subprojects/quote-1-rs.wrap                   |  3 +++
>  subprojects/syn-2-rs.wrap                     |  3 +++
>  subprojects/unicode-ident-1-rs.wrap           |  3 +++
>  subprojects/unicode-ident-1-rs/meson.build    | 20 -------------------
>  23 files changed, 44 insertions(+), 20 deletions(-)
>  delete mode 100644 subprojects/unicode-ident-1-rs/meson.build
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



