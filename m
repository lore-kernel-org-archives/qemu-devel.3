Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD210C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 11:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbd6-0002o3-V5; Thu, 27 Feb 2025 06:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbd2-0002hH-9K
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 06:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbcx-0006zq-MB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 06:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740654024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zo6DyPSAv2JcYtJVHblpCSdKkVIsSIgM7UWICPOOvKE=;
 b=PdXNNg8uDRrHlZl4fwdThleniXxCUg5AFd6enYpemq9c9hTC3hjm2HHdDZzIo/Thsm0sTc
 y1mje/DcoE+fVncUtR0bsKggSkNzBFeHhGHJ/zCeDu0wC6MP3h/+thX65D5DcH0cmxp2Em
 g9ec3mN7kcZFq0Dt/gyU/D09EzF+N6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-ymxAumHfOz2YYn3F-VsPQQ-1; Thu,
 27 Feb 2025 06:00:22 -0500
X-MC-Unique: ymxAumHfOz2YYn3F-VsPQQ-1
X-Mimecast-MFC-AGG-ID: ymxAumHfOz2YYn3F-VsPQQ_1740654021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BD7B180099F; Thu, 27 Feb 2025 11:00:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.184])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9DEA1800371; Thu, 27 Feb 2025 11:00:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/avocado: Remove the boot_linux.py and replay_linux.py
 tests
Date: Thu, 27 Feb 2025 12:00:14 +0100
Message-ID: <20250227110014.21048-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These tests are based on the cloudinit functions from Avocado.
The cloudinit is very, very slow compared to our other tests,
so most of these Avocado tests have either been disabled by default
with a decorator, or have been marked to only run with KVM.

We won't include this sluggish cloudinit stuff in the functional
framework, and we've already got plenty of other tests there that
check pretty much the same things, so let's simply get rid of these
old tests now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux.py   | 132 ----------------------
 tests/avocado/replay_linux.py | 206 ----------------------------------
 2 files changed, 338 deletions(-)
 delete mode 100644 tests/avocado/boot_linux.py
 delete mode 100644 tests/avocado/replay_linux.py

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
deleted file mode 100644
index a029ef4ad1e..00000000000
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
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
deleted file mode 100644
index 59169224353..00000000000
--- a/tests/avocado/replay_linux.py
+++ /dev/null
@@ -1,206 +0,0 @@
-# Record/replay test that boots a complete Linux system via a cloud image
-#
-# Copyright (c) 2020 ISP RAS
-#
-# Author:
-#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import logging
-import time
-
-from avocado import skipUnless
-from avocado_qemu import BUILD_DIR
-from avocado.utils import cloudinit
-from avocado.utils import network
-from avocado.utils import vmimage
-from avocado.utils import datadrainer
-from avocado.utils.path import find_command
-from avocado_qemu.linuxtest import LinuxTest
-
-class ReplayLinux(LinuxTest):
-    """
-    Boots a Linux system, checking for a successful initialization
-    """
-
-    timeout = 1800
-    chksum = None
-    hdd = 'ide-hd'
-    cd = 'ide-cd'
-    bus = 'ide'
-
-    def setUp(self):
-        # LinuxTest does many replay-incompatible things, but includes
-        # useful methods. Do not setup LinuxTest here and just
-        # call some functions.
-        super(LinuxTest, self).setUp()
-        self._set_distro()
-        self.boot_path = self.download_boot()
-        self.phone_server = cloudinit.PhoneHomeServer(('0.0.0.0', 0),
-                                                      self.name)
-        ssh_pubkey, self.ssh_key = self.set_up_existing_ssh_keys()
-        self.cloudinit_path = self.prepare_cloudinit(ssh_pubkey)
-
-    def vm_add_disk(self, vm, path, id, device):
-        bus_string = ''
-        if self.bus:
-            bus_string = ',bus=%s.%d' % (self.bus, id,)
-        vm.add_args('-drive', 'file=%s,snapshot=on,id=disk%s,if=none' % (path, id))
-        vm.add_args('-drive',
-            'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
-        vm.add_args('-device',
-            '%s,drive=disk%s-rr%s' % (device, id, bus_string))
-
-    def vm_add_cdrom(self, vm, path, id, device):
-        vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
-
-    def launch_and_wait(self, record, args, shift):
-        self.require_netdev('user')
-        vm = self.get_vm()
-        vm.add_args('-smp', '1')
-        vm.add_args('-m', '1024')
-        vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                    '-device', 'virtio-net,netdev=vnet')
-        vm.add_args('-object', 'filter-replay,id=replay,netdev=vnet')
-        if args:
-            vm.add_args(*args)
-        self.vm_add_disk(vm, self.boot_path, 0, self.hdd)
-        self.vm_add_cdrom(vm, self.cloudinit_path, 1, self.cd)
-        logger = logging.getLogger('replay')
-        if record:
-            logger.info('recording the execution...')
-            mode = 'record'
-        else:
-            logger.info('replaying the execution...')
-            mode = 'replay'
-        replay_path = os.path.join(self.workdir, 'replay.bin')
-        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
-                    (shift, mode, replay_path))
-
-        start_time = time.time()
-
-        vm.set_console()
-        vm.launch()
-        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
-                                    logger=self.log.getChild('console'),
-                                    stop_check=(lambda : not vm.is_running()))
-        console_drainer.start()
-        if record:
-            while not self.phone_server.instance_phoned_back:
-                self.phone_server.handle_request()
-            vm.shutdown()
-            logger.info('finished the recording with log size %s bytes'
-                % os.path.getsize(replay_path))
-            self.run_replay_dump(replay_path)
-            logger.info('successfully tested replay-dump.py')
-        else:
-            vm.event_wait('SHUTDOWN', self.timeout)
-            vm.wait()
-            logger.info('successfully finished the replay')
-        elapsed = time.time() - start_time
-        logger.info('elapsed time %.2f sec' % elapsed)
-        return elapsed
-
-    def run_rr(self, args=None, shift=7):
-        t1 = self.launch_and_wait(True, args, shift)
-        t2 = self.launch_and_wait(False, args, shift)
-        logger = logging.getLogger('replay')
-        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
-
-    def run_replay_dump(self, replay_path):
-        try:
-            subprocess.check_call(["./scripts/replay-dump.py",
-                                   "-f", replay_path],
-                                  stdout=subprocess.DEVNULL)
-        except subprocess.CalledProcessError:
-            self.fail('replay-dump.py failed')
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=accel:tcg
-    """
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664Virtio(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=virtio
-    :avocado: tags=accel:tcg
-    """
-
-    hdd = 'virtio-blk-pci'
-    cd = 'virtio-blk-pci'
-    bus = None
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxAarch64(ReplayLinux):
-    """
-    :avocado: tags=accel:tcg
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    :avocado: tags=cpu:max
-    """
-
-    chksum = '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49'
-
-    hdd = 'virtio-blk-device'
-    cd = 'virtio-blk-device'
-    bus = None
-
-    def get_common_args(self):
-        return ('-bios',
-                os.path.join(BUILD_DIR, 'pc-bios', 'edk2-aarch64-code.fd'),
-                "-cpu", "max,lpa2=off",
-                '-device', 'virtio-rng-pci,rng=rng0',
-                '-object', 'rng-builtin,id=rng0')
-
-    def test_virt_gicv2(self):
-        """
-        :avocado: tags=machine:gic-version=2
-        """
-
-        self.run_rr(shift=3,
-                    args=(*self.get_common_args(),
-                          "-machine", "virt,gic-version=2"))
-
-    def test_virt_gicv3(self):
-        """
-        :avocado: tags=machine:gic-version=3
-        """
-
-        self.run_rr(shift=3,
-                    args=(*self.get_common_args(),
-                          "-machine", "virt,gic-version=3"))
-- 
2.48.1


