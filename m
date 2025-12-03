Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2682D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhnA-0000NR-3o; Wed, 03 Dec 2025 03:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhml-00005F-DL; Wed, 03 Dec 2025 03:00:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmh-0006ip-U7; Wed, 03 Dec 2025 03:00:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1288170769;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6F1A132B490;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 092/116] tests/avocado: Remove the boot_linux.py tests
Date: Wed,  3 Dec 2025 10:59:12 +0300
Message-ID: <20251203075939.2366131-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These tests are based on the cloudinit functions from Avocado.
The cloudinit is very, very slow compared to our other tests,
so most of these Avocado tests have either been disabled by default
with a decorator, or have been marked to only run with KVM.

We won't include this sluggish cloudinit stuff in the functional
framework, and we've already got plenty of other tests there that
check pretty much the same things, so let's simply get rid of these
old tests now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-11-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e83aee9c6a0f169e8c5d9387f2429ec8f539dda9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
deleted file mode 100644
index a029ef4ad1..0000000000
--- a/tests/avocado/boot_linux.py
+++ /dev/null
@@ -1,132 +0,0 @@
-# Functional test that boots a complete Linux system via a cloud image
-#
-# Copyright (c) 2018-2020 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-
-from avocado_qemu.linuxtest import LinuxTest
-from avocado_qemu import BUILD_DIR
-
-from avocado import skipUnless
-
-
-class BootLinuxX8664(LinuxTest):
-    """
-    :avocado: tags=arch:x86_64
-    """
-    timeout = 480
-
-    def test_pc_i440fx_tcg(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_i440fx_kvm(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_tcg(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_kvm(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# For Aarch64 we only boot KVM tests in CI as booting the current
-# Fedora OS in TCG tests is very heavyweight. There are lighter weight
-# distros which we use in the machine_aarch64_virt.py tests.
-class BootLinuxAarch64(LinuxTest):
-    """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    """
-    timeout = 720
-
-    def test_virt_kvm(self):
-        """
-        :avocado: tags=accel:kvm
-        :avocado: tags=cpu:host
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "virt,gic-version=host")
-        self.vm.add_args('-bios',
-                         os.path.join(BUILD_DIR, 'pc-bios',
-                                      'edk2-aarch64-code.fd'))
-        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
-        self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# See the tux_baseline.py tests for almost the same coverage in a lot
-# less time.
-class BootLinuxPPC64(LinuxTest):
-    """
-    :avocado: tags=arch:ppc64
-    """
-
-    timeout = 360
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_pseries_tcg(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pseries_kvm(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "cap-ccf-assist=off")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-class BootLinuxS390X(LinuxTest):
-    """
-    :avocado: tags=arch:s390x
-    """
-
-    timeout = 240
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_s390_ccw_virtio_tcg(self):
-        """
-        :avocado: tags=machine:s390-ccw-virtio
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-- 
2.47.3


