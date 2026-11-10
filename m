Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0960A380E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N3kVgN3w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmDV-0002lj-Me; Tue, 10 Nov 2026 08:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQmDU-0002lR-6q
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:48:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQmDR-0007eU-Mv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:48:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso15762615e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794318527; x=1794923327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MU/hWuJhy9vPXtZ1xFRCzD80SgcRCoDtxuyDTNZiAWI=;
 b=N3kVgN3wl3RzmLTYooM4fZw84M7CHZMoo62scfi/aWJf5S4mfZGpU8SxIicRqmu5Ov
 Des6v6V/FZzyD8ehfa3BaBu5Azk+r0AD2m9tsa7GC7XbSYon9jULTgUpriy8b9jI0tlZ
 0bRxSF/2H3y3bK+WvcQeGlUL1x1S6K+8Pfwa92XqlVm/TaGDs9UIy9/icOQPro2onKNl
 hsWIPi1vNDngcDoucbrIh4xQ3XkQl4LTFFCTfcSr43zvkgTf4TTCS6VrAoEEIU2nWOSI
 kf/pX1mrWKhn9MCAKRwTTd3+SQ/a24cLLUhK7rdpR1wDLZA/ZZhUKcqnAPr/wYSRKX1Y
 YeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794318527; x=1794923327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MU/hWuJhy9vPXtZ1xFRCzD80SgcRCoDtxuyDTNZiAWI=;
 b=F8MXJ8oGwDjqJ3J20ZdDT2gsRuh1gvHiVWvwK8RfLokiTVa7aer3w2eVm+65SN8V7F
 2r1Rzp/SqqE7T/+miThS381aqV+0q9BpZGzfH1qs9OuoNeVamzrFUpP9Qe3RCHOE7TRz
 uU2oR0aPggekPnpTcldtvYNfPoqg4710B4pazAldfehAFzHD64yhi/+xTRi8/tpbsCY2
 ybKGLbuyQw5dfwZd5evEwhlztDz0bJ3gd6g4/KCIrr2IpUT9fnnswPtLzYkHpiJ/vyy9
 iZ9MCpceQtCUATHhMGML3tnbuD1BaioPBYTbKOFhzjyipweUJgXKhkGD2n5/F8ZFGkN9
 Mo+Q==
X-Gm-Message-State: APuU4Z+JQ8rQdivIxtvKnVhTFZeNk6nTQ7/bG2EQqI0d+bYfTXW/zCOq
 T7yHO6Pr5jA/4dv66hDlRoQCyh7pnurXbIvGgSO8yIkP/1oJPTLGz+ILiHVgiMtVNWLY+EMFjof
 gwXu1eZw=
X-Gm-Gg: AYBFou15ClFnvMO7V/gWQFdVD9dahoxaCr2uBnfSj/V5SFaYQIahdy2D6RnIdhjfMwY
 jAFsY/ML5pMz/hdmLGW/lKhp/g1bfeW2QPcDsXCLInlWEfRXGvMLNXoYwzAbaUO8wNAMTvsTW/f
 JTlwQYvey60/6WNvwHf9eX8mirlgjz1foKqJpeQePZ/Ug7KeC3zvPpWtck4MihfNukMrHLQKc/3
 5bCCvkPAhCt5J4LkLAdkY6ofsDyWBWGwp8z8y5/k0GkDkt/v84bnh83z1FXQislVGDiZr8wftj5
 xYiQ0h0+eHnGAJcm/rDka3bExfsYN5FHbhlWHDagFfQuJGo6z/0K8nF+hZva3+VRnbTrUPW44e1
 BhvvZJnvyg58qcYlsB5GV2W4TXEOZIH7aX+q6jWItkpLBi8lZcvZBmtGVwVq/pVZ9h+PBr1Wigb
 fkI2WmUhOH3lWSniZ38Ru1MilmaXS1baZErlDn5+lWLEe26ROvpWE9drFNbPWlHxWb7ocRDsi2c
 ymn2besQai7HPphARXVkwbUIeKqfXWbp7ShZBuxkeOUFg4o1DLxij+w47N5xXZCBrldN6FKSsx/
 USVUx3cL/YapqYQuZIljScueimTA71tPHr8QVGTgmzxM6sep1ykk/vZTiYofyqDTFsoid+OQB5+
 bnqJAddb8AuFTS1conR9TYy615qOE/ZoRig==
X-Received: by 2002:a05:600c:4e55:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4ba0233e687mr45060105e9.8.1794318527323; 
 Tue, 10 Nov 2026 05:48:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835d2c05dsm5087444f8f.25.2026.11.10.05.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:48:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] tests/functional/x86_64: Add test for ccid-card-emulated
Date: Tue, 10 Nov 2026 13:48:45 +0000
Message-ID: <20261110134845.1770151-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a functional test for ccid-card-emulated.  This roughly follows
the usage procedure we document in system/devices/ccid.rst of
creating some fake certificates, pointing the device at them, and
then inside the guest querying the smartcard for the certificates and
checking they validate.  It deviates slightly from the suggested
commands in the docs because the buildroot based rootfs doesn't have
glibc and so "NSS-based smartcard integration with coolkey plus
certutil" doesn't work.  Instead we use opensc's pkcs15-tool to read
the certs off the card and check them with openssl.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Here's the functional test I mentioned when I sent my other
patch for ccid-card-emulated.
---
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_ccid_emulated.py | 169 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100755 tests/functional/x86_64/test_ccid_emulated.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index bcda07620ff..9ed55fa99b3 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -35,6 +35,7 @@ endif
 
 tests_x86_64_system_thorough = [
   'acpi_bits',
+  'ccid_emulated',
   'hotplug_blk',
   'hotplug_scsi',
   'hotplug_cpu',
diff --git a/tests/functional/x86_64/test_ccid_emulated.py b/tests/functional/x86_64/test_ccid_emulated.py
new file mode 100755
index 00000000000..0c2d02fb3de
--- /dev/null
+++ b/tests/functional/x86_64/test_ccid_emulated.py
@@ -0,0 +1,169 @@
+#!/usr/bin/env python3
+#
+# Test of the ccid-emulated device. This roughly follows the lines
+# suggested in our documentation of it, but deviates a bit because
+# the buildroot-based rootfs we use doesn't have glibc to use the
+# certutil + NSS validation process. Instead we use opensc's
+# pkcs15-tool to read the certs off the card and openssl to check them.
+#
+# Copyright (c) 2026 Linaro Ltd
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+import subprocess
+
+from qemu_test import (Asset, exec_command_and_wait_for_pattern,
+                       skipIfMissingCommands)
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+
+class CCIDEmulatedTest(TuxRunBaselineTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/20261110/6.18.54/x86_64/bzImage',
+        'ba98a8a07d5f3f3e20119341059c0f0096fda499d30e30049c1ea64553b7e7c2')
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20261110/x86_64/rootfs.ext4.zst',
+        '267172d47dc9594a8f07ec7fec05dc17b0fc21c64d5b635fccd6455128a2eb58')
+
+    DEFAULT_KERNEL_PARAMS = ('console=ttyS0')
+
+    def create_certs(self):
+        # Create a CA and certificates in a dir under our test's
+        # working dir (removing any stale contents it had first). We
+        # return the db_spec that the ccid-card-emulated options need,
+        # plus the filename of the exported CA cert
+
+        certdir = self.scratch_file("certs")
+        shutil.rmtree(certdir, ignore_errors=True)
+        os.mkdir(certdir)
+
+        db_spec = f'sql:{certdir}'
+
+        # certutil will by default block asking for some keyboard
+        # input to get randomness; create a noise-file to pass to it
+        # instead so it will work non-interactively
+        noise_file=self.scratch_file("noise.bin")
+        with open(noise_file, 'wb') as f:
+            f.write(os.urandom(2048))
+
+        subprocess.check_call(['certutil', '-N', '-d', db_spec,
+                               '--empty-password'])
+
+        # We explicitly specify serial numbers (420, 421, 422, 423),
+        # because certutil's default is to generate a serial based on
+        # the current time, and when run from a script it will end up
+        # repeating the same serial for two certificates, which causes
+        # it to error out.
+        subprocess.check_call(['certutil', '-S', '-d', db_spec,
+                               '-z', noise_file,
+                               '-s', "CN=Fake Smart Card CA",
+                               '-x', '-t', 'TC,TC,TC',
+                               '-m', '420',
+                               '--keyUsage',
+                               'certSigning,crlSigning,critical',
+                               '-n', 'fake-smartcard-ca'],
+                              stdout=subprocess.DEVNULL,
+                              stderr=subprocess.DEVNULL)
+
+        subprocess.check_call(['certutil', '-S', '-d', db_spec,
+                               '-z', noise_file,
+                               '-t', ',,',
+                               '-s', "CN=John Doe",
+                               '-n', 'id-cert',
+                               '-m', '421',
+                               '-c', 'fake-smartcard-ca'],
+                              stdout=subprocess.DEVNULL,
+                              stderr=subprocess.DEVNULL)
+
+        subprocess.check_call(['certutil', '-S', '-d', db_spec,
+                               '-z', noise_file,
+                               '-t', ',,',
+                               '-s', "CN=John Doe (signing)",
+                               '--nsCertType', 'smime',
+                               '-n', 'signing-cert',
+                               '-m', '422',
+                               '-c', 'fake-smartcard-ca'],
+                              stdout=subprocess.DEVNULL,
+                              stderr=subprocess.DEVNULL)
+
+        subprocess.check_call(['certutil', '-S', '-d', db_spec,
+                               '-z', noise_file,
+                               '-t', ',,',
+                               '-s', "CN=John Doe (encryption)",
+                               '--nsCertType', 'sslClient',
+                               '-n', 'encryption-cert',
+                               '-m', '423',
+                               '-c', 'fake-smartcard-ca'],
+                              stdout=subprocess.DEVNULL,
+                              stderr=subprocess.DEVNULL)
+
+        # Now export the CA cert to a file
+        ca_cert = self.scratch_file("fake-smartcard-ca.pem")
+        subprocess.check_call(['certutil', '-L', '-a', '-d', db_spec,
+                               '-o', ca_cert, '-n', 'fake-smartcard-ca'])
+
+        return (db_spec, ca_cert)
+
+    def run_cmd(self, cmd):
+        # Run a command, and wait for the following prompt
+        exec_command_and_wait_for_pattern(self, cmd, '# ')
+
+    @skipIfMissingCommands('certutil')
+    def test_ccid(self):
+        self.set_machine('q35')
+        self.require_device('usb-ccid')
+        self.require_device('ccid-card-emulated')
+        self.cpu = 'Nehalem'
+        self.root = 'sda'
+
+        (kernel, disk, _, _) = self.fetch_tuxrun_assets(self.ASSET_KERNEL,
+                                                        self.ASSET_ROOTFS)
+
+        (db_spec, ca_cert) = self.create_certs()
+
+        certspec = f'db={db_spec},cert1=id-cert,cert2=signing-cert,cert3=encryption-cert'
+
+        self.vm.add_args('-m', '1G', '-usb',
+                         '-device', 'usb-ccid',
+                         '-device',
+                         f'ccid-card-emulated,backend=certificates,{certspec}',
+                         '-fw_cfg', f'opt/org.qemu/ccid-test,file={ca_cert}')
+
+        self.prepare_run(None, kernel, disk,
+                         drive="driver=ide-hd,bus=ide.0,unit=0")
+        self.vm.launch()
+
+        ps1='root@tuxtest:~#'
+        self.wait_for_console_pattern(self.kcmd_line)
+        self.wait_for_console_pattern('tuxtest login:')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
+
+        self.run_cmd('cp '
+                     '/sys/firmware/qemu_fw_cfg/by_name/opt/org.qemu/ccid-test/raw '
+                     '/tmp/fake-smartcard-ca.pem')
+
+        # Start the daemon which actually talks to the smartcard
+        self.run_cmd('pcscd -d')
+
+        # list the certs; having this in the console log may help debugging
+        self.run_cmd('pkcs15-tool --list-certificates')
+
+        # Read each cert off the card, and get openssl to check that it
+        # validates against our fake CA cert
+        for cert in ('0001', '0002', '0003'):
+            self.run_cmd('pkcs15-tool '
+                         f'--read-certificate {cert} -o /tmp/cert-{cert}.pem')
+            exec_command_and_wait_for_pattern(self,
+                                              'openssl verify '
+                                              '-CAfile '
+                                              '/tmp/fake-smartcard-ca.pem '
+                                              f'/tmp/cert-{cert}.pem',
+                                              f'/tmp/cert-{cert}.pem: OK',
+                                              failure_message='# ')
+            self.wait_for_console_pattern('# ')
+
+
+if __name__ == '__main__':
+    CCIDEmulatedTest.main()
-- 
2.43.0


