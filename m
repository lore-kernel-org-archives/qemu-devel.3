Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27471CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZIO-00005Z-1j; Thu, 11 Jun 2026 02:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIJ-000056-Be
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:41 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIG-0007XG-NY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781160817; x=1812696817;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w+NWyNCiA9FPJArTEmBIfUD57JuYWKayWZ3GY406jSg=;
 b=McLVU4WuNIC3m8R7wrNmvMWp3Xyee0Xr3BlbtnND6kmNa5tX3jQWfWUz
 +Iej675VwS8eyTRwCyjF6I1g0VkXVxrCUskjEK2LwFVoteHOnv0sQcu+8
 Ol54zbKpjxt6fpp5AsFxZQTQoOG80+SG3fSswu+MebsFgXbPFlmrCtH6+
 8pAg6DIpNR7URkUTsyqCKMldFcMsivq2VcbhU3yweeOFzYitEPf5U/iTb
 baPs9BuoLkYRWp4xXtzidXZ1zBHyrOjA01iPXClIo9QQCw5WVf8WPv7me
 3uBNYL7dyYH7MpAk1dm0/dd6ZjzctIwuUI8YSXNdDsF5YIOzgjbGeHI1E Q==;
X-CSE-ConnectionGUID: uBNwMpxVRiejboxtH29nwA==
X-CSE-MsgGUID: /hRzgm+TRhGCQsY2TsOPOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595413"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85595413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:34 -0700
X-CSE-ConnectionGUID: kUOFblCmREWuBer6+Y8LLA==
X-CSE-MsgGUID: oUJ7Vc7BTCiksKvtspAqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246469695"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH v2 0/5] hw/cxl: add trace-events coverage
Date: Thu, 11 Jun 2026 14:30:22 +0800
Message-ID: <20260611063027.1166493-1-junjie.cao@intel.com>
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

The CXL subsystem in QEMU currently has no trace coverage.  Debugging
mailbox commands, HDM decoder programming, event log activity, and
CFMWS address decoding relies on temporary printf or qemu_log_mask.

This series introduces trace-events infrastructure for the CXL
subsystem and adds 11 trace points covering the above paths.  All
events use the cxl_ prefix so -trace 'cxl_*' captures everything.

Changes since v1:
  - Split patch 2 into HDM-only; dropped CDAT traces -- source is
    commandline-controlled (Jonathan)
  - Split patch 3 into separate event-log and CFMWS patches (Jonathan)
  - Pass set and cmd as separate uint8_t parameters instead of a
    combined opcode (Jonathan)
  - Cover all 21 CXL_MBOX_INVALID_PAYLOAD_LENGTH return sites, not
    just the centralised entry check (Jonathan)
  - Rename depth -> occupancy in event log trace (Jonathan)
  - Defer passthrough-specific trace pending upstream support (Jonathan)
  - Add cxl_hdm_decoder_uncommit for commit/uncommit symmetry

v1: https://lore.kernel.org/qemu-devel/20260603013420.904749-1-junjie.cao@intel.com/

Junjie Cao (5):
  hw/cxl: introduce trace-events infrastructure
  hw/cxl: trace mailbox command dispatch and payload errors
  hw/cxl: trace HDM decoder write, commit and uncommit
  hw/cxl: trace event log insertion, overflow and clear
  hw/cxl: trace CFMWS address-to-device routing

 hw/cxl/cxl-events.c         | 13 +++++--
 hw/cxl/cxl-host.c           |  4 +++
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++--
 hw/cxl/trace-events         | 15 ++++++++
 hw/cxl/trace.h              |  2 ++
 hw/mem/cxl_type3.c          | 19 +++++++++-
 hw/mem/trace-events         |  5 +++
 include/hw/cxl/cxl_device.h |  1 +
 meson.build                 |  1 +
 9 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h

-- 
2.43.0


