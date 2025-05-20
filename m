Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F919C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOZa-0001ej-BV; Tue, 20 May 2025 11:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYc-0008G2-71; Tue, 20 May 2025 11:07:06 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYa-00030C-B2; Tue, 20 May 2025 11:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747753624; x=1779289624;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cxgum9TX1QPsBP6Jb40nvu24gmmxFOS5W0fX50LFfbQ=;
 b=nB7npsVkKOYtktgfoBWuyOPHQaAouMaSKpn+gbYD+h0roJ6I67WgH0BV
 m4A3e59c3grdtaQ5dNVezUH7azt34T9DTom0qSC5ThtnYji9N9I0gwKUx
 LaOk/X0ej2HcRpSrq7/QVwu0oPwCOL2JKQgcAaZW/xQp+C44W2b3H9tO/
 LmEy4pZC49Tl1jZChRzB2fETK2XskI0vzrq7VPqb1uioyTqbszbd590HC
 rgRp1UDBFxp3BUgZg3YZ2rPWh98fcecUKaVe3QH4VPYIriJrCK+rcgyQR
 ERYPf62yaIIGSCMhgLT/cgItDB0V0jhlRpL8q/xBpyC7Yl2V5tJB+jWoZ g==;
X-CSE-ConnectionGUID: /24fl3MAR9W97DJw9Q1y9Q==
X-CSE-MsgGUID: SmQxXve4QT+l2gsfxAHe9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59922543"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="59922543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 08:06:57 -0700
X-CSE-ConnectionGUID: U7WzDWE7S2GZB2PlAipwng==
X-CSE-MsgGUID: cWzzizZmRji0gd674gSzWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144461890"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 May 2025 08:06:51 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/5] rust: Fix Zhao's email address
Date: Tue, 20 May 2025 23:27:49 +0800
Message-Id: <20250520152750.2542612-5-zhao1.liu@intel.com>
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

No one could find Zhao Liu via zhai1.liu@intel.com.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs     | 2 +-
 rust/hw/timer/hpet/src/hpet.rs       | 2 +-
 rust/hw/timer/hpet/src/lib.rs        | 2 +-
 rust/qemu-api/src/bitops.rs          | 2 +-
 rust/qemu-api/src/timer.rs           | 2 +-
 rust/qemu-api/tests/vmstate_tests.rs | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index aa08d2835194..6c10316104ce 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::ptr::addr_of_mut;
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 6cc6fa0aeda0..8f68372dee52 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 1954584a87e9..141aae229d4d 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! # HPET QEMU Device Model
diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
index 023ec1a99831..b1e3a530ab54 100644
--- a/rust/qemu-api/src/bitops.rs
+++ b/rust/qemu-api/src/bitops.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! This module provides bit operation extensions to integer types.
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 868bd88575f2..0a2d111d4909 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index ad0fc5cd5dd0..bded836eb608 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2025 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-- 
2.34.1


