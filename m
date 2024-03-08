Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3F4C54E60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSX-0000cw-Ei; Fri, 08 Mar 2024 10:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSW-0000cW-Km
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:32 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSU-00041N-Sz
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912912; x=1741448912;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hQQp1HLSgx+wpMrBVHO/awDehkcqUXAg5RqG126+NFg=;
 b=QnAozsdXK5tjqV/8Ixus5oq4CAL7K1B4xAn9yxEhbxGjT436ZIGgAlQq
 ayFa7mGecez1IRQ7beWEFFzFlbw+hraIJGLXBBsGPtMZs24pLpP016R4C
 +YrvgoyTVi5DArBcHZq08ps3nCP2mDc4nhGgGGg73bJ0cbRrgT1VZ7GjS
 8Vf+4q/KYBkGKAsSDAnKyMnyFH9EVCa+5wUAYUvv2sI39B/ZfellcGNTf
 x4bdwHqlxtBXVGgsZBGPAR9xEKBqeU8q4gI7t52HbQ/vSPuJ4HvXMqqCR
 1ytYdSy0cBbGxyVjaWRRdyCy+gp1JKPK27QJM5RioVQeKF533NIxNzX94 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561066"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400335"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:27 -0800
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
Subject: [PATCH v2 06/13] tests/unit/test-smp-parse: Bump max_cpus to 4096
Date: Sat,  9 Mar 2024 00:01:41 +0800
Message-Id: <20240308160148.3130837-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The q35 machine is trying to support up to 4096 vCPUs [1], so it's
necessary to bump max_cpus in test-smp-parse to 4096 to cover the
topological needs of future machines.

[1]: https://lore.kernel.org/qemu-devel/20240228143351.3967-1-anisinha@redhat.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


