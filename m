Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DFFC3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqL9-0006kF-AN; Tue, 13 May 2025 10:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL6-0006Xs-I4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:37 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL4-0004Xw-6C
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747145434; x=1778681434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jcT761HObWrGavctwZQNcsHgl5lIyygr96ByBHS2GKc=;
 b=MDhl4RkPAlE0Z7+tFH2UyD/P9889Ug6rtoVv0C5Jk1QRnMSPEsT8m9cw
 WQN9OFrUbNYcp3WbRRr5tcP8KyA9zzHc0Ci0IjGPaluktKR/l3a54T9iR
 qTIACr3vX8w5E4Xy/uWQzLy3dxE8453onZrSkSCm1QZJYgemX6I7Gemwq
 vIO3Ve6xi/xs88hUPj0XQYfvzFinRaMMLeEl/yQ+U8s74J25YetXAdX7v
 1R1SZuyVAMQILSqno4HkYLNaPnZ9FdRTqRqxeysRg0i+fL4ZYUf9jm2V0
 pnJ7Ok8LNn+MudaUbxC+OoXYRAvCB1GFyM2gD2iaCVRqSXXhhJodRcNcQ w==;
X-CSE-ConnectionGUID: gEK68yZMSx6ZDHf2kcRvbQ==
X-CSE-MsgGUID: p3t5LuYIQOWpDdTvV1ftLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60393334"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="60393334"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 07:10:30 -0700
X-CSE-ConnectionGUID: XAGNETBlRP+rsL/8OPyzMQ==
X-CSE-MsgGUID: iYNru4lnSz+XeBHPCWUKCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138132785"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 13 May 2025 07:10:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] qapi/misc-target: Fix the doc related SGXEPCSection
Date: Tue, 13 May 2025 22:31:30 +0800
Message-Id: <20250513143131.2008078-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513143131.2008078-1-zhao1.liu@intel.com>
References: <20250513143131.2008078-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

The "sections" field of SGXInfo is used to gather EPC section
information for both the guest and the host. Therefore, delete the "for
guest" limitation.

Additionally, avoid the abbreviation "info" and use "information"
instead. And for SGXEPCSection, delete the redundant word "info".

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/misc-target.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 42e4a7417dc6..ed5b7db1bd2a 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -321,7 +321,7 @@
 ##
 # @SGXEPCSection:
 #
-# Information about intel SGX EPC section info
+# Information about intel SGX EPC section
 #
 # @node: the numa node
 #
@@ -346,7 +346,7 @@
 #
 # @flc: true if FLC is supported
 #
-# @sections: The EPC sections info for guest (Since: 7.0)
+# @sections: The EPC sections information (Since: 7.0)
 #
 # Since: 6.2
 ##
-- 
2.34.1


