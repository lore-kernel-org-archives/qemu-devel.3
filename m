Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6491DC7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 07:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTbN6-0003Dp-0q; Mon, 23 Jun 2025 03:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTbMz-0003CP-Qn; Mon, 23 Jun 2025 03:13:35 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTbMu-0006X4-Qh; Mon, 23 Jun 2025 03:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750662809; x=1782198809;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qOl7mHK6TK3aNhs6+gjydbgxV9RfzDGdv3wDQBk3UDE=;
 b=NC+KQ8EMkCIFWwdLkNnzjyOfXvySZagea9qVdGpq9X46mwho3wohly5f
 EZYqsBWQ+C/xdiQ9b36PmqMMVPaSjsqorr0sYmg2/if9gRT8M0idrqUri
 KLQEta733/dX2vktgqfIzgenOmzrcXpT2SfwxMTYEp/1lQKn/Cv9O37++
 92V68BQeQ7We3D3+ji2yUQGrC+2nmkcIRATbCG3RJLwwAxL/EYEfhkjpM
 0UlSo2ir2jMgMQfyupZZpqtHkIviLqmHoEUw2GPCuN+047t4fa6eMslg6
 BNrjnnZze6GX4PJPObOYfwToQV69UONG0t3Vj/ohqvBM0wGLcibss4ggv A==;
X-CSE-ConnectionGUID: OmIrM+W2TTerNc28nIIrpg==
X-CSE-MsgGUID: KX5II8ApR9mdSGFjF0A63g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56526768"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="56526768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 00:13:24 -0700
X-CSE-ConnectionGUID: PCMeYeJwRDSaVYiADSry+g==
X-CSE-MsgGUID: 3Oue4hlDSCSybtk4n698SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="155819621"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 00:13:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust/qemu-api: Fix binding path in source directory
Date: Mon, 23 Jun 2025 15:34:36 +0800
Message-Id: <20250623073436.1833357-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

The build.rs had supported placing bindings.inc.rs in rust/qemu-api/src,
but this "not encouraged" feature is broken.

Considering that manually copying bindings.inc.rs to the development
directory is also useful, fix the bindings.inc.rs path generation to
give this feature another chance.

Fixes: commit 1ae4ca0463d7 ("rust: move rust.bindgen to qemu-api crate")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/build.rs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 7849486c1baf..29d09456257c 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -9,12 +9,14 @@
 use std::{env, fs::remove_file, io::Result, path::Path};
 
 fn main() -> Result<()> {
-    // Placing bindings.inc.rs in the source directory is supported
-    // but not documented or encouraged.
-    let path = env::var("MESON_BUILD_ROOT")
-        .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        format!("{root}/rust/qemu-api/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+    };
 
-    let file = format!("{path}/rust/qemu-api/bindings.inc.rs");
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
-- 
2.34.1


