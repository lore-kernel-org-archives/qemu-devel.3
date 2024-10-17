Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74BAD3C521
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TQv-0000Ad-F3; Thu, 17 Oct 2024 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TQp-0000A4-2R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:32:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TQh-0001q3-PL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:32:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431137d12a5so12041295e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182770; x=1729787570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AgkgaAbQziOMfScOkAqQCRk4aNQbQUVYEqERQ+sqzM=;
 b=i5tDxpu165fhKhHk9bShqX52TRRKJ8KaA3d36gOPamUkGSI9SqBvXBC5yMiZBpOOBB
 1R+rjsw53yyL7rE9aRrC3Lg7pz2VGVKh8BfJnAVBngUDsbzBZKHHi22koh3sdm4n1yrp
 SorR+L7ZybupUMSAttP7QUvTveCWQlwV0Mi8hTYPhn0wi2OHP+sAHGQUOcWqMocvXX66
 s+VwZOJQ6WY7R0sRvfW4eOfpw+x+esI2D9tJ+mm92PmCajAadW3pc6tRH4F2KTTA776S
 AgbHJuwXGZOpN+l9lmN+mNQi/Ik6fyeeW+ZLFucrdMp7p54uI2DMeAM00uyqorM9m+1E
 37XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182770; x=1729787570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AgkgaAbQziOMfScOkAqQCRk4aNQbQUVYEqERQ+sqzM=;
 b=WwQE29OKEIcjb6qI269L009USI8d1yfQg6lcNxm7PblBVOz6u5yH+RljWoMi7dSI2T
 RbCllOZa1HH7+FWRfkKr1VkLYl/ir/p5e53k5LGvNRWsTDq+R7QgZJJ0MV8g/KRsv7N3
 EVFUZge8Fp/tg8V8Fhm8oopgxTlbCnAtNvYN5d7oqRIWyx45INNFH2pDOx878ZIPesNZ
 O70//HqDk0dGQHgyyfsBAt2eO4Lvv0zj4cuTCijjTHMwQvQR6eXtzJmXvAVtvFMs1fGT
 o6iw8p13wNIJeEFD6oH8ivugCphB09l2aa5A1LlAVXgDIOWUI8Zp/8fD4ynG/38JOz/Q
 a5Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW256c/KziddvLf06IjkJINFEqt91+NIQTk6Nk6cWZbhx7hmPZEUN2mSilcOn1rP9mEbJMAdinE1J+7@nongnu.org
X-Gm-Message-State: AOJu0YzSOrPo4a0UH3thpa2AsCPLk/et/2goQ8cV/I60O7MfZUC0F1N/
 TDh487CFpIGOQoVzV7KCMLbSRqxTiMsplHCAxghwKOXE+6ZRoJyWzp92Vko1eNc=
X-Google-Smtp-Source: AGHT+IEiZ11hPVxFdsgWTsoCL474PZCwiVi+Uoc7g8T1OZnst3FGZB1GV9b+SP1JIbWg4HV90wlMcQ==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4311decaa31mr199654335e9.10.1729182770227; 
 Thu, 17 Oct 2024 09:32:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc56sm545165e9.3.2024.10.17.09.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:32:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] tests/functional: Add a functional test for the sx1 board
Date: Thu, 17 Oct 2024 17:32:47 +0100
Message-Id: <20241017163247.711244-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017163247.711244-1-peter.maydell@linaro.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a functional test for the sx1 board that uses the kernel and
rootfs provided by Guenter Roeck in the linux-test-downloads repo:
 https://github.com/groeck/linux-test-downloads/

We have three variants of the test for this board:
  * just boot initrd
  * boot with filesystem on SD card
  * boot from flash

In all cases these images have a userspace that is configured to
immediately reboot the system on successful boot, and the board
itself supports telling QEMU to do the reboot, so we only need to
wait for QEMU to exit (via -no-reboot).

Since there are three subtests, the test as a whole takes about
80s on my local machine. That's about the same as the aarch64_virt
test, so give it the same overall test timeout as that one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The sdcard test requires the 'hw/sd/omap_mmc: Don't use sd_cmd_type_t' bugfix.
---
 tests/functional/meson.build     |  2 +
 tests/functional/test_arm_sx1.py | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/functional/test_arm_sx1.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0450805a9c4..ec72bfaf63e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -16,6 +16,7 @@ test_timeouts = {
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
   'arm_raspi2' : 120,
+  'arm_sx1' : 360,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -54,6 +55,7 @@ tests_arm_system_thorough = [
   'arm_collie',
   'arm_integratorcp',
   'arm_raspi2',
+  'arm_sx1',
   'arm_vexpress',
 ]
 
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
new file mode 100755
index 00000000000..2d86405831e
--- /dev/null
+++ b/tests/functional/test_arm_sx1.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Functional test that boots a Linux kernel on an sx1 machine
+# and checks the console. We have three variants:
+#  * just boot initrd
+#  * boot with filesystem on SD card
+#  * boot from flash
+# In all cases these images have a userspace that is configured
+# to immediately reboot the system on successful boot, so we
+# only need to wait for QEMU to exit (via -no-reboot).
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class SX1Test(LinuxKernelTest):
+
+    ASSET_ZIMAGE = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/zImage',
+        'a0271899a8dc2165f9e0adb2d0a57fc839ae3a469722ffc56c77e108a8887615')
+
+    ASSET_INITRD = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.cpio',
+        '35b0721249821aa544cd85b85d3cb8901db4c6d128eed86ab261e5d9e37d58f8')
+
+    ASSET_SD_FS = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.ext2',
+        'c1db7f43ef92469ebc8605013728c8950e7608439f01d13678994f0ce101c3a8')
+
+    ASSET_FLASH = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/flash',
+        '17e6a2758fa38efd2666be0879d4751fd37d194f25168a8deede420df519b676')
+
+    CONSOLE_ARGS = 'console=ttyS0,115200 earlycon=uart8250,mmio32,0xfffb0000,115200n8'
+
+    def test_arm_sx1_initrd(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.launch_kernel(zimage_path,
+                           initrd=initrd_path)
+        self.vm.wait()
+
+    def test_arm_sx1_sd(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        sd_fs_path = self.ASSET_SD_FS.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mmcblk0 rootwait {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.vm.add_args('-snapshot')
+        self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
+        self.launch_kernel(zimage_path)
+        self.vm.wait()
+
+    def test_arm_sx1_flash(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        flash_path = self.ASSET_FLASH.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mtdblock3 rootwait {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.vm.add_args('-snapshot')
+        self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
+        self.launch_kernel(zimage_path)
+        self.vm.wait()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


