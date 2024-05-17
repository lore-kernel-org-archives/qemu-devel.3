Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC224C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qpm-000497-6r; Fri, 17 May 2024 02:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpg-00046c-8M
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:44 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7qpb-0002mo-38
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715926359; x=1747462359;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5/ckqKt4nIuHpY/q7Lv+weUL8OZn9S8U9YTXztI/HLk=;
 b=C0hvbkM0FS5cmQ5R6O0TsvEufLiC1Oy+htARGOmIy2c7sY12K/IQpvm4
 QyYYwDFF/jvAwcMNcjzt8bgjWbkW5pKXR3wyG2OOwmcnSwavl2t9SUF6F
 PPNyNRjoOJPr+w+rRUtMj9VX4DEaUPQeh5yaNp8k6VGqxb5iSAJh6Jow1
 CpNsUayPFU5HzhLrv2yek/H4VxCc49fxzb9cPDIMJSipBL/ZT4xBOViJ7
 UZvyLgCevfdBQna5zYTDKvE8xxn4m5lIrWxhh2B1cFjs3FhWxjgl3r+90
 yhRbdptMpZIYrKwXS3VZ1IZAvvcWVnJad9hRlUNDqjCqKvjCQQn3PNCq+ w==;
X-CSE-ConnectionGUID: angyMfWlRWyCzYaUh+I25w==
X-CSE-MsgGUID: K9NT6nskRqaZUGfB2G4saA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15869069"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="15869069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 23:12:33 -0700
X-CSE-ConnectionGUID: oyEA/f9uTiWVAd46BezOaw==
X-CSE-MsgGUID: XE5+ZXrHQt6wd0Hq7KNapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="31620640"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 16 May 2024 23:12:32 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] qapi/qapi-schema: Clarify the dependency relationship
Date: Fri, 17 May 2024 14:27:46 +0800
Message-Id: <20240517062748.782366-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

At present, the correctness of the dependencies of JSON files is ensured
by the order in which they are listed, but in general, the mixing of
multiple files and the lack of clear guidelines for ordering them is not
friendly to extending and maintaining.

Therefore, I have a proposal to manually categorize and sort JSON files
generation order by dependencies/dependency hierarchy, to improve the
readability and maintainability of qapi-schema.json.

Welcome your feedback!

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  qapi: Reorder and categorize json files in qapi-schema.json
  qapi: List block-core.json in qapi-schema.json

 qapi/qapi-schema.json | 100 +++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 31 deletions(-)

-- 
2.34.1


