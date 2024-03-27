Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2CCC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRfM-0000FY-MV; Wed, 27 Mar 2024 07:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpRfI-0000FJ-O3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:41:56 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpRfG-000347-6p
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711539714; x=1743075714;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IsK7FM6JV64ClavXCbUb8x6UsIvU/oqb9Fw/iiCaWgk=;
 b=KNn2fULacWqz5VMeAzAtVYK+wo7Sl5mpUMogE+34+G1EWzYSRb3xXxQZ
 oH/IRDCd88UelaXbyk0+dI2C8zwh5HA5Bc4qgXZ/RrgcAEvtAlWQx0K9i
 S4OiupuRiVwCIuUrQLpV8h5SZxS7qnJ5X84H0cz1qgsQv0uJXk9/R8jz9
 goAeUIhJSIYy55i9Qtagogf2cx54XvLWc7ogMp7sfC/GRJRY5vYB10YhZ
 VzK1uW/SFdlbPNeyrdUtkBsWnZfl7zgPlITpGaWQ3vXxIXQ71Wh7666kv
 alaCE9fZMVNL0LmwD44fvq+UKsIlqHHUpvL9p4RHgniCgoDubW3QW934Z w==;
X-CSE-ConnectionGUID: dipmU3WVS3y7Ioct/pLNGg==
X-CSE-MsgGUID: Adf9xJtORC6sJbp/0fdYGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="32077492"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="32077492"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 04:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="20976709"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 27 Mar 2024 04:41:51 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] MAINTAINERS: Fix error-report.c entry
Date: Wed, 27 Mar 2024 19:55:39 +0800
Message-Id: <20240327115539.3860270-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The commit 15002f60f792 ("util: rename qemu-error.c to match its header
name") renamed util/qemu-error.c to util/error-report.c but missed to
change the corresponding entry.

To avoid get_maintainer.pl failing, update the error-report.c entry.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07af6b9d48e..197a06b42ff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3013,7 +3013,7 @@ F: include/qapi/error.h
 F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
-F: util/qemu-error.c
+F: util/error-report.c
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
-- 
2.34.1


