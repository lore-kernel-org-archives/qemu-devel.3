Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FD0C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlc-0007Wo-4R; Wed, 06 Mar 2024 04:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnla-0007V0-80
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:50 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlY-0002EH-Hm
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718048; x=1741254048;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qD3+/mxiUeFA8qjNfSYQGL/xmY6O+NdeVswkRvGf0gA=;
 b=jWvNhnilNV9RjQck4crAI+c4aDQO/Otm7QdmI8bEN6oqSpy2DhAUME9B
 202003Q5tsML8R6E+UU8qS1l+dWXR5onXOddrIf5xDyP85S0Vu8hYNnI3
 zpWJTOxrgg/0H6yFAtW2rejqkC2dL+mDUF5EMAKVxw37hzUu65f277aWk
 bxrBq7ks5zVbB+/XZn9RAqEVcGOcSrxNcyQUwfysDcZ4BlgDnYTYKmIlq
 97ID9V0ZuXt6SV8b60QcD/HJztem//ZtxmS3eFZjSJE7NvwwjFYm79hGC
 pDX8aI1OP3YdKvI/tTbp9Dhv6UjajPNmDgzYwq0+ZNcUTxJ/ep/oCbe7j Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897877"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897877"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854153"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:45 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/14] tests/unit/test-smp-parse: Bump max_cpus to 4096
Date: Wed,  6 Mar 2024 17:54:00 +0800
Message-Id: <20240306095407.3058909-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The q35 machine is trying to support up to 4096 vCPUs [1], so it's
necessary to bump max_cpus in test-smp-parse to 4096 to cover the
topological needs of future machines.

[1]: https://lore.kernel.org/qemu-devel/20240228143351.3967-1-anisinha@redhat.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
---
 tests/unit/test-smp-parse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 84e342277452..2eb9533bc505 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -20,8 +20,8 @@
 #define T true
 #define F false
 
-#define MIN_CPUS 1   /* set the min CPUs supported by the machine as 1 */
-#define MAX_CPUS 512 /* set the max CPUs supported by the machine as 512 */
+#define MIN_CPUS 1    /* set the min CPUs supported by the machine as 1 */
+#define MAX_CPUS 4096 /* set the max CPUs supported by the machine as 4096 */
 
 #define SMP_MACHINE_NAME "TEST-SMP"
 
@@ -333,13 +333,13 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
         /*
-         * config: -smp 512
+         * config: -smp 4096
          * The test machine should tweak the supported max CPUs to
-         * 511 (MAX_CPUS - 1) for testing.
+         * 4095 (MAX_CPUS - 1) for testing.
          */
-        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
-        .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
-                        "by machine '" SMP_MACHINE_NAME "' is 511",
+        .config = SMP_CONFIG_GENERIC(T, 4096, F, 0, F, 0, F, 0, F, 0),
+        .expect_error = "Invalid SMP CPUs 4096. The max CPUs supported "
+                        "by machine '" SMP_MACHINE_NAME "' is 4095",
     },
 };
 
-- 
2.34.1


