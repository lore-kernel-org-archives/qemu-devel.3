Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C1CFF4941
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74qB-0000zg-On; Mon, 30 Mar 2026 01:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74qA-0000zK-Bn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:07:06 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74q8-0001fl-QC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774847225; x=1806383225;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DjdOLgMldMmJy0IrwB1jcfFi+yHryWupaDG3cGqwz9g=;
 b=aXjNECercL/NEG8ZV06lH+19tMXTeyfM9WNAzslMuvVZRYDhCr4+aoTj
 UO0UGMkEO/IqLVlk2bEAps3KBmr6S9t6ybJMgVUJ5Up4cQiyXmNIHHYb0
 vV+n41VFdCY4NwxZ08a27p5IivhOhVfd2bgIunjsyFEztM4v4UnO9SKJB
 IIsM5opJAXa7VugRuLCkGD8lsaYecCfNC+699aWZnkZEXBia8d40nSHSN
 5X9zndpvJVA6AuQzoNkBUATlKrICblwaBR2tHyIHQ3frnxlufshNu0YYM
 ltG1wNwBIMAo+1vO1YdhHQqUQVlN3nLm3PDZiNvkENhwLjIaMJYBwfptk g==;
X-CSE-ConnectionGUID: rz4CcjynQsOlKw+hZRwERA==
X-CSE-MsgGUID: fA3E/6jESkmeLIZAj48O/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="101288404"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="101288404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:07:00 -0700
X-CSE-ConnectionGUID: bt9uLYe2TZyB8uBjxYktrA==
X-CSE-MsgGUID: S9IE+wNCRg6fDAQukE4fow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="230013974"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 29 Mar 2026 22:06:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] tests/functional/migration.py: Skip migration_with_exec() if
 socat is not available
Date: Mon, 30 Mar 2026 13:33:00 +0800
Message-Id: <20260330053300.2721608-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 643a171f5668 ("tests: Replace ncat with socat in migration test
and drop ncat from containers") replaced ncat with socat, but missed to
skip related test cases if socat is not available, which will cause test
errors on the system without socat.

Fix this by checking socat instead of the original ncat.

Fixes: 643a171f5668 ("tests: Replace ncat with socat in migration test and drop ncat from containers")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/functional/migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 2395119d6c66..144f091ba8aa 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -80,8 +80,8 @@ def migration_with_unix(self):
         self.migrate(dst_uri)
 
     def migration_with_exec(self):
-        if not which('ncat'):
-            self.skipTest('ncat is not available')
+        if not which('socat'):
+            self.skipTest('socat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
-- 
2.34.1


