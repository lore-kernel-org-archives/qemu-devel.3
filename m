Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92AE68975
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6T9B-0007Q3-Js; Thu, 31 Oct 2024 07:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6T96-0007O2-9a
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:15:21 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6T91-0004EL-42
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730373316; x=1761909316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tw9eIcIn49m5DnJkgd+UYwuXkMe8QSLIQifeqZSrvdM=;
 b=TMB3Iu6rRenStaNfCnHxgiNTukKbAaqtqVMnosA1GVIKlvkikRN4ZN0C
 u0Y61bDTrbb2//dYSvEszL4WvZRYq5gUUIH00IC4ZRJFb6/iehOfmj9Mg
 xgnvuIcMFwdSZot8n7qCnmwT9S8z+ZOb+Fmc9ff4MDiEMLoSl3I5BFtSP
 G/DqV7dk0VN9KnroukvS+YTrXgFx6bu4q2gIxzwVLKYO40vqqn317owVm
 Y/t6Ncshmtw/5Q/N2cjsFbQ9UqdeEVvGuRVRtcasFC5OdQ8Jyn0gaymK/
 gFstH8EGIXtKlDbd7lrEblrUXK1dS9xcXO3A3UDsdMak4J3dkTduvUP2+ A==;
X-CSE-ConnectionGUID: WsqkYZYVQxquhsHx+VBvLA==
X-CSE-MsgGUID: Cac/dwsUTzq1nNaih1dfEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52659498"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="52659498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 04:15:12 -0700
X-CSE-ConnectionGUID: fJsT1pKLRg+wrUbw9hu0uQ==
X-CSE-MsgGUID: 0dthywenT3exf9sYYz3S0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="113447174"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2024 04:15:10 -0700
Date: Thu, 31 Oct 2024 19:31:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: Re: [PATCH 13/23] rust: synchronize dependencies between subprojects
 and Cargo.lock
Message-ID: <ZyNqkmgGR3lgIWm7@intel.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025160209.194307-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Fri, Oct 25, 2024 at 06:01:58PM +0200, Paolo Bonzini wrote:
> Date: Fri, 25 Oct 2024 18:01:58 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 13/23] rust: synchronize dependencies between subprojects
>  and Cargo.lock
> X-Mailer: git-send-email 2.47.0
> 
> The next commit will introduce a new build.rs dependency for rust/qemu-api,
> version_check.  Before adding it, ensure that all dependencies are
> synchronized between the Meson- and cargo-based build systems.
> 
> Note that it's not clear whether in the long term we'll use Cargo for
> anything; it seems that the three main uses (clippy, rustfmt, rustdoc)

not sure whether cargo update could help to know if the dependenies can
be updated or not...

> can all be invoked manually---either via glue code in QEMU, or by
> extending Meson to gain the relevant functionality.  However, for
> the time being we're stuck with Cargo so it should at least look at
> the same code as the rest of the build system.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/Cargo.lock   |  3 +++
>  rust/qemu-api-macros/Cargo.lock |  9 ++++---
>  rust/qemu-api/Cargo.lock        | 47 +++++++++++++++++++++++++++++++++
>  rust/qemu-api/Cargo.toml        |  1 +
>  4 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
> index b58cebb186e..9f43b33e8b8 100644
> --- a/rust/hw/char/pl011/Cargo.lock
> +++ b/rust/hw/char/pl011/Cargo.lock
> @@ -91,6 +91,9 @@ dependencies = [
>  [[package]]
>  name = "qemu_api"
>  version = "0.1.0"
> +dependencies = [
> + "qemu_api_macros",
> +]
>  
>  [[package]]
>  name = "qemu_api_macros"
> diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
> index fdc0fce116c..f989e25829f 100644
> --- a/rust/qemu-api-macros/Cargo.lock
> +++ b/rust/qemu-api-macros/Cargo.lock
> @@ -4,9 +4,9 @@ version = 3
>  
>  [[package]]
>  name = "proc-macro2"
> -version = "1.0.86"
> +version = "1.0.84"
>  source = "registry+https://github.com/rust-lang/crates.io-index"
> -checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
> +checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
>  dependencies = [
>   "unicode-ident",
>  ]
> @@ -18,6 +18,7 @@ dependencies = [
>   "proc-macro2",
>   "quote",
>   "syn",
> + "unicode-ident",
>  ]

With cargo build, it seems this dependency doesn't need to be added here.

I compared the versions and checksums of the wrap files, and I also
built it using cargo build based on this commit. The only change by
Cargo is the one mentioned above; everything else looks good.

With the nit fixed or otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


