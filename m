Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA15E7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCqE-00060E-Pd; Tue, 07 Jan 2025 11:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCpT-00053g-C7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoX-0005v9-Th
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so7639836f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268740; x=1736873540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQuRMWlbCCi01i6ad4dl2DxKLluayG2p5Bfu87XJ3wk=;
 b=Jseg0zP8GYBBVSbTf7mtxdLsyCcHeIG6yOasK5pXyEp8P9MXVuQHhnEtekHsgIpZKx
 R+aeaDRb2J+5VHpHSwUfBaEs2OUbgJfYltJvjTKNDdDT+mDJqqos/FT43fDcgfFMmoCy
 x4qviyS+6MHvRiBwBEKj/Y74y1c3jR1AtVQe51AdTt3IObdVDghXRoao+31xme9XNmr0
 Eyh6ShUQRToTOIdAkExjnUl/ffUds5KcBemkx4ycUbTpfP54vzqzU3cg27kd4IZacQI1
 GqmxD03WcBmhOTw0lYgxRe5HyJKHdPt6UV3jvHchRqhh317+nehJ5SI2W14rVVgc7qcv
 XtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268740; x=1736873540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQuRMWlbCCi01i6ad4dl2DxKLluayG2p5Bfu87XJ3wk=;
 b=OS1LMxvajFkTTPCoE5c3wMzn3Vg5t+zFbRhEB6vSqgWyOzbrGfMxWyNwwXg+90Op8O
 IRXwlssQXinw81XMqLHBiKvJgdLDd/zNo28ASsi4jOBM2K3yyzQ10CFptEiGMeMFwbP0
 u7p/Ae8zggBHe95DeicPkmARXoqQyIgMyi3xVbCjIfyGJXgZOfTo7239+zGeyXkQKEtk
 TEIHsHvTy+a8ABM5AOB5XzVmeeUW5iUME1Ri1QRot39lw+v8wpcazvFyorNufTnWuo+L
 APxzGUAQhVXq2/jbpR1m/6a+V9/O7w3iiqY+HgVcusLDJBaC49MbKl1c5X874W1smKjc
 20dg==
X-Gm-Message-State: AOJu0Yyh8uBsafbRYhAqjZ1kiql1mb4cQUJabDq1fGYjij9L98U/6D3u
 1oanMg/BiVfgYHxvrbRWh0ZWX1wRf0FRGdkcPs3ZFNL1srdkpIy2RyxSdg3GhjA=
X-Gm-Gg: ASbGnct/4NFMDKyA+Hcg9c3QlFWvzA14BzGYDcl8ZKEXEMPY4mAwYBWLH0KBKtDRFUD
 JJ/G6X+FNDT9koxeENVQUn8yCf7zLfUvW8UNcmaPWMqjVJxxt2VrHy68pfWeQ77TbPNUTUBh060
 +uJ3LuyCnq9AP0kNpRN2+fMRt31RhlIgdxZkhetDMFvL85uMLuqe9p0y5JC3Gve0sqKYbUyPT7e
 tcA8EeQrM/lWxNsKelkZaz8YI2Qq4oDxtzI980+dOLtJ8yHGIgM8CY=
X-Google-Smtp-Source: AGHT+IHDvSwthRY1Bqg5XPKXJ6Wk492f34cXz4QB5e4dA8LTgHHR5riUpQLo8YqqMaElqSOq3JV8uQ==
X-Received: by 2002:a05:6000:1fa7:b0:385:f7a3:fed1 with SMTP id
 ffacd0b85a97d-38a223f5cf6mr58032077f8f.44.1736268740292; 
 Tue, 07 Jan 2025 08:52:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a7f1c26a6sm2223201f8f.53.2025.01.07.08.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62D625FBAC;
 Tue,  7 Jan 2025 16:52:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 15/29] tests/functional/aarch64: add tests for FEAT_RME
Date: Tue,  7 Jan 2025 16:51:53 +0000
Message-Id: <20250107165208.743958-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This boot an OP-TEE environment, and launch a nested guest VM inside it
using the Realms feature. We do it for virt and sbsa-ref platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241220165212.3653495-1-pierrick.bouvier@linaro.org>
[AJB: tweak ordering of setup]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>

-----

v2:
- move test to its own file
- add sbsa test
- check output of `cca-workload-attestation report`

v3:
- build and run test with cca-v4 images
- factorize nested guest test between both tests
- remove accel tcg option as it is the default when running tests
Note: It's a long test and there is a work in progress to understand why
debug build is so slow (x12 vs optimized).

v4:
- use pauth-impdef=on to speed up build time execution (x2.5 faster)
- increase timeout value

v5:
- migrate test to new archive_extract helper

v6:
 - archive_extract helper needs explicit format for .tar.gz archives
 - move set_machine/require_accel to the front
---
 tests/functional/meson.build                 |  4 +
 tests/functional/test_aarch64_rme_sbsaref.py | 69 ++++++++++++++
 tests/functional/test_aarch64_rme_virt.py    | 98 ++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7890dcb86d..bd3d903cfc 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,8 @@ endif
 test_timeouts = {
   'aarch64_aspeed' : 600,
   'aarch64_raspi4' : 480,
+  'aarch64_rme_virt' : 1200,
+  'aarch64_rme_sbsaref' : 1200,
   'aarch64_sbsaref_alpine' : 720,
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
@@ -60,6 +62,8 @@ tests_aarch64_system_thorough = [
   'aarch64_aspeed',
   'aarch64_raspi3',
   'aarch64_raspi4',
+  'aarch64_rme_virt',
+  'aarch64_rme_sbsaref',
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
new file mode 100755
index 0000000000..93bb528338
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Realms environment on sbsa-ref machine and a
+# nested guest VM using it.
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import os
+import logging
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from test_aarch64_rme_virt import test_realms_guest
+
+class Aarch64RMESbsaRefMachine(QemuSystemTest):
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_SBSA = Asset(
+        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
+         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
+         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
+
+    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
+    # and launching a nested VM using it.
+    def test_aarch64_rme_sbsaref(self):
+        self.set_machine('sbsa-ref')
+        self.require_accelerator('tcg')
+
+        self.vm.set_console()
+
+        stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
+        self.archive_extract(stack_path_tar_gz, format="tar")
+
+        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-sbsa')
+        pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
+        pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
+        virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'sbsa-ref')
+        self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
+        self.vm.add_args('-drive', f'file={pflash1},format=raw,if=pflash')
+        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')
+        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
+        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
+        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=shr0,mount_tag=shr0')
+        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
+        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
+
+        self.vm.launch()
+        # Wait for host VM boot to complete.
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        test_realms_guest(self)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
new file mode 100755
index 0000000000..42b9229b4c
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -0,0 +1,98 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Realms environment on virt machine and a nested
+# guest VM using it.
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import os
+import logging
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+
+def test_realms_guest(test_rme_instance):
+
+    # Boot the (nested) guest VM
+    exec_command(test_rme_instance,
+                 'qemu-system-aarch64 -M virt,gic-version=3 '
+                 '-cpu host -enable-kvm -m 512M '
+                 '-M confidential-guest-support=rme0 '
+                 '-object rme-guest,id=rme0 '
+                 '-device virtio-net-pci,netdev=net0,romfile= '
+                 '-netdev user,id=net0 '
+                 '-kernel /mnt/out/bin/Image '
+                 '-initrd /mnt/out-br/images/rootfs.cpio '
+                 '-serial stdio')
+    # Detect Realm activation during (nested) guest boot.
+    wait_for_console_pattern(test_rme_instance,
+                             'SMC_RMI_REALM_ACTIVATE')
+    # Wait for (nested) guest boot to complete.
+    wait_for_console_pattern(test_rme_instance,
+                             'Welcome to Buildroot')
+    exec_command_and_wait_for_pattern(test_rme_instance, 'root', '#')
+    # query (nested) guest cca report
+    exec_command(test_rme_instance, 'cca-workload-attestation report')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-platform-hash-algo-id": "sha-256"')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-realm-hash-algo-id": "sha-512"')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-realm-public-key-hash-algo-id": "sha-256"')
+
+class Aarch64RMEVirtMachine(QemuSystemTest):
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_VIRT = Asset(
+        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
+         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
+         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7ad')
+
+    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
+    # and launching a nested VM using it.
+    def test_aarch64_rme_virt(self):
+        self.set_machine('virt')
+        self.vm.set_console()
+        self.require_accelerator('tcg')
+
+        stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
+        self.archive_extract(stack_path_tar_gz, format="tar")
+
+        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-qemu_v8')
+        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
+        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'virt,acpi=off,'
+                         'virtualization=on,'
+                         'secure=on,'
+                         'gic-version=3')
+        self.vm.add_args('-bios', bios)
+        self.vm.add_args('-kernel', kernel)
+        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
+        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
+        self.vm.add_args('-device', 'virtio-9p-device,fsdev=shr0,mount_tag=shr0')
+        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
+        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-append', 'root=/dev/vda')
+
+        self.vm.launch()
+        # Wait for host VM boot to complete.
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        test_realms_guest(self)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.39.5


