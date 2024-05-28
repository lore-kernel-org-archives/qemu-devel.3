Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1Zo-00020t-Rf; Tue, 28 May 2024 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sC1Zl-0001wd-9K; Tue, 28 May 2024 14:29:33 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sC1Zj-0003D3-Hz; Tue, 28 May 2024 14:29:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 56AD8260836;
 Tue, 28 May 2024 20:29:28 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DyBjQKf_3Flr; Tue, 28 May 2024 20:29:26 +0200 (CEST)
Received: from applejack.lan (83.11.37.15.ipv4.supernova.orange.pl
 [83.11.37.15])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 528BC2600C6;
 Tue, 28 May 2024 20:29:25 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
Date: Tue, 28 May 2024 20:29:17 +0200
Message-ID: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Partial support for NUMA setup:
- cpu nodes
- memory nodes

Used versions:

- Trusted Firmware v2.11.0
- Tianocore EDK2 stable202405
- Tianocore EDK2 Platforms code commit 4bbd0ed

Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
---
 tests/avocado/machine_aarch64_sbsaref.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 98c76c1ff7..6bb82f2a03 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -37,18 +37,18 @@ def fetch_firmware(self):
 
         Used components:
 
-        - Trusted Firmware 2.10.2
-        - Tianocore EDK2 stable202402
-        - Tianocore EDK2-platforms commit 085c2fb
+        - Trusted Firmware 2.11.0
+        - Tianocore EDK2 stable202405
+        - Tianocore EDK2-platforms commit 4bbd0ed
 
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240313-116475/edk2/SBSA_FLASH0.fd.xz"
+            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "637593749cc307dea7dc13265c32e5d020267552f22b18a31850b8429fc5e159"
+        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -57,9 +57,9 @@ def fetch_firmware(self):
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240313-116475/edk2/SBSA_FLASH1.fd.xz"
+            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "cb0a5e8cf5e303c5d3dc106cfd5943ffe9714b86afddee7164c69ee1dd41991c"
+        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
         tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -98,15 +98,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.10.2(release):")
+        wait_for_console_pattern(self, "BL1: v2.11.0(release):")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.10.2(release)")
+        wait_for_console_pattern(self, "BL2: v2.11.0(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.10.2(release)")
+        wait_for_console_pattern(self, "BL31: v2.11.0(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
-- 
2.45.1


