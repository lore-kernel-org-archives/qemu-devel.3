Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3BEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 02:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHes-0006bJ-HS; Mon, 02 Jun 2025 22:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHeh-0006aF-8O; Mon, 02 Jun 2025 22:45:36 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHed-0005Ej-4c; Mon, 02 Jun 2025 22:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748918731; x=1780454731;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0tlELg/Hhen4u/rda5Bs9TEIIfha8t5K+ZIO3qkWm1k=;
 b=KtMIFTpwCMgBWFiS7KRsfqCHvJgDrv3n6BusyI5QTvoST1q2b+m2FF1a
 qmbkOA5WNFSC/XAOhDU+2Hw4Xki4pdYIKkrfMCpPkbhdWY69e3eAEvTVI
 dPAds7AeT/KdANwuw5lBUCbw+QcxSapoqqJM7ohiok1OnG99b72NzT5Ud
 i2JOri3xSocl5qOdAUXtZ36D2T/ZuCiWdBu5KdnIEQK0TXuXoEo0vHBqy
 Nl0ZMK3xRb2r/7Zs2aGf0rStb7qcE0uNLjIN38PTuSahrHMLBMjyILbrx
 KE267vZwRMpYT62VGkiUqsJmKPljD+wWdBWo6OjjVy7GfjPGMZTCJfdBP Q==;
X-CSE-ConnectionGUID: icRIpUg9S7eimSc7+0RK8A==
X-CSE-MsgGUID: dNNjMDcCSC6E4BS5+S5/Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54747043"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="54747043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 19:45:25 -0700
X-CSE-ConnectionGUID: 0H4t5kQ4Qd6bT4posNUC8A==
X-CSE-MsgGUID: Im3bG4ZXQKKW8f55OLRtrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="144599651"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 02 Jun 2025 19:45:24 -0700
Date: Tue, 3 Jun 2025 11:06:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/14] util/error: expose Error definition to Rust code
Message-ID: <aD5mveqY0bq5aTAk@intel.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530080307.2055502-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 30, 2025 at 10:02:55AM +0200, Paolo Bonzini wrote:
> Date: Fri, 30 May 2025 10:02:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/14] util/error: expose Error definition to Rust code
> X-Mailer: git-send-email 2.49.0
> 
> This is used to preserve the file and line in a roundtrip from
> C Error to Rust and back to C.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 26 ++++++++++++++++++++++++++
>  rust/wrapper.h                |  1 +
>  util/error.c                  | 10 +---------
>  3 files changed, 28 insertions(+), 9 deletions(-)
>  create mode 100644 include/qapi/error-internal.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


