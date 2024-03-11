Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EADC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjaJ8-0006oL-Mz; Mon, 11 Mar 2024 03:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaJ3-0006mQ-4s
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:47 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaJ1-0006O0-Lf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710142963; x=1741678963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cdkipYG8gT3vw8zhnJLXFox5OUOd0vNDUg2QN7WEIMY=;
 b=f9K504nCzYa4OfY4rofkxo7G4ZC7p6zmfsrZn0rreme1dTtP/5f6H6uy
 IqtvqDJ75d2ECqtgeFA923zw/7NaXn0emZoLnrj4rSFSwBIlJiCbPySFX
 OMrri5/b5ubwNP25MR/QSFbT3dJrYnRAdKVQhzO24jsTRG7El7WSGMP6m
 kmhhdpH9y4/pdSkzb5HqM4IsCU8DKCGuJFRH2BoJt0bf9iEa0T5kSXtEC
 yexwJdOgeAl4M7Zz2aaeP9Scy61sQciOHrEu5YsOL4JGpZelLay04bKNJ
 vnFCAl257LcIO13cBzg7fffrB9VMH52VmtBslTU0lpK+em02uBO3EzGRz g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="16229088"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="16229088"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 00:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="34215938"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2024 00:42:40 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 3/3] hw/core: Cleanup unused included headers in numa.c
Date: Mon, 11 Mar 2024 15:56:21 +0800
Message-Id: <20240311075621.3224684-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove unused header in numa.c:
* qemu/bitmap.h
* migration/vmstate.h

Note: Though parse_numa_hmat_lb() has the variable named "bitmap_copy",
it doesn't use the normal bitmap ops so that it's safe to exclude
qemu/bitmap.h header.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v3: Re-included hw/core/cpu.h since CPU_UNSET_NUMA_NODE_ID is defined
    in this header.
---
 hw/core/numa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0ff..81d21243498e 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -28,7 +28,6 @@
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
-#include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
@@ -36,7 +35,6 @@
 #include "sysemu/qtest.h"
 #include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
-#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
-- 
2.34.1


