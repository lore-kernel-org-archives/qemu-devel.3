Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429DCC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3nMl-0000pb-2e; Tue, 08 Sep 2026 00:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x3nMj-0000pO-7g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 00:23:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x3nMh-0007Fa-BL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 00:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788841403; x=1820377403;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HmRmQD9YKX84eLU/ZgkTm9R8wxWqW7AlQcjViEJchMw=;
 b=kMd1+4ETFW3Tg3oVCZcJODu+kYD9L7/u61//izjIDRgtB49xk2Y6Gw3B
 FwJoEDJm0tDtfPipLfned4LAciK99e4icVSdw/efo+C2dohmJ8uFjgulo
 /PsjlAL0jXqR0UzmiK9FsdHyPTfJUpa+prieHV6S6l9zDM5+qvTTldvP7
 h8PKBd4HDg8q/G40XVY3ZkUqSOu0xSlUjyJQekr5lrSaFlBOXYlZj/oNJ
 RJgS3JlQzKEOb7ixNbCXn5KGuQqUgA9lvcyIrZNPElqrnU/wKUjkuXNsc
 q+pJ+b8yPy8hK1WeS7DDaewrHLJDiP5TWutoFEsvlGSYvocSBhuC/ULyO g==;
X-CSE-ConnectionGUID: IkGWZq5zQrG7/eSJfPou4w==
X-CSE-MsgGUID: yrftIoyzTk64SoslHR3lIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76794268"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="76794268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:23:20 -0700
X-CSE-ConnectionGUID: mbnxLrnsQpuZhA5F3lDsOg==
X-CSE-MsgGUID: R9qyuIZfQ6+jx10zMA4hlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="272808648"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:23:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jic23@kernel.org,
 jonathan.cameron@oss.qualcomm.com
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Date: Tue,  8 Sep 2026 12:23:10 +0800
Message-ID: <20260908042310.493882-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I have been reviewing, testing and contributing to hw/cxl for the past
few months, and would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..bbabcf8cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
+R: Junjie Cao <junjie.cao@intel.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-- 
2.43.0


