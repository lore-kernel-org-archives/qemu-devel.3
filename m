Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF98E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 19:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMaI-0007Pn-N9; Thu, 19 Dec 2024 14:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOMaH-0007Ob-4V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:53:21 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOMaF-0005Fu-0m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:53:20 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-218c80a97caso10505265ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734637997; x=1735242797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wvaV57g/otsXFa0xdKkFwiLNACda5imzuK59SCTyNUQ=;
 b=qAbBfJIL97kWUOR4aGxNUhT2X3hqoHHRy8+uDYEThyJJn220S2Co/CQNSf9L7bFbul
 VA2lnsaLmHcGd9LjlsjeBSBDE3nml4kDD5eWi1nxoBMUMDlNFqYwHyUvlEtLui/4wWcP
 l/xcPyXGsOxsXInDi5pSWOW0Zx7SYpiG8ssJab5C8M2WRvtmWUwwSogSFwYttsJOjCTX
 r9bYYR5AHOZ2LEPV5tT6xCrbqhjFrRhZRXGVkwyArWLGadh24Wj84upyrIJUCJDOlohk
 6tBuiU0z8H+riigs58+PkeGBA19EpUDSgGlfYfhry0PCuXF984a0LyDe4GoQ7bK+MD8v
 OcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734637997; x=1735242797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvaV57g/otsXFa0xdKkFwiLNACda5imzuK59SCTyNUQ=;
 b=YhxsL1X6xhlxMaswGd+1QtJDvyNQCwzIidAT06bwrMbjezkvr3Cnig6/fjfSf3R2yT
 Lrdf9DqwGzrhfnpEz4JewfZtLrs/9tUAHbNUFFuouIwzrRkj6Xu/oarLZ1g9h6ymu7NK
 +qPnui4dyoQr8woAqBj8azzt1SUnvwEmT4V2s32rdlZRcq4/jYOxpVHVH8gqhQCwUH7l
 pnneu5jaSz2puHp9a162fzyDTkjtzImfRa+yt5WH5DgqnqKjxXDJTdke9TZfB1kBi9+w
 bqxTOjE3naqh/cf+aHSNwEtLgTh8RwTzees/pmZ0/L+OlfF0Edd5+o2CqNMxvDxGxrWS
 zXaw==
X-Gm-Message-State: AOJu0Yxqcpi6YxaBwbFOFGoB62CUltlF6131zV0TEZSrSDWAZRKpJeix
 z5d566LDz5ogp2GRgUNtjPFwM2SK4v5RydmWGuG8c513a8M3k9BSm3CHGhPyiLLdzMLMIX6fXmO
 AOmo=
X-Gm-Gg: ASbGncsKqywCPrwCjXv1v+6Z5UVMWAYiPTeh99YtRBgZZ4vwNEVDXstYFqr7+4t888b
 sJGvwYoXBUPRlwAfikeKLvnEZ77byWyuNwnhKq/yQW0/Y3CycH7cVPCn+I49RIwI5m2nkIgHRgD
 SAo3aWPvk/+bPS692zePs/2sIqjWhf/RpoMP4ma0SCkSR8AOh8Zhev2YBIGF8D56BNE9gPTk6Mt
 9UB/XR+tC0qORSp1tzOtsmVAWNrK4C8HN5qgyNCr2k+fUEppigFdpC8
X-Google-Smtp-Source: AGHT+IGwgSno1orswArW8r97qJ7fl9AiYisN+n//fqdwD3Da6gExJgYKhqxn2xzXY3TjRoAqLRq+aA==
X-Received: by 2002:a17:902:f705:b0:216:2e5e:971d with SMTP id
 d9443c01a7336-218d726c177mr111722155ad.51.1734637997109; 
 Thu, 19 Dec 2024 11:53:17 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96294bsm16259245ad.36.2024.12.19.11.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 11:53:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: mathieu.poirier@linaro.org, gustavo.romero@linaro.org,
 marcin.juszkiewicz@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, jean-philippe@linaro.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5] tests/functional/aarch64: add tests for FEAT_RME
Date: Thu, 19 Dec 2024 11:53:04 -0800
Message-Id: <20241219195304.3548246-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

This boot an OP-TEE environment, and launch a nested guest VM inside it
using the Realms feature. We do it for virt and sbsa-ref platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/meson.build                 |  4 +
 tests/functional/test_aarch64_rme_sbsaref.py | 68 ++++++++++++++
 tests/functional/test_aarch64_rme_virt.py    | 98 ++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ee417b0a1f7..8c789970d48 100644
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
index 00000000000..eb184fe201c
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -0,0 +1,68 @@
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
+        self.vm.set_console()
+        self.require_accelerator('tcg')
+
+        stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
+        self.archive_extract(stack_path_tar_gz)
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
index 00000000000..9e30cc9325c
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
+        self.archive_extract(stack_path_tar_gz)
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


