Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A520C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 06:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkdXs-0001KO-SY; Wed, 19 Feb 2025 01:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkdXp-0001Ji-Ql; Wed, 19 Feb 2025 01:26:54 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkdXj-0006el-PC; Wed, 19 Feb 2025 01:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739946407; x=1771482407;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xk2ZrkVGusRUrEcnU0dHUcdxXlH+QkgE9K1coBzLX9Q=;
 b=CXRZmeazIaMc0iQXriKtPpkiKVQ75JN6PhUGXm6luE2SxDSrcIgPtivp
 GVhshdvLy4sTT4X3f9XtKEbZZAkHx1rUQXoTIeTnbiVBm5Y4udlpGxkMr
 GuzrCHOYAOFUu0dX9vIpwOu2j8tzW2BTmEeAe+BP21FSVWcl0hkZlgp25
 blUhgDG5wKchyDhgzR21l75I30RogeNT9o+dKPQ20/ITeXRKuWnn0sz+c
 BqnZ0uL5y1exRjbOUB8bVwM90acbFYyqPb4R/l9oLmIKwX0bdnCM9GHby
 ZffUeJnR/Rn+W5qSvihQ8vTfxQW+Zr7Y5Mngy0O5GmgQKQakGV5yqnzuR w==;
X-CSE-ConnectionGUID: dxVOhoD1SPKrX36m2DheyQ==
X-CSE-MsgGUID: Ybb6FhJ3Q2WzbAbj3hgJ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40528228"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40528228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 22:26:42 -0800
X-CSE-ConnectionGUID: M31E44ljRm+zp3vhwI5gbw==
X-CSE-MsgGUID: +0rudihzRmeoaRm/u/zoWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119270260"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2025 22:26:40 -0800
Date: Wed, 19 Feb 2025 14:46:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 05/11] rust/block: Add empty crate
Message-ID: <Z7V+N/0AKw7qBQ63@intel.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-6-kwolf@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

> diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
> new file mode 100644
> index 0000000000..fbc2f2d6ef
> --- /dev/null
> +++ b/rust/block/Cargo.toml
> @@ -0,0 +1,16 @@
> +[package]
> +name = "block"
> +version = "0.1.0"
> +edition = "2021"
> +authors = ["Kevin Wolf <kwolf@redhat.com>"]
> +license = "GPL-2.0-or-later"
> +readme = "README.md"
> +description = "Block backends for QEMU"
> +repository = "https://gitlab.com/qemu-project/qemu/"
> +publish = false
> +keywords = []
> +categories = []

Per the commit f26137893b98 ("rust: remove unnecessary Cargo.toml
metadata"), readme & repository are not necessary. :-)

And rust-version is needed (since the commit 669fab6a1f3e).

> +[dependencies]
> +qemu_api = { path = "../qemu-api" }
> +libc = "0.2.162"

I think it's necessary add the lints section to apply workspace's lint
configurations:

[lints]
workspace = true

> diff --git a/rust/block/README.md b/rust/block/README.md
> new file mode 100644
> index 0000000000..debcc9d815
> --- /dev/null
> +++ b/rust/block/README.md
> @@ -0,0 +1,3 @@
> +# QEMU block backends
> +
> +This library implements block drivers for QEMU.

And doc can be updated in docs/devel/rust.rst, like Paolo's patch:

https://lore.kernel.org/qemu-devel/20250218080455.426383-1-pbonzini@redhat.com/

> diff --git a/rust/block/meson.build b/rust/block/meson.build
> new file mode 100644
> index 0000000000..ca93afd939
> --- /dev/null
> +++ b/rust/block/meson.build
> @@ -0,0 +1,20 @@
> +_block_rs = static_library(
> +  'block',
> +  files('src/lib.rs'),
> +  override_options: ['rust_std=2021', 'build.rust_std=2021'],
> +  rust_abi: 'rust',
> +  dependencies: [
> +    qemu_api_tools,
> +    qemu_api_macros,

I'm unsure without testing, the dependencies here looks different with
the Cargo.toml?

Regards,
Zhao


