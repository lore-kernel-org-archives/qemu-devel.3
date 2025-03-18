Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF5BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWMw-0005pi-I0; Tue, 18 Mar 2025 08:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHg-000082-6e; Tue, 18 Mar 2025 08:43:10 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHY-0002wy-Mt; Tue, 18 Mar 2025 08:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301777; x=1773837777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uOPuDQ/8Du8aSBzG3kAr7LjmXnlBH4ohlB+36Ri7rWI=;
 b=g4sH/x0j2GJ5NfLk4BPMG6IrV6xoCkHXnwPc3esr3pMUWwUrMxdv3wfy
 KoGHRJytuQHudlToxxvDHN+PAgx7PV6NYA6LcsNPE45fjYbbGAMzGwkpL
 43hmNYmEOC4m5FedptUvc+1hLLxWUB5nfcR7eObOadiNBk8qvi0qtG8oI
 kyLl4PWQI/jmbaMXINdfkqL5Pv1A02/mQNPKD/PW+K/1UMO6LpfSdBm7c
 /tSUcLfLmetxtO0/rFfW2E4/ux9c+ubvxABww9BuRnCjqzNt64KpVZaHZ
 LqWQ4iasEy76LRoH5o/EDm4KfzArNOZT70OvLMIZPG0cWDyT1vZszrf3N A==;
X-CSE-ConnectionGUID: Uas8xyp+RZ+DKtBiMcZqtw==
X-CSE-MsgGUID: +d7owt9HSZiQU54rfRfK3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824651"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824651"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:30 -0700
X-CSE-ConnectionGUID: 9WPdF0G/Q6GSeeL7ajUCpw==
X-CSE-MsgGUID: Bu8Gf5DcQJGIzaJrKFA9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980506"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 15/15] rust/vmstate: Include complete crate path of
 VMStateFlags in vmstate_clock
Date: Tue, 18 Mar 2025 21:02:19 +0800
Message-Id: <20250318130219.1799170-16-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318130219.1799170-1-zhao1.liu@intel.com>
References: <20250318130219.1799170-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

The use of "bindings::*" masks incomplete path of VMStateFlags.

Include complete crate path of VMStateFlags in vmstate_clock, and clean
up "bindings::*" in device_class.rs of pl011.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v2:
 * A new commit.
---
 rust/hw/char/pl011/src/device_class.rs | 8 ++++++--
 rust/qemu-api/src/vmstate.rs           | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 0b2076ddaa0f..b4d4a7eb432d 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -8,8 +8,12 @@
 };
 
 use qemu_api::{
-    bindings::*, c_str, prelude::*, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
-    vmstate_subsections, vmstate_unused, zeroable::Zeroable,
+    bindings::{qdev_prop_bool, qdev_prop_chr},
+    c_str,
+    prelude::*,
+    vmstate::VMStateDescription,
+    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    zeroable::Zeroable,
 };
 
 use crate::device::{PL011Registers, PL011State};
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9740931fb16a..1b2b12eadd6e 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -487,7 +487,10 @@ macro_rules! vmstate_clock {
                 $crate::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
-            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
+            flags: $crate::bindings::VMStateFlags(
+                $crate::bindings::VMStateFlags::VMS_STRUCT.0
+                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
+            ),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..$crate::zeroable::Zeroable::ZERO
         }
-- 
2.34.1


