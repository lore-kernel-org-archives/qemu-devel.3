Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF6C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2BUX-0003Qd-Vl; Tue, 08 Apr 2025 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2BU1-0003Kw-W0; Tue, 08 Apr 2025 12:07:30 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2BTt-0007cX-UR; Tue, 08 Apr 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744128442; x=1775664442;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HYRYFKnwlvNLLwRiYaYqmnF8qqgcQeGuqHSpmQRRW80=;
 b=RwsuibMxtGmXsyL7hmQsiZsiXaLLzXocdcUvPO1H/1yP064rMImdflkT
 kvl9ivqJYo6fis14W8mnH2Tzvh/5wpH9Q7nobPtfkq7I+vZD2OQ4mt4gx
 KW8CEpyZ5A/I472ROLuyLwQw/1yJWM3+hyW3+rek3Fl6/VZTOHCKPhMAI
 Vjt8JZzoGuusGUKDtonwj3pG2yDmyVNpqTNP9e/6zpMar8zalWAU7H4Fj
 eHJ4z56dneZZF8ziVuEjv8dlx+eegYHAnr6GT0apKBEGgCAINbevQ2nu/
 UfRuGtAfx7gLylDErW1N0xMPtT6opEFxx0spAWxC/j6OXgyGcQvw1ras4 g==;
X-CSE-ConnectionGUID: YgCPhg94T5WEdzlFHKXYAA==
X-CSE-MsgGUID: Q5dl03n2QMy8v/J9wuhWPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45466513"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45466513"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:06:52 -0700
X-CSE-ConnectionGUID: a4nxDZwHQ5OmprGUqjcv6w==
X-CSE-MsgGUID: wrBFuuAVQVSaSs1ZtckZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128820082"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 08 Apr 2025 09:06:50 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] scripts/checkpatch: Fix typo in SPDX-License-Identifier
 keyword
Date: Wed,  9 Apr 2025 00:27:02 +0800
Message-Id: <20250408162702.2350565-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

Fix the typo in the error message to help `grep` the example:

ERROR: New file '***' requires 'SPDX-License-Identifer'

Fixes: fa4d79c64dae ("scripts: mandate that new files have SPDX-License-Identifier")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6ae9d7febee8..365892de0428 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1688,11 +1688,11 @@ sub process {
 			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
 			    # source code files MUST have SPDX license declared
 			    ERROR("New file '$expect_spdx_file' requires " .
-				  "'SPDX-License-Identifer'");
+				  "'SPDX-License-Identifier'");
 			} else {
 			    # Other files MAY have SPDX license if appropriate
 			    WARN("Does new file '$expect_spdx_file' need " .
-				 "'SPDX-License-Identifer'?");
+				 "'SPDX-License-Identifier'?");
 			}
 		    }
 		    $expect_spdx = 1;
-- 
2.34.1


