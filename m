Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A416CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9A-0006qk-JC; Tue, 16 Sep 2025 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR93-0006eC-Gn; Tue, 16 Sep 2025 04:34:38 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8z-0005zx-GW; Tue, 16 Sep 2025 04:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011674; x=1789547674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5dOlQu9/LWVuyBR+Q9SafLwxJOv00jbSW+EcvT80qeI=;
 b=IzIiNn2Hu6kwT7jBTwTPUq7pHAu4IF3d/QF5FWUvjG4dZ07MZl2M4pe2
 vdC3XPXHUEfyoWomLJL9uJ5WKp9LtsUqi94HwzrsWuzCLCXt6osI2vBj8
 LBCKLAGrktpA3daTyUKwWua3Mi0/r88Z9mhojzDQWXJ45NmdqiHtzJvZd
 FpDVSNUp3ALEubhBA5+gtjtAJYUelAiLf37zIDyAiwY1Yz2OBcNSdfMxk
 DAoK0DsEPlZrkeJ6+F6RKiNDUgziFmPyzAuKVSqW5E+jNMtLB3qNPXk2m
 +zZkvcd7VFzozKpXAOnfDhBTux1oFvZUgQRY39IyAhSVH5TqrpuUhkArm A==;
X-CSE-ConnectionGUID: Pj/6j6k6Rny/J8r8B5xcwA==
X-CSE-MsgGUID: T9vLZnyLRWKSJ7y+6knONA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725172"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725172"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:20 -0700
X-CSE-ConnectionGUID: bcrpCV3OSjuK9oUIyX0WZQ==
X-CSE-MsgGUID: Jxg/NQnSQ3WgQwsTUo0XSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691062"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/12] rust/qdev: Refine the documentation for QDevProp trait
Date: Tue, 16 Sep 2025 16:55:51 +0800
Message-Id: <20250916085557.2008344-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Refine the documentation to clarify:
 * `unsfae` requires that `VALUE` must be valid.
 * using `*const` instead of `&` because the latter will cause compiler
   error.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 3ee5b242622d..2735e2b2c109 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -109,9 +109,16 @@ pub trait ResettablePhasesImpl {
 ///
 /// # Safety
 ///
-/// This trait is marked as `unsafe` because currently having a `const` refer to
-/// an `extern static` as a reference instead of a raw pointer results in this
-/// compiler error:
+/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
+/// reference to a [`bindings::PropertyInfo`].
+///
+/// Note we could not use a regular reference:
+///
+/// ```text
+/// const VALUE: &bindings::PropertyInfo = ...
+/// ```
+///
+/// because this results in the following compiler error:
 ///
 /// ```text
 /// constructing invalid value: encountered reference to `extern` static in `const`
@@ -119,7 +126,7 @@ pub trait ResettablePhasesImpl {
 ///
 /// This is because the compiler generally might dereference a normal reference
 /// during const evaluation, but not in this case (if it did, it'd need to
-/// dereference the raw pointer so this would fail to compile).
+/// dereference the raw pointer so using a `*const` would also fail to compile).
 ///
 /// It is the implementer's responsibility to provide a valid
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
-- 
2.34.1


