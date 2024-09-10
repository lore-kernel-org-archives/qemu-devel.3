Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506C5ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxUH-0006nV-LU; Tue, 10 Sep 2024 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snxUF-0006c9-5B; Tue, 10 Sep 2024 05:48:39 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snxUD-0000Mq-FQ; Tue, 10 Sep 2024 05:48:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 8B550260BB4;
 Tue, 10 Sep 2024 11:48:35 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 8iP37E5UKAXf; Tue, 10 Sep 2024 11:48:33 +0200 (CEST)
Received: from applejack.lan (83.11.24.101.ipv4.supernova.orange.pl
 [83.11.24.101])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 5360A260898;
 Tue, 10 Sep 2024 11:48:32 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Tue, 10 Sep 2024 11:48:11 +0200
Subject: [PATCH v5 4/4] tests: drop OpenBSD tests for aarch64/sbsa-ref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-b4-move-to-freebsd-v5-4-0fb66d803c93@linaro.org>
References: <20240910-b4-move-to-freebsd-v5-0-0fb66d803c93@linaro.org>
In-Reply-To: <20240910-b4-move-to-freebsd-v5-0-0fb66d803c93@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.14.0
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

OpenBSD 7.3 we use is EoL. Both 7.4 and 7.5 releases do not work on
anything above Neoverse-N1 due to PAC emulation:

https://marc.info/?l=openbsd-arm&m=171050428327850&w=2

OpenBSD 7.6 is not yet released.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 44 --------------------------------
 1 file changed, 44 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 1648e8ceb6..b50e1a5965 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -143,50 +143,6 @@ def test_sbsaref_alpine_linux_max(self):
         self.boot_alpine_linux("max")
 
 
-    ASSET_OPENBSD_ISO = Asset(
-        ('https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img'),
-        '7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5')
-
-    # This tests the whole boot chain from EFI to Userspace
-    # We only boot a whole OS for the current top level CPU and GIC
-    # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu=None):
-        self.fetch_firmware()
-
-        img_path = self.ASSET_OPENBSD_ISO.fetch()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-drive", f"file={img_path},format=raw,snapshot=on",
-        )
-        if cpu:
-            self.vm.add_args("-cpu", cpu)
-
-        self.vm.launch()
-        wait_for_console_pattern(self,
-                                 "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
-
-    def test_sbsaref_openbsd73_cortex_a57(self):
-        self.boot_openbsd73("cortex-a57")
-
-    def test_sbsaref_openbsd73_default_cpu(self):
-        self.boot_openbsd73()
-
-    def test_sbsaref_openbsd73_max_pauth_off(self):
-        self.boot_openbsd73("max,pauth=off")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_openbsd73_max_pauth_impdef(self):
-        self.boot_openbsd73("max,pauth-impdef=on")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_openbsd73_max(self):
-        self.boot_openbsd73("max")
-
-
     ASSET_FREEBSD_ISO = Asset(
         ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
          '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),

-- 
2.46.0


