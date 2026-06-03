Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E77CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUalf-0006o6-KS; Tue, 02 Jun 2026 21:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalb-0006nG-KL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:35 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalZ-0003fq-EK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780451494; x=1811987494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OYWkLcP9nBYSGNEgNcwSidJzJa7+Mo1aAZ1XxU1pqHA=;
 b=F7qKJiwtjimErLpfRbk+s2Ez5Qq7AaAItt1op6Nt8RFw8jr6T0lDWxLz
 BXldaH3rkoXLZJ9iu4DiM4AgHiveyjKlgavwvIgHo2DAwxLNoucLc7oh0
 9abLDu+PeoLd3Wjkr67x77t/O4zvcYBqRcPQgz3dh4TCGAo39OOdhmqiG
 Anpzz6Dw9oiwc86Fs9YpWv57/hr6UkWHOxITLde6zK5oPhkpBGYMrgtQU
 +WVRKfKrQqUsLAB/qOjbmTRUON04L3hSihj+almZADlyqcQBu/15NexH7
 /PfHUznTFsViYrOiCfxw0K7xBFz59fhPSeB3Bv6ESUfEDIcEUcr/uc+Ws w==;
X-CSE-ConnectionGUID: GncQWjMJRvSCgxwpvmeAug==
X-CSE-MsgGUID: ILBCOQwFS4iwsJwLHHGxpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84875623"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="84875623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:32 -0700
X-CSE-ConnectionGUID: gYw9qi65QNO4G5d+fL+KTA==
X-CSE-MsgGUID: /fEwf1m7Scipps1AEEBOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248387746"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:30 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: [PATCH 1/3] hw/cxl: add trace-events for mailbox dispatch
Date: Wed,  3 Jun 2026 09:34:18 +0800
Message-ID: <20260603013420.904749-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603013420.904749-1-junjie.cao@intel.com>
References: <20260603013420.904749-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The CXL subsystem currently has no trace coverage. Debugging mailbox
command flow requires either printf or qemu_log_mask, neither of which
is well suited for following the dispatch path that is exercised by
every guest driver probe.

Introduce a dedicated trace-events file under hw/cxl/ and wire it into
the build via the trace_events_subdirs list in the top-level
meson.build. Add three trace points covering command entry, payload
validation, and handler completion in cxl_process_cci_message():

  * cxl_mailbox_command          - command entry (opcode, len_in)
  * cxl_mailbox_invalid_payload  - payload length check rejection
  * cxl_mailbox_handler_return   - handler completion with return code
                                   and len_out

The early-exit paths for unimplemented commands, in-progress background
operations, and disabled media skip handler dispatch and are therefore
not paired with cxl_mailbox_handler_return; an absent return event for
a given cxl_mailbox_command identifies these cases in the trace stream.

Trace points use the cxl_ prefix so future patches in this subsystem
share a single namespace, allowing -trace 'cxl_*' to match all of them.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 +++++
 hw/cxl/trace-events        | 8 ++++++++
 hw/cxl/trace.h             | 4 ++++
 meson.build                | 1 +
 4 files changed, 18 insertions(+)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..521b8c6334 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,6 +27,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "trace.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -4580,6 +4581,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     CXLDeviceState *cxl_dstate;
 
     *len_out = 0;
+    trace_cxl_mailbox_command((set << 8) | cmd, len_in);
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (!h) {
@@ -4589,6 +4591,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
+        trace_cxl_mailbox_invalid_payload((set << 8) | cmd, len_in,
+                                          cxl_cmd->in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -4642,6 +4646,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
+    trace_cxl_mailbox_handler_return((set << 8) | cmd, ret, *len_out);
     return ret;
 }
 
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
new file mode 100644
index 0000000000..abca116ed3
--- /dev/null
+++ b/hw/cxl/trace-events
@@ -0,0 +1,8 @@
+# See docs/devel/tracing.rst for syntax documentation.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# cxl-mailbox-utils.c
+cxl_mailbox_command(uint16_t opcode, size_t len_in) "opcode=0x%04x len_in=%zu"
+cxl_mailbox_invalid_payload(uint16_t opcode, size_t len_in, size_t expected) "opcode=0x%04x len_in=%zu expected=%zu"
+cxl_mailbox_handler_return(uint16_t opcode, int ret, size_t len_out) "opcode=0x%04x ret=%d len_out=%zu"
diff --git a/hw/cxl/trace.h b/hw/cxl/trace.h
new file mode 100644
index 0000000000..84e79d50c0
--- /dev/null
+++ b/hw/cxl/trace.h
@@ -0,0 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "trace/trace-hw_cxl.h"
diff --git a/meson.build b/meson.build
index 19e123423b..c229199d5d 100644
--- a/meson.build
+++ b/meson.build
@@ -3596,6 +3596,7 @@ if have_system
     'hw/audio',
     'hw/block',
     'hw/char',
+    'hw/cxl',
     'hw/display',
     'hw/dma',
     'hw/fsi',
-- 
2.43.0


