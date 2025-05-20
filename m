Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C993AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOZB-0000dz-MG; Tue, 20 May 2025 11:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYa-0008B0-HG; Tue, 20 May 2025 11:07:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYY-0002za-Ji; Tue, 20 May 2025 11:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747753623; x=1779289623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ifXIFaK3P0jlcn0kIXOIQM5Yvn/iFff3tBlWKMGRt5w=;
 b=NKeui/ztZ77Ab7gQc1pdYgkENXUbOTiq9BIkDgRnBgsFkAA6h5UhPrXz
 7E/mu/F/tAUlEiq9wUHC236i5XIrCg31dH9VoDgXi/fsUUUEuiiH3me91
 mvPmPpvGg0WTpvZfXox8xXmV6tGWiGusmZZRCejsPtAz+i/EWi5qprrFA
 VFaJ9eZ41k7eBuXXaO7D6F+ZjG1k+NzexzVUBRwGPATQ/vhEyzSyrSPt1
 7r7V25P4F7JaPYUxzXsBwmoLxHb6xLRtuwbqEP6X5BEiy3/HWzFrlP9JL
 +hBP7qbxL28ZG8ZbJXw3I1UoNd/FO0OmqiMsa7uC8MFStHHnw4S6eBdDG Q==;
X-CSE-ConnectionGUID: WGMQYu6gQ2y/aWSE75nMvg==
X-CSE-MsgGUID: RiMREqF1ROWnt6zemczVVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59922546"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="59922546"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 08:06:57 -0700
X-CSE-ConnectionGUID: AjelRlkjRTatyIf49x3WEg==
X-CSE-MsgGUID: qPomVkvtQMKnBbDIsK423w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144461908"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 May 2025 08:06:53 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/5] rust: Fix the typos in doc
Date: Tue, 20 May 2025 23:27:50 +0800
Message-Id: <20250520152750.2542612-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520152750.2542612-1-zhao1.liu@intel.com>
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

These typos are found by "cargo spellcheck". Though it outputs a lot of
noise and false positives, there still are some real typos.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note: But I have to admit, cargo spellcheck isn't a great tool.

Picked from <20250218092108.3347963-1-zhao1.liu@intel.com> with checking
again.
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qom.rs         | 4 ++--
 rust/qemu-api/src/vmstate.rs     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bde3be65c5b0..bd5cee046473 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -480,13 +480,13 @@ pub fn post_load(&mut self) -> Result<(), ()> {
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
index 41e5a5e29a82..14f98fee60ab 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -291,7 +291,7 @@ fn as_object(&self) -> &Object {
     }
 
     /// Return the receiver as a const raw pointer to Object.
-    /// This is preferrable to `as_object_mut_ptr()` if a C
+    /// This is preferable to `as_object_mut_ptr()` if a C
     /// function only needs a `const Object *`.
     fn as_object_ptr(&self) -> *const bindings::Object {
         self.as_object().as_ptr()
@@ -485,7 +485,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// `INSTANCE_INIT` functions have been called.
     const INSTANCE_POST_INIT: Option<fn(&Self)> = None;
 
-    /// Called on descendent classes after all parent class initialization
+    /// Called on descendant classes after all parent class initialization
     /// has occurred, but before the class itself is initialized.  This
     /// is only useful if a class is not a leaf, and can be used to undo
     /// the effects of copying the contents of the parent's class struct
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9c8b2398e9d4..812f390d7802 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -9,7 +9,7 @@
 //! * [`vmstate_unused!`](crate::vmstate_unused) and
 //!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
-//!   which is defined by all migrateable types.
+//!   which is defined by all migratable types.
 //!
 //! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
 //!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), which help with
-- 
2.34.1


