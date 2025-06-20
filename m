Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05988C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYKK-0003jq-9E; Fri, 20 Jun 2025 05:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSYKI-0003j8-0z; Fri, 20 Jun 2025 05:46:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSYKC-0001HX-MU; Fri, 20 Jun 2025 05:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750412780; x=1781948780;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OtF5QLWiSi3HkyWcQstKPhjFG38NQRVgAtZdeqisCsI=;
 b=iodHW6M29GEV1SChNVaXNgaWUpa7mCPBnXKr0mlK25qkSkR5zKltoGvy
 7Yf8psR34GXMqbiPM+qWJpSgijwiRP2TlG4zGzk5Twj0iKt+mWxP4GlCz
 YIgfKeq2evCyIpP2J3bOyw24tbDtcLpSAP+WarqC3nzcMh5vniECM8o70
 hm0M9NCMmoIP2UXD8zImjYLNKqSIYVinUbOEFkriIx5GMXa2+9m0RdfeC
 F+NWi5acqTD58ilnlLvL5bZ/GTcLdGwabrdnjCF86fVGv768FkfjjZtKa
 7MzVOO6xJO/nk4OlziI7OpKW/PGQ/OlHoQ4qXCSEa0QNqi4ey/waFeTgr A==;
X-CSE-ConnectionGUID: cPb5UFbPTzas+Xc4pKyPGw==
X-CSE-MsgGUID: ewhp2ETjRoq7+Vi6KXRAVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52752258"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52752258"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:46:17 -0700
X-CSE-ConnectionGUID: BlmFe89BRrCLC7SQ/cqZlA==
X-CSE-MsgGUID: ZX2/Q7i1RiaVyW2AbLDQHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="155160688"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 20 Jun 2025 02:46:16 -0700
Date: Fri, 20 Jun 2025 18:07:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, tanishdesai37@gmail.com
Subject: Re: [PATCH 1/2] rust: prepare variable definitions for multiple
 bindgen invocations
Message-ID: <aFUy6CBpwgPoyYwC@intel.com>
References: <20250613130249.1225545-1-pbonzini@redhat.com>
 <20250613130249.1225545-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613130249.1225545-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On Fri, Jun 13, 2025 at 03:02:48PM +0200, Paolo Bonzini wrote:
> Date: Fri, 13 Jun 2025 15:02:48 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/2] rust: prepare variable definitions for multiple
>  bindgen invocations
> X-Mailer: git-send-email 2.49.0
> 
> When splitting the QEMU Rust bindings into multiple crates, the
> bindgen-generated structs also have to be split so that it's
> possible to add "impl" blocks (e.g. for Sync/Send or Default,
> or even for utility methods in cases such as VMStateFlags).
> 
> Tweak various variable definitions in meson.build, to avoid naming
> conflicts once there will be multiple bindgen invocations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build               | 21 ++++++++++++---------
>  rust/meson.build          |  2 +-
>  rust/qemu-api/meson.build |  2 +-
>  3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


