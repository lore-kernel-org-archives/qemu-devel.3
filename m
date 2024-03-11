Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F7C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjaJ8-0006ob-VD; Mon, 11 Mar 2024 03:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaJ0-0006lO-I4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:42 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaIx-0006N2-T6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710142960; x=1741678960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1JG2JjXlFkX+NfQ7eakn+IppegZlTy5uc/yPusI4Ma4=;
 b=KvLgHgVcFjgs0K36CubJTcLKwGx7BOClRfozDxMJ5etLyaCCxGNVEG7N
 7SrCjE/2fiQMySLxbg1eQYuHacxhyyG70HNydiOxZiD5B2cE0fAS5o/ez
 4OKcoKKHPlQdI6jui+rwrnr0cvARcauxTgXTQsQMSDW2LM5XkvfZvWjJg
 uruupMmDGgEANe5GxqNOqodeHDhfaeoOrDbyUGs5ASr4+zo1iiGf168Pr
 1PwgA8mO/pBnlhQtWRlLeSbRXD9jC5YhkMGDd1ug4Aqru+Df9fYYDlCTZ
 pcKwX3qaQusW3czNY9+QOGGreSBEXexxa49RcpQnvhr+1VxSUfIX+K6vP Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="16229070"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="16229070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 00:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="34215911"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2024 00:42:36 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
Date: Mon, 11 Mar 2024 15:56:19 +0800
Message-Id: <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
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

Remove unused headers in cpu-common.c:
* qemu/notify.h
* exec/cpu-common.h
* qemu/error-report.h
* qemu/qemu-print.h

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/cpu-common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 0108fb11dbc8..4bd9c70a83f1 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -22,14 +22,10 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "sysemu/hw_accel.h"
-#include "qemu/notify.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
-#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-- 
2.34.1


