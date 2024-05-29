Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E1CC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ3-0005W7-9g; Wed, 29 May 2024 02:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ1-0005VR-Ne
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCPz-0002st-8J
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962652; x=1748498652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rh2tN87Adt0+ICqb7vzJ4e9H8aV7j0n6tPKtAvVoIbI=;
 b=jRqBGcrNZMBT8yaT3U6tGe7aD2AiD774CmRygT4aGDlocINJ2FQ+V2lt
 sdYuNeXWHx4UqS2oulUxgsAbo+OPrnRsTjDycVHSbrP9D7ewbCRiRSi/B
 B9HbYAWLP3WJNzeHHJrctG1mHR1j+6wF1TgCHspoBtPLMG22MBfHTCnon
 Lrf0/AQHDVnWMYgZ1QC7hiq/bZLQltEDsDQBuMFmNOeGCzd3uPkyI8Xfv
 QPYepYEnQQ3s4vw9QqPhES+FTZbmJgwz5uTS/I70Cc5WDgWIF7Dwo+Psy
 3z2D9FJzNVVWOrWw8Z9MPvafxz7L1DuqseLN7e+EyDCVdsT9Drf3bO1St w==;
X-CSE-ConnectionGUID: 4ZDKwwuaS+uoOY/0NPI98A==
X-CSE-MsgGUID: 5AaMuKIVSbmas7bVtEfYuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187471"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:11 -0700
X-CSE-ConnectionGUID: 3etaa0T8RvG+zm4oKceLdQ==
X-CSE-MsgGUID: 2nwNpp5kQWmEA9g4Vjq06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144695"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/8] tests/unit/test-smp-parse: Fix comment of parameters=1
 case
Date: Wed, 29 May 2024 14:19:19 +0800
Message-Id: <20240529061925.350323-3-zhao1.liu@intel.com>
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

SMP_CONFIG_WITH_FULL_TOPO hasn't support module level, so the parameter
should indicate the "clusters".

Additionally, reorder the parameters of -smp to match the topology
hierarchy order.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index fa8e7d83a7b6..c9cbc89c21b9 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -333,7 +333,9 @@ static const struct SMPTestData data_generic_valid[] = {
     }, {
         /*
          * Unsupported parameters are always allowed to be set to '1'
-         * config: -smp 8,books=1,drawers=1,sockets=2,modules=1,dies=1,cores=2,threads=2,maxcpus=8
+         * config:
+         *   -smp 8,drawers=1,books=1,sockets=2,dies=1,clusters=1,cores=2,\
+         *        threads=2,maxcpus=8
          * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
         .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
-- 
2.34.1


