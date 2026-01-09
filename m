Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8279BD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RP-0006Vo-Ji; Fri, 09 Jan 2026 01:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qn-0005Tx-Uh
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:13 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Ql-0002yo-Vx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:09 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso2586964a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941826; x=1768546626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j/qPjdKZed+xiVY9WDXNNYe7vPb+h/Yx+dAPCmE0lo=;
 b=H8NvGagwQvRNVL0OF2F5mZEgq+6NkX/BQZWJZfF7wN7uqzgHL0fN1F+xnNKnAq2ORS
 DtmCGRYvFcm643RPfQhC5OQXsZLxiIKzAusU7fUA4RMANeSNbl7Bf0FBzQhqKWJ+VWgP
 dvwJrG9eAplQ2FXPNMPcGqWk7DIy7jbc/1uc6z7c+DErcJrR6zdcWmHvyoMJ30DiFWNA
 R7XEpMPthsM0cq7efB5OaI1uQiZ6XUxQYgfvG9P8aDXrGXxkSJ5iC4GSOxmM4Gc8EUGn
 huN49DIlOll1mjWeqSbXhhTaG2Oml3JkZhxs2gXKkxKXhJ3IDlg2Jjkq6gvP9TyPH6Um
 EMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941826; x=1768546626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+j/qPjdKZed+xiVY9WDXNNYe7vPb+h/Yx+dAPCmE0lo=;
 b=Q4VW9gCu0Y614LKGBwnKIh1K4XQztt4atxDGjP+JAcuw0sbQxUwl3fVm3+SeF3ff0a
 5T2PwCuJwrYJc3ArIIQjdKfljjoVSLHT7svVNJffb7/3SyQWQcFNMF8gFRh7sA6YjDJP
 qEXfw1AU8U3QvBKnpGpDuHXsGy6nBFIa+KTYFDOHTkZSyG28K4s0duDq/cw0rkCy8Y3l
 E4nKk827gxCLKfuPyQiZGFgjaiQJVUa1REPM8iNvYWrP8qVEpj2QtGIqusUqR32ds8Tz
 NlYR6B3vNoFN9SnSinFcOghpXVbcHpMD5O9qxKfxcZS2UH/9SOByprKvLjFJAbZ7b6GT
 1tsg==
X-Gm-Message-State: AOJu0YyJKJyX79WTsvEXA4antwABiTMsJKRzz4L8g5RQJ3dAkQ0YNxgr
 UI6RrMha6EIX6QFPujvZ7r33hlhB7TqWx0HPcj39ajZmSSnKha+1eGPUwGPOpw==
X-Gm-Gg: AY/fxX5eP6vxcXTN5AJkZOW0fS7RRGBzZgyc/YRt5lD+XWadiiruhrw7VvpXBKf+DPw
 qqeTQSbUB4TCKY4isCX+vBguU0qx4xuySfddFJXKCBN4WLcc85arvXU61ORciEeB54yPQ7faTUf
 Cw8A1w9EkBsFCWcPZDpkEiDc+dDtzbjBIMmwvYjNRgTRZbUoDoCW1nHkWEyOiGGJmbvAnzcIdCL
 /Tu4k5g/3MVYkGi8sl/Xr20Zlm347vVqoVL5uqCuQmTk5f5Q4NUrKEC9GkftXoAA6F+q9o/cDFF
 Yvztpp/hIoEhzfJ/NDNAt9mQmmsuxPC2cWRb8Uc4LxxDxQFefgxvL24/pnVV11gNejfof0aK+6q
 xgEOaKW8NLmTta3tR9g+YL9Q9OYxtwEBAV9IEAtNETJguiHWwkgZidCrueRieiTHVrUS6/l5wEC
 RczjbElgyt/avMjAZ/lGV/1WfWLcSKOIKfTeeyeqvPDETzTLGI4KpKha4WAiFYFR6aLXMtRZDNs
 IDSFP3M93f2GRK4qLfLHkaHPVzcWg==
X-Google-Smtp-Source: AGHT+IFmz69m1xpFuVcslGBi9cEhdOxpljiZJRs7GB/9b71I4UBpMcIIHWe29kQfJPgAOJXkH48ihg==
X-Received: by 2002:a05:6a20:12cf:b0:366:2476:db4a with SMTP id
 adf61e73a8af0-3898f9c73b1mr8497374637.59.1767941826276; 
 Thu, 08 Jan 2026 22:57:06 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:57:05 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 34/34] test/functional: Add test for boston-aia board
Date: Fri,  9 Jan 2026 16:54:59 +1000
Message-ID: <20260109065459.19987-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260108134128.2218102-13-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c1704d9275..b996c89d7d 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 test_riscv64_timeouts = {
+  'boston' : 120,
   'tuxrun' : 120,
 }
 
@@ -10,6 +11,7 @@ tests_riscv64_system_quick = [
 ]
 
 tests_riscv64_system_thorough = [
+  'boston',
   'sifive_u',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_payload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa')
+
+    ASSET_ROOTFS = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootfs.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565')
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file={rootfs_path},format=raw,snapshot=on')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        cmd = [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file={rootfs_path},format=raw,snapshot=on',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result = run(cmd, capture_output=True, text=True, timeout=5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP count")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.52.0


