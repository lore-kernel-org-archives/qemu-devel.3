Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7885C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ2-0005Va-Mr; Wed, 29 May 2024 02:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ0-0005V1-GJ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:12 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCPz-0002sy-05
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962651; x=1748498651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ngOdced1uceZL1uIE2kvQ+8BlkJIatVjqHcIP6gXYNE=;
 b=JSWWPsqJGdVkVYr/UkKJOfeMl6LsarqAz4GaoAcA2khKGKDpfinN/Jn+
 DMu2till8QtFLrVMXipVU9TkrRFmdwlrCDsP1tacfeaF7uKH0zEDxKr1y
 LxOOKMJ/1/gZlEuDnK7HwI18LFLGLWn39xxhK1tY6bNFrNrUY92kt4Rrp
 Os1pkvKVoJEgjYdM19wPrTDhQwojGSj6CUGWhLgNhdAUfnWh6Qdcn2Q4o
 NYerRgHiz88J8NiOFcuBZAm7dtuG+c+OoKG3q8iPiLR45s8Q60C7wR3o5
 JbnkASIDoxZiJcGS9gWH0EImOQd45y88rP0EoI/uSgl09WYFb0HYXS6ua A==;
X-CSE-ConnectionGUID: Ip4lhL9gS5GaJgV7xhlOmw==
X-CSE-MsgGUID: +woieLH3QrWMVDpYlMjecQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187462"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:08 -0700
X-CSE-ConnectionGUID: E9/rqUG/SWiL18edXVkNvg==
X-CSE-MsgGUID: yEyoO0hJS2em7SpPWuqExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144679"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:06 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/8] tests/unit/test-smp-parse: Fix comments of drawers and
 books case
Date: Wed, 29 May 2024 14:19:18 +0800
Message-Id: <20240529061925.350323-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fix the comments to match the actual configurations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 9fdba24fce56..fa8e7d83a7b6 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -474,8 +474,8 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
 static const struct SMPTestData data_with_drawers_books_invalid[] = {
     {
         /*
-         * config: -smp 200,drawers=2,books=2,sockets=2,cores=4,\
-         * threads=2,maxcpus=200
+         * config: -smp 200,drawers=3,books=5,sockets=2,cores=4,\
+         *              threads=2,maxcpus=200
          */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 200, T, 3, T, 5, T,
                                                 2, T, 4, T, 2, T, 200),
@@ -485,8 +485,8 @@ static const struct SMPTestData data_with_drawers_books_invalid[] = {
                         "cores (4) * threads (2) != maxcpus (200)",
     }, {
         /*
-         * config: -smp 242,drawers=2,books=2,sockets=2,cores=4,\
-         * threads=2,maxcpus=240
+         * config: -smp 242,drawers=3,books=5,sockets=2,cores=4,\
+         *              threads=2,maxcpus=240
          */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 242, T, 3, T, 5, T,
                                                 2, T, 4, T, 2, T, 240),
-- 
2.34.1


