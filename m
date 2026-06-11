Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44E6CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZIP-00005t-BI; Thu, 11 Jun 2026 02:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIN-00005k-Oh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:43 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIM-0007XG-Au
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781160823; x=1812696823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CcoznjziQF4d1eDXcs4Y72p3P/Kd8w83UdlGdptqyPI=;
 b=Oo3kvjADpw4jhRYKA6i7J/9weCntdMwOPknQ+zkBy+Mn8ase4/JjMXh9
 nsVx5w6lP0DIEHbTb6CWzFhAtnHmglckAgxuHirmcUjJkbeLnHp0kZtaW
 g2FebWI+ybRHGnLEVVvQadY9pdqZrjmsw/5zAaBYJnsq8wK/WFfFOeE+p
 AvV9VjUPAcZX81Zct/tPi1BOmTizISrKVIQgiA4At8ZZMiGk4QaePs+B6
 t5BPID4J/x8P7Tyci6rWzcitQz3if/ypxcbT5EObSeoDKfwo5LH02kEUV
 70ZUEzXS1qCQsFu393W8y5e1/5uU4bSwOeXc8KjXSHq5R04PPfxBxxHVG g==;
X-CSE-ConnectionGUID: zlx6Uk+cSiuMVC+7zzAO3Q==
X-CSE-MsgGUID: xcfMlKsdTM+Bhoaou7Ve4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595451"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85595451"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:42 -0700
X-CSE-ConnectionGUID: xfEkZdzxTZCMTCfAcdPOJg==
X-CSE-MsgGUID: zz+fC0XlRVSsLQNZ5OPqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246469751"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:40 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH v2 1/5] hw/cxl: introduce trace-events infrastructure
Date: Thu, 11 Jun 2026 14:30:23 +0800
Message-ID: <20260611063027.1166493-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611063027.1166493-1-junjie.cao@intel.com>
References: <20260611063027.1166493-1-junjie.cao@intel.com>
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

The CXL subsystem currently has no trace-events file.  Create one under
hw/cxl/ and register it in the top-level meson.build
trace_events_subdirs list so that subsequent patches can add trace
points incrementally.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/trace-events | 1 +
 hw/cxl/trace.h      | 2 ++
 meson.build         | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h

diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
new file mode 100644
index 0000000000..23bc9b19b9
--- /dev/null
+++ b/hw/cxl/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.rst for syntax documentation.
diff --git a/hw/cxl/trace.h b/hw/cxl/trace.h
new file mode 100644
index 0000000000..ab87f3e98f
--- /dev/null
+++ b/hw/cxl/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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


