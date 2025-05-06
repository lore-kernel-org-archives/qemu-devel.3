Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB31CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCa1-0006Ie-Rk; Tue, 06 May 2025 03:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCZx-0006Hj-QJ; Tue, 06 May 2025 03:19:01 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCZv-0004Gi-4O; Tue, 06 May 2025 03:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746515939; x=1778051939;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dsIXkco0LG3d6J/ztzirwi4i0myH6tM32CTEpYflnDs=;
 b=arko2uPzHbdPCD/F74/lmSnHT+tziyIWE3sKGS6isE2ewzfK3t37UA7N
 L2lCDzmm82dFjT7uGk002nefvXueDRCD7dR7d4jyAzaQT5dcGpzv8LKie
 t+BHgSNIPfIs+KLZCnYHUsdQF1e4UjlUATc8rjTZ3pQHx7u1gUgR7GjuX
 LMpgzFAzdhdlZA539UjL5z33cuJ0CwD3xZUS6iLXeIKn1F58/SuagNCuH
 iGFkrXTqzhoaHs2/nEaeac6FJxBQ7897fpRFgzzo2bWXy1PgKI9rTpujS
 v/3DNRA3EgAtl72YtJoe2Ps/eY9YcgcBTjO+WpdNjlXWZ2ZBnX8Yo++QI Q==;
X-CSE-ConnectionGUID: P6efs1GQTaWEUwH1zlzRuQ==
X-CSE-MsgGUID: lpzx/udLRS+XEnlfV9pjTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48302078"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="48302078"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:18:54 -0700
X-CSE-ConnectionGUID: DKU/yatjRIyVyxJ+TUTi+A==
X-CSE-MsgGUID: Uq23WSm1Q2qa7hGnepj6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="135428515"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 06 May 2025 00:18:52 -0700
Date: Tue, 6 May 2025 15:39:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/11] meson, cargo: require Rust 1.77.0
Message-ID: <aBm8yWd3sc+Ll28G@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 05, 2025 at 11:04:27AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:27 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/11] meson, cargo: require Rust 1.77.0
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build      | 6 +++---
>  rust/Cargo.toml  | 2 +-
>  rust/clippy.toml | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


