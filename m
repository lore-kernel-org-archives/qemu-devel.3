Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F99EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMWz-0005nC-D6; Mon, 27 Jan 2025 05:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcMWs-0005l1-5t; Mon, 27 Jan 2025 05:39:43 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcMWn-0003L4-Dk; Mon, 27 Jan 2025 05:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737974377; x=1769510377;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x9Wnk/VtlLlMs9Z7o+kmZK3Qdm5phOVBChnQ6Dyf3qU=;
 b=WUClN144W385bo1PBZcvfARNn1wpOlHX1Yz9Z3G8sFTKbSg5GY3DYB8X
 r0taccMEJePaTQpjHHelr55qEFvkbpm6nTWxUyt5UmTrLwIb2DRkD1BFt
 b3v1EO9WpuZV5rAkuhkHVulQq0eo3e7u3AnAU6Ay1zerk9zZ1skRjkhR0
 hQO9sh+2Kf9aA4LYPB3zGchnYkU9a4Fim6NTshi8eSzqm4UfIUKBvaFyi
 RncVnnLrjbTQGLM6NUhiMiKFhkHg2K4b3KOEHZLRd5zvqGhRn9xLTa8jf
 YPwp0NXdFQY3xU8/ed9fm9TWuuUiz8lOT5FTW/2G8mJ97xnHsOHD+FKa0 w==;
X-CSE-ConnectionGUID: xclM3dPUSvG4UqV8AK6cZA==
X-CSE-MsgGUID: /zJvYFg2TTawqBm1poeu6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="38319231"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="38319231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 02:39:34 -0800
X-CSE-ConnectionGUID: 1vORbhD7TZOjEssUQSqkZw==
X-CSE-MsgGUID: bvrDeySaR+Cy7CAPSqYvjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="108929376"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 27 Jan 2025 02:39:33 -0800
Date: Mon, 27 Jan 2025 18:58:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/10] rust: bindings: add Sync markers to types referred
 to by MemoryRegionOps
Message-ID: <Z5dm8ehRtDo2TqHt@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 17, 2025 at 08:40:02PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:40:02 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/10] rust: bindings: add Sync markers to types referred
>  to by MemoryRegionOps
> X-Mailer: git-send-email 2.47.1
> 
> This is needed for the MemoryRegionOps<T> to be declared as static;
> Rust requires static elements to be Sync.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 19 ++++++++++++++++++-
>  rust/qemu-api/src/irq.rs      |  3 +++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
> index 8a9b821bb91..3f61264ab80 100644
> --- a/rust/qemu-api/src/bindings.rs
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -21,7 +21,24 @@
>  #[cfg(not(MESON))]
>  include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
>  
> -unsafe impl Send for Property {}

I guess this is a rebase mistake since latest rust-next drops this
change :-).

> +// SAFETY: these are implemented in C; the bindings need to assert that the
> +// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
> +unsafe impl Sync for BusState {}

We haven't used BusState but it's fine, as the basic support, and after
all bindings file has this type.



