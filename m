Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFE4D41D71
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmt6-0006X7-RZ; Tue, 12 Nov 2024 04:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1tAmt4-0006Wo-G7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:08:38 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1tAmt2-00070g-Om
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731402516; x=1762938516;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5LECzq1IvntnwkQifhmvabbhUtJqhAPq0lwvYClRfIc=;
 b=Dp+i0ukIIyc0EyZOQAVdc1LCXWyfntXfstnQH79o0bDRacaR1xpMvfC8
 sBZjHz4DRvgjTnGu4bjmLhGcFIhBA3w6/DLXfDuKTKunDWHOJO/PHbbyp
 An57+kDUUuFrQaoFdXeKgIoatYxTUvA0Km8Le0ZHhsr5cN4u2Qw6NopJ6
 G5CXqac+xVOVQnyDODJkUa0pkyGm13BXJuObgJYm1OCHkTna/q5a8VpKv
 hjOjA4MrDqmO9rYugmreXmuynx155eqr1MX9OSYJLdlJvUyn+k2VJiqxb
 JtqfHR57dP4kLRtO8YQZVdwNSmRRVpQoMDabfXVH3uBBRp903Q4zhaiz+ w==;
X-CSE-ConnectionGUID: B7OjpfEQT+23GV+J+G2p9Q==
X-CSE-MsgGUID: pTwSMLXyQG2YyI1ctaL8EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="42607700"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; d="scan'208";a="42607700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2024 01:08:32 -0800
X-CSE-ConnectionGUID: MQ1aoHoxSaWzSAQyXqJlGA==
X-CSE-MsgGUID: cF2EnPKERnSv+yZNd/rkqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; d="scan'208";a="92445119"
Received: from acrn-optiplex-7050.sh.intel.com ([10.239.152.64])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2024 01:08:32 -0800
From: Zhang Chen <chen.zhang@intel.com>
To: qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] MAINTAINERS: Update my email address for COLO
Date: Tue, 12 Nov 2024 16:40:38 +0800
Message-ID: <20241112084038.6352-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..3f10529d9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3559,7 +3559,7 @@ F: include/migration/failover.h
 F: docs/COLO-FT.txt
 
 COLO Proxy
-M: Zhang Chen <chen.zhang@intel.com>
+M: Zhang Chen <zhangckid@gmail.com>
 M: Li Zhijian <lizhijian@fujitsu.com>
 S: Supported
 F: docs/colo-proxy.txt
-- 
2.43.0


