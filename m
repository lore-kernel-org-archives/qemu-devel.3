Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851FD68BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7qu-0003oz-J6; Thu, 18 Dec 2025 01:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7qo-0003oe-Dr
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:51:05 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7qj-0008SD-3p
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766040657; x=1797576657;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YqDwYRN4o6NV1SBhp1kDiX44vbCeEfv3x8WuuIFdaro=;
 b=ULO72o4LqZMIHNtg4KrYwYieu5IVQsWm7T+eVBFtl7oBE71sjS9kACg0
 ZK+qUo9HZ3M9wQY4wWl+2VTxE1h1MmpmhO0naNeRscMcGaFDsL/ll6fca
 /oJusANbBBGHGFcVC0/KfIn//BfL0eDs3pBa9/TMhrWP6kLAVlYO1QXA1
 67DIioYbLfYBt/iucoVjuJyoLfzR+lJcEd0jbYOXgquae8oD1wmZ+To8p
 YX5aP8Wpyqkpyms2WAsa2krvnNY9JZjB7rrOqzJqAbFZVLqX5xwWTzsOV
 MVofugEDQhkFB9YK/Fe6LN3iDpLYod94usMlExACjmoGPIiZNgkyGMn5c A==;
X-CSE-ConnectionGUID: WkZf/SWtRl+YxC+Bf3bM5A==
X-CSE-MsgGUID: WjQhtLuOS9K6/0Wz0czPnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="79358576"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="79358576"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:50:53 -0800
X-CSE-ConnectionGUID: FLuDGYQiRoSKnmgoFdwb0w==
X-CSE-MsgGUID: z6b3q+zeTSCr54Prg4YUOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203024903"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:50:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com,
 yi.l.liu@intel.com, joao.m.martins@oracle.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] docs/devel: Remove stale comments related to iommufd dirty
 tracking
Date: Thu, 18 Dec 2025 01:50:42 -0500
Message-ID: <20251218065042.639777-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

IOMMUFD dirty tracking support had be merged, the stale comments could
be dropped.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..b37098e1b6 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -127,18 +127,6 @@ Supports x86, ARM and s390x currently.
 Caveats
 =======
 
-Dirty page sync
----------------
-
-Dirty page sync with iommufd backend is unsupported yet, live migration is
-disabled by default. But it can be force enabled like below, low efficient
-though.
-
-.. code-block:: bash
-
-    -object iommufd,id=iommufd0
-    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0,enable-migration=on
-
 P2P DMA
 -------
 
-- 
2.47.1


