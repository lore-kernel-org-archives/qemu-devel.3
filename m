Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABB0C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qpm-0004BS-9E; Fri, 17 May 2024 02:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpj-00048Z-80
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:47 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpb-0002om-IP
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715926359; x=1747462359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/D5KL9gsn1w1Kjzhi/6jGBTDPW6/izNdWX+gtGUBd3E=;
 b=nLR0xVBwPDOPyzpKvTDGcCU3Z7knHMxsbNlvn8cgAsPo+QZF8kRqRt73
 U20kQmUL1BbypsGJs7b2s4YW33ceYNvJAV4e22UxtoaE0t9ZPWsEW/k74
 QgS76Jjo6WD9z3Zj6exjvBGJVXYY75+RmssFjlih6oUL0yzP/FhHelMva
 /6dQ9BVNd9o6FVjlDwMdJdqhJKCicinN1rld3Fur+FCmtK2RFjSYiJ/Gn
 YFB8m8gbbF4eOfj4LR5zNQWATVJKMsMgs3hBrHIRuuL+yfIkt+1q3ukK7
 mVY9dvqxMv3OG+QntyNz0CHatLpCfH9KGBDJxHaeMLzW/5nuQI6MHBOKs A==;
X-CSE-ConnectionGUID: 8lT/i5YSRBaYFMNeDmLw3g==
X-CSE-MsgGUID: NA+Cg3ShQs6Kz2FWU0WMIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15869080"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="15869080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 23:12:36 -0700
X-CSE-ConnectionGUID: WS8vR0YrSlGCvXLgZcR1jg==
X-CSE-MsgGUID: vBOD7RywSmyWxyEzBtw9ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="31620653"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 16 May 2024 23:12:35 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] qapi: List block-core.json in qapi-schema.json
Date: Fri, 17 May 2024 14:27:48 +0800
Message-Id: <20240517062748.782366-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517062748.782366-1-zhao1.liu@intel.com>
References: <20240517062748.782366-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Currently, block-core.json is not explicitly listed in the
qapi-schema.json.

To make the dependencies clearer, list block-core.json in section 2.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/qapi-schema.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 57ea6bcb33e9..14196128c44e 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -77,6 +77,8 @@
 #
 # All their dependencies are listed in the section 1.
 
+# include common.json, crypto.json, job.json, sockets.json
+{ 'include': 'block-core.json' }
 # include sockets.json
 { 'include': 'char.json' }
 # include machine-common.json
@@ -96,19 +98,17 @@
 
 # Section 3. Files with 2-level dependencies.
 #
-# Their dependencies are either listed in the previous sections, or are
-# not listed but include files from the previous section. At least one
-# dependency is a 1-level dependency file.
+# All their dependencies are listed in the previous sections. At least one
+# dependency is from section 2.
 
-# include sockets.json (section 1), block-core.json (not listed, 1-level
-# dependencies)
+# include sockets.json (section 1), block-core.json (section 2)
 { 'include': 'block-export.json' }
-# include block-core.json (not listed, 1-level dependencies)
+# include block-core.json (section 2)
 { 'include': 'block.json' }
 # include authz.json (section 1), common.json (section 1), crypto.json
-# (section 1), block-core.json (not listed, 1-level dependencies)
+# (section 1), block-core.json (section 2)
 { 'include': 'qom.json' }
-# include block-core.json (not listed, 1-level dependencies)
+# include block-core.json (section 2)
 { 'include': 'transaction.json' }
 
 # Section 4. Files with 3-level dependencies.
-- 
2.34.1


