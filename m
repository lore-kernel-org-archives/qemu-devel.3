Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32186C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfz28-0005dJ-AR; Thu, 06 Feb 2025 05:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfz25-0005co-KI; Thu, 06 Feb 2025 05:22:53 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfz21-0005wr-PC; Thu, 06 Feb 2025 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738837369; x=1770373369;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7YvjgdFPhRVvYw+UmD94ieXFYl4XTC5l5c0+MA5KbYg=;
 b=UMKcTIER5im28kb81p5QjiNDlkoZQnfyNJklBL1/Ll+TAe5xQXH8ffxa
 OSlQlUXI81rPJS/FyKn73rbk+b4oW5rpM2/lpwnSOA7tXtlk4+FSaAUzQ
 yi7TOoWVdeHAPCc04pt1W2oC9O1xEBN+/aR+RSjQZrK5L6eTNhLNW6AUt
 VIjDs/o5gZSRxRXzoZNF2bRfQCyAYYn06MKtGTCzZOfirdvpab9fr9tIY
 tQapPmOnMSNMo/oRFmVs3Uk67+SMXDi9HR0yJzGdrKVmOwYDw/s5ee/Vd
 GUKbCuOeFSFPv8F/n2rCsp77vPjYtJomIBu3VVXPQHirYMsGBR6kx/FdC Q==;
X-CSE-ConnectionGUID: nCug5IFjRJKEE5BRX+RHDA==
X-CSE-MsgGUID: WoynbqWtScCBlLW4ykr7xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39307594"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39307594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:22:46 -0800
X-CSE-ConnectionGUID: v/qESQ7TS6yFT9lUeVe8jg==
X-CSE-MsgGUID: IqcH1MHVSNa3ohntEq3FYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111023084"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 06 Feb 2025 02:22:45 -0800
Date: Thu, 6 Feb 2025 18:42:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/2] rust: remove unnecessary Cargo.toml metadata
Message-ID: <Z6SSBl3j9DUgdwLi@intel.com>
References: <20250129083705.1321407-1-pbonzini@redhat.com>
 <20250129083705.1321407-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129083705.1321407-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 29, 2025 at 09:37:03AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 09:37:03 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/2] rust: remove unnecessary Cargo.toml metadata
> X-Mailer: git-send-email 2.48.1
> 
> Some items of Cargo.toml (readme, homepage, repository) are
> only present because of clippy::cargo warnings being enabled in
> rust/hw/char/pl011/src/lib.rs.  But these items are not
> particularly useful and would be all the same for all Cargo.toml
> files in the QEMU workspace.  Clean them up.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/Cargo.toml   |  3 ---
>  rust/hw/char/pl011/README.md    | 31 -------------------------------
>  rust/hw/char/pl011/src/lib.rs   | 14 ++++++--------
>  rust/qemu-api-macros/Cargo.toml |  3 ---
>  rust/qemu-api-macros/README.md  |  1 -
>  5 files changed, 6 insertions(+), 46 deletions(-)
>  delete mode 100644 rust/hw/char/pl011/README.md
>  delete mode 100644 rust/qemu-api-macros/README.md
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


