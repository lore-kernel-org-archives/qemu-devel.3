Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C5DF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heR-0005Nv-Mq; Mon, 23 Mar 2026 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he3-0005Ej-BR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007tP-Hf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso482524866b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281403; x=1774886203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4sVo7ipM3ZjIyISVk1iGmWS/zTxx2pGnjJAKAGfU5o=;
 b=GB5i2dTvd/sy7BQgveuWAp+zObG5yby2uLMeO/1QBy40xBS6Cdbca7F++Pzn6yavpE
 RataaFszml7D23qW3BHgDQK2iwlmNv/LeVe8ie/+aBsxrNnFaerTaKOPolLSysvC9y+z
 IXGfGLTj0DFLjS2qMRA23gTvReGijPkOKS2pUeyrmegS0EfD10XkEStBxEIkuS2RYjKS
 NVyQnGAjzVgdt0RU533BX04q30aC0ifmC5BSuE7RnQp/nznpavl3ck8tV0aGmRoyW5V6
 0LxlCOfbAiigvDpLylwnQ4XVJ6zr37vL5plKGugmX/J11J9jed2DDTNV2oPR/qX8d8yp
 cajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281403; x=1774886203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L4sVo7ipM3ZjIyISVk1iGmWS/zTxx2pGnjJAKAGfU5o=;
 b=NgGxRWdp1vjCsyIBmlGdRYMoYbrz6X99yh1ow6lD+Y0JUL/AKdH4b5pGWvJs0kWU9b
 W7wGOA7azqbKoyrIURTzjB9Z5hM4aXAx9r+nKE9wklKh/S7Y1XvV9MJoBKE0NP56RnnM
 MJiPPb9ioerg3l0Jm71TxYLRpxBiumCXmU+1wwXINQAqXv2jH/iZy9Qk+L731DRe+KKr
 fU1rj2MJpOghTW9Hvf6GRqmEgvEmLRFZoCDNUGan0WZIqMaUkdaZxO4FvWTPeGU6+uox
 TvQvlPpojgW7pMlHskjQ4oKjwhYYHmvvimUCpoSrcl6muvy16kwa8duRsBuvzcOZUJBR
 UZEA==
X-Gm-Message-State: AOJu0YxRqIZtxja2sAUGFrQdjeR/qoFq8KmiVYkMX07ttz7pv786usk1
 G22LlSr8KU51kFZ3Qf0K2NL2z1G3cVER1max9UsgSa7vB2NSfW4dsw8UIW2V0GcuX0w=
X-Gm-Gg: ATEYQzwxzj/zvr9NPeMWEDwj+3OR4IIxWOPGA4hCveXqL110PSoXBbxsMI7lVZXnt2H
 DEUD1MOsAo3e2+VQe8nXoCCNJ4jLG699qoa5BfSTPdUq7SCRxWVP/5zfRLz1fMGW37++s29hDC9
 ozyE5niqooxc2M0zHQgLGsRBACH1gDBrdIJvhxgK2/T0tpPjWlMUh7CedBFsXFYVLYh2J/jTJfZ
 1/c/dkEsKxijQ741zfv2N9bNpVzoVGnCY+idmrvHTVtnCu9Mq30W6P0XpwYLEBNUWjaSZEaDKNT
 /KaOATflLIQGqJm3QRJ4BN+xsvqJUurp1bN5PRWgiRpoqu0T7PFsDP/bQ5YM9g6yWtMvW+ApnqU
 WhlWsUP057djxs2/LMrolOE0D+o3H0tEFIxkDw73byiDwT68dvkPxG53h6bliAeYTea8lcBXLO6
 THJfIUyhU7sGcf/tM/o5G9AlM=
X-Received: by 2002:a17:907:5c8:b0:b98:3293:ebb3 with SMTP id
 a640c23a62f3a-b988641045amr5649466b.26.1774281401635; 
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9833663137sm520102566b.49.2026.03.23.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 389C95F878;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 4/8] tests/functional: add VBSA linux tests
Date: Mon, 23 Mar 2026 15:56:33 +0000
Message-ID: <20260323155637.145015-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
Message-ID: <20260320155107.2143191-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


