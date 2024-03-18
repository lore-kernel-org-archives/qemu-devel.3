Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66842C54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDfG-0001cj-RS; Mon, 18 Mar 2024 10:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rmDf0-0001Tg-Vj; Mon, 18 Mar 2024 10:08:20 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rmDew-0006Gn-49; Mon, 18 Mar 2024 10:08:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 2CA7F260BB4;
 Mon, 18 Mar 2024 15:08:11 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5SIq3skwq7wl; Mon, 18 Mar 2024 15:08:09 +0100 (CET)
Received: from [172.17.0.1] (83.11.22.169.ipv4.supernova.orange.pl
 [83.11.22.169])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id AB129260FE6;
 Mon, 18 Mar 2024 15:08:07 +0100 (CET)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Mon, 18 Mar 2024 15:08:04 +0100
Subject: [PATCH v3 4/4] tests/avocado: sbsa-ref: add OpenBSD tests for misc
 'max' setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sbsa-ref-firmware-update-v3-4-1c33b995a538@linaro.org>
References: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
In-Reply-To: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
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

PAuth makes run timeout on CI so add tests using 'max' without
it and with impdef one.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index cf8954d02e..98c76c1ff7 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -203,18 +203,36 @@ def boot_openbsd73(self, cpu):
     def test_sbsaref_openbsd73_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("cortex-a57")
 
     def test_sbsaref_openbsd73_neoverse_n1(self):
         """
         :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("neoverse-n1")
 
+    def test_sbsaref_openbsd73_max_pauth_off(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd73("max,pauth=off")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_openbsd73_max_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd73("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max(self):
         """
         :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("max")
-

-- 
2.44.0


