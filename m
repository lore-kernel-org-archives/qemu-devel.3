Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764B3C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3u-0002G8-Dn; Mon, 06 Jul 2026 18:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3s-0002Dg-4W; Mon, 06 Jul 2026 18:45:12 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3p-0001G7-R0; Mon, 06 Jul 2026 18:45:11 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 80A4E7A01E4;
 Mon,  6 Jul 2026 18:45:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 18:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377908; x=
 1783464308; bh=hWa71vbrRL3wcudsdmqBSlMdacZJYGlOCvuDe0JhTKU=; b=I
 wqrcxwDXBM6UUPo8nr+WiJaQnU/j0lEocVyq8Y4+jMlBsZFNvhwsLkgM+/2xzFs+
 tMRlaakOqzQ1qbg4Gnv0VdFAWuKx4nyIK1hRgI5fuQenB01Twcef9Z3ZDnbZRXu1
 ZM7FRi+CutkiQsGuR0UOvd5aghkWqeKB0s0eEFpBUvHraIrOFgfirVacb5vfXh4z
 +60p2yCJi+na6jZxYVtmMFHxLlOcj3jzAriZNzqmAC1fL6lbD2Fwn3xX9VMRlszg
 1bpDY40xcYt+hWX+PzArQO6zjxsQwyDTl3fWKPLitCmcPekdrdVS+o7m+Y1RRQiW
 7ZhndAAQvUG/K0iZYH2TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377908; x=1783464308; bh=h
 Wa71vbrRL3wcudsdmqBSlMdacZJYGlOCvuDe0JhTKU=; b=YzKQv6/fnoMseDEzV
 CSCggPajwCL2xFtxbCg7zkoJpXHuy9CFwTUQee2lpr8xWQ+ouowGmZIVpkSTfNBr
 qyq63fh1N9IucV1MjutNgz9z2YBHQvxTCz/oxICrLULsylJC8VJZ7XSRUhM+v0FS
 /uwGuVN3oWL1bc2XjmSvLvklMIEp8YB3DOZLzyNjxzSTm0OxSobhEOd/fjKawB7g
 Vufd2xGdNZYxdfgS5A6pw+cNifgB9XNGjmqOBXfE10FI8BZlHYr58pOmLrMUM+5h
 kMH4ZhD++h3JYd0Rq65MYZ0jgq76agLlVU5nwChcXlFu0Msh+DZuaOzVxYhYqyxz
 KKP4w==
X-ME-Sender: <xms:9C9MaviS6SZgoPVhPGeNjksbjgbLIXtybK2eMpNRzHY_17lL9MirHQ>
 <xme:9C9MakI1HSNQvJ_bAZirsmU7E35OmtRYgCJYUsc51WhoGXpy8jb44sTzgAmsd2VtQ
 TQwFfIsZCZ2sZqWqhvOGjTluWScJ1vhQRLr5Pb59YWBj1mUfn748Q>
X-ME-Received: <xmr:9C9MaukGuk-CRQSs5BoVfQ67tfZEOOM7EeRPtAnI47lKGsZgIOE4xCSZATKx3Pm6VUJPbfVvFrSqMZPAaCoMvou7MzyIevIR-5H3ULh59SZ9ShEadLmPbeX1Mg>
X-ME-Proxy-Cause: dmFkZTEiFTtHt0YOnx1leXJPo4RVyWTN13fcIYGI1lWZMgNLf7wXqeUOLAXBD2zXA/jeli
 YD45DRJEjXaHCSv2cmn5kqCWcR9Gjq0W1r/X2s3zPlHhk10cPynvjgZmtm2RiaJdIKj8rU
 VzuIRGO6ubKn2Mgem/ophdM1cCUkseQvW3gtHqaxdehvx8B/vWC/b8CJudpL5m3VRURM/H
 XP2PWfzrBh/tPglOTuYCZfD8aZrqiMpTwY16/K/Z5G/jEzVnRE9nsWRW4xDZQZ7WWD+9+R
 HVgwyU31EScXhARPmO/oxvlZY8ttSvEgMGWOm6yhn/MJjVlYYOcJLTWW+sgMeXaZkQNkn5
 xHIbMri/gObAcuLl04SaY11IrhNJj9oYCX4pkYYBUsRyGbUtWfTnw43w0BiVb4vgF6AcFL
 NxpczC2FBp4qq4CCpijIlhHZIbYBVuWrf+Q/Q8UQzW7qhHjJxbDw7dkaipg8SUr7zovyZG
 9DqoPqpmYpLvZKSRR5pV3ux/1OZigsJoYy8AIpanMBv2vtwhx7vTEdOdT3IKbxLmb3UQCJ
 BJ+TprqB0JsfXSbSN/9wH/lCODMpVWrVAjma2TDX1q30iGYV2SdABQAHrCzkWbuXSn5fsI
 kOZNU1dHajWmdRG4HXCEHi6Wn6fyH83IKYgimNPwcP83wG26EHMsOoJVD1Pg
X-ME-Proxy: <xmx:9C9MasPFoNOjl36l6j9mujCgLnET76NScMSuFwDOjwmhCpL-YeiUMA>
 <xmx:9C9Mao6H1XMY4A2WahNiZQA8TwMFwoP9Omz_DXpkOXqmSncouLBVlg>
 <xmx:9C9MagbrCaqCwki2sCAssnNFz-TPvmXlvW1kERcntugVEdpmdo3jvA>
 <xmx:9C9MaleA0sX1B8G36WB-2X6kDLw5rLoAIgOPF0TndWyhy7HCsm9pWw>
 <xmx:9C9MakePTHsjWY21QP-x6kPm6RI9mQZBhrgz39IG7M7DSIjYbXdLGP25>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:45:05 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 09/11] tests/functional/x86_64: add migration test for NVMe
 device
Date: Tue,  7 Jul 2026 00:44:21 +0200
Message-ID: <20260706224426.14156-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Introduce a very simple test to ensure that NVMe device
migration works fine.

Test plan is simple:
1. prepare VM with NVMe device
2. run workload that produces relatively heavy IO on the device
3. migrate VM
4. ensure that workload is alive and finishes without errors

Test can be run as simple as:
$ meson test 'func-x86_64-nvme_migration' --setup thorough -C build

In the future we can extend this approach, and introduce some
fio-based tests. And probably, it makes sense to make this test
to apply not only to NVMe device, but also virtio-{blk,scsi},
ide, sata and other migratable devices.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Acked-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 172 ++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded61..24bc14f8fce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2680,6 +2680,7 @@ S: Supported
 F: hw/nvme/*
 F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
+F: tests/functional/x86_64/test_nvme_migration.py
 F: docs/system/devices/nvme.rst
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 1ed10ad6c295..fd77f19d7265 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -37,6 +37,7 @@ tests_x86_64_system_thorough = [
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
+  'nvme_migration',
   'replay',
   'reverse_debug',
   'tuxrun',
diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
new file mode 100755
index 000000000000..890f0aab6d6e
--- /dev/null
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# x86_64 NVMe migration test
+
+from migration import MigrationTest
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+
+
+class X8664NVMeMigrationTest(MigrationTest):
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    ASSET_DISKIMAGE = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'),
+        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
+
+    DEFAULT_KERNEL_PARAMS = ('root=/dev/nvme0n1p1 console=ttyS0 net.ifnames=0 '
+                             'rd.rescue quiet')
+
+    def wait_for_console_pattern(self, success_message, vm):
+        wait_for_console_pattern(
+            self,
+            success_message,
+            failure_message="Kernel panic - not syncing",
+            vm=vm,
+        )
+
+    def exec_command_and_check(self, command, vm):
+        prompt = '# '
+        exec_command_and_wait_for_pattern(self,
+                                        f"{command} && echo OK || echo FAIL",
+                                        'FAIL', vm=vm)
+        # Note, that commands we send to the console are echo-ed back,
+        # so if we have a word "FAIL" in the command itself, we should
+        # expect to see it once.
+        wait_for_console_pattern(self, 'OK', failure_message="FAIL", vm=vm)
+        self.wait_for_console_pattern(prompt, vm)
+
+    def configure_machine(self, vm):
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        diskimage_path = self.ASSET_DISKIMAGE.fetch()
+
+        vm.set_console()
+        vm.add_args("-cpu", "max")
+        vm.add_args("-m", "2G")
+        vm.add_args("-accel", "kvm")
+
+        vm.add_args('-drive',
+                         f'file={diskimage_path},if=none,id=drv0,snapshot=on')
+        vm.add_args('-device', 'nvme,bus=pcie.0,' +
+                    'drive=drv0,id=nvme-disk0,serial=nvmemigtest,bootindex=1')
+
+        vm.add_args(
+            "-kernel",
+            kernel_path,
+            "-initrd",
+            initrd_path,
+            "-append",
+            self.DEFAULT_KERNEL_PARAMS
+        )
+
+    def launch_source_vm(self, vm):
+        vm.launch()
+
+        self.wait_for_console_pattern('Entering emergency mode.', vm)
+        prompt = '# '
+        self.wait_for_console_pattern(prompt, vm)
+
+        # Synchronize on NVMe driver creating the root device
+        exec_command_and_wait_for_pattern(self,
+                        "while ! (dmesg -c | grep nvme0n1:) ; do sleep 1 ; done",
+                        "nvme0n1", vm=vm)
+        self.wait_for_console_pattern(prompt, vm)
+
+        # prepare system
+        exec_command_and_wait_for_pattern(self, 'mount /dev/nvme0n1p1 /sysroot',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'mount -t proc proc /proc',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys',
+                                          prompt, vm=vm)
+
+        # Run workload before migration to check if it continues
+        # to run properly after migration.
+        #
+        # Workload is simple: it continuously calculates checksums of
+        # all files in /usr/bin to generate some I/O load on
+        # the NVMe disk and at the same time it drops caches to
+        # make sure that we have some read I/O on the disk as well.
+        # If there are any issues with the migration of the NVMe device,
+        # we should see errors in dmesg and consequently in the workload log.
+        exec_command_and_wait_for_pattern(self,
+            "(while [ ! -f /tmp/test_nvme_mig_workload.stop ]; do \
+                rm -f /tmp/test_nvme_mig_workload.iter_finished; \
+                echo 3 > /proc/sys/vm/drop_caches; \
+                find /usr/bin -type f -exec cksum {} \\;; \
+                touch /tmp/test_nvme_mig_workload.iter_finished; \
+            done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
+            prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self,
+            'echo $! > /tmp/test_nvme_mig_workload.pid',
+            prompt, vm=vm)
+
+        # check if process is alive and running
+        self.exec_command_and_check(
+            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
+
+    def assert_dest_vm(self, vm):
+        prompt = '# '
+
+        # check if process is alive and running after migration,
+        # if not - fail the test
+        self.exec_command_and_check(
+            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
+
+        # signal workload to stop
+        exec_command_and_wait_for_pattern(self,
+            'touch /tmp/test_nvme_mig_workload.stop',
+            prompt, vm=vm)
+
+        # wait workload to finish, because we want to examine log
+        # to see if there are any errors
+        exec_command_and_wait_for_pattern(self,
+            "while [ ! -f /tmp/test_nvme_mig_workload.iter_finished ]; do \
+                sleep 1; \
+            done;",
+            prompt, vm=vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'cat /tmp/test_nvme_mig_workload.errors',
+            prompt, vm=vm)
+
+        # fail the test if non-empty
+        self.exec_command_and_check(
+            "[ ! -s /tmp/test_nvme_mig_workload.errors ]", vm)
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
-- 
2.53.0


