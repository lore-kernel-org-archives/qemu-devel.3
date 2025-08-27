Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36256CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urGwk-0006BN-8U; Wed, 27 Aug 2025 10:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urGwg-00069J-OE; Wed, 27 Aug 2025 10:16:15 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urGwe-0005Pv-4K; Wed, 27 Aug 2025 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756304172; x=1787840172;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=QZcgxXn/WefyHuhkOr0kLRoJkiy4L49DP7WrUMKn3q4=;
 b=k6hFREW05iAJzJy1JIe4ZIqAzgjZA13HbG6G0ZEOdenDq2W99oY0yWjP
 /IUBTWrOipKCyRkjyTue8jycq0FOytfVVkKmWbbGYWnJby/t/zzl5KibO
 c3DWSDtRKky14flltulHlu40pIVfssGbI65WfaGo+zrd2gG7u0ScHvf3L
 RK5vYVwAIHF2P4CKYXkqH8MGFRo1nqgPb57Kfn9UuuKgGQIPeqVuZL5ll
 fPpqP9uWUIhHdLs+HhvFoJ0dtrEK0Bh/zdY3lkEMsxnMrFf1sj4M1W0AL
 2jNo+KZXsKeC8qeCJMMcNcHNufPE/ZzxMypmfgkf8QWUrGpzOUeMyR5F6 Q==;
X-CSE-ConnectionGUID: Zk5AcQHyQue/suS/stVgfQ==
X-CSE-MsgGUID: jEJr/ORYR8KH+K4NryGWFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69149403"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69149403"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:16:06 -0700
X-CSE-ConnectionGUID: hMdQxRrsQaerlcl0NbxHdQ==
X-CSE-MsgGUID: CvfpyM80Q1SIw/cuNSslPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="175152822"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 27 Aug 2025 07:16:03 -0700
Date: Wed, 27 Aug 2025 22:37:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 01/22] docs/rust: update msrv
Message-ID: <aK8YPt8vt5XN0vDI@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-2-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 27, 2025 at 02:41:23PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:23 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 01/22] docs/rust: update msrv
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/rust.rst | 2 +-
>  rust/Cargo.toml     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index b6737536c6..f52da6f97e 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -1,4 +1,4 @@
> -.. |msrv| replace:: 1.63.0
> +.. |msrv| replace:: 1.77.0
>
>  Rust in QEMU
>  ============
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 0868e1b426..56cfe07791 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -13,6 +13,7 @@ edition = "2021"
>  homepage = "https://www.qemu.org"
>  license = "GPL-2.0-or-later"
>  repository = "https://gitlab.com/qemu-project/qemu/"
> +# don't forget to update docs/devel/rust.rst msrv

Good comment!

>  rust-version = "1.77.0"
>  

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


