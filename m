Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC05C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAaH-0006bP-3G; Thu, 05 Jun 2025 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAaE-0006ac-1H; Thu, 05 Jun 2025 09:24:38 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAaB-0004nj-PY; Thu, 05 Jun 2025 09:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749129876; x=1780665876;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vR6IePl07Jxlw+pwoPEoQIJHamyhBbgdQQCsqpDI54s=;
 b=gPEoY4d6QS3Zd3pTs+6ueXmcNF1EmY2XH1kIp7NWDZhVaN6+JbXdXk2z
 cfQQ+LCIYQuA39Lb2gR6glOU+LbZ+mMQBHgk5SztzcGSDuM1fEHi8lkd9
 jwTmrgd4g4LmR8OYYkhlyTVHVZOKp6Y/GH6XFlxyDK1N+xgrdfyFnRm7Z
 87j6F5yfGvz6kK/gNgoudhKZoZfDxsAlXzLDiLg/OIFJAwtJdr1Kxp4Zd
 2cMrDqIV6GkBsKLNtVgz8dNkVkkLXmFDPQfE0jGW18rt0Syk/E8OPPfDv
 W1nT74qflRrq7uBKwcyhI0XxHJWr3PFuYK5knwH0UMqcIWH512HYcxubx Q==;
X-CSE-ConnectionGUID: BkygiAfWSrOeoeorlYVTRA==
X-CSE-MsgGUID: JcqGGodqSZCh19tOHZSkKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51245197"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="51245197"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:24:32 -0700
X-CSE-ConnectionGUID: kAXlABKrTmSS3fQ1WVaJuA==
X-CSE-MsgGUID: 7RKMJEu/SD23/RYMDM4DfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="176469773"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 05 Jun 2025 06:24:31 -0700
Date: Thu, 5 Jun 2025 21:45:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
Message-ID: <aEGfiJ5YMw0qqa4T@intel.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101544.368953-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Thu, Jun 05, 2025 at 12:15:35PM +0200, Paolo Bonzini wrote:
> Date: Thu, 5 Jun 2025 12:15:35 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/14] rust: qemu-api: add bindings to Error
> X-Mailer: git-send-email 2.49.0
> 
> Provide an implementation of std::error::Error that bridges the Rust
> anyhow::Error and std::panic::Location types with QEMU's Error*.
> 
> It also has several utility methods, analogous to error_propagate(),
> that convert a Result into a return value + Error** pair.  One important
> difference is that these propagation methods *panic* if *errp is NULL,

nit: *panic* if *errp is not NULL

> unlike error_propagate() which eats subsequent errors[1].  The reason
> for this is that in C you have an error_set*() call at the site where
> the error is created, and calls to error_propagate() are relatively rare.
> 
> In Rust instead, even though these functions do "propagate" a
> qemu_api::Error into a C Error**, there is no error_setg() anywhere that
> could check for non-NULL errp and call abort().  error_propagate()'s
> behavior of ignoring subsequent errors is generally considered weird,
> and there would be a bigger risk of triggering it from Rust code.
> 
> [1] This is actually a violation of the preconditions of error_propagate(),
>     so it should not happen.  But you never know...
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst        |   5 +
>  rust/Cargo.lock            |  17 ++
>  rust/Cargo.toml            |   1 +
>  rust/qemu-api/Cargo.toml   |   2 +
>  rust/qemu-api/meson.build  |   1 +
>  rust/qemu-api/src/error.rs | 312 +++++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs   |   3 +
>  7 files changed, 341 insertions(+)
>  create mode 100644 rust/qemu-api/src/error.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


