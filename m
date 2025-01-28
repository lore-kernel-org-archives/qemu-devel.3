Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08A3C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxp-00029v-7C; Tue, 28 Jan 2025 15:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxm-00028q-8l
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxk-0001as-Cs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso241015e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095210; x=1738700010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+293gS1Cw1SuA2t316+tbEnWzM7aAkmjNNaFrnYHJG0=;
 b=XI4Y07LV4qJy3aTqbFSUjGokj2WYuYWNfXAEYursrg+QMfIVSbaZBWwIZ5XwX/ObtG
 Sq9khgvmqPiwq1GmRuCwIcbKLKGZK47j4SRlP5h6i6Z66vjl1idBLMG4w3H7Whnjk5BQ
 n8L+Yuvmc6xa3QrZ5VeI+Fbl4uMAKTburhLZQl14gvbjinpr4evsQ3b4tWNcuAclwP3v
 1w52ZecPpZyZExlavScIwRe7myC4NFVuykokZxGxYhTKyRdMKhnei/5t1/sNtubjhNkL
 RJHh9X5LezPRfZMTbU5toGEO6/0XIMiNJllu5j0S5bqae8HMvO0eAdjLc0GSu1davbef
 HOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095210; x=1738700010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+293gS1Cw1SuA2t316+tbEnWzM7aAkmjNNaFrnYHJG0=;
 b=sv7eANnR3whXrVrjyq/xfGGEhBaTGzKAk6ErIOc9UAmYGYNdNfhaaRgebXbxYc8KS5
 PC/0GvFvWDUvTmC0Z3rzdSHsV4eaMeHN74j1K+iwadj6OH3BnIg9ZlcAhlkTGa/v8ssa
 eUgBUpHuGYAy4CltsTYD2bUTC8ZQF07oxE+xwE+mdIJn9PXrwrnuPjqteyTy/uz+TMsm
 Y1s+QrNeOQ7VAHBH/8PxnbByS+SQI1e2BJFYtjtLOTIXrjhc08G4HcPpqUfdjMXQ0a52
 3femMMvzdfMiXJtIA6xU2Kj1T+TKyGUgJfBMCLEPZWQ1WZjcKrLDKYy9vDESWYFpAQJx
 80Pg==
X-Gm-Message-State: AOJu0YzIuLv5M8l+UnF0TRcqv5OpEgIrGoniSBp6mzoP3YpxtdbHDsVL
 gNsSd1+/MOvJruQipZ+YY4c09uBjooPpZLwyIsbjb0rIjSjqkwTFGL3637WdW1Eh5U5OEfbneeD
 s
X-Gm-Gg: ASbGncu5H3l+h2+X3bssG6d+okfq2JZf7uTEAGCCVlHY0jXp/ORLU6yUr+MFh5SwS5W
 oj2ItYdBr9rtyg+TWuxudAOiRWF6zPUDN8ifEs2ttGYvKuhtN8sA5YFqEuhLx6dAs70RGSVlX+8
 ikMkh//k+ZNStSNZexKSm4jqOCzD6sgU5bAN5HMSC/Ok3GialbsZseiAEnr86j/rEjZs2Q1BWKi
 SbRobVSUpNrvZtvWB/E5huvqgll/y0PXYZuKWcDdsl/rHtVEGX5ZPATs5GM/Z61jan8dG7Dz1+P
 5ZVjeiv9QBVC3P/uPhnWAg==
X-Google-Smtp-Source: AGHT+IHr3jWPFyAtiA8tH49CKS/Z6XBUNkunP4fTAOxleY3+VP4e5aW+oh1SalETexksZrjNqw9Jlg==
X-Received: by 2002:a05:600c:4f8e:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-438dbe99cd0mr5398495e9.7.1738095210436; 
 Tue, 28 Jan 2025 12:13:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] tests/functional: Add a test for the arm microbit machine
Date: Tue, 28 Jan 2025 20:12:51 +0000
Message-Id: <20250128201314.44038-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

We don't have any functional tests for this machine yet, thus let's
add a test with a MicroPython binary that is available online
(thanks to Joel Stanley for providing it, see:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606064.html ).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250124101709.1591761-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                           |  1 +
 tests/functional/meson.build          |  1 +
 tests/functional/test_arm_microbit.py | 31 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 tests/functional/test_arm_microbit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be3d8f431a..bb96a00db04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1157,6 +1157,7 @@ F: hw/*/microbit*.c
 F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
+F: tests/functional/test_arm_microbit.py
 F: docs/system/arm/nrf.rst
 
 ARM PL011 Rust device
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b7719ab85f9..b62f7142201 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -91,6 +91,7 @@ tests_arm_system_thorough = [
   'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
+  'arm_microbit',
   'arm_orangepi',
   'arm_quanta_gsj',
   'arm_raspi2',
diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/test_arm_microbit.py
new file mode 100755
index 00000000000..68ea4e73d62
--- /dev/null
+++ b/tests/functional/test_arm_microbit.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025, The QEMU Project Developers.
+#
+# A functional test that runs MicroPython on the arm microbit machine.
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class MicrobitMachine(QemuSystemTest):
+
+    ASSET_MICRO = Asset('https://ozlabs.org/~joel/microbit-micropython.hex',
+        '021641f93dfb11767d4978dbb3ca7f475d1b13c69e7f4aec3382f212636bffd6')
+
+    def test_arm_microbit(self):
+        self.set_machine('microbit')
+
+        micropython = self.ASSET_MICRO.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-device', f'loader,file={micropython}')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Type "help()" for more information.')
+        exec_command_and_wait_for_pattern(self, 'import machine as mch', '>>>')
+        exec_command_and_wait_for_pattern(self, 'mch.reset()', 'MicroPython')
+        wait_for_console_pattern(self, '>>>')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.34.1


