Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD8C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJUF-00038A-7D; Tue, 18 Feb 2025 04:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJU8-00037K-AC; Tue, 18 Feb 2025 04:01:46 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJU5-0005WF-DS; Tue, 18 Feb 2025 04:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739869302; x=1771405302;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qIHNCAX6kyKPE7zvr1dVSW7aT1fzA5e5v+pzLCf8QME=;
 b=IQkyFaL5s8npnsc+blO0iEHLoZgN/Rb3eJhPtr2KFznTgsOOW10wg4qN
 DldTiidRdYbmRDdQ7tfuuNaa+MohlxHhq3Zh+rUX67nK1yaLPAQya8vaR
 I+V5nWxchFYcGEuL566qOu5Xw2VwCmFXgajO0bLNBjr8l6C8RXYaBgMhi
 gR4CmNTSm0YSRH3iTVKQxqOBl8pi3ohZhZ9uoeDdZgqPxRWR0UjygF7Ro
 g/oKggVJ5S1I2dOnzqDX2Ptst+D4zIZlPC5ViiFyJP6vvLGysHYoKpA4V
 rBFs5FL6+Z0BG1vLWcS3xFcJFfXAoeD3q2MBaoDx1f3u4Lf42qewgRZ+m w==;
X-CSE-ConnectionGUID: EjqdGlEURqKcsg3lJ2a0Sw==
X-CSE-MsgGUID: bOBQnGiXQueXUKITpNX9zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51176438"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51176438"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:01:36 -0800
X-CSE-ConnectionGUID: GeGp+u36RumwEyYKVKywCw==
X-CSE-MsgGUID: BGd/NjZ/Q06CLpCe5nFYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118973143"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2025 01:01:35 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust: Fix the typos in doc
Date: Tue, 18 Feb 2025 17:21:08 +0800
Message-Id: <20250218092108.3347963-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

These typos are found by "cargo spellcheck". Though it outputs a lot of
noise and false positives, there still are some real typos.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qom.rs         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index fe73771021e7..e064da31be96 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -477,13 +477,13 @@ pub fn post_load(&mut self) -> Result<(), ()> {
 }
 
 impl PL011State {
-    /// Initializes a pre-allocated, unitialized instance of `PL011State`.
+    /// Initializes a pre-allocated, uninitialized instance of `PL011State`.
     ///
     /// # Safety
     ///
     /// `self` must point to a correctly sized and aligned location for the
     /// `PL011State` type. It must not be called more than once on the same
-    /// location/instance. All its fields are expected to hold unitialized
+    /// location/instance. All its fields are expected to hold uninitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
         static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 3d5ab2d90186..72e637868a9e 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -245,7 +245,7 @@ fn as_object(&self) -> &Object {
     }
 
     /// Return the receiver as a const raw pointer to Object.
-    /// This is preferrable to `as_object_mut_ptr()` if a C
+    /// This is preferable to `as_object_mut_ptr()` if a C
     /// function only needs a `const Object *`.
     fn as_object_ptr(&self) -> *const Object {
         self.as_ptr().cast()
@@ -517,7 +517,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
     /// `INSTANCE_INIT` functions have been called.
     const INSTANCE_POST_INIT: Option<fn(&Self)> = None;
 
-    /// Called on descendent classes after all parent class initialization
+    /// Called on descendant classes after all parent class initialization
     /// has occurred, but before the class itself is initialized.  This
     /// is only useful if a class is not a leaf, and can be used to undo
     /// the effects of copying the contents of the parent's class struct
-- 
2.34.1


