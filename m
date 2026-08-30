Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52856C61DE1
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0jhb-0005nN-62; Sun, 30 Aug 2026 13:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x0jhY-0005n2-5o; Sun, 30 Aug 2026 13:52:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x0jhV-0000KU-Sc; Sun, 30 Aug 2026 13:52:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67UGVhKP2874632; Sun, 30 Aug 2026 17:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=xPtMTA67u2wyxCK1Jvbc0WvXjv7z
 wrf5a4LT3OvGogQ=; b=FB5twDeleVjiD5E9QKOuOAbGXxYR94hKoeCA4aSg7/9U
 1G+e4597D0SN2+G0J7ww23H/XEa274LgJiS6AHkpSOWfiYMuehoKh6Rr6W10Iu4D
 LbMReGhccuJ7/uWHZl15xWBSBhC0sbmIiWj//6yA53jJf01jDGIxG6sOTNykOzsZ
 jF3rQ4RlpbaLxTtu965MF9mHwGpo5VDb3oe/0mP6l/Q30Fy8XCix9V21z+gkswnP
 dXynXTlSout1tIa+IXGVmzvVt+KtJaIY6oqpqfDmOTAYnKgXn83TDLCxcetM+KVj
 mMFqvkfvu6Mir2im9GqUhzxvVHQH6XuHlTtTyyhTYw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudd7qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Aug 2026 17:52:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67UHfKuc020819;
 Sun, 30 Aug 2026 17:52:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexsrx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Aug 2026 17:52:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67UHq8Sf64487838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Aug 2026 17:52:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3929458055;
 Sun, 30 Aug 2026 17:52:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33FA58043;
 Sun, 30 Aug 2026 17:52:04 +0000 (GMT)
Received: from [9.124.216.242] (unknown [9.124.216.242])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Aug 2026 17:52:04 +0000 (GMT)
Message-ID: <77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com>
Date: Sun, 30 Aug 2026 23:22:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: npiggin@gmail.com, Chinmay Rath <rathc@linux.ibm.com>,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
From: Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH] tests/functional/ppc64: add pseries migration and powernv
 NVMe tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Y7M4tAygjyhkbYgc6bLvbX1Zd9iEOYvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDE1MyBTYWx0ZWRfX69GgBMYHER0m
 AR5S8ovpC59PgddbwSAfQ/eKWmvuI1xJdNZz8uLht3mnTwsz3PgKic9JRGewiEPHRz2ChWReAJ1
 XdisukLtlxiq2mTs0ndInO8YK39shZBM9hFWvuX8QLTujumtjlJThafXCACv+G5M+AkRG744b43
 h+YYpWelshgTig1iiDzG2QBzq2yogUHGp7BGCFaGluzeSvvayKLzutYUx3Wa22mFFLwr3pF6BkW
 OcgSNpAfwZTLJwdHJ3woDm1UW0wc6i7Y5xceclryKA22ii1X8+L8MJwKIOhs8S0fz90y0SF0VUb
 UvITd4q6z5U07q7tEUHGjNmBijTfyrQabNV/YMFsX6xCplnCeDuWJHhhPo5idO0yh/oS1NKIgwn
 0aQmCr+heiM5PZXs/xKD5KrsWZuz2zNTYBttITeYqgt6DUpOdRtjpRwJuZ4+Axc8/RphDgkqDvJ
 jpwxc5F29gjnW7QAzbw==
X-Proofpoint-ORIG-GUID: k34ZvrDbuhraArNsxmKAMFQSxDpGML--
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDE1MyBTYWx0ZWRfX3rh+wUP47SWg
 6VP3wHYV1LaN508xJk4jIx1VnUzrbWdACS4OMKGbujT9/xZxDFwfXoqNVb9izDtf/EPJvuUuHfz
 c7oSGsovxDiulE7k6K+PM+eLiLYaBy8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a946dca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=I-Z7AQhl-F28tbCi2EkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608300153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Add two new groups of functional tests that cover scenarios currently
missing from the ppc64 test suite:

1. pseries live migration (pseries machine type)
    - Extends the quick migration suite (already covering mac99) with
      tcp-localhost, UNIX socket, and exec (socat) migration tests for
      the pseries machine type.  This complements the existing
      test_ppc64_linux_migration test in test_pseries.py (which boots a
      full kernel) by providing lightweight no-boot migration smoke tests
      that run quickly.

2. PowerNV NVMe + network device boot (powernv machine type)
    - The existing do_test_ppc64_powernv() helper in test_powernv.py
      already boots a rootfs from NVMe for P8/P9/P10/P11.  This patch
      adds a complementary test that also verifies the e1000e network
      adapter and USB xHCI controller are probed successfully by Linux -
      previously these were present in the device args but no console
      check was made for them.
    - Adds test_powernv10_rainier() for the powernv10-rainier variant
      that models the IBM Rainier system board.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>

diff --git a/tests/functional/ppc64/meson.build 
b/tests/functional/ppc64/meson.build
index cb3c745624..19c32c8b67 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -1,6 +1,8 @@
  # SPDX-License-Identifier: GPL-2.0-or-later

  test_ppc64_timeouts = {
+  'pseries_migrate' : 60,
+  'powernv_devices' : 480,
    'fadump' : 480,
    'hv' : 1000,
    'mac99' : 120,
@@ -14,12 +16,14 @@ test_ppc64_timeouts = {
  tests_ppc64_system_quick = [
    'migration',
    'vmstate',
+  'pseries_migrate',
  ]

  tests_ppc64_system_thorough = [
    'e500',
    'fadump',
    'hv',
+  'powernv_devices',
    'mac99',
    'openbsd',
    'powernv',
diff --git a/tests/functional/ppc64/test_powernv_devices.py 
b/tests/functional/ppc64/test_powernv_devices.py
new file mode 100644
index 0000000000..6135855612
--- /dev/null
+++ b/tests/functional/ppc64/test_powernv_devices.py
@@ -0,0 +1,151 @@
+#!/usr/bin/env python3
+#
+# Functional tests that boot Linux on powernv machines and explicitly
+# verify that PCIe-attached devices (NVMe, e1000e, xHCI USB) are
+# detected by the guest kernel.  Also covers the powernv10-rainier
+# board variant.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class PowerNVDevicesTest(LinuxKernelTest):
+    """
+    Boot Linux on powernv variants and verify that PCIe devices are
+    detected by the guest.
+
+    The existing test_powernv.py::do_test_ppc64_powernv() attaches an
+    NVMe drive, an e1000e NIC, and an xHCI USB controller, but only
+    waits for the CPU-generation string and the init process. This
+    test adds explicit console pattern checks for each device so that
+    regressions in device enumeration or PCI/PCIe topology are caught.
+
+    An additional test covers powernv10-rainier (the IBM Rainier system
+    board variant) which has a slightly different PHB topology.
+    """
+
+    timeout = 480
+
+    ASSET_KERNEL = Asset(
+ ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_powernv8-2025.02/vmlinux'),
+ '6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151')
+
+    ASSET_INITRD = Asset(
+ ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
+ 'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('tcg')
+
+    def _do_test_powernv_pcie_devices(self, machine):
+        """
+        Boot *machine* and verify NVMe, e1000e, and xHCI are detected.
+
+        Device topology (matches the existing do_test_ppc64_powernv 
helper):
+          pcie.2  → NVMe drive (boot device, rootfs)
+          bridge1 → e1000e NIC (addr 0x3)
+          bridge1 → nec-usb-xhci (addr 0x2)
+
+        Expected kernel log patterns checked:
+          * "nvme nvme0" — NVMe controller probe
+          * "e1000e"     — Intel e1000e NIC probe
+          * "xhci_hcd"   — USB xHCI host controller probe
+          * "Run /sbin/init as init process" — reached userland
+        """
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args(
+            '-kernel', kernel_path,
+            '-drive',
+ f'file={initrd_path},format=raw,if=none,id=drive0,readonly=on',
+            '-append', 'root=/dev/nvme0n1 console=tty0 console=hvc0',
+            '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
+            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234',
+            '-device', 'e1000e,bus=bridge1,addr=0x3',
+            '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2',
+        )
+        self.vm.launch()
+
+        # NVMe controller should be detected first (it is the boot disk).
+        self.wait_for_console_pattern('nvme nvme0')
+
+        # e1000e NIC detection.
+        self.wait_for_console_pattern('e1000e')
+
+        # USB xHCI host controller detection.
+        self.wait_for_console_pattern('xhci_hcd')
+
+        # System reached userland — final sanity check.
+        self.wait_for_console_pattern('Run /sbin/init as init process')
+
+    def test_powernv8_pcie_devices(self):
+        """powernv8 (P8): NVMe + e1000e + xHCI detected."""
+        self._do_test_powernv_pcie_devices('powernv8')
+
+    def test_powernv9_pcie_devices(self):
+        """powernv9 (P9): NVMe + e1000e + xHCI detected."""
+        self._do_test_powernv_pcie_devices('powernv9')
+
+    def test_powernv10_pcie_devices(self):
+        """powernv10 (P10): NVMe + e1000e + xHCI detected."""
+        self._do_test_powernv_pcie_devices('powernv10')
+
+    def test_powernv11_pcie_devices(self):
+        """powernv11 (P11): NVMe + e1000e + xHCI detected."""
+        self._do_test_powernv_pcie_devices('powernv11')
+
+    def test_powernv10_rainier_pcie_devices(self):
+        """
+        powernv10-rainier: NVMe + e1000e + xHCI detected.
+
+        The Rainier board variant maps PCIe root ports slightly
+        differently from the default powernv10 topology.  Verify that
+        the same device set is enumerated successfully.
+        """
+        self._do_test_powernv_pcie_devices('powernv10-rainier')
+
+    def test_powernv9_hpt_pcie_devices(self):
+        """
+        powernv9 booted with disable_radix (HPT mode): verify devices.
+
+        Radix MMU is the default on P9.  Force the HPT (Hash Page Table)
+        MMU path to exercise an alternative translation code path while
+        still ensuring PCI devices are enumerated correctly.
+        """
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.set_machine('powernv9')
+        self.vm.set_console()
+        self.vm.add_args(
+            '-kernel', kernel_path,
+            '-drive',
+ f'file={initrd_path},format=raw,if=none,id=drive0,readonly=on',
+            '-append',
+            'root=/dev/nvme0n1 console=tty0 console=hvc0 disable_radix',
+            '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
+            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234',
+            '-device', 'e1000e,bus=bridge1,addr=0x3',
+            '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2',
+        )
+        self.vm.launch()
+
+        # HPT-specific boot message.
+        self.wait_for_console_pattern('hash-mmu: Initializing hash mmu')
+
+        # Device checks same as the radix path.
+        self.wait_for_console_pattern('nvme nvme0')
+        self.wait_for_console_pattern('e1000e')
+        self.wait_for_console_pattern('xhci_hcd')
+        self.wait_for_console_pattern('Run /sbin/init as init process')
+
+
+if __name__ == '__main__':
+    PowerNVDevicesTest.main()
diff --git a/tests/functional/ppc64/test_pseries_migrate.py 
b/tests/functional/ppc64/test_pseries_migrate.py
new file mode 100644
index 0000000000..0cb929e35f
--- /dev/null
+++ b/tests/functional/ppc64/test_pseries_migrate.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Lightweight (no-boot) migration smoke tests for the pseries machine type.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from migration import MigrationTest
+
+
+class PseriesMigrationTest(MigrationTest):
+    """
+    Lightweight migration smoke tests for pseries.
+
+    No kernel is booted — QEMU is launched with -nodefaults and
+    immediately migrated so the tests run in a few seconds.  This
+    catches regressions in the pseries vmstate save/restore path
+    without the overhead of a full kernel boot.
+
+    These complement the existing test_ppc64_linux_migration test in
+    test_pseries.py which exercises migration mid-boot.
+    """
+
+    timeout = 60
+
+    def test_pseries_migration_with_tcp_localhost(self):
+        """Basic TCP-localhost migration for pseries."""
+        self.set_machine('pseries')
+        self.migration_with_tcp_localhost()
+
+    def test_pseries_migration_with_unix(self):
+        """UNIX socket migration for pseries."""
+        self.set_machine('pseries')
+        self.migration_with_unix()
+
+    def test_pseries_migration_with_exec(self):
+        """exec (socat) migration for pseries."""
+        self.set_machine('pseries')
+        self.migration_with_exec()
+
+    def test_powernv_migration_with_tcp_localhost(self):
+        """Basic TCP-localhost migration for powernv."""
+        self.set_machine('powernv')
+        self.migration_with_tcp_localhost()
+
+    def test_powernv_migration_with_unix(self):
+        """UNIX socket migration for powernv."""
+        self.set_machine('powernv')
+        self.migration_with_unix()
+
+    def test_powernv_migration_with_exec(self):
+        """exec (socat) migration for powernv."""
+        self.set_machine('powernv')
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
--
2.53.0


