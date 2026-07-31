Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E78C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmbC-0004Dr-9W; Fri, 31 Jul 2026 08:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmbB-0004D9-7D
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:44:25 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmb9-0001rz-RE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:44:24 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso849758f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501862; x=1786106662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ltDudjYe8pxHl7XxlWpSMq7ZVdlJnNvkY4t3t1H/f4=;
 b=SUa4mOm+mT069XvAwwqxc6RYfyNqB54uXrSyCKrpSgJPjZlzrdEh8m8K+6m4r6Q6S/
 Ei1u+tDlhMXU2/H2xBd6TFobx8Q/H3/+iInQRnvlzsNkGsOWBASgpXXV2yrb6GmEt7wz
 ECGQrCU9l3Q4ePoUOMtaPxa9IVdAUIF/eP4K7ylHTBQhbmiN96X5zGcJaTXbf/HHtAXm
 BCeH/AOsBzGAwTXormhDx1Ri1jrcti3nbIDH0w+aDNEqy7oCm1eaZMtCyIbH19u1uHtC
 Hsn4PxHX8dkbls4ykcStKpoOSWNBaVGHL34lF2RTBE44CZI5PDcJKxo7WLyrATnqKiFE
 2iew==
X-Gm-Message-State: AOJu0Yw5Sa2FqgTCJV2I9VdzDKBEG54948p1Y4HeugXV9Q1kvjmOmOWW
 sdytkqmeGlCwACDs4w3hm+ZJAT0Gex16nxN30EH+pKksKTC4nlXSpwdLhF1AwQd8
X-Gm-Gg: AR+sD106mjvl+5mp5QCMV9RIQl6YdYyHtnfCvVCUx+RLT9EswZaoxEsgylLCm4senfD
 pggxoutf+SzqUVsU6VOjrNJ8/jszYvSL5Djuwsdv684/US+WLYeMWUTL/SFMiwlufEMV+bQIy7o
 Fc4CsR+20MrrjFJKHPRT52+zq5ja513NY55Wwq/boYj6I3uCafRn2Rq1Nd+yIQfVTlhNc9qwxuQ
 iNiVWmAiMiIatGxrROKJNm5KJw+Wp0vE3BALmiKOntxLTQcJ61NG9UbU4XtVskAmYKuIVSIxSaa
 Xn1OCcI27J6fzAr7eJVF1WB556yXNsrg2b97BdlK1vekRnE4e9MZmZgZy2u8la42TCiiCQdJhBE
 fCSiINgUHmuXtUIaaHc004LP4b6S86fNPHhw0fGvkPY/XNA547IlcRPELFeLyor8J+e41QjaxKf
 9r8wmSa1gjU03LjNMdv75YJ5/j8g329vwHj822TLOnjke380HNH6cLFAAKpe5kfozG2iPL4v720
 EjQdaG2K1X58A12PYjWtjxtrmS70Ek/4nXJ
X-Received: by 2002:a05:6000:4b02:b0:47f:86af:8fe7 with SMTP id
 ffacd0b85a97d-47fd2add55amr4786062f8f.22.1785501862411; 
 Fri, 31 Jul 2026 05:44:22 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456220esm4643136f8f.18.2026.07.31.05.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:44:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:19 +0200
Subject: [PATCH v2 20/25] tests/functional: aspeed: add hwmon sensor read
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-20-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494709; l=1618;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=OWHYGLs9Qe48IkzshR4rzRcrC9b6ZFXaLE+JZF/S+fM=;
 b=J5M9HbJ1gKhvbWdXj54EEgDwLw2aIicbtMhLVNudouK6B3C9meC6hSnQaSapht6DcOAv3aYKR
 O0C2qT9fGoWCYJ0kyCQ4vEq9qA9pai0f2DDx18FlQ/ToBnh+PvCPaM1
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add read_hwmon()/wait_hwmon_value() to AspeedTest so board tests can
read a sysfs hwmon attribute over the console and poll it until it
reaches an expected value, instead of each test carrying its own copy.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/aspeed.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 08af6b4839..84d40fc0e9 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -2,6 +2,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import re
+import time
+
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import LinuxKernelTest
 
@@ -29,6 +32,19 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
     def wait_for_boot_complete(self):
         self.wait_for_console_pattern('login:')
 
+    def read_hwmon(self, hwmon, attr):
+        return exec_command_and_wait_for_pattern(
+            self, f'cat {hwmon}/{attr}', self.PROMPT)
+
+    def wait_hwmon_value(self, hwmon, attr, expected):
+        pattern = re.compile(rb'(?m)^%d\r*$' % expected)
+        if pattern.search(self.read_hwmon(hwmon, attr)):
+            return
+        time.sleep(2)
+        out = self.read_hwmon(hwmon, attr)
+        if not pattern.search(out):
+            self.fail(f'{attr} did not reach {expected}: {out!r}')
+
     def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
         self.require_netdev('user')
         self.vm.set_console()

-- 
2.50.1


