Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F729C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLXU-0001s6-96; Wed, 13 Mar 2024 06:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkLXP-0001qd-Go; Wed, 13 Mar 2024 06:08:43 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkLXC-0006Ui-RQ; Wed, 13 Mar 2024 06:08:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 441A6260B8D;
 Wed, 13 Mar 2024 11:08:27 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id uwUlmwSkaARn; Wed, 13 Mar 2024 11:08:25 +0100 (CET)
Received: from [172.17.0.1] (83.11.22.169.ipv4.supernova.orange.pl
 [83.11.22.169])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id B5E842601CE;
 Wed, 13 Mar 2024 11:08:23 +0100 (CET)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Wed, 13 Mar 2024 11:08:21 +0100
Subject: [PATCH 3/3] tests/avocado: use OpenBSD 7.4 for sbsa-ref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
In-Reply-To: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>, 
 qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.12.3
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

7.4 was released in October 2023, time to update before 7.3 gets dropped.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 259225f15f..94c9f81d72 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -159,14 +159,14 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu):
+    def boot_openbsd(self, cpu):
         self.fetch_firmware()
 
         img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
+            "https://cdn.openbsd.org/pub/OpenBSD/7.4/arm64/miniroot74.img"
         )
 
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
+        img_hash = "7b08b2ce081cff6408d183f7152ddcfd2779912104866e4fdf6ae2d864b51142"
         img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
 
         self.vm.set_console()
@@ -180,23 +180,23 @@ def boot_openbsd73(self, cpu):
         self.vm.launch()
         wait_for_console_pattern(self,
                                  "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
+                                 " 7.4 installation program.")
 
-    def test_sbsaref_openbsd73_cortex_a57(self):
+    def test_sbsaref_openbsd_cortex_a57(self):
         """
-        :avocado: tags=cpu:cortex-a57
+        :avocado: tags=cpu:cortex-a57,os:openbsd
         """
-        self.boot_openbsd73("cortex-a57")
+        self.boot_openbsd("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
+    def test_sbsaref_openbsd_neoverse_n1(self):
         """
-        :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=cpu:neoverse-n1,os:openbsd
         """
-        self.boot_openbsd73("neoverse-n1")
+        self.boot_openbsd("neoverse-n1")
 
-    def test_sbsaref_openbsd73_max(self):
+    def test_sbsaref_openbsd_max(self):
         """
-        :avocado: tags=cpu:max
+        :avocado: tags=cpu:max,os:openbsd
         """
-        self.boot_openbsd73("max")
+        self.boot_openbsd("max")
 

-- 
2.44.0


