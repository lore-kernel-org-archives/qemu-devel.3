Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A58FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs5-0008Em-Gs; Fri, 06 Mar 2026 11:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrw-0007NT-8B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrs-0007k7-EG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso3415785e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813854; x=1773418654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqXQr4uENYp7Zhjhp+PlBR4pffBHMkJZVYziiA75uYo=;
 b=zV4C65+4jPK7wTIZV5THW0GzSzqehAr0P7LD+5Nj/gBxGzIFZKU52tp4GUBLeodq+2
 oJKT6P2rWVSNAQxeE/G7Vfkx4AD70HLx5BJ5mqm/wksMy154qvhrmgaKhv+c1ldYaFXN
 uJzn6ux8qWsAF8e/qMCxiJo9mCWEmCPN8F7uKDJL/1STEujZREwhUkOHgyRqUQNXp2Sj
 r/9Q9IwcQIn6L+icYvaGzgNlGOzM6dHC9BFxmrBdzaoPtDowjKZX3DZSQwMvTqaZPY00
 LGuvhPONQy6Xez+DTgUZpuYdK/5R3u5BL7Xj6Co1eFv93kvnMio7x6yq22EduMpGgEV3
 jhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813854; x=1773418654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dqXQr4uENYp7Zhjhp+PlBR4pffBHMkJZVYziiA75uYo=;
 b=RdryjssjdxdbhRZhG9T31FRkSfrOoZSVN1Fky6nMZZ4clg+9CDC5058L0SNKOR5ZKD
 lhrDznfU5lRVbdNs88OnpwInke7ZzS36fGc8FGS2h3pGUO2PnhzJ+VuvbkyibQv4MR8v
 uoZQvJwJd2+1zZXMQ3Nlb3OiNClqEWHUNrg3EuVJrwtsLWGsPyq4boMDXU1KgpadokQf
 GK/uuyX9b3DQv9RTxwKyZh3P9+Wut83H3zW6LpaChrtzvYnrx9f6Qts1qHl0QHbl42bb
 I0twVqTT3D1gszQCQZwIszcRCd5jI9CCZ9/jfNHLapROfMUoRzPqAepdvXGIygLW4Pgw
 nRIw==
X-Gm-Message-State: AOJu0YwVgVk+oTaPaMCAX2/Q8IYqW6c9qlHEtRJrFgsKQpsRSzOphXdy
 di4i6SwTrhaqUHgP0QhKSqeWt88F12beUdNvU/P2TMHnFXSqmKTZqg7DGExdDTYlOzI=
X-Gm-Gg: ATEYQzzdpxNEJAA/Nky6pQDn2E60P5jc8myZpg+Il/2eYK8t3J93qvmcUnVNAXKW7/Y
 9B6TQq7nFcvaZa5CtHWlIFAq7WoRMb/rrzT3fqny1RVCH5JTYRJE4imU12dgxxQvPUx/RC0pMUV
 pYUDX348GGXReC9pL2reTBG2OZH2mBi5cBosa+75Slcq7T/Fds0y05CjB+uvNLcLeni4jvCeu5L
 npp2h14g2A/o7BrhdAsYCtxia/he2KJ6pUmcanqEvwc7H1Ri3jDyp85Sh5Y8NI2GVjVAfqeDeaJ
 tdO95lv02629SjMuEubm4ok3wkV8a3drD41rDsKSUnaM0R3XKc6+OU6PmVxXrqVLQHw62JYOYsF
 wRNeh9c3D2DDRSwaw2LYDVh6SrHTO3YMvmGEU4wk477M+M3MN4xb5S1kg7aRshMcmlq5vIOO6hk
 XTwjzQ8QWFYP+8EfRpm8yny8VHaMX+WxGFvA==
X-Received: by 2002:a05:600c:1c03:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-48526930d92mr47852765e9.13.1772813854432; 
 Fri, 06 Mar 2026 08:17:34 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852767d8e4sm42639265e9.2.2026.03.06.08.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80092689D6;
 Fri, 06 Mar 2026 16:17:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 7/7] tests/functional: add VBSA linux tests
Date: Fri,  6 Mar 2026 16:17:28 +0000
Message-ID: <20260306161728.2657486-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This extends the VBSA test to run the linux tests. The sysarch-acs
test suite does provide some pre-built images which is good because
the tests require a patched kernel. However due to the structure of
the image we need to jump one or two hoops to get something useful:

  - download and double decompress (zip then xz) the image
  - navigate grub to launch the Linux Execution Environment
  - shutdown the system once tests are done
  - extract the logs from the MSDOS file system and parse them

It does make the code a bit ugly but it works for me at least. So far
the subset of tests run is limited but that might be solved by adding
some more devices to the PCIe bus to exercise the SMMU behaviour.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_virt_vbsa.py | 123 +++++++++++++++++++--
 1 file changed, 112 insertions(+), 11 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
index 1dd4cecde1e..0456dfe9fd5 100755
--- a/tests/functional/aarch64/test_virt_vbsa.py
+++ b/tests/functional/aarch64/test_virt_vbsa.py
@@ -10,12 +10,15 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import shutil
-from subprocess import check_call, DEVNULL
+import re
+from subprocess import check_call, check_output, DEVNULL
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import get_qemu_img, skipIfMissingCommands
 from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern as int_until
 from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
+from qemu_test import send_key
 
 
 @skipIfMissingCommands("mformat", "mcopy", "mmd")
@@ -28,6 +31,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
                                  failure_message='FAILED',
                                  vm=vm)
 
+    def append_firmware_blobs(self):
+        """
+        Setup QEMU firmware blobs for boot.
+        """
+        code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
+        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
+        vars_path = self.scratch_file('vars.fd')
+        shutil.copy(vars_source, vars_path)
+
+        self.vm.add_args('-drive',
+                         f'if=pflash,format=raw,readonly=on,file={code_path}')
+        self.vm.add_args('-drive', f'if=pflash,format=raw,file={vars_path}')
+
+
     ASSET_VBSA_EFI = Asset(
         'https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
         '/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Vbsa.efi',
@@ -45,20 +62,12 @@ def test_aarch64_vbsa_uefi_tests(self):
 
         self.vm.set_console()
 
-        # virt machine wi
+        # virt machine
         self.set_machine('virt')
         self.vm.add_args('-M', 'virt,gic-version=max,virtualization=on')
         self.vm.add_args('-cpu', 'max', '-m', '1024')
 
-        # We will use the QEMU firmware blobs to boot
-        code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
-        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
-        vars_path = self.scratch_file('vars.fd')
-        shutil.copy(vars_source, vars_path)
-
-        self.vm.add_args('-drive',
-                         f'if=pflash,format=raw,readonly=on,file={code_path}')
-        self.vm.add_args('-drive', f'if=pflash,format=raw,file={vars_path}')
+        self.append_firmware_blobs()
 
         # Build an EFI FAT32 file-system for the UEFI tests
         vbsa_efi = self.ASSET_VBSA_EFI.fetch()
@@ -102,5 +111,97 @@ def test_aarch64_vbsa_uefi_tests(self):
         self.wait_for_console_pattern('VBSA tests complete. Reset the system.')
 
 
+    ASSET_SYSREADY_IMAGE = Asset(
+        'https://github.com/ARM-software/arm-systemready/'
+        'releases/download/v25.10_SR_3.1.0/systemready_acs_live_image.img.xz.zip',
+        'df2c359de15784b1da6a8e6f3c98a053ee38ac0b3f241ccea62e17db092eb03a')
+
+    ROOT_PROMPT = '/ # '
+    DOWN_KEY = "\x1b[B"
+
+    @skipIfMissingCommands("sfdisk", "jq")
+    def test_aarch64_vbsa_linux_tests(self):
+        """
+        Launch the Linux based VBSA test from the ACS prebuilt images.
+
+        We can use the pre-built images and then trigger the Linux
+        build and run the tests. We then need to slurp the results
+        from the partition.
+        """
+
+        self.vm.set_console()
+
+        # virt machine with SMMU
+        self.set_machine('virt')
+        self.vm.add_args('-M', 'virt,gic-version=max,virtualization=on,iommu=smmuv3')
+        self.vm.add_args('-cpu', 'max', '-m', '1024', '-smp', '4')
+
+        self.append_firmware_blobs()
+
+        # First fetch, decompress (twice) and prepare the disk image
+        # on an NVME device (the kernel only has drivers for that).
+        disk_image_zip = self.ASSET_SYSREADY_IMAGE.fetch()
+        disk_image_xz = self.uncompress(disk_image_zip,
+                                        target="sysacs.xz", format="zip")
+        disk_image = self.uncompress(disk_image_xz,
+                                     target="sysacs.img", format="xz")
+
+        self.vm.add_args('-device',
+                         'nvme,drive=hd,serial=QEMU_ROOT_SSD')
+        self.vm.add_args('-blockdev',
+                         f'driver=raw,node-name=hd,file.driver=file,file.filename={disk_image}')
+
+        # Launch QEMU and wait for grub and select the "Linux
+        # Execution Environment" so we can launch the test.
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Use the ^ and v keys to select which entry is highlighted')
+
+        # 3 down arrows then return to select entry
+        send_key(self, self.DOWN_KEY)
+        send_key(self, self.DOWN_KEY)
+        send_key(self, self.DOWN_KEY)
+
+        ec_and_wait(self, "\n", self.ROOT_PROMPT)
+
+        ec_and_wait(self, "/usr/bin/bsa.sh --skip B_REP_1,B_IEP_1,B_PCIe_11,B_MEM_06",
+                    self.ROOT_PROMPT)
+
+        # Now we can shutdown
+        ec_and_wait(self, "halt -f", "reboot: System halted")
+        self.vm.shutdown()
+
+        # and extract the test logs
+        offset = int(check_output(f"sfdisk --json {disk_image} |"
+                                  "jq '.partitiontable.partitions[0].start * 512'",
+                                  shell = True))
+        bsa_app_res = self.scratch_file("BsaResultsApp.log")
+        bsa_kern_res = self.scratch_file("BsaResultsKernel.log")
+
+        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
+                    f"::acs_results/Linux/BsaResultsApp.log", bsa_app_res])
+        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
+                    f"::acs_results/Linux/BsaResultsKernel.log", bsa_kern_res])
+
+        # for now just check the kernel log for the result summary
+        test_result_re = re.compile(r"\[.*\]\s+(.+): Result:\s+(\w+)")
+        summary_re = re.compile(r"Total Tests Run =\s*(\d+), Tests Passed =\s*(\d+), Tests Failed =\s*(\d+)")
+
+        with open(bsa_kern_res, 'r') as f:
+            for line in f:
+                test_match = test_result_re.search(line)
+                if test_match:
+                    desc = test_match.group(1)
+                    status = test_match.group(2)
+                    self.log.info(f"Test: {desc} status: {status}")
+
+                match = summary_re.search(line)
+                if match:
+                    total, passed, failed = match.groups()
+
+                    if int(failed) > 0:
+                        self.fail(f"{failed} tests failed ({total})")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.3


