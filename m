Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03001FD065A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0FCF-0006iX-1C; Wed, 11 Mar 2026 04:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0FBs-0006g0-KN; Wed, 11 Mar 2026 04:45:17 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0FBp-0005bn-9o; Wed, 11 Mar 2026 04:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773218713; x=1804754713;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mMOpQWW+g/XMluBRVCg1iH8ilkZo2rzj7MAi1sLNRgQ=;
 b=RuaeKcIKUoND8K9dZCZFE0Ph4s8PVtydDZTol4p6dHLWspm5THkcRgfx
 XAnf92xagGW10mpp5LhIjRoxmZGMzq4Gb6krGLghOQkXIh/4rEVKfn20K
 JK86U9b8/t20yCFohYBuhJBS2NqXj5I2e8vZk02YD0SS1BG9uVVkhURwZ
 sKGyW20QG3e+9B8T8yaAOSkkVYaCV3e5O7W/o0yGxFp8eG7CERp6lSzGK
 o9e5MI6yVufrgI0IynVbeLnneSj6aCNjJ6Us4Fya7+1yS8hK2Fp8NqU75
 WlOu+MSWpqOxbyeEngKSik4xVPAt4sJbUzuX+gZKXFWKp6CDKzr6dHfro g==;
X-CSE-ConnectionGUID: wa7Mo25QSLqxRTSMPhPkuQ==
X-CSE-MsgGUID: NN1xHqzxTViwan3lzajTKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84912063"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="84912063"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 01:45:07 -0700
X-CSE-ConnectionGUID: iiWDx0N+Ro+r/7MFFdQsBg==
X-CSE-MsgGUID: a6TDZtKGSoepWLJVVcJduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220575290"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 11 Mar 2026 01:45:04 -0700
Date: Wed, 11 Mar 2026 17:11:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] rust: Update Cargo.lock
Message-ID: <abExs0JTxGeTSY8U@intel.com>
References: <20260309172440.66409-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309172440.66409-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 06:24:40PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 18:24:40 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH] rust: Update Cargo.lock
> X-Mailer: git-send-email 2.53.0
> 
> Update Cargo.lock on top of commit  7ecd3f71079 ("Merge tag
> 'for-upstream' of https://gitlab.com/bonzini/qemu into staging").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  rust/Cargo.lock | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

When I ran `cargo +nightly build`, I met this error:

$ cargo +nightly build
   Compiling system-sys v0.1.0 (/media/liuzhao/data/qemu-cook/rust/bindings/system-sys)
error[E0432]: unresolved import `hwcore_sys`
  --> bindings/system-sys/lib.rs:22:5
   |
22 | use hwcore_sys::{qemu_irq, DeviceClass, DeviceState};
   |     ^^^^^^^^^^ use of unresolved module or unlinked crate `hwcore_sys`
   |
   = help: if you wanted to use a crate named `hwcore_sys`, use `cargo add hwcore_sys` to add it to your `Cargo.toml`

For more information about this error, try `rustc --explain E0432`.
error: could not compile `system-sys` (lib) due to 1 previous error

This is because of the wrong dependency relationship in Cargo.toml of
hwcore-sys & system-sys.

But the fix for this error will bring a little more change in
Cargo.lock (since the dependencies will change).

What about fixing this build bug first before updating Cargo.lock?

(That's a fix for build error I met.)
-------------------------------->8-------------------------------
From cc96c5530f5fe75eb0a422b092dbb761547e7514 Mon Sep 17 00:00:00 2001
From: Zhao Liu <zhao1.liu@intel.com>
Date: Wed, 11 Mar 2026 17:00:51 +0800
Subject: [PATCH] rust: Fix wrong dependencies for cargo

There's a build error:

$ cargo +nightly build
   Compiling system-sys v0.1.0 (/media/liuzhao/data/qemu-cook/rust/bindings/system-sys)
error[E0432]: unresolved import `hwcore_sys`
  --> bindings/system-sys/lib.rs:22:5
   |
22 | use hwcore_sys::{qemu_irq, DeviceClass, DeviceState};
   |     ^^^^^^^^^^ use of unresolved module or unlinked crate `hwcore_sys`
   |
   = help: if you wanted to use a crate named `hwcore_sys`, use `cargo add hwcore_sys` to add it to your `Cargo.toml`

For more information about this error, try `rustc --explain E0432`.
error: could not compile `system-sys` (lib) due to 1 previous error

This is because hwcore-sys & system-sys have the wrong dependencies
relationship in their Cargo.toml.

Fix the dependencies of hwcore-sys & system-sys in Cargo.toml, aligning
the dependencies described in their meson.build files.

Fixes: commit c899071b5a86 ("rust: move binding generation to bindings/")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/bindings/hwcore-sys/Cargo.toml | 1 -
 rust/bindings/system-sys/Cargo.toml | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bindings/hwcore-sys/Cargo.toml b/rust/bindings/hwcore-sys/Cargo.toml
index c20024e921a1..b5ae33da8ed6 100644
--- a/rust/bindings/hwcore-sys/Cargo.toml
+++ b/rust/bindings/hwcore-sys/Cargo.toml
@@ -21,7 +21,6 @@ chardev-sys = { path = "../chardev-sys" }
 qom-sys = { path = "../qom-sys" }
 migration-sys = { path = "../migration-sys" }
 util-sys = { path = "../util-sys" }
-system-sys = { path = "../system-sys" }

 [lints]
 workspace = true
diff --git a/rust/bindings/system-sys/Cargo.toml b/rust/bindings/system-sys/Cargo.toml
index 7e527130ff5d..bbb4eaa53db3 100644
--- a/rust/bindings/system-sys/Cargo.toml
+++ b/rust/bindings/system-sys/Cargo.toml
@@ -17,6 +17,7 @@ path = "lib.rs"
 [dependencies]
 glib-sys = { workspace = true }
 common = { path = "../../common" }
+hwcore-sys = { path = "../hwcore-sys" }
 migration-sys = { path = "../migration-sys" }
 util-sys = { path = "../util-sys" }
 qom-sys = { path = "../qom-sys" }
--
2.34.1



