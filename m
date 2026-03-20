Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC35910987A1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8G-0007c2-Ly; Fri, 20 Mar 2026 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c84-0007Xq-N3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:16 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c81-0005WA-RS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:16 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so1226881a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021872; x=1774626672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0fhuaBJdOuUGUkX7QYGpAS75ZDvg8jajU+pZxhAjHw=;
 b=Xae5ASASezCM2JtqVkX0Ug3c81SijJraeivF3nFZfN51mSNV5x+agS2nY6adjtAKY9
 14/tgekZ/tg0YBBYGcett/nIOLWp6gKM8QeNI6YZQQuiT3cqFg3wRFZNZ8Ya6wBIlt5o
 7Oq9SKaqAStwlo05CMlOhZiHIkpwWzdF3Oyej3QtawUc8CH2LtBgD+dmlplVv7wQbkwS
 qubgUrT+0qct1fukkYfUPYRaUylBfqv81HqWcFz76BFcDHmZOgZmnEtFrk3w1ws0J8MX
 l/Bq241SRIdlzH6Nn0XNkspJjXu3nA35/kdGyvq6GNb3nzxM+b9F11tFenH3HNQCVNhC
 UxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021872; x=1774626672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S0fhuaBJdOuUGUkX7QYGpAS75ZDvg8jajU+pZxhAjHw=;
 b=E2+HdTMz0jP+xKz0pXByfJARlhWIlilNYT1tizp8E8OBoNSmpq2G1CrYqqrH9o2uwS
 /d1LPc/5kf8BbkX/TQpnih4o5w9U3bfHq6Xx4n6dvGxuZwfNUb1SxShl1rXGNTqXfnot
 MtJWwd4XkDcPqPnViM4Ly9AprSjloTsTUQesL6yOQdfP+1RrbuRADP2Roht5/2xNXRLh
 Y5iNJyRiAK7bXNixqKTU1lX1qAJY6mA8MX99YJcacHZy8Xl9zDHK/G2Z8dQzC7ThFzJY
 Fi51pRcgc5IOuRM31xnrJJOrUQ+QUd9qgO3RjUUpZWyxNhWKn3MXq2WYeBJgW+bvKJXu
 fvCg==
X-Gm-Message-State: AOJu0YxoOxaIZygFbhRO74zcSWhLc3nMan1aCTs/V6W7Q8PfxEPU+AuR
 RVmA7Ew8rn7SEL31QIqfVVHxkER2273a8NzfFchb2X62sf6T3wZxRMQ5w+a++SjYIec=
X-Gm-Gg: ATEYQzx1w3RZIm63gEyXHLNDCJG1lHKiuKXSCWrZK0gZ6Fj5hGN2lIWVXR/dv8mnnjx
 /17pIqTez7eb46Nk4avm7ombWfagzgmmoihDtmusJzr2Ek4UkA5KkWot+fHsrLyqkCAqgwJ9l9Y
 mW+RyGO48xX7+eDbaLN2NyUyfjLg6kLawIpwsFMTrY1VJqyHbkgm1UIBW/ewUAO1arfs2eooAk/
 SBocQ4TPEHDX99n/dmXO8BwCvLEta65Nzf+C+b+MAuKAtBXznrS/DWSRuqGJDz7T2WgjqDv1Dyd
 rs5oetvp7TUduAwV6/EziGkSUUK2iVhWs7V/oZiRlRGSeI4HNxNawDxd59OEL6rdy4Lj9og1sKu
 bIT0CYJWr4IugRv5a4jfjI3I74sUCtOY4gfeYtpY4yP7ZdLZTsafmqFE3rqu9DER25w7FZrgkwL
 j3VLX97jlqNRYtBsDVlwRHNvU=
X-Received: by 2002:a05:6402:5287:b0:65f:81be:e7a5 with SMTP id
 4fb4d7f45d1cf-668c9c3f203mr2833499a12.23.1774021871872; 
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d1cc5f1dsm1453278a12.14.2026.03.20.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 252745F91F;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 4/8] tests/functional: add VBSA linux tests
Date: Fri, 20 Mar 2026 15:51:03 +0000
Message-ID: <20260320155107.2143191-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - dropped unused imports
  - use archive_extract for the zip step
  - drop virtuilization=on and smmu=max lines from config
  - use utf8 encodings for file access
  - don't use f"" strings when not needed
  - hack grub.cfg rather than using key presses
---
 tests/functional/aarch64/test_virt_vbsa.py | 122 +++++++++++++++++++--
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
index 1dd4cecde1e..57bfe5d7af2 100755
--- a/tests/functional/aarch64/test_virt_vbsa.py
+++ b/tests/functional/aarch64/test_virt_vbsa.py
@@ -10,7 +10,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import shutil
-from subprocess import check_call, DEVNULL
+import re
+from subprocess import check_call, check_output, DEVNULL
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import get_qemu_img, skipIfMissingCommands
@@ -28,6 +29,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
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
@@ -45,20 +60,12 @@ def test_aarch64_vbsa_uefi_tests(self):
 
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
@@ -102,5 +109,98 @@ def test_aarch64_vbsa_uefi_tests(self):
         self.wait_for_console_pattern('VBSA tests complete. Reset the system.')
 
 
+    ASSET_SYSREADY_IMAGE = Asset(
+        'https://github.com/ARM-software/arm-systemready/'
+        'releases/download/v25.10_SR_3.1.0/systemready_acs_live_image.img.xz.zip',
+        'df2c359de15784b1da6a8e6f3c98a053ee38ac0b3f241ccea62e17db092eb03a')
+
+    ROOT_PROMPT = '/ # '
+
+    @skipIfMissingCommands("sfdisk", "jq", "sed")
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
+        # Plain virt machine
+        self.set_machine('virt')
+        self.vm.add_args('-M', 'virt,gic-version=max')
+        self.vm.add_args('-cpu', 'max', '-m', '1024', '-smp', '4')
+
+        self.append_firmware_blobs()
+
+        # First fetch, decompress (twice) and prepare the disk image
+        # on an NVME device (the kernel only has drivers for that).
+        self.archive_extract(self.ASSET_SYSREADY_IMAGE, format="zip")
+        disk_image_xz = self.scratch_file("systemready_acs_live_image.img.xz")
+        disk_image = self.uncompress(disk_image_xz)
+
+        self.vm.add_args('-device',
+                         'nvme,drive=hd,serial=QEMU_ROOT_SSD')
+        self.vm.add_args('-blockdev',
+                         f'driver=raw,node-name=hd,file.driver=file,file.filename={disk_image}')
+
+        # Tweak grub.cfg default to avoid manually navigating grub
+        grub_cfg = self.scratch_file("grub.cfg")
+        offset = int(check_output(f"sfdisk --json {disk_image} |"
+                                  "jq '.partitiontable.partitions[0].start * 512'",
+                                  shell=True))
+        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
+                    "::/EFI/BOOT/grub.cfg", grub_cfg])
+
+        with open(grub_cfg, 'a', encoding="utf8") as f:
+            f.write("set default='Linux Execution Enviroment'")
+
+        check_call(["mcopy", "-D", "o",  "-i", f"{disk_image}@@{offset}",
+                    grub_cfg, "::/EFI/BOOT/grub.cfg"])
+
+        # Launch QEMU and wait for grub and select the "Linux
+        # Execution Environment" so we can launch the test.
+
+        self.vm.launch()
+        self.wait_for_console_pattern(self.ROOT_PROMPT)
+        ec_and_wait(self, "/usr/bin/bsa.sh --skip "
+                    "B_REP_1,B_IEP_1,B_PCIe_11,B_MEM_06",
+                    self.ROOT_PROMPT)
+
+        # Now we can shutdown
+        ec_and_wait(self, "halt -f", "reboot: System halted")
+        self.vm.shutdown()
+
+        # and extract the test logs
+        bsa_app_res = self.scratch_file("BsaResultsApp.log")
+        bsa_kern_res = self.scratch_file("BsaResultsKernel.log")
+
+        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
+                    "::acs_results/Linux/BsaResultsApp.log", bsa_app_res])
+        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
+                    "::acs_results/Linux/BsaResultsKernel.log", bsa_kern_res])
+
+        # for now just check the kernel log for the result summary
+        test_result_re = re.compile(r"\[.*\]\s+(.+): Result:\s+(\w+)")
+        summary_re = re.compile(r"Total Tests Run =\s*(\d+), Tests Passed =\s*(\d+), Tests Failed =\s*(\d+)")
+
+        with open(bsa_kern_res, 'r', encoding="utf8") as f:
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


