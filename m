Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC8E8305F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCB3-00067R-LH; Tue, 03 Feb 2026 03:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAt-0005Yc-6f; Tue, 03 Feb 2026 03:54:23 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAo-0003Po-GR; Tue, 03 Feb 2026 03:54:16 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:39 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:39 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 20/20] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Date: Tue, 3 Feb 2026 16:52:20 +0800
Message-ID: <20260203085229.1543287-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index 6236aeb11c..3485feaf2c 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):
             'ip addr show dev eth4',
             'inet 10.0.2.15/24')
 
+    def do_ast2600_i3c_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',
+            'Success on message 0')
+        exec_command_and_wait_for_pattern(self,
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | xargs',
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')
+
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):
             'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
         self.vm.add_args('-netdev', 'user,id=net1')
+        self.vm.add_args('-device',
+            'mock-i3c-target,bus=dw.i3c.5,pid=0xab9078563412')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default", "image-bmc"))
 
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):
         exec_command_and_wait_for_pattern(self,
              '/sbin/hwclock -f /dev/rtc1', year)
         self.do_ast2600_pcie_test()
+        self.do_ast2600_i3c_test()
 
     def test_arm_ast2600_otp_blockdev_device(self):
         self.vm.set_machine("ast2600-evb")
-- 
2.43.0


