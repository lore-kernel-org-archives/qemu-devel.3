Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC423CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUalc-0006nR-AK; Tue, 02 Jun 2026 21:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUala-0006mb-8N
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:34 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalY-0003f5-3C
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780451492; x=1811987492;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aR4nqQX7ZJ7fUfst5OzjdFIDEHT017X2nA0rRVOc7Gk=;
 b=LZq3lnPu6K8NkDn8D3YKU2HYVK405/H4ZUV0MpCblFQGhfsOUkTJ5du5
 oE6fHwua3BVLSGlTPkhLTaLueo0udbpwbfrm3quFpt5+eGGQBtUyxubzf
 5sYafYeoeZN7EMxG0yAZrVlccYRUYOSEFpG2n7Ab4PimeUrQOr8m45LtG
 /Rgnq1nEtdOzAaP5NKs4N457Fb9s5mwhpLQvh6UPhc/AhgZjknCzAg8/o
 5eskDfjwKWC2QT496gM40Tb840uElI90ncbJRn8tQOdDvaWnQFhv8qz4v
 n2tb8n08SUyUkGxOXZFrIJ8zU768b+hWlhXfvSP8hWU4iGXHmX3h/BxWU A==;
X-CSE-ConnectionGUID: XhH4MdwTTNiiOYV520g5LA==
X-CSE-MsgGUID: VjD+IQOJRjWEzHnzpiSoag==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84875613"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="84875613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:27 -0700
X-CSE-ConnectionGUID: /sGT4WABQqSOxpL5juP31A==
X-CSE-MsgGUID: aZbemsqoSQqke3OIsd1Ilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248387720"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:25 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: [PATCH 0/3] hw/cxl: add trace-events coverage
Date: Wed,  3 Jun 2026 09:34:17 +0800
Message-ID: <20260603013420.904749-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
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

The CXL subsystem in QEMU currently has no trace coverage: hw/cxl/
does not have its own trace-events file, and there are no trace_*()
calls across hw/cxl/ or hw/mem/cxl_type3.c. Debugging mailbox
commands, HDM decoder programming, CDAT ingestion, event log
activity, and CFMWS address decoding currently relies on temporary
printf instrumentation or qemu_log_mask output. Trace events offer a
more structured mechanism for observing these paths during
development.

This series introduces trace-events infrastructure for the CXL
subsystem and adds 12 trace points covering the paths listed above.
The events all use the cxl_ prefix so a single -trace 'cxl_*'
captures everything. The two cxl_hdm_decoder_* events live in the
existing hw/mem/trace-events alongside the file they trace
(hw/mem/cxl_type3.c); the cxl_ prefix preserves the unified
filtering UX.

Each patch is independent and corresponds to a self-contained debug
scenario:

  1/3 trace infrastructure + mailbox dispatch
      - cxl_mailbox_command, cxl_mailbox_invalid_payload,
        cxl_mailbox_handler_return

  2/3 HDM decoder commit + CDAT load
      - cxl_hdm_decoder_write, cxl_hdm_decoder_commit,
        cxl_cdat_init, cxl_cdat_loaded

  3/3 event log + CFMWS HPA -> device decoding
      - cxl_event_insert, cxl_event_overflow, cxl_event_clear
      - cxl_cfmws_lookup, cxl_cfmws_target_resolved

Junjie Cao (3):
  hw/cxl: add trace-events for mailbox dispatch
  hw/cxl: trace HDM decoder commit and CDAT load
  hw/cxl: trace event log activity and CFMWS address decoding

 hw/cxl/cxl-cdat.c          |  3 +++
 hw/cxl/cxl-events.c        |  8 +++++++-
 hw/cxl/cxl-host.c          |  4 ++++
 hw/cxl/cxl-mailbox-utils.c |  5 +++++
 hw/cxl/trace-events        | 21 +++++++++++++++++++++
 hw/cxl/trace.h             |  4 ++++
 hw/mem/cxl_type3.c         | 17 ++++++++++++++++-
 hw/mem/trace-events        |  4 ++++
 meson.build                |  1 +
 9 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h


base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
--
2.43.0


