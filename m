Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B875C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl0PA-000530-TS; Thu, 20 Feb 2025 01:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0P8-00051z-4s; Thu, 20 Feb 2025 01:51:26 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0P2-0008TF-FU; Thu, 20 Feb 2025 01:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740034280; x=1771570280;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bPZyB3UyxsLxPfEp+jE5eBqj7VHmV8DUxAGnLjJ/W20=;
 b=nVWHdgF91NjsmE94/X95MCBBr6SQ2y6oRM476OJGimRGVLjw+7nYJTTk
 /Mru0Wup5WCXYTbyz8vYDf6Ql1khOfNyamV/+ogwPIyPcdpilDE87+Ym2
 TbkwDQysSMH0k2B2Meoi9z8+EWus7xAzR/uKux1AArO6RNEkDO7q9G+mu
 iL65M0FmC5C15Y8pm0UtA1hZ+bfC40zBNdlxHbzE6oietHdqDT0Vy2R4j
 Jt/Jd7SjpkwwBcjiuHTqJVy8SQy8KPs5BXbFyxohNtpBsGKaNhnsLoIWt
 B2WTUEoHV11Q7LXAPAtuyCjZz7PHYJmZotp91UZ/SZApIxd7if3TfP6kF Q==;
X-CSE-ConnectionGUID: qDO58JZ+S5iq8f+vyNTYiA==
X-CSE-MsgGUID: b+zsVLGRQWu5C2qocuGhgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39988455"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="39988455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 22:51:15 -0800
X-CSE-ConnectionGUID: IuCU9/SdTs+/WdwPknGB4A==
X-CSE-MsgGUID: sBeZVXEITo+lQSV24z71Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="138151695"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 19 Feb 2025 22:51:13 -0800
Date: Thu, 20 Feb 2025 15:10:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 01/11] rust: Build separate qemu_api_tools and
 qemu_api_system
Message-ID: <Z7bVeEwL2wkjvX5q@intel.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-2-kwolf@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> index 57747bc934..bc0393add4 100644
> --- a/rust/qemu-api/Cargo.toml
> +++ b/rust/qemu-api/Cargo.toml
> @@ -25,6 +25,7 @@ version_check = "~0.9"
>  default = ["debug_cell"]
>  allocator = []
>  debug_cell = []
> +system= []

With this new feature, we also need to declear the this feature flag to
pl011 & hpet's Cargo.toml:

qemu_api = { path = "../../../qemu-api", features = ["system"] }

>  [lints]
>  workspace = true
> diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
> index 471e6c633d..b14f9d4e4a 100644
> --- a/rust/qemu-api/build.rs
> +++ b/rust/qemu-api/build.rs
> @@ -16,7 +16,13 @@ fn main() -> Result<()> {
>      let path = env::var("MESON_BUILD_ROOT")
>          .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
>  
> -    let file = format!("{}/bindings.inc.rs", path);
> +    let basename = if cfg!(feature = "system") {
> +        "bindings_system.inc.rs"
> +    } else {
> +        "bindings_tools.inc.rs"
> +    };
> +

Missing to update rust/qemu-api/.gitignore :-)

(I'm still learning your series and currently just trying out the compilation.)

Thanks,
Zhao


